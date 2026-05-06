# Dicionario de Dados — Schema `estoque`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 12 tabelas, 158 colunas
**Responsavel:** Schema estoque — movimentacoes, saldos de rolos, reservas e inventario

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `estoque.dtipo_movimentacaoestoque` | `estoque.d_tipo_movimento_estoque` | dimensao |
| `estoque.fcigam_saldo_estoque_atual` | `estoque.f_cigam_saldo_estoque_atual` | fato |
| `estoque.fentrada_op_estoque` | `estoque.f_entrada_op_estoque` | fato |
| `estoque.finventario_contabil` | `estoque.f_inventario_contabil` | fato |
| `estoque.freserva_estoque` | `estoque.f_reserva_estoque` | fato |
| `estoque.freserva_tinturaria` | `estoque.f_reserva_tinturaria` | fato |
| `estoque.frolos_estoq` | `estoque.f_rolo_estoque` | fato |
| `estoque.frolos_estoq_cong` | `estoque.f_rolo_estoque_cong` | fato |
| `estoque.fsaldoestoqueatual` | `estoque.f_saldo_estoque_atual` | fato |
| `estoque.fsaldoestoqueatual_cong` | `estoque.f_saldo_estoque_atual_cong` | fato |
| `estoque.fsaldoestoqueinteg` | `estoque.f_saldo_estoque_integ` | fato |
| `estoque.ftecidos_estoque` | `estoque.f_tecido_estoque` | fato |

---

## Detalhamento por Tabela

---

### estoque.dtipo_movimentacaoestoque

**Nome proposto:** `estoque.d_tipo_movimento_estoque`
**Tipo:** dimensao
**Descricao:** Tabela de dominio que classifica os tipos de transacao de movimentacao de estoque. Usada como lookup para categorizar entradas, saidas e transferencias registradas nas tabelas fato do schema.
**Sistema de origem:** Systextil / ERP interno

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `codigo_transacao` | `numeric(3) NULL` | `id` | `bigserial NOT NULL` | [RETYPE] [RENAME] | Surrogate key da dimensao; `numeric(3)` substituido por `bigserial` conforme BOAS_PRATICAS secao 5 |
| `codigo_transacao` | `numeric(3) NULL` | `id_tipo_movimento` | `smallint` | [ADD] | Business key operacional que identifica o tipo de transacao; mantido como `id_` pois nao e entidade com dimensao propria (secao 3.1) |
| `descricao` | `text NULL` | `ds_tipo_movimento` | `varchar(100)` | [RENAME] [RETYPE] | `text` irrestrito substituido por `varchar(100)`; prefixo `ds_` para descricoes curtas |
| `tipo_transacao` | `text NULL` | `ds_natureza_transacao` | `varchar(50)` | [RENAME] [RETYPE] | Classifica a natureza (entrada/saida/transferencia); `ds_` + `varchar(50)` adequados |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria; substitui padrao `ultima_atualizacao` ausente nesta tabela |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade sobre o codigo operacional:

```sql
CONSTRAINT uq_d_tipo_movimento_estoque_id UNIQUE (id_tipo_movimento)
```

#### Relacionamentos propostos

```
estoque.d_tipo_movimento_estoque
  <- estoque.f_inventario_contabil.id_tipo_movimento  (referencia por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_d_tipo_movimento_id ON estoque.d_tipo_movimento_estoque (id_tipo_movimento);
```

#### Impacto no ETL

- Renomear tabela exige atualizar DAG de carga e todas as queries de lookup.
- Criar view de compatibilidade `estoque.dtipo_movimentacaoestoque` por 90 dias.
- Pipeline deve mapear `codigo_transacao` -> `id_tipo_movimento` (smallint).
- Adicionar colunas `created_at` e `updated_at` com `DEFAULT current_timestamp`; ETL nao precisa envia-las.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE estoque.dtipo_movimentacaoestoque RENAME TO d_tipo_movimento_estoque;

-- 2. Adicionar surrogate key
ALTER TABLE estoque.d_tipo_movimento_estoque
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Adicionar coluna operacional tipada corretamente
ALTER TABLE estoque.d_tipo_movimento_estoque
    ADD COLUMN id_tipo_movimento smallint;

UPDATE estoque.d_tipo_movimento_estoque
    SET id_tipo_movimento = codigo_transacao::smallint;

ALTER TABLE estoque.d_tipo_movimento_estoque
    ADD CONSTRAINT uq_d_tipo_movimento_id UNIQUE (id_tipo_movimento);

-- 4. Renomear colunas descritivas
ALTER TABLE estoque.d_tipo_movimento_estoque
    RENAME COLUMN descricao TO ds_tipo_movimento;

ALTER TABLE estoque.d_tipo_movimento_estoque
    ALTER COLUMN ds_tipo_movimento TYPE varchar(100);

ALTER TABLE estoque.d_tipo_movimento_estoque
    RENAME COLUMN tipo_transacao TO ds_natureza_transacao;

ALTER TABLE estoque.d_tipo_movimento_estoque
    ALTER COLUMN ds_natureza_transacao TYPE varchar(50);

-- 5. Remover coluna original substituida
ALTER TABLE estoque.d_tipo_movimento_estoque
    DROP COLUMN codigo_transacao;

-- 6. Auditoria
ALTER TABLE estoque.d_tipo_movimento_estoque
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- 7. View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW estoque.dtipo_movimentacaoestoque AS
    SELECT * FROM estoque.d_tipo_movimento_estoque;
COMMENT ON VIEW estoque.dtipo_movimentacaoestoque IS
    'DEPRECATED 2026-05-05: usar d_tipo_movimento_estoque. Sera removido em 2026-08-03.';
```

---

### estoque.fcigam_saldo_estoque_atual

**Nome proposto:** `estoque.f_cigam_saldo_estoque_atual`
**Tipo:** fato
**Descricao:** Fato de saldo de estoque atual proveniente do sistema CIGAM (lojas/franquias). Registra a quantidade em estoque por loja e produto, identificado por codigo de barras. Granularidade: um registro por loja x produto x data de referencia.
**Sistema de origem:** CIGAM (sistema de gestao de lojas/franquias)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `loja` | `text NULL` | `ds_loja` | `varchar(10)` | [RENAME] [RETYPE] | Codigo curto da loja; `ds_` para descricoes/codigos alfanumericos de identificacao; `text` substituido por `varchar(10)` |
| `cnpj` | `text NULL` | `cnpj_loja` | `varchar(16)` | [RENAME] [RETYPE] | Nome segue dimensao de referencia `d_loja`; formato padrao CNPJ `XXXXXXXX/YYYY-ZZ`; `text` irrestrito e anti-padrao |
| `cod_barras` | `text NULL` | `cod_barras` | `varchar(20)` | [RETYPE] | `text` substituido por `varchar(20)` com tamanho explicito |
| `codigo_barras_ean` | `text NULL` | `cod_barras_ean` | `varchar(30)` | [RENAME] [RETYPE] | Remover prefixo `codigo_` (proibido); `varchar(30)` adequado para EAN-13/EAN-128 |
| `qtd_estoque` | `numeric(6) NULL` | `qt_estoque` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_` canonico; `numeric(6)` sem casas decimais substituido por `numeric(15,3)` padrao de quantidade |
| `data_estoque` | `timestamp NULL` | `dt_referencia` | `date` | [RENAME] [RETYPE] | Campo representa data de referencia do saldo, sem componente de hora relevante; `date` adequado; nome mais semantico |
| `id_rede` | `numeric(6) NULL` | `id_rede` | `smallint` | [RETYPE] | Nome correto com prefixo `id_`; `numeric(6)` -> `smallint` para codigo operacional de rede |
| `nome_loja` | `text NULL` | `nm_loja` | `varchar(100)` | [RENAME] [RETYPE] | Prefixo `nm_` para nomes completos; `varchar(100)` com limite explicito |
| `situacao` | `numeric(1) NULL` | `fl_ativo` | `boolean` | [RENAME] [RETYPE] | Flag de situacao ativa/inativa; `boolean` padrao (secao 8); substituir logica 1/0 no pipeline |
| `mes_ano` | `text NULL` | `ds_mes_ano` | `varchar(7)` | [RENAME] [RETYPE] | Descricao de periodo no formato `YYYY-MM`; `varchar(7)` adequado |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao (secao 4; secao 15.4) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Considerar constraint de unicidade composta:

```sql
CONSTRAINT uq_f_cigam_saldo UNIQUE (cnpj_loja, cod_barras, dt_referencia)
```

#### Relacionamentos propostos

```
estoque.f_cigam_saldo_estoque_atual
  |- cnpj_loja      -> live.d_loja.cnpj_loja           (por convencao, sem FK declarada)
  |- cod_barras_ean -> d_produto via ean (cross-reference)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_cigam_saldo_cnpj_loja   ON estoque.f_cigam_saldo_estoque_atual (cnpj_loja);
CREATE INDEX idx_f_cigam_saldo_cod_barras  ON estoque.f_cigam_saldo_estoque_atual (cod_barras);
CREATE INDEX idx_f_cigam_saldo_dt_ref      ON estoque.f_cigam_saldo_estoque_atual (dt_referencia);
CREATE INDEX idx_f_cigam_saldo_updated_at  ON estoque.f_cigam_saldo_estoque_atual (updated_at);
```

#### Impacto no ETL

- Pipeline CIGAM deve converter `situacao` (numeric 0/1) para `boolean` antes do insert.
- Campo `data_estoque` (timestamp) deve ser truncado para `date` no pipeline: `pd.to_datetime(df['data_estoque']).dt.date`.
- `cnpj` deve ser formatado via `fn_formatar_cnpj_cpf` antes da carga.
- Watermark de carga incremental: `updated_at`.

#### Migracao SQL

```sql
ALTER TABLE estoque.fcigam_saldo_estoque_atual RENAME TO f_cigam_saldo_estoque_atual;

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN loja TO ds_loja;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN ds_loja TYPE varchar(10);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN cnpj TO cnpj_loja;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN cnpj_loja TYPE varchar(16);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN cod_barras TYPE varchar(20);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN codigo_barras_ean TO cod_barras_ean;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN cod_barras_ean TYPE varchar(30);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN qtd_estoque TO qt_estoque;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN qt_estoque TYPE numeric(15,3);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN data_estoque TO dt_referencia;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN id_rede TYPE smallint USING id_rede::smallint;

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN nome_loja TO nm_loja;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN nm_loja TYPE varchar(100);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ADD COLUMN fl_ativo boolean;
UPDATE estoque.f_cigam_saldo_estoque_atual
    SET fl_ativo = CASE WHEN situacao = 1 THEN TRUE ELSE FALSE END;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    DROP COLUMN situacao;

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN mes_ano TO ds_mes_ano;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN ds_mes_ano TYPE varchar(7);

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_cigam_saldo_estoque_atual
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.fcigam_saldo_estoque_atual AS
    SELECT * FROM estoque.f_cigam_saldo_estoque_atual;
COMMENT ON VIEW estoque.fcigam_saldo_estoque_atual IS
    'DEPRECATED 2026-05-05: usar f_cigam_saldo_estoque_atual. Sera removido em 2026-08-03.';
```

---

### estoque.fentrada_op_estoque

**Nome proposto:** `estoque.f_entrada_op_estoque`
**Tipo:** fato
**Descricao:** Fato de entradas de estoque por ordem de producao. Registra quantidade e valor monetario de materiais ou produtos que entram no estoque como resultado de uma ordem de producao finalizada. Granularidade: um registro por ordem de producao x SKU x data de movimento.
**Sistema de origem:** Systextil / ERP producao

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `data_movimento` | `timestamp NULL` | `dt_movimento` | `date` | [RENAME] [RETYPE] | Data de entrada no estoque sem componente de hora relevante para analise; `dt_` + `date` |
| `sku` | `varchar(20) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | Renomear para join key canonica `sku_produto` (secao 6.1); `varchar(30)` tipo padrao do DW |
| `ordem_producao` | `varchar(10) NULL` | `nr_ordem_producao` | `varchar(10)` | [RENAME] | Prefixo `nr_` para numero de documento (secao 3.2); tipo mantido |
| `quantidade_entrada` | `int8 NULL` | `qt_entrada` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_` canonico; `int8` substituido por `numeric(15,3)` para suportar fracoes (kg, m) |
| `valor_monetario_entrada` | `numeric(18,3) NULL` | `vl_entrada` | `numeric(15,2)` | [RENAME] [RETYPE] | Prefixo `vl_` canonico; `numeric(18,3)` -> `numeric(15,2)` padrao monetario (secao 8); 3 casas aceitaveis se USD |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria; ausente na tabela original |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

#### Relacionamentos propostos

```
estoque.f_entrada_op_estoque
  |- sku_produto      -> live.d_produto.sku_produto        (por convencao, sem FK declarada)
  |- nr_ordem_producao -> ppcp.f_ordem_producao.nr_ordem_producao (por convencao)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_entrada_op_sku_produto      ON estoque.f_entrada_op_estoque (sku_produto);
CREATE INDEX idx_f_entrada_op_nr_ordem         ON estoque.f_entrada_op_estoque (nr_ordem_producao);
CREATE INDEX idx_f_entrada_op_dt_movimento     ON estoque.f_entrada_op_estoque (dt_movimento);
CREATE INDEX idx_f_entrada_op_updated_at       ON estoque.f_entrada_op_estoque (updated_at);
```

#### Impacto no ETL

- Campo `sku` no pipeline deve ser renomeado/mapeado para `sku_produto` e o tipo deve ser `varchar(30)`.
- `quantidade_entrada` (int8) deve ser convertido para `Decimal`/`float` com possibilidade de fracao.
- `data_movimento` (timestamp) truncar para `date` no pipeline.
- Adicionar `updated_at` ao pipeline com valor de `current_timestamp` ou watermark da origem.

#### Migracao SQL

```sql
ALTER TABLE estoque.fentrada_op_estoque RENAME TO f_entrada_op_estoque;

ALTER TABLE estoque.f_entrada_op_estoque
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_entrada_op_estoque
    RENAME COLUMN data_movimento TO dt_movimento;
ALTER TABLE estoque.f_entrada_op_estoque
    ALTER COLUMN dt_movimento TYPE date USING dt_movimento::date;

ALTER TABLE estoque.f_entrada_op_estoque
    RENAME COLUMN sku TO sku_produto;
ALTER TABLE estoque.f_entrada_op_estoque
    ALTER COLUMN sku_produto TYPE varchar(30);

ALTER TABLE estoque.f_entrada_op_estoque
    RENAME COLUMN ordem_producao TO nr_ordem_producao;

ALTER TABLE estoque.f_entrada_op_estoque
    RENAME COLUMN quantidade_entrada TO qt_entrada;
ALTER TABLE estoque.f_entrada_op_estoque
    ALTER COLUMN qt_entrada TYPE numeric(15,3) USING qt_entrada::numeric(15,3);

ALTER TABLE estoque.f_entrada_op_estoque
    RENAME COLUMN valor_monetario_entrada TO vl_entrada;
ALTER TABLE estoque.f_entrada_op_estoque
    ALTER COLUMN vl_entrada TYPE numeric(15,2) USING vl_entrada::numeric(15,2);

ALTER TABLE estoque.f_entrada_op_estoque
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.fentrada_op_estoque AS
    SELECT * FROM estoque.f_entrada_op_estoque;
COMMENT ON VIEW estoque.fentrada_op_estoque IS
    'DEPRECATED 2026-05-05: usar f_entrada_op_estoque. Sera removido em 2026-08-03.';
```

---

### estoque.finventario_contabil

**Nome proposto:** `estoque.f_inventario_contabil`
**Tipo:** fato
**Descricao:** Fato de inventario contabil por empresa, deposito e produto. Registra saldo fisico, custo medio e valor total de estoque por periodo mensal. Base para apuracao contabil do valor de estoque. Granularidade: um registro por empresa x deposito x item x mes/ano.
**Sistema de origem:** Systextil / ERP contabilidade

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `empresa` | `int4 NULL` | `id_empresa` | `smallint` | [RENAME] [RETYPE] | Codigo operacional de empresa; prefixo `id_`; `int4` -> `smallint` suficiente para codigos de empresa |
| `deposito` | `int4 NULL` | `cod_deposito` | `smallint` | [RENAME] [RETYPE] | Join key canonico de deposito (secao 11); `int4` -> `smallint` conforme padrao do dicionario de entidades |
| `descr_deposito` | `varchar(255) NULL` | `ds_deposito` | `varchar(100)` | [RENAME] [RETYPE] | Prefixo `ds_`; `varchar(255)` superdimensionado; `varchar(100)` adequado para nomes de deposito |
| `nivel` | `varchar(50) NULL` | `nr_nivel_estrutura` | `varchar(3)` | [RENAME] [RETYPE] | Nivel hierarquico do SKU; `varchar(3)` padrao do Systextil para nivel |
| `grupo` | `varchar(50) NULL` | `nr_grupo_estrutura` | `varchar(10)` | [RENAME] [RETYPE] | Referencia/artigo do SKU; `varchar(10)` conforme origem |
| `subgrupo` | `varchar(50) NULL` | `nr_subgrupo_estrutura` | `varchar(10)` | [RENAME] [RETYPE] | Tamanho do SKU; `varchar(10)` conforme origem |
| `item` | `varchar(50) NULL` | `nr_item_estrutura` | `varchar(10)` | [RENAME] [RETYPE] | Cor do SKU; `varchar(10)` conforme origem |
| `unidade_medida` | `varchar(10) NULL` | `ds_unidade_medida` | `varchar(5)` | [RENAME] [RETYPE] | Unidade de medida (KG, MT, PC); `varchar(5)` suficiente |
| `narrativa` | `varchar(255) NULL` | `obs_narrativa` | `text` | [RENAME] [RETYPE] | Texto livre de observacao; prefixo `obs_`; `text` mais adequado que `varchar(255)` arbitrario |
| `saldo_fisico` | `numeric(18,4) NULL` | `qt_saldo_fisico` | `numeric(15,3)` | [RENAME] [RETYPE] | Quantidade fisica em estoque; prefixo `qt_`; `numeric(15,3)` padrao de quantidade |
| `custo_medio` | `numeric(18,6) NULL` | `vl_custo_medio` | `numeric(15,6)` | [RENAME] [RETYPE] | Valor unitario de custo medio; prefixo `vl_`; 6 casas decimais mantidas pela precisao necessaria |
| `saldo` | `numeric(18,6) NULL` | `vl_saldo_contabil` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor contabil total (saldo_fisico x custo_medio); prefixo `vl_`; nome mais explicito |
| `mes_ano_movimento` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Data de referencia do periodo de inventario; `date` correto; nome mais semantico |
| `ultima_atualizacao` | `date NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] [RETYPE] | Auditoria padrao; `date` -> `timestamp` para precisao de carga |
| — | — | `sku_produto` | `varchar(30)` | [ADD] | Join key calculada pela concatenacao de nivel+grupo+subgrupo+item no pipeline (secao 6.1) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade:

```sql
CONSTRAINT uq_f_inventario_contabil UNIQUE (id_empresa, cod_deposito, sku_produto, dt_referencia)
```

#### Relacionamentos propostos

```
estoque.f_inventario_contabil
  |- id_empresa    -> (operacional — sem dimensao propria)
  |- cod_deposito  -> d_deposito.cod_deposito              (por convencao, sem FK declarada)
  |- sku_produto   -> live.d_produto.sku_produto           (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_inventario_cod_deposito ON estoque.f_inventario_contabil (cod_deposito);
CREATE INDEX idx_f_inventario_sku_produto  ON estoque.f_inventario_contabil (sku_produto);
CREATE INDEX idx_f_inventario_dt_ref       ON estoque.f_inventario_contabil (dt_referencia);
CREATE INDEX idx_f_inventario_id_empresa   ON estoque.f_inventario_contabil (id_empresa);
CREATE INDEX idx_f_inventario_updated_at   ON estoque.f_inventario_contabil (updated_at);
```

#### Impacto no ETL

- Pipeline deve calcular `sku_produto = nivel || '.' || grupo || '.' || subgrupo || '.' || item` antes do insert.
- `empresa` (int4) -> `id_empresa` (smallint): verificar limites no banco de origem.
- `deposito` (int4) -> `cod_deposito` (smallint): idem.
- `ultima_atualizacao` (date) deve ser convertido para timestamp no pipeline.
- Colunas de estrutura (nivel, grupo, subgrupo, item) podem ser mantidas em paralelo ate migracao completa.

#### Migracao SQL

```sql
ALTER TABLE estoque.finventario_contabil RENAME TO f_inventario_contabil;

ALTER TABLE estoque.f_inventario_contabil
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN empresa TO id_empresa;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN id_empresa TYPE smallint USING id_empresa::smallint;

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN deposito TO cod_deposito;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN cod_deposito TYPE smallint USING cod_deposito::smallint;

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN descr_deposito TO ds_deposito;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN ds_deposito TYPE varchar(100);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN nivel TO nr_nivel_estrutura;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN nr_nivel_estrutura TYPE varchar(3);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN grupo TO nr_grupo_estrutura;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN nr_grupo_estrutura TYPE varchar(10);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN subgrupo TO nr_subgrupo_estrutura;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN nr_subgrupo_estrutura TYPE varchar(10);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN item TO nr_item_estrutura;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN nr_item_estrutura TYPE varchar(10);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN unidade_medida TO ds_unidade_medida;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN ds_unidade_medida TYPE varchar(5);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN narrativa TO obs_narrativa;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN obs_narrativa TYPE text;

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN saldo_fisico TO qt_saldo_fisico;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN qt_saldo_fisico TYPE numeric(15,3);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN custo_medio TO vl_custo_medio;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN vl_custo_medio TYPE numeric(15,6);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN saldo TO vl_saldo_contabil;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN vl_saldo_contabil TYPE numeric(15,2);

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN mes_ano_movimento TO dt_referencia;

ALTER TABLE estoque.f_inventario_contabil
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_inventario_contabil
    ALTER COLUMN updated_at TYPE timestamp USING updated_at::timestamp,
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_inventario_contabil
    ADD COLUMN sku_produto varchar(30);

UPDATE estoque.f_inventario_contabil
    SET sku_produto = nr_nivel_estrutura || '.' || nr_grupo_estrutura || '.' ||
                      nr_subgrupo_estrutura || '.' || nr_item_estrutura;

ALTER TABLE estoque.f_inventario_contabil
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.finventario_contabil AS
    SELECT * FROM estoque.f_inventario_contabil;
COMMENT ON VIEW estoque.finventario_contabil IS
    'DEPRECATED 2026-05-05: usar f_inventario_contabil. Sera removido em 2026-08-03.';
```

---

### estoque.freserva_estoque

**Nome proposto:** `estoque.f_reserva_estoque`
**Tipo:** fato
**Descricao:** Fato de reservas de materiais para ordens de producao. Registra a quantidade reservada de insumos (tecidos, aviamentos) por ordem de producao e estagio produtivo. Granularidade: um registro por item de estrutura x ordem de producao x estagio.
**Sistema de origem:** Systextil / ERP producao (PPCP)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `nivel_estrutura` | `text NULL` | `nr_nivel_estrutura` | `varchar(3)` | [RENAME] [RETYPE] | Nivel hierarquico do SKU; `varchar(3)` padrao Systextil; `text` substituido |
| `grupo_estrutura` | `text NULL` | `nr_grupo_estrutura` | `varchar(10)` | [RENAME] [RETYPE] | Referencia/artigo; `varchar(10)` conforme origem |
| `subgru_estrutura` | `text NULL` | `nr_subgrupo_estrutura` | `varchar(10)` | [RENAME] [RETYPE] | Nome completo sem abreviacao `subgru_`; `varchar(10)` |
| `item_estrutura` | `text NULL` | `nr_item_estrutura` | `varchar(10)` | [RENAME] [RETYPE] | Codigo de cor/item; `varchar(10)` |
| `ordem_producao` | `numeric(9) NULL` | `nr_ordem_producao` | `integer` | [RENAME] [RETYPE] | Prefixo `nr_` para numero de documento; `integer` adequado para numero de OP |
| `codigo_estagio` | `numeric(5) NULL` | `id_estagio` | `smallint` | [RENAME] [RETYPE] | Codigo operacional de estagio produtivo; prefixo `id_`; `smallint` suficiente |
| `quantidade_reservada` | `numeric(38,10) NULL` | `qt_reservada` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_` canonico; `numeric(38,10)` e tipo legado Oracle sem sentido no Postgres; `numeric(15,3)` padrao |
| — | — | `sku_produto` | `varchar(30)` | [ADD] | Join key calculada no pipeline a partir das 4 partes de estrutura (secao 6.1) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria; ausente na tabela original |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

#### Relacionamentos propostos

```
estoque.f_reserva_estoque
  |- sku_produto       -> live.d_produto.sku_produto          (por convencao, sem FK declarada)
  |- nr_ordem_producao -> ppcp.f_ordem_producao.nr_ordem_producao (por convencao)
  |- id_estagio        -> ppcp.d_estagio.id_estagio           (por convencao)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_reserva_estoque_sku          ON estoque.f_reserva_estoque (sku_produto);
CREATE INDEX idx_f_reserva_estoque_nr_op        ON estoque.f_reserva_estoque (nr_ordem_producao);
CREATE INDEX idx_f_reserva_estoque_id_estagio   ON estoque.f_reserva_estoque (id_estagio);
CREATE INDEX idx_f_reserva_estoque_updated_at   ON estoque.f_reserva_estoque (updated_at);
```

#### Impacto no ETL

- Pipeline deve calcular `sku_produto` a partir das 4 partes da estrutura antes do insert.
- `quantidade_reservada` (numeric 38,10): converter para `Decimal` com 3 casas no pipeline; verificar overflow potencial.
- `numeric(9)` para `nr_ordem_producao` -> `integer`: verificar se ha OPs com valor > 2.147.483.647 (improvavel).
- Adicionar `created_at` e `updated_at` como `current_timestamp` na carga inicial.

#### Migracao SQL

```sql
ALTER TABLE estoque.freserva_estoque RENAME TO f_reserva_estoque;

ALTER TABLE estoque.f_reserva_estoque
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN nivel_estrutura TO nr_nivel_estrutura;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN nr_nivel_estrutura TYPE varchar(3);

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN grupo_estrutura TO nr_grupo_estrutura;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN nr_grupo_estrutura TYPE varchar(10);

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN subgru_estrutura TO nr_subgrupo_estrutura;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN nr_subgrupo_estrutura TYPE varchar(10);

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN item_estrutura TO nr_item_estrutura;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN nr_item_estrutura TYPE varchar(10);

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN ordem_producao TO nr_ordem_producao;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN nr_ordem_producao TYPE integer USING nr_ordem_producao::integer;

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN codigo_estagio TO id_estagio;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN id_estagio TYPE smallint USING id_estagio::smallint;

ALTER TABLE estoque.f_reserva_estoque
    RENAME COLUMN quantidade_reservada TO qt_reservada;
ALTER TABLE estoque.f_reserva_estoque
    ALTER COLUMN qt_reservada TYPE numeric(15,3) USING qt_reservada::numeric(15,3);

ALTER TABLE estoque.f_reserva_estoque
    ADD COLUMN sku_produto varchar(30);

UPDATE estoque.f_reserva_estoque
    SET sku_produto = nr_nivel_estrutura || '.' || nr_grupo_estrutura || '.' ||
                      nr_subgrupo_estrutura || '.' || nr_item_estrutura;

ALTER TABLE estoque.f_reserva_estoque
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.freserva_estoque AS
    SELECT * FROM estoque.f_reserva_estoque;
COMMENT ON VIEW estoque.freserva_estoque IS
    'DEPRECATED 2026-05-05: usar f_reserva_estoque. Sera removido em 2026-08-03.';
```

---

### estoque.freserva_tinturaria

**Nome proposto:** `estoque.f_reserva_tinturaria`
**Tipo:** fato
**Descricao:** Fato de reservas de materiais especificas para o processo de tinturaria. Registra a quantidade requisitada de insumos quimicos ou tecidos por ordem de producao/agrupamento e estagio. Granularidade: um registro por item de composicao x ordem de producao x ordem de agrupamento x estagio.
**Sistema de origem:** Systextil / ERP producao (modulo tinturaria)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `ordem_agrupamento` | `varchar(10) NULL` | `nr_ordem_agrupamento` | `varchar(10)` | [RENAME] | Prefixo `nr_` para numero de documento; tipo mantido |
| `ordem_de_producao` | `varchar(10) NULL` | `nr_ordem_producao` | `varchar(10)` | [RENAME] | Remover `_de_`; prefixo `nr_`; tipo mantido |
| `data_de_emissao` | `timestamp NULL` | `dt_emissao` | `date` | [RENAME] [RETYPE] | Remover `_de_`; data sem hora relevante; `date` adequado |
| `nivel_composicao` | `varchar(3) NULL` | `nr_nivel_composicao` | `varchar(3)` | [RENAME] | Prefixo `nr_`; tipo mantido (ja correto) |
| `grupo_composicao` | `varchar(10) NULL` | `nr_grupo_composicao` | `varchar(10)` | [RENAME] | Prefixo `nr_`; tipo mantido |
| `subgrupo_composicao` | `varchar(10) NULL` | `nr_subgrupo_composicao` | `varchar(10)` | [RENAME] | Prefixo `nr_`; tipo mantido |
| `item_composicao` | `varchar(10) NULL` | `nr_item_composicao` | `varchar(10)` | [RENAME] | Prefixo `nr_`; tipo mantido |
| `qtd_requistada` | `numeric(18,3) NULL` | `qt_requisitada` | `numeric(15,3)` | [RENAME] [RETYPE] | Corrigir typo `requistada`; prefixo `qt_` canonico; `numeric(15,3)` padrao |
| `deposito` | `varchar(10) NULL` | `cod_deposito` | `smallint` | [RENAME] [RETYPE] | Join key canonico de deposito (secao 11); `varchar(10)` -> `smallint`; pipeline deve converter |
| `data_emissao` | `timestamp NULL` | — | — | [CONFLITO] | Duplicata de `data_de_emissao`; verificar se tem valor diferente antes de remover |
| `codigo_estagio` | `varchar(5) NULL` | `id_estagio` | `smallint` | [RENAME] [RETYPE] | Codigo operacional; `varchar(5)` -> `smallint` |
| — | — | `sku_tecido` | `varchar(30)` | [ADD] | Join key calculada no pipeline a partir das 4 partes de composicao para tecidos (secao 6.1) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria; ausente na tabela original |

**Flags presentes:** [RENAME] [RETYPE] [ADD] [CONFLITO]

#### Conflito identificado

`data_de_emissao` e `data_emissao` sao colunas distintas na DDL original. Antes da migracao, executar:

```sql
SELECT
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE data_de_emissao IS DISTINCT FROM data_emissao) AS divergentes
FROM estoque.freserva_tinturaria;
```

Se `divergentes = 0`, `data_emissao` e redundante e deve ser removida. Caso contrario, investigar a semantica de cada campo antes de proceder.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

#### Relacionamentos propostos

```
estoque.f_reserva_tinturaria
  |- sku_tecido        -> ppcp.dtecidos.sku_tecido            (por convencao, sem FK declarada)
  |- cod_deposito      -> d_deposito.cod_deposito             (por convencao, sem FK declarada)
  |- nr_ordem_producao -> ppcp.f_ordem_producao.nr_ordem_producao (por convencao)
  |- id_estagio        -> ppcp.d_estagio.id_estagio           (por convencao)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_reserva_tint_sku_tecido  ON estoque.f_reserva_tinturaria (sku_tecido);
CREATE INDEX idx_f_reserva_tint_nr_op       ON estoque.f_reserva_tinturaria (nr_ordem_producao);
CREATE INDEX idx_f_reserva_tint_cod_dep     ON estoque.f_reserva_tinturaria (cod_deposito);
CREATE INDEX idx_f_reserva_tint_dt_emissao  ON estoque.f_reserva_tinturaria (dt_emissao);
CREATE INDEX idx_f_reserva_tint_updated_at  ON estoque.f_reserva_tinturaria (updated_at);
```

#### Impacto no ETL

- Pipeline deve resolver o conflito `data_de_emissao` / `data_emissao` antes da migracao.
- `deposito` (varchar) deve ser convertido para `smallint` no pipeline (mapear para tabela de depositos).
- `codigo_estagio` (varchar 5) -> `smallint`: verificar se ha valores nao numericos.
- Calcular `sku_tecido` a partir das 4 partes de composicao no pipeline.

#### Migracao SQL

```sql
-- PRE-REQUISITO: resolver conflito de data_de_emissao vs data_emissao (ver secao CONFLITO)

ALTER TABLE estoque.freserva_tinturaria RENAME TO f_reserva_tinturaria;

ALTER TABLE estoque.f_reserva_tinturaria
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN ordem_agrupamento TO nr_ordem_agrupamento;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN ordem_de_producao TO nr_ordem_producao;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN data_de_emissao TO dt_emissao;
ALTER TABLE estoque.f_reserva_tinturaria
    ALTER COLUMN dt_emissao TYPE date USING dt_emissao::date;

-- Remover duplicata apos investigacao (se divergentes = 0)
ALTER TABLE estoque.f_reserva_tinturaria
    DROP COLUMN data_emissao;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN nivel_composicao TO nr_nivel_composicao;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN grupo_composicao TO nr_grupo_composicao;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN subgrupo_composicao TO nr_subgrupo_composicao;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN item_composicao TO nr_item_composicao;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN qtd_requistada TO qt_requisitada;
ALTER TABLE estoque.f_reserva_tinturaria
    ALTER COLUMN qt_requisitada TYPE numeric(15,3);

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN deposito TO cod_deposito;
ALTER TABLE estoque.f_reserva_tinturaria
    ALTER COLUMN cod_deposito TYPE smallint USING cod_deposito::smallint;

ALTER TABLE estoque.f_reserva_tinturaria
    RENAME COLUMN codigo_estagio TO id_estagio;
ALTER TABLE estoque.f_reserva_tinturaria
    ALTER COLUMN id_estagio TYPE smallint USING id_estagio::smallint;

ALTER TABLE estoque.f_reserva_tinturaria
    ADD COLUMN sku_tecido varchar(30);

UPDATE estoque.f_reserva_tinturaria
    SET sku_tecido = nr_nivel_composicao || '.' || nr_grupo_composicao || '.' ||
                     nr_subgrupo_composicao || '.' || nr_item_composicao;

ALTER TABLE estoque.f_reserva_tinturaria
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.freserva_tinturaria AS
    SELECT * FROM estoque.f_reserva_tinturaria;
COMMENT ON VIEW estoque.freserva_tinturaria IS
    'DEPRECATED 2026-05-05: usar f_reserva_tinturaria. Sera removido em 2026-08-03.';
```

---

### estoque.frolos_estoq

**Nome proposto:** `estoque.f_rolo_estoque`
**Tipo:** fato
**Descricao:** Fato principal de saldo de rolos de tecido em estoque (posicao atual). Cada linha representa um rolo fisico com suas caracteristicas tecnicas (peso, largura, gramatura, metragem) e localizacao no deposito. Tabela central do schema para analise de estoque de tecidos por rolo. Granularidade: um registro por rolo de tecido.
**Sistema de origem:** Systextil / ERP producao (modulo tecelagem)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `codigo_rolo` | `int4 NULL` | `cod_rolo` | `integer` | [RENAME] | Join key de rolo; `cod_` pois e business key entre tabelas; `int4` = `integer`, tipo mantido |
| `periodo_producao` | `int2 NULL` | `nr_periodo_producao` | `smallint` | [RENAME] | Prefixo `nr_` para numero de periodo; `smallint` = `int2`, tipo mantido |
| `turno_producao` | `int2 NULL` | `id_turno_producao` | `smallint` | [RENAME] | Codigo operacional de turno; prefixo `id_`; tipo mantido |
| `cod_nuance` | `varchar(3) NULL` | `cod_nuance` | `varchar(3)` | [OK] | Nome e tipo ja adequados; `cod_` correto para variacao de cor/nuance |
| `numero_lote` | `varchar(15) NULL` | `nr_lote` | `varchar(15)` | [RENAME] | Prefixo `nr_`; tipo mantido |
| `ordem_producao` | `int4 NULL` | `nr_ordem_producao` | `integer` | [RENAME] | Prefixo `nr_` para numero de documento; `int4` = `integer`, tipo mantido |
| `tecido` | `varchar(111) NULL` | `sku_tecido` | `varchar(30)` | [RENAME] [RETYPE] | Substituir campo descritivo pelo join key canonico `sku_tecido` (secao 6.1 + secao 11); `varchar(30)` padrao; pipeline deve extrair sku do tecido |
| `codigo_deposito` | `int2 NULL` | `cod_deposito` | `smallint` | [RENAME] | Join key canonico de deposito (secao 11); `int2` = `smallint`, tipo mantido |
| `qualidade_rolo` | `int2 NULL` | `id_qualidade_rolo` | `smallint` | [RENAME] | Codigo de qualidade especifico do rolo; prefixo `id_`; tipo mantido |
| `endereco_rolo` | `varchar(30) NULL` | `end_rolo` | `varchar(30)` | [RENAME] | Localizacao fisica no deposito; prefixo `end_` para endereco; tipo mantido |
| `qualidade` | `int2 NULL` | `id_qualidade` | `smallint` | [RENAME] | Codigo de qualidade geral; prefixo `id_`; distinguir de `id_qualidade_rolo` |
| `data_entrada` | `timestamp NULL` | `dth_entrada` | `timestamp` | [RENAME] | Momento preciso de entrada do rolo no estoque; `timestamp` correto; prefixo `dth_` |
| `data_prod_tecel` | `timestamp NULL` | `dth_producao_tecel` | `timestamp` | [RENAME] | Data/hora de producao na tecelagem; `timestamp` correto; nome expandido |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao (secao 4) |
| `ordem_producao_dm` | `int4 NULL` | `nr_ordem_producao_dm` | `integer` | [RENAME] | Numero de OP do departamento de malharia; prefixo `nr_`; tipo mantido |
| `area_producao` | `int2 NULL` | `id_area_producao` | `smallint` | [RENAME] | Codigo de area produtiva; prefixo `id_`; tipo mantido |
| `observacao` | `varchar(500) NULL` | `obs_rolo` | `text` | [RENAME] [RETYPE] | Texto livre de observacao; prefixo `obs_`; `text` mais adequado |
| `rolo_estoque` | `numeric(18,3) NULL` | `qt_rolo_estoque` | `numeric(15,3)` | [RENAME] [RETYPE] | Quantidade do rolo em estoque (em metros ou quilos conforme `ds_unidade_medida`); prefixo `qt_` |
| `qtde_quilos_acab` | `numeric(18,3) NULL` | `ps_quilos_acabado` | `numeric(15,3)` | [RENAME] [RETYPE] | Peso em quilos de tecido acabado; prefixo `ps_` para peso fisico (secao 3.2) |
| `peso_bruto` | `numeric(18,3) NULL` | `ps_bruto` | `numeric(15,3)` | [RENAME] [RETYPE] | Peso bruto do rolo; prefixo `ps_`; `numeric(15,3)` padrao de peso |
| `peso_liquido_real` | `numeric(18,3) NULL` | `ps_liquido_real` | `numeric(15,3)` | [RENAME] [RETYPE] | Peso liquido real do rolo; prefixo `ps_` |
| `mt_lineares_prod` | `numeric(18,3) NULL` | `qt_metros_lineares` | `numeric(15,3)` | [RENAME] [RETYPE] | Metros lineares produzidos; prefixo `qt_` para quantidade mensuravel; nome expandido |
| `largura` | `numeric(18,3) NULL` | `qt_largura` | `numeric(15,3)` | [RENAME] [RETYPE] | Largura do tecido em metros; prefixo `qt_` para medida fisica |
| `gramatura` | `numeric(18,3) NULL` | `qt_gramatura` | `numeric(15,3)` | [RENAME] [RETYPE] | Gramatura do tecido em g/m²; prefixo `qt_` para medida fisica |
| `unidade_medida` | `varchar(5) NULL` | `ds_unidade_medida` | `varchar(5)` | [RENAME] | Unidade de medida do saldo; prefixo `ds_`; tipo mantido |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD] [OK]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade sobre o rolo:

```sql
CONSTRAINT uq_f_rolo_estoque_cod_rolo UNIQUE (cod_rolo)
```

#### Relacionamentos propostos

```
estoque.f_rolo_estoque
  |- sku_tecido        -> ppcp.dtecidos.sku_tecido            (por convencao, sem FK declarada)
  |- cod_deposito      -> d_deposito.cod_deposito             (por convencao, sem FK declarada)
  |- nr_ordem_producao -> ppcp.f_ordem_producao.nr_ordem_producao (por convencao)
  |- cod_rolo          -> estoque.f_tecido_estoque.cod_rolo   (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_f_rolo_estoque_cod ON estoque.f_rolo_estoque (cod_rolo);
CREATE INDEX idx_f_rolo_estoque_sku_tecido ON estoque.f_rolo_estoque (sku_tecido);
CREATE INDEX idx_f_rolo_estoque_cod_dep    ON estoque.f_rolo_estoque (cod_deposito);
CREATE INDEX idx_f_rolo_estoque_nr_op      ON estoque.f_rolo_estoque (nr_ordem_producao);
CREATE INDEX idx_f_rolo_estoque_updated_at ON estoque.f_rolo_estoque (updated_at);
```

#### Impacto no ETL

- Campo `tecido` (varchar 111) deve ser mapeado para `sku_tecido` (varchar 30) no pipeline; investigar se o campo contem o SKU composto ou descricao livre.
- Se `tecido` contem descricao livre, o pipeline deve fazer lookup na dimensao `ppcp.dtecidos` para obter `sku_tecido`.
- Colunas de peso (`ps_*`) devem ser enviadas como `Decimal` no pipeline.
- `rolo_estoque` renomeado para `qt_rolo_estoque`; pode ser metros lineares ou quilos dependendo da `ds_unidade_medida`.

#### Migracao SQL

```sql
ALTER TABLE estoque.frolos_estoq RENAME TO f_rolo_estoque;

ALTER TABLE estoque.f_rolo_estoque
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN codigo_rolo TO cod_rolo;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN periodo_producao TO nr_periodo_producao;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN turno_producao TO id_turno_producao;

-- cod_nuance: sem alteracao

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN numero_lote TO nr_lote;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN ordem_producao TO nr_ordem_producao;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN tecido TO sku_tecido;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN sku_tecido TYPE varchar(30);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN codigo_deposito TO cod_deposito;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN qualidade_rolo TO id_qualidade_rolo;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN endereco_rolo TO end_rolo;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN qualidade TO id_qualidade;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN data_entrada TO dth_entrada;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN data_prod_tecel TO dth_producao_tecel;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN ordem_producao_dm TO nr_ordem_producao_dm;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN area_producao TO id_area_producao;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN observacao TO obs_rolo;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN obs_rolo TYPE text;

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN rolo_estoque TO qt_rolo_estoque;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN qt_rolo_estoque TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN qtde_quilos_acab TO ps_quilos_acabado;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN ps_quilos_acabado TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN ps_bruto TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN peso_liquido_real TO ps_liquido_real;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN ps_liquido_real TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN mt_lineares_prod TO qt_metros_lineares;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN qt_metros_lineares TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN largura TO qt_largura;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN qt_largura TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN gramatura TO qt_gramatura;
ALTER TABLE estoque.f_rolo_estoque
    ALTER COLUMN qt_gramatura TYPE numeric(15,3);

ALTER TABLE estoque.f_rolo_estoque
    RENAME COLUMN unidade_medida TO ds_unidade_medida;

ALTER TABLE estoque.f_rolo_estoque
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.frolos_estoq AS
    SELECT * FROM estoque.f_rolo_estoque;
COMMENT ON VIEW estoque.frolos_estoq IS
    'DEPRECATED 2026-05-05: usar f_rolo_estoque. Sera removido em 2026-08-03.';
```

---

### estoque.frolos_estoq_cong

**Nome proposto:** `estoque.f_rolo_estoque_cong`
**Tipo:** fato
**Descricao:** Foto (snapshot) congelada da tabela `f_rolo_estoque` em uma data de referencia. Usada para comparacao historica de posicao de estoque de rolos. Mesma estrutura de `f_rolo_estoque`, com adicao da data de congelamento. Granularidade: um registro por rolo x data de congelamento.
**Sistema de origem:** Systextil / ERP producao (modulo tecelagem) — snapshot gerado pelo pipeline Airflow

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `codigo_rolo` | `int4 NULL` | `cod_rolo` | `integer` | [RENAME] | Idem `f_rolo_estoque` |
| `periodo_producao` | `int2 NULL` | `nr_periodo_producao` | `smallint` | [RENAME] | Idem `f_rolo_estoque` |
| `turno_producao` | `int2 NULL` | `id_turno_producao` | `smallint` | [RENAME] | Idem `f_rolo_estoque` |
| `cod_nuance` | `varchar(3) NULL` | `cod_nuance` | `varchar(3)` | [OK] | Idem `f_rolo_estoque` |
| `numero_lote` | `varchar(15) NULL` | `nr_lote` | `varchar(15)` | [RENAME] | Idem `f_rolo_estoque` |
| `ordem_producao` | `int4 NULL` | `nr_ordem_producao` | `integer` | [RENAME] | Idem `f_rolo_estoque` |
| `tecido` | `varchar(111) NULL` | `sku_tecido` | `varchar(30)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `codigo_deposito` | `int2 NULL` | `cod_deposito` | `smallint` | [RENAME] | Idem `f_rolo_estoque` |
| `qualidade_rolo` | `int2 NULL` | `id_qualidade_rolo` | `smallint` | [RENAME] | Idem `f_rolo_estoque` |
| `endereco_rolo` | `varchar(30) NULL` | `end_rolo` | `varchar(30)` | [RENAME] | Idem `f_rolo_estoque` |
| `qualidade` | `int2 NULL` | `id_qualidade` | `smallint` | [RENAME] | Idem `f_rolo_estoque` |
| `data_entrada` | `timestamp NULL` | `dth_entrada` | `timestamp` | [RENAME] | Idem `f_rolo_estoque` |
| `data_prod_tecel` | `timestamp NULL` | `dth_producao_tecel` | `timestamp` | [RENAME] | Idem `f_rolo_estoque` |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao |
| `ordem_producao_dm` | `int4 NULL` | `nr_ordem_producao_dm` | `integer` | [RENAME] | Idem `f_rolo_estoque` |
| `area_producao` | `int2 NULL` | `id_area_producao` | `smallint` | [RENAME] | Idem `f_rolo_estoque` |
| `observacao` | `varchar(500) NULL` | `obs_rolo` | `text` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `rolo_estoque` | `numeric(18,3) NULL` | `qt_rolo_estoque` | `numeric(15,3)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `qtde_quilos_acab` | `numeric(18,3) NULL` | `ps_quilos_acabado` | `numeric(15,3)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `peso_bruto` | `numeric(18,3) NULL` | `ps_bruto` | `numeric(15,3)` | [RETYPE] | Idem `f_rolo_estoque` |
| `peso_liquido_real` | `numeric(18,3) NULL` | `ps_liquido_real` | `numeric(15,3)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `mt_lineares_prod` | `numeric(18,3) NULL` | `qt_metros_lineares` | `numeric(15,3)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `largura` | `numeric(18,3) NULL` | `qt_largura` | `numeric(15,3)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `gramatura` | `numeric(18,3) NULL` | `qt_gramatura` | `numeric(15,3)` | [RENAME] [RETYPE] | Idem `f_rolo_estoque` |
| `unidade_medida` | `varchar(5) NULL` | `ds_unidade_medida` | `varchar(5)` | [RENAME] | Idem `f_rolo_estoque` |
| — | — | `dt_congelamento` | `date NOT NULL` | [ADD] | Data de referencia do snapshot; distingue versoes historicas do rolo |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD] [OK]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade para snapshots:

```sql
CONSTRAINT uq_f_rolo_estoque_cong UNIQUE (cod_rolo, dt_congelamento)
```

#### Relacionamentos propostos

```
estoque.f_rolo_estoque_cong
  |- cod_rolo          -> estoque.f_rolo_estoque.cod_rolo     (snapshot da linha de f_rolo_estoque)
  |- sku_tecido        -> ppcp.dtecidos.sku_tecido            (por convencao, sem FK declarada)
  |- cod_deposito      -> d_deposito.cod_deposito             (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_rolo_cong_cod_rolo     ON estoque.f_rolo_estoque_cong (cod_rolo);
CREATE INDEX idx_f_rolo_cong_sku_tecido   ON estoque.f_rolo_estoque_cong (sku_tecido);
CREATE INDEX idx_f_rolo_cong_dt_cong      ON estoque.f_rolo_estoque_cong (dt_congelamento);
CREATE INDEX idx_f_rolo_cong_cod_dep      ON estoque.f_rolo_estoque_cong (cod_deposito);
CREATE INDEX idx_f_rolo_cong_updated_at   ON estoque.f_rolo_estoque_cong (updated_at);
```

#### Impacto no ETL

- DAG de congelamento deve adicionar `dt_congelamento = current_date` ao inserir snapshot.
- Mesmas regras de transformacao de `f_rolo_estoque` aplicam-se aqui.
- Pipeline de congelamento deve garantir que nao insere duplicata para o mesmo `(cod_rolo, dt_congelamento)`.

#### Migracao SQL

```sql
-- Aplicar os mesmos renomeamentos de f_rolo_estoque (omitidos por brevidade — usar script identico)
ALTER TABLE estoque.frolos_estoq_cong RENAME TO f_rolo_estoque_cong;

-- Adicionar coluna de congelamento
ALTER TABLE estoque.f_rolo_estoque_cong
    ADD COLUMN dt_congelamento date;

-- Preencher retroativamente se disponivel; caso contrario deixar NULL ate proxima carga
-- UPDATE estoque.f_rolo_estoque_cong SET dt_congelamento = current_date WHERE dt_congelamento IS NULL;

ALTER TABLE estoque.f_rolo_estoque_cong
    ADD COLUMN id bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Demais colunas: aplicar renomeamentos identicos a f_rolo_estoque (ver script acima)

CREATE OR REPLACE VIEW estoque.frolos_estoq_cong AS
    SELECT * FROM estoque.f_rolo_estoque_cong;
COMMENT ON VIEW estoque.frolos_estoq_cong IS
    'DEPRECATED 2026-05-05: usar f_rolo_estoque_cong. Sera removido em 2026-08-03.';
```

---

### estoque.fsaldoestoqueatual

**Nome proposto:** `estoque.f_saldo_estoque_atual`
**Tipo:** fato
**Descricao:** Fato de saldo de estoque atual por empresa, deposito e produto. Registra quantidades empenhadas, disponiveis, sugeridas e valor total em estoque. Tabela principal de consulta de posicao atual de estoque de produtos acabados. Granularidade: um registro por empresa x deposito x produto (sku_produto).
**Sistema de origem:** Systextil / ERP (modulo estoque)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `cd_empresa` | `int2 NULL` | `id_empresa` | `smallint` | [RENAME] | Codigo operacional de empresa; prefixo `id_`; `int2` = `smallint`, tipo mantido |
| `cd_deposito` | `int2 NULL` | `cod_deposito` | `smallint` | [RENAME] | Join key canonico de deposito (secao 11); tipo mantido |
| `cd_nivel_estrutura` | `varchar(3) NULL` | `nr_nivel_estrutura` | `varchar(3)` | [RENAME] | Prefixo `nr_`; tipo mantido |
| `fk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | Join key canonico de produto (secao 6.1); nome `fk_` proibido como prefixo de coluna de join; `varchar(30)` padrao |
| `dt_ult_entrada` | `timestamp NULL` | `dth_ult_entrada` | `timestamp` | [RENAME] | Momento preciso da ultima entrada; prefixo `dth_`; `timestamp` correto |
| `dt_ult_saida` | `timestamp NULL` | `dth_ult_saida` | `timestamp` | [RENAME] | Momento preciso da ultima saida; prefixo `dth_` |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao (secao 4) |
| `codigo_barras` | `varchar(16) NULL` | `cod_barras` | `varchar(16)` | [RENAME] | Remover prefixo `codigo_` (proibido); tipo mantido |
| `qtd_empenhada` | `numeric(18,3) NULL` | `qt_empenhada` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_` canonico; `numeric(15,3)` padrao de quantidade |
| `qtd_est_atual` | `numeric(18,3) NULL` | `qt_estoque_atual` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_`; nome mais explicito sem abreviacao `est_` |
| `qtd_disponivel` | `numeric(18,3) NULL` | `qt_disponivel` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_`; `numeric(15,3)` padrao |
| `qtd_sugerida` | `numeric(18,3) NULL` | `qt_sugerida` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_`; `numeric(15,3)` padrao |
| `valor_em_estoque` | `float8 NULL` | `vl_estoque` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor monetario; prefixo `vl_`; `float8` substituido por `numeric(15,2)` — `float8` gera imprecisao em valores financeiros |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade:

```sql
CONSTRAINT uq_f_saldo_estoque_atual UNIQUE (id_empresa, cod_deposito, sku_produto)
```

#### Relacionamentos propostos

```
estoque.f_saldo_estoque_atual
  |- id_empresa    -> (operacional — sem dimensao propria)
  |- cod_deposito  -> d_deposito.cod_deposito              (por convencao, sem FK declarada)
  |- sku_produto   -> live.d_produto.sku_produto           (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_saldo_atual_sku_produto  ON estoque.f_saldo_estoque_atual (sku_produto);
CREATE INDEX idx_f_saldo_atual_cod_deposito ON estoque.f_saldo_estoque_atual (cod_deposito);
CREATE INDEX idx_f_saldo_atual_id_empresa   ON estoque.f_saldo_estoque_atual (id_empresa);
CREATE INDEX idx_f_saldo_atual_cod_barras   ON estoque.f_saldo_estoque_atual (cod_barras);
CREATE INDEX idx_f_saldo_atual_updated_at   ON estoque.f_saldo_estoque_atual (updated_at);
```

#### Impacto no ETL

- `fk_produto` (varchar 18) -> `sku_produto` (varchar 30): verificar se o valor ja esta no formato SKU composto ou e apenas o codigo de produto legado.
- `valor_em_estoque` (float8) -> `vl_estoque` (numeric 15,2): converter no pipeline com `round(valor, 2)` antes do insert para evitar artefatos de ponto flutuante.
- Watermark: `updated_at`.

#### Migracao SQL

```sql
ALTER TABLE estoque.fsaldoestoqueatual RENAME TO f_saldo_estoque_atual;

ALTER TABLE estoque.f_saldo_estoque_atual
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN cd_empresa TO id_empresa;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN cd_deposito TO cod_deposito;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN cd_nivel_estrutura TO nr_nivel_estrutura;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN sku_produto TYPE varchar(30);

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN dt_ult_entrada TO dth_ult_entrada;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN dt_ult_saida TO dth_ult_saida;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN codigo_barras TO cod_barras;

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN qtd_empenhada TO qt_empenhada;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN qt_empenhada TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN qtd_est_atual TO qt_estoque_atual;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN qt_estoque_atual TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN qtd_disponivel TO qt_disponivel;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN qt_disponivel TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN qtd_sugerida TO qt_sugerida;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN qt_sugerida TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual
    RENAME COLUMN valor_em_estoque TO vl_estoque;
ALTER TABLE estoque.f_saldo_estoque_atual
    ALTER COLUMN vl_estoque TYPE numeric(15,2) USING ROUND(vl_estoque::numeric, 2);

ALTER TABLE estoque.f_saldo_estoque_atual
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.fsaldoestoqueatual AS
    SELECT * FROM estoque.f_saldo_estoque_atual;
COMMENT ON VIEW estoque.fsaldoestoqueatual IS
    'DEPRECATED 2026-05-05: usar f_saldo_estoque_atual. Sera removido em 2026-08-03.';
```

---

### estoque.fsaldoestoqueatual_cong

**Nome proposto:** `estoque.f_saldo_estoque_atual_cong`
**Tipo:** fato
**Descricao:** Foto (snapshot) congelada do saldo de estoque atual em uma data de referencia. Mesma semantica de `f_saldo_estoque_atual`, com adicao de `dt_congelamento` para permitir analise historica da evolucao do estoque. Granularidade: um registro por empresa x deposito x produto x data de congelamento.
**Sistema de origem:** Systextil / ERP (modulo estoque) — snapshot gerado pelo pipeline Airflow

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `cd_empresa` | `numeric(3) NULL` | `id_empresa` | `smallint` | [RENAME] [RETYPE] | Idem `f_saldo_estoque_atual`; `numeric(3)` -> `smallint` |
| `cd_deposito` | `numeric(3) NULL` | `cod_deposito` | `smallint` | [RENAME] [RETYPE] | Join key canonico; `numeric(3)` -> `smallint` |
| `cd_nivel_estrutura` | `text NULL` | `nr_nivel_estrutura` | `varchar(3)` | [RENAME] [RETYPE] | `text` -> `varchar(3)` |
| `fk_produto` | `text NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | Join key canonico; `text` -> `varchar(30)` |
| `dt_ult_entrada` | `timestamp NULL` | `dth_ult_entrada` | `timestamp` | [RENAME] | Prefixo `dth_` |
| `dt_ult_saida` | `timestamp NULL` | `dth_ult_saida` | `timestamp` | [RENAME] | Prefixo `dth_` |
| `qtd_empenhada` | `numeric(13,3) NULL` | `qt_empenhada` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_`; normalizar para `numeric(15,3)` padrao |
| `qtd_est_atual` | `numeric(13,3) NULL` | `qt_estoque_atual` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_`; normalizar |
| `qtd_disponivel` | `numeric(38,10) NULL` | `qt_disponivel` | `numeric(15,3)` | [RENAME] [RETYPE] | Tipo legado Oracle; `numeric(15,3)` padrao do DW |
| `qtd_sugerida` | `numeric(13,3) NULL` | `qt_sugerida` | `numeric(15,3)` | [RENAME] [RETYPE] | Normalizar |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao |
| `data_congelamento` | `timestamp NULL` | `dt_congelamento` | `date NOT NULL` | [RENAME] [RETYPE] | Data de referencia do snapshot; `timestamp` -> `date`; deve ser NOT NULL |
| `valor_em_estoque` | `numeric(38,10) NULL` | `vl_estoque` | `numeric(15,2)` | [RENAME] [RETYPE] | Tipo legado Oracle; `numeric(15,2)` padrao monetario; prefixo `vl_` |
| `codigo_barras` | `text NULL` | `cod_barras` | `varchar(16)` | [RENAME] [RETYPE] | `text` -> `varchar(16)` |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade para snapshots:

```sql
CONSTRAINT uq_f_saldo_estoque_cong UNIQUE (id_empresa, cod_deposito, sku_produto, dt_congelamento)
```

#### Relacionamentos propostos

```
estoque.f_saldo_estoque_atual_cong
  |- cod_deposito  -> d_deposito.cod_deposito              (por convencao, sem FK declarada)
  |- sku_produto   -> live.d_produto.sku_produto           (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_saldo_cong_sku_produto  ON estoque.f_saldo_estoque_atual_cong (sku_produto);
CREATE INDEX idx_f_saldo_cong_cod_deposito ON estoque.f_saldo_estoque_atual_cong (cod_deposito);
CREATE INDEX idx_f_saldo_cong_dt_cong      ON estoque.f_saldo_estoque_atual_cong (dt_congelamento);
CREATE INDEX idx_f_saldo_cong_updated_at   ON estoque.f_saldo_estoque_atual_cong (updated_at);
```

#### Impacto no ETL

- `numeric(38,10)` nos campos `qtd_disponivel` e `valor_em_estoque` sao heranca de Oracle; converter para `numeric(15,3)` e `numeric(15,2)` respectivamente no pipeline.
- `data_congelamento` (timestamp) deve ser truncado para `date` no pipeline.
- `cd_empresa` e `cd_deposito` tipo `numeric(3)` -> `smallint`: garantir que nao ha valores fora do range.

#### Migracao SQL

```sql
ALTER TABLE estoque.fsaldoestoqueatual_cong RENAME TO f_saldo_estoque_atual_cong;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN cd_empresa TO id_empresa;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN id_empresa TYPE smallint USING id_empresa::smallint;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN cd_deposito TO cod_deposito;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN cod_deposito TYPE smallint USING cod_deposito::smallint;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN cd_nivel_estrutura TO nr_nivel_estrutura;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN nr_nivel_estrutura TYPE varchar(3);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN sku_produto TYPE varchar(30);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN dt_ult_entrada TO dth_ult_entrada;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN dt_ult_saida TO dth_ult_saida;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN qtd_empenhada TO qt_empenhada;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN qt_empenhada TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN qtd_est_atual TO qt_estoque_atual;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN qt_estoque_atual TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN qtd_disponivel TO qt_disponivel;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN qt_disponivel TYPE numeric(15,3) USING qt_disponivel::numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN qtd_sugerida TO qt_sugerida;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN qt_sugerida TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN data_congelamento TO dt_congelamento;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN dt_congelamento TYPE date USING dt_congelamento::date;

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN valor_em_estoque TO vl_estoque;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN vl_estoque TYPE numeric(15,2) USING ROUND(vl_estoque::numeric, 2);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    RENAME COLUMN codigo_barras TO cod_barras;
ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ALTER COLUMN cod_barras TYPE varchar(16);

ALTER TABLE estoque.f_saldo_estoque_atual_cong
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.fsaldoestoqueatual_cong AS
    SELECT * FROM estoque.f_saldo_estoque_atual_cong;
COMMENT ON VIEW estoque.fsaldoestoqueatual_cong IS
    'DEPRECATED 2026-05-05: usar f_saldo_estoque_atual_cong. Sera removido em 2026-08-03.';
```

---

### estoque.fsaldoestoqueinteg

**Nome proposto:** `estoque.f_saldo_estoque_integ`
**Tipo:** fato
**Descricao:** Fato de saldo de estoque de lojas da rede (integracao de franquias e filiais). Integra dados de posicao de estoque provenientes de sistemas das lojas parceiras, identificados por CNPJ e codigo de barras do produto. Granularidade: um registro por loja x produto (cod_barras) x periodo.
**Sistema de origem:** Sistemas de lojas da rede / integracao de franquias

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `loja` | `varchar(5) NULL` | `ds_loja` | `varchar(10)` | [RENAME] [RETYPE] | Codigo da loja; `ds_`; `varchar(10)` |
| `cnpj` | `varchar(20) NULL` | `cnpj_loja` | `varchar(16)` | [RENAME] [RETYPE] | Nome segue dimensao `d_loja`; `varchar(16)` formato padrao CNPJ |
| `cod_barras` | `varchar(20) NULL` | `cod_barras` | `varchar(20)` | [OK] | Nome adequado; tipo mantido |
| `codigo_barras_ean` | `varchar(30) NULL` | `cod_barras_ean` | `varchar(30)` | [RENAME] | Remover prefixo `codigo_`; tipo mantido |
| `qtd_estoque` | `numeric(18,3) NULL` | `qt_estoque` | `numeric(15,3)` | [RENAME] [RETYPE] | Prefixo `qt_`; `numeric(15,3)` padrao |
| `data_estoque` | `timestamp NULL` | `dt_referencia` | `date` | [RENAME] [RETYPE] | Data de referencia do saldo; `date` adequado |
| `rede` | `varchar(20) NULL` | `ds_rede` | `varchar(20)` | [RENAME] | Prefixo `ds_` para descricoes; tipo mantido |
| `fantasia` | `varchar(100) NULL` | `nm_fantasia_loja` | `varchar(100)` | [RENAME] | Prefixo `nm_`; tipo mantido |
| `sku` | `varchar(111) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | Join key canonico de produto (secao 6.1); `varchar(111)` superdimensionado; `varchar(30)` padrao |
| `tamanho` | `varchar(3) NULL` | `ds_tamanho` | `varchar(3)` | [RENAME] | Prefixo `ds_`; tipo mantido |
| `refcor` | `varchar(11) NULL` | `cod_refcor` | `varchar(11)` | [RENAME] | Referencia de cor; `cod_` para identificadores de negocio; tipo mantido |
| `situacao` | `varchar(1) NULL` | `fl_ativo` | `boolean` | [RENAME] [RETYPE] | Flag de situacao; `boolean` padrao (secao 8) |
| `mes_ano` | `varchar(75) NULL` | `ds_mes_ano` | `varchar(7)` | [RENAME] [RETYPE] | `varchar(75)` absurdamente grande; `varchar(7)` para `YYYY-MM` |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao (secao 4) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD] [OK]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

#### Relacionamentos propostos

```
estoque.f_saldo_estoque_integ
  |- cnpj_loja    -> live.d_loja.cnpj_loja               (por convencao, sem FK declarada)
  |- sku_produto  -> live.d_produto.sku_produto           (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_saldo_integ_cnpj_loja   ON estoque.f_saldo_estoque_integ (cnpj_loja);
CREATE INDEX idx_f_saldo_integ_sku_produto  ON estoque.f_saldo_estoque_integ (sku_produto);
CREATE INDEX idx_f_saldo_integ_cod_barras   ON estoque.f_saldo_estoque_integ (cod_barras);
CREATE INDEX idx_f_saldo_integ_dt_ref       ON estoque.f_saldo_estoque_integ (dt_referencia);
CREATE INDEX idx_f_saldo_integ_updated_at   ON estoque.f_saldo_estoque_integ (updated_at);
```

#### Impacto no ETL

- `sku` (varchar 111) -> `sku_produto` (varchar 30): verificar se o campo contem SKU composto ou nome descritivo longo; se descritivo, o pipeline deve montar o SKU a partir das 4 partes.
- `situacao` (varchar '1'/'0' ou 'A'/'I') -> `boolean`: pipeline deve mapear o valor de origem.
- `mes_ano` (varchar 75) -> `ds_mes_ano` (varchar 7): truncar ou reformatar para `YYYY-MM` no pipeline.
- `cnpj` (varchar 20) -> `cnpj_loja` (varchar 16): formatar via `fn_formatar_cnpj_cpf`.

#### Migracao SQL

```sql
ALTER TABLE estoque.fsaldoestoqueinteg RENAME TO f_saldo_estoque_integ;

ALTER TABLE estoque.f_saldo_estoque_integ
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN loja TO ds_loja;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN ds_loja TYPE varchar(10);

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN cnpj TO cnpj_loja;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN cnpj_loja TYPE varchar(16);

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN codigo_barras_ean TO cod_barras_ean;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN qtd_estoque TO qt_estoque;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN qt_estoque TYPE numeric(15,3);

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN data_estoque TO dt_referencia;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN dt_referencia TYPE date USING dt_referencia::date;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN rede TO ds_rede;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN fantasia TO nm_fantasia_loja;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN sku TO sku_produto;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN sku_produto TYPE varchar(30);

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN tamanho TO ds_tamanho;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN refcor TO cod_refcor;

ALTER TABLE estoque.f_saldo_estoque_integ
    ADD COLUMN fl_ativo boolean;
UPDATE estoque.f_saldo_estoque_integ
    SET fl_ativo = CASE WHEN situacao IN ('1', 'A', 'S') THEN TRUE ELSE FALSE END;
ALTER TABLE estoque.f_saldo_estoque_integ
    DROP COLUMN situacao;

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN mes_ano TO ds_mes_ano;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN ds_mes_ano TYPE varchar(7);

ALTER TABLE estoque.f_saldo_estoque_integ
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_saldo_estoque_integ
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_saldo_estoque_integ
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.fsaldoestoqueinteg AS
    SELECT * FROM estoque.f_saldo_estoque_integ;
COMMENT ON VIEW estoque.fsaldoestoqueinteg IS
    'DEPRECATED 2026-05-05: usar f_saldo_estoque_integ. Sera removido em 2026-08-03.';
```

---

### estoque.ftecidos_estoque

**Nome proposto:** `estoque.f_tecido_estoque`
**Tipo:** fato
**Descricao:** Fato de estoque de tecidos por rolo e deposito. Consolida atributos do tecido (grupo de cor, colecao, linha, artigo, gramatura) com informacoes de estoque fisico (quantidade de rolos, quilos acabados, metros lineares). Funciona como ponte entre a dimensao de tecidos e os rolos em estoque. Granularidade: um registro por tecido x rolo x deposito.
**Sistema de origem:** Systextil / ERP producao (modulo tecelagem)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `cd_tecido` | `varchar(30) NULL` | `sku_tecido` | `varchar(30)` | [RENAME] | Join key canonico de tecido (secao 11); `cd_tecido` viola a convencao de `sku_tecido`; tipo mantido |
| `nome_grupo` | `varchar(30) NULL` | `ds_grupo_cor` | `varchar(30)` | [RENAME] | Grupo de cor do tecido; `ds_` para descricao; tipo mantido |
| `nome_cor` | `varchar(20) NULL` | `ds_cor` | `varchar(20)` | [RENAME] | Nome da cor; prefixo `ds_`; tipo mantido |
| `colecao` | `varchar(20) NULL` | `ds_colecao` | `varchar(20)` | [RENAME] | Colecao do tecido; prefixo `ds_`; tipo mantido |
| `linha` | `varchar(40) NULL` | `ds_linha` | `varchar(40)` | [RENAME] | Linha do produto; prefixo `ds_`; tipo mantido |
| `artigo` | `varchar(25) NULL` | `ds_artigo` | `varchar(25)` | [RENAME] | Artigo/referencia; prefixo `ds_`; tipo mantido |
| `gramatura` | `numeric(18,3) NULL` | `qt_gramatura` | `numeric(15,3)` | [RENAME] [RETYPE] | Gramatura em g/m²; prefixo `qt_`; `numeric(15,3)` padrao |
| `certificacao_qualidade` | `int2 NULL` | `id_certificacao_qualidade` | `smallint` | [RENAME] | Codigo de certificacao de qualidade; prefixo `id_`; tipo mantido |
| `codigo_deposito` | `int2 NULL` | `cod_deposito` | `smallint` | [RENAME] | Join key canonico de deposito (secao 11); tipo mantido |
| `rolo_estoque` | `int2 NULL` | `qt_rolos_estoque` | `smallint` | [RENAME] | Quantidade de rolos em estoque; prefixo `qt_`; `int2` = `smallint` — considerar `integer` se houver mais de 32k rolos |
| `codigo_rolo` | `int4 NULL` | `cod_rolo` | `integer` | [RENAME] | Join key do rolo; `cod_`; tipo mantido |
| `unidade_medida` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(5)` | [RENAME] [RETYPE] | Prefixo `ds_`; `varchar(5)` para suportar siglas como `KG`, `MT`, `PC` |
| `qualidade_rolo` | `int2 NULL` | `id_qualidade_rolo` | `smallint` | [RENAME] | Codigo de qualidade do rolo; prefixo `id_`; tipo mantido |
| `qtde_quilos_acab` | `numeric(18,3) NULL` | `ps_quilos_acabado` | `numeric(15,3)` | [RENAME] [RETYPE] | Peso em quilos de tecido acabado; prefixo `ps_`; `numeric(15,3)` padrao de peso |
| `mt_lineares_prod` | `numeric(18,3) NULL` | `qt_metros_lineares` | `numeric(15,3)` | [RENAME] [RETYPE] | Metros lineares produzidos; prefixo `qt_`; `numeric(15,3)` |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria padrao (secao 4) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Constraint de unicidade:

```sql
CONSTRAINT uq_f_tecido_estoque UNIQUE (sku_tecido, cod_rolo, cod_deposito)
```

#### Relacionamentos propostos

```
estoque.f_tecido_estoque
  |- sku_tecido    -> ppcp.dtecidos.sku_tecido            (por convencao, sem FK declarada)
  |- cod_deposito  -> d_deposito.cod_deposito             (por convencao, sem FK declarada)
  |- cod_rolo      -> estoque.f_rolo_estoque.cod_rolo     (por convencao, sem FK declarada)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_tecido_estoque_sku_tecido  ON estoque.f_tecido_estoque (sku_tecido);
CREATE INDEX idx_f_tecido_estoque_cod_deposito ON estoque.f_tecido_estoque (cod_deposito);
CREATE INDEX idx_f_tecido_estoque_cod_rolo     ON estoque.f_tecido_estoque (cod_rolo);
CREATE INDEX idx_f_tecido_estoque_updated_at   ON estoque.f_tecido_estoque (updated_at);
```

#### Impacto no ETL

- `cd_tecido` deve ser renomeado para `sku_tecido` no pipeline; verificar se o valor ja e o SKU composto ou apenas o codigo do tecido no Systextil.
- `rolo_estoque` (int2) pode sofrer overflow se houver mais de 32.767 rolos; avaliar upgrade para `integer` no pipeline.
- `qt_gramatura` e `ps_quilos_acabado` devem ser enviados como `Decimal` no pipeline.
- Watermark: `updated_at`.

#### Migracao SQL

```sql
ALTER TABLE estoque.ftecidos_estoque RENAME TO f_tecido_estoque;

ALTER TABLE estoque.f_tecido_estoque
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN cd_tecido TO sku_tecido;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN nome_grupo TO ds_grupo_cor;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN nome_cor TO ds_cor;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN colecao TO ds_colecao;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN linha TO ds_linha;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN artigo TO ds_artigo;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN gramatura TO qt_gramatura;
ALTER TABLE estoque.f_tecido_estoque
    ALTER COLUMN qt_gramatura TYPE numeric(15,3);

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN certificacao_qualidade TO id_certificacao_qualidade;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN codigo_deposito TO cod_deposito;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN rolo_estoque TO qt_rolos_estoque;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN codigo_rolo TO cod_rolo;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN unidade_medida TO ds_unidade_medida;
ALTER TABLE estoque.f_tecido_estoque
    ALTER COLUMN ds_unidade_medida TYPE varchar(5);

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN qualidade_rolo TO id_qualidade_rolo;

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN qtde_quilos_acab TO ps_quilos_acabado;
ALTER TABLE estoque.f_tecido_estoque
    ALTER COLUMN ps_quilos_acabado TYPE numeric(15,3);

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN mt_lineares_prod TO qt_metros_lineares;
ALTER TABLE estoque.f_tecido_estoque
    ALTER COLUMN qt_metros_lineares TYPE numeric(15,3);

ALTER TABLE estoque.f_tecido_estoque
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE estoque.f_tecido_estoque
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN updated_at SET DEFAULT current_timestamp;

ALTER TABLE estoque.f_tecido_estoque
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

CREATE OR REPLACE VIEW estoque.ftecidos_estoque AS
    SELECT * FROM estoque.f_tecido_estoque;
COMMENT ON VIEW estoque.ftecidos_estoque IS
    'DEPRECATED 2026-05-05: usar f_tecido_estoque. Sera removido em 2026-08-03.';
```

---

## Convencoes aplicadas neste dicionario

| Convencao | Fonte |
|---|---|
| `sku_tecido varchar(30)` para identificacao de tecido | BOAS_PRATICAS_DW secao 6.1 e secao 11 |
| `sku_produto varchar(30)` para identificacao de produto | BOAS_PRATICAS_DW secao 6.1 |
| `cod_deposito smallint` como join key de deposito | BOAS_PRATICAS_DW secao 11 |
| `qt_*` para quantidades, `numeric(15,3)` | BOAS_PRATICAS_DW secao 3.2 e secao 8 |
| `vl_*` para valores monetarios, `numeric(15,2)` | BOAS_PRATICAS_DW secao 3.2 e secao 8 |
| `ps_*` para pesos fisicos, `numeric(15,3)` | BOAS_PRATICAS_DW secao 3.2 |
| `updated_at timestamp` para auditoria | BOAS_PRATICAS_DW secao 4 e secao 15.4 |
| `id bigserial PRIMARY KEY` surrogate key | BOAS_PRATICAS_DW secao 5 |
| `d_tipo_movimento_estoque` (era `dtipo_movimentacaoestoque`) | BOAS_PRATICAS_DW secao 2 |
| `f_rolo_estoque` (era `frolos_estoq`) | BOAS_PRATICAS_DW secao 2 |
| `numeric(38,10)` e `float8` substituidos por tipos padrao | BOAS_PRATICAS_DW secao 8 |
| Views de compatibilidade por 90 dias apos renomeio | BOAS_PRATICAS_DW secao 17.1 |
| Prefixos proibidos (`codigo_`, `quantidade_`, `valor_`, `fk_`) removidos | BOAS_PRATICAS_DW secao 1 |

---

## Pendencias e itens para investigacao

| Tabela | Pendencia |
|---|---|
| `freserva_tinturaria` | Verificar se `data_de_emissao` e `data_emissao` sao divergentes antes de remover duplicata |
| `frolos_estoq` / `ftecidos_estoque` | Campo `tecido` / `cd_tecido` — confirmar se contem SKU composto ou descricao livre; pode exigir lookup na dimensao `ppcp.dtecidos` |
| `fsaldoestoqueinteg` | Campo `situacao` (varchar 1) — levantar os valores distintos na origem para mapear corretamente para `boolean` |
| `fcigam_saldo_estoque_atual` | Campo `situacao` (numeric 1) — confirmar que valores sao estritamente 0 e 1 antes de converter para `boolean` |
| `fsaldoestoqueinteg` | Campo `sku` (varchar 111) — confirmar semantica; pode ser descricao livre ao inves de SKU composto |
| `f_rolo_estoque_cong` | Definir data de referencia para `dt_congelamento` retroativa na carga inicial |
| Todas as tabelas | Confirmar com o time de PPCP o mapeamento exato de `tecido varchar(111)` para `sku_tecido varchar(30)` |
