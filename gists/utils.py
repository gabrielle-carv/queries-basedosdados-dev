import pandas as pd
import ruamel.yaml as yaml
import requests 
from io import StringIO

def sheet_to_df(columns_config_url_or_path):
    """
    Convert sheet to dataframe
    """
    url = columns_config_url_or_path.replace("edit#gid=", "export?format=csv&gid=")
    try:
        return pd.read_csv(StringIO(requests.get(url, timeout=10).content.decode("utf-8")), dtype= str, na_values= "")
    except:
        print(
            "Check if your google sheet Share are: Anyone on the internet with this link can view"
        )
        
def create_model_from_architecture(architecture_df, output_dir, dataset_id, table_id, preprocessed_staging_column_names = True):

        if preprocessed_staging_column_names:
            architecture_df['original_name'] = architecture_df['name']

        with open(f"{output_dir}/{dataset_id}__{table_id}.sql", 'w') as file:
            sql_config = "{{ config(alias=" + f"'{table_id}'," + "schema=" + f"'{dataset_id}'" + ") }}\n"
            file.write(sql_config)
            sql_first_line = "select\n"
            file.write(sql_first_line)

            for _, column in architecture_df.iterrows():
                sql_line = f"safe_cast({column['original_name']} as {column['bigquery_type'].lower()}) {column['name']},\n"
                file.write(sql_line)

            sql_last_line = f"from `basedosdados-dev.{dataset_id}_staging.{table_id}` as t\n\n"
            file.write(sql_last_line)
        
def transform_string(input_string, delimiter=':', field=bool):
    try:
        parts = input_string.split(delimiter)

        if len(parts) == 2:
            dataset_coluna, id_coluna = parts

            if field:
                return id_coluna

            try:
                bucket, dataset, table = dataset_coluna.split(".")
                resultado = f'{dataset}__{table}'
                return f"ref('{resultado}')"
            except ValueError:
                print(f"Invalid format on `{input_string}`. Bucket id not found.")
                dataset, table = dataset_coluna.split(".")
                resultado = f'{dataset}__{table}'
                return f"ref('{resultado}')"
        else:
            print(f"Invalid input format on `{input_string}`. Expected format: 'dataset.column'")
            return None
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
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

def create_unique_combination(unique_keys):
        combinations = []
        combination = yaml.comments.CommentedMap()
        combination['dbt_utils.unique_combination_of_columns'] = {
            "combination_of_columns": unique_keys
        }
        combinations.append(combination)
        return combinations        

def create_not_null_proportion(at_least):
        not_null_proportion = []
        not_null = yaml.comments.CommentedMap()
        not_null['dbt_utils.not_null_proportion'] = {
            "at_least": at_least,
        }
        not_null_proportion.append(not_null)
        return not_null_proportion

def create_unique():
        return ["unique", "not_null"]

