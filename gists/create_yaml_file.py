import pandas as pd
import ruamel.yaml as yaml
import requests 
from io import StringIO

def create_yaml_file(arq_url, output_file, table_id, not_nul_columns):
    """
    Creates a YAML file based on the given input and saves it to the specified output file.
    Args:
        arq_url (str or list): The URL(s) or file path(s) of the input file(s) containing the data.
        output_file (str): The file path to save the generated YAML file.
        table_id (str or list): The table ID(s) or name(s) to use as the YAML model name(s).
    Raises:
        TypeError: If the table_id is not a string or a list.
    """
    yaml_obj = yaml.YAML(typ='rt')
    yaml_obj.indent(mapping=4, sequence=4, offset=2)

    data = yaml.comments.CommentedMap()
    data['version'] = 2
    data.yaml_set_comment_before_after_key('models', before='\n\n')
    data['models'] = []

    def sheet_to_df(columns_config_url_or_path):
        """
        Convert sheet to dataframe
        """
        url = columns_config_url_or_path.replace("edit#gid=", "export?format=csv&gid=")
        try:
            return pd.read_csv(StringIO(requests.get(url, timeout=10).content.decode("utf-8")))
        except:
            print(
                "Check if your google sheet Share are: Anyone on the internet with this link can view"
            )
    
    def transform_string(input_string, delimiter=':', field = bool):
        parts = input_string.split(delimiter)
    
        if len(parts) == 2:
            dataset_coluna, id_coluna = parts

            if field:
                return id_coluna
            else:
                bucket, dataset, table = dataset_coluna.split(".")
                resultado = f'{dataset}__{table}'
                return f"ref('{resultado}')"
        else:
            return None  

    def create_relationships(directory_column):
        relationships = []
        relationship = yaml.comments.CommentedMap()
        relationship['relationships'] = {
            "to": transform_string(f"{directory_column}", field=False),
            "field": transform_string(f"{directory_column}", field=True)
        }
        relationships.append(relationship)
        return relationships  

    def create_not_null_proportion(at_least):
        not_null_proportion = []
        not_null = yaml.comments.CommentedMap()
        not_null['dbt_utils.not_null_proportion'] = {
            "at_least": at_least,
        }
        not_null_proportion.append(not_null)
        return not_null_proportion            

    if isinstance(table_id, str):
        # If table_id is a string, assume a single input file
        dataframe = sheet_to_df(arq_url)
        conjunto = yaml.comments.CommentedMap()
        conjunto['name'] = f'{table_id}'
        conjunto['description'] = f"Insert `{table_id}` table description here"
        conjunto['columns'] = []
        

        for _, row in dataframe.iterrows():
            if not pd.isna(row["directory_column"]):
                name = row['name']
                description = row['description']
                directory = row["directory_column"]
                coluna = yaml.comments.CommentedMap()
                coluna['name'] = name
                coluna['description'] = description
                coluna['tests'] = create_relationships(directory)
                conjunto['columns'].append(coluna)
            else:
                name = row['name']
                description = row['description']
                coluna = yaml.comments.CommentedMap()
                coluna['name'] = name
                coluna['description'] = description
                coluna['tests'] = create_not_null_proportion(at_least=0.05) if name in not_nul_columns else None
                conjunto['columns'].append(coluna)

        data['models'].append(conjunto)

    elif isinstance(table_id, list):
        # If table_id is a list, assume multiple input files
        if not isinstance(arq_url, list) or len(arq_url) != len(table_id):
            raise ValueError("The number of URLs or file paths must match the number of table IDs.")
        
        for url, id in zip(arq_url, table_id):
            dataframe = sheet_to_df(url)
            conjunto = yaml.comments.CommentedMap()
            conjunto['name'] = f'{id}'
            conjunto['description'] = f"Insert `{id}` table description here"
            conjunto['columns'] = []

            for _, row in dataframe.iterrows():
                if not pd.isna(row["directory_column"]):
                    name = row['name']
                    description = row['description']
                    directory = row["directory_column"]
                    coluna = yaml.comments.CommentedMap()
                    coluna['name'] = name
                    coluna['description'] = description
                    coluna['tests'] = create_relationships(directory)
                    conjunto['columns'].append(coluna)
                else:
                    name = row['name']
                    description = row['description']
                    coluna = yaml.comments.CommentedMap()
                    coluna['name'] = name
                    coluna['description'] = description
                    coluna['tests'] = create_not_null_proportion(at_least=0.05) if name in not_nul_columns else None
                    conjunto['columns'].append(coluna)

            data['models'].append(conjunto)

    else:
        raise TypeError("The table_id must be a string or a list.")

    with open(output_file, 'w') as file:
        yaml_obj.dump(data, file)