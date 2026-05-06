# Documentação de Queries do Data Warehouse

## 📌 Boas Práticas para Documentação de Queries de DW

### 1. Centralização das Documentações
- Utilizar um repositório único: Git, Confluence, SharePoint, Wiki interna.
- Estrutura sugerida por camada ou projeto:

```plaintext
/datawarehouse
  /staging
  /integration
  /presentation
  /dimension_tables
  /fact_tables
```

---

### 2. Padronização do Cabeçalho nas Queries (comentários SQL)
Cada script SQL deve iniciar com um cabeçalho padronizado.

```sql
/*
Nome da Tabela: dw.fato_vendas
Responsável: Gustavo Puchalski
Última Atualização: 2025-06-16
Descrição: Tabela fato que armazena o histórico de vendas consolidadas por dia, loja e produto.

Fonte de Dados:
  - ERP_CIGAM: tabela vendas
  - Sistema Audaces: API de informações de produto

Transformações principais:
  - Join com tabela de produtos
  - Conversão de timezone
  - Exclusão de devoluções

Dependências:
  - dw.dim_produto
  - dw.dim_loja

Observações:
  - Atualização diária via Airflow DAG: dag_fato_vendas
*/
```

---

### 3. Documentação Funcional (Dicionário de Dados)
Manter descrições dos campos em um local externo (ex: Confluence ou planilha compartilhada).

| Tabela | Campo | Tipo | Descrição | Fonte | Observação |
|--------|-------|------|-------------|--------|------------|
| dw.fato_vendas | id_venda | int | ID único da venda | ERP | PK |
| dw.fato_vendas | dt_venda | date | Data da venda | ERP | |

Ferramentas comuns:
- Confluence
- Dataedo
- Atlan
- Microsoft Purview
- Excel/Google Sheets

---

### 4. Controle de Versões
- Versionamento via Git (GitHub, Bitbucket, GitLab).
- Revisão por Pull Request.
- Branches separados para desenvolvimento e produção.

---

### 5. Documentação de Pipelines ETL/ELT
Descrever:
- Frequência de execução
- Nome do pipeline / DAG no Airflow
- Volume estimado de dados
- Estratégia de carga: full load, incremental, CDC
- Regras de negócio

---

### 6. Relacionamento entre Tabelas
- Criar modelos dimensionais (ERD ou Star Schema).
- Ferramentas:
  - dbdiagram.io
  - SQLDBM
  - Lucidchart
  - dbt Docs (se usar dbt)

---

### 7. Checklist para Publicação de Tabela Nova
- [ ] Script SQL com cabeçalho padronizado
- [ ] Descrição completa no dicionário de dados
- [ ] Diagrama atualizado
- [ ] Pipeline documentado
- [ ] Testes de validação de carga executados

---

### 8. Ciclo de Vida de Uma Nova Tabela
1. Desenvolvimento da query SQL com cabeçalho
2. Execução e testes locais
3. Criação/atualização da documentação funcional
4. Versionamento via Git
5. Publicação via Airflow / orquestração
6. Atualização no dicionário e comunicação

---

### 9. Ferramentas de Apoio por Tipo

| Tipo | Ferramenta Sugerida |
|------|---------------------|
| Versionamento | Git, Bitbucket |
| Wiki | Confluence, SharePoint |
| Data Catalog | Dataedo, Atlan, Microsoft Purview |
| Diagramas | dbdiagram.io, Lucidchart, SQLDBM |
| Documentação automatizada | dbt Docs, Great Expectations |

---

Se desejar, é possível expandir esse documento com exemplos reais das queries da empresa ou gerar templates para uso interno.

