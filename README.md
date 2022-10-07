# Queries template

Esse é um template para um pacote DBT a ser importado no cluster do projeto `basedosdados-dev`, que irá gerar um servidor RPC para execução dos projetos específicos de cada projeto GCP. Deve-se respeitar a seguinte nomenclatura: queries-`<nome_do_projeto_gcp>`.

## Como usar esse template

- Na criação de um novo repositório, selecione o template `queries-template` e crie um repositório com o nome `queries-<nome_do_projeto_gcp>`.
- Configure o seguinte secret no repositório:
  - `VAULT_TOKEN`: token de acesso ao vault.

> Este projeto necessita das variáveis de ambiente descritas abaixo. Tais valores são providos na action do arquivo `cd.yaml`, os valores possuem como origem o Vault.

  - `GCP_SA_KEY_BASE64`: credenciais para uma conta de serviço com pleno acesso ao GKE, GCR e GCS. Preencher com o resultado de `cat sua-credencial.json | base64`.
  - `GCP_PROJECT_ID`: identificador do projeto no GCP.
  - `GKE_CLUSTER_NAME`: nome do cluster no GKE.
  - `GKE_CLUSTER_ZONE`: zona do cluster no GKE.

Aplique as seguintes alterações no projeto:

- Corrija o arquivo `cd.yaml`, onde todos os valores que estão como `<GCP_PROJECT_NAME>` devem ser substituídos pelo nome do projeto GCP;
- Garanta que todos os valores recuperados do Vault existam e estejam corretos;
- Modifique o nome do pacote em `dbt_project.yml` para o nome do seu projeto. Aproveite esse momento para ler, com calma, os comentários desse arquivo de configuração.
- [Crie contas de serviço](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) para seus projetos de desenvolvimento e produção. Caso tenha somente um projeto, pode usar a mesma conta para ambos os propósitos. **Nota:** **Jamais** faça commit de suas credenciais.
- Acesse o arquivo `profiles.yml` e se atente aos comentários, eles indicam os campos que devem ser alterados.
- Usando os arquivos de credencial, crie os secrets `credentials-dev` e `credentials-prod` [usando a flag `--from-file`](https://cloud.google.com/kubernetes-engine/docs/concepts/secret#creating_secrets_from_files).
- Faça o upload das alterações realizadas em seu repositório.
- Toda vez que houver uma alteração de código na branch `master`, uma instância atualizada do servidor RPC do DBT será criada em seu cluster, no devido namespace.

### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

## Como desenvolver novos modelos

1. Caso seja um `dataset-id` já existente, acesse `models/<dataset-id>` e pule para o passo 5.

2. Caso seja um novo `dataset-id`, crie um novo diretório `models/<dataset-id>`.

3. No arquivo `dbt_project.yml` registre o `dataset-id` junto aos já existentes, conforme exemplo abaixo:

```yaml
models:
  emd:
    dataset-id:
      +materialized: view # Materialization type (view, table or incremental)
      +schema: dataset-id # Overrides the default schema (defaults to what is set on profiles.yml)
```

4. No diretório `models/<dataset-id>`, crie um arquivo `schema.yml` para preencher metadados de suas tabelas. Exemplo abaixo:

```yaml
version: 2

models:
  - name: my_first_dbt_model
    description: "A starter dbt model"
    columns:
      - name: id
        description: "The primary key for this table"
```

5. Desenvolva seus modelos (que corresponderão a tabelas) no diretório `models/<dataset-id>`.
