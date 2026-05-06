# Dicionario de Dados — Schema `comercial`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 40 tabelas — pedidos de venda, faturamento, metas, representantes, colecoes, rastreio e integrações CRM/Shopify/LivePro
**Responsavel:** Schema comercial — nucleo de dados de vendas: pedidos, faturamento, metas por representante/estacao/loja, integracoes de CRM e e-commerce

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `comercial.destacao_colecao_subcolecao` | `comercial.d_estacao_colecao` | dimensao |
| `comercial.dlivepro_campaign_lists` | `comercial.d_livepro_campanha_lista` | dimensao |
| `comercial.dlivepro_campanha` | `comercial.d_livepro_campanha` | dimensao |
| `comercial.dlivepro_transactions` | `comercial.f_livepro_transacao` | fato |
| `comercial.dperiodo_venda_previsao` | `comercial.d_periodo_venda_previsao` | dimensao |
| `comercial.dprevisao_venda_capa` | `comercial.f_previsao_venda_capa` | fato |
| `comercial.dprevisao_venda_item` | `comercial.f_previsao_venda_item` | fato |
| `comercial.dprevisoes_vendas_colecao` | `comercial.d_previsao_venda_colecao` | dimensao |
| `comercial.drepresentante` | `comercial.d_representante` | dimensao |
| `comercial.fcontratos_locacao_lecom` | `comercial.f_contrato_locacao` | fato |
| `comercial.festoque_produtos` | `comercial.f_estoque_produto` | fato |
| `comercial.fitens_pedidos` | `comercial.f_item_pedido` | fato |
| `comercial.flivepro_conversao_campanha` | `comercial.f_livepro_conversao` | fato |
| `comercial.flog_itens_transfer` | `comercial.f_log_item_transfer` | fato |
| `comercial.flog_pedidos_itens_cancelados` | `comercial.f_log_item_cancelado` | fato |
| `comercial.flog_pedidos_itens_transferidos` | `comercial.f_log_item_transferido` | fato |
| `comercial.fmeta_categorias_orion` | `comercial.f_meta_categoria` | fato |
| `comercial.fmeta_estacao_orion` | `comercial.f_meta_estacao` | fato |
| `comercial.fmeta_representante` | `comercial.f_meta_representante` | fato |
| `comercial.fmeta_representante_orion` | `comercial.f_meta_representante_orion` | fato |
| `comercial.fmeta_tabpreco_orion` | `comercial.f_meta_tabela_preco` | fato |
| `comercial.fmovimentos_lojas_usa` | `comercial.f_movimento_loja_usa` | fato |
| `comercial.fnotas_canceladas` | `comercial.f_nota_cancelada` | fato |
| `comercial.fnotas_venda_produtos` | `comercial.f_nota_venda_item` | fato |
| `comercial.fpaypal_liberadas` | `comercial.f_paypal_liberada` | fato |
| `comercial.fpaypal_nao_liberadas` | `comercial.f_paypal_pendente` | fato |
| `comercial.fpedido` | `comercial.f_pedido_item` | fato |
| `comercial.fpedido_showroom` | `comercial.f_pedido_showroom_item` | fato |
| `comercial.fpedido_situacao_bloqueio` | `comercial.f_pedido_situacao` | fato |
| `comercial.fpedidos_capa` | `comercial.f_pedido_capa` | fato |
| `comercial.fpedidos_em_aberto` | `comercial.f_pedido_aberto` | fato |
| `comercial.fpedidos_itens_cancelados` | `comercial.f_pedido_item_cancelado` | fato |
| `comercial.fpedidos_refaturados` | `comercial.f_pedido_refaturado` | fato |
| `comercial.frastreio_entrega_loja` | `comercial.f_rastreio_entrega` | fato |
| `comercial.fregiao_representante` | `comercial.f_regiao_representante` | fato |
| `comercial.fsaldos_estoque_mes` | `comercial.f_saldo_estoque_mes` | fato |
| `comercial.fshopify_movimentacoes_ecom_internacional` | `comercial.f_shopify_mov_ecom_intl` | fato |
| `comercial.fshopify_orders` | `comercial.f_shopify_pedido` | fato |
| `comercial.fshopify_orders_itens` | `comercial.f_shopify_pedido_item` | fato |
| `comercial.ftitulos_venda` | `comercial.f_titulo_venda` | fato |

---

## Detalhamento por Tabela

---

### comercial.drepresentante

**Nome proposto:** `comercial.d_representante`
**Tipo:** dimensao
**Descricao:** Dimensao de representantes de venda com CNPJ, dados cadastrais, regiao e historico de atividade.
**Sistema de origem:** Systextil

> Esta e a tabela exemplo do BOAS_PRATICAS_DW.md secao 12. Toda renomeacao foi definida la.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_representante` | `varchar(6) NULL` | `cod_representante` | `varchar(6) NOT NULL` | [RENAME] | **Business key** — join key universal |
| `cnpj_repres` | `int8 NULL` | `cnpj_repres` | `varchar(16)` | [RETYPE] | CNPJ formato DW; `int8` para CNPJ e incorreto |
| `cod_empresa` | `int2 NULL` | `id_empresa` | `smallint` | [RENAME] | Empresa |
| `cod_repres` | `int2 NULL` | `id_cod_repres` | `smallint` | [RENAME] | Codigo interno do representante |
| `nome_repres` | `varchar(50) NULL` | `nm_representante` | `varchar(50)` | [RENAME] | Nome |
| `nome_fantasia` | `varchar(50) NULL` | `nm_fantasia` | `varchar(50)` | OK | Nome fantasia |
| `tipo_repres` | `int2 NULL` | `id_tipo_repres` | `smallint` | [RENAME] | Tipo |
| `endereco` | `varchar(60) NULL` | `end_logradouro` | `varchar(70)` | [RENAME] [RETYPE] | Logradouro |
| `bairro` | `varchar(20) NULL` | `end_bairro` | `varchar(20)` | [RENAME] | Bairro |
| `cidade` | `varchar(40) NULL` | `end_cidade` | `varchar(40)` | [RENAME] | Cidade |
| `regiao` | `varchar(20) NULL` | `ds_regiao` | `varchar(20)` | [RENAME] | Regiao |
| `subregiao` | `varchar(20) NULL` | `ds_subregiao` | `varchar(20)` | [RENAME] | Sub-regiao |
| `cep` | `int4 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP |
| `ddd_celular` | `int2 NULL` | `nr_ddd` | `smallint` | [RENAME] | DDD |
| `num_celular` | `int4 NULL` | `nr_celular` | `varchar(9)` | [RENAME] [RETYPE] | Numero celular |
| `fone_repres` | `int4 NULL` | `nr_telefone` | `varchar(15)` | [RENAME] [RETYPE] | Telefone |
| `inscricao_estadual` | `varchar(14) NULL` | `ds_inscricao_estadual` | `varchar(14)` | [RENAME] | IE |
| `email` | `varchar(60) NULL` | `nm_email` | `varchar(60)` | [RENAME] | Email |
| `situacao` | `int2 NULL` | `fl_ativo` | `boolean` | [RENAME] [RETYPE] | Ativo; converter int para boolean (1=ativo) |
| `conta_banco` | `varchar(15) NULL` | `ds_conta_banco` | `varchar(15)` | [RENAME] | Conta bancaria |
| `cod_agencia` | `varchar(15) NULL` | `ds_agencia` | `varchar(15)` | [RENAME] | Agencia |
| `cod_adm` | `int2 NULL` | `id_adm` | `smallint` | [RENAME] | Administrador |
| `ult_pedido` | `timestamp NULL` | `dth_ultimo_pedido` | `timestamp` | [RENAME] | Data/hora ultimo pedido |
| `dias_ult_pedido` | `float8 NULL` | `nr_dias_ultimo_pedido` | `integer` | [RENAME] [RETYPE] | Dias desde ultimo pedido |
| `dt_primeiro_pedido` | `timestamp NULL` | `dt_primeiro_pedido` | `date` | [RETYPE] | Data primeiro pedido |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `cod_cidade` | `varchar(5) NULL` | `cod_cidade` | `varchar(5)` | OK | Business key cidade |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_representante UNIQUE (cod_representante)
```

#### Migracao SQL

```sql
ALTER TABLE comercial.drepresentante RENAME TO d_representante;
ALTER TABLE comercial.d_representante ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE comercial.d_representante ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE comercial.d_representante RENAME COLUMN pk_representante TO cod_representante;
ALTER TABLE comercial.d_representante ALTER COLUMN cod_representante SET NOT NULL;
ALTER TABLE comercial.d_representante ADD CONSTRAINT uq_d_representante UNIQUE (cod_representante);
ALTER TABLE comercial.d_representante ALTER COLUMN cnpj_repres TYPE varchar(16) USING cnpj_repres::varchar;
ALTER TABLE comercial.d_representante RENAME COLUMN cod_empresa TO id_empresa;
ALTER TABLE comercial.d_representante RENAME COLUMN nome_repres TO nm_representante;
ALTER TABLE comercial.d_representante RENAME COLUMN tipo_repres TO id_tipo_repres;
ALTER TABLE comercial.d_representante RENAME COLUMN regiao TO ds_regiao;
ALTER TABLE comercial.d_representante RENAME COLUMN subregiao TO ds_subregiao;
ALTER TABLE comercial.d_representante RENAME COLUMN situacao TO fl_ativo;
ALTER TABLE comercial.d_representante ALTER COLUMN fl_ativo TYPE boolean USING (situacao = 1);
ALTER TABLE comercial.d_representante RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE comercial.d_representante ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE comercial.d_representante ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW comercial.drepresentante AS SELECT * FROM comercial.d_representante;
COMMENT ON VIEW comercial.drepresentante IS 'DEPRECATED 2026-05-05: usar d_representante. Sera removido em 2026-08-03.';
```

---

### comercial.destacao_colecao_subcolecao

**Nome proposto:** `comercial.d_estacao_colecao`
**Tipo:** dimensao
**Descricao:** Hierarquia estacao > colecao > subcolecao para classificacao de pedidos e metas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cod_estacao` | `numeric(9) NULL` | `id_estacao` | `integer` | [RENAME] [RETYPE] | Codigo da estacao |
| `desc_estacao` | `text NULL` | `ds_estacao` | `varchar(150)` | [RENAME] [RETYPE] | Descricao |
| `colecao` | `numeric(3) NULL` | `id_colecao` | `smallint` | [RENAME] [RETYPE] | Colecao |
| `desccolecao` | `text NULL` | `ds_colecao` | `varchar(50)` | [RENAME] [RETYPE] | Descricao |
| `subcolecao` | `numeric(4) NULL` | `id_subcolecao` | `smallint` | [RENAME] [RETYPE] | Subcolecao |
| `descsubcolecao` | `text NULL` | `ds_subcolecao` | `varchar(50)` | [RENAME] [RETYPE] | Descricao |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### comercial.dlivepro_campaign_lists

**Nome proposto:** `comercial.d_livepro_campanha_lista`
**Tipo:** dimensao
**Descricao:** Listas de contatos das campanhas LivePro CRM, com CPFs de clientes e vendedores, e CNPJ da loja.
**Sistema de origem:** LivePro CRM

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `campaign_list_id` | `int8 NULL` | `id_lista_campanha` | `bigint` | [RENAME] | ID da lista |
| `campaign_id` | `int8 NULL` | `id_campanha` | `bigint` | [RENAME] | ID da campanha |
| `customer_cpf` | `varchar(15) NULL` | `cnpj_cliente` | `varchar(16)` | [RENAME] [RETYPE] | CPF/CNPJ do cliente — nome segue dimensao |
| `customer_name` | `varchar(255) NULL` | `nm_cliente` | `varchar(255)` | [RENAME] | Nome do cliente |
| `campaign_seller_cpf` | `varchar(15) NULL` | `cpf_vendedor` | `varchar(12)` | [RENAME] [RETYPE] | CPF do vendedor; `varchar(12)` padrao CPF |
| `campaign_store_cnpj` | `varchar(18) NULL` | `cnpj_loja` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ da loja formato DW |
| `created_at` | `timestamp NULL` | `dth_criacao` | `timestamp` | [RENAME] | Criacao (da API, nao auditoria DW) |
| `contacted_at` | `timestamp NULL` | `dth_contato` | `timestamp` | [RENAME] | Contato |
| `campaign_name` | `varchar(255) NULL` | `nm_campanha` | `varchar(255)` | [RENAME] | Nome da campanha |
| `campaign_name_ajusted` | `varchar(255) NULL` | `nm_campanha_ajustado` | `varchar(255)` | [RENAME] | Nome ajustado |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria DW |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria DW |

> **Atencao:** A coluna `created_at` da API deve ser renomeada para `dth_criacao` para nao conflitar com a auditoria DW.

---

### comercial.dlivepro_campanha

**Nome proposto:** `comercial.d_livepro_campanha`
**Tipo:** dimensao
**Descricao:** Campanhas do LivePro CRM com configuracoes de recorrencia, impacto e audiencia.
**Sistema de origem:** LivePro CRM

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `campaigns_id` | `int8 NULL` | `id_campanha` | `bigint` | [RENAME] | ID da campanha |
| `campaigns_name` | `text NULL` | `nm_campanha` | `varchar(255)` | [RENAME] [RETYPE] | Nome |
| `status` | `bool NULL` | `fl_ativa` | `boolean` | [RENAME] | Status ativo/inativo |
| `contact_type` | `int4 NULL` | `id_tipo_contato` | `integer` | [RENAME] | Tipo de contato |
| `repick` | `bool NULL` | `fl_repick` | `boolean` | [RENAME] | Flag repick |
| `start_when_activate` | `bool NULL` | `fl_inicia_na_ativacao` | `boolean` | [RENAME] | Inicia ao ativar |
| `start_date` | `timestamp NULL` | `dth_inicio` | `timestamp` | [RENAME] | Inicio |
| `end_date` | `timestamp NULL` | `dth_fim` | `timestamp` | [RENAME] | Fim |
| `next_impact` | `int4 NULL` | `nr_proximo_impacto_dias` | `integer` | [RENAME] | Dias para proximo impacto |
| `created_at` | `timestamp NULL` | `dth_criacao` | `timestamp` | [RENAME] | Criacao na API |
| `audience_id` | `int8 NULL` | `id_audiencia` | `bigint` | [RENAME] | Audiencia |
| `image_path` | `text NULL` | `ds_caminho_imagem` | `text` | [RENAME] | Imagem |
| `client_list_duration` | `int4 NULL` | `nr_duracao_lista_dias` | `integer` | [RENAME] | Duracao da lista |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria DW |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria DW |

---

### comercial.dlivepro_transactions

**Nome proposto:** `comercial.f_livepro_transacao`
**Tipo:** fato
**Descricao:** Transacoes de venda originadas de campanhas LivePro, com CPF do cliente/vendedor e CNPJ da loja.
**Sistema de origem:** LivePro CRM

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `order_id` | `text NULL` | `nr_pedido` | `varchar(50)` | [RENAME] [RETYPE] | ID do pedido |
| `transaction_status_id` | `int8 NULL` | `id_status_transacao` | `integer` | [RENAME] [RETYPE] | Status |
| `customer_cpf` | `text NULL` | `cnpj_cliente` | `varchar(16)` | [RENAME] [RETYPE] | CPF/CNPJ cliente |
| `store_cnpj` | `text NULL` | `cnpj_loja` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ loja |
| `seller_cpf` | `text NULL` | `cpf_vendedor` | `varchar(12)` | [RENAME] [RETYPE] | CPF vendedor |
| `order_date` | `timestamp NULL` | `dth_pedido` | `timestamp` | [RENAME] | Data pedido |
| `coupon_discount` | `text NULL` | `ds_cupom_desconto` | `varchar(50)` | [RENAME] [RETYPE] | Cupom |
| `coupon_seller` | `text NULL` | `ds_cupom_vendedor` | `varchar(50)` | [RENAME] [RETYPE] | Cupom vendedor |
| `price_paid` | `float8 NULL` | `vl_pago` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor pago |
| `amount` | `int8 NULL` | `qt_itens` | `integer` | [RENAME] [RETYPE] | Quantidade de itens |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### comercial.fpedido

**Nome proposto:** `comercial.f_pedido_item`
**Tipo:** fato
**Descricao:** Fato principal de pedidos de venda, com itens, quantidades, valores e status por representante e produto.
**Sistema de origem:** Systextil

> Esta e a tabela fato central do schema comercial. Contem dados a nivel de item de pedido.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `fk_produto` | `varchar(25) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU do produto — join key |
| `ped_cdempresa` | `int2 NULL` | `id_empresa` | `smallint` | [RENAME] | Empresa |
| `ped_cdrep` | `int4 NULL` | `cod_representante` | `varchar(6)` | [RENAME] [RETYPE] | Business key representante — mesmo tipo que `d_representante.cod_representante` |
| `ped_cdpedido` | `int4 NULL` | `nr_pedido` | `integer` | [RENAME] | Numero do pedido |
| `ped_refproduto` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | [RENAME] | Referencia do produto |
| `ped_dataemissao` | `timestamp NULL` | `dt_emissao` | `date` | [RENAME] [RETYPE] | Data emissao; sem hora |
| `ped_dataembarque` | `timestamp NULL` | `dt_embarque` | `date` | [RENAME] [RETYPE] | Data embarque |
| `ped_codcancelamento` | `int2 NULL` | `id_cancelamento` | `smallint` | [RENAME] | Cancelamento |
| `ped_prazomedio` | `int2 NULL` | `nr_prazo_medio_dias` | `smallint` | [RENAME] | Prazo medio |
| `ped_periodo` | `int2 NULL` | `nr_periodo` | `smallint` | [RENAME] | Periodo |
| `ped_tabelapreco` | `int4 NULL` | `id_tabela_preco` | `integer` | [RENAME] | Tabela de preco |
| `ped_condicaopagamento` | `int2 NULL` | `id_condicao_pagto` | `smallint` | [RENAME] | Condicao pagamento |
| `itemped_qtdcancelada` | `float8 NULL` | `qt_cancelada` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd cancelada |
| `itemped_qtdsaldopedido` | `float8 NULL` | `qt_saldo_pedido` | `numeric(15,3)` | [RENAME] [RETYPE] | Saldo do pedido |
| `itemped_qtdepedido` | `numeric(18,3) NULL` | `qt_pedida` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd pedida |
| `itemped_qtdeliqpedido` | `numeric(18,3) NULL` | `qt_liquida_pedido` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd liquida |
| `itemped_percdescontoitem` | `numeric(18,3) NULL` | `pc_desconto_item` | `numeric(7,4)` | [RENAME] [RETYPE] | % desconto item |
| `itemped_valorliqpedido` | `numeric(18,3) NULL` | `vl_liquido_pedido` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor liquido |
| `itemped_valorcomissao` | `numeric(18,3) NULL` | `vl_comissao` | `numeric(15,2)` | [RENAME] [RETYPE] | Comissao |
| `itemped_vlrtotalbruto` | `numeric(18,3) NULL` | `vl_total_bruto` | `numeric(15,2)` | [RENAME] [RETYPE] | Total bruto |
| `itemped_vlrtotalfaturado` | `numeric(18,3) NULL` | `vl_total_faturado` | `numeric(15,2)` | [RENAME] [RETYPE] | Total faturado |
| `itemped_valorunitario` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,5)` | [RENAME] [RETYPE] | Valor unitario |
| `itemped_seqitem` | `int2 NULL` | `nr_seq_item` | `smallint` | [RENAME] | Sequencia do item |
| `itemped_codigodeposito` | `int2 NULL` | `id_deposito` | `smallint` | [RENAME] | Deposito |
| `fk_cliente` | `varchar(20) NULL` | `cod_cliente` | `varchar(20)` | [RENAME] | Business key cliente |
| `fk_representante` | `varchar(6) NULL` | `cod_representante` | `varchar(6)` | [RENAME] | Verificar duplicidade com `ped_cdrep` |
| `ped_cod_situacao_venda` | `varchar(2) NULL` | `id_situacao_venda` | `varchar(2)` | [RENAME] | Situacao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `itemped_qtd_faturada` | `numeric(18,3) NULL` | `qt_faturada` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd faturada |
| `ped_cod_natureza` | `int2 NULL` | `id_natureza_pedido` | `smallint` | [RENAME] | Natureza do pedido |
| `canal` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | [RENAME] | Canal de venda |
| `codigo_barras` | `varchar(16) NULL` | `cod_barras` | `varchar(16)` | [RENAME] | Codigo de barras |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

> **Decisao pendente:** `ped_cdrep` (int4) e `fk_representante` (varchar(6)) parecem referir ao mesmo representante mas com tipos diferentes. Consolidar em `cod_representante varchar(6)`. Ver CONFLITOS_E_DECISOES_PENDENTES.md.

#### Relacionamentos propostos

```
comercial.f_pedido_item
  |- sku_produto         -> live.d_produto.sku_produto
  |- cod_cliente         -> live.d_cliente.cod_cliente
  |- cod_representante   -> comercial.d_representante.cod_representante
  |- id_deposito         -> jma.ddeposito.codigo_deposito (apos renomear)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_pedido_item_produto ON comercial.f_pedido_item (sku_produto);
CREATE INDEX idx_f_pedido_item_cliente ON comercial.f_pedido_item (cod_cliente);
CREATE INDEX idx_f_pedido_item_representante ON comercial.f_pedido_item (cod_representante);
CREATE INDEX idx_f_pedido_item_emissao ON comercial.f_pedido_item (dt_emissao);
CREATE INDEX idx_f_pedido_item_pedido ON comercial.f_pedido_item (nr_pedido);
```

#### Migracao SQL (principais)

```sql
ALTER TABLE comercial.fpedido RENAME TO f_pedido_item;
ALTER TABLE comercial.f_pedido_item ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE comercial.f_pedido_item ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE comercial.f_pedido_item RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE comercial.f_pedido_item ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE comercial.f_pedido_item RENAME COLUMN fk_cliente TO cod_cliente;
ALTER TABLE comercial.f_pedido_item RENAME COLUMN ped_cdpedido TO nr_pedido;
ALTER TABLE comercial.f_pedido_item RENAME COLUMN ped_dataemissao TO dt_emissao_ts;
ALTER TABLE comercial.f_pedido_item ADD COLUMN dt_emissao date;
UPDATE comercial.f_pedido_item SET dt_emissao = dt_emissao_ts::date;
ALTER TABLE comercial.f_pedido_item DROP COLUMN dt_emissao_ts;
ALTER TABLE comercial.f_pedido_item RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE comercial.f_pedido_item ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE comercial.f_pedido_item ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW comercial.fpedido AS SELECT * FROM comercial.f_pedido_item;
COMMENT ON VIEW comercial.fpedido IS 'DEPRECATED 2026-05-05: usar f_pedido_item. Sera removido em 2026-08-03.';
```

---

### comercial.fnotas_venda_produtos

**Nome proposto:** `comercial.f_nota_venda_item`
**Tipo:** fato
**Descricao:** Fato de notas fiscais de venda com itens, quantidades e valores (faturamento por produto).
**Sistema de origem:** Systextil

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `nf_serienotafiscal` | `varchar(3) NULL` | `nr_serie_nf` | `varchar(3)` | [RENAME] | Serie NF |
| `nf_notafiscal` | `int4 NULL` | `nr_nota_fiscal` | `integer` | [RENAME] | Numero NF |
| `nf_nrpedidovenda` | `int4 NULL` | `nr_pedido` | `integer` | [RENAME] | Pedido de venda |
| `nf_cdempresa` | `int8 NULL` | `id_empresa` | `smallint` | [RENAME] [RETYPE] | Empresa |
| `pk_cliente` | `varchar(25) NULL` | `cod_cliente` | `varchar(20)` | [RENAME] [RETYPE] | Business key cliente |
| `nf_dataemissao` | `timestamp NULL` | `dt_emissao` | `date` | [RENAME] [RETYPE] | Data emissao |
| `data_embarque` | `timestamp NULL` | `dt_embarque` | `date` | [RENAME] [RETYPE] | Data embarque |
| `nf_cod_situacao` | `int8 NULL` | `id_situacao_nf` | `smallint` | [RENAME] [RETYPE] | Situacao da NF |
| `nf_desc_situacao` | `varchar(10) NULL` | `ds_situacao_nf` | `varchar(10)` | [RENAME] | Descricao |
| `canal` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | [RENAME] | Canal |
| `modalidade` | `varchar(50) NULL` | `ds_modalidade` | `varchar(50)` | [RENAME] | Modalidade |
| `nf_cod_natureza` | `int2 NULL` | `id_natureza` | `smallint` | [RENAME] | Natureza |
| `uf` | `varchar(2) NULL` | `ds_uf_destino` | `char(2)` | [RENAME] [RETYPE] | UF destino |
| `pk_produto` | `varchar(18) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU produto |
| `nf_nrseqitempedido` | `int8 NULL` | `nr_seq_item` | `smallint` | [RENAME] [RETYPE] | Sequencia item |
| `itemnf_qtdfaturada` | `numeric(18,3) NULL` | `qt_faturada` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd faturada |
| `itemnf_vlrunit` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,5)` | [RENAME] [RETYPE] | Valor unitario |
| `itemnf_vlr_contabil` | `numeric(18,3) NULL` | `vl_contabil` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor contabil |
| `itemnf_vlr_tot` | `numeric(18,3) NULL` | `vl_total` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor total |
| `itemnf_vlr_franchising` | `numeric(18,3) NULL` | `vl_franchising` | `numeric(15,2)` | [RENAME] [RETYPE] | Franchising |
| `cod_representante` | `int4 NULL` | `cod_representante` | `varchar(6)` | [RETYPE] | Business key — converter para varchar(6) |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Indices recomendados

```sql
CREATE INDEX idx_f_nota_venda_item_nf ON comercial.f_nota_venda_item (nr_nota_fiscal);
CREATE INDEX idx_f_nota_venda_item_cliente ON comercial.f_nota_venda_item (cod_cliente);
CREATE INDEX idx_f_nota_venda_item_produto ON comercial.f_nota_venda_item (sku_produto);
CREATE INDEX idx_f_nota_venda_item_emissao ON comercial.f_nota_venda_item (dt_emissao);
```

---

### comercial.fpedidos_capa

**Nome proposto:** `comercial.f_pedido_capa`
**Tipo:** fato
**Descricao:** Capa de pedidos (nivel de cabecalho) com valores totais, condicao de pagamento, representante e status.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| `pedido_venda` | `nr_pedido_venda` | `integer` | Numero do pedido |
| `codigo_empresa` | `id_empresa` | `smallint` | Empresa |
| `data_emissao` | `dt_emissao` | `date` | Emissao |
| `data_embarque` | `dt_embarque` | `date` | Embarque |
| `cd_representante` | `cod_representante` | `varchar(6)` | Business key representante |
| `descr_nat_oper` | `ds_natureza_operacao` | `varchar(40)` | Natureza |
| `tipo_carteira` | `ds_tipo_carteira` | `varchar(32)` | Tipo carteira |
| `estado_atual` | `ds_estado_atual` | `varchar(10)` | Estado atual |
| `cod_cancelamento` | `id_cancelamento` | `smallint` | Cancelamento |
| `motivo` | `ds_motivo_cancelamento` | `varchar(60)` | Motivo |
| `canal` | `ds_canal` | `varchar(100)` | Canal |
| `desc_cond_pgto` | `ds_condicao_pagto` | `varchar(30)` | Cond pagto |
| `situacao_venda` | `id_situacao_venda` | `smallint` | Situacao |
| `desc_situacao_venda` | `ds_situacao_venda` | `varchar(37)` | Descricao |
| `tipo_comissao` | `id_tipo_comissao` | `smallint` | Tipo comissao |
| `percent_comissao` | `pc_comissao` | `numeric(7,4)` | % comissao |
| `qtde_saldo_pedi` | `qt_saldo` | `numeric(15,3)` | Saldo qtd |
| `qtde_total_pedi` | `qt_total` | `numeric(15,3)` | Total qtd |
| `valor_saldo_pedi` | `vl_saldo` | `numeric(15,2)` | Saldo valor |
| `valor_liquido` | `vl_liquido` | `numeric(15,2)` | Valor liquido |
| `valor_bruto` | `vl_bruto` | `numeric(15,2)` | Valor bruto |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| `cnpj_cliente` | `cnpj_cliente` | `varchar(16)` (retype) | CNPJ formato DW |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### comercial.fitens_pedidos

**Nome proposto:** `comercial.f_item_pedido`
**Tipo:** fato
**Descricao:** Itens de pedidos (nivel de item) com quantidades e valores simplificados.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| `pedido_venda` | `nr_pedido_venda` | `integer` | Pedido |
| `seq_item` | `nr_seq_item` | `smallint` | Sequencia |
| `fk_produto` | `sku_produto` | `varchar(30)` | SKU |
| `cod_nat_op` | `id_natureza_op` | `smallint` | Natureza |
| `descr_nat_oper` | `ds_natureza_operacao` | `varchar(40)` | Descricao |
| `qtd_sugerida` | `qt_sugerida` | `numeric(15,3)` | Qtd sugerida |
| `qtd_afaturar` | `qt_a_faturar` | `numeric(15,3)` | A faturar |
| `qtd_faturada` | `qt_faturada` | `numeric(15,3)` | Faturada |
| `valor_unitario` | `vl_unitario` | `numeric(15,5)` | Valor unitario |
| `percentual_desc` | `pc_desconto` | `numeric(7,4)` | % desconto |
| `situacao_fatu_it` | `id_situacao_faturamento` | `smallint` | Situacao |
| `cod_cancelamento` | `id_cancelamento` | `smallint` | Cancelamento |
| `tabela_preco` | `ds_tabela_preco` | `varchar(35)` | Tabela preco |
| `qtd_cancelada` | `qt_cancelada` | `numeric(15,3)` | Cancelada |
| `valor_cancelado` | `vl_cancelado` | `numeric(15,2)` | Valor cancelado |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### comercial.fmeta_representante

**Nome proposto:** `comercial.f_meta_representante`
**Tipo:** fato
**Descricao:** Metas de representante por estacao e canal, com valor meta e tabela de preco.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| `cod_estacao` | `id_estacao` | `integer` | Estacao |
| `descricao` | `ds_estacao` | `varchar(150)` | Descricao |
| `tabela_preco` | `ds_tabela_preco` | `varchar(35)` | Tabela preco |
| `cod_representante` | `cod_representante` | `varchar(6)` (retype int4 -> varchar) | Business key rep |
| `descricao_rep` | `nm_representante` | `varchar(100)` | Nome |
| `cod_canal` | `id_canal` | `integer` | Canal |
| `canal` | `ds_canal` | `varchar(50)` | Descricao |
| `tipo_meta` | `id_tipo_meta` | `smallint` | Tipo |
| `meta` | `vl_meta` | `numeric(15,2)` | Valor meta |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### comercial.fsaldos_estoque_mes

**Nome proposto:** `comercial.f_saldo_estoque_mes`
**Tipo:** fato
**Descricao:** Saldos mensais de estoque por deposito e produto, com valores financeiros e estimados.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| `codigo_deposito` | `id_deposito` | `smallint` | Deposito |
| `desc_deposito` | `ds_deposito` | `varchar(30)` | Descricao |
| `pk_produto` | `sku_produto` | `varchar(30)` | SKU |
| `nivel_produto` | `cod_nivel_produto` | `varchar(1)` | Nivel |
| `referencia` | `cod_referencia` | `varchar(5)` | Referencia |
| `tamanho` | `cod_tamanho` | `varchar(3)` | Tamanho |
| `cor` | `cod_cor` | `varchar(6)` | Cor |
| `mes_ano_movimento` | `dt_mes_ano` | `date` | Mes/ano |
| `ano_movimento` | `nr_ano` | `smallint` | Ano |
| `mes_movimento` | `nr_mes` | `smallint` | Mes |
| `saldo_fisico` | `qt_saldo_fisico` | `numeric(15,3)` | Qtd fisica |
| `saldo_financeiro` | `vl_saldo_financeiro` | `numeric(15,2)` | Valor financeiro |
| `saldo_financeiro_estimado` | `vl_saldo_estimado` | `numeric(15,2)` | Estimado |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### comercial.fnotas_canceladas

**Nome proposto:** `comercial.f_nota_cancelada`
**Tipo:** fato
**Descricao:** Notas fiscais canceladas com motivo, forma e condicao de pagamento.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `serie_nota_fisc` | `nr_serie_nf` | `varchar(3)` |
| `num_nota_fiscal` | `nr_nota_fiscal` | `integer` |
| `num_pedido` | `nr_pedido` | `integer` |
| `data_emissao` | `dt_emissao` | `date` |
| `cod_canc_nfisc` | `id_motivo_cancelamento` | `smallint` |
| `motivo_cancel` | `ds_motivo_cancelamento` | `varchar(30)` |
| `situacao_duplic` | `id_situacao_duplicata` | `smallint` |
| `natur_operacao` | `id_natureza_operacao` | `smallint` |
| `descr_nat_oper` | `ds_natureza_operacao` | `varchar(40)` |
| `pk_cliente` | `cod_cliente` | `varchar(20)` |
| `qtde_itens` | `qt_itens` | `integer` |
| `valor_desconto` | `vl_desconto` | `numeric(15,2)` |
| `valor_itens_nfis` | `vl_total_itens` | `numeric(15,2)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.ftitulos_venda

**Nome proposto:** `comercial.f_titulo_venda`
**Tipo:** fato
**Descricao:** Titulos (duplicatas) gerados nas vendas, com situacao, valores e historico de pagamento.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pedido_venda` | `nr_pedido_venda` | `integer` |
| `serie_nota_fisc` | `nr_serie_nf` | `varchar(3)` |
| `nf_notafiscal` | `nr_nota_fiscal` | `integer` |
| `sequencia` | `nr_sequencia` | `smallint` |
| `cod_forma_pagto` | `id_forma_pagto` | `smallint` |
| `desc_forma_pgto` | `ds_forma_pagto` | `varchar(30)` |
| `situacao_duplic` | `id_situacao_duplicata` | `smallint` |
| `desc_situacao` | `ds_situacao` | `varchar(12)` |
| `valor_duplicata` | `vl_duplicata` | `numeric(15,2)` |
| `saldo_duplicata` | `vl_saldo_duplicata` | `numeric(15,2)` |
| `valor_pago` | `vl_pago` | `numeric(15,2)` |
| `historico_pgto` | `id_historico_pagto` | `smallint` |
| `historico_contab` | `ds_historico_contabil` | `varchar(30)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.fpedido_showroom

**Nome proposto:** `comercial.f_pedido_showroom_item`
**Tipo:** fato
**Descricao:** Pedidos de venda do showroom — estrutura identica a `f_pedido_item` com campo adicional `showroom_id`.

> Avaliar consolidacao com `f_pedido_item` usando flag `fl_showroom` ou `id_showroom`. Ver CONFLITOS_E_DECISOES_PENDENTES.md.

Segue as mesmas regras de `f_pedido_item`. Coluna adicional:
- `showroom_id int4 NULL` → `id_showroom integer`

---

### comercial.fpedido_situacao_bloqueio

**Nome proposto:** `comercial.f_pedido_situacao`
**Tipo:** fato
**Descricao:** Historico de situacoes de bloqueio/liberacao de pedidos.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pedido_venda` | `nr_pedido_venda` | `integer` |
| `seq_situacao` | `nr_seq_situacao` | `smallint` |
| `codigo_situacao` | `id_situacao` | `smallint` |
| `data_situacao` | `dth_situacao` | `timestamp` |
| `flag_liberacao` | `ds_flag_liberacao` | `text` |
| `desc_liberacao` | `ds_motivo_liberacao` | `text` |
| `data_liberacao` | `dth_liberacao` | `timestamp` |
| `responsavel` | `nm_responsavel` | `text` |
| `observacao` | `obs_situacao` | `text` |
| `usuario_bloqueio` | `nm_usuario_bloqueio` | `text` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.fpedidos_em_aberto

**Nome proposto:** `comercial.f_pedido_aberto`
**Tipo:** fato
**Descricao:** Pedidos em aberto (saldo nao faturado) por SKU, situacao e canal.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `sku` | `sku_produto` | `varchar(30)` |
| `codigo_empresa` | `id_empresa` | `smallint` |
| `data_emissao` | `dt_emissao` | `date` |
| `data_embarque` | `dt_embarque` | `date` |
| `descr_nat_oper` | `ds_natureza_operacao` | `varchar(60)` |
| `cod_cancelamento` | `id_cancelamento` | `varchar(3)` |
| `motivo` | `ds_motivo_cancelamento` | `varchar(60)` |
| `situacao_venda` | `id_situacao_venda` | `varchar(2)` |
| `desc_situacao_venda` | `ds_situacao_venda` | `varchar(40)` |
| `quantidade_pedido` | `qt_pedida` | `bigint` |
| `qtdcancelada` | `qt_cancelada` | `bigint` |
| `qtdsaldopedido` | `qt_saldo` | `bigint` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| `pedido_venda` | `nr_pedido_venda` | `varchar(20)` |
| `canal` | `ds_canal` | `varchar(35)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.flog_itens_transfer / flog_pedidos_itens_cancelados / flog_pedidos_itens_transferidos

**Nomes propostos:** `f_log_item_transfer`, `f_log_item_cancelado`, `f_log_item_transferido`
**Tipo:** fato (log)
**Descricao:** Logs de transferencia, cancelamento e transferencia de itens de pedido.

Padrao de renomeacao para todas:
- `numero_pedido / cd_pedido / ped_cdpedido` → `nr_pedido` (integer)
- `seq_item_pedido` → `nr_seq_item`
- `cd_item_trans` → `ds_item_transferencia`
- `qtd_transferida / qtdcancelada` → `qt_transferida / qt_cancelada` (numeric(15,3))
- Todas as colunas `data_*` → `dth_*` ou `dt_*`
- Adicionar `id bigserial PK`, `created_at`, `updated_at`

---

### comercial.fcontratos_locacao_lecom

**Nome proposto:** `comercial.f_contrato_locacao`
**Tipo:** fato
**Descricao:** Contratos de locacao do sistema Lecom (contratos de lojas/espacos), com CNPJ, endereco, vigencia e valores.
**Sistema de origem:** Lecom (workflow de contratos)

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cod_processo_f` | `id_processo` | `integer` |
| `nome_contrato` | `ds_contrato` | `varchar(50)` |
| `tipo_contrato` | `ds_tipo_contrato` | `varchar(50)` |
| `cnpj` | `cnpj_locatario` | `varchar(16)` |
| `cnpj_live` | `cnpj_live` | `varchar(16)` |
| `grupo_live` | `ds_grupo_live` | `varchar(200)` |
| `nome_completo` | `nm_responsavel` | `varchar(80)` |
| `cpf` | `cpf_responsavel` | `varchar(12)` |
| `endereco` | `end_logradouro` | `varchar(50)` |
| `cep` | `end_cep` | `varchar(12)` |
| `cidade` | `end_cidade` | `varchar(50)` |
| `estado` | `end_uf` | `varchar(2)` |
| `pais` | `end_pais` | `varchar(30)` |
| `data_inicio_vigencia` | `dt_inicio_vigencia` | `date` |
| `data_fim_vigencia` | `dt_fim_vigencia` | `date` |
| `valor_contratado` | `vl_contratado` | `numeric(15,2)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.festoque_produtos

**Nome proposto:** `comercial.f_estoque_produto`
**Tipo:** fato
**Descricao:** Snapshot de estoque de produtos com quantidades sugeridas, empenhadas, atuais e disponiveis.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_produto` | `sku_produto` | `varchar(30)` |
| `cod_erp` | `cod_erp` | `varchar(111)` |
| `conta_estoque` | `id_conta_estoque` | `smallint` |
| `unidade_medida` | `ds_unidade_medida` | `varchar(2)` |
| `qtd_sugerida` | `qt_sugerida` | `numeric(15,3)` |
| `qtd_empenhada` | `qt_empenhada` | `numeric(15,3)` |
| `qtd_est_atual` | `qt_estoque_atual` | `numeric(15,3)` |
| `qtd_disponivel` | `qt_disponivel` | `numeric(15,3)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.flivepro_conversao_campanha

**Nome proposto:** `comercial.f_livepro_conversao`
**Tipo:** fato
**Descricao:** Conversoes de campanha LivePro: pedidos gerados a partir de contatos de campanha.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `order_id` | `nr_pedido` | `varchar(50)` |
| `order_date` | `dth_pedido` | `timestamp` |
| `contacted_at` | `dth_contato` | `timestamp` |
| `campaign_list_id` | `id_lista_campanha` | `bigint` |
| `campaign_id` | `id_campanha` | `bigint` |
| `tempo_conversao` | `ds_tempo_conversao` | `text` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.fmeta_categorias_orion / fmeta_estacao_orion / fmeta_representante_orion / fmeta_tabpreco_orion

**Nomes propostos:** `f_meta_categoria`, `f_meta_estacao`, `f_meta_representante_orion`, `f_meta_tabela_preco`
**Tipo:** fato
**Descricao:** Metas do sistema Orion por categoria, estacao, representante e tabela de preco.
**Sistema de origem:** Orion (sistema de gestao de metas)

Padrao para todas:
- `cod_estacao numeric(9)` → `id_estacao integer`
- `catalogo numeric(4)` → `id_catalogo smallint`
- `cod_canal numeric(6)` → `id_canal integer`
- `cod_representante numeric(6)` → `cod_representante varchar(6)` (tipo padrao)
- `tipo_meta numeric` → `id_tipo_meta smallint`
- `meta numeric(9,2)` → `vl_meta numeric(15,2)`
- Colunas `valor_categoria_N` → `vl_categoria_N numeric(15,2)`
- Adicionar `id bigserial PK`, `created_at`, `updated_at`

---

### comercial.fmovimentos_lojas_usa

**Nome proposto:** `comercial.f_movimento_loja_usa`
**Tipo:** fato
**Descricao:** Movimentacoes de lojas internacionais (EUA), com dados de pedido, itens e valores em moeda local.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `id` | `id_pedido_api` | `varchar(100)` |
| `name` | `nm_pedido` | `varchar(50)` |
| `createdat` | `dth_criacao` | `timestamp` |
| `processedat` | `dth_processamento` | `timestamp` |
| `store` | `cod_loja` | `varchar(50)` |
| `sku` | `sku_produto` | `varchar(100)` |
| `product` | `ds_produto` | `varchar(200)` |
| `quantity` | `qt_vendida` | `integer` |
| `subtotalamount` | `vl_subtotal` | `numeric(15,2)` |
| `totaldiscountsamount` | `vl_descontos` | `numeric(15,2)` |
| `valorfaturamento` | `vl_faturamento` | `numeric(15,2)` |
| `originalunitpriceamount` | `vl_preco_unit_original` | `numeric(15,2)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.fpaypal_liberadas / fpaypal_nao_liberadas

**Nomes propostos:** `f_paypal_liberada`, `f_paypal_pendente`
**Tipo:** fato
**Descricao:** Notas fiscais com pagamento via PayPal: liberadas e pendentes de liberacao.

Padrao de renomeacao:
- `nota_fiscal numeric(9)` → `nr_nota_fiscal integer`
- `serie_nota text` → `nr_serie_nf varchar(3)`
- `status numeric(1)` → `id_status smallint`
- `cgc_9, cgc_4, cgc_2` → manter para referencia, alem de calcular `cnpj_cliente varchar(16)`
- `valor_nota numeric(38,10)` → `vl_nota numeric(15,2)` 
- Adicionar `id bigserial PK`, `created_at`, `updated_at`

---

### comercial.fpedidos_itens_cancelados / fpedidos_refaturados

**Nomes propostos:** `f_pedido_item_cancelado`, `f_pedido_refaturado`
**Tipo:** fato (log)
**Descricao:** Logs de cancelamento de itens de pedido e refaturamentos.

Padrao de renomeacao:
- `numero_pedido numeric(9)` → `nr_pedido integer`
- `sku text` → `sku_produto varchar(30)`
- `qtde_pedida_old/new numeric(16,3)` → `qt_pedida_ant/nova numeric(15,3)`
- `data_ocorr` → `dth_ocorrencia`
- Adicionar `id bigserial PK`, `created_at`, `updated_at`

---

### comercial.frastreio_entrega_loja

**Nome proposto:** `comercial.f_rastreio_entrega`
**Tipo:** fato
**Descricao:** Rastreio de entregas por nota fiscal e minuta, com rastreador TMS e data de envio.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pedido_venda` | `nr_pedido_venda` | `integer` |
| `serie_nota_fiscal` | `nr_serie_nf` | `varchar(3)` |
| `numero_nota_fiscal` | `nr_nota_fiscal` | `integer` |
| `numero_minuta` | `nr_minuta` | `integer` |
| `rastreador_tms` | `ds_rastreador_tms` | `varchar(100)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| `data_envio` | `dth_envio` | `timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.fregiao_representante

**Nome proposto:** `comercial.f_regiao_representante`
**Tipo:** fato (bridge)
**Descricao:** Associacao entre representante, cidades de atuacao e administradores.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cod_representante` | `cod_representante` | `varchar(6)` (retype de int4) |
| `cod_cidade` | `cod_cidade` | `varchar(5)` (retype de int4) |
| `cod_adm` | `id_adm` | `integer` |
| `nome_adm` | `nm_adm` | `varchar(40)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### comercial.fshopify_orders / fshopify_orders_itens / fshopify_movimentacoes_ecom_internacional

**Nomes propostos:** `f_shopify_pedido`, `f_shopify_pedido_item`, `f_shopify_mov_ecom_intl`
**Tipo:** fato
**Descricao:** Pedidos e itens do Shopify (e-commerce) e movimentacoes de e-commerce internacional.
**Sistema de origem:** Shopify

Padrao de renomeacao:
- `id int8` → `id_pedido_shopify bigint` (guardar ID original, adicionar `id bigserial PK`)
- `order_number` → `nr_pedido`
- `order_date` → `dth_pedido`
- `customer_id` → `id_cliente_shopify`
- `total_discounts` → `vl_descontos`
- `total_price` → `vl_total`
- `sku varchar(50)` → `sku_produto varchar(30)`
- `quantity int4` → `qt_vendida integer`
- `price` → `vl_unitario`
- Adicionar `created_at`, `updated_at`

---

### comercial.dperiodo_venda_previsao / dprevisao_venda_capa / dprevisao_venda_item / dprevisoes_vendas_colecao

**Nomes propostos:** `d_periodo_venda_previsao`, `f_previsao_venda_capa`, `f_previsao_venda_item`, `d_previsao_venda_colecao`
**Tipo:** dimensao / fato
**Descricao:** Tabelas de planejamento de venda por colecao, item e periodo.

Padrao de renomeacao:
- `ultima_atualizacao` → `updated_at`
- Colunas `id / id_previsao_vendas` → manter como `id_previsao` ou promover a `id bigserial PK`
- Colunas de valor `valor_sell_in / valor_sell_out` → `vl_sell_in / vl_sell_out numeric(15,2)`
- Colunas de qtd `qtde_previsao / qtde_vendida_base` → `qt_previsao / qt_vendida_base numeric(15,3)`
- `percentual_aplicar numeric(6,2)` → `pc_aplicar numeric(7,4)`
- Adicionar `created_at`, `updated_at`

---

## Conflitos e Decisoes Pendentes — Schema `comercial`

1. **`fpedido.ped_cdrep` (int4) vs `fpedido.fk_representante` (varchar(6))**: Duas colunas aparentemente para o mesmo representante com tipos diferentes. Consolidar em `cod_representante varchar(6)`.
2. **`fpedido` vs `fpedido_showroom`**: Estrutura identica com adicao de `showroom_id`. Avaliar consolidar em `f_pedido_item` com coluna `id_showroom nullable`.
3. **`fmeta_representante_orion` vs `fmeta_representante`**: Ambas tem metas de representante. Verificar se sao da mesma fonte ou de fontes diferentes (Systextil vs Orion).
4. **`fpaypal_liberadas.cgc_9, cgc_4, cgc_2`**: CNPJ fragmentado — deve ser reconstruido usando `dw.fn_formatar_cnpj_cpf` antes de inserir na coluna `cnpj_cliente`.
5. **`fnotas_venda_produtos.cod_representante` como int4**: Business key de representante deve ser `varchar(6)` em toda a tabela fato. Converter via `LPAD(cod_representante::text, 6, '0')` ou padrao existente.
6. **Tabelas de log** (`flog_*`, `fpedidos_itens_cancelados`): Verificar se sao logs de auditoria (imutaveis) ou tabelas operacionais. Se logs, nao devem ter `updated_at`.
