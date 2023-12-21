SELECT
SAFE_CAST(id_uf AS STRING) id_uf,
SAFE_CAST(sigla AS STRING) sigla,
SAFE_CAST(nome AS STRING) nome,
SAFE_CAST(regiao AS STRING) regiao
FROM basedosdados-staging.br_bd_diretorios_brasil_staging.uf AS t