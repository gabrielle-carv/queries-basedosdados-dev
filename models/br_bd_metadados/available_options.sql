SELECT
  SAFE_CAST(elemento AS STRING) elemento,
  SAFE_CAST(chave AS STRING) chave,
  SAFE_CAST(valor AS STRING) valor,
FROM `basedosdados-dev.br_bd_metadados_staging.columns` AS t