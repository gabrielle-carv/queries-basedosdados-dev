{{ config(alias='microdados', schema='br_anatel_telefonia_movel') }}
SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(ddd AS STRING) ddd,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(empresa AS STRING) empresa,
SAFE_CAST(porte_empresa AS STRING) porte_empresa,
SAFE_CAST(tecnologia AS STRING) tecnologia,
SAFE_CAST(sinal AS STRING) sinal,
SAFE_CAST(modalidade AS STRING) modalidade,
SAFE_CAST(pessoa AS STRING) pessoa,
SAFE_CAST(produto AS STRING) produto,
SAFE_CAST(acessos AS INT64) acessos
FROM basedosdados-dev.br_anatel_telefonia_movel_staging.microdados AS t