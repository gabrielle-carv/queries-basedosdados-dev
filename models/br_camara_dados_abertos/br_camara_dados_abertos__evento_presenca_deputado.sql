{{ config(alias='evento_presenca_deputado',schema='br_camara_dados_abertos') }}
SELECT
DISTINCT
SAFE_CAST(idEvento AS STRING) id_evento,
SAFE_CAST(SPLIT(FORMAT_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S', TIMESTAMP(dataHoraInicio)), 'T')[OFFSET(0)] AS DATE) data_inicio,
SAFE_CAST(SPLIT(FORMAT_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S', TIMESTAMP(dataHoraInicio)), 'T')[OFFSET(1)] AS TIME) horario_inicio,
SAFE_CAST(idDeputado AS STRING) id_deputado,
FROM basedosdados-dev.br_camara_dados_abertos_staging.evento_presenca_deputado AS t

