{{
  config(
    alias = 'proposicao_tema',
    schema='br_camara_dados_abertos',
    materialized='table',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 1935,
        "end": 2024,
        "interval": 1}
    }
    )
}}

SELECT
    SAFE_CAST(ano AS STRING) ano,
    SAFE_CAST(uriProposicao AS STRING) id_proposicao,
    SAFE_CAST(siglaTipo AS STRING) tipo_proposicao,
    SAFE_CAST(codTipoAutor AS STRING) tipo_autor,
    SAFE_CAST(id_tema AS STRING) codTema,
    SAFE_CAST(numero AS STRING) numero,
    SAFE_CAST(relevancia AS STRING) relevancia,    
FROM basedosdados-dev.br_camara_dados_abertos_staging.proposicao_tema AS t