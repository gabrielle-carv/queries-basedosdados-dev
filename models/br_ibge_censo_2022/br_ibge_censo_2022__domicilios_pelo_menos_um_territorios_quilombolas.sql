{{ config(alias='domicilios_pelo_menos_um_territorios_quilombolas',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(territorio_quilombola AS STRING) territorio_quilombola,
SAFE_CAST(domicilios_territorios_quilombolas AS STRING) domicilios_territorios_quilombolas,
SAFE_CAST(moradores_domicilios_territorios_quilombolas AS INT64) moradores_domicilios_territorios_quilombolas,
SAFE_CAST(moradores_quilombolas_domicilios_territorios_quilombolas AS INT64) moradores_quilombolas_domicilios_territorios_quilombolas,
SAFE_CAST(media_moradores_domicilios_territorios_quilombolas AS FLOAT64) media_moradores_domicilios_territorios_quilombolas,
SAFE_CAST(media_moradores_quilombolas_domicilios_territorios_quilombolas AS FLOAT64) media_moradores_quilombolas_domicilios_territorios_quilombolas,
FROM basedosdados-dev.br_ibge_censo_2022_staging.domicilios_pelo_menos_um_territorios_quilombolas AS t

