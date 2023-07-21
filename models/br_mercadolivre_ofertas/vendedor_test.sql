{{ config(
    materialized='table',
    partition_by={
      "field": "dia",
      "data_type": "date",
      "granularity": "day"
    }
)}}


WITH tabela_deduplicada AS (
    SELECT
        FORMAT_TIMESTAMP('%Y-%m-%d', dia) as data_consulta,
        id_municipio,
        vendedor_id as id_vendedor,
        nome as vendedor,
        classificacao,
        reputacao,
        experiencia as anos_experiencia,        
        ARRAY_AGG(opinioes.Bom)[OFFSET(0)] AS avaliacao_bom,
        ARRAY_AGG(opinioes.Regular)[OFFSET(0)] AS avaliacao_regular,
        ARRAY_AGG(opinioes.Ruim)[OFFSET(0)] AS avaliacao_ruim
    FROM
        `basedosdados.br_mercadolivre_ofertas.vendedor`
    GROUP BY
        data_consulta,
        vendedor_id,
        vendedor,
        experiencia,
        reputacao,
        classificacao,
        id_municipio
    HAVING
        COUNT(*) > 1
), tabela_unicos AS (
    SELECT
        FORMAT_TIMESTAMP('%Y-%m-%d', dia) as data_consulta,
        id_municipio,
        vendedor_id as id_vendedor,
        nome as vendedor,
        classificacao,
        reputacao,
        experiencia as anos_experiencia,
        ARRAY_AGG(opinioes.Bom)[OFFSET(0)] AS avaliacao_bom,
        ARRAY_AGG(opinioes.Regular)[OFFSET(0)] AS avaliacao_regular,
        ARRAY_AGG(opinioes.Ruim)[OFFSET(0)] AS avaliacao_ruim
    FROM
        `basedosdados.br_mercadolivre_ofertas.vendedor`
    GROUP BY
        data_consulta,
        vendedor_id,
        vendedor,
        experiencia,
        reputacao,
        classificacao,
        id_municipio
    HAVING
        COUNT(*) = 1
)
SELECT * FROM tabela_unicos
UNION ALL
SELECT * FROM tabela_deduplicada