{{
    config(
        alias="garantia_safra",
        schema="br_cgu_beneficios_cidadao",
        materialized="incremental",
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {"start": 2023, "end": 2024, "interval": 1},
        },
        cluster_by=["mes", "sigla_uf"],
    )
}}
with
    garantia_safra as (
        select
            safe_cast(substr(mes_referencia, 1, 4) as int64) ano,
            safe_cast(substr(mes_referencia, 5, 2) as int64) mes,
            safe_cast(mes_referencia as string) data_referencia,
            safe_cast(parse_date('%Y%m', mes_referencia) as date) data,
            t2.id_municipio,
            t2.nome as nome_municipio,
            safe_cast(t1.sigla_uf as string) sigla_uf,
            safe_cast(nis as string) nis_favorecido,
            safe_cast(t1.nome as string) nome_favorecido,
            safe_cast(valor as float64) valor_parcela,
        from `basedosdados-dev.br_cgu_beneficios_cidadao_staging.garantia_safra` t1
        left join
            `basedosdados.br_bd_diretorios_brasil.municipio` t2
            on safe_cast(t1.id_municipio_siafi as int64)
            = safe_cast(t2.id_municipio_rf as int64)
    )
select * except (data)
from garantia_safra
{% if is_incremental() %} where data > (select max(data) from {{ this }}) {% endif %}
