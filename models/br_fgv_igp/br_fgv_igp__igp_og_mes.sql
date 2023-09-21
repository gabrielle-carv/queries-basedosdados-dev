{{ 
    config(
        alias='igp_og_mes', 
        schema='br_fgv_igp',
        materialized='incremental',
    partition_by = {
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 1969,
        "end": 2024,
        "interval": 1}
     },
    post_hook=['CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                    ON {{this}}
                    GRANT TO ("allUsers")
                FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
              'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                    ON  {{this}}
                    GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                    FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)']
  )
}}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(indice AS FLOAT64) indice,
SAFE_CAST(variacao_mensal AS FLOAT64) var_mensal,
SAFE_CAST(variacao_12_meses AS FLOAT64) variacao_12_meses,
SAFE_CAST(variacao_acumulada_ano AS FLOAT64) variacao_acumulada_ano,
SAFE_CAST(indice_fechamento_mensal AS FLOAT64) indice_fechamento_mensal
FROM basedosdados-dev.br_fgv_igp_staging.igp_og_mes AS t
{% if is_incremental() %}
WHERE DATE(CAST(ano AS INT64),CAST(mes AS INT64),1) > (SELECT MAX(DATE(CAST(ano AS INT64),CAST(mes AS INT64),1)) FROM {{ this }} )
{% endif %}