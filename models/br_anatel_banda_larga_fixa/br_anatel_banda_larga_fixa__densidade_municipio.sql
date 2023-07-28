{{ config(
    alias='densidade_municipio',
    schema='br_anatel_banda_larga_fixa',
    materialized='table',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2007,
        "end": 2023,
        "interval": 1}
    },
    cluster_by = ["id_municipio", "mes"],
    labels = {'project_id': 'basedosdados-dev'})
 }}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(densidade AS FLOAT64) densidade
FROM basedosdados-dev.br_anatel_banda_larga_fixa_staging.densidade_municipio AS t
WHERE (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6
  OR  DATE_DIFF(DATE(2023,5,1),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 0)