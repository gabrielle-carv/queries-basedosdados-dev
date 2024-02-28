{{
    config(
        alias="microdados",
        schema="br_inpe_queimadas",
        materialized="table",
        labels={"tema": "meio-ambiente"},
    )
}}
select
    safe_cast(ano as int64) ano,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(bioma as string) bioma,
    safe_cast(id_bdq as string) id_bdq,
    safe_cast(id_foco as string) id_foco,
    safe_cast(data_hora as time) data_hora,
    st_geogpoint(
        safe_cast(longitude as float64), safe_cast(latitude as float64)
    ) centroide,
from `basedosdados-dev.br_inpe_queimadas_staging.microdados` as t
