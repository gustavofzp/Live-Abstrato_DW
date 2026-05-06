# Dicionario de Dados — Schema `expedicao`

> **Versao:** 1.0 | **Data:** 2026-05-05
> **Responsavel:** Especialista DW — Schema expedicao
> **Status:** Em revisao
> **Escopo:** 6 tabelas, 59 colunas

---

## Visao Geral do Schema

O schema `expedicao` concentra dados operacionais de ondas de separacao, planejamento de embarque e rastreamento de coleta no armazem. As tabelas sao alimentadas por sistemas WMS/PWT e pelo WMS Slim Sorter. O schema nao possui FKs declaradas; a integridade referencial e garantida por convencao no pipeline Airflow/Python.

**Sistemas de origem identificados:**
- PWT (sistema WMS interno) — tabelas `dondas_pwt` e `fondas_pwt_resumo`
- Slim Sorter (WMS de sorteio automatizado) — tabela `dondas_slim_sorter`
- Sistema de planejamento de expedicao (ERP/WMS) — tabelas `fondas_planejamento`, `fondas_por_usuario`, `fondas_produtos_pendentes`

**Prefixo das tabelas no DDL atual:**
- `d` — dimensoes de onda (listas/cadastros de ondas)
- `f` — fatos operacionais (movimentacoes, quantidades, planejamento)

**Convencoes de nomenclatura aplicadas neste dicionario:** conforme `BOAS_PRATICAS_DW.md` versao 2.0.

---

## Tabelas

### expedicao.dondas_pwt

**Nome proposto:** `expedicao.d_onda_pwt`
**Tipo:** dimensao
**Descricao:** Cadastro de ondas de separacao do sistema PWT. Cada registro representa uma onda de coleta, com sua situacao atual e quantidades agregadas de itens a coletar, coletados e pedidos. E a entidade central para joins de ondas PWT em fatos operacionais.
**Sistema de origem:** PWT (WMS interno)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| id_onda | int4 NULL | cod_onda | varchar(20) NOT NULL | RENAME, RETYPE | Business key da onda — deve ser join key universal com prefixo `cod_`. Tipo varchar(20) para compatibilidade com outros sistemas que podem usar onda alfanumerica. Adicionar UNIQUE constraint. |
| descricao_onda | text NULL | ds_onda | varchar(100) | RENAME, RETYPE | Descricao curta da onda; `ds_` e o prefixo correto. Limitar a varchar(100) evita uso de text para campo descritivo padrao. |
| situacao_onda | varchar(20) NULL | ds_situacao_onda | varchar(20) | RENAME | Descricao da situacao da onda; prefixo `ds_` adequado para campo descritivo textual. |
| qtd_coletar_item | numeric(15,2) NULL | qt_coletar_item | numeric(15,3) | RENAME, RETYPE | Quantidade — prefixo `qt_`. Retype para numeric(15,3) conforme padrao DW para quantidades. |
| qtd_coletada_item | numeric(15,2) NULL | qt_coletada_item | numeric(15,3) | RENAME, RETYPE | Idem anterior. |
| qtd_pedido | numeric(15,3) NULL | qt_pedido | numeric(15,3) | RENAME | Quantidade pedida na onda; prefixo `qt_` correto. Tipo ja esta padrao. |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | RENAME, REFORMAT | Coluna de auditoria — mapear para `updated_at` conforme regra de migracao das boas praticas. |
| — | — | id | bigserial PRIMARY KEY | ADD | Surrogate key obrigatoria em dimensoes conforme secao 5 das boas praticas. |
| — | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Coluna de auditoria obrigatoria (secao 4). |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade na business key:
```sql
UNIQUE (cod_onda)
```

#### Relacionamentos propostos

```
expedicao.d_onda_pwt
  |- cod_onda -> expedicao.f_onda_pwt_resumo.cod_onda  (join key de ondas PWT)
  |- cod_onda -> expedicao.f_onda_produtos_pendentes.cod_onda
  |- cod_onda -> expedicao.f_onda_por_usuario.cod_onda
```

#### Indices recomendados

```sql
-- Unicidade da business key (obrigatorio para dimensao)
CREATE UNIQUE INDEX uq_d_onda_pwt_cod_onda ON expedicao.d_onda_pwt (cod_onda);
-- Filtro frequente por situacao
CREATE INDEX idx_d_onda_pwt_situacao ON expedicao.d_onda_pwt (ds_situacao_onda);
-- Watermark para carga incremental
CREATE INDEX idx_d_onda_pwt_updated_at ON expedicao.d_onda_pwt (updated_at);
```

#### Impacto no ETL

- Renomear `id_onda` para `cod_onda` exige atualizacao do alias no pipeline de ingestao PWT.
- O tipo de `id_onda` e `int4`; se o sistema de origem sempre retornar numerico inteiro, o ETL deve fazer cast para `varchar` antes do insert: `str(id_onda)`.
- `ultima_atualizacao` deve ser lido como watermark na carga incremental e gravado em `updated_at`.
- `created_at` nao precisa ser enviado pelo ETL — o banco aplica o DEFAULT.
- Adicionar validacao de `cod_onda NOT NULL` no pipeline antes do insert.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE expedicao.dondas_pwt RENAME TO d_onda_pwt;

-- 2. Adicionar surrogate key
ALTER TABLE expedicao.d_onda_pwt
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear e retipar colunas
ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN id_onda TO cod_onda;

ALTER TABLE expedicao.d_onda_pwt
    ALTER COLUMN cod_onda TYPE varchar(20) USING cod_onda::varchar;

ALTER TABLE expedicao.d_onda_pwt
    ALTER COLUMN cod_onda SET NOT NULL;

ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN descricao_onda TO ds_onda;

ALTER TABLE expedicao.d_onda_pwt
    ALTER COLUMN ds_onda TYPE varchar(100) USING ds_onda::varchar(100);

ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN situacao_onda TO ds_situacao_onda;

ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN qtd_coletar_item TO qt_coletar_item;

ALTER TABLE expedicao.d_onda_pwt
    ALTER COLUMN qt_coletar_item TYPE numeric(15,3) USING qt_coletar_item::numeric(15,3);

ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN qtd_coletada_item TO qt_coletada_item;

ALTER TABLE expedicao.d_onda_pwt
    ALTER COLUMN qt_coletada_item TYPE numeric(15,3) USING qt_coletada_item::numeric(15,3);

ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN qtd_pedido TO qt_pedido;

ALTER TABLE expedicao.d_onda_pwt
    RENAME COLUMN ultima_atualizacao TO updated_at;

ALTER TABLE expedicao.d_onda_pwt
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- 4. Adicionar coluna de auditoria
ALTER TABLE expedicao.d_onda_pwt
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- 5. Unique constraint na business key
ALTER TABLE expedicao.d_onda_pwt
    ADD CONSTRAINT uq_d_onda_pwt_cod_onda UNIQUE (cod_onda);

-- 6. Indices
CREATE INDEX idx_d_onda_pwt_situacao  ON expedicao.d_onda_pwt (ds_situacao_onda);
CREATE INDEX idx_d_onda_pwt_updated_at ON expedicao.d_onda_pwt (updated_at);

-- 7. View de compatibilidade (manter 90 dias)
CREATE OR REPLACE VIEW expedicao.dondas_pwt AS
    SELECT * FROM expedicao.d_onda_pwt;
COMMENT ON VIEW expedicao.dondas_pwt IS
    'DEPRECATED 2026-05-05: usar d_onda_pwt. Sera removido em 2026-08-03.';
```

---

### expedicao.dondas_slim_sorter

**Nome proposto:** `expedicao.d_onda_slim_sorter`
**Tipo:** fato
**Descricao:** Registro granular de itens de onda no sistema Slim Sorter (WMS de sorteio automatizado). Cada linha representa um item de pedido dentro de uma onda, com seu SKU, situacao de coleta, usuario responsavel e tag de rastreamento. Apesar do prefixo `d` no nome atual, o conteudo e transacional (fato), pois possui granularidade de item-pedido-onda.
**Sistema de origem:** WMS Slim Sorter

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| id_onda | numeric(9) NULL | cod_onda | varchar(20) NOT NULL | RENAME, RETYPE | Business key de onda — join key com `d_onda_pwt` e `d_onda_slim_sorter`. varchar(20) alinhado com `d_onda_pwt.cod_onda`. |
| descricao_onda | text NULL | ds_onda | varchar(100) | RENAME, RETYPE | Atributo descritivo; `ds_` correto. Desnormalizacao aceitavel em fato operacional para evitar join extra. |
| situacao_pedido | numeric(2) NULL | id_situacao_pedido | smallint | RENAME, RETYPE | Codigo operacional de situacao — prefixo `id_` correto (nao e entidade/dimensao). smallint adequado para codigos com menos de 32k valores. |
| situacao_onda | numeric(2) NULL | id_situacao_onda | smallint | RENAME, RETYPE | Idem anterior. |
| situacao_onda_desc | text NULL | ds_situacao_onda | varchar(100) | RENAME, RETYPE | Descricao da situacao da onda; `ds_` correto. varchar(100) adequado. |
| id_pedido | numeric(9) NULL | nr_pedido | integer | RENAME, RETYPE | Numero do pedido — documento operacional, prefixo `nr_` conforme boas praticas (secao 3.2). |
| id_item | numeric(9) NULL | nr_item | integer | RENAME, RETYPE | Numero do item no pedido; prefixo `nr_` correto para sequencial de linha. |
| grupo | text NULL | ds_grupo | varchar(20) | RENAME, RETYPE | Grupo do produto (nivel hierarquico); `ds_` para descritivo. varchar(20) suficiente. |
| subgrupo | text NULL | ds_subgrupo | varchar(20) | RENAME, RETYPE | Subgrupo do produto; idem anterior. |
| item | text NULL | ds_item | varchar(20) | RENAME, RETYPE | Item do produto (parte do SKU); `ds_` correto. |
| sku | text NULL | sku_produto | varchar(30) NOT NULL | RENAME, RETYPE | Identificador de produto — deve ser `sku_produto` conforme secao 6.1 das boas praticas. varchar(30) padrao. Verificar se o valor ja e o SKU composto (nivel.referencia.tamanho.cor) ou apenas parte dele; se for parcial, consolidar no ETL. |
| qtd_coletar_item | numeric(4) NULL | qt_coletar_item | numeric(15,3) | RENAME, RETYPE | Quantidade; `qt_` correto. numeric(15,3) padrao DW. numeric(4) original e insuficiente para volumes maiores. |
| qtd_coletada_item | numeric(4) NULL | qt_coletada_item | numeric(15,3) | RENAME, RETYPE | Idem anterior. |
| situacao_item | numeric(2) NULL | id_situacao_item | smallint | RENAME, RETYPE | Codigo operacional de situacao do item; `id_` correto. |
| situacao_onda_item | text NULL | ds_situacao_onda_item | varchar(100) | RENAME, RETYPE | Descricao da situacao do item na onda; `ds_` correto. |
| usuario_situacao | numeric(5) NULL | id_usuario_situacao | integer | RENAME, RETYPE | Codigo operacional do usuario que alterou a situacao; `id_` correto. integer adequado. |
| usuario_situacao_item | text NULL | nm_usuario_situacao | varchar(100) | RENAME, RETYPE | Nome do usuario; `nm_` correto para nome de pessoa. varchar(100) adequado. |
| id_tag | text NULL | ds_tag | varchar(50) | RENAME, RETYPE | Tag de rastreamento do item; `ds_` para identificador textual nao estruturado. varchar(50) suficiente. |
| — | — | id | bigserial PRIMARY KEY | ADD | Surrogate key obrigatoria. |
| — | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Auditoria obrigatoria. |
| — | — | updated_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Auditoria obrigatoria — nao existia na tabela original. |

**Flags:** [RENAME] [RETYPE] [ADD] [CONFLITO]

**CONFLITO — campo `sku`:** O campo `sku` em `dondas_slim_sorter` precisa ser inspecionado no ETL para confirmar se contem o SKU composto (`nivel.referencia.tamanho.cor`) ou apenas um fragmento. Se for fragmento, o pipeline deve montar `sku_produto` antes do insert. Validar com a equipe de WMS.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural de negocio (unicidade por linha operacional):
```sql
-- Verificar se (cod_onda, nr_pedido, nr_item) e unica; se sim, adicionar constraint:
-- UNIQUE (cod_onda, nr_pedido, nr_item)
```

#### Relacionamentos propostos

```
expedicao.f_onda_slim_sorter
  |- cod_onda     -> expedicao.d_onda_pwt.cod_onda
  |- sku_produto  -> live.d_produto.sku_produto
  |- nr_pedido    -> (referencia ao pedido de venda — schema comercial ou equivalente)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_onda_slim_cod_onda    ON expedicao.f_onda_slim_sorter (cod_onda);
CREATE INDEX idx_f_onda_slim_sku_produto ON expedicao.f_onda_slim_sorter (sku_produto);
CREATE INDEX idx_f_onda_slim_nr_pedido   ON expedicao.f_onda_slim_sorter (nr_pedido);
CREATE INDEX idx_f_onda_slim_updated_at  ON expedicao.f_onda_slim_sorter (updated_at);
```

#### Impacto no ETL

- `sku`: confirmar formato com equipe WMS antes da migracao. Se nao for SKU composto, o ETL deve construir `nivel || '.' || referencia || '.' || tamanho || '.' || cor` e gravar em `sku_produto`.
- `id_onda` (numeric) -> `cod_onda` (varchar): cast no pipeline `str(int(id_onda))`.
- `usuario_situacao` (numeric) -> `id_usuario_situacao` (integer): cast direto.
- Incluir `updated_at = current_timestamp` na carga, pois a tabela original nao possui coluna de auditoria — o ETL deve preencher com o timestamp de ingestao.
- Validar `cod_onda` contra `d_onda_pwt.cod_onda` antes de inserir (integridade por convencao).

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE expedicao.dondas_slim_sorter RENAME TO f_onda_slim_sorter;

-- 2. Adicionar surrogate key
ALTER TABLE expedicao.f_onda_slim_sorter
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear e retipar colunas
ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN id_onda TO cod_onda;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN cod_onda TYPE varchar(20) USING cod_onda::varchar;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN cod_onda SET NOT NULL;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN descricao_onda TO ds_onda;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_onda TYPE varchar(100) USING ds_onda::varchar(100);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN situacao_pedido TO id_situacao_pedido;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN id_situacao_pedido TYPE smallint USING id_situacao_pedido::smallint;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN situacao_onda TO id_situacao_onda;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN id_situacao_onda TYPE smallint USING id_situacao_onda::smallint;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN situacao_onda_desc TO ds_situacao_onda;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_situacao_onda TYPE varchar(100) USING ds_situacao_onda::varchar(100);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN id_pedido TO nr_pedido;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN nr_pedido TYPE integer USING nr_pedido::integer;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN id_item TO nr_item;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN nr_item TYPE integer USING nr_item::integer;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN grupo TO ds_grupo;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_grupo TYPE varchar(20) USING ds_grupo::varchar(20);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN subgrupo TO ds_subgrupo;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_subgrupo TYPE varchar(20) USING ds_subgrupo::varchar(20);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN item TO ds_item;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_item TYPE varchar(20) USING ds_item::varchar(20);

-- ATENCAO: validar formato do campo sku antes deste ALTER
ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN sku TO sku_produto;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN sku_produto TYPE varchar(30) USING sku_produto::varchar(30);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN qtd_coletar_item TO qt_coletar_item;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN qt_coletar_item TYPE numeric(15,3) USING qt_coletar_item::numeric(15,3);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN qtd_coletada_item TO qt_coletada_item;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN qt_coletada_item TYPE numeric(15,3) USING qt_coletada_item::numeric(15,3);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN situacao_item TO id_situacao_item;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN id_situacao_item TYPE smallint USING id_situacao_item::smallint;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN situacao_onda_item TO ds_situacao_onda_item;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_situacao_onda_item TYPE varchar(100) USING ds_situacao_onda_item::varchar(100);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN usuario_situacao TO id_usuario_situacao;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN id_usuario_situacao TYPE integer USING id_usuario_situacao::integer;

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN usuario_situacao_item TO nm_usuario_situacao;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN nm_usuario_situacao TYPE varchar(100) USING nm_usuario_situacao::varchar(100);

ALTER TABLE expedicao.f_onda_slim_sorter
    RENAME COLUMN id_tag TO ds_tag;
ALTER TABLE expedicao.f_onda_slim_sorter
    ALTER COLUMN ds_tag TYPE varchar(50) USING ds_tag::varchar(50);

-- 4. Adicionar colunas de auditoria
ALTER TABLE expedicao.f_onda_slim_sorter
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- 5. Indices
CREATE INDEX idx_f_onda_slim_cod_onda    ON expedicao.f_onda_slim_sorter (cod_onda);
CREATE INDEX idx_f_onda_slim_sku_produto ON expedicao.f_onda_slim_sorter (sku_produto);
CREATE INDEX idx_f_onda_slim_nr_pedido   ON expedicao.f_onda_slim_sorter (nr_pedido);
CREATE INDEX idx_f_onda_slim_updated_at  ON expedicao.f_onda_slim_sorter (updated_at);

-- 6. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW expedicao.dondas_slim_sorter AS
    SELECT * FROM expedicao.f_onda_slim_sorter;
COMMENT ON VIEW expedicao.dondas_slim_sorter IS
    'DEPRECATED 2026-05-05: usar f_onda_slim_sorter. Sera removido em 2026-08-03.';
```

---

### expedicao.fondas_planejamento

**Nome proposto:** `expedicao.f_onda_planejamento`
**Tipo:** fato
**Descricao:** Registro de planejamento de embarque por onda de pedido. Cada linha representa um pedido de onda com data de emissao, data de embarque prevista, cliente, quantidade, representante, transportadora e endereco de entrega. E a tabela que suporta o planejamento logistico e a programacao de cargas.
**Sistema de origem:** ERP/WMS de planejamento de expedicao (sistema nao identificado explicitamente — verificar com equipe)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| empresapedidoonda | int4 NULL | id_empresa | smallint | RENAME, RETYPE | Codigo operacional da empresa; `id_` correto. smallint suficiente para codigos de empresa. |
| dataemissaopedidoonda | date NULL | dt_emissao_onda | date NOT NULL | RENAME, REFORMAT | Data de emissao do pedido de onda; `dt_` correto. NOT NULL pois e data obrigatoria em fatos. |
| pedidoonda | int4 NULL | nr_pedido_onda | integer | RENAME | Numero do pedido de onda — documento operacional; `nr_` correto. Tipo int4/integer equivalentes. |
| dataembarquepedidoonda | date NULL | dt_embarque | date | RENAME | Data de embarque previsto; `dt_` correto. Nullable pois pode nao estar definida no planejamento inicial. |
| clientepedidoonda | text NULL | nm_cliente | varchar(100) | RENAME, RETYPE | Nome do cliente; `nm_` correto para nome de entidade. varchar(100) adequado. Idealmente substituir por `cod_cliente` (join key) e manter `nm_cliente` desnormalizado se necessario para performance. |
| qtdepedidoonda | numeric(15,2) NULL | qt_pedido | numeric(15,3) | RENAME, RETYPE | Quantidade do pedido de onda; `qt_` correto. numeric(15,3) padrao DW. |
| representantepedidoonda | text NULL | nm_representante | varchar(100) | RENAME, RETYPE | Nome do representante; `nm_` correto. Idealmente incluir `cod_representante` como join key para `d_representante`. |
| transportadorapedidoonda | text NULL | nm_transportadora | varchar(100) | RENAME, RETYPE | Nome da transportadora; `nm_` correto. Idealmente incluir `cod_transportadora` como join key futura. |
| endereco | varchar(100) NULL | end_entrega | varchar(100) | RENAME | Endereco de entrega da onda; `end_` correto para campos de endereco. |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | RENAME, REFORMAT | Coluna de auditoria; mapear para `updated_at`. |
| — | — | id | bigserial PRIMARY KEY | ADD | Surrogate key obrigatoria. |
| — | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Auditoria obrigatoria. |
| — | — | cod_cliente | varchar(20) | ADD | Join key para `d_cliente` — adicionar quando o ETL puder resolver o codigo de cliente a partir do nome. Ate la, manter `nm_cliente` como atributo desnormalizado. |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD] [CONFLITO]

**CONFLITO — identificacao de cliente/representante/transportadora:** As colunas `clientepedidoonda`, `representantepedidoonda` e `transportadorapedidoonda` sao campos de texto livre (nome), sem codigo de join. Isso impede join com dimensoes. O pipeline deve ser ajustado para resolver `cod_cliente`, `cod_representante` via lookup antes do insert no DW. Ate que isso seja implementado, os campos `nm_*` devem ser mantidos para uso em relatorios.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Candidato a chave natural (verificar unicidade real nos dados):
```sql
-- UNIQUE (id_empresa, nr_pedido_onda, dt_emissao_onda)
```

#### Relacionamentos propostos

```
expedicao.f_onda_planejamento
  |- id_empresa        -> (id_empresa em outras tabelas do DW — nao ha d_empresa declarada)
  |- cod_cliente       -> comercial.d_cliente.cod_cliente  (apos resolucao do ETL)
  |- cod_representante -> comercial.d_representante.cod_representante  (apos resolucao do ETL)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_onda_plan_empresa     ON expedicao.f_onda_planejamento (id_empresa);
CREATE INDEX idx_f_onda_plan_dt_emissao  ON expedicao.f_onda_planejamento (dt_emissao_onda);
CREATE INDEX idx_f_onda_plan_dt_embarque ON expedicao.f_onda_planejamento (dt_embarque);
CREATE INDEX idx_f_onda_plan_updated_at  ON expedicao.f_onda_planejamento (updated_at);
-- Apos adicionar cod_cliente:
-- CREATE INDEX idx_f_onda_plan_cod_cliente ON expedicao.f_onda_planejamento (cod_cliente);
```

#### Impacto no ETL

- Renomear todos os campos compostos no SELECT do pipeline (ex: `clientepedidoonda AS nm_cliente`).
- `dataemissaopedidoonda` e `dataembarquepedidoonda` ja sao `date` — sem conversao de tipo necessaria.
- `empresapedidoonda` (int4) -> `id_empresa` (smallint): verificar se ha valores maiores que 32767 antes de retipar.
- `ultima_atualizacao` vira watermark de carga incremental em `updated_at`.
- Criar tarefa no backlog do ETL para resolver `cod_cliente` a partir de `nm_cliente` via lookup em `d_cliente`.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE expedicao.fondas_planejamento RENAME TO f_onda_planejamento;

-- 2. Adicionar surrogate key
ALTER TABLE expedicao.f_onda_planejamento
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear e retipar colunas
ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN empresapedidoonda TO id_empresa;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN id_empresa TYPE smallint USING id_empresa::smallint;

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN dataemissaopedidoonda TO dt_emissao_onda;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN dt_emissao_onda SET NOT NULL;

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN pedidoonda TO nr_pedido_onda;

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN dataembarquepedidoonda TO dt_embarque;

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN clientepedidoonda TO nm_cliente;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN nm_cliente TYPE varchar(100) USING nm_cliente::varchar(100);

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN qtdepedidoonda TO qt_pedido;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN qt_pedido TYPE numeric(15,3) USING qt_pedido::numeric(15,3);

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN representantepedidoonda TO nm_representante;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN nm_representante TYPE varchar(100) USING nm_representante::varchar(100);

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN transportadorapedidoonda TO nm_transportadora;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN nm_transportadora TYPE varchar(100) USING nm_transportadora::varchar(100);

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN endereco TO end_entrega;

ALTER TABLE expedicao.f_onda_planejamento
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE expedicao.f_onda_planejamento
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- 4. Adicionar colunas de auditoria e join keys futuras
ALTER TABLE expedicao.f_onda_planejamento
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Coluna de join key (adicionar apos resolver no ETL):
-- ALTER TABLE expedicao.f_onda_planejamento ADD COLUMN cod_cliente varchar(20);

-- 5. Indices
CREATE INDEX idx_f_onda_plan_empresa     ON expedicao.f_onda_planejamento (id_empresa);
CREATE INDEX idx_f_onda_plan_dt_emissao  ON expedicao.f_onda_planejamento (dt_emissao_onda);
CREATE INDEX idx_f_onda_plan_dt_embarque ON expedicao.f_onda_planejamento (dt_embarque);
CREATE INDEX idx_f_onda_plan_updated_at  ON expedicao.f_onda_planejamento (updated_at);

-- 6. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW expedicao.fondas_planejamento AS
    SELECT * FROM expedicao.f_onda_planejamento;
COMMENT ON VIEW expedicao.fondas_planejamento IS
    'DEPRECATED 2026-05-05: usar f_onda_planejamento. Sera removido em 2026-08-03.';
```

---

### expedicao.fondas_por_usuario

**Nome proposto:** `expedicao.f_onda_por_usuario`
**Tipo:** fato
**Descricao:** Registro de producao de coleta por usuario em cada onda. Cada linha representa a quantidade de itens coletados por um operador de armazem em uma onda em uma data especifica. Suporta analise de produtividade por operador e por onda.
**Sistema de origem:** WMS (sistema de coleta — provavelmente PWT ou integrador)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| id_usuario | int4 NULL | id_usuario | integer | OK | Codigo operacional do usuario; `id_` correto. Tipo integer adequado. |
| usuario | varchar(100) NULL | nm_usuario | varchar(100) | RENAME | Nome do usuario; `nm_` correto para nome de pessoa/login. |
| data_onda | date NULL | dt_onda | date NOT NULL | RENAME, REFORMAT | Data da onda de coleta; `dt_` correto. NOT NULL pois e data obrigatoria em fatos. |
| id_onda | int4 NULL | cod_onda | varchar(20) NOT NULL | RENAME, RETYPE | Business key de onda — join key com `d_onda_pwt`. varchar(20) alinhado. |
| qtdeitens | int4 NULL | qt_itens | numeric(15,3) | RENAME, RETYPE | Quantidade de itens coletados; `qt_` correto. numeric(15,3) padrao DW. int4 original pode ser mantido se sempre inteiro, mas numeric(15,3) garante consistencia com demais fatos. |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | RENAME, REFORMAT | Coluna de auditoria; mapear para `updated_at`. |
| id | varchar(10) NULL | ds_id_externo | varchar(10) | RENAME | Campo `id` com nome conflitante com o surrogate key do DW. Renomear para `ds_id_externo` para preservar o valor original do sistema de origem sem ambiguidade. Verificar com equipe o significado exato deste campo. |
| — | — | id | bigserial PRIMARY KEY | ADD | Surrogate key obrigatoria. |
| — | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Auditoria obrigatoria. |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD] [CONFLITO]

**CONFLITO — campo `id`:** A tabela possui uma coluna chamada `id` do tipo `varchar(10)` que e um identificador externo (possivelmente codigo do WMS), mas colide com o padrao de surrogate key do DW. Renomear para `ds_id_externo` antes de adicionar o `id bigserial`. Verificar com equipe o significado do campo.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Candidato a chave natural (verificar unicidade):
```sql
-- UNIQUE (cod_onda, id_usuario, dt_onda)
```

#### Relacionamentos propostos

```
expedicao.f_onda_por_usuario
  |- cod_onda    -> expedicao.d_onda_pwt.cod_onda
  |- id_usuario  -> (referencia ao cadastro de usuarios do WMS — sem dimensao declarada no DW)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_onda_usr_cod_onda   ON expedicao.f_onda_por_usuario (cod_onda);
CREATE INDEX idx_f_onda_usr_id_usuario ON expedicao.f_onda_por_usuario (id_usuario);
CREATE INDEX idx_f_onda_usr_dt_onda    ON expedicao.f_onda_por_usuario (dt_onda);
CREATE INDEX idx_f_onda_usr_updated_at ON expedicao.f_onda_por_usuario (updated_at);
```

#### Impacto no ETL

- Campo `id` (varchar) deve ser renomeado para `ds_id_externo` no SELECT do pipeline imediatamente, pois o banco ira receber `id bigserial` como PK.
- `id_onda` (int4) -> `cod_onda` (varchar): cast `str(id_onda)` no pipeline.
- `qtdeitens` -> `qt_itens`: atualizacao simples de alias.
- `ultima_atualizacao` vira watermark de carga incremental.
- Verificar com a equipe o significado do campo `id varchar(10)` antes de renomear.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE expedicao.fondas_por_usuario RENAME TO f_onda_por_usuario;

-- 2. Renomear coluna conflitante ANTES de adicionar surrogate key
ALTER TABLE expedicao.f_onda_por_usuario
    RENAME COLUMN id TO ds_id_externo;

-- 3. Adicionar surrogate key
ALTER TABLE expedicao.f_onda_por_usuario
    ADD COLUMN id bigserial PRIMARY KEY;

-- 4. Renomear e retipar demais colunas
ALTER TABLE expedicao.f_onda_por_usuario
    RENAME COLUMN usuario TO nm_usuario;

ALTER TABLE expedicao.f_onda_por_usuario
    RENAME COLUMN data_onda TO dt_onda;
ALTER TABLE expedicao.f_onda_por_usuario
    ALTER COLUMN dt_onda SET NOT NULL;

ALTER TABLE expedicao.f_onda_por_usuario
    RENAME COLUMN id_onda TO cod_onda;
ALTER TABLE expedicao.f_onda_por_usuario
    ALTER COLUMN cod_onda TYPE varchar(20) USING cod_onda::varchar;
ALTER TABLE expedicao.f_onda_por_usuario
    ALTER COLUMN cod_onda SET NOT NULL;

ALTER TABLE expedicao.f_onda_por_usuario
    RENAME COLUMN qtdeitens TO qt_itens;
ALTER TABLE expedicao.f_onda_por_usuario
    ALTER COLUMN qt_itens TYPE numeric(15,3) USING qt_itens::numeric(15,3);

ALTER TABLE expedicao.f_onda_por_usuario
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE expedicao.f_onda_por_usuario
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- 5. Adicionar auditoria
ALTER TABLE expedicao.f_onda_por_usuario
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- 6. Indices
CREATE INDEX idx_f_onda_usr_cod_onda   ON expedicao.f_onda_por_usuario (cod_onda);
CREATE INDEX idx_f_onda_usr_id_usuario ON expedicao.f_onda_por_usuario (id_usuario);
CREATE INDEX idx_f_onda_usr_dt_onda    ON expedicao.f_onda_por_usuario (dt_onda);
CREATE INDEX idx_f_onda_usr_updated_at ON expedicao.f_onda_por_usuario (updated_at);

-- 7. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW expedicao.fondas_por_usuario AS
    SELECT * FROM expedicao.f_onda_por_usuario;
COMMENT ON VIEW expedicao.fondas_por_usuario IS
    'DEPRECATED 2026-05-05: usar f_onda_por_usuario. Sera removido em 2026-08-03.';
```

---

### expedicao.fondas_produtos_pendentes

**Nome proposto:** `expedicao.f_onda_produto_pendente`
**Tipo:** fato
**Descricao:** Registro de itens pendentes de coleta por onda e endereco de armazem. Cada linha representa um produto (identificado por nivel, grupo, subgrupo e item) em um endereco de estoque, com a quantidade ainda a coletar e a situacao da onda. Suporta gestao de pendencias de separacao e prioridade de coleta.
**Sistema de origem:** WMS de planejamento de expedicao

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| id_onda | int4 NULL | cod_onda | varchar(20) NOT NULL | RENAME, RETYPE | Business key de onda; join key com `d_onda_pwt`. varchar(20) alinhado. |
| nivel | varchar(10) NULL | ds_nivel_produto | varchar(10) | RENAME | Nivel hierarquico do produto (parte do SKU composto). `ds_` para descritivo. Manter separado ou construir `sku_produto` — ver nota abaixo. |
| grupo | varchar(10) NULL | ds_grupo | varchar(10) | RENAME | Grupo/referencia do produto (parte do SKU). `ds_` correto. |
| subgrupo | varchar(10) NULL | ds_subgrupo | varchar(10) | RENAME | Subgrupo/tamanho do produto (parte do SKU). `ds_` correto. |
| item | varchar(10) NULL | ds_item | varchar(10) | RENAME | Item/cor do produto (parte do SKU). `ds_` correto. |
| qtd_coletar_item | numeric(15,2) NULL | qt_coletar_item | numeric(15,3) | RENAME, RETYPE | Quantidade pendente de coleta; `qt_` correto. numeric(15,3) padrao. |
| endereco | varchar(50) NULL | end_armazem | varchar(50) | RENAME | Endereco fisico do produto no armazem; `end_` correto. |
| situacao_onda | varchar(20) NULL | ds_situacao_onda | varchar(20) | RENAME | Descricao da situacao da onda; `ds_` correto. |
| ultima_atualizacao | date NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | RENAME, RETYPE, REFORMAT | Tipo `date` e insuficiente para auditoria de carga — converter para `timestamp`. Mapear para `updated_at`. |
| — | — | sku_produto | varchar(30) | ADD | Construir `nivel || '.' || grupo || '.' || subgrupo || '.' || item` no ETL e gravar como join key de produto. Permite join com `live.d_produto`. |
| — | — | id | bigserial PRIMARY KEY | ADD | Surrogate key obrigatoria. |
| — | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Auditoria obrigatoria. |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD]

**Nota sobre SKU:** As quatro partes (`nivel`, `grupo`, `subgrupo`, `item`) estao presentes na tabela e sao exatamente as componentes do `sku_produto` conforme secao 6.1 das boas praticas. O ETL deve construir `sku_produto = nivel || '.' || grupo || '.' || subgrupo || '.' || item` e gravar na nova coluna, mantendo as partes individuais para compatibilidade retroativa.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Candidato a chave natural (verificar unicidade):
```sql
-- UNIQUE (cod_onda, sku_produto, end_armazem)
```

#### Relacionamentos propostos

```
expedicao.f_onda_produto_pendente
  |- cod_onda    -> expedicao.d_onda_pwt.cod_onda
  |- sku_produto -> live.d_produto.sku_produto  (apos adicionar coluna sku_produto)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_onda_pend_cod_onda    ON expedicao.f_onda_produto_pendente (cod_onda);
CREATE INDEX idx_f_onda_pend_sku_produto ON expedicao.f_onda_produto_pendente (sku_produto);
CREATE INDEX idx_f_onda_pend_situacao    ON expedicao.f_onda_produto_pendente (ds_situacao_onda);
CREATE INDEX idx_f_onda_pend_updated_at  ON expedicao.f_onda_produto_pendente (updated_at);
```

#### Impacto no ETL

- Adicionar logica de construcao de `sku_produto` no pipeline: `nivel + '.' + grupo + '.' + subgrupo + '.' + item`.
- `ultima_atualizacao` e `date` na origem — o pipeline deve converter para `timestamp` ao gravar em `updated_at`: usar `datetime.combine(ultima_atualizacao, datetime.min.time())` em Python.
- `id_onda` (int4) -> `cod_onda` (varchar): cast `str(id_onda)` no pipeline.
- `qt_coletar_item` de numeric(15,2) para numeric(15,3): sem perda de precisao.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE expedicao.fondas_produtos_pendentes RENAME TO f_onda_produto_pendente;

-- 2. Adicionar surrogate key
ALTER TABLE expedicao.f_onda_produto_pendente
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear e retipar colunas
ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN id_onda TO cod_onda;
ALTER TABLE expedicao.f_onda_produto_pendente
    ALTER COLUMN cod_onda TYPE varchar(20) USING cod_onda::varchar;
ALTER TABLE expedicao.f_onda_produto_pendente
    ALTER COLUMN cod_onda SET NOT NULL;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN nivel TO ds_nivel_produto;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN grupo TO ds_grupo;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN subgrupo TO ds_subgrupo;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN item TO ds_item;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN qtd_coletar_item TO qt_coletar_item;
ALTER TABLE expedicao.f_onda_produto_pendente
    ALTER COLUMN qt_coletar_item TYPE numeric(15,3) USING qt_coletar_item::numeric(15,3);

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN endereco TO end_armazem;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN situacao_onda TO ds_situacao_onda;

ALTER TABLE expedicao.f_onda_produto_pendente
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE expedicao.f_onda_produto_pendente
    ALTER COLUMN updated_at TYPE timestamp USING updated_at::timestamp;
ALTER TABLE expedicao.f_onda_produto_pendente
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- 4. Adicionar colunas de auditoria e sku_produto
ALTER TABLE expedicao.f_onda_produto_pendente
    ADD COLUMN created_at  timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN sku_produto  varchar(30);

-- 5. Popular sku_produto a partir das partes existentes
UPDATE expedicao.f_onda_produto_pendente
SET sku_produto = CONCAT_WS('.', ds_nivel_produto, ds_grupo, ds_subgrupo, ds_item)
WHERE sku_produto IS NULL;

-- 6. Indices
CREATE INDEX idx_f_onda_pend_cod_onda    ON expedicao.f_onda_produto_pendente (cod_onda);
CREATE INDEX idx_f_onda_pend_sku_produto ON expedicao.f_onda_produto_pendente (sku_produto);
CREATE INDEX idx_f_onda_pend_situacao    ON expedicao.f_onda_produto_pendente (ds_situacao_onda);
CREATE INDEX idx_f_onda_pend_updated_at  ON expedicao.f_onda_produto_pendente (updated_at);

-- 7. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW expedicao.fondas_produtos_pendentes AS
    SELECT * FROM expedicao.f_onda_produto_pendente;
COMMENT ON VIEW expedicao.fondas_produtos_pendentes IS
    'DEPRECATED 2026-05-05: usar f_onda_produto_pendente. Sera removido em 2026-08-03.';
```

---

### expedicao.fondas_pwt_resumo

**Nome proposto:** `expedicao.f_onda_pwt_resumo`
**Tipo:** fato
**Descricao:** Resumo agregado por onda do sistema PWT. Cada linha representa o estado consolidado de uma onda: equipamento utilizado, situacao, data da situacao e totais de quantidade a coletar, coletada e pedida. E a tabela de monitoramento operacional de ondas PWT em nivel de onda (nao de item).
**Sistema de origem:** PWT (WMS interno)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| onda | numeric(9) NULL | cod_onda | varchar(20) NOT NULL | RENAME, RETYPE | Business key de onda; join key com `d_onda_pwt`. Renomear de `onda` para `cod_onda` para explicitar o papel de join key. varchar(20) alinhado. |
| situacao | text NULL | ds_situacao_onda | varchar(50) | RENAME, RETYPE | Descricao da situacao da onda; `ds_` correto. varchar(50) adequado para valores de situacao. |
| equipamento | text NULL | ds_equipamento | varchar(100) | RENAME, RETYPE | Descricao do equipamento utilizado na onda; `ds_` correto. varchar(100) adequado. |
| data_situacao | timestamp NULL | dth_situacao | timestamp | RENAME | Data e hora da ultima mudanca de situacao; `dth_` correto para timestamp com hora. |
| qtd_coletar | numeric(38,10) NULL | qt_coletar | numeric(15,3) | RENAME, RETYPE | Quantidade total a coletar; `qt_` correto. numeric(38,10) e excessivo — numeric(15,3) e o padrao DW. Verificar se ha perda de precisao nos dados reais antes de migrar. |
| qtd_coletada | numeric(38,10) NULL | qt_coletada | numeric(15,3) | RENAME, RETYPE | Quantidade coletada; idem anterior. |
| qtd_pedido | numeric(38,10) NULL | qt_pedido | numeric(15,3) | RENAME, RETYPE | Quantidade pedida na onda; idem anterior. |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | RENAME, REFORMAT | Coluna de auditoria; mapear para `updated_at`. |
| — | — | id | bigserial PRIMARY KEY | ADD | Surrogate key obrigatoria. |
| — | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | ADD | Auditoria obrigatoria. |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD] [CONFLITO]

**CONFLITO — tipo numeric(38,10):** O tipo `numeric(38,10)` e o padrao legado de sistemas Oracle/Systextil e indica que o campo foi copiado diretamente da origem sem normalizacao de tipo. A conversao para `numeric(15,3)` pode truncar valores com mais de 3 casas decimais. Antes de migrar, executar:
```sql
SELECT MAX(ABS(qtd_coletar - qtd_coletar::numeric(15,3))) AS max_diff
FROM expedicao.fondas_pwt_resumo;
```
Se `max_diff = 0`, a conversao e segura.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Candidato a chave natural (verificar unicidade — pode ter multiplos estados por onda ao longo do tempo):
```sql
-- UNIQUE (cod_onda, dth_situacao)  -- se a onda so tem um registro por timestamp de situacao
```

#### Relacionamentos propostos

```
expedicao.f_onda_pwt_resumo
  |- cod_onda -> expedicao.d_onda_pwt.cod_onda
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_onda_pwt_res_cod_onda    ON expedicao.f_onda_pwt_resumo (cod_onda);
CREATE INDEX idx_f_onda_pwt_res_situacao    ON expedicao.f_onda_pwt_resumo (ds_situacao_onda);
CREATE INDEX idx_f_onda_pwt_res_dth_situacao ON expedicao.f_onda_pwt_resumo (dth_situacao);
CREATE INDEX idx_f_onda_pwt_res_updated_at  ON expedicao.f_onda_pwt_resumo (updated_at);
```

#### Impacto no ETL

- `onda` (numeric) -> `cod_onda` (varchar): cast `str(int(onda))` no pipeline.
- `qtd_coletar/qtd_coletada/qtd_pedido` (numeric(38,10)): executar validacao de precisao antes da migracao de tipo.
- `ultima_atualizacao` vira watermark de carga incremental em `updated_at`.
- Verificar se o pipeline envia `numeric(38,10)` pelo SQLAlchemy — se sim, ajustar o dtype para `Numeric(15,3)` no `to_sql`.

#### Migracao SQL

```sql
-- PRECAUCAO: executar validacao de precisao antes deste script
-- SELECT MAX(ABS(qtd_coletar - qtd_coletar::numeric(15,3))) FROM expedicao.fondas_pwt_resumo;

-- 1. Renomear tabela
ALTER TABLE expedicao.fondas_pwt_resumo RENAME TO f_onda_pwt_resumo;

-- 2. Adicionar surrogate key
ALTER TABLE expedicao.f_onda_pwt_resumo
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear e retipar colunas
ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN onda TO cod_onda;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN cod_onda TYPE varchar(20) USING cod_onda::varchar;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN cod_onda SET NOT NULL;

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN situacao TO ds_situacao_onda;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN ds_situacao_onda TYPE varchar(50) USING ds_situacao_onda::varchar(50);

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN equipamento TO ds_equipamento;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN ds_equipamento TYPE varchar(100) USING ds_equipamento::varchar(100);

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN data_situacao TO dth_situacao;

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN qtd_coletar TO qt_coletar;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN qt_coletar TYPE numeric(15,3) USING qt_coletar::numeric(15,3);

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN qtd_coletada TO qt_coletada;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN qt_coletada TYPE numeric(15,3) USING qt_coletada::numeric(15,3);

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN qtd_pedido TO qt_pedido;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN qt_pedido TYPE numeric(15,3) USING qt_pedido::numeric(15,3);

ALTER TABLE expedicao.f_onda_pwt_resumo
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE expedicao.f_onda_pwt_resumo
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

-- 4. Adicionar auditoria
ALTER TABLE expedicao.f_onda_pwt_resumo
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- 5. Indices
CREATE INDEX idx_f_onda_pwt_res_cod_onda     ON expedicao.f_onda_pwt_resumo (cod_onda);
CREATE INDEX idx_f_onda_pwt_res_situacao     ON expedicao.f_onda_pwt_resumo (ds_situacao_onda);
CREATE INDEX idx_f_onda_pwt_res_dth_situacao ON expedicao.f_onda_pwt_resumo (dth_situacao);
CREATE INDEX idx_f_onda_pwt_res_updated_at   ON expedicao.f_onda_pwt_resumo (updated_at);

-- 6. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW expedicao.fondas_pwt_resumo AS
    SELECT * FROM expedicao.f_onda_pwt_resumo;
COMMENT ON VIEW expedicao.fondas_pwt_resumo IS
    'DEPRECATED 2026-05-05: usar f_onda_pwt_resumo. Sera removido em 2026-08-03.';
```

---

## Resumo de Renomeacoes

| Nome atual | Nome proposto | Tipo |
|---|---|---|
| expedicao.dondas_pwt | expedicao.d_onda_pwt | dimensao |
| expedicao.dondas_slim_sorter | expedicao.f_onda_slim_sorter | fato |
| expedicao.fondas_planejamento | expedicao.f_onda_planejamento | fato |
| expedicao.fondas_por_usuario | expedicao.f_onda_por_usuario | fato |
| expedicao.fondas_produtos_pendentes | expedicao.f_onda_produto_pendente | fato |
| expedicao.fondas_pwt_resumo | expedicao.f_onda_pwt_resumo | fato |

---

## Resumo de Conflitos e Pontos de Atencao

| Tabela | Conflito | Acao necessaria |
|---|---|---|
| f_onda_slim_sorter | Campo `sku` pode ser fragmento do SKU, nao o SKU composto | Confirmar com equipe WMS antes de renomear para `sku_produto` |
| f_onda_planejamento | Campos de cliente/representante/transportadora sao nomes livres sem codigo de join | Criar lookup no ETL para resolver `cod_cliente` e `cod_representante` |
| f_onda_por_usuario | Campo `id varchar(10)` colide com padrao de surrogate key DW | Renomear para `ds_id_externo` antes de adicionar `id bigserial`; confirmar significado com equipe |
| f_onda_pwt_resumo | Tipo `numeric(38,10)` em tres colunas de quantidade | Validar perda de precisao antes de converter para `numeric(15,3)` |

---

## Ordem de Execucao das Migracoes

Para garantir integridade referencial por convencao (sem FKs declaradas), executar nesta sequencia:

1. `expedicao.d_onda_pwt` — dimensao base; deve existir antes dos fatos
2. `expedicao.f_onda_pwt_resumo` — fato que referencia `d_onda_pwt`
3. `expedicao.f_onda_slim_sorter` — fato que referencia `d_onda_pwt` (apos validar campo `sku`)
4. `expedicao.f_onda_planejamento` — fato independente de onda PWT (sem join direto com `d_onda_pwt`)
5. `expedicao.f_onda_por_usuario` — fato que referencia `d_onda_pwt`
6. `expedicao.f_onda_produto_pendente` — fato que referencia `d_onda_pwt` e `live.d_produto`

---

## Arquivo de Versao de Migracao

Nomear o arquivo DDL de migracao conforme padrao da secao 17.4 das boas praticas:

```
V20260505__expedicao_rename_all_tables.sql
```
