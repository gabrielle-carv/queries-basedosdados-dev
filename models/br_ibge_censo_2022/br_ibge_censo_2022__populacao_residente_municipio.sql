{{ config(alias='populacao_residente_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(forma_declaracao_idade AS STRING) forma_declaracao_idade,
SAFE_CAST(sexo AS STRING) sexo,
SAFE_CAST(idade AS STRING) idade,
SAFE_CAST(populacao_residente AS INT64) populacao_residente,
FROM basedosdados-dev.br_ibge_censo_2022_staging.populacao_residente_municipio AS t

