WITH raw_cnes_profissional AS (
  -- 1. Retirar linhas com id_estabelecimento_cnes nulo
  SELECT *
  FROM `basedosdados-dev.br_ms_cnes_staging.profissional`
  WHERE CNES IS NOT NULL
),
raw_cnes_profissional_dir AS (
  -- 2. Adicionar id_municipio e sigla_uf
  SELECT *
  FROM raw_cnes_profissional 
  LEFT JOIN (SELECT id_municipio, id_municipio_6, sigla_uf,
  FROM `basedosdados-dev.br_bd_diretorios_brasil.municipio`) as mun
  ON raw_cnes_profissional.CODUFMUN = mun.id_municipio_6
)
SELECT 
CAST(SUBSTR(COMPETEN, 1, 4) AS INT64) AS ano,
CAST(SUBSTR(COMPETEN, 5, 2) AS INT64) AS mes,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
--criar com join na tabela da bd
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(id_municipio_6 AS STRING) id_municipio_6,
SAFE_CAST(CNES AS STRING) id_estabelecimento_cnes,
SAFE_CAST(REPLACE(UFMUNRES,"000000","") AS STRING) id_municipio_6_residencia,
SAFE_CAST(NOMEPROF AS STRING) nome,
SAFE_CAST(VINCULAC AS STRING) id_vinculo,
SAFE_CAST(REGISTRO AS STRING) id_registro_conselho,
SAFE_CAST(CONSELHO AS STRING) id_conselho,
SAFE_CAST(REPLACE(CNS_PROF,"999999999999999", '') AS STRING) cartao_nacional_saude,
SAFE_CAST(CBO AS STRING) cbo_2002,
SAFE_CAST(TERCEIRO AS STRING) indicador_estabelecimento_terceiro,
SAFE_CAST(VINCUL_C AS STRING) indicador_vinculo_contratado_sus,
SAFE_CAST(VINCUL_A AS STRING) indicador_vinculo_autonomo_sus,
SAFE_CAST(VINCUL_N AS STRING) indicador_vinculo_outros,
SAFE_CAST(PROF_SUS AS STRING) indicador_atende_sus,
SAFE_CAST(PROFNSUS AS STRING) indicador_atende_nao_sus,
SAFE_CAST(HORAOUTR AS INT64) carga_horaria_outros,
SAFE_CAST(HORAHOSP AS INT64) carga_horaria_hospitalar,
SAFE_CAST(HORA_AMB AS INT64) carga_horaria_ambulatorial
FROM raw_cnes_profissional_dir 
