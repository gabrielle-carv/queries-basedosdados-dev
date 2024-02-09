{% test not_null_multiple_columns(model, threshold=0.01) %}

    {%- set columns = adapter.get_columns_in_relation(model) -%}
    {% set suffix = '_nulls' %}

    with null_counts as(

        select 
            {% for column in columns -%}
            SUM(CASE WHEN {{ column.name }} IS NULL THEN 1 ELSE 0 END) AS {{ column.name }}{{ suffix }},
            {%- endfor %}
            count(*) as total_records
            from {{ model }}        
    ),

    gather_columns as (

        {% for column in columns -%}
        select '{{ column.name }}{{ suffix }}' as nome_coluna, {{ column.name }}{{ suffix }} as valor, total_records
        from null_counts
        {% if not loop.last %}union all {% endif %}
        {%- endfor %}
    ),

    validation_errors as (
        select
            *
        from gather_columns
        where
            valor / total_records > {{ threshold }}
        

    )
    select * from validation_errors
{% endtest %}