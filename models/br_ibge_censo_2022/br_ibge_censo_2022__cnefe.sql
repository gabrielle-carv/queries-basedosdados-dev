{{
config(alias='cnefe',
schema='br_ibge_censo_2022',
materialized='table',
    partition_by={
      "field": "id_municipio",
      "data_type": "string",
},
cluster_by = ["id_municipio", "sigla_uf"])}}

SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(especie_endereco AS STRING) especie_endereco,
SAFE_CAST(nivel_geo_coordenada AS STRING) nivel_geo_coordenada,
SAFE_CAST(latitude AS GEOGRAPHY) latitude,
SAFE_CAST(longitude AS GEOGRAPHY) longitude,
FROM basedosdados-dev.br_ibge_censo_2022_staging.cnefe AS t

