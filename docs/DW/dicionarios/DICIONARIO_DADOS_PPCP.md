# Dicionario de Dados — Schema `ppcp`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 52 tabelas — PPCP (Planejamento, Programacao e Controle da Producao): ordens de producao, corte, tecelagem, beneficiamento, controle de qualidade e fornecedores
**Responsavel:** Schema ppcp — dados de producao: ordens de producao e confeccao, estagios de producao, pontos de controle de qualidade, capacidade e maquinas

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `ppcp.dcad_centro_custo` | `ppcp.d_centro_custo` | dimensao |
| `ppcp.dcadastro_fornecedores` | `ppcp.d_fornecedor_producao` | dimensao |
| `ppcp.dcapacidade_fabrica` | `ppcp.d_capacidade_fabrica` | dimensao |
| `ppcp.ddivisao_producao` | `ppcp.d_divisao_producao` | dimensao |
| `ppcp.destagio` | `ppcp.d_estagio` | dimensao |
| `ppcp.dhomologacao_fornecedores` | `ppcp.d_homologacao_fornecedor` | dimensao |
| `ppcp.dinfotec_fornecedores` | `ppcp.d_infotec_fornecedor` | dimensao |
| `ppcp.dmaquina` | `ppcp.d_maquina` | dimensao |
| `ppcp.dmotivos_reposicao` | `ppcp.d_motivo_reposicao` | dimensao |
| `ppcp.dobs_estagio` | `ppcp.f_obs_estagio` | fato |
| `ppcp.doperacao` | `ppcp.d_operacao` | dimensao |
| `ppcp.dpolivalencia_maquinas` | `ppcp.d_polivalencia_maquina` | dimensao |
| `ppcp.dprevisao_vendas` | `ppcp.f_previsao_venda` | fato |
| `ppcp.dtecidos` | `ppcp.d_tecido` | dimensao |
| `ppcp.fapontamento_producao` | `ppcp.f_apontamento_producao` | fato |
| `ppcp.faprovacao_rolos_930` | `ppcp.f_aprovacao_rolo` | fato |
| `ppcp.faprovacoes_requisicao` | `ppcp.f_aprovacao_requisicao` | fato |
| `ppcp.fbeneficiamento_acomp_prod` | `ppcp.f_beneficiamento_acompanhamento` | fato |
| `ppcp.fconsumo_componente` | `ppcp.f_consumo_componente` | fato |
| `ppcp.fdefeitos_producao` | `ppcp.f_defeito_producao` | fato |
| `ppcp.festagios_beneficiamento` | `ppcp.f_estagio_beneficiamento` | fato |
| `ppcp.finspecao_qualidade` | `ppcp.f_inspecao_qualidade` | fato |
| `ppcp.fitens_requisicao_almoxerifado` | `ppcp.f_item_requisicao_almox` | fato |
| `ppcp.flista_prioridades` | `ppcp.f_lista_prioridade` | fato |
| `ppcp.fmaquinas_divisao_externa` | `ppcp.f_maquina_divisao_externa` | fato |
| `ppcp.fmaquinas_divisao_interna` | `ppcp.f_maquina_divisao_interna` | fato |
| `ppcp.fmedidas_insumos` | `ppcp.f_medida_insumo` | fato |
| `ppcp.fmovimentacao_enderecos` | `ppcp.f_movimentacao_endereco` | fato |
| `ppcp.foperadores_divisao` | `ppcp.f_operador_divisao` | fato |
| `ppcp.fordem_producao_leadtime` | `ppcp.f_ordem_producao_leadtime` | fato |
| `ppcp.fordens_aproduzir_pacote` | `ppcp.f_ordem_a_produzir_pacote` | fato |
| `ppcp.fordens_beneficiamento` | `ppcp.f_ordem_beneficiamento` | fato |
| `ppcp.fordens_corte` | `ppcp.f_ordem_corte` | fato |
| `ppcp.fordens_em_producao` | `ppcp.f_ordem_em_producao` | fato |
| `ppcp.fordens_produzidas` | `ppcp.f_ordem_produzida` | fato |
| `ppcp.fordens_produzidas_alt_item` | `ppcp.f_ordem_produzida_alt_item` | fato |
| `ppcp.fordens_reposicoes` | `ppcp.f_ordem_reposicao` | fato |
| `ppcp.fordens_servico` | `ppcp.f_ordem_servico` | fato |
| `ppcp.fordens_tecelagem` | `ppcp.f_ordem_tecelagem` | fato |
| `ppcp.fpontualidade_beneficiamento` | `ppcp.f_pontualidade_beneficiamento` | fato |
| `ppcp.fpontualidade_confeccao` | `ppcp.f_pontualidade_confeccao` | fato |
| `ppcp.fproducao_seda` | `ppcp.f_producao_seda` | fato |
| `ppcp.fprodutividade_operador_marft` | `ppcp.f_produtividade_operador` | fato |
| `ppcp.fprodutos_bloqueados_venda` | `ppcp.f_produto_bloqueado_venda` | fato |
| `ppcp.fqtd_produzida` | `ppcp.f_qtd_produzida` | fato |
| `ppcp.frejeicao_pecas_tecido` | `ppcp.f_rejeicao_peca_tecido` | fato |
| `ppcp.frolos_reservados` | `ppcp.f_rolo_reservado` | fato |
| `ppcp.froteiro` | `ppcp.f_roteiro` | fato |
| `ppcp.fstatus_requisicao_reposicoes` | `ppcp.f_status_requisicao_reposicao` | fato |
| `ppcp.fsugestao_cancelamento` | `ppcp.f_sugestao_cancelamento` | fato |
| `ppcp.fsugestao_reserva_tecido` | `ppcp.f_sugestao_reserva_tecido` | fato |
| `ppcp.ftempo_tear` | `ppcp.f_tempo_tear` | fato |

---

## Detalhamento por Tabela

---

### ppcp.dtecidos

**Nome proposto:** `ppcp.d_tecido`
**Tipo:** dimensao
**Descricao:** Dimensao de tecidos/insumos texteis com referencia, cor, composicao e tipo. `sku_tecido` e o business key canonico analogamente a `sku_produto`.
**Sistema de origem:** Systextil

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `ref_tecido` | `varchar(5) NULL` | `cod_referencia_tecido` | `varchar(5)` | [RENAME] | Referencia do tecido |
| `descricao_tecido` | `varchar(30) NULL` | `ds_tecido` | `varchar(30)` | [RENAME] | Descricao |
| `referencia` | `varchar(5) NULL` | `cod_referencia_produto` | `varchar(5)` | [RENAME] | Referencia do produto associado |
| `cod_cor` | `varchar(6) NULL` | `cod_cor` | `varchar(6)` | OK | Cor |
| `cod_tecido` | `varchar(50) NULL` | `sku_tecido` | `varchar(30) NOT NULL` | [RENAME] [RETYPE] | **Business key canonico** do tecido — join key universal; padrao `nivel.ref.tam.cor` |
| `unidade_medida` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(2)` | [RENAME] | Unidade |
| `composicao` | `varchar(300) NULL` | `ds_composicao` | `varchar(300)` | [RENAME] | Composicao de fibras |
| `tipo_produto` | `varchar(9) NULL` | `ds_tipo_produto` | `varchar(10)` | [RENAME] [RETYPE] | Tipo |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_tecido UNIQUE (sku_tecido)
```

#### Relacionamentos propostos

```
ppcp.d_tecido
  <- ppcp.fconsumo_componente.fk_componente (sku_tecido)
  <- ppcp.frejeicao_pecas_tecido.fk_tecido  (sku_tecido)
  <- ppcp.frolos_reservados.cd_tecido        (sku_tecido)
```

#### Migracao SQL

```sql
ALTER TABLE ppcp.dtecidos RENAME TO d_tecido;
ALTER TABLE ppcp.d_tecido ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ppcp.d_tecido ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ppcp.d_tecido RENAME COLUMN cod_tecido TO sku_tecido;
ALTER TABLE ppcp.d_tecido ALTER COLUMN sku_tecido TYPE varchar(30);
ALTER TABLE ppcp.d_tecido ADD CONSTRAINT uq_d_tecido UNIQUE (sku_tecido);
ALTER TABLE ppcp.d_tecido RENAME COLUMN ref_tecido TO cod_referencia_tecido;
ALTER TABLE ppcp.d_tecido RENAME COLUMN descricao_tecido TO ds_tecido;
ALTER TABLE ppcp.d_tecido RENAME COLUMN referencia TO cod_referencia_produto;
ALTER TABLE ppcp.d_tecido RENAME COLUMN unidade_medida TO ds_unidade_medida;
ALTER TABLE ppcp.d_tecido RENAME COLUMN composicao TO ds_composicao;
ALTER TABLE ppcp.d_tecido RENAME COLUMN tipo_produto TO ds_tipo_produto;
ALTER TABLE ppcp.d_tecido RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE ppcp.d_tecido ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE ppcp.d_tecido ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW ppcp.dtecidos AS SELECT * FROM ppcp.d_tecido;
COMMENT ON VIEW ppcp.dtecidos IS 'DEPRECATED 2026-05-05: usar d_tecido. Sera removido em 2026-08-03.';
```

---

### ppcp.destagio

**Nome proposto:** `ppcp.d_estagio`
**Tipo:** dimensao
**Descricao:** Estagios do processo produtivo (corte, costura, beneficiamento, etc.) com deposito e sequencia de calculo.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_estagio` | `int2 NULL` | `id_estagio` | `smallint NOT NULL` | [RENAME] | Business key do estagio |
| `desc_estagio` | `varchar(20) NULL` | `ds_estagio` | `varchar(20)` | [RENAME] | Descricao |
| `cod_deposito` | `int2 NULL` | `id_deposito` | `smallint` | [RENAME] | Deposito associado |
| `area_producao` | `int2 NULL` | `id_area_producao` | `smallint` | [RENAME] | Area de producao |
| `tipo_estagio` | `int2 NULL` | `id_tipo_estagio` | `smallint` | [RENAME] | Tipo |
| `estagio_final` | `int2 NULL` | `fl_estagio_final` | `boolean` | [RENAME] [RETYPE] | Flag estagio final |
| `sequencia_calculo_fila` | `int2 NULL` | `nr_seq_calculo_fila` | `smallint` | [RENAME] | Sequencia no calculo |
| `estagio_base_fila` | `int2 NULL` | `id_estagio_base_fila` | `smallint` | [RENAME] | Base da fila |
| `responsavel_estagio` | `varchar(20) NULL` | `nm_responsavel` | `varchar(20)` | [RENAME] | Responsavel |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ppcp.destagio RENAME TO d_estagio;
ALTER TABLE ppcp.d_estagio ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ppcp.d_estagio ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ppcp.d_estagio RENAME COLUMN pk_estagio TO id_estagio;
ALTER TABLE ppcp.d_estagio ADD CONSTRAINT uq_d_estagio UNIQUE (id_estagio);
ALTER TABLE ppcp.d_estagio RENAME COLUMN desc_estagio TO ds_estagio;
ALTER TABLE ppcp.d_estagio RENAME COLUMN cod_deposito TO id_deposito;
ALTER TABLE ppcp.d_estagio RENAME COLUMN area_producao TO id_area_producao;
ALTER TABLE ppcp.d_estagio RENAME COLUMN tipo_estagio TO id_tipo_estagio;
ALTER TABLE ppcp.d_estagio RENAME COLUMN estagio_final TO fl_estagio_final;
ALTER TABLE ppcp.d_estagio ALTER COLUMN fl_estagio_final TYPE boolean USING (estagio_final = 1);
ALTER TABLE ppcp.d_estagio RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE ppcp.d_estagio ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE ppcp.d_estagio ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW ppcp.destagio AS SELECT * FROM ppcp.d_estagio;
COMMENT ON VIEW ppcp.destagio IS 'DEPRECATED 2026-05-05: usar d_estagio. Sera removido em 2026-08-03.';
```

---

### ppcp.dmaquina

**Nome proposto:** `ppcp.d_maquina`
**Tipo:** dimensao
**Descricao:** Maquinas do parque fabril com grupo, subgrupo, familia, capacidade e centro de custo.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_maquina` | `varchar(8) NULL` | `cod_maquina` | `varchar(8) NOT NULL` | [RENAME] | Business key da maquina |
| `numero_maquina` | `int4 NULL` | `nr_maquina` | `integer` | [RENAME] | Numero fisico |
| `cod_grupo_maquina` | `varchar(4) NULL` | `cod_grupo_maquina` | `varchar(4)` | [RENAME] | Grupo |
| `desc_grupo_maquina` | `varchar(60) NULL` | `ds_grupo_maquina` | `varchar(60)` | [RENAME] | Descricao grupo |
| `unidade_medida` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(2)` | [RENAME] | Unidade |
| `subgrupo_maquina` | `varchar(3) NULL` | `cod_subgrupo_maquina` | `varchar(3)` | [RENAME] | Subgrupo |
| `desc_subgrupo` | `varchar(10) NULL` | `ds_subgrupo_maquina` | `varchar(10)` | [RENAME] | Descricao subgrupo |
| `cod_familia` | `int2 NULL` | `id_familia` | `smallint` | [RENAME] | Familia |
| `desc_familia` | `varchar(25) NULL` | `ds_familia` | `varchar(25)` | [RENAME] | Descricao familia |
| `maquina_ativa` | `int4 NULL` | `fl_ativa` | `boolean` | [RENAME] [RETYPE] | Ativa; converter |
| `cod_centro_custo` | `int8 NULL` | `id_centro_custo` | `integer` | [RENAME] [RETYPE] | CC |
| `observacao_maquina` | `varchar(65) NULL` | `obs_maquina` | `varchar(65)` | [RENAME] | Observacao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `numero_operadores` | `numeric(18,3) NULL` | `nr_operadores` | `smallint` | [RENAME] [RETYPE] | Numero de operadores |
| `volume_maximo` | `numeric(18,3) NULL` | `vl_volume_maximo` | `numeric(15,3)` | [RENAME] [RETYPE] | Volume maximo |
| `volume_minimo` | `numeric(18,3) NULL` | `vl_volume_minimo` | `numeric(15,3)` | [RENAME] [RETYPE] | Volume minimo |
| `pk_maquina_num` | `varchar(80) NULL` | `cod_maquina_num` | `varchar(80)` | [RENAME] | Codigo numerico da maquina |
| `nome_maquina` | `varchar(10) NULL` | `nm_maquina` | `varchar(10)` | [RENAME] | Nome curto |
| `descricao_maquina` | `varchar(144) NULL` | `ds_maquina` | `varchar(144)` | [RENAME] | Descricao completa |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE ppcp.dmaquina RENAME TO d_maquina;
ALTER TABLE ppcp.d_maquina ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ppcp.d_maquina ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ppcp.d_maquina RENAME COLUMN pk_maquina TO cod_maquina;
ALTER TABLE ppcp.d_maquina ADD CONSTRAINT uq_d_maquina UNIQUE (cod_maquina);
ALTER TABLE ppcp.d_maquina RENAME COLUMN desc_grupo_maquina TO ds_grupo_maquina;
ALTER TABLE ppcp.d_maquina RENAME COLUMN maquina_ativa TO fl_ativa;
ALTER TABLE ppcp.d_maquina ALTER COLUMN fl_ativa TYPE boolean USING (maquina_ativa = 1);
ALTER TABLE ppcp.d_maquina RENAME COLUMN cod_centro_custo TO id_centro_custo;
ALTER TABLE ppcp.d_maquina ALTER COLUMN id_centro_custo TYPE integer;
ALTER TABLE ppcp.d_maquina RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE ppcp.d_maquina ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE ppcp.d_maquina ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW ppcp.dmaquina AS SELECT * FROM ppcp.d_maquina;
COMMENT ON VIEW ppcp.dmaquina IS 'DEPRECATED 2026-05-05: usar d_maquina. Sera removido em 2026-08-03.';
```

---

### ppcp.doperacao

**Nome proposto:** `ppcp.d_operacao`
**Tipo:** dimensao
**Descricao:** Operacoes do processo produtivo (ex: costura, corte, prensagem).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_operacao` | `int4 NULL` | `id_operacao` | `integer NOT NULL` | [RENAME] | Business key |
| `desc_operacao` | `varchar(50) NULL` | `ds_operacao` | `varchar(50)` | [RENAME] | Descricao |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### ppcp.dcad_centro_custo

**Nome proposto:** `ppcp.d_centro_custo`
**Tipo:** dimensao
**Descricao:** Centros de custo da producao (PPCP). Estrutura similar a `live.d_centro_custo` mas com tipos `numeric` do Systextil.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `centro_custo` | `numeric(6) NULL` | `id_centro_custo` | `integer` | [RENAME] [RETYPE] | Codigo do CC |
| `descricao` | `text NULL` | `ds_centro_custo` | `varchar(20)` | [RENAME] [RETYPE] | Descricao |
| `divisao_producao` | `numeric(4) NULL` | `id_divisao` | `smallint` | [RENAME] [RETYPE] | Divisao |
| `custo_despesa` | `numeric(1) NULL` | `id_tipo_custo` | `smallint` | [RENAME] [RETYPE] | Custo ou despesa |
| `fixo_variavel` | `numeric(1) NULL` | `id_fixo_variavel` | `smallint` | [RENAME] [RETYPE] | Fixo/variavel |
| `tipo_mao_obra` | `numeric(1) NULL` | `id_tipo_mao_obra` | `smallint` | [RENAME] [RETYPE] | Tipo mao de obra |
| `tipo_ccusto` | `numeric(1) NULL` | `id_tipo_ccusto` | `smallint` | [RENAME] [RETYPE] | Tipo CC |
| `situacao` | `numeric(1) NULL` | `id_situacao` | `smallint` | [RENAME] [RETYPE] | Situacao |
| `tempo_turno1-4` | `numeric(3) NULL` | `nr_tempo_turno1-4` | `smallint` | [RENAME] [RETYPE] | Tempo por turno |
| `local_entrega` | `numeric(3) NULL` | `id_local_entrega` | `smallint` | [RENAME] [RETYPE] | Local |
| `centro_custo_pai` | `numeric(6) NULL` | `id_centro_custo_pai` | `integer` | [RENAME] [RETYPE] | Pai |
| `data_alteracao` | `timestamp NULL` | `dth_alteracao` | `timestamp` | [RENAME] | Alteracao |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

> **Decisao pendente:** `ppcp.d_centro_custo` e `live.d_centro_custo` parecem duplicadas. Avaliar consolidar em um schema centralizado.

---

### ppcp.dcadastro_fornecedores

**Nome proposto:** `ppcp.d_fornecedor_producao`
**Tipo:** dimensao
**Descricao:** Fornecedores/faccoes aprovadas para producao, com endereco e status de aprovacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cnpj_forn` | `varchar(184) NULL` | `cnpj_fornecedor` | `varchar(16)` | [RENAME] [RETYPE] | **CRITICO:** varchar(184) para CNPJ — reformatar para varchar(16) |
| `razao_social` | `varchar(200) NULL` | `nm_fornecedor_razao` | `varchar(200)` | [RENAME] | Razao social |
| `nome_fantasia` | `varchar(200) NULL` | `nm_fornecedor_fantasia` | `varchar(200)` | [RENAME] | Nome fantasia |
| `rua` | `varchar(200) NULL` | `end_logradouro` | `varchar(200)` | [RENAME] | Rua |
| `numero` | `int8 NULL` | `end_numero` | `varchar(10)` | [RENAME] [RETYPE] | Numero |
| `bairro` | `varchar(100) NULL` | `end_bairro` | `varchar(50)` | [RENAME] [RETYPE] | Bairro |
| `cidade` | `varchar(100) NULL` | `end_cidade` | `varchar(60)` | [RENAME] [RETYPE] | Cidade |
| `estado` | `varchar(2) NULL` | `end_uf` | `char(2)` | [RENAME] [RETYPE] | UF |
| `cep` | `int8 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP |
| `email` | `varchar(100) NULL` | `nm_email` | `varchar(100)` | [RENAME] | Email |
| `email_nfe` | `varchar(100) NULL` | `nm_email_nfe` | `varchar(100)` | [RENAME] | Email NF-e |
| `data_cadastro` | `timestamp NULL` | `dt_cadastro` | `date` | [RENAME] [RETYPE] | Cadastro |
| `data_aprovacao` | `timestamp NULL` | `dt_aprovacao` | `date` | [RENAME] [RETYPE] | Aprovacao |
| `divisao_producao` | `int4 NULL` | `id_divisao` | `integer` | [RENAME] | Divisao |
| `status` | `int2 NULL` | `id_status` | `smallint` | [RENAME] | Status |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

> **CRITICO:** `cnpj_forn varchar(184)` e muito maior que o necessario. Reformatar via `dw.fn_formatar_cnpj_cpf`.

---

### ppcp.dcapacidade_fabrica

**Nome proposto:** `ppcp.d_capacidade_fabrica`
**Tipo:** dimensao
**Descricao:** Capacidade de producao da fabrica por referencia, categoria e agrupamento, com limites semanais.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `referencia` | `cod_referencia` | `varchar(5)` |
| `id_categoria` | `id_categoria` | `integer` |
| `categoria` | `ds_categoria` | `varchar(80)` |
| `id_agrupamento` | `id_agrupamento` | `integer` |
| `nome_agrupamento` | `nm_agrupamento` | `varchar(80)` |
| `capacidade_semanal_min` | `vl_capacidade_min_semana` | `numeric(15,3)` |
| `capacidade_semanal_pecas` | `qt_capacidade_pecas_semana` | `numeric(15,3)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.ddivisao_producao

**Nome proposto:** `ppcp.d_divisao_producao`
**Tipo:** dimensao
**Descricao:** Divisoes de producao (celulas produtivas) com CNPJ do fornecedor, area, centro de custo e rota.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `divisao` | `int8 NULL` | `id_divisao` | `integer` | [RENAME] [RETYPE] | Codigo da divisao |
| `cnpj` | `varchar(25) NULL` | `cnpj_fornecedor` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ formato DW |
| `nomefornecedor` | `varchar(60) NULL` | `nm_fornecedor` | `varchar(60)` | [RENAME] | Nome |
| `descricaodivisao` | `varchar(20) NULL` | `ds_divisao` | `varchar(20)` | [RENAME] | Descricao |
| `area` | `int8 NULL` | `id_area` | `integer` | [RENAME] [RETYPE] | Area |
| `descricaoarea` | `varchar(20) NULL` | `ds_area` | `varchar(20)` | [RENAME] | Descricao |
| `centrocusto` | `int8 NULL` | `id_centro_custo` | `integer` | [RENAME] [RETYPE] | CC |
| `descricaocentrocusto` | `varchar(20) NULL` | `ds_centro_custo` | `varchar(20)` | [RENAME] | Descricao CC |
| `eficienciapadrao` | `int8 NULL` | `pc_eficiencia_padrao` | `numeric(7,4)` | [RENAME] [RETYPE] | Eficiencia padrao |
| `abastecimento` | `int2 NULL` | `id_tipo_abastecimento` | `smallint` | [RENAME] | Tipo abastecimento |
| `rota` | `int8 NULL` | `id_rota` | `integer` | [RENAME] [RETYPE] | Rota |
| `descricaorota` | `varchar(40) NULL` | `ds_rota` | `varchar(40)` | [RENAME] | Descricao rota |
| `tipolinha` | `numeric(13,3) NULL` | `id_tipo_linha` | `integer` | [RENAME] [RETYPE] | Tipo de linha |
| `responsavel` | `int8 NULL` | `id_responsavel` | `integer` | [RENAME] [RETYPE] | Responsavel |
| `descricaoresponsavel` | `varchar(40) NULL` | `nm_responsavel` | `varchar(40)` | [RENAME] | Nome |
| `operadores` | `int8 NULL` | `nr_operadores` | `integer` | [RENAME] [RETYPE] | Numero de operadores |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### ppcp.dhomologacao_fornecedores

**Nome proposto:** `ppcp.d_homologacao_fornecedor`
**Tipo:** dimensao
**Descricao:** Status de homologacao de fornecedores por area e responsavel.

Segue padrao de `d_fornecedor_producao` com campos adicionais:
- `id_area int2` → `id_area smallint`
- `nome_area varchar(20)` → `ds_area varchar(20)`
- `centro_custo int4` → `id_centro_custo integer`
- `nome_ccusto varchar(20)` → `ds_centro_custo varchar(20)`
- `id_responsavel int4` → `id_responsavel integer`
- `nome varchar(40)` → `nm_responsavel varchar(40)`
- `desc_status varchar(19)` → `ds_status varchar(20)`

---

### ppcp.dinfotec_fornecedores

**Nome proposto:** `ppcp.d_infotec_fornecedor`
**Tipo:** dimensao
**Descricao:** Informacoes tecnicas de fornecedores: operadores, maquinas, custos e eficiencia.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cnpj_forn` | `cnpj_fornecedor` | `varchar(16)` |
| `cargo_operador` | `id_cargo_operador` | `integer` |
| `qdt_operador` | `qt_operadores` | `integer` |
| `grupo_maquina` | `ds_grupo_maquina` | `varchar(50)` |
| `sub_grupo_maquina` | `ds_subgrupo_maquina` | `varchar(50)` |
| `qdt_maquina` | `qt_maquinas` | `integer` |
| `centro_custo` | `id_centro_custo` | `integer` |
| `id_tipo_servico` | `id_tipo_servico` | `integer` |
| `prazo_abastecimento` | `nr_prazo_abastecimento_dias` | `smallint` |
| `custo_minuto` | `vl_custo_minuto` | `numeric(15,4)` |
| `eficiencia_padrao` | `pc_eficiencia_padrao` | `numeric(7,4)` |
| `min_turno_01-04` | `nr_min_turno_01-04` | `numeric(15,3)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.dmotivos_reposicao

**Nome proposto:** `ppcp.d_motivo_reposicao`
**Tipo:** dimensao
**Descricao:** Motivos de reposicao de pecas por estagio e area.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `codigo` | `varchar(5) NULL` | `id_motivo` | `varchar(5)` | [RENAME] | Codigo do motivo |
| `desc_motivo` | `varchar(60) NULL` | `ds_motivo` | `varchar(60)` | [RENAME] | Descricao |
| `tipo` | `varchar(3) NULL` | `ds_tipo` | `varchar(3)` | [RENAME] | Tipo |
| `estagio` | `varchar(5) NULL` | `id_estagio` | `varchar(5)` | [RENAME] | Estagio |
| `area_agrupadora` | `varchar(5) NULL` | `ds_area_agrupadora` | `varchar(5)` | [RENAME] | Area |
| `desc_area` | `varchar(60) NULL` | `ds_area` | `varchar(60)` | [RENAME] | Descricao area |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### ppcp.dpolivalencia_maquinas

**Nome proposto:** `ppcp.d_polivalencia_maquina`
**Tipo:** dimensao
**Descricao:** Polivalencias entre maquinas — define que maquinas podem substituir uma maquina principal.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` (substituir o `id int8`) | [RETYPE] | Promover PK |
| `id` | `int8 NULL` | `id_polivalencia` | `bigint` | [RENAME] | Codigo |
| `maquina_princ` | `varchar(8) NULL` | `cod_maquina_principal` | `varchar(8)` | [RENAME] | Maquina principal |
| `maquina_poli_1` | `varchar(8) NULL` | `cod_maquina_poli_1` | `varchar(8)` | [RENAME] | Polivalencia 1 |
| `maquina_poli_2` | `varchar(8) NULL` | `cod_maquina_poli_2` | `varchar(8)` | [RENAME] | Polivalencia 2 |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### ppcp.dobs_estagio

**Nome proposto:** `ppcp.f_obs_estagio`
**Tipo:** fato
**Descricao:** Observacoes por ordem de producao e estagio — registro de ocorrencias durante a producao.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao` | `nr_ordem_producao` | `integer` |
| `ordem_confeccao` | `nr_ordem_confeccao` | `integer` |
| `estagio` | `id_estagio` | `integer` |
| `tamanho_ordem_confeccao` | `ds_tamanho_oc` | `varchar(15)` |
| `tipo_obs` | `ds_tipo_obs` | `varchar(200)` |
| `observacao_adicional` | `obs_adicional` | `varchar(500)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordens_corte

**Nome proposto:** `ppcp.f_ordem_corte`
**Tipo:** fato
**Descricao:** Ordens de corte por produto, estagio e periodo, com quantidades programadas, produzidas e canceladas.
**Sistema de origem:** Systextil PPCP

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cd_ordem_producao` | `int4 NULL` | `nr_ordem_producao` | `integer NOT NULL` | [RENAME] | OP |
| `cd_nivel99` | `float8 NULL` | `cod_nivel_produto` | `varchar(1)` | [RENAME] [RETYPE] | Nivel (parte 1 do SKU); `float8` para codigo = incorreto |
| `cd_grupo` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | [RENAME] | Referencia (parte 2) |
| `cd_subgrupo` | `varchar(5) NULL` | `cod_tamanho` | `varchar(3)` | [RENAME] [RETYPE] | Tamanho (parte 3) |
| `prod_rej_item` | `varchar(6) NULL` | `cod_cor` | `varchar(6)` | [RENAME] | Cor (parte 4 — confirmar mapeamento) |
| `fk_produto` | `varchar(125) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU |
| `cd_estagio` | `int4 NULL` | `id_estagio` | `integer` | [RENAME] | Estagio |
| `periodo_producao` | `int2 NULL` | `nr_periodo_producao` | `smallint` | [RENAME] | Periodo |
| `cd_ordem_confeccao` | `int4 NULL` | `nr_ordem_confeccao` | `integer` | [RENAME] | OC |
| `qtd_pecas_progamada` | `numeric(18,3) NULL` | `qt_programada` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd programada |
| `qtd_pecas_produzida` | `numeric(18,3) NULL` | `qt_produzida` | `numeric(15,3)` | [RENAME] [RETYPE] | Qtd produzida |
| `qtd_conserto` | `numeric(18,3) NULL` | `qt_conserto` | `numeric(15,3)` | [RENAME] [RETYPE] | Conserto |
| `qtd_pecas_2a` | `numeric(18,3) NULL` | `qt_segunda_qualidade` | `numeric(15,3)` | [RENAME] [RETYPE] | 2a qualidade |
| `qtd_perdas` | `numeric(18,3) NULL` | `qt_perdas` | `numeric(15,3)` | [RENAME] [RETYPE] | Perdas |
| `situacao_ordem` | `int2 NULL` | `id_situacao_ordem` | `smallint` | [RENAME] | Situacao |
| `cod_cancelamento` | `int2 NULL` | `id_cancelamento` | `smallint` | [RENAME] | Cancelamento |
| `data_alteracao` | `timestamp NULL` | `dth_alteracao` | `timestamp` | [RENAME] | Alteracao |
| `data_producao` | `timestamp NULL` | `dt_producao` | `date` | [RENAME] [RETYPE] | Data producao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `data_programacao` | `timestamp NULL` | `dt_programacao` | `date` | [RENAME] [RETYPE] | Programacao |
| `fk_fornecedor` | `varchar(150) NULL` | `cnpj_fornecedor` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ do fornecedor/faccao |
| `observacao` | `text NULL` | `obs_ordem` | `text` | [RENAME] | Observacao |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Relacionamentos propostos

```
ppcp.f_ordem_corte
  |- sku_produto     -> live.d_produto.sku_produto
  |- id_estagio      -> ppcp.d_estagio.id_estagio
  |- cnpj_fornecedor -> ppcp.d_fornecedor_producao.cnpj_fornecedor
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_ordem_corte_op ON ppcp.f_ordem_corte (nr_ordem_producao);
CREATE INDEX idx_f_ordem_corte_produto ON ppcp.f_ordem_corte (sku_produto);
CREATE INDEX idx_f_ordem_corte_periodo ON ppcp.f_ordem_corte (nr_periodo_producao);
```

#### Migracao SQL (principais)

```sql
ALTER TABLE ppcp.fordens_corte RENAME TO f_ordem_corte;
ALTER TABLE ppcp.f_ordem_corte ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE ppcp.f_ordem_corte ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE ppcp.f_ordem_corte RENAME COLUMN cd_ordem_producao TO nr_ordem_producao;
ALTER TABLE ppcp.f_ordem_corte RENAME COLUMN fk_produto TO sku_produto;
ALTER TABLE ppcp.f_ordem_corte ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE ppcp.f_ordem_corte RENAME COLUMN cd_estagio TO id_estagio;
ALTER TABLE ppcp.f_ordem_corte RENAME COLUMN fk_fornecedor TO cnpj_fornecedor;
ALTER TABLE ppcp.f_ordem_corte ALTER COLUMN cnpj_fornecedor TYPE varchar(16);
ALTER TABLE ppcp.f_ordem_corte RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE ppcp.f_ordem_corte ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE ppcp.f_ordem_corte ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW ppcp.fordens_corte AS SELECT * FROM ppcp.f_ordem_corte;
COMMENT ON VIEW ppcp.fordens_corte IS 'DEPRECATED 2026-05-05: usar f_ordem_corte. Sera removido em 2026-08-03.';
```

---

### ppcp.fordens_em_producao

**Nome proposto:** `ppcp.f_ordem_em_producao`
**Tipo:** fato
**Descricao:** Ordens atualmente em producao por estagio, com quantidades e CNPJ do fornecedor.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `periodo_producao` | `nr_periodo_producao` | `smallint` |
| `ordem_producao` | `nr_ordem_producao` | `integer` |
| `ordem_confeccao` | `nr_ordem_confeccao` | `integer` |
| `codigo_estagio` | `id_estagio` | `integer` |
| `fk_produto` | `sku_produto` | `varchar(30)` |
| `qtde_pecas_prog` | `qt_programada` | `numeric(15,3)` |
| `qtde_pecas_prod` | `qt_produzida` | `numeric(15,3)` |
| `qtde_em_producao` | `qt_em_producao` | `numeric(15,3)` |
| `cnpj_fornecedor` | `cnpj_fornecedor` | `varchar(16)` (retype) |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordens_produzidas / fordens_produzidas_alt_item

**Nomes propostos:** `f_ordem_produzida`, `f_ordem_produzida_alt_item`
**Tipo:** fato
**Descricao:** Ordens produzidas com detalhamento de estagio, fornecedor e quantidades.

Padrao de renomeacao (aplicar em ambas):
- `cd_nivel99 text` → `cod_nivel_produto varchar(1)`
- `cd_grupo text` → `cod_referencia varchar(5)`
- `cd_subgrupo text` → `cod_tamanho varchar(3)`
- `cd_item text` → `cod_cor varchar(6)`
- `cd_ordem_producao text/numeric(9)` → `nr_ordem_producao integer`
- `cd_ordem_confeccao numeric(5)` → `nr_ordem_confeccao integer`
- `cd_estagio numeric(5)` → `id_estagio integer`
- `des_estagio text` → `ds_estagio varchar(20)`
- `data_producao timestamp` → `dt_producao date`
- `data_entrada_estagio timestamp` → `dth_entrada_estagio timestamp`
- `qtd_produzidas numeric(38,10)` → `qt_produzidas numeric(15,3)`
- `qtd_conserto/perdas/segunda numeric(6)` → `qt_conserto/perdas/segunda_qualidade numeric(15,3)`
- `ultima_atualizacao timestamp` → `updated_at timestamp NOT NULL DEFAULT current_timestamp`
- Adicionar `id bigserial PK`, `created_at`

---

### ppcp.fapontamento_producao

**Nome proposto:** `ppcp.f_apontamento_producao`
**Tipo:** fato
**Descricao:** Apontamentos de producao por OP, OC, estagio e periodo com quantidades apontadas e perdas.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `periodo_producao` | `nr_periodo_producao` | `smallint` |
| `ordem_producao` | `nr_ordem_producao` | `integer` |
| `oc` | `nr_ordem_confeccao` | `integer` |
| `nivel` | `cod_nivel_produto` | `varchar(1)` |
| `grupo` | `cod_referencia` | `varchar(5)` |
| `subgrupo` | `cod_tamanho` | `varchar(3)` |
| `item` | `cod_cor` | `varchar(6)` |
| `codigo_estagio` | `id_estagio` | `integer` |
| `data_insercao` | `dth_apontamento` | `timestamp` |
| `codigo_usuario` | `id_usuario` | `integer` |
| `qtd_apontada` | `qt_apontada` | `numeric(15,3)` |
| `qtde_perdas` | `qt_perdas` | `numeric(15,3)` |
| `qtde_pecas_2a` | `qt_segunda_qualidade` | `numeric(15,3)` |
| `qtde_conserto` | `qt_conserto` | `numeric(15,3)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| `pk_produto` | `sku_produto` | `varchar(30)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fconsumo_componente

**Nome proposto:** `ppcp.f_consumo_componente`
**Tipo:** fato
**Descricao:** Estrutura de consumo de componentes (tecidos, aviamentos) por produto, com colecao e quantidade de consumo.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_produto` | `sku_produto` | `varchar(30)` |
| `desc_produto` | `ds_produto` | `varchar(70)` |
| `fk_componente` | `sku_componente` | `varchar(30)` (sku_tecido se for tecido) |
| `narrativa` | `ds_narrativa` | `varchar(70)` |
| `linha_produto` | `id_linha` | `smallint` |
| `descr_colecao` | `ds_colecao` | `varchar(20)` |
| `estagio` | `id_estagio` | `integer` |
| `ref_produto` | `cod_referencia_produto` | `varchar(5)` |
| `tam_produto` | `cod_tamanho_produto` | `varchar(3)` |
| `cor_produto` | `cod_cor_produto` | `varchar(6)` |
| `nivel_produto` | `cod_nivel_produto` | `varchar(1)` |
| `ref_componente` | `cod_referencia_componente` | `varchar(5)` |
| `colecao` | `id_colecao` | `smallint` |
| `consumo` | `qt_consumo` | `numeric(15,3)` |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fdefeitos_producao

**Nome proposto:** `ppcp.f_defeito_producao`
**Tipo:** fato
**Descricao:** Defeitos registrados na producao por estagio, motivo e ordem de confeccao.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `num_ordem_producao numeric(9)` | `nr_ordem_producao` | `integer` |
| `num_ordem_confeccao numeric(5)` | `nr_ordem_confeccao` | `integer` |
| `cod_estagio numeric(5)` | `id_estagio` | `integer` |
| `cod_periodo numeric(4)` | `nr_periodo_producao` | `smallint` |
| `pk_produto varchar(35)` | `sku_produto` | `varchar(30)` |
| `cod_motivo numeric(3)` | `id_motivo_defeito` | `smallint` |
| `des_motivo varchar(60)` | `ds_motivo_defeito` | `varchar(60)` |
| `qtd_perda numeric(18,3)` | `qt_perda` | `numeric(15,3)` |
| `data_rejeicao timestamp` | `dth_rejeicao` | `timestamp` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.finspecao_qualidade

**Nome proposto:** `ppcp.f_inspecao_qualidade`
**Tipo:** fato
**Descricao:** Inspecoes de qualidade com medidas, tolerancias e resultados por OP, OC e estagio.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `id_inspecao numeric(9)` | `id_inspecao` | `integer` |
| `ordem_producao numeric(9)` | `nr_ordem_producao` | `integer` |
| `ordem_confeccao numeric(5)` | `nr_ordem_confeccao` | `integer` |
| `periodo numeric(4)` | `nr_periodo_producao` | `smallint` |
| `cod_estagio numeric(2)` | `id_estagio` | `smallint` |
| `pk_produto text` | `sku_produto` | `varchar(30)` |
| `data_inspecao timestamp` | `dth_inspecao` | `timestamp` |
| `qtde_inspecionar_pcs numeric(6)` | `qt_a_inspecionar` | `numeric(6,0)` |
| `qtde_inspecionada_pcs numeric(6)` | `qt_inspecionada` | `numeric(6,0)` |
| `qtde_rejeitada_pcs numeric(6)` | `qt_rejeitada` | `numeric(6,0)` |
| `perc_rejeitada_pcs numeric(3)` | `pc_rejeitada` | `numeric(7,4)` |
| `val_medida_padrao numeric(7,3)` | `vl_medida_padrao` | `numeric(7,3)` |
| `val_medida_real numeric(7,3)` | `vl_medida_real` | `numeric(7,3)` |
| `data_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordens_beneficiamento / fordens_tecelagem

**Nomes propostos:** `f_ordem_beneficiamento`, `f_ordem_tecelagem`
**Tipo:** fato
**Descricao:** Ordens de beneficiamento e tecelagem com maquina, periodo, SKU e quantidades em kg/rolos.

Padrao de renomeacao (aplicar em ambas):
- `pk_maquina varchar(39)` → `cod_maquina varchar(8)` (truncar para padrao `d_maquina`)
- `pk_produto varchar(50/85)` → `sku_produto varchar(30)`
- `periodo_producao int2` → `nr_periodo_producao smallint`
- `ordem_producao/beneficiamento/tecelagem int4` → `nr_ordem_producao integer`
- `codigo_estagio int4` → `id_estagio integer`
- `quilos_prod/prog/prep numeric(21,3)` → `vl_quilos_prod/prog/prep numeric(15,3)`
- `rolos_prod/prog/prep numeric(21,3)` → `qt_rolos_prod/prog/prep numeric(15,3)`
- `ultima_atualizacao timestamp` → `updated_at`
- Adicionar `id bigserial PK`, `created_at`

---

### ppcp.fpontualidade_beneficiamento / fpontualidade_confeccao

**Nomes propostos:** `f_pontualidade_beneficiamento`, `f_pontualidade_confeccao`
**Tipo:** fato
**Descricao:** Metricas de pontualidade da producao por periodo e estagio.

Padrao:
- `periodo int4` → `nr_periodo_producao integer`
- `codigo_estagio int4` → `id_estagio integer`
- `programado/produzido numeric(15,3)` → `qt_programado/produzido`
- `percentual_pontualidade numeric(5,2)` → `pc_pontualidade numeric(7,4)`
- `ultima_atualizacao timestamp` → `updated_at`
- Datas timestamp que sao so data → converter para `date`
- Adicionar `id bigserial PK`, `created_at`

---

### ppcp.froteiro

**Nome proposto:** `ppcp.f_roteiro`
**Tipo:** fato
**Descricao:** Roteiro de producao por produto: sequencia de operacoes, estagios, tempo e maquinas.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `num_roteiro int2` | `nr_roteiro` | `smallint` |
| `seq_operacao int2` | `nr_seq_operacao` | `smallint` |
| `fk_operacao int4` | `id_operacao` | `integer` |
| `fk_estagio int2` | `id_estagio` | `smallint` |
| `fk_produto varchar(20)` | `sku_produto` | `varchar(30)` |
| `alternativa_item int4` | `nr_alternativa_item` | `integer` |
| `centro_custo int4` | `id_centro_custo` | `integer` |
| `minutos_roteiro numeric(18,3)` | `nr_minutos_roteiro` | `numeric(10,4)` |
| `velocidade numeric(18,3)` | `vl_velocidade` | `numeric(10,4)` |
| `minutos_homem numeric(18,3)` | `nr_minutos_homem` | `numeric(10,4)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordens_reposicoes

**Nome proposto:** `ppcp.f_ordem_reposicao`
**Tipo:** fato
**Descricao:** Ordens de reposicao de pecas com motivo, situacao e usuarios envolvidos.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `id_reposicao int4` | `id_reposicao` | `integer` |
| `ordemreposicao int4` | `nr_ordem_reposicao` | `integer` |
| `ordemproducao int4` | `nr_ordem_producao` | `integer` |
| `periodo int2` | `nr_periodo_producao` | `smallint` |
| `referencia varchar(5)` | `cod_referencia` | `varchar(5)` |
| `tamanho varchar(20)` | `cod_tamanho` | `varchar(5)` |
| `cor varchar(6)` | `cod_cor` | `varchar(6)` |
| `estagio int2` | `id_estagio` | `smallint` |
| `situacao int2` | `id_situacao` | `smallint` |
| `cod_motivo_reposicao numeric(9)` | `id_motivo_reposicao` | `integer` |
| `quantidade numeric(9)` | `qt_reposicao` | `integer` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordens_servico

**Nome proposto:** `ppcp.f_ordem_servico`
**Tipo:** fato
**Descricao:** Ordens de servico para fornecedores com NF, prazos e situacao.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `numero_ordem int8` | `nr_ordem_servico` | `integer` |
| `ordem_producao int8` | `nr_ordem_producao` | `integer` |
| `nota_fiscal int8` | `nr_nota_fiscal` | `integer` |
| `cod_fornecedor varchar(20)` | `cod_fornecedor` | `varchar(20)` |
| `data_emissao date` | `dt_emissao` | `date` |
| `data_entrega date` | `dt_entrega` | `date` |
| `codigo_servico int4` | `id_servico` | `integer` |
| `situacao_ordem varchar(20)` | `ds_situacao_ordem` | `varchar(20)` |
| `valor numeric(18,2)` | `vl_servico` | `numeric(15,2)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.dprevisao_vendas

**Nome proposto:** `ppcp.f_previsao_venda`
**Tipo:** fato
**Descricao:** Previsao de vendas por ref+cor/SKU, colecao e tabela de preco com quantidade e valores sell-in/sell-out.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `id int4` | `id_previsao` | `integer` |
| `descricao varchar(255)` | `ds_previsao` | `varchar(255)` |
| `descricaocolecao varchar(255)` | `ds_colecao` | `varchar(100)` |
| `ref_cor varchar(100)` | `sku_ref_cor` | `varchar(30)` |
| `sku varchar(100)` | `sku_produto` | `varchar(30)` |
| `percentual_aplicar numeric(10,4)` | `pc_aplicar` | `numeric(7,4)` |
| `qtde_previsao_item numeric(15,4)` | `qt_previsao_item` | `numeric(15,3)` |
| `valor_sell_in numeric(15,4)` | `vl_sell_in` | `numeric(15,2)` |
| `valor_sell_out numeric(15,4)` | `vl_sell_out` | `numeric(15,2)` |
| `qtde_previsao_capa numeric(15,4)` | `qt_previsao_capa` | `numeric(15,3)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fprodutos_bloqueados_venda

**Nome proposto:** `ppcp.f_produto_bloqueado_venda`
**Tipo:** fato
**Descricao:** Produtos bloqueados para venda com periodo de bloqueio e observacao.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `linha numeric(3)` | `id_linha` | `smallint` |
| `artigo numeric(5)` | `id_artigo` | `integer` |
| `colecao numeric(4)` | `id_colecao` | `smallint` |
| `pk_produto text` | `cod_produto_legado` | `varchar(25)` |
| `sku_produto text` | `sku_produto` | `varchar(30)` |
| `per_ini_bloq timestamp` | `dt_inicio_bloqueio` | `date` |
| `per_fim_bloq timestamp` | `dt_fim_bloqueio` | `date` |
| `observacao_bloq text` | `obs_bloqueio` | `text` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fqtd_produzida

**Nome proposto:** `ppcp.f_qtd_produzida`
**Tipo:** fato
**Descricao:** Quantidade produzida por OP, OC, estagio e usuario.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao int4` | `nr_ordem_producao` | `integer` |
| `oc int4` | `nr_ordem_confeccao` | `integer` |
| `codigo_estagio int4` | `id_estagio` | `integer` |
| `data_producao timestamp` | `dt_producao` | `date` |
| `referencia varchar(5)` | `cod_referencia` | `varchar(5)` |
| `tamanho varchar(3)` | `cod_tamanho` | `varchar(3)` |
| `cor varchar(6)` | `cod_cor` | `varchar(6)` |
| `qtd_programada int4` | `qt_programada` | `integer` |
| `codigo_usuario int4` | `id_usuario` | `integer` |
| `qtd_produzida numeric(18,3)` | `qt_produzida` | `numeric(15,3)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.frejeicao_pecas_tecido

**Nome proposto:** `ppcp.f_rejeicao_peca_tecido`
**Tipo:** fato
**Descricao:** Rejeicoes de pecas de tecido durante beneficiamento.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao int4` | `nr_ordem_producao` | `integer` |
| `estagio int4` | `id_estagio` | `integer` |
| `periodo int2` | `nr_periodo_producao` | `smallint` |
| `fk_tecido varchar(50)` | `sku_tecido` | `varchar(30)` |
| `fk_produto varchar(50)` | `sku_produto` | `varchar(30)` |
| `parte_peca varchar(50)` | `ds_parte_peca` | `varchar(50)` |
| `motivo int4` | `id_motivo` | `integer` |
| `desc_motivo varchar(60)` | `ds_motivo` | `varchar(60)` |
| `quantidade int2` | `qt_rejeitada` | `smallint` |
| `data_rejeicao timestamp` | `dth_rejeicao` | `timestamp` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.frolos_reservados

**Nome proposto:** `ppcp.f_rolo_reservado`
**Tipo:** fato
**Descricao:** Rolos de tecido reservados para ordens de producao.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao int4` | `nr_ordem_producao` | `integer` |
| `codigo_rolo int4` | `nr_rolo` | `integer` |
| `deposito int2` | `id_deposito` | `smallint` |
| `cd_tecido varchar(35)` | `sku_tecido` | `varchar(30)` |
| `qtde_reservada numeric(18,3)` | `qt_reservada` | `numeric(15,3)` |
| `qtde_necessaria numeric(18,3)` | `qt_necessaria` | `numeric(15,3)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.faprovacoes_requisicao

**Nome proposto:** `ppcp.f_aprovacao_requisicao`
**Tipo:** fato
**Descricao:** Aprovacoes de requisicoes de reposicao com status PCP e qualidade.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao int4` | `nr_ordem_producao` | `integer` |
| `ordem_reposicao int4` | `nr_ordem_reposicao` | `integer` |
| `estagio_solicitante int4` | `id_estagio_solicitante` | `integer` |
| `periodo int2` | `nr_periodo` | `smallint` |
| `referencia varchar(5)` | `cod_referencia` | `varchar(5)` |
| `tamanho varchar(3)` | `cod_tamanho` | `varchar(3)` |
| `cor varchar(6)` | `cod_cor` | `varchar(6)` |
| `status int2` | `id_status` | `smallint` |
| `status_repo varchar(32)` | `ds_status_repo` | `varchar(32)` |
| `status_pcp int2` | `id_status_pcp` | `smallint` |
| `desc_status_pcp varchar(32)` | `ds_status_pcp` | `varchar(32)` |
| `status_qualidade int2` | `id_status_qualidade` | `smallint` |
| `quantidade int4` | `qt_peca` | `integer` |
| `observacao varchar(500)` | `obs_requisicao` | `varchar(500)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.faprovacao_rolos_930

**Nome proposto:** `ppcp.f_aprovacao_rolo`
**Tipo:** fato
**Descricao:** Aprovacao de rolos no processo de inspecao 930.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `lote varchar(10)` | `nr_lote` | `varchar(10)` |
| `rolo varchar(10)` | `nr_rolo` | `varchar(10)` |
| `aprovado numeric(17,2)` | `qt_aprovada` | `numeric(15,3)` |
| `id_motivo int4` | `id_motivo` | `integer` |
| `desc_motivo varchar(60)` | `ds_motivo` | `varchar(60)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fbeneficiamento_acomp_prod

**Nome proposto:** `ppcp.f_beneficiamento_acompanhamento`
**Tipo:** fato
**Descricao:** Acompanhamento de beneficiamento com inicio, termino, operadores e previsao.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao int4` | `nr_ordem_producao` | `integer` |
| `codigo_estagio int4` | `id_estagio` | `integer` |
| `seq_operacao int4` | `nr_seq_operacao` | `integer` |
| `codigo_operacao int4` | `id_operacao` | `integer` |
| `numero_maquina int4` | `nr_maquina` | `integer` |
| `data_inicio date` | `dt_inicio` | `date` |
| `hora_inicio timestamp` | `dth_inicio` | `timestamp` |
| `operador_inicio int4` | `id_operador_inicio` | `integer` |
| `data_termino date` | `dt_termino` | `date` |
| `hora_termino timestamp` | `dth_termino` | `timestamp` |
| `operador_termino int4` | `id_operador_termino` | `integer` |
| `minutos_unitario numeric(10,2)` | `nr_minutos_unitario` | `numeric(10,4)` |
| `previsao_termino date` | `dt_previsao_termino` | `date` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.festagios_beneficiamento

**Nome proposto:** `ppcp.f_estagio_beneficiamento`
**Tipo:** fato
**Descricao:** Estagios de beneficiamento com datas de inicio e termino por sequencia de operacao.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `seq_operacao numeric(4)` | `nr_seq_operacao` | `smallint` |
| `codigo_estagio numeric(5)` | `id_estagio` | `integer` |
| `seq_estagio numeric(1)` | `nr_seq_estagio` | `smallint` |
| `turno_producao numeric(1)` | `id_turno` | `smallint` |
| `data_inicio timestamp` | `dth_inicio` | `timestamp` |
| `data_termino timestamp` | `dth_termino` | `timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fitens_requisicao_almoxerifado

**Nome proposto:** `ppcp.f_item_requisicao_almox`
**Tipo:** fato
**Descricao:** Itens de requisicao de almoxarifado por empresa, divisao, CC e deposito.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `empresa int2` | `id_empresa` | `smallint` |
| `desc_empresa varchar(35)` | `ds_empresa` | `varchar(35)` |
| `divisao_producao int2` | `id_divisao` | `smallint` |
| `centro_custo int4` | `id_centro_custo` | `integer` |
| `cod_deposito int2` | `id_deposito` | `smallint` |
| `sequencia int2` | `nr_sequencia` | `smallint` |
| `material varchar(120)` | `ds_material` | `varchar(120)` |
| `quantidade numeric(18,3)` | `qt_material` | `numeric(15,3)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.flista_prioridades

**Nome proposto:** `ppcp.f_lista_prioridade`
**Tipo:** fato
**Descricao:** Lista de prioridades de producao por referencia, tamanho, cor, estagio e pedido de venda.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `id float8` | `id_prioridade` | `integer` |
| `referencia varchar(5)` | `cod_referencia` | `varchar(5)` |
| `tamanho varchar(3)` | `cod_tamanho` | `varchar(3)` |
| `cor varchar(6)` | `cod_cor` | `varchar(6)` |
| `ordemproducao int4` | `nr_ordem_producao` | `integer` |
| `ordemconfeccao int4` | `nr_ordem_confeccao` | `integer` |
| `periodo int2` | `nr_periodo_producao` | `smallint` |
| `codestagio int4` | `id_estagio` | `integer` |
| `pedidovenda int4` | `nr_pedido_venda` | `integer` |
| `qtdeprogramada int4` | `qt_programada` | `integer` |
| `codfaccao varchar(100)` | `cnpj_faccao` | `varchar(16)` (formatar CNPJ) |
| `descfaccao varchar(60)` | `nm_faccao` | `varchar(60)` |
| `dataentradaestagio timestamp` | `dth_entrada_estagio` | `timestamp` |
| `ultima_atualizacao date` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fmaquinas_divisao_externa / fmaquinas_divisao_interna

**Nomes propostos:** `f_maquina_divisao_externa`, `f_maquina_divisao_interna`
**Tipo:** fato
**Descricao:** Maquinas por divisao externa (faccoes) e interna, com codigos, quantidades e status.

Padrao de renomeacao:
- Corrigir tipos `numeric(38,10)` para `integer` ou `numeric(15,3)`
- `cnpj text` → `cnpj_fornecedor varchar(16)`
- `cod_maquina text` → `cod_maquina varchar(8)`
- `maquina text` → `ds_maquina varchar(100)`
- Adicionar `id bigserial PK`, `created_at`, `updated_at` (external), ou confirmar `updated_at` (internal)

---

### ppcp.fmedidas_insumos

**Nome proposto:** `ppcp.f_medida_insumo`
**Tipo:** fato
**Descricao:** Medidas de insumos por referencia, sequencia e parte de conjunto, com tolerancias.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `referencia varchar(80)` | `cod_referencia` | `varchar(80)` |
| `alternativa int4` | `nr_alternativa` | `integer` |
| `sequencia int4` | `nr_sequencia` | `integer` |
| `descricao varchar(180)` | `ds_insumo` | `varchar(180)` |
| `tolerancia_min int4` | `vl_tolerancia_min` | `integer` |
| `tolerancia_max int4` | `vl_tolerancia_max` | `integer` |
| `tamanho varchar(40)` | `ds_tamanho` | `varchar(40)` |
| `medida numeric(15,3)` | `vl_medida` | `numeric(15,3)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fmovimentacao_enderecos

**Nome proposto:** `ppcp.f_movimentacao_endereco`
**Tipo:** fato
**Descricao:** Movimentacoes de enderecos de estoque por produto e deposito.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `produto text` | `sku_produto` | `varchar(30)` |
| `nivel text` | `cod_nivel` | `varchar(1)` |
| `grupo text` | `cod_referencia` | `varchar(5)` |
| `subgrupo text` | `cod_tamanho` | `varchar(3)` |
| `item text` | `cod_cor` | `varchar(6)` |
| `descricao text` | `ds_produto` | `varchar(100)` |
| `deposito numeric(3)` | `id_deposito` | `smallint` |
| `situacaotag numeric(1)` | `id_situacao_tag` | `smallint` |
| `qtdeenderecado numeric(38,10)` | `qt_enderecada` | `numeric(15,3)` |
| `qtdesemendereco numeric(38,10)` | `qt_sem_endereco` | `numeric(15,3)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.foperadores_divisao

**Nome proposto:** `ppcp.f_operador_divisao`
**Tipo:** fato
**Descricao:** Numero de operadores por divisao e turno em determinada data.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `data_operadoras timestamp` | `dt_referencia` | `date` |
| `turno_familia int2` | `id_turno_familia` | `smallint` |
| `divisao int4` | `id_divisao` | `integer` |
| `numero_operadoras int2` | `qt_operadores` | `smallint` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordem_producao_leadtime

**Nome proposto:** `ppcp.f_ordem_producao_leadtime`
**Tipo:** fato
**Descricao:** Leadtime de ordens de producao por estagio: entrada, saida e tempo decorrido.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `periodo numeric(38,10)` | `nr_periodo_producao` | `smallint` |
| `ordem_producao numeric(9)` | `nr_ordem_producao` | `integer` |
| `codigo_estagio numeric(5)` | `id_estagio` | `integer` |
| `qtde_produzida numeric(38,10)` | `qt_produzida` | `numeric(15,3)` |
| `data_entrada_fase timestamp` | `dth_entrada_estagio` | `timestamp` |
| `data_saida_fase timestamp` | `dth_saida_estagio` | `timestamp` |
| `lead_time numeric(38,10)` | `nr_lead_time_horas` | `numeric(10,2)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fordens_aproduzir_pacote

**Nome proposto:** `ppcp.f_ordem_a_produzir_pacote`
**Tipo:** fato
**Descricao:** Ordens a produzir em pacote por estagio e cor/tamanho.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `ordem_producao numeric(9)` | `nr_ordem_producao` | `integer` |
| `periodo_producao numeric(4)` | `nr_periodo_producao` | `smallint` |
| `cod_estagio numeric(5)` | `id_estagio` | `integer` |
| `cod_cor text` | `cod_cor` | `varchar(6)` |
| `cod_tam text` | `cod_tamanho` | `varchar(3)` |
| `qtde_pecas_prog numeric(38,10)` | `qt_programada` | `numeric(15,3)` |
| `qtde_a_produzir_pacote numeric(38,10)` | `qt_a_produzir_pacote` | `numeric(15,3)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fprodutividade_operador_marft

**Nome proposto:** `ppcp.f_produtividade_operador`
**Tipo:** fato
**Descricao:** Produtividade de operadores na Marft por celula, turno e data, com coeficientes de premio.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `"data" timestamp` | `dt_referencia` | `date` |
| `codigo_operador numeric(5)` | `id_operador` | `integer` |
| `nome text` | `nm_operador` | `varchar(100)` |
| `cpf text` | `cpf_operador` | `varchar(12)` |
| `codigo_celula numeric(5)` | `id_celula` | `integer` |
| `nome_celula text` | `nm_celula` | `varchar(50)` |
| `turno numeric(3)` | `id_turno` | `smallint` |
| `"percent" numeric(5,4)` | `pc_produtividade` | `numeric(7,4)` |
| `award_coefficient_c numeric(4,2)` | `vl_coef_premio_c` | `numeric(4,2)` |
| `award_coefficient_i numeric(4,2)` | `vl_coef_premio_i` | `numeric(4,2)` |
| `status_marft varchar(25)` | `ds_status` | `varchar(25)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fproducao_seda

**Nome proposto:** `ppcp.f_producao_seda`
**Tipo:** fato
**Descricao:** Producao de seda por turno, operador e pedido.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `turno numeric(38)` | `id_turno` | `smallint` |
| `nome text` | `nm_operador` | `varchar(100)` |
| `pedido numeric(9)` | `nr_pedido` | `integer` |
| `qtdepecas numeric(38,10)` | `qt_pecas` | `numeric(15,3)` |
| `dataleitura timestamp` | `dth_leitura` | `timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fstatus_requisicao_reposicoes

**Nome proposto:** `ppcp.f_status_requisicao_reposicao`
**Tipo:** fato
**Descricao:** Status historico de requisicoes de reposicao.

Segue padrao de `f_aprovacao_requisicao`:
- `ordem_producao int4` → `nr_ordem_producao integer`
- `estagio int4` → `id_estagio integer`
- `periodo int2` → `nr_periodo_producao smallint`
- `situacao int2` → `id_situacao smallint`
- `ultima_atualizacao timestamp` → `updated_at`

---

### ppcp.fsugestao_cancelamento

**Nome proposto:** `ppcp.f_sugestao_cancelamento`
**Tipo:** fato
**Descricao:** Sugestoes de cancelamento de producao por referencia e colecao.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `referencia varchar(5)` | `cod_referencia` | `varchar(5)` |
| `cor varchar(6)` | `cod_cor` | `varchar(6)` |
| `cod_colecao int2` | `id_colecao` | `smallint` |
| `desc_colecao varchar(20)` | `ds_colecao` | `varchar(20)` |
| `id_motivo int8` | `id_motivo` | `integer` |
| `sugcancelproducao varchar(28)` | `ds_sugestao_cancelamento` | `varchar(28)` |
| `desc_motivo varchar(30)` | `ds_motivo` | `varchar(30)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.fsugestao_reserva_tecido

**Nome proposto:** `ppcp.f_sugestao_reserva_tecido`
**Tipo:** fato
**Descricao:** Sugestoes de reserva de tecido para ordens de producao, com consumo programado.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `periodo_producao varchar(8)` | `nr_periodo_producao` | `varchar(8)` |
| `fk_componente varchar(40)` | `sku_tecido` | `varchar(30)` |
| `cd_ordem_producao varchar(25)` | `nr_ordem_producao` | `varchar(25)` |
| `referencia varchar(25)` | `cod_referencia` | `varchar(5)` |
| `cod_cor varchar(25)` | `cod_cor` | `varchar(6)` |
| `consumo_programado varchar(25)` | `qt_consumo_programado` | `numeric(15,3)` (converter de varchar) |
| `mt_lineares_prod numeric(17,2)` | `vl_metros_lineares_prod` | `numeric(15,3)` |
| `pecas_pacote numeric(18,3)` | `qt_pecas_pacote` | `numeric(15,3)` |
| `total_consumo numeric(18,3)` | `qt_consumo_total` | `numeric(15,3)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### ppcp.ftempo_tear

**Nome proposto:** `ppcp.f_tempo_tear`
**Tipo:** fato
**Descricao:** Tempos do roteiro de tear por produto, operacao e maquina com minutos homem e tempo maquina.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pk_produto text` | `cod_produto_legado` | `varchar(25)` |
| `sku_produto text` | `sku_produto` | `varchar(30)` |
| `descr_referencia text` | `ds_referencia` | `varchar(50)` |
| `numero_alternati numeric(2)` | `nr_alternativa` | `smallint` |
| `numero_roteiro numeric(2)` | `nr_roteiro` | `smallint` |
| `seq_operacao numeric(4)` | `nr_seq_operacao` | `smallint` |
| `codigo_estagio numeric(5)` | `id_estagio` | `integer` |
| `codigo_operacao numeric(5)` | `id_operacao` | `integer` |
| `nome_operacao text` | `ds_operacao` | `varchar(50)` |
| `grupo_maquina text` | `ds_grupo_maquina` | `varchar(50)` |
| `minutos_homem numeric(9,4)` | `nr_minutos_homem` | `numeric(9,4)` |
| `tempo_maquina numeric(9,4)` | `nr_tempo_maquina` | `numeric(9,4)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

## Conflitos e Decisoes Pendentes — Schema `ppcp`

1. **`dcad_centro_custo` duplicado em `ppcp` e `live`**: Ambos os schemas tem tabelas de centro de custo quase identicas. Avaliar centralizar em um schema unico (ex: `live.d_centro_custo`) e fazer a outra ser uma view.
2. **`cnpj_forn varchar(184)` em `dcadastro_fornecedores`, `dhomologacao_fornecedores`, `dinfotec_fornecedores`**: CNPJ com 184 chars — claramente errado. Reformatar para `varchar(16)` via `dw.fn_formatar_cnpj_cpf`. Prioridade alta.
3. **`cd_nivel99 float8` em `fordens_corte`**: Nivel do produto como float8 — incorreto; deve ser `varchar(1)`. O ETL deve converter antes de inserir.
4. **`fordens_produzidas.cd_ordem_producao text`**: Tipo text para numero de OP — deve ser `integer`. Verificar se ha dados nao numericos antes de converter.
5. **`flista_prioridades.id float8`**: ID como float8 — deve ser `integer`. Verificar dados.
6. **`fsugestao_reserva_tecido.consumo_programado varchar(25)`**: Campo de consumo como varchar — converter para `numeric(15,3)` no ETL.
7. **`fproducao_seda.turno numeric(38)`**: Tipo absurdo para numero de turno — deve ser `smallint`.
8. **SKU na coluna `fk_produto varchar(125/150/35)`**: Tamanhos variados para o mesmo campo. Padronizar para `sku_produto varchar(30)` em todas as tabelas.
