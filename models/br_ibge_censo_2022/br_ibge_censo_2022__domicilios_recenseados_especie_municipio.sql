{{ config(alias='domicilios_recenseados_especie_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(especie AS STRING) especie,
SAFE_CAST(domicilios_recenseados_domicilios_ AS INT64) domicilios_recenseados,
FROM basedosdados-dev.br_ibge_censo_2022_staging.domicilios_recenseados_especie_municipio AS t

