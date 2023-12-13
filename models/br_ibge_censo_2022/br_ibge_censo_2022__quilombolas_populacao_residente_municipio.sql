{{ config(alias='quilombolas_populacao_residente_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(territorios_quilombolas AS INT64) territorios_quilombolas,
SAFE_CAST(fora_territorios_quilombolas AS INT64) fora_territorios_quilombolas,
FROM basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_populacao_residente_municipio AS t

