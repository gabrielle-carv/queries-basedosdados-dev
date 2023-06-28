{% set columns = ['modalidade_operadora', 'faixa_etaria'] %}

{% for column in columns %}
UPDATE `basedosdados-dev.br_ans_beneficiario.microdados_teste` AS tabela_mae
SET {{ column }} = safe_cast(dicionario.chave AS STRING)
FROM `basedosdados-dev.br_ans_beneficiario.dicionario` AS dicionario
WHERE tabela_mae.{{ column }} = dicionario.valor;
{% endfor %}
