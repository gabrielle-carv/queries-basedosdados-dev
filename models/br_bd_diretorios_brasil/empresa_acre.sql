{{
    config(
        schema="br_bd_diretorios_brasil",
        materialized="incremental",
        unique_key="cnpj",
        cluster_by=[" id_municipio", "sigla_uf"],
        labels={"project_id": "basedosdados-dev", "tema": "economia"},
    )
}}


with
    tabela_empresa as (
        with
            matriz as (
                select distinct
                    cnpj, identificador_matriz_filial, b.valor as matriz_filial
                from `basedosdados.br_me_cnpj.estabelecimentos` a
                inner join
                    `basedosdados.br_me_cnpj.dicionario` b
                    on a.identificador_matriz_filial = b.chave
                where b.nome_coluna = 'identificador_matriz_filial' and sigla_uf = 'AC'
            ),
            situacao as (
                select distinct a.cnpj, b.valor as situacao_cadastral
                from `basedosdados.br_me_cnpj.estabelecimentos` a
                inner join
                    (
                        select cnpj, max(data) as max_data
                        from `basedosdados.br_me_cnpj.estabelecimentos`
                        where sigla_uf = 'AC'
                        group by cnpj
                    ) c
                    on a.cnpj = c.cnpj
                    and a.data = c.max_data
                inner join
                    `basedosdados.br_me_cnpj.dicionario` b
                    on a.situacao_cadastral = b.chave
                where b.nome_coluna = 'situacao_cadastral' and a.sigla_uf = 'AC'
            ),
            pais as (
                select distinct
                    cnpj,
                    case when sigla_uf = 'BR' then 'RJ' else sigla_uf end sigla_uf,
                    id_pais,
                    case
                        when a.id_pais = '8'
                        then 'Brasil'
                        when a.id_pais = '9'
                        then 'Brasil'
                        when
                            id_pais is null
                            and sigla_uf in (
                                'RO',
                                'AC',
                                'AM',
                                'RR',
                                'PA',
                                'AP',
                                'TO',
                                'MA',
                                'PI',
                                'CE',
                                'RN',
                                'PB',
                                'PE',
                                'AL',
                                'SE',
                                'BA',
                                'MG',
                                'ES',
                                'RJ',
                                'SP',
                                'PR',
                                'SC',
                                'RS',
                                'MS',
                                'MT',
                                'GO',
                                'DF',
                                'BR'
                            )
                        then 'Brasil'
                        else no_pais
                    end nome_pais_me,
                    case
                        when a.id_pais = '8'
                        then 'BRA'
                        when a.id_pais = '9'
                        then 'BRA'
                        when
                            id_pais is null
                            and sigla_uf in (
                                'RO',
                                'AC',
                                'AM',
                                'RR',
                                'PA',
                                'AP',
                                'TO',
                                'MA',
                                'PI',
                                'CE',
                                'RN',
                                'PB',
                                'PE',
                                'AL',
                                'SE',
                                'BA',
                                'MG',
                                'ES',
                                'RJ',
                                'SP',
                                'PR',
                                'SC',
                                'RS',
                                'MS',
                                'MT',
                                'GO',
                                'DF',
                                'BR'
                            )
                        then 'BRA'
                        when
                            a.id_pais is null
                            and sigla_uf not in (
                                'RO',
                                'AC',
                                'AM',
                                'RR',
                                'PA',
                                'AP',
                                'TO',
                                'MA',
                                'PI',
                                'CE',
                                'RN',
                                'PB',
                                'PE',
                                'AL',
                                'SE',
                                'BA',
                                'MG',
                                'ES',
                                'RJ',
                                'SP',
                                'PR',
                                'SC',
                                'RS',
                                'MS',
                                'MT',
                                'GO',
                                'DF',
                                'BR'
                            )
                        then code_iso3
                        else co_pais_isoa3
                    end id_code_iso3

                from `basedosdados.br_me_cnpj.estabelecimentos` a
                left join
                    `basedosdados-dev.br_bd_diretorios_brasil_staging.bairro_code_iso3` e
                    on a.bairro = e.bairro
                left join
                    `basedosdados-dev.br_bd_diretorios_mundo_staging.pais_code` d
                    on a.id_pais = d.co_pais
                where sigla_uf = 'AC'
            ),
            estabelecimento as (
                select distinct
                    a.cnpj,
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
                    a.id_pais as id_pais_me,
                    nome_pais_me,
                    concat(ddd_1, " ", telefone_1) as telefone_1,
                    concat(ddd_2, " ", telefone_2) as telefone_2,
                    concat(ddd_fax, " ", fax) as fax,
                    email

                from `basedosdados.br_me_cnpj.estabelecimentos` a
                inner join
                    (
                        select cnpj, max(data) as max_data
                        from `basedosdados.br_me_cnpj.estabelecimentos`
                        where sigla_uf = 'AC'
                        group by cnpj
                    ) e
                    on a.cnpj = e.cnpj
                    and a.data = e.max_data
                left join matriz b on a.cnpj = b.cnpj
                left join situacao c on a.cnpj = c.cnpj
                left join pais d on a.cnpj = d.cnpj
                where d.sigla_uf = 'AC'
            ),
            empresa as (
                select distinct
                    a.cnpj_basico,
                    razao_social,
                    natureza_juridica,
                    ente_federativo,
                    capital_social,
                    b.valor as porte,
                from `basedosdados.br_me_cnpj.empresas` a
                inner join
                    (
                        select cnpj_basico, max(data) as max_data
                        from `basedosdados.br_me_cnpj.empresas`
                        group by 1
                    ) c
                    on a.cnpj_basico = c.cnpj_basico
                    and a.data = c.max_data
                inner join `basedosdados.br_me_cnpj.dicionario` b on a.porte = b.chave
                where b.nome_coluna = 'porte'
            ),
            simples as (
                select distinct cnpj_basico, opcao_simples, opcao_mei
                from `basedosdados.br_me_cnpj.simples`
            )

        select
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
        from estabelecimento a
        left join empresa b on a.cnpj_basico = b.cnpj_basico
        left join simples c on a.cnpj_basico = c.cnpj_basico
    )
select *
from tabela_empresa
{% if is_incremental() %}
    where
        cnpj not in (
            select cnpj
            from {{ this }}
            where situacao_cadastral = tabela_empresa.situacao_cadastral
        )
{% endif %}
