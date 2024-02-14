{{
    config(
        materialized="incremental",
        partition_by={
            "field": "sigla_uf",
            "data_type": "string",
        },
    )
}}

select *
from `basedosdados-dev.br_tse_eleicoes_2022_staging.resultado_boletim_urna` as t
