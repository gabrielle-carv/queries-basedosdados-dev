{{ 
  config(
    schema='br_cvm_fi',
    materialized='table',
    cluster_by = "data_competencia",
    labels = {'project_id': 'basedosdados-dev', 'tema': 'economia'})
 }}
SELECT
SAFE_CAST(id_fundo AS STRING) id_fundo,
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(denominacao_social AS STRING) denominacao_social,
SAFE_CAST(data_registro AS DATE) data_registro,
SAFE_CAST(data_constituicao AS DATE) data_constituicao,
SAFE_CAST(codigo_cvm AS STRING) codigo_cvm,
SAFE_CAST(data_cancelamento AS DATE) data_cancelamento,
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(data_inicio_situacao AS DATE) data_inicio_situacao,
SAFE_CAST(data_inicio_atividade AS DATE) data_inicio_atividade,
SAFE_CAST(data_inicio_exercicio AS DATE) data_inicio_exercicio,
SAFE_CAST(data_fim_exercicio AS DATE) data_fim_exercicio,
SAFE_CAST(classe AS STRING) classe,
SAFE_CAST(data_inicio_classe AS DATE) data_inicio_classe,
SAFE_CAST(tipo_rentabilidade AS STRING) tipo_rentabilidade,
SAFE_CAST(tipo_condominio AS STRING) tipo_condominio,
SAFE_CAST(indicador_fundo_cotas AS INT64) indicador_fundo_cotas,
SAFE_CAST(indicador_fundo_exclusivo AS INT64) indicador_fundo_exclusivo,
SAFE_CAST(indicador_tributacao_longo_prazo AS INT64) indicador_tributacao_longo_prazo,
SAFE_CAST(publico_alvo AS INT64) publico_alvo,
SAFE_CAST(indicador_entidade_investimento AS INT64) indicador_entidade_investimento,
SAFE_CAST(taxa_perfomarnce AS FLOAT64) taxa_perfomarnce,
SAFE_CAST(informacoes_adicionais_taxa_performance AS STRING) informacoes_adicionais_taxa_performance,
SAFE_CAST(taxa_administracao AS FLOAT64) taxa_administracao,
SAFE_CAST(informacoes_adicionais_taxa_administracao AS STRING) informacoes_adicionais_taxa_administracao,
SAFE_CAST(valor_patrimonio_liquido AS FLOAT64) valor_patrimonio_liquido,
SAFE_CAST(data_patrimonio_liquido AS DATE) data_patrimonio_liquido,
SAFE_CAST(nome_diretor AS STRING) nome_diretor,
SAFE_CAST(cnpj_administrador AS STRING) cnpj_administrador,
SAFE_CAST(nome_administrador AS STRING) nome_administrador,
SAFE_CAST(indicador_pessoa_fisica_ou_juridica AS STRING) indicador_pessoa_fisica_ou_juridica,
SAFE_CAST(cpf_cnpj_gestor AS STRING) cpf_cnpj_gestor,
SAFE_CAST(nome_gestor AS STRING) nome_gestor,
SAFE_CAST(cnpj_auditor AS STRING) cnpj_auditor,
SAFE_CAST(nome_auditor AS STRING) nome_auditor,
SAFE_CAST(cnpj_custodiante AS STRING) cnpj_custodiante,
SAFE_CAST(nome_custodiante AS STRING) nome_custodiante,
SAFE_CAST(cnpj_controlador AS STRING) cnpj_controlador,
SAFE_CAST(nome_controlador AS STRING) nome_controlador,
SAFE_CAST(indicador_aplicacao_total_recursos_exterior AS INT64) indicador_aplicacao_total_recursos_exterior,
FROM basedosdados-dev.br_cvm_fi_staging.documentos_informacao_cadastral AS t

