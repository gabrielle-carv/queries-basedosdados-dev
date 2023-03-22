SELECT
  SAFE_CAST(element AS STRING) element,
  SAFE_CAST(key AS STRING) key,
  SAFE_CAST(valor AS STRING) valor,
FROM `basedosdados-dev.br_bd_metadados_staging.columns` AS t 