{{ 
  config(
    alias='data',    
    schema='br_bd_diretorios_data_tempo',
    materialized='table',)
}}

SELECT 
SAFE_CAST(data AS DATE) data,
SAFE_CAST(dia AS INT64) dia,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(bimestre AS INT64) bimestre,
SAFE_CAST(trimestre AS INT64) trimestre,
SAFE_CAST(semestre AS INT64) semestre,
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(dia_semana AS INT64) dia_semana
FROM basedosdados-dev.br_bd_diretorios_data_tempo_staging.data AS t