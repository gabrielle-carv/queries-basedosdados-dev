{{ config(
    alias='iptu',
    schema='br_mg_belohorizonte_smfa_iptu'
) }}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(indice_cadastral AS STRING) indice_cadastral,
SAFE_CAST(lote AS STRING) lote,
SAFE_CAST(zoneamento AS STRING) zoneamento,
SAFE_CAST(zona_homogenea AS STRING) zona_homogenea,
SAFE_CAST(cep AS STRING) cep,
SAFE_CAST(endereco AS STRING) endereco,
SAFE_CAST(tipo_construtivo AS STRING) tipo_construtivo,
SAFE_CAST(tipo_ocupacao AS STRING) tipo_ocupacao,
SAFE_CAST(padrao_acabamento AS STRING) padrao_acabamento,
SAFE_CAST(tipologia AS STRING) tipologia,
SAFE_CAST(codigo_quantidade_economia AS STRING) codigo_quantidade_economia,
SAFE_CAST(frequencia_coleta AS STRING) frequencia_coleta,
SAFE_CAST(indicador_rede_telefonica AS BOOL) indicador_rede_telefonica,
SAFE_CAST(indicador_meio_fio AS BOOL) indicador_meio_fio,
SAFE_CAST(indicador_pavimentacao AS BOOL) indicador_pavimentacao,
SAFE_CAST(indicador_arborizacao AS BOOL) indicador_arborizacao,
SAFE_CAST(indicador_galeria_pluvial AS BOOL) indicador_galeria_pluvial,
SAFE_CAST(indicador_iluminacao_publica AS BOOL) indicador_iluminacao_publica,
SAFE_CAST(indicador_rede_esgoto AS BOOL) indicador_rede_esgoto,
SAFE_CAST(indicador_agua AS BOOL) indicador_agua,
SAFE.ST_GEOGFROMTEXT(poligono) poligono,
SAFE_CAST(fracao_ideal AS INT64) fracao_ideal,
SAFE_CAST(area_terreno AS INT64) area_terreno,
SAFE_CAST(area_construida AS INT64) area_construida,
FROM basedosdados-dev.br_mg_belohorizonte_smfa_iptu_staging.iptu AS t