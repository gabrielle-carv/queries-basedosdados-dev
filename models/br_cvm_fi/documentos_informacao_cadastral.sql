{{
    config(
        schema="br_cvm_fi",
        materialized="table",
        cluster_by="id_fundo",
        labels={"project_id": "basedosdados-dev", "tema": "economia"},
    )
}}
select
    safe_cast(id_fundo as string) id_fundo,
    safe_cast(cnpj as string) cnpj,
    safe_cast(denominacao_social as string) denominacao_social,
    safe_cast(data_registro as date) data_registro,
    safe_cast(data_constituicao as date) data_constituicao,
    safe_cast(codigo_cvm as string) codigo_cvm,
    safe_cast(data_cancelamento as date) data_cancelamento,
    safe_cast(situacao as string) situacao,
    safe_cast(data_inicio_situacao as date) data_inicio_situacao,
    safe_cast(data_inicio_atividade as date) data_inicio_atividade,
    safe_cast(data_inicio_exercicio as date) data_inicio_exercicio,
    safe_cast(data_fim_exercicio as date) data_fim_exercicio,
    safe_cast(classe as string) classe,
    safe_cast(data_inicio_classe as date) data_inicio_classe,
    safe_cast(tipo_rentabilidade as string) tipo_rentabilidade,
    safe_cast(tipo_condominio as string) tipo_condominio,
    safe_cast(indicador_fundo_cotas as int64) indicador_fundo_cotas,
    safe_cast(indicador_fundo_exclusivo as int64) indicador_fundo_exclusivo,
    safe_cast(
        indicador_tributacao_longo_prazo as int64
    ) indicador_tributacao_longo_prazo,
    safe_cast(publico_alvo as int64) publico_alvo,
    safe_cast(indicador_entidade_investimento as int64) indicador_entidade_investimento,
    safe_cast(taxa_perfomarnce as float64) taxa_perfomarnce,
    safe_cast(
        informacoes_adicionais_taxa_performance as string
    ) informacoes_adicionais_taxa_performance,
    safe_cast(taxa_administracao as float64) taxa_administracao,
    safe_cast(
        informacoes_adicionais_taxa_administracao as string
    ) informacoes_adicionais_taxa_administracao,
    safe_cast(valor_patrimonio_liquido as float64) valor_patrimonio_liquido,
    safe_cast(data_patrimonio_liquido as date) data_patrimonio_liquido,
    safe_cast(nome_diretor as string) nome_diretor,
    safe_cast(cnpj_administrador as string) cnpj_administrador,
    safe_cast(nome_administrador as string) nome_administrador,
    safe_cast(
        indicador_pessoa_fisica_ou_juridica as string
    ) indicador_pessoa_fisica_ou_juridica,
    safe_cast(cpf_cnpj_gestor as string) cpf_cnpj_gestor,
    safe_cast(nome_gestor as string) nome_gestor,
    safe_cast(cnpj_auditor as string) cnpj_auditor,
    safe_cast(nome_auditor as string) nome_auditor,
    safe_cast(cnpj_custodiante as string) cnpj_custodiante,
    safe_cast(nome_custodiante as string) nome_custodiante,
    safe_cast(cnpj_controlador as string) cnpj_controlador,
    safe_cast(nome_controlador as string) nome_controlador,
    safe_cast(
        indicador_aplicacao_total_recursos_exterior as int64
    ) indicador_aplicacao_total_recursos_exterior,
from `basedosdados-dev.br_cvm_fi_staging.documentos_informacao_cadastral` as t
