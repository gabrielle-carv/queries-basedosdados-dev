{{
    config(
        schema = 'br_cgu_servidores_executivo_federal',
        materialized='table',
        partition_by={
            'field': 'ano',
            'data_type': 'int64',
            'range': {
                "start": 2013,
                "end": 2023,
                "interval": 1
            }
        },
        cluster_by=['ano', 'mes'],
        post_hook = [
          'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter
                      ON {{this}}
                      GRANT TO ("allUsers")
                      FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
          'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                      ON  {{this}}
                      GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                    FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)'
        ]
    )
}}

select
    safe_cast(ano as int64) ano,
    safe_cast(mes as int64) mes,
    safe_cast(id_servidor as string) id_servidor,
    safe_cast(cpf as string) cpf,
    safe_cast(nome as string) nome,
    safe_cast(remuneracao_bruta_brl as float64) remuneracao_bruta_brl,
    safe_cast(remuneracao_bruta_usd as float64) remuneracao_bruta_usd,
    safe_cast(abate_teto_brl as float64) abate_teto_brl,
    safe_cast(abate_teto_usd as float64) abate_teto_usd,
    safe_cast(gratificao_natalina_brl as float64) gratificao_natalina_brl,
    safe_cast(gratificao_natalina_usd as float64) gratificao_natalina_usd,
    safe_cast(
        abate_teto_gratificacao_natalina_brl as float64
    ) abate_teto_gratificacao_natalina_brl,
    safe_cast(
        abate_teto_gratificacao_natalina_usd as float64
    ) abate_teto_gratificacao_natalina_usd,
    safe_cast(ferias_brl as float64) ferias_brl,
    safe_cast(ferias_usd as float64) ferias_usd,
    safe_cast(outras_remuneracoes_brl as float64) outras_remuneracoes_brl,
    safe_cast(outras_remuneracoes_usd as float64) outras_remuneracoes_usd,
    safe_cast(irrf_brl as float64) irrf_brl,
    safe_cast(irrf_usd as float64) irrf_usd,
    safe_cast(pss_rgps_brl as float64) pss_rgps_brl,
    safe_cast(pss_rgps_usd as float64) pss_rgps_usd,
    safe_cast(demais_deducoes_brl as float64) demais_deducoes_brl,
    safe_cast(demais_deducoes_usd as float64) demais_deducoes_usd,
    safe_cast(pensao_militar_brl as float64) pensao_militar_brl,
    safe_cast(pensao_militar_usd as float64) pensao_militar_usd,
    safe_cast(fundo_saude_brl as float64) fundo_saude_brl,
    safe_cast(fundo_saude_usd as float64) fundo_saude_usd,
    safe_cast(
        taxa_ocupacao_imovel_funcional_brl as float64
    ) taxa_ocupacao_imovel_funcional_brl,
    safe_cast(
        taxa_ocupacao_imovel_funcional_usd as float64
    ) taxa_ocupacao_imovel_funcional_usd,
    safe_cast(
        remuneracao_liquida_militar_brl as float64
    ) remuneracao_liquida_militar_brl,
    safe_cast(
        remuneracao_liquida_militar_usd as float64
    ) remuneracao_liquida_militar_usd,
    safe_cast(verba_indenizatoria_civil_brl as float64) verba_indenizatoria_civil_brl,
    safe_cast(verba_indenizatoria_civil_usd as float64) verba_indenizatoria_civil_usd,
    safe_cast(
        verba_indenizatoria_militar_brl as float64
    ) verba_indenizatoria_militar_brl,
    safe_cast(
        verba_indenizatoria_militar_usd as float64
    ) verba_indenizatoria_militar_usd,
    safe_cast(
        verba_indenizatoria_deslig_voluntario_brl as float64
    ) verba_indenizatoria_deslig_voluntario_brl,
    safe_cast(
        verba_indenizatoria_deslig_voluntario_usd as float64
    ) verba_indenizatoria_deslig_voluntario_usd,
    safe_cast(total_verba_indenizatoria_brl as float64) total_verba_indenizatoria_brl,
    safe_cast(total_verba_indenizatoria_usd as float64) total_verba_indenizatoria_usd,
    safe_cast(origem as string) origem,
from `basedosdados-staging.br_cgu_servidores_executivo_federal_staging.remuneracao` as t
