{{
  config(
    schema='br_me_cnpj',
    materialized='table',
    partition_by={
      "field": "data",
      "data_type": "date",
    },
    post_hook=['CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                    ON {{this}}
                    GRANT TO ("allUsers")
                FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(data), MONTH) > 6 OR  DATE_DIFF(DATE(2023,5,1),DATE(data), MONTH) > 0)',
              'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                    ON  {{this}}
                    GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                    FILTER USING (EXTRACT(YEAR from data) = EXTRACT(YEAR from  CURRENT_DATE()))' ]) 
}}
SELECT 
    SAFE_CAST(data AS DATE) data,
    SAFE_CAST(lpad(cnpj_basico, 8, '0') AS STRING) cnpj_basico,
    SAFE_CAST(tipo AS STRING) tipo,
    SAFE_CAST(nome AS STRING) nome,
    SAFE_CAST(documento AS STRING) documento,
    CASE 
        WHEN qualificacao = '0' THEN '0'
        ELSE SAFE_CAST(REGEXP_REPLACE(qualificacao, '^0', '') AS STRING)
    END AS qualificacao,
    SAFE_CAST(REGEXP_REPLACE(qualificacao, '^0', '') AS STRING) qualificacao,
    SAFE_CAST(data_entrada_sociedade AS DATE) data_entrada_sociedade,
    SAFE_CAST(REPLACE(id_pais,".0","") AS STRING) id_pais,
    SAFE_CAST(cpf_representante_legal AS STRING) cpf_representante_legal,
    SAFE_CAST(nome_representante_legal AS STRING) nome_representante_legal,
    CASE 
        WHEN qualificacao_representante_legal = '0' THEN '0'
        ELSE SAFE_CAST(REGEXP_REPLACE(qualificacao_representante_legal, '^0', '') AS STRING)
    END AS qualificacao_representante_legal,
    SAFE_CAST(faixa_etaria AS STRING) faixa_etaria
FROM basedosdados-dev.br_me_cnpj_staging.socios AS t
WHERE qualificacao != "qualificacao"