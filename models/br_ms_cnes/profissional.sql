{{
    config(
        schema="br_ms_cnes",
        materialized="incremental",
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {"start": 2005, "end": 2023, "interval": 1},
        },
        pre_hook="DROP ALL ROW ACCESS POLICIES ON {{ this }}",
        post_hook=[
            'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter                     ON {{this}}                     GRANT TO ("allUsers")                     FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
            'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter        ON  {{this}}                     GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")                     FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)',
        ],
    )
}}
with
    raw_cnes_profissional as (
        -- 1. Retirar linhas com id_estabelecimento_cnes nulo
        select *
        from `basedosdados-dev.br_ms_cnes_staging.profissional`
        where cnes is not null
    ),
    profissional_x_estabelecimento as (
        select *
        from raw_cnes_profissional as pf
        left join
            (
                select
                    id_municipio,
                    cast(ano as string) as ano1,
                    cast(mes as string) as mes1,
                    id_estabelecimento_cnes as iddd
                from `basedosdados-dev.br_ms_cnes.estabelecimento`
            ) as st
            on pf.cnes = st.iddd
            and pf.ano = st.ano1
            and pf.mes = st.mes1
    )
select
    cast(substr(competen, 1, 4) as int64) as ano,
    cast(substr(competen, 5, 2) as int64) as mes,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(cnes as string) id_estabelecimento_cnes,
    -- replace de valores de linha com 6 zeros para null. 6 zeros é valor do campo
    -- UFMUNRES que indica null
    safe_cast(regexp_replace(ufmunres, '0{6}', '') as string) id_municipio_6_residencia,
    safe_cast(nomeprof as string) nome,
    safe_cast(vinculac as string) id_vinculo,
    safe_cast(registro as string) id_registro_conselho,
    safe_cast(conselho as string) id_conselho,
    -- replace de valores de linha com 15 zeros para null. 15 zeros é valor do campo
    -- CNS_PROF que indica null
    safe_cast(regexp_replace(cns_prof, '0{15}', '') as string) cartao_nacional_saude,
    safe_cast(cbo as string) cbo_2002,
    safe_cast(terceiro as string) indicador_estabelecimento_terceiro,
    safe_cast(vincul_c as string) indicador_vinculo_contratado_sus,
    safe_cast(vincul_a as string) indicador_vinculo_autonomo_sus,
    safe_cast(vincul_n as string) indicador_vinculo_outros,
    safe_cast(prof_sus as string) indicador_atende_sus,
    safe_cast(profnsus as string) indicador_atende_nao_sus,
    safe_cast(horaoutr as int64) carga_horaria_outros,
    safe_cast(horahosp as int64) carga_horaria_hospitalar,
    safe_cast(hora_amb as int64) carga_horaria_ambulatorial
from profissional_x_estabelecimento
{% if is_incremental() %}
    where concat(ano, mes) > (select max(concat(ano, mes)) from {{ this }})
{% endif %}
