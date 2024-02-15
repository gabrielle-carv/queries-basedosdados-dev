{{ config(
    schema='br_ans_beneficiario',
    alias = 'microdados',
    materialized='incremental',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2014,
        "end": 2023,
        "interval": 1}
    },    
    cluster_by = ["id_municipio_6", "mes", "sigla_uf"],    
    labels = {'project_id': 'basedosdados-dev'})
 }}


with ans as (
SELECT
CAST(ano AS INT64) ano,
CAST(mes AS INT64) mes,
CAST(sigla_uf AS STRING) sigla_uf,
CAST(CD_MUNICIPIO AS STRING) id_municipio_6,
CAST(CD_OPERADORA AS STRING) codigo_operadora,
CAST(INITCAP(`basedosdados-dev.functions.convert_latin_characters`(NM_RAZAO_SOCIAL)) AS STRING) razao_social,
CAST(NR_CNPJ AS STRING) cnpj, modalidade_operadora,
CAST(TP_SEXO AS STRING) sexo,
CAST(LOWER(`basedosdados-dev.functions.convert_latin_characters`(DE_FAIXA_ETARIA)) AS STRING) faixa_etaria,
CAST(LOWER(`basedosdados-dev.functions.convert_latin_characters`(DE_FAIXA_ETARIA_REAJ)) AS STRING) faixa_etaria_reajuste,
CAST(CD_PLANO AS STRING) codigo_plano,
CAST(TP_VIGENCIA_PLANO AS STRING) tipo_vigencia_plano,
CAST(INITCAP(`basedosdados-dev.functions.convert_latin_characters`(DE_CONTRATACAO_PLANO)) AS STRING) contratacao_beneficiario,
CAST(INITCAP(`basedosdados-dev.functions.convert_latin_characters`(DE_SEGMENTACAO_PLANO)) AS STRING) segmentacao_beneficiario,
CAST(INITCAP(`basedosdados-dev.functions.convert_latin_characters`(DE_ABRG_GEOGRAFICA_PLANO)) AS STRING) abrangencia_beneficiario,
CAST(INITCAP(`basedosdados-dev.functions.convert_latin_characters`(COBERTURA_ASSIST_PLAN)) AS STRING) cobertura_assistencia_beneficiario,
CAST(INITCAP(`basedosdados-dev.functions.convert_latin_characters`(TIPO_VINCULO)) AS STRING) tipo_vinculo,
CAST(QT_BENEFICIARIO_ATIVO AS INT64) quantidade_beneficiario_ativo,
CAST(QT_BENEFICIARIO_ADERIDO AS INT64) quantidade_beneficiario_aderido,
CAST(QT_BENEFICIARIO_CANCELADO AS INT64) quantidade_beneficiario_cancelado,
CAST(PARSE_DATE('%d/%m/%Y', DT_CARGA) AS DATE) data_carga,
FROM `basedosdados-dev.br_ans_beneficiario_staging.informacao_consolidada_atualizado`
where ano = '2014' and mes = '5')
select *
from ans
{% if is_incremental() %}
where
  data_carga >= (SELECT MAX(data_carga) FROM {{ this }}) 
{% endif %}


