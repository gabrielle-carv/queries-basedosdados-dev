{{ config(alias='area_territorial_densidade_demografica_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(populacao_residente AS INT64) populacao_residente,
SAFE_CAST(area_unidade_territorial AS INT64) area_unidade_territorial,
SAFE_CAST(densidade_demografica AS FLOAT64) densidade_demografica,
FROM basedosdados-dev.br_ibge_censo_2022_staging.area_territorial_densidade_demografica_municipio AS t

