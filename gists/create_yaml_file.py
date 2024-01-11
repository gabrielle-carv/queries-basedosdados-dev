import pandas as pd
import ruamel.yaml as yaml
from utils import *
import os
from typing import List


def create_yaml_file(arq_url, table_id, 
                     dataset_id, at_least: float = 0.05, 
                     unique_keys: List[str] = ["insert unique keys here"], 
                     mkdir=True, 
                     preprocessed_staging_column_names=True) -> None:
    """
    Creates dbt models and schema.yaml files based on the architecture table, including data quality tests automatically.

    Args:
        arq_url (str or list): The URL(s) or file path(s) of the input file(s) containing the data.
        table_id (str or list): The table ID(s) or name(s) to use as the YAML model name(s).
        dataset_id (str): The ID or name of the dataset to be used in the dbt models.
        at_least (float): The proportion of non-null values accepted in the columns.
        unique_keys (list, optional): A list of column names for which the 'dbt_utils.unique_combination_of_columns' test should be applied.
                                      Defaults to ["insert unique keys here"].
        mkdir (bool, optional): If True, creates a directory for the new model(s). Defaults to True.
        preprocessed_staging_column_names (bool, optional): If False, renames staging column names using the architecture. Defaults to True.

    Raises:
        TypeError: If the table_id is not a string or a list.
        ValueError: If the number of URLs or file paths does not match the number of table IDs.

    Notes:
        The function generates dbt models in YAML format based on the input data and saves them to the specified output file.
        The generated YAML file includes information about the dataset, model names, descriptions, and column details.

    Example:
        ```python
        create_yaml_file(arq_url='input_data.csv', table_id='example_table', dataset_id='example_dataset')
        ```

    """
    if mkdir:
        os.makedirs(f"./models/{dataset_id}/", exist_ok=True)
        output_path = f"./models/{dataset_id}" 
    else:
        print("Directory for the new model has not been created, saving files in /queries-basedosadados-dev/gists/")
        output_path = f"./gists/"      

    schema_path = f"{output_path}/schema.yml"

    yaml_obj = yaml.YAML(typ='rt')
    yaml_obj.indent(mapping=4, sequence=4, offset=2)

    if os.path.exists(schema_path):
        with open(schema_path, 'r') as file:
            data = yaml_obj.load(file)
    else: 
        data = yaml.comments.CommentedMap()
        data['version'] = 2
        data.yaml_set_comment_before_after_key('models', before='\n\n')
        data['models'] = []            

    exclude = ['(excluded)', '(erased)', '(deleted)','(excluido)']

    if isinstance(table_id, str): 
        table_id = [table_id]
        arq_url = [arq_url]

    # If table_id is a list, assume multiple input files
    if not isinstance(arq_url, list) or len(arq_url) != len(table_id):
        raise ValueError("The number of URLs or file paths must match the number of table IDs.")

    for url, id in zip(arq_url, table_id):

        unique_keys_copy = unique_keys.copy()
        architecture_df = sheet_to_df(url)
        architecture_df.dropna(subset = ['bigquery_type'], inplace= True)
        architecture_df = architecture_df[~architecture_df['bigquery_type'].apply(lambda x: any(word in x.lower() for word in exclude))]

        # If model is already in the schema.yaml, delete old model and create new one
        for model in data['models']:
            if id == model['name']:
                data['models'].remove(model)
                break

        table = yaml.comments.CommentedMap()
        table['name'] = f'{id}'
        table['description'] = f"Insert `{id}` table description here"
        table['tests'] = create_unique_combination(unique_keys_copy)
        table['columns'] = []

        for _, row in architecture_df.iterrows():
            column = yaml.comments.CommentedMap()
            column['name'] = row['name']
            column['description'] = row['description']
            tests = []
            tests += create_not_null_proportion(at_least)
            if not pd.isna(row["directory_column"]):
                directory = row["directory_column"]
                tests += create_relationships(directory)
            column['tests'] = tests
            table['columns'].append(column)


        data['models'].append(table)

        create_model_from_architecture(architecture_df,
                                        output_path,
                                        dataset_id, 
                                        id,
                                        preprocessed_staging_column_names) 

    with open(schema_path, 'w') as file:
        yaml_obj.dump(data, file)
                
    print("Files successfully created!")