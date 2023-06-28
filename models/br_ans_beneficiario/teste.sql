{% set columns = ['modalidade_operadora', 'faixa_etaria'] %}

{% for column in columns %}
WITH tabela_temporaria AS (
  SELECT
    tabela_mae.*,
    dicionario.chave AS {{ column }}
  FROM
    `basedosdados-dev.br_ans_beneficiario.microdados_teste` AS tabela_mae
  JOIN
    `basedosdados-dev.br_ans_beneficiario.dicionario` AS dicionario
  ON
    tabela_mae.{{ column }} = dicionario.valor
)
{% endfor %}
-- Substitua a tabela original pela tabela temporária
SELECT * FROM tabela_temporaria;
