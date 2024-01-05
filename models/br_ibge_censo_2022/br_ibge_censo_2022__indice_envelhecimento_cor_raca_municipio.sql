{{ config(alias='indice_envelhecimento_cor_raca_municipio',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(cor_raca AS STRING) cor_raca,
SAFE_CAST(indice_envelhecimento AS FLOAT64) indice_envelhecimento,
SAFE_CAST(idade_mediana AS INT64) idade_mediana,
SAFE_CAST(razao_sexo AS FLOAT64) razao_sexo,
FROM basedosdados-dev.br_ibge_censo_2022_staging.indice_envelhecimento_cor_raca_municipio AS t

