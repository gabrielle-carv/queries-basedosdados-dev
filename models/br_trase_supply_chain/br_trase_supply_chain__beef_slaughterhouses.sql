{{ config(
    alias='beef_slaughterhouses', 
    schema='br_trase_supply_chain') 
}}

SELECT
SAFE_CAST(the_geom AS STRING) geom_id,
SAFE_CAST(cartodb_id AS STRING) cartodb_id,
SAFE_CAST(the_geom_webmercator AS STRING) geom_webmercator_id,
SAFE_CAST(id AS STRING) slaugtherhouse_id,
SAFE_CAST(company AS STRING) company,
SAFE_CAST(geocode AS STRING) municipality_id,
SAFE_CAST(municipality AS STRING) municipality_name,
SAFE_CAST(uf AS STRING) state_id,
SAFE_CAST(lat AS GEOGRAPHY) latitude,
SAFE_CAST(long AS GEOGRAPHY) longitude,
SAFE_CAST(resolution AS STRING) resolution_id,
SAFE_CAST(subclass AS STRING) subclass,
SAFE_CAST(inspection_level AS STRING) inspection_level,
SAFE_CAST(other_names AS STRING) other_names,
SAFE_CAST(inspection_number AS STRING) inspection_number,
SAFE_CAST(tac AS STRING) tac,
SAFE_CAST(status AS STRING) status,
SAFE_CAST(address AS STRING) address,
SAFE_CAST(date_sif_registered AS STRING) date_sif_registered,
SAFE_CAST(sif_category AS STRING) sif_category,
SAFE_CAST(multifunctions AS STRING) multifunctions
FROM basedosdados-dev.br_trase_supply_chain_staging.beef_slaughterhouses AS t