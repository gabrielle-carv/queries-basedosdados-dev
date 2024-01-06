{{config(alias = 'proposicao_autor',schema='br_camara_dados_abertos')}}

SELECT
    SAFE_CAST(idProposicao AS STRING) id_proposicao,
    SAFE_CAST(uriProposicao AS STRING) url_proposicao,
    SAFE_CAST(idDeputadoAutor AS STRING) id_deputado,
    SAFE_CAST(codTipoAutor AS STRING) tipo_autor,
    SAFE_CAST(nomeAutor AS STRING) nome_autor,
    SAFE_CAST(siglaPartidoAutor AS STRING) sigla_partido,
    SAFE_CAST(SiglaUFAutor AS STRING) sigla_uf_autor,
    SAFE_CAST(ordemAssinatura AS STRING) ordem_assinatura,
    SAFE_CAST(proponente AS STRING) proponente,
    SAFE_CAST(uriAutor AS STRING) url_autor,
    SAFE_CAST(uriPartidoAutor AS STRING) url_partido,
FROM basedosdados-dev.br_camara_dados_abertos_staging.proposicao_autor AS t