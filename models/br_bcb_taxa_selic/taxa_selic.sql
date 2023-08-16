SELECT 
SAFE_CAST(data AS DATE) data,
SAFE_CAST(valor AS FLOAT) valor,
FROM basedosdados-dev.br_bcb_taxa_selic_staging.taxa_selic AS t