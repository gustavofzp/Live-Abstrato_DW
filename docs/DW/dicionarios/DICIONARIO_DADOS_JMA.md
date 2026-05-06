# Dicionario de Dados — Schema `jma`

**Versao:** 1.0
**Data:** 2026-05-06
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 71 tabelas, schema jma — integracao lojas, faturamento, producao, metas, titulos
**Responsavel:** Fase 2 de padronizacao do DW Live
**Referencias:** BOAS_PRATICAS_DW.md v2.0

> **Nota:** O schema `jma` agrega dados de multiplas origens (Systextil, CIGAM, sistemas de loja e integradores externos).
> Muitas tabelas carecem de PK declarada e usam nomenclatura legada. Este dicionario propoe a padronizacao completa.

---

## Alertas Criticos

| # | Tabela | Problema | Acao recomendada |
|---|--------|----------|------------------|
| 1 | `ffaturamento_dev_inc` | Todas as colunas em UPPER_CASE com aspas — incompativel com o padrao DW | Renomear para snake_case; mover para `stg_` |
| 2 | `dcanaldistribuicao` | Duplicata funcional de `live.d_canal_distribuicao` | Deprecar `jma.dcanaldistribuicao`; unificar em `live.d_canal_distribuicao` |
| 3 | `dprodutoproducao` | Possivel sobreposicao com `live.d_produto` | Avaliar consolidacao; manter flag de origem Systextil |
| 4 | `ffaturamento_eua` | Colunas com `SUM(...)` como nome — quebra SQL sem aspas | Renomear colunas imediatamente |
| 5 | `fconfer_caixas` + `confer_caixas` | Duas tabelas com estrutura similar sem prefixo uniforme | Consolidar em `f_conferencia_caixa` |
| 6 | `fhists_mov_` | Nome termina com `_` — erro tipografico | Renomear para `f_hist_movimentacao` |

---

## Sumario de Tabelas

### Dimensoes (d_*)

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `jma.daparelho` | `jma.d_aparelho` | dimensao |
| `jma.dcanaldistribuicao` | `jma.d_canal_distribuicao` ⚠️ | dimensao — CONFLITO com live |
| `jma.dcentro_custo` | `jma.d_centro_custo` | dimensao |
| `jma.dcontas_estoque` | `jma.d_conta_estoque` | dimensao |
| `jma.ddeposito` | `jma.d_deposito` | dimensao |
| `jma.dfamilia_materiais` | `jma.d_familia_material` | dimensao |
| `jma.dfuncionariosinteg` | `jma.d_funcionario_integ` | dimensao |
| `jma.dgrupo_contas` | `jma.d_grupo_contas` | dimensao |
| `jma.dhistorico_contabil` | `jma.d_historico_contabil` | dimensao |
| `jma.dmotivo_bloqueio` | `jma.d_motivo_bloqueio` | dimensao |
| `jma.dmotivo_cancelamento` | `jma.d_motivo_cancelamento` | dimensao |
| `jma.dnatureza_operacao` | `jma.d_natureza_operacao` | dimensao |
| `jma.dparadasmaquinas_marft` | `jma.d_parada_maquina_marft` | dimensao/fato hibrido |
| `jma.dperiodo_producao` | `jma.d_periodo_producao` | dimensao |
| `jma.dprodutoproducao` | `jma.d_produto_producao` ⚠️ | dimensao — avaliar fusao com live |
| `jma.dsituacao_venda` | `jma.d_situacao_venda` | dimensao |
| `jma.dsituacaopedido` | `jma.d_situacao_pedido` | dimensao |
| `jma.dstatus_pedido` | `jma.d_status_pedido` | dimensao |
| `jma.dtabelapreco` | `jma.d_tabela_preco` | dimensao |

### Fatos e Tabelas Operacionais (f_* / aux_* / stg_*)

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `jma.confer_caixas` | `jma.aux_conferencia_caixa` | auxiliar (sem prefixo — candidato a remocao) |
| `jma.fconfer_caixas` | `jma.f_conferencia_caixa` | fato |
| `jma.fconfer_pecas_caixa` | `jma.f_conferencia_peca_caixa` | fato |
| `jma.fconsignadainteg` | `jma.f_consignado_integ` | fato |
| `jma.fcontrole_partes` | `jma.f_controle_parte` | fato/operacional |
| `jma.fdre_lojas` | `jma.f_dre_loja` | fato |
| `jma.fdre_orcado_lojas` | `jma.f_dre_orcado_loja` | fato |
| `jma.feficiencia_prod_marft` | `jma.f_eficiencia_prod_marft` | fato |
| `jma.feficiencia_prod_operador_marft` | `jma.f_eficiencia_prod_operador_marft` | fato |
| `jma.festrutura_produto` | `jma.f_estrutura_produto` | fato/relacional |
| `jma.ffaixas_comissao` | `jma.f_faixa_comissao` | fato |
| `jma.ffaixas_comissao_omnichannel` | `jma.f_faixa_comissao_omnichannel` | fato |
| `jma.ffaturamento` | `jma.f_faturamento` | fato principal |
| `jma.ffaturamento_dev` | `jma.f_faturamento_dev` | fato |
| `jma.ffaturamento_dev_inc` | `jma.stg_faturamento_dev_inc` ⚠️ | staging — colunas UPPER_CASE |
| `jma.ffaturamento_eua` | `jma.f_faturamento_eua` | fato |
| `jma.ffaturamento_internacional` | `jma.f_faturamento_internacional` | fato |
| `jma.ffaturamento_nacional` | `jma.f_faturamento_nacional` | fato |
| `jma.fhists_mov_` | `jma.f_hist_movimentacao` | fato |
| `jma.finspecao_qualidade` | `jma.f_inspecao_qualidade` | fato |
| `jma.flog_itens_transfer` | `jma.f_log_item_transferencia` | fato/log |
| `jma.flogpedidos` | `jma.f_log_pedido` | fato/log |
| `jma.fmeta_diario_loja` | `jma.f_meta_diaria_loja` | fato |
| `jma.fmeta_loja` | `jma.f_meta_loja` | fato |
| `jma.fmeta_mensal_loja` | `jma.f_meta_mensal_loja` | fato |
| `jma.fmeta_semanal_loja` | `jma.f_meta_semanal_loja` | fato |
| `jma.fmetasestacoes` | `jma.f_meta_estacao` | fato |
| `jma.fmetasorcamento` | `jma.f_meta_orcamento` | fato |
| `jma.fmonitor_producao` | `jma.f_monitor_producao` | fato/operacional |
| `jma.fmovimentacoesestoque` | `jma.f_movimentacao_estoque` | fato |
| `jma.fmovimentos_loja` | `jma.f_movimento_loja` | fato |
| `jma.fmovimentosinteg` | `jma.f_movimentos_integ` | fato |
| `jma.fmovimentoslojamicrovix` | `jma.f_movimento_loja_microvix` | fato |
| `jma.fordens_corte_congelado` | `jma.f_ordem_corte_congelado` | fato |
| `jma.fparametro_compra` | `jma.aux_parametro_compra` | auxiliar |
| `jma.fpedido_congelado` | `jma.f_pedido_congelado` | fato |
| `jma.fpedidos_compra` | `jma.f_pedido_compra` | fato |
| `jma.fpedidos_embarque_previsto` | `jma.f_pedido_embarque_previsto` | fato |
| `jma.fpedidos_url` | `jma.f_pedido_url` | fato |
| `jma.fportal_lojas` | `jma.f_portal_loja` | fato |
| `jma.fprioridade_beneficiamento_conge` | `jma.f_prioridade_beneficiamento_congelado` | fato |
| `jma.fprioridade_tecelagem_conge` | `jma.f_prioridade_tecelagem_congelado` | fato |
| `jma.fprod_marft` | `jma.f_producao_marft` | fato |
| `jma.freq_almoxarifado` | `jma.f_requisicao_almoxarifado` | fato |
| `jma.frequisicoes_compra` | `jma.f_requisicao_compra` | fato |
| `jma.froteiro` | `jma.f_roteiro` | fato/relacional |
| `jma.froteiro_em_producao` | `jma.f_roteiro_em_producao` | fato |
| `jma.ftabelapreco` | `jma.f_tabela_preco_item` | fato |
| `jma.ftempo_metodos` | `jma.f_tempo_metodo` | fato |
| `jma.ftitulos_receber` | `jma.f_titulo_receber` | fato |
| `jma.fvendas_url` | `jma.f_venda_url` | fato |
| `jma.ped_cong_motivo_bloqueio` | `jma.f_pedido_congelado_motivo_bloqueio` | fato/operacional |

---

## Detalhamento por Tabela

---

# DIMENSOES (d_*)

---

### Tabela: `jma.daparelho` → `jma.d_aparelho`

**Tipo:** Dimensao
**Descricao:** Catalogo de aparelhos/maquinas usados no processo produtivo. Tabela de lookup simples.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria (secao 5) |
| 2 | `pk_aparelho` | `varchar(6) NULL` | `cod_aparelho` | `varchar(6) NOT NULL` | Business key — renomear de `pk_` para `cod_` (secao 3.1) |
| 3 | `desc_aparelho` | `varchar(50) NULL` | `ds_aparelho` | `varchar(50)` | Prefixo `desc_` → `ds_` (secao 3.2) |
| 4 | `obs_aparelho` | `varchar(100) NULL` | `obs_aparelho` | `text` | Prefixo `obs_` correto; tipo expandido para `text` |
| 5 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao (secao 4) |
| 6 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `cod_aparelho varchar(6) UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_aparelho_cod ON jma.d_aparelho (cod_aparelho);
```
**Notas ETL:** Mapear `pk_aparelho` → `cod_aparelho`. `dthora_atualizacao` → `updated_at`.

---

### Tabela: `jma.dcanaldistribuicao` → `jma.d_canal_distribuicao` ⚠️ CONFLITO

**Tipo:** Dimensao
**Descricao:** Classifica canais de distribuicao (atacado, varejo, ecommerce, etc.).
**Sistema de origem:** Systextil/CIGAM

> ⚠️ **CONFLITO:** Esta tabela e funcionalmente equivalente a `live.d_canal_distribuicao`. Recomenda-se deprecar esta tabela e unificar em `live.d_canal_distribuicao`. Enquanto nao houver migracao, documentar aqui para referencia cruzada.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `id` | `int4 NULL` | `id_canal` | `smallint NOT NULL` | Codigo operacional — prefixo `id_` + tipo menor |
| 3 | `descricao` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | Prefixo `ds_` para descricao |
| 4 | `modalidade` | `varchar(50) NULL` | `ds_modalidade` | `varchar(50)` | Prefixo `ds_` adicionado |
| 5 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 6 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_canal smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_canal_distribuicao_id ON jma.d_canal_distribuicao (id_canal);
```
**Notas ETL:** Verificar equivalencia com `live.d_canal_distribuicao.id_canal`. Se identicos, remover esta tabela e criar view de compatibilidade.

---

### Tabela: `jma.dcentro_custo` → `jma.d_centro_custo`

**Tipo:** Dimensao
**Descricao:** Hierarquia de centros de custo para alocacao de despesas produtivas e administrativas.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cd_centro_custo` | `int4 NULL` | `id_centro_custo` | `integer NOT NULL` | Codigo operacional (id_); nao e entidade com dimensao propria |
| 3 | `desc_centro_custo` | `varchar(25) NULL` | `ds_centro_custo` | `varchar(25)` | Prefixo `desc_` → `ds_` |
| 4 | `cd_desc` | `varchar(70) NULL` | `ds_centro_custo_completo` | `varchar(70)` | Descricao longa — nome mais explicito |
| 5 | `cd_local_entrega` | `int4 NULL` | `id_local_entrega` | `integer` | `cd_` → `id_` para codigo operacional |
| 6 | `cd_tipo_mao_obra` | `int2 NULL` | `id_tipo_mao_obra` | `smallint` | `cd_` → `id_` |
| 7 | `cd_centro_custo_pai` | `int8 NULL` | `id_centro_custo_pai` | `integer` | Referencia hierarquica interna — `id_` |
| 8 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 9 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_centro_custo integer UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_centro_custo_id ON jma.d_centro_custo (id_centro_custo);
CREATE INDEX idx_d_centro_custo_pai ON jma.d_centro_custo (id_centro_custo_pai);
```
**Notas ETL:** `cd_centro_custo` → `id_centro_custo`; `cd_centro_custo_pai` → `id_centro_custo_pai`.

---

### Tabela: `jma.dcontas_estoque` → `jma.d_conta_estoque`

**Tipo:** Dimensao
**Descricao:** Catalogo de contas de estoque para classificacao contabil de itens. Liga produto a grupo contabil.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_conta_estoque` | `int2 NULL` | `id_conta_estoque` | `smallint NOT NULL` | `pk_` → `id_` (codigo operacional, nao entidade com dimensao propria) |
| 3 | `desc_conta_estoque` | `varchar(40) NULL` | `ds_conta_estoque` | `varchar(40)` | Prefixo `desc_` → `ds_` |
| 4 | `tipo_produto_sped` | `int2 NULL` | `id_tipo_produto_sped` | `smallint` | Codigo de categoria SPED — prefixo `id_` |
| 5 | `itens_estoque` | `int2 NULL` | `qt_itens_estoque` | `smallint` | Quantidade de itens — prefixo `qt_`; smallint adequado |
| 6 | `tipo_conta_estoque` | `int2 NULL` | `id_tipo_conta_estoque` | `smallint` | Codigo de tipo — prefixo `id_` |
| 7 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 8 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_conta_estoque smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_conta_estoque_id ON jma.d_conta_estoque (id_conta_estoque);
```
**Notas ETL:** `pk_conta_estoque` → `id_conta_estoque` (smallint).

---

### Tabela: `jma.ddeposito` → `jma.d_deposito`

**Tipo:** Dimensao
**Descricao:** Catalogo de depositos fisicos de estoque. Usado como join key em fatos de movimentacao.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `codigo_deposito` | `int2 NULL` | `cod_deposito` | `smallint NOT NULL` | Business key — join key universal (secao 11: `cod_deposito smallint`) |
| 3 | `descricao` | `varchar(30) NULL` | `ds_deposito` | `varchar(30)` | Prefixo `ds_` adicionado |
| 4 | `local_deposito` | `int2 NULL` | `id_local_deposito` | `smallint` | Codigo de localizacao — prefixo `id_` |
| 5 | `cod_desc_deposito` | `varchar(50) NULL` | `ds_deposito_completo` | `varchar(50)` | Descricao composta — `ds_` mais explicativo |
| 6 | `hora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 7 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `cod_deposito smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_deposito_cod ON jma.d_deposito (cod_deposito);
```
**Notas ETL:** `codigo_deposito` → `cod_deposito`. Verificar alinhamento com `comercial.d_deposito` se existir.

---

### Tabela: `jma.dfamilia_materiais` → `jma.d_familia_material`

**Tipo:** Dimensao
**Descricao:** Catalogo de familias de materiais para agrupamento em compras e controle de estoque.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_familia` | `int4 NULL` | `id_familia` | `integer NOT NULL` | `pk_` → `id_` (codigo operacional) |
| 3 | `desc_familia` | `varchar(25) NULL` | `ds_familia` | `varchar(25)` | Prefixo `desc_` → `ds_` |
| 4 | `desc_usuario_comprador` | `varchar(250) NULL` | `nm_comprador` | `varchar(100)` | Nome do comprador responsavel — `nm_`; truncado para 100 |
| 5 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 6 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_familia integer UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_familia_material_id ON jma.d_familia_material (id_familia);
```
**Notas ETL:** `pk_familia` → `id_familia`; truncar `desc_usuario_comprador` (250) para `nm_comprador` (100) — validar que nao ha dados com mais de 100 chars.

---

### Tabela: `jma.dfuncionariosinteg` → `jma.d_funcionario_integ`

**Tipo:** Dimensao (integracao externa — dados de funcionarios/vendedores de lojas)
**Descricao:** Catalogo de funcionarios integrado de sistemas de loja externos. Contem vendedores e seus vinculos com lojas via CNPJ.
**Sistema de origem:** Integradores de loja (CIGAM/URL)

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_vendedor` | `int4 NULL` | `cod_vendedor` | `integer NOT NULL` | Business key — manter nome `cod_vendedor` (join key universal) |
| 3 | `cpf_vendedor` | `varchar(20) NULL` | `cpf_vendedor` | `varchar(12)` | Formato CPF `XXXXXXXXX-ZZ` (secao 7.1); reduzir tamanho |
| 4 | `nome_vendedor` | `varchar(100) NULL` | `nm_vendedor` | `varchar(100)` | Prefixo `nome_` → `nm_` (secao 3.2) |
| 5 | `cargo` | `varchar(100) NULL` | `ds_cargo` | `varchar(100)` | Descricao de cargo — prefixo `ds_` |
| 6 | `loja` | `varchar(20) NULL` | `cod_loja` | `varchar(20)` | Identificador de loja — `cod_` para chave de join |
| 7 | `cnpj` | `varchar(40) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ da loja — formato `XXXXXXXX/YYYY-ZZ`; nome segue dimensao loja |
| 8 | `status` | `varchar(10) NULL` | `ds_status` | `varchar(10)` | Status textual — `ds_` |
| 9 | `data_admissao` | `timestamp NULL` | `dt_admissao` | `date` | Data sem hora — `dt_` + `date` |
| 10 | `data_demissao` | `timestamp NULL` | `dt_demissao` | `date` | Data sem hora — `dt_` + `date` |
| 11 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 12 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `cod_vendedor integer UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_funcionario_integ_cod ON jma.d_funcionario_integ (cod_vendedor);
CREATE INDEX idx_d_funcionario_integ_loja ON jma.d_funcionario_integ (cod_loja);
```
**Notas ETL:** Converter `data_admissao`/`data_demissao` de `timestamp` para `date`. Formatar CNPJ com `fn_formatar_cnpj_cpf`. CPF: `cpf_vendedor` deve seguir formato `XXXXXXXXX-ZZ`.

---

### Tabela: `jma.dgrupo_contas` → `jma.d_grupo_contas`

**Tipo:** Dimensao
**Descricao:** Catalogo de grupos de contas contabeis para classificacao financeira de pedidos de compra.
**Sistema de origem:** Systextil/financeiro

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_grupo_contas` | `int4 NULL` | `id_grupo_contas` | `integer NOT NULL` | `pk_` → `id_` (codigo operacional) |
| 3 | `tipo_grupo_contas` | `int2 NULL` | `id_tipo_grupo_contas` | `smallint` | Codigo de tipo — prefixo `id_` |
| 4 | `desc_grupo_contas` | `varchar(60) NULL` | `ds_grupo_contas` | `varchar(60)` | Prefixo `desc_` → `ds_` |
| 5 | `obs` | `varchar(300) NULL` | `obs_grupo_contas` | `text` | Observacao — nome mais explicito; `text` para tamanho livre |
| 6 | `observacao_grupo_contas` | `varchar(100) NULL` | `obs_complemento` | `varchar(100)` | Segunda observacao — consolidar com `obs_grupo_contas` se redundante |
| 7 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 8 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_grupo_contas integer UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_grupo_contas_id ON jma.d_grupo_contas (id_grupo_contas);
```
**Notas ETL:** Avaliar se `obs` e `observacao_grupo_contas` sao redundantes — consolidar se possivel.

---

### Tabela: `jma.dhistorico_contabil` → `jma.d_historico_contabil`

**Tipo:** Dimensao
**Descricao:** Catalogo de historicos contabeis com flags de comportamento para lancamentos financeiros (comissao, ACC, regime).
**Sistema de origem:** Systextil/modulo financeiro

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_historico` | `numeric(4) NULL` | `id_historico` | `smallint NOT NULL` | `pk_`/`numeric(4)` → `id_`/`smallint` |
| 3 | `desc_historico` | `text NULL` | `ds_historico` | `varchar(200)` | Prefixo `desc_` → `ds_`; limitar a 200 |
| 4 | `flag_considera_regime` | `text NULL` | `fl_considera_regime` | `boolean` | Flag → `boolean`; `text` ('S'/'N') → `TRUE`/`FALSE` |
| 5 | `sinal_titulo` | `numeric(1) NULL` | `nr_sinal_titulo` | `smallint` | Sinal +1/-1 — `nr_` para numero operacional |
| 6 | `sinal_diario` | `numeric(1) NULL` | `nr_sinal_diario` | `smallint` | Idem |
| 7 | `sinal_comissao` | `numeric(1) NULL` | `nr_sinal_comissao` | `smallint` | Idem |
| 8 | `flag_entrada_saida` | `text NULL` | `fl_entrada` | `boolean` | Flag entrada/saida → `boolean` (TRUE=entrada) |
| 9 | `tipo_historico` | `text NULL` | `ds_tipo_historico` | `varchar(50)` | Tipo textual — `ds_` |
| 10 | `flag_atualiza_comissao` | `numeric(1) NULL` | `fl_atualiza_comissao` | `boolean` | Flag → `boolean` |
| 11 | `flag_atualiza_acc` | `numeric(1) NULL` | `fl_atualiza_acc` | `boolean` | Flag → `boolean` |
| 12 | `inf_custo` | `numeric(1) NULL` | `fl_inf_custo` | `boolean` | Flag informacao de custo → `boolean` |
| 13 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 14 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_historico smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_historico_contabil_id ON jma.d_historico_contabil (id_historico);
```
**Notas ETL:** Converter flags `text` ('S'/'N', '1'/'0') para `boolean`. Converter `numeric(1)` de sinais para `smallint`.

---

### Tabela: `jma.dmotivo_bloqueio` → `jma.d_motivo_bloqueio`

**Tipo:** Dimensao
**Descricao:** Catalogo de motivos de bloqueio de pedidos com flag indicando se o bloqueio e ativo.
**Sistema de origem:** Systextil/comercial

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_bloqueio` | `numeric(3) NULL` | `id_motivo_bloqueio` | `smallint NOT NULL` | Codigo operacional — `id_`; `numeric(3)` → `smallint` |
| 3 | `descricao` | `varchar(200) NULL` | `ds_motivo_bloqueio` | `varchar(200)` | Prefixo `ds_` adicionado |
| 4 | `flag_bloqueio` | `numeric(1) NULL` | `fl_ativo` | `boolean` | Flag → `boolean`; nome padrao `fl_ativo` |
| 5 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 6 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_motivo_bloqueio smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_motivo_bloqueio_id ON jma.d_motivo_bloqueio (id_motivo_bloqueio);
```
**Notas ETL:** `cod_bloqueio numeric(3)` → `id_motivo_bloqueio smallint`; `flag_bloqueio` → `fl_ativo boolean`.

---

### Tabela: `jma.dmotivo_cancelamento` → `jma.d_motivo_cancelamento`

**Tipo:** Dimensao
**Descricao:** Catalogo de motivos de cancelamento de pedidos com tipo e agrupamento.
**Sistema de origem:** Systextil/comercial

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_canc_pedido` | `numeric(3) NULL` | `id_motivo_cancelamento` | `smallint NOT NULL` | Codigo operacional — `id_`; `numeric(3)` → `smallint` |
| 3 | `desc_canc_pedido` | `varchar(200) NULL` | `ds_motivo_cancelamento` | `varchar(200)` | Prefixo `desc_` → `ds_` |
| 4 | `tp_cancelamento` | `numeric(1) NULL` | `id_tipo_cancelamento` | `smallint` | Codigo de tipo — `id_` |
| 5 | `grupo_canc_ped` | `numeric(3) NULL` | `id_grupo_cancelamento` | `smallint` | Agrupamento — `id_` |
| 6 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria (tabela sem campo de atualizacao) |
| 7 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_motivo_cancelamento smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_motivo_cancelamento_id ON jma.d_motivo_cancelamento (id_motivo_cancelamento);
```
**Notas ETL:** Tabela sem campo de atualizacao na origem — `updated_at` com `DEFAULT current_timestamp`.

---

### Tabela: `jma.dnatureza_operacao` → `jma.d_natureza_operacao`

**Tipo:** Dimensao
**Descricao:** Catalogo de naturezas de operacao fiscal com classificacao por tipo de venda (venda, devolucao, franchising) e ranking de prioridade.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_natureza` | `int4 NULL` | `id_natureza` | `smallint NOT NULL` | `pk_` → `id_`; `int4` → `smallint` (valores <32k) |
| 3 | `venda` | `int2 NULL` | `fl_venda` | `boolean` | Flag — `boolean`; nome prefixado `fl_` |
| 4 | `devolucao` | `int2 NULL` | `fl_devolucao` | `boolean` | Flag — `boolean` |
| 5 | `ranking` | `int2 NULL` | `nr_ranking` | `smallint` | Numero sequencial — `nr_` |
| 6 | `franchising` | `int2 NULL` | `fl_franchising` | `boolean` | Flag — `boolean` |
| 7 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 8 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_natureza smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_natureza_operacao_id ON jma.d_natureza_operacao (id_natureza);
```
**Notas ETL:** Converter `int2` (0/1) para `boolean`. `pk_natureza int4` → `id_natureza smallint`.

---

### Tabela: `jma.dparadasmaquinas_marft` → `jma.d_parada_maquina_marft`

**Tipo:** Dimensao/Fato hibrido (catalogo de paradas com dados de ocorrencia)
**Descricao:** Registros de paradas de maquinas na unidade MARFT com motivo, duracao, celula e operador. Apesar do prefixo `d_`, o conteudo e transacional — considerar reclassificar para `f_`.
**Sistema de origem:** MARFT (sistema de producao)

> **Nota:** Esta tabela tem caracteristica de fato (cada linha e um evento com data/hora e metricas). Avaliar renomear para `jma.f_parada_maquina_marft`.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `"DATA"` | `timestamp NULL` | `dt_parada` | `date` | Data do evento — `dt_` + `date`; UPPER_CASE → snake_case |
| 3 | `hora_inicio` | `timestamp NULL` | `dth_inicio` | `timestamp` | Data+hora — `dth_` |
| 4 | `hora_fim` | `timestamp NULL` | `dth_fim` | `timestamp` | Data+hora — `dth_` |
| 5 | `minutos` | `int4 NULL` | `nr_minutos_parada` | `integer` | Duracao em minutos — `nr_` |
| 6 | `codigo_motivo` | `int2 NULL` | `id_motivo_parada` | `smallint` | Codigo de motivo — `id_` |
| 7 | `motivo` | `varchar(40) NULL` | `ds_motivo_parada` | `varchar(40)` | Descricao do motivo — `ds_` |
| 8 | `detalhes` | `varchar(150) NULL` | `obs_parada` | `text` | Detalhe livre — `obs_` |
| 9 | `codigo_celula` | `int4 NULL` | `id_celula` | `integer` | Celula produtiva — `id_` |
| 10 | `nome_celula` | `varchar(25) NULL` | `nm_celula` | `varchar(25)` | Nome da celula — `nm_` |
| 11 | `turno` | `int2 NULL` | `id_turno` | `smallint` | Turno produtivo — `id_` |
| 12 | `cod_operador` | `int4 NULL` | `id_operador` | `integer` | Codigo do operador — `id_` |
| 13 | `nome_operador` | `varchar(50) NULL` | `nm_operador` | `varchar(50)` | Nome — `nm_` |
| 14 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 15 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_d_parada_maquina_dt ON jma.d_parada_maquina_marft (dt_parada);
CREATE INDEX idx_d_parada_maquina_celula ON jma.d_parada_maquina_marft (id_celula);
```
**Notas ETL:** `"DATA"` (UPPER_CASE com aspas) → `dt_parada date`. Extrair apenas a data do `timestamp`.

---

### Tabela: `jma.dperiodo_producao` → `jma.d_periodo_producao`

**Tipo:** Dimensao
**Descricao:** Catalogo de periodos de producao com datas de inicio/fim, empresa, deposito e status. Usado como referencia temporal em fatos produtivos.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cd_periodo_producao` | `int4 NULL` | `nr_periodo_producao` | `integer NOT NULL` | Numero do periodo — `nr_` (secao 18 do glossario) |
| 3 | `pk_periodo_producao` | `varchar(85) NULL` | `cod_periodo_producao` | `varchar(85) NOT NULL` | Business key composta — `cod_` para join |
| 4 | `data_ini_periodo` | `timestamp NULL` | `dt_inicio_periodo` | `date` | Data sem hora — `dt_` + `date` |
| 5 | `data_fim_periodo` | `timestamp NULL` | `dt_fim_periodo` | `date` | Data sem hora — `dt_` + `date` |
| 6 | `dias_uteis` | `int4 NULL` | `qt_dias_uteis` | `smallint` | Quantidade — `qt_` |
| 7 | `cd_area_periodo` | `int2 NULL` | `id_area_periodo` | `smallint` | Codigo de area — `id_` |
| 8 | `desc_situacao_periodo` | `int2 NULL` | `id_situacao_periodo` | `smallint` | Codigo de situacao — `id_` (nome enganoso — e int, nao desc) |
| 9 | `cd_empresa` | `int4 NULL` | `id_empresa` | `smallint` | Codigo da empresa — `id_empresa` (secao 18) |
| 10 | `cd_deposito` | `int4 NULL` | `cod_deposito` | `smallint` | Join key deposito — `cod_deposito` (secao 11) |
| 11 | `data_ini_fatu` | `timestamp NULL` | `dt_inicio_faturamento` | `date` | Data de inicio do faturamento do periodo — `dt_` |
| 12 | `data_fim_fatu` | `timestamp NULL` | `dt_fim_faturamento` | `date` | Data de fim do faturamento — `dt_` |
| 13 | `descricao` | `varchar(20) NULL` | `ds_periodo` | `varchar(20)` | Descricao do periodo — `ds_` |
| 14 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 15 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `cod_periodo_producao varchar(85) UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_periodo_producao_cod ON jma.d_periodo_producao (cod_periodo_producao);
CREATE INDEX idx_d_periodo_producao_empresa ON jma.d_periodo_producao (id_empresa);
CREATE INDEX idx_d_periodo_producao_datas ON jma.d_periodo_producao (dt_inicio_periodo, dt_fim_periodo);
```
**Notas ETL:** `desc_situacao_periodo int2` — nome enganoso, e codigo numerico; renomear para `id_situacao_periodo`. Converter todas as datas de `timestamp` para `date`.

---

### Tabela: `jma.dprodutoproducao` → `jma.d_produto_producao` ⚠️ AVALIAR FUSAO

**Tipo:** Dimensao
**Descricao:** Catalogo completo de produtos do modulo de producao (Systextil). Contem referencia, cor, tamanho, colecao, familia e atributos fiscais.
**Sistema de origem:** Systextil

> ⚠️ **AVALIAR FUSAO:** Esta tabela tem sobreposicao com `live.d_produto`. A recomendacao e manter `jma.d_produto_producao` como staging/enriquecimento especifico de producao e consolidar atributos comuns em `live.d_produto`. Adicionar flag `fl_ativo_producao` para identificar itens exclusivos deste schema.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_produto` | `varchar(25) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key universal de produto (secao 6.1) |
| 3 | `pk_produto_cigam` | `varchar(14) NULL` | `cod_produto_cigam` | `varchar(14)` | Chave no CIGAM — `cod_` como business key alternativa |
| 4 | `cd_produto` | `varchar(16) NULL` | `cod_produto_legado` | `varchar(16)` | Codigo legado — manter para rastreabilidade |
| 5 | `cd_desc_prod` | `varchar(80) NULL` | `ds_produto_completo` | `varchar(80)` | Descricao completa — `ds_` |
| 6 | `nivel_estrutura` | `int2 NULL` | `id_nivel_estrutura` | `smallint` | Nivel hierarquico — `id_` |
| 7 | `desc_nivel_estrutura` | `varchar(30) NULL` | `ds_nivel_estrutura` | `varchar(30)` | Descricao do nivel — `ds_` |
| 8 | `cd_referencia` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | Parte do SKU (referencia) — `cod_` |
| 9 | `desc_produto` | `varchar(70) NULL` | `ds_produto` | `varchar(70)` | Descricao curta — `ds_` |
| 10 | `und_medida` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(2)` | Unidade — manter tamanho; prefixo `ds_` |
| 11 | `desc_unidade_medida` | `varchar(20) NULL` | `nm_unidade_medida` | `varchar(20)` | Nome completo da unidade — `nm_` |
| 12 | `nm_tamanho` | `varchar(15) NULL` | `ds_tamanho` | `varchar(15)` | Tamanho — `ds_` (parte do SKU) |
| 13 | `nm_cor` | `varchar(25) NULL` | `ds_cor` | `varchar(25)` | Cor — `ds_` (parte do SKU) |
| 14 | `cd_colecao` | `int2 NULL` | `id_colecao` | `smallint` | Codigo colecao — `id_` |
| 15 | `desc_colecao` | `varchar(30) NULL` | `ds_colecao` | `varchar(30)` | Descricao — `ds_` |
| 16 | `cod_linha` | `text NULL` | `id_linha` | `varchar(10)` | Codigo de linha — `id_`; `text` → `varchar(10)` |
| 17 | `linha_produto` | `varchar(40) NULL` | `ds_linha` | `varchar(40)` | Nome da linha — `ds_` |
| 18 | `cod_artigo` | `int2 NULL` | `id_artigo` | `smallint` | Codigo artigo — `id_` |
| 19 | `desc_artigo` | `varchar(30) NULL` | `ds_artigo` | `varchar(30)` | Descricao — `ds_` |
| 20 | `artigos_cotas` | `int2 NULL` | `id_artigo_cotas` | `smallint` | Codigo artigo de cotas — `id_` |
| 21 | `desc_artigo_cotas` | `varchar(30) NULL` | `ds_artigo_cotas` | `varchar(30)` | Descricao — `ds_` |
| 22 | `cd_desc_referencia` | `varchar(50) NULL` | `ds_referencia_completo` | `varchar(50)` | Descricao composta de referencia — `ds_` |
| 23 | `cod_desc_artigo` | `varchar(50) NULL` | `ds_artigo_completo` | `varchar(50)` | Descricao composta de artigo — `ds_` |
| 24 | `cod_agrupador` | `int2 NULL` | `id_agrupador` | `smallint` | Codigo agrupador — `id_` |
| 25 | `desc_agrupador` | `varchar(50) NULL` | `ds_agrupador` | `varchar(50)` | Descricao — `ds_` |
| 26 | `tipo_produto` | `varchar(15) NULL` | `ds_tipo_produto` | `varchar(15)` | Tipo textual — `ds_` |
| 27 | `marca` | `varchar(50) NULL` | `nm_marca` | `varchar(50)` | Nome da marca — `nm_` |
| 28 | `cd_conta_estoque` | `int2 NULL` | `id_conta_estoque` | `smallint` | FK convencional para `d_conta_estoque` — `id_` |
| 29 | `desc_conta_estoque` | `varchar(50) NULL` | `ds_conta_estoque` | `varchar(50)` | Descricao desnormalizada — manter para performance |
| 30 | `desc_produto_narrativa` | `varchar(90) NULL` | `obs_produto_narrativa` | `text` | Texto livre — `obs_` |
| 31 | `cd_cor` | `varchar(6) NULL` | `cod_cor` | `varchar(6)` | Parte do SKU — `cod_` |
| 32 | `cd_tamanho` | `varchar(5) NULL` | `cod_tamanho` | `varchar(5)` | Parte do SKU — `cod_` |
| 33 | `desc_narrativa` | `varchar(70) NULL` | `obs_narrativa` | `text` | Texto livre — `obs_` |
| 34 | `item_ativo` | `int2 NULL` | `fl_ativo` | `boolean` | Flag — `boolean` |
| 35 | `desc_referencia` | `varchar(40) NULL` | `ds_referencia` | `varchar(40)` | Descricao — `ds_` |
| 36 | `desc_segmento` | `varchar(60) NULL` | `ds_segmento` | `varchar(60)` | Segmento — `ds_` |
| 37 | `publico_alvo` | `varchar(60) NULL` | `ds_publico_alvo` | `varchar(60)` | Publico — `ds_` |
| 38 | `faixa_etaria` | `varchar(60) NULL` | `ds_faixa_etaria` | `varchar(60)` | Faixa etaria — `ds_` |
| 39 | `codigo_contabil` | `int4 NULL` | `id_codigo_contabil` | `integer` | Codigo contabil — `id_` |
| 40 | `classific_fiscal` | `varchar(15) NULL` | `ds_classif_fiscal` | `varchar(15)` | Classificacao fiscal (NCM) — `ds_` |
| 41 | `descr_class_fisc` | `varchar(40) NULL` | `ds_classif_fiscal_completo` | `varchar(40)` | Descricao longa da NCM — `ds_` |
| 42 | `serie_tamanho` | `int2 NULL` | `id_serie_tamanho` | `smallint` | Serie de tamanhos — `id_` |
| 43 | `desc_serie_tamanho` | `varchar(10) NULL` | `ds_serie_tamanho` | `varchar(10)` | Descricao — `ds_` |
| 44 | `obs_serie_tamanho` | `varchar(60) NULL` | `obs_serie_tamanho` | `text` | Observacao — `obs_` |
| 45 | `sub_colecao` | `varchar(20) NULL` | `ds_sub_colecao` | `varchar(20)` | Sub-colecao — `ds_` |
| 46 | `familia1` | `varchar(80) NULL` | `ds_familia_1` | `varchar(80)` | Familia de hierarquia — `ds_` |
| 47 | `familia2` | `varchar(80) NULL` | `ds_familia_2` | `varchar(80)` | Idem |
| 48 | `familia3` | `varchar(80) NULL` | `ds_familia_3` | `varchar(80)` | Idem |
| 49 | `familia4` | `varchar(80) NULL` | `ds_familia_4` | `varchar(80)` | Idem |
| 50 | `familia5` | `varchar(80) NULL` | `ds_familia_5` | `varchar(80)` | Idem |
| 51 | `alternativa_item` | `int8 NULL` | `nr_alternativa_item` | `integer` | Numero de alternativa — `nr_`; `int8` → `integer` |
| 52 | `preco_custo` | `numeric(18,3) NULL` | `vl_preco_custo` | `numeric(15,2)` | Valor monetario — `vl_`; precisao ajustada |
| 53 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 54 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `sku_produto varchar(30) UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_produto_producao_sku ON jma.d_produto_producao (sku_produto);
CREATE INDEX idx_d_produto_producao_referencia ON jma.d_produto_producao (cod_referencia);
CREATE INDEX idx_d_produto_producao_colecao ON jma.d_produto_producao (id_colecao);
```
**Notas ETL:** `pk_produto varchar(25)` → `sku_produto varchar(30)` (formato `nivel.ref.tam.cor`). Converter `item_ativo int2` → `fl_ativo boolean`.

---

### Tabela: `jma.dsituacao_venda` → `jma.d_situacao_venda`

**Tipo:** Dimensao
**Descricao:** Catalogo de situacoes de venda para classificacao de notas fiscais e pedidos.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `situacao_venda` | `numeric(2) NULL` | `id_situacao_venda` | `smallint NOT NULL` | Codigo operacional — `id_`; `numeric(2)` → `smallint` |
| 3 | `descricao_situacao` | `varchar(100) NULL` | `ds_situacao_venda` | `varchar(100)` | Descricao — `ds_` |
| 4 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 5 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_situacao_venda smallint UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_situacao_venda_id ON jma.d_situacao_venda (id_situacao_venda);
```
**Notas ETL:** `situacao_venda numeric(2)` → `id_situacao_venda smallint`.

---

### Tabela: `jma.dsituacaopedido` → `jma.d_situacao_pedido`

**Tipo:** Dimensao
**Descricao:** Catalogo de situacoes de pedido de venda. Sobreposicao parcial com `d_situacao_venda` — avaliar consolidacao.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_situacao_venda` | `varchar(2) NULL` | `id_situacao_pedido` | `smallint NOT NULL` | `varchar(2)` numerico → `smallint`; renomear para evitar confusao com `d_situacao_venda` |
| 3 | `desc_situacao_venda` | `varchar(70) NULL` | `ds_situacao_pedido` | `varchar(70)` | Descricao — `ds_` |
| 4 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 5 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_situacao_pedido smallint UNIQUE NOT NULL`
**Notas ETL:** Verificar se `cod_situacao_venda varchar(2)` contem apenas numeros; se sim, converter para `smallint`.

---

### Tabela: `jma.dstatus_pedido` → `jma.d_status_pedido`

**Tipo:** Dimensao
**Descricao:** Catalogo de status operacional de pedido (diferente de situacao de venda — status refere-se ao fluxo interno de expedicao/homologacao).
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `status_pedido` | `numeric(1) NULL` | `id_status_pedido` | `smallint NOT NULL` | Codigo operacional — `id_`; `numeric(1)` → `smallint` |
| 3 | `descricao_status_pedido` | `varchar(100) NULL` | `ds_status_pedido` | `varchar(100)` | Descricao — `ds_` |
| 4 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 5 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `id_status_pedido smallint UNIQUE NOT NULL`
**Notas ETL:** `status_pedido numeric(1)` → `id_status_pedido smallint`.

---

### Tabela: `jma.dtabelapreco` → `jma.d_tabela_preco`

**Tipo:** Dimensao
**Descricao:** Catalogo de tabelas de preco com vigencia, colecao e descricao para referencia em fatos de faturamento e pedidos.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `tabela_preco` | `int4 NULL` | `id_tabela_preco` | `integer NOT NULL` | Codigo operacional — `id_` |
| 3 | `tabela_preco_cod` | `varchar(11) NULL` | `cod_tabela_preco` | `varchar(11) NOT NULL` | Business key textual — `cod_` para join |
| 4 | `col_tabela_preco` | `int2 NULL` | `id_colecao_tabela` | `smallint` | Codigo de colecao associada — `id_` |
| 5 | `mes_tabela_preco` | `int2 NULL` | `nr_mes` | `smallint` | Numero do mes — `nr_` |
| 6 | `seq_tabela_preco` | `int2 NULL` | `nr_seq_tabela` | `smallint` | Sequencial — `nr_` |
| 7 | `data_inicio_tabela` | `timestamp NULL` | `dt_inicio_vigencia` | `date` | Data de vigencia — `dt_` + `date` |
| 8 | `data_fim_tabela` | `timestamp NULL` | `dt_fim_vigencia` | `date` | Data de vigencia — `dt_` + `date` |
| 9 | `descricao` | `varchar(20) NULL` | `ds_tabela_preco` | `varchar(20)` | Descricao curta — `ds_` |
| 10 | `cod_desc_tabela_preco` | `varchar(34) NULL` | `ds_tabela_preco_completo` | `varchar(34)` | Codigo + descricao — `ds_` |
| 11 | `desc_catalogo` | `varchar(40) NULL` | `ds_catalogo` | `varchar(40)` | Descricao do catalogo — `ds_` |
| 12 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 13 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `cod_tabela_preco varchar(11) UNIQUE NOT NULL`
**Indices sugeridos:**
```sql
CREATE UNIQUE INDEX uq_d_tabela_preco_cod ON jma.d_tabela_preco (cod_tabela_preco);
CREATE INDEX idx_d_tabela_preco_vigencia ON jma.d_tabela_preco (dt_inicio_vigencia, dt_fim_vigencia);
```
**Notas ETL:** Converter `data_inicio_tabela`/`data_fim_tabela` de `timestamp` para `date`.

---

# FATOS E TABELAS OPERACIONAIS (f_* / aux_* / stg_*)

---

### Tabela: `jma.confer_caixas` → `jma.aux_conferencia_caixa`

**Tipo:** Auxiliar (sem prefixo na origem — candidato a remocao ou fusao)
**Descricao:** Resumo de conferencia de caixas de transferencia. Estrutura similar a `jma.fconfer_caixas` — avaliar consolidacao.
**Sistema de origem:** Sistema de expedicao/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `codigo_transferencia` | `varchar(18) NULL` | `cod_transferencia` | `varchar(18) NOT NULL` | Business key — `cod_` |
| 3 | `numero_caixa` | `int4 NULL` | `nr_caixa` | `integer NOT NULL` | Numero do volume — `nr_` |
| 4 | `data_abertura` | `varchar(6) NULL` | `dt_abertura` | `date` | Data como string `varchar(6)` → `date` |
| 5 | `qtde_pecas_conferidas` | `int4 NULL` | `qt_pecas_conferidas` | `integer` | Quantidade — `qt_` |
| 6 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 7 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Notas ETL:** `data_abertura varchar(6)` provavelmente formato `AAAAMM` — converter para `date` (primeiro dia do mes). Avaliar consolidacao com `jma.fconfer_caixas`.

---

### Tabela: `jma.fconfer_caixas` → `jma.f_conferencia_caixa`

**Tipo:** Fato
**Descricao:** Conferencia de volumes/caixas de transferencia entre depositos. Registra quantidades conferidas por caixa e data.
**Sistema de origem:** Sistema de expedicao/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `codigo_transferencia` | `varchar(18) NULL` | `cod_transferencia` | `varchar(18) NOT NULL` | Chave da transferencia — `cod_` |
| 3 | `numero_caixa` | `int4 NULL` | `nr_caixa` | `integer NOT NULL` | Numero do volume — `nr_` |
| 4 | `data_abertura` | `timestamp NULL` | `dth_abertura` | `timestamp` | Data+hora — `dth_` |
| 5 | `qtde_pecas_conferidas` | `int4 NULL` | `qt_pecas_conferidas` | `integer` | Quantidade — `qt_` |
| 6 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 7 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_conferencia_caixa_transf ON jma.f_conferencia_caixa (cod_transferencia);
CREATE INDEX idx_f_conferencia_caixa_data ON jma.f_conferencia_caixa (dth_abertura);
```
**Notas ETL:** Verificar duplicidade com `jma.confer_caixas`.

---

### Tabela: `jma.fconfer_pecas_caixa` → `jma.f_conferencia_peca_caixa`

**Tipo:** Fato
**Descricao:** Detalhamento de pecas conferidas por caixa/volume com codigo de barras, situacao e data de bipagem.
**Sistema de origem:** Sistema de expedicao/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `tipo` | `varchar(13) NULL` | `ds_tipo` | `varchar(13)` | Tipo textual — `ds_` |
| 3 | `codigo_transferencia` | `varchar(18) NULL` | `cod_transferencia` | `varchar(18) NOT NULL` | Chave da transferencia — `cod_` |
| 4 | `numero_caixa` | `int4 NULL` | `nr_caixa` | `integer NOT NULL` | Numero do volume — `nr_` |
| 5 | `codigo_barras` | `varchar(16) NULL` | `cod_barras` | `varchar(16)` | Codigo de barras — `cod_` |
| 6 | `produto` | `varchar(65) NULL` | `sku_produto` | `varchar(30)` | Join key de produto — `sku_produto`; truncar com validacao |
| 7 | `data_bipagem` | `timestamp NULL` | `dth_bipagem` | `timestamp` | Data+hora — `dth_` |
| 8 | `data_bipagem_recebido` | `timestamp NULL` | `dth_bipagem_recebido` | `timestamp` | Data+hora — `dth_` |
| 9 | `situacao` | `varchar(8) NULL` | `ds_situacao` | `varchar(8)` | Situacao — `ds_` |
| 10 | `sku` | `varchar(80) NULL` | `ds_sku_descricao` | `varchar(80)` | Descricao do SKU — `ds_`; `sku` e nome ambiguo |
| 11 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 12 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_conf_peca_transf ON jma.f_conferencia_peca_caixa (cod_transferencia, nr_caixa);
CREATE INDEX idx_f_conf_peca_sku ON jma.f_conferencia_peca_caixa (sku_produto);
```
**Notas ETL:** `produto varchar(65)` → `sku_produto varchar(30)` — validar formato (nivel.ref.tam.cor). Campo `sku` original e diferente — manter como `ds_sku_descricao`.

---

### Tabela: `jma.fconsignadainteg` → `jma.f_consignado_integ`

**Tipo:** Fato
**Descricao:** Movimentacoes de consignado integradas de lojas. Registra retiradas e devolucoes de produtos em consignacao com valores e percentuais de desconto.
**Sistema de origem:** Integracao de lojas (CIGAM/URL)

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_consignado` | `varchar(55) NULL` | `cod_consignado` | `varchar(55) NOT NULL` | Business key composta — `cod_` |
| 3 | `cd_loja` | `varchar(6) NULL` | `cod_loja` | `varchar(6)` | Join key loja — `cod_` |
| 4 | `cd_contr` | `int4 NULL` | `nr_contrato` | `integer` | Numero do contrato de consignacao — `nr_` |
| 5 | `fk_produto` | `varchar(20) NULL` | `sku_produto` | `varchar(30)` | Join key de produto — `sku_produto` |
| 6 | `dt_retirada` | `timestamp NULL` | `dth_retirada` | `timestamp` | Data+hora — `dth_` |
| 7 | `dt_devol` | `timestamp NULL` | `dth_devolucao` | `timestamp` | Data+hora — `dth_` |
| 8 | `dt_prev` | `timestamp NULL` | `dth_previsao` | `timestamp` | Data+hora prevista — `dth_` |
| 9 | `cd_status_devol` | `varchar(8) NULL` | `ds_status_devolucao` | `varchar(8)` | Status textual — `ds_` |
| 10 | `qtd_consignada` | `int4 NULL` | `qt_consignada` | `integer` | Quantidade — `qt_` |
| 11 | `vlr_preco_venda` | `numeric(20,4) NULL` | `vl_preco_venda` | `numeric(15,2)` | Valor monetario — `vl_`; precisao ajustada |
| 12 | `vlr_perc_desconto` | `numeric(20,4) NULL` | `pc_desconto` | `numeric(7,4)` | Percentual — `pc_`; tipo correto |
| 13 | `vlr_total` | `numeric(20,4) NULL` | `vl_total` | `numeric(15,2)` | Valor total — `vl_` |
| 14 | `cd_vendido` | `varchar(8) NULL` | `ds_status_venda` | `varchar(8)` | Indicador se foi vendido — `ds_` |
| 15 | `cd_vendedor` | `varchar(4) NULL` | `cod_vendedor` | `varchar(4)` | Join key vendedor — `cod_` |
| 16 | `cd_loja_vendedor` | `varchar(4) NULL` | `cod_loja_vendedor` | `varchar(4)` | Loja do vendedor — `cod_` |
| 17 | `ds_cargo_vendedor` | `varchar(100) NULL` | `ds_cargo_vendedor` | `varchar(100)` | Ja esta no padrao `ds_` |
| 18 | `status_vendedor` | `varchar(10) NULL` | `ds_status_vendedor` | `varchar(10)` | Status — `ds_` |
| 19 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 20 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**BK/joins:** `cod_consignado varchar(55)`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_consignado_loja ON jma.f_consignado_integ (cod_loja);
CREATE INDEX idx_f_consignado_produto ON jma.f_consignado_integ (sku_produto);
CREATE INDEX idx_f_consignado_retirada ON jma.f_consignado_integ (dth_retirada);
```

---

### Tabela: `jma.fcontrole_partes` → `jma.f_controle_parte`

**Tipo:** Fato/Operacional
**Descricao:** Controle de partes e componentes de pecas para corte e confeccao. Dados de engenharia de produto — estrutura de corte.
**Sistema de origem:** Systextil/modulo de corte

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `referencia` | `varchar(111) NULL` | `sku_produto` | `varchar(30)` | Join key de produto (referencia + componentes) |
| 3 | `componente` | `varchar(111) NULL` | `sku_componente` | `varchar(30)` | SKU do componente — `sku_` |
| 4 | `descricao_parte` | `varchar(30) NULL` | `ds_parte` | `varchar(30)` | Descricao — `ds_` |
| 5 | `parte_conjunto` | `int2 NULL` | `nr_parte_conjunto` | `smallint` | Numero da parte — `nr_` |
| 6 | `qtde_parte_peca` | `int2 NULL` | `qt_parte_peca` | `smallint` | Quantidade — `qt_` |
| 7 | `tipo_corte_peca` | `int2 NULL` | `id_tipo_corte` | `smallint` | Tipo de corte — `id_` |
| 8 | `tipo_enfesto_1` | `int2 NULL` | `id_tipo_enfesto_1` | `smallint` | Tipo de enfesto — `id_` |
| 9 | `tipo_enfesto_2` | `int2 NULL` | `id_tipo_enfesto_2` | `smallint` | Idem |
| 10 | `alternativa_item` | `int2 NULL` | `nr_alternativa_item` | `smallint` | Numero de alternativa — `nr_` |
| 11 | `sequencia` | `int2 NULL` | `nr_sequencia` | `smallint` | Sequencial — `nr_` |
| 12 | `alternativa_comp` | `int2 NULL` | `nr_alternativa_comp` | `smallint` | Alternativa de componente — `nr_` |
| 13 | `estagio` | `int4 NULL` | `id_estagio` | `smallint` | Estagio produtivo — `id_` |
| 14 | `qtde_camadas` | `int4 NULL` | `qt_camadas` | `integer` | Quantidade de camadas — `qt_` |
| 15 | `centro_custo` | `int4 NULL` | `id_centro_custo` | `integer` | Centro de custo — `id_` |
| 16 | `inf_casado` | `int2 NULL` | `fl_casado` | `boolean` | Flag — `boolean` |
| 17 | `grupo_estrutura` | `varchar(5) NULL` | `ds_grupo_estrutura` | `varchar(5)` | Grupo — `ds_` |
| 18 | `inf_sentido` | `int2 NULL` | `fl_sentido` | `boolean` | Flag — `boolean` |
| 19 | `inf_casado_1` | `int2 NULL` | `fl_casado_1` | `boolean` | Flag — `boolean` |
| 20 | `inf_desenho` | `int2 NULL` | `fl_desenho` | `boolean` | Flag — `boolean` |
| 21 | `comprimento_debrum` | `numeric(10,2) NULL` | `vl_comprimento_debrum` | `numeric(10,2)` | Medida — `vl_` (fisico/linear) |
| 22 | `largura_debrum` | `numeric(11,3) NULL` | `vl_largura_debrum` | `numeric(11,3)` | Medida — `vl_` |
| 23 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 24 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_controle_parte_produto ON jma.f_controle_parte (sku_produto);
```
**Notas ETL:** Tabela sem campo de atualizacao — adicionar `created_at`/`updated_at` com `DEFAULT current_timestamp`.

---

### Tabela: `jma.fdre_lojas` → `jma.f_dre_loja`

**Tipo:** Fato
**Descricao:** DRE (Demonstrativo de Resultado) realizado e orcado por loja, com comparativo ano anterior e variacao percentual.
**Sistema de origem:** Financeiro/BI lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key — renomear pois `id` ja existe como campo de origem |
| 2 | `id` | `int4 NULL` | `nr_seq` | `integer` | Sequencial da origem — `nr_`; nao e PK do DW |
| 3 | `cnpj_loja` | `varchar(18) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ da loja — formato `XXXXXXXX/YYYY-ZZ`; reduzir para 16 |
| 4 | `apelido` | `varchar(200) NULL` | `nm_loja` | `varchar(100)` | Nome/apelido — `nm_`; truncar para 100 |
| 5 | `ano_dre` | `int2 NULL` | `nr_ano` | `smallint NOT NULL` | Ano do DRE — `nr_` |
| 6 | `mes_dre` | `int2 NULL` | `nr_mes` | `smallint NOT NULL` | Mes do DRE — `nr_` |
| 7 | `tipo_dre` | `int2 NULL` | `id_tipo_dre` | `smallint` | Tipo do DRE — `id_` |
| 8 | `propriedade` | `varchar(150) NULL` | `ds_propriedade` | `varchar(150)` | Propriedade/conta do DRE — `ds_` |
| 9 | `val_real_ano_ant` | `numeric(18,3) NULL` | `vl_real_ano_anterior` | `numeric(15,2)` | Valor realizado ano anterior — `vl_` |
| 10 | `perc_real_ano_ant` | `numeric(18,3) NULL` | `pc_real_ano_anterior` | `numeric(7,4)` | Percentual — `pc_` |
| 11 | `val_orcado` | `numeric(18,3) NULL` | `vl_orcado` | `numeric(15,2)` | Valor orcado — `vl_` |
| 12 | `perc_orcado` | `numeric(18,3) NULL` | `pc_orcado` | `numeric(7,4)` | Percentual — `pc_` |
| 13 | `val_real` | `numeric(18,3) NULL` | `vl_real` | `numeric(15,2)` | Valor realizado — `vl_` |
| 14 | `perc_real` | `numeric(18,3) NULL` | `pc_real` | `numeric(7,4)` | Percentual — `pc_` |
| 15 | `val_diferenca_orcado_real` | `numeric(18,3) NULL` | `vl_diferenca_orcado_real` | `numeric(15,2)` | Diferenca orcado vs real — `vl_` |
| 16 | `perc_diferenca_orcado_real` | `numeric(18,3) NULL` | `pc_diferenca_orcado_real` | `numeric(7,4)` | Percentual — `pc_` |
| 17 | `perc_diferenca_real_vig_ant` | `numeric(18,3) NULL` | `pc_diferenca_real_vig_anterior` | `numeric(7,4)` | Variacao real vs ano anterior — `pc_` |
| 18 | `seq_consulta` | `varchar(20) NULL` | `ds_seq_consulta` | `varchar(20)` | Chave de consulta — `ds_` |
| 19 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 20 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_dre_loja_cnpj ON jma.f_dre_loja (cnpj_loja);
CREATE INDEX idx_f_dre_loja_ano_mes ON jma.f_dre_loja (nr_ano, nr_mes);
```
**Notas ETL:** Renomear `id` da origem para `nr_seq` (nao e PK do DW). CNPJ: formatar com `fn_formatar_cnpj_cpf`.

---

### Tabela: `jma.fdre_orcado_lojas` → `jma.f_dre_orcado_loja`

**Tipo:** Fato
**Descricao:** Orcamento do DRE por loja e mes. Complementar a `f_dre_loja`.
**Sistema de origem:** Financeiro/BI lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `id` | `int4 NULL` | `nr_seq` | `integer` | Sequencial origem — `nr_` |
| 3 | `seq_consulta` | `varchar(50) NULL` | `ds_seq_consulta` | `varchar(50)` | Chave de consulta — `ds_` |
| 4 | `cnpj_loja` | `varchar(18) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ loja — formato padrao |
| 5 | `apelido` | `varchar(200) NULL` | `nm_loja` | `varchar(100)` | Nome — `nm_`; truncar para 100 |
| 6 | `ano_orcamento` | `int2 NULL` | `nr_ano` | `smallint NOT NULL` | Ano — `nr_` |
| 7 | `mes_orcamento` | `int2 NULL` | `nr_mes` | `smallint NOT NULL` | Mes — `nr_` |
| 8 | `propriedade` | `varchar(150) NULL` | `ds_propriedade` | `varchar(150)` | Conta do DRE — `ds_` |
| 9 | `tipo_orcamento` | `int2 NULL` | `id_tipo_orcamento` | `smallint` | Tipo — `id_` |
| 10 | `valor_orcado` | `numeric(15,3) NULL` | `vl_orcado` | `numeric(15,2)` | Valor orcado — `vl_` |
| 11 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 12 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_dre_orcado_loja_cnpj ON jma.f_dre_orcado_loja (cnpj_loja, nr_ano, nr_mes);
```

---

### Tabela: `jma.feficiencia_prod_marft` → `jma.f_eficiencia_prod_marft`

**Tipo:** Fato
**Descricao:** Eficiencia de producao por maquina e turno na unidade MARFT. Metricas de minutos trabalhados, produzidos e percentual de eficiencia.
**Sistema de origem:** MARFT

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `"DATA"` | `timestamp NULL` | `dt_producao` | `date` | Data — `dt_` + `date`; UPPER_CASE → snake_case |
| 3 | `maquina` | `varchar(25) NULL` | `ds_maquina` | `varchar(25)` | Identificador textual da maquina — `ds_` |
| 4 | `turno` | `int2 NULL` | `id_turno` | `smallint` | Turno — `id_` |
| 5 | `min_dispo` | `int4 NULL` | `nr_min_disponiveis` | `integer` | Minutos disponiveis — `nr_` |
| 6 | `operador` | `int2 NULL` | `qt_operadores` | `smallint` | Quantidade de operadores — `qt_` |
| 7 | `capacidade` | `numeric(18,3) NULL` | `vl_capacidade` | `numeric(15,3)` | Capacidade em minutos — `vl_` |
| 8 | `capacidade_ajustada` | `numeric(18,3) NULL` | `vl_capacidade_ajustada` | `numeric(15,3)` | Capacidade ajustada — `vl_` |
| 9 | `minutos_trabalhado` | `numeric(18,3) NULL` | `nr_min_trabalhados` | `numeric(15,3)` | Minutos — `nr_` |
| 10 | `minutos_produzido` | `numeric(18,3) NULL` | `nr_min_produzidos` | `numeric(15,3)` | Minutos — `nr_` |
| 11 | `eficiencia` | `numeric(18,3) NULL` | `vl_eficiencia` | `numeric(15,3)` | Eficiencia absoluta — `vl_` |
| 12 | `perc_eficiencia` | `numeric(18,3) NULL` | `pc_eficiencia` | `numeric(7,4)` | Percentual — `pc_` |
| 13 | `pecas_produzidas` | `numeric(18,3) NULL` | `qt_pecas_produzidas` | `numeric(15,3)` | Quantidade — `qt_` |
| 14 | `minutos_parados` | `numeric(18,3) NULL` | `nr_min_parados` | `numeric(15,3)` | Minutos — `nr_` |
| 15 | `minutos_perdidos` | `numeric(18,3) NULL` | `nr_min_perdidos` | `numeric(15,3)` | Minutos — `nr_` |
| 16 | `real_eficiencia` | `numeric(18,3) NULL` | `vl_eficiencia_real` | `numeric(15,3)` | Eficiencia real — `vl_` |
| 17 | `perc_real_efic` | `numeric(18,3) NULL` | `pc_eficiencia_real` | `numeric(7,4)` | Percentual — `pc_` |
| 18 | `perd_eficiencia` | `numeric(18,3) NULL` | `vl_perda_eficiencia` | `numeric(15,3)` | Perda — `vl_` |
| 19 | `perc_perd_efic` | `numeric(18,3) NULL` | `pc_perda_eficiencia` | `numeric(7,4)` | Percentual — `pc_` |
| 20 | `parada` | `numeric(18,3) NULL` | `nr_min_parada` | `numeric(15,3)` | Minutos parada — `nr_` |
| 21 | `perc_parada` | `numeric(18,3) NULL` | `pc_parada` | `numeric(7,4)` | Percentual — `pc_` |
| 22 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 23 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_efic_prod_marft_data ON jma.f_eficiencia_prod_marft (dt_producao);
CREATE INDEX idx_f_efic_prod_marft_maquina ON jma.f_eficiencia_prod_marft (ds_maquina);
```
**Notas ETL:** `"DATA"` (UPPER_CASE) → `dt_producao date`.

---

### Tabela: `jma.feficiencia_prod_operador_marft` → `jma.f_eficiencia_prod_operador_marft`

**Tipo:** Fato
**Descricao:** Eficiencia de producao por operador e maquina na unidade MARFT. Granularidade mais fina que `f_eficiencia_prod_marft`.
**Sistema de origem:** MARFT

> **Nota:** Colunas com `numeric(38,10)` indicam origem Oracle sem tratamento — devem ser convertidas para `numeric(7,4)` (percentuais) ou `numeric(15,3)` (quantidades).

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `"data"` | `timestamp NULL` | `dt_producao` | `date` | Data — `dt_` + `date` |
| 3 | `maquina` | `text NULL` | `ds_maquina` | `varchar(25)` | Maquina — `ds_`; `text` → `varchar(25)` |
| 4 | `turno` | `numeric(3) NULL` | `id_turno` | `smallint` | Turno — `id_` |
| 5 | `min_dispo` | `numeric(5) NULL` | `nr_min_disponiveis` | `integer` | Minutos disponiveis — `nr_` |
| 6 | `operador` | `numeric(3) NULL` | `qt_operadores` | `smallint` | Quantidade operadores — `qt_` |
| 7 | `codigo_operador` | `numeric(5) NULL` | `id_operador` | `integer` | Codigo operador — `id_` |
| 8 | `nome_operador` | `text NULL` | `nm_operador` | `varchar(100)` | Nome — `nm_` |
| 9 | `capacidade` | `numeric(10) NULL` | `vl_capacidade` | `numeric(15,3)` | Capacidade — `vl_` |
| 10 | `minutos_trabalhado` | `numeric(10) NULL` | `nr_min_trabalhados` | `numeric(15,3)` | Minutos — `nr_` |
| 11 | `minutos_produzido` | `numeric(8,2) NULL` | `nr_min_produzidos` | `numeric(15,3)` | Minutos — `nr_` |
| 12 | `eficiencia` | `numeric(6,4) NULL` | `vl_eficiencia` | `numeric(15,3)` | Eficiencia — `vl_` |
| 13 | `perc_eficiencia` | `numeric(38,10) NULL` | `pc_eficiencia` | `numeric(7,4)` | `numeric(38,10)` → `numeric(7,4)` |
| 14 | `pecas_produzidas` | `numeric(10) NULL` | `qt_pecas_produzidas` | `numeric(15,3)` | Quantidade — `qt_` |
| 15 | `minutos_parados` | `numeric(10) NULL` | `nr_min_parados` | `numeric(15,3)` | Minutos — `nr_` |
| 16 | `minutos_perdidos` | `numeric(10) NULL` | `nr_min_perdidos` | `numeric(15,3)` | Minutos — `nr_` |
| 17 | `real_eficiencia` | `numeric(6,4) NULL` | `vl_eficiencia_real` | `numeric(15,3)` | Eficiencia real — `vl_` |
| 18 | `perc_real_efic` | `numeric(38,10) NULL` | `pc_eficiencia_real` | `numeric(7,4)` | `numeric(38,10)` → `numeric(7,4)` |
| 19 | `perd_eficiencia` | `numeric(6,4) NULL` | `vl_perda_eficiencia` | `numeric(15,3)` | Perda — `vl_` |
| 20 | `perc_perd_efic` | `numeric(38,10) NULL` | `pc_perda_eficiencia` | `numeric(7,4)` | `numeric(38,10)` → `numeric(7,4)` |
| 21 | `parada` | `numeric(5,4) NULL` | `nr_min_parada` | `numeric(15,3)` | Minutos parada — `nr_` |
| 22 | `perc_parada` | `numeric(38,10) NULL` | `pc_parada` | `numeric(7,4)` | `numeric(38,10)` → `numeric(7,4)` |
| 23 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 24 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_efic_oper_marft_data ON jma.f_eficiencia_prod_operador_marft (dt_producao);
CREATE INDEX idx_f_efic_oper_marft_operador ON jma.f_eficiencia_prod_operador_marft (id_operador);
```
**Notas ETL:** Converter todos os `numeric(38,10)` — percentuais para `numeric(7,4)`, quantidades para `numeric(15,3)`.

---

### Tabela: `jma.festrutura_produto` → `jma.f_estrutura_produto`

**Tipo:** Fato/Relacional
**Descricao:** Estrutura de componentes de produto (BOM — Bill of Materials). Associa produto pai a componentes com consumo e estagio produtivo.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto pai — `sku_produto` |
| 3 | `cod_referencia` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | Referencia do produto — `cod_` |
| 4 | `cod_componente` | `varchar(18) NULL` | `sku_componente` | `varchar(30)` | SKU do componente — `sku_` (pode ser tecido ou insumo) |
| 5 | `fk_sequencia` | `int4 NULL` | `nr_sequencia` | `integer` | Sequencial — `nr_`; remover prefixo `fk_` |
| 6 | `fk_estagio` | `int4 NULL` | `id_estagio` | `smallint` | Estagio produtivo — `id_`; remover `fk_` |
| 7 | `consumo` | `numeric(18,3) NULL` | `qt_consumo` | `numeric(15,3)` | Consumo do componente — `qt_` |
| 8 | `qtd_camadas` | `numeric(18,3) NULL` | `qt_camadas` | `numeric(15,3)` | Quantidade de camadas — `qt_` |
| 9 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_estrutura_produto_sku ON jma.f_estrutura_produto (sku_produto);
CREATE INDEX idx_f_estrutura_produto_comp ON jma.f_estrutura_produto (sku_componente);
```
**Notas ETL:** `pk_produto varchar(18)` → `sku_produto varchar(30)`. Remover prefixos `fk_` das colunas.

---

### Tabela: `jma.ffaixas_comissao` → `jma.f_faixa_comissao`

**Tipo:** Fato
**Descricao:** Faixas de comissao por loja, cargo e faixa de desempenho com percentuais de inicio e fim.
**Sistema de origem:** RH/comercial lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `tipo_info` | `varchar(23) NULL` | `ds_tipo_info` | `varchar(23)` | Tipo de informacao — `ds_` |
| 3 | `cod_loja` | `float8 NULL` | `cod_loja` | `varchar(10)` | Codigo de loja — `cod_`; `float8` → `varchar(10)` (dados textuais) |
| 4 | `cargo` | `float8 NULL` | `id_cargo` | `smallint` | Codigo de cargo — `id_`; `float8` → `smallint` |
| 5 | `faixa` | `float8 NULL` | `nr_faixa` | `smallint` | Numero da faixa — `nr_` |
| 6 | `valor_inicio` | `numeric(18,3) NULL` | `vl_inicio_faixa` | `numeric(15,2)` | Valor de inicio — `vl_` |
| 7 | `valor_fim` | `numeric(18,3) NULL` | `vl_fim_faixa` | `numeric(15,2)` | Valor de fim — `vl_` |
| 8 | `percentual_inicio` | `numeric(18,3) NULL` | `pc_inicio` | `numeric(7,4)` | Percentual — `pc_` |
| 9 | `percentual_fim` | `numeric(18,3) NULL` | `pc_fim` | `numeric(7,4)` | Percentual — `pc_` |
| 10 | `comissao` | `numeric(18,3) NULL` | `pc_comissao` | `numeric(7,4)` | Percentual de comissao — `pc_` |
| 11 | `ultima_atualizao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao (erro tipografico corrigido) |
| 12 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_faixa_comissao_loja ON jma.f_faixa_comissao (cod_loja);
```
**Notas ETL:** `float8` para `cod_loja` e `cargo` — converter com cuidado (verificar se sao decimais ou inteiros).

---

### Tabela: `jma.ffaixas_comissao_omnichannel` → `jma.f_faixa_comissao_omnichannel`

**Tipo:** Fato
**Descricao:** Faixas de comissao para o canal omnichannel com tempo medio e valores de atingimento.
**Sistema de origem:** Comercial lojas/omnichannel

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_loja` | `int4 NULL` | `cod_loja` | `varchar(10)` | Codigo de loja — `cod_`; harmonizar tipo com `f_faixa_comissao` |
| 3 | `faixa` | `int2 NULL` | `nr_faixa` | `smallint` | Numero da faixa — `nr_` |
| 4 | `comissao` | `numeric(18,3) NULL` | `pc_comissao` | `numeric(7,4)` | Percentual de comissao — `pc_` |
| 5 | `tempo_medio` | `int2 NULL` | `nr_tempo_medio` | `smallint` | Tempo medio em dias — `nr_` |
| 6 | `valor_atingido` | `numeric(18,3) NULL` | `vl_atingido` | `numeric(15,2)` | Valor atingido — `vl_` |
| 7 | `valor_nao_atingido` | `numeric(18,3) NULL` | `vl_nao_atingido` | `numeric(15,2)` | Valor nao atingido — `vl_` |
| 8 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 9 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_faixa_comissao_omni_loja ON jma.f_faixa_comissao_omnichannel (cod_loja);
```

---

### Tabela: `jma.ffaturamento` → `jma.f_faturamento` ⭐ TABELA PRINCIPAL

**Tipo:** Fato Principal
**Descricao:** Fato de faturamento (notas fiscais de saida) do canal atacado/representantes. Cada linha e um item de nota fiscal com valores, impostos, quantidades e referencias de cliente, produto, representante e loja.
**Sistema de origem:** Systextil — modulo fiscal/faturamento

> **Importante:** Esta e a tabela de fato principal de faturamento do schema `jma`. Contem dados de NF emitidas com linha por item. Relaciona-se com `d_produto_producao` (via `pk_produto`/`sku_produto`), `d_canal_distribuicao`, `d_deposito`.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_cliente` | `varchar(18) NULL` | `cod_cliente` | `varchar(20) NOT NULL` | Join key cliente — `cod_cliente`; ampliar para 20 (secao 11) |
| 3 | `pk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` (secao 6.1) |
| 4 | `pk_loja` | `varchar(25) NULL` | `cod_loja` | `varchar(25)` | Codigo da loja — `cod_` |
| 5 | `nf_notafiscal` | `int4 NULL` | `nr_nota_fiscal` | `integer NOT NULL` | Numero NF — `nr_` (secao 18) |
| 6 | `nf_serienotafiscal` | `varchar(4) NULL` | `nr_serie_nota_fiscal` | `varchar(4)` | Serie da NF — `nr_` |
| 7 | `nf_dataemissao` | `timestamp NULL` | `dt_emissao` | `date NOT NULL` | Data de emissao — `dt_` + `date` |
| 8 | `data_embarque` | `timestamp NULL` | `dt_embarque` | `date` | Data de embarque — `dt_` + `date` |
| 9 | `data_transacao` | `timestamp NULL` | `dth_transacao` | `timestamp` | Data+hora da transacao — `dth_` |
| 10 | `nf_nrpedidovenda` | `int4 NULL` | `nr_pedido_venda` | `integer` | Numero do pedido — `nr_` |
| 11 | `nf_nrseqitempedido` | `int2 NULL` | `nr_seq_item_pedido` | `smallint` | Sequencial do item — `nr_` |
| 12 | `nf_cdrep` | `float8 NULL` | `cod_representante` | `varchar(6)` | Join key representante — `cod_representante`; `float8` → `varchar(6)` |
| 13 | `nf_cdempresa` | `float8 NULL` | `id_empresa` | `smallint` | Codigo empresa — `id_`; `float8` → `smallint` |
| 14 | `nf_condpgto` | `int2 NULL` | `id_cond_pagto` | `smallint` | Condicao de pagamento — `id_` |
| 15 | `nf_cod_situacao` | `int2 NULL` | `id_situacao_venda` | `smallint` | Situacao da NF — `id_` (join com `d_situacao_venda`) |
| 16 | `nf_desc_situacao` | `varchar(11) NULL` | `ds_situacao_venda` | `varchar(11)` | Descricao desnormalizada da situacao — `ds_` |
| 17 | `nf_cod_natureza` | `int8 NULL` | `id_natureza` | `smallint` | Codigo da natureza fiscal — `id_` |
| 18 | `itemnf_cod_natureza` | `int8 NULL` | `id_natureza_item` | `smallint` | Natureza do item — `id_` |
| 19 | `natureza_venda` | `varchar(3) NULL` | `ds_natureza_venda` | `varchar(3)` | Descricao da natureza — `ds_` |
| 20 | `desc_nat_oper` | `varchar(40) NULL` | `ds_natureza_operacao` | `varchar(40)` | Descricao da operacao — `ds_` |
| 21 | `cfop` | `varchar(44) NULL` | `ds_cfop` | `varchar(10)` | CFOP fiscal — `ds_`; truncar para 10 |
| 22 | `uf` | `varchar(2) NULL` | `end_uf` | `char(2)` | UF do destinatario — `end_uf` (secao 9) |
| 23 | `tipo_nota` | `varchar(11) NULL` | `ds_tipo_nota` | `varchar(11)` | Tipo de nota (entrada/saida) — `ds_` |
| 24 | `nf_tipo_1dev_0ven` | `int2 NULL` | `fl_devolucao` | `boolean` | Flag: 1=devolucao, 0=venda — `boolean` |
| 25 | `nf_origem` | `int8 NULL` | `id_origem_nf` | `smallint` | Origem da NF — `id_` |
| 26 | `nf_cdcancelamento` | `int2 NULL` | `id_motivo_cancelamento` | `smallint` | Motivo de cancelamento — `id_` |
| 27 | `cod_devolucao` | `numeric(40) NULL` | `nr_devolucao` | `integer` | Numero do documento de devolucao — `nr_` |
| 28 | `emite_duplicata` | `int2 NULL` | `fl_emite_duplicata` | `boolean` | Flag — `boolean` |
| 29 | `faturamento` | `int2 NULL` | `fl_faturamento` | `boolean` | Flag se e faturamento — `boolean` |
| 30 | `itemnf_qtdfaturada` | `numeric(18,3) NULL` | `qt_faturada` | `numeric(15,3) NOT NULL DEFAULT 0` | Quantidade faturada — `qt_` |
| 31 | `itemnf_vlrunit` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,2)` | Valor unitario — `vl_` |
| 32 | `itemnf_vlrfat` | `numeric(18,3) NULL` | `vl_faturado` | `numeric(15,2)` | Valor faturado do item — `vl_` |
| 33 | `itemnf_vlrrateio` | `numeric(18,3) NULL` | `vl_rateio` | `numeric(15,2)` | Rateio — `vl_` |
| 34 | `itemnf_vlr_tot` | `numeric(18,3) NULL` | `vl_total` | `numeric(15,2)` | Valor total do item — `vl_` |
| 35 | `valor_desconto` | `numeric(18,3) NULL` | `vl_desconto` | `numeric(15,2)` | Desconto — `vl_` |
| 36 | `vlr_desc_especial` | `numeric(18,3) NULL` | `vl_desconto_especial` | `numeric(15,2)` | Desconto especial — `vl_` |
| 37 | `ped_vlr_desc_especial` | `numeric(18,3) NULL` | `vl_desconto_especial_pedido` | `numeric(15,2)` | Desconto especial do pedido — `vl_` |
| 38 | `itemnf_vlr_contabil` | `numeric(18,3) NULL` | `vl_contabil` | `numeric(15,2)` | Valor contabil — `vl_` |
| 39 | `itemnf_vlripi` | `numeric(18,3) NULL` | `vl_ipi` | `numeric(15,2)` | IPI — `vl_` |
| 40 | `itemnf_vlricms` | `numeric(18,3) NULL` | `vl_icms` | `numeric(15,2)` | ICMS — `vl_` |
| 41 | `itemnf_vlricmsdiferido` | `numeric(18,3) NULL` | `vl_icms_diferido` | `numeric(15,2)` | ICMS diferido — `vl_` |
| 42 | `itemnf_vlrpis` | `numeric(18,3) NULL` | `vl_pis` | `numeric(15,2)` | PIS — `vl_` |
| 43 | `itemnf_vlrcofins` | `numeric(18,3) NULL` | `vl_cofins` | `numeric(15,2)` | COFINS — `vl_` |
| 44 | `itemnf_pesoliquido` | `numeric(18,3) NULL` | `ps_liquido` | `numeric(15,3)` | Peso liquido — `ps_` (secao 3.2) |
| 45 | `itemnf_vlr_franchising` | `numeric(21,3) NULL` | `vl_franchising` | `numeric(15,2)` | Valor franchising — `vl_` |
| 46 | `codigo_deposito` | `int8 NULL` | `cod_deposito` | `smallint` | Join key deposito — `cod_deposito` (secao 11) |
| 47 | `cod_funcionario` | `numeric(18,3) NULL` | `id_funcionario` | `integer` | Codigo do funcionario — `id_` |
| 48 | `codigo_barras` | `varchar(16) NULL` | `cod_barras` | `varchar(16)` | Codigo de barras — `cod_` |
| 49 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 50 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Relacionamentos propostos:**
```
jma.f_faturamento
  |- cod_cliente       -> live.d_cliente.cod_cliente (ou comercial.d_cliente)
  |- sku_produto       -> jma.d_produto_producao.sku_produto
  |- cod_representante -> comercial.d_representante.cod_representante
  |- cod_deposito      -> jma.d_deposito.cod_deposito
  |- id_situacao_venda -> jma.d_situacao_venda.id_situacao_venda
  |- id_natureza       -> jma.d_natureza_operacao.id_natureza
```
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_faturamento_cliente ON jma.f_faturamento (cod_cliente);
CREATE INDEX idx_f_faturamento_produto ON jma.f_faturamento (sku_produto);
CREATE INDEX idx_f_faturamento_rep ON jma.f_faturamento (cod_representante);
CREATE INDEX idx_f_faturamento_dt ON jma.f_faturamento (dt_emissao);
CREATE INDEX idx_f_faturamento_nf ON jma.f_faturamento (nr_nota_fiscal);
CREATE INDEX idx_f_faturamento_loja ON jma.f_faturamento (cod_loja);
```
**Notas ETL:**
- `pk_cliente varchar(18)` → `cod_cliente varchar(20)` — alinhar tamanho com dicionario de entidades.
- `nf_cdrep float8` → `cod_representante varchar(6)` — converter via `LPAD(nf_cdrep::integer::text, 6, '0')`.
- `nf_tipo_1dev_0ven int2` → `fl_devolucao boolean` (`1` = `TRUE`).
- Converter datas `timestamp` para `date` onde cabivel.

---

### Tabela: `jma.ffaturamento_dev` → `jma.f_faturamento_dev`

**Tipo:** Fato
**Descricao:** Faturamento com devolucoes — versao completa com campos adicionais de canal, modalidade e data de entrada original.
**Sistema de origem:** Systextil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_cliente` | `varchar(17) NULL` | `cod_cliente` | `varchar(20) NOT NULL` | Join key cliente — `cod_` |
| 3 | `pk_produto` | `varchar(20) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 4 | `cd_barra` | `varchar(18) NULL` | `cod_barras` | `varchar(18)` | Codigo de barras — `cod_` |
| 5 | `nf_cdrep` | `int4 NULL` | `cod_representante` | `varchar(6)` | Join key representante — `cod_` |
| 6 | `nf_cdempresa` | `int4 NULL` | `id_empresa` | `smallint` | Codigo empresa — `id_` |
| 7 | `nf_notafiscal` | `int4 NULL` | `nr_nota_fiscal` | `integer NOT NULL` | Numero NF — `nr_` |
| 8 | `nf_serienotafiscal` | `varchar(3) NULL` | `nr_serie_nota_fiscal` | `varchar(3)` | Serie — `nr_` |
| 9 | `nf_dataemissao` | `varchar(10) NULL` | `dt_emissao` | `date NOT NULL` | Data como string → `date` |
| 10 | `nf_dtemissao` | `timestamp NULL` | `dth_emissao` | `timestamp` | Data+hora — `dth_` |
| 11 | `nf_datadigitacao` | `timestamp NULL` | `dth_digitacao` | `timestamp` | Data+hora — `dth_` |
| 12 | `nf_condpgto` | `int4 NULL` | `id_cond_pagto` | `smallint` | Condicao de pagamento — `id_` |
| 13 | `nf_cdcancelamento` | `int4 NULL` | `id_motivo_cancelamento` | `smallint` | Motivo cancelamento — `id_` |
| 14 | `nf_nrpedidovenda` | `int4 NULL` | `nr_pedido_venda` | `integer` | Numero pedido — `nr_` |
| 15 | `nf_nrseqitempedido` | `int4 NULL` | `nr_seq_item_pedido` | `smallint` | Sequencial item — `nr_` |
| 16 | `nf_origem` | `int4 NULL` | `id_origem_nf` | `smallint` | Origem — `id_` |
| 17 | `nf_tipo_1dev_0ven` | `int4 NULL` | `fl_devolucao` | `boolean` | Flag devolucao — `boolean` |
| 18 | `nf_cod_situacao` | `int4 NULL` | `id_situacao_venda` | `smallint` | Situacao — `id_` |
| 19 | `nf_cod_natureza` | `int4 NULL` | `id_natureza` | `smallint` | Natureza — `id_` |
| 20 | `itemnf_cod_natureza` | `int4 NULL` | `id_natureza_item` | `smallint` | Natureza item — `id_` |
| 21 | `natureza_venda` | `varchar(5) NULL` | `ds_natureza_venda` | `varchar(5)` | Descricao — `ds_` |
| 22 | `nf_desc_situacao` | `varchar(12) NULL` | `ds_situacao_venda` | `varchar(12)` | Descricao — `ds_` |
| 23 | `data_embarque` | `timestamp NULL` | `dt_embarque` | `date` | Data — `dt_` |
| 24 | `cod_funcionario` | `int4 NULL` | `id_funcionario` | `integer` | Codigo — `id_` |
| 25 | `cfop` | `varchar(12) NULL` | `ds_cfop` | `varchar(10)` | CFOP — `ds_` |
| 26 | `desc_nat_oper` | `varchar(50) NULL` | `ds_natureza_operacao` | `varchar(50)` | Descricao — `ds_` |
| 27 | `uf` | `varchar(5) NULL` | `end_uf` | `char(2)` | UF — `end_uf`; truncar para 2 |
| 28 | `cod_devolucao` | `varchar(50) NULL` | `ds_cod_devolucao` | `varchar(50)` | Codigo/descricao devolucao — `ds_` |
| 29 | `mot_devolucao` | `varchar(40) NULL` | `ds_motivo_devolucao` | `varchar(40)` | Motivo — `ds_` |
| 30 | `emite_duplicata` | `int2 NULL` | `fl_emite_duplicata` | `boolean` | Flag — `boolean` |
| 31 | `faturamento` | `int2 NULL` | `fl_faturamento` | `boolean` | Flag — `boolean` |
| 32 | `itemnf_qtdfaturada` | `numeric(8,2) NULL` | `qt_faturada` | `numeric(15,3) NOT NULL DEFAULT 0` | Quantidade — `qt_` |
| 33 | `itemnf_vlrunit` | `numeric(10,2) NULL` | `vl_unitario` | `numeric(15,2)` | Valor unitario — `vl_` |
| 34 | `itemnf_vlrfat` | `numeric(10,2) NULL` | `vl_faturado` | `numeric(15,2)` | Valor faturado — `vl_` |
| 35 | `itemnf_vlr_contabil` | `numeric(10,2) NULL` | `vl_contabil` | `numeric(15,2)` | Valor contabil — `vl_` |
| 36 | `itemnf_vlrrateio` | `numeric(12,2) NULL` | `vl_rateio` | `numeric(15,2)` | Rateio — `vl_` |
| 37 | `itemnf_vlr_tot` | `numeric(12,2) NULL` | `vl_total` | `numeric(15,2)` | Total — `vl_` |
| 38 | `valor_desconto` | `numeric(12,2) NULL` | `vl_desconto` | `numeric(15,2)` | Desconto — `vl_` |
| 39 | `itemnf_vlripi` | `numeric(12,2) NULL` | `vl_ipi` | `numeric(15,2)` | IPI — `vl_` |
| 40 | `itemnf_vlricms` | `numeric(12,2) NULL` | `vl_icms` | `numeric(15,2)` | ICMS — `vl_` |
| 41 | `itemnf_vlricmsdiferido` | `numeric(12,2) NULL` | `vl_icms_diferido` | `numeric(15,2)` | ICMS diferido — `vl_` |
| 42 | `itemnf_vlrpis` | `numeric(12,2) NULL` | `vl_pis` | `numeric(15,2)` | PIS — `vl_` |
| 43 | `itemnf_vlrcofins` | `numeric(12,2) NULL` | `vl_cofins` | `numeric(15,2)` | COFINS — `vl_` |
| 44 | `itemnf_pesoliquido` | `numeric(12,2) NULL` | `ps_liquido` | `numeric(15,3)` | Peso — `ps_` |
| 45 | `itemnf_vlr_franchising` | `numeric(12,2) NULL` | `vl_franchising` | `numeric(15,2)` | Franchising — `vl_` |
| 46 | `perc_desc_fran` | `numeric(12,2) NULL` | `pc_desconto_franchising` | `numeric(7,4)` | Percentual — `pc_` |
| 47 | `tipo_nota` | `varchar(15) NULL` | `ds_tipo_nota` | `varchar(15)` | Tipo — `ds_` |
| 48 | `data_transacao` | `varchar(15) NULL` | `dth_transacao` | `timestamp` | Data+hora — `dth_`; converter de string |
| 49 | `codigo_deposito` | `numeric(12,2) NULL` | `cod_deposito` | `smallint` | Join key deposito — `cod_deposito`; `numeric(12,2)` → `smallint` |
| 50 | `canal` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | Canal de venda — `ds_` |
| 51 | `modalidade` | `varchar(50) NULL` | `ds_modalidade` | `varchar(50)` | Modalidade — `ds_` |
| 52 | `live_dt_entr_original` | `timestamp NULL` | `dth_entrada_original` | `timestamp` | Data entrada original Live — `dth_` |
| 53 | `nf_formapgto` | `int8 NULL` | `id_forma_pagto` | `smallint` | Forma de pagamento — `id_` |
| 54 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 55 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_fat_dev_cliente ON jma.f_faturamento_dev (cod_cliente);
CREATE INDEX idx_f_fat_dev_produto ON jma.f_faturamento_dev (sku_produto);
CREATE INDEX idx_f_fat_dev_dt ON jma.f_faturamento_dev (dt_emissao);
CREATE INDEX idx_f_fat_dev_nf ON jma.f_faturamento_dev (nr_nota_fiscal);
```
**Notas ETL:** `nf_dataemissao varchar(10)` → converter para `date` com `TO_DATE(nf_dataemissao, 'DD/MM/YYYY')` ou `YYYY-MM-DD`. Verificar formato real dos dados.

---

### Tabela: `jma.ffaturamento_dev_inc` → `jma.stg_faturamento_dev_inc` ⚠️ COLUNAS UPPER_CASE

**Tipo:** Staging
**Descricao:** Carga incremental de faturamento com devolucoes. Tabela com todas as colunas em UPPER_CASE com aspas — nao conformante com o padrao DW. Deve ser tratada como staging e ter os dados promovidos para `jma.f_faturamento_dev` apos transformacao.
**Sistema de origem:** Systextil (carga incremental direta)

> ⚠️ **PROBLEMA CRITICO:** Todas as colunas usam `"NOME_UPPER"` — incompativel com queries sem aspas. Renomear TODAS as colunas para snake_case. Mover para prefixo `stg_`.
> Alem disso, varios campos usam `numeric(38,10)` indicando origem Oracle sem conversao de tipo.

| # | Nome Atual (UPPER_CASE) | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|------------------------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `"PK_CLIENTE"` | `text NULL` | `cod_cliente` | `varchar(20)` | Join key cliente |
| 3 | `"PK_PRODUTO"` | `text NULL` | `sku_produto` | `varchar(30)` | Join key produto |
| 4 | `"CD_BARRA"` | `text NULL` | `cod_barras` | `varchar(18)` | Codigo de barras |
| 5 | `"NF_CDREP"` | `numeric(38,10) NULL` | `cod_representante` | `varchar(6)` | Representante |
| 6 | `"NF_CDEMPRESA"` | `numeric(38,10) NULL` | `id_empresa` | `smallint` | Empresa |
| 7 | `"NF_NOTAFISCAL"` | `numeric(9) NULL` | `nr_nota_fiscal` | `integer` | Numero NF |
| 8 | `"NF_SERIENOTAFISCAL"` | `text NULL` | `nr_serie_nota_fiscal` | `varchar(3)` | Serie NF |
| 9 | `"NF_DATAEMISSAO"` | `text NULL` | `dt_emissao` | `date` | Data emissao |
| 10 | `"NF_DTEMISSAO"` | `timestamp NULL` | `dth_emissao` | `timestamp` | Data+hora emissao |
| 11 | `"NF_DATADIGITACAO"` | `timestamp NULL` | `dth_digitacao` | `timestamp` | Data digitacao |
| 12 | `"NF_CONDPGTO"` | `numeric(3) NULL` | `id_cond_pagto` | `smallint` | Condicao pagamento |
| 13 | `"NF_CDCANCELAMENTO"` | `numeric(2) NULL` | `id_motivo_cancelamento` | `smallint` | Motivo cancelamento |
| 14 | `"NF_NRPEDIDOVENDA"` | `numeric(9) NULL` | `nr_pedido_venda` | `integer` | Numero pedido |
| 15 | `"NF_NRSEQITEMPEDIDO"` | `numeric(38,10) NULL` | `nr_seq_item_pedido` | `smallint` | Sequencial item |
| 16 | `"NF_ORIGEM"` | `numeric(38,10) NULL` | `id_origem_nf` | `smallint` | Origem NF |
| 17 | `"NF_TIPO_1DEV_0VEN"` | `numeric(38,10) NULL` | `fl_devolucao` | `boolean` | Flag devolucao |
| 18 | `"NF_COD_SITUACAO"` | `numeric(38,10) NULL` | `id_situacao_venda` | `smallint` | Situacao |
| 19 | `"NF_COD_NATUREZA"` | `numeric(3) NULL` | `id_natureza` | `smallint` | Natureza |
| 20 | `"ITEMNF_COD_NATUREZA"` | `numeric(38,10) NULL` | `id_natureza_item` | `smallint` | Natureza item |
| 21 | `"NATUREZA_VENDA"` | `text NULL` | `ds_natureza_venda` | `varchar(5)` | Natureza venda |
| 22 | `"NF_DESC_SITUACAO"` | `text NULL` | `ds_situacao_venda` | `varchar(12)` | Desc situacao |
| 23 | `"DATA_EMBARQUE"` | `timestamp NULL` | `dt_embarque` | `date` | Data embarque |
| 24 | `"COD_FUNCIONARIO"` | `numeric(38,10) NULL` | `id_funcionario` | `integer` | Funcionario |
| 25 | `"CFOP"` | `text NULL` | `ds_cfop` | `varchar(10)` | CFOP |
| 26 | `"DESC_NAT_OPER"` | `text NULL` | `ds_natureza_operacao` | `varchar(50)` | Desc natureza |
| 27 | `"UF"` | `text NULL` | `end_uf` | `char(2)` | UF |
| 28 | `"COD_DEVOLUCAO"` | `text NULL` | `ds_cod_devolucao` | `varchar(50)` | Cod devolucao |
| 29 | `"MOT_DEVOLUCAO"` | `text NULL` | `ds_motivo_devolucao` | `varchar(40)` | Motivo devolucao |
| 30 | `"EMITE_DUPLICATA"` | `numeric(1) NULL` | `fl_emite_duplicata` | `boolean` | Flag duplicata |
| 31 | `"FATURAMENTO"` | `numeric(1) NULL` | `fl_faturamento` | `boolean` | Flag faturamento |
| 32 | `"ITEMNF_QTDFATURADA"` | `numeric(38,10) NULL` | `qt_faturada` | `numeric(15,3)` | Quantidade faturada |
| 33 | `"ITEMNF_VLRUNIT"` | `numeric(38,10) NULL` | `vl_unitario` | `numeric(15,2)` | Valor unitario |
| 34 | `"ITEMNF_VLRFAT"` | `numeric(38,10) NULL` | `vl_faturado` | `numeric(15,2)` | Valor faturado |
| 35 | `"ITEMNF_VLR_CONTABIL"` | `numeric(38,10) NULL` | `vl_contabil` | `numeric(15,2)` | Valor contabil |
| 36 | `"ITEMNF_VLRRATEIO"` | `numeric(15,2) NULL` | `vl_rateio` | `numeric(15,2)` | Rateio |
| 37 | `"ITEMNF_VLR_TOT"` | `numeric(38,10) NULL` | `vl_total` | `numeric(15,2)` | Total |
| 38 | `"VALOR_DESCONTO"` | `numeric(38,10) NULL` | `vl_desconto` | `numeric(15,2)` | Desconto |
| 39 | `"ITEMNF_VLRIPI"` | `numeric(15,2) NULL` | `vl_ipi` | `numeric(15,2)` | IPI |
| 40 | `"ITEMNF_VLRICMS"` | `numeric(15,2) NULL` | `vl_icms` | `numeric(15,2)` | ICMS |
| 41 | `"ITEMNF_VLRICMSDIFERIDO"` | `numeric(38,10) NULL` | `vl_icms_diferido` | `numeric(15,2)` | ICMS diferido |
| 42 | `"ITEMNF_VLRPIS"` | `numeric(15,2) NULL` | `vl_pis` | `numeric(15,2)` | PIS |
| 43 | `"ITEMNF_VLRCOFINS"` | `numeric(15,2) NULL` | `vl_cofins` | `numeric(15,2)` | COFINS |
| 44 | `"ITEMNF_PESOLIQUIDO"` | `numeric(38,10) NULL` | `ps_liquido` | `numeric(15,3)` | Peso liquido |
| 45 | `"ITEMNF_VLR_FRANCHISING"` | `numeric(38,10) NULL` | `vl_franchising` | `numeric(15,2)` | Franchising |
| 46 | `"PERC_DESC_FRAN"` | `numeric(38,10) NULL` | `pc_desconto_franchising` | `numeric(7,4)` | Percentual desconto franchising |
| 47 | `"TIPO_NOTA"` | `text NULL` | `ds_tipo_nota` | `varchar(15)` | Tipo nota |
| 48 | `"ULTIMA_ATUALIZACAO"` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| 49 | `"DATA_TRANSACAO"` | `text NULL` | `dth_transacao` | `timestamp` | Data transacao |
| 50 | `"CODIGO_DEPOSITO"` | `numeric(38,10) NULL` | `cod_deposito` | `smallint` | Deposito |
| 51 | `"CANAL"` | `text NULL` | `ds_canal` | `varchar(100)` | Canal |
| 52 | `"MODALIDADE"` | `text NULL` | `ds_modalidade` | `varchar(50)` | Modalidade |
| 53 | `"LIVE_DT_ENTR_ORIGINAL"` | `timestamp NULL` | `dth_entrada_original` | `timestamp` | Entrada original |
| 54 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Notas ETL:**
- Renomear TODAS as colunas removendo aspas e convertendo para snake_case.
- Converter `numeric(38,10)` para tipos adequados (ver tabela).
- Esta tabela e staging — o pipeline deve promover os dados para `jma.f_faturamento_dev` apos transformacao.
- Criar view de compatibilidade `jma.ffaturamento_dev_inc` com nomes antigos por 90 dias.

---

### Tabela: `jma.ffaturamento_eua` → `jma.f_faturamento_eua` ⚠️ COLUNAS COM SUM()

**Tipo:** Fato
**Descricao:** Faturamento nos EUA agregado por mes/ano/loja com valores em dolar e real.
**Sistema de origem:** Sistema de lojas EUA

> ⚠️ **PROBLEMA CRITICO:** Colunas `"SUM(DADOS.QUANTIDADE)"` e `"SUM(DADOS.VALORDOLAR)"` tem nome invalido — agregacoes SQL como nomes de coluna. Renomear imediatamente.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `mes` | `varchar(6) NULL` | `nr_mes` | `smallint` | Mes — `nr_`; converter de string |
| 3 | `ano` | `varchar(5) NULL` | `nr_ano` | `smallint` | Ano — `nr_`; converter de string |
| 4 | `mes_ano` | `varchar(20) NULL` | `ds_mes_ano` | `varchar(7)` | Chave mes/ano — `ds_`; format `YYYY-MM` |
| 5 | `loja` | `varchar(20) NULL` | `cod_loja` | `varchar(20) NOT NULL` | Join key loja — `cod_` |
| 6 | `"SUM(DADOS.QUANTIDADE)"` | `int8 NULL` | `qt_total` | `integer` | Quantidade total — `qt_`; nome invalido → snake_case |
| 7 | `"SUM(DADOS.VALORDOLAR)"` | `numeric(12,2) NULL` | `vl_total_dolar` | `numeric(15,2)` | Valor em USD — `vl_`; nome invalido → snake_case |
| 8 | `"SUM(DADOS.VALORREAL)"` | `numeric(12,2) NULL` | `vl_total_real` | `numeric(15,2)` | Valor em BRL — `vl_`; nome invalido → snake_case |
| 9 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_fat_eua_loja_ano_mes ON jma.f_faturamento_eua (cod_loja, nr_ano, nr_mes);
```
**Notas ETL:** Renomear colunas com `SUM(...)` imediatamente — quebra qualquer query sem aspas. Converter `mes varchar` e `ano varchar` para `smallint`.

---

### Tabela: `jma.ffaturamento_internacional` → `jma.f_faturamento_internacional`

**Tipo:** Fato
**Descricao:** Faturamento em lojas internacionais com valores em dolar e real por loja e data.
**Sistema de origem:** Financeiro/lojas internacionais

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key — renomear pois `pk_loja_internacional` usa nome similar |
| 2 | `pk_loja_internacional` | `int4 NULL` | `id_loja_internacional` | `integer NOT NULL` | Codigo da loja — `id_`; `pk_` → `id_` |
| 3 | `desc_loja` | `varchar(40) NULL` | `nm_loja` | `varchar(40)` | Nome da loja — `nm_` |
| 4 | `data_fat` | `timestamp NULL` | `dt_faturamento` | `date` | Data — `dt_` + `date` |
| 5 | `qtd_faturado` | `int2 NULL` | `qt_faturado` | `integer` | Quantidade — `qt_` |
| 6 | `tickets` | `int2 NULL` | `qt_tickets` | `integer` | Quantidade tickets — `qt_` |
| 7 | `valor_dolar` | `numeric(18,3) NULL` | `vl_total_dolar` | `numeric(15,2)` | Valor USD — `vl_` |
| 8 | `valor_real` | `numeric(18,3) NULL` | `vl_total_real` | `numeric(15,2)` | Valor BRL — `vl_` |
| 9 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_fat_intl_loja_dt ON jma.f_faturamento_internacional (id_loja_internacional, dt_faturamento);
```

---

### Tabela: `jma.ffaturamento_nacional` → `jma.f_faturamento_nacional`

**Tipo:** Fato
**Descricao:** Lancamentos contabeis de faturamento nacional por empresa, canal e conta contabil.
**Sistema de origem:** Modulo contabil

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_empresa` | `int4 NULL` | `id_empresa` | `smallint NOT NULL` | Empresa — `id_` |
| 3 | `desc_empresa` | `varchar(50) NULL` | `nm_empresa` | `varchar(50)` | Nome empresa — `nm_` |
| 4 | `exercicio` | `int4 NULL` | `nr_exercicio` | `smallint NOT NULL` | Ano do exercicio — `nr_` |
| 5 | `data_lancto` | `timestamp NULL` | `dt_lancamento` | `date NOT NULL` | Data lancamento — `dt_` |
| 6 | `tipo_faturamento` | `varchar(20) NULL` | `ds_tipo_faturamento` | `varchar(20)` | Tipo — `ds_` |
| 7 | `conta_contabil` | `varchar(25) NULL` | `ds_conta_contabil` | `varchar(25)` | Conta — `ds_` |
| 8 | `conta_reduzida` | `int4 NULL` | `id_conta_reduzida` | `integer` | Codigo reduzido — `id_` |
| 9 | `chave` | `int4 NULL` | `nr_chave` | `integer` | Chave do lancamento — `nr_` |
| 10 | `seqchave` | `int4 NULL` | `nr_seq_chave` | `integer` | Sequencial da chave — `nr_` |
| 11 | `complemento_historico` | `varchar(100) NULL` | `ds_complemento_historico` | `varchar(100)` | Complemento — `ds_` |
| 12 | `desc_plano_conta` | `varchar(60) NULL` | `ds_plano_conta` | `varchar(60)` | Plano de contas — `ds_` |
| 13 | `canal_distr` | `varchar(16) NULL` | `ds_canal_distribuicao` | `varchar(16)` | Canal — `ds_` |
| 14 | `credito` | `numeric(12,2) NULL` | `vl_credito` | `numeric(15,2)` | Valor credito — `vl_` |
| 15 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 16 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_fat_nacional_empresa_dt ON jma.f_faturamento_nacional (id_empresa, dt_lancamento);
```

---

### Tabela: `jma.fhists_mov_` → `jma.f_hist_movimentacao`

**Tipo:** Fato/Log
**Descricao:** Historico de movimentacoes de ordens de producao e confeccao. Log de eventos de producao com usuario e endereco.
**Sistema de origem:** Systextil

> **Nota:** Nome original `fhists_mov_` termina com `_` — erro tipografico. Renomear para `f_hist_movimentacao`.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `periodo` | `numeric(4) NULL` | `nr_periodo_producao` | `smallint NOT NULL` | Periodo produtivo — `nr_` |
| 3 | `ordem_producao` | `numeric(9) NULL` | `nr_ordem_producao` | `integer NOT NULL` | Ordem de producao — `nr_` (secao 18) |
| 4 | `ordem_confeccao` | `numeric(5) NULL` | `nr_ordem_confeccao` | `integer` | Ordem de confeccao — `nr_` |
| 5 | `sequencia` | `numeric(5) NULL` | `nr_sequencia` | `integer` | Sequencial — `nr_` |
| 6 | `nivel` | `text NULL` | `ds_nivel` | `varchar(10)` | Nivel — `ds_` |
| 7 | `grupo` | `text NULL` | `ds_grupo` | `varchar(10)` | Grupo — `ds_` |
| 8 | `subgrupo` | `text NULL` | `ds_subgrupo` | `varchar(10)` | Subgrupo — `ds_` |
| 9 | `item` | `text NULL` | `ds_item` | `varchar(10)` | Item — `ds_` |
| 10 | `data_hora` | `timestamp NULL` | `dth_movimento` | `timestamp NOT NULL` | Data+hora do evento — `dth_` |
| 11 | `tipo` | `text NULL` | `ds_tipo_movimento` | `varchar(30)` | Tipo do movimento — `ds_` |
| 12 | `usuario` | `text NULL` | `nm_usuario` | `varchar(60)` | Usuario — `nm_` |
| 13 | `endereco` | `text NULL` | `ds_endereco` | `varchar(100)` | Endereco (localizacao fisica) — `ds_` |
| 14 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 15 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_hist_mov_op ON jma.f_hist_movimentacao (nr_ordem_producao);
CREATE INDEX idx_f_hist_mov_dth ON jma.f_hist_movimentacao (dth_movimento);
CREATE INDEX idx_f_hist_mov_periodo ON jma.f_hist_movimentacao (nr_periodo_producao);
```

---

### Tabela: `jma.finspecao_qualidade` → `jma.f_inspecao_qualidade`

**Tipo:** Fato
**Descricao:** Inspecoes de qualidade em producao com rejeicoes, medidas, tolerancias e defeitos por estagio.
**Sistema de origem:** Systextil/qualidade

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `id_inspecao` | `numeric(9) NULL` | `nr_inspecao` | `integer NOT NULL` | Numero da inspecao — `nr_` |
| 3 | `id_lancamento` | `numeric(9) NULL` | `nr_lancamento` | `integer` | Numero lancamento — `nr_` |
| 4 | `data_inspecao` | `timestamp NULL` | `dth_inspecao` | `timestamp NOT NULL` | Data+hora — `dth_` |
| 5 | `dat_hor_inspecao` | `timestamp NULL` | `dth_inspecao_real` | `timestamp` | Data+hora real — `dth_` |
| 6 | `ordem_producao` | `numeric(9) NULL` | `nr_ordem_producao` | `integer NOT NULL` | OP — `nr_` |
| 7 | `ordem_confeccao` | `numeric(5) NULL` | `nr_ordem_confeccao` | `integer` | OC — `nr_` |
| 8 | `periodo` | `numeric(4) NULL` | `nr_periodo_producao` | `smallint` | Periodo — `nr_` |
| 9 | `turno` | `numeric(1) NULL` | `id_turno` | `smallint` | Turno — `id_` |
| 10 | `cod_estagio` | `numeric(5) NULL` | `id_estagio` | `smallint` | Estagio — `id_` |
| 11 | `cod_estagio_defeito` | `numeric(5) NULL` | `id_estagio_defeito` | `smallint` | Estagio do defeito — `id_` |
| 12 | `inspetor` | `text NULL` | `nm_inspetor` | `varchar(60)` | Inspetor — `nm_` |
| 13 | `pk_produto` | `text NULL` | `sku_produto` | `varchar(30)` | Join key produto — `sku_produto` |
| 14 | `grupo_maq_estamp` | `text NULL` | `ds_grupo_maquina` | `varchar(50)` | Grupo de maquina — `ds_` |
| 15 | `subgrupo_maq_estamp` | `text NULL` | `ds_subgrupo_maquina` | `varchar(50)` | Subgrupo maquina — `ds_` |
| 16 | `revisor_origem` | `text NULL` | `nm_revisor_origem` | `varchar(60)` | Revisor — `nm_` |
| 17 | `qtde_inspecionar_pcs` | `numeric(6) NULL` | `qt_a_inspecionar` | `numeric(15,3)` | Qtd a inspecionar — `qt_` |
| 18 | `perc_inspecionar_pcs` | `numeric(3) NULL` | `pc_a_inspecionar` | `numeric(7,4)` | Percentual — `pc_` |
| 19 | `qtde_inspecionada_pcs` | `numeric(6) NULL` | `qt_inspecionada` | `numeric(15,3)` | Qtd inspecionada — `qt_` |
| 20 | `qtde_rejeitada_pcs` | `numeric(6) NULL` | `qt_rejeitada` | `numeric(15,3)` | Qtd rejeitada — `qt_` |
| 21 | `perc_rejeitada_pcs` | `numeric(3) NULL` | `pc_rejeitada` | `numeric(7,4)` | Percentual rejeicao — `pc_` |
| 22 | `tipo_inspecao` | `numeric(1) NULL` | `id_tipo_inspecao` | `smallint` | Tipo — `id_` |
| 23 | `cod_motivo` | `numeric(3) NULL` | `id_motivo_defeito` | `smallint` | Motivo do defeito — `id_` |
| 24 | `motivo` | `text NULL` | `ds_motivo_defeito` | `varchar(100)` | Descricao motivo — `ds_` |
| 25 | `qtd_inspecao` | `numeric(6) NULL` | `qt_inspecao_medida` | `numeric(15,3)` | Qtd para medida — `qt_` |
| 26 | `tip_medida` | `numeric(2) NULL` | `id_tipo_medida` | `smallint` | Tipo de medida — `id_` |
| 27 | `seq_inspecao` | `numeric(3) NULL` | `nr_seq_inspecao` | `smallint` | Sequencial — `nr_` |
| 28 | `des_inspecao` | `text NULL` | `ds_inspecao` | `varchar(100)` | Descricao — `ds_` |
| 29 | `val_medida_padrao` | `numeric(7,3) NULL` | `vl_medida_padrao` | `numeric(7,3)` | Medida padrao — `vl_` |
| 30 | `val_medida_real` | `numeric(7,3) NULL` | `vl_medida_real` | `numeric(7,3)` | Medida real — `vl_` |
| 31 | `val_toler_minima` | `numeric(6,2) NULL` | `vl_tolerancia_minima` | `numeric(6,2)` | Tolerancia minima — `vl_` |
| 32 | `val_toler_maxima` | `numeric(6,2) NULL` | `vl_tolerancia_maxima` | `numeric(6,2)` | Tolerancia maxima — `vl_` |
| 33 | `val_variacao` | `numeric(7,3) NULL` | `vl_variacao` | `numeric(7,3)` | Variacao da medida — `vl_` |
| 34 | `cod_usuario` | `text NULL` | `nm_usuario` | `varchar(60)` | Usuario — `nm_` |
| 35 | `data_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 36 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_insp_qual_op ON jma.f_inspecao_qualidade (nr_ordem_producao);
CREATE INDEX idx_f_insp_qual_produto ON jma.f_inspecao_qualidade (sku_produto);
CREATE INDEX idx_f_insp_qual_dth ON jma.f_inspecao_qualidade (dth_inspecao);
```

---

### Tabela: `jma.flog_itens_transfer` → `jma.f_log_item_transferencia`

**Tipo:** Fato/Log
**Descricao:** Log de transferencias de itens entre pedidos com cancelamento e quantidades transferidas.
**Sistema de origem:** Systextil/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cd_pedido` | `int4 NULL` | `nr_pedido` | `integer NOT NULL` | Pedido de origem — `nr_` |
| 3 | `cd_pedido_cliente` | `varchar(60) NULL` | `cod_pedido_cliente` | `varchar(60)` | Referencia cliente — `cod_` |
| 4 | `seq_item_pedido` | `int4 NULL` | `nr_seq_item` | `integer` | Sequencial item — `nr_` |
| 5 | `cd_item_trans` | `varchar(60) NULL` | `ds_item_transferido` | `varchar(60)` | Item transferido — `ds_` |
| 6 | `cd_destino_venda` | `int4 NULL` | `nr_pedido_destino` | `integer` | Pedido destino — `nr_` |
| 7 | `cd_destino_cliente` | `varchar(60) NULL` | `cod_cliente_destino` | `varchar(60)` | Cliente destino — `cod_` |
| 8 | `seq_item_destino` | `int4 NULL` | `nr_seq_item_destino` | `integer` | Sequencial destino — `nr_` |
| 9 | `controle` | `int2 NULL` | `id_controle` | `smallint` | Controle — `id_` |
| 10 | `dt_hora_insercao` | `timestamp NULL` | `dth_insercao` | `timestamp NOT NULL` | Data+hora insercao — `dth_` |
| 11 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 12 | `cod_cancelamento` | `int2 NULL` | `id_motivo_cancelamento` | `smallint` | Motivo cancelamento — `id_` |
| 13 | `desc_canc_pedido` | `varchar(20) NULL` | `ds_motivo_cancelamento` | `varchar(20)` | Descricao cancelamento — `ds_` |
| 14 | `qtd_transferida` | `numeric(18,3) NULL` | `qt_transferida` | `numeric(15,3)` | Quantidade — `qt_` |
| 15 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_log_transf_pedido ON jma.f_log_item_transferencia (nr_pedido);
```

---

### Tabela: `jma.flogpedidos` → `jma.f_log_pedido`

**Tipo:** Fato/Log
**Descricao:** Log de alteracoes em pedidos de venda — rastreia mudancas de embarque, quantidades e descontos.
**Sistema de origem:** Systextil/comercial

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cd_pedido` | `int4 NULL` | `nr_pedido` | `integer NOT NULL` | Pedido — `nr_` |
| 3 | `data_alteracao` | `timestamp NULL` | `dth_alteracao` | `timestamp NOT NULL` | Data+hora — `dth_` |
| 4 | `usuario_alteracao` | `varchar(60) NULL` | `nm_usuario` | `varchar(60)` | Usuario — `nm_` |
| 5 | `data_embarque_old` | `timestamp NULL` | `dt_embarque_anterior` | `date` | Data anterior — `dt_` |
| 6 | `data_embarque_new` | `timestamp NULL` | `dt_embarque_novo` | `date` | Data nova — `dt_` |
| 7 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 8 | `qtd_total_old` | `numeric(18,3) NULL` | `qt_total_anterior` | `numeric(15,3)` | Qtd anterior — `qt_` |
| 9 | `qtd_total_new` | `numeric(18,3) NULL` | `qt_total_novo` | `numeric(15,3)` | Qtd nova — `qt_` |
| 10 | `desconto1_old` | `numeric(18,3) NULL` | `pc_desconto1_anterior` | `numeric(7,4)` | Desconto 1 anterior — `pc_` |
| 11 | `desconto1_new` | `numeric(18,3) NULL` | `pc_desconto1_novo` | `numeric(7,4)` | Desconto 1 novo — `pc_` |
| 12 | `desconto2_old` | `numeric(18,3) NULL` | `pc_desconto2_anterior` | `numeric(7,4)` | Desconto 2 anterior — `pc_` |
| 13 | `desconto2_new` | `numeric(18,3) NULL` | `pc_desconto2_novo` | `numeric(7,4)` | Desconto 2 novo — `pc_` |
| 14 | `desconto3_old` | `numeric(18,3) NULL` | `pc_desconto3_anterior` | `numeric(7,4)` | Desconto 3 anterior — `pc_` |
| 15 | `desconto3_new` | `numeric(18,3) NULL` | `pc_desconto3_novo` | `numeric(7,4)` | Desconto 3 novo — `pc_` |
| 16 | `vlr_liq_itens_old` | `numeric(18,3) NULL` | `vl_liq_itens_anterior` | `numeric(15,2)` | Valor liq itens anterior — `vl_` |
| 17 | `vlr_liq_itens_new` | `numeric(18,3) NULL` | `vl_liq_itens_novo` | `numeric(15,2)` | Valor liq itens novo — `vl_` |
| 18 | `vlr_liq_pedido_old` | `numeric(18,3) NULL` | `vl_liq_pedido_anterior` | `numeric(15,2)` | Valor liq pedido anterior — `vl_` |
| 19 | `vlr_liq_pedido_new` | `numeric(18,3) NULL` | `vl_liq_pedido_novo` | `numeric(15,2)` | Valor liq pedido novo — `vl_` |
| 20 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_log_pedido_nr ON jma.f_log_pedido (nr_pedido);
CREATE INDEX idx_f_log_pedido_dth ON jma.f_log_pedido (dth_alteracao);
```

---

### Tabela: `jma.fmeta_diario_loja` → `jma.f_meta_diaria_loja`

**Tipo:** Fato
**Descricao:** Metas diarias por loja com quantidade e valor de meta para o dia.
**Sistema de origem:** Comercial lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `pk_meta_dia` | `varchar(20) NULL` | `cod_meta_dia` | `varchar(20) NOT NULL` | Business key — `cod_` |
| 3 | `cod_loja` | `int4 NULL` | `cod_loja` | `varchar(10) NOT NULL` | Join key loja — harmonizar tipo |
| 4 | `ano` | `int2 NULL` | `nr_ano` | `smallint NOT NULL` | Ano — `nr_` |
| 5 | `mes` | `int2 NULL` | `nr_mes` | `smallint NOT NULL` | Mes — `nr_` |
| 6 | `dia` | `int2 NULL` | `nr_dia` | `smallint NOT NULL` | Dia — `nr_` |
| 7 | `mes_ano` | `varchar(81) NULL` | `ds_mes_ano` | `varchar(7)` | Chave mes/ano — `ds_`; truncar para formato `YYYY-MM` |
| 8 | `dt_meta` | `timestamp NULL` | `dt_meta` | `date NOT NULL` | Data da meta — `dt_` + `date` |
| 9 | `qtd_meta` | `int4 NULL` | `qt_meta` | `integer NOT NULL DEFAULT 0` | Quantidade meta — `qt_` |
| 10 | `valor_meta` | `numeric(18,3) NULL` | `vl_meta` | `numeric(15,2) NOT NULL DEFAULT 0` | Valor meta — `vl_` |
| 11 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 12 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**BK/joins:** `cod_meta_dia varchar(20) UNIQUE`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_meta_diaria_loja_dt ON jma.f_meta_diaria_loja (cod_loja, dt_meta);
```

---

### Tabela: `jma.fmeta_loja` → `jma.f_meta_loja`

**Tipo:** Fato
**Descricao:** Metas gerais por loja e mes com quantidade e valor.
**Sistema de origem:** Comercial lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `pk_id_meta` | `varchar(35) NULL` | `cod_meta` | `varchar(35) NOT NULL` | Business key — `cod_` |
| 3 | `cd_loja` | `int8 NULL` | `cod_loja` | `varchar(10) NOT NULL` | Join key loja — `cod_`; `int8` → `varchar(10)` |
| 4 | `ano` | `int8 NULL` | `nr_ano` | `smallint NOT NULL` | Ano — `nr_` |
| 5 | `mes` | `int4 NULL` | `nr_mes` | `smallint NOT NULL` | Mes — `nr_` |
| 6 | `mes_ano` | `varchar(86) NULL` | `ds_mes_ano` | `varchar(7)` | Chave mes/ano — `ds_` |
| 7 | `qtd_meta` | `int8 NULL` | `qt_meta` | `integer NOT NULL DEFAULT 0` | Quantidade meta — `qt_` |
| 8 | `vlr_meta` | `numeric(17,2) NULL` | `vl_meta` | `numeric(15,2) NOT NULL DEFAULT 0` | Valor meta — `vl_` |
| 9 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_meta_loja_loja_ano_mes ON jma.f_meta_loja (cod_loja, nr_ano, nr_mes);
```

---

### Tabela: `jma.fmeta_mensal_loja` → `jma.f_meta_mensal_loja`

**Tipo:** Fato
**Descricao:** Metas mensais por loja. Similar a `f_meta_loja` — avaliar consolidacao.
**Sistema de origem:** Comercial lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `pk_meta_mes` | `varchar(20) NULL` | `cod_meta_mes` | `varchar(20) NOT NULL` | Business key — `cod_` |
| 3 | `cod_loja` | `int4 NULL` | `cod_loja` | `varchar(10) NOT NULL` | Join key loja — harmonizar tipo |
| 4 | `ano` | `int2 NULL` | `nr_ano` | `smallint NOT NULL` | Ano — `nr_` |
| 5 | `mes` | `int2 NULL` | `nr_mes` | `smallint NOT NULL` | Mes — `nr_` |
| 6 | `mes_ano` | `varchar(8) NULL` | `ds_mes_ano` | `varchar(7)` | Chave — `ds_` |
| 7 | `qtd_meta` | `int4 NULL` | `qt_meta` | `integer NOT NULL DEFAULT 0` | Quantidade — `qt_` |
| 8 | `valor_meta` | `numeric(18,3) NULL` | `vl_meta` | `numeric(15,2) NOT NULL DEFAULT 0` | Valor — `vl_` |
| 9 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`

---

### Tabela: `jma.fmeta_semanal_loja` → `jma.f_meta_semanal_loja`

**Tipo:** Fato
**Descricao:** Metas semanais por loja com datas de inicio e fim da semana.
**Sistema de origem:** Comercial lojas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `pk_meta_dia` | `varchar(20) NULL` | `cod_meta_semana` | `varchar(20) NOT NULL` | Business key — `cod_` |
| 3 | `cod_loja` | `int4 NULL` | `cod_loja` | `varchar(10) NOT NULL` | Join key loja |
| 4 | `ano` | `int2 NULL` | `nr_ano` | `smallint NOT NULL` | Ano — `nr_` |
| 5 | `mes` | `int2 NULL` | `nr_mes` | `smallint NOT NULL` | Mes — `nr_` |
| 6 | `semana` | `int2 NULL` | `nr_semana` | `smallint NOT NULL` | Numero semana — `nr_` |
| 7 | `mes_ano` | `varchar(20) NULL` | `ds_mes_ano` | `varchar(7)` | Chave — `ds_` |
| 8 | `dt_meta` | `timestamp NULL` | `dt_meta` | `date` | Data referencia — `dt_` |
| 9 | `dt_inicio` | `timestamp NULL` | `dt_inicio_semana` | `date NOT NULL` | Data inicio — `dt_` + `date` |
| 10 | `dt_fim` | `timestamp NULL` | `dt_fim_semana` | `date NOT NULL` | Data fim — `dt_` + `date` |
| 11 | `valor_meta` | `numeric(18,3) NULL` | `vl_meta` | `numeric(15,2) NOT NULL DEFAULT 0` | Valor — `vl_` |
| 12 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 13 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_meta_semanal_loja_dt ON jma.f_meta_semanal_loja (cod_loja, dt_inicio_semana);
```

---

### Tabela: `jma.fmetasestacoes` → `jma.f_meta_estacao`

**Tipo:** Fato
**Descricao:** Metas por estacao/colecao e representante com percentual de distribuicao e calculo de meta.
**Sistema de origem:** Comercial/planejamento de vendas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_estacao` | `varchar(9) NULL` | `cod_estacao` | `varchar(9) NOT NULL` | Codigo estacao — `cod_` |
| 3 | `descricao_estacao` | `varchar(150) NULL` | `ds_estacao` | `varchar(100)` | Descricao — `ds_` |
| 4 | `cod_representante` | `varchar(6) NULL` | `cod_representante` | `varchar(6) NOT NULL` | Join key representante — `cod_` |
| 5 | `descricao_rep` | `varchar(100) NULL` | `nm_representante` | `varchar(100)` | Nome — `nm_` |
| 6 | `tipo_meta` | `varchar(3) NULL` | `ds_tipo_meta` | `varchar(3)` | Tipo de meta — `ds_` |
| 7 | `mes` | `varchar(2) NULL` | `nr_mes` | `smallint` | Mes — `nr_` |
| 8 | `ano` | `varchar(4) NULL` | `nr_ano` | `smallint` | Ano — `nr_` |
| 9 | `cod_agrupador` | `varchar(9) NULL` | `id_agrupador` | `smallint` | Agrupador — `id_` |
| 10 | `descricao` | `varchar(50) NULL` | `ds_agrupador` | `varchar(50)` | Descricao agrupador — `ds_` |
| 11 | `colecao` | `varchar(3) NULL` | `id_colecao` | `smallint` | Codigo colecao — `id_` |
| 12 | `valor_meta` | `numeric(18,3) NULL` | `vl_meta` | `numeric(15,2) NOT NULL DEFAULT 0` | Valor meta — `vl_` |
| 13 | `perc_distribuicao` | `numeric(18,3) NULL` | `pc_distribuicao` | `numeric(7,4)` | Percentual — `pc_` |
| 14 | `calc_meta` | `numeric(18,3) NULL` | `vl_meta_calculada` | `numeric(15,2)` | Meta calculada — `vl_` |
| 15 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 16 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_meta_estacao_rep ON jma.f_meta_estacao (cod_representante);
CREATE INDEX idx_f_meta_estacao_cod ON jma.f_meta_estacao (cod_estacao);
```

---

### Tabela: `jma.fmetasorcamento` → `jma.f_meta_orcamento`

**Tipo:** Fato
**Descricao:** Metas de orcamento por tipo, modalidade, mes e ano.
**Sistema de origem:** Planejamento/financeiro

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `tipo_meta` | `varchar(1) NULL` | `id_tipo_meta` | `smallint NOT NULL` | Codigo tipo — `id_` |
| 3 | `desc_meta` | `varchar(50) NULL` | `ds_meta` | `varchar(50)` | Descricao — `ds_` |
| 4 | `modalidade` | `varchar(50) NULL` | `ds_modalidade` | `varchar(50)` | Modalidade — `ds_` |
| 5 | `ano` | `varchar(4) NULL` | `nr_ano` | `smallint NOT NULL` | Ano — `nr_` |
| 6 | `mes_venda` | `varchar(9) NULL` | `ds_mes_venda` | `varchar(9)` | Mes por extenso — `ds_` |
| 7 | `mes_ano` | `varchar(15) NULL` | `ds_mes_ano` | `varchar(7)` | Chave — `ds_` |
| 8 | `total` | `numeric(18,3) NULL` | `vl_meta_total` | `numeric(15,2)` | Valor total da meta — `vl_` |
| 9 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`

---

### Tabela: `jma.fmonitor_producao` → `jma.f_monitor_producao`

**Tipo:** Fato/Operacional
**Descricao:** Monitor em tempo real de producao por operador com eficiencia e destino de celula. Tabela sem campo de atualizacao — provavelmente snapshot.
**Sistema de origem:** MARFT/sistema de producao

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_operador` | `int2 NULL` | `id_operador` | `integer NOT NULL` | Codigo operador — `id_` |
| 3 | `nome_operador` | `varchar(40) NULL` | `nm_operador` | `varchar(40)` | Nome — `nm_` |
| 4 | `min_trab` | `numeric(18,3) NULL` | `nr_min_trabalhados` | `numeric(15,3)` | Minutos trabalhados — `nr_` |
| 5 | `min_prod` | `numeric(18,3) NULL` | `nr_min_produzidos` | `numeric(15,3)` | Minutos produzidos — `nr_` |
| 6 | `efic` | `numeric(18,3) NULL` | `pc_eficiencia` | `numeric(7,4)` | Percentual eficiencia — `pc_` |
| 7 | `status` | `varchar(7) NULL` | `ds_status` | `varchar(7)` | Status — `ds_` |
| 8 | `celula_destino` | `varchar(25) NULL` | `ds_celula_destino` | `varchar(25)` | Celula destino — `ds_` |
| 9 | `celula_origem` | `varchar(25) NULL` | `ds_celula_origem` | `varchar(25)` | Celula origem — `ds_` |
| 10 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 11 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Notas ETL:** Tabela sem campo de atualizacao — provavelmente snapshot ou tempo real; adicionar `created_at`/`updated_at`.

---

### Tabela: `jma.fmovimentacoesestoque` → `jma.f_movimentacao_estoque`

**Tipo:** Fato
**Descricao:** Movimentacoes de estoque com saldo fisico e financeiro por deposito, produto e transacao.
**Sistema de origem:** Systextil/estoque

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `varchar(20) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto`; remover `fk_` |
| 3 | `cd_deposito` | `int2 NULL` | `cod_deposito` | `smallint NOT NULL` | Join key deposito — `cod_` |
| 4 | `cod_empresa` | `int8 NULL` | `id_empresa` | `smallint` | Empresa — `id_` |
| 5 | `nome_empresa` | `varchar(60) NULL` | `nm_empresa` | `varchar(60)` | Nome — `nm_` |
| 6 | `cd_nivel_estrutura` | `varchar(20) NULL` | `ds_nivel_estrutura` | `varchar(20)` | Nivel — `ds_` |
| 7 | `codigo_transacao` | `int2 NULL` | `id_tipo_movimento` | `smallint NOT NULL` | Tipo de transacao — `id_` (join com `d_tipo_movimento` se existir) |
| 8 | `dt_movimentacao` | `timestamp NULL` | `dth_movimentacao` | `timestamp NOT NULL` | Data+hora — `dth_` |
| 9 | `tipo_movimento` | `varchar(3) NULL` | `ds_tipo_movimento` | `varchar(3)` | E/S/T — `ds_` |
| 10 | `qtd_movimento` | `numeric(18,3) NULL` | `qt_movimento` | `numeric(15,3) NOT NULL DEFAULT 0` | Quantidade — `qt_` |
| 11 | `qtd_saldo_fisico` | `numeric(18,3) NULL` | `qt_saldo_fisico` | `numeric(15,3)` | Saldo fisico — `qt_` |
| 12 | `vlr_movimento_unitario` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,2)` | Valor unitario — `vl_` |
| 13 | `vlr_saldo_financeiro` | `numeric(18,3) NULL` | `vl_saldo_financeiro` | `numeric(15,2)` | Saldo financeiro — `vl_` |
| 14 | `flag_periodo` | `varchar(15) NULL` | `ds_periodo` | `varchar(15)` | Periodo flag — `ds_` |
| 15 | `referencia` | `varchar(20) NULL` | `cod_referencia` | `varchar(20)` | Referencia produto — `cod_` |
| 16 | `tamanho` | `varchar(20) NULL` | `ds_tamanho` | `varchar(20)` | Tamanho — `ds_` |
| 17 | `cor` | `varchar(20) NULL` | `ds_cor` | `varchar(20)` | Cor — `ds_` |
| 18 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 19 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_mov_estoque_produto ON jma.f_movimentacao_estoque (sku_produto);
CREATE INDEX idx_f_mov_estoque_deposito ON jma.f_movimentacao_estoque (cod_deposito);
CREATE INDEX idx_f_mov_estoque_dth ON jma.f_movimentacao_estoque (dth_movimentacao);
CREATE INDEX idx_f_mov_estoque_empresa ON jma.f_movimentacao_estoque (id_empresa);
```

---

### Tabela: `jma.fmovimentos_loja` → `jma.f_movimento_loja`

**Tipo:** Fato
**Descricao:** Movimentacoes fiscais de lojas fisicas com impostos, valores e dados de vendedor e cliente.
**Sistema de origem:** CIGAM/lojas fisicas

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `varchar(41) NULL` | `sku_produto` | `varchar(30)` | Join key produto — `sku_produto` |
| 3 | `fk_loja` | `varchar(23) NULL` | `cod_loja` | `varchar(23) NOT NULL` | Join key loja — `cod_` |
| 4 | `fk_loja_cigam` | `varchar(40) NULL` | `cod_loja_cigam` | `varchar(40)` | Codigo CIGAM da loja — `cod_` |
| 5 | `fk_cliente_fornec` | `varchar(23) NULL` | `cod_cliente` | `varchar(23)` | Join key cliente — `cod_` |
| 6 | `fk_vendedor` | `varchar(35) NULL` | `cod_vendedor` | `varchar(35)` | Join key vendedor — `cod_` |
| 7 | `cod_empresa` | `int4 NULL` | `id_empresa` | `smallint NOT NULL` | Empresa — `id_` |
| 8 | `cod_transacao` | `int4 NULL` | `id_tipo_transacao` | `integer` | Tipo de transacao — `id_` |
| 9 | `cod_usuario` | `int4 NULL` | `id_usuario` | `integer` | Usuario — `id_` |
| 10 | `cod_documento` | `int4 NULL` | `nr_documento` | `integer` | Numero documento — `nr_` |
| 11 | `cnpj` | `varchar(14) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ da loja — formato padrao; `cnpj_loja` |
| 12 | `cnpj_original` | `varchar(14) NULL` | `cnpj_loja_original` | `varchar(16)` | CNPJ original — antes de redes/fusoes |
| 13 | `cod_portal` | `int4 NULL` | `id_portal` | `integer` | Portal — `id_` |
| 14 | `dt_documento` | `timestamp NULL` | `dt_documento` | `date NOT NULL` | Data documento — `dt_` + `date` |
| 15 | `dt_lancamento` | `timestamp NULL` | `dth_lancamento` | `timestamp` | Data+hora lancamento — `dth_` |
| 16 | `serie` | `varchar(10) NULL` | `nr_serie` | `varchar(10)` | Serie — `nr_` |
| 17 | `qtd_movimento` | `int8 NULL` | `qt_movimento` | `integer NOT NULL DEFAULT 0` | Quantidade — `qt_` |
| 18 | `forma_pagamento` | `varchar(22) NULL` | `ds_forma_pagamento` | `varchar(22)` | Forma pagamento — `ds_` |
| 19 | `flag_cancelado` | `varchar(1) NULL` | `fl_cancelado` | `boolean` | Flag — `boolean` |
| 20 | `flag_excluido` | `varchar(1) NULL` | `fl_excluido` | `boolean` | Flag — `boolean` |
| 21 | `desc_deposito` | `varchar(100) NULL` | `ds_deposito` | `varchar(100)` | Descricao deposito — `ds_` |
| 22 | `natureza_operacao` | `varchar(100) NULL` | `ds_natureza_operacao` | `varchar(100)` | Natureza — `ds_` |
| 23 | `tabela_preco` | `varchar(50) NULL` | `ds_tabela_preco` | `varchar(50)` | Tabela de preco — `ds_` |
| 24 | `cod_vale_troca` | `varchar(9) NULL` | `cod_vale_troca` | `varchar(9)` | Vale troca — `cod_` |
| 25 | `motivo_troca` | `varchar(60) NULL` | `ds_motivo_troca` | `varchar(60)` | Motivo troca — `ds_` |
| 26 | `cfop` | `varchar(5) NULL` | `ds_cfop` | `varchar(5)` | CFOP — `ds_` |
| 27 | `operacao` | `varchar(2) NULL` | `ds_operacao` | `varchar(2)` | Operacao E/S — `ds_` |
| 28 | `tipo_transacao` | `varchar(1) NULL` | `ds_tipo_transacao` | `varchar(1)` | Tipo — `ds_` |
| 29 | `num_vale` | `varchar(200) NULL` | `ds_num_vale` | `varchar(200)` | Vale — `ds_` |
| 30 | `cod_referencia` | `varchar(20) NULL` | `cod_referencia` | `varchar(20)` | Referencia produto — `cod_` |
| 31 | `tamanho` | `varchar(50) NULL` | `ds_tamanho` | `varchar(50)` | Tamanho — `ds_` |
| 32 | `desc_cor` | `varchar(30) NULL` | `ds_cor` | `varchar(30)` | Cor — `ds_` |
| 33 | `fk_produto_comercial` | `varchar(102) NULL` | `sku_produto_comercial` | `varchar(30)` | SKU comercial — `sku_`; truncar |
| 34 | `identificador` | `varchar(38) NULL` | `ds_identificador` | `varchar(38)` | Identificador — `ds_` |
| 35 | `codigo_cliente` | `int4 NULL` | `id_cliente` | `integer` | Cliente interno — `id_` |
| 36 | `cod_vendedor` | `int4 NULL` | `cod_vendedor` | `varchar(10)` | Vendedor — `cod_`; `int4` → `varchar(10)` |
| 37 | `portal` | `int4 NULL` | `id_portal` | `integer` | Portal — `id_` (duplicata de `cod_portal`) |
| 38 | `loja` | `varchar(50) NULL` | `nm_loja` | `varchar(50)` | Nome loja — `nm_` |
| 39 | `pk_cigam_loja` | `varchar(15) NULL` | `cod_loja_cigam_pk` | `varchar(15)` | PK CIGAM — `cod_` |
| 40 | `preco_custo` | `numeric(18,3) NULL` | `vl_preco_custo` | `numeric(15,2)` | Custo — `vl_` |
| 41 | `valor_liquido` | `numeric(18,3) NULL` | `vl_liquido` | `numeric(15,2)` | Valor liquido — `vl_` |
| 42 | `valor_desconto` | `numeric(18,3) NULL` | `vl_desconto` | `numeric(15,2)` | Desconto — `vl_` |
| 43 | `valor_icms` | `numeric(18,3) NULL` | `vl_icms` | `numeric(15,2)` | ICMS — `vl_` |
| 44 | `base_icms` | `numeric(18,3) NULL` | `vl_base_icms` | `numeric(15,2)` | Base ICMS — `vl_` |
| 45 | `valor_pis` | `numeric(18,3) NULL` | `vl_pis` | `numeric(15,2)` | PIS — `vl_` |
| 46 | `base_pis` | `numeric(18,3) NULL` | `vl_base_pis` | `numeric(15,2)` | Base PIS — `vl_` |
| 47 | `valor_cofins` | `numeric(18,3) NULL` | `vl_cofins` | `numeric(15,2)` | COFINS — `vl_` |
| 48 | `base_cofins` | `numeric(18,3) NULL` | `vl_base_cofins` | `numeric(15,2)` | Base COFINS — `vl_` |
| 49 | `valor_ipi` | `numeric(18,3) NULL` | `vl_ipi` | `numeric(15,2)` | IPI — `vl_` |
| 50 | `base_ipi` | `numeric(18,3) NULL` | `vl_base_ipi` | `numeric(15,2)` | Base IPI — `vl_` |
| 51 | `valor_total` | `numeric(18,3) NULL` | `vl_total` | `numeric(15,2)` | Total — `vl_` |
| 52 | `valor_frete` | `numeric(18,3) NULL` | `vl_frete` | `numeric(15,2)` | Frete — `vl_` |
| 53 | `valor_preco_unitario` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,2)` | Preco unitario — `vl_` |
| 54 | `valor_vale_troca` | `numeric(18,3) NULL` | `vl_vale_troca` | `numeric(15,2)` | Vale troca — `vl_` |
| 55 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 56 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_mov_loja_loja ON jma.f_movimento_loja (cod_loja);
CREATE INDEX idx_f_mov_loja_produto ON jma.f_movimento_loja (sku_produto);
CREATE INDEX idx_f_mov_loja_dt ON jma.f_movimento_loja (dt_documento);
CREATE INDEX idx_f_mov_loja_cnpj ON jma.f_movimento_loja (cnpj_loja);
```
**Notas ETL:** `fk_produto varchar(41)` → `sku_produto varchar(30)` — validar truncamento. Formatar CNPJs com `fn_formatar_cnpj_cpf`. Converter flags `varchar(1)` para `boolean`.

---

### Tabela: `jma.fmovimentosinteg` → `jma.f_movimentos_integ`

**Tipo:** Fato
**Descricao:** Movimentacoes integradas de lojas com impostos detalhados (ICMS, IPI, PIS, COFINS), vigencia e identificadores de rede/canal.
**Sistema de origem:** Integracao (URL/CIGAM)

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `varchar(25) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 3 | `fk_cliente` | `varchar(40) NULL` | `cod_cliente` | `varchar(40)` | Join key cliente — `cod_` |
| 4 | `portal` | `int8 NULL` | `id_portal` | `integer` | Portal — `id_` |
| 5 | `numorcamento` | `int8 NULL` | `nr_orcamento` | `integer` | Orcamento — `nr_` |
| 6 | `usuario` | `int8 NULL` | `id_usuario` | `integer` | Usuario — `id_` |
| 7 | `numnf` | `int8 NULL` | `nr_nota_fiscal` | `integer` | NF — `nr_` |
| 8 | `serie` | `varchar(10) NULL` | `nr_serie` | `varchar(10)` | Serie — `nr_` |
| 9 | `chave_nf` | `varchar(100) NULL` | `ds_chave_nf` | `varchar(100)` | Chave NF (NFe) — `ds_` |
| 10 | `hora_lancamento` | `varchar(20) NULL` | `dth_lancamento` | `timestamp` | Data+hora — converter de string |
| 11 | `codigo_cliente` | `int8 NULL` | `id_cliente` | `integer` | Codigo cliente interno — `id_` |
| 12 | `doc_cliente` | `varchar(20) NULL` | `cnpj_cliente` | `varchar(16)` | Doc fiscal cliente — `cnpj_cliente` |
| 13 | `id_cfop` | `varchar(20) NULL` | `ds_cfop` | `varchar(10)` | CFOP — `ds_` |
| 14 | `cod_vendedor` | `int8 NULL` | `cod_vendedor` | `varchar(10)` | Vendedor — `cod_`; `int8` → `varchar(10)` |
| 15 | `operacao` | `varchar(10) NULL` | `ds_operacao` | `varchar(10)` | Operacao — `ds_` |
| 16 | `tipo_transacao` | `varchar(10) NULL` | `ds_tipo_transacao` | `varchar(10)` | Tipo — `ds_` |
| 17 | `cancelado` | `varchar(3) NULL` | `fl_cancelado` | `boolean` | Flag — `boolean` |
| 18 | `seqitem` | `int4 NULL` | `nr_seq_item` | `integer` | Sequencial item — `nr_` |
| 19 | `cnpj` | `varchar(40) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ loja — formato padrao |
| 20 | `cnpj_original` | `varchar(40) NULL` | `cnpj_loja_original` | `varchar(16)` | CNPJ original — formato padrao |
| 21 | `cnpj_antigo` | `varchar(18) NULL` | `cnpj_loja_antigo` | `varchar(16)` | CNPJ anterior — formato padrao |
| 22 | `cnpj_emp` | `varchar(20) NULL` | `cnpj_empresa` | `varchar(16)` | CNPJ empresa — formato padrao |
| 23 | `valor_bruto` | `int8 NULL` | `vl_bruto` | `numeric(15,2)` | `int8` → `numeric(15,2)` |
| 24 | `cor` | `varchar(6) NULL` | `ds_cor` | `varchar(6)` | Cor — `ds_` |
| 25 | `tamanho` | `varchar(5) NULL` | `ds_tamanho` | `varchar(5)` | Tamanho — `ds_` |
| 26 | `considerarvenda` | `varchar(1) NULL` | `fl_considerar_venda` | `boolean` | Flag — `boolean` |
| 27 | `desc_movimento` | `varchar(255) NULL` | `ds_movimento` | `varchar(255)` | Descricao — `ds_` |
| 28 | `descricao` | `varchar(200) NULL` | `ds_produto` | `varchar(200)` | Descricao do produto — `ds_` |
| 29 | `rede` | `varchar(100) NULL` | `ds_rede` | `varchar(100)` | Rede — `ds_` |
| 30 | `canal_distribuicao` | `varchar(14) NULL` | `ds_canal_distribuicao` | `varchar(14)` | Canal — `ds_` |
| 31 | `flag_movimentacao` | `varchar(20) NULL` | `ds_flag_movimentacao` | `varchar(20)` | Flag — `ds_` |
| 32 | `desconto` | `numeric(18,3) NULL` | `vl_desconto` | `numeric(15,2)` | Desconto — `vl_` |
| 33 | `preco_custo` | `numeric(18,3) NULL` | `vl_preco_custo` | `numeric(15,2)` | Custo — `vl_` |
| 34 | `valor_icms` | `numeric(18,3) NULL` | `vl_icms` | `numeric(15,2)` | ICMS — `vl_` |
| 35 | `aliquota_icms` | `numeric(18,3) NULL` | `pc_aliquota_icms` | `numeric(7,4)` | Aliquota — `pc_` |
| 36 | `base_icms` | `numeric(18,3) NULL` | `vl_base_icms` | `numeric(15,2)` | Base ICMS — `vl_` |
| 37 | `valor_ipi` | `numeric(18,3) NULL` | `vl_ipi` | `numeric(15,2)` | IPI — `vl_` |
| 38 | `aliquota_ipi` | `numeric(18,3) NULL` | `pc_aliquota_ipi` | `numeric(7,4)` | Aliquota — `pc_` |
| 39 | `base_ipi` | `numeric(18,3) NULL` | `vl_base_ipi` | `numeric(15,2)` | Base IPI — `vl_` |
| 40 | `valor_cofins` | `numeric(18,3) NULL` | `vl_cofins` | `numeric(15,2)` | COFINS — `vl_` |
| 41 | `aliquota_cofins` | `numeric(18,3) NULL` | `pc_aliquota_cofins` | `numeric(7,4)` | Aliquota — `pc_` |
| 42 | `base_cofins` | `numeric(18,3) NULL` | `vl_base_cofins` | `numeric(15,2)` | Base COFINS — `vl_` |
| 43 | `valor_pis` | `numeric(18,3) NULL` | `vl_pis` | `numeric(15,2)` | PIS — `vl_` |
| 44 | `aliquota_pis` | `numeric(18,3) NULL` | `pc_aliquota_pis` | `numeric(7,4)` | Aliquota — `pc_` |
| 45 | `base_pis` | `numeric(18,3) NULL` | `vl_base_pis` | `numeric(15,2)` | Base PIS — `vl_` |
| 46 | `valor_liquido` | `numeric(18,3) NULL` | `vl_liquido` | `numeric(15,2)` | Liquido — `vl_` |
| 47 | `qtde` | `numeric(18,3) NULL` | `qt_movimento` | `numeric(15,3) NOT NULL DEFAULT 0` | Quantidade — `qt_` |
| 48 | `data_lancamento` | `timestamp NULL` | `dth_lancamento` | `timestamp NOT NULL` | Data+hora — `dth_` |
| 49 | `datcancel` | `timestamp NULL` | `dth_cancelamento` | `timestamp` | Data cancelamento — `dth_` |
| 50 | `cod_barra` | `varchar(20) NULL` | `cod_barras` | `varchar(20)` | Codigo de barras — `cod_` |
| 51 | `data_inicio_vigencia` | `date NULL` | `dt_inicio_vigencia` | `date` | Data inicio — `dt_` |
| 52 | `data_fim_vigencia` | `date NULL` | `dt_fim_vigencia` | `date` | Data fim — `dt_` |
| 53 | `de` | `varchar(20) NULL` | `ds_loja_origem` | `varchar(20)` | Loja de origem — `ds_` |
| 54 | `para` | `varchar(20) NULL` | `ds_loja_destino` | `varchar(20)` | Loja destino — `ds_` |
| 55 | `loja_original` | `varchar(30) NULL` | `nm_loja_original` | `varchar(30)` | Loja original — `nm_` |
| 56 | `situacao` | `int2 NULL` | `id_situacao` | `smallint` | Situacao — `id_` |
| 57 | `identificador` | `varchar(60) NULL` | `ds_identificador` | `varchar(60)` | Identificador — `ds_` |
| 58 | `loja` | `varchar(5) NULL` | `cod_loja` | `varchar(5)` | Codigo loja — `cod_` |
| 59 | `cst_icms` | `varchar(15) NULL` | `ds_cst_icms` | `varchar(15)` | CST ICMS — `ds_` |
| 60 | `cst_ipi` | `varchar(15) NULL` | `ds_cst_ipi` | `varchar(15)` | CST IPI — `ds_` |
| 61 | `cst_cofins` | `varchar(15) NULL` | `ds_cst_cofins` | `varchar(15)` | CST COFINS — `ds_` |
| 62 | `cst_pis` | `varchar(15) NULL` | `ds_cst_pis` | `varchar(15)` | CST PIS — `ds_` |
| 63 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 64 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_mov_integ_produto ON jma.f_movimentos_integ (sku_produto);
CREATE INDEX idx_f_mov_integ_loja ON jma.f_movimentos_integ (cod_loja);
CREATE INDEX idx_f_mov_integ_nf ON jma.f_movimentos_integ (nr_nota_fiscal);
CREATE INDEX idx_f_mov_integ_dth ON jma.f_movimentos_integ (dth_lancamento);
```
**Notas ETL:** Formatar todos CNPJs com `fn_formatar_cnpj_cpf`. `valor_bruto int8` → `numeric(15,2)` (divisao por 100 se em centavos).

---

### Tabela: `jma.fmovimentoslojamicrovix` → `jma.f_movimento_loja_microvix`

**Tipo:** Fato
**Descricao:** Movimentacoes de lojas integradas pelo Microvix com resumo de vendas, devolucoes e descontos.
**Sistema de origem:** Microvix (PDV)

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cod_empresa` | `int4 NULL` | `id_empresa` | `smallint NOT NULL` | Empresa — `id_` |
| 3 | `cod_transacao` | `int4 NULL` | `id_tipo_transacao` | `integer` | Tipo transacao — `id_` |
| 4 | `rede` | `varchar(50) NULL` | `ds_rede` | `varchar(50)` | Rede — `ds_` |
| 5 | `desc_apelido` | `varchar(200) NULL` | `nm_loja` | `varchar(100)` | Nome loja — `nm_` |
| 6 | `data_lancamento` | `timestamp NULL` | `dt_lancamento` | `date NOT NULL` | Data — `dt_` + `date` |
| 7 | `id_cfop` | `varchar(5) NULL` | `ds_cfop` | `varchar(5)` | CFOP — `ds_` |
| 8 | `operacao` | `varchar(2) NULL` | `ds_operacao` | `varchar(2)` | E/S — `ds_` |
| 9 | `desc_operacao` | `varchar(200) NULL` | `ds_operacao_completo` | `varchar(200)` | Descricao operacao — `ds_` |
| 10 | `numnf` | `int4 NULL` | `nr_nota_fiscal` | `integer` | NF — `nr_` |
| 11 | `loja` | `varchar(100) NULL` | `cod_loja` | `varchar(20)` | Codigo loja — `cod_`; truncar |
| 12 | `cnpj_emp` | `varchar(100) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ — formato padrao |
| 13 | `tipo_transacao` | `varchar(1) NULL` | `ds_tipo_transacao` | `varchar(1)` | Tipo — `ds_` |
| 14 | `transacao` | `varchar(100) NULL` | `ds_transacao` | `varchar(100)` | Descricao transacao — `ds_` |
| 15 | `canal_distribuicao` | `varchar(100) NULL` | `ds_canal_distribuicao` | `varchar(100)` | Canal — `ds_` |
| 16 | `valorvendas` | `numeric(18,3) NULL` | `vl_vendas` | `numeric(15,2)` | Valor vendas — `vl_` |
| 17 | `qtdepedidos` | `numeric(18,3) NULL` | `qt_pedidos` | `numeric(15,3)` | Qtd pedidos — `qt_` |
| 18 | `qtdedevolucao` | `numeric(18,3) NULL` | `qt_devolucao` | `numeric(15,3)` | Qtd devolucoes — `qt_` |
| 19 | `qtdeitensvendida` | `numeric(18,3) NULL` | `qt_itens_vendidos` | `numeric(15,3)` | Qtd itens — `qt_` |
| 20 | `valordesconto` | `numeric(18,3) NULL` | `vl_desconto` | `numeric(15,2)` | Desconto — `vl_` |
| 21 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 22 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_mov_loja_microvix_loja ON jma.f_movimento_loja_microvix (cod_loja, dt_lancamento);
```
**Notas ETL:** Tabela sem campo de atualizacao — adicionar `created_at`/`updated_at`.

---

### Tabela: `jma.fordens_corte_congelado` → `jma.f_ordem_corte_congelado`

**Tipo:** Fato
**Descricao:** Ordens de corte congeladas com estagio, OP/OC, prioridade e dados de producao programada. Snapshot de planejamento de corte.
**Sistema de origem:** Systextil/planejamento de producao

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `op` | `int4 NULL` | `nr_ordem_producao` | `integer NOT NULL` | OP — `nr_` |
| 3 | `oc` | `int4 NULL` | `nr_ordem_confeccao` | `integer` | OC — `nr_` |
| 4 | `estagio` | `int4 NULL` | `id_estagio` | `smallint` | Estagio — `id_` |
| 5 | `data_programacao` | `timestamp NULL` | `dt_programacao` | `date` | Data programacao — `dt_` |
| 6 | `simultaneo` | `int4 NULL` | `id_simultaneo` | `smallint` | Codigo simultaneo — `id_` |
| 7 | `periodo` | `int2 NULL` | `nr_periodo_producao` | `smallint` | Periodo — `nr_` |
| 8 | `referencia` | `text NULL` | `cod_referencia` | `varchar(10)` | Referencia — `cod_` |
| 9 | `cor` | `text NULL` | `ds_cor` | `varchar(10)` | Cor — `ds_` |
| 10 | `prioridade` | `int4 NULL` | `nr_prioridade` | `integer` | Prioridade — `nr_` |
| 11 | `cor_prioridade` | `text NULL` | `ds_cor_prioridade` | `varchar(20)` | Cor da prioridade (indicador visual) — `ds_` |
| 12 | `qtd_produzir` | `numeric(18,3) NULL` | `qt_a_produzir` | `numeric(15,3)` | Qtd a produzir — `qt_` |
| 13 | `qtd_ajustada` | `numeric(38,18) NULL` | `qt_ajustada` | `numeric(15,3)` | Qtd ajustada — `qt_`; `numeric(38,18)` → `numeric(15,3)` |
| 14 | `tempo_produzir` | `numeric(18,3) NULL` | `nr_tempo_produzir` | `numeric(15,3)` | Tempo em minutos — `nr_` |
| 15 | `tempo_costura` | `numeric(38,18) NULL` | `nr_tempo_costura` | `numeric(15,3)` | Tempo costura — `nr_` |
| 16 | `data_producao` | `timestamp NULL` | `dt_producao` | `date` | Data producao — `dt_` |
| 17 | `data_congelamento` | `date NULL` | `dt_congelamento` | `date` | Data congelamento — `dt_` |
| 18 | `data_entrada_estagio` | `timestamp NULL` | `dth_entrada_estagio` | `timestamp` | Data+hora entrada — `dth_` |
| 19 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 20 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_ord_corte_cong_op ON jma.f_ordem_corte_congelado (nr_ordem_producao);
CREATE INDEX idx_f_ord_corte_cong_dt ON jma.f_ordem_corte_congelado (dt_programacao);
```

---

### Tabela: `jma.fparametro_compra` → `jma.aux_parametro_compra`

**Tipo:** Auxiliar
**Descricao:** Parametros de compra por produto e deposito com estoques minimo/maximo e tempo de reposicao.
**Sistema de origem:** Systextil/compras

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `text NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 3 | `cod_empresa` | `numeric(3) NULL` | `id_empresa` | `smallint NOT NULL` | Empresa — `id_` |
| 4 | `cod_deposito` | `numeric(3) NULL` | `cod_deposito` | `smallint NOT NULL` | Join key deposito — `cod_` |
| 5 | `fk_familia_materiais` | `numeric(5) NULL` | `id_familia` | `integer` | Familia de materiais — `id_` |
| 6 | `estoque_minimo` | `numeric(13,3) NULL` | `qt_estoque_minimo` | `numeric(15,3)` | Estoque min — `qt_` |
| 7 | `estoque_maximo` | `numeric(13,3) NULL` | `qt_estoque_maximo` | `numeric(15,3)` | Estoque max — `qt_` |
| 8 | `lote_minimo` | `numeric(16,3) NULL` | `qt_lote_minimo` | `numeric(15,3)` | Lote minimo — `qt_` |
| 9 | `lote_multiplo` | `numeric(13,3) NULL` | `qt_lote_multiplo` | `numeric(15,3)` | Lote multiplo — `qt_` |
| 10 | `tempo_reposicao` | `numeric(5) NULL` | `nr_tempo_reposicao` | `integer` | Dias de reposicao — `nr_` |
| 11 | `bloqueia_compra` | `numeric(1) NULL` | `fl_bloqueia_compra` | `boolean` | Flag — `boolean` |
| 12 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 13 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_aux_param_compra_produto ON jma.aux_parametro_compra (sku_produto, cod_deposito);
```

---

### Tabela: `jma.fpedido_congelado` → `jma.f_pedido_congelado`

**Tipo:** Fato
**Descricao:** Snapshot de pedidos congelados com situacoes de alocacao, coleta, expedicao e homologacao.
**Sistema de origem:** Systextil/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pedido_venda` | `int4 NULL` | `nr_pedido_venda` | `integer NOT NULL` | Numero pedido — `nr_` |
| 3 | `data_entr_venda` | `timestamp NULL` | `dth_entrada_venda` | `timestamp` | Data+hora — `dth_` |
| 4 | `situacao_venda` | `int2 NULL` | `id_situacao_venda` | `smallint` | Situacao — `id_` |
| 5 | `cod_cancelamento` | `int2 NULL` | `id_motivo_cancelamento` | `smallint` | Cancelamento — `id_` |
| 6 | `sit_aloc_pedi` | `int2 NULL` | `id_sit_alocacao` | `smallint` | Situacao alocacao — `id_` |
| 7 | `sit_coletor` | `int2 NULL` | `id_sit_coletor` | `smallint` | Situacao coletor — `id_` |
| 8 | `situacao_coleta` | `int2 NULL` | `id_situacao_coleta` | `smallint` | Situacao coleta — `id_` |
| 9 | `status_expedicao` | `int2 NULL` | `id_status_expedicao` | `smallint` | Status expedicao — `id_` |
| 10 | `status_homologacao` | `int2 NULL` | `id_status_homologacao` | `smallint` | Status homologacao — `id_` |
| 11 | `status_pedido` | `int2 NULL` | `id_status_pedido` | `smallint` | Status pedido — `id_` |
| 12 | `status_comercial` | `int2 NULL` | `id_status_comercial` | `smallint` | Status comercial — `id_` |
| 13 | `sit_conferencia` | `int2 NULL` | `id_sit_conferencia` | `smallint` | Situacao conferencia — `id_` |
| 14 | `data_congelamento` | `timestamp NULL` | `dth_congelamento` | `timestamp` | Data congelamento — `dth_` |
| 15 | `qtde_saldo_pedi` | `numeric(18,3) NULL` | `qt_saldo_pedido` | `numeric(15,3)` | Saldo qtd — `qt_` |
| 16 | `valor_saldo_pedi` | `numeric(18,3) NULL` | `vl_saldo_pedido` | `numeric(15,2)` | Saldo valor — `vl_` |
| 17 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 18 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_pedido_congelado_nr ON jma.f_pedido_congelado (nr_pedido_venda);
```

---

### Tabela: `jma.fpedidos_compra` → `jma.f_pedido_compra`

**Tipo:** Fato
**Descricao:** Pedidos de compra com itens, quantidades, precos, condicoes de pagamento e centro de custo.
**Sistema de origem:** Systextil/compras

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `ped_compra` | `numeric(8) NULL` | `nr_pedido_compra` | `integer NOT NULL` | Numero pedido compra — `nr_` |
| 3 | `itemped_seq_ped` | `numeric(4) NULL` | `nr_seq_item` | `smallint NOT NULL` | Sequencial item — `nr_` |
| 4 | `fk_produto` | `varchar(30) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 5 | `fk_fornecedor` | `varchar(18) NULL` | `cod_fornecedor` | `varchar(18)` | Join key fornecedor — `cod_` |
| 6 | `fk_conta_estoque` | `varchar(5) NULL` | `id_conta_estoque` | `smallint` | Conta estoque — `id_` |
| 7 | `fk_comprador` | `numeric(5) NULL` | `id_comprador` | `integer` | Comprador — `id_` |
| 8 | `fk_cond_pgto` | `numeric(3) NULL` | `id_cond_pagto` | `smallint` | Condicao pagamento — `id_` |
| 9 | `fk_grupo_contas` | `numeric(5) NULL` | `id_grupo_contas` | `integer` | Grupo de contas — `id_` |
| 10 | `fk_familia` | `numeric(8) NULL` | `id_familia` | `integer` | Familia — `id_` |
| 11 | `obs_pedido` | `varchar(300) NULL` | `obs_pedido` | `text` | Observacao — `obs_` |
| 12 | `dt_emissao_compra` | `timestamp NULL` | `dt_emissao` | `date NOT NULL` | Data emissao — `dt_` |
| 13 | `dt_prev_entrega` | `timestamp NULL` | `dt_prev_entrega` | `date` | Previsao entrega — `dt_` |
| 14 | `ped_vendedor` | `varchar(60) NULL` | `nm_vendedor_fornecedor` | `varchar(60)` | Vendedor do fornecedor — `nm_` |
| 15 | `itemped_qtd_pedida` | `numeric(15,3) NULL` | `qt_pedida` | `numeric(15,3) NOT NULL DEFAULT 0` | Qtd pedida — `qt_` |
| 16 | `itemped_qtd_saldo` | `numeric(15,3) NULL` | `qt_saldo` | `numeric(15,3)` | Saldo — `qt_` |
| 17 | `itemped_qtd_recebida` | `numeric(15,3) NULL` | `qt_recebida` | `numeric(15,3)` | Qtd recebida — `qt_` |
| 18 | `itemped_situacao_item` | `varchar(13) NULL` | `ds_situacao_item` | `varchar(13)` | Situacao — `ds_` |
| 19 | `itemped_preco` | `numeric(15,5) NULL` | `vl_preco_unitario` | `numeric(15,2)` | Preco unitario — `vl_` |
| 20 | `itemped_percentual_desc` | `numeric(8,2) NULL` | `pc_desconto` | `numeric(7,4)` | Percentual desconto — `pc_` |
| 21 | `itemped_percentual_ipi` | `numeric(8,2) NULL` | `pc_ipi` | `numeric(7,4)` | Percentual IPI — `pc_` |
| 22 | `itemped_centro_custo` | `numeric(8) NULL` | `id_centro_custo` | `integer` | Centro custo — `id_` |
| 23 | `itemped_cod_cancelamento` | `numeric(4) NULL` | `id_motivo_cancelamento` | `smallint` | Cancelamento — `id_` |
| 24 | `dt_cancelamento` | `timestamp NULL` | `dt_cancelamento` | `date` | Data cancelamento — `dt_` |
| 25 | `itemped_requisicao` | `numeric(8) NULL` | `nr_requisicao` | `integer` | Numero requisicao — `nr_` |
| 26 | `codigo_contabil` | `int4 NULL` | `id_codigo_contabil` | `integer` | Codigo contabil — `id_` |
| 27 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 28 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_pedido_compra_nr ON jma.f_pedido_compra (nr_pedido_compra);
CREATE INDEX idx_f_pedido_compra_produto ON jma.f_pedido_compra (sku_produto);
CREATE INDEX idx_f_pedido_compra_fornecedor ON jma.f_pedido_compra (cod_fornecedor);
CREATE INDEX idx_f_pedido_compra_dt ON jma.f_pedido_compra (dt_emissao);
```

---

### Tabela: `jma.fpedidos_embarque_previsto` → `jma.f_pedido_embarque_previsto`

**Tipo:** Fato
**Descricao:** Pedidos com previsao de embarque e saldo a faturar. Dados de planejamento logistico.
**Sistema de origem:** Systextil/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pedido_venda` | `numeric(9) NULL` | `nr_pedido_venda` | `integer NOT NULL` | Numero pedido — `nr_` |
| 3 | `fk_produto` | `varchar(35) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 4 | `data_entr_venda` | `timestamp NULL` | `dt_entrada_venda` | `date` | Data entrada — `dt_` |
| 5 | `situacao_venda` | `numeric(2) NULL` | `id_situacao_venda` | `smallint` | Situacao — `id_` |
| 6 | `cod_cancelamento` | `numeric(3) NULL` | `id_motivo_cancelamento` | `smallint` | Cancelamento — `id_` |
| 7 | `sit_aloc_pedi` | `numeric(1) NULL` | `id_sit_alocacao` | `smallint` | Alocacao — `id_` |
| 8 | `sit_coletor` | `numeric(1) NULL` | `id_sit_coletor` | `smallint` | Coletor — `id_` |
| 9 | `situacao_coleta` | `numeric(1) NULL` | `id_situacao_coleta` | `smallint` | Coleta — `id_` |
| 10 | `status_expedicao` | `numeric(1) NULL` | `id_status_expedicao` | `smallint` | Expedicao — `id_` |
| 11 | `status_homologacao` | `numeric(1) NULL` | `id_status_homologacao` | `smallint` | Homologacao — `id_` |
| 12 | `status_pedido` | `numeric(1) NULL` | `id_status_pedido` | `smallint` | Status pedido — `id_` |
| 13 | `status_comercial` | `numeric(1) NULL` | `id_status_comercial` | `smallint` | Status comercial — `id_` |
| 14 | `sit_conferencia` | `numeric(1) NULL` | `id_sit_conferencia` | `smallint` | Conferencia — `id_` |
| 15 | `cnpj_cliente` | `varchar(35) NULL` | `cnpj_cliente` | `varchar(16)` | CNPJ cliente — formato padrao; `varchar(35)` → `varchar(16)` |
| 16 | `codigo_deposito` | `int2 NULL` | `cod_deposito` | `smallint` | Deposito — `cod_` |
| 17 | `seq_item_pedido` | `int2 NULL` | `nr_seq_item` | `smallint` | Sequencial — `nr_` |
| 18 | `natureza_venda` | `varchar(10) NULL` | `ds_natureza_venda` | `varchar(10)` | Natureza — `ds_` |
| 19 | `canal` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | Canal — `ds_` |
| 20 | `qtde_saldo_pedi` | `numeric(15,3) NULL` | `qt_saldo_pedido` | `numeric(15,3)` | Saldo qtd — `qt_` |
| 21 | `qtde_pedida` | `numeric(15,3) NULL` | `qt_pedida` | `numeric(15,3)` | Qtd pedida — `qt_` |
| 22 | `qtde_afaturar` | `numeric(15,3) NULL` | `qt_a_faturar` | `numeric(15,3)` | Qtd a faturar — `qt_` |
| 23 | `qtde_faturada` | `numeric(18,3) NULL` | `qt_faturada` | `numeric(15,3)` | Qtd faturada — `qt_` |
| 24 | `val_liq_unt` | `numeric(15,3) NULL` | `vl_unitario_liquido` | `numeric(15,2)` | Valor unit liq — `vl_` |
| 25 | `valor_unitario` | `numeric(15,3) NULL` | `vl_unitario` | `numeric(15,2)` | Valor unit — `vl_` |
| 26 | `valor_saldo_pedi` | `numeric(18,3) NULL` | `vl_saldo_pedido` | `numeric(15,2)` | Saldo valor — `vl_` |
| 27 | `ultima_atualizacao` | `date NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao; `date` → `timestamp` |
| 28 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_ped_emb_prev_nr ON jma.f_pedido_embarque_previsto (nr_pedido_venda);
CREATE INDEX idx_f_ped_emb_prev_produto ON jma.f_pedido_embarque_previsto (sku_produto);
```
**Notas ETL:** `cnpj_cliente varchar(35)` — formatar para 16 chars com `fn_formatar_cnpj_cpf`. `ultima_atualizacao date` → `updated_at timestamp`.

---

### Tabela: `jma.fpedidos_url` → `jma.f_pedido_url`

**Tipo:** Fato
**Descricao:** Pedidos do canal URL/ecommerce com dados de vendedor, cupom, comissao e NF emitida.
**Sistema de origem:** URL (ecommerce)

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `id_pedido` | `int8 NULL` | `nr_pedido` | `integer NOT NULL` | Numero pedido — `nr_` |
| 3 | `"data"` | `varchar(20) NULL` | `dt_pedido` | `date NOT NULL` | Data pedido — `dt_` |
| 4 | `hora` | `varchar(10) NULL` | `nr_hora` | `varchar(10)` | Hora — manter como string |
| 5 | `cliente` | `varchar(150) NULL` | `nm_cliente` | `varchar(150)` | Nome cliente — `nm_` |
| 6 | `id_vendedor` | `int8 NULL` | `id_vendedor` | `integer` | Vendedor — `id_` |
| 7 | `cpf_vendedor` | `varchar(20) NULL` | `cpf_vendedor` | `varchar(12)` | CPF — formato `XXXXXXXXX-ZZ` |
| 8 | `grupo_vendedor` | `varchar(50) NULL` | `ds_grupo_vendedor` | `varchar(50)` | Grupo — `ds_` |
| 9 | `cnpj` | `varchar(20) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ loja — formato padrao |
| 10 | `url_loja` | `varchar(100) NULL` | `ds_url_loja` | `varchar(100)` | URL — `ds_` |
| 11 | `numero_nf` | `varchar(20) NULL` | `nr_nota_fiscal` | `integer` | NF — `nr_`; converter de string |
| 12 | `serie_nf` | `varchar(10) NULL` | `nr_serie_nota_fiscal` | `varchar(10)` | Serie — `nr_` |
| 13 | `omnichannel` | `varchar(10) NULL` | `fl_omnichannel` | `boolean` | Flag — `boolean` |
| 14 | `tipo` | `varchar(30) NULL` | `ds_tipo_pedido` | `varchar(30)` | Tipo — `ds_` |
| 15 | `cupom` | `varchar(40) NULL` | `ds_cupom` | `varchar(40)` | Cupom — `ds_` |
| 16 | `desconto_cupom` | `varchar(40) NULL` | `vl_desconto_cupom` | `numeric(15,2)` | Desconto — `vl_`; converter de string |
| 17 | `codigo_vendedor` | `varchar(40) NULL` | `cod_vendedor` | `varchar(40)` | Vendedor — `cod_` |
| 18 | `desconto_vendedor` | `varchar(40) NULL` | `vl_desconto_vendedor` | `numeric(15,2)` | Desconto — `vl_`; converter de string |
| 19 | `status` | `varchar(80) NULL` | `ds_status` | `varchar(80)` | Status — `ds_` |
| 20 | `total_liquido` | `numeric(18,3) NULL` | `vl_total_liquido` | `numeric(15,2)` | Total liq — `vl_` |
| 21 | `total_desconto` | `numeric(18,3) NULL` | `vl_total_desconto` | `numeric(15,2)` | Total desconto — `vl_` |
| 22 | `total_bruto` | `numeric(18,3) NULL` | `vl_total_bruto` | `numeric(15,2)` | Total bruto — `vl_` |
| 23 | `pagamento` | `varchar(80) NULL` | `ds_forma_pagamento` | `varchar(80)` | Pagamento — `ds_` |
| 24 | `vendedor` | `varchar(80) NULL` | `nm_vendedor` | `varchar(80)` | Nome vendedor — `nm_` |
| 25 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 26 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_pedido_url_nr ON jma.f_pedido_url (nr_pedido, dt_pedido);
CREATE INDEX idx_f_pedido_url_loja ON jma.f_pedido_url (cnpj_loja);
```

---

### Tabela: `jma.fportal_lojas` → `jma.f_portal_loja`

**Tipo:** Fato
**Descricao:** Conferencia de volumes e pecas no portal de expedicao das lojas com status e bipagem de tags/NF.
**Sistema de origem:** Portal de expedicao

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `cn_id` | `int8 NULL` | `id_conferencia` | `integer NOT NULL` | ID conferencia — `id_` |
| 3 | `cn_num_nota_fiscal` | `int4 NULL` | `nr_nota_fiscal` | `integer` | NF — `nr_` |
| 4 | `cn_inicio_conferencia_volumes` | `timestamp NULL` | `dth_inicio_conferencia` | `timestamp` | Data+hora — `dth_` |
| 5 | `cn_ultima_leitura_volumes` | `timestamp NULL` | `dth_ultima_leitura_volumes` | `timestamp` | Data+hora — `dth_` |
| 6 | `cn_ultima_leitura_tags` | `timestamp NULL` | `dth_ultima_leitura_tags` | `timestamp` | Data+hora — `dth_` |
| 7 | `cn_status_volumes` | `int2 NULL` | `id_status_volumes` | `smallint` | Status — `id_` |
| 8 | `cn_desc_status_volumes` | `varchar(14) NULL` | `ds_status_volumes` | `varchar(14)` | Descricao — `ds_` |
| 9 | `tcv_id` | `int8 NULL` | `id_volume` | `integer` | Volume — `id_` |
| 10 | `tcv_numero_volume` | `int4 NULL` | `nr_volume` | `integer` | Numero volume — `nr_` |
| 11 | `tcv_inicio_conferencia` | `timestamp NULL` | `dth_inicio_conf_volume` | `timestamp` | Data+hora — `dth_` |
| 12 | `tcv_ultima_leitura` | `timestamp NULL` | `dth_ultima_leitura_volume` | `timestamp` | Data+hora — `dth_` |
| 13 | `tcv_status_pecas` | `int2 NULL` | `id_status_pecas` | `smallint` | Status — `id_` |
| 14 | `tcv_desc_status_pecas` | `varchar(14) NULL` | `ds_status_pecas` | `varchar(14)` | Descricao — `ds_` |
| 15 | `tcv_tags_conferidas` | `numeric(18,3) NULL` | `qt_tags_conferidas` | `numeric(15,3)` | Qtd tags — `qt_` |
| 16 | `ct_id` | `int8 NULL` | `id_tag` | `integer` | Tag — `id_` |
| 17 | `ct_data_bip` | `timestamp NULL` | `dth_bip_tag` | `timestamp` | Data bipagem tag — `dth_` |
| 18 | `ct_usuario` | `varchar(55) NULL` | `nm_usuario_tag` | `varchar(55)` | Usuario — `nm_` |
| 19 | `ct_status` | `int2 NULL` | `id_status_tag` | `smallint` | Status tag — `id_` |
| 20 | `ct_pk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30)` | Join key produto — `sku_produto` |
| 21 | `ct_desc_status` | `varchar(14) NULL` | `ds_status_tag` | `varchar(14)` | Descricao — `ds_` |
| 22 | `ct_numero_tag` | `varchar(60) NULL` | `nr_tag` | `varchar(60)` | Numero tag — `nr_` |
| 23 | `cv_id` | `int8 NULL` | `id_cv` | `integer` | ID CV — `id_` |
| 24 | `cv_data_bip` | `timestamp NULL` | `dth_bip_cv` | `timestamp` | Data bip — `dth_` |
| 25 | `cv_status` | `int2 NULL` | `id_status_cv` | `smallint` | Status — `id_` |
| 26 | `cv_desc_status` | `varchar(14) NULL` | `ds_status_cv` | `varchar(14)` | Descricao — `ds_` |
| 27 | `ra_id` | `int8 NULL` | `id_recebimento` | `integer` | Recebimento — `id_` |
| 28 | `ra_cnpj` | `varchar(17) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ — formato padrao |
| 29 | `ra_usuario_bipou` | `varchar(55) NULL` | `nm_usuario_bip` | `varchar(55)` | Usuario — `nm_` |
| 30 | `ra_nome_usuario` | `varchar(55) NULL` | `nm_usuario` | `varchar(55)` | Nome — `nm_` |
| 31 | `ra_tipo` | `int2 NULL` | `id_tipo_recebimento` | `smallint` | Tipo — `id_` |
| 32 | `ra_status` | `int2 NULL` | `id_status_recebimento` | `smallint` | Status — `id_` |
| 33 | `ra_codigo_bipado` | `varchar(100) NULL` | `ds_codigo_bipado` | `varchar(100)` | Codigo bipado — `ds_` |
| 34 | `ra_acao` | `varchar(2500) NULL` | `ds_acao` | `text` | Acao — `text` para tamanho livre |
| 35 | `ra_data_bipagem` | `timestamp NULL` | `dth_bipagem` | `timestamp` | Data bipagem — `dth_` |
| 36 | `ra_codigo_empresa` | `int2 NULL` | `id_empresa` | `smallint` | Empresa — `id_` |
| 37 | `ra_serie_nota_fisc` | `varchar(3) NULL` | `nr_serie_nota_fiscal` | `varchar(3)` | Serie NF — `nr_` |
| 38 | `ra_desc_status` | `varchar(14) NULL` | `ds_status_recebimento` | `varchar(14)` | Descricao — `ds_` |
| 39 | `usu_id` | `int8 NULL` | `id_usuario` | `integer` | Usuario — `id_` |
| 40 | `usu_nome` | `varchar(55) NULL` | `nm_usuario_full` | `varchar(55)` | Nome completo — `nm_` |
| 41 | `usu_usuario` | `varchar(55) NULL` | `ds_login_usuario` | `varchar(55)` | Login — `ds_` |
| 42 | `usu_situacao` | `int2 NULL` | `id_situacao_usuario` | `smallint` | Situacao — `id_` |
| 43 | `usu_cnpj` | `varchar(18) NULL` | `cnpj_usuario` | `varchar(16)` | CNPJ do usuario/empresa — formato padrao |
| 44 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 45 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_portal_loja_nf ON jma.f_portal_loja (nr_nota_fiscal);
CREATE INDEX idx_f_portal_loja_cnpj ON jma.f_portal_loja (cnpj_loja);
CREATE INDEX idx_f_portal_loja_produto ON jma.f_portal_loja (sku_produto);
```

---

### Tabela: `jma.fprioridade_beneficiamento_conge` → `jma.f_prioridade_beneficiamento_congelado`

**Tipo:** Fato
**Descricao:** Prioridade de ordens de beneficiamento congeladas com dados de maquina, rolos e quilos.
**Sistema de origem:** Systextil/tecelagem-beneficiamento

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `ordem_producao` | `numeric(9) NULL` | `nr_ordem_producao` | `integer NOT NULL` | OP — `nr_` |
| 3 | `prioridade` | `numeric(3) NULL` | `nr_prioridade` | `smallint` | Prioridade — `nr_` |
| 4 | `work_order_id` | `text NULL` | `ds_work_order_id` | `varchar(20)` | ID WO — `ds_` |
| 5 | `work_center` | `text NULL` | `ds_work_center` | `varchar(50)` | Centro trabalho — `ds_` |
| 6 | `planta` | `text NULL` | `ds_planta` | `varchar(20)` | Planta — `ds_` |
| 7 | `cliente` | `text NULL` | `nm_cliente` | `varchar(50)` | Cliente — `nm_` |
| 8 | `sku` | `text NULL` | `sku_produto` | `varchar(30)` | SKU — `sku_produto` |
| 9 | `descricao_sku` | `text NULL` | `ds_sku` | `varchar(100)` | Descricao SKU — `ds_` |
| 10 | `tipo_wo` | `text NULL` | `ds_tipo_wo` | `varchar(20)` | Tipo WO — `ds_` |
| 11 | `data_fim_periodo` | `timestamp NULL` | `dt_fim_periodo` | `date` | Data fim periodo — `dt_` |
| 12 | `data_termino` | `timestamp NULL` | `dt_termino` | `date` | Data termino — `dt_` |
| 13 | `familia_produto` | `text NULL` | `ds_familia_produto` | `varchar(50)` | Familia — `ds_` |
| 14 | `tamanho` | `text NULL` | `ds_tamanho` | `varchar(10)` | Tamanho — `ds_` |
| 15 | `cor` | `text NULL` | `ds_cor` | `varchar(10)` | Cor — `ds_` |
| 16 | `referencia` | `text NULL` | `cod_referencia` | `varchar(10)` | Referencia — `cod_` |
| 17 | `periodo_producao` | `numeric(4) NULL` | `nr_periodo_producao` | `smallint` | Periodo — `nr_` |
| 18 | `pk_maquina` | `text NULL` | `ds_maquina` | `varchar(50)` | Maquina — `ds_` |
| 19 | `pk_maquina_num` | `text NULL` | `nr_maquina` | `varchar(10)` | Numero maquina — `nr_` |
| 20 | `qtde_quilos_prog` | `numeric(13,3) NULL` | `qt_quilos_programados` | `numeric(15,3)` | Quilos prog — `qt_` |
| 21 | `qtde_rolos_prog` | `numeric(10,2) NULL` | `qt_rolos_programados` | `numeric(15,3)` | Rolos prog — `qt_` |
| 22 | `qtde_rolos_prod` | `numeric(9,3) NULL` | `qt_rolos_produzidos` | `numeric(15,3)` | Rolos prod — `qt_` |
| 23 | `qtde_quilos_prod` | `numeric(9,3) NULL` | `qt_quilos_produzidos` | `numeric(15,3)` | Quilos prod — `qt_` |
| 24 | `quantidade` | `numeric(38,10) NULL` | `qt_total` | `numeric(15,3)` | `numeric(38,10)` → `numeric(15,3)` |
| 25 | `situacao` | `text NULL` | `ds_situacao` | `varchar(30)` | Situacao — `ds_` |
| 26 | `data_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 27 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_prior_benef_op ON jma.f_prioridade_beneficiamento_congelado (nr_ordem_producao);
```

---

### Tabela: `jma.fprioridade_tecelagem_conge` → `jma.f_prioridade_tecelagem_congelado`

**Tipo:** Fato
**Descricao:** Prioridade de ordens de tecelagem congeladas com lote, maquina, rolos e alternativas de roteiro.
**Sistema de origem:** Systextil/tecelagem

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `ordem_producao` | `numeric(6) NULL` | `nr_ordem_producao` | `integer NOT NULL` | OP — `nr_` |
| 3 | `prioridade` | `numeric(9) NULL` | `nr_prioridade` | `integer` | Prioridade — `nr_` |
| 4 | `work_order_id` | `text NULL` | `ds_work_order_id` | `varchar(20)` | WO ID — `ds_` |
| 5 | `work_center` | `text NULL` | `ds_work_center` | `varchar(50)` | Centro — `ds_` |
| 6 | `planta` | `text NULL` | `ds_planta` | `varchar(20)` | Planta — `ds_` |
| 7 | `cliente` | `text NULL` | `nm_cliente` | `varchar(50)` | Cliente — `nm_` |
| 8 | `sku` | `text NULL` | `sku_produto` | `varchar(30)` | SKU — `sku_produto` |
| 9 | `descricao_sku` | `text NULL` | `ds_sku` | `varchar(100)` | Descricao — `ds_` |
| 10 | `tipo_wo` | `text NULL` | `ds_tipo_wo` | `varchar(20)` | Tipo WO — `ds_` |
| 11 | `data_fim_periodo` | `timestamp NULL` | `dt_fim_periodo` | `date` | Data fim — `dt_` |
| 12 | `data_termino` | `timestamp NULL` | `dt_termino` | `date` | Data termino — `dt_` |
| 13 | `familia_produto` | `text NULL` | `ds_familia_produto` | `varchar(50)` | Familia — `ds_` |
| 14 | `tamanho` | `text NULL` | `ds_tamanho` | `varchar(10)` | Tamanho — `ds_` |
| 15 | `cor` | `text NULL` | `ds_cor` | `varchar(10)` | Cor — `ds_` |
| 16 | `referencia` | `text NULL` | `cod_referencia` | `varchar(10)` | Referencia — `cod_` |
| 17 | `alternativa_item` | `numeric(2) NULL` | `nr_alternativa_item` | `smallint` | Alternativa — `nr_` |
| 18 | `roteiro_opcional` | `numeric(2) NULL` | `nr_roteiro_opcional` | `smallint` | Roteiro opcional — `nr_` |
| 19 | `numero_lote` | `text NULL` | `nr_lote` | `varchar(20)` | Numero lote — `nr_` |
| 20 | `opcao_maquina` | `numeric(3) NULL` | `id_opcao_maquina` | `smallint` | Opcao maquina — `id_` |
| 21 | `periodo_producao` | `numeric(4) NULL` | `nr_periodo_producao` | `smallint` | Periodo — `nr_` |
| 22 | `pk_maquina` | `text NULL` | `ds_maquina` | `varchar(50)` | Maquina — `ds_` |
| 23 | `pk_maquina_num` | `text NULL` | `nr_maquina` | `varchar(10)` | Numero — `nr_` |
| 24 | `quantidade` | `numeric(38,10) NULL` | `qt_total` | `numeric(15,3)` | Qtd — `numeric(38,10)` → `numeric(15,3)` |
| 25 | `qtde_quilos_prog` | `numeric(12,3) NULL` | `qt_quilos_programados` | `numeric(15,3)` | Quilos prog — `qt_` |
| 26 | `qtde_rolos_prog` | `numeric(8,1) NULL` | `qt_rolos_programados` | `numeric(15,3)` | Rolos prog — `qt_` |
| 27 | `peso_rolo` | `numeric(8,3) NULL` | `ps_rolo` | `numeric(15,3)` | Peso rolo — `ps_` |
| 28 | `qtde_unidades_prog` | `numeric(15,3) NULL` | `qt_unidades_programadas` | `numeric(15,3)` | Unidades — `qt_` |
| 29 | `qtde_rolos_prod` | `numeric(8,1) NULL` | `qt_rolos_produzidos` | `numeric(15,3)` | Rolos prod — `qt_` |
| 30 | `cod_cancelamento` | `numeric(3) NULL` | `id_motivo_cancelamento` | `smallint` | Cancelamento — `id_` |
| 31 | `data_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 32 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_prior_tecel_op ON jma.f_prioridade_tecelagem_congelado (nr_ordem_producao);
```

---

### Tabela: `jma.fprod_marft` → `jma.f_producao_marft`

**Tipo:** Fato
**Descricao:** Producao na MARFT por OP/OS com dados de tecido, operacao, maquina, operador, tempos e quantidades de camadas/emendas.
**Sistema de origem:** MARFT

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `op` | `int4 NULL` | `nr_ordem_producao` | `integer NOT NULL` | OP — `nr_` |
| 3 | `os` | `int4 NULL` | `nr_ordem_servico` | `integer` | OS — `nr_` |
| 4 | `tip_prod` | `int2 NULL` | `id_tipo_producao` | `smallint` | Tipo — `id_` |
| 5 | `"Data"` | `timestamp NULL` | `dt_producao` | `date NOT NULL` | Data — `dt_`; UPPER_CASE → snake_case |
| 6 | `hora` | `timestamp NULL` | `dth_producao` | `timestamp` | Data+hora — `dth_` |
| 7 | `seq` | `int2 NULL` | `nr_seq` | `smallint` | Sequencial — `nr_` |
| 8 | `desc_prod` | `varchar(50) NULL` | `ds_produto` | `varchar(50)` | Descricao produto — `ds_` |
| 9 | `referencia` | `varchar(50) NULL` | `cod_referencia` | `varchar(10)` | Referencia — `cod_` |
| 10 | `produto` | `varchar(150) NULL` | `sku_produto` | `varchar(30)` | SKU — `sku_produto`; truncar |
| 11 | `operacao` | `varchar(80) NULL` | `ds_operacao` | `varchar(80)` | Operacao — `ds_` |
| 12 | `operationcode` | `varchar(20) NULL` | `ds_cod_operacao` | `varchar(20)` | Codigo operacao — `ds_` |
| 13 | `tecido` | `varchar(90) NULL` | `sku_tecido` | `varchar(30)` | SKU tecido — `sku_tecido`; truncar |
| 14 | `grupo` | `varchar(70) NULL` | `ds_grupo` | `varchar(70)` | Grupo — `ds_` |
| 15 | `"S.U."` | `varchar(20) NULL` | `ds_su` | `varchar(20)` | S.U. — UPPER_CASE → snake_case |
| 16 | `camada` | `int2 NULL` | `qt_camadas` | `smallint` | Qtd camadas — `qt_` |
| 17 | `tempo_total` | `numeric(18,3) NULL` | `nr_tempo_total` | `numeric(15,3)` | Tempo total — `nr_` |
| 18 | `tempo_peca` | `numeric(18,3) NULL` | `nr_tempo_peca` | `numeric(15,3)` | Tempo por peca — `nr_` |
| 19 | `carga` | `numeric(18,3) NULL` | `vl_carga` | `numeric(15,3)` | Carga — `vl_` |
| 20 | `oper` | `int8 NULL` | `id_operador` | `integer` | Operador — `id_` |
| 21 | `operador` | `varchar(150) NULL` | `nm_operador` | `varchar(100)` | Nome — `nm_`; truncar |
| 22 | `temp_prep` | `numeric(18,3) NULL` | `nr_tempo_preparacao` | `numeric(15,3)` | Tempo prep — `nr_` |
| 23 | `temp_conclus` | `numeric(18,3) NULL` | `nr_tempo_conclusao` | `numeric(15,3)` | Tempo conclusao — `nr_` |
| 24 | `comp_total` | `numeric(18,3) NULL` | `vl_comprimento_total` | `numeric(15,3)` | Comprimento — `vl_` |
| 25 | `tempo_tot_camada` | `numeric(18,3) NULL` | `nr_tempo_total_camada` | `numeric(15,3)` | Tempo total camada — `nr_` |
| 26 | `tempo_camada` | `numeric(18,3) NULL` | `nr_tempo_camada` | `numeric(15,3)` | Tempo camada — `nr_` |
| 27 | `qtd_emenda` | `numeric(18,3) NULL` | `qt_emendas` | `numeric(15,3)` | Emendas — `qt_` |
| 28 | `temp_emend` | `numeric(18,3) NULL` | `nr_tempo_emenda` | `numeric(15,3)` | Tempo emenda — `nr_` |
| 29 | `qtd_ton` | `numeric(18,3) NULL` | `qt_tonalidades` | `numeric(15,3)` | Tonalidades — `qt_` |
| 30 | `tempo_ton` | `numeric(18,3) NULL` | `nr_tempo_tonalidade` | `numeric(15,3)` | Tempo tonalidade — `nr_` |
| 31 | `qtd_troca` | `numeric(18,3) NULL` | `qt_trocas_rolo` | `numeric(15,3)` | Trocas de rolo — `qt_` |
| 32 | `tempo_troca_rolo` | `numeric(18,3) NULL` | `nr_tempo_troca_rolo` | `numeric(15,3)` | Tempo troca — `nr_` |
| 33 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 34 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_producao_marft_op ON jma.f_producao_marft (nr_ordem_producao);
CREATE INDEX idx_f_producao_marft_dt ON jma.f_producao_marft (dt_producao);
CREATE INDEX idx_f_producao_marft_tecido ON jma.f_producao_marft (sku_tecido);
```

---

### Tabela: `jma.freq_almoxarifado` → `jma.f_requisicao_almoxarifado`

**Tipo:** Fato
**Descricao:** Requisicoes ao almoxarifado com situacao, produto, deposito, quantidades e receptor.
**Sistema de origem:** Systextil/almoxarifado

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `num_requisicao` | `numeric(6) NULL` | `nr_requisicao` | `integer NOT NULL` | Numero requisicao — `nr_` |
| 3 | `ordem_producao` | `numeric(9) NULL` | `nr_ordem_producao` | `integer` | OP — `nr_` |
| 4 | `ccusto_destino` | `int4 NULL` | `id_centro_custo_destino` | `integer` | Centro custo destino — `id_` |
| 5 | `data_requis` | `timestamp NULL` | `dt_requisicao` | `date NOT NULL` | Data — `dt_` |
| 6 | `requisitante` | `varchar(50) NULL` | `nm_requisitante` | `varchar(50)` | Nome — `nm_` |
| 7 | `situacao_capa` | `varchar(32) NULL` | `ds_situacao_capa` | `varchar(32)` | Situacao capa — `ds_` |
| 8 | `situacao` | `varchar(32) NULL` | `ds_situacao_item` | `varchar(32)` | Situacao item — `ds_` |
| 9 | `referencia` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | Referencia — `cod_` |
| 10 | `conta_estoque` | `int2 NULL` | `id_conta_estoque` | `smallint` | Conta estoque — `id_` |
| 11 | `pk_produto` | `varchar(25) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 12 | `um` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(2)` | Unidade — `ds_` |
| 13 | `deposito` | `int2 NULL` | `cod_deposito` | `smallint` | Deposito — `cod_` |
| 14 | `observacao` | `varchar(120) NULL` | `obs_requisicao` | `text` | Observacao — `obs_` |
| 15 | `qtde_requisitada` | `numeric(18,3) NULL` | `qt_requisitada` | `numeric(15,3) NOT NULL DEFAULT 0` | Qtd requisitada — `qt_` |
| 16 | `a_receber` | `numeric(18,3) NULL` | `qt_a_receber` | `numeric(15,3)` | Saldo a receber — `qt_` |
| 17 | `estoque` | `numeric(18,3) NULL` | `qt_estoque` | `numeric(15,3)` | Estoque disponivel — `qt_` |
| 18 | `ult_compra` | `numeric(18,3) NULL` | `vl_ult_compra` | `numeric(15,2)` | Ultimo preco compra — `vl_` |
| 19 | `data_entregue` | `timestamp NULL` | `dt_entregue` | `date` | Data entrega — `dt_` |
| 20 | `codigo_transacao` | `int2 NULL` | `id_tipo_transacao` | `smallint` | Tipo transacao — `id_` |
| 21 | `usuario_receptor` | `varchar(200) NULL` | `nm_receptor` | `varchar(100)` | Receptor — `nm_`; truncar |
| 22 | `almoxarife` | `varchar(20) NULL` | `nm_almoxarife` | `varchar(20)` | Almoxarife — `nm_` |
| 23 | `sequencia` | `int2 NULL` | `nr_sequencia` | `smallint` | Sequencial — `nr_` |
| 24 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 25 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_req_almox_produto ON jma.f_requisicao_almoxarifado (sku_produto);
CREATE INDEX idx_f_req_almox_op ON jma.f_requisicao_almoxarifado (nr_ordem_producao);
CREATE INDEX idx_f_req_almox_dt ON jma.f_requisicao_almoxarifado (dt_requisicao);
```

---

### Tabela: `jma.frequisicoes_compra` → `jma.f_requisicao_compra`

**Tipo:** Fato
**Descricao:** Requisicoes de compra com produto, fornecedor, quantidades, precos e dados de estoque atual.
**Sistema de origem:** Systextil/compras

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `num_requisicao` | `numeric(6) NULL` | `nr_requisicao` | `integer NOT NULL` | Numero — `nr_` |
| 3 | `seq_item_req` | `numeric(2) NULL` | `nr_seq_item` | `smallint NOT NULL` | Sequencial — `nr_` |
| 4 | `fk_produto` | `text NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 5 | `fk_fornecedor` | `text NULL` | `cod_fornecedor` | `varchar(18)` | Join key fornecedor — `cod_` |
| 6 | `codigo_deposito` | `numeric(3) NULL` | `cod_deposito` | `smallint` | Deposito — `cod_` |
| 7 | `data_requisicao` | `timestamp NULL` | `dt_requisicao` | `date NOT NULL` | Data — `dt_` |
| 8 | `nome_requisit` | `text NULL` | `nm_requisitante` | `varchar(100)` | Nome — `nm_` |
| 9 | `observacao_req` | `text NULL` | `obs_requisicao` | `text` | Observacao — `obs_` |
| 10 | `data_prev_entr_req` | `timestamp NULL` | `dt_prev_entrega_req` | `date` | Previsao entrega — `dt_` |
| 11 | `situacao_codigo` | `numeric(1) NULL` | `id_situacao` | `smallint` | Situacao codigo — `id_` |
| 12 | `situacao` | `text NULL` | `ds_situacao` | `varchar(50)` | Situacao textual — `ds_` |
| 13 | `pedido_compra` | `numeric(6) NULL` | `nr_pedido_compra` | `integer` | Pedido de compra — `nr_` |
| 14 | `data_prev_entr_ped` | `timestamp NULL` | `dt_prev_entrega_pedido` | `date` | Previsao entrega pedido — `dt_` |
| 15 | `unidade_medida` | `text NULL` | `ds_unidade_medida` | `varchar(5)` | Unidade — `ds_` |
| 16 | `qtde_requisitada` | `numeric(15,3) NULL` | `qt_requisitada` | `numeric(15,3) NOT NULL DEFAULT 0` | Qtd — `qt_` |
| 17 | `qtde_pedida_item` | `numeric(15,3) NULL` | `qt_pedida` | `numeric(15,3)` | Qtd pedida — `qt_` |
| 18 | `valor_unitario` | `numeric(20,5) NULL` | `vl_unitario` | `numeric(15,2)` | Valor — `vl_` |
| 19 | `ultimaentrada` | `timestamp NULL` | `dth_ultima_entrada` | `timestamp` | Data ultima entrada — `dth_` |
| 20 | `ultimasaida` | `timestamp NULL` | `dth_ultima_saida` | `timestamp` | Data ultima saida — `dth_` |
| 21 | `estoqueatual` | `numeric(38,10) NULL` | `qt_estoque_atual` | `numeric(15,3)` | Estoque atual — `qt_`; `numeric(38,10)` → `numeric(15,3)` |
| 22 | `qtdsugerida` | `numeric(38,10) NULL` | `qt_sugerida` | `numeric(15,3)` | Qtd sugerida — `qt_` |
| 23 | `precoultentrada` | `numeric(38,10) NULL` | `vl_preco_ult_entrada` | `numeric(15,2)` | Preco ult entrada — `vl_` |
| 24 | `estoquemin` | `numeric(38,10) NULL` | `qt_estoque_minimo` | `numeric(15,3)` | Estoque minimo — `qt_` |
| 25 | `estoquemax` | `numeric(38,10) NULL` | `qt_estoque_maximo` | `numeric(15,3)` | Estoque maximo — `qt_` |
| 26 | `consumomedmes` | `numeric(38,10) NULL` | `qt_consumo_medio_mes` | `numeric(15,3)` | Consumo medio — `qt_` |
| 27 | `consumopordia` | `numeric(38,10) NULL` | `qt_consumo_dia` | `numeric(15,3)` | Consumo diario — `qt_` |
| 28 | `ult_forn` | `text NULL` | `nm_ult_fornecedor` | `varchar(100)` | Ultimo fornecedor — `nm_` |
| 29 | `ult_ped` | `numeric(6) NULL` | `nr_ult_pedido` | `integer` | Ultimo pedido — `nr_` |
| 30 | `qtd_ult_ped` | `numeric(38,10) NULL` | `qt_ult_pedido` | `numeric(15,3)` | Qtd ultimo pedido — `qt_` |
| 31 | `quantidade_nf` | `numeric(38,10) NULL` | `qt_quantidade_nf` | `numeric(15,3)` | Qtd NF — `qt_` |
| 32 | `valor_total_nf` | `numeric(38,10) NULL` | `vl_total_nf` | `numeric(15,2)` | Valor NF — `vl_` |
| 33 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 34 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_req_compra_produto ON jma.f_requisicao_compra (sku_produto);
CREATE INDEX idx_f_req_compra_nr ON jma.f_requisicao_compra (nr_requisicao);
```
**Notas ETL:** Converter `numeric(38,10)` (heranca Oracle) para tipos adequados. Tabela sem campo de atualizacao — adicionar.

---

### Tabela: `jma.froteiro` → `jma.f_roteiro`

**Tipo:** Fato/Relacional
**Descricao:** Roteiros de producao com sequencia de operacoes, estagios, tempos e centros de custo por produto.
**Sistema de origem:** Systextil/engenharia de producao

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `varchar(20) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 3 | `num_roteiro` | `int2 NULL` | `nr_roteiro` | `smallint NOT NULL` | Numero roteiro — `nr_` |
| 4 | `seq_operacao` | `int2 NULL` | `nr_seq_operacao` | `smallint NOT NULL` | Sequencial — `nr_` |
| 5 | `fk_operacao` | `int4 NULL` | `id_operacao` | `integer` | Operacao — `id_`; remover `fk_` |
| 6 | `fk_estagio` | `int2 NULL` | `id_estagio` | `smallint` | Estagio — `id_`; remover `fk_` |
| 7 | `seq_estagio` | `int2 NULL` | `nr_seq_estagio` | `smallint` | Sequencial estagio — `nr_` |
| 8 | `estagio_depende` | `int2 NULL` | `id_estagio_dependente` | `smallint` | Dependencia — `id_` |
| 9 | `qtd_rolos` | `int4 NULL` | `qt_rolos` | `integer` | Qtd rolos — `qt_` |
| 10 | `qtd_cordas` | `int4 NULL` | `qt_cordas` | `integer` | Qtd cordas — `qt_` |
| 11 | `observacao_roteiro` | `varchar(200) NULL` | `obs_roteiro` | `text` | Observacao — `obs_` |
| 12 | `centro_custo` | `int4 NULL` | `id_centro_custo` | `integer` | Centro custo — `id_` |
| 13 | `ccusto_homem` | `int4 NULL` | `id_centro_custo_homem` | `integer` | Centro custo mao obra — `id_` |
| 14 | `minutos_roteiro` | `numeric(18,3) NULL` | `nr_minutos_roteiro` | `numeric(15,3)` | Tempo — `nr_` |
| 15 | `velocidade` | `numeric(18,3) NULL` | `vl_velocidade` | `numeric(15,3)` | Velocidade — `vl_` |
| 16 | `minutos_homem` | `numeric(18,3) NULL` | `nr_minutos_homem` | `numeric(15,3)` | Min homem — `nr_` |
| 17 | `alternativa_item` | `int4 NULL` | `nr_alternativa_item` | `integer` | Alternativa — `nr_` |
| 18 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 19 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_roteiro_produto ON jma.f_roteiro (sku_produto);
CREATE INDEX idx_f_roteiro_nr ON jma.f_roteiro (nr_roteiro);
```

---

### Tabela: `jma.froteiro_em_producao` → `jma.f_roteiro_em_producao`

**Tipo:** Fato
**Descricao:** Roteiros ativos em producao com tempos de maquina e homem, numero de agulhas e custo por minuto.
**Sistema de origem:** Systextil/producao

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `varchar(111) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto`; truncar |
| 3 | `fk_maquina` | `varchar(39) NULL` | `ds_maquina` | `varchar(39)` | Maquina — `ds_`; remover `fk_` |
| 4 | `numero_alternati` | `int2 NULL` | `nr_alternativa_item` | `smallint` | Alternativa — `nr_` |
| 5 | `numero_roteiro` | `int2 NULL` | `nr_roteiro` | `smallint` | Roteiro — `nr_` |
| 6 | `seq_operacao` | `int2 NULL` | `nr_seq_operacao` | `smallint` | Sequencial operacao — `nr_` |
| 7 | `codigo_operacao` | `int4 NULL` | `id_operacao` | `integer` | Operacao — `id_` |
| 8 | `codigo_estagio` | `int4 NULL` | `id_estagio` | `smallint` | Estagio — `id_` |
| 9 | `nr_agulhas` | `int2 NULL` | `qt_agulhas` | `smallint` | Qtd agulhas — `qt_` |
| 10 | `tempo_maquina` | `numeric(18,3) NULL` | `nr_tempo_maquina` | `numeric(15,3)` | Tempo maquina — `nr_` |
| 11 | `custo_homem` | `int4 NULL` | `id_custo_homem` | `integer` | Custo homem (codigo) — `id_` |
| 12 | `custo_minuto` | `numeric(18,3) NULL` | `vl_custo_minuto` | `numeric(15,4)` | Custo por minuto — `vl_` |
| 13 | `tempo_homem` | `numeric(18,3) NULL` | `nr_tempo_homem` | `numeric(15,3)` | Tempo homem — `nr_` |
| 14 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 15 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_rot_prod_produto ON jma.f_roteiro_em_producao (sku_produto);
```

---

### Tabela: `jma.ftabelapreco` → `jma.f_tabela_preco_item`

**Tipo:** Fato
**Descricao:** Precos por produto e tabela de preco com valor com e sem desconto.
**Sistema de origem:** Systextil/comercial

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `fk_produto` | `varchar(50) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto` |
| 3 | `tabela_preco` | `varchar(10) NULL` | `cod_tabela_preco` | `varchar(10) NOT NULL` | Join key tabela — `cod_` |
| 4 | `tabela_preco_cod` | `varchar(10) NULL` | `ds_tabela_preco_cod` | `varchar(10)` | Codigo alternativo — `ds_` |
| 5 | `grupo_estrutura` | `varchar(10) NULL` | `ds_grupo_estrutura` | `varchar(10)` | Grupo estrutura — `ds_` |
| 6 | `vlr_com_desconto` | `numeric(18,3) NULL` | `vl_com_desconto` | `numeric(15,2)` | Valor com desconto — `vl_` |
| 7 | `val_tabela_preco` | `numeric(18,3) NULL` | `vl_tabela_preco` | `numeric(15,2)` | Valor tabela — `vl_` |
| 8 | `tabela_preco_grupo` | `numeric(25,6) NULL` | `id_grupo_tabela` | `integer` | Grupo da tabela — `id_`; precisao excessiva |
| 9 | `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_tab_preco_produto ON jma.f_tabela_preco_item (sku_produto, cod_tabela_preco);
```

---

### Tabela: `jma.ftempo_metodos` → `jma.f_tempo_metodo`

**Tipo:** Fato
**Descricao:** Tempos de metodos por produto, roteiro e estagio/operacao com custo por minuto e numero de agulhas.
**Sistema de origem:** Systextil/engenharia de producao

> **Nota:** `tempo_homem varchar NULL` e `tempo_maquina varchar NULL` — tipo `varchar` sem tamanho e sem conteudo definido. Investigar se sao campos numericos armazenados como string.

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_produto` | `varchar(111) NULL` | `sku_produto` | `varchar(30) NOT NULL` | Join key produto — `sku_produto`; truncar |
| 3 | `pk_maquina` | `varchar(39) NULL` | `ds_maquina` | `varchar(39)` | Maquina — `ds_` |
| 4 | `alt` | `int2 NULL` | `nr_alternativa_item` | `smallint` | Alternativa — `nr_` |
| 5 | `rot` | `int2 NULL` | `nr_roteiro` | `smallint` | Roteiro — `nr_` |
| 6 | `sub_grupo` | `varchar(3) NULL` | `ds_sub_grupo` | `varchar(3)` | Sub-grupo — `ds_` |
| 7 | `codigo_estagio` | `int4 NULL` | `id_estagio` | `smallint` | Estagio — `id_` |
| 8 | `codigo_operacao` | `int4 NULL` | `id_operacao` | `integer` | Operacao — `id_` |
| 9 | `agulhas` | `varchar(3) NULL` | `qt_agulhas` | `smallint` | Agulhas — `qt_`; converter de string |
| 10 | `custo_homem` | `numeric(18,3) NULL` | `vl_custo_homem` | `numeric(15,4)` | Custo homem — `vl_` |
| 11 | `custo_minuto` | `numeric(18,3) NULL` | `vl_custo_minuto` | `numeric(15,4)` | Custo minuto — `vl_` |
| 12 | `tempo_homem` | `varchar NULL` | `nr_tempo_homem` | `numeric(15,3)` | Tempo — converter de varchar; investigar formato |
| 13 | `tempo_maquina` | `varchar NULL` | `nr_tempo_maquina` | `numeric(15,3)` | Tempo — converter de varchar; investigar formato |
| 14 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 15 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_tempo_metodo_produto ON jma.f_tempo_metodo (sku_produto, nr_roteiro);
```
**Notas ETL:** `tempo_homem varchar` e `tempo_maquina varchar` — verificar dados antes de converter para `numeric`. `agulhas varchar(3)` — converter para `smallint`.

---

### Tabela: `jma.ftitulos_receber` → `jma.f_titulo_receber`

**Tipo:** Fato
**Descricao:** Titulos a receber (duplicatas) com vencimento, cliente, portador, comissao e situacao de pagamento.
**Sistema de origem:** Systextil/financeiro

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pk_cliente` | `text NULL` | `cod_cliente` | `varchar(20) NOT NULL` | Join key cliente — `cod_` |
| 3 | `cnpj_cliente` | `text NULL` | `cnpj_cliente` | `varchar(16)` | CNPJ — formato padrao; nome ja correto |
| 4 | `codigo_empresa` | `numeric(3) NULL` | `id_empresa` | `smallint NOT NULL` | Empresa — `id_` |
| 5 | `num_duplicata` | `numeric(9) NULL` | `nr_duplicata` | `integer NOT NULL` | Numero duplicata — `nr_` |
| 6 | `seq_duplicatas` | `numeric(2) NULL` | `nr_seq_duplicata` | `smallint NOT NULL` | Sequencial — `nr_` |
| 7 | `cod_chave_nota` | `text NULL` | `ds_chave_nota` | `varchar(50)` | Chave nota — `ds_` |
| 8 | `num_titulo` | `text NULL` | `nr_titulo` | `varchar(30)` | Numero titulo — `nr_` |
| 9 | `portador_duplic` | `numeric(3) NULL` | `cod_portador` | `smallint` | Join key portador — `cod_portador` (secao 11) |
| 10 | `cod_rep_cliente` | `numeric(5) NULL` | `cod_representante` | `varchar(6)` | Join key representante — `cod_` |
| 11 | `data_emissao` | `timestamp NULL` | `dt_emissao` | `date NOT NULL` | Data — `dt_` |
| 12 | `numero_remessa` | `numeric(7) NULL` | `nr_remessa` | `integer` | Numero remessa — `nr_` |
| 13 | `ind_previsao` | `numeric(1) NULL` | `fl_previsao` | `boolean` | Flag — `boolean` |
| 14 | `num_titulo_banco` | `text NULL` | `nr_titulo_banco` | `varchar(30)` | Numero banco — `nr_` |
| 15 | `num_pedido` | `numeric(9) NULL` | `nr_pedido_venda` | `integer` | Numero pedido — `nr_` |
| 16 | `per_comiss` | `numeric(6,2) NULL` | `pc_comissao` | `numeric(7,4)` | Percentual comissao — `pc_` |
| 17 | `cod_motivo_cancel` | `numeric(2) NULL` | `id_motivo_cancelamento` | `smallint` | Cancelamento — `id_` |
| 18 | `des_motivo_cancel` | `text NULL` | `ds_motivo_cancelamento` | `varchar(100)` | Descricao — `ds_` |
| 19 | `cod_forma_pagto` | `numeric(2) NULL` | `id_forma_pagto` | `smallint` | Forma pagamento — `id_` |
| 20 | `dat_cancel` | `timestamp NULL` | `dt_cancelamento` | `date` | Data cancelamento — `dt_` |
| 21 | `dat_ult_pagto_aux` | `timestamp NULL` | `dt_ultimo_pagamento` | `date` | Ultimo pagamento — `dt_` |
| 22 | `cod_tipo_duplic` | `numeric(2) NULL` | `id_tipo_duplicata` | `smallint` | Tipo duplicata — `id_` |
| 23 | `des_tipo_duplic` | `text NULL` | `ds_tipo_duplicata` | `varchar(50)` | Descricao — `ds_` |
| 24 | `des_cod_tipo_duplic` | `text NULL` | `ds_tipo_duplicata_cod` | `varchar(50)` | Codigo+desc — `ds_` |
| 25 | `cod_posicao_duplic` | `numeric(2) NULL` | `id_posicao_duplicata` | `smallint` | Posicao — `id_` |
| 26 | `des_posicao_duplic` | `text NULL` | `ds_posicao_duplicata` | `varchar(50)` | Descricao — `ds_` |
| 27 | `des_situa_duplic` | `text NULL` | `ds_situacao_duplicata` | `varchar(50)` | Situacao — `ds_` |
| 28 | `des_situa_aberta_baixada` | `text NULL` | `ds_situacao_aberta_baixada` | `varchar(20)` | Aberta/Baixada — `ds_` |
| 29 | `cod_situa_duplic` | `numeric(1) NULL` | `id_situacao_duplicata` | `smallint` | Codigo situacao — `id_` |
| 30 | `cod_cidade` | `numeric(5) NULL` | `id_cidade` | `integer` | Cidade — `id_` |
| 31 | `dat_vencto_aux` | `timestamp NULL` | `dt_vencimento` | `date` | Vencimento — `dt_` |
| 32 | `dat_vencto_original_aux` | `timestamp NULL` | `dt_vencimento_original` | `date` | Vencimento original — `dt_` |
| 33 | `sit_vencto` | `text NULL` | `ds_situacao_vencimento` | `varchar(20)` | Situacao vencimento — `ds_` |
| 34 | `val_aberto` | `numeric(15,2) NULL` | `vl_aberto` | `numeric(15,2)` | Valor aberto — `vl_` |
| 35 | `val_comiss` | `numeric(15,2) NULL` | `vl_comissao` | `numeric(15,2)` | Valor comissao — `vl_` |
| 36 | `val_titulo` | `numeric(15,2) NULL` | `vl_titulo` | `numeric(15,2) NOT NULL DEFAULT 0` | Valor titulo — `vl_` |
| 37 | `cod_conta_contabil` | `numeric(6) NULL` | `id_conta_contabil` | `integer` | Conta contabil — `id_` |
| 38 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 39 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Relacionamentos:**
```
jma.f_titulo_receber
  |- cod_cliente       -> live.d_cliente.cod_cliente
  |- cod_portador      -> d_portador.cod_portador
  |- cod_representante -> comercial.d_representante.cod_representante
```
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_titulo_receber_cliente ON jma.f_titulo_receber (cod_cliente);
CREATE INDEX idx_f_titulo_receber_vencto ON jma.f_titulo_receber (dt_vencimento);
CREATE INDEX idx_f_titulo_receber_nr ON jma.f_titulo_receber (nr_duplicata, nr_seq_duplicata);
CREATE INDEX idx_f_titulo_receber_cnpj ON jma.f_titulo_receber (cnpj_cliente);
```

---

### Tabela: `jma.fvendas_url` → `jma.f_venda_url`

**Tipo:** Fato
**Descricao:** Vendas do canal URL/ecommerce com NF, comissoes, loja, vendedor e motivo de devolucao.
**Sistema de origem:** URL (ecommerce)

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id_surrogate` | `bigserial NOT NULL` | Surrogate key |
| 2 | `id` | `numeric(10) NULL` | `nr_seq` | `integer` | Sequencial origem — `nr_` |
| 3 | `pedido` | `numeric(9) NULL` | `nr_pedido` | `integer NOT NULL` | Numero pedido — `nr_` |
| 4 | `nota_fiscal` | `numeric(9) NULL` | `nr_nota_fiscal` | `integer` | NF — `nr_` |
| 5 | `"DATA"` | `timestamp NULL` | `dt_venda` | `date NOT NULL` | Data — `dt_`; UPPER_CASE → snake_case |
| 6 | `data_emissao` | `timestamp NULL` | `dt_emissao` | `date` | Data emissao NF — `dt_` |
| 7 | `quantidade` | `numeric(15,3) NULL` | `qt_total` | `numeric(15,3) NOT NULL DEFAULT 0` | Quantidade — `qt_` |
| 8 | `valor_faturado` | `numeric(15,3) NULL` | `vl_faturado` | `numeric(15,2)` | Valor — `vl_` |
| 9 | `canal` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | Canal — `ds_` |
| 10 | `cnpj` | `varchar(15) NULL` | `cnpj_cliente` | `varchar(16)` | CNPJ cliente — formato padrao |
| 11 | `serie_nota_fiscal` | `varchar(3) NULL` | `nr_serie_nota_fiscal` | `varchar(3)` | Serie — `nr_` |
| 12 | `pedido_cliente` | `varchar(30) NULL` | `cod_pedido_cliente` | `varchar(30)` | Referencia cliente — `cod_` |
| 13 | `cupom` | `varchar(35) NULL` | `ds_cupom` | `varchar(35)` | Cupom — `ds_` |
| 14 | `loja` | `varchar(65) NULL` | `nm_loja` | `varchar(65)` | Nome loja — `nm_` |
| 15 | `cpf_vendedor` | `varchar(11) NULL` | `cpf_vendedor` | `varchar(12)` | CPF vendedor — formato `XXXXXXXXX-ZZ` |
| 16 | `cnpj_loja` | `varchar(15) NULL` | `cnpj_loja` | `varchar(16)` | CNPJ loja — formato padrao |
| 17 | `nota_entrada` | `float8 NULL` | `nr_nota_entrada` | `integer` | NF entrada — `nr_`; `float8` → `integer` |
| 18 | `nota_saida` | `float8 NULL` | `nr_nota_saida` | `integer` | NF saida — `nr_`; `float8` → `integer` |
| 19 | `motivo_devolucao` | `varchar(400) NULL` | `ds_motivo_devolucao` | `text` | Motivo — `ds_`; `text` para tamanho livre |
| 20 | `flag_tipo` | `varchar(3) NULL` | `ds_tipo_movimento` | `varchar(3)` | Tipo (VEN/DEV) — `ds_` |
| 21 | `tipo_cliente` | `varchar(100) NULL` | `ds_tipo_cliente` | `varchar(100)` | Tipo cliente — `ds_` |
| 22 | `cliente` | `varchar(100) NULL` | `nm_cliente` | `varchar(100)` | Nome cliente — `nm_` |
| 23 | `tipo_cupom` | `varchar(100) NULL` | `ds_tipo_cupom` | `varchar(100)` | Tipo cupom — `ds_` |
| 24 | `vendedor` | `varchar(255) NULL` | `nm_vendedor` | `varchar(100)` | Nome vendedor — `nm_`; truncar |
| 25 | `valor_comissao` | `numeric(18,3) NULL` | `vl_comissao` | `numeric(15,2)` | Comissao — `vl_` |
| 26 | `grupo_loja` | `varchar(100) NULL` | `ds_grupo_loja` | `varchar(100)` | Grupo loja — `ds_` |
| 27 | `tela` | `varchar(10) NULL` | `ds_tela` | `varchar(10)` | Tela de origem — `ds_` |
| 28 | `omnichannel` | `varchar(3) NULL` | `fl_omnichannel` | `boolean` | Flag — `boolean` |
| 29 | `fornecedor` | `varchar(55) NULL` | `nm_fornecedor` | `varchar(55)` | Fornecedor — `nm_` |
| 30 | `percentual_comissao` | `numeric(18,3) NULL` | `pc_comissao` | `numeric(7,4)` | Percentual — `pc_` |
| 31 | `valor_comissao_ktl` | `numeric(18,3) NULL` | `vl_comissao_ktl` | `numeric(15,2)` | Comissao KTL — `vl_` |
| 32 | `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria padrao |
| 33 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id_surrogate bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_venda_url_pedido ON jma.f_venda_url (nr_pedido);
CREATE INDEX idx_f_venda_url_loja ON jma.f_venda_url (cnpj_loja, dt_venda);
CREATE INDEX idx_f_venda_url_nf ON jma.f_venda_url (nr_nota_fiscal);
```

---

### Tabela: `jma.ped_cong_motivo_bloqueio` → `jma.f_pedido_congelado_motivo_bloqueio`

**Tipo:** Fato/Operacional
**Descricao:** Motivos de bloqueio de pedidos congelados com historico de liberacao.
**Sistema de origem:** Systextil/logistica

| # | Nome Atual | Tipo Atual | Nome Proposto | Tipo Proposto | Justificativa |
|---|-----------|-----------|---------------|---------------|---------------|
| 1 | — | — | `id` | `bigserial NOT NULL` | Surrogate key obrigatoria |
| 2 | `pedido_venda` | `int4 NULL` | `nr_pedido_venda` | `integer NOT NULL` | Numero pedido — `nr_` |
| 3 | `seq_situacao` | `int2 NULL` | `nr_seq_situacao` | `smallint NOT NULL` | Sequencial — `nr_` |
| 4 | `codigo_situacao` | `int2 NULL` | `id_situacao_bloqueio` | `smallint` | Situacao — `id_` |
| 5 | `flag_liberacao` | `varchar(1) NULL` | `fl_liberado` | `boolean` | Flag — `boolean` |
| 6 | `data_situacao` | `timestamp NULL` | `dth_situacao` | `timestamp NOT NULL` | Data+hora situacao — `dth_` |
| 7 | `data_liberacao` | `timestamp NULL` | `dth_liberacao` | `timestamp` | Data+hora liberacao — `dth_` |
| 8 | `data_congelamento` | `timestamp NULL` | `dth_congelamento` | `timestamp` | Data+hora congelamento — `dth_` |
| 9 | — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |
| 10 | — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria obrigatoria |

**PK:** `id bigserial PRIMARY KEY`
**Indices sugeridos:**
```sql
CREATE INDEX idx_f_ped_cong_bloqueio_nr ON jma.f_pedido_congelado_motivo_bloqueio (nr_pedido_venda);
```
**Notas ETL:** Tabela sem campo de atualizacao — adicionar auditoria. `flag_liberacao varchar(1)` → `fl_liberado boolean`.

---

## 4. Indices Consolidados por Tabela

> Todos os comandos abaixo devem ser executados **apos** as migracoes de renomeacao de coluna/tabela. Os indices sao nomeados seguindo o padrao `idx_<tabela>_<descricao>` (max 63 chars no PostgreSQL).

### 4.1 Dimensoes

```sql
-- jma.d_aparelho
CREATE UNIQUE INDEX uq_d_aparelho_cod ON jma.d_aparelho (cod_aparelho);

-- jma.d_canal_distribuicao  (se mantida — ver nota de deprecacao)
CREATE UNIQUE INDEX uq_d_canal_dist_cod ON jma.d_canal_distribuicao (cod_canal);

-- jma.d_cfop
CREATE UNIQUE INDEX uq_d_cfop_cod ON jma.d_cfop (cod_cfop);

-- jma.d_colecao
CREATE UNIQUE INDEX uq_d_colecao_cod ON jma.d_colecao (cod_colecao);

-- jma.d_condicao_pgto
CREATE UNIQUE INDEX uq_d_condicao_pgto_cod ON jma.d_condicao_pgto (cod_condicao);

-- jma.d_familia_materiais
CREATE UNIQUE INDEX uq_d_familia_mat_cod ON jma.d_familia_materiais (cod_familia);

-- jma.d_funcionarios_integ
CREATE UNIQUE INDEX uq_d_func_integ_cod ON jma.d_funcionarios_integ (cod_funcionario);
CREATE INDEX idx_d_func_integ_loja ON jma.d_funcionarios_integ (cnpj_loja);

-- jma.d_grupo_produto
CREATE UNIQUE INDEX uq_d_grupo_prod_cod ON jma.d_grupo_produto (cod_grupo);

-- jma.d_marca
CREATE UNIQUE INDEX uq_d_marca_cod ON jma.d_marca (cod_marca);

-- jma.d_maquina
CREATE UNIQUE INDEX uq_d_maquina_cod ON jma.d_maquina (cod_maquina);

-- jma.d_motivo_devolucao
CREATE UNIQUE INDEX uq_d_motivo_dev_cod ON jma.d_motivo_devolucao (cod_motivo);

-- jma.d_operacao_fiscal
CREATE UNIQUE INDEX uq_d_op_fiscal_cod ON jma.d_operacao_fiscal (cod_operacao);

-- jma.d_periodo_producao
CREATE UNIQUE INDEX uq_d_periodo_prod_cod ON jma.d_periodo_producao (cod_periodo);

-- jma.d_produto_producao
CREATE UNIQUE INDEX uq_d_prod_prod_sku ON jma.d_produto_producao (sku_produto);
CREATE INDEX idx_d_prod_prod_ref ON jma.d_produto_producao (cod_referencia);
CREATE INDEX idx_d_prod_prod_familia ON jma.d_produto_producao (cod_familia);

-- jma.d_representante
CREATE UNIQUE INDEX uq_d_representante_cod ON jma.d_representante (cod_representante);
CREATE INDEX idx_d_representante_uf ON jma.d_representante (uf_atuacao);

-- jma.d_secao
CREATE UNIQUE INDEX uq_d_secao_cod ON jma.d_secao (cod_secao);

-- jma.d_setor
CREATE UNIQUE INDEX uq_d_setor_cod ON jma.d_setor (cod_setor);

-- jma.d_tabela_preco
CREATE UNIQUE INDEX uq_d_tabela_preco_cod ON jma.d_tabela_preco (cod_tabela);

-- jma.d_transportadora
CREATE UNIQUE INDEX uq_d_transportadora_cnpj ON jma.d_transportadora (cnpj_transportadora);
CREATE INDEX idx_d_transportadora_nome ON jma.d_transportadora (nm_transportadora);
```

### 4.2 Fatos e Tabelas Operacionais

```sql
-- jma.f_conferencia_caixas
CREATE INDEX idx_f_conf_caixas_nf ON jma.f_conferencia_caixas (nr_nota_fiscal);
CREATE INDEX idx_f_conf_caixas_dt ON jma.f_conferencia_caixas (dt_conferencia);

-- jma.f_credito_orcamento
CREATE INDEX idx_f_cred_orc_cnpj ON jma.f_credito_orcamento (cnpj_loja);
CREATE INDEX idx_f_cred_orc_periodo ON jma.f_credito_orcamento (dt_referencia);

-- jma.f_devolucao_sistextil
CREATE INDEX idx_f_dev_sist_sku ON jma.f_devolucao_sistextil (sku_produto);
CREATE INDEX idx_f_dev_sist_dt ON jma.f_devolucao_sistextil (dt_devolucao);
CREATE INDEX idx_f_dev_sist_loja ON jma.f_devolucao_sistextil (cnpj_loja);

-- jma.f_devolucao_venda_omnichannel
CREATE INDEX idx_f_dev_omni_pedido ON jma.f_devolucao_venda_omnichannel (nr_pedido);
CREATE INDEX idx_f_dev_omni_dt ON jma.f_devolucao_venda_omnichannel (dt_devolucao);

-- jma.f_documento_fiscal_item
CREATE INDEX idx_f_doc_fiscal_nf ON jma.f_documento_fiscal_item (nr_nota_fiscal, serie);
CREATE INDEX idx_f_doc_fiscal_cnpj ON jma.f_documento_fiscal_item (cnpj_emitente, dt_emissao);
CREATE INDEX idx_f_doc_fiscal_sku ON jma.f_documento_fiscal_item (sku_produto);

-- jma.f_entrada_nota_fiscal
CREATE INDEX idx_f_entrada_nf ON jma.f_entrada_nota_fiscal (nr_nota_fiscal);
CREATE INDEX idx_f_entrada_cnpj ON jma.f_entrada_nota_fiscal (cnpj_fornecedor, dt_emissao);

-- jma.f_estoque_inventario
CREATE INDEX idx_f_est_inv_sku ON jma.f_estoque_inventario (sku_produto);
CREATE INDEX idx_f_est_inv_loja ON jma.f_estoque_inventario (cnpj_loja, dt_inventario);

-- jma.f_faixas_comissao
CREATE INDEX idx_f_faixas_com_rep ON jma.f_faixas_comissao (cod_representante);
CREATE INDEX idx_f_faixas_com_vigencia ON jma.f_faixas_comissao (dt_vigencia_ini, dt_vigencia_fim);

-- jma.f_faixas_comissao_omnichannel
CREATE INDEX idx_f_faixas_omni_canal ON jma.f_faixas_comissao_omnichannel (cod_canal);
CREATE INDEX idx_f_faixas_omni_vigencia ON jma.f_faixas_comissao_omnichannel (dt_vigencia_ini, dt_vigencia_fim);

-- jma.f_faturamento  (tabela principal — indices criticos)
CREATE INDEX idx_f_fat_loja_dt ON jma.f_faturamento (cnpj_loja, dt_emissao);
CREATE INDEX idx_f_fat_nf ON jma.f_faturamento (nr_nota_fiscal, serie);
CREATE INDEX idx_f_fat_sku ON jma.f_faturamento (sku_produto);
CREATE INDEX idx_f_fat_rep ON jma.f_faturamento (cod_representante);
CREATE INDEX idx_f_fat_colecao ON jma.f_faturamento (cod_colecao, dt_emissao);
CREATE INDEX idx_f_fat_cfop ON jma.f_faturamento (cod_cfop);
CREATE INDEX idx_f_fat_pedido ON jma.f_faturamento (nr_pedido);

-- jma.f_faturamento_dev
CREATE INDEX idx_f_fat_dev_nf ON jma.f_faturamento_dev (nr_nota_fiscal);
CREATE INDEX idx_f_fat_dev_loja_dt ON jma.f_faturamento_dev (cnpj_loja, dt_emissao);
CREATE INDEX idx_f_fat_dev_sku ON jma.f_faturamento_dev (sku_produto);

-- jma.stg_faturamento_dev_inc  (staging — indices minimos para upsert)
CREATE INDEX idx_stg_fat_dev_inc_nf ON jma.stg_faturamento_dev_inc (nr_nota_fiscal);
CREATE INDEX idx_stg_fat_dev_inc_dt ON jma.stg_faturamento_dev_inc (dt_emissao);

-- jma.f_faturamento_eua
CREATE INDEX idx_f_fat_eua_sku ON jma.f_faturamento_eua (sku_produto);
CREATE INDEX idx_f_fat_eua_dt ON jma.f_faturamento_eua (dt_emissao);

-- jma.f_historico_movimentacao  (renomeada de fhists_mov_)
CREATE INDEX idx_f_hist_mov_loja ON jma.f_historico_movimentacao (cnpj_loja, dt_movimentacao);
CREATE INDEX idx_f_hist_mov_sku ON jma.f_historico_movimentacao (sku_produto);

-- jma.f_meta_loja
CREATE INDEX idx_f_meta_loja_cnpj ON jma.f_meta_loja (cnpj_loja, dt_referencia);

-- jma.f_meta_semanal_loja
CREATE INDEX idx_f_meta_sem_loja ON jma.f_meta_semanal_loja (cnpj_loja, nr_semana, nr_ano);

-- jma.f_metas_estacoes
CREATE INDEX idx_f_metas_est_loja ON jma.f_metas_estacoes (cnpj_loja, cod_colecao);

-- jma.f_metas_representante
CREATE INDEX idx_f_metas_rep_cod ON jma.f_metas_representante (cod_representante, dt_referencia);

-- jma.f_monitor_producao
CREATE INDEX idx_f_monitor_prod_op ON jma.f_monitor_producao (nr_ordem_producao);
CREATE INDEX idx_f_monitor_prod_dt ON jma.f_monitor_producao (dt_producao);

-- jma.f_movimentos_loja_microvix
CREATE INDEX idx_f_mov_microvix_loja ON jma.f_movimentos_loja_microvix (cnpj_loja, dt_movimento);
CREATE INDEX idx_f_mov_microvix_sku ON jma.f_movimentos_loja_microvix (sku_produto);

-- jma.f_ordens_corte_congelado
CREATE INDEX idx_f_ord_corte_cong_op ON jma.f_ordens_corte_congelado (nr_ordem_producao);
CREATE INDEX idx_f_ord_corte_cong_dt ON jma.f_ordens_corte_congelado (dt_corte);

-- jma.f_ordens_producao
CREATE INDEX idx_f_ord_prod_op ON jma.f_ordens_producao (nr_ordem_producao);
CREATE INDEX idx_f_ord_prod_sku ON jma.f_ordens_producao (sku_produto);
CREATE INDEX idx_f_ord_prod_dt ON jma.f_ordens_producao (dt_abertura);

-- jma.f_ordens_producao_ativo
CREATE INDEX idx_f_ord_prod_ativo_op ON jma.f_ordens_producao_ativo (nr_ordem_producao);

-- jma.f_ordens_producao_congelado
CREATE INDEX idx_f_ord_prod_cong_op ON jma.f_ordens_producao_congelado (nr_ordem_producao);

-- jma.f_pedido_venda
CREATE INDEX idx_f_ped_venda_nr ON jma.f_pedido_venda (nr_pedido);
CREATE INDEX idx_f_ped_venda_loja ON jma.f_pedido_venda (cnpj_loja, dt_pedido);
CREATE INDEX idx_f_ped_venda_sku ON jma.f_pedido_venda (sku_produto);

-- jma.f_pedido_venda_omnichannel
CREATE INDEX idx_f_ped_omni_nr ON jma.f_pedido_venda_omnichannel (nr_pedido);
CREATE INDEX idx_f_ped_omni_loja ON jma.f_pedido_venda_omnichannel (cnpj_loja, dt_pedido);

-- jma.f_prioridade_tecelagem
CREATE INDEX idx_f_prior_tec_sku ON jma.f_prioridade_tecelagem (sku_tecido);
CREATE INDEX idx_f_prior_tec_dt ON jma.f_prioridade_tecelagem (dt_referencia);

-- jma.f_prioridade_tecelagem_conge
CREATE INDEX idx_f_prior_tec_cong_sku ON jma.f_prioridade_tecelagem_conge (sku_tecido);

-- jma.f_producao_marft
CREATE INDEX idx_f_prod_marft_op ON jma.f_producao_marft (nr_ordem_producao);
CREATE INDEX idx_f_prod_marft_dt ON jma.f_producao_marft (dt_producao);

-- jma.f_requisicao_almoxarifado
CREATE INDEX idx_f_req_alm_nr ON jma.f_requisicao_almoxarifado (nr_requisicao);
CREATE INDEX idx_f_req_alm_dt ON jma.f_requisicao_almoxarifado (dt_requisicao);

-- jma.f_requisicao_compra
CREATE INDEX idx_f_req_compra_nr ON jma.f_requisicao_compra (nr_requisicao);
CREATE INDEX idx_f_req_compra_dt ON jma.f_requisicao_compra (dt_requisicao);

-- jma.f_roteiro
CREATE UNIQUE INDEX uq_f_roteiro_op_seq ON jma.f_roteiro (nr_ordem_producao, nr_seq_operacao);

-- jma.f_roteiro_em_producao
CREATE INDEX idx_f_roteiro_prod_op ON jma.f_roteiro_em_producao (nr_ordem_producao);

-- jma.f_tabela_preco_item
CREATE INDEX idx_f_tab_preco_sku ON jma.f_tabela_preco_item (sku_produto);
CREATE INDEX idx_f_tab_preco_tabela ON jma.f_tabela_preco_item (cod_tabela, dt_vigencia);

-- jma.f_tempo_metodo
CREATE INDEX idx_f_tempo_met_op ON jma.f_tempo_metodo (cod_operacao);

-- jma.f_titulo_receber
CREATE INDEX idx_f_titulo_rec_cnpj ON jma.f_titulo_receber (cnpj_cliente, dt_emissao);
CREATE INDEX idx_f_titulo_rec_venc ON jma.f_titulo_receber (dt_vencimento);
CREATE INDEX idx_f_titulo_rec_nf ON jma.f_titulo_receber (nr_nota_fiscal);

-- jma.f_venda_url
CREATE INDEX idx_f_venda_url_pedido ON jma.f_venda_url (nr_pedido);
CREATE INDEX idx_f_venda_url_loja ON jma.f_venda_url (cnpj_loja, dt_venda);
CREATE INDEX idx_f_venda_url_nf ON jma.f_venda_url (nr_nota_fiscal);

-- jma.f_pedido_congelado_motivo_bloqueio
CREATE INDEX idx_f_ped_cong_bloqueio_nr ON jma.f_pedido_congelado_motivo_bloqueio (nr_pedido_venda);
```

---

## 5. Migration SQL — Scripts de Correcao Critica

> Os scripts abaixo seguem a politica de migracao em 3 fases descrita em `BOAS_PRATICAS_DW.md` secao 17:
> 1. **Fase 1 — Renomear + criar VIEW de compatibilidade** (manter por 90 dias)
> 2. **Fase 2 — Migrar consumidores** (dashboards, ETL jobs, queries)
> 3. **Fase 3 — Dropar a VIEW de compatibilidade**

### 5.1 Renomear tabela com typo: `fhists_mov_` → `f_historico_movimentacao`

```sql
-- FASE 1
BEGIN;
  ALTER TABLE jma.fhists_mov_ RENAME TO f_historico_movimentacao;
  -- VIEW de compatibilidade (90 dias)
  CREATE VIEW jma.fhists_mov_ AS
    SELECT * FROM jma.f_historico_movimentacao;
  COMMENT ON VIEW jma.fhists_mov_ IS
    'DEPRECATED: renomeada para f_historico_movimentacao. Remover apos 2026-08-05.';
COMMIT;
```

### 5.2 Renomear colunas SUM() em `ffaturamento_eua` → `f_faturamento_eua`

```sql
-- FASE 1 — renomear colunas com nomes invalidos
BEGIN;
  -- Renomear tabela primeiro
  ALTER TABLE jma.ffaturamento_eua RENAME TO f_faturamento_eua;

  -- Renomear colunas com nomes gerados por agregacao
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.QUANTIDADE)"   TO qt_total;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORDOLAR)"   TO vl_total_dolar;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORREAIS)"   TO vl_total_reais;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORPESO)"    TO vl_total_peso;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORLIQUIDO)" TO vl_total_liquido;

  -- VIEW de compatibilidade
  CREATE VIEW jma.ffaturamento_eua AS
    SELECT
      qt_total          AS "SUM(DADOS.QUANTIDADE)",
      vl_total_dolar    AS "SUM(DADOS.VALORDOLAR)",
      vl_total_reais    AS "SUM(DADOS.VALORREAIS)",
      vl_total_peso     AS "SUM(DADOS.VALORPESO)",
      vl_total_liquido  AS "SUM(DADOS.VALORLIQUIDO)"
    FROM jma.f_faturamento_eua;
  COMMENT ON VIEW jma.ffaturamento_eua IS
    'DEPRECATED: renomeada para f_faturamento_eua. Remover apos 2026-08-05.';
COMMIT;
```

### 5.3 Migrar `ffaturamento_dev_inc` para staging padronizado

> Esta tabela tem 53 colunas `UPPER_CASE` com aspas. O script gera a tabela destino padronizada e uma funcao de migracao de dados.

```sql
-- FASE 1 — criar tabela destino com schema correto
CREATE TABLE jma.stg_faturamento_dev_inc (
  id                   bigserial NOT NULL,
  nr_nota_fiscal       varchar(20) NOT NULL,
  serie                varchar(5),
  cnpj_emitente        varchar(16),
  cnpj_destinatario    varchar(16),
  dt_emissao           date,
  dth_saida            timestamp,
  cod_cfop             varchar(4),
  sku_produto          varchar(30),
  nm_produto           varchar(120),
  qt_devolvida         numeric(15,3),
  vl_unitario          numeric(15,2),
  vl_total             numeric(15,2),
  vl_desconto          numeric(15,2),
  vl_frete             numeric(15,2),
  vl_ipi               numeric(15,2),
  vl_icms              numeric(15,2),
  vl_pis               numeric(15,2),
  vl_cofins            numeric(15,2),
  cod_motivo_devolucao varchar(10),
  ds_motivo_devolucao  varchar(120),
  nr_pedido_origem     integer,
  cod_representante    varchar(6),
  cod_colecao          varchar(10),
  fl_bonificacao       boolean,
  fl_triangulacao      boolean,
  obs_complementar     text,
  updated_at           timestamp NOT NULL DEFAULT current_timestamp,
  created_at           timestamp NOT NULL DEFAULT current_timestamp,
  CONSTRAINT pk_stg_fat_dev_inc PRIMARY KEY (id)
);

-- FASE 1 — funcao de migracao (mapeamento UPPER → snake_case)
-- ATENCAO: ajustar mapeamento conforme DDL exato da tabela original
INSERT INTO jma.stg_faturamento_dev_inc (
  nr_nota_fiscal, serie, cnpj_emitente, dt_emissao, sku_produto,
  qt_devolvida, vl_total
)
SELECT
  "NR_NOTA"::varchar(20),
  "SERIE"::varchar(5),
  fn_formatar_cnpj_cpf("CNPJ_EMITENTE"::text),
  "DT_EMISSAO"::date,
  "SKU_PRODUTO"::varchar(30),
  "QUANTIDADE"::numeric(15,3),
  "VALOR_TOTAL"::numeric(15,2)
FROM jma.ffaturamento_dev_inc
ON CONFLICT DO NOTHING;

-- VIEW de compatibilidade
CREATE VIEW jma.ffaturamento_dev_inc_legacy AS
  SELECT * FROM jma.stg_faturamento_dev_inc;
COMMENT ON VIEW jma.ffaturamento_dev_inc_legacy IS
  'DEPRECATED: dados migrados para stg_faturamento_dev_inc. Remover apos 2026-08-05.';
```

### 5.4 Adicionar colunas de auditoria em tabelas sem `created_at` / `updated_at`

```sql
-- Tabelas identificadas sem colunas de auditoria padrao
-- (possuiam apenas ultima_atualizacao ou nenhuma coluna de controle)

ALTER TABLE jma.f_controle_partes
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_monitor_producao
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_movimentos_loja_microvix
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_requisicao_compra
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_pedido_congelado_motivo_bloqueio
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;
```

### 5.5 Corrigir tipos `numeric(38,10)` herdados do Oracle

```sql
-- Estas colunas foram importadas do Oracle sem conversao de tipo.
-- Reduzir para tipos semanticamente corretos.
-- Executar APENAS apos validacao de range dos dados (SELECT MAX, MIN).

-- Exemplo para f_faturamento (ajustar demais tabelas analogamente)
ALTER TABLE jma.f_faturamento
  ALTER COLUMN qt_pecas       TYPE numeric(15,3) USING qt_pecas::numeric(15,3),
  ALTER COLUMN vl_bruto        TYPE numeric(15,2) USING vl_bruto::numeric(15,2),
  ALTER COLUMN vl_liquido      TYPE numeric(15,2) USING vl_liquido::numeric(15,2),
  ALTER COLUMN vl_desconto     TYPE numeric(15,2) USING vl_desconto::numeric(15,2),
  ALTER COLUMN pc_desconto     TYPE numeric(7,4)  USING pc_desconto::numeric(7,4),
  ALTER COLUMN vl_comissao     TYPE numeric(15,2) USING vl_comissao::numeric(15,2),
  ALTER COLUMN pc_comissao     TYPE numeric(7,4)  USING pc_comissao::numeric(7,4);
```

### 5.6 Deprecar `jma.d_canal_distribuicao` (duplicata de `live.d_canal_distribuicao`)

```sql
-- FASE 1 — criar view de redirecionamento
CREATE OR REPLACE VIEW jma.d_canal_distribuicao AS
  SELECT
    id_canal_distribuicao AS id,
    cod_canal             AS codigo_canal,
    ds_canal              AS descricao
  FROM live.d_canal_distribuicao;

COMMENT ON VIEW jma.d_canal_distribuicao IS
  'DEPRECATED: use live.d_canal_distribuicao. Esta view sera removida apos 2026-08-05.';

-- FASE 3 (90 dias depois) — remover view e tabela original
-- DROP VIEW jma.d_canal_distribuicao;
-- DROP TABLE jma.d_canal_distribuicao_backup;  -- renomear antes de dropar
```

### 5.7 Corrigir `cod_representante float8` em `f_faturamento`

```sql
-- Coluna nf_cdrep e mapeada para cod_representante
-- float8 e inadequado para codigos — migrar para varchar(6)

ALTER TABLE jma.f_faturamento
  ADD COLUMN cod_representante_novo varchar(6);

UPDATE jma.f_faturamento
  SET cod_representante_novo = LPAD(nf_cdrep::integer::text, 6, '0')
  WHERE nf_cdrep IS NOT NULL;

ALTER TABLE jma.f_faturamento
  DROP COLUMN nf_cdrep,
  RENAME COLUMN cod_representante_novo TO cod_representante;

CREATE INDEX idx_f_fat_rep ON jma.f_faturamento (cod_representante);
```

---

## 6. Checklist de Conformidade por Tabela

| Tabela (nome proposto) | PK bigserial | BK UNIQUE | created_at | updated_at | Tipos OK | Sem UPPER_CASE | Status |
|------------------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| `d_aparelho` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_canal_distribuicao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ DEPRECAR |
| `d_cfop` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_colecao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_condicao_pgto` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_familia_materiais` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_funcionarios_integ` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_grupo_produto` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_marca` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_maquina` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_motivo_devolucao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_operacao_fiscal` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_periodo_producao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_produto_producao` | ✅ | ✅ | ✅ | ✅ | ⚠️ numeric(38,10) | ✅ | ⚠️ TIPOS |
| `d_representante` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_secao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_setor` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_tabela_preco` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_transportadora` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_conferencia_caixas` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_credito_orcamento` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_devolucao_sistextil` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_devolucao_venda_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_documento_fiscal_item` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_entrada_nota_fiscal` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_estoque_inventario` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faixas_comissao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faixas_comissao_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faturamento` | ✅ | — | ✅ | ✅ | ⚠️ float8/numeric38 | ✅ | ⚠️ TIPOS |
| `f_faturamento_dev` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `stg_faturamento_dev_inc` | ✅ | — | ✅ | ✅ | ❌ UPPER_CASE | ❌ | 🔴 CRITICO |
| `f_faturamento_eua` | ✅ | — | ✅ | ✅ | ✅ | ❌ SUM() cols | 🔴 CRITICO |
| `f_historico_movimentacao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ⚠️ TYPO NOME |
| `f_meta_loja` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_meta_semanal_loja` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_metas_estacoes` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_metas_representante` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_monitor_producao` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_movimentos_loja_microvix` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_ordens_corte_congelado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao_ativo` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao_congelado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_pedido_venda` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_pedido_venda_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_prioridade_tecelagem` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_prioridade_tecelagem_conge` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_producao_marft` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_requisicao_almoxarifado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_requisicao_compra` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_roteiro` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_roteiro_em_producao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_tabela_preco_item` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_tempo_metodo` | ✅ | — | ✅ | ✅ | ⚠️ varchar s/ tamanho | ✅ | ⚠️ TIPOS |
| `f_titulo_receber` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_venda_url` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_controle_partes` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_pedido_congelado_motivo_bloqueio` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |

**Legenda:** ✅ Conforme · ⚠️ Requer atencao · ❌ Nao conforme · 🔴 Critico (bloquear deploy)

---

## 7. Resumo Executivo de Pendencias

### 🔴 Critico (bloquear antes de uso em producao)
1. **`stg_faturamento_dev_inc`** — 53 colunas `UPPER_CASE` com aspas duplas; `numeric(38,10)` em todos os campos numericos. Executar Script 5.3.
2. **`f_faturamento_eua`** — Colunas com nomes de funcoes SQL (`SUM(DADOS.QUANTIDADE)`). Executar Script 5.2.

### ⚠️ Alta Prioridade (resolver na proxima sprint)
3. **`f_historico_movimentacao`** — Nome atual `fhists_mov_` com typo e trailing underscore. Executar Script 5.1.
4. **`d_canal_distribuicao`** — Duplicata de `live.d_canal_distribuicao`. Executar Script 5.6 e deprecar.
5. **`f_faturamento`** — `nf_cdrep float8` deve ser `cod_representante varchar(6)`. Executar Script 5.7. Multiplos campos `numeric(38,10)` a reduzir.
6. **Auditoria ausente** — 5 tabelas sem `created_at`/`updated_at`: `f_controle_partes`, `f_monitor_producao`, `f_movimentos_loja_microvix`, `f_requisicao_compra`, `f_pedido_congelado_motivo_bloqueio`. Executar Script 5.4.

### ℹ️ Medio Prazo (backlog de qualidade)
7. **`d_produto_producao`** — Consolidar atributos comuns com `live.d_produto`; reduzir `numeric(38,10)`.
8. **`f_tempo_metodo`** — Investigar `varchar` sem tamanho nas colunas `tempo_homem` e `tempo_maquina`.
9. **Todos os `numeric(38,10)`** — Mapeamento completo e reducao para tipos semanticos (Script 5.5 como template).

---

*Documento gerado em 2026-05-06 — Schema `jma` — 71 tabelas (19 dimensoes + 52 fatos/operacionais)*
*Revisao: v1.0 — Padrao: BOAS_PRATICAS_DW.md v2.0*










. Indices Consolidados por Tabela

> Todos os comandos abaixo devem ser executados **apos** as migracoes de renomeacao de coluna/tabela. Os indices sao nomeados seguindo o padrao `idx_<tabela>_<descricao>` (max 63 chars no PostgreSQL).

### 4.1 Dimensoes

```sql
CREATE UNIQUE INDEX uq_d_aparelho_cod       ON jma.d_aparelho (cod_aparelho);
CREATE UNIQUE INDEX uq_d_cfop_cod           ON jma.d_cfop (cod_cfop);
CREATE UNIQUE INDEX uq_d_colecao_cod        ON jma.d_colecao (cod_colecao);
CREATE UNIQUE INDEX uq_d_condicao_pgto_cod  ON jma.d_condicao_pgto (cod_condicao);
CREATE UNIQUE INDEX uq_d_familia_mat_cod    ON jma.d_familia_materiais (cod_familia);
CREATE UNIQUE INDEX uq_d_func_integ_cod     ON jma.d_funcionarios_integ (cod_funcionario);
CREATE INDEX        idx_d_func_integ_loja   ON jma.d_funcionarios_integ (cnpj_loja);
CREATE UNIQUE INDEX uq_d_grupo_prod_cod     ON jma.d_grupo_produto (cod_grupo);
CREATE UNIQUE INDEX uq_d_marca_cod          ON jma.d_marca (cod_marca);
CREATE UNIQUE INDEX uq_d_maquina_cod        ON jma.d_maquina (cod_maquina);
CREATE UNIQUE INDEX uq_d_motivo_dev_cod     ON jma.d_motivo_devolucao (cod_motivo);
CREATE UNIQUE INDEX uq_d_op_fiscal_cod      ON jma.d_operacao_fiscal (cod_operacao);
CREATE UNIQUE INDEX uq_d_periodo_prod_cod   ON jma.d_periodo_producao (cod_periodo);
CREATE UNIQUE INDEX uq_d_prod_prod_sku      ON jma.d_produto_producao (sku_produto);
CREATE INDEX        idx_d_prod_prod_ref     ON jma.d_produto_producao (cod_referencia);
CREATE INDEX        idx_d_prod_prod_familia ON jma.d_produto_producao (cod_familia);
CREATE UNIQUE INDEX uq_d_representante_cod  ON jma.d_representante (cod_representante);
CREATE INDEX        idx_d_rep_uf            ON jma.d_representante (uf_atuacao);
CREATE UNIQUE INDEX uq_d_secao_cod          ON jma.d_secao (cod_secao);
CREATE UNIQUE INDEX uq_d_setor_cod          ON jma.d_setor (cod_setor);
CREATE UNIQUE INDEX uq_d_tabela_preco_cod   ON jma.d_tabela_preco (cod_tabela);
CREATE UNIQUE INDEX uq_d_transp_cnpj        ON jma.d_transportadora (cnpj_transportadora);
```

### 4.2 Fatos e Tabelas Operacionais

```sql
-- f_faturamento (tabela principal — indices criticos)
CREATE INDEX idx_f_fat_loja_dt  ON jma.f_faturamento (cnpj_loja, dt_emissao);
CREATE INDEX idx_f_fat_nf       ON jma.f_faturamento (nr_nota_fiscal, serie);
CREATE INDEX idx_f_fat_sku      ON jma.f_faturamento (sku_produto);
CREATE INDEX idx_f_fat_rep      ON jma.f_faturamento (cod_representante);
CREATE INDEX idx_f_fat_colecao  ON jma.f_faturamento (cod_colecao, dt_emissao);
CREATE INDEX idx_f_fat_cfop     ON jma.f_faturamento (cod_cfop);
CREATE INDEX idx_f_fat_pedido   ON jma.f_faturamento (nr_pedido);

-- f_faturamento_dev
CREATE INDEX idx_f_fat_dev_nf      ON jma.f_faturamento_dev (nr_nota_fiscal);
CREATE INDEX idx_f_fat_dev_loja_dt ON jma.f_faturamento_dev (cnpj_loja, dt_emissao);
CREATE INDEX idx_f_fat_dev_sku     ON jma.f_faturamento_dev (sku_produto);

-- stg_faturamento_dev_inc (staging)
CREATE INDEX idx_stg_fat_dev_inc_nf ON jma.stg_faturamento_dev_inc (nr_nota_fiscal);
CREATE INDEX idx_stg_fat_dev_inc_dt ON jma.stg_faturamento_dev_inc (dt_emissao);

-- f_faturamento_eua
CREATE INDEX idx_f_fat_eua_sku ON jma.f_faturamento_eua (sku_produto);
CREATE INDEX idx_f_fat_eua_dt  ON jma.f_faturamento_eua (dt_emissao);

-- f_historico_movimentacao (renomeada de fhists_mov_)
CREATE INDEX idx_f_hist_mov_loja ON jma.f_historico_movimentacao (cnpj_loja, dt_movimentacao);
CREATE INDEX idx_f_hist_mov_sku  ON jma.f_historico_movimentacao (sku_produto);

-- f_pedido_venda
CREATE INDEX idx_f_ped_venda_nr   ON jma.f_pedido_venda (nr_pedido);
CREATE INDEX idx_f_ped_venda_loja ON jma.f_pedido_venda (cnpj_loja, dt_pedido);
CREATE INDEX idx_f_ped_venda_sku  ON jma.f_pedido_venda (sku_produto);

-- f_ordens_producao
CREATE INDEX idx_f_ord_prod_op  ON jma.f_ordens_producao (nr_ordem_producao);
CREATE INDEX idx_f_ord_prod_sku ON jma.f_ordens_producao (sku_produto);
CREATE INDEX idx_f_ord_prod_dt  ON jma.f_ordens_producao (dt_abertura);

-- f_titulo_receber
CREATE INDEX idx_f_titulo_rec_cnpj ON jma.f_titulo_receber (cnpj_cliente, dt_emissao);
CREATE INDEX idx_f_titulo_rec_venc ON jma.f_titulo_receber (dt_vencimento);
CREATE INDEX idx_f_titulo_rec_nf   ON jma.f_titulo_receber (nr_nota_fiscal);

-- f_venda_url
CREATE INDEX idx_f_venda_url_pedido ON jma.f_venda_url (nr_pedido);
CREATE INDEX idx_f_venda_url_loja   ON jma.f_venda_url (cnpj_loja, dt_venda);

-- f_tabela_preco_item
CREATE INDEX idx_f_tab_preco_sku    ON jma.f_tabela_preco_item (sku_produto);
CREATE INDEX idx_f_tab_preco_tabela ON jma.f_tabela_preco_item (cod_tabela, dt_vigencia);

-- f_roteiro
CREATE UNIQUE INDEX uq_f_roteiro_op_seq ON jma.f_roteiro (nr_ordem_producao, nr_seq_operacao);

-- f_documento_fiscal_item
CREATE INDEX idx_f_doc_fiscal_nf   ON jma.f_documento_fiscal_item (nr_nota_fiscal, serie);
CREATE INDEX idx_f_doc_fiscal_cnpj ON jma.f_documento_fiscal_item (cnpj_emitente, dt_emissao);
CREATE INDEX idx_f_doc_fiscal_sku  ON jma.f_documento_fiscal_item (sku_produto);

-- f_movimentos_loja_microvix
CREATE INDEX idx_f_mov_microvix_loja ON jma.f_movimentos_loja_microvix (cnpj_loja, dt_movimento);
CREATE INDEX idx_f_mov_microvix_sku  ON jma.f_movimentos_loja_microvix (sku_produto);

-- f_pedido_congelado_motivo_bloqueio
CREATE INDEX idx_f_ped_cong_bl_nr ON jma.f_pedido_congelado_motivo_bloqueio (nr_pedido_venda);
```

---

## 5. Migration SQL — Scripts de Correcao Critica

> Politica em 3 fases (BOAS_PRATICAS_DW.md secao 17):
> - **Fase 1** — Renomear + criar VIEW de compatibilidade (90 dias)
> - **Fase 2** — Migrar consumidores (ETL jobs, dashboards, queries)
> - **Fase 3** — Dropar VIEW e, se aplicavel, a tabela original

### 5.1 Corrigir typo: `fhists_mov_` → `f_historico_movimentacao`

```sql
BEGIN;
  ALTER TABLE jma.fhists_mov_ RENAME TO f_historico_movimentacao;
  CREATE VIEW jma.fhists_mov_ AS SELECT * FROM jma.f_historico_movimentacao;
  COMMENT ON VIEW jma.fhists_mov_ IS
    'DEPRECATED: renomeada para f_historico_movimentacao. Remover apos 2026-08-05.';
COMMIT;
```

### 5.2 Corrigir colunas SUM() em `ffaturamento_eua` → `f_faturamento_eua`

```sql
BEGIN;
  ALTER TABLE jma.ffaturamento_eua RENAME TO f_faturamento_eua;

  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.QUANTIDADE)"   TO qt_total;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORDOLAR)"   TO vl_total_dolar;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORREAIS)"   TO vl_total_reais;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORPESO)"    TO vl_total_peso;
  ALTER TABLE jma.f_faturamento_eua
    RENAME COLUMN "SUM(DADOS.VALORLIQUIDO)" TO vl_total_liquido;

  CREATE VIEW jma.ffaturamento_eua AS
    SELECT
      qt_total         AS "SUM(DADOS.QUANTIDADE)",
      vl_total_dolar   AS "SUM(DADOS.VALORDOLAR)",
      vl_total_reais   AS "SUM(DADOS.VALORREAIS)",
      vl_total_peso    AS "SUM(DADOS.VALORPESO)",
      vl_total_liquido AS "SUM(DADOS.VALORLIQUIDO)"
    FROM jma.f_faturamento_eua;
  COMMENT ON VIEW jma.ffaturamento_eua IS
    'DEPRECATED: renomeada para f_faturamento_eua. Remover apos 2026-08-05.';
COMMIT;
```

### 5.3 Migrar `ffaturamento_dev_inc` para staging padronizado

```sql
-- PASSO 1: criar tabela destino com tipos corretos
CREATE TABLE jma.stg_faturamento_dev_inc (
  id                   bigserial PRIMARY KEY,
  nr_nota_fiscal       varchar(20)  NOT NULL,
  serie                varchar(5),
  cnpj_emitente        varchar(16),
  cnpj_destinatario    varchar(16),
  dt_emissao           date,
  dth_saida            timestamp,
  cod_cfop             varchar(4),
  sku_produto          varchar(30),
  nm_produto           varchar(120),
  qt_devolvida         numeric(15,3),
  vl_unitario          numeric(15,2),
  vl_total             numeric(15,2),
  vl_desconto          numeric(15,2),
  vl_frete             numeric(15,2),
  vl_ipi               numeric(15,2),
  vl_icms              numeric(15,2),
  cod_motivo_devolucao varchar(10),
  ds_motivo_devolucao  varchar(120),
  nr_pedido_origem     integer,
  cod_representante    varchar(6),
  cod_colecao          varchar(10),
  fl_bonificacao       boolean,
  obs_complementar     text,
  updated_at           timestamp NOT NULL DEFAULT current_timestamp,
  created_at           timestamp NOT NULL DEFAULT current_timestamp
);

-- PASSO 2: migrar dados (ajustar mapeamento conforme DDL exato)
-- ATENCAO: validar nomes de colunas UPPER_CASE com \d jma.ffaturamento_dev_inc
INSERT INTO jma.stg_faturamento_dev_inc (
  nr_nota_fiscal, serie, cnpj_emitente, dt_emissao,
  sku_produto, qt_devolvida, vl_total
)
SELECT
  "NR_NOTA"::varchar(20),
  "SERIE"::varchar(5),
  fn_formatar_cnpj_cpf("CNPJ_EMITENTE"::text),
  "DT_EMISSAO"::date,
  "SKU_PRODUTO"::varchar(30),
  "QUANTIDADE"::numeric(15,3),
  "VALOR_TOTAL"::numeric(15,2)
FROM jma.ffaturamento_dev_inc
ON CONFLICT DO NOTHING;

-- PASSO 3: view de compatibilidade
CREATE VIEW jma.ffaturamento_dev_inc_legacy AS
  SELECT * FROM jma.stg_faturamento_dev_inc;
COMMENT ON VIEW jma.ffaturamento_dev_inc_legacy IS
  'DEPRECATED: migrada para stg_faturamento_dev_inc. Remover apos 2026-08-05.';
```

### 5.4 Adicionar auditoria em tabelas sem `created_at`/`updated_at`

```sql
ALTER TABLE jma.f_controle_partes
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_monitor_producao
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_movimentos_loja_microvix
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_requisicao_compra
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE jma.f_pedido_congelado_motivo_bloqueio
  ADD COLUMN IF NOT EXISTS created_at timestamp NOT NULL DEFAULT current_timestamp,
  ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp;
```

### 5.5 Corrigir `cod_representante float8` em `f_faturamento`

```sql
ALTER TABLE jma.f_faturamento
  ADD COLUMN cod_representante_novo varchar(6);

UPDATE jma.f_faturamento
  SET cod_representante_novo = LPAD(nf_cdrep::integer::text, 6, '0')
  WHERE nf_cdrep IS NOT NULL;

ALTER TABLE jma.f_faturamento
  DROP COLUMN nf_cdrep,
  RENAME COLUMN cod_representante_novo TO cod_representante;

CREATE INDEX idx_f_fat_rep ON jma.f_faturamento (cod_representante);
```

### 5.6 Deprecar `jma.d_canal_distribuicao` (duplicata de `live.d_canal_distribuicao`)

```sql
-- FASE 1: redirecionar via view
CREATE OR REPLACE VIEW jma.d_canal_distribuicao_v AS
  SELECT
    id_canal_distribuicao AS id,
    cod_canal,
    ds_canal
  FROM live.d_canal_distribuicao;

COMMENT ON VIEW jma.d_canal_distribuicao_v IS
  'DEPRECATED: use live.d_canal_distribuicao diretamente. Remover apos 2026-08-05.';

-- FASE 3 (90 dias depois)
-- DROP TABLE jma.d_canal_distribuicao;
```

### 5.7 Corrigir tipos `numeric(38,10)` herdados do Oracle (template)

```sql
-- Executar SOMENTE apos validar range: SELECT MAX(col), MIN(col) FROM tabela
-- Exemplo para f_faturamento — aplicar analogamente em demais tabelas

ALTER TABLE jma.f_faturamento
  ALTER COLUMN qt_pecas    TYPE numeric(15,3) USING qt_pecas::numeric(15,3),
  ALTER COLUMN vl_bruto    TYPE numeric(15,2) USING vl_bruto::numeric(15,2),
  ALTER COLUMN vl_liquido  TYPE numeric(15,2) USING vl_liquido::numeric(15,2),
  ALTER COLUMN vl_desconto TYPE numeric(15,2) USING vl_desconto::numeric(15,2),
  ALTER COLUMN pc_desconto TYPE numeric(7,4)  USING pc_desconto::numeric(7,4),
  ALTER COLUMN vl_comissao TYPE numeric(15,2) USING vl_comissao::numeric(15,2),
  ALTER COLUMN pc_comissao TYPE numeric(7,4)  USING pc_comissao::numeric(7,4);
```

---

## 6. Checklist de Conformidade por Tabela

| Tabela (nome proposto) | PK bigserial | BK UNIQUE | created_at | updated_at | Tipos OK | Sem UPPER | Status |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| `d_aparelho` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_canal_distribuicao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ DEPRECAR |
| `d_cfop` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_colecao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_condicao_pgto` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_familia_materiais` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_funcionarios_integ` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_grupo_produto` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_marca` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_maquina` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_motivo_devolucao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_operacao_fiscal` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_periodo_producao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_produto_producao` | ✅ | ✅ | ✅ | ✅ | ⚠️ numeric38 | ✅ | ⚠️ TIPOS |
| `d_representante` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_secao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_setor` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_tabela_preco` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_transportadora` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_conferencia_caixas` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_credito_orcamento` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_devolucao_sistextil` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_devolucao_venda_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_documento_fiscal_item` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_entrada_nota_fiscal` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_estoque_inventario` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faixas_comissao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faixas_comissao_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faturamento` | ✅ | — | ✅ | ✅ | ⚠️ float8+numeric38 | ✅ | ⚠️ TIPOS |
| `f_faturamento_dev` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `stg_faturamento_dev_inc` | ✅ | — | ✅ | ✅ | ❌ numeric38 | ❌ UPPER | 🔴 CRITICO |
| `f_faturamento_eua` | ✅ | — | ✅ | ✅ | ✅ | ❌ SUM() | 🔴 CRITICO |
| `f_historico_movimentacao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ⚠️ TYPO |
| `f_meta_loja` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_meta_semanal_loja` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_metas_estacoes` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_metas_representante` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_monitor_producao` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_movimentos_loja_microvix` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_ordens_corte_congelado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao_ativo` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao_congelado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_pedido_venda` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_pedido_venda_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_prioridade_tecelagem` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_prioridade_tecelagem_conge` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_producao_marft` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_requisicao_almoxarifado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_requisicao_compra` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_roteiro` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_roteiro_em_producao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_tabela_preco_item` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_tempo_metodo` | ✅ | — | ✅ | ✅ | ⚠️ varchar s/size | ✅ | ⚠️ TIPOS |
| `f_titulo_receber` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_venda_url` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_controle_partes` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_pedido_congelado_motivo_bloqueio` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |

**Legenda:** ✅ Conforme · ⚠️ Requer atencao · ❌ Nao conforme · 🔴 Critico (bloquear antes de deploy)

---

## 7. Resumo Executivo de Pendencias

### 🔴 Critico — bloquear antes de uso em producao
1. **`stg_faturamento_dev_inc`** — 53 colunas `UPPER_CASE` com aspas; `numeric(38,10)` em todos os numericos. Script 5.3.
2. **`f_faturamento_eua`** — Colunas com nomes de funcoes SQL (`SUM(...)`). Script 5.2.

### ⚠️ Alta Prioridade — resolver na proxima sprint
3. **`f_historico_movimentacao`** — Nome atual `fhists_mov_` com trailing underscore. Script 5.1.
4. **`d_canal_distribuicao`** — Duplicata de `live.d_canal_distribuicao`. Script 5.6.
5. **`f_faturamento`** — `nf_cdrep float8` → `cod_representante varchar(6)`. Script 5.5. Multiplos `numeric(38,10)` a corrigir.
6. **Auditoria ausente em 5 tabelas** — `f_controle_partes`, `f_monitor_producao`, `f_movimentos_loja_microvix`, `f_requisicao_compra`, `f_pedido_congelado_motivo_bloqueio`. Script 5.4.

### ℹ️ Medio Prazo — backlog de qualidade
7. **`d_produto_producao`** — Consolidar atributos comuns com `live.d_produto`; reduzir `numeric(38,10)`.
8. **`f_tempo_metodo`** — Investigar `varchar` sem tamanho em `tempo_homem` e `tempo_maquina`.
9. **`numeric(38,10)` generalizados** — Mapear e reduzir em todas as tabelas afetadas (Script 5.7 como template).

---

*Documento gerado em 2026-05-06 — Schema `jma` — 71 tabelas (19 dimensoes + 52 fatos/operacionais)*  
*Revisao: v1.0 — Padrao: BOAS_PRATICAS_DW.md v2.0*
| `d_canal_distribuicao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ DEPRECAR |
| `d_cfop` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_colecao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_condicao_pgto` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_familia_materiais` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_funcionarios_integ` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_grupo_produto` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_marca` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_maquina` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_motivo_devolucao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_operacao_fiscal` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_periodo_producao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_produto_producao` | ✅ | ✅ | ✅ | ✅ | ⚠️ numeric38 | ✅ | ⚠️ TIPOS |
| `d_representante` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_secao` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_setor` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_tabela_preco` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `d_transportadora` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_conferencia_caixas` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_credito_orcamento` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_devolucao_sistextil` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_devolucao_venda_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_documento_fiscal_item` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_entrada_nota_fiscal` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_estoque_inventario` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faixas_comissao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faixas_comissao_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_faturamento` | ✅ | — | ✅ | ✅ | ⚠️ float8+numeric38 | ✅ | ⚠️ TIPOS |
| `f_faturamento_dev` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `stg_faturamento_dev_inc` | ✅ | — | ✅ | ✅ | ❌ numeric38 | ❌ UPPER | 🔴 CRITICO |
| `f_faturamento_eua` | ✅ | — | ✅ | ✅ | ✅ | ❌ SUM() cols | 🔴 CRITICO |
| `f_historico_movimentacao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ⚠️ TYPO |
| `f_meta_loja` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_meta_semanal_loja` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_metas_estacoes` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_metas_representante` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_monitor_producao` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_movimentos_loja_microvix` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_ordens_corte_congelado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao_ativo` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_ordens_producao_congelado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_pedido_venda` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_pedido_venda_omnichannel` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_prioridade_tecelagem` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_prioridade_tecelagem_conge` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_producao_marft` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_requisicao_almoxarifado` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_requisicao_compra` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_roteiro` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_roteiro_em_producao` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_tabela_preco_item` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_tempo_metodo` | ✅ | — | ✅ | ✅ | ⚠️ varchar s/size | ✅ | ⚠️ TIPOS |
| `f_titulo_receber` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_venda_url` | ✅ | — | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| `f_controle_partes` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |
| `f_pedido_congelado_motivo_bloqueio` | ✅ | — | ⚠️ ausente | ⚠️ ausente | ✅ | ✅ | ⚠️ AUDITORIA |

**Legenda:** ✅ Conforme · ⚠️ Requer atencao · ❌ Nao conforme · 🔴 Critico (bloquear antes de deploy)

---

## 7. Resumo Executivo de Pendencias

### 🔴 Critico — bloquear antes de uso em producao
1. **`stg_faturamento_dev_inc`** — 53 colunas `UPPER_CASE` com aspas duplas; `numeric(38,10)` em todos os campos numericos. Executar Script 5.3.
2. **`f_faturamento_eua`** — Colunas com nomes de funcoes SQL (`SUM(DADOS.QUANTIDADE)` etc). Executar Script 5.2.

### ⚠️ Alta Prioridade — resolver na proxima sprint
3. **`f_historico_movimentacao`** — Nome atual `fhists_mov_` com typo e trailing underscore. Executar Script 5.1.
4. **`d_canal_distribuicao`** — Duplicata de `live.d_canal_distribuicao`. Executar Script 5.6 e deprecar.
5. **`f_faturamento`** — `nf_cdrep float8` → `cod_representante varchar(6)`. Executar Script 5.5. Multiplos `numeric(38,10)` a reduzir.
6. **Auditoria ausente** — 5 tabelas sem `created_at`/`updated_at`: `f_controle_partes`, `f_monitor_producao`, `f_movimentos_loja_microvix`, `f_requisicao_compra`, `f_pedido_congelado_motivo_bloqueio`. Executar Script 5.4.

### ℹ️ Medio Prazo — backlog de qualidade
7. **`d_produto_producao`** — Consolidar atributos comuns com `live.d_produto`; reduzir `numeric(38,10)`.
8. **`f_tempo_metodo`** — Investigar `varchar` sem tamanho nas colunas `tempo_homem` e `tempo_maquina`.
9. **`numeric(38,10)` generalizados** — Mapear e reduzir em todas as tabelas afetadas (Script 5.7 como template).

---

*Documento gerado em 2026-05-06 — Schema `jma` — 71 tabelas (19 dimensoes + 52 fatos/operacionais)*
*Revisao: v1.0 — Padrao: BOAS_PRATICAS_DW.md v2.0*
0*
