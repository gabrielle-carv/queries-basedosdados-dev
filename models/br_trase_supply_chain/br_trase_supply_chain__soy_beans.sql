{{ config(
    alias='soy_beans', 
    schema='br_trase_supply_chain') 
}}

SELECT
SAFE_CAST(YEAR AS INT64) year,
SAFE_CAST(COUNTRY OF PRODUCTION AS STRING) country_production_iso3,
SAFE_CAST(BIOME AS STRING) biome,
SAFE_CAST(STATE AS STRING) state,
SAFE_CAST(MUNICIPALITY OF PRODUCTION AS STRING) municipality_production,
SAFE_CAST(LOGISTICS HUB AS STRING) municipality_logistics_hub,
SAFE_CAST(PORT OF EXPORT AS STRING) export_port,
SAFE_CAST(EXPORTER AS STRING) exporter_name,
SAFE_CAST(EXPORTER GROUP AS STRING) exporter_group,
SAFE_CAST(IMPORTER AS STRING) importer_name,
SAFE_CAST(IMPORTER GROUP AS STRING) importer_group,
---SAFE_CAST(nan AS STRING) country_first_import_iso3,
SAFE_CAST(COUNTRY OF FIRST IMPORT AS STRING) country_first_import_name,
SAFE_CAST(ECONOMIC BLOC AS STRING) economic_bloc_first_import_name,
SAFE_CAST(TYPE AS STRING) type,
SAFE_CAST(Soy deforestation exposure AS STRING) soy_deforestation_exposure,
SAFE_CAST(CO2_GROSS_EMISSIONS_SOY_DEFORESTATION_5_YEAR_TOTAL_EXPOSURE AS FLOAT64) co2_gross_emissions_deforestation_5,
SAFE_CAST(CO2_NET_EMISSIONS_SOY_DEFORESTATION_5_YEAR_TOTAL_EXPOSURE AS FLOAT64) co2_net_emissions_deforestation_5,
SAFE_CAST(LAND_USE_HA AS FLOAT64) land_use,
SAFE_CAST(FOB_USD AS FLOAT64) fob_usd,
SAFE_CAST(SOY_EQUIVALENT_TONNES AS FLOAT64) soy_total_export,
SAFE_CAST(Soy deforestation risk AS FLOAT64) soy_risk,
SAFE_CAST(ZERO_DEFORESTATION_BRAZIL_SOY AS STRING) zero_deforestation_commitments,
SAFE_CAST(TRASE_GEOCODE AS STRING) trase_geocode
FROM basedosdados-dev.br_trase_supply_chain_staging.soy_beans AS t