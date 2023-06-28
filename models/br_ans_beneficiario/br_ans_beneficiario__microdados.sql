{{ config(
    alias='microdados',
    schema='br_ans_beneficiario',
    materialized='table',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2014,
        "end": 2022,
        "interval": 1}
    },
    cluster_by = ["id_municipio_6", "mes"],
    labels = {'project_id': 'basedosdados-dev'})
 }}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(sigla_uf AS INT64) sigla_uf,
SAFE_CAST(id_municipio_6 AS STRING) id_municipio_6,
SAFE_CAST(codigo_operadora AS STRING) codigo_operadora,
SAFE_CAST(razao_social AS STRING) razao_social,
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(INITCAP(TRANSLATE(modalidade_operadora, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) modalidade_operadora,
SAFE_CAST(sexo AS STRING) sexo,
SAFE_CAST(INITCAP(TRANSLATE(faixa_etaria, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) faixa_etaria,
SAFE_CAST(INITCAP(TRANSLATE(faixa_etaria_reajuste, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) faixa_etaria_reajuste,
SAFE_CAST(codigo_plano AS STRING) codigo_plano,
SAFE_CAST(tipo_vigencia_plano AS STRING) tipo_vigencia_plano,
SAFE_CAST(INITCAP(TRANSLATE(contratacao_beneficiario, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) contratacao_beneficiario,
SAFE_CAST(INITCAP(TRANSLATE(segmentacao_beneficiario, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) segmentacao_beneficiario,
SAFE_CAST(INITCAP(TRANSLATE(abrangencia_beneficiario, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) abrangencia_beneficiario,
SAFE_CAST(INITCAP(TRANSLATE(cobertura_assistencia_beneficiario, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) cobertura_assistencia_beneficiario,
SAFE_CAST(INITCAP(TRANSLATE(tipo_vinculo, 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ', 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC')) AS STRING) tipo_vinculo,
SAFE_CAST(quantidade_beneficiario_ativo AS INT64) quantidade_beneficiario_ativo,
SAFE_CAST(quantidade_beneficiario_aderido AS INT64) quantidade_beneficiario_aderido,
SAFE_CAST(quantidade_beneficiario_cancelado AS INT64) quantidade_beneficiario_cancelado,
FROM basedosdados-dev.br_ans_beneficiario_staging.sample AS t