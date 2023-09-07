{{ 
  config(
    schema='br_rf_cafir',
    materialized='table',
     partition_by={
      "field": "data",
      "data_type": "date",
      "granularity": "day"
     }   
    )
 }}
SELECT basedosdados-dev.functions.convert_latin_characters('açu')
SELECT
    SAFE_CAST(data as DATE) data,
    SAFE_CAST(data_inscricao as STRING) data_inscricao,
    SAFE_CAST(id as STRING) id,
    SAFE_CAST(nome as STRING) nome,
    SAFE_CAST(situacao as STRING) situacao,
    SAFE_CAST(endereco as STRING) endereco,
    SAFE_CAST(zona_redefinir as STRING) zona_redefinir,
    SAFE_CAST(sigla_uf as STRING) sigla_uf,
    SAFE_CAST(municipio as STRING) municipio,
    SAFE_CAST(cep as STRING) cep,
    SAFE_CAST(status_rever as STRING) status_rever,
    SAFE_CAST(cd as STRING) cd
FROM `basedosdados-dev.br_rf_cafir_staging.imoveis_rurais` AS t

