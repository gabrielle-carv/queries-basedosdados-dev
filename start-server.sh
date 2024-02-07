#!/usr/bin/env sh

export DBT_ELEMENTARY_ENABLED=True
dbt deps
dbt-rpc serve --profiles-dir "." --host "0.0.0.0" --port "8580"
