# Dicionario de Dados — Schema `api`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 17 tabelas — integracao com APIs externas (Altervision, Boxlink, Vitrine/checklist)
**Responsavel:** Schema api — dados capturados de APIs de parceiros: contagem de pessoas, clima, rastreio de entregas e checklists de vitrine/loja

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `api.altervision_conversao` | `api.f_altervision_conversao` | fato |
| `api.altervision_countperhour` | `api.f_altervision_contagem_hora` | fato |
| `api.altervision_getage` | `api.f_altervision_faixa_etaria` | fato |
| `api.altervision_getgender` | `api.f_altervision_genero` | fato |
| `api.altervision_getprofileperstore` | `api.f_altervision_perfil_loja` | fato |
| `api.altervision_weather` | `api.f_altervision_clima` | fato |
| `api.boxlink_rastreio_encomendas` | `api.f_boxlink_rastreio` | fato |
| `api.fevidencias` | `api.f_evidencias` | fato |
| `api.fplanos` | `api.f_plano_acao` | fato |
| `api.vitrine` | `api.f_vitrine` | fato |
| `api.vitrine_checklist` | `api.f_vitrine_checklist` | fato |
| `api.vitrine_indicators` | `api.f_vitrine_indicador` | fato |
| `api.vitrine_indicators_stores` | `api.f_vitrine_indicador_loja` | fato |
| `api.vitrine_opcoes_respostas` | `api.aux_vitrine_opcao_resposta` | auxiliar |
| `api.vitrine_qualitybyspace` | `api.f_vitrine_qualidade_espaco` | fato |
| `api.vitrine_questions` | `api.f_vitrine_questao` | fato |
| `api.vitrine_respostas` | `api.f_vitrine_resposta` | fato |

---

## Detalhamento por Tabela

---

### api.altervision_conversao

**Nome proposto:** `api.f_altervision_conversao`
**Tipo:** fato
**Descricao:** Metricas diarias de conversao de trafego por loja, capturadas da API Altervision. Registra visitantes, vendas e uptime do sensor por loja e data.
**Sistema de origem:** API Altervision (sensor de contagem de pessoas)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key obrigatoria (secao 5) |
| `store` | `varchar NULL` | `cod_loja` | `varchar(20)` | [RENAME] [RETYPE] | Identificador da loja; usar prefixo `cod_` por ser join key com `live.dlojas` |
| `uptime` | `numeric NULL` | `pc_uptime` | `numeric(7,4)` | [RENAME] [RETYPE] | Percentual de disponibilidade do sensor; prefixo `pc_` |
| `localdate` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Data de referencia da medicao; prefixo `dt_` |
| `visitors` | `int4 NULL` | `qt_visitantes` | `integer` | [RENAME] | Quantidade de visitantes; prefixo `qt_` |
| `nbsales` | `int4 NULL` | `qt_vendas` | `integer` | [RENAME] | Numero de vendas registradas; prefixo `qt_` |
| `totalsales` | `numeric NULL` | `vl_vendas` | `numeric(15,2)` | [RENAME] [RETYPE] | Valor total de vendas; prefixo `vl_` e tipo padrao |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Mapeado para `updated_at` canonico (secao 4) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria obrigatoria (secao 4) |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

#### Relacionamentos propostos

```
api.f_altervision_conversao
  |- cod_loja -> live.dlojas.pk_loja  (referencia por convencao; apos renomear dlojas para d_loja)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_altervision_conversao_loja ON api.f_altervision_conversao (cod_loja);
CREATE INDEX idx_f_altervision_conversao_dt ON api.f_altervision_conversao (dt_referencia);
```

#### Impacto no ETL

- Renomear tabela e todas as colunas exige atualizar DAG de ingestao da API Altervision.
- Criar view de compatibilidade `api.altervision_conversao` por 90 dias.
- `store` deve ser mapeado para o mesmo formato de `cod_loja` utilizado em `live.dlojas`.

#### Migracao SQL

```sql
ALTER TABLE api.altervision_conversao RENAME TO f_altervision_conversao;

ALTER TABLE api.f_altervision_conversao
    ADD COLUMN id bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE api.f_altervision_conversao RENAME COLUMN store TO cod_loja;
ALTER TABLE api.f_altervision_conversao RENAME COLUMN uptime TO pc_uptime;
ALTER TABLE api.f_altervision_conversao ALTER COLUMN pc_uptime TYPE numeric(7,4);
ALTER TABLE api.f_altervision_conversao RENAME COLUMN localdate TO dt_referencia;
ALTER TABLE api.f_altervision_conversao RENAME COLUMN visitors TO qt_visitantes;
ALTER TABLE api.f_altervision_conversao RENAME COLUMN nbsales TO qt_vendas;
ALTER TABLE api.f_altervision_conversao RENAME COLUMN totalsales TO vl_vendas;
ALTER TABLE api.f_altervision_conversao ALTER COLUMN vl_vendas TYPE numeric(15,2);
ALTER TABLE api.f_altervision_conversao RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_altervision_conversao ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_altervision_conversao ALTER COLUMN updated_at SET DEFAULT current_timestamp;

CREATE OR REPLACE VIEW api.altervision_conversao AS
    SELECT * FROM api.f_altervision_conversao;
COMMENT ON VIEW api.altervision_conversao IS
    'DEPRECATED 2026-05-05: usar f_altervision_conversao. Sera removido em 2026-08-03.';
```

---

### api.altervision_countperhour

**Nome proposto:** `api.f_altervision_contagem_hora`
**Tipo:** fato
**Descricao:** Contagem de visitantes por hora do dia, loja e data. Permite analise de pico de fluxo intradiario.
**Sistema de origem:** API Altervision

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `store_identifier` | `varchar NULL` | `cod_loja` | `varchar(20)` | [RENAME] | Join key com `live.dlojas` |
| `day` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Data de referencia; `"day"` e palavra reservada PostgreSQL — remover aspas |
| `hour` | `int4 NULL` | `nr_hora` | `smallint` | [RENAME] [RETYPE] | Hora do dia (0-23); prefixo `nr_`; `smallint` suficiente |
| `count` | `int4 NULL` | `qt_visitantes` | `integer` | [RENAME] | Contagem de visitantes nessa hora |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.altervision_countperhour RENAME TO f_altervision_contagem_hora;
ALTER TABLE api.f_altervision_contagem_hora
    ADD COLUMN id bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_altervision_contagem_hora RENAME COLUMN store_identifier TO cod_loja;
ALTER TABLE api.f_altervision_contagem_hora RENAME COLUMN "day" TO dt_referencia;
ALTER TABLE api.f_altervision_contagem_hora RENAME COLUMN "hour" TO nr_hora;
ALTER TABLE api.f_altervision_contagem_hora ALTER COLUMN nr_hora TYPE smallint;
ALTER TABLE api.f_altervision_contagem_hora RENAME COLUMN count TO qt_visitantes;
ALTER TABLE api.f_altervision_contagem_hora RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_altervision_contagem_hora ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_altervision_contagem_hora ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.altervision_countperhour AS SELECT * FROM api.f_altervision_contagem_hora;
COMMENT ON VIEW api.altervision_countperhour IS 'DEPRECATED 2026-05-05: usar f_altervision_contagem_hora. Sera removido em 2026-08-03.';
```

---

### api.altervision_getage

**Nome proposto:** `api.f_altervision_faixa_etaria`
**Tipo:** fato
**Descricao:** Distribuicao de visitantes por faixa etaria, loja e data.
**Sistema de origem:** API Altervision

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `day` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Remover aspas; prefixo `dt_` |
| `loja` | `varchar NULL` | `cod_loja` | `varchar(20)` | [RENAME] | Join key |
| `idade` | `varchar NULL` | `ds_faixa_etaria` | `varchar(30)` | [RENAME] | Descricao da faixa etaria; prefixo `ds_` |
| `count` | `numeric(18,3) NULL` | `qt_visitantes` | `numeric(15,3)` | [RENAME] [RETYPE] | Contagem; `numeric(15,3)` padrao |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.altervision_getage RENAME TO f_altervision_faixa_etaria;
ALTER TABLE api.f_altervision_faixa_etaria ADD COLUMN id bigserial PRIMARY KEY, ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_altervision_faixa_etaria RENAME COLUMN "day" TO dt_referencia;
ALTER TABLE api.f_altervision_faixa_etaria RENAME COLUMN loja TO cod_loja;
ALTER TABLE api.f_altervision_faixa_etaria RENAME COLUMN idade TO ds_faixa_etaria;
ALTER TABLE api.f_altervision_faixa_etaria ALTER COLUMN ds_faixa_etaria TYPE varchar(30);
ALTER TABLE api.f_altervision_faixa_etaria RENAME COLUMN count TO qt_visitantes;
ALTER TABLE api.f_altervision_faixa_etaria ALTER COLUMN qt_visitantes TYPE numeric(15,3);
ALTER TABLE api.f_altervision_faixa_etaria RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_altervision_faixa_etaria ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_altervision_faixa_etaria ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.altervision_getage AS SELECT * FROM api.f_altervision_faixa_etaria;
COMMENT ON VIEW api.altervision_getage IS 'DEPRECATED 2026-05-05: usar f_altervision_faixa_etaria. Sera removido em 2026-08-03.';
```

---

### api.altervision_getgender

**Nome proposto:** `api.f_altervision_genero`
**Tipo:** fato
**Descricao:** Distribuicao de visitantes por genero, loja e data.
**Sistema de origem:** API Altervision

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `day` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Remover aspas |
| `loja` | `varchar NULL` | `cod_loja` | `varchar(20)` | [RENAME] | Join key |
| `genero` | `varchar NULL` | `ds_genero` | `varchar(20)` | [RENAME] | Descricao do genero; prefixo `ds_` |
| `count` | `numeric NULL` | `qt_visitantes` | `numeric(15,3)` | [RENAME] [RETYPE] | Contagem |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [RETYPE] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.altervision_getgender RENAME TO f_altervision_genero;
ALTER TABLE api.f_altervision_genero ADD COLUMN id bigserial PRIMARY KEY, ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_altervision_genero RENAME COLUMN "day" TO dt_referencia;
ALTER TABLE api.f_altervision_genero RENAME COLUMN loja TO cod_loja;
ALTER TABLE api.f_altervision_genero RENAME COLUMN genero TO ds_genero;
ALTER TABLE api.f_altervision_genero ALTER COLUMN ds_genero TYPE varchar(20);
ALTER TABLE api.f_altervision_genero RENAME COLUMN count TO qt_visitantes;
ALTER TABLE api.f_altervision_genero ALTER COLUMN qt_visitantes TYPE numeric(15,3);
ALTER TABLE api.f_altervision_genero RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_altervision_genero ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_altervision_genero ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.altervision_getgender AS SELECT * FROM api.f_altervision_genero;
COMMENT ON VIEW api.altervision_getgender IS 'DEPRECATED 2026-05-05: usar f_altervision_genero. Sera removido em 2026-08-03.';
```

---

### api.altervision_getprofileperstore

**Nome proposto:** `api.f_altervision_perfil_loja`
**Tipo:** fato
**Descricao:** Perfil demografico combinado (genero + faixa etaria) de visitantes por loja e data.
**Sistema de origem:** API Altervision

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `day` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Remover aspas |
| `loja` | `varchar NULL` | `cod_loja` | `varchar(20)` | [RENAME] | Join key |
| `genero` | `varchar NULL` | `ds_genero` | `varchar(20)` | [RENAME] | Descricao |
| `idade` | `varchar NULL` | `ds_faixa_etaria` | `varchar(30)` | [RENAME] | Descricao |
| `count` | `numeric(15,3) NULL` | `qt_visitantes` | `numeric(15,3)` | [RENAME] | Contagem |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.altervision_getprofileperstore RENAME TO f_altervision_perfil_loja;
ALTER TABLE api.f_altervision_perfil_loja ADD COLUMN id bigserial PRIMARY KEY, ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_altervision_perfil_loja RENAME COLUMN "day" TO dt_referencia;
ALTER TABLE api.f_altervision_perfil_loja RENAME COLUMN loja TO cod_loja;
ALTER TABLE api.f_altervision_perfil_loja RENAME COLUMN genero TO ds_genero;
ALTER TABLE api.f_altervision_perfil_loja RENAME COLUMN idade TO ds_faixa_etaria;
ALTER TABLE api.f_altervision_perfil_loja RENAME COLUMN count TO qt_visitantes;
ALTER TABLE api.f_altervision_perfil_loja RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_altervision_perfil_loja ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_altervision_perfil_loja ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.altervision_getprofileperstore AS SELECT * FROM api.f_altervision_perfil_loja;
COMMENT ON VIEW api.altervision_getprofileperstore IS 'DEPRECATED 2026-05-05: usar f_altervision_perfil_loja. Sera removido em 2026-08-03.';
```

---

### api.altervision_weather

**Nome proposto:** `api.f_altervision_clima`
**Tipo:** fato
**Descricao:** Registro de condicoes climaticas por loja e data, cruzado com dados de trafego.
**Sistema de origem:** API Altervision

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `day` | `date NULL` | `dt_referencia` | `date` | [RENAME] | Remover aspas |
| `loja` | `varchar NULL` | `cod_loja` | `varchar(20)` | [RENAME] | Join key |
| `tipo_clima` | `varchar NULL` | `ds_tipo_clima` | `varchar(30)` | [RENAME] | Categoria (ensolarado, chuvoso, etc); prefixo `ds_` |
| `clima` | `varchar NULL` | `ds_clima` | `varchar(60)` | [RENAME] | Descricao detalhada do clima |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.altervision_weather RENAME TO f_altervision_clima;
ALTER TABLE api.f_altervision_clima ADD COLUMN id bigserial PRIMARY KEY, ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_altervision_clima RENAME COLUMN "day" TO dt_referencia;
ALTER TABLE api.f_altervision_clima RENAME COLUMN loja TO cod_loja;
ALTER TABLE api.f_altervision_clima RENAME COLUMN tipo_clima TO ds_tipo_clima;
ALTER TABLE api.f_altervision_clima RENAME COLUMN clima TO ds_clima;
ALTER TABLE api.f_altervision_clima RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_altervision_clima ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_altervision_clima ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.altervision_weather AS SELECT * FROM api.f_altervision_clima;
COMMENT ON VIEW api.altervision_weather IS 'DEPRECATED 2026-05-05: usar f_altervision_clima. Sera removido em 2026-08-03.';
```

---

### api.boxlink_rastreio_encomendas

**Nome proposto:** `api.f_boxlink_rastreio`
**Tipo:** fato
**Descricao:** Rastreamento de entregas de pedidos via transportadora Boxlink. Registra status de envio, estimativa de entrega e rastreador TMS por nota fiscal.
**Sistema de origem:** API Boxlink (TMS/transportadora)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pedido_venda` | `varchar(20) NULL` | `nr_pedido_venda` | `varchar(20)` | [RENAME] | Numero do pedido; prefixo `nr_`; manter varchar para compatibilidade |
| `serie_nota_fiscal` | `varchar(10) NULL` | `nr_serie_nf` | `varchar(10)` | [RENAME] | Serie da nota fiscal |
| `numero_nota_fiscal` | `varchar(30) NULL` | `nr_nota_fiscal` | `varchar(30)` | [RENAME] | Numero da NF; manter varchar pelo formato TMS |
| `numero_minuta` | `int4 NULL` | `nr_minuta` | `integer` | [RENAME] | Numero da minuta de transporte |
| `rastreador_tms` | `varchar(90) NULL` | `ds_rastreador_tms` | `varchar(90)` | [RENAME] | Codigo de rastreio TMS; prefixo `ds_` |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `data_envio` | `timestamp NULL` | `dth_envio` | `timestamp` | [RENAME] | Data e hora do envio; prefixo `dth_` |
| `entrega_estimada` | `timestamp NULL` | `dth_entrega_estimada` | `timestamp` | [RENAME] | Estimativa de entrega |
| `status` | `varchar(120) NULL` | `ds_status_entrega` | `varchar(120)` | [RENAME] | Status atual da entrega |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [ADD]

#### Indices recomendados

```sql
CREATE INDEX idx_f_boxlink_rastreio_pedido ON api.f_boxlink_rastreio (nr_pedido_venda);
CREATE INDEX idx_f_boxlink_rastreio_nf ON api.f_boxlink_rastreio (nr_nota_fiscal);
```

#### Migracao SQL

```sql
ALTER TABLE api.boxlink_rastreio_encomendas RENAME TO f_boxlink_rastreio;
ALTER TABLE api.f_boxlink_rastreio ADD COLUMN id bigserial PRIMARY KEY, ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN pedido_venda TO nr_pedido_venda;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN serie_nota_fiscal TO nr_serie_nf;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN numero_nota_fiscal TO nr_nota_fiscal;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN numero_minuta TO nr_minuta;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN rastreador_tms TO ds_rastreador_tms;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_boxlink_rastreio ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_boxlink_rastreio ALTER COLUMN updated_at SET DEFAULT current_timestamp;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN data_envio TO dth_envio;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN entrega_estimada TO dth_entrega_estimada;
ALTER TABLE api.f_boxlink_rastreio RENAME COLUMN status TO ds_status_entrega;
CREATE OR REPLACE VIEW api.boxlink_rastreio_encomendas AS SELECT * FROM api.f_boxlink_rastreio;
COMMENT ON VIEW api.boxlink_rastreio_encomendas IS 'DEPRECATED 2026-05-05: usar f_boxlink_rastreio. Sera removido em 2026-08-03.';
```

---

### api.fevidencias

**Nome proposto:** `api.f_evidencias`
**Tipo:** fato
**Descricao:** Evidencias (fotos/videos) vinculadas a respostas de checklist de vitrine. Registra o tipo e URL da evidencia por resposta.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `answer_id` | `int4 NULL` | `id_resposta` | `integer` | [RENAME] | Codigo operacional de resposta; `id_` por nao ser entidade propria |
| `answer_evidence_type_id` | `int4 NULL` | `id_tipo_evidencia` | `integer` | [RENAME] | Codigo do tipo de evidencia |
| `answer_url` | `text NULL` | `ds_url_evidencia` | `text` | [RENAME] | URL da evidencia |
| `answer_evidence_type_id_ref` | `int4 NULL` | `id_tipo_evidencia_ref` | `integer` | [RENAME] | Referencia ao tipo de evidencia |
| `answer_evidence_type_name_ref` | `text NULL` | `ds_tipo_evidencia` | `text` | [RENAME] | Descricao do tipo de evidencia |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.fevidencias RENAME TO f_evidencias;
ALTER TABLE api.f_evidencias ADD COLUMN id bigserial PRIMARY KEY, ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp, ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_evidencias RENAME COLUMN answer_id TO id_resposta;
ALTER TABLE api.f_evidencias RENAME COLUMN answer_evidence_type_id TO id_tipo_evidencia;
ALTER TABLE api.f_evidencias RENAME COLUMN answer_url TO ds_url_evidencia;
ALTER TABLE api.f_evidencias RENAME COLUMN answer_evidence_type_id_ref TO id_tipo_evidencia_ref;
ALTER TABLE api.f_evidencias RENAME COLUMN answer_evidence_type_name_ref TO ds_tipo_evidencia;
CREATE OR REPLACE VIEW api.fevidencias AS SELECT * FROM api.f_evidencias;
COMMENT ON VIEW api.fevidencias IS 'DEPRECATED 2026-05-05: usar f_evidencias. Sera removido em 2026-08-03.';
```

---

### api.fplanos

**Nome proposto:** `api.f_plano_acao`
**Tipo:** fato
**Descricao:** Planos de acao gerados a partir de respostas de checklist de vitrine. Vincula tarefa, checklist, questao e responsavel.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | Promover a surrogate key com bigserial |
| `task_code` | `varchar(50) NULL` | `nr_tarefa` | `varchar(50)` | [RENAME] | Codigo da tarefa; prefixo `nr_` |
| `creator_user_id` | `varchar(100) NULL` | `id_usuario_criador` | `varchar(100)` | [RENAME] | ID do usuario criador |
| `created_at` | `timestamp NULL` | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Tornar NOT NULL |
| `updated_at` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Tornar NOT NULL |
| `checklist_execution_id` | `int4 NULL` | `id_execucao_checklist` | `integer` | [RENAME] | ID da execucao do checklist |
| `question_id` | `int4 NULL` | `id_questao` | `integer` | [RENAME] | ID da questao |
| `action_plan_state_id` | `int4 NULL` | `id_status_plano` | `integer` | [RENAME] | Status do plano de acao |
| `action_plan_state_name` | `text NULL` | `ds_status_plano` | `varchar(80)` | [RENAME] [RETYPE] | Descricao do status; limitar tamanho |
| `user_id` | `varchar(100) NULL` | `id_usuario_resp` | `varchar(100)` | [RENAME] | ID do responsavel |
| `user_name` | `text NULL` | `nm_usuario_resp` | `varchar(100)` | [RENAME] [RETYPE] | Nome do responsavel |
| `user_role` | `text NULL` | `ds_cargo_usuario` | `varchar(80)` | [RENAME] [RETYPE] | Cargo/funcao do responsavel |
| `answer_id` | `int4 NULL` | `id_resposta` | `integer` | [RENAME] | ID da resposta vinculada |
| `answer_respondent_user_id` | `varchar(100) NULL` | `id_usuario_respondente` | `varchar(100)` | [RENAME] | ID do respondente |
| `answer_approver_user_id` | `varchar(100) NULL` | `id_usuario_aprovador` | `varchar(100)` | [RENAME] | ID do aprovador |
| `answer` | `varchar(1000) NULL` | `ds_resposta` | `varchar(1000)` | [RENAME] | Texto da resposta |

**Flags presentes:** [RENAME] [RETYPE]

#### Migracao SQL

```sql
ALTER TABLE api.fplanos RENAME TO f_plano_acao;
ALTER TABLE api.f_plano_acao ALTER COLUMN id SET NOT NULL;
ALTER TABLE api.f_plano_acao ALTER COLUMN id TYPE bigint USING id::bigint;
ALTER TABLE api.f_plano_acao ADD CONSTRAINT f_plano_acao_pkey PRIMARY KEY (id);
ALTER TABLE api.f_plano_acao RENAME COLUMN task_code TO nr_tarefa;
ALTER TABLE api.f_plano_acao RENAME COLUMN creator_user_id TO id_usuario_criador;
ALTER TABLE api.f_plano_acao ALTER COLUMN created_at SET NOT NULL;
ALTER TABLE api.f_plano_acao ALTER COLUMN created_at SET DEFAULT current_timestamp;
ALTER TABLE api.f_plano_acao ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_plano_acao ALTER COLUMN updated_at SET DEFAULT current_timestamp;
ALTER TABLE api.f_plano_acao RENAME COLUMN checklist_execution_id TO id_execucao_checklist;
ALTER TABLE api.f_plano_acao RENAME COLUMN question_id TO id_questao;
ALTER TABLE api.f_plano_acao RENAME COLUMN action_plan_state_id TO id_status_plano;
ALTER TABLE api.f_plano_acao RENAME COLUMN action_plan_state_name TO ds_status_plano;
ALTER TABLE api.f_plano_acao ALTER COLUMN ds_status_plano TYPE varchar(80);
ALTER TABLE api.f_plano_acao RENAME COLUMN user_id TO id_usuario_resp;
ALTER TABLE api.f_plano_acao RENAME COLUMN user_name TO nm_usuario_resp;
ALTER TABLE api.f_plano_acao ALTER COLUMN nm_usuario_resp TYPE varchar(100);
ALTER TABLE api.f_plano_acao RENAME COLUMN user_role TO ds_cargo_usuario;
ALTER TABLE api.f_plano_acao ALTER COLUMN ds_cargo_usuario TYPE varchar(80);
ALTER TABLE api.f_plano_acao RENAME COLUMN answer_id TO id_resposta;
ALTER TABLE api.f_plano_acao RENAME COLUMN answer_respondent_user_id TO id_usuario_respondente;
ALTER TABLE api.f_plano_acao RENAME COLUMN answer_approver_user_id TO id_usuario_aprovador;
ALTER TABLE api.f_plano_acao RENAME COLUMN answer TO ds_resposta;
CREATE OR REPLACE VIEW api.fplanos AS SELECT * FROM api.f_plano_acao;
COMMENT ON VIEW api.fplanos IS 'DEPRECATED 2026-05-05: usar f_plano_acao. Sera removido em 2026-08-03.';
```

---

### api.vitrine

**Nome proposto:** `api.f_vitrine`
**Tipo:** fato
**Descricao:** Dados consolidados de checklist de vitrine por loja, questao e execucao. Tabela desnormalizada com informacoes de resposta, score e evidencias.
**Sistema de origem:** API de checklist de vitrine/lojas

> **Decisao pendente:** Esta tabela e muito similar a `api.vitrine_checklist` e `api.vitrine_questions`. Avaliar se pode ser consolidada ou se e uma view agregada que deve ser descontinuada. Ver CONFLITOS_E_DECISOES_PENDENTES.md.

#### Colunas (principais — tabela com 29 colunas)

| Coluna atual | Nome proposto | Justificativa |
|---|---|---|
| `checklist_title` | `ds_checklist` | Descricao do checklist |
| `checklist_id` | `id_checklist` | ID operacional |
| `recurrence_start_date` | `dth_inicio_recorrencia` | Data/hora de inicio |
| `recurrence_end_date` | `dth_fim_recorrencia` | Data/hora de fim |
| `groups` | `ds_grupos` | Grupos associados; remover aspas |
| `checklist_execution_state_name` | `ds_status_execucao` | Status da execucao |
| `checklist_execution_start_date` | `dth_inicio_execucao` | Inicio da execucao |
| `checklist_execution_end_date` | `dth_fim_execucao` | Fim da execucao |
| `user_id` | `id_usuario` | ID do usuario |
| `user_name` | `nm_usuario` | Nome do usuario |
| `is_audit` | `fl_auditoria` | Flag de auditoria; converter para boolean |
| `question_description` | `ds_questao` | Descricao da questao |
| `action_plan_amount` | `qt_planos_acao` | Quantidade de planos de acao |
| `opportunities` | `qt_oportunidades` | Numero de oportunidades |
| `question_id` | `id_questao` | ID da questao |
| `business_unit_id` | `id_unidade_negocio` | ID da loja/unidade |
| `business_unit_code` | `cod_unidade_negocio` | Codigo da unidade |
| `checklist_execution_id` | `id_execucao_checklist` | ID da execucao |
| `score` | `vl_score` | Score obtido; tipo varchar -> numeric |
| `score_max` | `vl_score_max` | Score maximo |
| `score_rate` | `pc_score` | Percentual de score |
| `question_answers` | `ds_opcoes_resposta` | Opcoes de resposta |
| `answer` | `ds_resposta` | Resposta registrada |
| `group_names` | `ds_grupo_nomes` | Nomes dos grupos |
| `commercial_names` | `ds_nomes_comerciais` | Nomes comerciais |
| `question_title` | `ds_titulo_questao` | Titulo da questao |
| `text_evidence` | `ds_evidencia_texto` | Texto de evidencia |
| `category_name` | `ds_categoria` | Nome da categoria |
| `department_names` | `ds_departamentos` | Departamentos |
| `business_unit_name` | `nm_unidade_negocio` | Nome da unidade |

#### Migracao SQL (resumida)

```sql
ALTER TABLE api.vitrine RENAME TO f_vitrine;
ALTER TABLE api.f_vitrine ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE api.f_vitrine ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_vitrine ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear todas as colunas conforme tabela acima
-- Converter score/score_max/score_rate de varchar para numeric onde aplicavel
CREATE OR REPLACE VIEW api.vitrine AS SELECT * FROM api.f_vitrine;
COMMENT ON VIEW api.vitrine IS 'DEPRECATED 2026-05-05: usar f_vitrine. Sera removido em 2026-08-03.';
```

---

### api.vitrine_checklist

**Nome proposto:** `api.f_vitrine_checklist`
**Tipo:** fato
**Descricao:** Dados de execucao de checklist por unidade de negocio (loja), incluindo score, quantidade de questoes e planos de acao.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| `checklist_id` | `id_checklist` | `integer` | ID operacional |
| `checklist_title` | `ds_checklist` | `varchar(100)` | Descricao |
| `business_unit_id` | `id_unidade_negocio` | `bigint` | ID da loja |
| `business_unit_name` | `nm_unidade_negocio` | `varchar(207)` | Nome da loja |
| `business_unit_code` | `cod_unidade_negocio` | `bigint` | Codigo da loja |
| `group_names` | `ds_grupos` | `varchar(200)` | Grupos |
| `checklist_execution_id` | `id_execucao_checklist` | `bigint` | ID execucao |
| `checklist_execution_state_name` | `ds_status_execucao` | `varchar(50)` | Status |
| `user_id` | `id_usuario` | `varchar(50)` | ID usuario |
| `user_name` | `nm_usuario` | `varchar(100)` | Nome |
| `score_rate` | `pc_score` | `float8` | Percentual score |
| `action_plan_amount` | `qt_planos_acao` | `bigint` | Qtd planos |
| `opportunities` | `qt_oportunidades` | `integer` | Oportunidades |
| `is_audit` | `fl_auditoria` | `varchar(50)` | Flag auditoria |
| `question_id` | `id_questao` | `bigint` | ID questao |
| `question_title` | `ds_titulo_questao` | `varchar(202)` | Titulo |
| `question_description` | `ds_questao` | `varchar(203)` | Descricao |
| `text_evidence` | `ds_evidencia_texto` | `varchar(204)` | Evidencia |
| `score` | `vl_score` | `bigint` | Score |
| `score_max` | `vl_score_max` | `bigint` | Score max |
| `department_names` | `ds_departamentos` | `varchar(205)` | Depto |
| `category_name` | `ds_categoria` | `varchar(206)` | Categoria |
| `icon` | `ds_icone` | `varchar(200)` | Icone |
| `label_cod` | `ds_label_cod` | `varchar(100)` | Codigo label |
| `answer` | `ds_resposta` | `varchar(2500)` | Resposta |
| `question_score` | `ds_score_questao` | `varchar(200)` | Score questao |
| `ultima_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| `checklist_execution_end_date` | `dth_fim_execucao` | `timestamp` | Fim execucao |
| `checklist_execution_start_date` | `dth_inicio_execucao` | `timestamp` | Inicio execucao |
| `recurrence_end_date` | `dth_fim_recorrencia` | `timestamp` | Fim recorrencia |
| `recurrence_start_date` | `dth_inicio_recorrencia` | `timestamp` | Inicio recorrencia |
| `commercial_names` | `ds_nomes_comerciais` | `varchar(300)` | Nomes comerciais |
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE api.vitrine_checklist RENAME TO f_vitrine_checklist;
ALTER TABLE api.f_vitrine_checklist ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE api.f_vitrine_checklist ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme tabela acima
ALTER TABLE api.f_vitrine_checklist RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE api.f_vitrine_checklist ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE api.f_vitrine_checklist ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.vitrine_checklist AS SELECT * FROM api.f_vitrine_checklist;
COMMENT ON VIEW api.vitrine_checklist IS 'DEPRECATED 2026-05-05: usar f_vitrine_checklist. Sera removido em 2026-08-03.';
```

---

### api.vitrine_indicators

**Nome proposto:** `api.f_vitrine_indicador`
**Tipo:** fato
**Descricao:** Indicadores agregados de qualidade de vitrine por loja, incluindo metricas de execucao pontual, rework, qualidade e estrelas.
**Sistema de origem:** API de checklist de vitrine/lojas

> **Decisao pendente:** Muitas colunas em ingles (do payload da API). Manter nome original ou traduzir? Ver CONFLITOS_E_DECISOES_PENDENTES.md.

#### Colunas (principais — mapeamento de renomeacoes)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| `company_id` | `id_empresa_api` | `varchar(200)` | ID da empresa na API |
| `id` | `id` | `bigserial NOT NULL` | Promover a PK |
| `name` | `ds_indicador` | `varchar(200)` | Descricao do indicador |
| `date_start` | `dth_inicio` | `timestamp` | Data inicio |
| `date_end` | `dth_fim` | `timestamp` | Data fim |
| `store_id` | `id_loja_api` | `varchar(200)` | ID da loja na API |
| `nm_store` | `nm_loja` | `varchar(200)` | Nome da loja |
| `code` | `cod_loja` | `varchar(200)` | Codigo da loja (join key) |
| `nm_group` | `nm_grupo` | `varchar(200)` | Grupo da loja |
| `store_status` | `ds_status_loja` | `varchar(200)` | Status da loja |
| `totaldone` | `qt_concluidos` | `numeric(15,3)` | Qtd concluidos |
| `totalnotapply` | `qt_nao_aplica` | `numeric(15,3)` | Qtd nao se aplica |
| `done` | `qt_feitos` | `integer` | Feitos |
| `notapply` | `qt_nao_aplica_item` | `numeric(15,3)` | Nao aplica por item |
| `notdone` | `qt_nao_feitos` | `numeric(15,3)` | Nao feitos |
| `executiondate` | `dth_execucao` | `timestamp` | Data execucao |
| `ontime` | `fl_no_prazo` | `integer` | Executado no prazo |
| `quality` | `pc_qualidade` | `numeric(12,3)` | Percentual qualidade |
| `rework` | `pc_retrabalho` | `numeric(12,3)` | Percentual retrabalho |
| `star` | `vl_estrelas` | `numeric(15,3)` | Pontuacao estrelas |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE api.vitrine_indicators RENAME TO f_vitrine_indicador;
ALTER TABLE api.f_vitrine_indicador ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_vitrine_indicador ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme tabela acima
CREATE OR REPLACE VIEW api.vitrine_indicators AS SELECT * FROM api.f_vitrine_indicador;
COMMENT ON VIEW api.vitrine_indicators IS 'DEPRECATED 2026-05-05: usar f_vitrine_indicador. Sera removido em 2026-08-03.';
```

---

### api.vitrine_indicators_stores

**Nome proposto:** `api.f_vitrine_indicador_loja`
**Tipo:** fato
**Descricao:** Indicadores de vitrine consolidados por loja, sem detalhamento por data de execucao. Complementar a `f_vitrine_indicador`.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas (principais)

Segue o mesmo padrao de renomeacao de `f_vitrine_indicador`, com excecao de:
- `date_start` / `date_end` sao `varchar(50)` — converter para `date` no ETL
- Colunas de contagem (`ontime`, `storeexecutiontime`, etc.) ja sao `int4`

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| `company_id` | `id_empresa_api` | `varchar(200)` |
| `id` | `id` | `bigserial NOT NULL` |
| `name` | `ds_indicador` | `varchar(200)` |
| `store_id` | `id_loja_api` | `varchar(200)` |
| `nm_store` | `nm_loja` | `varchar(200)` |
| `code` | `cod_loja` | `varchar(200)` |
| `nm_group` | `nm_grupo` | `varchar(200)` |
| `store_status` | `ds_status_loja` | `varchar(200)` |
| `date_start` | `dt_inicio` | `date` (converter de varchar) |
| `date_end` | `dt_fim` | `date` (converter de varchar) |
| `executiondate` | `dt_execucao` | `date` (converter de varchar) |
| `ontime` | `fl_no_prazo` | `integer` |
| `quality` | `qt_qualidade` | `integer` |
| `rework` | `qt_retrabalho` | `integer` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

> **Decisao pendente:** `date_start`, `date_end`, `executiondate` estao como `varchar(50)` — o ETL deve converter para `date` antes de inserir. Ver CONFLITOS_E_DECISOES_PENDENTES.md.

#### Migracao SQL (resumida)

```sql
ALTER TABLE api.vitrine_indicators_stores RENAME TO f_vitrine_indicador_loja;
ALTER TABLE api.f_vitrine_indicador_loja ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_vitrine_indicador_loja ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
CREATE OR REPLACE VIEW api.vitrine_indicators_stores AS SELECT * FROM api.f_vitrine_indicador_loja;
COMMENT ON VIEW api.vitrine_indicators_stores IS 'DEPRECATED 2026-05-05: usar f_vitrine_indicador_loja. Sera removido em 2026-08-03.';
```

---

### api.vitrine_opcoes_respostas

**Nome proposto:** `api.aux_vitrine_opcao_resposta`
**Tipo:** auxiliar (lookup)
**Descricao:** Tabela de dominio que lista as opcoes de resposta possiveis para cada questao de checklist, com icone, label e score.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `checklist_id` | `int8 NULL` | `id_checklist` | `bigint` | [RENAME] | ID operacional |
| `checklist_execution_id` | `int8 NULL` | `id_execucao_checklist` | `bigint` | [RENAME] | ID execucao |
| `business_unit_id` | `int8 NULL` | `id_unidade_negocio` | `bigint` | [RENAME] | ID da loja |
| `question_id` | `int8 NULL` | `id_questao` | `bigint` | [RENAME] | ID da questao |
| `icon` | `varchar(200) NULL` | `ds_icone` | `varchar(200)` | [RENAME] | Icone da opcao |
| `label_cod` | `varchar(100) NULL` | `ds_label_cod` | `varchar(100)` | [RENAME] | Codigo do label |
| `label` | `varchar(200) NULL` | `ds_label` | `varchar(200)` | [RENAME] | Texto do label; remover aspas |
| `score` | `varchar(200) NULL` | `vl_score` | `varchar(200)` | [RENAME] | Score da opcao (manter varchar; API retorna valores textuais) |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.vitrine_opcoes_respostas RENAME TO aux_vitrine_opcao_resposta;
ALTER TABLE api.aux_vitrine_opcao_resposta ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE api.aux_vitrine_opcao_resposta ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.aux_vitrine_opcao_resposta ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN checklist_id TO id_checklist;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN checklist_execution_id TO id_execucao_checklist;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN business_unit_id TO id_unidade_negocio;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN question_id TO id_questao;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN icon TO ds_icone;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN label_cod TO ds_label_cod;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN "label" TO ds_label;
ALTER TABLE api.aux_vitrine_opcao_resposta RENAME COLUMN score TO vl_score;
CREATE OR REPLACE VIEW api.vitrine_opcoes_respostas AS SELECT * FROM api.aux_vitrine_opcao_resposta;
COMMENT ON VIEW api.vitrine_opcoes_respostas IS 'DEPRECATED 2026-05-05: usar aux_vitrine_opcao_resposta. Sera removido em 2026-08-03.';
```

---

### api.vitrine_qualitybyspace

**Nome proposto:** `api.f_vitrine_qualidade_espaco`
**Tipo:** fato
**Descricao:** Metricas de qualidade por espaco/questao de vitrine, com estrelas, retrabalho e razoes de aprovacao/reprovacao.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| `id` | `id` | `bigserial NOT NULL` | Promover a PK |
| `quality_id` | `id_qualidade` | `varchar(100)` | ID da dimensao qualidade |
| `name` | `ds_espaco` | `varchar(300)` | Nome do espaco/questao |
| `orientation` | `obs_orientacao` | `varchar(2000)` | Orientacoes; prefixo `obs_` |
| `star` | `vl_estrelas` | `numeric(12,3)` | Pontuacao |
| `quality` | `pc_qualidade` | `numeric(12,3)` | Percentual qualidade |
| `not_apply` | `qt_nao_aplica` | `numeric(12,3)` | Qtd nao aplica |
| `not_apply_reasons` | `ds_motivos_nao_aplica` | `varchar(2000)` | Motivos |
| `approved_reasons` | `ds_motivos_aprovado` | `varchar(2000)` | Motivos aprovacao |
| `reproved_reasons` | `ds_motivos_reprovado` | `varchar(2000)` | Motivos reprovacao |
| `company_id` | `id_empresa_api` | `varchar(100)` | ID empresa na API |
| `store_id` | `id_loja_api` | `varchar(100)` | ID loja na API |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

#### Migracao SQL (resumida)

```sql
ALTER TABLE api.vitrine_qualitybyspace RENAME TO f_vitrine_qualidade_espaco;
-- Adicionar auditoria e renomear colunas conforme tabela
CREATE OR REPLACE VIEW api.vitrine_qualitybyspace AS SELECT * FROM api.f_vitrine_qualidade_espaco;
COMMENT ON VIEW api.vitrine_qualitybyspace IS 'DEPRECATED 2026-05-05: usar f_vitrine_qualidade_espaco. Sera removido em 2026-08-03.';
```

---

### api.vitrine_questions

**Nome proposto:** `api.f_vitrine_questao`
**Tipo:** fato
**Descricao:** Dados de questoes de checklist por execucao, incluindo score, resposta e evidencias textuais.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas (principais)

Segue padrao de renomeacao de `f_vitrine_checklist`. Diferencas principais:
- Nao tem `group_names`, `commercial_names` com `ultima_atualizacao`
- Adicionar `created_at` e `updated_at`

#### Migracao SQL (resumida)

```sql
ALTER TABLE api.vitrine_questions RENAME TO f_vitrine_questao;
ALTER TABLE api.f_vitrine_questao ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE api.f_vitrine_questao ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_vitrine_questao ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
-- Renomear colunas conforme padrao das demais tabelas vitrine_*
CREATE OR REPLACE VIEW api.vitrine_questions AS SELECT * FROM api.f_vitrine_questao;
COMMENT ON VIEW api.vitrine_questions IS 'DEPRECATED 2026-05-05: usar f_vitrine_questao. Sera removido em 2026-08-03.';
```

---

### api.vitrine_respostas

**Nome proposto:** `api.f_vitrine_resposta`
**Tipo:** fato
**Descricao:** Respostas registradas por execucao de checklist, com score, icone e label. Complementa `aux_vitrine_opcao_resposta`.
**Sistema de origem:** API de checklist de vitrine/lojas

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| — | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `icon` | `varchar(200) NULL` | `ds_icone` | `varchar(200)` | [RENAME] | Icone da resposta |
| `label` | `varchar(200) NULL` | `ds_label` | `varchar(200)` | [RENAME] | Remover aspas; prefixo `ds_` |
| `score` | `varchar(200) NULL` | `vl_score` | `varchar(200)` | [RENAME] | Score (manter varchar) |
| `evidences` | `varchar(200) NULL` | `ds_evidencias` | `varchar(200)` | [RENAME] | Evidencias |
| `checklist_id` | `varchar(200) NULL` | `id_checklist` | `varchar(200)` | [RENAME] | ID checklist |
| `business_unit_id` | `varchar(200) NULL` | `id_unidade_negocio` | `varchar(200)` | [RENAME] | ID loja |
| `checklist_execution_id` | `varchar(200) NULL` | `id_execucao_checklist` | `varchar(200)` | [RENAME] | ID execucao |
| `question_id` | `varchar(200) NULL` | `id_questao` | `varchar(200)` | [RENAME] | ID questao |
| `recurrence_start_date` | `date NULL` | `dt_inicio_recorrencia` | `date` | [RENAME] | Data inicio |
| `recurrence_end_date` | `date NULL` | `dt_fim_recorrencia` | `date` | [RENAME] | Data fim |
| — | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| — | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

**Flags presentes:** [RENAME] [ADD]

#### Migracao SQL

```sql
ALTER TABLE api.vitrine_respostas RENAME TO f_vitrine_resposta;
ALTER TABLE api.f_vitrine_resposta ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE api.f_vitrine_resposta ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_vitrine_resposta ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN icon TO ds_icone;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN "label" TO ds_label;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN score TO vl_score;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN evidences TO ds_evidencias;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN checklist_id TO id_checklist;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN business_unit_id TO id_unidade_negocio;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN checklist_execution_id TO id_execucao_checklist;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN question_id TO id_questao;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN recurrence_start_date TO dt_inicio_recorrencia;
ALTER TABLE api.f_vitrine_resposta RENAME COLUMN recurrence_end_date TO dt_fim_recorrencia;
CREATE OR REPLACE VIEW api.vitrine_respostas AS SELECT * FROM api.f_vitrine_resposta;
COMMENT ON VIEW api.vitrine_respostas IS 'DEPRECATED 2026-05-05: usar f_vitrine_resposta. Sera removido em 2026-08-03.';
```

---

## Conflitos e Decisoes Pendentes — Schema `api`

1. **Duplicidade vitrine/vitrine_checklist/vitrine_questions**: As tres tabelas tem estrutura similar. Avaliar se `vitrine` e uma view materializada ou tabela redundante. Recomendacao: consolidar em `f_vitrine_checklist` e deprecar `f_vitrine`.
2. **Colunas de data como varchar em vitrine_indicators_stores**: `date_start`, `date_end`, `executiondate` estao como `varchar(50)`. O ETL deve normalizar para `date` antes de inserir no DW.
3. **Nomes de colunas em ingles**: Tabelas das APIs Altervision e Vitrine usam nomes em ingles no payload. Decisao: traduzir para portugues no DW (padrao do projeto) ou manter ingles para facilitar mapeamento com a API? Recomendacao: traduzir conforme proposto neste dicionario.
4. **`cod_loja` x `id_loja_api`**: Nas tabelas Altervision, `store`/`loja` pode ser o codigo interno do sistema ou um ID da API. Confirmar se o valor e o mesmo que `live.dlojas.pk_loja` para definir se e `cod_loja` (join key) ou `id_loja_api` (id operacional sem join).
