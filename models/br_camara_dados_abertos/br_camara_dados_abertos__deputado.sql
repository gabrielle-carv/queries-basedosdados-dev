{{ config(alias='deputado',schema='br_camara_dados_abertos') }}
SELECT
    SAFE_CAST(nome AS STRING) nome,
    SAFE_CAST(nome_civil AS STRING) nome_civil,
    SAFE_CAST(data_nascimento AS DATE) data_nascimento,
    SAFE_CAST(data_falecimento AS DATE) data_falecimento,
    SAFE_CAST(id_municipio_nascimento AS STRING) id_municipio_nascimento,
    SAFE_CAST(sigla_uf_nascimento AS STRING) sigla_uf_nascimento,
    REPLACE(REPLACE(SAFE_CAST(sexo AS STRING), 'M', 'Masculino'), 'F', 'Feminino') sexo,
    SAFE_CAST(id_inicial_legislatura AS STRING) id_inicial_legislatura,
    SAFE_CAST(id_final_legislatura AS STRING) id_final_legislatura,
    SAFE_CAST(url_site AS STRING) url_site,
    SAFE_CAST(url_rede_social AS STRING) url_rede_social
FROM basedosdados-dev.br_camara_dados_abertos_staging.deputado AS t

