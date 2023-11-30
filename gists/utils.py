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
        return pd.read_csv(StringIO(requests.get(url, timeout=10).content.decode("utf-8")))
    except:
        print(
            "Check if your google sheet Share are: Anyone on the internet with this link can view"
        )

def create_models_from_architectures(architectures, output_dir, dataset_id, table_ids):
        """
        Create SQL files based on the provided DataFrames for multiple architectures.

        Parameters:
        - architectures (list or DataFrame): List of DataFrames or a single DataFrame representing the architectures.
        - output_dir (str): The directory where the SQL files will be saved.
        - dataset_id (str): Identifier for the dataset.
        - table_ids (list or str): List of table identifiers or a single table identifier corresponding to each architecture.

        Notes:
        - If 'architectures' or 'table_ids' is not a list, it will be converted to a list.
        - The function generates SQL files for each architecture, named as "{output_dir}/{dataset_id}__{table_id}.sql".
        """
        if not isinstance(architectures, list):
            architectures = [architectures]
        if not isinstance(table_ids, list):
            table_ids = [table_ids]                        

        for architecture, table_id in zip(architectures,  table_ids):
            dataframe = sheet_to_df(architecture)
            with open(f"{output_dir}/{dataset_id}__{table_id}.sql", 'w') as file:
                sql_config = "{{ config(alias=" + f"'{table_id}'," + "schema=" + f"'{dataset_id}'" + ") }}\n"
                file.write(sql_config)
                sql_first_line = "SELECT\n"
                file.write(sql_first_line)

                for _, row in dataframe.iterrows():
                    name = row['name']
                    bigquery_type = row['bigquery_type'].upper()
                    sql_line = f'SAFE_CAST({name} AS {bigquery_type}) {name},\n'
                    file.write(sql_line)

                sql_last_line = f"FROM basedosdados-staging.{dataset_id}_staging.{table_id} AS t\n\n"
                file.write(sql_last_line)
        
        

def transform_string(input_string, delimiter=':', field=bool):
        parts = input_string.split(delimiter)

        if len(parts) == 2:
            dataset_coluna, id_coluna = parts

            if field:
                return id_coluna
            try:
                bucket, dataset, table = dataset_coluna.split(".")
                resultado = f'{dataset}__{table}'
                return f"ref('{resultado}')"
            except Exception:
                print("Bucket id not found in `directory_column`, using dataset_id and table_id instead.")
                dataset, table = dataset_coluna.split(".")
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

def create_unique():
        return ["unique", "not_null"]
