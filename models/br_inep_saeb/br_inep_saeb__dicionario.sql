{{ config(alias="dicionario", schema="br_inep_saeb") }}

select 
    safe_cast(id_tabela as string) id_tabela,
    safe_cast(nome_coluna as string) nome_coluna,
    safe_cast(chave as string) chave,
    safe_cast(cobertura_temporal as string) cobertura_temporal,
    safe_cast(valor as string) valor
from `basedosdados-dev.br_inep_saeb_staging.dicionario` as t
where id_tabela is not null
