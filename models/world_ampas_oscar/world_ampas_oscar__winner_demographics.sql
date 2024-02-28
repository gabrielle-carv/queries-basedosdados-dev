{{ 
  config(
    alias='winner_demographics',    
    schema='world_ampas_oscar',
    materialized='table',
)
}}

SELECT 
SAFE_CAST(name AS STRING) name,
SAFE_CAST(birth_date AS DATE) birth_date,
SAFE_CAST(birthplace AS STRING) birthplace,
SAFE_CAST(race_ethnicity AS STRING) race_ethnicity,
SAFE_CAST(religion AS STRING) religion,
SAFE_CAST(sexual_orientation AS STRING) sexual_orientation,
SAFE_CAST(year_edition AS INT64) year_edition,
SAFE_CAST(category AS STRING) category,
SAFE_CAST(movie AS STRING) movie,
FROM basedosdados-dev.world_ampas_oscar_staging.winner_demographics AS t