{{
  config(
    schema='br_me_cnpj',
    materialized='table',
    partition_by={
      "field": "data",
      "data_type": "date",
    }
  )
}}

SELECT 
SAFE_CAST(data AS DATE) data,
SAFE_CAST(lpad(cnpj_basico, 8, '0') AS STRING) cnpj_basico,
SAFE_CAST(razao_social AS STRING) razao_social,
SAFE_CAST(natureza_juridica AS STRING) natureza_juridica,
SAFE_CAST(qualificacao_responsavel AS STRING) qualificacao_responsavel,
SAFE_CAST(capital_social AS FLOAT64) capital_social,
SAFE_CAST(porte AS STRING) porte,
SAFE_CAST(ente_federativo AS STRING) ente_federativo
FROM basedosdados-dev.br_me_cnpj_staging.empresas AS t