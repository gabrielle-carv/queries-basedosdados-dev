SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(acessos AS INT64) acessos,
SAFE_CAST(densidade AS FLOAT64) densidade
FROM basedosdados-dev.br_anatel_banda_larga_fixa_staging.densidade_brasil AS t