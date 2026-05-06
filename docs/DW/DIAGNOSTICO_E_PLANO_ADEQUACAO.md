# Diagnóstico e Plano de Adequação do Data Warehouse

> **Versão:** 1.0 | **Data:** 2026-05-05  
> **Baseado em análise de:** `DLL_DW.sql` (963 tabelas), 172 arquivos JSON de schema, `DLL_Senior.sql`, `DLL_Systextil.sql`, `DLL_Orion.sql`

---

## A. Diagnóstico Atual

### Problemas Críticos (bloqueadores de governança)

| # | Problema | Impacto | Exemplo concreto |
|---|----------|---------|------------------|
| 1 | **Coluna de auditoria com 3 nomes diferentes** | Joins e pipelines quebram ao mudar schema | `dthora_atualizacao` vs `ultima_atualizacao` vs `updated_at` |
| 2 | **Prefixo de código sem padrão** | Ambiguidade semântica em queries | `cd_empresa` vs `cod_empresa` vs `codigo_deposito` |
| 3 | **Prefixo de valor sem padrão** | BI tools geram campos duplicados | `vlr_franchising` vs `valor_unitario` vs `valor_desconto` |
| 4 | **Prefixo de quantidade sem padrão** | Aggregates incorretos em dashboards | `qtd_movimento` vs `quantidade_entrada` vs `qtde_item_fatur` |
| 5 | **Tabela `jma.ffaturamento_dev_inc` com colunas UPPER_CASE quoted** | Quebra qualquer ORM/tool sem aspas | `"PK_CLIENTE"`, `"NF_CDREP"`, `"ITEMNF_VLRFAT"` |
| 6 | **PKs com tipos inconsistentes para a mesma entidade** | JOINs silenciosamente errados (cast implícito) | `fk_cliente varchar(20)` vs `varchar(25)` vs `pk_cliente varchar(16)` |
| 7 | **Prefixo de tabela sem underscore** | Dificulta filtros por tipo de tabela | `drepresentante`, `fpedido` ao invés de `d_representante`, `f_pedido` |
| 8 | **Schemas `api` e `eventos` com padrão completamente diferente** | Dois mundos dentro do mesmo DW | `id serial4`, `created_at`, nomes em inglês |
| 9 | **CNPJ/CPF com múltiplos formatos** | JOINs incorretos entre entidades | `XX.XXX.XXX/YYYY-ZZ` vs `XXXXXXXX/YYYY-ZZ` vs `XXXXXXXXYYYYZZ` |
| 10 | **CNPJ/CPF fragmentado em 3 colunas no Systextil** | Reconstrução inconsistente nos pipelines | `CGC_9`+`CGC_4`+`CGC_2` vs `CGC_R`+`CGC_O`+`CGC_2` (alfanumérico) |

### Inconsistências Secundárias

- Prefixo de descrição: `desc_` vs `descr_` vs `nm_` vs `cd_ds_`
- Prefixo de data: `dt_` vs `data_` vs `dthora_`
- Prefixo de percentual: `perc_` vs `percentual_`
- Campos de endereço: `endereco` vs `endereco_fornecedor` vs `cd_endereco`
- Campos de status: `situacao_cliente` vs `cd_situacao_fornecedor` vs `situacao`
- Ausência de `created_at` na maioria das tabelas
- Ausência de padrão para soft-delete

### Análise do Schema PPCP — Erros Encontrados no Mapeamento Parcial

> Baseado em análise do arquivo `Conversor_colunas_dw(Colunas renomeadas).csv` — 24 tabelas, ~170 colunas do schema `ppcp`.

| # | Erro | Linhas CSV afetadas | Impacto |
|---|------|--------------------|---------| 
| E1 | **`dthora_atualizacao` mapeado para `ultima_atualizacao`** (direção errada — destino é tão não-padrão quanto a origem) | `ppcp.froteiro` (linha 28) | Pipeline incremental continua quebrado |
| E2 | **Prefixo `codigo_` usado em ~30 colunas** (palavra completa proibida) | Disseminado em 15+ tabelas | Linter vai rejeitar todo o schema |
| E3 | **`fk_produto` → `id_produto`** ignorando regra de SKU | `ppcp.ftempo_tear` (l.2), `ppcp.froteiro` (l.29), `ppcp.fordens_corte` (l.136), + outros | Join de produto fica inconsistente com restante do DW |
| E4 | **`fk_fornecedor` → `id_fornecedor`** quando deveria ser `cod_fornecedor` (entidade com dimensão) | `ppcp.fordens_corte` (linha 137) | Join com `d_fornecedor` quebrado por nome |
| E5 | **Prefixos de palavra completa**: `sequencia_`, `numero_`, `descricao_`, `nome_`, `quantidade_` usados como prefixo | Disseminado | Equivalente ao problema E2 |
| E6 | **Inconsistência interna no CSV**: `Para = id_tecido` mas `OBS = Mudar para sku_tecido`** | `ppcp.frolos_reservados` (l.32), `ppcp.frejeicao_pecas_tecido` (l.37) | Executar o CSV literalmente gera coluna `id_tecido` incorreta |
| E7 | **`rolos_produzido`, `rolos_programado`, `rolos_preprarados`** sem prefixo de quantidade (+ typo em "preprarados") | `ppcp.fordens_tecelagem` (l.61-63), `ppcp.fordens_beneficiamento` | Aggregates sem prefixo `qt_` |
| E8 | **Trailing space em `sequencia_estagio `** | `ppcp.flista_prioridades` (linha 185) | DDL com nome de coluna errado |
| E9 | **Linha sem nome de tabela** (`;desc_empresa;nome_empresa;`) | Linha 207 | Mapeamento incompleto — aplicar a qual tabela? |
| E10 | **`ordemreposicaoformatted`** com `Para` vazio + `qtde_programada`** com `Para` vazio | `ppcp.fordens_reposicoes` (l.64), `ppcp.fordens_em_producao` (l.113) | Devem ser excluídas — confirmar antes de executar |

### Riscos Técnicos

| Risco | Descrição |
|-------|-----------|
| JOINs com cast implícito | `varchar(16)` vs `varchar(25)` para mesma entidade — full scan silencioso |
| Pipelines frágeis | Dependência em `dthora_atualizacao` falha em tabelas que usam `ultima_atualizacao` |
| Onboarding caro | Analistas não conseguem inferir tipo de tabela ou qual campo usar para incremental load |
| CNPJ alfanumérico não suportado | Colunas `int8` para CNPJ quebrarão com a IN RFB 2.229/2024 |

### Inventário de Prefixos Conflitantes Encontrados

| Categoria | Prefixos encontrados | Padrão proposto |
|-----------|---------------------|-----------------|
| Código | `cd_`, `cod_`, `codigo_` | `id_` (operacional) / `cod_` (entidade) |
| Valor | `vlr_`, `valor_`, `itemped_valor*` | `vl_` |
| Quantidade | `qtd_`, `quantidade_`, `qtde_` | `qt_` |
| Percentual | `perc_`, `percentual_`, `ped_perc*` | `pc_` |
| Descrição | `desc_`, `descr_`, `nm_`, `cd_ds_` | `ds_` (curto) / `nm_` (nome) |
| Data | `dt_`, `data_`, `dthora_` | `dt_` (date) / `dth_` (timestamp) |
| Auditoria update | `dthora_atualizacao`, `ultima_atualizacao`, `updated_at` | `updated_at` |

---

## B. Mapeamento de Adequação

### Tabelas para Renomear (sem underscore → com underscore)

| Schema | Nome atual | Nome proposto | Tipo |
|--------|-----------|--------------|------|
| comercial | `drepresentante` | `d_representante` | dimensão |
| comercial | `fpedido` | `f_pedido` | fato |
| comercial | `fitens_pedidos` | `f_pedido_item` | fato |
| comercial | `dprevisao_venda_capa` | `d_previsao_venda_capa` | dimensão |
| comercial | `dprevisao_venda_item` | `d_previsao_venda_item` | dimensão |
| comercial | `destacao_colecao_subcolecao` | `d_estacao_colecao` | dimensão |
| estoque | `dtipo_movimentacaoestoque` | `d_tipo_movimento_estoque` | dimensão |
| estoque | `frolos_estoq` | `f_rolo_estoque` | fato |
| jma | `ffaturamento_dev_inc` | `f_faturamento_item` (mover para comercial) | fato |
| jma | `daparelho` | `d_aparelho` | dimensão |
| jma | `dcentro_custo` | `d_centro_custo` | dimensão |
| jma | `dgrupo_contas` | `d_grupo_contas` | dimensão |
| jma | `dnatureza_operacao` | `d_natureza_operacao` | dimensão |

### Colunas de Auditoria para Padronizar

```sql
-- Identificar todas as variantes (executar primeiro):
SELECT table_schema, table_name, column_name
FROM information_schema.columns
WHERE column_name IN ('dthora_atualizacao', 'ultima_atualizacao', 'dthora_atu')
ORDER BY table_schema, table_name;
```

Ambas as variantes serão renomeadas para `updated_at`.

### Chaves Primárias/Estrangeiras para Migrar

| Padrão atual | Padrão novo | Nota |
|-------------|-------------|------|
| `pk_cliente varchar(16)` | `cod_cliente varchar(20) UNIQUE` | business key — visível externamente |
| `pk_produto varchar(25)` | `cod_produto varchar(25) UNIQUE` | idem |
| `pk_representante varchar(6)` | `cod_representante varchar(6) UNIQUE` | idem |
| `fk_cliente varchar(20)` | `cod_cliente varchar(20)` | renomear para join key |
| `fk_produto varchar(25)` | `cod_produto varchar(25)` | renomear para join key |

> A adição do `id bigserial` como surrogate key é um detalhe interno de cada dimensão — não faz parte do mapeamento de colunas externas. Cada dimensão receberá `id bigserial PRIMARY KEY` durante a Fase 6, mas essa coluna nunca aparece em fatos nem em queries de negócio.

### CNPJ/CPF — Nomes padrão por entidade (dimensão define o nome)

| Entidade | Dimensão | Coluna padrão | Tipo | Situação atual |
|----------|----------|---------------|------|----------------|
| Cliente | `d_cliente` | `cnpj_cliente` | `varchar(16)` | Nome correto; verificar tipo (`int8` → `varchar(16)`) |
| Representante | `d_representante` | `cnpj_repres` | `varchar(16)` | Nome correto; verificar tipo (`int8` → `varchar(16)`) |
| Fornecedor | `d_fornecedor` | `cnpj_fornecedor` | `varchar(16)` | Nome correto; verificar tipo |
| Transportadora | `d_transportadora` | `cnpj_transportadora` | `varchar(16)` | Mapear colunas Systextil |

**O que deve ser corrigido:**
- Tipo das colunas onde ainda é `int8` ou `numeric` (não suporta alfanumérico)
- Nomes inconsistentes em tabelas fato (ex: `cgc_cliente`, `nr_doc_cli` → renomear para `cnpj_cliente`)
- Pipelines de ingestão para suportar `_R`/`_O` (CNPJ alfanumérico) com fallback para `_9`/`_4`

**O que NÃO deve ser alterado:**
- Colunas já nomeadas corretamente (`cnpj_cliente`, `cnpj_repres`, `cnpj_fornecedor`)

---

## C. Plano de Migração

### Abordagem: Incremental por Schema (recomendado)

| Critério | Incremental | Big Bang |
|----------|------------|----------|
| Risco | Baixo | Muito alto |
| Consumidores | Adapta gradualmente | Quebra tudo |
| Rollback | Drop view | Restore backup |

**Estratégia de compatibilidade:** renomear tabela → criar view com nome antigo → deprecar após 90 dias.

---

### Fase 0 — Inventário e Baseline

**Objetivo:** mapear impacto completo antes de qualquer mudança.

- [ ] Exportar lista completa de tabelas + colunas do PostgreSQL para planilha de controle
- [ ] Mapear todos os consumidores (BI tools, APIs, DAGs do Airflow)
- [ ] Definir janela de manutenção por schema
- [ ] Criar schema `_legado` para views de compatibilidade
- [ ] Definir dicionário de entidades (tipos canônicos de `cod_<entidade>`)

---

### Fase 1 — Auditoria: `updated_at` / `created_at` ⚡ Alta prioridade

**Escopo:** 963 tabelas — zero quebra de negócio se feito corretamente.

```sql
-- Renomear variantes de auditoria para updated_at
DO $$
DECLARE r RECORD;
BEGIN
    FOR r IN
        SELECT table_schema, table_name, column_name
        FROM information_schema.columns
        WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
          AND column_name IN ('dthora_atualizacao', 'ultima_atualizacao', 'dthora_atu')
    LOOP
        EXECUTE format(
            'ALTER TABLE %I.%I RENAME COLUMN %I TO updated_at',
            r.table_schema, r.table_name, r.column_name
        );
    END LOOP;
END $$;

-- Adicionar created_at onde não existe
DO $$
DECLARE r RECORD;
BEGIN
    FOR r IN
        SELECT t.table_schema, t.table_name
        FROM information_schema.tables t
        WHERE t.table_type = 'BASE TABLE'
          AND t.table_schema NOT IN ('pg_catalog', 'information_schema')
          AND NOT EXISTS (
            SELECT 1 FROM information_schema.columns c
            WHERE c.table_schema = t.table_schema
              AND c.table_name = t.table_name
              AND c.column_name = 'created_at'
          )
    LOOP
        EXECUTE format(
            'ALTER TABLE %I.%I ADD COLUMN created_at timestamp DEFAULT current_timestamp',
            r.table_schema, r.table_name
        );
    END LOOP;
END $$;
```

**Validação:**
```sql
SELECT table_schema, table_name, column_name
FROM information_schema.columns
WHERE column_name IN ('dthora_atualizacao', 'ultima_atualizacao')
ORDER BY table_schema;
-- Deve retornar zero linhas após a migração
```

---

### Fase 2 — Tabela `jma.ffaturamento_dev_inc` ⚡ Alta prioridade

**Problema:** única tabela com colunas UPPER_CASE quoted — quebra qualquer ferramenta padrão.

```sql
BEGIN;

CREATE TABLE jma.f_faturamento_item AS
SELECT
    "PK_CLIENTE"           AS cod_cliente,
    "PK_PRODUTO"           AS cod_produto,
    "CD_BARRA"             AS cd_barra,
    "NF_NOTAFISCAL"        AS nr_nota_fiscal,
    "NF_SERIENOTAFISCAL"   AS ds_serie_nf,
    "NF_DTEMISSAO"         AS dt_emissao,
    "NF_COD_SITUACAO"      AS id_situacao,
    "NF_COD_NATUREZA"      AS id_natureza,
    "ITEMNF_QTDFATURADA"   AS qt_faturada,
    "ITEMNF_VLRUNIT"       AS vl_unitario,
    "ITEMNF_VLRFAT"        AS vl_faturado,
    "ITEMNF_VLR_CONTABIL"  AS vl_contabil,
    "ITEMNF_VLRICMS"       AS vl_icms,
    "ITEMNF_VLRIPI"        AS vl_ipi,
    "ITEMNF_VLRPIS"        AS vl_pis,
    "ITEMNF_VLRCOFINS"     AS vl_cofins,
    "ITEMNF_PESOLIQUIDO"   AS ps_liquido,
    "ITEMNF_VLR_FRANCHISING" AS vl_franchising,
    "PERC_DESC_FRAN"       AS pc_desconto_franquia,
    "DATA_EMBARQUE"        AS dt_embarque,
    "ULTIMA_ATUALIZACAO"   AS updated_at
FROM jma.ffaturamento_dev_inc;

-- View de compatibilidade (manter até todos os consumers serem migrados)
CREATE OR REPLACE VIEW jma.ffaturamento_dev_inc_v1 AS SELECT * FROM jma.ffaturamento_dev_inc;
COMMENT ON VIEW jma.ffaturamento_dev_inc_v1 IS 'DEPRECATED: usar jma.f_faturamento_item';

COMMIT;
```

---

### Fase 3 — Prefixos de Colunas por Schema

**Ordem por impacto crescente:**

| Ordem | Schema | Tabelas aprox. | Complexidade |
|-------|--------|----------------|--------------|
| 1 | `homologacao`, `temporario` | ~15 | Baixa |
| 2 | `jma` | ~40 | Média |
| 3 | `rh`, `rh_sci` | ~60 | Média |
| 4 | `ppcp` | ~30 | Média |
| 5 | `estoque` | ~80 | Alta |
| 6 | `financeiro` | ~70 | Alta |
| 7 | `comercial` | ~150 | Muito Alta |
| 8 | `api`, `eventos` | ~80 | Avaliar: manter inglês? |

**Mapeamento de renomeação (amostra):**

| Padrão atual | Padrão novo | Tipo de mudança |
|-------------|-------------|-----------------|
| `valor_unitario` / `vlr_unit` / `itemped_valorunitario` | `vl_unitario` | unificação |
| `qtd_pedida` / `qtde_pedida` / `quantidade_pedida` | `qt_pedida` | unificação |
| `percentual_desc` / `perc_desconto` | `pc_desconto` | unificação |
| `desc_produto` / `descr_prod` | `ds_produto` | unificação |
| `data_emissao` / `dt_emissao` | `dt_emissao` | unificação |
| `cod_empresa` | `id_empresa` | operacional → `id_` |
| `cod_natureza` | `id_natureza` | operacional → `id_` |
| `pk_cliente` | `cod_cliente` + `id bigserial` | split (Fase 6) |

**Mapeamento específico do schema `ppcp` (corrigindo erros do CSV):**

| Padrão CSV proposto | Padrão correto | Regra aplicada |
|--------------------|---------------|----------------|
| `id_produto` / `fk_produto` | `sku_produto` | SKU padrão — seção 6.1 |
| `id_tecido` / `fk_tecido` | `sku_tecido` | SKU padrão — seção 6.1 |
| `codigo_estagio` | `id_estagio` | `codigo_` proibido; código operacional → `id_` |
| `codigo_situacao` | `id_situacao` | idem |
| `codigo_cor` | `id_cor` | idem |
| `codigo_colecao` | `id_colecao` | idem |
| `codigo_maquina` | `id_maquina` | idem (ou `cod_maquina` se houver `d_maquina`) |
| `codigo_roteiro` | `nr_roteiro` | número de roteiro — `nr_` |
| `codigo_operacao` | `id_operacao` | código operacional |
| `codigo_divisao` | `id_divisao` | idem |
| `codigo_cancelamento` | `id_cancelamento` | idem |
| `codigo_linha` | `id_linha` | idem |
| `codigo_artigo` | `id_artigo` | idem |
| `codigo_estagio_depende` | `id_estagio_depende` | idem |
| `sequencia_operacao` | `nr_seq_operacao` | `sequencia_` proibido; `nr_` para sequencial |
| `sequencia_estagio` | `nr_seq_estagio` | idem |
| `sequencia_estrutura` | `nr_seq_estrutura` | idem |
| `descricao_referencia` | `ds_referencia` | `descricao_` proibido → `ds_` |
| `descricao_situacao` | `ds_situacao` | idem |
| `descricao_motivo` | `ds_motivo` | idem |
| `descricao_estagio` | `ds_estagio` | idem |
| `descricao_colecao` | `ds_colecao` | idem |
| `descricao_familia` | `ds_familia` | idem |
| `numero_agulhas` | `nr_agulhas` | `numero_` proibido — `nr_` já era correto |
| `nome_grupo_maquina` | `nm_grupo_maquina` | `nome_` proibido → `nm_` |
| `unidade_medida` | `id_unidade_medida` | sem prefixo → `id_` (código operacional) |
| `tipo_maquina` | `id_tipo_maquina` | sem prefixo → `id_` |
| `ordem_producao` | `nr_ordem_producao` | número de documento → `nr_` |
| `ordem_confeccao` | `nr_ordem_confeccao` | idem |
| `ordem_reposicao` | `nr_ordem_reposicao` | idem |
| `rolos_produzido` | `qt_rolos_produzido` | quantidade sem prefixo → `qt_` |
| `rolos_programado` | `qt_rolos_programado` | idem |
| `rolos_preprarados` (typo) | `qt_rolos_preparado` | idem + correção de typo |
| `quantidade_*` (genérico) | `qt_*` | unificação |
| `dthora_atualizacao` → `ultima_atualizacao` | `updated_at` | ❌ CSV errado — destino deve ser `updated_at` |
| `id_fornecedor` (de `fk_fornecedor`) | `cod_fornecedor` | entidade com dimensão → `cod_` |
| `data_geracao`, `data_baixa_estagio` | `dt_geracao`, `dt_baixa_estagio` | `data_` proibido → `dt_` |
| `agrupamento_artigo` | `ds_agrupamento_artigo` | sem prefixo → `ds_` |
| `periodo_producao` | `nr_periodo_producao` | período numérico → `nr_` |
| `nome_faccao` | `nm_faccao` | `nome_` proibido → `nm_` |
| `usuario_gerador`, `usuario_baixa_estagio` | `nm_usuario_gerador`, `nm_usuario_baixa_estagio` | sem prefixo → `nm_` |
| `tempo_unitario` | `nr_tempo_unitario` | sem prefixo → `nr_` |

---

### Fase 4 — Renomeação de Tabelas

**Template de migração:**

```sql
-- Etapa 1: renomear tabela
ALTER TABLE comercial.drepresentante RENAME TO d_representante;

-- Etapa 2: view de compatibilidade (manter 90 dias)
CREATE OR REPLACE VIEW comercial.drepresentante AS
    SELECT * FROM comercial.d_representante;
COMMENT ON VIEW comercial.drepresentante IS
    'DEPRECATED: usar d_representante';
```

**Tabelas prioritárias:**

| Atual | Proposto | Schema |
|-------|----------|--------|
| `drepresentante` | `d_representante` | comercial |
| `fpedido` | `f_pedido` | comercial |
| `fitens_pedidos` | `f_pedido_item` | comercial |
| `dtipo_movimentacaoestoque` | `d_tipo_movimento_estoque` | estoque |
| `frolos_estoq` | `f_rolo_estoque` | estoque |

---

### Fase 5 — CNPJ / CPF

**Princípio:** a dimensão define o nome. Colunas já nomeadas corretamente (`cnpj_cliente`, `cnpj_repres`, `cnpj_fornecedor`) **não são renomeadas**. O trabalho é: corrigir tipo, padronizar nomes inconsistentes em fatos, e atualizar pipelines para suportar CNPJ alfanumérico.

**Etapa 1 — Mapear colunas de CNPJ/CPF no DW e nos pipelines**

```bash
# Localizar todas as colunas que representam CNPJ/CPF no DW
grep -Ei '(cnpj|cpf|cgc|documento)' docs/DW/DLL_DW.sql | grep -i 'column' | sort -u

# Localizar colunas fragmentadas no Systextil (origem)
grep -Ei '[A-Z_]+(9|_R|4|_O|2)[[:space:]]' docs/Systextil/DLL_Systextil.sql | sort -u
```

**Etapa 2 — Corrigir tipo onde ainda é `int8` ou `numeric`**

Colunas com tipo numérico não suportam CNPJ alfanumérico (IN RFB 2.229/2024).

```sql
-- Corrigir somente onde o tipo está errado; NÃO renomear
ALTER TABLE comercial.d_representante
    ALTER COLUMN cnpj_repres TYPE varchar(16)
    USING cnpj_repres::varchar;

-- Repetir para cada tabela com tipo incorreto
-- (identificar via information_schema)
SELECT table_schema, table_name, column_name, data_type
FROM information_schema.columns
WHERE column_name IN ('cnpj_cliente', 'cnpj_repres', 'cnpj_fornecedor', 'cnpj_transportadora')
  AND data_type NOT IN ('character varying', 'text')
ORDER BY table_schema, table_name;
```

**Etapa 3 — Renomear somente colunas inconsistentes em tabelas fato**

Fatos que usam nomes diferentes do padrão da dimensão devem ser corrigidos:

```sql
-- Exemplos de nomes inconsistentes encontrados → renomear para o padrão da dimensão
ALTER TABLE comercial.f_vendas   RENAME COLUMN cgc_cliente   TO cnpj_cliente;
ALTER TABLE comercial.f_pedido   RENAME COLUMN nr_doc_cli    TO cnpj_cliente;
ALTER TABLE financeiro.f_receber RENAME COLUMN cnpj          TO cnpj_cliente;

-- Regra: o nome deve ser idêntico ao da dimensão de referência
-- d_cliente.cnpj_cliente → f_*.cnpj_cliente
-- d_representante.cnpj_repres → f_*.cnpj_repres
-- d_fornecedor.cnpj_fornecedor → f_*.cnpj_fornecedor
```

**Etapa 4 — Atualizar pipelines de ingestão para suportar CNPJ alfanumérico**

Prioridade: `_R`/`_O` (novo alfanumérico) → fallback `_9`/`_4` (legado numérico).

```sql
-- Ingestão Systextil → d_cliente
SELECT
    dw.fn_formatar_cnpj_cpf(
        COALESCE(NULLIF(TRIM(cgc_r), ''), cgc_9::text),  -- _R tem prioridade
        COALESCE(NULLIF(TRIM(cgc_o), ''), cgc_4::text),  -- _O tem prioridade
        cgc_2
    ) AS cnpj_cliente,                                    -- alias = nome da dimensão
    CASE
        WHEN COALESCE(NULLIF(TRIM(cgc_o), ''), cgc_4::text) IN ('0', '0000') THEN 'CPF'
        ELSE 'CNPJ'
    END AS tp_documento_cliente
FROM systextil.clientes;
```

Função completa disponível em `BOAS_PRATICAS_DW.md` seção 7.4.

**Etapa 5 — Backfill de registros com formato antigo**

```sql
-- Identificar registros com formato inválido (com pontos ou sem separadores)
SELECT COUNT(*) AS a_corrigir
FROM comercial.d_cliente
WHERE cnpj_cliente ~ '\.'              -- formato XX.XXX.XXX/...
   OR cnpj_cliente ~ '^[0-9]{14}$';   -- 14 dígitos sem formatação

-- Reprocessar da staging (preferencial) ou aplicar formatação direta
UPDATE comercial.d_cliente
SET cnpj_cliente = dw.fn_formatar_cnpj_cpf(
    LEFT(REGEXP_REPLACE(cnpj_cliente, '[^0-9A-Z]', '', 'g'), 8),
    SUBSTRING(REGEXP_REPLACE(cnpj_cliente, '[^0-9A-Z]', '', 'g'), 9, 4),
    RIGHT(REGEXP_REPLACE(cnpj_cliente, '[^0-9A-Z]', '', 'g'), 2)::int
)
WHERE cnpj_cliente ~ '\.'
   OR cnpj_cliente ~ '^[0-9]{14}$';
```

**Etapa 6 — Validar consistência entre dimensão e fatos**

```sql
-- Joins inconsistentes: fatos com cnpj_cliente que não existem em d_cliente
SELECT COUNT(*) AS orfaos
FROM comercial.f_pedido f
WHERE f.cnpj_cliente IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM comercial.d_cliente d
    WHERE d.cnpj_cliente = f.cnpj_cliente
  );

-- Validar formato em todas as tabelas com coluna cnpj_cliente
SELECT 'f_pedido' AS tabela,
    SUM(CASE WHEN cnpj_cliente ~ '^[0-9]{8}/[0-9]{4}-[0-9]{2}$'
                 OR cnpj_cliente ~ '^[0-9A-Z]{8}/[0-9A-Z]{4}-[0-9]{2}$'
                 OR cnpj_cliente ~ '^[0-9]{9}-[0-9]{2}$'
             THEN 1 ELSE 0 END) AS validos,
    COUNT(*) AS total
FROM comercial.f_pedido
WHERE cnpj_cliente IS NOT NULL;
```

---

### Fase 6 — Surrogate Keys: `id` + `cod_`

**Alta prioridade — requer mapeamento completo de consumers antes de iniciar.**

```sql
BEGIN;

-- Exemplo: d_cliente
ALTER TABLE comercial.d_cliente ADD COLUMN id bigserial;
ALTER TABLE comercial.d_cliente RENAME COLUMN pk_cliente TO cod_cliente;
ALTER TABLE comercial.d_cliente ADD CONSTRAINT uq_d_cliente_cod UNIQUE (cod_cliente);
ALTER TABLE comercial.d_cliente ADD PRIMARY KEY (id);

-- Nas fatos: renomear fk_ para cod_
ALTER TABLE comercial.f_pedido RENAME COLUMN fk_cliente TO cod_cliente;

-- Criar índice para performance de joins
CREATE INDEX CONCURRENTLY idx_f_pedido_cod_cliente ON comercial.f_pedido(cod_cliente);

-- Renomear códigos operacionais: cod_empresa → id_empresa
ALTER TABLE comercial.d_cliente RENAME COLUMN cod_empresa TO id_empresa;

COMMIT;
```

---

### Validações Pós-Migração Completa

```sql
-- 1. Colunas de auditoria antigas (deve retornar zero)
SELECT table_schema, table_name, column_name
FROM information_schema.columns
WHERE column_name IN ('dthora_atualizacao', 'ultima_atualizacao')
ORDER BY table_schema, table_name;

-- 2. Colunas com prefixos proibidos (palavras completas ou abreviações não-padrão)
SELECT table_schema, table_name, column_name
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema', 'api', 'eventos')
  AND column_name ~ '^(vlr_|valor_|qtd_|quantidade_|qtde_|perc_|percentual_|descr_|codigo_|descricao_|numero_|nome_|sequencia_)'
ORDER BY table_schema, table_name, column_name;

-- 3. Tabelas sem updated_at
SELECT table_schema, table_name
FROM information_schema.tables t
WHERE table_type = 'BASE TABLE'
  AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns c
    WHERE c.table_schema = t.table_schema
      AND c.table_name = t.table_name
      AND c.column_name = 'updated_at'
  )
ORDER BY table_schema, table_name;

-- 4. CNPJ/CPF com formato inválido (usando nomes canônicos de cada dimensão)
SELECT tabela, COUNT(*) AS invalidos
FROM (
    SELECT 'd_cliente'       AS tabela, cnpj_cliente       AS cnpj FROM comercial.d_cliente
    UNION ALL
    SELECT 'd_representante' AS tabela, cnpj_repres        AS cnpj FROM comercial.d_representante
    UNION ALL
    SELECT 'd_fornecedor'    AS tabela, cnpj_fornecedor    AS cnpj FROM comercial.d_fornecedor
) t
WHERE cnpj IS NOT NULL
  AND cnpj !~ '^[0-9]{8}/[0-9]{4}-[0-9]{2}$'
  AND cnpj !~ '^[0-9A-Z]{8}/[0-9A-Z]{4}-[0-9]{2}$'
  AND cnpj !~ '^[0-9]{9}-[0-9]{2}$'
GROUP BY tabela;
```

---

### Linter de Nomenclatura (integrar no CI/CD)

```python
# naming_linter.py
import psycopg2, sys

FORBIDDEN_PREFIXES = [
    'vlr_', 'valor_', 'qtd_', 'quantidade_', 'qtde_',
    'perc_', 'percentual_', 'descr_', 'dthora_', 'ultima_atualizacao',
    'codigo_', 'descricao_', 'numero_', 'nome_', 'sequencia_',
]
REQUIRED_AUDIT = {'created_at', 'updated_at'}
TABLE_PREFIXES = ('d_', 'f_', 'stg_', 'brd_', 'aux_', 'tmp_')

def lint_schema(conn_str: str, schema: str) -> int:
    conn = psycopg2.connect(conn_str)
    cur = conn.cursor()
    errors = []

    cur.execute("""
        SELECT table_name FROM information_schema.tables
        WHERE table_schema = %s AND table_type = 'BASE TABLE'
    """, (schema,))
    for (table,) in cur.fetchall():
        if not any(table.startswith(p) for p in TABLE_PREFIXES):
            errors.append(f"TABLE {schema}.{table}: prefixo d_/f_/stg_ ausente")

    cur.execute("""
        SELECT table_name, column_name FROM information_schema.columns
        WHERE table_schema = %s
    """, (schema,))
    for table, col in cur.fetchall():
        for bad in FORBIDDEN_PREFIXES:
            if col.startswith(bad):
                errors.append(f"COLUMN {schema}.{table}.{col}: prefixo '{bad}' proibido")

    cur.execute("""
        SELECT table_name, array_agg(column_name) AS cols
        FROM information_schema.columns WHERE table_schema = %s
        GROUP BY table_name
    """, (schema,))
    for table, cols in cur.fetchall():
        missing = REQUIRED_AUDIT - set(cols)
        if missing:
            errors.append(f"AUDIT {schema}.{table}: colunas ausentes {missing}")

    for e in errors:
        print(e)
    return len(errors)

if __name__ == '__main__':
    sys.exit(lint_schema(sys.argv[1], sys.argv[2]))
```

**Uso:**
```bash
python naming_linter.py "host=... dbname=..." comercial
python naming_linter.py "host=... dbname=..." estoque
```

---

### Conflitos e Decisões Pendentes

| # | Decisão | Recomendação |
|---|---------|-------------|
| 1 | Schemas `api`/`eventos`: manter inglês ou forçar português? | Manter inglês — são integrações externas |
| 2 | `fk_cliente` tem tamanhos diferentes (`varchar(20)` vs `varchar(25)`) — qual é correto? | Verificar no Senior antes de migrar |
| 3 | `f_pedido` mistura cabeçalho (`ped_*`) e item (`itemped_*`) — separar? | Sim: `f_pedido_cabecalho` + `f_pedido_item` — impacto alto em BI |
| 4 | Schema `jma`: permanente ou temporário? | Se temporário, migrar tabelas para `comercial` |
| 5 | `comercial.fnotas_venda_produtos` e `jma.ffaturamento_dev_inc` parecem duplicadas — consolidar? | Analisar granularidade antes de decidir |
| 6 | **PPCP** — `ppcp.fmaquinas_divisao_externa.maquina` → `id_maquina`? CSV marcou com `???` | Verificar se `maquina` é join key para `d_maquina` (→ `cod_maquina`) ou código operacional (→ `id_maquina`) |
| 7 | **PPCP** — `ppcp.fitens_requisicao_almoxerifado` linha 207 sem nome de tabela (`desc_empresa` / `nome_empresa`) | Identificar a qual tabela pertence antes de incluir no plano |
| 8 | **PPCP** — `ppcp.fordens_reposicoes.ordemreposicaoformatted` e `ppcp.fordens_em_producao.qtde_programada` marcadas para exclusão | Confirmar com equipe de negócio antes de executar DROP COLUMN |
| 9 | **PPCP** — `ppcp.ftempo_tear.fk_produto` marcada para exclusão | Confirmar: se excluída, verificar que não é usada em nenhum join ativo |
| 10 | **PPCP** — `ppcp.froteiro.fk_produto` sem OBS de exclusão — deve ir para `sku_produto`? | Confirmar se a coluna deve ser mantida como `sku_produto` ou excluída igual à `ftempo_tear` |
