select
    safe_cast(element as string) element,
    safe_cast(key as string) key,
    safe_cast(value as string) value,
from `basedosdados-dev.br_bd_metadados_staging.available_options` as t
