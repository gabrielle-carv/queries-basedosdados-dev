{%- macro clean_cols(df_col) -%}
    {# pass a column that will be standadirzed #}
    
    --{%- for column in columns_to_wrang -%}
    {%- df_col | replace(',','') | replace('¿', '') | replace('ª', '') | replace('º', '')  -%}
       -- {% set _ = df.update({x: df[x].replace(',', '').replace('¿', '').rstrip('ª').rstrip('º').lstrip('0')}) %}
    
    --{{ df_col }}
{% endmacro %}
