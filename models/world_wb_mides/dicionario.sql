{{
    config(
        alias="dicionario",
        schema="world_wb_mides",
        materialized="table",
        labels={"tema": "economia"},
    )
}}
select
    safe_cast(id_tabela as string) id_tabela,
    safe_cast(coluna as string) coluna,
    safe_cast(chave as string) chave,
    safe_cast(cobertura_temporal as string) cobertura_temporal,
    safe_cast(valor as string) valor
from `basedosdados-dev.world_wb_mides_staging.dicionario` as t
