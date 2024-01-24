{{
    config(
        schema='br_tse_eleicoes',
        alias = 'candidatos',
        materialized='table',
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {
                "start": 1994,
                "end": 2022,
                "interval": 2
            }
        }
    )
}}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(tipo_eleicao AS STRING) tipo_eleicao,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(id_municipio_tse AS STRING) id_municipio_tse,
CAST(SPLIT(id_candidato_bd, '.')[OFFSET(0)]  AS STRING) id_candidato_bd,
CAST(SPLIT(cpf, '.')[OFFSET(0)] AS STRING) cpf,
SAFE_CAST(titulo_eleitoral AS STRING) titulo_eleitoral,
SAFE_CAST(sequencial AS STRING) sequencial,
SAFE_CAST(numero AS STRING) numero,
SAFE_CAST(nome AS STRING) nome,
SAFE_CAST(nome_urna AS STRING) nome_urna,
SAFE_CAST(numero_partido AS STRING) numero_partido,
SAFE_CAST(sigla_partido AS STRING) sigla_partido,
SAFE_CAST(cargo AS STRING) cargo,
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(ocupacao AS STRING) ocupacao,
SAFE_CAST(data_nascimento AS DATE) data_nascimento,
CAST(SPLIT(idade, '.')[OFFSET(0)] AS INT64) idade,
SAFE_CAST(genero AS STRING) genero,
SAFE_CAST(instrucao AS STRING) instrucao,
SAFE_CAST(estado_civil AS STRING) estado_civil,
SAFE_CAST(nacionalidade AS STRING) nacionalidade,
SAFE_CAST(sigla_uf_nascimento AS STRING) sigla_uf_nascimento,
SAFE_CAST(municipio_nascimento AS STRING) municipio_nascimento,
SAFE_CAST(email AS STRING) email,
SAFE_CAST(raca AS STRING) raca,
SAFE_CAST(situacao_totalizacao AS STRING) situacao_totalizacao,
SAFE_CAST(numero_federacao AS STRING) numero_federacao,
SAFE_CAST(nome_federacao AS STRING) nome_federacao,
SAFE_CAST(sigla_federacao AS STRING) sigla_federacao,
SAFE_CAST(composicao_federacao AS STRING) composicao_federacao,
CASE
  WHEN prestou_contas='N' THEN 'Não'
  WHEN prestou_contas='S' THEN 'Sim'
END AS prestou_contas
FROM basedosdados-dev.br_tse_eleicoes_staging.candidatos AS t