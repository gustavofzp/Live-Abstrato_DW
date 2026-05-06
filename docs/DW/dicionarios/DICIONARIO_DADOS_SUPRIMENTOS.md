# Dicionario de Dados — Schema `suprimentos`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 15 tabelas — compras, fornecedores, OBC (Orion Business Cloud), notas de entrada, requisicoes e investimentos
**Responsavel:** Schema suprimentos — gestao de compras: pedidos, requisicoes, fornecedores, projetos OBC e notas de entrada

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `suprimentos.dfornecedor_produto` | `suprimentos.d_fornecedor_produto` | dimensao |
| `suprimentos.dlancamentos_produto` | `suprimentos.d_lancamento_produto` | dimensao |
| `suprimentos.dlancamentos_servico` | `suprimentos.d_lancamento_servico` | dimensao |
| `suprimentos.dobc_empresas` | `suprimentos.d_obc_empresa` | dimensao |
| `suprimentos.dobc_sdcv_detalhes` | `suprimentos.f_obc_sdcv_detalhe` | fato |
| `suprimentos.dobc_sdcv_resumo` | `suprimentos.f_obc_sdcv_resumo` | fato |
| `suprimentos.fauditorio_de_pedido_de_compra` | `suprimentos.f_auditoria_pedido_compra` | fato |
| `suprimentos.fdados_bi` | `suprimentos.f_compra_bi` | fato |
| `suprimentos.finvestimento_realizado` | `suprimentos.f_investimento_realizado` | fato |
| `suprimentos.fitem_projeto_obc` | `suprimentos.f_obc_item_projeto` | fato |
| `suprimentos.fnota_entrada` | `suprimentos.f_nota_entrada` | fato |
| `suprimentos.fnota_entrada2` | `suprimentos.f_nota_entrada_legado` | fato |
| `suprimentos.fpendencias_acessorios` | `suprimentos.f_pendencia_acessorio` | fato |
| `suprimentos.fprojeto_obc` | `suprimentos.f_obc_projeto` | fato |
| `suprimentos.frequisicoes_compra` | `suprimentos.f_requisicao_compra` | fato |

---

## Detalhamento por Tabela

---

### suprimentos.dfornecedor_produto

**Nome proposto:** `suprimentos.d_fornecedor_produto`
**Tipo:** dimensao
**Descricao:** Relacao entre fornecedor e produto, com parametros de reposicao (lote, tempo, moeda). Tabela bridge entre `d_fornecedor` e produto.
**Sistema de origem:** Systextil / ERP

> **Decisao pendente:** As colunas `"código produto"` e `descrição` tem acentos e cedilha no nome — devem ser normalizadas urgentemente. Ver CONFLITOS_E_DECISOES_PENDENTES.md.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key (sem PK) |
| `"código produto"` | `text NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | **CRITICO:** nome com acento e cedilha; mapear para SKU padrao do DW |
| `descrição` | `text NULL` | `ds_produto` | `varchar(100)` | [RENAME] [RETYPE] | **CRITICO:** coluna com acento — renomear |
| `"cnpj fornecedor"` | `text NULL` | `cnpj_fornecedor` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ; formato `XXXXXXXX/YYYY-ZZ`; nome da dimensao `d_fornecedor` |
| `nome_fornecedor` | `text NULL` | `nm_fornecedor` | `varchar(100)` | [RENAME] [RETYPE] | Nome do fornecedor; prefixo `nm_` |
| `codigo_fornecedor` | `text NULL` | `cod_fornecedor` | `varchar(18)` | [RENAME] [RETYPE] | Business key do fornecedor — join key com `d_fornecedor` |
| `tempo_reposicao` | `numeric(5) NULL` | `nr_tempo_reposicao_dias` | `smallint` | [RENAME] [RETYPE] | Tempo em dias; `smallint` suficiente |
| `lote_multiplo` | `numeric(12,3) NULL` | `qt_lote_multiplo` | `numeric(15,3)` | [RENAME] [RETYPE] | Lote multiplo de pedido |
| `codigo_moeda` | `numeric(2) NULL` | `id_moeda` | `smallint` | [RENAME] [RETYPE] | Codigo da moeda; `id_` operacional |
| `unid_conv` | `text NULL` | `ds_unidade_conversao` | `varchar(10)` | [RENAME] [RETYPE] | Unidade de conversao |
| `fator_conv` | `numeric(14,6) NULL` | `vl_fator_conversao` | `numeric(14,6)` | [RENAME] | Fator de conversao |
| `qtde_por_embalagem` | `numeric(13,3) NULL` | `qt_por_embalagem` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd por embalagem |
| `operador_calc` | `text NULL` | `ds_operador_calculo` | `varchar(10)` | [RENAME] [RETYPE] | Operador de calculo (*, /, +, -) |
| `desc_referencia` | `varchar(85) NULL` | `ds_referencia` | `varchar(85)` | [RENAME] | Descricao da referencia do produto |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Migracao SQL

```sql
ALTER TABLE suprimentos.dfornecedor_produto RENAME TO d_fornecedor_produto;
ALTER TABLE suprimentos.d_fornecedor_produto ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.d_fornecedor_produto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.d_fornecedor_produto ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN "código produto" TO sku_produto;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN "descrição" TO ds_produto;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN ds_produto TYPE varchar(100);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN "cnpj fornecedor" TO cnpj_fornecedor;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN cnpj_fornecedor TYPE varchar(16);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN nome_fornecedor TO nm_fornecedor;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN nm_fornecedor TYPE varchar(100);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN codigo_fornecedor TO cod_fornecedor;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN cod_fornecedor TYPE varchar(18);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN tempo_reposicao TO nr_tempo_reposicao_dias;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN nr_tempo_reposicao_dias TYPE smallint;
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN lote_multiplo TO qt_lote_multiplo;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN qt_lote_multiplo TYPE numeric(15,3);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN codigo_moeda TO id_moeda;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN id_moeda TYPE smallint;
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN unid_conv TO ds_unidade_conversao;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN ds_unidade_conversao TYPE varchar(10);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN fator_conv TO vl_fator_conversao;
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN qtde_por_embalagem TO qt_por_embalagem;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN qt_por_embalagem TYPE numeric(15,3);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN operador_calc TO ds_operador_calculo;
ALTER TABLE suprimentos.d_fornecedor_produto ALTER COLUMN ds_operador_calculo TYPE varchar(10);
ALTER TABLE suprimentos.d_fornecedor_produto RENAME COLUMN desc_referencia TO ds_referencia;
CREATE OR REPLACE VIEW suprimentos.dfornecedor_produto AS SELECT * FROM suprimentos.d_fornecedor_produto;
COMMENT ON VIEW suprimentos.dfornecedor_produto IS 'DEPRECATED 2026-05-05: usar d_fornecedor_produto. Sera removido em 2026-08-03.';
```

---

### suprimentos.dlancamentos_produto

**Nome proposto:** `suprimentos.d_lancamento_produto`
**Tipo:** dimensao
**Descricao:** Relacao entre produto e centro de custo via numero contabil. Tabela de vinculo para lancamentos contabeis de produtos.
**Sistema de origem:** Systextil / contabilidade

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `produto` | `text NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | Identificador do produto; mapear para SKU padrao |
| `num_contabil` | `numeric(9) NULL` | `nr_conta_contabil` | `integer` | [RENAME] [RETYPE] | Numero da conta contabil |
| `documento` | `numeric(9) NULL` | `nr_documento` | `integer` | [RENAME] [RETYPE] | Numero do documento fiscal |
| `centro_de_custo` | `text NULL` | `ds_centro_custo` | `varchar(80)` | [RENAME] [RETYPE] | Descricao do centro de custo |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE suprimentos.dlancamentos_produto RENAME TO d_lancamento_produto;
ALTER TABLE suprimentos.d_lancamento_produto ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.d_lancamento_produto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.d_lancamento_produto RENAME COLUMN produto TO sku_produto;
ALTER TABLE suprimentos.d_lancamento_produto ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE suprimentos.d_lancamento_produto RENAME COLUMN num_contabil TO nr_conta_contabil;
ALTER TABLE suprimentos.d_lancamento_produto ALTER COLUMN nr_conta_contabil TYPE integer;
ALTER TABLE suprimentos.d_lancamento_produto RENAME COLUMN documento TO nr_documento;
ALTER TABLE suprimentos.d_lancamento_produto ALTER COLUMN nr_documento TYPE integer;
ALTER TABLE suprimentos.d_lancamento_produto RENAME COLUMN centro_de_custo TO ds_centro_custo;
ALTER TABLE suprimentos.d_lancamento_produto ALTER COLUMN ds_centro_custo TYPE varchar(80);
ALTER TABLE suprimentos.d_lancamento_produto RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE suprimentos.d_lancamento_produto ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE suprimentos.d_lancamento_produto ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW suprimentos.dlancamentos_produto AS SELECT * FROM suprimentos.d_lancamento_produto;
COMMENT ON VIEW suprimentos.dlancamentos_produto IS 'DEPRECATED 2026-05-05: usar d_lancamento_produto. Sera removido em 2026-08-03.';
```

---

### suprimentos.dlancamentos_servico

**Nome proposto:** `suprimentos.d_lancamento_servico`
**Tipo:** dimensao
**Descricao:** Relacao entre servico/produto e centro de custo via duplicata. Analogo a `d_lancamento_produto` para servicos.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `produto` | `text NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | Produto/servico vinculado |
| `num_contabil` | `numeric(9) NULL` | `nr_conta_contabil` | `integer` | [RENAME] [RETYPE] | Conta contabil |
| `nr_duplicata` | `numeric(9) NULL` | `nr_duplicata` | `integer` | [RETYPE] | Numero da duplicata; tipo OK, apenas retype |
| `centro_de_custo` | `text NULL` | `ds_centro_custo` | `varchar(80)` | [RENAME] [RETYPE] | Centro de custo |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE suprimentos.dlancamentos_servico RENAME TO d_lancamento_servico;
ALTER TABLE suprimentos.d_lancamento_servico ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.d_lancamento_servico ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.d_lancamento_servico RENAME COLUMN produto TO sku_produto;
ALTER TABLE suprimentos.d_lancamento_servico ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE suprimentos.d_lancamento_servico RENAME COLUMN num_contabil TO nr_conta_contabil;
ALTER TABLE suprimentos.d_lancamento_servico ALTER COLUMN nr_conta_contabil TYPE integer;
ALTER TABLE suprimentos.d_lancamento_servico ALTER COLUMN nr_duplicata TYPE integer;
ALTER TABLE suprimentos.d_lancamento_servico RENAME COLUMN centro_de_custo TO ds_centro_custo;
ALTER TABLE suprimentos.d_lancamento_servico ALTER COLUMN ds_centro_custo TYPE varchar(80);
ALTER TABLE suprimentos.d_lancamento_servico RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE suprimentos.d_lancamento_servico ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE suprimentos.d_lancamento_servico ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW suprimentos.dlancamentos_servico AS SELECT * FROM suprimentos.d_lancamento_servico;
COMMENT ON VIEW suprimentos.dlancamentos_servico IS 'DEPRECATED 2026-05-05: usar d_lancamento_servico. Sera removido em 2026-08-03.';
```

---

### suprimentos.dobc_empresas

**Nome proposto:** `suprimentos.d_obc_empresa`
**Tipo:** dimensao
**Descricao:** Empresas e filiais cadastradas no OBC (Orion Business Cloud), com status e hierarquia empresa/filial.
**Sistema de origem:** OBC (Orion Business Cloud) — sistema de compras

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `id_filial` | `text NULL` | `cod_filial` | `varchar(20)` | [RENAME] [RETYPE] | Codigo da filial (OBC); renomear `id_` para `cod_` pois e join key |
| `filial_razao_social` | `text NULL` | `nm_filial_razao` | `varchar(100)` | [RENAME] [RETYPE] | Razao social da filial |
| `filial_nome_fantasia` | `text NULL` | `nm_filial_fantasia` | `varchar(100)` | [RENAME] [RETYPE] | Nome fantasia |
| `filial_status` | `text NULL` | `id_status_filial` | `varchar(20)` | [RENAME] [RETYPE] | Status da filial (codigo) |
| `filial_empresa` | `text NULL` | `nm_empresa_grupo` | `varchar(100)` | [RENAME] [RETYPE] | Nome do grupo empresarial |
| `id_empresa` | `text NULL` | `cod_empresa_obc` | `varchar(20)` | [RENAME] [RETYPE] | Codigo da empresa no OBC |
| `filial_status_nome` | `text NULL` | `ds_status_filial` | `varchar(50)` | [RENAME] [RETYPE] | Descricao do status |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE suprimentos.dobc_empresas RENAME TO d_obc_empresa;
ALTER TABLE suprimentos.d_obc_empresa ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.d_obc_empresa ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.d_obc_empresa ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN id_filial TO cod_filial;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN cod_filial TYPE varchar(20);
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN filial_razao_social TO nm_filial_razao;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN nm_filial_razao TYPE varchar(100);
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN filial_nome_fantasia TO nm_filial_fantasia;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN nm_filial_fantasia TYPE varchar(100);
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN filial_status TO id_status_filial;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN id_status_filial TYPE varchar(20);
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN filial_empresa TO nm_empresa_grupo;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN nm_empresa_grupo TYPE varchar(100);
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN id_empresa TO cod_empresa_obc;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN cod_empresa_obc TYPE varchar(20);
ALTER TABLE suprimentos.d_obc_empresa RENAME COLUMN filial_status_nome TO ds_status_filial;
ALTER TABLE suprimentos.d_obc_empresa ALTER COLUMN ds_status_filial TYPE varchar(50);
CREATE OR REPLACE VIEW suprimentos.dobc_empresas AS SELECT * FROM suprimentos.d_obc_empresa;
COMMENT ON VIEW suprimentos.dobc_empresas IS 'DEPRECATED 2026-05-05: usar d_obc_empresa. Sera removido em 2026-08-03.';
```

---

### suprimentos.dobc_sdcv_detalhes

**Nome proposto:** `suprimentos.f_obc_sdcv_detalhe`
**Tipo:** fato
**Descricao:** Detalhamento de cada SDCV (Solicitacao de Compra e Venda) do OBC: item, fornecedor, proposta, cotacao, saving, NF e prazos.
**Sistema de origem:** OBC (Orion Business Cloud)

> Esta tabela tem 90+ colunas, muitas com tipos `numeric(38,18)` (inadequados — heranca do Oracle). Este dicionario lista as renomeacoes; a migracao deve ser executada em janela de manutencao.

#### Colunas — Mapeamento completo

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| `sdcv_codigo` | `nr_sdcv` | `bigint` | Numero do SDCV |
| `sdcv_requisicao_erp` | `nr_requisicao_erp` | `varchar(50)` | Numero da requisicao no ERP |
| `sdcv_prioridade` | `ds_prioridade` | `varchar(50)` | Prioridade |
| `sdcv_motivo_urgencia` | `ds_motivo_urgencia` | `varchar(100)` | Motivo de urgencia |
| `sdc_descricao_adicional` | `obs_descricao_adicional` | `text` | Descricao adicional |
| `sdc_motivo_outro` | `obs_motivo_outro` | `text` | Outro motivo |
| `sdc_descricao` | `ds_sdc` | `varchar(200)` | Descricao da solicitacao |
| `comentario_uso_interno` | `obs_uso_interno` | `text` | Comentario interno |
| `sdcv_tipo` | `ds_tipo_sdcv` | `varchar(50)` | Tipo do SDCV |
| `sdcv_tipo_registro` | `ds_tipo_registro` | `varchar(50)` | Tipo de registro |
| `sdcv_tipo_compra` | `ds_tipo_compra` | `varchar(50)` | Tipo de compra |
| `contrato_numero` | `nr_contrato` | `integer` | Numero do contrato |
| `sdcv_solicitante` | `nm_solicitante` | `varchar(100)` | Solicitante |
| `sdcv_comprador` | `nm_comprador` | `varchar(100)` | Comprador |
| `sdcv_c_custo_codigo` | `ds_centro_custo_cod` | `varchar(50)` | Codigo do CC |
| `sdcv_c_custo_nome` | `ds_centro_custo` | `varchar(100)` | Nome do CC |
| `sdcv_c_contabil_codigo` | `ds_conta_contabil_cod` | `varchar(50)` | Conta contabil |
| `sdcv_c_contabil_nome` | `ds_conta_contabil` | `varchar(100)` | Nome conta contabil |
| `sdcv_empresa` | `nm_empresa` | `varchar(100)` | Empresa |
| `sdcv_filial_nome` | `nm_filial` | `varchar(100)` | Filial |
| `sdcv_filial_razao_social` | `nm_filial_razao` | `varchar(150)` | Razao social |
| `sdcv_local_entrega_nome` | `nm_local_entrega` | `varchar(100)` | Local de entrega |
| `sdcv_grupo_descricao` | `ds_grupo` | `varchar(100)` | Grupo |
| `sdcv_quantidade` | `qt_solicitada` | `numeric(15,3)` | Quantidade solicitada |
| `sdcv_unidade` | `ds_unidade` | `varchar(20)` | Unidade de medida |
| `sdcv_de_projeto` | `fl_de_projeto` | `varchar(10)` | Se e de projeto |
| `projeto_codigo` | `cod_projeto` | `bigint` | Codigo do projeto |
| `projeto_nome` | `nm_projeto` | `text` | Nome do projeto |
| `projeto_fase_codigo` | `id_fase_projeto` | `integer` | Codigo da fase |
| `projeto_fase` | `ds_fase_projeto` | `text` | Nome da fase |
| `categoria_nivel_1` | `ds_categoria_n1` | `text` | Categoria nivel 1 |
| `categoria_nivel_2` | `ds_categoria_n2` | `text` | Categoria nivel 2 |
| `categoria_nivel_3` | `ds_categoria_n3` | `text` | Categoria nivel 3 |
| `caracteristica_item` | `ds_caracteristica_item` | `text` | Caracteristica |
| `item_codigo` | `id_item` | `integer` | Codigo do item |
| `item_codigo_erp` | `cod_item_erp` | `text` | Codigo ERP do item |
| `item_nome` | `nm_item` | `text` | Nome do item |
| `proposta_de_contrato` | `ds_proposta_contrato` | `text` | Proposta de contrato |
| `proposta_frete` | `ds_tipo_frete` | `text` | Tipo de frete |
| `proposta_valor_frete` | `vl_frete` | `numeric(15,2)` | Valor do frete |
| `proposta_vlr_unit` | `vl_unitario` | `numeric(15,5)` | Valor unitario |
| `proposta_vlr_total` | `vl_total` | `numeric(15,2)` | Valor total |
| `proposta_vlr_unit_inicial` | `vl_unitario_inicial` | `numeric(15,5)` | Valor unitario inicial |
| `proposta_vlr_total_inicial` | `vl_total_inicial` | `numeric(15,2)` | Valor total inicial |
| `proposta_custo_unit` | `vl_custo_unitario` | `numeric(15,5)` | Custo unitario |
| `proposta_custo_total` | `vl_custo_total` | `numeric(15,2)` | Custo total |
| `saving_vlr_valor_saving` | `vl_saving` | `numeric(15,2)` | Saving em valor |
| `saving_vlr_percentual_saving` | `pc_saving` | `numeric(7,4)` | Saving percentual |
| `fornecedor_razao_social` | `nm_fornecedor_razao` | `text` | Razao social |
| `fornecedor_fantasia` | `nm_fornecedor_fantasia` | `text` | Nome fantasia |
| `fornecedor_cnpj` | `cnpj_fornecedor` | `varchar(16)` | CNPJ no formato DW |
| `fornecedor_cidade` | `nm_cidade_fornecedor` | `text` | Cidade |
| `fornecedor_estado` | `ds_uf_fornecedor` | `varchar(2)` | UF |
| `compra_numero` | `nr_compra` | `integer` | Numero da compra |
| `pedido_numero` | `nr_pedido` | `text` | Numero do pedido |
| `pedido_qtd_pedida` | `qt_pedida` | `numeric(15,3)` | Qtd pedida |
| `pedido_qtd_recebida` | `qt_recebida` | `numeric(15,3)` | Qtd recebida |
| `pedido_qtd_saldo` | `qt_saldo` | `numeric(15,3)` | Qtd saldo |
| `pedido_situacao_entrega` | `ds_situacao_entrega` | `text` | Situacao entrega |
| `nf_numero` | `nr_nota_fiscal` | `text` | Numero da NF |
| `nf_serie` | `nr_serie_nf` | `text` | Serie |
| `nf_data_emissao` | `dt_emissao_nf` | `text` | Data emissao (texto — converter no ETL) |
| `data_criacao_sdcv` | `dt_criacao` | `text` | Data criacao |
| `data_emissao_pedido` | `dt_emissao_pedido` | `text` | Data emissao pedido |
| `data_previsao_entrega` | `dt_previsao_entrega` | `text` | Previsao entrega |
| `data_primeira_entrega` | `dt_primeira_entrega` | `text` | Primeira entrega |
| `data_ultima_entrega` | `dt_ultima_entrega` | `text` | Ultima entrega |
| `prazo_sugerido` | `nr_prazo_sugerido_dias` | `integer` | Prazo em dias |
| `prazo_solicitante` | `nr_prazo_solicitante_dias` | `integer` | Prazo solicitante |
| `tempo_total` | `nr_tempo_total_dias` | `numeric(10,2)` | Tempo total |
| `nota_primeiro_vencimento` | `dth_primeiro_vencimento` | `timestamp` | Vencimento |
| `nota_item_valor` | `vl_item_nf` | `numeric(15,2)` | Valor do item NF |
| `sdc_status` | `ds_status_sdc` | `text` | Status do SDC |
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

> **Decisao pendente:** Todas as colunas de data sao `text` — o ETL deve converter para `date`/`timestamp` antes de inserir.

#### Migracao SQL (parcial — principais renomeacoes)

```sql
ALTER TABLE suprimentos.dobc_sdcv_detalhes RENAME TO f_obc_sdcv_detalhe;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN sdcv_codigo TO nr_sdcv;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN sdcv_solicitante TO nm_solicitante;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN sdcv_comprador TO nm_comprador;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN sdcv_quantidade TO qt_solicitada;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ALTER COLUMN qt_solicitada TYPE numeric(15,3) USING qt_solicitada::numeric(15,3);
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN proposta_vlr_unit TO vl_unitario;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ALTER COLUMN vl_unitario TYPE numeric(15,5) USING vl_unitario::numeric(15,5);
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN proposta_vlr_total TO vl_total;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ALTER COLUMN vl_total TYPE numeric(15,2) USING vl_total::numeric(15,2);
ALTER TABLE suprimentos.f_obc_sdcv_detalhe RENAME COLUMN fornecedor_cnpj TO cnpj_fornecedor;
ALTER TABLE suprimentos.f_obc_sdcv_detalhe ALTER COLUMN cnpj_fornecedor TYPE varchar(16);
-- (continuar para todas as demais colunas conforme tabela acima)
CREATE OR REPLACE VIEW suprimentos.dobc_sdcv_detalhes AS SELECT * FROM suprimentos.f_obc_sdcv_detalhe;
COMMENT ON VIEW suprimentos.dobc_sdcv_detalhes IS 'DEPRECATED 2026-05-05: usar f_obc_sdcv_detalhe. Sera removido em 2026-08-03.';
```

---

### suprimentos.dobc_sdcv_resumo

**Nome proposto:** `suprimentos.f_obc_sdcv_resumo`
**Tipo:** fato
**Descricao:** Resumo de cada SDCV: status, valores totais, saving, moeda e datas principais.
**Sistema de origem:** OBC

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| `id_sdcv` | `nr_sdcv` | `bigint` |
| `sdcv_status` | `id_status_sdcv` | `varchar(20)` |
| `sdcv_status_nome` | `ds_status_sdcv` | `varchar(50)` |
| `sdcv_tipo` | `ds_tipo_sdcv` | `varchar(50)` |
| `sdcv_prioridade` | `ds_prioridade` | `varchar(50)` |
| `sdcv_tipo_registro` | `ds_tipo_registro` | `varchar(50)` |
| `sdcv_tipo_compra` | `ds_tipo_compra` | `varchar(50)` |
| `sdcv_qtdade` | `qt_solicitada` | `numeric(15,3)` |
| `sdcv_valor_total` | `vl_total` | `numeric(15,2)` |
| `sdcv_saving_valor` | `vl_saving` | `numeric(15,2)` |
| `sdcv_saving_percentual` | `pc_saving` | `numeric(7,4)` |
| `sdcv_saving_tipo` | `ds_tipo_saving` | `text` |
| `sdcv_moeda` | `ds_moeda` | `text` |
| `sdcv_data_criacao` | `dt_criacao` | `text` |
| `sdcv_data_envio_cotacao` | `dt_envio_cotacao` | `text` |
| `sdcv_data_envio_aprovacao` | `dt_envio_aprovacao` | `text` |
| `sdcv_data_compra` | `dt_compra` | `text` |
| `id_solicitante` | `id_solicitante` | `text` |
| `id_comprador` | `id_comprador` | `text` |
| `id_item` | `id_item` | `text` |
| `sdcv_filial_razao` | `nm_filial_razao` | `text` |
| `id_filial` | `cod_filial` | `text` |
| `sdcv_empresa_nome` | `nm_empresa` | `text` |
| `id_projeto` | `cod_projeto` | `bigint` |
| `id_fase_projeto` | `id_fase_projeto` | `integer` |
| `id_contrato` | `nr_contrato` | `integer` |
| `id_pedido` | `nr_pedido` | `text` |
| `id_compra` | `nr_compra` | `integer` |
| `id_cotacao` | `nr_cotacao` | `integer` |
| `sdcv_motivo` | `ds_motivo` | `text` |
| `sdcv_descricao_complementar` | `obs_descricao_complementar` | `text` |
| `sdcv_descricao_interna` | `obs_descricao_interna` | `text` |
| `sdcv_motivo_escolha_fornecedor` | `obs_motivo_escolha_forn` | `text` |
| `sdc_data_ult_movimentacao` | `dth_ultima_movimentacao` | `timestamp` |
| `sdc_target` | `vl_target` | `numeric(18,6)` |
| ADD | `id` | `bigserial NOT NULL` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

#### Migracao SQL (resumida)

```sql
ALTER TABLE suprimentos.dobc_sdcv_resumo RENAME TO f_obc_sdcv_resumo;
ALTER TABLE suprimentos.f_obc_sdcv_resumo ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_obc_sdcv_resumo ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_obc_sdcv_resumo ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme tabela acima
CREATE OR REPLACE VIEW suprimentos.dobc_sdcv_resumo AS SELECT * FROM suprimentos.f_obc_sdcv_resumo;
COMMENT ON VIEW suprimentos.dobc_sdcv_resumo IS 'DEPRECATED 2026-05-05: usar f_obc_sdcv_resumo. Sera removido em 2026-08-03.';
```

---

### suprimentos.fauditorio_de_pedido_de_compra

**Nome proposto:** `suprimentos.f_auditoria_pedido_compra`
**Tipo:** fato
**Descricao:** Auditoria de pedidos de compra comparando valor de titulo com valor do pedido. Identifica divergencias.
**Sistema de origem:** Systextil / financeiro

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `titulo` | `numeric(9) NULL` | `nr_titulo` | `integer` | [RENAME] [RETYPE] | Numero do titulo |
| `tipo_titulo` | `numeric(2) NULL` | `id_tipo_titulo` | `smallint` | [RENAME] [RETYPE] | Tipo do titulo |
| `cnpj_titulo` | `text NULL` | `cnpj_fornecedor` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ no formato DW |
| `emitente_titulo` | `text NULL` | `nm_emitente` | `varchar(100)` | [RENAME] [RETYPE] | Nome do emitente |
| `centro_custo` | `numeric(6) NULL` | `id_centro_custo` | `integer` | [RENAME] [RETYPE] | Codigo do centro de custo |
| `valor_titulo` | `numeric(38,10) NULL` | `vl_titulo` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor do titulo; `numeric(38,10)` inadequado |
| `pedido` | `numeric(38,10) NULL` | `nr_pedido` | `integer` | [RENAME] [RETYPE] | Numero do pedido |
| `valor_pedido` | `numeric(38,10) NULL` | `vl_pedido` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor do pedido |
| `valor_diferenca` | `numeric(38,10) NULL` | `vl_diferenca` | `numeric(15,2)` | [RENAME] [RETYPE] | Diferenca titulo x pedido |
| `encontrado` | `text NULL` | `fl_encontrado` | `varchar(3)` | [RENAME] [RETYPE] | Flag de correspondencia (S/N) — avaliar converter para boolean |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE suprimentos.fauditorio_de_pedido_de_compra RENAME TO f_auditoria_pedido_compra;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN titulo TO nr_titulo;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN nr_titulo TYPE integer USING nr_titulo::integer;
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN tipo_titulo TO id_tipo_titulo;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN id_tipo_titulo TYPE smallint;
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN cnpj_titulo TO cnpj_fornecedor;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN cnpj_fornecedor TYPE varchar(16);
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN emitente_titulo TO nm_emitente;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN nm_emitente TYPE varchar(100);
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN centro_custo TO id_centro_custo;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN id_centro_custo TYPE integer;
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN valor_titulo TO vl_titulo;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN vl_titulo TYPE numeric(15,2) USING vl_titulo::numeric(15,2);
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN pedido TO nr_pedido;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN nr_pedido TYPE integer USING nr_pedido::integer;
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN valor_pedido TO vl_pedido;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN vl_pedido TYPE numeric(15,2) USING vl_pedido::numeric(15,2);
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN valor_diferenca TO vl_diferenca;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN vl_diferenca TYPE numeric(15,2) USING vl_diferenca::numeric(15,2);
ALTER TABLE suprimentos.f_auditoria_pedido_compra RENAME COLUMN encontrado TO fl_encontrado;
ALTER TABLE suprimentos.f_auditoria_pedido_compra ALTER COLUMN fl_encontrado TYPE varchar(3);
CREATE OR REPLACE VIEW suprimentos.fauditorio_de_pedido_de_compra AS SELECT * FROM suprimentos.f_auditoria_pedido_compra;
COMMENT ON VIEW suprimentos.fauditorio_de_pedido_de_compra IS 'DEPRECATED 2026-05-05: usar f_auditoria_pedido_compra. Sera removido em 2026-08-03.';
```

---

### suprimentos.fdados_bi

**Nome proposto:** `suprimentos.f_compra_bi`
**Tipo:** fato
**Descricao:** Visao consolidada de compras para BI: SDCV, pedido, fornecedor, item, NF e valores. Subconjunto de `f_obc_sdcv_detalhe`.
**Sistema de origem:** OBC

> **Decisao pendente:** Avaliar se `f_compra_bi` pode ser substituida por uma view sobre `f_obc_sdcv_detalhe` ao inves de tabela materializada.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| `sdcv_tipo` | `ds_tipo_sdcv` | `text` |
| `data_criacao_sdcv` | `dt_criacao` | `text` |
| `data_ultima_entrega` | `dt_ultima_entrega` | `text` |
| `centro_de_custo_cod` | `ds_centro_custo_cod` | `text` |
| `projeto_codigo` | `cod_projeto` | `bigint` |
| `projeto_nome` | `nm_projeto` | `text` |
| `sdcv_empresa` | `nm_empresa` | `text` |
| `sdcv_c_contabil_codigo` | `ds_conta_contabil_cod` | `text` |
| `sdcv_codigo` | `nr_sdcv` | `numeric(15)` |
| `pedido_numero` | `nr_pedido` | `text` |
| `sdcv_solicitante` | `nm_solicitante` | `text` |
| `fornecedor_cnpj` | `cnpj_fornecedor` | `varchar(16)` |
| `fornecedor_razao_social` | `nm_fornecedor` | `text` |
| `item_codigo_erp` | `cod_item_erp` | `text` |
| `item_nome` | `nm_item` | `text` |
| `nf_numero` | `nr_nota_fiscal` | `text` |
| `nota_item_valor` | `vl_item_nf` | `numeric(15,3)` |
| `nf_data_emissao` | `dt_emissao_nf` | `text` |
| `nota_primeiro_vencimento` | `dth_primeiro_vencimento` | `timestamp` |
| `sdcv_valor_total` | `vl_total_sdcv` | `numeric(15,3)` |
| `proposta_vlr_unit` | `vl_unitario` | `numeric(15,3)` |
| ADD | `id` | `bigserial NOT NULL` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### suprimentos.finvestimento_realizado

**Nome proposto:** `suprimentos.f_investimento_realizado`
**Tipo:** fato
**Descricao:** Investimentos em bens patrimoniais realizados por empresa, fornecedor e centro de custo.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `empresa` | `varchar(150) NULL` | `nm_empresa` | `varchar(150)` | [RENAME] | Nome da empresa |
| `produto` | `varchar(50) NULL` | `ds_produto` | `varchar(50)` | [RENAME] | Descricao do produto/bem |
| `numero_nota` | `int4 NULL` | `nr_nota_fiscal` | `integer` | [RENAME] | Numero da NF |
| `centro_de_custo` | `varchar(150) NULL` | `ds_centro_custo` | `varchar(150)` | [RENAME] | Centro de custo |
| `fornecedor` | `varchar(20) NULL` | `cod_fornecedor` | `varchar(20)` | [RENAME] | Codigo do fornecedor |
| `nome_fornecedor` | `varchar(150) NULL` | `nm_fornecedor` | `varchar(150)` | [RENAME] | Nome do fornecedor |
| `descricao_bem` | `text NULL` | `ds_bem` | `text` | [RENAME] | Descricao do bem |
| `cod_do_bem` | `varchar(50) NULL` | `cod_bem` | `varchar(50)` | [RENAME] | Codigo do bem patrimonial |
| `observacoes_do_bem` | `text NULL` | `obs_bem` | `text` | [RENAME] | Observacoes |
| `grupo_do_bem` | `varchar(150) NULL` | `ds_grupo_bem` | `varchar(150)` | [RENAME] | Grupo do bem |
| `grupo_do_produto` | `varchar(150) NULL` | `ds_grupo_produto` | `varchar(150)` | [RENAME] | Grupo do produto |
| `data_aquisicao` | `date NULL` | `dt_aquisicao` | `date` | [RENAME] | Data de aquisicao |
| `valor_bem` | `numeric(15,2) NULL` | `vl_bem` | `numeric(15,2)` | [RENAME] | Valor do bem |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `descricao` | `varchar(300) NULL` | `obs_descricao` | `varchar(300)` | [RENAME] | Descricao adicional |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE suprimentos.finvestimento_realizado RENAME TO f_investimento_realizado;
ALTER TABLE suprimentos.f_investimento_realizado ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_investimento_realizado ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN empresa TO nm_empresa;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN produto TO ds_produto;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN numero_nota TO nr_nota_fiscal;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN centro_de_custo TO ds_centro_custo;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN fornecedor TO cod_fornecedor;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN nome_fornecedor TO nm_fornecedor;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN descricao_bem TO ds_bem;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN cod_do_bem TO cod_bem;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN observacoes_do_bem TO obs_bem;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN grupo_do_bem TO ds_grupo_bem;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN grupo_do_produto TO ds_grupo_produto;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN data_aquisicao TO dt_aquisicao;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN valor_bem TO vl_bem;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE suprimentos.f_investimento_realizado ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE suprimentos.f_investimento_realizado ALTER COLUMN updated_at SET DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_investimento_realizado RENAME COLUMN descricao TO obs_descricao;
CREATE OR REPLACE VIEW suprimentos.finvestimento_realizado AS SELECT * FROM suprimentos.f_investimento_realizado;
COMMENT ON VIEW suprimentos.finvestimento_realizado IS 'DEPRECATED 2026-05-05: usar f_investimento_realizado. Sera removido em 2026-08-03.';
```

---

### suprimentos.fitem_projeto_obc

**Nome proposto:** `suprimentos.f_obc_item_projeto`
**Tipo:** fato
**Descricao:** Itens de projetos OBC com valores previstos, aprovados e realizados por fase e fornecedor.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| `sdcv_codigo` | `nr_sdcv` | `bigint` |
| `prj_codigo` | `cod_projeto` | `bigint` |
| `prj_nome` | `nm_projeto` | `text` |
| `data_criacao_sdcv` | `dth_criacao_sdcv` | `timestamp` |
| `centro_de_custo_cod` | `ds_centro_custo_cod` | `text` |
| `sdcv_c_custo_nome` | `ds_centro_custo` | `text` |
| `pfa_codigo` | `id_fase_projeto` | `bigint` |
| `pfa_descricao` | `ds_fase_projeto` | `text` |
| `pedido_numero` | `nr_pedido` | `text` |
| `item_descricao` | `ds_item` | `text` |
| `id_item` | `id_item` | `bigint` |
| `sdcv_tipo_registro` | `ds_tipo_registro` | `text` |
| `id_categoria_nivel1` | `id_categoria_n1` | `bigint` |
| `id_categoria_nivel2` | `id_categoria_n2` | `bigint` |
| `item_categoria_nivel1` | `ds_categoria_n1` | `text` |
| `item_categoria_nivel2` | `ds_categoria_n2` | `text` |
| `item_categoria_nivel3` | `ds_categoria_n3` | `text` |
| `proposta_vlr_total` | `vl_proposta_total` | `numeric(18,2)` |
| `fornecedor_fantasia` | `nm_fornecedor_fantasia` | `text` |
| `fornecedor_cnpj` | `cnpj_fornecedor` | `varchar(16)` |
| `proposta_vlr_unit` | `vl_proposta_unitario` | `numeric(18,2)` |
| `sdcv_quantidade` | `qt_solicitada` | `numeric(18,4)` |
| `compra_numero` | `nr_compra` | `bigint` |
| `sdcv_solicitante` | `nm_solicitante` | `text` |
| `sdcv_comprador` | `nm_comprador` | `text` |
| `prj_status` | `ds_status_projeto` | `text` |
| `sdc_status` | `ds_status_sdc` | `text` |
| `prv_valor_previsto` | `vl_previsto` | `numeric(18,2)` |
| `prj_valor_aprovado` | `vl_aprovado` | `numeric(18,2)` |
| `prj_valor_base` | `vl_base` | `numeric(18,2)` |
| `valor_total` | `vl_total` | `numeric(18,3)` |
| `prazo_medio_pgto` | `nr_prazo_medio_pagto` | `integer` |
| ADD | `id` | `bigserial NOT NULL` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### suprimentos.fnota_entrada

**Nome proposto:** `suprimentos.f_nota_entrada`
**Tipo:** fato
**Descricao:** Notas fiscais de entrada de mercadorias com itens, valores tributarios e vinculo com pedido de compra.
**Sistema de origem:** Systextil

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `nf_notafiscal` | `int4 NULL` | `nr_nota_fiscal` | `integer` | [RENAME] | Numero da NF |
| `nf_serienotafiscal` | `varchar(5) NULL` | `nr_serie_nf` | `varchar(5)` | [RENAME] | Serie |
| `nf_dataemissao` | `timestamp NULL` | `dth_emissao` | `timestamp` | [RENAME] | Data/hora emissao |
| `fk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU do produto; `fk_` substituido por `sku_` |
| `pedido_compra` | `int8 NULL` | `nr_pedido_compra` | `integer` | [RENAME] [RETYPE] | Numero do pedido de compra |
| `seq_item_pedido_compra` | `int8 NULL` | `nr_seq_item` | `smallint` | [RENAME] [RETYPE] | Sequencia do item |
| `fk_cliente` | `varchar(20) NULL` | `cod_cliente` | `varchar(20)` | [RENAME] | Business key do cliente |
| `fk_fornecedor` | `varchar(20) NULL` | `cod_fornecedor` | `varchar(20)` | [RENAME] | Business key do fornecedor |
| `itemnf_vlr_tot` | `numeric(18,3) NULL` | `vl_total_item` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor total do item |
| `itemnf_quantidade` | `numeric(18,3) NULL` | `qt_faturada` | `numeric(15,3)` | [RENAME] | Quantidade faturada |
| `itemnf_vlrunit` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,5)` | [RENAME] [RETYPE] | Valor unitario |
| `itemnf_vlrdesconto` | `numeric(18,3) NULL` | `vl_desconto` | `numeric(15,2)` | [RENAME] [RETYPE] | Desconto |
| `itemnf_vlripi` | `numeric(18,3) NULL` | `vl_ipi` | `numeric(15,2)` | [RENAME] [RETYPE] | IPI |
| `itemnf_vlricms` | `numeric(18,3) NULL` | `vl_icms` | `numeric(15,2)` | [RENAME] [RETYPE] | ICMS |
| `itemnf_vlricmsdiferido` | `numeric(18,3) NULL` | `vl_icms_diferido` | `numeric(15,2)` | [RENAME] [RETYPE] | ICMS diferido |
| `itemnf_vlrpis` | `numeric(18,3) NULL` | `vl_pis` | `numeric(15,2)` | [RENAME] [RETYPE] | PIS |
| `itemnf_vlrcofins` | `numeric(18,3) NULL` | `vl_cofins` | `numeric(15,2)` | [RENAME] [RETYPE] | COFINS |
| `condicao_pagto` | `int2 NULL` | `id_condicao_pagto` | `smallint` | [RENAME] | Condicao de pagamento |
| `nf_origem` | `int4 NULL` | `id_origem_nf` | `integer` | [RENAME] | Origem da NF |
| `cfop` | `varchar(44) NULL` | `ds_cfop` | `varchar(10)` | [RENAME] [RETYPE] | CFOP (max 9 chars + descricao); limitar |
| `desc_nat_oper` | `varchar(40) NULL` | `ds_natureza_operacao` | `varchar(40)` | [RENAME] | Natureza da operacao |
| `uf` | `varchar(2) NULL` | `ds_uf` | `char(2)` | [RENAME] [RETYPE] | UF |
| `fk_centro_custo` | `int8 NULL` | `id_centro_custo` | `integer` | [RENAME] [RETYPE] | Centro de custo |
| `fk_conta_estoque` | `int4 NULL` | `id_conta_estoque` | `smallint` | [RENAME] [RETYPE] | Conta de estoque |
| `codigo_contabil` | `int4 NULL` | `id_conta_contabil` | `integer` | [RENAME] | Conta contabil |
| `fk_grupo_contas` | `int4 NULL` | `id_grupo_contas` | `integer` | [RENAME] | Grupo de contas |
| `cod_familia` | `int4 NULL` | `id_familia` | `integer` | [RENAME] | Familia do produto |
| `descricao_familia` | `varchar(20) NULL` | `ds_familia` | `varchar(20)` | [RENAME] | Descricao da familia |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `data_digitacao` | `timestamp NULL` | `dth_digitacao` | `timestamp` | [RENAME] | Data de digitacao |
| `data_transacao` | `timestamp NULL` | `dth_transacao` | `timestamp` | [RENAME] | Data da transacao |
| `usuario_digitacao` | `varchar(250) NULL` | `nm_usuario_digitacao` | `varchar(100)` | [RENAME] [RETYPE] | Usuario digitador |
| `situacao_entrada` | `int2 NULL` | `id_situacao_entrada` | `smallint` | [RENAME] | Situacao da entrada |
| `especie_docto` | `varchar(5) NULL` | `ds_especie_docto` | `varchar(5)` | [RENAME] | Especie do documento |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Relacionamentos propostos

```
suprimentos.f_nota_entrada
  |- cod_fornecedor -> live.dfornecedor.pk_fornecedor (apos renomear)
  |- sku_produto    -> live.dproduto.sku_produto
  |- cod_cliente    -> live.dcliente.pk_cliente (apos renomear)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_nota_entrada_nf ON suprimentos.f_nota_entrada (nr_nota_fiscal);
CREATE INDEX idx_f_nota_entrada_fornecedor ON suprimentos.f_nota_entrada (cod_fornecedor);
CREATE INDEX idx_f_nota_entrada_produto ON suprimentos.f_nota_entrada (sku_produto);
CREATE INDEX idx_f_nota_entrada_emissao ON suprimentos.f_nota_entrada (dth_emissao);
```

#### Migracao SQL (resumida)

```sql
ALTER TABLE suprimentos.fnota_entrada RENAME TO f_nota_entrada;
ALTER TABLE suprimentos.f_nota_entrada ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_nota_entrada ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_nota_entrada RENAME COLUMN nf_notafiscal TO nr_nota_fiscal;
ALTER TABLE suprimentos.f_nota_entrada RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE suprimentos.f_nota_entrada ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE suprimentos.f_nota_entrada RENAME COLUMN fk_fornecedor TO cod_fornecedor;
ALTER TABLE suprimentos.f_nota_entrada RENAME COLUMN fk_cliente TO cod_cliente;
ALTER TABLE suprimentos.f_nota_entrada RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE suprimentos.f_nota_entrada ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE suprimentos.f_nota_entrada ALTER COLUMN updated_at SET DEFAULT current_timestamp;
-- (continuar renomeacoes conforme tabela)
CREATE OR REPLACE VIEW suprimentos.fnota_entrada AS SELECT * FROM suprimentos.f_nota_entrada;
COMMENT ON VIEW suprimentos.fnota_entrada IS 'DEPRECATED 2026-05-05: usar f_nota_entrada. Sera removido em 2026-08-03.';
```

---

### suprimentos.fnota_entrada2

**Nome proposto:** `suprimentos.f_nota_entrada_legado`
**Tipo:** fato
**Descricao:** Versao legada de nota de entrada com tipos `numeric(38,10)` (heranca Oracle). Duplicata de `fnota_entrada` com tipos ruins.

> **Decisao pendente:** Verificar se `fnota_entrada2` tem dados que nao existem em `fnota_entrada`. Se for redundante, planejar descontinuacao. Ver CONFLITOS_E_DECISOES_PENDENTES.md.

A estrutura e identica a `f_nota_entrada` com as seguintes diferencas:
- `dthora_atualizacao` (nao `ultima_atualizacao`) → `updated_at`
- Tipos `numeric(38,10)` em lugar de `numeric(18,3)` — corrigir para padrao
- Alguns campos como `text` ao inves de `varchar` — padronizar

#### Migracao SQL (resumida)

```sql
ALTER TABLE suprimentos.fnota_entrada2 RENAME TO f_nota_entrada_legado;
-- Mesmas renomeacoes de fnota_entrada + correcao de tipos numeric(38,10) -> numeric(15,x)
ALTER TABLE suprimentos.f_nota_entrada_legado RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE suprimentos.f_nota_entrada_legado ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_nota_entrada_legado ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
-- Corrigir itemnf_vlr_tot: numeric(38,10) -> numeric(15,2)
ALTER TABLE suprimentos.f_nota_entrada_legado
    ALTER COLUMN itemnf_vlr_tot TYPE numeric(15,2) USING itemnf_vlr_tot::numeric(15,2);
CREATE OR REPLACE VIEW suprimentos.fnota_entrada2 AS SELECT * FROM suprimentos.f_nota_entrada_legado;
COMMENT ON VIEW suprimentos.fnota_entrada2 IS 'DEPRECATED 2026-05-05: usar f_nota_entrada_legado. Sera removido em 2026-08-03.';
```

---

### suprimentos.fpendencias_acessorios

**Nome proposto:** `suprimentos.f_pendencia_acessorio`
**Tipo:** fato
**Descricao:** Pendencias de acessorios por ordem de servico e producao, com CNPJ do fornecedor.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `empresa` | `numeric(3) NULL` | `id_empresa` | `smallint` | [RENAME] [RETYPE] | Codigo da empresa |
| `data_emissao` | `timestamp NULL` | `dth_emissao` | `timestamp` | [RENAME] | Data de emissao |
| `nota_fiscal` | `numeric(9) NULL` | `nr_nota_fiscal` | `integer` | [RENAME] [RETYPE] | Numero da NF |
| `serie_nota_fiscal` | `text NULL` | `nr_serie_nf` | `varchar(5)` | [RENAME] [RETYPE] | Serie |
| `ordem_servico` | `numeric(9) NULL` | `nr_ordem_servico` | `integer` | [RENAME] [RETYPE] | Numero da OS |
| `ordem_producao` | `numeric(9) NULL` | `nr_ordem_producao` | `integer` | [RENAME] [RETYPE] | Numero da OP |
| `cnpj_fornecedor` | `text NULL` | `cnpj_fornecedor` | `varchar(16)` | [RETYPE] | CNPJ padrao DW; `text` → `varchar(16)` |
| `nome_fornecedor` | `text NULL` | `nm_fornecedor` | `varchar(100)` | [RENAME] [RETYPE] | Nome do fornecedor |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE suprimentos.fpendencias_acessorios RENAME TO f_pendencia_acessorio;
ALTER TABLE suprimentos.f_pendencia_acessorio ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_pendencia_acessorio ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_pendencia_acessorio ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN empresa TO id_empresa;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN id_empresa TYPE smallint;
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN data_emissao TO dth_emissao;
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN nota_fiscal TO nr_nota_fiscal;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN nr_nota_fiscal TYPE integer;
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN serie_nota_fiscal TO nr_serie_nf;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN nr_serie_nf TYPE varchar(5);
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN ordem_servico TO nr_ordem_servico;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN nr_ordem_servico TYPE integer;
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN ordem_producao TO nr_ordem_producao;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN nr_ordem_producao TYPE integer;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN cnpj_fornecedor TYPE varchar(16);
ALTER TABLE suprimentos.f_pendencia_acessorio RENAME COLUMN nome_fornecedor TO nm_fornecedor;
ALTER TABLE suprimentos.f_pendencia_acessorio ALTER COLUMN nm_fornecedor TYPE varchar(100);
CREATE OR REPLACE VIEW suprimentos.fpendencias_acessorios AS SELECT * FROM suprimentos.f_pendencia_acessorio;
COMMENT ON VIEW suprimentos.fpendencias_acessorios IS 'DEPRECATED 2026-05-05: usar f_pendencia_acessorio. Sera removido em 2026-08-03.';
```

---

### suprimentos.fprojeto_obc

**Nome proposto:** `suprimentos.f_obc_projeto`
**Tipo:** fato
**Descricao:** Projetos OBC com valores previstos, orcados, empenhados e realizados por fase.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `projeto_codigo` | `int8 NULL` | `cod_projeto` | `bigint` | [RENAME] | Business key do projeto |
| `projeto_nome` | `text NULL` | `nm_projeto` | `text` | [RENAME] | Nome |
| `projeto_fase` | `text NULL` | `ds_fase_projeto` | `text` | [RENAME] | Fase |
| `projeto_fase_codigo` | `int4 NULL` | `id_fase_projeto` | `integer` | [RENAME] | Codigo da fase |
| `prj_data_ini` | `date NULL` | `dt_inicio` | `date` | [RENAME] | Data inicio |
| `prj_data_fim` | `date NULL` | `dt_fim` | `date` | [RENAME] | Data fim |
| `"valor total previsto"` | `numeric(38,18) NULL` | `vl_previsto_total` | `numeric(18,2)` | [RENAME] [RETYPE] | **CRITICO:** nome com espaco |
| `"valor total orçado"` | `numeric(38,18) NULL` | `vl_orcado_total` | `numeric(18,2)` | [RENAME] [RETYPE] | **CRITICO:** acento no nome |
| `"valor total empenhado"` | `numeric(38,18) NULL` | `vl_empenhado_total` | `numeric(18,2)` | [RENAME] [RETYPE] | Empenhado |
| `"valor total empenhado em contrato"` | `numeric(38,18) NULL` | `vl_empenhado_contrato` | `numeric(18,2)` | [RENAME] [RETYPE] | Empenhado em contrato |
| `"valor total pedidos"` | `numeric(38,18) NULL` | `vl_pedidos_total` | `numeric(18,2)` | [RENAME] [RETYPE] | Total em pedidos |
| `"valor total requisicoes de estoque"` | `numeric(38,18) NULL` | `vl_requisicoes_estoque` | `numeric(18,2)` | [RENAME] [RETYPE] | Requisicoes estoque |
| `"valor total notas fiscais"` | `numeric(38,18) NULL` | `vl_notas_fiscais` | `numeric(18,2)` | [RENAME] [RETYPE] | Total NFs |
| `"saldo total"` | `numeric(38,18) NULL` | `vl_saldo` | `numeric(18,2)` | [RENAME] [RETYPE] | Saldo |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

> **CRITICO:** 8 colunas tem espacos e/ou acentos nos nomes. Prioridade alta para renomear.

#### Migracao SQL

```sql
ALTER TABLE suprimentos.fprojeto_obc RENAME TO f_obc_projeto;
ALTER TABLE suprimentos.f_obc_projeto ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_obc_projeto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_obc_projeto ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN projeto_codigo TO cod_projeto;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN projeto_nome TO nm_projeto;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN projeto_fase TO ds_fase_projeto;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN projeto_fase_codigo TO id_fase_projeto;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN prj_data_ini TO dt_inicio;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN prj_data_fim TO dt_fim;
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total previsto" TO vl_previsto_total;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_previsto_total TYPE numeric(18,2) USING vl_previsto_total::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total orçado" TO vl_orcado_total;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_orcado_total TYPE numeric(18,2) USING vl_orcado_total::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total empenhado" TO vl_empenhado_total;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_empenhado_total TYPE numeric(18,2) USING vl_empenhado_total::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total empenhado em contrato" TO vl_empenhado_contrato;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_empenhado_contrato TYPE numeric(18,2) USING vl_empenhado_contrato::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total pedidos" TO vl_pedidos_total;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_pedidos_total TYPE numeric(18,2) USING vl_pedidos_total::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total requisicoes de estoque" TO vl_requisicoes_estoque;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_requisicoes_estoque TYPE numeric(18,2) USING vl_requisicoes_estoque::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "valor total notas fiscais" TO vl_notas_fiscais;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_notas_fiscais TYPE numeric(18,2) USING vl_notas_fiscais::numeric(18,2);
ALTER TABLE suprimentos.f_obc_projeto RENAME COLUMN "saldo total" TO vl_saldo;
ALTER TABLE suprimentos.f_obc_projeto ALTER COLUMN vl_saldo TYPE numeric(18,2) USING vl_saldo::numeric(18,2);
CREATE OR REPLACE VIEW suprimentos.fprojeto_obc AS SELECT * FROM suprimentos.f_obc_projeto;
COMMENT ON VIEW suprimentos.fprojeto_obc IS 'DEPRECATED 2026-05-05: usar f_obc_projeto. Sera removido em 2026-08-03.';
```

---

### suprimentos.frequisicoes_compra

**Nome proposto:** `suprimentos.f_requisicao_compra`
**Tipo:** fato
**Descricao:** Requisicoes de compra com status, produto, fornecedor, quantidades e parametros de estoque.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `num_requisicao` | `numeric(6) NULL` | `nr_requisicao` | `integer` | [RENAME] [RETYPE] | Numero da requisicao |
| `seq_item_req` | `numeric(2) NULL` | `nr_seq_item` | `smallint` | [RENAME] [RETYPE] | Sequencia do item |
| `codigo_deposito` | `numeric(3) NULL` | `id_deposito` | `smallint` | [RENAME] [RETYPE] | Deposito |
| `data_requisicao` | `timestamp NULL` | `dth_requisicao` | `timestamp` | [RENAME] | Data da requisicao |
| `nome_requisit` | `text NULL` | `nm_requisitante` | `varchar(100)` | [RENAME] [RETYPE] | Requisitante |
| `observacao_req` | `text NULL` | `obs_requisicao` | `text` | [RENAME] | Observacao |
| `data_prev_entr_req` | `timestamp NULL` | `dth_prev_entrega_req` | `timestamp` | [RENAME] | Prev entrega pela req |
| `situacao_codigo` | `numeric(1) NULL` | `id_situacao` | `smallint` | [RENAME] [RETYPE] | Situacao |
| `cod_cancelamento` | `numeric(2) NULL` | `id_cancelamento` | `smallint` | [RENAME] [RETYPE] | Codigo cancelamento |
| `descr_canc_comp` | `text NULL` | `ds_motivo_cancelamento` | `varchar(100)` | [RENAME] [RETYPE] | Motivo cancelamento |
| `situacao` | `text NULL` | `ds_situacao` | `varchar(50)` | [RENAME] [RETYPE] | Descricao situacao |
| `pedido_compra` | `numeric(6) NULL` | `nr_pedido_compra` | `integer` | [RENAME] [RETYPE] | Pedido de compra |
| `data_prev_entr_ped` | `timestamp NULL` | `dth_prev_entrega_ped` | `timestamp` | [RENAME] | Prev entrega pelo pedido |
| `fk_produto` | `text NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU do produto |
| `fk_fornecedor` | `text NULL` | `cod_fornecedor` | `varchar(18)` | [RENAME] [RETYPE] | Business key fornecedor |
| `unidade_medida` | `text NULL` | `ds_unidade_medida` | `varchar(5)` | [RENAME] [RETYPE] | Unidade |
| `qtde_requisitada` | `numeric(15,3) NULL` | `qt_requisitada` | `numeric(15,3)` | [RENAME] | Qtd requisitada |
| `qtde_pedida_item` | `numeric(15,3) NULL` | `qt_pedida` | `numeric(15,3)` | [RENAME] | Qtd pedida |
| `valor_unitario` | `numeric(20,5) NULL` | `vl_unitario` | `numeric(15,5)` | [RENAME] [RETYPE] | Valor unitario |
| `ultimaentrada` | `timestamp NULL` | `dth_ultima_entrada` | `timestamp` | [RENAME] | Ultima entrada |
| `ultimasaida` | `timestamp NULL` | `dth_ultima_saida` | `timestamp` | [RENAME] | Ultima saida |
| `estoqueatual` | `numeric(38,10) NULL` | `qt_estoque_atual` | `numeric(15,3)` | [RENAME] [RETYPE] | Estoque atual; `numeric(38,10)` inadequado |
| `qtdsugerida` | `numeric(38,10) NULL` | `qt_sugerida` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd sugerida |
| `precoultentrada` | `numeric(38,10) NULL` | `vl_preco_ult_entrada` | `numeric(15,5)` | [RENAME] [RETYPE] | Preco ultima entrada |
| `estoquemin` | `numeric(38,10) NULL` | `qt_estoque_minimo` | `numeric(15,3)` | [RENAME] [RETYPE] | Estoque minimo |
| `estoquemax` | `numeric(38,10) NULL` | `qt_estoque_maximo` | `numeric(15,3)` | [RENAME] [RETYPE] | Estoque maximo |
| `consumomedmes` | `numeric(38,10) NULL` | `qt_consumo_med_mes` | `numeric(15,3)` | [RENAME] [RETYPE] | Consumo medio mensal |
| `consumopordia` | `numeric(38,10) NULL` | `qt_consumo_por_dia` | `numeric(15,3)` | [RENAME] [RETYPE] | Consumo por dia |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE suprimentos.frequisicoes_compra RENAME TO f_requisicao_compra;
ALTER TABLE suprimentos.f_requisicao_compra ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE suprimentos.f_requisicao_compra ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_requisicao_compra ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE suprimentos.f_requisicao_compra RENAME COLUMN num_requisicao TO nr_requisicao;
ALTER TABLE suprimentos.f_requisicao_compra ALTER COLUMN nr_requisicao TYPE integer;
ALTER TABLE suprimentos.f_requisicao_compra RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE suprimentos.f_requisicao_compra ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE suprimentos.f_requisicao_compra RENAME COLUMN fk_fornecedor TO cod_fornecedor;
ALTER TABLE suprimentos.f_requisicao_compra ALTER COLUMN cod_fornecedor TYPE varchar(18);
ALTER TABLE suprimentos.f_requisicao_compra RENAME COLUMN estoqueatual TO qt_estoque_atual;
ALTER TABLE suprimentos.f_requisicao_compra ALTER COLUMN qt_estoque_atual TYPE numeric(15,3) USING qt_estoque_atual::numeric(15,3);
-- (continuar para demais colunas numeric(38,10))
CREATE OR REPLACE VIEW suprimentos.frequisicoes_compra AS SELECT * FROM suprimentos.f_requisicao_compra;
COMMENT ON VIEW suprimentos.frequisicoes_compra IS 'DEPRECATED 2026-05-05: usar f_requisicao_compra. Sera removido em 2026-08-03.';
```

---

## Conflitos e Decisoes Pendentes — Schema `suprimentos`

1. **Colunas com acentos em `dfornecedor_produto`**: `"código produto"` e `"descrição"` precisam ser renomeadas com urgencia — causam problemas em queries sem aspas.
2. **Colunas com espacos em `fprojeto_obc`**: 8 colunas com espaco no nome. Prioridade alta.
3. **`fnota_entrada` vs `fnota_entrada2`**: Sao tabelas duplicadas com estrutura similar. Verificar se ha dados exclusivos em `fnota_entrada2` antes de deprecar. Se redundante, consolidar em `f_nota_entrada`.
4. **Datas como `text` nas tabelas OBC**: `dobc_sdcv_detalhes` e `fdados_bi` tem datas como `text`. O ETL deve normalizar para `date`/`timestamp` antes de inserir.
5. **`fdados_bi` como view ou tabela**: Verificar se `fdados_bi` pode ser substituida por uma view sobre `f_obc_sdcv_detalhe`.
6. **CNPJ em `fauditorio`**: `cnpj_titulo` e `text` — confirmar se o formato ja esta no padrao DW (`XXXXXXXX/YYYY-ZZ`) antes de converter para `varchar(16)`.
