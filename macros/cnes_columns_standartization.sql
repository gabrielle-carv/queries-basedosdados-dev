{% macro data_wrangling(df) -%}
    {%- set strip = ['REGSAUDE', 'MICR_REG', 'DISTRSAN', 'DISTRADM', 'PF_PJ', 'NIV_DEP', 'COD_IR',
                     'ESFERA_A', 'ATIVIDAD', 'TP_UNID', 'TURNO_AT', 'NIV_HIER', 'TP_PREST', 'ORGEXPED',
                     'AV_ACRED', 'AV_PNASS'] -%}
    
    {%- for x in strip -%}
        {% set _ = df.update({x: df[x].replace(',', '').replace('¿', '').rstrip('ª').rstrip('º').lstrip('0')}) %}
    {%- endfor -%}
    
    {{ df }}
{% endmacro %}
