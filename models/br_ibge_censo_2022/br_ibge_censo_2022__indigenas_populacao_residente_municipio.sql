{{ config(alias='indigenas_populacao_residente_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(quesito_declaracao_indigena AS STRING) quesito_declaracao_indigena,
SAFE_CAST(localizacao_domicilio AS STRING) localizacao_domicilio,
SAFE_CAST(pessoas_indigenas AS INT64) pessoas_indigenas,
SAFE_CAST(populacao_residente AS INT64) populacao_residente,
FROM basedosdados-dev.br_ibge_censo_2022_staging.indigenas_populacao_residente_municipio AS t

