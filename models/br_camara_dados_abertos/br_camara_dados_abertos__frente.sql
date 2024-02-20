{{ config(alias='frente',schema='br_camara_dados_abertos') }}
SELECT
SAFE_CAST(id AS STRING) id,
SAFE_CAST(titulo AS STRING) titulo,
SAFE_CAST(dataCriacao AS DATE) data_criacao,
SAFE_CAST(idLegislatura AS STRING) id_legislatura,
SAFE_CAST(telefone AS STRING) telefone,
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(urlDocumento AS STRING) url_documento,
SAFE_CAST(coordenador_id AS STRING) id_coordenador,
SAFE_CAST(coordenador_nome AS STRING) nome_coordenador,
safe_cast(coordenador_urlfoto as string) url_foto_coordenador,
FROM basedosdados-dev.br_camara_dados_abertos_staging.frente AS t

