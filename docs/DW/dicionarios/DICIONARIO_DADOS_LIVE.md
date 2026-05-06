# Dicionario de Dados — Schema `live`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 20 tabelas — dimensoes do canal de varejo: produtos, lojas, clientes, colecoes, calendario
**Responsavel:** Schema live — tabelas mestre do canal de varejo: produto (SKU), lojas, clientes, fornecedores, colecoes, calendario, briefing e referencias

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `live.dbriefing` | `live.d_briefing` | dimensao |
| `live.dcad_centro_custo` | `live.d_centro_custo` | dimensao |
| `live.dcalendario` | `live.d_calendario` | dimensao |
| `live.dcanaldistribuicao` | `live.d_canal_distribuicao` | dimensao |
| `live.dcidades` | `live.d_cidade` | dimensao |
| `live.dcliente` | `live.d_cliente` | dimensao |
| `live.dcliente_fornec_loja` | `live.d_cliente_fornec_loja` | dimensao |
| `live.dcolecoes` | `live.d_colecao` | dimensao |
| `live.dcolecoes_subcolecoes` | `live.d_colecao_subcolecao` | dimensao |
| `live.dconjuntos` | `live.d_conjunto_produto` | dimensao |
| `live.dfornecedor` | `live.d_fornecedor` | dimensao |
| `live.dimg_produtos` | `live.d_imagem_produto` | dimensao |
| `live.dlojas` | `live.d_loja` | dimensao |
| `live.dperiodo_colecoes` | `live.d_periodo_colecao` | dimensao |
| `live.dproduto` | `live.d_produto` | dimensao |
| `live.dproduto_loja` | `live.d_produto_loja` | dimensao |
| `live.dreferencias_mta` | `live.d_referencia_mta` | dimensao |
| `live.dregiao_lojas` | `live.d_regiao_loja` | dimensao |
| `live.dresponsavel_loja` | `live.d_responsavel_loja` | dimensao |
| `live.dshowroom` | `live.d_showroom` | dimensao |

---

## Detalhamento por Tabela

---

### live.dbriefing

**Nome proposto:** `live.d_briefing`
**Tipo:** dimensao
**Descricao:** Briefing de produto por referencia e cor, com atributos comerciais, marketing e producao. Dimensao rica de produto para analise de colecao.
**Sistema de origem:** Sistema de produto/PDM interno

#### Colunas (principais — tabela com ~90 colunas)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| ADD | `id` | `bigserial NOT NULL` | Surrogate key (sem PK) |
| `referencia` | `cod_referencia` | `varchar(6)` | Codigo da referencia — join key com produto |
| `cor_venda` | `cod_cor` | `varchar(6)` | Codigo da cor |
| `ref_cor` | `sku_produto_ref_cor` | `varchar(11)` | Referencia+cor; parte do SKU |
| `desc_colecao` | `ds_colecao` | `varchar(60)` | Descricao da colecao |
| `desc_sub_colecao` | `ds_subcolecao` | `varchar(100)` | Subcolecao |
| `linha_produto` | `ds_linha` | `varchar(40)` | Linha do produto |
| `desc_segmento` | `ds_segmento` | `varchar(62)` | Segmento |
| `pilar` | `ds_pilar` | `varchar(64)` | Pilar de produto |
| `artigo_produto` | `ds_artigo` | `varchar(25)` | Artigo |
| `desc_comercial` | `ds_comercial` | `varchar(100)` | Descricao comercial |
| `desc_tamanhos` | `ds_tamanhos` | `varchar(10)` | Grade de tamanhos |
| `grade` | `ds_grade` | `varchar(700)` | Grade completa |
| `mp_principal` | `cod_mp_principal` | `varchar(20)` | Materia-prima principal |
| `num_sku` | `qt_skus` | `integer` | Numero de SKUs |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| `ano_venda` | `nr_ano_venda` | `integer` | Ano de venda |
| `modalidade` | `ds_modalidade` | `varchar(68)` | Modalidade |
| `fat_plan_fabrica` | `dt_fat_plan_fabrica` | `date` | Data fat planejado fabrica |
| `lancamento_plan_loja` | `dt_lancamento_plan_loja` | `date` | Data lancamento planejado loja |
| `aposta_criacao` | `fl_aposta_criacao` | `boolean` | Flag aposta criacao |
| `estoque_limitado` | `fl_estoque_limitado` | `boolean` | Flag estoque limitado |
| `grade_multipla` | `fl_grade_multipla` | `boolean` | Flag grade multipla |
| `live_run` | `fl_live_run` | `boolean` | Flag live run |
| `acao_varejo` | `fl_acao_varejo` | `boolean` | Flag acao varejo |
| `must_have` | `fl_must_have` | `boolean` | Flag must have |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

> **Nota:** As flags `numeric(1)` (0/1) devem ser convertidas para `boolean` no ETL antes de inserir, ou via `ALTER COLUMN ... TYPE boolean USING col = 1`.

#### Migracao SQL (resumida)

```sql
ALTER TABLE live.dbriefing RENAME TO d_briefing;
ALTER TABLE live.d_briefing ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_briefing ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_briefing RENAME COLUMN referencia TO cod_referencia;
ALTER TABLE live.d_briefing RENAME COLUMN cor_venda TO cod_cor;
ALTER TABLE live.d_briefing RENAME COLUMN ref_cor TO sku_produto_ref_cor;
ALTER TABLE live.d_briefing RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE live.d_briefing ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_briefing ALTER COLUMN updated_at SET DEFAULT current_timestamp;
-- Converter flags numeric(1) para boolean
ALTER TABLE live.d_briefing ALTER COLUMN aposta_criacao TYPE boolean USING (aposta_criacao = 1);
ALTER TABLE live.d_briefing ALTER COLUMN estoque_limitado TYPE boolean USING (estoque_limitado = 1);
ALTER TABLE live.d_briefing ALTER COLUMN grade_multipla TYPE boolean USING (grade_multipla = 1);
ALTER TABLE live.d_briefing ALTER COLUMN live_run TYPE boolean USING (live_run = 1);
ALTER TABLE live.d_briefing ALTER COLUMN acao_varejo TYPE boolean USING (acao_varejo = 1);
ALTER TABLE live.d_briefing ALTER COLUMN must_have TYPE boolean USING (must_have = 1);
ALTER TABLE live.d_briefing ALTER COLUMN nova_cor TYPE boolean USING (nova_cor = 1);
ALTER TABLE live.d_briefing ALTER COLUMN visual_merchandising TYPE boolean USING (visual_merchandising = 1);
ALTER TABLE live.d_briefing ALTER COLUMN promocional TYPE boolean USING (promocional = 1);
ALTER TABLE live.d_briefing ALTER COLUMN neon TYPE boolean USING (neon = 1);
ALTER TABLE live.d_briefing ALTER COLUMN look_book TYPE boolean USING (look_book = 1);
CREATE OR REPLACE VIEW live.dbriefing AS SELECT * FROM live.d_briefing;
COMMENT ON VIEW live.dbriefing IS 'DEPRECATED 2026-05-05: usar d_briefing. Sera removido em 2026-08-03.';
```

---

### live.dcad_centro_custo

**Nome proposto:** `live.d_centro_custo`
**Tipo:** dimensao
**Descricao:** Centros de custo da producao com classificacao (custo/despesa, fixo/variavel, tipo de mao de obra).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `centro_custo` | `int4 NULL` | `id_centro_custo` | `integer` | [RENAME] | Codigo operacional do CC |
| `descricao` | `varchar(20) NULL` | `ds_centro_custo` | `varchar(20)` | [RENAME] | Descricao |
| `divisao_producao` | `int2 NULL` | `id_divisao` | `smallint` | [RENAME] | Divisao de producao |
| `custo_despesa` | `int2 NULL` | `id_tipo_custo` | `smallint` | [RENAME] | Custo ou despesa |
| `fixo_variavel` | `int2 NULL` | `id_tipo_fixo_variavel` | `smallint` | [RENAME] | Fixo ou variavel |
| `tipo_mao_obra` | `int2 NULL` | `id_tipo_mao_obra` | `smallint` | [RENAME] | Tipo de mao de obra |
| `tipo_ccusto` | `int2 NULL` | `id_tipo_ccusto` | `smallint` | [RENAME] | Tipo de CC |
| `situacao` | `int2 NULL` | `id_situacao` | `smallint` | [RENAME] | Situacao |
| `tempo_turno1` / `tempo_turno2` / `tempo_turno3` / `tempo_turno4` | `int2 NULL` | `nr_tempo_turno1` / ...2 / ...3 / ...4 | `smallint` | [RENAME] | Tempo por turno |
| `local_entrega` | `varchar(20) NULL` | `ds_local_entrega` | `varchar(20)` | [RENAME] | Local de entrega |
| `centro_custo_pai` | `int4 NULL` | `id_centro_custo_pai` | `integer` | [RENAME] | CC pai (hierarquia) |
| `data_alteracao` | `timestamp NULL` | `dth_alteracao` | `timestamp` | [RENAME] | Data de alteracao |
| `validar_cc_empresa` | `varchar(1) NULL` | `fl_validar_empresa` | `varchar(1)` | [RENAME] | Flag validacao empresa |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE live.dcad_centro_custo RENAME TO d_centro_custo;
ALTER TABLE live.d_centro_custo ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_centro_custo ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_centro_custo RENAME COLUMN centro_custo TO id_centro_custo;
ALTER TABLE live.d_centro_custo ADD CONSTRAINT uq_d_centro_custo UNIQUE (id_centro_custo);
ALTER TABLE live.d_centro_custo RENAME COLUMN descricao TO ds_centro_custo;
ALTER TABLE live.d_centro_custo RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE live.d_centro_custo ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_centro_custo ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dcad_centro_custo AS SELECT * FROM live.d_centro_custo;
COMMENT ON VIEW live.dcad_centro_custo IS 'DEPRECATED 2026-05-05: usar d_centro_custo. Sera removido em 2026-08-03.';
```

---

### live.dcalendario

**Nome proposto:** `live.d_calendario`
**Tipo:** dimensao
**Descricao:** Calendario com atributos de data: ano, mes, semana, dia util, dia util financeiro. Dimensao de data do DW.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `data` | `date NULL` | `dt_data` | `date NOT NULL` | [RENAME] | Chave natural; remover aspas |
| `ano` | `int4 NULL` | `nr_ano` | `smallint` | [RENAME] [RETYPE] | Ano |
| `mes` | `int4 NULL` | `nr_mes` | `smallint` | [RENAME] [RETYPE] | Mes (1-12) |
| `nummesano` | `varchar(20) NULL` | `ds_mes_ano_num` | `varchar(20)` | [RENAME] | Ex: "012026" |
| `mes_ano` | `varchar(20) NULL` | `ds_mes_ano` | `varchar(20)` | [RENAME] | Ex: "Jan/2026" |
| `nm_mes` | `varchar(20) NULL` | `nm_mes` | `varchar(20)` | OK | Nome do mes |
| `abrev_mes` | `varchar(20) NULL` | `ds_abrev_mes` | `varchar(5)` | [RENAME] [RETYPE] | Abreviacao (Jan, Fev...) |
| `dia` | `int4 NULL` | `nr_dia` | `smallint` | [RENAME] [RETYPE] | Dia do mes |
| `nm_dia` | `varchar(20) NULL` | `nm_dia_semana` | `varchar(20)` | [RENAME] | Nome do dia |
| `abrev_dia` | `varchar(20) NULL` | `ds_abrev_dia` | `varchar(5)` | [RENAME] [RETYPE] | Abreviacao (Seg, Ter...) |
| `nr_dia_semana` | `int4 NULL` | `nr_dia_semana` | `smallint` | [RETYPE] | 1=Dom, 7=Sab |
| `numero_semana` | `int4 NULL` | `nr_semana` | `smallint` | [RENAME] [RETYPE] | Semana do ano |
| `semana_ano_tabela` | `varchar(30) NULL` | `ds_semana_ano` | `varchar(30)` | [RENAME] | Ex: "Sem 01/2026" |
| `dia_do_ano` | `int4 NULL` | `nr_dia_do_ano` | `smallint` | [RENAME] [RETYPE] | Dia do ano (1-366) |
| `dia_semana` | `int4 NULL` | `nr_posicao_semana` | `smallint` | [RENAME] [RETYPE] | Posicao na semana |
| `dia_util` | `int4 NULL` | `fl_dia_util` | `boolean` | [RENAME] [RETYPE] | Flag dia util; converter int para boolean |
| `dia_util_finan` | `int4 NULL` | `fl_dia_util_financeiro` | `boolean` | [RENAME] [RETYPE] | Flag dia util financeiro |
| `ultima_atualizacao` | `date NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] [RETYPE] | Auditoria; `date` → `timestamp` |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_calendario UNIQUE (dt_data)
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_d_calendario_data ON live.d_calendario (dt_data);
CREATE INDEX idx_d_calendario_ano_mes ON live.d_calendario (nr_ano, nr_mes);
CREATE INDEX idx_d_calendario_fl_util ON live.d_calendario (fl_dia_util);
```

#### Migracao SQL

```sql
ALTER TABLE live.dcalendario RENAME TO d_calendario;
ALTER TABLE live.d_calendario ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_calendario ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_calendario RENAME COLUMN "data" TO dt_data;
ALTER TABLE live.d_calendario ADD CONSTRAINT uq_d_calendario UNIQUE (dt_data);
ALTER TABLE live.d_calendario RENAME COLUMN ano TO nr_ano;
ALTER TABLE live.d_calendario ALTER COLUMN nr_ano TYPE smallint;
ALTER TABLE live.d_calendario RENAME COLUMN mes TO nr_mes;
ALTER TABLE live.d_calendario ALTER COLUMN nr_mes TYPE smallint;
ALTER TABLE live.d_calendario RENAME COLUMN dia TO nr_dia;
ALTER TABLE live.d_calendario ALTER COLUMN nr_dia TYPE smallint;
ALTER TABLE live.d_calendario RENAME COLUMN dia_util TO fl_dia_util;
ALTER TABLE live.d_calendario ALTER COLUMN fl_dia_util TYPE boolean USING (dia_util = 1);
ALTER TABLE live.d_calendario RENAME COLUMN dia_util_finan TO fl_dia_util_financeiro;
ALTER TABLE live.d_calendario ALTER COLUMN fl_dia_util_financeiro TYPE boolean USING (dia_util_finan = 1);
ALTER TABLE live.d_calendario RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE live.d_calendario ALTER COLUMN updated_at TYPE timestamp USING updated_at::timestamp;
ALTER TABLE live.d_calendario ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_calendario ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dcalendario AS SELECT * FROM live.d_calendario;
COMMENT ON VIEW live.dcalendario IS 'DEPRECATED 2026-05-05: usar d_calendario. Sera removido em 2026-08-03.';
```

---

### live.dcanaldistribuicao

**Nome proposto:** `live.d_canal_distribuicao`
**Tipo:** dimensao
**Descricao:** Canal de distribuicao (atacado, varejo, e-commerce, etc.) com modalidade.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key (a coluna `id` existente vira `id_canal`) |
| `id` | `int4 NULL` | `id_canal` | `integer` | [RENAME] | Codigo operacional do canal |
| `descricao` | `varchar(100) NULL` | `ds_canal` | `varchar(100)` | [RENAME] | Descricao |
| `modalidade` | `varchar(50) NULL` | `ds_modalidade` | `varchar(50)` | [RENAME] | Modalidade de venda |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE live.dcanaldistribuicao RENAME TO d_canal_distribuicao;
ALTER TABLE live.d_canal_distribuicao RENAME COLUMN id TO id_canal;
ALTER TABLE live.d_canal_distribuicao ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_canal_distribuicao ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_canal_distribuicao ADD CONSTRAINT uq_d_canal UNIQUE (id_canal);
ALTER TABLE live.d_canal_distribuicao RENAME COLUMN descricao TO ds_canal;
ALTER TABLE live.d_canal_distribuicao RENAME COLUMN modalidade TO ds_modalidade;
ALTER TABLE live.d_canal_distribuicao RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_canal_distribuicao ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_canal_distribuicao ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dcanaldistribuicao AS SELECT * FROM live.d_canal_distribuicao;
COMMENT ON VIEW live.dcanaldistribuicao IS 'DEPRECATED 2026-05-05: usar d_canal_distribuicao. Sera removido em 2026-08-03.';
```

---

### live.dcidades

**Nome proposto:** `live.d_cidade`
**Tipo:** dimensao
**Descricao:** Cadastro de cidades com UF, DDD, pais, IBGE e sub-regiao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cod_cidade` | `varchar(5) NULL` | `cod_cidade` | `varchar(5)` | OK | Business key da cidade — manter nome |
| `nm_cidade` | `varchar(60) NULL` | `nm_cidade` | `varchar(60)` | OK | Nome da cidade |
| `uf` | `varchar(2) NULL` | `ds_uf` | `char(2)` | [RENAME] [RETYPE] | UF; usar `char(2)` |
| `ddd` | `int2 NULL` | `nr_ddd` | `smallint` | [RENAME] | DDD |
| `cod_pais` | `int2 NULL` | `id_pais` | `smallint` | [RENAME] | Codigo do pais |
| `cod_fiscal` | `int4 NULL` | `id_cod_fiscal` | `integer` | [RENAME] | Codigo fiscal |
| `cod_reg_mer_ex` | `int2 NULL` | `id_regiao_mercado_ext` | `smallint` | [RENAME] | Regiao de mercado externo |
| `populacao` | `int4 NULL` | `qt_populacao` | `integer` | [RENAME] | Populacao |
| `cod_cidade_zona_franca` | `int4 NULL` | `id_cidade_zona_franca` | `integer` | [RENAME] | Zona franca |
| `cod_cidade_ibge` | `int4 NULL` | `id_ibge` | `integer` | [RENAME] | Codigo IBGE |
| `cod_sub_regiao` | `int2 NULL` | `id_sub_regiao` | `smallint` | [RENAME] | Sub-regiao |
| `sub_regiao` | `varchar(40) NULL` | `ds_sub_regiao` | `varchar(40)` | [RENAME] | Descricao sub-regiao |
| `cod_suframa` | `int2 NULL` | `id_suframa` | `smallint` | [RENAME] | Codigo SUFRAMA |
| `cep` | `int4 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP; usar `char(8)` |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `nm_pais` | `varchar(30) NULL` | `nm_pais` | `varchar(30)` | OK | Nome do pais |
| `estado_extenso` | `varchar(30) NULL` | `nm_estado` | `varchar(30)` | [RENAME] | Nome do estado por extenso |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE live.dcidades RENAME TO d_cidade;
ALTER TABLE live.d_cidade ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_cidade ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_cidade ADD CONSTRAINT uq_d_cidade UNIQUE (cod_cidade);
ALTER TABLE live.d_cidade RENAME COLUMN uf TO ds_uf;
ALTER TABLE live.d_cidade ALTER COLUMN ds_uf TYPE char(2);
ALTER TABLE live.d_cidade RENAME COLUMN ddd TO nr_ddd;
ALTER TABLE live.d_cidade RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_cidade ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_cidade ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dcidades AS SELECT * FROM live.d_cidade;
COMMENT ON VIEW live.dcidades IS 'DEPRECATED 2026-05-05: usar d_cidade. Sera removido em 2026-08-03.';
```

---

### live.dcliente

**Nome proposto:** `live.d_cliente`
**Tipo:** dimensao
**Descricao:** Dimensao de clientes do canal de varejo com atributos de identificacao, localizacao, representante e historico de compras.
**Sistema de origem:** Systextil / CIGAM

> Esta e a dimensao principal de cliente. O campo `pk_cliente` e o business key (join key universal) que deve ser renomeado para `cod_cliente`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_cliente` | `varchar(16) NULL` | `cod_cliente` | `varchar(20) NOT NULL` | [RENAME] [RETYPE] | **Business key — join key universal** em todo o DW; aumentar para varchar(20) padrao |
| `cod_empresa` | `int2 NULL` | `id_empresa` | `smallint` | [RENAME] | Codigo da empresa |
| `nm_cliente` | `varchar(70) NULL` | `nm_cliente` | `varchar(70)` | OK | Nome do cliente |
| `nm_fantasia` | `varchar(70) NULL` | `nm_fantasia` | `varchar(70)` | OK | Nome fantasia |
| `fone_cliente` | `int4 NULL` | `nr_telefone` | `varchar(15)` | [RENAME] [RETYPE] | Telefone; usar varchar para suportar formatacao |
| `uf_cliente` | `varchar(2) NULL` | `end_uf` | `char(2)` | [RENAME] [RETYPE] | UF; usar prefixo `end_` |
| `cep` | `int4 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP; `char(8)` |
| `cidade` | `varchar(70) NULL` | `end_cidade` | `varchar(60)` | [RENAME] [RETYPE] | Cidade |
| `endereco` | `varchar(70) NULL` | `end_logradouro` | `varchar(70)` | [RENAME] | Logradouro |
| `bairro` | `varchar(20) NULL` | `end_bairro` | `varchar(30)` | [RENAME] [RETYPE] | Bairro |
| `dt_cadastro` | `timestamp NULL` | `dt_cadastro` | `date` | [RETYPE] | Data de cadastro; `date` (sem hora) |
| `cod_representante` | `int2 NULL` | `cod_representante` | `varchar(6)` | [RETYPE] | **Business key do representante** — deve ter mesmo tipo que `drepresentante.pk_representante` |
| `nm_representante` | `varchar(50) NULL` | `nm_representante` | `varchar(50)` | OK | Nome |
| `nm_subregiao_cliente` | `varchar(20) NULL` | `ds_sub_regiao` | `varchar(20)` | [RENAME] | Sub-regiao |
| `tipo_cliente` | `varchar(70) NULL` | `ds_tipo_cliente` | `varchar(70)` | [RENAME] | Tipo de cliente |
| `tipo_cliente_agrupamento` | `varchar(60) NULL` | `ds_agrupamento_cliente` | `varchar(60)` | [RENAME] | Agrupamento |
| `dt_ult_compra` | `timestamp NULL` | `dt_ultima_compra` | `date` | [RENAME] [RETYPE] | Data ultima compra |
| `vlr_ult_compra` | `numeric(18,3) NULL` | `vl_ultima_compra` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor ultima compra |
| `prazo_medio` | `numeric(9,3) NULL` | `nr_prazo_medio_dias` | `numeric(6,1)` | [RENAME] [RETYPE] | Prazo medio de pagamento |
| `dt_ultima_fatura` | `timestamp NULL` | `dt_ultima_fatura` | `date` | [RETYPE] | Ultima fatura |
| `email_cliente` | `varchar(100) NULL` | `nm_email` | `varchar(100)` | [RENAME] | Email |
| `grupo_economico` | `varchar(60) NULL` | `ds_grupo_economico` | `varchar(60)` | [RENAME] | Grupo economico |
| `cd_grupo_economico` | `int4 NULL` | `id_grupo_economico` | `integer` | [RENAME] | ID grupo economico |
| `situacao_cliente` | `varchar(7) NULL` | `ds_situacao` | `varchar(10)` | [RENAME] [RETYPE] | Situacao do cliente |
| `conceito_cliente` | `varchar(20) NULL` | `ds_conceito` | `varchar(20)` | [RENAME] | Conceito |
| `modalidade_cliente` | `varchar(30) NULL` | `ds_modalidade` | `varchar(30)` | [RENAME] | Modalidade |
| `pais_cliente` | `varchar(25) NULL` | `end_pais` | `varchar(30)` | [RENAME] [RETYPE] | Pais |
| `regiao_cliente` | `varchar(20) NULL` | `ds_regiao` | `varchar(20)` | [RENAME] | Regiao |
| `cod_cidade` | `int4 NULL` | `cod_cidade` | `varchar(5)` | [RETYPE] | Business key da cidade — mesmo tipo que `d_cidade.cod_cidade` |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `cnpj_cliente` | `varchar(120) NULL` | `cnpj_cliente` | `varchar(16)` | [RETYPE] | CNPJ formato DW `XXXXXXXX/YYYY-ZZ`; `varchar(120)` inadequado |
| ADD | — | `tp_documento_cliente` | `varchar(4)` | [ADD] | 'CPF' ou 'CNPJ' — derivado do formato |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_cliente UNIQUE (cod_cliente)
```

#### Relacionamentos propostos

```
live.d_cliente
  <- comercial.fpedido.fk_cliente      (cod_cliente)
  <- jma.ffaturamento.pk_cliente       (cod_cliente)
  <- comercial.fnotas_venda_produtos.pk_cliente (cod_cliente)
  |- cod_cidade -> live.d_cidade.cod_cidade
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX uq_d_cliente ON live.d_cliente (cod_cliente);
CREATE INDEX idx_d_cliente_representante ON live.d_cliente (cod_representante);
CREATE INDEX idx_d_cliente_uf ON live.d_cliente (end_uf);
```

#### Impacto no ETL

- `fk_cliente` em todas as tabelas fato deve ser renomeado para `cod_cliente` e ter mesmo tipo `varchar(20)`.
- `pk_cliente` de origem Systextil deve ser normalizado para `cod_cliente`.
- `cnpj_cliente` deve ser formatado pela funcao `dw.fn_formatar_cnpj_cpf` antes de inserir.

#### Migracao SQL (principais)

```sql
ALTER TABLE live.dcliente RENAME TO d_cliente;
ALTER TABLE live.d_cliente ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_cliente ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_cliente ADD COLUMN tp_documento_cliente varchar(4);
ALTER TABLE live.d_cliente RENAME COLUMN pk_cliente TO cod_cliente;
ALTER TABLE live.d_cliente ALTER COLUMN cod_cliente TYPE varchar(20);
ALTER TABLE live.d_cliente ADD CONSTRAINT uq_d_cliente UNIQUE (cod_cliente);
ALTER TABLE live.d_cliente RENAME COLUMN cod_empresa TO id_empresa;
ALTER TABLE live.d_cliente ALTER COLUMN cod_representante TYPE varchar(6);
ALTER TABLE live.d_cliente RENAME COLUMN dt_cadastro TO dt_cadastro_ts;
ALTER TABLE live.d_cliente ADD COLUMN dt_cadastro date;
UPDATE live.d_cliente SET dt_cadastro = dt_cadastro_ts::date;
ALTER TABLE live.d_cliente DROP COLUMN dt_cadastro_ts;
ALTER TABLE live.d_cliente RENAME COLUMN cnpj_cliente TO cnpj_cliente_orig;
-- Reformatar CNPJ usando fn_formatar_cnpj_cpf antes de inserir nova coluna
ALTER TABLE live.d_cliente ADD COLUMN cnpj_cliente varchar(16);
ALTER TABLE live.d_cliente RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_cliente ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_cliente ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dcliente AS SELECT * FROM live.d_cliente;
COMMENT ON VIEW live.dcliente IS 'DEPRECATED 2026-05-05: usar d_cliente. Sera removido em 2026-08-03.';
```

---

### live.dcliente_fornec_loja

**Nome proposto:** `live.d_cliente_fornec_loja`
**Tipo:** dimensao
**Descricao:** Clientes e fornecedores do canal de loja (CIGAM). Cadastro simplificado para o sistema de PDV.
**Sistema de origem:** CIGAM (sistema PDV de lojas)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_cliente_fornec` | `varchar(21) NULL` | `cod_cliente_fornec` | `varchar(21)` | [RENAME] | Business key do cliente/fornecedor na loja |
| `nome_cliente` | `varchar(60) NULL` | `nm_cliente` | `varchar(60)` | [RENAME] | Nome |
| `razao_cliente` | `varchar(60) NULL` | `nm_razao_social` | `varchar(60)` | [RENAME] | Razao social |
| `tipo_cliente` | `varchar(1) NULL` | `ds_tipo_cliente` | `varchar(1)` | [RENAME] | Tipo (F/J) |
| `endereco` | `varchar(250) NULL` | `end_logradouro` | `varchar(250)` | [RENAME] | Logradouro |
| `pais` | `varchar(80) NULL` | `end_pais` | `varchar(80)` | [RENAME] | Pais |
| `fone_cliente` | `varchar(20) NULL` | `nr_telefone` | `varchar(20)` | [RENAME] | Telefone |
| `email_cliente` | `varchar(50) NULL` | `nm_email` | `varchar(50)` | [RENAME] | Email |
| `sexo` | `varchar(1) NULL` | `ds_sexo` | `varchar(1)` | [RENAME] | Sexo |
| `dt_cadastro` | `timestamp NULL` | `dt_cadastro` | `date` | [RETYPE] | Data cadastro |
| `ativo` | `varchar(1) NULL` | `fl_ativo` | `boolean` | [RENAME] [RETYPE] | Converter 'S'/'N' para boolean |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE live.dcliente_fornec_loja RENAME TO d_cliente_fornec_loja;
ALTER TABLE live.d_cliente_fornec_loja ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_cliente_fornec_loja ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_cliente_fornec_loja RENAME COLUMN pk_cliente_fornec TO cod_cliente_fornec;
ALTER TABLE live.d_cliente_fornec_loja ADD CONSTRAINT uq_d_cliente_fornec_loja UNIQUE (cod_cliente_fornec);
ALTER TABLE live.d_cliente_fornec_loja RENAME COLUMN nome_cliente TO nm_cliente;
ALTER TABLE live.d_cliente_fornec_loja RENAME COLUMN razao_cliente TO nm_razao_social;
ALTER TABLE live.d_cliente_fornec_loja RENAME COLUMN ativo TO fl_ativo;
ALTER TABLE live.d_cliente_fornec_loja ALTER COLUMN fl_ativo TYPE boolean USING (ativo = 'S');
ALTER TABLE live.d_cliente_fornec_loja RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_cliente_fornec_loja ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_cliente_fornec_loja ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dcliente_fornec_loja AS SELECT * FROM live.d_cliente_fornec_loja;
COMMENT ON VIEW live.dcliente_fornec_loja IS 'DEPRECATED 2026-05-05: usar d_cliente_fornec_loja. Sera removido em 2026-08-03.';
```

---

### live.dcolecoes

**Nome proposto:** `live.d_colecao`
**Tipo:** dimensao
**Descricao:** Colecoes de produto (estacoes comerciais) com sigla.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cod_colecao` | `numeric(3) NULL` | `id_colecao` | `smallint` | [RENAME] [RETYPE] | Codigo da colecao; `id_` pois nao ha dimensao separada |
| `desc_colecao` | `text NULL` | `ds_colecao` | `varchar(50)` | [RENAME] [RETYPE] | Descricao |
| `sigla_colecao` | `text NULL` | `ds_sigla` | `varchar(10)` | [RENAME] [RETYPE] | Sigla |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE live.dcolecoes RENAME TO d_colecao;
ALTER TABLE live.d_colecao ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_colecao ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_colecao ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_colecao RENAME COLUMN cod_colecao TO id_colecao;
ALTER TABLE live.d_colecao ALTER COLUMN id_colecao TYPE smallint;
ALTER TABLE live.d_colecao ADD CONSTRAINT uq_d_colecao UNIQUE (id_colecao);
ALTER TABLE live.d_colecao RENAME COLUMN desc_colecao TO ds_colecao;
ALTER TABLE live.d_colecao ALTER COLUMN ds_colecao TYPE varchar(50);
ALTER TABLE live.d_colecao RENAME COLUMN sigla_colecao TO ds_sigla;
ALTER TABLE live.d_colecao ALTER COLUMN ds_sigla TYPE varchar(10);
CREATE OR REPLACE VIEW live.dcolecoes AS SELECT * FROM live.d_colecao;
COMMENT ON VIEW live.dcolecoes IS 'DEPRECATED 2026-05-05: usar d_colecao. Sera removido em 2026-08-03.';
```

---

### live.dcolecoes_subcolecoes

**Nome proposto:** `live.d_colecao_subcolecao`
**Tipo:** dimensao
**Descricao:** Relacao entre colecoes e subcolecoes por referencia de produto.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `referencia` | `text NULL` | `cod_referencia` | `varchar(5)` | [RENAME] [RETYPE] | Referencia do produto |
| `colecao` | `numeric(3) NULL` | `id_colecao` | `smallint` | [RENAME] [RETYPE] | Colecao |
| `desc_colecao` | `text NULL` | `ds_colecao` | `varchar(50)` | [RENAME] [RETYPE] | Descricao |
| `cod_subcolecao` | `numeric(38,10) NULL` | `id_subcolecao` | `smallint` | [RENAME] [RETYPE] | Subcolecao; `numeric(38,10)` inadequado |
| `desc_sub_colecao` | `text NULL` | `ds_subcolecao` | `varchar(50)` | [RENAME] [RETYPE] | Descricao |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dconjuntos

**Nome proposto:** `live.d_conjunto_produto`
**Tipo:** dimensao
**Descricao:** Conjuntos de produtos (A+B) que formam composicoes de looks, por empresa e par de referencias+cores.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cod_empresa` | `int2 NULL` | `id_empresa` | `smallint` | [RENAME] | Empresa |
| `cor_ref_a` | `varchar(6) NULL` | `cod_cor_a` | `varchar(6)` | [RENAME] | Cor da referencia A |
| `cor_ref_b` | `varchar(6) NULL` | `cod_cor_b` | `varchar(6)` | [RENAME] | Cor da referencia B |
| `referencia_a` | `varchar(5) NULL` | `cod_referencia_a` | `varchar(5)` | [RENAME] | Referencia A |
| `referencia_b` | `varchar(5) NULL` | `cod_referencia_b` | `varchar(5)` | [RENAME] | Referencia B |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dfornecedor

**Nome proposto:** `live.d_fornecedor`
**Tipo:** dimensao
**Descricao:** Fornecedores do canal de varejo com contato, endereco e situacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_fornecedor` | `varchar(25) NULL` | `cod_fornecedor` | `varchar(20) NOT NULL` | [RENAME] [RETYPE] | **Business key** do fornecedor — join key universal |
| `nm_fornecedor` | `varchar(60) NULL` | `nm_fornecedor` | `varchar(60)` | OK | Nome |
| `cd_situacao_fornecedor` | `int2 NULL` | `id_situacao` | `smallint` | [RENAME] | Situacao |
| `telefone_fornecedor` | `int4 NULL` | `nr_telefone` | `varchar(15)` | [RENAME] [RETYPE] | Telefone |
| `cep_fornecedor` | `int4 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP |
| `endereco_fornecedor` | `varchar(80) NULL` | `end_logradouro` | `varchar(80)` | [RENAME] | Logradouro |
| `nr_endereco` | `varchar(25) NULL` | `end_numero` | `varchar(10)` | [RENAME] [RETYPE] | Numero |
| `bairro_fornecedor` | `varchar(40) NULL` | `end_bairro` | `varchar(40)` | [RENAME] | Bairro |
| `cidade_fornecedor` | `varchar(60) NULL` | `end_cidade` | `varchar(60)` | [RENAME] | Cidade |
| `uf_fornecedor` | `varchar(2) NULL` | `end_uf` | `char(2)` | [RENAME] [RETYPE] | UF |
| `dt_cadastro_fornecedor` | `timestamp NULL` | `dt_cadastro` | `date` | [RENAME] [RETYPE] | Data cadastro |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `nm_fantasia` | `varchar(80) NULL` | `nm_fantasia` | `varchar(80)` | OK | Nome fantasia |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE live.dfornecedor RENAME TO d_fornecedor;
ALTER TABLE live.d_fornecedor ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_fornecedor ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_fornecedor RENAME COLUMN pk_fornecedor TO cod_fornecedor;
ALTER TABLE live.d_fornecedor ALTER COLUMN cod_fornecedor TYPE varchar(20);
ALTER TABLE live.d_fornecedor ADD CONSTRAINT uq_d_fornecedor UNIQUE (cod_fornecedor);
ALTER TABLE live.d_fornecedor RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_fornecedor ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_fornecedor ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dfornecedor AS SELECT * FROM live.d_fornecedor;
COMMENT ON VIEW live.dfornecedor IS 'DEPRECATED 2026-05-05: usar d_fornecedor. Sera removido em 2026-08-03.';
```

---

### live.dimg_produtos

**Nome proposto:** `live.d_imagem_produto`
**Tipo:** dimensao
**Descricao:** URLs e imagens (base64) de produtos por referencia e cor. Tabela de imagens do catalogo.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `id_produto` | `varchar(20) NULL` | `sku_produto` | `varchar(30)` | [RENAME] [RETYPE] | SKU do produto |
| `referencia` | `varchar(20) NULL` | `cod_referencia` | `varchar(5)` | [RENAME] [RETYPE] | Referencia |
| `cor` | `varchar(20) NULL` | `cod_cor` | `varchar(6)` | [RENAME] [RETYPE] | Cor |
| `seq_imagem` | `int8 NULL` | `nr_seq_imagem` | `integer` | [RENAME] [RETYPE] | Sequencia da imagem |
| `imagem_url` | `varchar(3000) NULL` | `ds_url_imagem` | `varchar(3000)` | [RENAME] | URL da imagem |
| `imagem_base64` | `text NULL` | `ds_imagem_base64` | `text` | [RENAME] | Imagem em base64 |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dlojas

**Nome proposto:** `live.d_loja`
**Tipo:** dimensao
**Descricao:** Dimensao de lojas fisicas e virtuais com CNPJ, localizacao, rede, regiao e atributos operacionais.
**Sistema de origem:** CIGAM (PDV) + cadastro interno

> Esta e a dimensao principal de loja. O campo `pk_loja` (int4) deve ser renomeado para `id_loja` (codigo interno). `pk_cnpj` deve virar `cnpj_loja`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key DW |
| `pk_loja` | `int4 NULL` | `id_loja` | `integer NOT NULL` | [RENAME] | Business key da loja (int) — join key |
| `desc_loja` | `varchar(200) NULL` | `ds_loja` | `varchar(200)` | [RENAME] | Descricao |
| `desc_apelido` | `varchar(200) NULL` | `nm_apelido` | `varchar(100)` | [RENAME] [RETYPE] | Apelido |
| `desc_razao_social` | `varchar(200) NULL` | `nm_razao_social` | `varchar(200)` | [RENAME] | Razao social |
| `pk_cnpj` | `varchar(35) NULL` | `cnpj_loja` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ no formato DW |
| `cod_inscricao_estadual` | `varchar(20) NULL` | `ds_inscricao_estadual` | `varchar(20)` | [RENAME] | IE |
| `cod_funcionario` | `int4 NULL` | `id_responsavel` | `integer` | [RENAME] | Responsavel pela loja |
| `cep` | `int4 NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP |
| `desc_endereco` | `varchar(200) NULL` | `end_logradouro` | `varchar(200)` | [RENAME] | Logradouro |
| `telefone` | `int8 NULL` | `nr_telefone` | `varchar(15)` | [RENAME] [RETYPE] | Telefone |
| `cod_portal` | `varchar(20) NULL` | `cod_portal` | `varchar(20)` | OK | Codigo portal |
| `pk_portal` | `int4 NULL` | `id_portal` | `integer` | [RENAME] | ID portal CIGAM |
| `dt_inauguracao` | `timestamp NULL` | `dt_inauguracao` | `date` | [RETYPE] | Data inauguracao |
| `metragem` | `numeric(7,2) NULL` | `vl_metragem` | `numeric(7,2)` | [RENAME] | Metragem em m² |
| `cod_regiao` | `int4 NULL` | `id_regiao` | `integer` | [RENAME] | Regiao |
| `cod_usuario` | `int4 NULL` | `id_usuario` | `integer` | [RENAME] | Usuario responsavel |
| `flag_abre_aos_domingos` | `int2 NULL` | `fl_abre_domingo` | `boolean` | [RENAME] [RETYPE] | Flag domingo |
| `omny_channel` | `int2 NULL` | `fl_omnichannel` | `boolean` | [RENAME] [RETYPE] | Flag omnichannel |
| `cod_rede` | `int4 NULL` | `id_rede` | `integer` | [RENAME] | Rede da loja |
| `porc_franchising` | `numeric(7,2) NULL` | `pc_franchising` | `numeric(7,4)` | [RENAME] [RETYPE] | Percentual franchising |
| `ponto_retirada` | `int2 NULL` | `fl_ponto_retirada` | `boolean` | [RENAME] [RETYPE] | Flag ponto de retirada |
| `cupom_desconto_loja` | `varchar(20) NULL` | `ds_cupom_desconto` | `varchar(20)` | [RENAME] | Cupom |
| `dt_cadastro` | `timestamp NULL` | `dt_cadastro` | `date` | [RETYPE] | Data cadastro |
| `dt_ult_alteracao` | `timestamp NULL` | `dth_ultima_alteracao` | `timestamp` | [RENAME] | Ultima alteracao |
| `cod_cidade` | `int4 NULL` | `cod_cidade` | `varchar(5)` | [RETYPE] | Business key da cidade — mesmo tipo que `d_cidade` |
| `cidade` | `varchar(40) NULL` | `nm_cidade` | `varchar(60)` | [RENAME] [RETYPE] | Nome da cidade |
| `estado` | `varchar(2) NULL` | `ds_uf` | `char(2)` | [RENAME] [RETYPE] | UF |
| `regiao` | `varchar(100) NULL` | `ds_regiao` | `varchar(100)` | [RENAME] | Descricao da regiao |
| `rede` | `varchar(50) NULL` | `nm_rede` | `varchar(50)` | [RENAME] | Nome da rede |
| `situacao` | `varchar(7) NULL` | `ds_situacao` | `varchar(10)` | [RENAME] [RETYPE] | Situacao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_loja UNIQUE (id_loja)
```

#### Relacionamentos propostos

```
live.d_loja
  <- jma.fmovimentos_loja.fk_loja (id_loja)
  <- jma.fdre_lojas.cnpj_loja     (cnpj_loja)
```

#### Migracao SQL (principais)

```sql
ALTER TABLE live.dlojas RENAME TO d_loja;
ALTER TABLE live.d_loja ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_loja ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_loja RENAME COLUMN pk_loja TO id_loja;
ALTER TABLE live.d_loja ADD CONSTRAINT uq_d_loja UNIQUE (id_loja);
ALTER TABLE live.d_loja RENAME COLUMN desc_loja TO ds_loja;
ALTER TABLE live.d_loja RENAME COLUMN desc_apelido TO nm_apelido;
ALTER TABLE live.d_loja RENAME COLUMN desc_razao_social TO nm_razao_social;
ALTER TABLE live.d_loja RENAME COLUMN pk_cnpj TO cnpj_loja_orig;
ALTER TABLE live.d_loja ADD COLUMN cnpj_loja varchar(16);
-- Reformatar CNPJ para padrao DW
ALTER TABLE live.d_loja RENAME COLUMN flag_abre_aos_domingos TO fl_abre_domingo;
ALTER TABLE live.d_loja ALTER COLUMN fl_abre_domingo TYPE boolean USING (flag_abre_aos_domingos = 1);
ALTER TABLE live.d_loja RENAME COLUMN omny_channel TO fl_omnichannel;
ALTER TABLE live.d_loja ALTER COLUMN fl_omnichannel TYPE boolean USING (omny_channel = 1);
ALTER TABLE live.d_loja RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_loja ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_loja ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dlojas AS SELECT * FROM live.d_loja;
COMMENT ON VIEW live.dlojas IS 'DEPRECATED 2026-05-05: usar d_loja. Sera removido em 2026-08-03.';
```

---

### live.dperiodo_colecoes

**Nome proposto:** `live.d_periodo_colecao`
**Tipo:** dimensao
**Descricao:** Periodos de cada colecao (sell-in, sell-out, producao) com classificacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id_periodo` | Manter `id` existente como PK se possivel; ou `bigserial` | [ADD] | |
| `id` | `int4 NULL` | `id` | `bigserial` (promover) | [RETYPE] | PK |
| `colecao` | `int2 NULL` | `id_colecao` | `smallint` | [RENAME] | Colecao |
| `descr_colecao` | `varchar(20) NULL` | `ds_colecao` | `varchar(20)` | [RENAME] | Descricao |
| `subcolecao` | `int2 NULL` | `id_subcolecao` | `smallint` | [RENAME] | Subcolecao |
| `descr_sub_colecao` | `varchar(20) NULL` | `ds_subcolecao` | `varchar(20)` | [RENAME] | Descricao |
| `classificacao` | `int2 NULL` | `id_classificacao` | `smallint` | [RENAME] | Classificacao |
| `descr_classificacao` | `varchar(6) NULL` | `ds_classificacao` | `varchar(6)` | [RENAME] | Descricao |
| `data_inicio_sell_in` | `timestamp NULL` | `dt_inicio_sell_in` | `date` | [RENAME] [RETYPE] | Inicio sell-in |
| `data_fim_sell_in` | `timestamp NULL` | `dt_fim_sell_in` | `date` | [RENAME] [RETYPE] | Fim sell-in |
| `data_inicio_sell_out` | `timestamp NULL` | `dt_inicio_sell_out` | `date` | [RENAME] [RETYPE] | Inicio sell-out |
| `data_fim_sell_out` | `timestamp NULL` | `dt_fim_sell_out` | `date` | [RENAME] [RETYPE] | Fim sell-out |
| `data_inicio_producao` | `timestamp NULL` | `dt_inicio_producao` | `date` | [RENAME] [RETYPE] | Inicio producao |
| `data_fim_producao` | `timestamp NULL` | `dt_fim_producao` | `date` | [RENAME] [RETYPE] | Fim producao |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dproduto

**Nome proposto:** `live.d_produto`
**Tipo:** dimensao
**Descricao:** Dimensao principal de produto do DW: SKU completo (referencia.tamanho.cor) com todos os atributos de produto do Systextil/CIGAM.
**Sistema de origem:** Systextil + CIGAM

> `pk_produto` e o identificador composto legado. A coluna `sku_produto` ja existe como varchar(120) — deve ser o business key canonico no formato `nivel.referencia.tamanho.cor`.

#### Colunas (principais)

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_produto` | `varchar(25) NULL` | `cod_produto_legado` | `varchar(25)` | [RENAME] | Manter legado para compatibilidade |
| `sku_produto` | `varchar(120) NULL` | `sku_produto` | `varchar(30) NOT NULL` | [RETYPE] | **Business key canonical** — join key universal; corrigir tamanho para varchar(30) |
| `cd_referencia` | `varchar(5) NULL` | `cod_referencia` | `varchar(5)` | [RENAME] | Parte 2 do SKU |
| `cd_desc_prod` | `varchar(80) NULL` | `ds_produto` | `varchar(80)` | [RENAME] | Descricao |
| `desc_produto` | `varchar(70) NULL` | `ds_produto_curto` | `varchar(70)` | [RENAME] | Descricao curta |
| `nm_tamanho` | `varchar(15) NULL` | `ds_tamanho` | `varchar(15)` | [RENAME] | Tamanho (parte 3 do SKU) |
| `nm_cor` | `varchar(25) NULL` | `ds_cor` | `varchar(25)` | [RENAME] | Cor (parte 4 do SKU) |
| `cd_cor` | `varchar(6) NULL` | `cod_cor` | `varchar(6)` | [RENAME] | Codigo da cor |
| `cd_tamanho` | `varchar(5) NULL` | `cod_tamanho` | `varchar(5)` | [RENAME] | Codigo do tamanho |
| `cd_colecao` | `int2 NULL` | `id_colecao` | `smallint` | [RENAME] | Colecao |
| `desc_colecao` | `varchar(30) NULL` | `ds_colecao` | `varchar(30)` | [RENAME] | Desc colecao |
| `cod_linha` | `int4 NULL` | `id_linha` | `integer` | [RENAME] | Linha |
| `linha_produto` | `varchar(40) NULL` | `ds_linha` | `varchar(40)` | [RENAME] | Desc linha |
| `preco_custo` | `numeric(18,3) NULL` | `vl_preco_custo` | `numeric(15,2)` | [RENAME] [RETYPE] | Preco de custo |
| `item_ativo` | `int2 NULL` | `fl_ativo` | `boolean` | [RENAME] [RETYPE] | Ativo; converter para boolean |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_produto UNIQUE (sku_produto)
```

#### Relacionamentos propostos

```
live.d_produto
  <- comercial.fpedido.fk_produto         (sku_produto)
  <- jma.ffaturamento.pk_produto          (sku_produto)
  <- estoque.fsaldoestoqueatual.fk_produto (sku_produto)
```

#### Migracao SQL (principais)

```sql
ALTER TABLE live.dproduto RENAME TO d_produto;
ALTER TABLE live.d_produto ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE live.d_produto ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_produto ALTER COLUMN sku_produto TYPE varchar(30);
ALTER TABLE live.d_produto ADD CONSTRAINT uq_d_produto UNIQUE (sku_produto);
ALTER TABLE live.d_produto RENAME COLUMN pk_produto TO cod_produto_legado;
ALTER TABLE live.d_produto RENAME COLUMN cd_referencia TO cod_referencia;
ALTER TABLE live.d_produto RENAME COLUMN cd_desc_prod TO ds_produto;
ALTER TABLE live.d_produto RENAME COLUMN item_ativo TO fl_ativo;
ALTER TABLE live.d_produto ALTER COLUMN fl_ativo TYPE boolean USING (item_ativo = 1);
ALTER TABLE live.d_produto RENAME COLUMN dthora_atualizacao TO updated_at;
ALTER TABLE live.d_produto ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE live.d_produto ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW live.dproduto AS SELECT * FROM live.d_produto;
COMMENT ON VIEW live.dproduto IS 'DEPRECATED 2026-05-05: usar d_produto. Sera removido em 2026-08-03.';
```

---

### live.dproduto_loja

**Nome proposto:** `live.d_produto_loja`
**Tipo:** dimensao
**Descricao:** Produtos cadastrados no sistema de PDV das lojas (CIGAM) com atributos de NCM, CEST e classificacoes.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_produto` | `varchar(41) NULL` | `sku_produto_loja` | `varchar(41)` | [RENAME] | SKU no sistema de loja; pode diferir do SKU padrao |
| `desc_produto` | `varchar(80) NULL` | `ds_produto` | `varchar(80)` | [RENAME] | Descricao |
| `cod_ncm` | `varchar(20) NULL` | `ds_ncm` | `varchar(10)` | [RENAME] [RETYPE] | NCM; limitar |
| `cod_cest` | `varchar(10) NULL` | `ds_cest` | `varchar(10)` | [RENAME] | CEST |
| `cod_referencia` | `varchar(20) NULL` | `cod_referencia` | `varchar(5)` | [RETYPE] | Referencia; limitar |
| `desc_unidade` | `varchar(10) NULL` | `ds_unidade_medida` | `varchar(5)` | [RENAME] [RETYPE] | Unidade |
| `desc_tamanho` | `varchar(50) NULL` | `ds_tamanho` | `varchar(15)` | [RENAME] [RETYPE] | Tamanho |
| `desc_setor` | `varchar(30) NULL` | `ds_setor` | `varchar(30)` | [RENAME] | Setor |
| `desc_linha` | `varchar(30) NULL` | `ds_linha` | `varchar(40)` | [RENAME] [RETYPE] | Linha |
| `desc_marca` | `varchar(30) NULL` | `ds_marca` | `varchar(50)` | [RENAME] [RETYPE] | Marca |
| `desc_cor` | `varchar(30) NULL` | `ds_cor` | `varchar(25)` | [RENAME] [RETYPE] | Cor |
| `desc_colecao` | `varchar(50) NULL` | `ds_colecao` | `varchar(50)` | [RENAME] | Colecao |
| `desc_classificacao` | `varchar(50) NULL` | `ds_classificacao` | `varchar(50)` | [RENAME] | Classificacao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dreferencias_mta

**Nome proposto:** `live.d_referencia_mta`
**Tipo:** dimensao
**Descricao:** Referencias de produto no sistema MTA (Multi-Touch Attribution) com precos sell-in/sell-out, lancamento e status.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| `referencia` | `cod_referencia` | `varchar(50)` | Referencia |
| `tamanho` | `ds_tamanho` | `varchar(20)` | Tamanho |
| `corvenda` | `cod_cor` | `varchar(50)` | Codigo cor |
| `linkimagem` | `ds_url_imagem` | `text` | URL imagem |
| `refcor` | `sku_ref_cor` | `varchar(50)` | SKU ref+cor |
| `colecao` | `ds_colecao` | `varchar(100)` | Colecao |
| `categoria` | `ds_categoria` | `varchar(100)` | Categoria |
| `mpprincipal` | `ds_mp_principal` | `varchar(100)` | MP principal |
| `sellin` | `vl_preco_sell_in` | `numeric(15,2)` | Preco sell-in |
| `sellout` | `vl_preco_sell_out` | `numeric(15,2)` | Preco sell-out |
| `lancamento` | `dt_lancamento` | `date` | Data lancamento |
| `descricaocor` | `ds_cor` | `varchar(255)` | Descricao da cor |
| `linha` | `cod_linha` | `varchar(50)` | Linha |
| `descricaolinha` | `ds_linha` | `varchar(255)` | Descricao linha |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| `status` | `ds_status` | `varchar(15)` | Status |
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### live.dregiao_lojas

**Nome proposto:** `live.d_regiao_loja`
**Tipo:** dimensao
**Descricao:** Regioes de lojas com cidade associada.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cod_regiao` | `int4 NULL` | `id_regiao` | `integer` | [RENAME] | Codigo da regiao |
| `desc_regiao` | `varchar(40) NULL` | `ds_regiao` | `varchar(40)` | [RENAME] | Descricao |
| `cod_cidade` | `int4 NULL` | `cod_cidade` | `varchar(5)` | [RETYPE] | Business key da cidade |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dresponsavel_loja

**Nome proposto:** `live.d_responsavel_loja`
**Tipo:** dimensao
**Descricao:** Responsaveis (gerentes, supervisores) por loja, com cargo, funcao e situacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_responsavel` | `varchar(80) NULL` | `cod_responsavel` | `varchar(80)` | [RENAME] | Business key |
| `cod_loja` | `int4 NULL` | `id_loja` | `integer` | [RENAME] | FK para `d_loja.id_loja` |
| `desc_responsavel` | `varchar(100) NULL` | `nm_responsavel` | `varchar(100)` | [RENAME] | Nome |
| `cargo` | `varchar(200) NULL` | `ds_cargo` | `varchar(100)` | [RENAME] [RETYPE] | Cargo |
| `cod_situacao` | `int2 NULL` | `id_situacao` | `smallint` | [RENAME] | Situacao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `email` | `text NULL` | `nm_email` | `varchar(100)` | [RENAME] [RETYPE] | Email |
| `cod_funcao` | `int4 NULL` | `id_funcao` | `integer` | [RENAME] | Funcao |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### live.dshowroom

**Nome proposto:** `live.d_showroom`
**Tipo:** dimensao
**Descricao:** Showrooms com periodo de referencia para pedidos e colecoes/subcolecoes vinculadas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `serial4 NOT NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | PK — promover de serial4 para bigserial |
| `nome_showroom` | `varchar NULL` | `nm_showroom` | `varchar(100)` | [RENAME] [RETYPE] | Nome do showroom |
| `data_inicio` | `date NULL` | `dt_inicio` | `date` | [RENAME] | Inicio do periodo |
| `data_fim` | `date NULL` | `dt_fim` | `date` | [RENAME] | Fim do periodo |
| `colecao` | `_int4 NULL` | `ids_colecoes` | `_int4` | [RENAME] | Array de colecoes |
| `subcolecao` | `_int4 NULL` | `ids_subcolecoes` | `_int4` | [RENAME] | Array de subcolecoes |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Migracao SQL

```sql
ALTER TABLE live.dshowroom RENAME TO d_showroom;
ALTER TABLE live.d_showroom ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_showroom ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE live.d_showroom RENAME COLUMN nome_showroom TO nm_showroom;
ALTER TABLE live.d_showroom ALTER COLUMN nm_showroom TYPE varchar(100);
ALTER TABLE live.d_showroom RENAME COLUMN data_inicio TO dt_inicio;
ALTER TABLE live.d_showroom RENAME COLUMN data_fim TO dt_fim;
ALTER TABLE live.d_showroom RENAME COLUMN colecao TO ids_colecoes;
ALTER TABLE live.d_showroom RENAME COLUMN subcolecao TO ids_subcolecoes;
CREATE OR REPLACE VIEW live.dshowroom AS SELECT * FROM live.d_showroom;
COMMENT ON VIEW live.dshowroom IS 'DEPRECATED 2026-05-05: usar d_showroom. Sera removido em 2026-08-03.';
```

---

## Conflitos e Decisoes Pendentes — Schema `live`

1. **`dcliente.cnpj_cliente` como varchar(120)**: Muito maior que o necessario (16 chars). Verificar se ha CPFs misturados antes de truncar para varchar(16). O ETL deve reformatar via `dw.fn_formatar_cnpj_cpf`.
2. **`dlojas.pk_cnpj` como varchar(35)**: Mesmo problema de CNPJ. Reformatar e converter para `cnpj_loja varchar(16)`.
3. **`dproduto.sku_produto` como varchar(120)**: Deve ser normalizado para varchar(30) conforme padrao da secao 6.1 do BOAS_PRATICAS.
4. **`dproduto_loja.pk_produto` vs `dproduto.pk_produto`**: Os dois tem formatos diferentes de identificador de produto. Confirmar se `dproduto_loja.pk_produto` segue o mesmo formato SKU para usar `sku_produto` ou requer identificador diferente.
5. **`dcalendario.ultima_atualizacao` como `date`**: E o unico campo de auditoria como `date` no DW — converter para `timestamp`.
6. **Flags `numeric(1)` em `dbriefing`**: 11 flags como `numeric(1)` devem ser convertidas para `boolean`. O ETL ja deve ter logica para isso.
7. **`dcanaldistribuicao` duplicada em `live` e `jma`**: Verificar se sao identicas e consolidar em uma.
