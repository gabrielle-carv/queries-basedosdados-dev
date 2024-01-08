{{ config(alias='populacao_residente_cor_raca',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(cor_raca AS STRING) cor_raca,
SAFE_CAST(populacao_residente AS INT64) populacao_residente,
FROM basedosdados-dev.br_ibge_censo_2022_staging.populacao_residente_cor_raca AS t

