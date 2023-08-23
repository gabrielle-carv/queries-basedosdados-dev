{{ config(
    alias='municipio',
    schema='br_inep_saeb',
    materialized='table',
    labels = {'project_id': 'basedosdados-dev', 'tema': 'educacao'})
 }}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(rede AS STRING) rede,
SAFE_CAST(localizacao AS STRING) localizacao,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(disciplina AS STRING) disciplina,
SAFE_CAST(serie AS INT64) serie,
SAFE_CAST(media AS FLOAT64) media,
SAFE_CAST(nivel_0 AS FLOAT64) nivel_0,
SAFE_CAST(nivel_1 AS FLOAT64) nivel_1,
SAFE_CAST(nivel_2 AS FLOAT64) nivel_2,
SAFE_CAST(nivel_3 AS FLOAT64) nivel_3,
SAFE_CAST(nivel_4 AS FLOAT64) nivel_4,
SAFE_CAST(nivel_5 AS FLOAT64) nivel_5,
SAFE_CAST(nivel_6 AS FLOAT64) nivel_6,
SAFE_CAST(nivel_7 AS FLOAT64) nivel_7,
SAFE_CAST(nivel_8 AS FLOAT64) nivel_8,
SAFE_CAST(nivel_9 AS FLOAT64) nivel_9,
SAFE_CAST(nivel_10 AS FLOAT64) nivel_10
FROM basedosdados-dev.br_inep_saeb_staging.municipio AS t