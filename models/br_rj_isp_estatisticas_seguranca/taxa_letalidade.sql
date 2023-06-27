SELECT

SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(regiao AS STRING) regiao,
SAFE_CAST(delito AS STRING) delito,
SAFE_CAST(contagem_delito AS FLOAT64) contagem_delito,
SAFE_CAST(populacao AS INT64) populacao,
SAFE_CAST(taxa_cem_mil_habitantes AS FLOAT64) taxa_cem_mil_habitantes

FROM basedosdados-dev.br_rj_isp_estatisticas_seguranca_staging.taxa_letalidade AS t