import pandas as pd
import ruamel.yaml as yaml
from utils import *
import os
from typing import List
#test

def create_yaml_file(arq_url, table_id, dataset_id, at_least: float = 0.05, unique_keys: List[str] = [], mkdir=True) -> None:
    """
    Creates dbt models and schema.yaml files based on the architecture table, with the possibility of including data quality tests automatically.

    Args:
        arq_url (str or list): The URL(s) or file path(s) of the input file(s) containing the data.
        table_id (str or list): The table ID(s) or name(s) to use as the YAML model name(s).
        dataset_id (str): The ID or name of the dataset to be used in the dbt models.
        at_least (float): The proportion of non-null values accepted in the columns.
        unique_keys (list, optional): A list of column names for which the 'dbt_utils.unique_combination_of_columns' test should be applied.
                                      Defaults to [].
        mkdir (bool, optional): If True, creates a directory for the new model(s). Defaults to True.

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
    yaml_obj = yaml.YAML(typ='rt')
    yaml_obj.indent(mapping=4, sequence=4, offset=2)

    data = yaml.comments.CommentedMap()
    data['version'] = 2
    data.yaml_set_comment_before_after_key('models', before='\n\n')
    data['models'] = []            

    if isinstance(table_id, str):
        if mkdir:
            os.makedirs(f"./models/{dataset_id}/", exist_ok=True)
        else:
            print("Directory for the new model has not been created, saving files in /queries-basedosadados-dev/gists/")    
        
        # If table_id is a string, assume a single input file
        dataframe = sheet_to_df(arq_url)
        conjunto = yaml.comments.CommentedMap()
        conjunto['name'] = f'{table_id}'
        conjunto['description'] = f"Insert `{table_id}` table description here"
        conjunto['tests'] = create_unique_combination(unique_keys)
        conjunto['columns'] = []

        for _, row in dataframe.iterrows():
            if not pd.isna(row["directory_column"]):
                name = row['name']
                description = row['description']
                directory = row["directory_column"]
                coluna = yaml.comments.CommentedMap()
                coluna['name'] = name
                coluna['description'] = description
                tests = []
                tests += create_not_null_proportion(at_least)
                tests += create_relationships(directory)
                coluna['tests'] = tests
                conjunto['columns'].append(coluna)
            else:
                name = row['name']
                description = row['description']
                coluna = yaml.comments.CommentedMap()
                coluna['name'] = name
                coluna['description'] = description
                tests = []
                tests += create_not_null_proportion(at_least)
                coluna['tests'] = tests
                conjunto['columns'].append(coluna)

        data['models'].append(conjunto)

    elif isinstance(table_id, list):
        # If table_id is a list, assume multiple input files
        if not isinstance(arq_url, list) or len(arq_url) != len(table_id):
            raise ValueError("The number of URLs or file paths must match the number of table IDs.")
        if mkdir:
            os.makedirs(f"./models/{dataset_id}/", exist_ok=True)
        else:
            print("Directory for the new model has not been created, saving files in /queries-basedosadados-dev/gists/")    

        for url, id in zip(arq_url, table_id):
            dataframe = sheet_to_df(url)
            conjunto = yaml.comments.CommentedMap()
            conjunto['name'] = f'{id}'
            conjunto['description'] = f"Insert `{id}` table description here"
            conjunto['tests'] = create_unique_combination(unique_keys)
            conjunto['columns'] = []

            for _, row in dataframe.iterrows():
                if not pd.isna(row["directory_column"]):
                    name = row['name']
                    description = row['description']
                    directory = row["directory_column"]
                    coluna = yaml.comments.CommentedMap()
                    coluna['name'] = name
                    coluna['description'] = description
                    tests = []
                    tests += create_not_null_proportion(at_least)
                    tests += create_relationships(directory)
                    coluna['tests'] = tests
                    conjunto['columns'].append(coluna)
                else:
                    name = row['name']
                    description = row['description']
                    coluna = yaml.comments.CommentedMap()
                    coluna['name'] = name
                    coluna['description'] = description
                    tests = []
                    tests += create_not_null_proportion(at_least)
                    coluna['tests'] = tests
                    conjunto['columns'].append(coluna)

            data['models'].append(conjunto)

    else:
        raise TypeError("The table_id must be a string or a list.")

    if mkdir:       
        with open(f"./models/{dataset_id}/schema.yml", 'w') as file:
            yaml_obj.dump(data, file)

        print(f"{table_id}")
        create_models_from_architectures(arq_url,
                                         output_dir=f"./models/{dataset_id}/",
                                         dataset_id=dataset_id,
                                         table_ids=table_id)               
    else:
        with open("./gists/schema.yml", 'w') as file:
            yaml_obj.dump(data, file)

        create_models_from_architectures(arq_url,
                                         output_dir=f"./gists/{dataset_id}/",
                                         dataset_id=dataset_id,
                                         table_ids=table_id)           
    print("Files successfully created!")