{{ config(alias="evento_requerimento", schema="br_camara_dados_abertos") }}
select
    safe_cast(idevento as string) id,
    safe_cast(titulorequerimento as string) titulo_requerimento,
from `basedosdados-dev.br_camara_dados_abertos_staging.evento_requerimento` as t

