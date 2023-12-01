{{
config(
    alias='municipio_tipo',
    schema='br_denatran_frota',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2003,
        "end": 2024,
        "interval": 1}},
    cluster_by = ["mes", "sigla_uf"]
)

}}

SELECT
    SAFE_CAST(ano as INT64) ano,
    SAFE_CAST(mes as INT64) mes,
    SAFE_CAST(sigla_uf as STRING) sigla_uf,
    SAFE_CAST(id_municipio as STRING) id_municipio,
    SAFE_CAST(tipo_veiculo as STRING) tipo_veiculo,
    SAFE_CAST(quantidade as INT64) quantidade
FROM basedosdados-dev.br_denatran_frota_staging.municipio_tipo
