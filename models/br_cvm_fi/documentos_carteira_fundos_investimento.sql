{{ 
  config(
    schema='br_cvm_fi',
    materialized='table',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2005,
        "end": 2023,
        "interval": 1}
    },
    cluster_by = ["mes", "id_fundo"],
    labels = {'project_id': 'basedosdados-dev', 'tema': 'economia'})
 }}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(id_fundo AS STRING) id_fundo,
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(denominacao_social AS STRING) denominacao_social,
SAFE_CAST(data_competencia AS DATE) data_competencia,
SAFE_CAST(tipo_aplicacao AS STRING) tipo_aplicacao,
SAFE_CAST(tipo_ativo AS STRING) tipo_ativo,
SAFE_CAST(indicador_emissor_ligado AS INT64) indicador_emissor_ligado,
SAFE_CAST(tipo_negociacao AS STRING) tipo_negociacao,
SAFE_CAST(quantidade_vendas_negocios_mes AS INT64) quantidade_vendas_negocios_mes,
SAFE_CAST(valor_vendas_negocios_mes AS FLOAT64) valor_vendas_negocios_mes,
SAFE_CAST(quantidade_aquisicoes_negocios_mes AS INT64) quantidade_aquisicoes_negocios_mes,
SAFE_CAST(valor_aquisicoes_negocios_mes AS FLOAT64) valor_aquisicoes_negocios_mes,
SAFE_CAST(quantidade_posicao_final AS INT64) quantidade_posicao_final,
SAFE_CAST(valor_mercado_posicao_final AS FLOAT64) valor_mercado_posicao_final,
SAFE_CAST(valor_custo_posicao_final AS FLOAT64) valor_custo_posicao_final,
SAFE_CAST(prazo_confidencialidae_aplicacao AS STRING) prazo_confidencialidae_aplicacao,
SAFE_CAST(tipo_titulo_publico AS STRING) tipo_titulo_publico,
SAFE_CAST(codigo_isin AS STRING) codigo_isin,
SAFE_CAST(codigo_selic AS STRING) codigo_selic,
SAFE_CAST(data_emissao AS DATE) data_emissao,
SAFE_CAST(data_vencimento AS DATE) data_vencimento,
SAFE_CAST(cnpj_fundo_investido AS STRING) cnpj_fundo_investido,
SAFE_CAST(denominacao_social_fundo_investido AS STRING) denominacao_social_fundo_investido,
SAFE_CAST(codigo_swap AS STRING) codigo_swap,
SAFE_CAST(descricao_tipo_ativo_swap AS STRING) descricao_tipo_ativo_swap,
SAFE_CAST(codigo_ativo AS STRING) codigo_ativo,
SAFE_CAST(descricao_ativo AS STRING) descricao_ativo,
SAFE_CAST(data_inicio_vigencia AS DATE) data_inicio_vigencia,
SAFE_CAST(data_fim_vigencia AS DATE) data_fim_vigencia,
SAFE_CAST(cnpj_emissor AS STRING) cnpj_emissor,
SAFE_CAST(nome_emissor AS STRING) nome_emissor,
SAFE_CAST(indicador_titulo_pos_fixado AS INT64) indicador_titulo_pos_fixado,
SAFE_CAST(codigo_indexador_pos_fixados AS STRING) codigo_indexador_pos_fixados,
SAFE_CAST(descricao_indexador_pos_fixados AS STRING) descricao_indexador_pos_fixados,
SAFE_CAST(porcentagem_indexador_pos_fixados AS FLOAT64) porcentagem_indexador_pos_fixados,
SAFE_CAST(porcentagem_cupom_pos_fixados AS FLOAT64) porcentagem_cupom_pos_fixados,
SAFE_CAST(porcentagem_taxa_concentrada_pre_fixados AS FLOAT64) porcentagem_taxa_concentrada_pre_fixados,
SAFE_CAST(indicador_emissor_possui_classificacao_risco AS STRING) indicador_emissor_possui_classificacao_risco,
SAFE_CAST(nome_agencia_classificacao_risco AS STRING) nome_agencia_classificacao_risco,
SAFE_CAST(data_classificacao_risco AS DATE) data_classificacao_risco,
SAFE_CAST(grau_risco_atribuido AS STRING) grau_risco_atribuido,
SAFE_CAST(indicador_emissor_pessoa_fisica_juridica AS INT64) indicador_emissor_pessoa_fisica_juridica,
SAFE_CAST(indicador_codigo_identificacao_emissor_pessoa_fisica_juridica AS INT64) indicador_codigo_identificacao_emissor_pessoa_fisica_juridica,
SAFE_CAST(indicador_titulo_registrado_cetip AS INT64) indicador_titulo_registrado_cetip,
SAFE_CAST(indicador_titulo_possui_garantia_seguro AS INT64) indicador_titulo_possui_garantia_seguro,
SAFE_CAST(cnpj_instituicao_financeira_coobrigacao AS STRING) cnpj_instituicao_financeira_coobrigacao,
SAFE_CAST(indicador_investimento_coletivo AS INT64) indicador_investimento_coletivo,
SAFE_CAST(indicador_gestao_carteira_influencia_gestor AS INT64) indicador_gestao_carteira_influencia_gestor,
SAFE_CAST(codigo_pais AS STRING) codigo_pais,
SAFE_CAST(nome_pais AS STRING) nome_pais,
SAFE_CAST(codigo_bolsa_mercado_balcao AS STRING) codigo_bolsa_mercado_balcao,
SAFE_CAST(tipo_bolsa_mercado_balcao AS STRING) tipo_bolsa_mercado_balcao,
SAFE_CAST(codigo_ativo_bolsa_mercado_balcao_local_aquisicao AS STRING) codigo_ativo_bolsa_mercado_balcao_local_aquisicao,
SAFE_CAST(descricao_ativo_exterior AS STRING) descricao_ativo_exterior,
SAFE_CAST(quantidade_ativos_exterior AS INT64) quantidade_ativos_exterior,
SAFE_CAST(valor_ativo_exterior AS FLOAT64) valor_ativo_exterior,
FROM basedosdados-staging.br_cvm_fi_staging.documentos_carteira_fundos_investimento AS t

