{{ config(alias='frente_deputado',schema='br_camara_dados_abertos') }}
SELECT
SAFE_CAST(id AS STRING) id_frente,
SAFE_CAST(titulo AS STRING) titulo,
REPLACE(SAFE_CAST(id_deputado AS STRING), ".0", "") id_deputado,
INITCAP(nome_deputado) nome_deputado,
SAFE_CAST(titulo_deputado AS STRING) titulo_deputado,
SAFE_CAST(url_foto_deputado AS STRING) url_foto_deputado,
FROM basedosdados-dev.br_camara_dados_abertos_staging.frente_deputado AS t