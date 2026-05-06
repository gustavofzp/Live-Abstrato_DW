# Dicionario de Dados — Schema `ti`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 27 tabelas — chamados GLPI, projetos Orion, squads, sprints Orus
**Responsavel:** Schema ti — dados de gestao de TI: chamados de suporte (GLPI), projetos e demandas (Orion), sprints e atendimento (Orus)

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `ti.ddescricao_prioridade` | `ti.d_prioridade` | dimensao |
| `ti.ddescricao_status` | `ti.d_status` | dimensao |
| `ti.dglpi_categorias` | `ti.d_glpi_categoria` | dimensao |
| `ti.dglpi_estagios` | `ti.d_glpi_estagio` | dimensao |
| `ti.dglpi_filas` | `ti.d_glpi_fila` | dimensao |
| `ti.dglpi_grupos` | `ti.d_glpi_grupo` | dimensao |
| `ti.dglpi_sistemas` | `ti.d_glpi_sistema` | dimensao |
| `ti.dglpi_sla` | `ti.d_glpi_sla` | dimensao |
| `ti.dglpi_subcategoria_sistemas` | `ti.d_glpi_subcategoria` | dimensao |
| `ti.dglpi_times` | `ti.d_glpi_time` | dimensao |
| `ti.dorion_demandas` | `ti.d_orion_demanda` | dimensao |
| `ti.dorion_iniciativas` | `ti.d_orion_iniciativa` | dimensao |
| `ti.dorion_map_processos` | `ti.d_orion_mapa_processo` | dimensao |
| `ti.dorion_projetos` | `ti.d_orion_projeto` | dimensao |
| `ti.dsquads` | `ti.d_squad` | dimensao |
| `ti.dsquads_composicao` | `ti.d_squad_composicao` | dimensao |
| `ti.fat_comentarios_glpi` | `ti.f_glpi_comentario` | fato |
| `ti.fglpi_chamados` | `ti.f_glpi_chamado` | fato |
| `ti.forion_demandas` | `ti.f_orion_demanda` | fato |
| `ti.forion_entrega_projetos` | `ti.f_orion_entrega_projeto` | fato |
| `ti.forion_setor_demandas` | `ti.f_orion_setor_demanda` | fato |
| `ti.forion_setor_projetos` | `ti.f_orion_setor_projeto` | fato |
| `ti.forus_atendimento` | `ti.f_orus_atendimento` | fato |
| `ti.forus_desvios_formais` | `ti.f_orus_desvio_formal` | fato |
| `ti.forus_desvios_informais` | `ti.f_orus_desvio_informal` | fato |
| `ti.forus_melhoria` | `ti.f_orus_melhoria` | fato |
| `ti.forus_resumo_sprint` | `ti.f_orus_resumo_sprint` | fato |
| `ti.forus_sprint` | `ti.d_orus_sprint` | dimensao |

---

## Detalhamento por Tabela

---

### ti.ddescricao_prioridade

**Nome proposto:** `ti.d_prioridade`
**Tipo:** dimensao
**Descricao:** Dominio de prioridades de chamados GLPI (1 = muito alto, 5 = muito baixo).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `prioridade_id` | `int4 NOT NULL` | `id_prioridade` | `smallint NOT NULL` | [RENAME] [RETYPE] | Codigo operacional de prioridade; `id_` pois nao e entidade com dimensao separada; `smallint` suficiente |
| `desc_prioridade` | `text NOT NULL` | `ds_prioridade` | `varchar(50) NOT NULL` | [RENAME] [RETYPE] | Descricao da prioridade; limitar tamanho |
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_prioridade UNIQUE (id_prioridade)
```

#### Migracao SQL

```sql
ALTER TABLE ti.ddescricao_prioridade RENAME TO d_prioridade;
ALTER TABLE ti.d_prioridade DROP CONSTRAINT ddescricao_prioridade_pkey;
ALTER TABLE ti.d_prioridade ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_prioridade ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_prioridade ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_prioridade RENAME COLUMN prioridade_id TO id_prioridade;
ALTER TABLE ti.d_prioridade ALTER COLUMN id_prioridade TYPE smallint;
ALTER TABLE ti.d_prioridade RENAME COLUMN desc_prioridade TO ds_prioridade;
ALTER TABLE ti.d_prioridade ALTER COLUMN ds_prioridade TYPE varchar(50);
ALTER TABLE ti.d_prioridade ADD CONSTRAINT uq_d_prioridade UNIQUE (id_prioridade);
CREATE OR REPLACE VIEW ti.ddescricao_prioridade AS SELECT * FROM ti.d_prioridade;
COMMENT ON VIEW ti.ddescricao_prioridade IS 'DEPRECATED 2026-05-05: usar d_prioridade. Sera removido em 2026-08-03.';
```

---

### ti.ddescricao_status

**Nome proposto:** `ti.d_status`
**Tipo:** dimensao
**Descricao:** Dominio de status de chamados GLPI.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `status_id` | `int4 NOT NULL` | `id_status` | `smallint NOT NULL` | [RENAME] [RETYPE] | Codigo operacional; `smallint` suficiente |
| `descricao_status` | `text NOT NULL` | `ds_status` | `varchar(50) NOT NULL` | [RENAME] [RETYPE] | Descricao do status |
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.ddescricao_status RENAME TO d_status;
ALTER TABLE ti.d_status DROP CONSTRAINT ddescricao_status_pkey;
ALTER TABLE ti.d_status ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_status ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_status ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_status RENAME COLUMN status_id TO id_status;
ALTER TABLE ti.d_status ALTER COLUMN id_status TYPE smallint;
ALTER TABLE ti.d_status RENAME COLUMN descricao_status TO ds_status;
ALTER TABLE ti.d_status ALTER COLUMN ds_status TYPE varchar(50);
ALTER TABLE ti.d_status ADD CONSTRAINT uq_d_status UNIQUE (id_status);
CREATE OR REPLACE VIEW ti.ddescricao_status AS SELECT * FROM ti.d_status;
COMMENT ON VIEW ti.ddescricao_status IS 'DEPRECATED 2026-05-05: usar d_status. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_categorias

**Nome proposto:** `ti.d_glpi_categoria`
**Tipo:** dimensao
**Descricao:** Categorias de chamados GLPI com hierarquia (categoria > subcategoria > tipo de sistema).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 NOT NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | Promover a bigserial |
| `itilcategories_id` | `int4 NULL` | `id_categoria_glpi` | `integer` | [RENAME] | ID interno do GLPI |
| `categoria_nome` | `varchar(100) NULL` | `ds_categoria` | `varchar(100)` | [RENAME] | Nome da categoria; prefixo `ds_` |
| `completename` | `varchar(255) NULL` | `ds_categoria_completa` | `varchar(255)` | [RENAME] | Caminho completo da categoria |
| `subcategoria` | `varchar(50) NULL` | `ds_subcategoria` | `varchar(50)` | [RENAME] | Subcategoria |
| `tipo_sistema` | `varchar(50) NULL` | `ds_tipo_sistema` | `varchar(50)` | [RENAME] | Tipo de sistema afetado |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Relacionamentos propostos

```
ti.d_glpi_categoria
  <- ti.f_glpi_chamado.id_categoria  (referencia por convencao)
```

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_categorias RENAME TO d_glpi_categoria;
ALTER TABLE ti.d_glpi_categoria DROP CONSTRAINT dglpi_categorias_pkey;
ALTER TABLE ti.d_glpi_categoria ALTER COLUMN id TYPE bigint USING id::bigint;
ALTER TABLE ti.d_glpi_categoria ADD CONSTRAINT d_glpi_categoria_pkey PRIMARY KEY (id);
ALTER TABLE ti.d_glpi_categoria ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_categoria ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_categoria RENAME COLUMN itilcategories_id TO id_categoria_glpi;
ALTER TABLE ti.d_glpi_categoria RENAME COLUMN categoria_nome TO ds_categoria;
ALTER TABLE ti.d_glpi_categoria RENAME COLUMN completename TO ds_categoria_completa;
ALTER TABLE ti.d_glpi_categoria RENAME COLUMN subcategoria TO ds_subcategoria;
ALTER TABLE ti.d_glpi_categoria RENAME COLUMN tipo_sistema TO ds_tipo_sistema;
CREATE OR REPLACE VIEW ti.dglpi_categorias AS SELECT * FROM ti.d_glpi_categoria;
COMMENT ON VIEW ti.dglpi_categorias IS 'DEPRECATED 2026-05-05: usar d_glpi_categoria. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_estagios

**Nome proposto:** `ti.d_glpi_estagio`
**Tipo:** dimensao
**Descricao:** Estagios do fluxo de atendimento de chamados GLPI por departamento e tecnico responsavel.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | [RETYPE] | Manter identity; renomear para bigserial semanticamente |
| `depto` | `varchar(50) NULL` | `ds_departamento` | `varchar(50)` | [RENAME] | Departamento; prefixo `ds_` |
| `tipo` | `varchar(50) NULL` | `ds_tipo_estagio` | `varchar(50)` | [RENAME] | Tipo do estagio |
| `fase` | `varchar(100) NULL` | `ds_fase` | `varchar(100)` | [RENAME] | Fase do fluxo |
| `etapa` | `varchar(100) NULL` | `ds_etapa` | `varchar(100)` | [RENAME] | Etapa da fase |
| `id_tecnico` | `int4 NULL` | `id_tecnico` | `integer` | OK | Ja usa prefixo correto |
| `tecnico` | `varchar(100) NULL` | `nm_tecnico` | `varchar(100)` | [RENAME] | Nome do tecnico; prefixo `nm_` |
| `responsavel` | `varchar(50) NULL` | `nm_responsavel` | `varchar(50)` | [RENAME] | Nome do responsavel |
| `resp_tecnico` | `varchar(50) NULL` | `nm_resp_tecnico` | `varchar(50)` | [RENAME] | Nome do responsavel tecnico |
| `time` | `varchar(50) NULL` | `ds_time` | `varchar(50)` | [RENAME] | Time de atendimento; remover aspas |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_estagios RENAME TO d_glpi_estagio;
ALTER TABLE ti.d_glpi_estagio ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_estagio ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN depto TO ds_departamento;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN tipo TO ds_tipo_estagio;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN fase TO ds_fase;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN etapa TO ds_etapa;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN tecnico TO nm_tecnico;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN responsavel TO nm_responsavel;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN resp_tecnico TO nm_resp_tecnico;
ALTER TABLE ti.d_glpi_estagio RENAME COLUMN "time" TO ds_time;
CREATE OR REPLACE VIEW ti.dglpi_estagios AS SELECT * FROM ti.d_glpi_estagio;
COMMENT ON VIEW ti.dglpi_estagios IS 'DEPRECATED 2026-05-05: usar d_glpi_estagio. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_filas

**Nome proposto:** `ti.d_glpi_fila`
**Tipo:** dimensao
**Descricao:** Filas de atendimento do GLPI com fase e etapa associadas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id_fila` | `integer` | (manter `id` existente como chave operacional) | Nao tem PK declarada |
| `id` | `int4 NULL` | `id_fila` | `integer` | [RENAME] | Codigo operacional da fila; `id_` |
| `name` | `varchar(255) NULL` | `nm_fila` | `varchar(255)` | [RENAME] | Nome da fila; remover aspas |
| `comment` | `text NULL` | `obs_fila` | `text` | [RENAME] | Observacao; remover aspas |
| `fase` | `varchar(255) NULL` | `ds_fase` | `varchar(255)` | [RENAME] | Fase |
| `etapa` | `varchar(255) NULL` | `ds_etapa` | `varchar(255)` | [RENAME] | Etapa |
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_filas RENAME TO d_glpi_fila;
ALTER TABLE ti.d_glpi_fila RENAME COLUMN id TO id_fila;
ALTER TABLE ti.d_glpi_fila ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_glpi_fila ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_fila ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_fila RENAME COLUMN "name" TO nm_fila;
ALTER TABLE ti.d_glpi_fila RENAME COLUMN "comment" TO obs_fila;
ALTER TABLE ti.d_glpi_fila RENAME COLUMN fase TO ds_fase;
ALTER TABLE ti.d_glpi_fila RENAME COLUMN etapa TO ds_etapa;
CREATE OR REPLACE VIEW ti.dglpi_filas AS SELECT * FROM ti.d_glpi_fila;
COMMENT ON VIEW ti.dglpi_filas IS 'DEPRECATED 2026-05-05: usar d_glpi_fila. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_grupos

**Nome proposto:** `ti.d_glpi_grupo`
**Tipo:** dimensao
**Descricao:** Grupos de solicitantes e tecnicos do GLPI com hierarquia departamental.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `id` | `int8 NULL` | `id_grupo_glpi` | `bigint` | [RENAME] | ID operacional do grupo no GLPI |
| `groups_id` | `int8 NULL` | `id_grupo_pai` | `bigint` | [RENAME] | ID do grupo pai (hierarquia) |
| `completename` | `text NULL` | `ds_grupo_completo` | `text` | [RENAME] | Nome completo com hierarquia |
| `area` | `text NULL` | `ds_area` | `varchar(100)` | [RENAME] [RETYPE] | Area; limitar tamanho |
| `departamento` | `text NULL` | `ds_departamento` | `varchar(100)` | [RENAME] [RETYPE] | Departamento |
| `setor` | `text NULL` | `ds_setor` | `varchar(100)` | [RENAME] [RETYPE] | Setor |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_grupos RENAME TO d_glpi_grupo;
ALTER TABLE ti.d_glpi_grupo RENAME COLUMN id TO id_grupo_glpi;
ALTER TABLE ti.d_glpi_grupo RENAME COLUMN groups_id TO id_grupo_pai;
ALTER TABLE ti.d_glpi_grupo ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_glpi_grupo ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_grupo ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_grupo RENAME COLUMN completename TO ds_grupo_completo;
ALTER TABLE ti.d_glpi_grupo RENAME COLUMN area TO ds_area;
ALTER TABLE ti.d_glpi_grupo ALTER COLUMN ds_area TYPE varchar(100);
ALTER TABLE ti.d_glpi_grupo RENAME COLUMN departamento TO ds_departamento;
ALTER TABLE ti.d_glpi_grupo ALTER COLUMN ds_departamento TYPE varchar(100);
ALTER TABLE ti.d_glpi_grupo RENAME COLUMN setor TO ds_setor;
ALTER TABLE ti.d_glpi_grupo ALTER COLUMN ds_setor TYPE varchar(100);
CREATE OR REPLACE VIEW ti.dglpi_grupos AS SELECT * FROM ti.d_glpi_grupo;
COMMENT ON VIEW ti.dglpi_grupos IS 'DEPRECATED 2026-05-05: usar d_glpi_grupo. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_sistemas

**Nome proposto:** `ti.d_glpi_sistema`
**Tipo:** dimensao
**Descricao:** Sistemas catalogados no GLPI para categorizacao de chamados.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `sistemas_id` | `int4 NOT NULL` | `id` | `bigserial NOT NULL` | [RENAME] [RETYPE] | Renomear PK para `id` padrao |
| `sistema` | `varchar(255) NOT NULL` | `nm_sistema` | `varchar(255) NOT NULL` | [RENAME] | Nome do sistema |
| `categoria` | `varchar(255) NOT NULL` | `ds_categoria` | `varchar(255) NOT NULL` | [RENAME] | Categoria do sistema |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_sistemas RENAME TO d_glpi_sistema;
ALTER TABLE ti.d_glpi_sistema DROP CONSTRAINT sistemas_glpi_pkey;
ALTER TABLE ti.d_glpi_sistema ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_glpi_sistema ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_sistema ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_sistema RENAME COLUMN sistema TO nm_sistema;
ALTER TABLE ti.d_glpi_sistema RENAME COLUMN categoria TO ds_categoria;
-- Manter sistemas_id como id_sistema para rastreabilidade
ALTER TABLE ti.d_glpi_sistema RENAME COLUMN sistemas_id TO id_sistema;
ALTER TABLE ti.d_glpi_sistema ADD CONSTRAINT uq_d_glpi_sistema UNIQUE (id_sistema);
CREATE OR REPLACE VIEW ti.dglpi_sistemas AS SELECT * FROM ti.d_glpi_sistema;
COMMENT ON VIEW ti.dglpi_sistemas IS 'DEPRECATED 2026-05-05: usar d_glpi_sistema. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_sla

**Nome proposto:** `ti.d_glpi_sla`
**Tipo:** dimensao
**Descricao:** SLAs definidos por tipo de chamado, categoria e estagio. Define o prazo esperado de resolucao em horas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | OK | Manter PK |
| `tipo_chamado` | `varchar(20) NULL` | `ds_tipo_chamado` | `varchar(20)` | [RENAME] | Tipo do chamado; `ds_` |
| `categoria` | `varchar(20) NULL` | `ds_categoria` | `varchar(20)` | [RENAME] | Categoria do chamado |
| `estagio` | `varchar(50) NULL` | `ds_estagio` | `varchar(50)` | [RENAME] | Estagio de aplicacao do SLA |
| `sla` | `int4 NULL` | `nr_sla_horas` | `integer` | [RENAME] | Prazo do SLA em horas |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_sla RENAME TO d_glpi_sla;
ALTER TABLE ti.d_glpi_sla ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_sla ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_sla RENAME COLUMN tipo_chamado TO ds_tipo_chamado;
ALTER TABLE ti.d_glpi_sla RENAME COLUMN categoria TO ds_categoria;
ALTER TABLE ti.d_glpi_sla RENAME COLUMN estagio TO ds_estagio;
ALTER TABLE ti.d_glpi_sla RENAME COLUMN sla TO nr_sla_horas;
CREATE OR REPLACE VIEW ti.dglpi_sla AS SELECT * FROM ti.d_glpi_sla;
COMMENT ON VIEW ti.dglpi_sla IS 'DEPRECATED 2026-05-05: usar d_glpi_sla. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_subcategoria_sistemas

**Nome proposto:** `ti.d_glpi_subcategoria`
**Tipo:** dimensao
**Descricao:** Subcategorias dos sistemas GLPI, vinculadas a `d_glpi_sistema`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `sub_categoria_id` | `int4 NOT NULL` | `id` | `bigserial NOT NULL` | [RENAME] [RETYPE] | Renomear PK para padrao `id` |
| `subcategoria_desc` | `varchar(255) NOT NULL` | `ds_subcategoria` | `varchar(255) NOT NULL` | [RENAME] | Descricao da subcategoria |
| `categoria_id` | `int4 NOT NULL` | `id_sistema` | `integer NOT NULL` | [RENAME] | FK para `d_glpi_sistema.id_sistema` |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Relacionamentos propostos

```
ti.d_glpi_subcategoria
  |- id_sistema -> ti.d_glpi_sistema.id_sistema
```

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_subcategoria_sistemas RENAME TO d_glpi_subcategoria;
ALTER TABLE ti.d_glpi_subcategoria DROP CONSTRAINT dim_subcategoria_sistemas_glpi_pkey;
ALTER TABLE ti.d_glpi_subcategoria ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_glpi_subcategoria ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_subcategoria ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_subcategoria RENAME COLUMN subcategoria_desc TO ds_subcategoria;
ALTER TABLE ti.d_glpi_subcategoria RENAME COLUMN categoria_id TO id_sistema;
ALTER TABLE ti.d_glpi_subcategoria RENAME COLUMN sub_categoria_id TO id_subcategoria;
ALTER TABLE ti.d_glpi_subcategoria ADD CONSTRAINT uq_d_glpi_subcategoria UNIQUE (id_subcategoria);
CREATE OR REPLACE VIEW ti.dglpi_subcategoria_sistemas AS SELECT * FROM ti.d_glpi_subcategoria;
COMMENT ON VIEW ti.dglpi_subcategoria_sistemas IS 'DEPRECATED 2026-05-05: usar d_glpi_subcategoria. Sera removido em 2026-08-03.';
```

---

### ti.dglpi_times

**Nome proposto:** `ti.d_glpi_time`
**Tipo:** dimensao
**Descricao:** Times de atendimento vinculados a filas GLPI.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | OK | Manter PK |
| `fila_glpi` | `varchar(50) NULL` | `nm_fila` | `varchar(50)` | [RENAME] | Nome da fila; `nm_` |
| `time` | `varchar(50) NULL` | `nm_time` | `varchar(50)` | [RENAME] | Nome do time; remover aspas |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dglpi_times RENAME TO d_glpi_time;
ALTER TABLE ti.d_glpi_time ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_time ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_glpi_time RENAME COLUMN fila_glpi TO nm_fila;
ALTER TABLE ti.d_glpi_time RENAME COLUMN "time" TO nm_time;
CREATE OR REPLACE VIEW ti.dglpi_times AS SELECT * FROM ti.d_glpi_time;
COMMENT ON VIEW ti.dglpi_times IS 'DEPRECATED 2026-05-05: usar d_glpi_time. Sera removido em 2026-08-03.';
```

---

### ti.dorion_demandas

**Nome proposto:** `ti.d_orion_demanda`
**Tipo:** dimensao
**Descricao:** Demandas do sistema Orion (gestao de projetos/backlog) com titulo, sistema, status e datas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id_demanda` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | [RENAME] | Renomear PK para `id` padrao |
| `titulo` | `varchar(255) NULL` | `ds_titulo` | `varchar(255)` | [RENAME] | Titulo da demanda |
| `sistema` | `varchar(255) NULL` | `nm_sistema` | `varchar(255)` | [RENAME] | Sistema vinculado |
| `data_criacao` | `date NULL` | `dt_criacao` | `date` | [RENAME] | Data de criacao |
| `data_vencimento` | `date NULL` | `dt_vencimento` | `date` | [RENAME] | Data de vencimento |
| `descricao` | `text NULL` | `obs_demanda` | `text` | [RENAME] | Descricao/observacao |
| `tipo` | `varchar(50) NULL` | `ds_tipo` | `varchar(50)` | [RENAME] | Tipo da demanda |
| `coluna` | `int4 NULL` | `id_coluna` | `integer` | [RENAME] | Coluna no kanban |
| `ordem` | `int4 NULL` | `nr_ordem` | `integer` | [RENAME] | Ordem na coluna |
| `chamados` | `_int4 NULL` | `ids_chamados` | `_int4` | OK | Array de IDs de chamados vinculados |
| `prioridade` | `varchar NULL` | `ds_prioridade` | `varchar(20)` | [RENAME] [RETYPE] | Prioridade; limitar tamanho |
| `data_solucao` | `date NULL` | `dt_solucao` | `date` | [RENAME] | Data de solucao |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dorion_demandas RENAME TO d_orion_demanda;
ALTER TABLE ti.d_orion_demanda DROP CONSTRAINT dorion_demandas_pkey;
ALTER TABLE ti.d_orion_demanda ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_orion_demanda ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_demanda ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN id_demanda TO cod_demanda;
ALTER TABLE ti.d_orion_demanda ADD CONSTRAINT uq_d_orion_demanda UNIQUE (cod_demanda);
ALTER TABLE ti.d_orion_demanda RENAME COLUMN titulo TO ds_titulo;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN sistema TO nm_sistema;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN data_criacao TO dt_criacao;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN data_vencimento TO dt_vencimento;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN descricao TO obs_demanda;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN tipo TO ds_tipo;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN coluna TO id_coluna;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN ordem TO nr_ordem;
ALTER TABLE ti.d_orion_demanda RENAME COLUMN prioridade TO ds_prioridade;
ALTER TABLE ti.d_orion_demanda ALTER COLUMN ds_prioridade TYPE varchar(20);
ALTER TABLE ti.d_orion_demanda RENAME COLUMN data_solucao TO dt_solucao;
CREATE OR REPLACE VIEW ti.dorion_demandas AS SELECT * FROM ti.d_orion_demanda;
COMMENT ON VIEW ti.dorion_demandas IS 'DEPRECATED 2026-05-05: usar d_orion_demanda. Sera removido em 2026-08-03.';
```

---

### ti.dorion_iniciativas

**Nome proposto:** `ti.d_orion_iniciativa`
**Tipo:** dimensao
**Descricao:** Iniciativas estrategicas de TI no Orion, com autor e responsavel.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id_iniciativa` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | [RENAME] | PK padrao |
| `titulo` | `varchar(255) NULL` | `ds_titulo` | `varchar(255)` | [RENAME] | Titulo |
| `sistema` | `varchar(255) NULL` | `nm_sistema` | `varchar(255)` | [RENAME] | Sistema |
| `data_criacao` | `date NULL` | `dt_criacao` | `date` | [RENAME] | Data criacao |
| `id_autor` | `int4 NULL` | `id_autor` | `integer` | OK | ID do autor |
| `id_responsavel` | `int4 NULL` | `id_responsavel` | `integer` | OK | ID do responsavel |
| `descricao` | `text NULL` | `obs_iniciativa` | `text` | [RENAME] | Descricao |
| `tipo` | `varchar(50) NULL` | `ds_tipo` | `varchar(50)` | [RENAME] | Tipo |
| `coluna` | `int4 NULL` | `id_coluna` | `integer` | [RENAME] | Coluna kanban |
| `ordem` | `int4 NULL` | `nr_ordem` | `integer` | [RENAME] | Ordem |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.dorion_iniciativas RENAME TO d_orion_iniciativa;
ALTER TABLE ti.d_orion_iniciativa DROP CONSTRAINT dorion_iniciativas_pkey;
ALTER TABLE ti.d_orion_iniciativa ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_orion_iniciativa ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_iniciativa ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN id_iniciativa TO cod_iniciativa;
ALTER TABLE ti.d_orion_iniciativa ADD CONSTRAINT uq_d_orion_iniciativa UNIQUE (cod_iniciativa);
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN titulo TO ds_titulo;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN sistema TO nm_sistema;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN data_criacao TO dt_criacao;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN descricao TO obs_iniciativa;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN tipo TO ds_tipo;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN coluna TO id_coluna;
ALTER TABLE ti.d_orion_iniciativa RENAME COLUMN ordem TO nr_ordem;
CREATE OR REPLACE VIEW ti.dorion_iniciativas AS SELECT * FROM ti.d_orion_iniciativa;
COMMENT ON VIEW ti.dorion_iniciativas IS 'DEPRECATED 2026-05-05: usar d_orion_iniciativa. Sera removido em 2026-08-03.';
```

---

### ti.dorion_map_processos

**Nome proposto:** `ti.d_orion_mapa_processo`
**Tipo:** dimensao
**Descricao:** Mapeamento hierarquico de processos por setor: processo > subprocesso > detalhe.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id_map` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | [RENAME] | PK padrao |
| `setor` | `varchar(50) NULL` | `ds_setor` | `varchar(50)` | [RENAME] | Setor |
| `processo` | `int4 NULL` | `id_processo` | `integer` | [RENAME] | ID do processo |
| `processo_map` | `int4 NULL` | `nr_processo_map` | `integer` | [RENAME] | Numero do processo no mapa |
| `subprocesso` | `int4 NULL` | `id_subprocesso` | `integer` | [RENAME] | ID do subprocesso |
| `subprocesso_map` | `int4 NULL` | `nr_subprocesso_map` | `integer` | [RENAME] | Numero no mapa |
| `detalhe_subprocesso` | `int4 NULL` | `id_detalhe_subprocesso` | `integer` | [RENAME] | Detalhe |
| `detalhe_subprocesso_map` | `int4 NULL` | `nr_detalhe_map` | `integer` | [RENAME] | Numero no mapa |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.dorion_map_processos RENAME TO d_orion_mapa_processo;
ALTER TABLE ti.d_orion_mapa_processo DROP CONSTRAINT dorion_map_processos_pkey;
ALTER TABLE ti.d_orion_mapa_processo ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_orion_mapa_processo ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_mapa_processo ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme tabela acima
CREATE OR REPLACE VIEW ti.dorion_map_processos AS SELECT * FROM ti.d_orion_mapa_processo;
COMMENT ON VIEW ti.dorion_map_processos IS 'DEPRECATED 2026-05-05: usar d_orion_mapa_processo. Sera removido em 2026-08-03.';
```

---

### ti.dorion_projetos

**Nome proposto:** `ti.d_orion_projeto`
**Tipo:** dimensao
**Descricao:** Projetos de TI cadastrados no Orion com descricao, objetivo, pendencias e status.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key (tabela nao tem PK) |
| `id` | `varchar(9) NULL` | `cod_projeto` | `varchar(9)` | [RENAME] | Codigo do projeto; `cod_` para join key |
| `cod_projeto` | `varchar(9) NULL` | `nr_codigo_externo` | `varchar(9)` | [RENAME] | Codigo externo/legado; verificar se e igual a `cod_projeto` |
| `data_criacao` | `timestamp NULL` | `dth_criacao` | `timestamp` | [RENAME] | Data/hora de criacao |
| `origem_projeto` | `varchar(150) NULL` | `ds_origem` | `varchar(150)` | [RENAME] | Origem do projeto |
| `descricao` | `varchar(400) NULL` | `ds_projeto` | `varchar(400)` | [RENAME] | Descricao |
| `descricao_problema` | `varchar(4000) NULL` | `obs_problema` | `varchar(4000)` | [RENAME] | Descricao do problema |
| `objetivo_projeto` | `varchar(4000) NULL` | `obs_objetivo` | `varchar(4000)` | [RENAME] | Objetivo |
| `pendencias` | `varchar(4000) NULL` | `obs_pendencias` | `varchar(4000)` | [RENAME] | Pendencias |
| `acao_em_andamento` | `varchar(4000) NULL` | `obs_acao_andamento` | `varchar(4000)` | [RENAME] | Acoes em andamento |
| `proximas_acoes` | `varchar(4000) NULL` | `obs_proximas_acoes` | `varchar(4000)` | [RENAME] | Proximas acoes |
| `status` | `varchar(50) NULL` | `ds_status` | `varchar(50)` | [RENAME] | Status do projeto |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

> **Decisao pendente:** As colunas `id` e `cod_projeto` parecem conter o mesmo valor. Verificar e consolidar em `cod_projeto`.

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.dorion_projetos RENAME TO d_orion_projeto;
ALTER TABLE ti.d_orion_projeto ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_orion_projeto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_projeto ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orion_projeto RENAME COLUMN id TO cod_projeto;
ALTER TABLE ti.d_orion_projeto ADD CONSTRAINT uq_d_orion_projeto UNIQUE (cod_projeto);
ALTER TABLE ti.d_orion_projeto RENAME COLUMN data_criacao TO dth_criacao;
-- Renomear demais colunas conforme tabela acima
CREATE OR REPLACE VIEW ti.dorion_projetos AS SELECT * FROM ti.d_orion_projeto;
COMMENT ON VIEW ti.dorion_projetos IS 'DEPRECATED 2026-05-05: usar d_orion_projeto. Sera removido em 2026-08-03.';
```

---

### ti.dsquads

**Nome proposto:** `ti.d_squad`
**Tipo:** dimensao
**Descricao:** Squads de TI com responsavel e icone.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `squad_id` | `int4 NOT NULL` | `id` | `bigserial NOT NULL` | [RENAME] | PK padrao |
| `squad_name` | `varchar NULL` | `nm_squad` | `varchar(100)` | [RENAME] [RETYPE] | Nome do squad |
| `responsavel` | `varchar NULL` | `nm_responsavel` | `varchar(100)` | [RENAME] [RETYPE] | Responsavel |
| `backlog` | `int4 NULL` | `qt_backlog` | `integer` | [RENAME] | Quantidade no backlog |
| `icone` | `varchar(50) NULL` | `ds_icone` | `varchar(50)` | [RENAME] | Icone do squad |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dsquads RENAME TO d_squad;
ALTER TABLE ti.d_squad DROP CONSTRAINT squad_pk;
ALTER TABLE ti.d_squad ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_squad ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_squad ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_squad RENAME COLUMN squad_id TO id_squad;
ALTER TABLE ti.d_squad ADD CONSTRAINT uq_d_squad UNIQUE (id_squad);
ALTER TABLE ti.d_squad RENAME COLUMN squad_name TO nm_squad;
ALTER TABLE ti.d_squad ALTER COLUMN nm_squad TYPE varchar(100);
ALTER TABLE ti.d_squad RENAME COLUMN responsavel TO nm_responsavel;
ALTER TABLE ti.d_squad ALTER COLUMN nm_responsavel TYPE varchar(100);
ALTER TABLE ti.d_squad RENAME COLUMN backlog TO qt_backlog;
ALTER TABLE ti.d_squad RENAME COLUMN icone TO ds_icone;
CREATE OR REPLACE VIEW ti.dsquads AS SELECT * FROM ti.d_squad;
COMMENT ON VIEW ti.dsquads IS 'DEPRECATED 2026-05-05: usar d_squad. Sera removido em 2026-08-03.';
```

---

### ti.dsquads_composicao

**Nome proposto:** `ti.d_squad_composicao`
**Tipo:** dimensao
**Descricao:** Composicao dos squads — membros vinculados a cada squad com id do analista.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 NOT NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | PK |
| `nome` | `varchar NULL` | `nm_membro` | `varchar(100)` | [RENAME] [RETYPE] | Nome do membro |
| `squad_id` | `int4 NULL` | `id_squad` | `integer` | OK | FK para `d_squad.id_squad` |
| `analista_id` | `int4 NULL` | `id_analista` | `integer` | OK | ID do analista |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.dsquads_composicao RENAME TO d_squad_composicao;
ALTER TABLE ti.d_squad_composicao ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_squad_composicao ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_squad_composicao RENAME COLUMN nome TO nm_membro;
ALTER TABLE ti.d_squad_composicao ALTER COLUMN nm_membro TYPE varchar(100);
CREATE OR REPLACE VIEW ti.dsquads_composicao AS SELECT * FROM ti.d_squad_composicao;
COMMENT ON VIEW ti.dsquads_composicao IS 'DEPRECATED 2026-05-05: usar d_squad_composicao. Sera removido em 2026-08-03.';
```

---

### ti.fat_comentarios_glpi

**Nome proposto:** `ti.f_glpi_comentario`
**Tipo:** fato
**Descricao:** Ultimo comentario/post por chamado GLPI. Um registro por chamado com o texto e usuario do ultimo post.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `chamado_id` | `int4 NOT NULL` | `id_chamado` | `integer NOT NULL` | [RENAME] | FK para `f_glpi_chamado`; manter como chave natural por ser 1:1 com chamado |
| `titulo_chamado` | `varchar(500) NULL` | `ds_titulo_chamado` | `varchar(500)` | [RENAME] | Titulo do chamado |
| `data_ultimo_post` | `timestamp NULL` | `dth_ultimo_post` | `timestamp` | [RENAME] | Data/hora do ultimo post |
| `post_texto` | `text NULL` | `obs_post` | `text` | [RENAME] | Texto do post; `obs_` para texto livre |
| `user_post` | `varchar(200) NULL` | `nm_usuario_post` | `varchar(200)` | [RENAME] | Usuario que fez o post |
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Relacionamentos propostos

```
ti.f_glpi_comentario
  |- id_chamado -> ti.f_glpi_chamado.id_chamado
```

#### Migracao SQL

```sql
ALTER TABLE ti.fat_comentarios_glpi RENAME TO f_glpi_comentario;
ALTER TABLE ti.f_glpi_comentario DROP CONSTRAINT fat_comentarios_glpi_pkey;
ALTER TABLE ti.f_glpi_comentario ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.f_glpi_comentario ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_glpi_comentario ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_glpi_comentario RENAME COLUMN chamado_id TO id_chamado;
ALTER TABLE ti.f_glpi_comentario RENAME COLUMN titulo_chamado TO ds_titulo_chamado;
ALTER TABLE ti.f_glpi_comentario RENAME COLUMN data_ultimo_post TO dth_ultimo_post;
ALTER TABLE ti.f_glpi_comentario RENAME COLUMN post_texto TO obs_post;
ALTER TABLE ti.f_glpi_comentario RENAME COLUMN user_post TO nm_usuario_post;
CREATE OR REPLACE VIEW ti.fat_comentarios_glpi AS SELECT * FROM ti.f_glpi_comentario;
COMMENT ON VIEW ti.fat_comentarios_glpi IS 'DEPRECATED 2026-05-05: usar f_glpi_comentario. Sera removido em 2026-08-03.';
```

---

### ti.fglpi_chamados

**Nome proposto:** `ti.f_glpi_chamado`
**Tipo:** fato
**Descricao:** Chamados de suporte registrados no GLPI, com SLA, prioridade, tecnico, solicitante e metricas de resolucao.
**Sistema de origem:** GLPI (sistema de chamados de TI)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 NOT NULL` | `id_chamado` | `integer NOT NULL` | [RENAME] | Manter como chave de negocio; adicionar surrogate separado |
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key DW |
| `date` | `timestamp NULL` | `dth_abertura` | `timestamp` | [RENAME] | Data/hora de abertura; remover aspas |
| `closedate` | `timestamp NULL` | `dth_fechamento` | `timestamp` | [RENAME] | Data/hora de fechamento |
| `solvedate` | `timestamp NULL` | `dth_solucao` | `timestamp` | [RENAME] | Data/hora de solucao |
| `tempo_para_solucao` | `timestamp NULL` | `dth_prazo_solucao` | `timestamp` | [RENAME] | Prazo para solucao (SLA) |
| `status` | `int4 NULL` | `id_status` | `integer` | [RENAME] | FK para `d_status.id_status` |
| `slas_id_tto` | `int4 NULL` | `id_sla_tto` | `integer` | [RENAME] | SLA time-to-own |
| `slas_id_ttr` | `int4 NULL` | `id_sla_ttr` | `integer` | [RENAME] | SLA time-to-resolve |
| `sla_waiting_duration` | `int4 NULL` | `nr_sla_espera_min` | `integer` | [RENAME] | Tempo de espera em minutos |
| `priority` | `int4 NULL` | `id_prioridade` | `integer` | [RENAME] | FK para `d_prioridade.id_prioridade` |
| `id_solicitante` | `int4 NULL` | `id_solicitante` | `integer` | OK | ID do solicitante |
| `urgencia` | `int4 NULL` | `id_urgencia` | `integer` | [RENAME] | Nivel de urgencia |
| `tipo_prioridade` | `varchar(50) NULL` | `ds_tipo_prioridade` | `varchar(50)` | [RENAME] | Descricao da prioridade |
| `impacto` | `int4 NULL` | `id_impacto` | `integer` | [RENAME] | Nivel de impacto |
| `prioridade_cs` | `float8 NULL` | `vl_prioridade_cs` | `numeric(5,2)` | [RENAME] [RETYPE] | Score de prioridade CS |
| `gut` | `int4 NULL` | `vl_gut` | `integer` | [RENAME] | Score GUT |
| `categoria_id` | `int4 NULL` | `id_categoria` | `integer` | [RENAME] | FK para `d_glpi_categoria` |
| `categoria` | `varchar(50) NULL` | `ds_categoria` | `varchar(50)` | [RENAME] | Descricao da categoria |
| `id_tecnico` | `int4 NULL` | `id_tecnico` | `integer` | OK | ID do tecnico responsavel |
| `tecnico` | `varchar(50) NULL` | `nm_tecnico` | `varchar(50)` | [RENAME] | Nome do tecnico |
| `solicitante` | `varchar(50) NULL` | `nm_solicitante` | `varchar(50)` | [RENAME] | Nome do solicitante |
| `titulo` | `varchar(255) NULL` | `ds_titulo` | `varchar(255)` | [RENAME] | Titulo do chamado |
| `horas_resolucao` | `float8 NULL` | `vl_horas_resolucao` | `numeric(10,2)` | [RENAME] [RETYPE] | Horas para resolucao |
| `horas_solucao` | `float8 NULL` | `vl_horas_solucao` | `numeric(10,2)` | [RENAME] [RETYPE] | Horas para solucao |
| `sla_esperado` | `int4 NULL` | `nr_sla_esperado_horas` | `integer` | [RENAME] | SLA esperado em horas |
| `sla` | `varchar(20) NULL` | `ds_sla_status` | `varchar(20)` | [RENAME] | Status do SLA (dentro/fora) |
| `nota_survey` | `int4 NULL` | `vl_nota_survey` | `integer` | [RENAME] | Nota da pesquisa de satisfacao |
| `comentario_survey` | `text NULL` | `obs_survey` | `text` | [RENAME] | Comentario da pesquisa |
| `data_survey` | `timestamp NULL` | `dth_survey` | `timestamp` | [RENAME] | Data da pesquisa |
| `link_chamado` | `varchar(255) NULL` | `ds_link_chamado` | `varchar(255)` | [RENAME] | Link do chamado no GLPI |
| `tipo_chamado` | `varchar(50) NULL` | `ds_tipo_chamado` | `varchar(50)` | [RENAME] | Tipo do chamado |
| `id_grupo_solicitante` | `varchar(7) NULL` | `id_grupo_solicitante` | `varchar(7)` | OK | ID do grupo solicitante |
| `sprint` | `int8 NULL` | `id_sprint` | `bigint` | [RENAME] | ID da sprint vinculada |
| `valor_orcamento` | `numeric(15,3) NULL` | `vl_orcamento` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor do orcamento |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Relacionamentos propostos

```
ti.f_glpi_chamado
  |- id_status      -> ti.d_status.id_status
  |- id_prioridade  -> ti.d_prioridade.id_prioridade
  |- id_categoria   -> ti.d_glpi_categoria.id (ou id_categoria_glpi)
  |- id_sprint      -> ti.d_orus_sprint.id_sprint
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_glpi_chamado_status ON ti.f_glpi_chamado (id_status);
CREATE INDEX idx_f_glpi_chamado_prioridade ON ti.f_glpi_chamado (id_prioridade);
CREATE INDEX idx_f_glpi_chamado_abertura ON ti.f_glpi_chamado (dth_abertura);
CREATE INDEX idx_f_glpi_chamado_tecnico ON ti.f_glpi_chamado (id_tecnico);
```

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.fglpi_chamados RENAME TO f_glpi_chamado;
ALTER TABLE ti.f_glpi_chamado DROP CONSTRAINT fglpi_chamados_pkey;
ALTER TABLE ti.f_glpi_chamado RENAME COLUMN id TO id_chamado;
ALTER TABLE ti.f_glpi_chamado ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.f_glpi_chamado ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_glpi_chamado ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_glpi_chamado ADD CONSTRAINT uq_f_glpi_chamado UNIQUE (id_chamado);
-- Renomear demais colunas conforme tabela acima
CREATE OR REPLACE VIEW ti.fglpi_chamados AS SELECT * FROM ti.f_glpi_chamado;
COMMENT ON VIEW ti.fglpi_chamados IS 'DEPRECATED 2026-05-05: usar f_glpi_chamado. Sera removido em 2026-08-03.';
```

---

### ti.forion_demandas

**Nome proposto:** `ti.f_orion_demanda`
**Tipo:** fato
**Descricao:** Registro de demandas por squad e mes no Orion, vinculando chamados e tarefas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 IDENTITY` | `id` | `bigserial NOT NULL` | OK | PK |
| `mes` | `date NULL` | `dt_mes` | `date` | [RENAME] | Mes de referencia; `dt_` |
| `squad_id` | `int4 NULL` | `id_squad` | `integer` | OK | FK para `d_squad` |
| `tipo` | `varchar(20) NULL` | `ds_tipo` | `varchar(20)` | [RENAME] | Tipo |
| `chamado_id` | `int4 NULL` | `id_chamado` | `integer` | [RENAME] | FK para `f_glpi_chamado.id_chamado` |
| `descricao` | `varchar(255) NULL` | `ds_descricao` | `varchar(255)` | [RENAME] | Descricao |
| `comentario` | `varchar(255) NULL` | `obs_comentario` | `varchar(255)` | [RENAME] | Comentario |
| `is_check` | `bool DEFAULT false NULL` | `fl_concluido` | `boolean DEFAULT false` | [RENAME] | Flag de conclusao |
| `ordem` | `int4 DEFAULT 0 NULL` | `nr_ordem` | `integer DEFAULT 0` | [RENAME] | Ordem |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ti.forion_demandas RENAME TO f_orion_demanda;
ALTER TABLE ti.f_orion_demanda ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orion_demanda ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN mes TO dt_mes;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN tipo TO ds_tipo;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN chamado_id TO id_chamado;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN descricao TO ds_descricao;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN comentario TO obs_comentario;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN is_check TO fl_concluido;
ALTER TABLE ti.f_orion_demanda RENAME COLUMN ordem TO nr_ordem;
CREATE OR REPLACE VIEW ti.forion_demandas AS SELECT * FROM ti.f_orion_demanda;
COMMENT ON VIEW ti.forion_demandas IS 'DEPRECATED 2026-05-05: usar f_orion_demanda. Sera removido em 2026-08-03.';
```

---

### ti.forion_entrega_projetos

**Nome proposto:** `ti.f_orion_entrega_projeto`
**Tipo:** fato
**Descricao:** Registro de entregas de projetos por squad e mes.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| `id` (IDENTITY) | `id` | `bigserial NOT NULL` |
| `mes` | `dt_mes` | `date` |
| `squad_id` | `id_squad` | `integer` |
| `tipo` | `ds_tipo` | `varchar(2)` |
| `projeto_id` | `id_projeto` | `integer` |
| `prioridade` | `id_prioridade` | `integer` |
| `comentario` | `obs_comentario` | `varchar(255)` |
| `texto` | `ds_texto` | `varchar(255)` |
| `is_check` | `fl_concluido` | `boolean` |
| `ordem` | `nr_ordem` | `integer` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.forion_entrega_projetos RENAME TO f_orion_entrega_projeto;
ALTER TABLE ti.f_orion_entrega_projeto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orion_entrega_projeto ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme tabela acima
CREATE OR REPLACE VIEW ti.forion_entrega_projetos AS SELECT * FROM ti.f_orion_entrega_projeto;
COMMENT ON VIEW ti.forion_entrega_projetos IS 'DEPRECATED 2026-05-05: usar f_orion_entrega_projeto. Sera removido em 2026-08-03.';
```

---

### ti.forion_setor_demandas

**Nome proposto:** `ti.f_orion_setor_demanda`
**Tipo:** fato
**Descricao:** Demandas associadas a setores da empresa no Orion, com mes de referencia e status de conclusao.

#### Colunas (principais)

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| `id` (serial4) | `id` | PK |
| `tipo` | `ds_tipo` | Tipo |
| `chamado_id` | `id_chamado` | FK para chamado |
| `descricao` | `ds_descricao` | Descricao |
| `comentario` | `obs_comentario` | Comentario |
| `setor_id` | `id_setor` | ID do setor |
| `mes` | `dt_mes` | Mes de referencia |
| `is_check` | `fl_concluido` | Flag |
| `ordem` | `nr_ordem` | Ordem |
| ADD | `created_at` | Auditoria |
| ADD | `updated_at` | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.forion_setor_demandas RENAME TO f_orion_setor_demanda;
ALTER TABLE ti.f_orion_setor_demanda ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orion_setor_demanda ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme tabela acima
CREATE OR REPLACE VIEW ti.forion_setor_demandas AS SELECT * FROM ti.f_orion_setor_demanda;
COMMENT ON VIEW ti.forion_setor_demandas IS 'DEPRECATED 2026-05-05: usar f_orion_setor_demanda. Sera removido em 2026-08-03.';
```

---

### ti.forion_setor_projetos

**Nome proposto:** `ti.f_orion_setor_projeto`
**Tipo:** fato
**Descricao:** Projetos por setor e mes no Orion.

Segue padrao identico a `f_orion_setor_demanda`. Renomear: `projeto_id -> id_projeto`, `is_check -> fl_concluido`, `ordem -> nr_ordem`, `mes -> dt_mes`, `comentario -> obs_comentario`, `texto -> ds_texto`, `prioridade -> id_prioridade`.

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.forion_setor_projetos RENAME TO f_orion_setor_projeto;
ALTER TABLE ti.f_orion_setor_projeto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orion_setor_projeto ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
CREATE OR REPLACE VIEW ti.forion_setor_projetos AS SELECT * FROM ti.f_orion_setor_projeto;
COMMENT ON VIEW ti.forion_setor_projetos IS 'DEPRECATED 2026-05-05: usar f_orion_setor_projeto. Sera removido em 2026-08-03.';
```

---

### ti.forus_atendimento

**Nome proposto:** `ti.f_orus_atendimento`
**Tipo:** fato
**Descricao:** Atendimentos por sprint e dev no sistema Orus, com horas planejadas vs apontadas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key (sem PK) |
| `sprint_id` | `int8 NULL` | `id_sprint` | `bigint` | [RENAME] | FK para `d_orus_sprint` |
| `sprint_number` | `int4 NULL` | `nr_sprint` | `integer` | [RENAME] | Numero da sprint |
| `status_sprint` | `varchar(50) NULL` | `ds_status_sprint` | `varchar(50)` | [RENAME] | Status da sprint |
| `ticket_number` | `int4 NULL` | `nr_ticket` | `integer` | [RENAME] | Numero do ticket |
| `id` | `int4 NULL` | `id_tarefa` | `integer` | [RENAME] | ID da tarefa (conflito com surrogate key — renomear) |
| `created_at` | `timestamp NULL` | `dth_criacao_tarefa` | `timestamp` | [RENAME] | Data criacao da tarefa (diferenciar de `created_at` auditoria) |
| `type` | `varchar(50) NULL` | `ds_tipo` | `varchar(50)` | [RENAME] | Tipo; remover aspas |
| `team` | `varchar(50) NULL` | `nm_time` | `varchar(50)` | [RENAME] | Time |
| `nome_dev` | `varchar(200) NULL` | `nm_dev` | `varchar(200)` | [RENAME] | Nome do desenvolvedor |
| `fase_atual` | `varchar(100) NULL` | `ds_fase_atual` | `varchar(100)` | [RENAME] | Fase atual |
| `planejado` | `int4 NULL` | `qt_planejado` | `integer` | [RENAME] | Qtd planejada |
| `total_concluidas` | `int4 NULL` | `qt_concluidas` | `integer` | [RENAME] | Total concluidas |
| `total_em_aberto` | `int4 NULL` | `qt_em_aberto` | `integer` | [RENAME] | Total em aberto |
| `horas_planejadas` | `numeric(10,2) NULL` | `vl_horas_planejadas` | `numeric(10,2)` | [RENAME] | Horas planejadas |
| `horas_apontadas` | `numeric(10,2) NULL` | `vl_horas_apontadas` | `numeric(10,2)` | [RENAME] | Horas apontadas |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria DW |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria DW |

> **Atencao:** A coluna `created_at` original da API refere-se a criacao da tarefa e deve ser renomeada para `dth_criacao_tarefa` para evitar conflito com a coluna de auditoria DW.

#### Migracao SQL (resumida)

```sql
ALTER TABLE ti.forus_atendimento RENAME TO f_orus_atendimento;
ALTER TABLE ti.f_orus_atendimento RENAME COLUMN id TO id_tarefa;
ALTER TABLE ti.f_orus_atendimento ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.f_orus_atendimento RENAME COLUMN created_at TO dth_criacao_tarefa;
ALTER TABLE ti.f_orus_atendimento ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orus_atendimento ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear demais colunas conforme tabela acima
CREATE OR REPLACE VIEW ti.forus_atendimento AS SELECT * FROM ti.f_orus_atendimento;
COMMENT ON VIEW ti.forus_atendimento IS 'DEPRECATED 2026-05-05: usar f_orus_atendimento. Sera removido em 2026-08-03.';
```

---

### ti.forus_desvios_formais

**Nome proposto:** `ti.f_orus_desvio_formal`
**Tipo:** fato
**Descricao:** Desvios formais de sprint por ticket e dev, com horas apontadas.

#### Colunas (principais)

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| ADD | `id` bigserial | Surrogate key |
| `sprint_id` | `id_sprint` | FK para sprint |
| `sprint_number` | `nr_sprint` | Numero da sprint |
| `status` | `ds_status_sprint` | Status |
| `ticket_number` | `nr_ticket` | Numero ticket |
| `type` | `ds_tipo` | Tipo; remover aspas |
| `team` | `nm_time` | Time |
| `nome_dev` | `nm_dev` | Dev |
| `tipo_desvio` | `ds_tipo_desvio` | Tipo do desvio |
| `horas_apontadas` | `vl_horas_apontadas` | Horas |
| ADD | `created_at` / `updated_at` | Auditoria |

---

### ti.forus_desvios_informais

**Nome proposto:** `ti.f_orus_desvio_informal`
**Tipo:** fato
**Descricao:** Desvios informais de sprint com descricao e horas apontadas.

Segue padrao de `f_orus_desvio_formal`. Adicionar: `id bigserial PK`, renomear `created_at` para `dth_criacao_tarefa`, adicionar auditoria.

---

### ti.forus_melhoria

**Nome proposto:** `ti.f_orus_melhoria`
**Tipo:** fato
**Descricao:** Melhorias de sprint por ticket, dev e time, com horas planejadas vs apontadas.

Segue padrao de `f_orus_atendimento`. Renomear `current_phase_name -> ds_fase_atual`.

---

### ti.forus_resumo_sprint

**Nome proposto:** `ti.f_orus_resumo_sprint`
**Tipo:** fato
**Descricao:** Resumo de sprint com totalizadores por ticket. Tabela com problemas graves de tipo (`numeric(38,10)`, nomes com espacos).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `id` | `numeric(10) NULL` | `id_tarefa` | `integer` | [RENAME] [RETYPE] | ID da tarefa |
| `sprint_number` | `numeric(38) NULL` | `nr_sprint` | `integer` | [RENAME] [RETYPE] | `numeric(38)` inadequado; usar `integer` |
| `status` | `text NULL` | `ds_status_sprint` | `varchar(50)` | [RENAME] [RETYPE] | Status |
| `ticket_number` | `numeric(10) NULL` | `nr_ticket` | `integer` | [RENAME] [RETYPE] | Ticket |
| `team` | `text NULL` | `nm_time` | `varchar(100)` | [RENAME] [RETYPE] | Time |
| `"nome dev"` | `text NULL` | `nm_dev` | `varchar(200)` | [RENAME] [RETYPE] | **CRITICO:** nome com espaco — usar aspas ou renomear urgentemente |
| `current_phase_name` | `text NULL` | `ds_fase_atual` | `varchar(100)` | [RENAME] [RETYPE] | Fase |
| `planejado` | `numeric(38,10) NULL` | `qt_planejado` | `integer` | [RENAME] [RETYPE] | `numeric(38,10)` inadequado |
| `total_concluidas` | `numeric(38,10) NULL` | `qt_concluidas` | `integer` | [RENAME] [RETYPE] | Idem |
| `total_em_aberto` | `numeric(38,10) NULL` | `qt_em_aberto` | `integer` | [RENAME] [RETYPE] | Idem |
| `"horas planejadas"` | `numeric(38,10) NULL` | `vl_horas_planejadas` | `numeric(10,2)` | [RENAME] [RETYPE] | **CRITICO:** nome com espaco |
| `"horas apontadas"` | `numeric(38,10) NULL` | `vl_horas_apontadas` | `numeric(10,2)` | [RENAME] [RETYPE] | **CRITICO:** nome com espaco |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

> **CRITICO:** Tres colunas tem espacos no nome (`"nome dev"`, `"horas planejadas"`, `"horas apontadas"`). Renomear e prioridade alta.

#### Migracao SQL

```sql
ALTER TABLE ti.forus_resumo_sprint RENAME TO f_orus_resumo_sprint;
ALTER TABLE ti.f_orus_resumo_sprint ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.f_orus_resumo_sprint ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orus_resumo_sprint ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN id TO id_tarefa;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN id_tarefa TYPE integer USING id_tarefa::integer;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN sprint_number TO nr_sprint;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN nr_sprint TYPE integer USING nr_sprint::integer;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN status TO ds_status_sprint;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN ds_status_sprint TYPE varchar(50);
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN ticket_number TO nr_ticket;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN nr_ticket TYPE integer USING nr_ticket::integer;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN team TO nm_time;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN nm_time TYPE varchar(100);
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN "nome dev" TO nm_dev;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN nm_dev TYPE varchar(200);
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN current_phase_name TO ds_fase_atual;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN ds_fase_atual TYPE varchar(100);
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN planejado TO qt_planejado;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN qt_planejado TYPE integer USING qt_planejado::integer;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN total_concluidas TO qt_concluidas;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN qt_concluidas TYPE integer USING qt_concluidas::integer;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN total_em_aberto TO qt_em_aberto;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN qt_em_aberto TYPE integer USING qt_em_aberto::integer;
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN "horas planejadas" TO vl_horas_planejadas;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN vl_horas_planejadas TYPE numeric(10,2) USING vl_horas_planejadas::numeric(10,2);
ALTER TABLE ti.f_orus_resumo_sprint RENAME COLUMN "horas apontadas" TO vl_horas_apontadas;
ALTER TABLE ti.f_orus_resumo_sprint ALTER COLUMN vl_horas_apontadas TYPE numeric(10,2) USING vl_horas_apontadas::numeric(10,2);
CREATE OR REPLACE VIEW ti.forus_resumo_sprint AS SELECT * FROM ti.f_orus_resumo_sprint;
COMMENT ON VIEW ti.forus_resumo_sprint IS 'DEPRECATED 2026-05-05: usar f_orus_resumo_sprint. Sera removido em 2026-08-03.';
```

---

### ti.forus_sprint

**Nome proposto:** `ti.d_orus_sprint`
**Tipo:** dimensao
**Descricao:** Sprints do Orus com periodo, status, time e horas disponives/trabalhadas. E dimensao (lookup) para as fatos `f_orus_*`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key DW |
| `id` | `int4 NULL` | `id_sprint` | `integer` | [RENAME] | Codigo operacional da sprint |
| `sprint_number` | `int4 NULL` | `nr_sprint` | `integer` | [RENAME] | Numero da sprint |
| `active` | `int4 NULL` | `fl_ativa` | `boolean` | [RENAME] [RETYPE] | Flag de sprint ativa; converter para boolean |
| `name` | `varchar(150) NULL` | `nm_sprint` | `varchar(150)` | [RENAME] | Nome da sprint; remover aspas |
| `description` | `text NULL` | `obs_sprint` | `text` | [RENAME] | Descricao |
| `start_date` | `date NULL` | `dt_inicio` | `date` | [RENAME] | Data de inicio |
| `end_date` | `date NULL` | `dt_fim` | `date` | [RENAME] | Data de fim |
| `status` | `varchar(50) NULL` | `ds_status` | `varchar(50)` | [RENAME] | Status |
| `team` | `varchar(50) NULL` | `nm_time` | `varchar(50)` | [RENAME] | Time; remover aspas |
| `available_hours` | `numeric(10,2) NULL` | `vl_horas_disponiveis` | `numeric(10,2)` | [RENAME] | Horas disponiveis |
| `total_hours` | `numeric(10,2) NULL` | `vl_horas_total` | `numeric(10,2)` | [RENAME] | Total de horas |
| `worked_hours` | `numeric(10,2) NULL` | `vl_horas_trabalhadas` | `numeric(10,2)` | [RENAME] | Horas trabalhadas |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_orus_sprint UNIQUE (id_sprint)
```

#### Migracao SQL

```sql
ALTER TABLE ti.forus_sprint RENAME TO d_orus_sprint;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN id TO id_sprint;
ALTER TABLE ti.d_orus_sprint ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ti.d_orus_sprint ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orus_sprint ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ti.d_orus_sprint ADD CONSTRAINT uq_d_orus_sprint UNIQUE (id_sprint);
ALTER TABLE ti.d_orus_sprint RENAME COLUMN sprint_number TO nr_sprint;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN active TO fl_ativa;
ALTER TABLE ti.d_orus_sprint ALTER COLUMN fl_ativa TYPE boolean USING (active = 1);
ALTER TABLE ti.d_orus_sprint RENAME COLUMN "name" TO nm_sprint;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN description TO obs_sprint;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN start_date TO dt_inicio;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN end_date TO dt_fim;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN status TO ds_status;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN team TO nm_time;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN available_hours TO vl_horas_disponiveis;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN total_hours TO vl_horas_total;
ALTER TABLE ti.d_orus_sprint RENAME COLUMN worked_hours TO vl_horas_trabalhadas;
CREATE OR REPLACE VIEW ti.forus_sprint AS SELECT * FROM ti.d_orus_sprint;
COMMENT ON VIEW ti.forus_sprint IS 'DEPRECATED 2026-05-05: usar d_orus_sprint. Sera removido em 2026-08-03.';
```

---

## Conflitos e Decisoes Pendentes — Schema `ti`

1. **`dorion_projetos.id` vs `cod_projeto`**: As duas colunas parecem ter o mesmo valor. Confirmar se `cod_projeto` e redundante e pode ser removido.
2. **`forus_atendimento.created_at`**: Conflito de nome entre a coluna vinda da API (data de criacao da tarefa) e a coluna de auditoria DW. Proposta: renomear a coluna da API para `dth_criacao_tarefa`.
3. **`forus_resumo_sprint` — nomes com espaco**: Prioridade alta para renomear `"nome dev"`, `"horas planejadas"` e `"horas apontadas"`.
4. **`forus_sprint` classificada como fato ou dimensao?**: A tabela contem atributos de sprint (nome, periodo, time, status) e funciona como lookup para as demais tabelas `forus_*`. Proposta: classificar como `d_orus_sprint`.
