{{ 
  config(
    alias='ano',    
    schema='br_bd_diretorios_data_tempo')
}}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(bissexto AS INT64) bissexto
FROM basedosdados-dev.br_bd_diretorios_data_tempo_staging.ano AS t