{{ 
  config(
    schema='br_ms_cnes',
    materialized='incremental',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2005,
        "end": 2023,
        "interval": 1}
     },
     pre_hook = "DROP ALL ROW ACCESS POLICIES ON {{ this }}",
     post_hook = [ 
      'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                    ON {{this}}
                    GRANT TO ("allUsers")
                    FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
      'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
       ON  {{this}}
                    GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                    FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)'      
     ]   
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
SAFE_CAST(SGRUPHAB AS STRING) tipo_habilitacao,
CASE WHEN SAFE_CAST(SGRUPHAB AS STRING) IN ("0901","0902","0903","0904","0905","0906","0907","1901","1902","2901","3304") THEN '2' ELSE '1' END AS nivel_habilitacao,
SAFE_CAST(PORTARIA AS STRING) portaria,
SAFE_CAST(CONCAT(SUBSTRING(DTPORTAR,-4),'-',SUBSTRING(DTPORTAR,-7,2),'-',SUBSTRING(DTPORTAR,1,2)) AS DATE) data_portaria,
CAST(SUBSTR(MAPORTAR, 1, 4) AS INT64) AS ano_portaria,
CAST(SUBSTR(MAPORTAR, 5, 2) AS INT64) AS mes_portaria,
FROM cnes_add_muni AS t
{% if is_incremental() %} 
WHERE DATE(CAST(ano AS INT64),CAST(mes AS INT64),1) > (SELECT MAX(DATE(CAST(ano AS INT64),CAST(mes AS INT64),1)) FROM {{ this }} )
{% endif %}