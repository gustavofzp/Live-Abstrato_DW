# Dicionario de Dados — Schema `sustentabilidade`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — pendente validacao com equipe de sustentabilidade
**Escopo:** 5 tabelas | 81 colunas
**Responsavel:** Especialista DW — Schema sustentabilidade

---

## Visao Geral do Schema

O schema `sustentabilidade` centraliza os dados de gestao ambiental e energetica da organizacao. Abrange dois dominios principais:

- **Energia:** consumo horario de energia eletrica (`f_consumo_energia`), controle mensal financeiro-energetico (`f_controle_energia`) e notas fiscais de compra de energia (`f_notas_energia`).
- **Residuos:** registros de descarte e destinacao de residuos (`f_descarte_residuos`) e notas fiscais de servicos de coleta/destinacao (`f_notas_residuos`).

Todas as 5 tabelas possuem prefixo `f` (fato) na nomenclatura atual, mas nenhuma possui surrogate key (`id bigserial PRIMARY KEY`) nem colunas de auditoria padrao (`created_at`, `updated_at`). A migracao proposta corrige essas lacunas e padroniza nomenclatura conforme as boas praticas do DW.

---

## Indice de Tabelas

| Nome atual | Nome proposto | Tipo | Colunas |
|---|---|---|---|
| `sustentabilidade.fconsumo_energia` | `sustentabilidade.f_consumo_energia` | fato | 7 + 3 (auditoria/PK) |
| `sustentabilidade.fcontrole_energia` | `sustentabilidade.f_controle_energia` | fato | 33 + 3 (auditoria/PK) |
| `sustentabilidade.fdescarte_residuos` | `sustentabilidade.f_descarte_residuos` | fato | 8 + 2 (auditoria) |
| `sustentabilidade.fnotas_energia` | `sustentabilidade.f_notas_energia` | fato | 14 + 3 (auditoria/PK) |
| `sustentabilidade.fnotas_residuos` | `sustentabilidade.f_notas_residuos` | fato | 19 + 2 (auditoria) |

---

## Detalhamento por Tabela

---

### sustentabilidade.fconsumo_energia

**Nome proposto:** `sustentabilidade.f_consumo_energia`
**Tipo:** fato
**Descricao:** Registra o consumo horario de energia eletrica medido por equipamentos de telemetria (medidores inteligentes). Cada linha representa uma leitura de um periodo horario, com os valores de energia ativa consumida, ativa fornecida, reativa e consumo em hora cheia. E a tabela de maior granularidade do schema — base para analises de perfil de carga e gestao de demanda.
**Sistema de origem:** Sistema de telemetria / medidores de energia (API ou coleta batch); dados brutos provavelmente extraidos de planilhas ou sistema SCADA.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `data_hora` | `timestamp NULL` | `dth_referencia` | `timestamp NOT NULL` | RENAME | Prefixo `dth_` obrigatorio para data+hora; nome `referencia` reflete que e o instante da medicao; NOT NULL pois e a chave temporal do fato |
| `ativo_consumido` | `numeric NULL` | `qt_ativo_consumido` | `numeric(15,3) NULL` | RENAME, RETYPE | Prefixo `qt_` para grandeza fisica (kWh); precisao 3 casas padrao para quantidades; tipo sem precisao explicita e proibido |
| `ativo_fornecido` | `numeric NULL` | `qt_ativo_fornecido` | `numeric(15,3) NULL` | RENAME, RETYPE | Mesma justificativa: grandeza fisica com prefixo `qt_` |
| `reativo` | `numeric NULL` | `qt_reativo` | `numeric(15,3) NULL` | RENAME, RETYPE | Energia reativa (kVAr); prefixo `qt_` e precisao padrao |
| `periodo` | `text NULL` | `ds_periodo` | `varchar(30) NULL` | RENAME, RETYPE | Descricao textual do periodo (ex.: "Ponta", "Fora Ponta"); prefixo `ds_`; substituir `text` aberto por `varchar` com tamanho controlado |
| `hora_cheia` | `bool NULL` | `fl_hora_cheia` | `boolean NULL` | RENAME | Prefixo `fl_` obrigatorio para booleanos; nome semantico mantido |
| `consumo_hora_cheia` | `numeric NULL` | `qt_consumo_hora_cheia` | `numeric(15,3) NULL` | RENAME, RETYPE | Grandeza fisica; prefixo `qt_`; precisao padrao |
| _(ausente)_ | — | `id` | `bigserial NOT NULL` | ADD | Surrogate key obrigatoria em toda tabela de fato do DW |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria e watermark para carga incremental |

**Flags utilizadas nesta tabela:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Nao existe chave natural unica identificavel com segurança apenas por `dth_referencia`, pois o sistema de origem pode gerar mais de uma leitura por timestamp (ex.: multiplos medidores). Recomenda-se investigar se ha identificador de medidor no sistema de origem; caso confirmado, adicionar `id_medidor smallint` e criar UNIQUE em `(dth_referencia, id_medidor)`.

#### Relacionamentos propostos

Esta tabela nao possui join keys canonicas identificadas no DDL atual. Nao ha referencia direta a dimensoes do DW (empresa, local, medidor). Relacionamentos futuros esperados apos enriquecimento:

```
sustentabilidade.f_consumo_energia
  |- id_medidor (futuro) -> sustentabilidade.d_medidor.id (a criar)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_consumo_energia_dth_referencia
    ON sustentabilidade.f_consumo_energia (dth_referencia);

CREATE INDEX idx_f_consumo_energia_fl_hora_cheia
    ON sustentabilidade.f_consumo_energia (fl_hora_cheia);
```

#### Impacto no ETL

- A DAG de ingestao deve renomear todas as colunas no SELECT antes de inserir: `data_hora AS dth_referencia`, `ativo_consumido AS qt_ativo_consumido`, etc.
- Incluir filtro `WHERE data_hora > :ultima_carga` usando `updated_at` como watermark apos adicao da coluna.
- Validar que `dth_referencia` nunca seja NULL antes do insert (rejeitar ou alertar registros sem timestamp).
- O tipo `numeric` sem precisao no sistema de origem deve ser lido como `float64` no pandas e convertido para `Decimal` antes do insert para evitar perda de precisao.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE sustentabilidade.fconsumo_energia
    RENAME TO f_consumo_energia;

-- Passo 2: Adicionar surrogate key e colunas de auditoria
ALTER TABLE sustentabilidade.f_consumo_energia
    ADD COLUMN id bigserial PRIMARY KEY;

ALTER TABLE sustentabilidade.f_consumo_energia
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- Passo 3: Renomear colunas
ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN data_hora TO dth_referencia;

ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN ativo_consumido TO qt_ativo_consumido;

ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN ativo_fornecido TO qt_ativo_fornecido;

ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN reativo TO qt_reativo;

ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN periodo TO ds_periodo;

ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN hora_cheia TO fl_hora_cheia;

ALTER TABLE sustentabilidade.f_consumo_energia
    RENAME COLUMN consumo_hora_cheia TO qt_consumo_hora_cheia;

-- Passo 4: Ajustar tipos
ALTER TABLE sustentabilidade.f_consumo_energia
    ALTER COLUMN qt_ativo_consumido TYPE numeric(15,3),
    ALTER COLUMN qt_ativo_fornecido TYPE numeric(15,3),
    ALTER COLUMN qt_reativo TYPE numeric(15,3),
    ALTER COLUMN qt_consumo_hora_cheia TYPE numeric(15,3),
    ALTER COLUMN ds_periodo TYPE varchar(30);

-- Passo 5: Criar indices
CREATE INDEX idx_f_consumo_energia_dth_referencia
    ON sustentabilidade.f_consumo_energia (dth_referencia);

CREATE INDEX idx_f_consumo_energia_fl_hora_cheia
    ON sustentabilidade.f_consumo_energia (fl_hora_cheia);

-- Passo 6: View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW sustentabilidade.fconsumo_energia AS
    SELECT * FROM sustentabilidade.f_consumo_energia;
COMMENT ON VIEW sustentabilidade.fconsumo_energia IS
    'DEPRECATED 2026-05-05: usar f_consumo_energia. Sera removido em 2026-08-03.';
```

---

### sustentabilidade.fcontrole_energia

**Nome proposto:** `sustentabilidade.f_controle_energia`
**Tipo:** fato
**Descricao:** Tabela de controle mensal de energia eletrica. Agrega, por data (geralmente granularidade diaria ou mensal), as informacoes de geracao fotovoltaica (inversores GoodWe e SunWeg), consumo faturado pela distribuidora CELESC, faturas da comercializadora MLE e calculos de economia derivados da energia solar e do contrato de energia livre. E a principal tabela de analise financeiro-energetica do schema, com 33 colunas de metricas calculadas.
**Sistema de origem:** Planilhas de controle energetico / ERP financeiro / leituras dos inversores (APIs GoodWe e SunWeg); dados consolidados manualmente ou via script Python.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `data` | `date NULL` | `dt_referencia` | `date NOT NULL` | RENAME | Prefixo `dt_` para campo so-data; NOT NULL pois e a chave temporal do fato mensal |
| `goodwe_kwh` | `numeric(12,2) NULL` | `qt_geracao_goodwe_kwh` | `numeric(15,3) NULL` | RENAME, RETYPE | Grandeza fisica (kWh); prefixo `qt_`; precisao 3 casas para compatibilidade com padrao de quantidade; nome mais descritivo identifica a fonte |
| `sunweg_kwh` | `numeric(12,2) NULL` | `qt_geracao_sunweg_kwh` | `numeric(15,3) NULL` | RENAME, RETYPE | Idem: geracao do inversor SunWeg em kWh |
| `geracao_total` | `numeric(14,2) NULL` | `qt_geracao_total_kwh` | `numeric(15,3) NULL` | RENAME, RETYPE | Soma das geracoes; `qt_` + sufixo `_kwh` deixa a unidade explicita |
| `ano` | `numeric NULL` | `nr_ano` | `smallint NULL` | RENAME, RETYPE | Numero de ano (ex.: 2026); `nr_` para sequencial; `smallint` adequado (valores <32k) |
| `mes` | `varchar(20) NULL` | `ds_mes` | `varchar(20) NULL` | RENAME | Descricao textual do mes (ex.: "Janeiro"); prefixo `ds_` |
| `kwh_faturado` | `numeric(12,2) NULL` | `qt_kwh_faturado` | `numeric(15,3) NULL` | RENAME, RETYPE | Quantidade de kWh na fatura; prefixo `qt_`; precisao 3 casas |
| `fatura_celesc` | `numeric(12,2) NULL` | `vl_fatura_celesc` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor monetario (R$); prefixo `vl_`; precisao padrao `numeric(15,2)` |
| `fatura_mle` | `numeric(12,2) NULL` | `vl_fatura_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor monetario; prefixo `vl_` |
| `fatura_total` | `numeric(12,2) NULL` | `vl_fatura_total` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor monetario; prefixo `vl_` |
| `rs_kwh_faturado` | `numeric(12,2) NULL` | `vl_rs_kwh_faturado` | `numeric(15,2) NULL` | RENAME, RETYPE | Custo unitario (R$/kWh) do kWh faturado; prefixo `vl_` para valor monetario unitario |
| `rs_kwh_distribuicao` | `numeric(12,2) NULL` | `vl_rs_kwh_distribuicao` | `numeric(15,2) NULL` | RENAME, RETYPE | Custo da componente de distribuicao por kWh |
| `rs_kwh_energia` | `numeric(12,2) NULL` | `vl_rs_kwh_energia` | `numeric(15,2) NULL` | RENAME, RETYPE | Custo da componente de energia por kWh |
| `pct_distribuicao` | `numeric(7,4) NULL` | `pc_distribuicao` | `numeric(7,4) NULL` | RENAME | Prefixo `pc_` para percentual; tipo ja adequado |
| `pct_energia` | `numeric(7,4) NULL` | `pc_energia` | `numeric(7,4) NULL` | RENAME | Prefixo `pc_` para percentual |
| `ufv_live` | `numeric(12,2) NULL` | `qt_ufv_live_kwh` | `numeric(15,3) NULL` | RENAME, RETYPE | Unidade Fotovoltaica da Live (kWh); `qt_` + sufixo `_kwh`; nome descritivo |
| `pct_geracao` | `numeric(7,4) NULL` | `pc_geracao` | `numeric(7,4) NULL` | RENAME | Percentual de geracao solar sobre consumo; prefixo `pc_` |
| `rs_econ_ufv` | `numeric(12,2) NULL` | `vl_economia_ufv` | `numeric(15,2) NULL` | RENAME, RETYPE | Economia monetaria gerada pela UFV; prefixo `vl_`; nome mais legivel sem abreviacao `rs_econ_` |
| `kwh_real` | `numeric(12,2) NULL` | `qt_kwh_real` | `numeric(15,3) NULL` | RENAME, RETYPE | Consumo real (descontada geracao solar); `qt_` |
| `fatura_sem_mle` | `numeric(12,2) NULL` | `vl_fatura_sem_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor hipotetico da fatura sem contrato MLE; `vl_` |
| `rs_econ_mle` | `numeric(12,2) NULL` | `vl_economia_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Economia gerada pelo contrato MLE; prefixo `vl_` |
| `pct_economia_bruto_mle` | `numeric(7,4) NULL` | `pc_economia_bruto_mle` | `numeric(7,4) NULL` | RENAME | Percentual de economia bruta MLE; prefixo `pc_` |
| `taxas_mle` | `numeric(12,2) NULL` | `vl_taxas_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor das taxas cobradas pela MLE; `vl_` |
| `comissao_mle` | `numeric(12,2) NULL` | `vl_comissao_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Comissao paga a MLE; `vl_` |
| `venda_energia_mle` | `numeric(12,2) NULL` | `vl_venda_energia_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Receita de venda de energia via MLE; `vl_` |
| `saldo_encargos_mle` | `numeric(12,2) NULL` | `vl_saldo_encargos_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Saldo de encargos do contrato MLE; `vl_` |
| `liquido_mle` | `numeric(12,2) NULL` | `vl_liquido_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Resultado liquido do contrato MLE; `vl_` |
| `pct_economia_liquido_mle` | `numeric(7,4) NULL` | `pc_economia_liquido_mle` | `numeric(7,4) NULL` | RENAME | Percentual de economia liquida MLE; prefixo `pc_` |
| `rs_fatura_consumo_real` | `numeric(12,2) NULL` | `vl_fatura_consumo_real` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor da fatura baseado no consumo real; `vl_` |
| `rs_fat_sem_ufv_mle` | `numeric(12,2) NULL` | `vl_fatura_sem_ufv_mle` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor hipotetico da fatura sem UFV e sem MLE; nome mais legivel; `vl_` |
| `economia_operacao` | `numeric(12,2) NULL` | `vl_economia_operacao` | `numeric(15,2) NULL` | RENAME, RETYPE | Economia operacional total; `vl_` |
| `economia_bruta` | `numeric(12,2) NULL` | `vl_economia_bruta` | `numeric(15,2) NULL` | RENAME, RETYPE | Economia bruta total; `vl_` |
| `data_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME | Coluna de auditoria canonicaconforme boas praticas (secao 4 e 15.4); `dthora_atualizacao` e `data_atualizacao` sempre mapeiam para `updated_at` |
| `ano_temp` | `numeric NULL` | _(DROP)_ | — | DROP | Campo temporario de controle de ETL sem valor analitico; semantica duplica `nr_ano`; remover apos validacao com equipe |
| _(ausente)_ | — | `id` | `bigserial NOT NULL` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags utilizadas nesta tabela:** [RENAME] [RETYPE] [ADD] [DROP]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(dt_referencia)` — assumindo granularidade diaria e uma linha por dia. Verificar com a equipe se pode haver mais de uma linha por data (ex.: diferentes unidades). Se confirmada unicidade, adicionar:

```sql
ALTER TABLE sustentabilidade.f_controle_energia
    ADD CONSTRAINT uq_f_controle_energia_dt UNIQUE (dt_referencia);
```

#### Relacionamentos propostos

Nao ha join keys canonicas explicitamente presentes. A tabela e auto-contida com metricas financeiro-energeticas mensais.

```
sustentabilidade.f_controle_energia
  (sem joins externos identificados no DDL atual)
  (futuro: id_empresa -> se houver controle por filial)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_controle_energia_dt_referencia
    ON sustentabilidade.f_controle_energia (dt_referencia);

CREATE INDEX idx_f_controle_energia_nr_ano
    ON sustentabilidade.f_controle_energia (nr_ano);
```

#### Impacto no ETL

- 33 renomeacoes de colunas exigem refatoracao completa do SELECT de ingestao.
- Campo `ano_temp` deve ser removido do INSERT apos confirmacao de drop — validar que nenhum dashboard ou DAG downstream consome este campo antes da remocao.
- `data_atualizacao` ja funciona como watermark; renomear para `updated_at` e ajustar o parametro de watermark na DAG.
- Valores `rs_*` (custo unitario R$/kWh) e valores monetarios com `numeric(12,2)` devem ser promovidos para `numeric(15,2)` — ajustar `dtype` no `to_sql`.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE sustentabilidade.fcontrole_energia
    RENAME TO f_controle_energia;

-- Passo 2: Adicionar surrogate key e created_at
ALTER TABLE sustentabilidade.f_controle_energia
    ADD COLUMN id bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Passo 3: Renomear data_atualizacao para updated_at
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN data_atualizacao TO updated_at;

-- Passo 4: Renomear coluna de data
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN "data" TO dt_referencia;

-- Passo 5: Renomear colunas de geracao
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN goodwe_kwh TO qt_geracao_goodwe_kwh;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN sunweg_kwh TO qt_geracao_sunweg_kwh;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN geracao_total TO qt_geracao_total_kwh;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN kwh_faturado TO qt_kwh_faturado;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN ufv_live TO qt_ufv_live_kwh;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN kwh_real TO qt_kwh_real;

-- Passo 6: Renomear colunas de periodo
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN ano TO nr_ano;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN mes TO ds_mes;

-- Passo 7: Renomear colunas monetarias (vl_)
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN fatura_celesc TO vl_fatura_celesc;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN fatura_mle TO vl_fatura_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN fatura_total TO vl_fatura_total;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_kwh_faturado TO vl_rs_kwh_faturado;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_kwh_distribuicao TO vl_rs_kwh_distribuicao;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_kwh_energia TO vl_rs_kwh_energia;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_econ_ufv TO vl_economia_ufv;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN fatura_sem_mle TO vl_fatura_sem_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_econ_mle TO vl_economia_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN taxas_mle TO vl_taxas_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN comissao_mle TO vl_comissao_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN venda_energia_mle TO vl_venda_energia_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN saldo_encargos_mle TO vl_saldo_encargos_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN liquido_mle TO vl_liquido_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_fatura_consumo_real TO vl_fatura_consumo_real;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN rs_fat_sem_ufv_mle TO vl_fatura_sem_ufv_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN economia_operacao TO vl_economia_operacao;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN economia_bruta TO vl_economia_bruta;

-- Passo 8: Renomear colunas de percentual (pc_)
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN pct_distribuicao TO pc_distribuicao;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN pct_energia TO pc_energia;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN pct_geracao TO pc_geracao;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN pct_economia_bruto_mle TO pc_economia_bruto_mle;
ALTER TABLE sustentabilidade.f_controle_energia
    RENAME COLUMN pct_economia_liquido_mle TO pc_economia_liquido_mle;

-- Passo 9: Ajustar tipos das colunas monetarias e de quantidade
ALTER TABLE sustentabilidade.f_controle_energia
    ALTER COLUMN qt_geracao_goodwe_kwh TYPE numeric(15,3),
    ALTER COLUMN qt_geracao_sunweg_kwh TYPE numeric(15,3),
    ALTER COLUMN qt_geracao_total_kwh  TYPE numeric(15,3),
    ALTER COLUMN qt_kwh_faturado       TYPE numeric(15,3),
    ALTER COLUMN qt_ufv_live_kwh       TYPE numeric(15,3),
    ALTER COLUMN qt_kwh_real           TYPE numeric(15,3),
    ALTER COLUMN nr_ano                TYPE smallint USING nr_ano::smallint,
    ALTER COLUMN vl_fatura_celesc      TYPE numeric(15,2),
    ALTER COLUMN vl_fatura_mle         TYPE numeric(15,2),
    ALTER COLUMN vl_fatura_total       TYPE numeric(15,2),
    ALTER COLUMN vl_rs_kwh_faturado    TYPE numeric(15,2),
    ALTER COLUMN vl_rs_kwh_distribuicao TYPE numeric(15,2),
    ALTER COLUMN vl_rs_kwh_energia     TYPE numeric(15,2),
    ALTER COLUMN vl_economia_ufv       TYPE numeric(15,2),
    ALTER COLUMN vl_fatura_sem_mle     TYPE numeric(15,2),
    ALTER COLUMN vl_economia_mle       TYPE numeric(15,2),
    ALTER COLUMN vl_taxas_mle          TYPE numeric(15,2),
    ALTER COLUMN vl_comissao_mle       TYPE numeric(15,2),
    ALTER COLUMN vl_venda_energia_mle  TYPE numeric(15,2),
    ALTER COLUMN vl_saldo_encargos_mle TYPE numeric(15,2),
    ALTER COLUMN vl_liquido_mle        TYPE numeric(15,2),
    ALTER COLUMN vl_fatura_consumo_real TYPE numeric(15,2),
    ALTER COLUMN vl_fatura_sem_ufv_mle TYPE numeric(15,2),
    ALTER COLUMN vl_economia_operacao  TYPE numeric(15,2),
    ALTER COLUMN vl_economia_bruta     TYPE numeric(15,2);

-- Passo 10: Remover campo temporario (validar antes com equipe e BI)
-- ALTER TABLE sustentabilidade.f_controle_energia DROP COLUMN ano_temp;

-- Passo 11: Indices
CREATE INDEX idx_f_controle_energia_dt_referencia
    ON sustentabilidade.f_controle_energia (dt_referencia);
CREATE INDEX idx_f_controle_energia_nr_ano
    ON sustentabilidade.f_controle_energia (nr_ano);

-- Passo 12: View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW sustentabilidade.fcontrole_energia AS
    SELECT * FROM sustentabilidade.f_controle_energia;
COMMENT ON VIEW sustentabilidade.fcontrole_energia IS
    'DEPRECATED 2026-05-05: usar f_controle_energia. Sera removido em 2026-08-03.';
```

---

### sustentabilidade.fdescarte_residuos

**Nome proposto:** `sustentabilidade.f_descarte_residuos`
**Tipo:** fato
**Descricao:** Registra cada evento de descarte ou destinacao de residuos da empresa. Cada linha representa um lance de descarte de um tipo especifico de residuo em uma data, com a quantidade, unidade de medida e valor unitario de custo ou receita do descarte. E a tabela transacional central do dominio de residuos, alimentando relatorios de gestao de residuos solidos (GRS) e indicadores ESG.
**Sistema de origem:** Sistema de controle de residuos interno ou planilha de gestao; campo `ultima_atualizacao` sugere carga incremental por timestamp.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME | Mapeamento canonico: `ultima_atualizacao` -> `updated_at` (boas praticas secao 4) |
| `id` | `int4 NULL` | `id` | `bigserial NOT NULL PRIMARY KEY` | RETYPE | Campo `id` ja existe; promover a PK oficial com tipo `bigserial`; atualmente nullable sem constraint PK — CONFLITO: verificar se o valor e gerado pelo sistema de origem ou pelo DW |
| `data_descarte` | `timestamp NULL` | `dt_descarte` | `date NOT NULL` | RENAME, RETYPE | Evento de descarte nao requer horario; `date` e suficiente e mais correto semanticamente; NOT NULL pois e a dimensao temporal obrigatoria do fato |
| `id_tipo_residuo` | `int4 NULL` | `id_tipo_residuo` | `smallint NULL` | RETYPE | Codigo operacional de categoria; prefixo `id_` correto; tipo `smallint` adequado (categorias <32k) |
| `residuo` | `varchar(100) NULL` | `ds_residuo` | `varchar(100) NULL` | RENAME | Descricao do tipo de residuo; prefixo `ds_` |
| `unidade` | `varchar(3) NULL` | `ds_unidade` | `varchar(10) NULL` | RENAME, RETYPE | Unidade de medida (ex.: "kg", "L", "ton"); prefixo `ds_`; ampliar para `varchar(10)` para acomodar descricoes como "unid" |
| `valor_unitario` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,2) NULL` | RENAME, RETYPE | Custo/receita unitario do descarte (R$); prefixo `vl_`; `numeric(15,2)` padrao para valores monetarios; `numeric(18,3)` e superdimensionado |
| `quantidade` | `numeric(18,3) NULL` | `qt_descartada` | `numeric(15,3) NULL` | RENAME, RETYPE | Quantidade descartada; prefixo `qt_`; nome mais especifico; `numeric(15,3)` padrao |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags utilizadas nesta tabela:** [RENAME] [RETYPE] [ADD] [CONFLITO]

**CONFLITO — campo `id`:**
O campo `id int4 NULL` existe na tabela mas nao tem constraint PRIMARY KEY declarada no DDL. Valores podem vir do sistema de origem (chave natural) ou ser gerados pelo DW. Antes da migracao, verificar:
1. Se `id` ja e unico e NOT NULL nos dados atuais: `SELECT COUNT(*), COUNT(DISTINCT id), COUNT(*) FILTER (WHERE id IS NULL) FROM sustentabilidade.fdescarte_residuos;`
2. Se vier do sistema de origem, manter como `id_descarte integer NOT NULL UNIQUE` e criar `id bigserial PRIMARY KEY` separado.
3. Se for gerado pelo DW, promover diretamente para `bigserial PRIMARY KEY`.

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Se `id` vier do sistema de origem (chave natural):

```sql
-- Manter id original como id_descarte e criar novo surrogate
id         bigserial    PRIMARY KEY,
id_descarte integer     NOT NULL UNIQUE   -- chave do sistema de origem
```

#### Relacionamentos propostos

```
sustentabilidade.f_descarte_residuos
  |- id_tipo_residuo -> (futura tabela auxiliar sustentabilidade.aux_tipo_residuo.id)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_descarte_residuos_dt_descarte
    ON sustentabilidade.f_descarte_residuos (dt_descarte);

CREATE INDEX idx_f_descarte_residuos_id_tipo_residuo
    ON sustentabilidade.f_descarte_residuos (id_tipo_residuo);
```

#### Impacto no ETL

- Verificar comportamento do campo `id` antes de qualquer migracao (ver CONFLITO acima).
- A conversao de `data_descarte timestamp` para `dt_descarte date` exige truncamento no ETL: `pd.to_datetime(df['data_descarte']).dt.date`.
- `valor_unitario numeric(18,3)` deve ser relido como `Decimal` e truncado para 2 casas antes do insert no novo tipo `numeric(15,2)` — confirmar que nenhum dado existente usa a 3a casa decimal de forma significativa.
- Watermark de carga incremental: usar `updated_at` (ex-`ultima_atualizacao`).

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE sustentabilidade.fdescarte_residuos
    RENAME TO f_descarte_residuos;

-- Passo 2: Renomear ultima_atualizacao para updated_at e adicionar created_at
ALTER TABLE sustentabilidade.f_descarte_residuos
    RENAME COLUMN ultima_atualizacao TO updated_at;

ALTER TABLE sustentabilidade.f_descarte_residuos
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Passo 3: Resolver CONFLITO do campo id
-- Opcao A — id e gerado pelo DW (promover a PK):
ALTER TABLE sustentabilidade.f_descarte_residuos
    ALTER COLUMN id SET NOT NULL;
CREATE SEQUENCE IF NOT EXISTS sustentabilidade.f_descarte_residuos_id_seq;
ALTER TABLE sustentabilidade.f_descarte_residuos
    ALTER COLUMN id SET DEFAULT nextval('sustentabilidade.f_descarte_residuos_id_seq');
ALTER TABLE sustentabilidade.f_descarte_residuos
    ADD PRIMARY KEY (id);

-- Opcao B — id vem do sistema de origem (renomear e criar novo surrogate):
-- ALTER TABLE sustentabilidade.f_descarte_residuos RENAME COLUMN id TO id_descarte;
-- ALTER TABLE sustentabilidade.f_descarte_residuos ADD COLUMN id bigserial PRIMARY KEY;

-- Passo 4: Renomear e ajustar demais colunas
ALTER TABLE sustentabilidade.f_descarte_residuos
    RENAME COLUMN data_descarte TO dt_descarte;

ALTER TABLE sustentabilidade.f_descarte_residuos
    RENAME COLUMN residuo TO ds_residuo;

ALTER TABLE sustentabilidade.f_descarte_residuos
    RENAME COLUMN unidade TO ds_unidade;

ALTER TABLE sustentabilidade.f_descarte_residuos
    RENAME COLUMN valor_unitario TO vl_unitario;

ALTER TABLE sustentabilidade.f_descarte_residuos
    RENAME COLUMN quantidade TO qt_descartada;

-- Passo 5: Ajustar tipos
ALTER TABLE sustentabilidade.f_descarte_residuos
    ALTER COLUMN dt_descarte TYPE date USING dt_descarte::date,
    ALTER COLUMN id_tipo_residuo TYPE smallint USING id_tipo_residuo::smallint,
    ALTER COLUMN ds_unidade TYPE varchar(10),
    ALTER COLUMN vl_unitario TYPE numeric(15,2),
    ALTER COLUMN qt_descartada TYPE numeric(15,3);

-- Passo 6: Indices
CREATE INDEX idx_f_descarte_residuos_dt_descarte
    ON sustentabilidade.f_descarte_residuos (dt_descarte);
CREATE INDEX idx_f_descarte_residuos_id_tipo_residuo
    ON sustentabilidade.f_descarte_residuos (id_tipo_residuo);

-- Passo 7: View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW sustentabilidade.fdescarte_residuos AS
    SELECT * FROM sustentabilidade.f_descarte_residuos;
COMMENT ON VIEW sustentabilidade.fdescarte_residuos IS
    'DEPRECATED 2026-05-05: usar f_descarte_residuos. Sera removido em 2026-08-03.';
```

---

### sustentabilidade.fnotas_energia

**Nome proposto:** `sustentabilidade.f_notas_energia`
**Tipo:** fato
**Descricao:** Registra os itens das notas fiscais de compra de energia eletrica. Cada linha representa um item de nota fiscal emitido por um fornecedor de energia (ex.: CELESC, MLE ou outro comercializador), contendo dados do documento fiscal (serie, numero, centro de custo, conta contabil), identificacao das partes (CNPJ comprador, nome fornecedor) e valores do item (quantidade, valor unitario, valor total). Permite conciliar as faturas de energia com os registros de controle e consumo.
**Sistema de origem:** ERP financeiro / modulo de contas a pagar (notas fiscais de entrada); provavelmente Systextil ou sistema financeiro equivalente.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `serie` | `text NULL` | `nr_serie` | `varchar(3) NULL` | RENAME, RETYPE | Serie da nota fiscal; prefixo `nr_` para identificador de documento; `varchar(3)` adequado (series fiscais sao curtas); substituir `text` aberto |
| `documento` | `numeric(9) NULL` | `nr_nota_fiscal` | `integer NULL` | RENAME, RETYPE | Numero do documento fiscal; nome canonico do DW e `nr_nota_fiscal` (boas praticas secao 18); `integer` adequado |
| `centro_custo` | `numeric(9) NULL` | `nr_centro_custo` | `integer NULL` | RENAME, RETYPE | Codigo do centro de custo; `nr_` para numeracao de estrutura contabil; `integer` adequado |
| `codigo_contabil` | `numeric(9) NULL` | `nr_codigo_contabil` | `integer NULL` | RENAME, RETYPE | Codigo da conta contabil; `nr_` para sequencial contabil; prefixo proibido `codigo_` substituido |
| `num_contabil` | `numeric(9) NULL` | `nr_contabil` | `integer NULL` | RENAME, RETYPE | Numero contabil complementar; `nr_`; `integer` adequado |
| `data_emissao` | `timestamp NULL` | `dt_emissao` | `date NOT NULL` | RENAME, RETYPE | Data de emissao da NF; apenas data, sem horario; NOT NULL pois e dimensao temporal obrigatoria do fato fiscal |
| `cnpj_comprador` | `text NULL` | `cnpj_comprador` | `varchar(16) NULL` | RETYPE | Nome correto conforme boas praticas (nao e `cnpj_cliente` pois o comprador e a propria empresa; manter nome semantico); tipo `varchar(16)` padrao para CNPJ |
| `nome_fornecedor` | `text NULL` | `nm_fornecedor` | `varchar(100) NULL` | RENAME, RETYPE | Nome do fornecedor; prefixo `nm_`; `varchar(100)` adequado para razao social; substituir `text` aberto |
| `produto` | `text NULL` | `ds_produto` | `varchar(120) NULL` | RENAME, RETYPE | Descricao do produto/servico de energia na NF; prefixo `ds_`; `varchar(120)` controlado |
| `descricao_item` | `text NULL` | `ds_item` | `varchar(200) NULL` | RENAME, RETYPE | Descricao detalhada do item da NF; prefixo `ds_`; `varchar(200)` para acomodar descricoes fiscais |
| `unidade_medida` | `text NULL` | `ds_unidade_medida` | `varchar(10) NULL` | RENAME, RETYPE | Unidade de medida do item (ex.: "kWh", "MWh"); prefixo `ds_`; `varchar(10)` controlado |
| `valor_unitario` | `numeric(20,5) NULL` | `vl_unitario` | `numeric(15,5) NULL` | RENAME, RETYPE | Valor unitario do item; prefixo `vl_`; manter 5 casas decimais pois tarifa de energia tem precisao alta; reduzir `numeric(20,5)` para `numeric(15,5)` — suficiente para valores praticos |
| `quantidade` | `numeric(14,3) NULL` | `qt_item` | `numeric(15,3) NULL` | RENAME, RETYPE | Quantidade do item na NF; prefixo `qt_`; `numeric(15,3)` padrao |
| `valor_total` | `numeric(15,2) NULL` | `vl_total` | `numeric(15,2) NULL` | RENAME | Valor total do item na NF; prefixo `vl_`; tipo ja adequado |
| _(ausente)_ | — | `id` | `bigserial NOT NULL` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria e watermark |

**Flags utilizadas nesta tabela:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(nr_serie, nr_nota_fiscal, nr_codigo_contabil)` — tipicamente um item de NF pode ser identificado por serie + numero + conta contabil. Confirmar com equipe se combinacao e unica; se sim, adicionar:

```sql
ALTER TABLE sustentabilidade.f_notas_energia
    ADD CONSTRAINT uq_f_notas_energia_item
    UNIQUE (nr_serie, nr_nota_fiscal, nr_codigo_contabil);
```

#### Relacionamentos propostos

```
sustentabilidade.f_notas_energia
  |- cnpj_comprador    -> (CNPJ da propria empresa — nao faz join com dimensao externa)
  |- nm_fornecedor     -> (futuro: cnpj_fornecedor -> comercial.d_fornecedor.cnpj_fornecedor)
  |- nr_centro_custo   -> (futuro: dimensao de centro de custo, se existir no DW)
  |- nr_codigo_contabil -> (futuro: plano de contas, se modelado)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_notas_energia_dt_emissao
    ON sustentabilidade.f_notas_energia (dt_emissao);

CREATE INDEX idx_f_notas_energia_nr_nota_fiscal
    ON sustentabilidade.f_notas_energia (nr_nota_fiscal);

CREATE INDEX idx_f_notas_energia_nr_centro_custo
    ON sustentabilidade.f_notas_energia (nr_centro_custo);
```

#### Impacto no ETL

- `data_emissao timestamp` deve ser truncado para `date` no ETL: `pd.to_datetime(df['data_emissao']).dt.date`.
- `cnpj_comprador text` deve ser formatado para o padrao DW `XXXXXXXX/YYYY-ZZ` antes do insert — usar `fn_formatar_cnpj_cpf` ou equivalente Python.
- `valor_unitario numeric(20,5)`: verificar no pandas se valores existentes ultrapassam a precisao de `numeric(15,5)` — improvavel para tarifas de energia praticas, mas validar.
- Nenhum campo de timestamp de atualizacao existe atualmente: apos adicao de `updated_at`, o ETL deve popular este campo manualmente no momento da carga.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE sustentabilidade.fnotas_energia
    RENAME TO f_notas_energia;

-- Passo 2: Adicionar colunas de auditoria e surrogate key
ALTER TABLE sustentabilidade.f_notas_energia
    ADD COLUMN id bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- Passo 3: Renomear colunas
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN serie TO nr_serie;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN documento TO nr_nota_fiscal;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN centro_custo TO nr_centro_custo;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN codigo_contabil TO nr_codigo_contabil;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN num_contabil TO nr_contabil;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN data_emissao TO dt_emissao;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN nome_fornecedor TO nm_fornecedor;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN produto TO ds_produto;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN descricao_item TO ds_item;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN unidade_medida TO ds_unidade_medida;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN valor_unitario TO vl_unitario;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN quantidade TO qt_item;
ALTER TABLE sustentabilidade.f_notas_energia
    RENAME COLUMN valor_total TO vl_total;

-- Passo 4: Ajustar tipos
ALTER TABLE sustentabilidade.f_notas_energia
    ALTER COLUMN nr_serie          TYPE varchar(3),
    ALTER COLUMN nr_nota_fiscal    TYPE integer USING nr_nota_fiscal::integer,
    ALTER COLUMN nr_centro_custo   TYPE integer USING nr_centro_custo::integer,
    ALTER COLUMN nr_codigo_contabil TYPE integer USING nr_codigo_contabil::integer,
    ALTER COLUMN nr_contabil       TYPE integer USING nr_contabil::integer,
    ALTER COLUMN dt_emissao        TYPE date USING dt_emissao::date,
    ALTER COLUMN cnpj_comprador    TYPE varchar(16),
    ALTER COLUMN nm_fornecedor     TYPE varchar(100),
    ALTER COLUMN ds_produto        TYPE varchar(120),
    ALTER COLUMN ds_item           TYPE varchar(200),
    ALTER COLUMN ds_unidade_medida TYPE varchar(10),
    ALTER COLUMN vl_unitario       TYPE numeric(15,5),
    ALTER COLUMN qt_item           TYPE numeric(15,3);

-- Passo 5: Indices
CREATE INDEX idx_f_notas_energia_dt_emissao
    ON sustentabilidade.f_notas_energia (dt_emissao);
CREATE INDEX idx_f_notas_energia_nr_nota_fiscal
    ON sustentabilidade.f_notas_energia (nr_nota_fiscal);
CREATE INDEX idx_f_notas_energia_nr_centro_custo
    ON sustentabilidade.f_notas_energia (nr_centro_custo);

-- Passo 6: View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW sustentabilidade.fnotas_energia AS
    SELECT * FROM sustentabilidade.f_notas_energia;
COMMENT ON VIEW sustentabilidade.fnotas_energia IS
    'DEPRECATED 2026-05-05: usar f_notas_energia. Sera removido em 2026-08-03.';
```

---

### sustentabilidade.fnotas_residuos

**Nome proposto:** `sustentabilidade.f_notas_residuos`
**Tipo:** fato
**Descricao:** Registra os itens das notas fiscais de servicos de coleta, transporte e destinacao de residuos. Cada linha representa um item de nota fiscal de fornecedor de servico ambiental (empresa coletora, reciclador, aterro), com dados do documento fiscal, quantidades coletadas, valores faturados e descricao do residuo/servico. Complementa a tabela `f_descarte_residuos` com a visao financeira e fiscal dos servicos de gestao de residuos.
**Sistema de origem:** ERP financeiro / modulo de contas a pagar; provavelmente Systextil ou sistema financeiro (campo `codigo_empresa` sugere origem multi-empresa).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `codigo_empresa` | `int2 NULL` | `id_empresa` | `smallint NULL` | RENAME | Prefixo proibido `codigo_` substituido por `id_` (codigo operacional de empresa); tipo `smallint` ja correto |
| `serie_nota_fisc` | `varchar(3) NULL` | `nr_serie` | `varchar(3) NULL` | RENAME | Serie da NF; prefixo `nr_` para documento; nome mais legivel; tipo ja adequado |
| `num_nota_fiscal` | `int4 NULL` | `nr_nota_fiscal` | `integer NULL` | RENAME, RETYPE | Nome canonico do DW; `integer` equivalente a `int4` — tornar explicito |
| `centro_custo` | `int4 NULL` | `nr_centro_custo` | `integer NULL` | RENAME, RETYPE | Numero do centro de custo; prefixo `nr_`; `integer` explicito |
| `codigo_contabil` | `int4 NULL` | `nr_codigo_contabil` | `integer NULL` | RENAME, RETYPE | Prefixo proibido `codigo_` substituido; prefixo `nr_` para conta contabil |
| `num_contabil` | `int4 NULL` | `nr_contabil` | `integer NULL` | RENAME, RETYPE | Numero contabil; prefixo `nr_`; `integer` explicito |
| `data_emissao` | `timestamp NULL` | `dt_emissao` | `date NOT NULL` | RENAME, RETYPE | Data de emissao; apenas data, sem hora; NOT NULL — dimensao temporal obrigatoria |
| `cnpj_comprador` | `varchar(120) NULL` | `cnpj_comprador` | `varchar(16) NULL` | RETYPE | CNPJ da empresa compradora (propria empresa); nome semantico correto; tipo `varchar(16)` padrao DW — atual `varchar(120)` e excessivo e permite dados incorretos |
| `nome_fornecedor` | `varchar(60) NULL` | `nm_fornecedor` | `varchar(100) NULL` | RENAME, RETYPE | Nome do fornecedor; prefixo `nm_`; ampliar para `varchar(100)` — razoes sociais podem ultrapassar 60 chars |
| `natur_operacao` | `int2 NULL` | `id_natureza` | `smallint NULL` | RENAME | Natureza da operacao fiscal; prefixo `id_` para codigo operacional; nome canonico alinhado ao glossario DW (`id_natureza`); tipo `smallint` ja correto |
| `quantidade` | `numeric(18,3) NULL` | `qt_item` | `numeric(15,3) NULL` | RENAME, RETYPE | Quantidade do item na NF; prefixo `qt_`; `numeric(15,3)` padrao |
| `valor_itens_nfis` | `numeric(18,3) NULL` | `vl_itens` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor dos itens da NF; prefixo `vl_`; `numeric(15,2)` para valores monetarios; nome mais legivel |
| `produto` | `varchar(111) NULL` | `ds_produto` | `varchar(120) NULL` | RENAME, RETYPE | Descricao do produto/servico; prefixo `ds_`; arredondar para `varchar(120)` |
| `descricao_item` | `varchar(120) NULL` | `ds_item` | `varchar(200) NULL` | RENAME, RETYPE | Descricao detalhada do item; prefixo `ds_`; ampliar para `varchar(200)` |
| `unidade_medida` | `varchar(2) NULL` | `ds_unidade_medida` | `varchar(10) NULL` | RENAME, RETYPE | Unidade de medida; prefixo `ds_`; ampliar para `varchar(10)` — `varchar(2)` e restritivo demais |
| `valor_unitario` | `numeric(18,3) NULL` | `vl_unitario` | `numeric(15,3) NULL` | RENAME, RETYPE | Valor unitario do servico; prefixo `vl_`; manter 3 casas para precisao de servicos ambientais; `numeric(15,3)` |
| `qtde_item_fatur` | `numeric(18,3) NULL` | `qt_faturada` | `numeric(15,3) NULL` | RENAME, RETYPE | Quantidade efetivamente faturada (pode diferir de `qt_item`); prefixo `qt_`; nome mais legivel |
| `valor_faturado` | `numeric(18,3) NULL` | `vl_faturado` | `numeric(15,2) NULL` | RENAME, RETYPE | Valor total faturado; prefixo `vl_`; `numeric(15,2)` para monetario |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | RENAME | Mapeamento canonico `ultima_atualizacao` -> `updated_at` |
| _(ausente)_ | — | `id` | `bigserial NOT NULL` | ADD | Surrogate key obrigatoria |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria |

**Flags utilizadas nesta tabela:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave natural candidata: `(id_empresa, nr_serie, nr_nota_fiscal, nr_codigo_contabil)` — combinacao tipica de item de NF em sistemas multi-empresa. Confirmar unicidade e adicionar UNIQUE constraint se validado:

```sql
ALTER TABLE sustentabilidade.f_notas_residuos
    ADD CONSTRAINT uq_f_notas_residuos_item
    UNIQUE (id_empresa, nr_serie, nr_nota_fiscal, nr_codigo_contabil);
```

#### Relacionamentos propostos

```
sustentabilidade.f_notas_residuos
  |- id_empresa        -> (id_empresa referencia empresa interna — sem dimensao dedicada atual)
  |- cnpj_comprador    -> (CNPJ da propria empresa)
  |- nm_fornecedor     -> (futuro: cnpj_fornecedor -> comercial.d_fornecedor.cnpj_fornecedor)
  |- nr_centro_custo   -> (futuro: dimensao de centro de custo)
  |- nr_codigo_contabil -> (futuro: plano de contas)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_notas_residuos_dt_emissao
    ON sustentabilidade.f_notas_residuos (dt_emissao);

CREATE INDEX idx_f_notas_residuos_nr_nota_fiscal
    ON sustentabilidade.f_notas_residuos (nr_nota_fiscal);

CREATE INDEX idx_f_notas_residuos_id_empresa
    ON sustentabilidade.f_notas_residuos (id_empresa);

CREATE INDEX idx_f_notas_residuos_nr_centro_custo
    ON sustentabilidade.f_notas_residuos (nr_centro_custo);
```

#### Impacto no ETL

- `cnpj_comprador varchar(120)` pode conter CNPJ em formato nao padronizado (sem mascara, com pontos, com 14 digitos puro). Aplicar `fn_formatar_cnpj_cpf` ou equivalente Python antes do insert para garantir formato `XXXXXXXX/YYYY-ZZ`.
- `data_emissao timestamp` -> `dt_emissao date`: truncar no ETL com `pd.to_datetime().dt.date`.
- `unidade_medida varchar(2)` e muito restritivo; confirmar no sistema de origem se existem valores com mais de 2 caracteres antes de ampliar — pode haver dados atualmente truncados.
- Multiplas colunas com `numeric(18,3)` para valores monetarios devem ser convertidas para `numeric(15,2)` — validar que nenhum valor existente usa a 3a casa decimal com significado financeiro real.
- `ultima_atualizacao` ja funciona como watermark; renomear para `updated_at` e ajustar parametro na DAG.

#### Migracao SQL

```sql
-- Passo 1: Renomear tabela
ALTER TABLE sustentabilidade.fnotas_residuos
    RENAME TO f_notas_residuos;

-- Passo 2: Adicionar surrogate key e created_at; renomear ultima_atualizacao
ALTER TABLE sustentabilidade.f_notas_residuos
    ADD COLUMN id bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN ultima_atualizacao TO updated_at;

-- Passo 3: Renomear colunas
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN codigo_empresa TO id_empresa;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN serie_nota_fisc TO nr_serie;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN num_nota_fiscal TO nr_nota_fiscal;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN centro_custo TO nr_centro_custo;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN codigo_contabil TO nr_codigo_contabil;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN num_contabil TO nr_contabil;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN data_emissao TO dt_emissao;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN nome_fornecedor TO nm_fornecedor;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN natur_operacao TO id_natureza;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN quantidade TO qt_item;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN valor_itens_nfis TO vl_itens;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN produto TO ds_produto;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN descricao_item TO ds_item;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN unidade_medida TO ds_unidade_medida;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN valor_unitario TO vl_unitario;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN qtde_item_fatur TO qt_faturada;
ALTER TABLE sustentabilidade.f_notas_residuos
    RENAME COLUMN valor_faturado TO vl_faturado;

-- Passo 4: Ajustar tipos
ALTER TABLE sustentabilidade.f_notas_residuos
    ALTER COLUMN nr_nota_fiscal    TYPE integer USING nr_nota_fiscal::integer,
    ALTER COLUMN nr_centro_custo   TYPE integer USING nr_centro_custo::integer,
    ALTER COLUMN nr_codigo_contabil TYPE integer USING nr_codigo_contabil::integer,
    ALTER COLUMN nr_contabil       TYPE integer USING nr_contabil::integer,
    ALTER COLUMN dt_emissao        TYPE date USING dt_emissao::date,
    ALTER COLUMN cnpj_comprador    TYPE varchar(16),
    ALTER COLUMN nm_fornecedor     TYPE varchar(100),
    ALTER COLUMN qt_item           TYPE numeric(15,3),
    ALTER COLUMN vl_itens          TYPE numeric(15,2),
    ALTER COLUMN ds_produto        TYPE varchar(120),
    ALTER COLUMN ds_item           TYPE varchar(200),
    ALTER COLUMN ds_unidade_medida TYPE varchar(10),
    ALTER COLUMN vl_unitario       TYPE numeric(15,3),
    ALTER COLUMN qt_faturada       TYPE numeric(15,3),
    ALTER COLUMN vl_faturado       TYPE numeric(15,2);

-- Passo 5: Indices
CREATE INDEX idx_f_notas_residuos_dt_emissao
    ON sustentabilidade.f_notas_residuos (dt_emissao);
CREATE INDEX idx_f_notas_residuos_nr_nota_fiscal
    ON sustentabilidade.f_notas_residuos (nr_nota_fiscal);
CREATE INDEX idx_f_notas_residuos_id_empresa
    ON sustentabilidade.f_notas_residuos (id_empresa);
CREATE INDEX idx_f_notas_residuos_nr_centro_custo
    ON sustentabilidade.f_notas_residuos (nr_centro_custo);

-- Passo 6: View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW sustentabilidade.fnotas_residuos AS
    SELECT * FROM sustentabilidade.f_notas_residuos;
COMMENT ON VIEW sustentabilidade.fnotas_residuos IS
    'DEPRECATED 2026-05-05: usar f_notas_residuos. Sera removido em 2026-08-03.';
```

---

## Resumo das Mudancas por Categoria

### Tabelas renomeadas (5/5)

| Nome atual | Nome proposto |
|---|---|
| `fconsumo_energia` | `f_consumo_energia` |
| `fcontrole_energia` | `f_controle_energia` |
| `fdescarte_residuos` | `f_descarte_residuos` |
| `fnotas_energia` | `f_notas_energia` |
| `fnotas_residuos` | `f_notas_residuos` |

### Colunas adicionadas (ADD)

Todas as 5 tabelas recebem `id bigserial PRIMARY KEY`, `created_at` e `updated_at` (ou mapeamento de campo existente para `updated_at`).

| Tabela | Coluna adicionada |
|---|---|
| `f_consumo_energia` | `id`, `created_at`, `updated_at` |
| `f_controle_energia` | `id`, `created_at` (`data_atualizacao` vira `updated_at`) |
| `f_descarte_residuos` | `created_at` (`ultima_atualizacao` vira `updated_at`; `id` promovido a PK) |
| `f_notas_energia` | `id`, `created_at`, `updated_at` |
| `f_notas_residuos` | `id`, `created_at` (`ultima_atualizacao` vira `updated_at`) |

### Colunas a eliminar (DROP)

| Tabela | Coluna | Justificativa |
|---|---|---|
| `f_controle_energia` | `ano_temp` | Campo temporario de controle de ETL sem valor analitico; duplica `nr_ano` |

### Conflitos identificados (CONFLITO)

| Tabela | Campo | Descricao |
|---|---|---|
| `f_descarte_residuos` | `id` | Campo existe como `int4 NULL` sem PK constraint. Verificar se e gerado pelo DW ou pelo sistema de origem antes de promover a surrogate key. |

### Pontos de atencao para migracao

1. **Janela de manutencao:** As alteracoes de tipo (especialmente `ALTER COLUMN ... TYPE`) em tabelas com dados exigem parada das DAGs de carga durante a execucao.
2. **Validacao de dados antes do retype:** Para `cnpj_comprador varchar(120) -> varchar(16)` em `f_notas_residuos`, confirmar que todos os valores existentes cabem em 16 caracteres apos formatacao padrao.
3. **Campo `ano_temp`:** Nao remover sem confirmar com a equipe que nenhum dashboard ou DAG consome este campo.
4. **Views de compatibilidade:** Todas as 5 views com nomes antigos devem ser removidas em 2026-08-03 (90 dias apos a migracao).
5. **Watermark de carga incremental:** Apos migracao, atualizar todas as DAGs para usar `updated_at` como watermark em vez dos nomes anteriores (`data_atualizacao`, `ultima_atualizacao`).

---

## Tabelas Auxiliares Recomendadas (a criar)

| Tabela proposta | Justificativa |
|---|---|
| `sustentabilidade.aux_tipo_residuo` | Dimensao de lookup para `id_tipo_residuo` em `f_descarte_residuos`; atualmente o `id_tipo_residuo` nao tem tabela de referencia no schema |
| `sustentabilidade.aux_periodo_energia` | Opcional: centralizar os valores de `ds_periodo` (ex.: "Ponta", "Fora Ponta", "Reservado") para garantir consistencia |

---

*Dicionario gerado em 2026-05-05. Proxima revisao recomendada: apos conclusao da migracao ou em 2026-08-05.*
