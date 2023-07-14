-- Arquivo: tabela_temporaria.sql

{% set columns = ['modalidade_operadora', 'faixa_etaria'] %}
{% set sufixo = 'teste_' %}

{% for column in columns %}
  {% if loop.index > 1 %}
  UNION ALL
  {% endif %}
  
  SELECT
    tabela_mae.*,
    dicionario.chave AS {{ sufixo ~ column }}
  FROM
    `basedosdados-dev.br_ans_beneficiario.microdados_teste` AS tabela_mae
  JOIN
    `basedosdados-dev.br_ans_beneficiario.dicionario` AS dicionario
  ON
    tabela_mae.{{ column }} = dicionario.valor
{% endfor %}