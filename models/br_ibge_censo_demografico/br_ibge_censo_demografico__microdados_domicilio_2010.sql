{{ 
  config(
    alias='microdados_domicilio_2010',
    schema='br_ibge_censo_demografico',
    materialized='table',
    partition_by={
      "field": "sigla_uf",
      "data_type": "string",
    },
    )
 }}
SELECT 
SAFE_CAST(id_regiao AS STRING) id_regiao,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_mesorregiao AS STRING) id_mesorregiao,
SAFE_CAST(id_microrregiao AS STRING) id_microrregiao,
SAFE_CAST(id_regiao_metropolitana AS STRING) id_regiao_metropolitana,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(situacao_setor AS INT64) situacao_setor,
SAFE_CAST(situacao_domicilio AS INT64) situacao_domicilio,
SAFE_CAST(controle AS INT64) controle,
SAFE_CAST(peso_amostral AS FLOAT64) peso_amostral,
SAFE_CAST(area_ponderacao AS INT64) area_ponderacao,
SAFE_CAST(v4001 AS STRING) v4001,
SAFE_CAST(v4002 AS STRING) v4002,
SAFE_CAST(v0201 AS STRING) v0201,
SAFE_CAST(v2011 AS STRING) v2011,
SAFE_CAST(v2012 AS FLOAT64) v2012,
SAFE_CAST(v0202 AS STRING) v0202,
SAFE_CAST(v0203 AS STRING) v0203,
SAFE_CAST(v6203 AS FLOAT64) v6203,
SAFE_CAST(v0204 AS INT64) v0204,
SAFE_CAST(v6204 AS FLOAT64) v6204,
SAFE_CAST(v0205 AS STRING) v0205,
SAFE_CAST(v0206 AS STRING) v0206,
SAFE_CAST(v0207 AS STRING) v0207,
SAFE_CAST(v0208 AS STRING) v0208,
SAFE_CAST(v0209 AS STRING) v0209,
SAFE_CAST(v0210 AS STRING) v0210,
SAFE_CAST(v0211 AS STRING) v0211,
SAFE_CAST(v0212 AS STRING) v0212,
SAFE_CAST(v0213 AS STRING) v0213,
SAFE_CAST(v0214 AS STRING) v0214,
SAFE_CAST(v0215 AS STRING) v0215,
SAFE_CAST(v0216 AS STRING) v0216,
SAFE_CAST(v0217 AS STRING) v0217,
SAFE_CAST(v0218 AS STRING) v0218,
SAFE_CAST(v0219 AS STRING) v0219,
SAFE_CAST(v0220 AS STRING) v0220,
SAFE_CAST(v0221 AS STRING) v0221,
SAFE_CAST(v0222 AS STRING) v0222,
SAFE_CAST(v0301 AS STRING) v0301,
SAFE_CAST(v0401 AS STRING) v0401,
SAFE_CAST(v0402 AS STRING) v0402,
SAFE_CAST(v0701 AS STRING) v0701,
SAFE_CAST(v6529 AS INT64) v6529,
SAFE_CAST(v6530 AS FLOAT64) v6530,
SAFE_CAST(v6531 AS INT64) v6531,
SAFE_CAST(v6532 AS FLOAT64) v6532,
SAFE_CAST(v6600 AS INT64) v6600,
SAFE_CAST(v6210 AS INT64) v6210,
SAFE_CAST(m0201 AS STRING) m0201,
SAFE_CAST(m02011 AS STRING) m02011,
SAFE_CAST(m0202 AS STRING) m0202,
SAFE_CAST(m0203 AS STRING) m0203,
SAFE_CAST(m0204 AS STRING) m0204,
SAFE_CAST(m0205 AS STRING) m0205,
SAFE_CAST(m0206 AS STRING) m0206,
SAFE_CAST(m0207 AS STRING) m0207,
SAFE_CAST(m0208 AS STRING) m0208,
SAFE_CAST(m0209 AS STRING) m0209,
SAFE_CAST(m0210 AS STRING) m0210,
SAFE_CAST(m0211 AS STRING) m0211,
SAFE_CAST(m0212 AS STRING) m0212,
SAFE_CAST(m0213 AS STRING) m0213,
SAFE_CAST(m0214 AS STRING) m0214,
SAFE_CAST(m0215 AS STRING) m0215,
SAFE_CAST(m0216 AS STRING) m0216,
SAFE_CAST(m0217 AS STRING) m0217,
SAFE_CAST(m0218 AS STRING) m0218,
SAFE_CAST(m0219 AS STRING) m0219,
SAFE_CAST(m0220 AS STRING) m0220,
SAFE_CAST(m0221 AS STRING) m0221,
SAFE_CAST(m0222 AS STRING) m0222,
SAFE_CAST(m0301 AS STRING) m0301,
SAFE_CAST(m0401 AS STRING) m0401,
SAFE_CAST(m0402 AS STRING) m0402,
SAFE_CAST(m0701 AS STRING) m0701
from basedosdados-dev.br_ibge_censo_demografico_staging.microdados_domicilio_2010 as t