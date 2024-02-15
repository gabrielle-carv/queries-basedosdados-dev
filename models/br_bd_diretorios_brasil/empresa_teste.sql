{{ 
  config(
    schema='br_bd_diretorios_brasil',
    materialized='table',
    cluster_by =    [' id_municipio', 'sigla_uf'] ,
    labels = {'project_id': 'basedosdados-dev', 'tema': 'economia'})
}}




WITH matriz AS (
  SELECT
    DISTINCT cnpj,
    identificador_matriz_filial,
    b.valor AS matriz_filial
  FROM `basedosdados.br_me_cnpj.estabelecimentos` a
  INNER JOIN `basedosdados.br_me_cnpj.dicionario` b
    ON a.identificador_matriz_filial = b.chave
  WHERE b.nome_coluna ='identificador_matriz_filial'
    AND sigla_uf ='AC'
),
situacao AS (
  SELECT 
    DISTINCT a.cnpj,
    b.valor AS situacao_cadastral
  FROM `basedosdados.br_me_cnpj.estabelecimentos` a
  INNER JOIN (
    SELECT 
      cnpj,
      MAX(data) AS max_data
    FROM `basedosdados.br_me_cnpj.estabelecimentos`
    WHERE sigla_uf ='AC'
    GROUP BY cnpj
  ) c
    ON a.cnpj = c.cnpj AND a.data = c.max_data
  INNER JOIN `basedosdados.br_me_cnpj.dicionario` b
    ON a.situacao_cadastral = b.chave
  WHERE b.nome_coluna ='situacao_cadastral'
    AND a.sigla_uf ='AC'
),
pais AS (
  SELECT
    DISTINCT cnpj,
    CASE 
      WHEN sigla_uf = 'BR' THEN 'RJ'
      ELSE sigla_uf
    END sigla_uf,
    id_pais,
    CASE
      WHEN a.id_pais = '8' THEN 'Brasil'
      WHEN a.id_pais = '9' THEN 'Brasil'
      WHEN id_pais IS NULL AND sigla_uf IN ('RO','AC','AM','RR','PA','AP','TO','MA','PI','CE','RN','PB','PE',
        'AL', 'SE', 'BA', 'MG', 'ES', 'RJ', 'SP', 'PR', 'SC', 'RS', 'MS','MT','GO','DF','BR') THEN 'Brasil'
      ELSE no_pais 
    END nome_pais_me,
    CASE 
      WHEN a.id_pais = '8' THEN 'BRA'
      WHEN a.id_pais = '9' THEN 'BRA'
      WHEN id_pais IS NULL AND sigla_uf IN ('RO','AC','AM','RR','PA','AP','TO','MA','PI','CE','RN','PB','PE',
        'AL', 'SE', 'BA', 'MG', 'ES', 'RJ', 'SP', 'PR', 'SC', 'RS', 'MS','MT','GO','DF','BR') THEN 'BRA' 
      WHEN a.id_pais IS NULL AND sigla_uf NOT IN ('RO','AC','AM','RR','PA','AP','TO','MA','PI','CE','RN','PB','PE',
        'AL', 'SE', 'BA', 'MG', 'ES', 'RJ', 'SP', 'PR', 'SC', 'RS', 'MS','MT','GO','DF','BR') THEN code_iso3
      ELSE co_pais_isoa3
    END id_code_iso3
    
  FROM `basedosdados.br_me_cnpj.estabelecimentos` a
  LEFT JOIN `basedosdados-dev.br_bd_diretorios_brasil_staging.bairro_code_iso3` e
  ON a.bairro = e.bairro
  LEFT JOIN `basedosdados-dev.br_bd_diretorios_mundo_staging.pais_code` d
    ON a.id_pais = d.co_pais
  WHERE sigla_uf = 'AC'
), estabelecimento AS (
SELECT 
  distinct a.cnpj,
  cnpj_basico,
  cnpj_ordem,
  cnpj_dv,
  nome_fantasia,
  cnae_fiscal_principal,
  cnae_fiscal_secundaria,
  matriz_filial,
  c.situacao_cadastral,
  situacao_especial,
  cep,
  tipo_logradouro,
  logradouro,
  numero,
  complemento,
  bairro,
  id_municipio,
  id_municipio_rf,
  d.sigla_uf,
  id_code_iso3,
  a.id_pais  as id_pais_me,
  nome_pais_me,
  CONCAT(ddd_1," ",telefone_1 ) as telefone_1,
  CONCAT(ddd_2," ",telefone_2 ) as telefone_2,
  CONCAT(ddd_fax," ",fax ) as fax, 
  email 

FROM `basedosdados.br_me_cnpj.estabelecimentos` a
INNER JOIN (
    SELECT 
      cnpj,
      MAX(data) AS max_data
    FROM `basedosdados.br_me_cnpj.estabelecimentos`
    WHERE sigla_uf ='AC'
    GROUP BY cnpj
  ) e
    ON a.cnpj = e.cnpj AND a.data = e.max_data
LEFT JOIN matriz b
ON a.cnpj = b.cnpj 
LEFT JOIN situacao c
ON a.cnpj = c.cnpj 
LEFT JOIN pais d
ON a.cnpj = d.cnpj
WHERE d.sigla_uf ='AC')
, empresa AS (
SELECT
  distinct a.cnpj_basico,
  razao_social,
  natureza_juridica,
  ente_federativo,
  capital_social,
  b.valor AS porte,
FROM `basedosdados.br_me_cnpj.empresas` a
INNER JOIN (
  SELECT 
    cnpj_basico,
    MAX(data) as max_data
  FROM `basedosdados.br_me_cnpj.empresas`
  GROUP BY 1
) c
ON a.cnpj_basico = c.cnpj_basico AND a.data = c.max_data
INNER JOIN `basedosdados.br_me_cnpj.dicionario` b
ON a.porte = b.chave
WHERE b.nome_coluna ='porte'
), simples AS (
SELECT 
  distinct cnpj_basico,
  opcao_simples,
  opcao_mei
FROM `basedosdados.br_me_cnpj.simples` 
)

SELECT 
    cnpj,
    a.cnpj_basico,
    a.cnpj_ordem,
    cnpj_dv,
    razao_social,
    nome_fantasia,
    natureza_juridica,
    ente_federativo,
    cnae_fiscal_principal,
    cnae_fiscal_secundaria,
    capital_social,
    porte,
    matriz_filial,
    situacao_cadastral,
    situacao_especial,
    opcao_simples,
    opcao_mei,
    cep,
    tipo_logradouro,
    logradouro,
    numero,
    complemento,
    bairro,
    id_municipio,
    id_municipio_rf,
    sigla_uf,
    id_code_iso3,
    id_pais_me,
    nome_pais_me,
    telefone_1,
    telefone_2,
    fax,
    email
FROM estabelecimento a
LEFT JOIN empresa b
ON a.cnpj_basico = b.cnpj_basico
LEFT JOIN simples c
ON a.cnpj_basico = c.cnpj_basico