{{ 
  config(
    alias='cbo_2002',    
    schema='br_bd_diretorios_brasil',
    materialized='table',)
}}

SELECT 
SAFE_CAST(cbo_2002 AS STRING) cbo_2002,
SAFE_CAST(descricao AS STRING) descricao,
SAFE_CAST(familia AS STRING) familia,
SAFE_CAST(descricao_familia AS STRING) descricao_familia,
SAFE_CAST(subgrupo AS STRING) subgrupo,
SAFE_CAST(descricao_subgrupo AS STRING) descricao_subgrupo,
SAFE_CAST(subgrupo_principal AS STRING) subgrupo_principal,
SAFE_CAST(descricao_subgrupo_principal AS STRING) descricao_subgrupo_principal,
SAFE_CAST(grande_grupo AS STRING) grande_grupo,
SAFE_CAST(descricao_grande_grupo AS STRING) descricao_grande_grupo
FROM basedosdados-dev.br_bd_diretorios_brasil_staging.cbo_2002 AS t