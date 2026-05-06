# Dicionario de Dados — Schema `eventos`

> **Versao:** 1.0 | **Data:** 2026-05-05
> **Status:** Em revisao
> **Responsavel:** Data Engineering
> **Schema:** `eventos` | **Tabelas documentadas:** 9 | **Colunas totais:** 180
> **Referencia de boas praticas:** `BOAS_PRATICAS_DW.md` v2.0

---

## Visao Geral do Schema

O schema `eventos` concentra dados de eventos comerciais e experiencias de clientes, cobrindo quatro dominios principais:

1. **Inscricoes e participantes** — dados de inscritos em eventos (`dinfo_eventos`, `fexperience_registrations`)
2. **Catalogo de eventos** — definicoes e configuracoes dos eventos (`fexperience_events`)
3. **Compras e suprimentos** — notas de compra e pedidos de compra vinculados a eventos (`fnotas_compras_eventos`, `fpedidos_compra_eventos`)
4. **Financeiro contabil** — lancamentos de debito, credito e titulos a pagar relacionados a eventos (`fdebitos_eventos`, `fcreditos_eventos`, `ftitulos_compras_eventos`)
5. **Itens de carrinho** — detalhe dos itens adquiridos online (`ditens_carrinho`)

**Padrao de nomenclatura observado:** misto (ingles + portugues). Tabelas originadas da API Experience usam ingles (`fexperience_events`, `fexperience_registrations`, `ditens_carrinho`); demais usam portugues. Conflito documentado e sinalizado com flag `[CONFLITO]` nas colunas afetadas.

**Sistema de origem identificado:**
- API Experience (plataforma de inscricoes em corridas/eventos esportivos)
- ERP / sistema contabil interno (lancamentos financeiros e pedidos de compra)

---

## Tabelas

---

### eventos.dinfo_eventos

**Nome proposto:** `eventos.d_inscricao_evento`
**Tipo:** dimensao
**Descricao:** Registro de inscritos em eventos. Cada linha representa uma inscricao de participante em um evento especifico, contendo dados pessoais, categorias de participacao, valores pagos e status da inscricao. Serve como dimensao de participante para as fatos financeiras do schema.
**Sistema de origem:** API Experience / plataforma de inscricoes em eventos

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int8 NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | Deve ser surrogate key `bigserial PRIMARY KEY`; atualmente nullable e sem constraint PK |
| `nome_evento` | `text NULL` | `nm_evento` | `varchar(100) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `nm_`; limitar tamanho para indexabilidade |
| `nome` | `text NULL` | `nm_participante` | `varchar(100) NULL` | [RENAME] [RETYPE] | Nome ambiguo; renomear para clareza; limitar tamanho |
| `primeira_corrida` | `text NULL` | `fl_primeira_corrida` | `boolean NULL` | [RENAME] [RETYPE] | Campo semanticamente booleano (sim/nao); aplicar prefixo `fl_` e tipo `boolean` |
| `email` | `text NULL` | `nm_email` | `varchar(150) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `nm_`; limitar tamanho |
| `cpf` | `varchar(20) NULL` | `cpf_participante` | `varchar(12) NULL` | [RENAME] [RETYPE] | Formato padrao DW: `XXXXXXXXX-ZZ` (12 chars); renomear com sufixo de entidade |
| `cpf_responsavel` | `varchar(20) NULL` | `cpf_responsavel` | `varchar(12) NULL` | [RETYPE] | Mesmo formato de CPF; reduzir para 12 chars |
| `data_aniversario` | `date NULL` | `dt_nascimento` | `date NULL` | [RENAME] | Aplicar prefixo `dt_`; "aniversario" e coloquial — usar "nascimento" |
| `genero` | `varchar(20) NULL` | `ds_genero` | `varchar(20) NULL` | [RENAME] | Aplicar prefixo `ds_` |
| `pcd` | `int4 NULL` | `fl_pcd` | `boolean NULL` | [RENAME] [RETYPE] | Campo semanticamente booleano (pessoa com deficiencia: sim/nao); tipo `boolean` |
| `celular` | `varchar(20) NULL` | `nr_celular` | `varchar(20) NULL` | [RENAME] | Aplicar prefixo `nr_` |
| `kit` | `text NULL` | `ds_kit` | `varchar(50) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `ds_`; limitar tamanho |
| `subtotal` | `numeric(12,2) NULL` | `vl_subtotal` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `vl_`; padronizar precisao para `numeric(15,2)` |
| `desconto` | `numeric(12,2) NULL` | `vl_desconto` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `vl_`; padronizar precisao |
| `total` | `numeric(12,2) NULL` | `vl_total` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `vl_`; padronizar precisao |
| `nome_time` | `text NULL` | `nm_time` | `varchar(100) NULL` | [RENAME] [RETYPE] | Aplicar prefixo `nm_`; limitar tamanho |
| `informacao_adicional` | `text NULL` | `obs_adicional` | `text NULL` | [RENAME] | Texto livre — prefixo `obs_` |
| `status` | `varchar(50) NULL` | `ds_status` | `varchar(50) NULL` | [RENAME] | Aplicar prefixo `ds_` |
| `origem` | `varchar(50) NULL` | `ds_origem` | `varchar(50) NULL` | [RENAME] | Aplicar prefixo `ds_` |
| `numer_peito` | `varchar(50) NULL` | `nr_peito` | `varchar(20) NULL` | [RENAME] [RETYPE] | Typo no nome original (`numer`); aplicar prefixo `nr_`; reduzir tamanho |
| `check_in` | `varchar(20) NULL` | `fl_check_in` | `boolean NULL` | [RENAME] [RETYPE] | Campo semanticamente booleano; tipo `boolean` |
| `data_registro` | `timestamp NULL` | `dth_registro` | `timestamp NULL` | [RENAME] | Aplicar prefixo `dth_` para timestamp |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

**Observacao de CONFLITO:** O campo `id` e `int8 NULL` sem PRIMARY KEY declarada — a tabela nao possui chave primaria garantida no banco. Verificar unicidade antes de promover a surrogate key.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Adicionar constraint UNIQUE em `(cpf_participante, nm_evento)` como chave de negocio composta, pois uma pessoa so pode se inscrever uma vez por evento.

#### Relacionamentos propostos

```
eventos.d_inscricao_evento
  |- nm_evento -> eventos.f_experience_events.nm_evento   (join por nome, sem cod_ canonica — ver nota)
```

> Nota: nao existe dimensao de eventos com chave natural padronizada (`cod_evento`). Recomenda-se criar `cod_evento` baseado em `event_id` da `fexperience_events` e propaga-lo nesta tabela.

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_d_inscricao_evento_cpf_evento
    ON eventos.d_inscricao_evento (cpf_participante, nm_evento);

CREATE INDEX idx_d_inscricao_evento_nm_evento
    ON eventos.d_inscricao_evento (nm_evento);

CREATE INDEX idx_d_inscricao_evento_ds_status
    ON eventos.d_inscricao_evento (ds_status);
```

#### Impacto no ETL

- Remover colunas `pcd` (int4) e `primeira_corrida` (text) do SELECT de origem; converter para `boolean` no pipeline com `CASE WHEN valor IN ('S', 'SIM', '1', 'true') THEN TRUE ELSE FALSE END`.
- `check_in` requer mesma logica de conversao booleana.
- CPF deve ser formatado para `XXXXXXXXX-ZZ` usando logica de limpeza de mascara.
- Renomear aliases no DAG para os novos nomes de coluna.
- Adicionar `created_at` e `updated_at` como colunas com `DEFAULT current_timestamp` — o ETL nao precisa enviá-las.

#### Migracao SQL

```sql
-- 1. Criar tabela nova com estrutura correta
CREATE TABLE eventos.d_inscricao_evento (
    id                   bigserial        PRIMARY KEY,
    nm_evento            varchar(100)     NULL,
    nm_participante      varchar(100)     NULL,
    fl_primeira_corrida  boolean          NULL,
    nm_email             varchar(150)     NULL,
    cpf_participante     varchar(12)      NULL,
    cpf_responsavel      varchar(12)      NULL,
    dt_nascimento        date             NULL,
    ds_genero            varchar(20)      NULL,
    fl_pcd               boolean          NULL,
    nr_celular           varchar(20)      NULL,
    ds_kit               varchar(50)      NULL,
    vl_subtotal          numeric(15,2)    NULL,
    vl_desconto          numeric(15,2)    NULL,
    vl_total             numeric(15,2)    NULL,
    nm_time              varchar(100)     NULL,
    obs_adicional        text             NULL,
    ds_status            varchar(50)      NULL,
    ds_origem            varchar(50)      NULL,
    nr_peito             varchar(20)      NULL,
    fl_check_in          boolean          NULL,
    dth_registro         timestamp        NULL,
    created_at           timestamp        NOT NULL DEFAULT current_timestamp,
    updated_at           timestamp        NOT NULL DEFAULT current_timestamp
);

-- 2. Migrar dados com conversoes
INSERT INTO eventos.d_inscricao_evento (
    nm_evento, nm_participante, fl_primeira_corrida, nm_email,
    cpf_participante, cpf_responsavel, dt_nascimento, ds_genero,
    fl_pcd, nr_celular, ds_kit, vl_subtotal, vl_desconto, vl_total,
    nm_time, obs_adicional, ds_status, ds_origem, nr_peito,
    fl_check_in, dth_registro
)
SELECT
    nome_evento,
    nome,
    CASE WHEN LOWER(TRIM(primeira_corrida)) IN ('s', 'sim', '1', 'true', 'yes') THEN TRUE
         WHEN LOWER(TRIM(primeira_corrida)) IN ('n', 'nao', '0', 'false', 'no') THEN FALSE
         ELSE NULL END,
    email,
    -- CPF: remover mascara e reformatar como XXXXXXXXX-ZZ
    CASE WHEN cpf IS NOT NULL THEN
        LPAD(REGEXP_REPLACE(cpf, '[^0-9]', '', 'g'), 9, '0')
        || '-' || RIGHT(REGEXP_REPLACE(cpf, '[^0-9]', '', 'g'), 2)
    ELSE NULL END,
    CASE WHEN cpf_responsavel IS NOT NULL THEN
        LPAD(REGEXP_REPLACE(cpf_responsavel, '[^0-9]', '', 'g'), 9, '0')
        || '-' || RIGHT(REGEXP_REPLACE(cpf_responsavel, '[^0-9]', '', 'g'), 2)
    ELSE NULL END,
    data_aniversario,
    genero,
    CASE WHEN pcd = 1 THEN TRUE WHEN pcd = 0 THEN FALSE ELSE NULL END,
    celular,
    kit,
    subtotal,
    desconto,
    total,
    nome_time,
    informacao_adicional,
    status,
    origem,
    numer_peito,
    CASE WHEN LOWER(TRIM(check_in)) IN ('s', 'sim', '1', 'true', 'yes') THEN TRUE
         WHEN LOWER(TRIM(check_in)) IN ('n', 'nao', '0', 'false', 'no') THEN FALSE
         ELSE NULL END,
    data_registro
FROM eventos.dinfo_eventos;

-- 3. Indices
CREATE UNIQUE INDEX uq_d_inscricao_evento_cpf_evento
    ON eventos.d_inscricao_evento (cpf_participante, nm_evento);
CREATE INDEX idx_d_inscricao_evento_nm_evento
    ON eventos.d_inscricao_evento (nm_evento);
CREATE INDEX idx_d_inscricao_evento_ds_status
    ON eventos.d_inscricao_evento (ds_status);

-- 4. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW eventos.dinfo_eventos AS
    SELECT * FROM eventos.d_inscricao_evento;
COMMENT ON VIEW eventos.dinfo_eventos IS
    'DEPRECATED 2026-05-05: usar d_inscricao_evento. Sera removido em 2026-08-03.';
```

---

### eventos.ditens_carrinho

**Nome proposto:** `eventos.f_item_carrinho`
**Tipo:** fato
**Descricao:** Registra os itens adquiridos em cada carrinho de compra de evento (ex.: camiseta, medalha, servico adicional). Cada linha representa um item dentro de um pedido, com preco cheio, preco pago e desconto. Tabela de granularidade item-pedido.
**Sistema de origem:** API Experience / plataforma de inscricoes em eventos

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `serial4 NOT NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | `serial4` gera `integer` (max ~2 bilhoes); padrao DW e `bigserial`; PK ja declarada |
| `id_cart` | `int4 NULL` | `nr_carrinho` | `integer NULL` | [RENAME] | `id_cart` e ingles e ambiguo; `nr_carrinho` e mais descritivo e em portugues; `int4` = `integer` — OK |
| `order_id` | `int4 NULL` | `nr_pedido` | `integer NULL` | [RENAME] [CONFLITO] | Nome em ingles; renomear para `nr_pedido`; verificar se conflita com `order_id` da `fexperience_registrations` |
| `event_id` | `int4 NULL` | `cod_evento` | `integer NULL` | [RENAME] | Chave de negocio do evento; usar prefixo `cod_` para join key |
| `order_date` | `date NULL` | `dt_pedido` | `date NULL` | [RENAME] [CONFLITO] | Nome em ingles; renomear para portugues |
| `name` | `varchar(100) NULL` | `nm_item` | `varchar(100) NULL` | [RENAME] [CONFLITO] | Nome reservado em SQL; renomear para `nm_item` |
| `size` | `varchar(20) NULL` | `ds_tamanho` | `varchar(20) NULL` | [RENAME] [CONFLITO] | Palavra reservada em SQL; renomear para `ds_tamanho` |
| `price_full` | `numeric NULL` | `vl_preco_cheio` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Nome em ingles; sem precisao definida — padronizar para `numeric(15,2)` |
| `price_paid` | `numeric NULL` | `vl_preco_pago` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Nome em ingles; sem precisao definida — padronizar |
| `discount` | `numeric NULL` | `vl_desconto` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Nome em ingles; sem precisao definida — padronizar |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [CONFLITO]

**Observacao de CONFLITO:** Colunas `name` e `size` sao palavras reservadas em SQL e estavam entre aspas duplas no DDL original (`"name"`, `"size"`). Isso quebra queries sem aspas. Renomear e obrigatorio. `order_id` aparece tambem em `fexperience_registrations` com tipo `text` — inconsistencia de tipo a ser resolvida.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY   -- ja existe como serial4; migrar para bigserial
```

#### Relacionamentos propostos

```
eventos.f_item_carrinho
  |- cod_evento  -> eventos.f_experience_events.id   (join key de evento — sem cod_ canonica ainda)
  |- nr_pedido   -> eventos.fexperience_registrations.order_id  (atencao: tipo divergente — int4 vs text)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_item_carrinho_cod_evento
    ON eventos.f_item_carrinho (cod_evento);

CREATE INDEX idx_f_item_carrinho_nr_pedido
    ON eventos.f_item_carrinho (nr_pedido);

CREATE INDEX idx_f_item_carrinho_dt_pedido
    ON eventos.f_item_carrinho (dt_pedido);
```

#### Impacto no ETL

- Alterar alias de todas as colunas no DAG de carga.
- `numeric` sem precisao deve ser lido como `float64` no pandas — converter para `Decimal` antes do insert em `numeric(15,2)`.
- `id_cart` e `order_id` sao chaves de rastreio operacional; verificar se o sistema de origem envia como integer ou string (a tabela `fexperience_registrations` tem `order_id text`).
- Adicionar `created_at` e `updated_at` como defaults no banco.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.f_item_carrinho (
    id               bigserial        PRIMARY KEY,
    nr_carrinho      integer          NULL,
    nr_pedido        integer          NULL,
    cod_evento       integer          NULL,
    dt_pedido        date             NULL,
    nm_item          varchar(100)     NULL,
    ds_tamanho       varchar(20)      NULL,
    vl_preco_cheio   numeric(15,2)    NULL,
    vl_preco_pago    numeric(15,2)    NULL,
    vl_desconto      numeric(15,2)    NULL,
    created_at       timestamp        NOT NULL DEFAULT current_timestamp,
    updated_at       timestamp        NOT NULL DEFAULT current_timestamp
);

-- 2. Migrar dados
INSERT INTO eventos.f_item_carrinho (
    id, nr_carrinho, nr_pedido, cod_evento, dt_pedido,
    nm_item, ds_tamanho, vl_preco_cheio, vl_preco_pago, vl_desconto
)
SELECT
    id,
    id_cart,
    order_id,
    event_id,
    order_date,
    "name",
    "size",
    ROUND(price_full::numeric, 2),
    ROUND(price_paid::numeric, 2),
    ROUND(discount::numeric, 2)
FROM eventos.ditens_carrinho;

-- 3. Indices
CREATE INDEX idx_f_item_carrinho_cod_evento ON eventos.f_item_carrinho (cod_evento);
CREATE INDEX idx_f_item_carrinho_nr_pedido  ON eventos.f_item_carrinho (nr_pedido);
CREATE INDEX idx_f_item_carrinho_dt_pedido  ON eventos.f_item_carrinho (dt_pedido);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.ditens_carrinho AS
    SELECT
        id,
        nr_carrinho   AS id_cart,
        nr_pedido     AS order_id,
        cod_evento    AS event_id,
        dt_pedido     AS order_date,
        nm_item       AS "name",
        ds_tamanho    AS "size",
        vl_preco_cheio AS price_full,
        vl_preco_pago  AS price_paid,
        vl_desconto    AS discount
    FROM eventos.f_item_carrinho;
COMMENT ON VIEW eventos.ditens_carrinho IS
    'DEPRECATED 2026-05-05: usar f_item_carrinho. Sera removido em 2026-08-03.';
```

---

### eventos.fcreditos_eventos

**Nome proposto:** `eventos.f_credito_contabil_evento`
**Tipo:** fato
**Descricao:** Lancamentos contabeis de credito relacionados a eventos. Cada linha representa um lancamento de credito no plano de contas do ERP, identificado pela chave composta empresa + exercicio + numero de lancamento + sequencia. Estrutura espelhada de `fdebitos_eventos`.
**Sistema de origem:** ERP / sistema contabil interno

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `cod_empresa` | `numeric(3) NULL` | `id_empresa` | `smallint NULL` | [RENAME] [RETYPE] | Campo operacional de identificacao de empresa; prefixo `id_`; `smallint` e suficiente para <32k empresas |
| `exercicio` | `numeric(4) NULL` | `nr_exercicio` | `smallint NULL` | [RENAME] [RETYPE] | Ano fiscal (ex.: 2026); prefixo `nr_`; `smallint` suficiente |
| `numero_lanc` | `numeric(9) NULL` | `nr_lancamento` | `integer NULL` | [RENAME] [RETYPE] | Prefixo proibido `numero_` — usar `nr_`; `integer` adequado |
| `seq_lanc` | `numeric(5) NULL` | `nr_seq_lancamento` | `smallint NULL` | [RENAME] [RETYPE] | Sequencia dentro do lancamento; `smallint` suficiente |
| `origem` | `numeric(2) NULL` | `id_origem` | `smallint NULL` | [RENAME] [RETYPE] | Codigo de origem do lancamento; prefixo `id_` |
| `lote` | `numeric(5) NULL` | `nr_lote` | `integer NULL` | [RENAME] [RETYPE] | Numero de lote de lancamento; prefixo `nr_` |
| `periodo` | `numeric(4) NULL` | `nr_periodo` | `smallint NULL` | [RENAME] [RETYPE] | Periodo contabil (mes/ano); prefixo `nr_` |
| `conta_contabil` | `text NULL` | `ds_conta_contabil` | `varchar(30) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `conta_reduzida` | `numeric(5) NULL` | `nr_conta_reduzida` | `integer NULL` | [RENAME] [RETYPE] | Prefixo `nr_` |
| `subconta` | `numeric(4) NULL` | `nr_subconta` | `smallint NULL` | [RENAME] [RETYPE] | Prefixo `nr_` |
| `centro_custo` | `numeric(6) NULL` | `cod_centro_custo` | `integer NULL` | [RENAME] [RETYPE] | Chave de negocio de centro de custo; prefixo `cod_` |
| `debito_credito` | `text NULL` | `ds_debito_credito` | `char(1) NULL` | [RENAME] [RETYPE] | Indicador D/C; prefixo `ds_`; `char(1)` suficiente |
| `hist_contabil` | `numeric(4) NULL` | `id_historico_contabil` | `smallint NULL` | [RENAME] [RETYPE] | Codigo de historico contabil padronizado; prefixo `id_` |
| `compl_histor1` | `text NULL` | `obs_complemento_historico` | `text NULL` | [RENAME] | Texto livre; prefixo `obs_` |
| `data_lancto` | `timestamp NULL` | `dth_lancamento` | `timestamp NULL` | [RENAME] | Prefixo `dth_` para timestamp |
| `valor_lancto` | `numeric(15,2) NULL` | `vl_lancamento` | `numeric(15,2) NULL` | [RENAME] | Prefixo `vl_`; precisao ja correta |
| `filial_lancto` | `numeric(3) NULL` | `id_filial` | `smallint NULL` | [RENAME] [RETYPE] | Identificador de filial; prefixo `id_` |
| `contabilizado` | `numeric(1) NULL` | `fl_contabilizado` | `boolean NULL` | [RENAME] [RETYPE] | Campo semanticamente booleano (0/1); converter para `boolean` |
| `data_contab` | `timestamp NULL` | `dth_contabilizacao` | `timestamp NULL` | [RENAME] | Prefixo `dth_` |
| `documento` | `numeric(9) NULL` | `nr_documento` | `integer NULL` | [RENAME] [RETYPE] | Numero do documento origem; prefixo `nr_` |
| `datainsercao` | `timestamp NULL` | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Mapear campo de insercao para coluna de auditoria padrao `created_at` |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

Nao existe surrogate key. A chave natural composta e: `(id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento)`.

```sql
id bigserial PRIMARY KEY,
UNIQUE (id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento)
```

#### Relacionamentos propostos

```
eventos.f_credito_contabil_evento
  |- id_empresa       -> (sem dimensao de empresa no schema; referencia semantica a id_empresa nos demais schemas)
  |- cod_centro_custo -> (sem dimensao de centro de custo declarada no schema eventos)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_f_credito_contabil_evento
    ON eventos.f_credito_contabil_evento (id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento);

CREATE INDEX idx_f_credito_contabil_evento_dth_lancamento
    ON eventos.f_credito_contabil_evento (dth_lancamento);

CREATE INDEX idx_f_credito_contabil_evento_cod_centro_custo
    ON eventos.f_credito_contabil_evento (cod_centro_custo);

CREATE INDEX idx_f_credito_contabil_evento_id_empresa
    ON eventos.f_credito_contabil_evento (id_empresa);
```

#### Impacto no ETL

- `contabilizado` (0/1 numeric) deve ser convertido para `boolean` no pipeline: `CASE WHEN contabilizado = 1 THEN TRUE ELSE FALSE END`.
- `datainsercao` deve ser mapeado para `created_at`; nao enviar pelo ETL — usar DEFAULT do banco na carga incremental.
- Todos os campos `numeric(n)` sem casas decimais devem ser lidos como `int64` no pandas e inseridos nos tipos inteiros correspondentes.
- O campo `debito_credito` deve ser validado como `'D'` ou `'C'` antes da carga.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.f_credito_contabil_evento (
    id                         bigserial    PRIMARY KEY,
    id_empresa                 smallint     NULL,
    nr_exercicio               smallint     NULL,
    nr_lancamento              integer      NULL,
    nr_seq_lancamento          smallint     NULL,
    id_origem                  smallint     NULL,
    nr_lote                    integer      NULL,
    nr_periodo                 smallint     NULL,
    ds_conta_contabil          varchar(30)  NULL,
    nr_conta_reduzida          integer      NULL,
    nr_subconta                smallint     NULL,
    cod_centro_custo           integer      NULL,
    ds_debito_credito          char(1)      NULL,
    id_historico_contabil      smallint     NULL,
    obs_complemento_historico  text         NULL,
    dth_lancamento             timestamp    NULL,
    vl_lancamento              numeric(15,2) NULL,
    id_filial                  smallint     NULL,
    fl_contabilizado           boolean      NULL,
    dth_contabilizacao         timestamp    NULL,
    nr_documento               integer      NULL,
    created_at                 timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at                 timestamp    NOT NULL DEFAULT current_timestamp,
    CONSTRAINT uq_f_credito_contabil_evento
        UNIQUE (id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento)
);

-- 2. Migrar dados
INSERT INTO eventos.f_credito_contabil_evento (
    id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento,
    id_origem, nr_lote, nr_periodo, ds_conta_contabil,
    nr_conta_reduzida, nr_subconta, cod_centro_custo, ds_debito_credito,
    id_historico_contabil, obs_complemento_historico, dth_lancamento,
    vl_lancamento, id_filial, fl_contabilizado, dth_contabilizacao,
    nr_documento, created_at
)
SELECT
    cod_empresa::smallint, exercicio::smallint, numero_lanc::integer,
    seq_lanc::smallint, origem::smallint, lote::integer, periodo::smallint,
    conta_contabil, conta_reduzida::integer, subconta::smallint,
    centro_custo::integer, debito_credito, hist_contabil::smallint,
    compl_histor1, data_lancto, valor_lancto, filial_lancto::smallint,
    CASE WHEN contabilizado = 1 THEN TRUE ELSE FALSE END,
    data_contab, documento::integer,
    COALESCE(datainsercao, current_timestamp)
FROM eventos.fcreditos_eventos;

-- 3. Indices
CREATE INDEX idx_f_credito_contabil_evento_dth_lancamento
    ON eventos.f_credito_contabil_evento (dth_lancamento);
CREATE INDEX idx_f_credito_contabil_evento_cod_centro_custo
    ON eventos.f_credito_contabil_evento (cod_centro_custo);
CREATE INDEX idx_f_credito_contabil_evento_id_empresa
    ON eventos.f_credito_contabil_evento (id_empresa);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.fcreditos_eventos AS
    SELECT
        id_empresa      AS cod_empresa,
        nr_exercicio    AS exercicio,
        nr_lancamento   AS numero_lanc,
        nr_seq_lancamento AS seq_lanc,
        id_origem       AS origem,
        nr_lote         AS lote,
        nr_periodo      AS periodo,
        ds_conta_contabil AS conta_contabil,
        nr_conta_reduzida AS conta_reduzida,
        nr_subconta     AS subconta,
        cod_centro_custo AS centro_custo,
        ds_debito_credito AS debito_credito,
        id_historico_contabil AS hist_contabil,
        obs_complemento_historico AS compl_histor1,
        dth_lancamento  AS data_lancto,
        vl_lancamento   AS valor_lancto,
        id_filial       AS filial_lancto,
        fl_contabilizado::integer AS contabilizado,
        dth_contabilizacao AS data_contab,
        nr_documento    AS documento,
        created_at      AS datainsercao
    FROM eventos.f_credito_contabil_evento;
COMMENT ON VIEW eventos.fcreditos_eventos IS
    'DEPRECATED 2026-05-05: usar f_credito_contabil_evento. Sera removido em 2026-08-03.';
```

---

### eventos.fdebitos_eventos

**Nome proposto:** `eventos.f_debito_contabil_evento`
**Tipo:** fato
**Descricao:** Lancamentos contabeis de debito relacionados a eventos. Estrutura identica a `fcreditos_eventos` — cada linha representa um lancamento de debito no plano de contas do ERP. As duas tabelas formam o par debito/credito da contabilidade por partidas dobradas.
**Sistema de origem:** ERP / sistema contabil interno

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `cod_empresa` | `numeric(3) NULL` | `id_empresa` | `smallint NULL` | [RENAME] [RETYPE] | Idem `fcreditos_eventos` |
| `exercicio` | `numeric(4) NULL` | `nr_exercicio` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `numero_lanc` | `numeric(9) NULL` | `nr_lancamento` | `integer NULL` | [RENAME] [RETYPE] | Idem |
| `seq_lanc` | `numeric(5) NULL` | `nr_seq_lancamento` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `origem` | `numeric(2) NULL` | `id_origem` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `lote` | `numeric(5) NULL` | `nr_lote` | `integer NULL` | [RENAME] [RETYPE] | Idem |
| `periodo` | `numeric(4) NULL` | `nr_periodo` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `conta_contabil` | `text NULL` | `ds_conta_contabil` | `varchar(30) NULL` | [RENAME] [RETYPE] | Idem |
| `conta_reduzida` | `numeric(5) NULL` | `nr_conta_reduzida` | `integer NULL` | [RENAME] [RETYPE] | Idem |
| `subconta` | `numeric(4) NULL` | `nr_subconta` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `centro_custo` | `numeric(6) NULL` | `cod_centro_custo` | `integer NULL` | [RENAME] [RETYPE] | Idem |
| `debito_credito` | `text NULL` | `ds_debito_credito` | `char(1) NULL` | [RENAME] [RETYPE] | Idem |
| `hist_contabil` | `numeric(4) NULL` | `id_historico_contabil` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `compl_histor1` | `text NULL` | `obs_complemento_historico` | `text NULL` | [RENAME] | Idem |
| `data_lancto` | `timestamp NULL` | `dth_lancamento` | `timestamp NULL` | [RENAME] | Idem |
| `valor_lancto` | `numeric(15,2) NULL` | `vl_lancamento` | `numeric(15,2) NULL` | [RENAME] | Idem |
| `filial_lancto` | `numeric(3) NULL` | `id_filial` | `smallint NULL` | [RENAME] [RETYPE] | Idem |
| `contabilizado` | `numeric(1) NULL` | `fl_contabilizado` | `boolean NULL` | [RENAME] [RETYPE] | Idem |
| `data_contab` | `timestamp NULL` | `dth_contabilizacao` | `timestamp NULL` | [RENAME] | Idem |
| `documento` | `numeric(9) NULL` | `nr_documento` | `integer NULL` | [RENAME] [RETYPE] | Idem |
| `datainsercao` | `timestamp NULL` | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Idem |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

> Esta tabela e estruturalmente identica a `fcreditos_eventos`. As propostas de migracao, relacionamentos e indices seguem o mesmo padrao. Ver secao `eventos.fcreditos_eventos` para o DDL completo, substituindo o nome da tabela por `f_debito_contabil_evento` e da view por `fdebitos_eventos`.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
UNIQUE (id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento)
```

#### Relacionamentos propostos

```
eventos.f_debito_contabil_evento
  |- id_empresa       -> (referencia semantica)
  |- cod_centro_custo -> (sem dimensao declarada no schema)
  |- (nr_lancamento, nr_seq_lancamento) <-> eventos.f_credito_contabil_evento (mesma chave — partida dobrada)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_f_debito_contabil_evento
    ON eventos.f_debito_contabil_evento (id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento);

CREATE INDEX idx_f_debito_contabil_evento_dth_lancamento
    ON eventos.f_debito_contabil_evento (dth_lancamento);

CREATE INDEX idx_f_debito_contabil_evento_cod_centro_custo
    ON eventos.f_debito_contabil_evento (cod_centro_custo);
```

#### Impacto no ETL

Identico ao de `fcreditos_eventos`. O DAG de carga provavelmente e o mesmo ou espelhado — verificar se e possivel unificar em uma unica tabela com coluna `ds_debito_credito char(1)` (`'D'` / `'C'`), eliminando a duplicacao estrutural.

#### Migracao SQL

```sql
-- 1. Criar tabela nova (estrutura identica a f_credito_contabil_evento)
CREATE TABLE eventos.f_debito_contabil_evento (
    id                         bigserial    PRIMARY KEY,
    id_empresa                 smallint     NULL,
    nr_exercicio               smallint     NULL,
    nr_lancamento              integer      NULL,
    nr_seq_lancamento          smallint     NULL,
    id_origem                  smallint     NULL,
    nr_lote                    integer      NULL,
    nr_periodo                 smallint     NULL,
    ds_conta_contabil          varchar(30)  NULL,
    nr_conta_reduzida          integer      NULL,
    nr_subconta                smallint     NULL,
    cod_centro_custo           integer      NULL,
    ds_debito_credito          char(1)      NULL,
    id_historico_contabil      smallint     NULL,
    obs_complemento_historico  text         NULL,
    dth_lancamento             timestamp    NULL,
    vl_lancamento              numeric(15,2) NULL,
    id_filial                  smallint     NULL,
    fl_contabilizado           boolean      NULL,
    dth_contabilizacao         timestamp    NULL,
    nr_documento               integer      NULL,
    created_at                 timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at                 timestamp    NOT NULL DEFAULT current_timestamp,
    CONSTRAINT uq_f_debito_contabil_evento
        UNIQUE (id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento)
);

-- 2. Migrar dados (mesma logica de fcreditos_eventos)
INSERT INTO eventos.f_debito_contabil_evento (
    id_empresa, nr_exercicio, nr_lancamento, nr_seq_lancamento,
    id_origem, nr_lote, nr_periodo, ds_conta_contabil,
    nr_conta_reduzida, nr_subconta, cod_centro_custo, ds_debito_credito,
    id_historico_contabil, obs_complemento_historico, dth_lancamento,
    vl_lancamento, id_filial, fl_contabilizado, dth_contabilizacao,
    nr_documento, created_at
)
SELECT
    cod_empresa::smallint, exercicio::smallint, numero_lanc::integer,
    seq_lanc::smallint, origem::smallint, lote::integer, periodo::smallint,
    conta_contabil, conta_reduzida::integer, subconta::smallint,
    centro_custo::integer, debito_credito, hist_contabil::smallint,
    compl_histor1, data_lancto, valor_lancto, filial_lancto::smallint,
    CASE WHEN contabilizado = 1 THEN TRUE ELSE FALSE END,
    data_contab, documento::integer,
    COALESCE(datainsercao, current_timestamp)
FROM eventos.fdebitos_eventos;

-- 3. View de compatibilidade
CREATE OR REPLACE VIEW eventos.fdebitos_eventos AS
    SELECT
        id_empresa      AS cod_empresa,
        nr_exercicio    AS exercicio,
        nr_lancamento   AS numero_lanc,
        nr_seq_lancamento AS seq_lanc,
        id_origem       AS origem,
        nr_lote         AS lote,
        nr_periodo      AS periodo,
        ds_conta_contabil AS conta_contabil,
        nr_conta_reduzida AS conta_reduzida,
        nr_subconta     AS subconta,
        cod_centro_custo AS centro_custo,
        ds_debito_credito AS debito_credito,
        id_historico_contabil AS hist_contabil,
        obs_complemento_historico AS compl_histor1,
        dth_lancamento  AS data_lancto,
        vl_lancamento   AS valor_lancto,
        id_filial       AS filial_lancto,
        fl_contabilizado::integer AS contabilizado,
        dth_contabilizacao AS data_contab,
        nr_documento    AS documento,
        created_at      AS datainsercao
    FROM eventos.f_debito_contabil_evento;
COMMENT ON VIEW eventos.fdebitos_eventos IS
    'DEPRECATED 2026-05-05: usar f_debito_contabil_evento. Sera removido em 2026-08-03.';
```

---

### eventos.fexperience_events

**Nome proposto:** `eventos.d_evento`
**Tipo:** dimensao
**Descricao:** Catalogo de eventos da plataforma Experience. Cada linha representa um evento unico com suas configuracoes (modalidade, distancia, limites de inscricao, datas de abertura/encerramento e localizacao). E a dimensao central do schema, referenciada por inscricoes e itens de carrinho.
**Sistema de origem:** API Experience

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int8 NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | Deve ser surrogate key `bigserial PRIMARY KEY`; atualmente nullable e sem PK |
| `event_id` | `int8 NULL` | `cod_evento` | `integer NULL` | [RENAME] [RETYPE] [CONFLITO] | Chave de negocio do sistema de origem; prefixo `cod_`; nome em ingles — conflito de padrao |
| `event_name` | `text NULL` | `nm_evento` | `varchar(150) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; renomear; limitar tamanho |
| `event_status` | `text NULL` | `ds_status` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; renomear; limitar tamanho |
| `event_type` | `text NULL` | `ds_tipo_evento` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; renomear |
| `modality` | `text NULL` | `ds_modalidade` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; renomear |
| `registration_limit` | `int8 NULL` | `qt_limite_inscricao` | `integer NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; prefixo `qt_`; `int8` excessivo — `integer` suficiente |
| `distance` | `text NULL` | `ds_distancia` | `varchar(30) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; renomear; limitar tamanho |
| `start_time` | `text NULL` | `ds_horario_inicio` | `varchar(10) NULL` | [RENAME] [RETYPE] [CONFLITO] | Armazenado como texto (ex.: "07:30"); manter como varchar ate confirmacao do formato |
| `min_subscription_age` | `int8 NULL` | `qt_idade_minima` | `smallint NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; prefixo `qt_`; `smallint` suficiente para idade |
| `max_subscription_age` | `int8 NULL` | `qt_idade_maxima` | `smallint NULL` | [RENAME] [RETYPE] [CONFLITO] | Idem |
| `event_date` | `date NULL` | `dt_evento` | `date NULL` | [RENAME] [CONFLITO] | Nome em ingles; renomear; tipo `date` ja correto |
| `subscriptions_opened` | `date NULL` | `dt_abertura_inscricao` | `date NULL` | [RENAME] [CONFLITO] | Nome em ingles; renomear |
| `subscriptions_closed` | `date NULL` | `dt_encerramento_inscricao` | `date NULL` | [RENAME] [CONFLITO] | Nome em ingles; renomear |
| `event_address` | `text NULL` | `end_logradouro_evento` | `varchar(200) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; renomear; usar prefixo `end_` |
| `event_photo` | `text NULL` | `nm_url_foto` | `text NULL` | [RENAME] [CONFLITO] | URL da foto; nome em ingles; renomear |
| `results_link` | `text NULL` | `nm_url_resultados` | `text NULL` | [RENAME] [CONFLITO] | URL de resultados; nome em ingles |
| `start_location` | `text NULL` | `ds_local_largada` | `text NULL` | [RENAME] [CONFLITO] | Nome em ingles; renomear |
| `map` | `text NULL` | `nm_url_mapa` | `text NULL` | [RENAME] [CONFLITO] | URL ou embed de mapa; nome em ingles e palavra reservada potencial |
| `event_description` | `text NULL` | `obs_descricao` | `text NULL` | [RENAME] [CONFLITO] | Texto livre; nome em ingles; prefixo `obs_` |
| `created_at` | `timestamp NULL` | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Coluna de auditoria ja existe; tornar NOT NULL |
| `updated_at` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Idem |

**Flags:** [RENAME] [RETYPE] [CONFLITO]

**Observacao de CONFLITO:** Todas as colunas de negocio estao em ingles (API externa). O padrao do DW exige portugues para entidades de negocio. Cada coluna recebe flag `[CONFLITO]`. O `map` e palavra reservada em algumas versoes de SQL — deve ser renomeado.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
UNIQUE (cod_evento)   -- business key do sistema de origem
```

#### Relacionamentos propostos

```
eventos.d_evento
  |- cod_evento (UNIQUE) <- eventos.f_item_carrinho.cod_evento
  |- cod_evento (UNIQUE) <- eventos.fexperience_registrations.event_id  (apos normalizacao)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_d_evento_cod_evento
    ON eventos.d_evento (cod_evento);

CREATE INDEX idx_d_evento_dt_evento
    ON eventos.d_evento (dt_evento);

CREATE INDEX idx_d_evento_ds_status
    ON eventos.d_evento (ds_status);
```

#### Impacto no ETL

- Renomear todos os aliases no DAG de ingestao da API Experience.
- `start_time` vindo como texto da API deve ser validado (formato `HH:MM` ou `HH:MM:SS`) antes da carga.
- `registration_limit`, `min_subscription_age`, `max_subscription_age` vem como `int8` da API — truncar para `integer`/`smallint`.
- `created_at` e `updated_at` ja existem; tornar NOT NULL no banco com ALTER TABLE.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.d_evento (
    id                         bigserial    PRIMARY KEY,
    cod_evento                 integer      NULL,
    nm_evento                  varchar(150) NULL,
    ds_status                  varchar(50)  NULL,
    ds_tipo_evento             varchar(50)  NULL,
    ds_modalidade              varchar(50)  NULL,
    qt_limite_inscricao        integer      NULL,
    ds_distancia               varchar(30)  NULL,
    ds_horario_inicio          varchar(10)  NULL,
    qt_idade_minima            smallint     NULL,
    qt_idade_maxima            smallint     NULL,
    dt_evento                  date         NULL,
    dt_abertura_inscricao      date         NULL,
    dt_encerramento_inscricao  date         NULL,
    end_logradouro_evento      varchar(200) NULL,
    nm_url_foto                text         NULL,
    nm_url_resultados          text         NULL,
    ds_local_largada           text         NULL,
    nm_url_mapa                text         NULL,
    obs_descricao              text         NULL,
    created_at                 timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at                 timestamp    NOT NULL DEFAULT current_timestamp,
    CONSTRAINT uq_d_evento_cod_evento UNIQUE (cod_evento)
);

-- 2. Migrar dados
INSERT INTO eventos.d_evento (
    cod_evento, nm_evento, ds_status, ds_tipo_evento, ds_modalidade,
    qt_limite_inscricao, ds_distancia, ds_horario_inicio,
    qt_idade_minima, qt_idade_maxima, dt_evento,
    dt_abertura_inscricao, dt_encerramento_inscricao,
    end_logradouro_evento, nm_url_foto, nm_url_resultados,
    ds_local_largada, nm_url_mapa, obs_descricao,
    created_at, updated_at
)
SELECT
    event_id::integer, event_name, event_status, event_type, modality,
    registration_limit::integer, distance, start_time,
    min_subscription_age::smallint, max_subscription_age::smallint, event_date,
    subscriptions_opened, subscriptions_closed,
    event_address, event_photo, results_link,
    start_location, "map", event_description,
    COALESCE(created_at, current_timestamp),
    COALESCE(updated_at, current_timestamp)
FROM eventos.fexperience_events;

-- 3. Indices
CREATE UNIQUE INDEX uq_d_evento_cod_evento ON eventos.d_evento (cod_evento);
CREATE INDEX idx_d_evento_dt_evento        ON eventos.d_evento (dt_evento);
CREATE INDEX idx_d_evento_ds_status        ON eventos.d_evento (ds_status);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.fexperience_events AS
    SELECT
        id              AS id,
        cod_evento      AS event_id,
        nm_evento       AS event_name,
        ds_status       AS event_status,
        ds_tipo_evento  AS event_type,
        ds_modalidade   AS modality,
        qt_limite_inscricao AS registration_limit,
        ds_distancia    AS distance,
        ds_horario_inicio AS start_time,
        qt_idade_minima AS min_subscription_age,
        qt_idade_maxima AS max_subscription_age,
        dt_evento       AS event_date,
        dt_abertura_inscricao AS subscriptions_opened,
        dt_encerramento_inscricao AS subscriptions_closed,
        end_logradouro_evento AS event_address,
        nm_url_foto     AS event_photo,
        nm_url_resultados AS results_link,
        ds_local_largada AS start_location,
        nm_url_mapa     AS "map",
        obs_descricao   AS event_description,
        created_at,
        updated_at
    FROM eventos.d_evento;
COMMENT ON VIEW eventos.fexperience_events IS
    'DEPRECATED 2026-05-05: usar d_evento. Sera removido em 2026-08-03.';
```

---

### eventos.fexperience_registrations

**Nome proposto:** `eventos.f_inscricao_evento`
**Tipo:** fato
**Descricao:** Inscricoes de participantes em eventos da plataforma Experience. Cada linha representa uma inscricao confirmada, ligando o participante (CPF/CNPJ), o evento (`event_id`), a loja de origem, e os dados de pagamento e kit. E a principal tabela de fatos do schema, integrando dados de pessoas, eventos e valores pagos.
**Sistema de origem:** API Experience

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int8 NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | Surrogate key; tornar `bigserial PRIMARY KEY` |
| `event_id` | `int8 NULL` | `cod_evento` | `integer NULL` | [RENAME] [RETYPE] [CONFLITO] | Join key para `d_evento`; nome em ingles |
| `modality` | `text NULL` | `ds_modalidade` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; limitar tamanho |
| `distance` | `text NULL` | `ds_distancia` | `varchar(30) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; limitar tamanho |
| `chest_number` | `text NULL` | `nr_peito` | `varchar(20) NULL` | [RENAME] [RETYPE] [CONFLITO] | Numero de peito; nome em ingles; prefixo `nr_` |
| `store_cnpj` | `text NULL` | `cnpj_loja` | `varchar(16) NULL` | [RENAME] [RETYPE] [CONFLITO] | CNPJ da loja de venda; nome em ingles; formato padrao DW `varchar(16)` |
| `store_name` | `text NULL` | `nm_loja` | `varchar(100) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome da loja; nome em ingles |
| `cpf_cnpj` | `text NULL` | `cpf_cnpj_participante` | `varchar(16) NULL` | [RENAME] [RETYPE] | Campo misto CPF/CNPJ; padrao DW `varchar(16)`; renomear com sufixo de entidade |
| `birthday` | `date NULL` | `dt_nascimento` | `date NULL` | [RENAME] [CONFLITO] | Nome em ingles; tipo `date` ja correto |
| `gender` | `text NULL` | `ds_genero` | `varchar(20) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; limitar tamanho |
| `order_date` | `timestamp NULL` | `dth_pedido` | `timestamp NULL` | [RENAME] [CONFLITO] | Nome em ingles; tipo `timestamp` ja correto — manter como timestamp pois tem hora |
| `order_id` | `text NULL` | `nr_pedido` | `varchar(30) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; tipo `text` — verificar formato; reduzir para `varchar(30)` |
| `order_status` | `text NULL` | `ds_status_pedido` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Nome em ingles; limitar tamanho |
| `coupon` | `text NULL` | `ds_cupom` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Codigo do cupom; nome em ingles; limitar tamanho |
| `coupon_group` | `text NULL` | `ds_grupo_cupom` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Grupo do cupom; nome em ingles |
| `payment_type` | `text NULL` | `ds_tipo_pagamento` | `varchar(30) NULL` | [RENAME] [RETYPE] [CONFLITO] | Forma de pagamento; nome em ingles |
| `kit` | `text NULL` | `ds_kit` | `varchar(50) NULL` | [RENAME] [RETYPE] [CONFLITO] | Kit selecionado; nome em ingles |
| `cart_items` | `text NULL` | `obs_itens_carrinho` | `text NULL` | [RENAME] [CONFLITO] | JSON ou lista de itens; nome em ingles; prefixo `obs_` como texto livre |
| `price_paid` | `float8 NULL` | `vl_pago` | `numeric(15,2) NULL` | [RENAME] [RETYPE] [CONFLITO] | Valor pago; nome em ingles; `float8` deve ser `numeric(15,2)` para valores financeiros |
| `created_at` | `timestamp NULL` | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Auditoria; tornar NOT NULL |
| `updated_at` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Auditoria; tornar NOT NULL |

**Flags:** [RENAME] [RETYPE] [CONFLITO]

**Observacao de CONFLITO:** `price_paid` e `float8` — tipo inadequado para valores financeiros (perde precisao decimal). Converter para `numeric(15,2)` e obrigatorio. `order_id` e `text` aqui, mas `int4` em `ditens_carrinho` — inconsistencia estrutural a ser resolvida antes da integracao.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Adicionar indice unico em `(cod_evento, cpf_cnpj_participante, nr_pedido)` como controle de duplicidade de negocio.

#### Relacionamentos propostos

```
eventos.f_inscricao_evento
  |- cod_evento               -> eventos.d_evento.cod_evento
  |- cnpj_loja                -> (sem dimensao de loja no schema eventos)
  |- cpf_cnpj_participante    -> eventos.d_inscricao_evento.cpf_participante (join por CPF)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_inscricao_evento_cod_evento
    ON eventos.f_inscricao_evento (cod_evento);

CREATE INDEX idx_f_inscricao_evento_cpf_cnpj_participante
    ON eventos.f_inscricao_evento (cpf_cnpj_participante);

CREATE INDEX idx_f_inscricao_evento_dth_pedido
    ON eventos.f_inscricao_evento (dth_pedido);

CREATE INDEX idx_f_inscricao_evento_ds_status_pedido
    ON eventos.f_inscricao_evento (ds_status_pedido);
```

#### Impacto no ETL

- `price_paid float8` no SELECT de origem deve ser convertido via `ROUND(price_paid::numeric, 2)` antes do insert.
- `order_id text` diverge de `ditens_carrinho.order_id int4` — o pipeline deve normalizar o tipo. Recomenda-se manter como `varchar(30)` e adaptar o join.
- Todos os aliases no DAG de ingestao da API Experience devem ser atualizados.
- `cpf_cnpj` deve ser formatado para o padrao DW usando a funcao `dw.fn_formatar_cnpj_cpf`.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.f_inscricao_evento (
    id                      bigserial    PRIMARY KEY,
    cod_evento              integer      NULL,
    ds_modalidade           varchar(50)  NULL,
    ds_distancia            varchar(30)  NULL,
    nr_peito                varchar(20)  NULL,
    cnpj_loja               varchar(16)  NULL,
    nm_loja                 varchar(100) NULL,
    cpf_cnpj_participante   varchar(16)  NULL,
    dt_nascimento           date         NULL,
    ds_genero               varchar(20)  NULL,
    dth_pedido              timestamp    NULL,
    nr_pedido               varchar(30)  NULL,
    ds_status_pedido        varchar(50)  NULL,
    ds_cupom                varchar(50)  NULL,
    ds_grupo_cupom          varchar(50)  NULL,
    ds_tipo_pagamento       varchar(30)  NULL,
    ds_kit                  varchar(50)  NULL,
    obs_itens_carrinho      text         NULL,
    vl_pago                 numeric(15,2) NULL,
    created_at              timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at              timestamp    NOT NULL DEFAULT current_timestamp
);

-- 2. Migrar dados
INSERT INTO eventos.f_inscricao_evento (
    cod_evento, ds_modalidade, ds_distancia, nr_peito,
    cnpj_loja, nm_loja, cpf_cnpj_participante, dt_nascimento,
    ds_genero, dth_pedido, nr_pedido, ds_status_pedido,
    ds_cupom, ds_grupo_cupom, ds_tipo_pagamento, ds_kit,
    obs_itens_carrinho, vl_pago,
    created_at, updated_at
)
SELECT
    event_id::integer, modality, distance, chest_number,
    store_cnpj, store_name, cpf_cnpj, birthday,
    gender, order_date, order_id, order_status,
    coupon, coupon_group, payment_type, kit,
    cart_items, ROUND(price_paid::numeric, 2),
    COALESCE(created_at, current_timestamp),
    COALESCE(updated_at, current_timestamp)
FROM eventos.fexperience_registrations;

-- 3. Indices
CREATE INDEX idx_f_inscricao_evento_cod_evento
    ON eventos.f_inscricao_evento (cod_evento);
CREATE INDEX idx_f_inscricao_evento_cpf_cnpj_participante
    ON eventos.f_inscricao_evento (cpf_cnpj_participante);
CREATE INDEX idx_f_inscricao_evento_dth_pedido
    ON eventos.f_inscricao_evento (dth_pedido);
CREATE INDEX idx_f_inscricao_evento_ds_status_pedido
    ON eventos.f_inscricao_evento (ds_status_pedido);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.fexperience_registrations AS
    SELECT
        id,
        cod_evento      AS event_id,
        ds_modalidade   AS modality,
        ds_distancia    AS distance,
        nr_peito        AS chest_number,
        cnpj_loja       AS store_cnpj,
        nm_loja         AS store_name,
        cpf_cnpj_participante AS cpf_cnpj,
        dt_nascimento   AS birthday,
        ds_genero       AS gender,
        dth_pedido      AS order_date,
        nr_pedido       AS order_id,
        ds_status_pedido AS order_status,
        ds_cupom        AS coupon,
        ds_grupo_cupom  AS coupon_group,
        ds_tipo_pagamento AS payment_type,
        ds_kit          AS kit,
        obs_itens_carrinho AS cart_items,
        vl_pago::float8 AS price_paid,
        created_at,
        updated_at
    FROM eventos.f_inscricao_evento;
COMMENT ON VIEW eventos.fexperience_registrations IS
    'DEPRECATED 2026-05-05: usar f_inscricao_evento. Sera removido em 2026-08-03.';
```

---

### eventos.fnotas_compras_eventos

**Nome proposto:** `eventos.f_nota_compra_evento`
**Tipo:** fato
**Descricao:** Notas fiscais de compra (entrada) associadas a eventos. Cada linha representa um item de nota fiscal de compra de insumos ou servicos para realizacao de eventos, com dados de fornecedor, produto, quantidades e valores. Granularidade: item de nota fiscal.
**Sistema de origem:** ERP / sistema de compras interno

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `serie` | `text NULL` | `ds_serie` | `varchar(5) NULL` | [RENAME] [RETYPE] | Serie da nota fiscal; limitar tamanho; prefixo `ds_` |
| `documento` | `numeric(9) NULL` | `nr_nota_fiscal` | `integer NULL` | [RENAME] [RETYPE] | Numero do documento fiscal; prefixo `nr_`; nome canonico do DW |
| `sequencia` | `numeric(9) NULL` | `nr_sequencia` | `integer NULL` | [RENAME] [RETYPE] | Sequencia do item na nota; prefixo `nr_` |
| `centro_custo` | `numeric(9) NULL` | `cod_centro_custo` | `integer NULL` | [RENAME] [RETYPE] | Chave de negocio; prefixo `cod_` |
| `nome_centro_custo` | `text NULL` | `nm_centro_custo` | `varchar(60) NULL` | [RENAME] [RETYPE] | Prefixo proibido `nome_`; usar `nm_`; limitar tamanho |
| `especie_docto` | `text NULL` | `ds_especie_docto` | `varchar(10) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `data_transacao` | `timestamp NULL` | `dt_transacao` | `date NULL` | [RENAME] [RETYPE] | Campo e data sem hora (semantica de dia); converter para `date` |
| `data_emissao` | `timestamp NULL` | `dt_emissao` | `date NULL` | [RENAME] [RETYPE] | Idem — data de emissao sem hora |
| `cod_produto` | `text NULL` | `cod_produto` | `varchar(30) NULL` | [RETYPE] | Nome ja usa `cod_`; limitar tamanho |
| `descricao_item` | `text NULL` | `ds_item` | `varchar(150) NULL` | [RENAME] [RETYPE] | Prefixo proibido `descricao_`; usar `ds_`; limitar tamanho |
| `desc_natureza_oper` | `text NULL` | `ds_natureza_operacao` | `varchar(60) NULL` | [RENAME] [RETYPE] | Expandir abreviacao; prefixo `ds_`; limitar tamanho |
| `cod_situacao_nota` | `numeric(1) NULL` | `id_situacao_nota` | `smallint NULL` | [RENAME] [RETYPE] | Codigo operacional de categoria; prefixo `id_`; `smallint` suficiente |
| `desc_situacao_nota` | `text NULL` | `ds_situacao_nota` | `varchar(40) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `codigo_cancelamento_pedido` | `numeric(2) NULL` | `id_cancelamento_pedido` | `smallint NULL` | [RENAME] [RETYPE] | Codigo operacional; prefixo `id_`; prefixo proibido `codigo_` |
| `desc_cancelamento_pedido` | `text NULL` | `ds_cancelamento_pedido` | `varchar(80) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `data_canc_nfisc` | `timestamp NULL` | `dt_cancelamento_nf` | `date NULL` | [RENAME] [RETYPE] | Data de cancelamento; converter para `date` |
| `cnpj_fornecedor` | `text NULL` | `cnpj_fornecedor` | `varchar(16) NULL` | [RETYPE] | Nome ja correto; padronizar tipo para `varchar(16)` |
| `nome_fornecedor` | `text NULL` | `nm_fornecedor` | `varchar(60) NULL` | [RENAME] [RETYPE] | Prefixo proibido `nome_`; usar `nm_`; limitar tamanho |
| `cod_tipo_fornecedor` | `numeric(4) NULL` | `id_tipo_fornecedor` | `smallint NULL` | [RENAME] [RETYPE] | Codigo operacional de categoria; prefixo `id_` |
| `desc_tipo_fornecedor` | `text NULL` | `ds_tipo_fornecedor` | `varchar(40) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `desc_cond_pgto` | `text NULL` | `ds_condicao_pagamento` | `varchar(40) NULL` | [RENAME] [RETYPE] | Expandir abreviacao; prefixo `ds_`; limitar tamanho |
| `unidade_medida` | `text NULL` | `ds_unidade_medida` | `varchar(10) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `quantidade` | `numeric(14,3) NULL` | `qt_item` | `numeric(15,3) NULL` | [RENAME] [RETYPE] | Prefixo `qt_`; padronizar precisao para `numeric(15,3)` |
| `valor_unitario` | `numeric(20,5) NULL` | `vl_unitario` | `numeric(15,5) NULL` | [RENAME] [RETYPE] | Prefixo `vl_`; `numeric(20,5)` excessivo; `numeric(15,5)` adequado |
| `valor_total` | `numeric(15,2) NULL` | `vl_total` | `numeric(15,2) NULL` | [RENAME] | Prefixo `vl_`; precisao ja correta |
| `data_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Mapear para coluna de auditoria padrao `updated_at` |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

Nao existe surrogate key. Chave natural composta: `(nr_nota_fiscal, ds_serie, nr_sequencia)`.

```sql
id bigserial PRIMARY KEY,
UNIQUE (nr_nota_fiscal, ds_serie, nr_sequencia)
```

#### Relacionamentos propostos

```
eventos.f_nota_compra_evento
  |- cnpj_fornecedor   -> (sem d_fornecedor no schema eventos; referencia semantica ao schema comercial ou similar)
  |- cod_centro_custo  -> (sem dimensao de centro de custo declarada)
  |- cod_produto       -> (sem d_produto no schema eventos)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_f_nota_compra_evento
    ON eventos.f_nota_compra_evento (nr_nota_fiscal, ds_serie, nr_sequencia);

CREATE INDEX idx_f_nota_compra_evento_cnpj_fornecedor
    ON eventos.f_nota_compra_evento (cnpj_fornecedor);

CREATE INDEX idx_f_nota_compra_evento_dt_emissao
    ON eventos.f_nota_compra_evento (dt_emissao);

CREATE INDEX idx_f_nota_compra_evento_cod_centro_custo
    ON eventos.f_nota_compra_evento (cod_centro_custo);
```

#### Impacto no ETL

- `data_transacao` e `data_emissao` chegam como `timestamp` do ERP — extrair apenas a data com `.dt.date` no pandas ou `::date` no SQL.
- `data_canc_nfisc` idem.
- `data_atualizacao` deve ser usado como watermark de carga incremental (mapear para `updated_at`).
- `valor_unitario numeric(20,5)` pode causar overflow no pandas com `float64` — usar `Decimal` ou `numeric(15,5)`.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.f_nota_compra_evento (
    id                      bigserial    PRIMARY KEY,
    ds_serie                varchar(5)   NULL,
    nr_nota_fiscal          integer      NULL,
    nr_sequencia            integer      NULL,
    cod_centro_custo        integer      NULL,
    nm_centro_custo         varchar(60)  NULL,
    ds_especie_docto        varchar(10)  NULL,
    dt_transacao            date         NULL,
    dt_emissao              date         NULL,
    cod_produto             varchar(30)  NULL,
    ds_item                 varchar(150) NULL,
    ds_natureza_operacao    varchar(60)  NULL,
    id_situacao_nota        smallint     NULL,
    ds_situacao_nota        varchar(40)  NULL,
    id_cancelamento_pedido  smallint     NULL,
    ds_cancelamento_pedido  varchar(80)  NULL,
    dt_cancelamento_nf      date         NULL,
    cnpj_fornecedor         varchar(16)  NULL,
    nm_fornecedor           varchar(60)  NULL,
    id_tipo_fornecedor      smallint     NULL,
    ds_tipo_fornecedor      varchar(40)  NULL,
    ds_condicao_pagamento   varchar(40)  NULL,
    ds_unidade_medida       varchar(10)  NULL,
    qt_item                 numeric(15,3) NULL,
    vl_unitario             numeric(15,5) NULL,
    vl_total                numeric(15,2) NULL,
    created_at              timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at              timestamp    NOT NULL DEFAULT current_timestamp,
    CONSTRAINT uq_f_nota_compra_evento UNIQUE (nr_nota_fiscal, ds_serie, nr_sequencia)
);

-- 2. Migrar dados
INSERT INTO eventos.f_nota_compra_evento (
    ds_serie, nr_nota_fiscal, nr_sequencia, cod_centro_custo, nm_centro_custo,
    ds_especie_docto, dt_transacao, dt_emissao, cod_produto, ds_item,
    ds_natureza_operacao, id_situacao_nota, ds_situacao_nota,
    id_cancelamento_pedido, ds_cancelamento_pedido, dt_cancelamento_nf,
    cnpj_fornecedor, nm_fornecedor, id_tipo_fornecedor, ds_tipo_fornecedor,
    ds_condicao_pagamento, ds_unidade_medida, qt_item, vl_unitario, vl_total,
    updated_at
)
SELECT
    serie, documento::integer, sequencia::integer,
    centro_custo::integer, nome_centro_custo,
    especie_docto, data_transacao::date, data_emissao::date,
    cod_produto, descricao_item,
    desc_natureza_oper, cod_situacao_nota::smallint, desc_situacao_nota,
    codigo_cancelamento_pedido::smallint, desc_cancelamento_pedido,
    data_canc_nfisc::date,
    cnpj_fornecedor, nome_fornecedor,
    cod_tipo_fornecedor::smallint, desc_tipo_fornecedor,
    desc_cond_pgto, unidade_medida,
    quantidade, valor_unitario, valor_total,
    COALESCE(data_atualizacao, current_timestamp)
FROM eventos.fnotas_compras_eventos;

-- 3. Indices
CREATE INDEX idx_f_nota_compra_evento_cnpj_fornecedor
    ON eventos.f_nota_compra_evento (cnpj_fornecedor);
CREATE INDEX idx_f_nota_compra_evento_dt_emissao
    ON eventos.f_nota_compra_evento (dt_emissao);
CREATE INDEX idx_f_nota_compra_evento_cod_centro_custo
    ON eventos.f_nota_compra_evento (cod_centro_custo);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.fnotas_compras_eventos AS
    SELECT
        ds_serie              AS serie,
        nr_nota_fiscal        AS documento,
        nr_sequencia          AS sequencia,
        cod_centro_custo      AS centro_custo,
        nm_centro_custo       AS nome_centro_custo,
        ds_especie_docto      AS especie_docto,
        dt_transacao          AS data_transacao,
        dt_emissao            AS data_emissao,
        cod_produto,
        ds_item               AS descricao_item,
        ds_natureza_operacao  AS desc_natureza_oper,
        id_situacao_nota      AS cod_situacao_nota,
        ds_situacao_nota      AS desc_situacao_nota,
        id_cancelamento_pedido AS codigo_cancelamento_pedido,
        ds_cancelamento_pedido AS desc_cancelamento_pedido,
        dt_cancelamento_nf    AS data_canc_nfisc,
        cnpj_fornecedor,
        nm_fornecedor         AS nome_fornecedor,
        id_tipo_fornecedor    AS cod_tipo_fornecedor,
        ds_tipo_fornecedor    AS desc_tipo_fornecedor,
        ds_condicao_pagamento AS desc_cond_pgto,
        ds_unidade_medida     AS unidade_medida,
        qt_item               AS quantidade,
        vl_unitario           AS valor_unitario,
        vl_total              AS valor_total,
        updated_at            AS data_atualizacao
    FROM eventos.f_nota_compra_evento;
COMMENT ON VIEW eventos.fnotas_compras_eventos IS
    'DEPRECATED 2026-05-05: usar f_nota_compra_evento. Sera removido em 2026-08-03.';
```

---

### eventos.fpedidos_compra_eventos

**Nome proposto:** `eventos.f_pedido_compra_evento`
**Tipo:** fato
**Descricao:** Pedidos de compra de insumos e servicos para realizacao de eventos. Cada linha representa um item de pedido de compra, com dados de fornecedor, produto, quantidades pedidas e saldo, e status do pedido. Complementa `fnotas_compras_eventos` no ciclo de compras (pedido -> nota fiscal).
**Sistema de origem:** ERP / sistema de compras interno

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `pedido_compra` | `numeric(6) NULL` | `nr_pedido_compra` | `integer NULL` | [RENAME] [RETYPE] | Prefixo `nr_`; `integer` adequado |
| `seq_item_pedido` | `numeric(3) NULL` | `nr_seq_item` | `smallint NULL` | [RENAME] [RETYPE] | Prefixo `nr_`; `smallint` suficiente |
| `numero_compra_obc` | `text NULL` | `nr_compra_obc` | `varchar(20) NULL` | [RENAME] [RETYPE] | Prefixo proibido `numero_`; usar `nr_`; limitar tamanho |
| `num_requisicao` | `numeric(6) NULL` | `nr_requisicao` | `integer NULL` | [RENAME] [RETYPE] | Prefixo `nr_`; `integer` adequado |
| `centro_custo` | `numeric(6) NULL` | `cod_centro_custo` | `integer NULL` | [RENAME] [RETYPE] | Chave de negocio; prefixo `cod_` |
| `nome_centro_custo` | `text NULL` | `nm_centro_custo` | `varchar(60) NULL` | [RENAME] [RETYPE] | Prefixo proibido `nome_`; usar `nm_`; limitar tamanho |
| `data_prev_entr` | `timestamp NULL` | `dt_prev_entrega` | `date NULL` | [RENAME] [RETYPE] | Data prevista de entrega; converter para `date`; expandir abreviacao |
| `dt_emis_ped_comp` | `timestamp NULL` | `dt_emissao_pedido` | `date NULL` | [RENAME] [RETYPE] | Data de emissao; converter para `date`; expandir abreviacao |
| `cod_produto` | `text NULL` | `cod_produto` | `varchar(30) NULL` | [RETYPE] | Nome ja correto; limitar tamanho |
| `descricao_item` | `text NULL` | `ds_item` | `varchar(150) NULL` | [RENAME] [RETYPE] | Prefixo proibido `descricao_`; usar `ds_`; limitar tamanho |
| `cod_situacao_nota` | `numeric(1) NULL` | `id_situacao_pedido` | `smallint NULL` | [RENAME] [RETYPE] | Nome equivocado — e situacao do pedido, nao da nota; prefixo `id_` |
| `sts_pedido_desc` | `text NULL` | `ds_situacao_pedido` | `varchar(40) NULL` | [RENAME] [RETYPE] | Abreviacao; expandir; prefixo `ds_` |
| `codigo_cancelamento_pedido` | `numeric(2) NULL` | `id_cancelamento_pedido` | `smallint NULL` | [RENAME] [RETYPE] | Prefixo proibido `codigo_`; usar `id_` |
| `desc_cancelamento_pedido` | `text NULL` | `ds_cancelamento_pedido` | `varchar(80) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `codigo_cancelamento_item` | `numeric(2) NULL` | `id_cancelamento_item` | `smallint NULL` | [RENAME] [RETYPE] | Prefixo proibido `codigo_`; usar `id_` |
| `desc_cancelamento_item` | `text NULL` | `ds_cancelamento_item` | `varchar(80) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `cnpj_fornecedor` | `text NULL` | `cnpj_fornecedor` | `varchar(16) NULL` | [RETYPE] | Nome ja correto; padronizar tipo |
| `nome_fornecedor` | `text NULL` | `nm_fornecedor` | `varchar(60) NULL` | [RENAME] [RETYPE] | Prefixo proibido `nome_`; usar `nm_`; limitar tamanho |
| `cod_tipo_fornecedor` | `numeric(4) NULL` | `id_tipo_fornecedor` | `smallint NULL` | [RENAME] [RETYPE] | Codigo operacional; prefixo `id_` |
| `desc_tipo_fornecedor` | `text NULL` | `ds_tipo_fornecedor` | `varchar(40) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `unidade_medida` | `text NULL` | `ds_unidade_medida` | `varchar(10) NULL` | [RENAME] [RETYPE] | Prefixo `ds_`; limitar tamanho |
| `qtde_saldo_item` | `numeric(15,3) NULL` | `qt_saldo_item` | `numeric(15,3) NULL` | [RENAME] | Prefixo `qt_`; precisao ja correta |
| `qtde_pedida_item` | `numeric(15,3) NULL` | `qt_pedida_item` | `numeric(15,3) NULL` | [RENAME] | Prefixo `qt_`; precisao ja correta |
| `preco_item_comp` | `numeric(15,5) NULL` | `vl_preco_item` | `numeric(15,5) NULL` | [RENAME] | Prefixo `vl_`; expandir abreviacao; precisao ja correta |
| `data_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Mapear para auditoria padrao |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

Chave natural composta: `(nr_pedido_compra, nr_seq_item)`.

```sql
id bigserial PRIMARY KEY,
UNIQUE (nr_pedido_compra, nr_seq_item)
```

#### Relacionamentos propostos

```
eventos.f_pedido_compra_evento
  |- cnpj_fornecedor    -> (referencia semantica; sem d_fornecedor no schema)
  |- cod_centro_custo   -> (sem dimensao de centro de custo declarada)
  |- cod_produto        -> (sem d_produto no schema eventos)
  |- nr_pedido_compra   -> eventos.f_nota_compra_evento (via ciclo pedido -> NF)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_f_pedido_compra_evento
    ON eventos.f_pedido_compra_evento (nr_pedido_compra, nr_seq_item);

CREATE INDEX idx_f_pedido_compra_evento_cnpj_fornecedor
    ON eventos.f_pedido_compra_evento (cnpj_fornecedor);

CREATE INDEX idx_f_pedido_compra_evento_dt_emissao_pedido
    ON eventos.f_pedido_compra_evento (dt_emissao_pedido);

CREATE INDEX idx_f_pedido_compra_evento_cod_centro_custo
    ON eventos.f_pedido_compra_evento (cod_centro_custo);
```

#### Impacto no ETL

- `data_prev_entr` e `dt_emis_ped_comp` chegam como `timestamp` — extrair `::date`.
- `data_atualizacao` e o watermark incremental — mapear para `updated_at`.
- `cod_situacao_nota` semanticamente e situacao do pedido — validar com o sistema de origem se o dominio de valores e o mesmo que em `fnotas_compras_eventos`.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.f_pedido_compra_evento (
    id                      bigserial    PRIMARY KEY,
    nr_pedido_compra        integer      NULL,
    nr_seq_item             smallint     NULL,
    nr_compra_obc           varchar(20)  NULL,
    nr_requisicao           integer      NULL,
    cod_centro_custo        integer      NULL,
    nm_centro_custo         varchar(60)  NULL,
    dt_prev_entrega         date         NULL,
    dt_emissao_pedido       date         NULL,
    cod_produto             varchar(30)  NULL,
    ds_item                 varchar(150) NULL,
    id_situacao_pedido      smallint     NULL,
    ds_situacao_pedido      varchar(40)  NULL,
    id_cancelamento_pedido  smallint     NULL,
    ds_cancelamento_pedido  varchar(80)  NULL,
    id_cancelamento_item    smallint     NULL,
    ds_cancelamento_item    varchar(80)  NULL,
    cnpj_fornecedor         varchar(16)  NULL,
    nm_fornecedor           varchar(60)  NULL,
    id_tipo_fornecedor      smallint     NULL,
    ds_tipo_fornecedor      varchar(40)  NULL,
    ds_unidade_medida       varchar(10)  NULL,
    qt_saldo_item           numeric(15,3) NULL,
    qt_pedida_item          numeric(15,3) NULL,
    vl_preco_item           numeric(15,5) NULL,
    created_at              timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at              timestamp    NOT NULL DEFAULT current_timestamp,
    CONSTRAINT uq_f_pedido_compra_evento UNIQUE (nr_pedido_compra, nr_seq_item)
);

-- 2. Migrar dados
INSERT INTO eventos.f_pedido_compra_evento (
    nr_pedido_compra, nr_seq_item, nr_compra_obc, nr_requisicao,
    cod_centro_custo, nm_centro_custo, dt_prev_entrega, dt_emissao_pedido,
    cod_produto, ds_item, id_situacao_pedido, ds_situacao_pedido,
    id_cancelamento_pedido, ds_cancelamento_pedido,
    id_cancelamento_item, ds_cancelamento_item,
    cnpj_fornecedor, nm_fornecedor, id_tipo_fornecedor, ds_tipo_fornecedor,
    ds_unidade_medida, qt_saldo_item, qt_pedida_item, vl_preco_item,
    updated_at
)
SELECT
    pedido_compra::integer, seq_item_pedido::smallint,
    numero_compra_obc, num_requisicao::integer,
    centro_custo::integer, nome_centro_custo,
    data_prev_entr::date, dt_emis_ped_comp::date,
    cod_produto, descricao_item,
    cod_situacao_nota::smallint, sts_pedido_desc,
    codigo_cancelamento_pedido::smallint, desc_cancelamento_pedido,
    codigo_cancelamento_item::smallint, desc_cancelamento_item,
    cnpj_fornecedor, nome_fornecedor,
    cod_tipo_fornecedor::smallint, desc_tipo_fornecedor,
    unidade_medida, qtde_saldo_item, qtde_pedida_item, preco_item_comp,
    COALESCE(data_atualizacao, current_timestamp)
FROM eventos.fpedidos_compra_eventos;

-- 3. Indices
CREATE INDEX idx_f_pedido_compra_evento_cnpj_fornecedor
    ON eventos.f_pedido_compra_evento (cnpj_fornecedor);
CREATE INDEX idx_f_pedido_compra_evento_dt_emissao_pedido
    ON eventos.f_pedido_compra_evento (dt_emissao_pedido);
CREATE INDEX idx_f_pedido_compra_evento_cod_centro_custo
    ON eventos.f_pedido_compra_evento (cod_centro_custo);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.fpedidos_compra_eventos AS
    SELECT
        nr_pedido_compra        AS pedido_compra,
        nr_seq_item             AS seq_item_pedido,
        nr_compra_obc           AS numero_compra_obc,
        nr_requisicao           AS num_requisicao,
        cod_centro_custo        AS centro_custo,
        nm_centro_custo         AS nome_centro_custo,
        dt_prev_entrega         AS data_prev_entr,
        dt_emissao_pedido       AS dt_emis_ped_comp,
        cod_produto,
        ds_item                 AS descricao_item,
        id_situacao_pedido      AS cod_situacao_nota,
        ds_situacao_pedido      AS sts_pedido_desc,
        id_cancelamento_pedido  AS codigo_cancelamento_pedido,
        ds_cancelamento_pedido  AS desc_cancelamento_pedido,
        id_cancelamento_item    AS codigo_cancelamento_item,
        ds_cancelamento_item    AS desc_cancelamento_item,
        cnpj_fornecedor,
        nm_fornecedor           AS nome_fornecedor,
        id_tipo_fornecedor      AS cod_tipo_fornecedor,
        ds_tipo_fornecedor      AS desc_tipo_fornecedor,
        ds_unidade_medida       AS unidade_medida,
        qt_saldo_item           AS qtde_saldo_item,
        qt_pedida_item          AS qtde_pedida_item,
        vl_preco_item           AS preco_item_comp,
        updated_at              AS data_atualizacao
    FROM eventos.f_pedido_compra_evento;
COMMENT ON VIEW eventos.fpedidos_compra_eventos IS
    'DEPRECATED 2026-05-05: usar f_pedido_compra_evento. Sera removido em 2026-08-03.';
```

---

### eventos.ftitulos_compras_eventos

**Nome proposto:** `eventos.f_titulo_compra_evento`
**Tipo:** fato
**Descricao:** Titulos financeiros a pagar originados de compras para eventos (duplicatas de fornecedor). Cada linha representa uma parcela de um titulo, com dados do documento, centro de custo, fornecedor, condicao de pagamento e valor da parcela. Granularidade: parcela de titulo.
**Sistema de origem:** ERP / sistema financeiro interno

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `documento` | `varchar(10) NULL` | `nr_documento` | `varchar(10) NULL` | [RENAME] | Prefixo `nr_`; tamanho adequado |
| `centro_custo` | `varchar(10) NULL` | `cod_centro_custo` | `varchar(10) NULL` | [RENAME] | Chave de negocio; prefixo `cod_`; manter varchar pois pode ser alfanumerico nesta origem |
| `nome_centro_custo` | `varchar(40) NULL` | `nm_centro_custo` | `varchar(40) NULL` | [RENAME] | Prefixo proibido `nome_`; usar `nm_`; tamanho adequado |
| `especie_docto` | `varchar(5) NULL` | `ds_especie_docto` | `varchar(5) NULL` | [RENAME] | Prefixo `ds_`; tamanho adequado |
| `data_transacao` | `timestamp NULL` | `dt_transacao` | `date NULL` | [RENAME] [RETYPE] | Semanticamente data; converter para `date` |
| `data_emissao` | `timestamp NULL` | `dt_emissao` | `date NULL` | [RENAME] [RETYPE] | Semanticamente data; converter para `date` |
| `codigo_contabil` | `varchar(10) NULL` | `ds_codigo_contabil` | `varchar(10) NULL` | [RENAME] | Prefixo proibido `codigo_`; usar `ds_` (e descritivo, nao join key) |
| `codigo_cancelamento_pedido` | `varchar(5) NULL` | `id_cancelamento_pedido` | `varchar(5) NULL` | [RENAME] | Prefixo proibido `codigo_`; usar `id_`; manter varchar pois diferente das outras tabelas (numeric vs varchar) — [CONFLITO] |
| `desc_cancelamento_pedido` | `varchar(80) NULL` | `ds_cancelamento_pedido` | `varchar(80) NULL` | [RENAME] | Prefixo `ds_`; tamanho adequado |
| `data_canc_tit` | `timestamp NULL` | `dt_cancelamento_titulo` | `date NULL` | [RENAME] [RETYPE] | Data de cancelamento do titulo; converter para `date`; expandir abreviacao |
| `cnpj_fornecedor` | `varchar(15) NULL` | `cnpj_fornecedor` | `varchar(16) NULL` | [RETYPE] | Nome ja correto; aumentar de 15 para 16 chars (padrao DW) |
| `nome_fornecedor` | `varchar(60) NULL` | `nm_fornecedor` | `varchar(60) NULL` | [RENAME] | Prefixo proibido `nome_`; usar `nm_`; tamanho adequado |
| `cod_tipo_fornecedor` | `varchar(4) NULL` | `id_tipo_fornecedor` | `varchar(4) NULL` | [RENAME] | Codigo operacional; prefixo `id_`; manter varchar — diferente de `numeric(4)` nas outras tabelas [CONFLITO] |
| `forn_descricao` | `varchar(40) NULL` | `ds_tipo_fornecedor` | `varchar(40) NULL` | [RENAME] | Abreviacao; e a descricao do tipo de fornecedor — renomear para consistencia com outras tabelas |
| `cond_pagto` | `varchar(3) NULL` | `ds_condicao_pagamento` | `varchar(10) NULL` | [RENAME] [RETYPE] | Expandir abreviacao; ampliar tamanho levemente |
| `valor_parcela` | `numeric(17,2) NULL` | `vl_parcela` | `numeric(15,2) NULL` | [RENAME] [RETYPE] | Prefixo `vl_`; `numeric(17,2)` nao e padrao — usar `numeric(15,2)` |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [CONFLITO]

**Observacao de CONFLITO:**
- `cnpj_fornecedor` e `varchar(15)` aqui contra `text` em `fnotas_compras_eventos` e `fpedidos_compra_eventos` — padronizar todos para `varchar(16)`.
- `cod_tipo_fornecedor` e `varchar(4)` aqui contra `numeric(4)` nas outras tabelas — inconsistencia de tipo entre tabelas do mesmo schema para o mesmo conceito. Verificar o sistema de origem e definir tipo canonico.
- `codigo_cancelamento_pedido` e `varchar(5)` aqui contra `numeric(2)` nas demais — idem.

#### Chave primaria proposta

Nao existe surrogate key. Chave de negocio: `(nr_documento, cod_centro_custo)` — verificar se e unica na origem.

```sql
id bigserial PRIMARY KEY
```

#### Relacionamentos propostos

```
eventos.f_titulo_compra_evento
  |- cnpj_fornecedor    -> (referencia semantica; sem d_fornecedor no schema)
  |- cod_centro_custo   -> (sem dimensao de centro de custo declarada)
  |- nr_documento       -> eventos.f_nota_compra_evento.nr_nota_fiscal (via ciclo compra -> titulo)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_titulo_compra_evento_cnpj_fornecedor
    ON eventos.f_titulo_compra_evento (cnpj_fornecedor);

CREATE INDEX idx_f_titulo_compra_evento_dt_emissao
    ON eventos.f_titulo_compra_evento (dt_emissao);

CREATE INDEX idx_f_titulo_compra_evento_cod_centro_custo
    ON eventos.f_titulo_compra_evento (cod_centro_custo);
```

#### Impacto no ETL

- `data_transacao`, `data_emissao` e `data_canc_tit` chegam como `timestamp` — extrair `::date`.
- `cnpj_fornecedor varchar(15)` no banco de origem — o pipeline deve aceitar e armazenar em `varchar(16)`.
- `cod_tipo_fornecedor varchar(4)` e `codigo_cancelamento_pedido varchar(5)` — verificar se o sistema envia com zeros a esquerda (ex.: `'0001'`) e garantir que o mesmo formato e mantido em outras tabelas.
- `valor_parcela numeric(17,2)` — validar que nao ha valores com mais de 13 digitos inteiros antes de converter para `numeric(15,2)`.

#### Migracao SQL

```sql
-- 1. Criar tabela nova
CREATE TABLE eventos.f_titulo_compra_evento (
    id                      bigserial    PRIMARY KEY,
    nr_documento            varchar(10)  NULL,
    cod_centro_custo        varchar(10)  NULL,
    nm_centro_custo         varchar(40)  NULL,
    ds_especie_docto        varchar(5)   NULL,
    dt_transacao            date         NULL,
    dt_emissao              date         NULL,
    ds_codigo_contabil      varchar(10)  NULL,
    id_cancelamento_pedido  varchar(5)   NULL,
    ds_cancelamento_pedido  varchar(80)  NULL,
    dt_cancelamento_titulo  date         NULL,
    cnpj_fornecedor         varchar(16)  NULL,
    nm_fornecedor           varchar(60)  NULL,
    id_tipo_fornecedor      varchar(4)   NULL,
    ds_tipo_fornecedor      varchar(40)  NULL,
    ds_condicao_pagamento   varchar(10)  NULL,
    vl_parcela              numeric(15,2) NULL,
    created_at              timestamp    NOT NULL DEFAULT current_timestamp,
    updated_at              timestamp    NOT NULL DEFAULT current_timestamp
);

-- 2. Migrar dados
INSERT INTO eventos.f_titulo_compra_evento (
    nr_documento, cod_centro_custo, nm_centro_custo,
    ds_especie_docto, dt_transacao, dt_emissao, ds_codigo_contabil,
    id_cancelamento_pedido, ds_cancelamento_pedido,
    dt_cancelamento_titulo, cnpj_fornecedor, nm_fornecedor,
    id_tipo_fornecedor, ds_tipo_fornecedor, ds_condicao_pagamento, vl_parcela
)
SELECT
    documento, centro_custo, nome_centro_custo,
    especie_docto, data_transacao::date, data_emissao::date, codigo_contabil,
    codigo_cancelamento_pedido, desc_cancelamento_pedido,
    data_canc_tit::date, cnpj_fornecedor, nome_fornecedor,
    cod_tipo_fornecedor, forn_descricao, cond_pagto,
    ROUND(valor_parcela::numeric, 2)
FROM eventos.ftitulos_compras_eventos;

-- 3. Indices
CREATE INDEX idx_f_titulo_compra_evento_cnpj_fornecedor
    ON eventos.f_titulo_compra_evento (cnpj_fornecedor);
CREATE INDEX idx_f_titulo_compra_evento_dt_emissao
    ON eventos.f_titulo_compra_evento (dt_emissao);
CREATE INDEX idx_f_titulo_compra_evento_cod_centro_custo
    ON eventos.f_titulo_compra_evento (cod_centro_custo);

-- 4. View de compatibilidade
CREATE OR REPLACE VIEW eventos.ftitulos_compras_eventos AS
    SELECT
        nr_documento            AS documento,
        cod_centro_custo        AS centro_custo,
        nm_centro_custo         AS nome_centro_custo,
        ds_especie_docto        AS especie_docto,
        dt_transacao            AS data_transacao,
        dt_emissao              AS data_emissao,
        ds_codigo_contabil      AS codigo_contabil,
        id_cancelamento_pedido  AS codigo_cancelamento_pedido,
        ds_cancelamento_pedido  AS desc_cancelamento_pedido,
        dt_cancelamento_titulo  AS data_canc_tit,
        cnpj_fornecedor,
        nm_fornecedor           AS nome_fornecedor,
        id_tipo_fornecedor      AS cod_tipo_fornecedor,
        ds_tipo_fornecedor      AS forn_descricao,
        ds_condicao_pagamento   AS cond_pagto,
        vl_parcela              AS valor_parcela
    FROM eventos.f_titulo_compra_evento;
COMMENT ON VIEW eventos.ftitulos_compras_eventos IS
    'DEPRECATED 2026-05-05: usar f_titulo_compra_evento. Sera removido em 2026-08-03.';
```

---

## Resumo Executivo de Conformidade

### Mapa de renomeacao de tabelas

| Nome atual | Nome proposto | Tipo |
|---|---|---|
| `eventos.dinfo_eventos` | `eventos.d_inscricao_evento` | dimensao |
| `eventos.ditens_carrinho` | `eventos.f_item_carrinho` | fato |
| `eventos.fcreditos_eventos` | `eventos.f_credito_contabil_evento` | fato |
| `eventos.fdebitos_eventos` | `eventos.f_debito_contabil_evento` | fato |
| `eventos.fexperience_events` | `eventos.d_evento` | dimensao |
| `eventos.fexperience_registrations` | `eventos.f_inscricao_evento` | fato |
| `eventos.fnotas_compras_eventos` | `eventos.f_nota_compra_evento` | fato |
| `eventos.fpedidos_compra_eventos` | `eventos.f_pedido_compra_evento` | fato |
| `eventos.ftitulos_compras_eventos` | `eventos.f_titulo_compra_evento` | fato |

### Conflitos criticos a resolver antes da migracao

| # | Conflito | Tabelas envolvidas | Acao necessaria |
|---|---|---|---|
| 1 | `order_id` e `int4` em `ditens_carrinho` e `text` em `fexperience_registrations` | `ditens_carrinho`, `fexperience_registrations` | Definir tipo canonico no sistema de origem e padronizar |
| 2 | `cnpj_fornecedor` e `text` em `fnotas_compras_eventos` e `fpedidos_compra_eventos`, mas `varchar(15)` em `ftitulos_compras_eventos` | 3 tabelas | Padronizar para `varchar(16)` em todas |
| 3 | `cod_tipo_fornecedor` e `numeric(4)` nas notas/pedidos mas `varchar(4)` nos titulos | 3 tabelas | Definir tipo canonico; suspeita de codigo alfanumerico na origem dos titulos |
| 4 | `codigo_cancelamento_pedido` e `numeric(2)` nas notas/pedidos mas `varchar(5)` nos titulos | 3 tabelas | Idem — definir tipo canonico |
| 5 | Todas as tabelas de origem API Experience tem colunas em ingles | 5 tabelas | Renomear conforme proposta; manter views de compatibilidade 90 dias |
| 6 | `dinfo_eventos.id` e `fexperience_events.id` sao `int8 NULL` sem PRIMARY KEY | 2 tabelas | Tornar `bigserial NOT NULL PRIMARY KEY` |
| 7 | Sem `cod_evento` como join key canonica propagada entre tabelas | Schema inteiro | Criar `cod_evento integer` e propagar em `d_inscricao_evento` e `f_item_carrinho` |

### Colunas de auditoria — status por tabela

| Tabela | `created_at` | `updated_at` |
|---|---|---|
| `dinfo_eventos` | Ausente — ADD | Ausente — ADD |
| `ditens_carrinho` | Ausente — ADD | Ausente — ADD |
| `fcreditos_eventos` | `datainsercao` — RENAME | Ausente — ADD |
| `fdebitos_eventos` | `datainsercao` — RENAME | Ausente — ADD |
| `fexperience_events` | Presente (nullable) — RETYPE | Presente (nullable) — RETYPE |
| `fexperience_registrations` | Presente (nullable) — RETYPE | Presente (nullable) — RETYPE |
| `fnotas_compras_eventos` | Ausente — ADD | `data_atualizacao` — RENAME |
| `fpedidos_compra_eventos` | Ausente — ADD | `data_atualizacao` — RENAME |
| `ftitulos_compras_eventos` | Ausente — ADD | Ausente — ADD |

### Surrogate keys — status por tabela

| Tabela | Status atual | Acao |
|---|---|---|
| `dinfo_eventos` | `id int8 NULL` — sem PK | Tornar `bigserial PRIMARY KEY` |
| `ditens_carrinho` | `id serial4` com PK | Migrar para `bigserial` |
| `fcreditos_eventos` | Sem surrogate key | Adicionar `id bigserial PRIMARY KEY` |
| `fdebitos_eventos` | Sem surrogate key | Adicionar `id bigserial PRIMARY KEY` |
| `fexperience_events` | `id int8 NULL` — sem PK | Tornar `bigserial PRIMARY KEY` |
| `fexperience_registrations` | `id int8 NULL` — sem PK | Tornar `bigserial PRIMARY KEY` |
| `fnotas_compras_eventos` | Sem surrogate key | Adicionar `id bigserial PRIMARY KEY` |
| `fpedidos_compra_eventos` | Sem surrogate key | Adicionar `id bigserial PRIMARY KEY` |
| `ftitulos_compras_eventos` | Sem surrogate key | Adicionar `id bigserial PRIMARY KEY` |
