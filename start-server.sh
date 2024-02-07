#!/usr/bin/env sh

dbt deps
export DBT_ELEMENTARY_ENABLED=True
dbt-rpc serve --profiles-dir "." --host "0.0.0.0" --port "8580"
