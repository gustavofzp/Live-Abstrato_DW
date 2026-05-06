# Boas Práticas e Padrão Oficial do Data Warehouse

> **Versão:** 2.0 | **Data:** 2026-05-05  
> **Status:** Aprovado  
> **Escopo:** Todas as tabelas do DW PostgreSQL (18 schemas, 963 tabelas)

---

## 1. Regras Gerais

- **Idioma:** Português para entidades de negócio; inglês somente para campos técnicos/infra (`created_at`, `updated_at`)
- **Case:** `snake_case` obrigatório — NUNCA UPPER_CASE com aspas, camelCase ou PascalCase
- **Comprimento máximo:** 63 caracteres (limite PostgreSQL)
- **Abreviações:** somente as aprovadas neste documento; novas precisam ser adicionadas ao dicionário
- **Prefixos proibidos (palavra completa):** nunca usar como prefixo: `codigo_`, `descricao_`, `quantidade_`, `valor_`, `percentual_`, `sequencia_`, `numero_`, `nome_` — usar as formas abreviadas aprovadas (`id_`, `ds_`, `qt_`, `vl_`, `pc_`, `nr_`, `nm_`)

---

## 2. Prefixos de Tabela

| Tipo | Prefixo | Exemplo |
|------|---------|---------|
| Dimensão | `d_` | `d_cliente`, `d_produto` |
| Fato | `f_` | `f_pedido`, `f_faturamento` |
| Staging (carga bruta) | `stg_` | `stg_senior_pedido` |
| Integração/bridge | `brd_` | `brd_produto_colecao` |
| Auxiliar/lookup | `aux_` | `aux_tipo_movimento` |
| Temp/homologação | `tmp_` | `tmp_carga_20250101` |

---

## 3. Prefixos de Coluna

### 3.1 Chaves (modelo `id` / `cod_` / `id_`)

| Convenção | Papel | Tipo | Onde aparece | Exemplo |
|-----------|-------|------|--------------|---------|
| `id` | Surrogate key gerada pelo DW (PK) | `bigserial` | Apenas na própria tabela | `id` em `d_cliente`, `id` em `f_pedido` |
| `cod_` | Business key / chave natural — **join key universal** | conforme origem (varchar ou numeric) | Dimensão (UNIQUE) + todas as fatos que referenciam | `cod_cliente`, `cod_produto` |
| `id_` | Código operacional — identifica categorias/tipos | `smallint` / `int` | Qualquer tabela | `id_empresa`, `id_natureza`, `id_tipo_movimento` |

> **Regra de ouro do `cod_`:** `cod_<entidade>` tem o mesmo valor e tipo em QUALQUER tabela do DW. Isso permite `a.cod_cliente = b.cod_cliente` sem precisar conhecer FKs explícitas. `id` (plain) é interno à tabela e nunca aparece em outras.

**Distinção entre `cod_` e `id_`:**

| Prefixo | Uso | Exemplo |
|---------|-----|---------|
| `cod_` | Chave de **entidade/dimensão** — é join key entre tabelas | `cod_cliente`, `cod_produto`, `cod_representante` |
| `id_` | Código **operacional** — não é entidade, não é join key | `id_empresa`, `id_natureza`, `id_tipo_movimento` |

### 3.2 Demais Colunas

| Categoria | Prefixo | Tipo sugerido | Exemplo |
|-----------|---------|--------------|---------|
| Código operacional / id de categoria | `id_` | `smallint` / `int` | `id_empresa`, `id_natureza` |
| Descrição / nome curto | `ds_` | `varchar` | `ds_produto`, `ds_natureza` |
| Nome completo | `nm_` | `varchar` | `nm_cliente`, `nm_fantasia` |
| Valor monetário | `vl_` | `numeric(15,2)` | `vl_faturado`, `vl_desconto` |
| Quantidade | `qt_` | `numeric(15,3)` | `qt_pedida`, `qt_faturada` |
| Percentual | `pc_` | `numeric(7,4)` | `pc_desconto`, `pc_comissao` |
| Data (sem hora) | `dt_` | `date` | `dt_emissao`, `dt_vencimento` |
| Data e hora | `dth_` | `timestamp` | `dth_referencia` |
| Flag / booleano | `fl_` | `boolean` | `fl_ativo`, `fl_cancelado` |
| Peso / medida física | `ps_` | `numeric(15,3)` | `ps_liquido`, `ps_bruto` |
| Número sequencial / documento | `nr_` | `integer` / `varchar` | `nr_nota_fiscal`, `nr_pedido` |
| Observação / texto livre | `obs_` | `text` | `obs_pedido` |
| Endereço (campos) | `end_` | `varchar` | `end_logradouro`, `end_cep` |
| CNPJ / CPF | `cnpj_<entidade>` | `varchar(16)` | nome segue a dimensão de referência — ver seção 7 |
| SKU de produto (identificador composto) | `sku_` | `varchar(30)` | `sku_produto`, `sku_tecido` — ver seção 6.1 |

---

## 4. Colunas de Auditoria (obrigatórias em toda tabela)

```sql
created_at   timestamp NOT NULL DEFAULT current_timestamp,
updated_at   timestamp NOT NULL DEFAULT current_timestamp
```

Tabelas que precisam rastrear usuário:
```sql
created_by   varchar(100),
updated_by   varchar(100)
```

> **Regra de migração:** `dthora_atualizacao` e `ultima_atualizacao` são mapeados para `updated_at`.

---

## 5. Surrogate Key (`id`)

```sql
id   bigserial PRIMARY KEY
```

- Tipo: `bigserial` (auto-increment)
- Nome: sempre `id` — sem sufixo, sem complemento
- **Aparece apenas na própria tabela** — nunca é referenciado em outras tabelas
- Uso: controle interno do DW (SCD Type 2, auditoria de carga, referência em logs)

---

## 6. Business Key / Join Key (`cod_`)

```sql
-- Na dimensão:
cod_cliente   varchar(20) NOT NULL UNIQUE   -- chave natural do sistema de origem

-- Em qualquer fato:
cod_cliente   varchar(20) NOT NULL          -- mesma coluna, mesmo tipo, mesmo significado
```

- Nome: `cod_<nome_entidade>`
- Tipo: **idêntico em TODAS as tabelas** — definido no dicionário de entidades
- É a coluna de join universal: `f_pedido.cod_cliente = d_cliente.cod_cliente`
- Criar índice em fatos: `CREATE INDEX ON f_pedido(cod_cliente)`

**Integridade por convenção** (sem FK explícita):
1. `UNIQUE` constraint em `d_<entidade>.cod_<entidade>`
2. Pipeline valida existência antes de inserir no fato
3. Linter de nomenclatura garante mesmo tipo em todas as tabelas

---

## 6.1 Identificador de Produto (`sku_`)

O produto no Systextil é identificado por quatro partes que formam o SKU composto:

| Parte | Coluna de origem | Significado |
|-------|------------------|-------------|
| `nivel_produto` | `cd_nivel99` | Nível hierárquico do produto |
| `referencia` | `cd_grupo` | Referência / artigo |
| `tamanho` | `cd_subgrupo` | Tamanho |
| `cod_cor` | `cd_item` | Código da cor |

**Padrão no DW:** as quatro partes são concatenadas com `.` (ponto), formando o `sku_produto`:

```sql
sku_produto = nivel_produto || '.' || referencia || '.' || tamanho || '.' || cod_cor
-- Exemplo: '01.ABC123.M.001'
```

- **Nome da coluna:** `sku_produto` em qualquer tabela que referencie o produto
- **Tipo:** `varchar(30)`
- **Substitui:** `cod_produto`, `pk_produto`, `fk_produto`, `id_produto` — todos unificados em `sku_produto`
- **Índice em fatos:** `CREATE INDEX ON f_pedido_item(sku_produto)`
- **Equivalente para tecido:** `sku_tecido` (mesma lógica — ver dicionário de entidades)

> **Regra de ouro:** `sku_produto` é a join key universal de produto — mesma coluna, mesmo valor, mesmo tipo em QUALQUER tabela do DW.

**Geração do SKU no pipeline de ingestão (Systextil → DW):**

```sql
-- Construir sku_produto a partir das 4 partes de origem
SELECT
    cd_nivel99 || '.' || cd_grupo || '.' || cd_subgrupo || '.' || cd_item AS sku_produto
FROM systextil.produtos;
```

---

## 7. Padrão CNPJ / CPF

### 7.1 Formatos Definidos

| Identificador | Formato DW | Tamanho | Tipo PostgreSQL | Exemplo |
|---------------|-----------|---------|-----------------|---------|
| CNPJ | `XXXXXXXX/YYYY-ZZ` | 16 chars | `varchar(16)` | `12345678/0001-90` |
| CPF | `XXXXXXXXX-ZZ` | 12 chars | `varchar(12)` | `123456789-09` |
| Coluna mista | `varchar(16)` | 16 chars | `varchar(16)` | aceita ambos |

> **Regra:** sem pontos na primeira parte; `/` e `-` mantidos. Tipo sempre `varchar` para suportar CNPJ alfanumérico (IN RFB nº 2.229/2024).

### 7.2 Nomenclatura — Princípio: a dimensão define o nome

**Regra:** o nome da coluna de CNPJ/CPF em qualquer tabela do DW deve ser idêntico ao da dimensão de referência. Isso garante joins por nome, sem ambiguidade.

| Entidade | Dimensão | Nome padrão da coluna | Tipo |
|----------|----------|-----------------------|------|
| Cliente | `d_cliente` | `cnpj_cliente` | `varchar(16)` |
| Representante | `d_representante` | `cnpj_repres` | `varchar(16)` |
| Fornecedor | `d_fornecedor` | `cnpj_fornecedor` | `varchar(16)` |
| Transportadora | `d_transportadora` | `cnpj_transportadora` | `varchar(16)` |

> **Join padrão:**
> ```sql
> SELECT * FROM d_cliente a
> JOIN f_vendas b ON a.cnpj_cliente = b.cnpj_cliente
> ```
>
> **Evitar:** `nr_cnpj`, `cnpj`, `cpf_cnpj`, `documento_cliente` — nomes genéricos que quebram a rastreabilidade do join.

### 7.3 Mapeamento Systextil

O Systextil fragmenta CNPJ/CPF em 3 colunas:

| Parte | Legado (numérico) | Novo (alfanumérico) | Tipo origem | Significado |
|-------|-------------------|---------------------|-------------|-------------|
| Parte 1 | `_9` (ex: `CGC_9`) | `_R` (ex: `CGC_R`) | `NUMBER(9,0)` → `VARCHAR2(9)` | Raiz CNPJ (8 dígitos) ou CPF (9 dígitos) |
| Parte 2 | `_4` (ex: `CGC_4`) | `_O` (ex: `CGC_O`) | `NUMBER(4,0)` → `VARCHAR2(4)` | Filial CNPJ; `0` indica CPF |
| Dígitos | `_2` (ex: `CGC_2`) | `_2` (inalterado) | `NUMBER(2,0)` | Dígitos verificadores |

**Detecção CPF vs CNPJ:**
- `_4 = 0` → **CPF**: `_9` (9 dígitos) + `-` + `_2` (2 dígitos)
- `_4 ≠ 0` → **CNPJ**: `_9` (8 dígitos) + `/` + `_4` (4 dígitos) + `-` + `_2` (2 dígitos)

**Prioridade de leitura:** colunas `_R`/`_O` (se preenchidas) → fallback `_9`/`_4`

### 7.4 Função de Reconstrução

```sql
CREATE OR REPLACE FUNCTION dw.fn_formatar_cnpj_cpf(
    p_parte1  varchar,   -- cgc_r ou cgc_9::text
    p_parte2  varchar,   -- cgc_o ou cgc_4::text; NULL ou '0000' = CPF
    p_digitos int        -- cgc_2
) RETURNS varchar(16) AS $$
DECLARE
    v_parte1  text := LPAD(TRIM(COALESCE(p_parte1, '0')), 9, '0');
    v_parte2  text := TRIM(COALESCE(p_parte2, '0'));
    v_dig     text := LPAD(p_digitos::text, 2, '0');
BEGIN
    IF v_parte2 IS NULL OR v_parte2 = '0' OR v_parte2 = '0000' THEN
        RETURN v_parte1 || '-' || v_dig;  -- CPF: XXXXXXXXX-ZZ
    ELSE
        RETURN LPAD(v_parte1, 8, '0') || '/' || LPAD(v_parte2, 4, '0') || '-' || v_dig;  -- CNPJ
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
```

**Uso no pipeline — o alias deve usar o nome da dimensão:**
```sql
-- Ingestão para d_cliente
SELECT
    dw.fn_formatar_cnpj_cpf(
        COALESCE(NULLIF(TRIM(cgc_r), ''), cgc_9::text),
        COALESCE(NULLIF(TRIM(cgc_o), ''), cgc_4::text),
        cgc_2
    ) AS cnpj_cliente,          -- nome da coluna na dimensão
    CASE
        WHEN COALESCE(NULLIF(TRIM(cgc_o), ''), cgc_4::text) IN ('0', '0000') THEN 'CPF'
        ELSE 'CNPJ'
    END AS tp_documento_cliente  -- prefixo da entidade para evitar conflito em joins
FROM systextil.clientes;
```

**Entidades com CNPJ/CPF no Systextil:**

| Entidade | Colunas legado | Colunas novas | Coluna DW |
|----------|---------------|---------------|-----------|
| Cliente | `CGC_9`, `CGC_4`, `CGC_2` | `CGC_R`, `CGC_O`, `CGC_2` | `cnpj_cliente` |
| Transportadora | `TRAN_CLI_FORNE9`, `TRAN_CLI_FORNE4`, `TRAN_CLI_FORNE2` | verificar | `cnpj_transportadora` |
| Fornecedor | identificar no DDL_Systextil | verificar | `cnpj_fornecedor` |
| Representante | identificar no DDL_Systextil | verificar | `cnpj_repres` |

---

## 8. Tipos de Dados Padronizados

| Conceito | Tipo | Observação |
|----------|------|------------|
| Valor monetário | `numeric(15,2)` | 2 casas para R$; 3 para USD/internacional |
| Quantidade | `numeric(15,3)` | 3 casas para kg/m/unid |
| Percentual | `numeric(7,4)` | Ex: 15.2500 = 15,25% |
| CNPJ / CPF | `varchar(16)` | Formato `XXXXXXXX/YYYY-ZZ` (CNPJ) ou `XXXXXXXXX-ZZ` (CPF); nome segue dimensão (`cnpj_cliente`, etc.) |
| CEP | `char(8)` | Sem formatação |
| UF | `char(2)` | Maiúsculo |
| Flag | `boolean` | `TRUE`/`FALSE` — evitar `char(1)` com 'S'/'N' |
| Texto longo | `text` | Sem `varchar` aberto |
| Código curto | `varchar(n)` | Com tamanho explícito |
| Data | `date` | Nunca `timestamp` para campos só-data |
| Data+hora | `timestamp` | Sem timezone (UTC implícito no pipeline) |
| ID operacional | `smallint` | Para categorias com <32k valores |
| Surrogate key | `bigserial` | PKs geradas pelo DW |

---

## 9. Estrutura Padrão de Dimensão

```sql
CREATE TABLE comercial.d_cliente (
    -- surrogate key (interna, sem sufixo)
    id               bigserial        PRIMARY KEY,
    -- business key (join key universal)
    cod_cliente      varchar(20)      NOT NULL UNIQUE,
    -- atributos descritivos
    nm_cliente       varchar(70)      NOT NULL,
    nm_fantasia      varchar(70),
    id_empresa       smallint         NOT NULL,
    id_tipo_cliente  smallint,
    ds_tipo_cliente  varchar(40),
    ds_situacao      varchar(10),
    fl_ativo         boolean          DEFAULT TRUE,
    cnpj_cliente     varchar(16),      -- nome idêntico ao usado em todas as fatos relacionadas
    tp_documento_cliente varchar(4),   -- 'CPF' ou 'CNPJ'
    -- endereço
    end_logradouro   varchar(70),
    end_bairro       varchar(20),
    end_cidade       varchar(40),
    end_uf           char(2),
    end_cep          char(8),
    end_pais         varchar(25),
    -- contato
    nm_email         varchar(100),
    nr_telefone      varchar(15),
    -- auditoria
    created_at       timestamp        NOT NULL DEFAULT current_timestamp,
    updated_at       timestamp        NOT NULL DEFAULT current_timestamp
);
```

---

## 10. Estrutura Padrão de Fato

```sql
CREATE TABLE comercial.f_pedido_item (
    -- surrogate do fato
    id               bigserial        PRIMARY KEY,
    -- join keys (mesmo nome e tipo que na dimensão correspondente)
    sku_produto      varchar(30)      NOT NULL,  -- = d_produto.sku_produto
    cod_cliente      varchar(20)      NOT NULL,  -- = d_cliente.cod_cliente
    cod_representante varchar(6),                -- = d_representante.cod_representante
    -- datas
    dt_emissao       date             NOT NULL,
    dt_embarque      date,
    -- métricas
    qt_pedida        numeric(15,3)    NOT NULL DEFAULT 0,
    qt_faturada      numeric(15,3)    DEFAULT 0,
    qt_cancelada     numeric(15,3)    DEFAULT 0,
    vl_unitario      numeric(15,2),
    vl_total_bruto   numeric(15,2),
    vl_desconto      numeric(15,2)    DEFAULT 0,
    vl_total_liquido numeric(15,2),
    pc_desconto      numeric(7,4)     DEFAULT 0,
    -- contexto operacional (id_ = não é entidade, não faz join com dimensão)
    id_situacao_venda smallint,
    id_natureza       smallint,
    nr_pedido         integer,
    -- auditoria
    created_at        timestamp        NOT NULL DEFAULT current_timestamp,
    updated_at        timestamp        NOT NULL DEFAULT current_timestamp
);

-- Join padrão:
-- SELECT * FROM f_pedido_item f JOIN d_cliente c ON f.cod_cliente = c.cod_cliente
```

---

## 11. Dicionário de Entidades (join keys canônicas)

| Entidade | Coluna join | Tipo | Dimensão |
|----------|-------------|------|----------|
| cliente | `cod_cliente` | `varchar(20)` | `d_cliente` |
| produto | `sku_produto` | `varchar(30)` | `d_produto` |
| tecido | `sku_tecido` | `varchar(30)` | `d_tecido` |
| representante | `cod_representante` | `varchar(6)` | `d_representante` |
| fornecedor | `cod_fornecedor` | `varchar(18)` | `d_fornecedor` |
| colaborador | `cod_colaborador` | `varchar(20)` | `d_colaborador` |
| portador | `cod_portador` | verificar | `d_portador` |
| deposito | `cod_deposito` | `smallint` | `d_deposito` |

> Tabela viva — adicionar novas entidades conforme necessário. Cada `cod_<entidade>` deve ter exatamente um tipo canônico definido aqui.

---

## 12. Exemplos Antes × Depois

### Dimensão Representante

| Antes (`comercial.drepresentante`) | Depois (`comercial.d_representante`) |
|-------------------------------------|--------------------------------------|
| `pk_representante varchar(6)` | `id bigserial PK` + `cod_representante varchar(6) UNIQUE` |
| `cnpj_repres int8` | `cnpj_repres varchar(16)` |
| `nome_repres varchar(50)` | `nm_representante varchar(50)` |
| `nome_fantasia varchar(50)` | `nm_fantasia varchar(50)` |
| `dthora_atualizacao timestamp` | `updated_at timestamp` |
| `cod_empresa int2` | `id_empresa smallint` |
| `regiao varchar(20)` | `ds_regiao varchar(20)` |
| `subregiao varchar(20)` | `ds_subregiao varchar(20)` |
| `situacao int2` | `fl_ativo boolean` |

### Fato Faturamento

| Antes (`jma.ffaturamento_dev_inc`) | Depois (`comercial.f_faturamento_item`) |
|------------------------------------|------------------------------------------|
| `"PK_CLIENTE" text` | `cod_cliente varchar(20)` |
| `"PK_PRODUTO" text` | `cod_produto varchar(25)` |
| `"NF_NOTAFISCAL" numeric(9)` | `nr_nota_fiscal integer` |
| `"NF_DATAEMISSAO" text` | `dt_emissao date` |
| `"ITEMNF_QTDFATURADA" numeric(38,10)` | `qt_faturada numeric(15,3)` |
| `"ITEMNF_VLRUNIT" numeric(38,10)` | `vl_unitario numeric(15,2)` |
| `"ITEMNF_VLRICMS" numeric(15,2)` | `vl_icms numeric(15,2)` |
| `"ULTIMA_ATUALIZACAO" timestamp` | `updated_at timestamp` |
| `"NF_COD_SITUACAO" numeric(38,10)` | `id_situacao smallint` |
| `"NF_COD_NATUREZA" numeric(3)` | `id_natureza smallint` |

---

## 13. Regras de NULL e Defaults

### 13.1 Quando usar NOT NULL

| Caso | Regra |
|------|-------|
| Business key em dimensão (`cod_`) | Sempre `NOT NULL` |
| Datas de fato obrigatórias (`dt_emissao`) | `NOT NULL` |
| Colunas de auditoria (`created_at`, `updated_at`) | `NOT NULL DEFAULT current_timestamp` |
| Métricas principais em fatos (`qt_pedida`, `vl_total`) | `NOT NULL DEFAULT 0` |
| Atributos descritivos opcionais | Nullable — não forçar `NOT NULL` |
| Colunas adicionadas por ALTER TABLE em tabelas existentes | Nullable — ETL não garante preenchimento retroativo |

### 13.2 Defaults por tipo

| Tipo | Default recomendado |
|------|---------------------|
| `timestamp` (auditoria) | `DEFAULT current_timestamp` |
| `boolean` (flags) | `DEFAULT TRUE` para flags de ativo; `DEFAULT FALSE` para flags de evento |
| `numeric` (métricas em fatos) | `DEFAULT 0` quando o zero é semanticamente correto |
| `varchar` / `text` | Sem default — NULL é preferível a string vazia |
| `smallint` / `integer` (códigos) | Sem default — NULL indica ausência de informação |

### 13.3 Valores NULL no ETL

- NULL significa ausência de informação. Nunca substituir por `'N/A'`, `'DESCONHECIDO'`, `0` forçado, ou string vazia.
- O ETL em Python deve usar `None` (que se torna NULL no banco) para valores ausentes.
- Para campos com `NOT NULL DEFAULT 0`, o pipeline pode omitir a coluna e deixar o banco aplicar o default.

---

## 14. Dimensoes Variantes no Tempo (SCD)

### 14.1 SCD Tipo 1 — Sobrescrever (padrao para a maioria)

Usar quando a mudança de atributo não precisa ser rastreada historicamente.

```sql
-- Pipeline: UPDATE ... WHERE cod_cliente = ?
UPDATE d_cliente
SET nm_cliente = :novo_nome,
    updated_at = current_timestamp
WHERE cod_cliente = :cod;
```

- Todas as dimensoes do DW usam SCD Tipo 1 por padrao.
- O campo `updated_at` registra a ultima atualizacao.
- Nao existe coluna `dt_vigencia_inicio` / `dt_vigencia_fim` em SCD Tipo 1.

### 14.2 SCD Tipo 2 — Historico (uso restrito)

Usar apenas quando o historico de um atributo e necessario para analise temporal correta.

```sql
CREATE TABLE d_cliente_hist (
    id               bigserial   PRIMARY KEY,
    cod_cliente      varchar(20) NOT NULL,
    nm_cliente       varchar(70),
    fl_vigente       boolean     NOT NULL DEFAULT TRUE,
    dt_inicio        date        NOT NULL,
    dt_fim           date,       -- NULL = vigente
    created_at       timestamp   NOT NULL DEFAULT current_timestamp,
    updated_at       timestamp   NOT NULL DEFAULT current_timestamp,
    CONSTRAINT uq_cliente_hist UNIQUE (cod_cliente, dt_inicio)
);
```

Regras SCD Tipo 2:
- `cod_cliente` se repete para cada versao do registro.
- `id` e o surrogate key unico por versao — nunca referenciado externamente.
- `fl_vigente = TRUE` apenas na versao corrente; pipeline faz UPDATE da versao anterior antes do INSERT da nova.
- `dt_fim = NULL` indica registro vigente.
- Fatos referenciam `cod_cliente` (nao `id`) — o join retorna todos os registros historicos; filtrar por `fl_vigente = TRUE` para o estado atual.

### 14.3 Como o ETL garante integridade sem FK

O DW nao usa FOREIGN KEY declarada (por limitacoes de ETL batch e performance). A integridade e garantida por convencao no pipeline:

```python
# Padrao obrigatorio no Airflow DAG antes de inserir em fatos:
def validar_chave_dimensao(df, chave, tabela_dim, conn):
    """Valida que todos os valores de 'chave' existem na dimensao."""
    existentes = pd.read_sql(
        f"SELECT {chave} FROM {tabela_dim}", conn
    )[chave].tolist()
    orfaos = df[~df[chave].isin(existentes)]
    if not orfaos.empty:
        raise ValueError(f"{len(orfaos)} registros sem correspondencia em {tabela_dim}")
```

Alternativa mais eficiente para grandes volumes:

```python
# LEFT JOIN no banco e filtrar NULLs
query = f"""
    SELECT f.*
    FROM staging_fato f
    LEFT JOIN {tabela_dim} d USING ({chave})
    WHERE d.{chave} IS NULL
"""
orfaos = pd.read_sql(query, conn)
if len(orfaos) > 0:
    raise ValueError(f"{len(orfaos)} orfaos detectados")
```

---

## 15. Compatibilidade com ETL Airflow / Python

### 15.1 Tipos de dados x conectores Python

| Tipo PostgreSQL | Tipo Python (pandas) | Observacao |
|-----------------|---------------------|------------|
| `bigserial` | `int64` | gerado pelo banco; nao enviar no INSERT |
| `boolean` | `bool` | psycopg2 converte automaticamente |
| `date` | `datetime.date` ou `str` `YYYY-MM-DD` | `pd.to_datetime().dt.date` |
| `timestamp` | `datetime.datetime` | sem tz; psycopg2 insere naive datetime como-e |
| `numeric(15,2)` | `Decimal` ou `float64` | usar `Decimal` para valores financeiros criticos |
| `varchar(n)` | `str` | truncar se necessario antes do insert |
| `text` | `str` | sem limite |
| `smallint` | `int16` ou `int64` | pandas nao tem int16 nativo; usar int64 |
| `char(2)` / `char(8)` | `str` | padding automatico pelo banco |
| `bigint` | `int64` | |

### 15.2 Uso do to_sql (pandas)

```python
# Configuracao minima para insert seguro
df.to_sql(
    name='f_pedido_item',
    schema='comercial',
    con=engine,
    if_exists='append',
    index=False,
    method='multi',       # inserts em batch
    chunksize=1000,
    dtype={               # declarar tipos quando necessario
        'dt_emissao': sqlalchemy.Date(),
        'vl_total': sqlalchemy.Numeric(15, 2),
    }
)
```

### 15.3 Regras de nomenclatura que o ETL deve respeitar

- O alias das colunas no SELECT do pipeline deve bater exatamente com o nome da coluna no DW.
- Nunca usar `AS "NOME_UPPER"` — o PostgreSQL preserva o case com aspas e quebra queries sem aspas.
- Sempre usar `snake_case` sem aspas tanto no DDL quanto nos SELECTs do pipeline.
- Colunas de auditoria (`created_at`, `updated_at`) nao precisam ser enviadas pelo ETL — o banco aplica o `DEFAULT current_timestamp`.

### 15.4 Carga incremental

- Usar `updated_at` como watermark para cargas incrementais.
- O campo de watermark no banco de origem deve ser mapeado para `updated_at` no DW.
- Nunca usar `dthora_atualizacao`, `ultima_atualizacao` — usar `updated_at` canonico.

```python
# Padrao de carga incremental
ultima_carga = get_ultima_carga(schema, tabela)
query = f"""
    SELECT * FROM origem.tabela
    WHERE updated_at > '{ultima_carga}'
    ORDER BY updated_at
"""
```

---

## 16. Relacionamentos e Integridade Referencial

### 16.1 FK convencional (sem declaracao no banco)

O DW nao declara FOREIGN KEY constraints por tres razoes:
1. O ETL batch nao garante ordem de carga — fato pode chegar antes da dimensao ser carregada.
2. FKs adicionam overhead em INSERT massivo.
3. O conector psycopg2/SQLAlchemy nao valida FKs automaticamente.

A integridade e garantida por:
- UNIQUE constraint em `d_<entidade>.cod_<entidade>` (garantia estrutural).
- Validacao no pipeline antes da carga (ver secao 14.3).
- Reconciliacao diaria por query de orfaos (ver secao 14.3).

### 16.2 Relacionamentos propostos por convencao

Toda tabela fato deve documentar seus relacionamentos esperados no dicionario de dados:

```
comercial.f_pedido_item
  |- cod_cliente      -> comercial.d_cliente.cod_cliente
  |- sku_produto      -> live.d_produto.sku_produto (ou ppcp.dtecidos para tecidos)
  |- cod_representante -> comercial.d_representante.cod_representante
```

### 16.3 Indices obrigatorios em fatos

```sql
-- Indice em cada join key de fato
CREATE INDEX idx_f_pedido_cod_cliente       ON comercial.f_pedido(cod_cliente);
CREATE INDEX idx_f_pedido_sku_produto       ON comercial.f_pedido(sku_produto);
CREATE INDEX idx_f_pedido_cod_representante ON comercial.f_pedido(cod_representante);
CREATE INDEX idx_f_pedido_dt_emissao        ON comercial.f_pedido(dt_emissao);
```

---

## 17. Versionamento e Migracoes

### 17.1 Estrategia de compatibilidade retroativa

Toda mudanca estrutural (renomear coluna, mudar tipo, renomear tabela) segue o ciclo:

```
1. Renomear tabela/coluna
2. Criar view com nome antigo (alias de compatibilidade)
3. Notificar consumidores (DAGs, BI tools)
4. Aguardar 90 dias
5. Remover view de compatibilidade
```

```sql
-- Exemplo: renomear tabela
ALTER TABLE comercial.drepresentante RENAME TO d_representante;

-- View de compatibilidade (90 dias)
CREATE OR REPLACE VIEW comercial.drepresentante AS
    SELECT * FROM comercial.d_representante;
COMMENT ON VIEW comercial.drepresentante IS
    'DEPRECATED 2026-05-05: usar d_representante. Sera removido em 2026-08-03.';
```

### 17.2 Adicionar coluna (nao quebra pipeline)

```sql
-- Seguro: coluna nullable com default
ALTER TABLE comercial.f_pedido
    ADD COLUMN fl_reprocessado boolean DEFAULT FALSE;
```

- Adicionar coluna nullable nunca quebra DAGs existentes.
- Colunas obrigatorias (`NOT NULL` sem default) exigem migracao coordenada com o pipeline.

### 17.3 Mudar tipo de coluna

```sql
-- Deve ser executado em janela de manutencao
ALTER TABLE comercial.d_representante
    ALTER COLUMN cnpj_repres TYPE varchar(16)
    USING cnpj_repres::varchar;
```

- Mudancas de tipo requerem parada da DAG de carga durante a execucao.
- Validar que o novo tipo e compativel com o que o pipeline envia.

### 17.4 Controle de versao do DDL

- Todo DDL de migracao deve ser commitado em Git antes de ser executado.
- Nomear arquivos: `V<YYYYMMDD>__<schema>_<descricao>.sql`
- Exemplo: `V20260505__comercial_rename_drepresentante.sql`

---

## 18. Glossario de Termos de Negocio

| Termo | Forma canonica no DW | Observacao |
|-------|---------------------|------------|
| Cliente | `d_cliente`, `cod_cliente` | Pessoa fisica ou juridica compradora |
| Representante | `d_representante`, `cod_representante` | Vendedor externo |
| Produto | `d_produto` (live), `sku_produto` | Identificado pelo SKU composto |
| Tecido | `dtecidos` (ppcp), `sku_tecido` | Materia-prima textil |
| Colecao | `dcolecoes` | Agrupamento de produtos por estacao |
| Estacao | referenciada por `id_estacao` | Ex.: Verao 26, Inverno 26 |
| Nota Fiscal | `nr_nota_fiscal` (integer) | Numero do documento fiscal |
| Ordem de Producao | `nr_ordem_producao` (integer/varchar) | Documento de producao interna |
| Ordem de Confeccao | `nr_ordem_confeccao` (integer/varchar) | Suborden de confeccao |
| Estagio | `id_estagio` (smallint) | Etapa do processo produtivo |
| Deposito | `cod_deposito` (smallint), `d_deposito` | Local fisico de estoque |
| Empresa | `id_empresa` (smallint) | Codigo da empresa no sistema de origem |
| Periodo de Producao | `nr_periodo_producao` (integer) | Ciclo mensal/semanal de planejamento |
| Faccao | `id_faccao` ou `cod_faccao` | Fabricante terceirizado |
| Divisao | `id_divisao` (smallint) | Divisao produtiva interna |
| Maquina | `id_maquina` (smallint/varchar) | Equipamento de producao |
| Operacao | `id_operacao` (smallint) | Etapa operacional do roteiro |
| Roteiro | `nr_roteiro` (integer/varchar) | Sequencia de operacoes de um produto |
| Faturamento | `f_faturamento*` | Nota fiscal de saida emitida |
| Pedido | `f_pedido*`, `fpedido*` | Pedido de venda do cliente |
| Loja | `dlojas` (live) | Ponto de venda fisico ou virtual |
| Portador | `d_portador`, `cod_portador` | Banco/meio de recebimento financeiro |
| Titulo | `ftitulos_*` | Documento financeiro a receber/pagar |
| Canal de Distribuicao | `dcanaldistribuicao` | Tipo de venda (atacado, varejo, ecom) |
| Colaborador | `d_colaborador`, `cod_colaborador` | Funcionario interno |

---

## 19. Checklist de Revisao antes de Criar Tabela Nova

Antes de criar qualquer tabela nova no DW, verificar:

- [ ] Nome da tabela usa prefixo correto (`d_`, `f_`, `stg_`, `brd_`, `aux_`, `tmp_`)
- [ ] Nome em `snake_case`, sem UPPER_CASE ou camelCase
- [ ] Nome no schema correto (nao criar no `temporario` ou `stage` como definitiva)
- [ ] Toda coluna tem prefixo conforme secao 3
- [ ] Nenhum prefixo proibido usado (`codigo_`, `descricao_`, `quantidade_`, etc.)
- [ ] Business keys (`cod_`) tem tipo identico ao da dimensao correspondente (secao 11)
- [ ] `sku_produto` e `sku_tecido` usados onde cabivel (nao `id_produto`, `fk_produto`)
- [ ] CNPJ/CPF usa nome da dimensao de referencia (`cnpj_cliente`, `cnpj_repres`, etc.)
- [ ] Colunas de auditoria presentes: `created_at`, `updated_at`
- [ ] Tipos de dados conforme secao 8 (sem `numeric(38,10)`, sem `int8` para CNPJ)
- [ ] Surrogate key `id bigserial PRIMARY KEY` declarada (exceto em tabelas staging)
- [ ] Relacionamentos documentados no dicionario de dados do schema
- [ ] Indices criados para join keys e colunas de filtro frequente
- [ ] Pipeline (DAG Airflow) atualizado para usar o novo nome e tipo
- [ ] DDL commitado em Git com nome de arquivo versionado
