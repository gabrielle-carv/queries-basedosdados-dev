SELECT
SAFE_CAST(ano_competencia AS NUMERIC) ano_competencia,
SAFE_CAST(mes_competencia AS NUMERIC) mes_competencia,
SAFE_CAST(ano_caixa AS NUMERIC) ano_caixa,
SAFE_CAST(mes_caixa AS NUMERIC) mes_caixa,
SAFE_CAST(categoria AS STRING) categoria,
SAFE_CAST(tipo AS STRING) tipo,
SAFE_CAST(frequencia AS STRING) frequencia,
SAFE_CAST(equipe AS STRING) equipe,
SAFE_CAST(valor AS NUMERIC) valor
FROM basedosdados-dev.br_bd_indicadores_staging.contabilidade AS t
