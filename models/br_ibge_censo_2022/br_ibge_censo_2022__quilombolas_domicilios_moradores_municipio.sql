{{ config(alias='quilombolas_domicilios_moradores_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(domicilios AS INT64) domicilios,
SAFE_CAST(moradores_domicilios AS INT64) moradores_domicilios,
SAFE_CAST(moradores_quilombolas_domicilios AS INT64) moradores_quilombolas_domicilios,
SAFE_CAST(media_moradres_domicilios AS FLOAT64) media_moradres_domicilios,
SAFE_CAST(media_moradores_quilombolas_domicilios AS FLOAT64) media_moradores_quilombolas_domicilios,
SAFE_CAST(localizacao_domicilio AS STRING) localizacao_domicilio,
FROM basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_domicilios_moradores_municipio AS t

