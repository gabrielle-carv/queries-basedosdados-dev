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
WITH raw_cnes_habilitacaol AS (
  -- 1. Retirar linhas com id_estabelecimento_cnes nulo
  SELECT *
  FROM `basedosdados-dev.br_ms_cnes_staging.habilitacao`
  WHERE CNES IS NOT NULL
),
raw_cnes_habilitacao_without_duplicates as(
  -- 2. distinct nas linhas 
  SELECT DISTINCT *
  FROM raw_cnes_habilitacaol
),
cnes_add_muni AS (
  -- 3. Adicionar id_municipio e sigla_uf
  SELECT *
  FROM raw_cnes_habilitacao_without_duplicates  
  LEFT JOIN (SELECT id_municipio, id_municipio_6,
  FROM `basedosdados-dev.br_bd_diretorios_brasil.municipio`) as mun
  ON raw_cnes_habilitacao_without_duplicates.CODUFMUN = mun.id_municipio_6
)

SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(CNES AS STRING) id_estabelecimento_cnes,
SAFE_CAST(NULEITOS AS INT64) quantidade_leitos,
CAST(SUBSTR(CMPT_INI, 1, 4) AS INT64) AS ano_competencia_inicial,
CAST(SUBSTR(CMPT_INI, 5, 2) AS INT64) AS mes_competencia_inicial,
CAST(SUBSTR(CMPT_FIM, 1, 4) AS INT64) AS ano_competencia_final,
CAST(SUBSTR(CMPT_FIM, 5, 2) AS INT64) AS mes_competencia_final,
SAFE_CAST(SGRUPHAB AS STRING) habilitacao,
SAFE_CAST(PORTARIA AS STRING) portaria,
SAFE_CAST(DTPORTAR AS DATE) data_portaria,
CAST(SUBSTR(MAPORTAR, 1, 4) AS INT64) AS ano_portaria,
CAST(SUBSTR(MAPORTAR, 5, 2) AS INT64) AS mes_portaria,
FROM basedosdados-dev.br_ons.habilitacao AS t