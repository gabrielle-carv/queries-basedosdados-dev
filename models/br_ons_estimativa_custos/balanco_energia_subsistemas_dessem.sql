SELECT
SAFE_CAST(data AS DATE) data,
SAFE_CAST(hora AS TIME) hora,
SAFE_CAST(id_subsistema AS STRING) id_subsistema,
SAFE_CAST(subsistema AS STRING) subsistema,
SAFE_CAST(valor_demanda AS FLOAT64) valor_demanda,
SAFE_CAST(usina_hidraulica_verificada AS FLOAT64) usina_hidraulica_verificada,
SAFE_CAST(geracao_pequena_usina_hidraulica_verificada AS FLOAT64) geracao_pequena_usina_hidraulica_verificada,
SAFE_CAST(geracao_usina_termica_verificada AS FLOAT64) geracao_usina_termica_verificada,
SAFE_CAST(geracao_pequena_usina_termica_verificada AS FLOAT64) geracao_pequena_usina_termica_verificada,
SAFE_CAST(geracao_eolica_verificada AS FLOAT64) geracao_eolica_verificada,
SAFE_CAST(geracao_fotovoltaica_verificada AS FLOAT64) geracao_fotovoltaica_verificada
FROM basedosdados-dev.br_ons_estimativa_custos.balanco_energia_subsistemas_dessem AS t