{{ 
  config(
    schema='br_ms_cnes',
    materialized='table',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2005,
        "end": 2023,
        "interval": 1}
     }  
    )
 }}


WITH raw_cnes_leito AS (
  -- 1. Retirar linhas com id_estabelecimento_cnes nulo
  SELECT *
  FROM `basedosdados-dev.br_ms_cnes_staging.leito`
  WHERE CNES IS NOT NULL)
cnes_leito_duplicates AS (
    SELECT DISTINCT *
    FROM raw_cnes_leito
)  
cnes_add_muni AS (
  -- 3. Adicionar id_municipio 
  SELECT *
  FROM cnes_leito_duplicates  
  LEFT JOIN (SELECT id_municipio, id_municipio_6,
  FROM `basedosdados-dev.br_bd_diretorios_brasil.municipio`) as mun
  ON raw_cnes_estabelecimento_without_duplicates.CODUFMUN = mun.id_municipio_6
)

SELECT 
SAFE_CAST(ano AS INT64),
SAFE_CAST(mes AS INT64),
SAFE_CAST(id_municipio AS STRING),
SAFE_CAST(sigla_uf AS STRING),
SAFE_CAST(CNES AS STRING) AS id_estabelecimento_cnes,
SAFE_CAST(TP_LEITO AS STRING) AS tipo_leito,
SAFE_CAST(CODLEITO AS STRING) AS especialidade,
SAFE_CAST(QT_EXIST AS STRING) AS quantidade,
SAFE_CAST(QT_CONTR AS STRING) AS quantidade_contratado,
SAFE_CAST(QT_SUS AS STRING) AS quantidade_sus
FROM cnes_add_muni