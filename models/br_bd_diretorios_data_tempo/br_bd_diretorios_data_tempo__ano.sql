{{ config(alias="ano", schema="br_bd_diretorios_data_tempo") }}

select safe_cast(ano as int64) ano, safe_cast(bissexto as int64) bissexto
from `basedosdados-dev.br_bd_diretorios_data_tempo_staging.ano` as t
