{{
    config(
        materialized="table",
        partition_by={"field": "dia", "data_type": "date", "granularity": "day"},
    )
}}

select
    dia,
    parse_datetime('%Y-%m-%d %H:%M:%S', data_hora) as data_hora,
    titulo,
    lpad(item_id, 12, '0') as item_id,
    if(
        trim(regexp_replace(categorias, r'\[|\]|\'', '')) = '',
        null,
        array(
            select trim(value)
            from unnest(split(regexp_replace(categorias, r'\[|\]|\'', ''))) as value
        )
    ) as categorias,
    safe_cast(quantidade_avaliacoes as int64) quantidade_avaliacoes,
    safe_cast(desconto as int64) desconto,
    safe_cast(envio_pais as bool) envio_pais,
    safe_cast(estrelas as float64) estrelas,
    safe_cast(preco as float64) preco,
    safe_cast(preco_original as float64) preco_original,
    case when vendedor = 'None' then null else vendedor end as vendedor,
    secao_site,
    case
        when caracteristicas = '{}' then null else caracteristicas
    end as caracteristicas,
from `basedosdados-dev.br_mercadolivre_ofertas_staging.item`
