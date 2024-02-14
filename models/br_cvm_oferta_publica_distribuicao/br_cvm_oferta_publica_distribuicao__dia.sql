{{
    config(
        alias="dia",
        schema="br_cvm_oferta_publica_distribuicao",
        materialized="incremental",
        partition_by={
            "field": "data_abertura_processo",
            "data_type": "date",
            "granularity": "day",
        },
        pre_hook="DROP ALL ROW ACCESS POLICIES ON {{ this }}",
        post_hook=[
            'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter                     ON {{this}}                     GRANT TO ("allUsers")                 FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(data_abertura_processo), MONTH) > 6)',
            'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter                     ON  {{this}}                     GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")                     FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(data_abertura_processo), MONTH) <= 6)',
        ],
    )
}}

with
    tabela as (
        select
            safe_cast(numero_processo as string) numero_processo,
            safe_cast(numero_registro_oferta as string) numero_registro_oferta,
            safe_cast(tipo_oferta as string) tipo_oferta,
            safe_cast(
                tipo_componente_oferta_mista as string
            ) tipo_componente_oferta_mista,
            safe_cast(tipo_ativo as string) tipo_ativo,
            safe_cast(cnpj_emissor as string) cnpj_emissor,
            safe_cast(nome_emissor as string) nome_emissor,
            safe_cast(cnpj_lider as string) cnpj_lider,
            safe_cast(nome_lider as string) nome_lider,
            safe_cast(nome_vendedor as string) nome_vendedor,
            safe_cast(cnpj_ofertante as string) cnpj_ofertante,
            safe_cast(nome_ofertante as string) nome_ofertante,
            safe_cast(rito_oferta as string) rito_oferta,
            safe_cast(modalidade_oferta as string) modalidade_oferta,
            safe_cast(modalidade_registro as string) modalidade_registro,
            safe_cast(
                modalidade_dispensa_registro as string
            ) modalidade_dispensa_registro,
            safe_cast(data_abertura_processo as date) data_abertura_processo,
            safe_cast(data_protocolo as date) data_protocolo,
            safe_cast(data_dispensa_oferta as date) data_dispensa_oferta,
            safe_cast(data_registro_oferta as date) data_registro_oferta,
            safe_cast(data_inicio_oferta as date) data_inicio_oferta,
            safe_cast(data_encerramento_oferta as date) data_encerramento_oferta,
            safe_cast(emissao as string) emissao,
            safe_cast(classe_ativo as string) classe_ativo,
            safe_cast(serie as string) serie,
            safe_cast(especie_ativo as string) especie_ativo,
            safe_cast(forma_ativo as string) forma_ativo,
            safe_cast(data_emissao as date) data_emissao,
            safe_cast(data_vencimento as date) data_vencimento,
            safe_cast(
                quantidade_sem_lote_suplementar as string
            ) quantidade_sem_lote_suplementar,
            safe_cast(
                quantidade_no_lote_suplementar as string
            ) quantidade_no_lote_suplementar,
            safe_cast(quantidade_total as string) quantidade_total,
            safe_cast(preco_unitario as string) preco_unitario,
            safe_cast(valor_total as string) valor_total,
            safe_cast(oferta_inicial as string) oferta_inicial,
            safe_cast(oferta_incentivo_fiscal as string) oferta_incentivo_fiscal,
            safe_cast(oferta_regime_fiduciario as string) oferta_regime_fiduciario,
            safe_cast(atualizacao_monetaria as string) atualizacao_monetaria,
            safe_cast(juros as string) juros,
            safe_cast(projeto_audiovisual as string) projeto_audiovisual,
            safe_cast(tipo_societario_emissor as string) tipo_societario_emissor,
            safe_cast(tipo_fundo_investimento as string) tipo_fundo_investimento,
            safe_cast(ultimo_comunicado as string) ultimo_comunicado,
            safe_cast(data_comunicado as date) data_comunicado
        from `basedosdados-dev.br_cvm_oferta_publica_distribuicao_staging.dia` as t
    )
select *
from tabela
{% if is_incremental() %}

    -- this filter will only be applied on an incremental run
    -- (uses > to include records whose timestamp occurred since the last run of this
    -- model)
    where data_abertura_processo > (select max(data_abertura_processo) from {{ this }})

{% endif %}
