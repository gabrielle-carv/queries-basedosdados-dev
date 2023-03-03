{{ config(materialized='view') }}
SELECT 
    SAFE_CAST(elemento AS string) elemento, 
    SAFE_CAST(chave AS string) chave,
    SAFE_CAST(valor AS string) valor,
FROM basedosdados-dev.bd_available_options_staging.available_options_test as t
