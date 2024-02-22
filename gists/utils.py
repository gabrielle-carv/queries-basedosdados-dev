import pandas as pd
import ruamel.yaml as yaml
import requests 
from io import StringIO
import re


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

def extract_column_parts(input_string):
    pattern_1 = re.compile(r"(\w+)\.(\w+):(\w+)")
    pattern_2 = re.compile(r"\w+\.(\w+)\.(\w+):(\w+)")
    
    if pattern_1.match(input_string):    
        return pattern_1.findall(input_string)[0]
    elif pattern_2.match(input_string): 
        return pattern_2.findall(input_string)[0]
    else: 
        raise ValueError(f"Invalid input format on `{input_string}`. Expected format: 'dataset.table:column'")

def extract_relationship_info(input_string):
    try:
        dataset, table, column = extract_column_parts(input_string)

        if column == table:
            column = f'{column}.{column}'
        
        field = f"ref('{column}')"
        table_path = f"ref('{dataset}__{table}')"

        return table_path, field

    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None

def create_relationships(directory_column):
        relationship_table, relationship_field  = extract_relationship_info(directory_column)
        list_relationships = []
        yaml_relationship = yaml.comments.CommentedMap()
        yaml_relationship['relationships'] = {
            "to": relationship_table,
            "field": relationship_field
        }
        list_relationships.append(yaml_relationship)
        return list_relationships

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
        not_null['not_null_proportion_multiple_columns'] = {
            "at_least": at_least,
        }
        not_null_proportion.append(not_null)
        return not_null_proportion

def create_unique():
        return ["unique", "not_null"]

