# Dicionario de Dados — Schema `homologacao`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Em revisao
**Escopo:** Schema `homologacao` — 2 tabelas, 39 colunas
**Responsavel:** Equipe de Data Warehouse
**Referencias:** BOAS_PRATICAS_DW.md v2.0, homologacao.sql, _inventario_dw.md

---

## Visao Geral do Schema

O schema `homologacao` contem tabelas temporarias utilizadas no ambiente de homologacao para
testes de indicadores de vitrine e lojas. As tabelas replicam estruturas de fatos que serao
promovidas ao schema definitivo apos validacao. Por serem de homologacao, seguem convencao
de prefixo `tmp_` nas propostas de renomeacao, conforme boas praticas do DW.

O schema contem dados provenientes da API da plataforma de vitrine (Live), cobrindo metricas
de execucao de espacos de loja, qualidade de execucao e desempenho por espaco/vitrine.

**Tabelas:** 2
**Colunas totais:** 39
**Sistema de origem principal:** API Live (plataforma de indicadores de vitrine/lojas)

---

## Tabelas

---

### homologacao.fvitrine_indicadores_loja

**Nome proposto:** `homologacao.tmp_vitrine_indicadores_loja`
**Tipo:** homologacao
**Descricao:** Tabela de homologacao que armazena indicadores agregados de execucao de vitrine por loja e por campanha de vitrine. Cada registro representa o resultado de uma rodada de avaliacao de uma loja (`store_id`) dentro de uma campanha (`id`), contendo contagens de espacos executados, nao executados, nao aplicaveis e metricas derivadas de qualidade, retrabalho e pontualidade. Destinada a validar calculos de KPIs antes da promocao ao schema definitivo.
**Sistema de origem:** API Live (plataforma de vitrine/lojas)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 NOT NULL` | `id` | `bigserial NOT NULL` | RETYPE | Surrogate key deve ser `bigserial` conforme padrao DW (secao 5 boas praticas). Valor existente pode ser preservado via sequence reset. |
| `company_id` | `varchar(50) NULL` | `id_company` | `varchar(50) NULL` | RENAME | Prefixo `id_` para codigos operacionais que nao sao join keys de entidade/dimensao. |
| `name` | `varchar(255) NULL` | `nm_campanha` | `varchar(255) NULL` | RENAME | Prefixo `nm_` para nomes conforme boas praticas secao 3.2. Nome `name` e generico; `nm_campanha` explicita a entidade representada. |
| `date_start` | `timestamp NULL` | `dth_inicio` | `timestamp NULL` | RENAME | Prefixo `dth_` para campos data+hora conforme secao 3.2. |
| `date_end` | `timestamp NULL` | `dth_fim` | `timestamp NULL` | RENAME | Prefixo `dth_` para campos data+hora conforme secao 3.2. |
| `store_id` | `varchar(50) NULL` | `cod_loja` | `varchar(50) NULL` | RENAME | Join key de entidade loja — deve usar prefixo `cod_` conforme secao 3.1 e dicionario de entidades. Permite join com `live.dlojas`. |
| `nm_store` | `varchar(255) NULL` | `nm_loja` | `varchar(255) NULL` | OK | Prefixo `nm_` ja correto. Renomear apenas para padronizar entidade (`store` -> `loja`). |
| `code` | `int2 NULL` | `nr_code` | `smallint NULL` | RENAME | Campo de numero sequencial/codigo — prefixo `nr_` conforme secao 3.2. Tipo `int2` equivale a `smallint`, sem alteracao de tipo necessaria. |
| `nm_group` | `varchar(255) NULL` | `nm_grupo` | `varchar(255) NULL` | RENAME | Prefixo `nm_` ja presente; ajustar apenas para portugues (`group` -> `grupo`). |
| `store_status` | `varchar(30) NULL` | `ds_status_loja` | `varchar(30) NULL` | RENAME | Status descritivo — prefixo `ds_` conforme secao 3.2. |
| `aprovador` | `varchar(30) NULL` | `nm_aprovador` | `varchar(30) NULL` | RENAME | Nome de pessoa — prefixo `nm_` conforme secao 3.2. |
| `executor` | `varchar(50) NULL` | `nm_executor` | `varchar(50) NULL` | RENAME | Nome de pessoa — prefixo `nm_` conforme secao 3.2. |
| `comercial` | `varchar(30) NULL` | `nm_comercial` | `varchar(30) NULL` | RENAME | Nome de responsavel comercial — prefixo `nm_` conforme secao 3.2. |
| `visualizador` | `varchar(20) NULL` | `nm_visualizador` | `varchar(20) NULL` | RENAME | Nome de usuario com perfil visualizador — prefixo `nm_` conforme secao 3.2. |
| `franqueado` | `varchar(50) NULL` | `nm_franqueado` | `varchar(50) NULL` | RENAME | Nome do franqueado da loja — prefixo `nm_` conforme secao 3.2. |
| `totalspace` | `int2 NULL` | `qt_total_espacos` | `smallint NULL` | RENAME | Quantidade — prefixo `qt_` conforme secao 3.2. camelCase proibido. |
| `totaldone` | `int2 NULL` | `qt_total_executados` | `smallint NULL` | RENAME | Quantidade de espacos executados — prefixo `qt_`. |
| `totalnotapply` | `int2 NULL` | `qt_total_nao_aplicavel` | `smallint NULL` | RENAME | Quantidade de espacos nao aplicaveis — prefixo `qt_`. |
| `done` | `int2 NULL` | `qt_executados` | `smallint NULL` | RENAME | Quantidade executados (sessao corrente) — prefixo `qt_`. Nome `done` e ingles generico. |
| `notapply` | `int2 NULL` | `qt_nao_aplicavel` | `smallint NULL` | RENAME | Quantidade nao aplicavel (sessao corrente) — prefixo `qt_`. |
| `notdone` | `int2 NULL` | `qt_nao_executados` | `smallint NULL` | RENAME | Quantidade nao executados — prefixo `qt_`. |
| `executiondate` | `timestamp NULL` | `dth_execucao` | `timestamp NULL` | RENAME | Data+hora de execucao — prefixo `dth_` conforme secao 3.2. |
| `ontime` | `numeric(5,2) NULL` | `pc_no_prazo` | `numeric(7,4) NULL` | RENAME | RETYPE | Percentual de execucao no prazo — prefixo `pc_`. Tipo padrao de percentual e `numeric(7,4)` conforme secao 8. |
| `storeexecutiontime` | `varchar(20) NULL` | `ds_tempo_execucao_loja` | `varchar(20) NULL` | RENAME | Descricao/codigo de tempo de execucao da loja — prefixo `ds_`. camelCase proibido. |
| `storeapprovaltime` | `varchar(20) NULL` | `ds_tempo_aprovacao_loja` | `varchar(20) NULL` | RENAME | Descricao/codigo de tempo de aprovacao da loja — prefixo `ds_`. camelCase proibido. |
| `notevaluatedontime` | `int2 NULL` | `qt_nao_avaliado_no_prazo` | `smallint NULL` | RENAME | Contagem de itens nao avaliados no prazo — prefixo `qt_`. |
| `notevaluatedofftime` | `int2 NULL` | `qt_nao_avaliado_fora_prazo` | `smallint NULL` | RENAME | Contagem de itens nao avaliados fora do prazo — prefixo `qt_`. |
| `notsendontime` | `int2 NULL` | `qt_nao_enviado_no_prazo` | `smallint NULL` | RENAME | Contagem de itens nao enviados no prazo — prefixo `qt_`. |
| `notsendofftime` | `int2 NULL` | `qt_nao_enviado_fora_prazo` | `smallint NULL` | RENAME | Contagem de itens nao enviados fora do prazo — prefixo `qt_`. |
| `quality` | `numeric(5,2) NULL` | `pc_qualidade` | `numeric(7,4) NULL` | RENAME | RETYPE | Percentual de qualidade — prefixo `pc_`. Tipo padrao `numeric(7,4)` conforme secao 8. |
| `rework` | `numeric(5,2) NULL` | `pc_retrabalho` | `numeric(7,4) NULL` | RENAME | RETYPE | Percentual de retrabalho — prefixo `pc_`. Tipo padrao `numeric(7,4)` conforme secao 8. |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria conforme secao 4 das boas praticas. |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria conforme secao 4 das boas praticas. Usada como watermark para carga incremental. |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
-- Manter PK simples sobre o surrogate key
CONSTRAINT tmp_vitrine_indicadores_loja_pkey PRIMARY KEY (id)
```

A PK atual sobre `id int4` e funcional. Apos migracao, `id` passa a `bigserial` com a sequence
redefinida a partir do valor maximo existente, preservando todos os registros.

#### Relacionamentos propostos

```
homologacao.tmp_vitrine_indicadores_loja
  |- cod_loja  ->  live.dlojas.store_id   (join por convencao; sem FK declarada)
```

Nao ha dimensao `d_loja` canonizada no DW. O join deve ser feito contra `live.dlojas` usando
o campo `store_id` dessa tabela ate que uma dimensao padrao seja criada. Documentar no DAG.

#### Indices recomendados

```sql
-- Filtro por loja (join mais frequente)
CREATE INDEX idx_tmp_vitrine_ind_loja_cod_loja
    ON homologacao.tmp_vitrine_indicadores_loja (cod_loja);

-- Filtro por periodo
CREATE INDEX idx_tmp_vitrine_ind_loja_dth_inicio
    ON homologacao.tmp_vitrine_indicadores_loja (dth_inicio);

-- Filtro combinado loja + periodo (padrao de consulta de indicadores)
CREATE INDEX idx_tmp_vitrine_ind_loja_loja_inicio
    ON homologacao.tmp_vitrine_indicadores_loja (cod_loja, dth_inicio);
```

#### Impacto no ETL

- A DAG de carga deve ser pausada durante a execucao do DDL de migracao (alteracoes de tipo
  em `id`, `ontime`, `quality`, `rework` exigem `ALTER COLUMN ... USING`).
- Apos migracao, atualizar aliases no SELECT do pipeline: `company_id AS id_company`,
  `store_id AS cod_loja`, `name AS nm_campanha`, etc.
- Inserir `created_at` e `updated_at` no pipeline; o banco aplica o DEFAULT automaticamente
  se o ETL omitir as colunas.
- Usar `updated_at` como watermark para cargas incrementais (substituir qualquer logica
  baseada em `executiondate`).
- Verificar se a sequence do `id` esta com valor maior que o maximo atual antes de reativar
  a carga:
  ```sql
  SELECT setval(
      pg_get_serial_sequence('homologacao.tmp_vitrine_indicadores_loja', 'id'),
      (SELECT MAX(id) FROM homologacao.tmp_vitrine_indicadores_loja)
  );
  ```

#### Migracao SQL

```sql
-- ==============================================================
-- V20260505__homologacao_tmp_vitrine_indicadores_loja.sql
-- Migracao: homologacao.fvitrine_indicadores_loja
--        -> homologacao.tmp_vitrine_indicadores_loja
-- Executar em janela de manutencao com DAG pausada.
-- ==============================================================

BEGIN;

-- 1. Renomear tabela
ALTER TABLE homologacao.fvitrine_indicadores_loja
    RENAME TO tmp_vitrine_indicadores_loja;

-- 2. Ajustar tipo da surrogate key para bigserial
--    (criar sequence, alterar coluna, vincular sequence)
CREATE SEQUENCE IF NOT EXISTS homologacao.tmp_vitrine_indicadores_loja_id_seq
    START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    ALTER COLUMN id TYPE bigint USING id::bigint,
    ALTER COLUMN id SET DEFAULT nextval(
        'homologacao.tmp_vitrine_indicadores_loja_id_seq'
    );

-- Sincronizar sequence com valor maximo atual
SELECT setval(
    'homologacao.tmp_vitrine_indicadores_loja_id_seq',
    COALESCE((SELECT MAX(id) FROM homologacao.tmp_vitrine_indicadores_loja), 1)
);

ALTER SEQUENCE homologacao.tmp_vitrine_indicadores_loja_id_seq
    OWNED BY homologacao.tmp_vitrine_indicadores_loja.id;

-- 3. Renomear colunas
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN company_id         TO id_company;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN "name"             TO nm_campanha;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN date_start         TO dth_inicio;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN date_end           TO dth_fim;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN store_id           TO cod_loja;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN nm_store           TO nm_loja;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN code               TO nr_code;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN nm_group           TO nm_grupo;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN store_status       TO ds_status_loja;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN aprovador          TO nm_aprovador;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN executor           TO nm_executor;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN comercial          TO nm_comercial;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN visualizador       TO nm_visualizador;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN franqueado         TO nm_franqueado;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN totalspace         TO qt_total_espacos;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN totaldone          TO qt_total_executados;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN totalnotapply      TO qt_total_nao_aplicavel;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN done               TO qt_executados;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN notapply           TO qt_nao_aplicavel;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN notdone            TO qt_nao_executados;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN executiondate      TO dth_execucao;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN ontime             TO pc_no_prazo;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN storeexecutiontime TO ds_tempo_execucao_loja;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN storeapprovaltime  TO ds_tempo_aprovacao_loja;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN notevaluatedontime  TO qt_nao_avaliado_no_prazo;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN notevaluatedofftime TO qt_nao_avaliado_fora_prazo;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN notsendontime       TO qt_nao_enviado_no_prazo;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN notsendofftime      TO qt_nao_enviado_fora_prazo;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN quality             TO pc_qualidade;
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME COLUMN rework              TO pc_retrabalho;

-- 4. Ajustar tipos de percentuais
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    ALTER COLUMN pc_no_prazo   TYPE numeric(7,4) USING pc_no_prazo::numeric(7,4),
    ALTER COLUMN pc_qualidade  TYPE numeric(7,4) USING pc_qualidade::numeric(7,4),
    ALTER COLUMN pc_retrabalho TYPE numeric(7,4) USING pc_retrabalho::numeric(7,4);

-- 5. Adicionar colunas de auditoria (nullable para nao quebrar pipeline existente)
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    ADD COLUMN IF NOT EXISTS created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN IF NOT EXISTS updated_at timestamp DEFAULT current_timestamp;

-- Preencher auditoria retroativamente com timestamp de migracao
UPDATE homologacao.tmp_vitrine_indicadores_loja
    SET created_at = current_timestamp,
        updated_at = current_timestamp
    WHERE created_at IS NULL;

-- Tornar NOT NULL apos preenchimento
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

-- 6. Renomear constraint de PK
ALTER TABLE homologacao.tmp_vitrine_indicadores_loja
    RENAME CONSTRAINT fvitrine_indicadores_loja_pkey
    TO tmp_vitrine_indicadores_loja_pkey;

-- 7. Criar indices
CREATE INDEX idx_tmp_vitrine_ind_loja_cod_loja
    ON homologacao.tmp_vitrine_indicadores_loja (cod_loja);

CREATE INDEX idx_tmp_vitrine_ind_loja_dth_inicio
    ON homologacao.tmp_vitrine_indicadores_loja (dth_inicio);

CREATE INDEX idx_tmp_vitrine_ind_loja_loja_inicio
    ON homologacao.tmp_vitrine_indicadores_loja (cod_loja, dth_inicio);

-- 8. View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW homologacao.fvitrine_indicadores_loja AS
    SELECT
        id,
        id_company           AS company_id,
        nm_campanha          AS "name",
        dth_inicio           AS date_start,
        dth_fim              AS date_end,
        cod_loja             AS store_id,
        nm_loja              AS nm_store,
        nr_code              AS code,
        nm_grupo             AS nm_group,
        ds_status_loja       AS store_status,
        nm_aprovador         AS aprovador,
        nm_executor          AS executor,
        nm_comercial         AS comercial,
        nm_visualizador      AS visualizador,
        nm_franqueado        AS franqueado,
        qt_total_espacos     AS totalspace,
        qt_total_executados  AS totaldone,
        qt_total_nao_aplicavel AS totalnotapply,
        qt_executados        AS done,
        qt_nao_aplicavel     AS notapply,
        qt_nao_executados    AS notdone,
        dth_execucao         AS executiondate,
        pc_no_prazo          AS ontime,
        ds_tempo_execucao_loja  AS storeexecutiontime,
        ds_tempo_aprovacao_loja AS storeapprovaltime,
        qt_nao_avaliado_no_prazo   AS notevaluatedontime,
        qt_nao_avaliado_fora_prazo AS notevaluatedofftime,
        qt_nao_enviado_no_prazo    AS notsendontime,
        qt_nao_enviado_fora_prazo  AS notsendofftime,
        pc_qualidade         AS quality,
        pc_retrabalho        AS rework
    FROM homologacao.tmp_vitrine_indicadores_loja;

COMMENT ON VIEW homologacao.fvitrine_indicadores_loja IS
    'DEPRECATED 2026-05-05: usar tmp_vitrine_indicadores_loja. Sera removida em 2026-08-03.';

COMMIT;
```

---

### homologacao.fvitrine_quality_by_space

**Nome proposto:** `homologacao.tmp_vitrine_qualidade_por_espaco`
**Tipo:** homologacao
**Descricao:** Tabela de homologacao que armazena indicadores de qualidade de execucao por espaco de vitrine dentro de uma loja. Cada registro representa a avaliacao de um espaco especifico (`space_id`) em uma loja (`store_id`), contendo a nota (estrelas), percentual de qualidade, percentual de nao-aplicabilidade e os motivos consolidados de aprovacao, reprovacao e nao-aplicabilidade em formato texto. Destinada a validar calculos granulares de qualidade por espaco antes da promocao ao schema definitivo.
**Sistema de origem:** API Live (plataforma de vitrine/lojas)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `store_id` | `varchar(50) NOT NULL` | `cod_loja` | `varchar(50) NOT NULL` | RENAME | Join key de entidade loja — prefixo `cod_` conforme secao 3.1. Permite join com `live.dlojas`. Compoe a PK composta. |
| `space_id` | `varchar(50) NOT NULL` | `cod_espaco` | `varchar(50) NOT NULL` | RENAME | Join key de espaco — prefixo `cod_` conforme secao 3.1. Compoe a PK composta. |
| `name` | `varchar(150) NULL` | `nm_espaco` | `varchar(150) NULL` | RENAME | Nome do espaco — prefixo `nm_` conforme secao 3.2. Nome `name` e ingles generico. |
| `orientation` | `text NULL` | `ds_orientacao` | `text NULL` | RENAME | Texto de orientacao de execucao — prefixo `ds_` conforme secao 3.2. Tipo `text` adequado para conteudo variavel sem limite conhecido. |
| `star` | `numeric(5,2) NULL` | `pc_estrelas` | `numeric(7,4) NULL` | RENAME | RETYPE | Nota em estrelas interpretada como percentual/pontuacao — prefixo `pc_`. Tipo padrao `numeric(7,4)` conforme secao 8. Se for escala absoluta (ex.: 1-5), considerar `vl_estrelas numeric(5,2)`. |
| `quality` | `numeric(5,2) NULL` | `pc_qualidade` | `numeric(7,4) NULL` | RENAME | RETYPE | Percentual de qualidade do espaco — prefixo `pc_`. Tipo padrao `numeric(7,4)` conforme secao 8. |
| `notapply` | `numeric(5,2) NULL` | `pc_nao_aplicavel` | `numeric(7,4) NULL` | RENAME | RETYPE | Percentual de itens nao aplicaveis no espaco — prefixo `pc_`. Tipo padrao `numeric(7,4)` conforme secao 8. |
| `notapplyreasons` | `text NULL` | `obs_motivos_nao_aplicavel` | `text NULL` | RENAME | Texto livre com motivos de nao-aplicabilidade — prefixo `obs_` conforme secao 3.2. |
| `approvedreasons` | `text NULL` | `obs_motivos_aprovacao` | `text NULL` | RENAME | Texto livre com motivos de aprovacao — prefixo `obs_` conforme secao 3.2. |
| `reprovedreasons` | `text NULL` | `obs_motivos_reprovacao` | `text NULL` | RENAME | Texto livre com motivos de reprovacao — prefixo `obs_` conforme secao 3.2. |
| _(ausente)_ | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria conforme secao 4 das boas praticas. |
| _(ausente)_ | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | ADD | Coluna de auditoria obrigatoria conforme secao 4 das boas praticas. Usada como watermark para carga incremental. |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
-- PK composta mantida; renomear colunas que a compoem
CONSTRAINT tmp_vitrine_qualidade_por_espaco_pkey PRIMARY KEY (cod_loja, cod_espaco)
```

A PK atual `(store_id, space_id)` e estruturalmente adequada. Apos renomear as colunas, a
constraint deve ser recriada com os novos nomes. Nao ha surrogate key porque a combinacao
`(cod_loja, cod_espaco)` identifica o registro de forma natural e unica.

#### Relacionamentos propostos

```
homologacao.tmp_vitrine_qualidade_por_espaco
  |- cod_loja   ->  live.dlojas.store_id   (join por convencao; sem FK declarada)
  |- (cod_loja) ->  homologacao.tmp_vitrine_indicadores_loja.cod_loja
                    (correlacao de contexto; sem FK declarada)
```

O campo `cod_espaco` nao possui dimensao correspondente no DW atual. Documentar no DAG
que `cod_espaco` e um identificador natural vindo da API Live e nao referencia tabela
de dimensao.

#### Indices recomendados

```sql
-- Filtro por loja (consulta mais frequente: todos os espacos de uma loja)
CREATE INDEX idx_tmp_vitrine_qps_cod_loja
    ON homologacao.tmp_vitrine_qualidade_por_espaco (cod_loja);

-- Filtro por espaco (consulta de desempenho de um espaco especifico)
CREATE INDEX idx_tmp_vitrine_qps_cod_espaco
    ON homologacao.tmp_vitrine_qualidade_por_espaco (cod_espaco);
```

A PK composta `(cod_loja, cod_espaco)` ja indexa a combinacao completa. Os indices adicionais
cobrem filtros por coluna individual.

#### Impacto no ETL

- A DAG de carga deve ser pausada durante a execucao do DDL (renomeacao de PK composta
  requer DROP/RECREATE da constraint).
- Atualizar aliases no SELECT do pipeline: `store_id AS cod_loja`, `space_id AS cod_espaco`,
  `name AS nm_espaco`, etc.
- Ajustar o tipo de `star`, `quality` e `notapply` de `numeric(5,2)` para `numeric(7,4)`:
  os valores existentes sao representaveis sem perda de precisao (ampliacao de escala).
- Inserir `created_at` e `updated_at` no pipeline; o banco aplica o DEFAULT automaticamente
  se o ETL omitir as colunas.
- Usar `updated_at` como watermark para cargas incrementais.
- Validar se a combinacao `(cod_loja, cod_espaco)` e verdadeiramente unica no fonte antes
  de cada carga para evitar violacao de PK.

#### Migracao SQL

```sql
-- ==============================================================
-- V20260505__homologacao_tmp_vitrine_qualidade_por_espaco.sql
-- Migracao: homologacao.fvitrine_quality_by_space
--        -> homologacao.tmp_vitrine_qualidade_por_espaco
-- Executar em janela de manutencao com DAG pausada.
-- ==============================================================

BEGIN;

-- 1. Renomear tabela
ALTER TABLE homologacao.fvitrine_quality_by_space
    RENAME TO tmp_vitrine_qualidade_por_espaco;

-- 2. Renomear colunas
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN store_id         TO cod_loja;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN space_id         TO cod_espaco;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN "name"           TO nm_espaco;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN orientation      TO ds_orientacao;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN star             TO pc_estrelas;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN quality          TO pc_qualidade;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN notapply         TO pc_nao_aplicavel;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN notapplyreasons  TO obs_motivos_nao_aplicavel;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN approvedreasons  TO obs_motivos_aprovacao;
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    RENAME COLUMN reprovedreasons  TO obs_motivos_reprovacao;

-- 3. Ajustar tipos de percentuais/pontuacao
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    ALTER COLUMN pc_estrelas      TYPE numeric(7,4) USING pc_estrelas::numeric(7,4),
    ALTER COLUMN pc_qualidade     TYPE numeric(7,4) USING pc_qualidade::numeric(7,4),
    ALTER COLUMN pc_nao_aplicavel TYPE numeric(7,4) USING pc_nao_aplicavel::numeric(7,4);

-- 4. Recriar constraint de PK com novos nomes de coluna
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    DROP CONSTRAINT fvitrine_quality_by_space_pkey;

ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    ADD CONSTRAINT tmp_vitrine_qualidade_por_espaco_pkey
        PRIMARY KEY (cod_loja, cod_espaco);

-- 5. Adicionar colunas de auditoria (nullable para nao quebrar pipeline existente)
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    ADD COLUMN IF NOT EXISTS created_at timestamp DEFAULT current_timestamp,
    ADD COLUMN IF NOT EXISTS updated_at timestamp DEFAULT current_timestamp;

-- Preencher auditoria retroativamente
UPDATE homologacao.tmp_vitrine_qualidade_por_espaco
    SET created_at = current_timestamp,
        updated_at = current_timestamp
    WHERE created_at IS NULL;

-- Tornar NOT NULL apos preenchimento
ALTER TABLE homologacao.tmp_vitrine_qualidade_por_espaco
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

-- 6. Criar indices
CREATE INDEX idx_tmp_vitrine_qps_cod_loja
    ON homologacao.tmp_vitrine_qualidade_por_espaco (cod_loja);

CREATE INDEX idx_tmp_vitrine_qps_cod_espaco
    ON homologacao.tmp_vitrine_qualidade_por_espaco (cod_espaco);

-- 7. View de compatibilidade (remover apos 90 dias — 2026-08-03)
CREATE OR REPLACE VIEW homologacao.fvitrine_quality_by_space AS
    SELECT
        cod_loja                  AS store_id,
        cod_espaco                AS space_id,
        nm_espaco                 AS "name",
        ds_orientacao             AS orientation,
        pc_estrelas               AS star,
        pc_qualidade              AS quality,
        pc_nao_aplicavel          AS notapply,
        obs_motivos_nao_aplicavel AS notapplyreasons,
        obs_motivos_aprovacao     AS approvedreasons,
        obs_motivos_reprovacao    AS reprovedreasons
    FROM homologacao.tmp_vitrine_qualidade_por_espaco;

COMMENT ON VIEW homologacao.fvitrine_quality_by_space IS
    'DEPRECATED 2026-05-05: usar tmp_vitrine_qualidade_por_espaco. Sera removida em 2026-08-03.';

COMMIT;
```

---

## Resumo das Alteracoes

| Tabela atual | Tabela proposta | Colunas renomeadas | Colunas retype | Colunas adicionadas |
|---|---|---|---|---|
| `fvitrine_indicadores_loja` | `tmp_vitrine_indicadores_loja` | 28 | 4 (`id`, `pc_no_prazo`, `pc_qualidade`, `pc_retrabalho`) | 2 (`created_at`, `updated_at`) |
| `fvitrine_quality_by_space` | `tmp_vitrine_qualidade_por_espaco` | 10 | 3 (`pc_estrelas`, `pc_qualidade`, `pc_nao_aplicavel`) | 2 (`created_at`, `updated_at`) |

## Ordem de Execucao das Migracoes

As duas migracoes sao independentes entre si e podem ser executadas em qualquer ordem.
Recomenda-se executar em janela de manutencao com ambas as DAGs pausadas para evitar
conflito de escrita durante o DDL.

1. `V20260505__homologacao_tmp_vitrine_indicadores_loja.sql`
2. `V20260505__homologacao_tmp_vitrine_qualidade_por_espaco.sql`

Apos 90 dias (2026-08-03), remover as views de compatibilidade:

```sql
DROP VIEW IF EXISTS homologacao.fvitrine_indicadores_loja;
DROP VIEW IF EXISTS homologacao.fvitrine_quality_by_space;
```
