{{ 
  config(
    schema='br_ms_cnes',
    materialized='table',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2005,
        "end": 2023,
        "interval": 1}
     }  
    )
 }}

WITH raw_cnes_estabelecimento AS (
  -- 1. Retirar linhas com id_estabelecimento_cnes nulo
  SELECT *
  FROM `basedosdados-dev.br_ms_cnes_staging.estabelecimento`
  WHERE CNES IS NOT NULL
),
raw_cnes_estabelecimento_without_duplicates as(
  -- 2. distinct nas linhas 
  SELECT DISTINCT *
  FROM raw_cnes_estabelecimento
),
cnes_add_muni AS (
  -- 3. Adicionar id_municipio e sigla_uf
  SELECT *
  FROM raw_cnes_estabelecimento_without_duplicates  
  LEFT JOIN (SELECT id_municipio, id_municipio_6,
  FROM `basedosdados-dev.br_bd_diretorios_brasil.municipio`) as mun
  ON raw_cnes_estabelecimento_without_duplicates.CODUFMUN = mun.id_municipio_6
)
  -- 4. padronização, ordenação de colunas e conversão de tipos
  -- 5. Aplica macro clean_cols em certas colunas 
  SELECT
  SAFE_CAST(ano AS INT64) AS ano,
  SAFE_CAST(mes  AS INT64) AS mes,
  SAFE_CAST(sigla_uf AS STRING) sigla_uf, 
  CAST(SUBSTR(DT_ATUAL, 1, 4) AS INT64) AS ano_atualizacao,
  CAST(SUBSTR(DT_ATUAL, 5, 2) AS INT64) AS mes_atualizacao,
  SAFE_CAST(id_municipio AS STRING) id_municipio,
  SAFE_CAST(CODUFMUN AS STRING) id_municipio_6,
  SAFE_CAST({{clean_cols('REGSAUDE')}} AS STRING) id_regiao_saude,
  SAFE_CAST({{clean_cols('MICR_REG')}} AS STRING) id_microrregiao_saude,
  SAFE_CAST({{clean_cols('DISTRSAN')}} AS STRING) id_distrito_sanitario,
  SAFE_CAST({{clean_cols('DISTRADM')}} AS STRING) id_distrito_administrativo,
  SAFE_CAST(COD_CEP AS STRING) cep,
  SAFE_CAST(CNES AS STRING) id_estabelecimento_cnes,
  SAFE_CAST({{clean_cols('PF_PJ')}} AS STRING) tipo_pessoa,
  -- fazer replace em valores de linha com 14 zeros para null. 14 zeros é o tamanho de um valor nulo na variável cpf/cnpj
  SAFE_CAST(regexp_replace(CPF_CNPJ, '0{14}', '') AS STRING) cpf_cnpj,
  SAFE_CAST({{clean_cols('NIV_DEP')}} AS STRING) tipo_grau_dependencia,
  -- fazer replace em valores de linha com 14 zeros para null. 14 zeros é o tamanho de um cpf/cnpj nulo
  SAFE_CAST(regexp_replace(CNPJ_MAN, '0{14}', '') AS STRING) cnpj_mantenedora,
  SAFE_CAST({{clean_cols('COD_IR')}} AS STRING) tipo_retencao_tributos_mantenedora,
  SAFE_CAST(VINC_SUS AS INT64) indicador_vinculo_sus,
  SAFE_CAST(TPGESTAO AS STRING) tipo_gestao,
  SAFE_CAST({{clean_cols('ESFERA_A')}} AS STRING) tipo_esfera_administrativa,
  SAFE_CAST(RETENCAO AS STRING) tipo_retencao_tributos,
  SAFE_CAST({{clean_cols('ATIVIDAD')}} AS STRING) tipo_atividade_ensino_pesquisa,
  SAFE_CAST(NATUREZA AS STRING) tipo_natureza_administrativa,
  SAFE_CAST(NAT_JUR AS STRING) id_natureza_juridica,
  SAFE_CAST(CLIENTEL AS STRING) tipo_fluxo_atendimento,
  SAFE_CAST({{clean_cols('TP_UNID')}} AS STRING) tipo_unidade,
  SAFE_CAST({{clean_cols('TURNO_AT')}} AS STRING) tipo_turno,
  SAFE_CAST({{clean_cols('NIV_HIER')}} AS STRING) tipo_nivel_hierarquia,
  SAFE_CAST({{clean_cols('TP_PREST')}} AS STRING) tipo_prestador,
  SAFE_CAST(CO_BANCO AS STRING) banco,
  SAFE_CAST(CO_AGENC AS STRING) agencia,
  SAFE_CAST(C_CORREN AS STRING) conta_corrente,
  SAFE_CAST(CONTRATM AS STRING) id_contrato_municipio_sus,
  SAFE_CAST(PARSE_DATE('%Y%m%d', DT_PUBLM) AS DATE) data_publicacao_contrato_municipal,
  SAFE_CAST(PARSE_DATE('%Y%m%d', DT_PUBLE) AS DATE) data_publicacao_contrato_estadual,
  SAFE_CAST(CONTRATE AS STRING) id_contrato_estado_sus,
  SAFE_CAST(ALVARA AS STRING) numero_alvara,
  SAFE_CAST(PARSE_DATE('%Y%m%d', DT_EXPED) AS DATE) data_expedicao_alvara,
  SAFE_CAST({{clean_cols('ORGEXPED')}} AS STRING) tipo_orgao_expedidor,
  SAFE_CAST({{clean_cols('AV_ACRED')}} AS STRING) tipo_avaliacao_acreditacao_hospitalar,
  SAFE_CAST(CLASAVAL AS STRING) tipo_classificacao_acreditacao_hospitalar,
  CAST(SUBSTR(DT_ACRED, 1, 4) AS INT64) AS ano_acreditacao,
  CAST(SUBSTR(DT_ACRED, 5, 2) AS INT64) AS mes_acreditacao,
  SAFE_CAST({{clean_cols('AV_PNASS')}} AS INT64) tipo_avaliacao_pnass,
  CAST(SUBSTR(DT_PNASS, 1, 4) as INT64) AS ano_avaliacao_pnass,
  CAST(SUBSTR(DT_PNASS, 5, 2) AS INT64) AS mes_avaliacao_pnass,
  SAFE_CAST(NIVATE_A AS INT64) indicador_atencao_ambulatorial,
  SAFE_CAST(GESPRG1E AS INT64) indicador_gestao_basica_ambulatorial_estadual,
  SAFE_CAST(GESPRG1M AS INT64) indicador_gestao_basica_ambulatorial_municipal,
  SAFE_CAST(GESPRG2E AS INT64) indicador_gestao_media_ambulatorial_estadual,
  SAFE_CAST(GESPRG2M AS INT64) indicador_gestao_media_ambulatorial_municipal,
  SAFE_CAST(GESPRG4E AS INT64) indicador_gestao_alta_ambulatorial_estadual,
  SAFE_CAST(GESPRG4M AS INT64) indicador_gestao_alta_ambulatorial_municipal,
  SAFE_CAST(NIVATE_H AS INT64) indicador_atencao_hospitalar,
  SAFE_CAST(GESPRG5E AS INT64) indicador_gestao_media_hospitalar_estadual,
  SAFE_CAST(GESPRG5M AS INT64) indicador_gestao_media_hospitalar_municipal,
  SAFE_CAST(GESPRG6E AS INT64) indicador_gestao_alta_hospitalar_estadual,
  SAFE_CAST(GESPRG6M AS INT64) indicador_gestao_alta_hospitalar_municipal,
  SAFE_CAST(GESPRG3E AS INT64) indicador_gestao_hospitalar_estadual,
  SAFE_CAST(GESPRG3M AS INT64) indicador_gestao_hospitalar_municipal,
  SAFE_CAST(LEITHOSP AS INT64) indicador_leito_hospitalar,
  SAFE_CAST(QTLEITP1 AS INT64) quantidade_leito_cirurgico,
  SAFE_CAST(QTLEITP2 AS INT64) quantidade_leito_clinico,
  SAFE_CAST(QTLEITP3 AS INT64) quantidade_leito_complementar,
  SAFE_CAST(QTLEIT05 AS INT64) quantidade_leito_repouso_pediatrico_urgencia,
  SAFE_CAST(QTLEIT06 AS INT64) quantidade_leito_repouso_feminino_urgencia,
  SAFE_CAST(QTLEIT07 AS INT64) quantidade_leito_repouso_masculino_urgencia,
  SAFE_CAST(QTLEIT08 AS INT64) quantidade_leito_repouso_indiferenciado_urgencia,
  SAFE_CAST(URGEMERG AS INT64) indicador_instalacao_urgencia,
  SAFE_CAST(QTINST01 AS INT64) quantidade_consultorio_pediatrico_urgencia,
  SAFE_CAST(QTINST02 AS INT64) quantidade_consultorio_feminino_urgencia,
  SAFE_CAST(QTINST03 AS INT64) quantidade_consultorio_masculino_urgencia,
  SAFE_CAST(QTINST04 AS INT64) quantidade_consultorio_indiferenciado_urgencia,
  SAFE_CAST(QTINST09 AS INT64) quantidade_consultorio_odontologia_urgencia,
  SAFE_CAST(QTINST05 AS INT64) quantidade_sala_repouso_pediatrico_urgencia,
  SAFE_CAST(QTINST06 AS INT64) quantidade_sala_repouso_feminino_urgencia,
  SAFE_CAST(QTINST07 AS INT64) quantidade_sala_repouso_masculino_urgencia,
  SAFE_CAST(QTINST08 AS INT64) quantidade_sala_repouso_indiferenciado_urgencia,
  SAFE_CAST(QTLEIT09 AS INT64) quantidade_equipos_odontologia_urgencia,
  SAFE_CAST(QTINST10 AS INT64) quantidade_sala_higienizacao_urgencia,
  SAFE_CAST(QTINST11 AS INT64) quantidade_sala_gesso_urgencia,
  SAFE_CAST(QTINST12 AS INT64) quantidade_sala_curativo_urgencia,
  SAFE_CAST(QTINST13 AS INT64) quantidade_sala_pequena_cirurgia_urgencia,
  SAFE_CAST(QTINST14 AS INT64) quantidade_consultorio_medico_urgencia,
  SAFE_CAST(ATENDAMB AS INT64) indicador_instalacao_ambulatorial,
  SAFE_CAST(QTINST15 AS INT64) quantidade_consultorio_clinica_basica_ambulatorial,
  SAFE_CAST(QTINST16 AS INT64) quantidade_consultorio_clinica_especializada_ambulatorial,
  SAFE_CAST(QTINST17 AS INT64) quantidade_consultorio_clinica_indiferenciada_ambulatorial,
  SAFE_CAST(QTINST18 AS INT64) quantidade_consultorio_nao_medico_ambulatorial,
  SAFE_CAST(QTINST19 AS INT64) quantidade_sala_repouso_feminino_ambulatorial,
  SAFE_CAST(QTLEIT19 AS INT64) quantidade_leito_repouso_feminino_ambulatorial,
  SAFE_CAST(QTINST20 AS INT64) quantidade_sala_repouso_masculino_ambulatorial,
  SAFE_CAST(QTLEIT20 AS INT64) quantidade_leito_repouso_masculino_ambulatorial,
  SAFE_CAST(QTINST21 AS INT64) quantidade_sala_repouso_pediatrico_ambulatorial,
  SAFE_CAST(QTLEIT21 AS INT64) quantidade_leito_repouso_pediatrico_ambulatorial,
  SAFE_CAST(QTINST22 AS INT64) quantidade_sala_repouso_indiferenciado_ambulatorial,
  SAFE_CAST(QTLEIT22 AS INT64) quantidade_leito_repouso_indiferenciado_ambulatorial,
  SAFE_CAST(QTINST23 AS INT64) quantidade_consultorio_odontologia_ambulatorial,
  SAFE_CAST(QTLEIT23 AS INT64) quantidade_equipos_odontologia_ambulatorial,
  SAFE_CAST(QTINST24 AS INT64) quantidade_sala_pequena_cirurgia_ambulatorial,
  SAFE_CAST(QTINST25 AS INT64) quantidade_sala_enfermagem_ambulatorial,
  SAFE_CAST(QTINST26 AS INT64) quantidade_sala_imunizacao_ambulatorial,
  SAFE_CAST(QTINST27 AS INT64) quantidade_sala_nebulizacao_ambulatorial,
  SAFE_CAST(QTINST28 AS INT64) quantidade_sala_gesso_ambulatorial,
  SAFE_CAST(QTINST29 AS INT64) quantidade_sala_curativo_ambulatorial,
  SAFE_CAST(QTINST30 AS INT64) quantidade_sala_cirurgia_ambulatorial,
  SAFE_CAST(ATENDHOS AS INT64) indicador_instalacao_hospitalar,
  SAFE_CAST(CENTRCIR AS INT64) indicador_instalacao_hospitalar_centro_cirurgico,
  SAFE_CAST(QTINST31 AS INT64) quantidade_sala_cirurgia_centro_cirurgico,
  SAFE_CAST(QTINST32 AS INT64) quantidade_sala_recuperacao_centro_cirurgico,
  SAFE_CAST(QTLEIT32 AS INT64) quantidade_leito_recuperacao_centro_cirurgico,
  SAFE_CAST(QTINST33 AS INT64) quantidade_sala_cirurgia_ambulatorial_centro_cirurgico,
  SAFE_CAST(CENTROBS AS INT64) indicador_instalacao_hospitalar_centro_obstetrico,
  SAFE_CAST(QTINST34 AS INT64) quantidade_sala_pre_parto_centro_obstetrico,
  SAFE_CAST(QTLEIT34 AS INT64) quantidade_leito_pre_parto_centro_obstetrico,
  SAFE_CAST(QTINST35 AS INT64) quantidade_sala_parto_normal_centro_obstetrico,
  SAFE_CAST(QTINST36 AS INT64) quantidade_sala_curetagem_centro_obstetrico,
  SAFE_CAST(QTINST37 AS INT64) quantidade_sala_cirurgia_centro_obstetrico,
  SAFE_CAST(CENTRNEO AS INT64) indicador_instalacao_hospitalar_neonatal,
  SAFE_CAST(QTLEIT38 AS INT64) quantidade_leito_recem_nascido_normal_neonatal,
  SAFE_CAST(QTLEIT39 AS INT64) quantidade_leito_recem_nascido_patologico_neonatal,
  SAFE_CAST(QTLEIT40 AS INT64) quantidade_leito_conjunto_neonatal,
  SAFE_CAST(SERAPOIO AS INT64) indicador_servico_apoio,
  SAFE_CAST(SERAP01P AS INT64) indicador_servico_same_spp_proprio,
  SAFE_CAST(SERAP01T AS INT64) indicador_servico_same_spp_terceirizado,
  SAFE_CAST(SERAP02P AS INT64) indicador_servico_social_proprio,
  SAFE_CAST(SERAP02T AS INT64) indicador_servico_social_terceirizado,
  SAFE_CAST(SERAP03P AS INT64) indicador_servico_farmacia_proprio,
  SAFE_CAST(SERAP03T AS INT64) indicador_servico_farmacia_terceirizado,
  SAFE_CAST(SERAP04P AS INT64) indicador_servico_esterilizacao_proprio,
  SAFE_CAST(SERAP04T AS INT64) indicador_servico_esterilizacao_terceirizado,
  SAFE_CAST(SERAP05P AS INT64) indicador_servico_nutricao_proprio,
  SAFE_CAST(SERAP05T AS INT64) indicador_servico_nutricao_terceirizado,
  SAFE_CAST(SERAP06P AS INT64) indicador_servico_lactario_proprio,
  SAFE_CAST(SERAP06T AS INT64) indicador_servico_lactario_terceirizado,
  SAFE_CAST(SERAP07P AS INT64) indicador_servico_banco_leite_proprio,
  SAFE_CAST(SERAP07T AS INT64) indicador_servico_banco_leite_terceirizado,
  SAFE_CAST(SERAP08P AS INT64) indicador_servico_lavanderia_proprio,
  SAFE_CAST(SERAP08T AS INT64) indicador_servico_lavanderia_terceirizado,
  SAFE_CAST(SERAP09P AS INT64) indicador_servico_manutencao_proprio,
  SAFE_CAST(SERAP09T AS INT64) indicador_servico_manutencao_terceirizado,
  SAFE_CAST(SERAP10P AS INT64) indicador_servico_ambulancia_proprio,
  SAFE_CAST(SERAP10T AS INT64) indicador_servico_ambulancia_terceirizado,
  SAFE_CAST(SERAP11P AS INT64) indicador_servico_necroterio_proprio,
  SAFE_CAST(SERAP11T AS INT64) indicador_servico_necroterio_terceirizado,
  SAFE_CAST(COLETRES AS INT64) indicador_coleta_residuo,
  SAFE_CAST(RES_BIOL AS INT64) indicador_coleta_residuo_biologico,
  SAFE_CAST(RES_QUIM AS INT64) indicador_coleta_residuo_quimico,
  SAFE_CAST(RES_RADI AS INT64) indicador_coleta_rejeito_radioativo,
  SAFE_CAST(RES_COMU AS INT64) indicador_coleta_rejeito_comum,
  SAFE_CAST(COMISSAO AS INT64) indicador_comissao,
  SAFE_CAST(COMISS01 AS INT64) indicador_comissao_etica_medica,
  SAFE_CAST(COMISS02 AS INT64) indicador_comissao_etica_enfermagem,
  SAFE_CAST(COMISS03 AS INT64) indicador_comissao_farmacia_terapeutica,
  SAFE_CAST(COMISS04 AS INT64) indicador_comissao_controle_infeccao,
  SAFE_CAST(COMISS05 AS INT64) indicador_comissao_apropriacao_custos,
  SAFE_CAST(COMISS06 AS INT64) indicador_comissao_cipa,
  SAFE_CAST(COMISS07 AS INT64) indicador_comissao_revisao_prontuario,
  SAFE_CAST(COMISS08 AS INT64) indicador_comissao_revisao_documentacao,
  SAFE_CAST(COMISS09 AS INT64) indicador_comissao_analise_obito_biopisias,
  SAFE_CAST(COMISS10 AS INT64) indicador_comissao_investigacao_epidemiologica,
  SAFE_CAST(COMISS11 AS INT64) indicador_comissao_notificacao_doencas,
  SAFE_CAST(COMISS12 AS INT64) indicador_comissao_zoonose_vetores,
  SAFE_CAST(ATEND_PR AS INT64) indicador_atendimento_prestado,
  SAFE_CAST(AP01CV01 AS INT64) indicador_atendimento_internacao_sus,
  SAFE_CAST(AP01CV02 AS INT64) indicador_atendimento_internacao_particular,
  SAFE_CAST(AP01CV03 AS INT64) indicador_atendimento_internacao_plano_seguro_proprio,
  SAFE_CAST(AP01CV04 AS INT64) indicador_atendimento_internacao_plano_seguro_terceiro,
  SAFE_CAST(AP01CV05 AS INT64) indicador_atendimento_internacao_plano_saude_publico,
  SAFE_CAST(AP01CV06 AS INT64) indicador_atendimento_internacao_plano_saude_privado,
  SAFE_CAST(AP02CV01 AS INT64) indicador_atendimento_ambulatorial_sus,
  SAFE_CAST(AP02CV02 AS INT64) indicador_atendimento_ambulatorial_particular,
  SAFE_CAST(AP02CV03 AS INT64) indicador_atendimento_ambulatorial_plano_seguro_proprio,
  SAFE_CAST(AP02CV04 AS INT64) indicador_atendimento_ambulatorial_plano_seguro_terceiro,
  SAFE_CAST(AP02CV05 AS INT64) indicador_atendimento_ambulatorial_plano_saude_publico,
  SAFE_CAST(AP02CV06 AS INT64) indicador_atendimento_ambulatorial_plano_saude_privado,
  SAFE_CAST(AP03CV01 AS INT64) indicador_atendimento_sadt_sus,
  SAFE_CAST(AP03CV02 AS INT64) indicador_atendimento_sadt_privado,
  SAFE_CAST(AP03CV03 AS INT64) indicador_atendimento_sadt_plano_seguro_proprio,
  SAFE_CAST(AP03CV04 AS INT64) indicador_atendimento_sadt_plano_seguro_terceiro,
  SAFE_CAST(AP03CV05 AS INT64) indicador_atendimento_sadt_plano_saude_publico,
  SAFE_CAST(AP03CV06 AS INT64) indicador_atendimento_sadt_plano_saude_privado,
  SAFE_CAST(AP04CV01 AS STRING) indicador_atendimento_urgencia_sus,
  SAFE_CAST(AP04CV02 AS INT64) indicador_atendimento_urgencia_privado,
  SAFE_CAST(AP04CV03 AS INT64) indicador_atendimento_urgencia_plano_seguro_proprio,
  SAFE_CAST(AP04CV04 AS INT64) indicador_atendimento_urgencia_plano_seguro_terceiro,
  SAFE_CAST(AP04CV05 AS INT64) indicador_atendimento_urgencia_plano_saude_publico,
  SAFE_CAST(AP04CV06 AS INT64) indicador_atendimento_urgencia_plano_saude_privado,
  SAFE_CAST(AP05CV01 AS INT64) indicador_atendimento_outros_sus,
  SAFE_CAST(AP05CV02 AS INT64) indicador_atendimento_outros_privado,
  SAFE_CAST(AP05CV03 AS INT64) indicador_atendimento_outros_plano_seguro_proprio,
  SAFE_CAST(AP05CV04 AS INT64) indicador_atendimento_outros_plano_seguro_terceiro,
  SAFE_CAST(AP05CV05 AS INT64) indicador_atendimento_outros_plano_saude_publico,
  SAFE_CAST(AP05CV06 AS INT64) indicador_atendimento_outros_plano_saude_privado,
  SAFE_CAST(AP06CV01 AS INT64) indicador_atendimento_vigilancia_sus,
  SAFE_CAST(AP06CV02 AS INT64) indicador_atendimento_vigilancia_privado,
  SAFE_CAST(AP06CV03 AS INT64) indicador_atendimento_vigilancia_plano_seguro_proprio,
  SAFE_CAST(AP06CV04 AS INT64) indicador_atendimento_vigilancia_plano_seguro_terceiro,
  SAFE_CAST(AP06CV05 AS INT64) indicador_atendimento_vigilancia_plano_saude_publico,
  SAFE_CAST(AP06CV06 AS INT64) indicador_atendimento_vigilancia_plano_saude_privado,
  SAFE_CAST(AP07CV01 AS INT64) indicador_atendimento_regulacao_sus,
  SAFE_CAST(AP07CV02 AS INT64) indicador_atendimento_regulacao_privado,
  SAFE_CAST(AP07CV03 AS INT64) indicador_atendimento_regulacao_plano_seguro_proprio,
  SAFE_CAST(AP07CV04 AS INT64) indicador_atendimento_regulacao_plano_seguro_terceiro,
  SAFE_CAST(AP07CV05 AS INT64) indicador_atendimento_regulacao_plano_saude_publico,
  SAFE_CAST(AP07CV06 AS INT64) indicador_atendimento_regulacao_plano_saude_privado
  FROM cnes_add_muni AS t
  WHERE (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6
  OR  DATE_DIFF(DATE(2023,5,1),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 0) 
