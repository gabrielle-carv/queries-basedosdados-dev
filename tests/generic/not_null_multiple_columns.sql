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
    validation_errors as (

        select
            COUNT(*) AS columns_with_more_than_5_percent_nulls
        from null_counts
        where
            {% for column in columns -%}
            {{ column.name }}{{ suffix }} / total_records > {{ threshold }}  {% if not loop.last %} OR {% endif %}
            {%- endfor %}

    )
    select * from validation_errors
{% endtest %}