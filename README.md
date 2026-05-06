# Knowledge Base — Data Warehouse Live!

Base de conhecimento centralizada para o Data Warehouse da Live!, incluindo padrões de nomenclatura, documentação de schemas, dicionários de dados e planos de governança.

---

## Por que este repositório existe

O conhecimento sobre sistemas, estrutura do DW e regras de negócio estava **fragmentado**: na cabeça das pessoas, em anexos de tickets GLPI, em PDFs sem versionamento. Isso gerava riscos reais:

- Projetos de IA/dados construídos sobre base frágil
- Dependência de pessoas-chave (bus factor)
- Custo oculto de onboarding e retrabalho

Este repositório centraliza e versiona esse conhecimento.

---

## O que tem aqui

```
Knowledge Base/
├── docs/
│   ├── DW/                        # Padrões e diagnósticos do Data Warehouse
│   │   ├── BOAS_PRATICAS_DW.md        # Regras oficiais de nomenclatura e estrutura
│   │   ├── DIAGNOSTICO_E_PLANO_ADEQUACAO.md  # Problemas encontrados e plano de adequação
│   │   ├── CONFLITOS_E_DECISOES_PENDENTES.md # Log de conflitos e decisões em aberto
│   │   ├── _inventario_dw.md          # Inventário: 18 schemas, 963 tabelas, 15.731 colunas
│   │   ├── DLL_DW.sql                 # DDL completo do banco
│   │   ├── PLANO_MIGRACAO_JMA.md      # Plano de consolidação do schema JMA
│   │   ├── _schema_extracts/          # Extratos por schema (SQL)
│   │   └── dicionarios/               # Dicionários de dados por área
│   ├── Plan/                      # Planejamento e governança
│   │   ├── 01_Apresentacao_Gerencia.md    # Apresentação para gestão de TI
│   │   └── 02_Roadmap_Alto_Nivel.md       # Roadmap da Knowledge Base
│   ├── Orion/                     # Documentação do ERP Orion
│   ├── Senior/                    # Documentação do ERP Senior
│   └── Systextil/                 # Documentação do ERP Systextil
├── documentacao_dw_queries.md     # Boas práticas para documentar queries
└── padronizacao_de_nomenclatura_de_tabelas_dw.md  # Convenções de nomenclatura
```

---

## Por onde começar

| Objetivo | Documento |
|---|---|
| Entender o contexto do projeto | [docs/Plan/01_Apresentacao_Gerencia.md](docs/Plan/01_Apresentacao_Gerencia.md) |
| Consultar os padrões vigentes | [docs/DW/BOAS_PRATICAS_DW.md](docs/DW/BOAS_PRATICAS_DW.md) |
| Ver o que está pendente de decisão | [docs/DW/CONFLITOS_E_DECISOES_PENDENTES.md](docs/DW/CONFLITOS_E_DECISOES_PENDENTES.md) |
| Entender o tamanho do DW | [docs/DW/_inventario_dw.md](docs/DW/_inventario_dw.md) |

---

## Padrões resumidos

O DW usa **PostgreSQL** com modelagem dimensional. As regras principais:

- Nomes em **português**, **snake_case**, até 63 caracteres
- Prefixos de tabela: `d_` (dimensão), `f_` (fato), `stg_` (stage), `brd_` (bridge), `aux_` (auxiliar), `tmp_` (temporário)
- Chave surrogate: `id` — Chave de negócio: `cod_` — Código operacional: `id_`
- Colunas de auditoria obrigatórias: `created_at`, `updated_at`

Regras completas em [docs/DW/BOAS_PRATICAS_DW.md](docs/DW/BOAS_PRATICAS_DW.md).

---

## Stack

- **Banco de dados:** PostgreSQL (18 schemas, 963 tabelas, 15.731 colunas)
- **Orquestração ETL:** Apache Airflow
- **Sistemas fonte:** Senior, Systextil, Orion
- **Documentação:** Git + Docmost (wiki)

---

## Status atual

- Padrões definidos (v2.0)
- Diagnóstico concluído: 10 problemas críticos identificados
- 28+ conflitos de nomenclatura mapeados e aguardando decisão
- Fase: **Piloto TI** — pré-implementação
