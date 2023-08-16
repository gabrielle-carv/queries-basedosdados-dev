{{
  config(
    schema='br_me_cnpj',
    materialized='table',
    partition_by={
      "field": "data",
      "data_type": "date",
    }
  )
}}

SELECT 
SAFE_CAST(data AS DATE) data,
SAFE_CAST(lpad(cnpj_basico, 8, '0') AS STRING) cnpj_basico,
SAFE_CAST(tipo AS STRING) tipo,
SAFE_CAST(nome AS STRING) nome,
SAFE_CAST(documento AS STRING) documento,
SAFE_CAST(qualificacao AS STRING) qualificacao,
SAFE_CAST(data_entrada_sociedade AS DATE) data_entrada_sociedade,
SAFE_CAST(REPLACE(id_pais,".0","") AS STRING) id_pais,
SAFE_CAST(cpf_representante_legal AS STRING) cpf_representante_legal,
SAFE_CAST(nome_representante_legal AS STRING) nome_representante_legal,
SAFE_CAST(qualificacao_representante_legal AS STRING) qualificacao_representante_legal,
SAFE_CAST(faixa_etaria AS STRING) faixa_etaria
FROM basedosdados-dev.br_me_cnpj_staging.socios AS t