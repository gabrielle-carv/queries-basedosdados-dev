{{
    config(
        alias="proposicao_microdados",
        schema="br_camara_dados_abertos",
        materialized="table",
        partition_by={
            "field": "ano",
            "data_type": "INT64",
            "range": {"start": 1935, "end": 2023, "interval": 1},
        },
    )
}}

select
    safe_cast(ano as int64) ano,
    safe_cast(
        split(
            format_timestamp('%Y-%m-%dT%H:%M:%E*S', timestamp(dataapresentacao)), 'T'
        )[offset(0)] as date
    ) data,
    safe_cast(
        split(
            format_timestamp('%Y-%m-%dT%H:%M:%E*S', timestamp(dataapresentacao)), 'T'
        )[offset(1)] as time
    ) horario,
    safe_cast(id as string) id,
    safe_cast(uri as string) url,
    safe_cast(numero as string) numero,
    safe_cast(siglatipo as string) sigla,
    safe_cast(descricaotipo as string) tipo,
    safe_cast(ementa as string) ementa,
    safe_cast(ementadetalhada as string) ementa_detalhada,
    safe_cast(keywords as string) palavra_chave,
    safe_cast(uriorgaonumerador as string) url_orgao_numerador,
    safe_cast(uripropprincipal as string) url_principal,
    safe_cast(uripropposterior as string) url_posterior,
    safe_cast(urlinteiroteor as string) url_teor_proposicao,
    safe_cast(ultimostatus_datahora as string) data_hora_ultimo_status,
    safe_cast(ultimostatus_urirelator as string) url_relator_ultimo_status,
    safe_cast(ultimostatus_siglaorgao as string) sigla_orgao_ultimo_status,
    safe_cast(ultimostatus_regime as string) regime_ultimo_status,
    safe_cast(ultimostatus_descricaotramitacao as string) tramitacao_ultimo_status,
    safe_cast(ultimostatus_descricaosituacao as string) situacao_ultimo_status,
    safe_cast(ultimostatus_despacho as string) despacho_ultimo_status,
    safe_cast(ultimostatus_apreciacao as string) apreciacao_ultimo_status,
    safe_cast(ultimostatus_sequencia as string) sequencia_ultimo_status,
    safe_cast(ultimostatus_url as string) url_ultimo_status,
from `basedosdados-dev.br_camara_dados_abertos_staging.proposicao_microdados` as t
