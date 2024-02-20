{{ config(alias='evento_requerimento',schema='br_camara_dados_abertos') }}
SELECT
SAFE_CAST(idEvento AS STRING) id_evento,
SAFE_CAST(tituloRequerimento AS STRING) titulo_requerimento,
FROM basedosdados-dev.br_camara_dados_abertos_staging.evento_requerimento AS t