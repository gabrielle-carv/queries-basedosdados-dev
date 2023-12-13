{{ config(alias='populacao_grupos_idade_uf',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(grupo_idade AS STRING) grupo_idade,
SAFE_CAST(populacao AS INT64) populacao,
FROM basedosdados-dev.br_ibge_censo_2022_staging.populacao_grupos_idade_uf AS t

