{{ config(alias='populacao_residente_terras_indigenas',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(terra_indigena AS STRING) terra_indigena,
SAFE_CAST(pessoas_residentes_terras_indigenas AS INT64) pessoas_residentes_terras_indigenas,
SAFE_CAST(pessoas_indigenas_residentes_terras_indigenas AS INT64) pessoas_indigenas_residentes_terras_indigenas,
SAFE_CAST(quesito_declaracao_indigena AS STRING) quesito_declaracao_indigena,
FROM basedosdados-dev.br_ibge_censo_2022_staging.populacao_residente_terras_indigenas AS t

