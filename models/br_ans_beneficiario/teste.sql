UPDATE `basedosdados-dev.br_ans_beneficiario.microdados` as tabela_mae
SET modalidade_operadora = safe_cast(dicionario.chave AS STRING)
FROM `basedosdados-dev.br_ans_beneficiario_staging.dicionario` AS dicionario
WHERE tabela_mae.modalidade_operadora = dicionario.valor
