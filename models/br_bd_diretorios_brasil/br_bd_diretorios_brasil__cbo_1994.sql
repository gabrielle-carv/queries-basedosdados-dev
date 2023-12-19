
{{ 
  config(
    alias='cbo_1994',    
    schema='br_bd_diretorios_brasil',
    materialized='table',)
}}

SELECT 
SAFE_CAST(cbo_1994 AS STRING) cbo_1994,
SAFE_CAST(descricao AS STRING) descricao
FROM basedosdados-dev.br_bd_diretorios_brasil_staging.cbo_1994 AS t