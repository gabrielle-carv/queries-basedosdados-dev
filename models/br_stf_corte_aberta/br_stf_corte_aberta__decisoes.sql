{{ 
config(
    schema='br_stf_carta_aberta',
    alias='decisoes',
    materialized='table',
    partition_by={
    "field": "ano",
    "data_type": "int64",
    "range": {
        "start": 2000,
        "end": 2023,
        "interval": 1}
    },
    labels =  {'tema': 'direito'},
    )
}}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(classe AS STRING) classe,
SAFE_CAST(numero AS STRING) numero,
SAFE_CAST(relator AS STRING) relator,
SAFE_CAST(link AS STRING) link,
SAFE_CAST(subgrupo_andamento AS STRING) subgrupo_andamento,
SAFE_CAST(andamento AS STRING) andamento,
SAFE_CAST(observacao_andamento_decisao AS STRING) observacao_andamento_decisao,
SAFE_CAST(modalidade_julgamento AS STRING) modalidade_julgamento,
SAFE_CAST(tipo_julgamento AS STRING) tipo_julgamento,
SAFE_CAST(meio_tramitacao AS STRING) meio_tramitacao,
SAFE_CAST(indicador_tramitacao AS BOOL) indicador_tramitacao,
SAFE_CAST(assunto_processo AS STRING) assunto_processo,
SAFE_CAST(ramo_direito AS STRING) ramo_direito,
SAFE_CAST(data_autuacao AS DATE) data_autuacao,
SAFE_CAST(data_decisao AS DATE) data_decisao,
SAFE_CAST(data_baixa_processo AS DATE) data_baixa_processo
FROM basedosdados-dev.br_stf_corte_aberta_staging.decisoes AS t