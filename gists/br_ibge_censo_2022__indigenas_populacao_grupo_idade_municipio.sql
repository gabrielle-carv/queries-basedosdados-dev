{{ config(alias='indigenas_populacao_grupo_idade_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(grupo_idade AS STRING) grupo_idade,
SAFE_CAST(sexo AS STRING) sexo,
SAFE_CAST(populacao_residente AS INT64) populacao_residente,
FROM basedosdados-dev.br_ibge_censo_2022_staging.indigenas_populacao_grupo_idade_municipio AS t

