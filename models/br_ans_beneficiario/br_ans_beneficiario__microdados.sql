{{
    config(
        schema="br_ans_beneficiario",
        alias="microdados",
        materialized="incremental",
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {"start": 2014, "end": 2023, "interval": 1},
        },
        cluster_by=["id_municipio_6", "mes", "sigla_uf"],
        labels={"project_id": "basedosdados-dev"},
    )
}}


with
    ans as (
        select
            cast(ano as int64) ano,
            cast(mes as int64) mes,
            cast(sigla_uf as string) sigla_uf,
            cast(cd_municipio as string) id_municipio_6,
            cast(cd_operadora as string) codigo_operadora,
            cast(
                initcap(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        nm_razao_social
                    )
                ) as string
            ) razao_social,
            cast(nr_cnpj as string) cnpj,
            modalidade_operadora,
            cast(tp_sexo as string) sexo,
            cast(
                lower(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        de_faixa_etaria
                    )
                ) as string
            ) faixa_etaria,
            cast(
                lower(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        de_faixa_etaria_reaj
                    )
                ) as string
            ) faixa_etaria_reajuste,
            cast(cd_plano as string) codigo_plano,
            cast(tp_vigencia_plano as string) tipo_vigencia_plano,
            cast(
                initcap(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        de_contratacao_plano
                    )
                ) as string
            ) contratacao_beneficiario,
            cast(
                initcap(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        de_segmentacao_plano
                    )
                ) as string
            ) segmentacao_beneficiario,
            cast(
                initcap(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        de_abrg_geografica_plano
                    )
                ) as string
            ) abrangencia_beneficiario,
            cast(
                initcap(
                    `basedosdados-dev.functions.convert_latin_characters`(
                        cobertura_assist_plan
                    )
                ) as string
            ) cobertura_assistencia_beneficiario,
            cast(
                initcap(
                    `basedosdados-dev.functions.convert_latin_characters`(tipo_vinculo)
                ) as string
            ) tipo_vinculo,
            cast(qt_beneficiario_ativo as int64) quantidade_beneficiario_ativo,
            cast(qt_beneficiario_aderido as int64) quantidade_beneficiario_aderido,
            cast(qt_beneficiario_cancelado as int64) quantidade_beneficiario_cancelado,
            cast(parse_date('%d/%m/%Y', dt_carga) as date) data_carga,
        from
            `basedosdados-dev.br_ans_beneficiario_staging.informacao_consolidada_atualizado`
        where ano = '2014' and mes = '5'
    )
select *
from ans
{% if is_incremental() %}
    where data_carga >= (select max(data_carga) from {{ this }})
{% endif %}
