# Dicionario de Dados — Schema `marft`

> **Versao:** 1.0 | **Data:** 2026-05-05
> **Responsavel:** Especialista DW
> **Status:** Rascunho
> **Escopo:** 12 tabelas do schema `marft` — dados de desempenho de producao da fabrica Marft

---

## Sumario

| Tabela atual | Tabela proposta | Tipo | Colunas |
|---|---|---|---|
| `marft.dcelula_parada` | `marft.d_parada_celula` | dimensao | 9 |
| `marft.dfunc_integracao` | `marft.stg_colaborador_integracao` | staging | 10 |
| `marft.dmotivo` | `marft.d_motivo_parada` | dimensao | 6 |
| `marft.doperador_falta` | `marft.d_falta_operador` | dimensao | 9 |
| `marft.doperador_parada` | `marft.d_parada_operador` | dimensao | 11 |
| `marft.dvalores_premio` | `marft.aux_valor_premio` | auxiliar | 7 |
| `marft.fdesempenho_operador_individual` | `marft.f_desempenho_operador_individual` | fato | 12 |
| `marft.fdesempenho_operador_maquina` | `marft.f_desempenho_operador_maquina` | fato | 12 |
| `marft.foperador_status` | `marft.f_operador_status` | fato | 22 |
| `marft.fprod_oper` | `marft.f_producao_operacao` | fato | 23 |
| `marft.fproducao_celula` | `marft.f_producao_celula` | fato | 28 |
| `marft.fproducao_operador` | `marft.f_producao_operador` | fato | 23 |

---

## Convencoes aplicadas

- Prefixos de tabela: `d_` (dimensao), `f_` (fato), `stg_` (staging), `aux_` (lookup/auxiliar).
- Prefixos de coluna conforme BOAS_PRATICAS_DW.md secao 3: `cod_`, `id_`, `nm_`, `ds_`, `dt_`, `dth_`, `qt_`, `vl_`, `pc_`, `fl_`, `nr_`, `obs_`.
- `ultima_atualizacao` → `updated_at timestamp NOT NULL DEFAULT current_timestamp`.
- Surrogate key `id bigserial PRIMARY KEY` adicionada em todas as tabelas que nao sao staging.
- Campos `"data"` e `"DATA"` (apenas data de referencia de turno/celula) → `dt_referencia date`.
- Campos `hora_inicio` / `hora_fim` que registram instante completo permanecem `timestamp` renomeados para `dth_inicio` / `dth_fim`.
- Flags de inteiro (`int2` com valores 0/1) → `boolean`.
- Campos `numeric(38,10)` de metricas → `numeric(15,3)` ou `numeric(7,4)` conforme semantica.
- CPF armazenado como `text` sem padrao → `varchar(12)` com formato `XXXXXXXXX-ZZ`.
- Nomes em UPPER_CASE (ex.: `"DATA"`, `operator_status_id`) → `snake_case` sem aspas.

---

## Tabelas

---

### marft.dcelula_parada

**Nome proposto:** `marft.d_parada_celula`
**Tipo:** dimensao
**Descricao:** Registra as paradas ocorridas em celulas de producao por turno e data, com duracao em minutos e motivo associado. Funciona como dimensao de evento de parada de celula — cada linha e um evento de interrupcao de uma celula especifica em um turno.
**Sistema de origem:** Sistema de gestao de producao Marft (via API/integracao propria).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria conforme boas praticas secao 5 |
| `codigo_celula` | `int4 NULL` | `cod_celula` | `int4 NOT NULL` | RENAME | Remove prefixo proibido `codigo_`; passa a join key canonica de celula |
| `shift` | `int2 NULL` | `id_turno` | `smallint` | RENAME | Codigo operacional de turno; prefixo `id_` correto |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Campo e data de referencia do turno, sem componente horaria relevante; `date` correto |
| `hora_inicio` | `timestamp NULL` | `dth_inicio` | `timestamp` | RENAME | Instante completo de inicio da parada; prefixo `dth_` correto |
| `hora_fim` | `timestamp NULL` | `dth_fim` | `timestamp` | RENAME | Instante completo de fim da parada; prefixo `dth_` correto |
| `detalhes` | `varchar(150) NULL` | `obs_detalhes` | `varchar(150)` | RENAME | Texto livre de observacao; prefixo `obs_` correto |
| `minutos` | `int4 NULL` | `qt_minutos_parada` | `integer` | RENAME | Quantidade de minutos; prefixo `qt_` correto |
| `codigo_motivo` | `int2 NULL` | `cod_motivo` | `smallint` | RENAME | Join key para `d_motivo_parada`; prefixo `cod_` correto |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Coluna de auditoria padrao DW |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural de negocio (sem unicidade garantida na origem): `(cod_celula, id_turno, dt_referencia, dth_inicio)` — recomenda-se constraint UNIQUE composta apos validacao de dados.

#### Relacionamentos propostos

```
marft.d_parada_celula
  |- cod_celula  -> (sem dimensao d_celula declarada no schema marft; join candidato com tabela de celulas do sistema Marft)
  |- cod_motivo  -> marft.d_motivo_parada.cod_motivo
```

#### Indices recomendados

```sql
CREATE INDEX idx_d_parada_celula_cod_celula   ON marft.d_parada_celula(cod_celula);
CREATE INDEX idx_d_parada_celula_cod_motivo   ON marft.d_parada_celula(cod_motivo);
CREATE INDEX idx_d_parada_celula_dt_referencia ON marft.d_parada_celula(dt_referencia);
```

#### Impacto no ETL

- Renomear alias de todas as colunas no DAG de carga do schema marft.
- Converter campo `data` (timestamp) para `date` no pipeline: `pd.to_datetime(df['data']).dt.date`.
- Adicionar logica de `NOT NULL` em `cod_celula` com rejeicao de registros sem celula.
- `updated_at` passa a ser gerenciado pelo banco via `DEFAULT current_timestamp`; remover do INSERT.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.dcelula_parada RENAME TO d_parada_celula;

-- Passo 2: Adicionar surrogate key
ALTER TABLE marft.d_parada_celula
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN codigo_celula TO cod_celula;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN shift TO id_turno;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.d_parada_celula
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN hora_inicio TO dth_inicio;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN hora_fim TO dth_fim;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN detalhes TO obs_detalhes;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN minutos TO qt_minutos_parada;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN codigo_motivo TO cod_motivo;
ALTER TABLE marft.d_parada_celula
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.d_parada_celula
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- Passo 4: View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.dcelula_parada AS
    SELECT * FROM marft.d_parada_celula;
COMMENT ON VIEW marft.dcelula_parada IS
    'DEPRECATED 2026-05-05: usar d_parada_celula. Sera removido em 2026-08-03.';
```

---

### marft.dfunc_integracao

**Nome proposto:** `marft.stg_colaborador_integracao`
**Tipo:** staging
**Descricao:** Tabela de integracao bruta de colaboradores (funcionarios) recebida do sistema de origem (RH/folha de pagamento). Contem dados pessoais e status de vinculo, sem transformacao. Nao possui surrogate key — e staging de passagem para eventual dimensao de colaborador.
**Sistema de origem:** Sistema de RH externo / folha de pagamento (integracao por arquivo ou API).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `empresa` | `varchar(10) NULL` | `id_empresa` | `varchar(10)` | RENAME | Codigo operacional de empresa; `id_` correto (nao e join key de dimensao) |
| `cracha` | `varchar(20) NULL` | `cod_colaborador` | `varchar(20)` | RENAME | Business key do colaborador; join key canonica conforme dicionario de entidades |
| `nome` | `varchar(100) NULL` | `nm_colaborador` | `varchar(100)` | RENAME | Nome completo; prefixo `nm_` correto |
| `admissao` | `timestamp NULL` | `dt_admissao` | `date` | RENAME, RETYPE | Data de admissao sem componente horaria; `date` correto |
| `cpf` | `varchar(20) NULL` | `cpf_colaborador` | `varchar(12)` | RENAME, RETYPE, REFORMAT | CPF deve seguir formato `XXXXXXXXX-ZZ` com tamanho `varchar(12)` |
| `status` | `varchar(20) NULL` | `ds_status` | `varchar(20)` | RENAME | Descricao de status; prefixo `ds_` correto |
| `origem` | `varchar(60) NULL` | `ds_origem` | `varchar(60)` | RENAME | Descricao da origem do registro; prefixo `ds_` correto |
| `dat_nasc` | `timestamp NULL` | `dt_nascimento` | `date` | RENAME, RETYPE | Data de nascimento sem componente horaria; `date` correto |
| `dat_ult_alt` | `timestamp NULL` | `dth_ultima_alteracao` | `timestamp` | RENAME | Instante da ultima alteracao na origem; prefixo `dth_` correto |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Coluna de auditoria padrao DW |

**Flags presentes:** RENAME, RETYPE, REFORMAT

#### Chave primaria proposta

Tabela staging — sem surrogate key. Chave natural candidata: `cod_colaborador` (UNIQUE apos limpeza de duplicatas).

#### Relacionamentos propostos

```
marft.stg_colaborador_integracao
  |- cod_colaborador -> (candidato a join com d_colaborador em schema rh ou ppcp)
```

#### Indices recomendados

```sql
CREATE INDEX idx_stg_colaborador_integracao_cod ON marft.stg_colaborador_integracao(cod_colaborador);
```

#### Impacto no ETL

- Reformatar CPF no pipeline: `XXXXXXXXX-ZZ` (remover pontos, manter traco).
- Converter `admissao`, `dat_nasc` de timestamp para date: `pd.to_datetime(df[col]).dt.date`.
- Validar unicidade de `cod_colaborador` antes da carga.
- Alinhar `id_empresa` com o codigo de empresa usado nos demais schemas.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.dfunc_integracao RENAME TO stg_colaborador_integracao;

-- Passo 2: Renomear colunas
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN empresa TO id_empresa;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN cracha TO cod_colaborador;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN nome TO nm_colaborador;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN admissao TO dt_admissao;
ALTER TABLE marft.stg_colaborador_integracao
    ALTER COLUMN dt_admissao TYPE date USING dt_admissao::date;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN cpf TO cpf_colaborador;
ALTER TABLE marft.stg_colaborador_integracao
    ALTER COLUMN cpf_colaborador TYPE varchar(12);
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN status TO ds_status;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN origem TO ds_origem;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN dat_nasc TO dt_nascimento;
ALTER TABLE marft.stg_colaborador_integracao
    ALTER COLUMN dt_nascimento TYPE date USING dt_nascimento::date;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN dat_ult_alt TO dth_ultima_alteracao;
ALTER TABLE marft.stg_colaborador_integracao RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.stg_colaborador_integracao
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.dfunc_integracao AS
    SELECT * FROM marft.stg_colaborador_integracao;
COMMENT ON VIEW marft.dfunc_integracao IS
    'DEPRECATED 2026-05-05: usar stg_colaborador_integracao. Sera removido em 2026-08-03.';
```

---

### marft.dmotivo

**Nome proposto:** `marft.d_motivo_parada`
**Tipo:** dimensao
**Descricao:** Tabela de dominio (lookup) dos motivos de parada de celula e de operador. Cada linha descreve um tipo de interrupcao com nome, descricao, status de ativo e codigo de integracao com sistema externo.
**Sistema de origem:** Sistema de gestao de producao Marft.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `codigo_motivo` | `int2 NULL` | `cod_motivo` | `smallint NOT NULL` | RENAME | Business key; join key canonica referenciada em `d_parada_celula` e `d_parada_operador` |
| `nome` | `varchar(40) NULL` | `nm_motivo` | `varchar(40)` | RENAME | Nome do motivo; prefixo `nm_` correto |
| `descricao` | `varchar(250) NULL` | `ds_motivo` | `varchar(250)` | RENAME | Descricao longa; prefixo `ds_` correto |
| `active` | `int2 NULL` | `fl_ativo` | `boolean DEFAULT TRUE` | RENAME, RETYPE | Flag booleana; `int2` com 0/1 → `boolean` |
| `integrationcode` | `varchar(10) NULL` | `cod_integracao` | `varchar(10)` | RENAME | Codigo de integracao com sistema externo; sem camelCase |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_motivo_parada_cod UNIQUE (cod_motivo)
```

#### Relacionamentos propostos

```
marft.d_motivo_parada e referenciada por:
  |- marft.d_parada_celula.cod_motivo
  |- marft.d_parada_operador.cod_motivo
  |- marft.d_falta_operador.cod_motivo
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_d_motivo_parada_cod ON marft.d_motivo_parada(cod_motivo);
```

#### Impacto no ETL

- Converter `active` (int2: 0/1) para boolean no pipeline: `df['active'].astype(bool)`.
- Garantir UPSERT por `cod_motivo` no DAG (SCD Tipo 1).
- Remover `updated_at` do INSERT — banco aplica default.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.dmotivo RENAME TO d_motivo_parada;

-- Passo 2: Surrogate key
ALTER TABLE marft.d_motivo_parada
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.d_motivo_parada RENAME COLUMN codigo_motivo TO cod_motivo;
ALTER TABLE marft.d_motivo_parada RENAME COLUMN nome TO nm_motivo;
ALTER TABLE marft.d_motivo_parada RENAME COLUMN descricao TO ds_motivo;
ALTER TABLE marft.d_motivo_parada RENAME COLUMN active TO fl_ativo;
ALTER TABLE marft.d_motivo_parada
    ALTER COLUMN fl_ativo TYPE boolean USING (fl_ativo = 1);
ALTER TABLE marft.d_motivo_parada
    ALTER COLUMN fl_ativo SET DEFAULT TRUE;
ALTER TABLE marft.d_motivo_parada RENAME COLUMN integrationcode TO cod_integracao;
ALTER TABLE marft.d_motivo_parada RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.d_motivo_parada
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- Passo 4: Unique constraint
ALTER TABLE marft.d_motivo_parada
    ADD CONSTRAINT uq_d_motivo_parada_cod UNIQUE (cod_motivo);

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.dmotivo AS
    SELECT * FROM marft.d_motivo_parada;
COMMENT ON VIEW marft.dmotivo IS
    'DEPRECATED 2026-05-05: usar d_motivo_parada. Sera removido em 2026-08-03.';
```

---

### marft.doperador_falta

**Nome proposto:** `marft.d_falta_operador`
**Tipo:** dimensao
**Descricao:** Registra as faltas (ausencias) de operadores individuais, com periodo, duracao em minutos e motivo. Cada linha representa um evento de falta de um operador em um dia especifico.
**Sistema de origem:** Sistema de gestao de producao Marft.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria; substitui o campo `id int8` sem garantia de unicidade |
| `id` | `int8 NULL` | `nr_id_origem` | `bigint` | RENAME | ID da origem — preservado para rastreabilidade; nao e surrogate DW |
| `codigo_operador` | `int4 NULL` | `cod_operador` | `int4` | RENAME | Join key canonica de operador |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data da falta sem componente horaria |
| `hora_inicio` | `timestamp NULL` | `dth_inicio` | `timestamp` | RENAME | Instante de inicio da falta |
| `hora_fim` | `timestamp NULL` | `dth_fim` | `timestamp` | RENAME | Instante de fim da falta |
| `detalhes` | `varchar(150) NULL` | `obs_detalhes` | `varchar(150)` | RENAME | Texto livre; prefixo `obs_` correto |
| `minutos` | `int4 NULL` | `qt_minutos_falta` | `integer` | RENAME | Quantidade de minutos de falta |
| `codigo_motivo` | `int2 NULL` | `cod_motivo` | `smallint` | RENAME | Join key para `d_motivo_parada` |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_operador, dt_referencia, dth_inicio)`.

#### Relacionamentos propostos

```
marft.d_falta_operador
  |- cod_operador -> marft.f_operador_status.cod_operador (ou dimensao de operador)
  |- cod_motivo   -> marft.d_motivo_parada.cod_motivo
```

#### Indices recomendados

```sql
CREATE INDEX idx_d_falta_operador_cod_operador  ON marft.d_falta_operador(cod_operador);
CREATE INDEX idx_d_falta_operador_dt_referencia ON marft.d_falta_operador(dt_referencia);
CREATE INDEX idx_d_falta_operador_cod_motivo    ON marft.d_falta_operador(cod_motivo);
```

#### Impacto no ETL

- Renomear campo `id` de origem para `nr_id_origem` — nao conflitar com surrogate key DW.
- Converter `data` timestamp → date no pipeline.
- Validar existencia de `cod_motivo` em `d_motivo_parada` antes da carga.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.doperador_falta RENAME TO d_falta_operador;

-- Passo 2: Renomear id de origem antes de adicionar surrogate
ALTER TABLE marft.d_falta_operador RENAME COLUMN id TO nr_id_origem;

-- Passo 3: Surrogate key
ALTER TABLE marft.d_falta_operador
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 4: Demais colunas
ALTER TABLE marft.d_falta_operador RENAME COLUMN codigo_operador TO cod_operador;
ALTER TABLE marft.d_falta_operador RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.d_falta_operador
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.d_falta_operador RENAME COLUMN hora_inicio TO dth_inicio;
ALTER TABLE marft.d_falta_operador RENAME COLUMN hora_fim TO dth_fim;
ALTER TABLE marft.d_falta_operador RENAME COLUMN detalhes TO obs_detalhes;
ALTER TABLE marft.d_falta_operador RENAME COLUMN minutos TO qt_minutos_falta;
ALTER TABLE marft.d_falta_operador RENAME COLUMN codigo_motivo TO cod_motivo;
ALTER TABLE marft.d_falta_operador RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.d_falta_operador
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.doperador_falta AS
    SELECT * FROM marft.d_falta_operador;
COMMENT ON VIEW marft.doperador_falta IS
    'DEPRECATED 2026-05-05: usar d_falta_operador. Sera removido em 2026-08-03.';
```

---

### marft.doperador_parada

**Nome proposto:** `marft.d_parada_operador`
**Tipo:** dimensao
**Descricao:** Registra paradas individuais de operadores (interrupcoes durante o turno), incluindo motivo, duracao, flags de desconto de tempo e de exclusao do relatorio.
**Sistema de origem:** Sistema de gestao de producao Marft.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria; substitui campo `id int8` da origem |
| `id` | `int8 NULL` | `nr_id_origem` | `bigint` | RENAME | ID da origem preservado para rastreabilidade |
| `codigo_operador` | `int4 NULL` | `cod_operador` | `int4` | RENAME | Join key canonica de operador |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data de referencia da parada |
| `hora_inicio` | `timestamp NULL` | `dth_inicio` | `timestamp` | RENAME | Instante de inicio da parada |
| `hora_fim` | `timestamp NULL` | `dth_fim` | `timestamp` | RENAME | Instante de fim da parada |
| `minutos` | `int4 NULL` | `qt_minutos_parada` | `integer` | RENAME | Duracao da parada em minutos |
| `codigo_motivo` | `int2 NULL` | `cod_motivo` | `smallint` | RENAME | Join key para `d_motivo_parada` |
| `detalhes` | `varchar(150) NULL` | `obs_detalhes` | `varchar(150)` | RENAME | Texto livre da parada |
| `descontar_tempo` | `int2 NULL` | `fl_descontar_tempo` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag: descontar tempo da parada do total disponivel |
| `ignorereport` | `int2 NULL` | `fl_ignorar_relatorio` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag: ignorar parada nos relatorios; snake_case obrigatorio |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_operador, dt_referencia, dth_inicio)`.

#### Relacionamentos propostos

```
marft.d_parada_operador
  |- cod_operador -> marft.f_operador_status.cod_operador
  |- cod_motivo   -> marft.d_motivo_parada.cod_motivo
```

#### Indices recomendados

```sql
CREATE INDEX idx_d_parada_operador_cod_operador  ON marft.d_parada_operador(cod_operador);
CREATE INDEX idx_d_parada_operador_dt_referencia ON marft.d_parada_operador(dt_referencia);
CREATE INDEX idx_d_parada_operador_cod_motivo    ON marft.d_parada_operador(cod_motivo);
```

#### Impacto no ETL

- Converter `descontar_tempo` e `ignorereport` (int2) para boolean.
- Renomear campo `id` de origem para `nr_id_origem` antes de adicionar surrogate.
- Converter `data` timestamp → date.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.doperador_parada RENAME TO d_parada_operador;

-- Passo 2: Renomear id de origem
ALTER TABLE marft.d_parada_operador RENAME COLUMN id TO nr_id_origem;

-- Passo 3: Surrogate key
ALTER TABLE marft.d_parada_operador
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 4: Demais colunas
ALTER TABLE marft.d_parada_operador RENAME COLUMN codigo_operador TO cod_operador;
ALTER TABLE marft.d_parada_operador RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.d_parada_operador
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.d_parada_operador RENAME COLUMN hora_inicio TO dth_inicio;
ALTER TABLE marft.d_parada_operador RENAME COLUMN hora_fim TO dth_fim;
ALTER TABLE marft.d_parada_operador RENAME COLUMN minutos TO qt_minutos_parada;
ALTER TABLE marft.d_parada_operador RENAME COLUMN codigo_motivo TO cod_motivo;
ALTER TABLE marft.d_parada_operador RENAME COLUMN detalhes TO obs_detalhes;
ALTER TABLE marft.d_parada_operador RENAME COLUMN descontar_tempo TO fl_descontar_tempo;
ALTER TABLE marft.d_parada_operador
    ALTER COLUMN fl_descontar_tempo TYPE boolean USING (fl_descontar_tempo = 1);
ALTER TABLE marft.d_parada_operador
    ALTER COLUMN fl_descontar_tempo SET DEFAULT FALSE;
ALTER TABLE marft.d_parada_operador RENAME COLUMN ignorereport TO fl_ignorar_relatorio;
ALTER TABLE marft.d_parada_operador
    ALTER COLUMN fl_ignorar_relatorio TYPE boolean USING (fl_ignorar_relatorio = 1);
ALTER TABLE marft.d_parada_operador
    ALTER COLUMN fl_ignorar_relatorio SET DEFAULT FALSE;
ALTER TABLE marft.d_parada_operador RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.d_parada_operador
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.doperador_parada AS
    SELECT * FROM marft.d_parada_operador;
COMMENT ON VIEW marft.doperador_parada IS
    'DEPRECATED 2026-05-05: usar d_parada_operador. Sera removido em 2026-08-03.';
```

---

### marft.dvalores_premio

**Nome proposto:** `marft.aux_valor_premio`
**Tipo:** auxiliar
**Descricao:** Tabela de lookup que define os valores monetarios dos premios de produtividade por faixa de eficiencia e vigencia temporal. Nao e dimensao principal nem fato — e uma tabela de parametrizacao de regras de negocio.
**Sistema de origem:** Parametrizacao interna do sistema Marft.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `codigo_premio` | `numeric(5) NULL` | `cod_premio` | `integer` | RENAME, RETYPE | Business key do premio; `integer` suficiente para ate 5 digitos; remove prefixo proibido |
| `start_date` | `timestamp NULL` | `dt_inicio_vigencia` | `date` | RENAME, RETYPE | Data de inicio da vigencia da faixa; `date` correto |
| `end_date` | `timestamp NULL` | `dt_fim_vigencia` | `date` | RENAME, RETYPE | Data de fim da vigencia; `date` correto |
| `nome` | `text NULL` | `nm_premio` | `varchar(100)` | RENAME, RETYPE | Nome do premio; `text` aberto substituido por `varchar(100)` com tamanho coerente |
| `efic_min` | `numeric(5,2) NULL` | `pc_eficiencia_minima` | `numeric(7,4)` | RENAME, RETYPE | Percentual de eficiencia minima para o premio; prefixo `pc_` e tipo padrao `numeric(7,4)` |
| `ate` | `numeric(5,2) NULL` | `pc_eficiencia_maxima` | `numeric(7,4)` | RENAME, RETYPE | Limite superior da faixa de eficiencia; nome `ate` e ambiguo |
| `valor` | `numeric(5,2) NULL` | `vl_premio` | `numeric(15,2)` | RENAME, RETYPE | Valor monetario do premio; `numeric(5,2)` limita a R$999,99; expandido para padrao monetario |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_premio, dt_inicio_vigencia)`.

#### Relacionamentos propostos

```
marft.aux_valor_premio
  |- cod_premio -> marft.f_operador_status.cod_premio (codigo do premio associado ao operador no status)
```

#### Indices recomendados

```sql
CREATE INDEX idx_aux_valor_premio_cod_premio     ON marft.aux_valor_premio(cod_premio);
CREATE INDEX idx_aux_valor_premio_dt_inicio      ON marft.aux_valor_premio(dt_inicio_vigencia);
CREATE INDEX idx_aux_valor_premio_dt_fim         ON marft.aux_valor_premio(dt_fim_vigencia);
```

#### Impacto no ETL

- Converter `start_date` / `end_date` (timestamp) → date no pipeline.
- Escalar `efic_min` e `ate` de `numeric(5,2)` para `numeric(7,4)` — verificar se valores estao em percentual (ex.: 85.50) ou decimal (ex.: 0.8550); padronizar no pipeline.
- Ampliar precisao de `vl_premio` para `numeric(15,2)`.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.dvalores_premio RENAME TO aux_valor_premio;

-- Passo 2: Surrogate key
ALTER TABLE marft.aux_valor_premio
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.aux_valor_premio RENAME COLUMN codigo_premio TO cod_premio;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN cod_premio TYPE integer USING cod_premio::integer;
ALTER TABLE marft.aux_valor_premio RENAME COLUMN start_date TO dt_inicio_vigencia;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN dt_inicio_vigencia TYPE date USING dt_inicio_vigencia::date;
ALTER TABLE marft.aux_valor_premio RENAME COLUMN end_date TO dt_fim_vigencia;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN dt_fim_vigencia TYPE date USING dt_fim_vigencia::date;
ALTER TABLE marft.aux_valor_premio RENAME COLUMN nome TO nm_premio;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN nm_premio TYPE varchar(100);
ALTER TABLE marft.aux_valor_premio RENAME COLUMN efic_min TO pc_eficiencia_minima;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN pc_eficiencia_minima TYPE numeric(7,4);
ALTER TABLE marft.aux_valor_premio RENAME COLUMN ate TO pc_eficiencia_maxima;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN pc_eficiencia_maxima TYPE numeric(7,4);
ALTER TABLE marft.aux_valor_premio RENAME COLUMN valor TO vl_premio;
ALTER TABLE marft.aux_valor_premio
    ALTER COLUMN vl_premio TYPE numeric(15,2);

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.dvalores_premio AS
    SELECT * FROM marft.aux_valor_premio;
COMMENT ON VIEW marft.dvalores_premio IS
    'DEPRECATED 2026-05-05: usar aux_valor_premio. Sera removido em 2026-08-03.';
```

---

### marft.fdesempenho_operador_individual

**Nome proposto:** `marft.f_desempenho_operador_individual`
**Tipo:** fato
**Descricao:** Fato de desempenho individual do operador por dia, celula e turno. Contem metricas de tempo disponivel, tempo produzido e eficiencia calculada para cada operador em modo de operacao individual (sem maquina compartilhada).
**Sistema de origem:** Sistema de gestao de producao Marft — modulo de eficiencia individual.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data do desempenho; sem componente horaria |
| `codigo_operador` | `numeric(5) NULL` | `cod_operador` | `integer` | RENAME, RETYPE | Join key canonica de operador; remove prefixo proibido |
| `nome` | `text NULL` | `nm_operador` | `varchar(100)` | RENAME, RETYPE | Nome do operador; desnormalizacao de conveniencia; tamanho explicito |
| `cpf` | `text NULL` | `cpf_colaborador` | `varchar(12)` | RENAME, RETYPE, REFORMAT | CPF no formato padrao DW `XXXXXXXXX-ZZ` |
| `cracha` | `text NULL` | `cod_colaborador` | `varchar(20)` | RENAME, RETYPE | Cracha e business key do colaborador; alinha com `stg_colaborador_integracao` |
| `codigo_celula` | `numeric(5) NULL` | `cod_celula` | `integer` | RENAME, RETYPE | Join key canonica de celula |
| `nome_celula` | `text NULL` | `nm_celula` | `varchar(100)` | RENAME, RETYPE | Nome da celula; desnormalizacao; tamanho explicito |
| `turno` | `numeric(5) NULL` | `id_turno` | `smallint` | RENAME, RETYPE | Codigo operacional de turno |
| `percent` | `numeric(5,4) NULL` | `pc_percentual_tempo` | `numeric(7,4)` | RENAME, RETYPE | Percentual do tempo do operador alocado; nome `percent` e palavra reservada SQL |
| `minutos` | `numeric(38,10) NULL` | `qt_minutos_disponiveis` | `numeric(15,3)` | RENAME, RETYPE | Minutos disponiveis; `numeric(38,10)` superdimensionado |
| `minutos_produzidos` | `numeric(38,10) NULL` | `qt_minutos_produzidos` | `numeric(15,3)` | RENAME, RETYPE | Minutos efetivamente produzidos |
| `eficiencia` | `numeric(38,10) NULL` | `pc_eficiencia` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia calculada como percentual; tipo padrao `numeric(7,4)` |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags presentes:** RENAME, RETYPE, REFORMAT, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_operador, dt_referencia, id_turno, cod_celula)`.

#### Relacionamentos propostos

```
marft.f_desempenho_operador_individual
  |- cod_operador    -> marft.f_operador_status.cod_operador
  |- cod_celula      -> (dimensao de celula — sem tabela declarada no schema marft)
  |- cod_colaborador -> marft.stg_colaborador_integracao.cod_colaborador
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_desempenho_ind_cod_operador  ON marft.f_desempenho_operador_individual(cod_operador);
CREATE INDEX idx_f_desempenho_ind_dt_referencia ON marft.f_desempenho_operador_individual(dt_referencia);
CREATE INDEX idx_f_desempenho_ind_cod_celula    ON marft.f_desempenho_operador_individual(cod_celula);
```

#### Impacto no ETL

- Converter `data` timestamp → date.
- Reduzir precisao de `minutos` e `minutos_produzidos` de `numeric(38,10)` para `numeric(15,3)` — verificar se ha perda de dados.
- Padronizar CPF no pipeline.
- Adicionar `updated_at` no DDL com DEFAULT; nao enviar no INSERT.
- Renomear `"percent"` que e palavra reservada SQL em alguns contextos.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.fdesempenho_operador_individual RENAME TO f_desempenho_operador_individual;

-- Passo 2: Surrogate key
ALTER TABLE marft.f_desempenho_operador_individual
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN codigo_operador TO cod_operador;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN cod_operador TYPE integer USING cod_operador::integer;
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN nome TO nm_operador;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN nm_operador TYPE varchar(100);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN cpf TO cpf_colaborador;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN cpf_colaborador TYPE varchar(12);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN cracha TO cod_colaborador;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN cod_colaborador TYPE varchar(20);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN codigo_celula TO cod_celula;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN cod_celula TYPE integer USING cod_celula::integer;
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN nome_celula TO nm_celula;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN nm_celula TYPE varchar(100);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN turno TO id_turno;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN id_turno TYPE smallint USING id_turno::smallint;
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN "percent" TO pc_percentual_tempo;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN pc_percentual_tempo TYPE numeric(7,4);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN minutos TO qt_minutos_disponiveis;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN qt_minutos_disponiveis TYPE numeric(15,3);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN minutos_produzidos TO qt_minutos_produzidos;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN qt_minutos_produzidos TYPE numeric(15,3);
ALTER TABLE marft.f_desempenho_operador_individual RENAME COLUMN eficiencia TO pc_eficiencia;
ALTER TABLE marft.f_desempenho_operador_individual
    ALTER COLUMN pc_eficiencia TYPE numeric(7,4);

-- Passo 4: Coluna de auditoria
ALTER TABLE marft.f_desempenho_operador_individual
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.fdesempenho_operador_individual AS
    SELECT * FROM marft.f_desempenho_operador_individual;
COMMENT ON VIEW marft.fdesempenho_operador_individual IS
    'DEPRECATED 2026-05-05: usar f_desempenho_operador_individual. Sera removido em 2026-08-03.';
```

---

### marft.fdesempenho_operador_maquina

**Nome proposto:** `marft.f_desempenho_operador_maquina`
**Tipo:** fato
**Descricao:** Fato de desempenho do operador em modo de operacao em maquina compartilhada (celula de producao com equipamento). Estrutura identica a `f_desempenho_operador_individual`, diferenciada pela origem do calculo de eficiencia — considera a carga de maquina e nao somente o tempo individual.
**Sistema de origem:** Sistema de gestao de producao Marft — modulo de eficiencia por maquina.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data do desempenho |
| `codigo_operador` | `numeric(5) NULL` | `cod_operador` | `integer` | RENAME, RETYPE | Join key canonica de operador |
| `nome` | `text NULL` | `nm_operador` | `varchar(100)` | RENAME, RETYPE | Nome do operador; desnormalizacao |
| `cpf` | `text NULL` | `cpf_colaborador` | `varchar(12)` | RENAME, RETYPE, REFORMAT | CPF no formato padrao DW |
| `cracha` | `text NULL` | `cod_colaborador` | `varchar(20)` | RENAME, RETYPE | Cracha como business key do colaborador |
| `codigo_celula` | `numeric(5) NULL` | `cod_celula` | `integer` | RENAME, RETYPE | Join key canonica de celula |
| `nome_celula` | `text NULL` | `nm_celula` | `varchar(100)` | RENAME, RETYPE | Nome da celula; desnormalizacao |
| `turno` | `numeric(5) NULL` | `id_turno` | `smallint` | RENAME, RETYPE | Codigo operacional de turno |
| `percent` | `numeric(5,4) NULL` | `pc_percentual_tempo` | `numeric(7,4)` | RENAME, RETYPE | Percentual de tempo alocado; palavra reservada evitada |
| `minutos` | `numeric(38,10) NULL` | `qt_minutos_disponiveis` | `numeric(15,3)` | RENAME, RETYPE | Minutos disponiveis |
| `minutos_produzidos` | `numeric(38,10) NULL` | `qt_minutos_produzidos` | `numeric(15,3)` | RENAME, RETYPE | Minutos produzidos |
| `eficiencia` | `numeric(38,10) NULL` | `pc_eficiencia` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia por maquina |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Auditoria obrigatoria |

**Flags presentes:** RENAME, RETYPE, REFORMAT, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_operador, dt_referencia, id_turno, cod_celula)`.

#### Relacionamentos propostos

```
marft.f_desempenho_operador_maquina
  |- cod_operador    -> marft.f_operador_status.cod_operador
  |- cod_celula      -> (dimensao de celula externa ao schema marft)
  |- cod_colaborador -> marft.stg_colaborador_integracao.cod_colaborador
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_desempenho_maq_cod_operador  ON marft.f_desempenho_operador_maquina(cod_operador);
CREATE INDEX idx_f_desempenho_maq_dt_referencia ON marft.f_desempenho_operador_maquina(dt_referencia);
CREATE INDEX idx_f_desempenho_maq_cod_celula    ON marft.f_desempenho_operador_maquina(cod_celula);
```

#### Impacto no ETL

- Identico ao da tabela `f_desempenho_operador_individual` — as duas tabelas devem ter o mesmo pipeline de transformacao com parametro de modo (individual vs maquina).
- Verificar se ambas as tabelas podem ser unificadas em uma unica fato com coluna `id_modo_eficiencia` (individual=1, maquina=2) — decisao de modelagem a avaliar com o time.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.fdesempenho_operador_maquina RENAME TO f_desempenho_operador_maquina;

-- Passo 2: Surrogate key
ALTER TABLE marft.f_desempenho_operador_maquina
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar (identico a f_desempenho_operador_individual)
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN codigo_operador TO cod_operador;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN cod_operador TYPE integer USING cod_operador::integer;
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN nome TO nm_operador;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN nm_operador TYPE varchar(100);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN cpf TO cpf_colaborador;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN cpf_colaborador TYPE varchar(12);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN cracha TO cod_colaborador;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN cod_colaborador TYPE varchar(20);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN codigo_celula TO cod_celula;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN cod_celula TYPE integer USING cod_celula::integer;
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN nome_celula TO nm_celula;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN nm_celula TYPE varchar(100);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN turno TO id_turno;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN id_turno TYPE smallint USING id_turno::smallint;
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN "percent" TO pc_percentual_tempo;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN pc_percentual_tempo TYPE numeric(7,4);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN minutos TO qt_minutos_disponiveis;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN qt_minutos_disponiveis TYPE numeric(15,3);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN minutos_produzidos TO qt_minutos_produzidos;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN qt_minutos_produzidos TYPE numeric(15,3);
ALTER TABLE marft.f_desempenho_operador_maquina RENAME COLUMN eficiencia TO pc_eficiencia;
ALTER TABLE marft.f_desempenho_operador_maquina
    ALTER COLUMN pc_eficiencia TYPE numeric(7,4);
ALTER TABLE marft.f_desempenho_operador_maquina
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.fdesempenho_operador_maquina AS
    SELECT * FROM marft.f_desempenho_operador_maquina;
COMMENT ON VIEW marft.fdesempenho_operador_maquina IS
    'DEPRECATED 2026-05-05: usar f_desempenho_operador_maquina. Sera removido em 2026-08-03.';
```

---

### marft.foperador_status

**Nome proposto:** `marft.f_operador_status`
**Tipo:** fato
**Descricao:** Fato que registra o status diario de cada operador na celula: celula designada, turno, funcao, premio, centro de custo, tempo de celula e coeficientes de premio. E a tabela central de alocacao de operadores — referenciada pelas demais fatos de producao e desempenho. Contem o `operator_status_id` como chave de integracao com `fproducao_operador`.
**Sistema de origem:** Sistema de gestao de producao Marft — modulo de alocacao de operadores.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `operator_status_id` | `int8 NULL` | `nr_status_id_origem` | `bigint` | RENAME | ID da origem; passa a `nr_` pois nao e surrogate DW; referenciado em `f_producao_operador` |
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key DW |
| `create_date` | `timestamp NULL` | `dth_criacao_origem` | `timestamp` | RENAME | Data/hora de criacao do status na origem; prefixo `dth_` correto |
| `codigo_operador` | `int4 NULL` | `cod_operador` | `int4` | RENAME | Join key canonica de operador |
| `DATA` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data do status; UPPER_CASE proibido; sem componente horaria |
| `codigo_sit_prof` | `int4 NULL` | `id_situacao_profissional` | `integer` | RENAME | Codigo operacional de situacao profissional; prefixo `id_` correto |
| `codigo_funcao` | `int2 NULL` | `id_funcao` | `smallint` | RENAME | Codigo operacional de funcao; prefixo `id_` correto |
| `codigo_celula` | `int4 NULL` | `cod_celula` | `int4` | RENAME | Join key canonica de celula |
| `shift` | `int2 NULL` | `id_turno` | `smallint` | RENAME | Codigo operacional de turno |
| `codigo_premio` | `int4 NULL` | `cod_premio` | `integer` | RENAME | Join key para `aux_valor_premio`; remove prefixo proibido |
| `cost_center_code` | `int4 NULL` | `id_centro_custo` | `integer` | RENAME | Codigo operacional de centro de custo; snake_case; sem ingles puro |
| `tempo_celula` | `int2 NULL` | `qt_tempo_celula` | `smallint` | RENAME | Tempo alocado na celula; prefixo `qt_` |
| `ativo` | `int2 NULL` | `fl_ativo` | `boolean DEFAULT TRUE` | RENAME, RETYPE | Flag de registro ativo |
| `observacao` | `varchar(250) NULL` | `obs_operador` | `varchar(250)` | RENAME | Observacao livre; prefixo `obs_` correto |
| `codigo_empresa` | `varchar(5) NULL` | `id_empresa` | `varchar(5)` | RENAME | Codigo operacional de empresa |
| `assiduityaward` | `int2 NULL` | `fl_premio_assiduidade` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag de premio por assiduidade; camelCase proibido; int2→boolean |
| `leader` | `int2 NULL` | `fl_lider` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag de operador lider; int2→boolean |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |
| `award_coefficient_i` | `numeric(18,3) NULL` | `pc_coeficiente_premio_individual` | `numeric(7,4)` | RENAME, RETYPE | Coeficiente do premio individual; camelCase proibido; tipo percentual |
| `award_coefficient_c` | `numeric(18,3) NULL` | `pc_coeficiente_premio_celula` | `numeric(7,4)` | RENAME, RETYPE | Coeficiente do premio de celula; camelCase proibido |
| `award_individual_me` | `numeric(18,3) NULL` | `pc_premio_individual_me` | `numeric(7,4)` | RENAME, RETYPE | Percentual de premio individual ME; camelCase proibido |
| `maximumefficiency` | `numeric(18,3) NULL` | `pc_eficiencia_maxima` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia maxima parametrizada; camelCase proibido |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_operador, dt_referencia, id_turno, cod_celula)`.

#### Relacionamentos propostos

```
marft.f_operador_status
  |- cod_operador -> (dimensao de colaborador — rh schema ou stg_colaborador_integracao)
  |- cod_celula   -> (dimensao de celula externa)
  |- cod_premio   -> marft.aux_valor_premio.cod_premio
  |- nr_status_id_origem -> marft.f_producao_operador.nr_status_id_origem (join de rastreabilidade)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_operador_status_cod_operador  ON marft.f_operador_status(cod_operador);
CREATE INDEX idx_f_operador_status_dt_referencia ON marft.f_operador_status(dt_referencia);
CREATE INDEX idx_f_operador_status_cod_celula    ON marft.f_operador_status(cod_celula);
CREATE INDEX idx_f_operador_status_nr_status_id  ON marft.f_operador_status(nr_status_id_origem);
```

#### Impacto no ETL

- Renomear `operator_status_id` para `nr_status_id_origem` — atualizar DAG de `f_producao_operador` que referencia este campo.
- Converter `DATA` (UPPER_CASE com aspas) → remover aspas e retipar para date.
- Converter flags `ativo`, `assiduityaward`, `leader` de int2 para boolean.
- Converter campos `award_*` e `maximumefficiency` de `numeric(18,3)` para `numeric(7,4)` — verificar escala (decimal ou percentual absoluto).

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.foperador_status RENAME TO f_operador_status;

-- Passo 2: Renomear operator_status_id antes de adicionar surrogate
ALTER TABLE marft.f_operador_status RENAME COLUMN operator_status_id TO nr_status_id_origem;

-- Passo 3: Surrogate key
ALTER TABLE marft.f_operador_status
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 4: Demais colunas
ALTER TABLE marft.f_operador_status RENAME COLUMN create_date TO dth_criacao_origem;
ALTER TABLE marft.f_operador_status RENAME COLUMN codigo_operador TO cod_operador;
ALTER TABLE marft.f_operador_status RENAME COLUMN "DATA" TO dt_referencia;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.f_operador_status RENAME COLUMN codigo_sit_prof TO id_situacao_profissional;
ALTER TABLE marft.f_operador_status RENAME COLUMN codigo_funcao TO id_funcao;
ALTER TABLE marft.f_operador_status RENAME COLUMN codigo_celula TO cod_celula;
ALTER TABLE marft.f_operador_status RENAME COLUMN shift TO id_turno;
ALTER TABLE marft.f_operador_status RENAME COLUMN codigo_premio TO cod_premio;
ALTER TABLE marft.f_operador_status RENAME COLUMN cost_center_code TO id_centro_custo;
ALTER TABLE marft.f_operador_status RENAME COLUMN tempo_celula TO qt_tempo_celula;
ALTER TABLE marft.f_operador_status RENAME COLUMN ativo TO fl_ativo;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN fl_ativo TYPE boolean USING (fl_ativo = 1);
ALTER TABLE marft.f_operador_status ALTER COLUMN fl_ativo SET DEFAULT TRUE;
ALTER TABLE marft.f_operador_status RENAME COLUMN observacao TO obs_operador;
ALTER TABLE marft.f_operador_status RENAME COLUMN codigo_empresa TO id_empresa;
ALTER TABLE marft.f_operador_status RENAME COLUMN assiduityaward TO fl_premio_assiduidade;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN fl_premio_assiduidade TYPE boolean USING (fl_premio_assiduidade = 1);
ALTER TABLE marft.f_operador_status ALTER COLUMN fl_premio_assiduidade SET DEFAULT FALSE;
ALTER TABLE marft.f_operador_status RENAME COLUMN leader TO fl_lider;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN fl_lider TYPE boolean USING (fl_lider = 1);
ALTER TABLE marft.f_operador_status ALTER COLUMN fl_lider SET DEFAULT FALSE;
ALTER TABLE marft.f_operador_status RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;
ALTER TABLE marft.f_operador_status RENAME COLUMN award_coefficient_i TO pc_coeficiente_premio_individual;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN pc_coeficiente_premio_individual TYPE numeric(7,4);
ALTER TABLE marft.f_operador_status RENAME COLUMN award_coefficient_c TO pc_coeficiente_premio_celula;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN pc_coeficiente_premio_celula TYPE numeric(7,4);
ALTER TABLE marft.f_operador_status RENAME COLUMN award_individual_me TO pc_premio_individual_me;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN pc_premio_individual_me TYPE numeric(7,4);
ALTER TABLE marft.f_operador_status RENAME COLUMN maximumefficiency TO pc_eficiencia_maxima;
ALTER TABLE marft.f_operador_status
    ALTER COLUMN pc_eficiencia_maxima TYPE numeric(7,4);

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.foperador_status AS
    SELECT * FROM marft.f_operador_status;
COMMENT ON VIEW marft.foperador_status IS
    'DEPRECATED 2026-05-05: usar f_operador_status. Sera removido em 2026-08-03.';
```

---

### marft.fprod_oper

**Nome proposto:** `marft.f_producao_operacao`
**Tipo:** fato
**Descricao:** Fato granular de producao por operacao: cada linha representa a execucao de uma operacao especifica (sequencia de uma OP/OS) por um operador em uma hora registrada. Contem quantidades produzidas, tempo gasto, carga de trabalho e dados de rastreabilidade (caixa, grupo, referencia, produto).
**Sistema de origem:** Sistema de gestao de producao Marft — modulo de apontamento de producao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `op` | `numeric(10) NULL` | `nr_ordem_producao` | `integer` | RENAME, RETYPE | Numero da OP; prefixo `nr_` correto; nome completo |
| `os` | `numeric(10) NULL` | `nr_ordem_servico` | `integer` | RENAME, RETYPE | Numero da OS; prefixo `nr_` correto; nome completo |
| `seq` | `numeric(5) NULL` | `nr_sequencia` | `smallint` | RENAME, RETYPE | Numero de sequencia da operacao na OS |
| `caixa` | `text NULL` | `ds_caixa` | `varchar(50)` | RENAME, RETYPE | Identificador de caixa/lote; prefixo `ds_`; tamanho explicito |
| `grupo` | `text NULL` | `ds_grupo` | `varchar(50)` | RENAME, RETYPE | Grupo do produto/operacao; prefixo `ds_`; tamanho explicito |
| `hora` | `timestamp NULL` | `dth_apontamento` | `timestamp` | RENAME | Instante do apontamento de producao; prefixo `dth_` correto |
| `cod_oper` | `text NULL` | `cod_operacao` | `varchar(20)` | RENAME, RETYPE | Codigo da operacao; `cod_` ja correto; nome mais explicito; tamanho explicito |
| `operacao` | `text NULL` | `nm_operacao` | `varchar(100)` | RENAME, RETYPE | Nome da operacao; prefixo `nm_` correto |
| `cod_operador` | `numeric(5) NULL` | `cod_operador` | `integer` | RETYPE | Join key canonica de operador; nome ja correto |
| `operador` | `text NULL` | `nm_operador` | `varchar(100)` | RENAME, RETYPE | Nome do operador; desnormalizacao |
| `qtde` | `numeric(5) NULL` | `qt_pecas_produzidas` | `smallint` | RENAME, RETYPE | Quantidade produzida; nome completo; prefixo `qt_` |
| `tempo` | `numeric(7,2) NULL` | `qt_tempo_minutos` | `numeric(7,2)` | RENAME | Tempo gasto na operacao em minutos; nome mais descritivo |
| `carga` | `numeric(38,10) NULL` | `qt_carga` | `numeric(15,3)` | RENAME, RETYPE | Carga de trabalho da operacao; `numeric(38,10)` superdimensionado |
| `gd` | `numeric(4,2) NULL` | `pc_grau_dificuldade` | `numeric(7,4)` | RENAME, RETYPE | Grau de dificuldade da operacao; abreviacao `gd` nao aprovada |
| `cod_cel` | `numeric(5) NULL` | `cod_celula` | `integer` | RENAME, RETYPE | Join key canonica de celula; nome completo |
| `celula_os` | `text NULL` | `nm_celula` | `varchar(100)` | RENAME, RETYPE | Nome da celula da OS; prefixo `nm_` correto |
| `turno` | `numeric(5) NULL` | `id_turno` | `smallint` | RENAME, RETYPE | Codigo operacional de turno |
| `referencia` | `text NULL` | `ds_referencia` | `varchar(50)` | RENAME, RETYPE | Referencia do produto; prefixo `ds_`; tamanho explicito |
| `produto` | `text NULL` | `nm_produto` | `varchar(100)` | RENAME, RETYPE | Nome do produto; prefixo `nm_` correto |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data de referencia do apontamento |
| `cpf` | `text NULL` | `cpf_colaborador` | `varchar(12)` | RENAME, RETYPE, REFORMAT | CPF no formato padrao DW |

**Flags presentes:** RENAME, RETYPE, REFORMAT, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(nr_ordem_producao, nr_ordem_servico, nr_sequencia, cod_operador, dth_apontamento)`.

#### Relacionamentos propostos

```
marft.f_producao_operacao
  |- cod_operador    -> marft.f_operador_status.cod_operador
  |- cod_celula      -> (dimensao de celula externa)
  |- nr_ordem_producao -> (fato ou dimensao de OP em schema ppcp, se existir)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_producao_operacao_cod_operador     ON marft.f_producao_operacao(cod_operador);
CREATE INDEX idx_f_producao_operacao_dt_referencia    ON marft.f_producao_operacao(dt_referencia);
CREATE INDEX idx_f_producao_operacao_cod_celula       ON marft.f_producao_operacao(cod_celula);
CREATE INDEX idx_f_producao_operacao_nr_ordem_producao ON marft.f_producao_operacao(nr_ordem_producao);
CREATE INDEX idx_f_producao_operacao_dth_apontamento  ON marft.f_producao_operacao(dth_apontamento);
```

#### Impacto no ETL

- Multiplas colunas de tipo `text` sem tamanho — definir `varchar(n)` e truncar no pipeline antes do INSERT.
- Converter `data` timestamp → date.
- Reduzir `carga` de `numeric(38,10)` para `numeric(15,3)` — validar que nao ha perda de precisao.
- Padronizar CPF.
- Renomear alias `op`, `os`, `seq`, `gd` no SELECT do pipeline — nomes curtos ambiguos.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.fprod_oper RENAME TO f_producao_operacao;

-- Passo 2: Surrogate key
ALTER TABLE marft.f_producao_operacao
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.f_producao_operacao RENAME COLUMN op TO nr_ordem_producao;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nr_ordem_producao TYPE integer USING nr_ordem_producao::integer;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN os TO nr_ordem_servico;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nr_ordem_servico TYPE integer USING nr_ordem_servico::integer;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN seq TO nr_sequencia;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nr_sequencia TYPE smallint USING nr_sequencia::smallint;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN caixa TO ds_caixa;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN ds_caixa TYPE varchar(50);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN grupo TO ds_grupo;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN ds_grupo TYPE varchar(50);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN hora TO dth_apontamento;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN cod_oper TO cod_operacao;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN cod_operacao TYPE varchar(20);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN operacao TO nm_operacao;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nm_operacao TYPE varchar(100);
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN cod_operador TYPE integer USING cod_operador::integer;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN operador TO nm_operador;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nm_operador TYPE varchar(100);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN qtde TO qt_pecas_produzidas;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN qt_pecas_produzidas TYPE smallint USING qt_pecas_produzidas::smallint;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN tempo TO qt_tempo_minutos;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN carga TO qt_carga;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN qt_carga TYPE numeric(15,3);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN gd TO pc_grau_dificuldade;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN pc_grau_dificuldade TYPE numeric(7,4);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN cod_cel TO cod_celula;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN cod_celula TYPE integer USING cod_celula::integer;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN celula_os TO nm_celula;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nm_celula TYPE varchar(100);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN turno TO id_turno;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN id_turno TYPE smallint USING id_turno::smallint;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN referencia TO ds_referencia;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN ds_referencia TYPE varchar(50);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN produto TO nm_produto;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN nm_produto TYPE varchar(100);
ALTER TABLE marft.f_producao_operacao RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.f_producao_operacao RENAME COLUMN cpf TO cpf_colaborador;
ALTER TABLE marft.f_producao_operacao
    ALTER COLUMN cpf_colaborador TYPE varchar(12);

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.fprod_oper AS
    SELECT * FROM marft.f_producao_operacao;
COMMENT ON VIEW marft.fprod_oper IS
    'DEPRECATED 2026-05-05: usar f_producao_operacao. Sera removido em 2026-08-03.';
```

---

### marft.fproducao_celula

**Nome proposto:** `marft.f_producao_celula`
**Tipo:** fato
**Descricao:** Fato de producao agregada por celula, turno e data. Contem metricas de eficiencia, RFT (Right First Time), SMO (Standard Minutes of Operation), capacidade produtiva, minutos disponiveis, paradas e eficiencia real versus perdida. E a tabela principal de acompanhamento de desempenho de celula.
**Sistema de origem:** Sistema de gestao de producao Marft — modulo de consolidacao de celula.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `codigo_celula` | `int4 NULL` | `cod_celula` | `int4` | RENAME | Join key canonica de celula |
| `shift` | `int2 NULL` | `id_turno` | `smallint` | RENAME | Codigo operacional de turno |
| `DATA` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data do turno; UPPER_CASE proibido; sem componente horaria |
| `minutos_dia` | `int4 NULL` | `qt_minutos_dia` | `integer` | RENAME | Minutos totais do dia/turno |
| `operadores` | `int2 NULL` | `qt_operadores` | `smallint` | RENAME | Quantidade de operadores alocados na celula |
| `total_minutos_parada` | `int4 NULL` | `qt_minutos_parada_total` | `integer` | RENAME | Total de minutos de parada na celula |
| `total_minutos_dia` | `int8 NULL` | `qt_minutos_dia_total` | `bigint` | RENAME | Total de minutos-operador disponiveis no dia |
| `total_minutos_produzidos` | `numeric(18,3) NULL` | `qt_minutos_produzidos_total` | `numeric(15,3)` | RENAME, RETYPE | Total de minutos produzidos; `numeric(18,3)` → padrao `numeric(15,3)` |
| `total_pecas_produzidas` | `int8 NULL` | `qt_pecas_produzidas_total` | `bigint` | RENAME | Total de pecas produzidas no turno |
| `eficiencia` | `numeric(18,3) NULL` | `pc_eficiencia` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia da celula; tipo padrao `numeric(7,4)` |
| `rft` | `numeric(18,3) NULL` | `pc_rft` | `numeric(7,4)` | RENAME, RETYPE | Right First Time — percentual de acerto na primeira tentativa |
| `smo` | `numeric(18,3) NULL` | `qt_smo` | `numeric(15,3)` | RENAME, RETYPE | Standard Minutes of Operation — volume em minutos padrao |
| `eficiencia_peca` | `numeric(18,3) NULL` | `pc_eficiencia_peca` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia calculada por peca |
| `operational_eff` | `int2 NULL` | `fl_eficiencia_operacional` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag de eficiencia operacional ativa; int2→boolean |
| `partial_parts` | `int2 NULL` | `fl_pecas_parciais` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag de producao com pecas parciais; int2→boolean |
| `part_amount` | `int2 NULL` | `qt_pecas_parciais` | `smallint` | RENAME | Quantidade de pecas parciais; semanticamente nao e flag |
| `message` | `varchar(250) NULL` | `obs_mensagem` | `varchar(250)` | RENAME | Mensagem operacional; prefixo `obs_` correto |
| `part_code` | `int4 NULL` | `id_codigo_peca` | `integer` | RENAME | Codigo operacional de peca |
| `productivecapacity` | `int8 NULL` | `qt_capacidade_produtiva` | `bigint` | RENAME | Capacidade produtiva em minutos; camelCase proibido |
| `availableminutes` | `int8 NULL` | `qt_minutos_disponiveis` | `bigint` | RENAME | Minutos disponiveis para producao; camelCase proibido |
| `holiday` | `int2 NULL` | `fl_feriado` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag de feriado; int2→boolean |
| `realefficiency` | `numeric(18,3) NULL` | `pc_eficiencia_real` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia real (descontando paradas nao produtivas); camelCase proibido |
| `lostefficiency` | `numeric(18,3) NULL` | `pc_eficiencia_perdida` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia perdida por paradas; camelCase proibido |
| `stoppercent` | `numeric(18,3) NULL` | `pc_percentual_parada` | `numeric(7,4)` | RENAME, RETYPE | Percentual do tempo em parada; camelCase proibido |
| `lostminutes` | `int8 NULL` | `qt_minutos_perdidos` | `bigint` | RENAME | Minutos perdidos por paradas nao produtivas; camelCase proibido |
| `stopminutes` | `int8 NULL` | `qt_minutos_parada` | `bigint` | RENAME | Minutos totais em parada; camelCase proibido |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_celula, id_turno, dt_referencia)` — deve ser UNIQUE (um registro por celula/turno/data).

```sql
ALTER TABLE marft.f_producao_celula
    ADD CONSTRAINT uq_f_producao_celula UNIQUE (cod_celula, id_turno, dt_referencia);
```

#### Relacionamentos propostos

```
marft.f_producao_celula
  |- cod_celula -> (dimensao de celula externa ao schema marft)
  |- Agregado de: marft.f_producao_operador (por celula/turno/data)
  |- Agregado de: marft.d_parada_celula (paradas da celula)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_producao_celula_cod_celula    ON marft.f_producao_celula(cod_celula);
CREATE INDEX idx_f_producao_celula_dt_referencia ON marft.f_producao_celula(dt_referencia);
CREATE INDEX idx_f_producao_celula_id_turno      ON marft.f_producao_celula(id_turno);
```

#### Impacto no ETL

- Grande volume de renomeacoes — atualizar todo o SELECT do DAG de carga.
- Converter `DATA` (UPPER_CASE, timestamp) → date; remover aspas no DDL.
- Converter 4 flags (int2) → boolean.
- Verificar conflito de nome: `qt_minutos_parada_total` (de `total_minutos_parada`) vs `qt_minutos_parada` (de `stopminutes`) — sao conceitos distintos: total de parada computado e minutos brutos em parada.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.fproducao_celula RENAME TO f_producao_celula;

-- Passo 2: Surrogate key
ALTER TABLE marft.f_producao_celula
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.f_producao_celula RENAME COLUMN codigo_celula TO cod_celula;
ALTER TABLE marft.f_producao_celula RENAME COLUMN shift TO id_turno;
ALTER TABLE marft.f_producao_celula RENAME COLUMN "DATA" TO dt_referencia;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.f_producao_celula RENAME COLUMN minutos_dia TO qt_minutos_dia;
ALTER TABLE marft.f_producao_celula RENAME COLUMN operadores TO qt_operadores;
ALTER TABLE marft.f_producao_celula RENAME COLUMN total_minutos_parada TO qt_minutos_parada_total;
ALTER TABLE marft.f_producao_celula RENAME COLUMN total_minutos_dia TO qt_minutos_dia_total;
ALTER TABLE marft.f_producao_celula RENAME COLUMN total_minutos_produzidos TO qt_minutos_produzidos_total;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN qt_minutos_produzidos_total TYPE numeric(15,3);
ALTER TABLE marft.f_producao_celula RENAME COLUMN total_pecas_produzidas TO qt_pecas_produzidas_total;
ALTER TABLE marft.f_producao_celula RENAME COLUMN eficiencia TO pc_eficiencia;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN pc_eficiencia TYPE numeric(7,4);
ALTER TABLE marft.f_producao_celula RENAME COLUMN rft TO pc_rft;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN pc_rft TYPE numeric(7,4);
ALTER TABLE marft.f_producao_celula RENAME COLUMN smo TO qt_smo;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN qt_smo TYPE numeric(15,3);
ALTER TABLE marft.f_producao_celula RENAME COLUMN eficiencia_peca TO pc_eficiencia_peca;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN pc_eficiencia_peca TYPE numeric(7,4);
ALTER TABLE marft.f_producao_celula RENAME COLUMN operational_eff TO fl_eficiencia_operacional;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN fl_eficiencia_operacional TYPE boolean USING (fl_eficiencia_operacional = 1);
ALTER TABLE marft.f_producao_celula ALTER COLUMN fl_eficiencia_operacional SET DEFAULT FALSE;
ALTER TABLE marft.f_producao_celula RENAME COLUMN partial_parts TO fl_pecas_parciais;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN fl_pecas_parciais TYPE boolean USING (fl_pecas_parciais = 1);
ALTER TABLE marft.f_producao_celula ALTER COLUMN fl_pecas_parciais SET DEFAULT FALSE;
ALTER TABLE marft.f_producao_celula RENAME COLUMN part_amount TO qt_pecas_parciais;
ALTER TABLE marft.f_producao_celula RENAME COLUMN message TO obs_mensagem;
ALTER TABLE marft.f_producao_celula RENAME COLUMN part_code TO id_codigo_peca;
ALTER TABLE marft.f_producao_celula RENAME COLUMN productivecapacity TO qt_capacidade_produtiva;
ALTER TABLE marft.f_producao_celula RENAME COLUMN availableminutes TO qt_minutos_disponiveis;
ALTER TABLE marft.f_producao_celula RENAME COLUMN holiday TO fl_feriado;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN fl_feriado TYPE boolean USING (fl_feriado = 1);
ALTER TABLE marft.f_producao_celula ALTER COLUMN fl_feriado SET DEFAULT FALSE;
ALTER TABLE marft.f_producao_celula RENAME COLUMN realefficiency TO pc_eficiencia_real;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN pc_eficiencia_real TYPE numeric(7,4);
ALTER TABLE marft.f_producao_celula RENAME COLUMN lostefficiency TO pc_eficiencia_perdida;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN pc_eficiencia_perdida TYPE numeric(7,4);
ALTER TABLE marft.f_producao_celula RENAME COLUMN stoppercent TO pc_percentual_parada;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN pc_percentual_parada TYPE numeric(7,4);
ALTER TABLE marft.f_producao_celula RENAME COLUMN lostminutes TO qt_minutos_perdidos;
ALTER TABLE marft.f_producao_celula RENAME COLUMN stopminutes TO qt_minutos_parada;
ALTER TABLE marft.f_producao_celula RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.f_producao_celula
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- Passo 4: Unique constraint na chave natural
ALTER TABLE marft.f_producao_celula
    ADD CONSTRAINT uq_f_producao_celula UNIQUE (cod_celula, id_turno, dt_referencia);

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.fproducao_celula AS
    SELECT * FROM marft.f_producao_celula;
COMMENT ON VIEW marft.fproducao_celula IS
    'DEPRECATED 2026-05-05: usar f_producao_celula. Sera removido em 2026-08-03.';
```

---

### marft.fproducao_operador

**Nome proposto:** `marft.f_producao_operador`
**Tipo:** fato
**Descricao:** Fato de producao diaria agregada por operador, celula e turno. Contem metricas de minutos disponiveis, paradas, faltas, minutos produzidos e indicadores de eficiencia, RFT e SMO — tanto para o turno corrente quanto gerais (acumulados). Referencia o `operator_status_id` de `f_operador_status` para rastreabilidade do status do operador.
**Sistema de origem:** Sistema de gestao de producao Marft — modulo de producao por operador.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| _(ausente)_ | — | `id` | `bigserial PRIMARY KEY` | ADD | Surrogate key obrigatoria |
| `codigo_operador` | `int4 NULL` | `cod_operador` | `int4` | RENAME | Join key canonica de operador |
| `data` | `timestamp NULL` | `dt_referencia` | `date` | RENAME, RETYPE | Data do apontamento; sem componente horaria |
| `codigo_celula` | `int4 NULL` | `cod_celula` | `int4` | RENAME | Join key canonica de celula |
| `shift` | `int2 NULL` | `id_turno` | `smallint` | RENAME | Codigo operacional de turno |
| `operator_status_id` | `int8 NULL` | `nr_status_id_origem` | `bigint` | RENAME | Referencia ao status do operador em `f_operador_status`; prefixo `nr_` pois nao e surrogate DW; sem camelCase |
| `minutos` | `int4 NULL` | `qt_minutos_disponiveis` | `integer` | RENAME | Minutos disponiveis do operador no turno |
| `minutos_parada` | `int4 NULL` | `qt_minutos_parada` | `integer` | RENAME | Minutos em parada no turno |
| `minutos_falta` | `int4 NULL` | `qt_minutos_falta` | `integer` | RENAME | Minutos de falta no turno |
| `minutos_horario` | `int4 NULL` | `qt_minutos_horario` | `integer` | RENAME | Minutos de horario programado |
| `total_minutos_dia` | `int4 NULL` | `qt_minutos_dia_total` | `integer` | RENAME | Total de minutos do dia/turno |
| `minutos_produzidos` | `numeric(18,3) NULL` | `qt_minutos_produzidos` | `numeric(15,3)` | RENAME, RETYPE | Minutos produzidos no turno |
| `total_minutos_produzidos` | `numeric(18,3) NULL` | `qt_minutos_produzidos_total` | `numeric(15,3)` | RENAME, RETYPE | Total acumulado de minutos produzidos |
| `eficiencia` | `numeric(18,3) NULL` | `pc_eficiencia` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia do operador no turno |
| `eficiencia_geral` | `numeric(18,3) NULL` | `pc_eficiencia_geral` | `numeric(7,4)` | RENAME, RETYPE | Eficiencia geral acumulada do operador |
| `rft` | `numeric(18,3) NULL` | `pc_rft` | `numeric(7,4)` | RENAME, RETYPE | Right First Time do turno |
| `rft_geral` | `numeric(18,3) NULL` | `pc_rft_geral` | `numeric(7,4)` | RENAME, RETYPE | RFT geral acumulado |
| `smo` | `numeric(18,3) NULL` | `qt_smo` | `numeric(15,3)` | RENAME, RETYPE | Standard Minutes of Operation do turno |
| `smo_geral` | `numeric(18,3) NULL` | `qt_smo_geral` | `numeric(15,3)` | RENAME, RETYPE | SMO geral acumulado |
| `message` | `varchar(500) NULL` | `obs_mensagem` | `varchar(500)` | RENAME | Mensagem operacional; prefixo `obs_` correto |
| `holiday` | `int2 NULL` | `fl_feriado` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag de feriado; int2→boolean |
| `sourcecell` | `int2 NULL` | `fl_celula_origem` | `boolean DEFAULT FALSE` | RENAME, RETYPE | Flag indicando se o operador e da celula de origem; camelCase proibido; int2→boolean |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME, RETYPE | Auditoria padrao |

**Flags presentes:** RENAME, RETYPE, ADD

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(cod_operador, dt_referencia, id_turno, cod_celula)` — deve ser UNIQUE.

```sql
ALTER TABLE marft.f_producao_operador
    ADD CONSTRAINT uq_f_producao_operador UNIQUE (cod_operador, dt_referencia, id_turno, cod_celula);
```

#### Relacionamentos propostos

```
marft.f_producao_operador
  |- cod_operador       -> marft.f_operador_status.cod_operador
  |- cod_celula         -> (dimensao de celula externa)
  |- nr_status_id_origem -> marft.f_operador_status.nr_status_id_origem
  |- Agrega: marft.f_producao_operacao (minutos/pecas por operacao no turno)
  |- Agrega: marft.d_parada_operador (paradas do operador)
  |- Agrega: marft.d_falta_operador (faltas do operador)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_producao_operador_cod_operador    ON marft.f_producao_operador(cod_operador);
CREATE INDEX idx_f_producao_operador_dt_referencia   ON marft.f_producao_operador(dt_referencia);
CREATE INDEX idx_f_producao_operador_cod_celula      ON marft.f_producao_operador(cod_celula);
CREATE INDEX idx_f_producao_operador_nr_status_id    ON marft.f_producao_operador(nr_status_id_origem);
```

#### Impacto no ETL

- Renomear `operator_status_id` para `nr_status_id_origem` — alinhar com renomeacao na `f_operador_status`.
- Converter flags `holiday` e `sourcecell` (int2) → boolean.
- Reduzir `numeric(18,3)` para `numeric(15,3)` em metricas e `numeric(7,4)` em percentuais.
- Converter `data` timestamp → date.
- Adicionar constraint UNIQUE apos validacao de dados existentes.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE marft.fproducao_operador RENAME TO f_producao_operador;

-- Passo 2: Surrogate key
ALTER TABLE marft.f_producao_operador
    ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 3: Renomear e retipar colunas
ALTER TABLE marft.f_producao_operador RENAME COLUMN codigo_operador TO cod_operador;
ALTER TABLE marft.f_producao_operador RENAME COLUMN "data" TO dt_referencia;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;
ALTER TABLE marft.f_producao_operador RENAME COLUMN codigo_celula TO cod_celula;
ALTER TABLE marft.f_producao_operador RENAME COLUMN shift TO id_turno;
ALTER TABLE marft.f_producao_operador RENAME COLUMN operator_status_id TO nr_status_id_origem;
ALTER TABLE marft.f_producao_operador RENAME COLUMN minutos TO qt_minutos_disponiveis;
ALTER TABLE marft.f_producao_operador RENAME COLUMN minutos_parada TO qt_minutos_parada;
ALTER TABLE marft.f_producao_operador RENAME COLUMN minutos_falta TO qt_minutos_falta;
ALTER TABLE marft.f_producao_operador RENAME COLUMN minutos_horario TO qt_minutos_horario;
ALTER TABLE marft.f_producao_operador RENAME COLUMN total_minutos_dia TO qt_minutos_dia_total;
ALTER TABLE marft.f_producao_operador RENAME COLUMN minutos_produzidos TO qt_minutos_produzidos;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN qt_minutos_produzidos TYPE numeric(15,3);
ALTER TABLE marft.f_producao_operador RENAME COLUMN total_minutos_produzidos TO qt_minutos_produzidos_total;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN qt_minutos_produzidos_total TYPE numeric(15,3);
ALTER TABLE marft.f_producao_operador RENAME COLUMN eficiencia TO pc_eficiencia;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN pc_eficiencia TYPE numeric(7,4);
ALTER TABLE marft.f_producao_operador RENAME COLUMN eficiencia_geral TO pc_eficiencia_geral;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN pc_eficiencia_geral TYPE numeric(7,4);
ALTER TABLE marft.f_producao_operador RENAME COLUMN rft TO pc_rft;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN pc_rft TYPE numeric(7,4);
ALTER TABLE marft.f_producao_operador RENAME COLUMN rft_geral TO pc_rft_geral;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN pc_rft_geral TYPE numeric(7,4);
ALTER TABLE marft.f_producao_operador RENAME COLUMN smo TO qt_smo;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN qt_smo TYPE numeric(15,3);
ALTER TABLE marft.f_producao_operador RENAME COLUMN smo_geral TO qt_smo_geral;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN qt_smo_geral TYPE numeric(15,3);
ALTER TABLE marft.f_producao_operador RENAME COLUMN message TO obs_mensagem;
ALTER TABLE marft.f_producao_operador RENAME COLUMN holiday TO fl_feriado;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN fl_feriado TYPE boolean USING (fl_feriado = 1);
ALTER TABLE marft.f_producao_operador ALTER COLUMN fl_feriado SET DEFAULT FALSE;
ALTER TABLE marft.f_producao_operador RENAME COLUMN sourcecell TO fl_celula_origem;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN fl_celula_origem TYPE boolean USING (fl_celula_origem = 1);
ALTER TABLE marft.f_producao_operador ALTER COLUMN fl_celula_origem SET DEFAULT FALSE;
ALTER TABLE marft.f_producao_operador RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE marft.f_producao_operador
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- Passo 4: Unique constraint
ALTER TABLE marft.f_producao_operador
    ADD CONSTRAINT uq_f_producao_operador UNIQUE (cod_operador, dt_referencia, id_turno, cod_celula);

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW marft.fproducao_operador AS
    SELECT * FROM marft.f_producao_operador;
COMMENT ON VIEW marft.fproducao_operador IS
    'DEPRECATED 2026-05-05: usar f_producao_operador. Sera removido em 2026-08-03.';
```

---

## Apendice A — Mapa de relacionamentos do schema marft

```
marft.d_motivo_parada
  <- marft.d_parada_celula.cod_motivo
  <- marft.d_parada_operador.cod_motivo
  <- marft.d_falta_operador.cod_motivo

marft.aux_valor_premio
  <- marft.f_operador_status.cod_premio

marft.f_operador_status
  <- marft.f_producao_operador.nr_status_id_origem (rastreabilidade)
  <- marft.f_desempenho_operador_individual.cod_operador
  <- marft.f_desempenho_operador_maquina.cod_operador

marft.stg_colaborador_integracao
  <- marft.f_desempenho_operador_individual.cod_colaborador
  <- marft.f_desempenho_operador_maquina.cod_colaborador

marft.f_producao_operador (agregado por operador/celula/turno/data)
  <- marft.f_producao_operacao (granular por operacao)
  <- marft.d_parada_operador (paradas do operador)
  <- marft.d_falta_operador (faltas do operador)

marft.f_producao_celula (agregado por celula/turno/data)
  <- marft.f_producao_operador (agregado de operadores)
  <- marft.d_parada_celula (paradas da celula)
```

---

## Apendice B — Entidades canonicas adicionadas ao dicionario global

As seguintes entidades do schema marft devem ser incorporadas ao dicionario global (BOAS_PRATICAS_DW.md secao 11):

| Entidade | Coluna join | Tipo | Dimensao/Fato |
|---|---|---|---|
| operador | `cod_operador` | `int4` | `marft.f_operador_status` |
| celula | `cod_celula` | `int4` | (sem dimensao declarada — join por convencao) |
| motivo_parada | `cod_motivo` | `smallint` | `marft.d_motivo_parada` |
| premio | `cod_premio` | `integer` | `marft.aux_valor_premio` |

---

## Apendice C — Conflitos e pontos de atencao

| Tabela | Coluna | Conflito | Acao recomendada |
|---|---|---|---|
| `f_producao_celula` | `qt_minutos_parada_total` vs `qt_minutos_parada` | Dois campos de parada com semanticas distintas: `total_minutos_parada` (calculo DW) e `stopminutes` (bruto da origem) | Manter ambos com nomes distintos; documentar diferenca no ETL |
| `f_operador_status` | `pc_coeficiente_premio_individual`, `pc_coeficiente_premio_celula`, `pc_premio_individual_me`, `pc_eficiencia_maxima` | Campos `numeric(18,3)` com semantica de percentual — verificar se estao em escala 0-100 ou 0-1 antes de converter para `numeric(7,4)` | Auditar valores na base antes da migracao de tipo |
| `fdesempenho_operador_individual` e `fdesempenho_operador_maquina` | Estrutura identica | Duas tabelas com schema exatamente igual, diferenciadas apenas pelo modulo de calculo | Avaliar unificacao com coluna `id_modo_eficiencia` (1=individual, 2=maquina) |
| Todas as tabelas | `ultima_atualizacao NULL` | Auditoria sem NOT NULL e sem DEFAULT na origem | Aplicar `SET DEFAULT current_timestamp` e atualizar pipeline para nao enviar este campo |
