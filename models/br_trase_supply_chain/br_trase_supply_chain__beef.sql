{{ config(
    alias='beef', 
    schema='br_trase_supply_chain') 
}}

SELECT
SAFE_CAST(YEAR AS INT64) year,
SAFE_CAST(COUNTRY OF PRODUCTION AS STRING) country_production,
SAFE_CAST(BIOME AS STRING) biome,
SAFE_CAST(STATE AS STRING) state,
SAFE_CAST(MUNICIPALITY AS STRING) municipality_production,
SAFE_CAST(LOGISTICS HUB AS STRING) municipality_logistics_hub,
SAFE_CAST(EXPORTER AS STRING) exporter,
SAFE_CAST(EXPORTER GROUP AS STRING) exporter_group,
SAFE_CAST(IMPORTER AS STRING) importer,
SAFE_CAST(IMPORTER GROUP AS STRING) importer_group,
SAFE_CAST(nan AS STRING) country_first_import_iso3,
SAFE_CAST(COUNTRY OF FIRST IMPORT AS STRING) country_first_import_name,
SAFE_CAST(ECONOMIC BLOC AS STRING) economic_bloc,
SAFE_CAST(TYPE AS STRING) type,
SAFE_CAST(countries AS STRING) cattle_deforestation_exposure,
SAFE_CAST(FOB_USD AS FLOAT64) fob_usd,
SAFE_CAST(CO2_EMISSIONS_CATTLE_DEFORESTATION_5_YEAR_TOTAL_EXPOSURE AS FLOAT64) co2_emissions_deforestation_5,
SAFE_CAST(BEEF_EQUIVALENT_TONNES AS FLOAT64) beef_tonnes,
SAFE_CAST(ZERO_DEFORESTATION_BRAZIL_BEEF AS FLOAT64) zero_deforestation_commitments,
SAFE_CAST(LAND_USE AS FLOAT64) land_use,
SAFE_CAST(PRODUCT_DESCR AS STRING) product_description,
SAFE_CAST(TRASE_GEOCODE AS STRING) trase_geocode
FROM basedosdados-dev.br_trase_supply_chain_staging.beef AS t