{{ 
config(
    schema='br_stf_carta_aberta',
    alias='decisoes')
}}

SELECT 
SAFE_CAST(classe AS INT64) classe,
SAFE_CAST(numero AS STRING) numero,
SAFE_CAST(polo_ativo AS STRING) polo_ativo,
SAFE_CAST(advogado_polo_ativo AS STRING) advogado_polo_ativo,
SAFE_CAST(polo_passivo AS STRING) polo_passivo,
SAFE_CAST(advogado_polo_passivo AS STRING) advogado_polo_passivo,
FROM basedosdados-dev.br_stf_corte_aberta_staging.partes AS t