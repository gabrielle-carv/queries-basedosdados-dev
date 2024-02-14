{{
    config(
        alias="amazonia_legal",
        schema="br_geobr_mapas",
        materialized="table",
    )
}}
select safe.st_geogfromtext(geometria) geometria,
from `basedosdados-dev.br_geobr_mapas_staging.amazonia_legal` as t
