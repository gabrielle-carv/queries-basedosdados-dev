SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(id_face_quadra AS STRING) id_face_quadra,
SAFE_CAST(logradouro AS STRING) logradouro,
SAFE_CAST(geometria AS STRING) geometria,
SAFE_CAST(metrica AS STRING) metrica,
SAFE_CAST(pavimentacao AS STRING) pavimentacao,
SAFE_CAST(agua AS STRING) agua,
SAFE_CAST(esgoto AS STRING) esgoto,
SAFE_CAST(galeria_pluvial AS STRING) galeria_pluvial,
SAFE_CAST(sarjeta AS STRING) sarjeta,
SAFE_CAST(iluminacao_publica AS STRING) iluminacao_publica,
SAFE_CAST(arborizacao AS STRING) arborizacao,
SAFE_CAST(latitude AS float64) latitude,
SAFE_CAST(longitude AS float64) longitude,
SAFE_CAST(valor AS float64) valor
FROM basedosdados-dev.br_ce_fortaleza_sefin_dados_imobiliarios_staging.face_quadra AS t