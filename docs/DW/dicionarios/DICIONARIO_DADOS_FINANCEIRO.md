# Dicionario de Dados — Schema `financeiro`

> **Versao:** 1.0 | **Data:** 2026-05-05
> **Responsavel:** Especialista DW — Schema financeiro
> **Status:** Proposta de padronizacao
> **Escopo:** Apuracao de notas fiscais de entrada e saida, lancamentos contabeis, orcamentos e titulos a receber.

---

## Visao Geral do Schema

| Tabela atual | Tipo | Tabela proposta | Descricao resumida |
|---|---|---|---|
| `dconsulta_nfs` | dimensao/staging | `d_consulta_nf` | Cabecalho de notas fiscais para consulta rapida |
| `dlancamentos_contabeis` | fato | `f_lancamento_contabil` | Lancamentos debito/credito no plano de contas |
| `fapuracao_notas_entrada` | fato | `f_apuracao_nf_entrada` | Apuracao fiscal e tributaria de NF de entrada |
| `fapuracao_notas_saida` | fato | `f_apuracao_nf_saida` | Apuracao fiscal e tributaria de NF de saida |
| `forion_orcamento` | fato | `f_orcamento` | Orcamento por centro de custo e conta contabil |
| `ftitulos_receber_resumo` | fato | `f_titulo_receber` | Titulos a receber com situacao e pagamentos |

---

## Tabelas

---

### financeiro.dconsulta_nfs

**Nome proposto:** `financeiro.d_consulta_nf`
**Tipo:** dimensao
**Descricao:** Armazena o cabecalho das notas fiscais (entrada e saida) para consulta rapida de situacao, datas e valores totais. Funciona como dimensao degenerade de nota fiscal dentro do schema financeiro, complementando as tabelas de apuracao.
**Sistema de origem:** Systextil (modulo fiscal/faturamento)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `num_nota_fiscal` | `varchar(50)` | `nr_nota_fiscal` | `integer` | RENAME, RETYPE | Numero de NF e sempre numerico; prefixo `nr_` para documento sequencial conforme boas praticas; integer suficiente para 9 digitos |
| `serie_nota_fisc` | `varchar(20)` | `ds_serie` | `varchar(5)` | RENAME, RETYPE | Serie da NF e descricao curta; `varchar(50)` e excessivo para serie (tipicamente 1-3 chars); reduzir para `varchar(5)` |
| `especie_docto` | `varchar(20)` | `ds_especie_docto` | `varchar(20)` | RENAME | Prefixo `ds_` obrigatorio para descricao |
| `data_base_fatur` | `date` | `dt_base_faturamento` | `date` | RENAME | Prefixo `dt_` e nome completo sem abreviacao obscura |
| `data_saida` | `date` | `dt_saida` | `date` | RENAME | Prefixo `dt_` conforme padrao |
| `data_prevista` | `date` | `dt_prevista` | `date` | RENAME | Prefixo `dt_` conforme padrao |
| `cod_rep_cliente` | `varchar(50)` | `cod_representante` | `varchar(6)` | RENAME, RETYPE, CONFLITO | Nome atual e ambiguo; renomear para join key canonical com `d_representante`; `varchar(50)` excessivo — tipo canonical e `varchar(6)` |
| `pedido_venda` | `varchar(50)` | `nr_pedido` | `varchar(20)` | RENAME, RETYPE | Numero de pedido; prefixo `nr_`; reduzir tamanho |
| `usuario_digitacao` | `varchar(100)` | `nm_usuario_digitacao` | `varchar(100)` | RENAME | Prefixo `nm_` para nome de usuario |
| `valor_itens_nfis` | `numeric(15,2)` | `vl_itens` | `numeric(15,2)` | RENAME | Prefixo `vl_`; sufixo `_nfis` e redundante dentro do contexto da tabela |
| `valor_desconto` | `numeric(15,2)` | `vl_desconto` | `numeric(15,2)` | RENAME | Prefixo `vl_` |
| `situacao_nfisc` | `varchar(20)` | `ds_situacao` | `varchar(20)` | RENAME | Prefixo `ds_` para descricao de situacao |
| _(ausente)_ | — | `id` | `bigserial` | ADD | Surrogate key obrigatoria em toda tabela DW |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [CONFLITO]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Nao existe chave natural unica evidente (numero de NF pode se repetir entre empresas e series). A chave de negocio composta sugerida para UNIQUE e `(nr_nota_fiscal, ds_serie, id_empresa)` — porem `id_empresa` nao existe nesta tabela atualmente; avaliar adicao ou manter apenas surrogate key.

#### Relacionamentos propostos

```
financeiro.d_consulta_nf
  |- cod_representante  -> comercial.d_representante.cod_representante
  |- nr_nota_fiscal     -> financeiro.f_apuracao_nf_saida.nr_nota_fiscal  (join por numero)
```

#### Indices recomendados

```sql
CREATE INDEX idx_d_consulta_nf_nr_nota        ON financeiro.d_consulta_nf(nr_nota_fiscal);
CREATE INDEX idx_d_consulta_nf_dt_saida       ON financeiro.d_consulta_nf(dt_saida);
CREATE INDEX idx_d_consulta_nf_cod_repres     ON financeiro.d_consulta_nf(cod_representante);
CREATE INDEX idx_d_consulta_nf_ds_situacao    ON financeiro.d_consulta_nf(ds_situacao);
```

#### Impacto no ETL

- Renomear `cod_rep_cliente` para `cod_representante` e reduzir tipo de `varchar(50)` para `varchar(6)` exige conversao e validacao dos dados existentes — checar se ha valores com mais de 6 caracteres antes da migracao.
- Converter `num_nota_fiscal` de `varchar(50)` para `integer`: checar presenca de valores nao numericos ou alfanumericos no campo (ex: notas complementares com sufixo). Se existirem, manter `varchar(20)` e usar prefixo `nr_` mesmo assim.
- Colunas de auditoria (`created_at`, `updated_at`) devem ser adicionadas sem `NOT NULL` inicialmente (ADD COLUMN nullable) para nao quebrar carga existente; tornar `NOT NULL` apos backfill.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE financeiro.dconsulta_nfs RENAME TO d_consulta_nf;

-- 2. Adicionar surrogate key
ALTER TABLE financeiro.d_consulta_nf
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear colunas
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN num_nota_fiscal    TO nr_nota_fiscal_raw;   -- transicao: checar conversao
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN serie_nota_fisc    TO ds_serie;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN especie_docto      TO ds_especie_docto;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN data_base_fatur    TO dt_base_faturamento;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN data_saida         TO dt_saida;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN data_prevista      TO dt_prevista;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN cod_rep_cliente    TO cod_representante;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN pedido_venda       TO nr_pedido;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN usuario_digitacao  TO nm_usuario_digitacao;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN valor_itens_nfis   TO vl_itens;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN valor_desconto     TO vl_desconto;
ALTER TABLE financeiro.d_consulta_nf
    RENAME COLUMN situacao_nfisc     TO ds_situacao;

-- 4. Adicionar coluna nr_nota_fiscal integer apos validacao dos dados
-- (executar somente apos confirmar ausencia de valores nao numericos)
ALTER TABLE financeiro.d_consulta_nf
    ADD COLUMN nr_nota_fiscal integer;
UPDATE financeiro.d_consulta_nf
    SET nr_nota_fiscal = nr_nota_fiscal_raw::integer
    WHERE nr_nota_fiscal_raw ~ '^\d+$';
-- Apos validacao: remover coluna _raw
-- ALTER TABLE financeiro.d_consulta_nf DROP COLUMN nr_nota_fiscal_raw;

-- 5. Retype cod_representante
ALTER TABLE financeiro.d_consulta_nf
    ALTER COLUMN cod_representante TYPE varchar(6)
    USING TRIM(cod_representante)::varchar;

-- 6. Auditoria
ALTER TABLE financeiro.d_consulta_nf
    ADD COLUMN created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp DEFAULT current_timestamp;

-- 7. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW financeiro.dconsulta_nfs AS
    SELECT * FROM financeiro.d_consulta_nf;
COMMENT ON VIEW financeiro.dconsulta_nfs IS
    'DEPRECATED 2026-05-05: usar d_consulta_nf. Sera removido em 2026-08-03.';
```

---

### financeiro.dlancamentos_contabeis

**Nome proposto:** `financeiro.f_lancamento_contabil`
**Tipo:** fato
**Descricao:** Registra cada lancamento contabil do sistema ERP com debito e credito, vinculado a empresa, conta contabil, centro de custo e historico. E a tabela base para reconciliacao e fechamento contabil.
**Sistema de origem:** Systextil (modulo contabilidade)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `exercicio` | `numeric(4)` | `nr_exercicio` | `smallint` | RENAME, RETYPE | Ano fiscal e numero inteiro de 4 digitos; `smallint` adequado (range +-32k); prefixo `nr_` para numero sequencial |
| `data_lancto` | `timestamp` | `dt_lancamento` | `date` | RENAME, RETYPE | Data de lancamento nao precisa de hora; converter para `date`; nome completo sem abreviacao |
| `cod_empresa` | `numeric(3)` | `id_empresa` | `smallint` | RENAME, RETYPE | Codigo operacional de empresa; prefixo `id_`; `smallint` suficiente |
| `desc_empresa` | `text` | `nm_empresa` | `varchar(70)` | RENAME, RETYPE | Nome da empresa; prefixo `nm_`; `text` sem limite e excessivo |
| `conta_contabil` | `text` | `ds_conta_contabil` | `varchar(40)` | RENAME, RETYPE | Descricao ou codigo da conta; prefixo `ds_`; tamanho limitado |
| `conta_reduzida` | `numeric(5)` | `nr_conta_reduzida` | `integer` | RENAME, RETYPE | Numero reduzido da conta; prefixo `nr_` |
| `centro_custo` | `numeric(6)` | `id_centro_custo` | `integer` | RENAME, RETYPE | Codigo operacional de centro de custo; prefixo `id_` |
| `desc_ccusto` | `text` | `ds_centro_custo` | `varchar(60)` | RENAME, RETYPE | Descricao do centro de custo; prefixo `ds_` |
| `chave` | `numeric(9)` | `nr_chave` | `integer` | RENAME, RETYPE | Numero da chave do lancamento no sistema de origem; prefixo `nr_` |
| `seqchave` | `numeric(5)` | `nr_seq_chave` | `smallint` | RENAME, RETYPE | Sequencia dentro da chave; `smallint` suficiente |
| `cod_contabil` | `numeric(4)` | `id_historico_contabil` | `smallint` | RENAME, RETYPE | Codigo do historico padrao; prefixo `id_` (nao e entidade/dimensao) |
| `desc_historico` | `text` | `ds_historico` | `text` | RENAME | Descricao do historico padrao; prefixo `ds_`; manter `text` pois pode ser longo |
| `complemento_historico` | `text` | `obs_complemento` | `text` | RENAME | Texto livre de complemento; prefixo `obs_` |
| `debito` | `numeric(38,10)` | `vl_debito` | `numeric(15,2)` | RENAME, RETYPE | Valor monetario; prefixo `vl_`; `numeric(38,10)` e excessivo — padrao DW e `numeric(15,2)` |
| `credito` | `numeric(38,10)` | `vl_credito` | `numeric(15,2)` | RENAME, RETYPE | Valor monetario; prefixo `vl_`; mesma justificativa do debito |
| `desc_plano_conta` | `text` | `ds_plano_conta` | `varchar(80)` | RENAME, RETYPE | Descricao do plano de contas; prefixo `ds_` |
| `ultima_atualizacao` | `timestamp` | `updated_at` | `timestamp` | RENAME | Mapeamento canonico de campo de atualizacao para `updated_at` |
| _(ausente)_ | — | `id` | `bigserial` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural de negocio: `(nr_exercicio, id_empresa, nr_chave, nr_seq_chave)` — candidata a UNIQUE constraint apos validacao de unicidade nos dados.

#### Relacionamentos propostos

```
financeiro.f_lancamento_contabil
  |- id_empresa       -> (sem dimensao formal; id_ operacional)
  |- id_centro_custo  -> (sem dimensao formal; id_ operacional)
  |- nr_exercicio     -> referencia temporal por ano fiscal
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_lanc_cont_empresa        ON financeiro.f_lancamento_contabil(id_empresa);
CREATE INDEX idx_f_lanc_cont_dt_lancamento  ON financeiro.f_lancamento_contabil(dt_lancamento);
CREATE INDEX idx_f_lanc_cont_nr_chave       ON financeiro.f_lancamento_contabil(nr_chave);
CREATE INDEX idx_f_lanc_cont_centro_custo   ON financeiro.f_lancamento_contabil(id_centro_custo);
CREATE INDEX idx_f_lanc_cont_conta_red      ON financeiro.f_lancamento_contabil(nr_conta_reduzida);
CREATE INDEX idx_f_lanc_cont_exercicio      ON financeiro.f_lancamento_contabil(nr_exercicio);
CREATE INDEX idx_f_lanc_cont_updated_at     ON financeiro.f_lancamento_contabil(updated_at);
```

#### Impacto no ETL

- `debito` e `credito` como `numeric(38,10)`: a conversao para `numeric(15,2)` pode provocar perda de precisao se houver valores com mais de 2 casas decimais significativas — checar dados antes da migracao.
- `data_lancto timestamp` -> `date`: verificar se alguma DAG utiliza a componente horaria; se sim, criar coluna `dth_lancamento timestamp` adicional e deprecar `data_lancto` gradualmente.
- `ultima_atualizacao` mapeado para `updated_at` serve de watermark para carga incremental.
- Tabela provavelmente tem alto volume; migracao de tipo de `numeric(38,10)` para `numeric(15,2)` deve ser feita em janela de manutencao com parada da DAG.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE financeiro.dlancamentos_contabeis RENAME TO f_lancamento_contabil;

-- 2. Surrogate key
ALTER TABLE financeiro.f_lancamento_contabil
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear colunas
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN exercicio             TO nr_exercicio;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN data_lancto           TO dt_lancamento;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN cod_empresa           TO id_empresa;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN desc_empresa          TO nm_empresa;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN conta_contabil        TO ds_conta_contabil;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN conta_reduzida        TO nr_conta_reduzida;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN centro_custo          TO id_centro_custo;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN desc_ccusto           TO ds_centro_custo;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN chave                 TO nr_chave;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN seqchave              TO nr_seq_chave;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN cod_contabil          TO id_historico_contabil;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN desc_historico        TO ds_historico;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN complemento_historico TO obs_complemento;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN debito                TO vl_debito;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN credito               TO vl_credito;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN desc_plano_conta      TO ds_plano_conta;
ALTER TABLE financeiro.f_lancamento_contabil
    RENAME COLUMN ultima_atualizacao    TO updated_at;

-- 4. Retype (executar em janela de manutencao com DAG pausada)
ALTER TABLE financeiro.f_lancamento_contabil
    ALTER COLUMN nr_exercicio           TYPE smallint  USING nr_exercicio::smallint,
    ALTER COLUMN dt_lancamento          TYPE date      USING dt_lancamento::date,
    ALTER COLUMN id_empresa             TYPE smallint  USING id_empresa::smallint,
    ALTER COLUMN nm_empresa             TYPE varchar(70),
    ALTER COLUMN ds_conta_contabil      TYPE varchar(40),
    ALTER COLUMN nr_conta_reduzida      TYPE integer   USING nr_conta_reduzida::integer,
    ALTER COLUMN id_centro_custo        TYPE integer   USING id_centro_custo::integer,
    ALTER COLUMN ds_centro_custo        TYPE varchar(60),
    ALTER COLUMN nr_chave               TYPE integer   USING nr_chave::integer,
    ALTER COLUMN nr_seq_chave           TYPE smallint  USING nr_seq_chave::smallint,
    ALTER COLUMN id_historico_contabil  TYPE smallint  USING id_historico_contabil::smallint,
    ALTER COLUMN vl_debito              TYPE numeric(15,2) USING vl_debito::numeric(15,2),
    ALTER COLUMN vl_credito             TYPE numeric(15,2) USING vl_credito::numeric(15,2),
    ALTER COLUMN ds_plano_conta         TYPE varchar(80);

-- 5. Auditoria
ALTER TABLE financeiro.f_lancamento_contabil
    ADD COLUMN created_at timestamp DEFAULT current_timestamp;

-- 6. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW financeiro.dlancamentos_contabeis AS
    SELECT * FROM financeiro.f_lancamento_contabil;
COMMENT ON VIEW financeiro.dlancamentos_contabeis IS
    'DEPRECATED 2026-05-05: usar f_lancamento_contabil. Sera removido em 2026-08-03.';
```

---

### financeiro.fapuracao_notas_entrada

**Nome proposto:** `financeiro.f_apuracao_nf_entrada`
**Tipo:** fato
**Descricao:** Apuracao fiscal e tributaria das notas fiscais de entrada (compras e devolucoes de clientes). Contem bases de calculo e valores de ICMS, IPI, PIS, COFINS por classificacao fiscal e natureza de operacao.
**Sistema de origem:** Systextil (modulo fiscal — livros de entrada)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `codigo_empresa` | `numeric(3)` | `id_empresa` | `smallint` | RENAME, RETYPE | Codigo operacional; prefixo `id_`; `smallint` suficiente |
| `data_transacao` | `timestamp` | `dt_transacao` | `date` | RENAME, RETYPE | Data sem componente horaria relevante; converter para `date` |
| `codificacao_contabil` | `numeric(38,10)` | `id_codificacao_contabil` | `integer` | RENAME, RETYPE | Codigo operacional contabil; `numeric(38,10)` excessivo — `integer` suficiente |
| `classificacao_fiscal` | `text` | `ds_classificacao_fiscal` | `varchar(20)` | RENAME, RETYPE | Descricao da classificacao fiscal; prefixo `ds_` |
| `documento` | `numeric(9)` | `nr_nota_fiscal` | `integer` | RENAME, RETYPE | Numero do documento fiscal de entrada; usar nome canonical `nr_nota_fiscal` |
| `serie` | `text` | `ds_serie` | `varchar(5)` | RENAME, RETYPE | Serie da NF; prefixo `ds_` |
| `cgc_cli_for_9` | `numeric(9)` | _(parte de `cnpj_fornecedor`)_ | — | REFORMAT | Parte 1 do CNPJ/CPF do fornecedor; consolidar com `_4` e `_2` em `cnpj_fornecedor` |
| `cgc_cli_for_4` | `numeric(4)` | _(parte de `cnpj_fornecedor`)_ | — | REFORMAT | Parte 2 (filial) do CNPJ; consolidar |
| `cgc_cli_for_2` | `numeric(2)` | _(parte de `cnpj_fornecedor`)_ | — | REFORMAT | Digitos verificadores do CNPJ; consolidar |
| _(consolidacao)_ | — | `cnpj_fornecedor` | `varchar(16)` | ADD | CNPJ/CPF do fornecedor reconstruido via `fn_formatar_cnpj_cpf`; nome canonical da dimensao `d_fornecedor` |
| `data_emissao` | `timestamp` | `dt_emissao` | `date` | RENAME, RETYPE | Data de emissao sem hora; converter para `date` |
| `tipo_valores_fiscal` | `text` | `ds_tipo_valores_fiscal` | `varchar(20)` | RENAME, RETYPE | Descricao do tipo de valores fiscais; prefixo `ds_` |
| `situacao_entrada` | `numeric(1)` | `id_situacao_entrada` | `smallint` | RENAME, RETYPE | Flag/codigo de situacao; prefixo `id_` |
| `rateio_despesas` | `numeric(15,2)` | `vl_rateio_despesas` | `numeric(15,2)` | RENAME | Valor de rateio de despesas; prefixo `vl_` |
| `classif_contabil` | `numeric(6)` | `id_classif_contabil` | `integer` | RENAME, RETYPE | Codigo de classificacao contabil; prefixo `id_` |
| `cod_natureza` | `text` | `ds_natureza` | `varchar(20)` | RENAME, RETYPE | Descricao ou codigo da natureza de operacao; `text` excessivo |
| `descr_nat_oper` | `text` | `ds_nat_operacao` | `varchar(60)` | RENAME, RETYPE | Descricao da natureza de operacao; prefixo `ds_` |
| `livros_fiscais` | `numeric(1)` | `fl_livros_fiscais` | `boolean` | RENAME, RETYPE | Flag indicando escrituracao em livros fiscais; converter para `boolean` |
| `divisao_natur` | `numeric(2)` | `id_divisao_natureza` | `smallint` | RENAME, RETYPE | Codigo da divisao da natureza; prefixo `id_` |
| `natur_operacao` | `numeric(3)` | `id_natureza_operacao` | `smallint` | RENAME, RETYPE | Codigo da natureza de operacao; prefixo `id_` |
| `estado_natoper` | `text` | `ds_uf_nat_operacao` | `char(2)` | RENAME, RETYPE | UF da natureza de operacao; usar `char(2)` maiusculo |
| `cod_vlfiscal_icm` | `numeric(9)` | `id_vl_fiscal_icm` | `integer` | RENAME, RETYPE | Codigo operacional do valor fiscal de ICMS; prefixo `id_` |
| `cod_vlfiscal_ipi` | `numeric(9)` | `id_vl_fiscal_ipi` | `integer` | RENAME, RETYPE | Codigo operacional do valor fiscal de IPI; prefixo `id_` |
| `base_diferenca` | `numeric(15,2)` | `vl_base_diferenca` | `numeric(15,2)` | RENAME | Base de calculo de diferenca; prefixo `vl_` |
| `base_ipi` | `numeric(15,2)` | `vl_base_ipi` | `numeric(15,2)` | RENAME | Base de calculo do IPI; prefixo `vl_` |
| `base_pis_cofins` | `numeric(15,2)` | `vl_base_pis_cofins` | `numeric(15,2)` | RENAME | Base de calculo PIS/COFINS; prefixo `vl_` |
| `base_icms_subs` | `numeric(14,2)` | `vl_base_icms_st` | `numeric(15,2)` | RENAME, RETYPE | Base de calculo ICMS substituicao tributaria; padronizar para `numeric(15,2)` |
| `base_icms` | `numeric(15,2)` | `vl_base_icms` | `numeric(15,2)` | RENAME | Base de calculo ICMS; prefixo `vl_` |
| `base_calc_icm` | `numeric(15,2)` | `vl_base_calc_icms` | `numeric(15,2)` | RENAME | Base de calculo do ICMS (campo alternativo/legado); prefixo `vl_` |
| `valor_total_ipi` | `numeric(15,2)` | `vl_total_ipi` | `numeric(15,2)` | RENAME | Valor total IPI; prefixo `vl_` |
| `valor_despesas` | `numeric(15,2)` | `vl_despesas` | `numeric(15,2)` | RENAME | Valor de despesas acessorias; prefixo `vl_` |
| `valor_frete` | `numeric(15,2)` | `vl_frete` | `numeric(15,2)` | RENAME | Valor do frete; prefixo `vl_` |
| `valor_desconto` | `numeric(15,2)` | `vl_desconto` | `numeric(15,2)` | RENAME | Valor de desconto; prefixo `vl_` |
| `valor_seguro` | `numeric(15,2)` | `vl_seguro` | `numeric(15,2)` | RENAME | Valor do seguro; prefixo `vl_` |
| `valor_ipi` | `numeric(15,2)` | `vl_ipi` | `numeric(15,2)` | RENAME | Valor do IPI; prefixo `vl_` |
| `valor_pis` | `numeric(15,2)` | `vl_pis` | `numeric(15,2)` | RENAME | Valor do PIS; prefixo `vl_` |
| `valor_cofins` | `numeric(15,2)` | `vl_cofins` | `numeric(15,2)` | RENAME | Valor do COFINS; prefixo `vl_` |
| `valor_icms` | `numeric(15,2)` | `vl_icms` | `numeric(15,2)` | RENAME | Valor do ICMS; prefixo `vl_` |
| `valor_total` | `numeric(15,2)` | `vl_total` | `numeric(15,2)` | RENAME | Valor total da NF; prefixo `vl_` |
| `valor_itens` | `numeric(15,2)` | `vl_itens` | `numeric(15,2)` | RENAME | Valor dos itens; prefixo `vl_` |
| `desconta_ipi_icms` | `numeric(15,2)` | `vl_desconta_ipi_icms` | `numeric(15,2)` | RENAME | Valor deduzido de IPI/ICMS; prefixo `vl_` |
| _(ausente)_ | — | `id` | `bigserial` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural de negocio candidata: `(id_empresa, nr_nota_fiscal, ds_serie, cnpj_fornecedor)` — validar unicidade antes de aplicar UNIQUE constraint.

#### Relacionamentos propostos

```
financeiro.f_apuracao_nf_entrada
  |- id_empresa        -> (id_ operacional; sem dimensao formal)
  |- cnpj_fornecedor   -> comercial.d_fornecedor.cnpj_fornecedor  (quando disponivel)
  |- nr_nota_fiscal    -> financeiro.d_consulta_nf.nr_nota_fiscal  (join informacional)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_apr_ent_empresa         ON financeiro.f_apuracao_nf_entrada(id_empresa);
CREATE INDEX idx_f_apr_ent_dt_emissao      ON financeiro.f_apuracao_nf_entrada(dt_emissao);
CREATE INDEX idx_f_apr_ent_dt_transacao    ON financeiro.f_apuracao_nf_entrada(dt_transacao);
CREATE INDEX idx_f_apr_ent_nr_nf           ON financeiro.f_apuracao_nf_entrada(nr_nota_fiscal);
CREATE INDEX idx_f_apr_ent_cnpj_forn       ON financeiro.f_apuracao_nf_entrada(cnpj_fornecedor);
CREATE INDEX idx_f_apr_ent_updated_at      ON financeiro.f_apuracao_nf_entrada(updated_at);
```

#### Impacto no ETL

- As tres colunas `cgc_cli_for_9`, `cgc_cli_for_4`, `cgc_cli_for_2` devem ser consolidadas em `cnpj_fornecedor varchar(16)` usando `dw.fn_formatar_cnpj_cpf` no pipeline; as colunas originais podem ser mantidas durante periodo de transicao e removidas apos validacao.
- `codificacao_contabil numeric(38,10)` armazena codigo inteiro em tipo excessivo; converter para `integer` apos checar que nao ha casas decimais significativas nos dados.
- `livros_fiscais numeric(1)` — verificar se os valores sao estritamente 0/1; se sim, converter para `boolean`; se houver outros valores, usar `smallint`.
- `data_transacao` e `data_emissao` como `timestamp`: checar se alguma DAG filtra por hora antes de converter para `date`.
- Volume potencialmente alto; todas as mudancas de tipo devem ocorrer em janela de manutencao.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE financeiro.fapuracao_notas_entrada RENAME TO f_apuracao_nf_entrada;

-- 2. Surrogate key
ALTER TABLE financeiro.f_apuracao_nf_entrada
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Adicionar coluna cnpj_fornecedor consolidada (antes de remover as partes)
ALTER TABLE financeiro.f_apuracao_nf_entrada
    ADD COLUMN cnpj_fornecedor varchar(16);

UPDATE financeiro.f_apuracao_nf_entrada
    SET cnpj_fornecedor = dw.fn_formatar_cnpj_cpf(
        cgc_cli_for_9::text,
        cgc_cli_for_4::text,
        cgc_cli_for_2::int
    );

-- 4. Renomear colunas
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN codigo_empresa          TO id_empresa;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN data_transacao          TO dt_transacao;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN codificacao_contabil    TO id_codificacao_contabil;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN classificacao_fiscal    TO ds_classificacao_fiscal;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN documento               TO nr_nota_fiscal;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN serie                   TO ds_serie;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN data_emissao            TO dt_emissao;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN tipo_valores_fiscal     TO ds_tipo_valores_fiscal;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN situacao_entrada        TO id_situacao_entrada;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN rateio_despesas         TO vl_rateio_despesas;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN classif_contabil        TO id_classif_contabil;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN cod_natureza            TO ds_natureza;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN descr_nat_oper          TO ds_nat_operacao;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN livros_fiscais          TO fl_livros_fiscais;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN divisao_natur           TO id_divisao_natureza;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN natur_operacao          TO id_natureza_operacao;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN estado_natoper          TO ds_uf_nat_operacao;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN cod_vlfiscal_icm        TO id_vl_fiscal_icm;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN cod_vlfiscal_ipi        TO id_vl_fiscal_ipi;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN base_diferenca          TO vl_base_diferenca;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN base_ipi                TO vl_base_ipi;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN base_pis_cofins         TO vl_base_pis_cofins;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN base_icms_subs          TO vl_base_icms_st;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN base_icms               TO vl_base_icms;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN base_calc_icm           TO vl_base_calc_icms;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_total_ipi         TO vl_total_ipi;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_despesas          TO vl_despesas;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_frete             TO vl_frete;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_desconto          TO vl_desconto;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_seguro            TO vl_seguro;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_ipi               TO vl_ipi;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_pis               TO vl_pis;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_cofins            TO vl_cofins;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_icms              TO vl_icms;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_total             TO vl_total;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN valor_itens             TO vl_itens;
ALTER TABLE financeiro.f_apuracao_nf_entrada
    RENAME COLUMN desconta_ipi_icms       TO vl_desconta_ipi_icms;

-- 5. Retype (janela de manutencao)
ALTER TABLE financeiro.f_apuracao_nf_entrada
    ALTER COLUMN id_empresa               TYPE smallint  USING id_empresa::smallint,
    ALTER COLUMN dt_transacao             TYPE date      USING dt_transacao::date,
    ALTER COLUMN id_codificacao_contabil  TYPE integer   USING id_codificacao_contabil::integer,
    ALTER COLUMN ds_classificacao_fiscal  TYPE varchar(20),
    ALTER COLUMN nr_nota_fiscal           TYPE integer   USING nr_nota_fiscal::integer,
    ALTER COLUMN ds_serie                 TYPE varchar(5),
    ALTER COLUMN dt_emissao               TYPE date      USING dt_emissao::date,
    ALTER COLUMN ds_tipo_valores_fiscal   TYPE varchar(20),
    ALTER COLUMN id_situacao_entrada      TYPE smallint  USING id_situacao_entrada::smallint,
    ALTER COLUMN id_classif_contabil      TYPE integer   USING id_classif_contabil::integer,
    ALTER COLUMN ds_natureza              TYPE varchar(20),
    ALTER COLUMN ds_nat_operacao          TYPE varchar(60),
    ALTER COLUMN fl_livros_fiscais        TYPE boolean   USING (fl_livros_fiscais = 1),
    ALTER COLUMN id_divisao_natureza      TYPE smallint  USING id_divisao_natureza::smallint,
    ALTER COLUMN id_natureza_operacao     TYPE smallint  USING id_natureza_operacao::smallint,
    ALTER COLUMN ds_uf_nat_operacao       TYPE char(2),
    ALTER COLUMN id_vl_fiscal_icm         TYPE integer   USING id_vl_fiscal_icm::integer,
    ALTER COLUMN id_vl_fiscal_ipi         TYPE integer   USING id_vl_fiscal_ipi::integer,
    ALTER COLUMN vl_base_icms_st          TYPE numeric(15,2);

-- 6. Auditoria
ALTER TABLE financeiro.f_apuracao_nf_entrada
    ADD COLUMN created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp DEFAULT current_timestamp;

-- 7. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW financeiro.fapuracao_notas_entrada AS
    SELECT * FROM financeiro.f_apuracao_nf_entrada;
COMMENT ON VIEW financeiro.fapuracao_notas_entrada IS
    'DEPRECATED 2026-05-05: usar f_apuracao_nf_entrada. Sera removido em 2026-08-03.';
```

---

### financeiro.fapuracao_notas_saida

**Nome proposto:** `financeiro.f_apuracao_nf_saida`
**Tipo:** fato
**Descricao:** Apuracao fiscal e tributaria das notas fiscais de saida (faturamento e remessas). Registra bases de calculo, aliquotas e valores de ICMS, IPI, PIS, COFINS por item, alem de quantidade faturada e valores contabeis.
**Sistema de origem:** Systextil (modulo fiscal — livros de saida)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `codigo_empresa` | `numeric(3)` | `id_empresa` | `smallint` | RENAME, RETYPE | Codigo operacional; prefixo `id_`; `smallint` suficiente |
| `codificacao_contabil` | `numeric(6)` | `id_codificacao_contabil` | `integer` | RENAME, RETYPE | Codigo operacional contabil; prefixo `id_` |
| `classificacao_fiscal` | `text` | `ds_classificacao_fiscal` | `varchar(20)` | RENAME, RETYPE | Descricao da classificacao fiscal; prefixo `ds_` |
| `num_nota_fiscal` | `numeric(9)` | `nr_nota_fiscal` | `integer` | RENAME, RETYPE | Numero da NF de saida; usar nome canonical `nr_nota_fiscal` com `integer` |
| `serie_nota_fisc` | `text` | `ds_serie` | `varchar(5)` | RENAME, RETYPE | Serie da NF; prefixo `ds_` |
| `data_emissao` | `timestamp` | `dt_emissao` | `date` | RENAME, RETYPE | Data sem componente horaria; converter para `date` |
| `situacao_nfisc` | `numeric(1)` | `id_situacao_nf` | `smallint` | RENAME, RETYPE | Codigo de situacao da NF; prefixo `id_` |
| `cgc_9` | `numeric(9)` | _(parte de `cnpj_cliente`)_ | — | REFORMAT | Parte 1 do CNPJ/CPF do cliente; consolidar em `cnpj_cliente` |
| `cgc_4` | `numeric(4)` | _(parte de `cnpj_cliente`)_ | — | REFORMAT | Parte 2 (filial) do CNPJ; consolidar |
| `cgc_2` | `numeric(2)` | _(parte de `cnpj_cliente`)_ | — | REFORMAT | Digitos verificadores; consolidar |
| _(consolidacao)_ | — | `cnpj_cliente` | `varchar(16)` | ADD | CNPJ/CPF do cliente reconstruido via `fn_formatar_cnpj_cpf`; nome canonical de `d_cliente` |
| `tipo_nf_referenciada` | `numeric(1)` | `id_tipo_nf_referenciada` | `smallint` | RENAME, RETYPE | Tipo de NF referenciada; prefixo `id_` |
| `classif_contabil_nf_item` | `numeric(6)` | `id_classif_contabil_item` | `integer` | RENAME, RETYPE | Classificacao contabil do item; prefixo `id_` |
| `desconta_ipi_icms` | `numeric(1)` | `fl_desconta_ipi_icms` | `boolean` | RENAME, RETYPE | Flag de deducao IPI/ICMS; converter para `boolean` |
| `classif_contabil` | `numeric(6)` | `id_classif_contabil` | `integer` | RENAME, RETYPE | Classificacao contabil da NF; prefixo `id_` |
| `cod_natureza` | `text` | `ds_natureza` | `varchar(20)` | RENAME, RETYPE | Codigo/descricao da natureza; prefixo `ds_` |
| `descr_nat_oper` | `text` | `ds_nat_operacao` | `varchar(60)` | RENAME, RETYPE | Descricao da natureza de operacao; prefixo `ds_` |
| `livros_fiscais` | `numeric(1)` | `fl_livros_fiscais` | `boolean` | RENAME, RETYPE | Flag de escrituracao em livros fiscais |
| `divisao_natur` | `numeric(2)` | `id_divisao_natureza` | `smallint` | RENAME, RETYPE | Codigo da divisao da natureza; prefixo `id_` |
| `classific_fiscal` | `text` | `ds_classif_fiscal_item` | `varchar(20)` | RENAME, RETYPE | Classificacao fiscal do item (campo duplicado de `classificacao_fiscal`; verificar se e o mesmo dado); prefixo `ds_` |
| `natopeno_nat_oper` | `numeric(3)` | `id_natureza_operacao` | `smallint` | RENAME, RETYPE | Codigo da natureza de operacao; prefixo `id_` |
| `natopeno_est_oper` | `text` | `ds_uf_nat_operacao` | `char(2)` | RENAME, RETYPE | UF da natureza de operacao; `char(2)` |
| `consiste_cvf_icms` | `numeric(1)` | `fl_consiste_cvf_icms` | `boolean` | RENAME, RETYPE | Flag de consistencia do CVF-ICMS |
| `rateio_despesa` | `numeric(15,2)` | `vl_rateio_despesas` | `numeric(15,2)` | RENAME | Valor de rateio de despesas; prefixo `vl_` |
| `rateio_desc_propaganda` | `numeric(15,2)` | `vl_rateio_desc_propaganda` | `numeric(15,2)` | RENAME | Valor de rateio de desconto de propaganda; prefixo `vl_` |
| `isento_outros` | `numeric(15,2)` | `vl_isento_outros` | `numeric(15,2)` | RENAME | Valor isento ou outros; prefixo `vl_` |
| `cod_justificativa` | `numeric(1)` | `id_justificativa` | `smallint` | RENAME, RETYPE | Codigo de justificativa; prefixo `id_` |
| `cvf_icms` | `numeric(2)` | `id_cvf_icms` | `smallint` | RENAME, RETYPE | Codigo do CVF-ICMS; prefixo `id_` |
| `cvf_ipi` | `numeric(1)` | `id_cvf_ipi` | `smallint` | RENAME, RETYPE | Codigo do CVF-IPI; prefixo `id_` |
| `cvf_icm_diferenc` | `numeric(9)` | `id_cvf_icms_diferenc` | `integer` | RENAME, RETYPE | Codigo de diferenca de CVF-ICMS; prefixo `id_` |
| `base_icms` | `numeric(15,2)` | `vl_base_icms` | `numeric(15,2)` | RENAME | Base de calculo ICMS; prefixo `vl_` |
| `base_icms_difer` | `numeric(15,2)` | `vl_base_icms_diferido` | `numeric(15,2)` | RENAME | Base ICMS diferido; prefixo `vl_` |
| `basi_pis_cofins` | `numeric(15,2)` | `vl_base_pis_cofins` | `numeric(15,2)` | RENAME | Base PIS/COFINS; prefixo `vl_`; corrigir nome (tinha `basi_` truncado) |
| `perc_icms` | `numeric(6,2)` | `pc_icms` | `numeric(7,4)` | RENAME, RETYPE | Percentual ICMS; prefixo `pc_`; padrao `numeric(7,4)` |
| `perc_ipi` | `numeric(6,2)` | `pc_ipi` | `numeric(7,4)` | RENAME, RETYPE | Percentual IPI; prefixo `pc_`; padrao `numeric(7,4)` |
| `perc_reducao_icm` | `numeric(8,4)` | `pc_reducao_icms` | `numeric(7,4)` | RENAME, RETYPE | Percentual de reducao da base ICMS; prefixo `pc_`; padrao `numeric(7,4)` |
| `perc_substituica` | `numeric(5,2)` | `pc_substituicao` | `numeric(7,4)` | RENAME, RETYPE | Percentual de substituicao tributaria; prefixo `pc_`; padrao `numeric(7,4)` |
| `perc_iva_1` | `numeric(6,2)` | `pc_iva` | `numeric(7,4)` | RENAME, RETYPE | Percentual IVA (Indice de Valor Adicionado); prefixo `pc_`; padrao `numeric(7,4)` |
| `valor_icms_difer` | `numeric(11,2)` | `vl_icms_diferido` | `numeric(15,2)` | RENAME, RETYPE | Valor ICMS diferido; prefixo `vl_`; padronizar para `numeric(15,2)` |
| `valor_ipi` | `numeric(15,2)` | `vl_ipi` | `numeric(15,2)` | RENAME | Valor IPI; prefixo `vl_` |
| `valor_pis` | `numeric(15,2)` | `vl_pis` | `numeric(15,2)` | RENAME | Valor PIS; prefixo `vl_` |
| `valor_icms` | `numeric(15,2)` | `vl_icms` | `numeric(15,2)` | RENAME | Valor ICMS; prefixo `vl_` |
| `valor_cofins` | `numeric(15,2)` | `vl_cofins` | `numeric(15,2)` | RENAME | Valor COFINS; prefixo `vl_` |
| `valor_faturado` | `numeric(15,2)` | `vl_faturado` | `numeric(15,2)` | RENAME | Valor faturado total; prefixo `vl_` |
| `valor_contabil` | `numeric(15,2)` | `vl_contabil` | `numeric(15,2)` | RENAME | Valor contabil da NF; prefixo `vl_` |
| `valor_unitario` | `numeric(18,5)` | `vl_unitario` | `numeric(15,5)` | RENAME, RETYPE | Valor unitario do item; prefixo `vl_`; reduzir de `numeric(18,5)` para `numeric(15,5)` — 5 casas para precisao em unitario |
| `qtde_item_fatur` | `numeric(15,3)` | `qt_item_faturado` | `numeric(15,3)` | RENAME | Quantidade faturada do item; prefixo `qt_` |
| _(ausente)_ | — | `id` | `bigserial` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [REFORMAT] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural de negocio candidata: `(id_empresa, nr_nota_fiscal, ds_serie)` — validar unicidade (a tabela pode ter um registro por NF ou por item; se por item, incluir `sku_produto` na chave quando disponivel).

#### Relacionamentos propostos

```
financeiro.f_apuracao_nf_saida
  |- id_empresa        -> (id_ operacional; sem dimensao formal)
  |- cnpj_cliente      -> comercial.d_cliente.cnpj_cliente
  |- nr_nota_fiscal    -> financeiro.d_consulta_nf.nr_nota_fiscal  (join informacional)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_apr_sai_empresa       ON financeiro.f_apuracao_nf_saida(id_empresa);
CREATE INDEX idx_f_apr_sai_dt_emissao    ON financeiro.f_apuracao_nf_saida(dt_emissao);
CREATE INDEX idx_f_apr_sai_nr_nf         ON financeiro.f_apuracao_nf_saida(nr_nota_fiscal);
CREATE INDEX idx_f_apr_sai_cnpj_cliente  ON financeiro.f_apuracao_nf_saida(cnpj_cliente);
CREATE INDEX idx_f_apr_sai_updated_at    ON financeiro.f_apuracao_nf_saida(updated_at);
```

#### Impacto no ETL

- As tres colunas `cgc_9`, `cgc_4`, `cgc_2` consolidam-se em `cnpj_cliente varchar(16)` usando `dw.fn_formatar_cnpj_cpf`; manter as colunas originais durante transicao.
- `perc_*` com `numeric(6,2)` ou `numeric(5,2)` -> `numeric(7,4)`: verificar se ha perda de dados (ex: `perc_reducao_icm` ja e `numeric(8,4)` — ao converter para `numeric(7,4)` checar range maximo dos dados).
- `valor_unitario numeric(18,5)`: reduzir para `numeric(15,5)` e seguro para valores monetarios unitarios com 5 casas.
- Dois campos duplicados de classificacao fiscal (`classificacao_fiscal` e `classific_fiscal`): confirmar com time de negocio se sao o mesmo dado ou dados distintos antes de consolidar.
- `data_emissao timestamp` -> `date`: checar uso da componente horaria nas DAGs.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE financeiro.fapuracao_notas_saida RENAME TO f_apuracao_nf_saida;

-- 2. Surrogate key
ALTER TABLE financeiro.f_apuracao_nf_saida
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Adicionar coluna cnpj_cliente consolidada
ALTER TABLE financeiro.f_apuracao_nf_saida
    ADD COLUMN cnpj_cliente varchar(16);

UPDATE financeiro.f_apuracao_nf_saida
    SET cnpj_cliente = dw.fn_formatar_cnpj_cpf(
        cgc_9::text,
        cgc_4::text,
        cgc_2::int
    );

-- 4. Renomear colunas
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN codigo_empresa            TO id_empresa;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN codificacao_contabil      TO id_codificacao_contabil;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN classificacao_fiscal      TO ds_classificacao_fiscal;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN num_nota_fiscal           TO nr_nota_fiscal;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN serie_nota_fisc           TO ds_serie;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN data_emissao              TO dt_emissao;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN situacao_nfisc            TO id_situacao_nf;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN tipo_nf_referenciada      TO id_tipo_nf_referenciada;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN classif_contabil_nf_item  TO id_classif_contabil_item;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN desconta_ipi_icms         TO fl_desconta_ipi_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN classif_contabil          TO id_classif_contabil;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN cod_natureza              TO ds_natureza;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN descr_nat_oper            TO ds_nat_operacao;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN divisao_natur             TO id_divisao_natureza;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN classific_fiscal          TO ds_classif_fiscal_item;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN natopeno_nat_oper         TO id_natureza_operacao;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN natopeno_est_oper         TO ds_uf_nat_operacao;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN consiste_cvf_icms         TO fl_consiste_cvf_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN rateio_despesa            TO vl_rateio_despesas;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN rateio_desc_propaganda    TO vl_rateio_desc_propaganda;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN isento_outros             TO vl_isento_outros;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN cod_justificativa         TO id_justificativa;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN cvf_icms                  TO id_cvf_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN cvf_ipi                   TO id_cvf_ipi;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN cvf_icm_diferenc          TO id_cvf_icms_diferenc;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN base_icms                 TO vl_base_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN base_icms_difer           TO vl_base_icms_diferido;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN basi_pis_cofins           TO vl_base_pis_cofins;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN perc_icms                 TO pc_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN perc_ipi                  TO pc_ipi;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN perc_reducao_icm          TO pc_reducao_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN perc_substituica          TO pc_substituicao;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN perc_iva_1                TO pc_iva;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_icms_difer          TO vl_icms_diferido;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_ipi                 TO vl_ipi;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_pis                 TO vl_pis;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_icms                TO vl_icms;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_cofins              TO vl_cofins;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_faturado            TO vl_faturado;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_contabil            TO vl_contabil;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN valor_unitario            TO vl_unitario;
ALTER TABLE financeiro.f_apuracao_nf_saida
    RENAME COLUMN qtde_item_fatur           TO qt_item_faturado;

-- 5. Retype (janela de manutencao)
ALTER TABLE financeiro.f_apuracao_nf_saida
    ALTER COLUMN id_empresa                 TYPE smallint  USING id_empresa::smallint,
    ALTER COLUMN id_codificacao_contabil    TYPE integer   USING id_codificacao_contabil::integer,
    ALTER COLUMN ds_classificacao_fiscal    TYPE varchar(20),
    ALTER COLUMN nr_nota_fiscal             TYPE integer   USING nr_nota_fiscal::integer,
    ALTER COLUMN ds_serie                   TYPE varchar(5),
    ALTER COLUMN dt_emissao                 TYPE date      USING dt_emissao::date,
    ALTER COLUMN id_situacao_nf             TYPE smallint  USING id_situacao_nf::smallint,
    ALTER COLUMN id_tipo_nf_referenciada    TYPE smallint  USING id_tipo_nf_referenciada::smallint,
    ALTER COLUMN id_classif_contabil_item   TYPE integer   USING id_classif_contabil_item::integer,
    ALTER COLUMN fl_desconta_ipi_icms       TYPE boolean   USING (fl_desconta_ipi_icms = 1),
    ALTER COLUMN id_classif_contabil        TYPE integer   USING id_classif_contabil::integer,
    ALTER COLUMN ds_natureza                TYPE varchar(20),
    ALTER COLUMN ds_nat_operacao            TYPE varchar(60),
    ALTER COLUMN fl_livros_fiscais          TYPE boolean   USING (fl_livros_fiscais = 1),
    ALTER COLUMN id_divisao_natureza        TYPE smallint  USING id_divisao_natureza::smallint,
    ALTER COLUMN ds_classif_fiscal_item     TYPE varchar(20),
    ALTER COLUMN id_natureza_operacao       TYPE smallint  USING id_natureza_operacao::smallint,
    ALTER COLUMN ds_uf_nat_operacao         TYPE char(2),
    ALTER COLUMN fl_consiste_cvf_icms       TYPE boolean   USING (fl_consiste_cvf_icms = 1),
    ALTER COLUMN id_justificativa           TYPE smallint  USING id_justificativa::smallint,
    ALTER COLUMN id_cvf_icms                TYPE smallint  USING id_cvf_icms::smallint,
    ALTER COLUMN id_cvf_ipi                 TYPE smallint  USING id_cvf_ipi::smallint,
    ALTER COLUMN id_cvf_icms_diferenc       TYPE integer   USING id_cvf_icms_diferenc::integer,
    ALTER COLUMN pc_icms                    TYPE numeric(7,4) USING pc_icms::numeric(7,4),
    ALTER COLUMN pc_ipi                     TYPE numeric(7,4) USING pc_ipi::numeric(7,4),
    ALTER COLUMN pc_reducao_icms            TYPE numeric(7,4) USING pc_reducao_icms::numeric(7,4),
    ALTER COLUMN pc_substituicao            TYPE numeric(7,4) USING pc_substituicao::numeric(7,4),
    ALTER COLUMN pc_iva                     TYPE numeric(7,4) USING pc_iva::numeric(7,4),
    ALTER COLUMN vl_icms_diferido           TYPE numeric(15,2) USING vl_icms_diferido::numeric(15,2),
    ALTER COLUMN vl_unitario                TYPE numeric(15,5) USING vl_unitario::numeric(15,5);

-- 6. Auditoria
ALTER TABLE financeiro.f_apuracao_nf_saida
    ADD COLUMN created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp DEFAULT current_timestamp;

-- 7. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW financeiro.fapuracao_notas_saida AS
    SELECT * FROM financeiro.f_apuracao_nf_saida;
COMMENT ON VIEW financeiro.fapuracao_notas_saida IS
    'DEPRECATED 2026-05-05: usar f_apuracao_nf_saida. Sera removido em 2026-08-03.';
```

---

### financeiro.forion_orcamento

**Nome proposto:** `financeiro.f_orcamento`
**Tipo:** fato
**Descricao:** Registra os valores orcados por centro de custo, conta contabil e periodo (mes/ano), provenientes do sistema Orion de gestao orcamentaria. Serve de base para analise de desvio entre orcado e realizado.
**Sistema de origem:** Orion (sistema de orcamento corporativo)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `numeric(6)` | `id` | `bigserial` | RETYPE | Surrogate key; manter nome `id`; converter de `numeric(6)` para `bigserial` para seguir padrao DW |
| `centro_custo` | `text` | `ds_centro_custo` | `varchar(60)` | RENAME, RETYPE | Descricao ou codigo do centro de custo; prefixo `ds_`; `text` excessivo |
| `plano_ano` | `numeric(38)` | `nr_plano_ano` | `integer` | RENAME, RETYPE | Numero do plano orcamentario por ano; `numeric(38)` excessivo — `integer` suficiente; prefixo `nr_` |
| `conta` | `text` | `ds_conta` | `varchar(40)` | RENAME, RETYPE | Descricao ou codigo da conta contabil; prefixo `ds_` |
| `fornecedor` | `text` | `nm_fornecedor` | `varchar(100)` | RENAME, RETYPE | Nome do fornecedor vinculado ao orcamento; prefixo `nm_` |
| `despesa` | `text` | `ds_despesa` | `varchar(100)` | RENAME, RETYPE | Descricao da despesa orcada; prefixo `ds_` |
| `tipo_orcamento` | `text` | `ds_tipo_orcamento` | `varchar(30)` | RENAME, RETYPE | Tipo de orcamento (ex: operacional, capital); prefixo `ds_` |
| `cargo` | `text` | `ds_cargo` | `varchar(60)` | RENAME, RETYPE | Cargo vinculado ao orcamento (ex: para despesas de pessoal); prefixo `ds_` |
| `ano` | `numeric(4)` | `nr_ano` | `smallint` | RENAME, RETYPE | Ano do orcamento; `smallint` suficiente; prefixo `nr_` |
| `mes` | `numeric(38,10)` | `nr_mes` | `smallint` | RENAME, RETYPE | Mes do orcamento (1-12); `numeric(38,10)` completamente inadequado — `smallint` suficiente |
| `mes_ano` | `timestamp` | `dt_mes_ano` | `date` | RENAME, RETYPE | Data de referencia do mes/ano orcado; converter para `date`; prefixo `dt_` |
| `quantidade` | `numeric(3)` | `qt_quantidade` | `smallint` | RENAME, RETYPE | Quantidade orcada (ex: numero de colaboradores); `smallint` suficiente; prefixo `qt_` |
| `valor_orcado` | `numeric(10,2)` | `vl_orcado` | `numeric(15,2)` | RENAME, RETYPE | Valor orcado; prefixo `vl_`; padronizar para `numeric(15,2)` |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

A coluna `id` existente e `numeric(6)`, provavelmente auto-incrementada no sistema de origem. Converter para `bigserial` ou manter como `integer` com `NOT NULL UNIQUE` e adicionar `bigserial` como nova PK, dependendo de como o ETL trata o campo.

Opcao alternativa — manter `id` original como business key:
```sql
-- id original vira campo de negocio
ALTER TABLE financeiro.f_orcamento RENAME COLUMN id TO id_orion;
-- nova surrogate key:
ALTER TABLE financeiro.f_orcamento ADD COLUMN id bigserial PRIMARY KEY;
```

Chave natural de negocio candidata: `(nr_plano_ano, ds_centro_custo, ds_conta, nr_ano, nr_mes)` — avaliar unicidade.

#### Relacionamentos propostos

```
financeiro.f_orcamento
  |- ds_centro_custo  -> (sem dimensao formal de centro de custo; id_ operacional)
  |- nr_ano, nr_mes   -> referencia temporal
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_orcamento_nr_ano          ON financeiro.f_orcamento(nr_ano);
CREATE INDEX idx_f_orcamento_nr_mes          ON financeiro.f_orcamento(nr_mes);
CREATE INDEX idx_f_orcamento_dt_mes_ano      ON financeiro.f_orcamento(dt_mes_ano);
CREATE INDEX idx_f_orcamento_ds_centro_custo ON financeiro.f_orcamento(ds_centro_custo);
CREATE INDEX idx_f_orcamento_updated_at      ON financeiro.f_orcamento(updated_at);
```

#### Impacto no ETL

- `mes numeric(38,10)` e o tipo mais inadequado do schema — o ETL pode estar enviando um float; verificar se os valores sao inteiros puros antes de converter para `smallint`.
- `plano_ano numeric(38)` — mesma verificacao; confirmar que nao ha casas decimais.
- `mes_ano timestamp`: se o ETL usa esta coluna como watermark, manter como `timestamp` ate migrar a logica de carga para `updated_at`.
- `id numeric(6)`: se o sistema Orion gera o `id`, o ETL nao deve sobrescrever — manter como `id_orion integer` e criar novo `id bigserial` como PK interna do DW.
- `quantidade numeric(3)`: verificar se ha valores 0-999 apenas (range de `smallint` e -32768 a 32767).

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE financeiro.forion_orcamento RENAME TO f_orcamento;

-- 2. Tratar coluna id existente (id do Orion -> id_orion; nova PK bigserial)
ALTER TABLE financeiro.f_orcamento RENAME COLUMN id TO id_orion;
ALTER TABLE financeiro.f_orcamento
    ALTER COLUMN id_orion TYPE integer USING id_orion::integer;
ALTER TABLE financeiro.f_orcamento
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear colunas
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN centro_custo      TO ds_centro_custo;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN plano_ano         TO nr_plano_ano;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN conta             TO ds_conta;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN fornecedor        TO nm_fornecedor;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN despesa           TO ds_despesa;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN tipo_orcamento    TO ds_tipo_orcamento;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN cargo             TO ds_cargo;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN ano               TO nr_ano;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN mes               TO nr_mes;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN mes_ano           TO dt_mes_ano;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN quantidade        TO qt_quantidade;
ALTER TABLE financeiro.f_orcamento
    RENAME COLUMN valor_orcado      TO vl_orcado;

-- 4. Retype
ALTER TABLE financeiro.f_orcamento
    ALTER COLUMN nr_plano_ano       TYPE integer   USING nr_plano_ano::integer,
    ALTER COLUMN ds_centro_custo    TYPE varchar(60),
    ALTER COLUMN ds_conta           TYPE varchar(40),
    ALTER COLUMN nm_fornecedor      TYPE varchar(100),
    ALTER COLUMN ds_despesa         TYPE varchar(100),
    ALTER COLUMN ds_tipo_orcamento  TYPE varchar(30),
    ALTER COLUMN ds_cargo           TYPE varchar(60),
    ALTER COLUMN nr_ano             TYPE smallint  USING nr_ano::smallint,
    ALTER COLUMN nr_mes             TYPE smallint  USING nr_mes::smallint,
    ALTER COLUMN dt_mes_ano         TYPE date      USING dt_mes_ano::date,
    ALTER COLUMN qt_quantidade      TYPE smallint  USING qt_quantidade::smallint,
    ALTER COLUMN vl_orcado          TYPE numeric(15,2) USING vl_orcado::numeric(15,2);

-- 5. Auditoria
ALTER TABLE financeiro.f_orcamento
    ADD COLUMN created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp DEFAULT current_timestamp;

-- 6. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW financeiro.forion_orcamento AS
    SELECT * FROM financeiro.f_orcamento;
COMMENT ON VIEW financeiro.forion_orcamento IS
    'DEPRECATED 2026-05-05: usar f_orcamento. Sera removido em 2026-08-03.';
```

---

### financeiro.ftitulos_receber_resumo

**Nome proposto:** `financeiro.f_titulo_receber`
**Tipo:** fato
**Descricao:** Resumo dos titulos a receber por cliente, com situacao da duplicata, valores de desconto concedido e valor pago, e data do ultimo pagamento. Base para relatorios de inadimplencia e fluxo de caixa.
**Sistema de origem:** Systextil (modulo financeiro — contas a receber)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `num_titulo` | `text` | `nr_titulo` | `varchar(20)` | RENAME, RETYPE | Numero do titulo; prefixo `nr_`; `text` sem limite e excessivo |
| `cnpj_cliente` | `text` | `cnpj_cliente` | `varchar(16)` | RETYPE | Nome ja esta correto e canonical; apenas ajustar tipo de `text` para `varchar(16)` |
| `pk_cliente` | `text` | `cod_cliente` | `varchar(20)` | RENAME | PK do sistema de origem vira join key canonical `cod_cliente`; tipo `varchar(20)` conforme dicionario de entidades |
| `nome_cliente` | `text` | `nm_cliente` | `varchar(70)` | RENAME, RETYPE | Nome do cliente; prefixo `nm_`; limitar tamanho |
| `descricao` | `text` | `ds_titulo` | `text` | RENAME | Descricao do titulo; prefixo `ds_`; manter `text` pois pode ser longa |
| `cod_situa_duplic` | `numeric(1)` | `id_situacao_duplicata` | `smallint` | RENAME, RETYPE | Codigo de situacao da duplicata; prefixo `id_`; `smallint` adequado |
| `val_desconto` | `numeric(15,2)` | `vl_desconto` | `numeric(15,2)` | RENAME | Valor de desconto concedido; prefixo `vl_` |
| `val_pago` | `numeric(38,10)` | `vl_pago` | `numeric(15,2)` | RENAME, RETYPE | Valor pago; prefixo `vl_`; `numeric(38,10)` excessivo — padrao `numeric(15,2)` |
| `dat_ult_pagto_aux` | `timestamp` | `dt_ultimo_pagamento` | `date` | RENAME, RETYPE | Data do ultimo pagamento; sem componente horaria relevante; prefixo `dt_`; nome completo |
| _(ausente)_ | — | `id` | `bigserial` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural de negocio candidata: `nr_titulo` ou `(nr_titulo, cod_cliente)` — validar unicidade nos dados antes de aplicar UNIQUE constraint.

#### Relacionamentos propostos

```
financeiro.f_titulo_receber
  |- cod_cliente    -> comercial.d_cliente.cod_cliente
  |- cnpj_cliente   -> comercial.d_cliente.cnpj_cliente  (join alternativo)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_titulo_rec_cod_cliente        ON financeiro.f_titulo_receber(cod_cliente);
CREATE INDEX idx_f_titulo_rec_cnpj_cliente       ON financeiro.f_titulo_receber(cnpj_cliente);
CREATE INDEX idx_f_titulo_rec_nr_titulo          ON financeiro.f_titulo_receber(nr_titulo);
CREATE INDEX idx_f_titulo_rec_id_situacao        ON financeiro.f_titulo_receber(id_situacao_duplicata);
CREATE INDEX idx_f_titulo_rec_dt_ult_pagamento   ON financeiro.f_titulo_receber(dt_ultimo_pagamento);
CREATE INDEX idx_f_titulo_rec_updated_at         ON financeiro.f_titulo_receber(updated_at);
```

#### Impacto no ETL

- `pk_cliente text` -> `cod_cliente varchar(20)`: validar que todos os valores de `pk_cliente` existem em `comercial.d_cliente.cod_cliente` antes de renomear; esse e o join key mais critico da tabela.
- `val_pago numeric(38,10)` -> `numeric(15,2)`: checar se ha valores com mais de 2 casas decimais significativas; a perda de precisao pode impactar conciliacao financeira.
- `cnpj_cliente text` -> `varchar(16)`: verificar se os dados ja estao no formato `XXXXXXXX/YYYY-ZZ` ou se precisam ser reformatados; se estiverem como texto livre, aplicar `fn_formatar_cnpj_cpf` no pipeline.
- `dat_ult_pagto_aux timestamp` -> `date`: nome `_aux` sugere campo auxiliar de processamento; confirmar com time de negocio se a componente horaria e necessaria.
- Esta tabela e "resumo" — verificar se ha tabela de titulos detalhadada em outro schema (ex: `temporario.financeiro_ftitulos_receber_resumo`) para consolidar ou manter separadas.

#### Migracao SQL

```sql
-- 1. Renomear tabela
ALTER TABLE financeiro.ftitulos_receber_resumo RENAME TO f_titulo_receber;

-- 2. Surrogate key
ALTER TABLE financeiro.f_titulo_receber
    ADD COLUMN id bigserial PRIMARY KEY;

-- 3. Renomear colunas
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN num_titulo         TO nr_titulo;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN pk_cliente         TO cod_cliente;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN nome_cliente       TO nm_cliente;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN descricao          TO ds_titulo;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN cod_situa_duplic   TO id_situacao_duplicata;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN val_desconto       TO vl_desconto;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN val_pago           TO vl_pago;
ALTER TABLE financeiro.f_titulo_receber
    RENAME COLUMN dat_ult_pagto_aux  TO dt_ultimo_pagamento;

-- 4. Retype
ALTER TABLE financeiro.f_titulo_receber
    ALTER COLUMN nr_titulo              TYPE varchar(20),
    ALTER COLUMN cnpj_cliente           TYPE varchar(16),
    ALTER COLUMN cod_cliente            TYPE varchar(20),
    ALTER COLUMN nm_cliente             TYPE varchar(70),
    ALTER COLUMN id_situacao_duplicata  TYPE smallint  USING id_situacao_duplicata::smallint,
    ALTER COLUMN vl_pago                TYPE numeric(15,2) USING vl_pago::numeric(15,2),
    ALTER COLUMN dt_ultimo_pagamento    TYPE date      USING dt_ultimo_pagamento::date;

-- 5. Auditoria
ALTER TABLE financeiro.f_titulo_receber
    ADD COLUMN created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp DEFAULT current_timestamp;

-- 6. View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW financeiro.ftitulos_receber_resumo AS
    SELECT * FROM financeiro.f_titulo_receber;
COMMENT ON VIEW financeiro.ftitulos_receber_resumo IS
    'DEPRECATED 2026-05-05: usar f_titulo_receber. Sera removido em 2026-08-03.';
```

---

## Resumo das Alteracoes

### Contagem de flags por tabela

| Tabela | RENAME | RETYPE | REFORMAT | ADD | DROP | CONFLITO |
|---|---|---|---|---|---|---|
| `d_consulta_nf` | 11 | 2 | 0 | 3 | 0 | 1 |
| `f_lancamento_contabil` | 16 | 14 | 0 | 2 | 0 | 0 |
| `f_apuracao_nf_entrada` | 38 | 20 | 3 | 4 | 0 | 0 |
| `f_apuracao_nf_saida` | 44 | 28 | 3 | 4 | 0 | 0 |
| `f_orcamento` | 12 | 10 | 0 | 3 | 0 | 0 |
| `f_titulo_receber` | 8 | 6 | 0 | 3 | 0 | 0 |

### Problemas criticos identificados

| Problema | Tabelas afetadas | Acao |
|---|---|---|
| `numeric(38,10)` para valores monetarios | `f_lancamento_contabil`, `f_apuracao_nf_entrada`, `f_titulo_receber` | Converter para `numeric(15,2)` apos checagem de precisao |
| CNPJ fragmentado em 3 colunas | `f_apuracao_nf_entrada`, `f_apuracao_nf_saida` | Consolidar com `fn_formatar_cnpj_cpf` |
| `timestamp` em campos so-data | Todas as 6 tabelas | Converter para `date` apos checar uso de hora nas DAGs |
| Ausencia de surrogate key (`id bigserial`) | Todas as 6 tabelas | Adicionar `id bigserial PRIMARY KEY` |
| Ausencia de colunas de auditoria | Todas as 6 tabelas | Adicionar `created_at`, `updated_at` |
| `pk_cliente` como nome de join key | `f_titulo_receber` | Renomear para `cod_cliente` (join key canonical) |
| `perc_*` com tipo inadequado | `f_apuracao_nf_saida` | Converter para `numeric(7,4)` |
| `numeric(38)` sem casas decimais | `f_orcamento` (colunas `plano_ano`, `mes`) | Converter para `integer`/`smallint` |

### Convencoes de CNPJ adotadas

Seguindo a secao 7 das boas praticas:

| Campo | Tabela | Nome canonical |
|---|---|---|
| `cgc_cli_for_9/4/2` | `f_apuracao_nf_entrada` | `cnpj_fornecedor varchar(16)` |
| `cgc_9/4/2` | `f_apuracao_nf_saida` | `cnpj_cliente varchar(16)` |
| `cnpj_cliente text` | `f_titulo_receber` | `cnpj_cliente varchar(16)` (apenas retype) |

### Ordem de execucao recomendada

1. Validar dados criticos antes da migracao (valores com mais de 2 casas decimais em `numeric(38,10)`, valores nao numericos em colunas de NF, range de `cod_representante`).
2. Pausar DAGs do schema `financeiro`.
3. Executar migracao tabela por tabela na ordem: `f_titulo_receber` (menor impacto) -> `f_orcamento` -> `d_consulta_nf` -> `f_lancamento_contabil` -> `f_apuracao_nf_entrada` -> `f_apuracao_nf_saida`.
4. Criar views de compatibilidade antes de reativar DAGs.
5. Atualizar aliases nos pipelines Airflow para usar novos nomes de colunas.
6. Agendar remocao das views de compatibilidade para 2026-08-03.
