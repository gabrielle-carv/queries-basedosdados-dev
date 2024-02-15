SELECT
  SAFE_CAST(element AS STRING) element,
  SAFE_CAST(key AS STRING) key,
  SAFE_CAST(value AS STRING) value,
FROM `basedosdados-dev.br_bd_metadados_staging.available_options` AS t 