# Dicionario de Dados — Schema `stage`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 20 tabelas — area de staging para cargas incrementais e integracoes
**Responsavel:** Schema stage — tabelas de staging/transit: dados brutos antes de carga nas tabelas definitivas; nao sao consumidos diretamente por BI

---

## Caracteristicas do Schema

O schema `stage` e uma **area de transit** — as tabelas recebem dados brutos dos sistemas de origem antes de serem transformados e carregados nas tabelas definitivas de outros schemas (live, jma, ppcp, etc.).

**Regras especificas para staging:**
- Tabelas devem usar prefixo `stg_` conforme BOAS_PRATICAS secao 2.
- Surrogate keys (`id bigserial`) **nao sao obrigatorias** em tabelas de staging.
- Colunas de auditoria (`created_at`, `updated_at`) sao recomendadas mas nao obrigatorias.
- Tipos de dados podem ser mais flexiveis que nas tabelas definitivas (ex: `text` para staging).
- Tabelas sem prefixo `stg_` (como `pedi100`, `pedi135`, `lojas_vigencia_stage`) sao legadas e devem ser renomeadas.

---

## Sumario

| Tabela atual | Nome proposto | Observacao |
|---|---|---|
| `stage.dstg_evento_stage` | `stage.stg_evento` | Remover duplo sufixo `_stage` |
| `stage.fmovimentosinteg_stage` | `stage.stg_movimentos_integ` | Remover prefixo `f`; ja tem `stage` no nome |
| `stage.fordens_corte_hist_stage` | `stage.stg_ordens_corte_hist` | Corrigir prefixo |
| `stage.fordens_corte_stage` | `stage.stg_ordens_corte` | Corrigir prefixo |
| `stage.fstg_corte_40` | `stage.stg_corte_40` | Remover prefixo `f` |
| `stage.ftabelaprecogrupoest` | `stage.stg_tabela_preco_grupo` | Corrigir prefixo; sem `_stage` |
| `stage.ftabelaprecostage` | `stage.stg_tabela_preco` | Corrigir prefixo |
| `stage.lojas_vigencia_stage` | `stage.stg_loja_vigencia` | Normalizar nome |
| `stage.pedi100` | `stage.stg_pedido_100` | Adicionar prefixo `stg_` |
| `stage.pedi135` | `stage.stg_pedido_135` | Adicionar prefixo `stg_` |
| `stage.stage_movimentacoes_integ` | `stage.stg_movimentacoes_integ` | Remover prefixo redundante `stage_` |
| `stage.stg_cnpj_ativos_integ` | `stage.stg_cnpj_ativo` | Simplificar nome |
| `stage.stg_evidencias` | `stage.stg_evidencia` | Padrao singular |
| `stage.stg_infos_lojas_integ` | `stage.stg_loja_info` | Simplificar |
| `stage.stg_movimentos_integ` | `stage.stg_movimento_loja` | Simplificar |
| `stage.stg_movimentos_integ_full` | `stage.stg_movimento_loja_full` | Versao full |
| `stage.stg_paradasmaquinas_marft_oper` | `stage.stg_parada_maquina_oper` | Simplificar |
| `stage.stg_paradasmaquinas_marft_pmo` | `stage.stg_parada_maquina_pmo` | Simplificar |
| `stage.stg_planos` | `stage.stg_plano_acao` | Nome em singular |
| `stage.stg_sugestao_reserva_tecido_oc` | `stage.stg_sugestao_reserva_tecido` | Simplificar |

---

## Detalhamento por Tabela

---

### stage.dstg_evento_stage

**Nome proposto:** `stage.stg_evento`
**Tipo:** staging
**Descricao:** Staging de eventos/codigos de calculo de RH. Transit para `rh.devento` ou similar.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `pk_evento` | `text NULL` | `cod_evento` | `varchar(20)` | [RENAME] [RETYPE] | Codigo do evento |
| `cd_evento` | `numeric(4) NULL` | `id_evento` | `smallint` | [RENAME] [RETYPE] | ID numerico |
| `cd_tipo_evento` | `numeric(1) NULL` | `id_tipo_evento` | `smallint` | [RENAME] [RETYPE] | Tipo |
| `ds_evento` | `text NULL` | `ds_evento` | `varchar(100)` | [RETYPE] | Descricao |
| `ds_evento_codigo` | `text NULL` | `ds_evento_codigo` | `varchar(50)` | [RETYPE] | Codigo descritivo |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp` | [RENAME] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE stage.dstg_evento_stage RENAME TO stg_evento;
ALTER TABLE stage.stg_evento RENAME COLUMN pk_evento TO cod_evento;
ALTER TABLE stage.stg_evento ALTER COLUMN cod_evento TYPE varchar(20);
ALTER TABLE stage.stg_evento RENAME COLUMN cd_evento TO id_evento;
ALTER TABLE stage.stg_evento ALTER COLUMN id_evento TYPE smallint;
ALTER TABLE stage.stg_evento RENAME COLUMN cd_tipo_evento TO id_tipo_evento;
ALTER TABLE stage.stg_evento ALTER COLUMN id_tipo_evento TYPE smallint;
ALTER TABLE stage.stg_evento ALTER COLUMN ds_evento TYPE varchar(100);
ALTER TABLE stage.stg_evento RENAME COLUMN ultima_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.dstg_evento_stage AS SELECT * FROM stage.stg_evento;
COMMENT ON VIEW stage.dstg_evento_stage IS 'DEPRECATED 2026-05-05: usar stg_evento. Sera removido em 2026-08-03.';
```

---

### stage.fmovimentosinteg_stage

**Nome proposto:** `stage.stg_movimentos_integ`
**Tipo:** staging
**Descricao:** Staging de movimentacoes de integracao de lojas (transit para `jma.fmovimentosinteg`). Dados brutos do CIGAM/portal antes da transformacao.

#### Colunas (principais)

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| `portal` | `id_portal` | Codigo do portal |
| `fk_cliente` | `cod_cliente` | Codigo do cliente |
| `numorcamento` | `nr_orcamento` | Numero do orcamento |
| `numnf` | `nr_nota_fiscal` | NF |
| `serie` | `nr_serie_nf` | Serie |
| `fk_produto` | `sku_produto` | SKU do produto |
| `data_lancamento` | `dth_lancamento` | Data/hora |
| `ultima_atualizacao` | `updated_at` | Auditoria |
| `valor_liquido` | `vl_liquido` | Valor liquido |
| `desconto` | `vl_desconto` | Desconto |
| `cnpj` | `cnpj_loja` | CNPJ da loja |

#### Migracao SQL (resumida)

```sql
ALTER TABLE stage.fmovimentosinteg_stage RENAME TO stg_movimentos_integ;
ALTER TABLE stage.stg_movimentos_integ RENAME COLUMN fk_cliente TO cod_cliente;
ALTER TABLE stage.stg_movimentos_integ RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE stage.stg_movimentos_integ RENAME COLUMN numorcamento TO nr_orcamento;
ALTER TABLE stage.stg_movimentos_integ RENAME COLUMN numnf TO nr_nota_fiscal;
ALTER TABLE stage.stg_movimentos_integ RENAME COLUMN ultima_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.fmovimentosinteg_stage AS SELECT * FROM stage.stg_movimentos_integ;
COMMENT ON VIEW stage.fmovimentosinteg_stage IS 'DEPRECATED 2026-05-05: usar stg_movimentos_integ. Sera removido em 2026-08-03.';
```

---

### stage.fordens_corte_hist_stage

**Nome proposto:** `stage.stg_ordens_corte_hist`
**Tipo:** staging
**Descricao:** Tabela de historico de ordens de corte em staging. Contem apenas um campo `id varchar(25)` — provavelmente tabela de controle de IDs processados.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `varchar(25) NULL` | `id_ordem_corte` | `varchar(25)` | [RENAME] | ID da ordem de corte processada |

#### Migracao SQL

```sql
ALTER TABLE stage.fordens_corte_hist_stage RENAME TO stg_ordens_corte_hist;
ALTER TABLE stage.stg_ordens_corte_hist RENAME COLUMN id TO id_ordem_corte;
CREATE OR REPLACE VIEW stage.fordens_corte_hist_stage AS SELECT * FROM stage.stg_ordens_corte_hist;
COMMENT ON VIEW stage.fordens_corte_hist_stage IS 'DEPRECATED 2026-05-05: usar stg_ordens_corte_hist. Sera removido em 2026-08-03.';
```

---

### stage.fordens_corte_stage

**Nome proposto:** `stage.stg_ordens_corte`
**Tipo:** staging
**Descricao:** Staging de ordens de corte do PPCP. Transit para `ppcp.fordens_corte` / `jma.fordens_corte_stage`.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| `cd_ordem_producao` | `nr_ordem_producao` | `integer` | Numero da OP |
| `cd_grupo` | `cod_referencia` | `varchar(5)` | Referencia (grupo=referencia no Systextil) |
| `cd_subgrupo` | `cod_tamanho` | `varchar(5)` | Tamanho |
| `prod_rej_item` | `cod_cor` | `varchar(6)` | Cor do item |
| `periodo_producao` | `nr_periodo_producao` | `smallint` | Periodo |
| `cd_ordem_confeccao` | `nr_ordem_confeccao` | `integer` | OC |
| `situacao_ordem` | `id_situacao_ordem` | `smallint` | Situacao |
| `data_alteracao` | `dth_alteracao` | `timestamp` | Alteracao |
| `data_producao` | `dt_producao` | `date` | Data producao |
| `dthora_atualizacao` | `updated_at` | `timestamp` | Auditoria |
| `fk_produto` | `sku_produto` | `varchar(30)` | SKU |
| `fk_fornecedor` | `cod_fornecedor` | `varchar(18)` | Fornecedor (faccao) |
| `qtd_pecas_progamada` | `qt_programada` | `numeric(15,3)` | Qtd programada |
| `qtd_pecas_produzida` | `qt_produzida` | `numeric(15,3)` | Qtd produzida |

#### Migracao SQL (resumida)

```sql
ALTER TABLE stage.fordens_corte_stage RENAME TO stg_ordens_corte;
ALTER TABLE stage.stg_ordens_corte RENAME COLUMN cd_ordem_producao TO nr_ordem_producao;
ALTER TABLE stage.stg_ordens_corte RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE stage.stg_ordens_corte ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE stage.stg_ordens_corte RENAME COLUMN dthora_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.fordens_corte_stage AS SELECT * FROM stage.stg_ordens_corte;
COMMENT ON VIEW stage.fordens_corte_stage IS 'DEPRECATED 2026-05-05: usar stg_ordens_corte. Sera removido em 2026-08-03.';
```

---

### stage.fstg_corte_40

**Nome proposto:** `stage.stg_corte_40`
**Tipo:** staging
**Descricao:** Staging incremental de cortes do estagio 40 (tecelagem?). Transit para `ppcp` / `jma`.

#### Colunas (principais)

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| `cd_ordem_producao` | `nr_ordem_producao` | OP |
| `cd_nivel99` | `cod_nivel_produto` | Nivel do SKU |
| `cd_grupo` | `cod_referencia` | Referencia |
| `cd_subgrupo` | `cod_tamanho` | Tamanho |
| `prod_rej_item` | `cod_cor` | Cor |
| `cd_estagio` | `id_estagio` | Estagio |
| `periodo_producao` | `nr_periodo_producao` | Periodo |
| `cd_ordem_confeccao` | `nr_ordem_confeccao` | OC |
| `dthora_atualizacao` | `updated_at` | Auditoria |
| `fk_produto` | `sku_produto` | SKU |

#### Migracao SQL (resumida)

```sql
ALTER TABLE stage.fstg_corte_40 RENAME TO stg_corte_40;
ALTER TABLE stage.stg_corte_40 RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE stage.stg_corte_40 RENAME COLUMN dthora_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.fstg_corte_40 AS SELECT * FROM stage.stg_corte_40;
COMMENT ON VIEW stage.fstg_corte_40 IS 'DEPRECATED 2026-05-05: usar stg_corte_40. Sera removido em 2026-08-03.';
```

---

### stage.ftabelaprecogrupoest

**Nome proposto:** `stage.stg_tabela_preco_grupo`
**Tipo:** staging
**Descricao:** Staging de tabela de precos por grupo de estrutura de produto. Todos os campos sao `text` — versao raw de staging.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `tabela_preco` | `text NULL` | `cod_tabela_preco` | `text` | [RENAME] | Codigo da tabela (manter text em staging) |
| `tabela_preco_cod` | `text NULL` | `ds_tabela_preco_cod` | `text` | [RENAME] | Codigo descritivo |
| `grupo_estrutura` | `text NULL` | `ds_grupo_estrutura` | `text` | [RENAME] | Grupo de estrutura |
| `item_estrutura` | `text NULL` | `ds_item_estrutura` | `text` | [RENAME] | Item |
| `subgru_estrutura` | `text NULL` | `ds_subgrupo_estrutura` | `text` | [RENAME] | Subgrupo |
| `nivel_estrutura` | `text NULL` | `ds_nivel_estrutura` | `text` | [RENAME] | Nivel |
| `val_tabela_preco` | `numeric(19,6) NULL` | `vl_tabela_preco` | `numeric(15,5)` | [RENAME] [RETYPE] | Valor; padronizar tipo |

#### Migracao SQL

```sql
ALTER TABLE stage.ftabelaprecogrupoest RENAME TO stg_tabela_preco_grupo;
ALTER TABLE stage.stg_tabela_preco_grupo RENAME COLUMN tabela_preco TO cod_tabela_preco;
ALTER TABLE stage.stg_tabela_preco_grupo RENAME COLUMN grupo_estrutura TO ds_grupo_estrutura;
ALTER TABLE stage.stg_tabela_preco_grupo RENAME COLUMN item_estrutura TO ds_item_estrutura;
ALTER TABLE stage.stg_tabela_preco_grupo RENAME COLUMN subgru_estrutura TO ds_subgrupo_estrutura;
ALTER TABLE stage.stg_tabela_preco_grupo RENAME COLUMN nivel_estrutura TO ds_nivel_estrutura;
ALTER TABLE stage.stg_tabela_preco_grupo RENAME COLUMN val_tabela_preco TO vl_tabela_preco;
ALTER TABLE stage.stg_tabela_preco_grupo ALTER COLUMN vl_tabela_preco TYPE numeric(15,5) USING vl_tabela_preco::numeric(15,5);
CREATE OR REPLACE VIEW stage.ftabelaprecogrupoest AS SELECT * FROM stage.stg_tabela_preco_grupo;
COMMENT ON VIEW stage.ftabelaprecogrupoest IS 'DEPRECATED 2026-05-05: usar stg_tabela_preco_grupo. Sera removido em 2026-08-03.';
```

---

### stage.ftabelaprecostage

**Nome proposto:** `stage.stg_tabela_preco`
**Tipo:** staging
**Descricao:** Staging de tabela de precos de produtos. Transit para `jma.ftabelapreco`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `tabela_preco` | `varchar(9) NULL` | `cod_tabela_preco` | `varchar(9)` | [RENAME] | Codigo |
| `tabela_preco_cod` | `varchar(11) NULL` | `ds_tabela_preco_cod` | `varchar(11)` | [RENAME] | Codigo descritivo |
| `fk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU |
| `val_tabela_preco` | `numeric(18,3) NULL` | `vl_tabela_preco` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor |
| `vlr_com_desconto` | `numeric(18,3) NULL` | `vl_com_desconto` | `numeric(15,2)` | [RENAME] [RETYPE] | Com desconto |
| `grupo_estrutura` | `varchar(5) NULL` | `ds_grupo_estrutura` | `varchar(5)` | [RENAME] | Grupo |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp` | [RENAME] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE stage.ftabelaprecostage RENAME TO stg_tabela_preco;
ALTER TABLE stage.stg_tabela_preco RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE stage.stg_tabela_preco ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE stage.stg_tabela_preco RENAME COLUMN dthora_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.ftabelaprecostage AS SELECT * FROM stage.stg_tabela_preco;
COMMENT ON VIEW stage.ftabelaprecostage IS 'DEPRECATED 2026-05-05: usar stg_tabela_preco. Sera removido em 2026-08-03.';
```

---

### stage.lojas_vigencia_stage

**Nome proposto:** `stage.stg_loja_vigencia`
**Tipo:** staging
**Descricao:** Vigencia de CNPJ por loja — registra troca de CNPJ com periodo de vigencia e portais antigo/novo.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | (sem surrogate em staging) | — | — | Staging sem PK obrigatoria |
| `id` | `int4 NULL` | `id_vigencia` | `integer` | [RENAME] | ID do registro |
| `data_fim_vigencia` | `timestamp NULL` | `dt_fim_vigencia` | `date` | [RENAME] [RETYPE] | Data fim; converter de timestamp para date |
| `portal_antigo` | `varchar(35) NULL` | `cod_portal_antigo` | `varchar(35)` | [RENAME] | Portal antigo |
| `portal_novo` | `varchar(35) NULL` | `cod_portal_novo` | `varchar(35)` | [RENAME] | Portal novo |
| `ordem_troca` | `varchar(35) NULL` | `nr_ordem_troca` | `varchar(35)` | [RENAME] | Ordem da troca |
| `id_portal_fixo` | `varchar(35) NULL` | `cod_portal_fixo` | `varchar(35)` | [RENAME] | Portal fixo (nao muda) |
| `data_criacao` | `timestamp NULL` | `dth_criacao` | `timestamp` | [RENAME] | Criacao |
| `usuario_criacao` | `varchar(35) NULL` | `nm_usuario_criacao` | `varchar(35)` | [RENAME] | Usuario |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp` | [RENAME] | Auditoria |
| `cnpj_antigo_completo` | `varchar(15) NULL` | `cnpj_antigo` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ antigo; formato DW |
| `cnpj_atual_completo` | `varchar(15) NULL` | `cnpj_atual` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ atual; formato DW |
| `cnpj_antigo` | `varchar(14) NULL` | `cnpj_antigo_sem_dv` | `varchar(14)` | [RENAME] | CNPJ sem digitos — manter para referencia |
| `cnpj_atual` | `varchar(14) NULL` | `cnpj_atual_sem_dv` | `varchar(14)` | [RENAME] | Idem |
| `data_inicio_vigencia` | `timestamp NULL` | `dt_inicio_vigencia` | `date` | [RENAME] [RETYPE] | Data inicio |

#### Migracao SQL

```sql
ALTER TABLE stage.lojas_vigencia_stage RENAME TO stg_loja_vigencia;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN id TO id_vigencia;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN portal_antigo TO cod_portal_antigo;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN portal_novo TO cod_portal_novo;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN ordem_troca TO nr_ordem_troca;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN id_portal_fixo TO cod_portal_fixo;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN data_criacao TO dth_criacao;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN usuario_criacao TO nm_usuario_criacao;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN cnpj_antigo_completo TO cnpj_antigo;
ALTER TABLE stage.stg_loja_vigencia ALTER COLUMN cnpj_antigo TYPE varchar(16);
ALTER TABLE stage.stg_loja_vigencia RENAME COLUMN cnpj_atual_completo TO cnpj_atual;
ALTER TABLE stage.stg_loja_vigencia ALTER COLUMN cnpj_atual TYPE varchar(16);
CREATE OR REPLACE VIEW stage.lojas_vigencia_stage AS SELECT * FROM stage.stg_loja_vigencia;
COMMENT ON VIEW stage.lojas_vigencia_stage IS 'DEPRECATED 2026-05-05: usar stg_loja_vigencia. Sera removido em 2026-08-03.';
```

---

### stage.pedi100

**Nome proposto:** `stage.stg_pedido_100`
**Tipo:** staging
**Descricao:** Staging de pedidos com status (100 = pedidos em carteira/saldo). Transit para tabelas de pedido em `jma`/`comercial`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `pedido_venda` | `numeric(9) NULL` | `nr_pedido_venda` | `integer` | [RENAME] [RETYPE] | Pedido |
| `data_entr_venda` | `timestamp NULL` | `dt_entrega_venda` | `date` | [RENAME] [RETYPE] | Data entrega |
| `situacao_venda` | `numeric(2) NULL` | `id_situacao_venda` | `smallint` | [RENAME] [RETYPE] | Situacao |
| `cod_cancelamento` | `numeric(3) NULL` | `id_cancelamento` | `smallint` | [RENAME] [RETYPE] | Cancelamento |
| `qtde_saldo_pedi` | `numeric(15,3) NULL` | `qt_saldo` | `numeric(15,3)` | [RENAME] | Saldo qtd |
| `valor_saldo_pedi` | `numeric(15,3) NULL` | `vl_saldo` | `numeric(15,2)` | [RENAME] [RETYPE] | Saldo valor |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp` | [RENAME] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE stage.pedi100 RENAME TO stg_pedido_100;
ALTER TABLE stage.stg_pedido_100 RENAME COLUMN pedido_venda TO nr_pedido_venda;
ALTER TABLE stage.stg_pedido_100 ALTER COLUMN nr_pedido_venda TYPE integer;
ALTER TABLE stage.stg_pedido_100 RENAME COLUMN ultima_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.pedi100 AS SELECT * FROM stage.stg_pedido_100;
COMMENT ON VIEW stage.pedi100 IS 'DEPRECATED 2026-05-05: usar stg_pedido_100. Sera removido em 2026-08-03.';
```

---

### stage.pedi135

**Nome proposto:** `stage.stg_pedido_135`
**Tipo:** staging
**Descricao:** Staging de situacoes de pedido (135 = historico de bloqueio/liberacao). Transit para controle de pedidos.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `pedido_venda` | `numeric(9) NULL` | `nr_pedido_venda` | `integer` | [RENAME] [RETYPE] | Pedido |
| `seq_situacao` | `numeric(2) NULL` | `nr_seq_situacao` | `smallint` | [RENAME] [RETYPE] | Sequencia |
| `codigo_situacao` | `numeric(2) NULL` | `id_situacao` | `smallint` | [RENAME] [RETYPE] | Situacao |
| `flag_liberacao` | `varchar(5) NULL` | `fl_liberacao` | `varchar(5)` | [RENAME] | Flag liberacao |
| `data_situacao` | `timestamp NULL` | `dth_situacao` | `timestamp` | [RENAME] | Data situacao |
| `data_liberacao` | `timestamp NULL` | `dth_liberacao` | `timestamp` | [RENAME] | Data liberacao |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp` | [RENAME] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE stage.pedi135 RENAME TO stg_pedido_135;
ALTER TABLE stage.stg_pedido_135 RENAME COLUMN pedido_venda TO nr_pedido_venda;
ALTER TABLE stage.stg_pedido_135 ALTER COLUMN nr_pedido_venda TYPE integer;
ALTER TABLE stage.stg_pedido_135 RENAME COLUMN ultima_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.pedi135 AS SELECT * FROM stage.stg_pedido_135;
COMMENT ON VIEW stage.pedi135 IS 'DEPRECATED 2026-05-05: usar stg_pedido_135. Sera removido em 2026-08-03.';
```

---

### stage.stage_movimentacoes_integ

**Nome proposto:** `stage.stg_movimentacoes_integ`
**Tipo:** staging
**Descricao:** Staging de movimentacoes de integracao de lojas — versao mais completa que `stg_movimentos_integ`, com campo `portal_movimentacao` e `cnpj_movimentacao`.

#### Colunas (principais — apenas diferencas de `stg_movimentos_integ`)

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| `portal_movimentacao` | `id_portal` | ID do portal |
| `cnpj_movimentacao` | `cnpj_loja` | CNPJ da loja |
| `fk_produto` | `sku_produto` | SKU |
| `ultima_atualizacao` | `updated_at` | Auditoria |
| `loja_movimentacao` | `cod_loja` | Codigo da loja |

#### Migracao SQL (resumida)

```sql
ALTER TABLE stage.stage_movimentacoes_integ RENAME TO stg_movimentacoes_integ;
ALTER TABLE stage.stg_movimentacoes_integ RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE stage.stg_movimentacoes_integ ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE stage.stg_movimentacoes_integ RENAME COLUMN ultima_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.stage_movimentacoes_integ AS SELECT * FROM stage.stg_movimentacoes_integ;
COMMENT ON VIEW stage.stage_movimentacoes_integ IS 'DEPRECATED 2026-05-05: usar stg_movimentacoes_integ. Sera removido em 2026-08-03.';
```

---

### stage.stg_cnpj_ativos_integ

**Nome proposto:** `stage.stg_cnpj_ativo`
**Tipo:** staging
**Descricao:** CNPJs ativos com vigencia e portais correspondentes. Tabela de referencia para integracao de lojas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `cnpj_antigo` | `varchar(20) NULL` | `cnpj_antigo` | `varchar(16)` | [RETYPE] | CNPJ formato DW |
| `cnpj_atual` | `varchar(20) NULL` | `cnpj_atual` | `varchar(16)` | [RETYPE] | CNPJ formato DW |
| `data_inicio_vigencia` | `date NULL` | `dt_inicio_vigencia` | `date` | OK | Data inicio |
| `data_fim_vigencia` | `date NULL` | `dt_fim_vigencia` | `date` | OK | Data fim |
| `portal_antigo` | `varchar(20) NULL` | `cod_portal_antigo` | `varchar(20)` | [RENAME] | Portal antigo |
| `portal_atual` | `varchar(20) NULL` | `cod_portal_atual` | `varchar(20)` | [RENAME] | Portal atual |

#### Migracao SQL

```sql
ALTER TABLE stage.stg_cnpj_ativos_integ RENAME TO stg_cnpj_ativo;
ALTER TABLE stage.stg_cnpj_ativo ALTER COLUMN cnpj_antigo TYPE varchar(16);
ALTER TABLE stage.stg_cnpj_ativo ALTER COLUMN cnpj_atual TYPE varchar(16);
ALTER TABLE stage.stg_cnpj_ativo RENAME COLUMN portal_antigo TO cod_portal_antigo;
ALTER TABLE stage.stg_cnpj_ativo RENAME COLUMN portal_atual TO cod_portal_atual;
```

---

### stage.stg_evidencias

**Nome proposto:** `stage.stg_evidencia`
**Tipo:** staging
**Descricao:** Evidencias de checklist em staging. Transit para `api.f_evidencias`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `answer_id` | `varchar(100) NULL` | `id_resposta` | `varchar(100)` | [RENAME] | ID da resposta (varchar em staging — tipagem frouxa intencional) |
| `answer_evidence_type_id` | `varchar(100) NULL` | `id_tipo_evidencia` | `varchar(100)` | [RENAME] | Tipo |
| `answer_url` | `text NULL` | `ds_url_evidencia` | `text` | [RENAME] | URL |
| `answer_evidence_type_id_ref` | `varchar(100) NULL` | `id_tipo_evidencia_ref` | `varchar(100)` | [RENAME] | Referencia tipo |
| `answer_evidence_type_name_ref` | `varchar(100) NULL` | `ds_tipo_evidencia` | `varchar(100)` | [RENAME] | Descricao |

---

### stage.stg_infos_lojas_integ

**Nome proposto:** `stage.stg_loja_info`
**Tipo:** staging
**Descricao:** Informacoes de lojas para integracao. Transit para `live.d_loja`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id_loja` | `int4 NULL` | `id_loja` | `integer` | OK | ID da loja |
| `descricao` | `varchar(200) NULL` | `ds_loja` | `varchar(200)` | [RENAME] | Descricao |
| `apelido` | `varchar(200) NULL` | `nm_apelido` | `varchar(100)` | [RENAME] [RETYPE] | Apelido |
| `razao_social` | `varchar(200) NULL` | `nm_razao_social` | `varchar(200)` | [RENAME] | Razao social |
| `situacao` | `int2 NULL` | `id_situacao` | `smallint` | [RENAME] | Situacao |
| `endereco` | `varchar(200) NULL` | `end_logradouro` | `varchar(200)` | [RENAME] | Endereco |
| `cep` | `int4 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP |
| `id_portal` | `int4 NULL` | `id_portal` | `integer` | OK | Portal CIGAM |
| `data_inauguracao` | `timestamp NULL` | `dt_inauguracao` | `date` | [RENAME] [RETYPE] | Inauguracao |
| `cnpj` | `varchar(100) NULL` | `cnpj_loja` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ formato DW |
| `portal` | `varchar(72) NULL` | `cod_portal` | `varchar(35)` | [RENAME] [RETYPE] | Codigo portal |
| `rede` | `varchar(100) NULL` | `nm_rede` | `varchar(50)` | [RENAME] [RETYPE] | Rede |

---

### stage.stg_movimentos_integ

**Nome proposto:** `stage.stg_movimento_loja`
**Tipo:** staging
**Descricao:** Movimentacoes de lojas para integracao (versao com mais colunas que `fmovimentosinteg_stage`).

Segue mesmo padrao de `stg_movimentos_integ` (renomeada de `fmovimentosinteg_stage`). Renomear colunas `fk_produto -> sku_produto`, `ultima_atualizacao -> updated_at`.

---

### stage.stg_movimentos_integ_full

**Nome proposto:** `stage.stg_movimento_loja_full`
**Tipo:** staging
**Descricao:** Versao completa (full load) de movimentacoes de lojas.

> **Decisao pendente:** Avaliar se `stg_movimento_loja_full` pode ser consolidada com `stg_movimento_loja` via flag `fl_full_load`.

---

### stage.stg_paradasmaquinas_marft_oper

**Nome proposto:** `stage.stg_parada_maquina_oper`
**Tipo:** staging
**Descricao:** Staging de paradas de maquina por operador na Marft.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `cod_operador` | `numeric(5) NULL` | `id_operador` | `integer` | [RENAME] [RETYPE] | Operador |
| `nome_operador` | `text NULL` | `nm_operador` | `varchar(100)` | [RENAME] [RETYPE] | Nome |
| `data` | `timestamp NULL` | `dt_data` | `date` | [RENAME] [RETYPE] | Data; remover aspas; `date` |
| `hora_inicio` | `timestamp NULL` | `dth_inicio` | `timestamp` | [RENAME] | Inicio |
| `hora_fim` | `timestamp NULL` | `dth_fim` | `timestamp` | [RENAME] | Fim |
| `minutos` | `numeric(5) NULL` | `nr_minutos` | `integer` | [RENAME] [RETYPE] | Minutos parado |
| `codigo_motivo` | `numeric(3) NULL` | `id_motivo` | `smallint` | [RENAME] [RETYPE] | Motivo |
| `motivo` | `text NULL` | `ds_motivo` | `varchar(100)` | [RENAME] [RETYPE] | Descricao |
| `detalhes` | `text NULL` | `obs_detalhes` | `text` | [RENAME] | Detalhes |
| `codigo_celula` | `numeric(5) NULL` | `id_celula` | `integer` | [RENAME] [RETYPE] | Celula |
| `nome_celula` | `text NULL` | `nm_celula` | `varchar(50)` | [RENAME] [RETYPE] | Nome |
| `turno` | `numeric(3) NULL` | `id_turno` | `smallint` | [RENAME] [RETYPE] | Turno |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp` | [RENAME] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE stage.stg_paradasmaquinas_marft_oper RENAME TO stg_parada_maquina_oper;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN cod_operador TO id_operador;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN id_operador TYPE integer;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN nome_operador TO nm_operador;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN nm_operador TYPE varchar(100);
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN "data" TO dt_data;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN dt_data TYPE date USING dt_data::date;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN hora_inicio TO dth_inicio;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN hora_fim TO dth_fim;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN minutos TO nr_minutos;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN nr_minutos TYPE integer;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN codigo_motivo TO id_motivo;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN id_motivo TYPE smallint;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN motivo TO ds_motivo;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN ds_motivo TYPE varchar(100);
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN detalhes TO obs_detalhes;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN codigo_celula TO id_celula;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN id_celula TYPE integer;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN nome_celula TO nm_celula;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN nm_celula TYPE varchar(50);
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN turno TO id_turno;
ALTER TABLE stage.stg_parada_maquina_oper ALTER COLUMN id_turno TYPE smallint;
ALTER TABLE stage.stg_parada_maquina_oper RENAME COLUMN ultima_atualizacao TO updated_at;
CREATE OR REPLACE VIEW stage.stg_paradasmaquinas_marft_oper AS SELECT * FROM stage.stg_parada_maquina_oper;
COMMENT ON VIEW stage.stg_paradasmaquinas_marft_oper IS 'DEPRECATED 2026-05-05: usar stg_parada_maquina_oper. Sera removido em 2026-08-03.';
```

---

### stage.stg_paradasmaquinas_marft_pmo

**Nome proposto:** `stage.stg_parada_maquina_pmo`
**Tipo:** staging
**Descricao:** Staging de paradas de maquina por PMO (planejamento). Estrutura identica a `stg_parada_maquina_oper`.

Segue o mesmo padrao de renomeacao de `stg_parada_maquina_oper`.

---

### stage.stg_planos

**Nome proposto:** `stage.stg_plano_acao`
**Tipo:** staging
**Descricao:** Staging de planos de acao de checklist. Todos os campos sao `varchar(100)` — tipagem frouxa intencional de staging. Transit para `api.f_plano_acao`.

#### Colunas

Todos os campos sao `varchar(100)` ou `varchar(1000)` — manter em staging. Apenas renomear `answer_answer -> ds_resposta`.

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| `id` | `id_plano` | ID do plano |
| `task_code` | `nr_tarefa` | Codigo tarefa |
| `creator_user_id` | `id_usuario_criador` | Criador |
| `created_at` | `dth_criacao` | Criacao (manter como varchar em staging) |
| `updated_at` | `dth_atualizacao` | Atualizacao |
| `checklist_execution_id` | `id_execucao_checklist` | Execucao |
| `question_id` | `id_questao` | Questao |
| `action_plan_state_id` | `id_status_plano` | Status |
| `action_plan_state_name` | `ds_status_plano` | Descricao status |
| `user_id` | `id_usuario_resp` | Responsavel |
| `user_name` | `nm_usuario_resp` | Nome |
| `user_role` | `ds_cargo` | Cargo |
| `answer_id` | `id_resposta` | Resposta |
| `answer_respondent_user_id` | `id_usuario_respondente` | Respondente |
| `answer_approver_user_id` | `id_usuario_aprovador` | Aprovador |
| `answer_answer` | `ds_resposta` | Texto da resposta |

#### Migracao SQL (resumida)

```sql
ALTER TABLE stage.stg_planos RENAME TO stg_plano_acao;
ALTER TABLE stage.stg_plano_acao RENAME COLUMN answer_answer TO ds_resposta;
-- Renomear demais colunas conforme tabela acima
CREATE OR REPLACE VIEW stage.stg_planos AS SELECT * FROM stage.stg_plano_acao;
COMMENT ON VIEW stage.stg_planos IS 'DEPRECATED 2026-05-05: usar stg_plano_acao. Sera removido em 2026-08-03.';
```

---

### stage.stg_sugestao_reserva_tecido_oc

**Nome proposto:** `stage.stg_sugestao_reserva_tecido`
**Tipo:** staging
**Descricao:** Sugestoes de reserva de tecido por ordem de confeccao. Transit para `ppcp.fsugestao_reserva_tecido`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `cd_ordem_producao` | `varchar(25) NULL` | `nr_ordem_producao` | `varchar(25)` | [RENAME] | OP (manter varchar em staging) |
| `periodo_producao` | `varchar(25) NULL` | `nr_periodo_producao` | `varchar(25)` | [RENAME] | Periodo |
| `cd_estagio` | `varchar(25) NULL` | `id_estagio` | `varchar(25)` | [RENAME] | Estagio |
| `referencia` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | [RENAME] | Referencia |
| `cod_cor` | `varchar(6) NULL` | `cod_cor` | `varchar(6)` | OK | Cor |
| `fk_produto` | `varchar(40) NULL` | `sku_produto` | `varchar(40)` | [RENAME] | SKU |
| `fk_componente` | `varchar(40) NULL` | `sku_componente` | `varchar(40)` | [RENAME] | Componente (tecido) |
| `unidade_medida` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(2)` | [RENAME] | Unidade |
| `qtd_a_produzir` | `numeric(17,2) NULL` | `qt_a_produzir` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd a produzir |
| `qtd_em_producao_pacote` | `numeric(17,2) NULL` | `qt_em_producao_pacote` | `numeric(15,3)` | [RENAME] [RETYPE] | Em producao |
| `qtd_pecas_progamada` | `numeric(17,2) NULL` | `qt_programada` | `numeric(15,3)` | [RENAME] [RETYPE] | Programada |
| `consumo_programado` | `numeric(17,2) NULL` | `qt_consumo_programado` | `numeric(15,3)` | [RENAME] [RETYPE] | Consumo programado |

#### Migracao SQL

```sql
ALTER TABLE stage.stg_sugestao_reserva_tecido_oc RENAME TO stg_sugestao_reserva_tecido;
ALTER TABLE stage.stg_sugestao_reserva_tecido RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE stage.stg_sugestao_reserva_tecido RENAME COLUMN fk_componente TO sku_componente;
ALTER TABLE stage.stg_sugestao_reserva_tecido RENAME COLUMN qtd_a_produzir TO qt_a_produzir;
ALTER TABLE stage.stg_sugestao_reserva_tecido ALTER COLUMN qt_a_produzir TYPE numeric(15,3);
ALTER TABLE stage.stg_sugestao_reserva_tecido RENAME COLUMN qtd_pecas_progamada TO qt_programada;
ALTER TABLE stage.stg_sugestao_reserva_tecido ALTER COLUMN qt_programada TYPE numeric(15,3);
ALTER TABLE stage.stg_sugestao_reserva_tecido RENAME COLUMN consumo_programado TO qt_consumo_programado;
ALTER TABLE stage.stg_sugestao_reserva_tecido ALTER COLUMN qt_consumo_programado TYPE numeric(15,3);
CREATE OR REPLACE VIEW stage.stg_sugestao_reserva_tecido_oc AS SELECT * FROM stage.stg_sugestao_reserva_tecido;
COMMENT ON VIEW stage.stg_sugestao_reserva_tecido_oc IS 'DEPRECATED 2026-05-05: usar stg_sugestao_reserva_tecido. Sera removido em 2026-08-03.';
```

---

## Conflitos e Decisoes Pendentes — Schema `stage`

1. **`stg_movimentos_integ` vs `stg_movimentacoes_integ` vs `stg_movimento_loja` vs `stg_movimento_loja_full`**: Ha 4 tabelas de movimentacao com estrutura similar. Consolidar em 2 (incremental + full) e documentar as diferencas.
2. **`stg_parada_maquina_oper` vs `stg_parada_maquina_pmo`**: Estrutura identica. Avaliar se pode ser uma unica tabela com campo `ds_tipo_parada`.
3. **Campos `valor_bruto int8` em `fmovimentosinteg_stage`**: `int8` para valor monetario — deve ser `numeric(15,2)` na tabela definitiva. Corrigir na transformacao do ETL.
4. **`stg_corte_40` — nome sem semantica**: O sufixo `_40` refere-se ao estagio 40 (cortaria?). Confirmar e incluir na documentacao.
