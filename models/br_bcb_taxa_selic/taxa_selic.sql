select safe_cast(data as date) data, safe_cast(valor as float64) valor,
from `basedosdados-dev.br_bcb_taxa_selic_staging.taxa_selic` as t
