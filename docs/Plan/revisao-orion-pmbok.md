# Revisão do Sistema ORION (Gerenciamento de Projetos) à luz do PMBOK

**Contexto:** Análise do schema atual (tabelas `ORION_TI_0xx`) contra as 10 Áreas de Conhecimento e 5 Grupos de Processos do PMBOK, com propostas de melhoria técnicas (quick wins) e arquiteturais (evolução estrutural).

**Autor da revisão:** Claude (baseado na skill `pmbok-project-management`)
**Data:** 23/04/2026

---

## 1. Resumo Executivo

O modelo atual cobre **razoavelmente bem** as fases iniciais do ciclo de vida de projeto (Iniciação, Planejamento parcial) e tem uma base sólida para **apontamento de horas** (timesheet via `ORION_TI_070/071/072`). No entanto, apresenta lacunas significativas em áreas críticas do PMBOK:

| Área de Conhecimento PMBOK | Cobertura Atual | Veredicto |
|---|---|---|
| Integration Management | Parcial (charter em campos-texto) | Média |
| Scope Management | Parcial (requisitos/entregáveis em texto livre) | Média |
| Schedule Management | Boa (atividades + tarefas + datas) | Boa |
| Cost Management | Básica (orçamento + custo de hora) | Média |
| Quality Management | **Ausente** | **Crítica** |
| Resource Management | Parcial (equipe sem RACI) | Média |
| Communications Management | **Ausente** | **Crítica** |
| Risk Management | **Apenas texto livre** | **Crítica** |
| Procurement Management | **Quase ausente** (só `PAGAR_PARA`) | **Crítica** |
| Stakeholder Management | Parcial (texto + equipe) | Média |

**Problemas técnicos imediatos** (quick wins): duas tabelas sem PK, redundância em campos de status, ROI armazenado como VARCHAR, ausência de auditoria sistemática, e tipos temporais inadequados.

---

## 2. Mapeamento do Modelo Atual

| Tabela | Propósito inferido | Observações |
|---|---|---|
| `ORION_TI_041` | Domínio: Status de projeto | OK, tabela de lookup simples |
| `ORION_TI_040` | **Projeto** (núcleo — charter + acompanhamento) | Muito "gorda" — 35 colunas misturando charter, status, próximas ações |
| `ORION_TI_042` | Histórico de mudança de status | Bom padrão de auditoria |
| `ORION_TI_045` | Atividades planejadas | Representa macro-atividades |
| `ORION_TI_046` | Tarefas (subdivisão da atividade) | Só 2 níveis — não é uma WBS verdadeira |
| `ORION_TI_055` | Equipe do projeto (RH alocado) | Sem RACI, sem alocação % |
| `ORION_TI_060` | Seguidores/watchers do projeto (?) | **Sem PK** |
| `ORION_TI_065` | Itens de custo/orçamento | Sem status de aprovação, sem categoria, sem fase |
| `ORION_TI_070` | Registro de atividade executada (apontamento) | Timesheet da atividade |
| `ORION_TI_071` | Registro de tarefa executada | Timesheet da tarefa |
| `ORION_TI_072` | Usuários envolvidos no registro | **Sem PK** |

**Referenciadas mas não apresentadas:** `ORION_TI_030` (Fases), `ORION_TI_035` (Tipos de atividade), `ORION_TI_050` (Funções da pessoa), `ORION_001` (Usuários).

---

## 3. Diagnóstico Técnico — Quick Wins

### 3.1 Tabelas sem Primary Key

`ORION_TI_060` e `ORION_TI_072` foram criadas **sem `PRIMARY KEY`** — apenas com a coluna `ID VARCHAR2(100)`. Isso quebra integridade referencial, impede replicação lógica e prejudica performance de JOINs.

```sql
-- Correção
ALTER TABLE ORION.ORION_TI_060 ADD CONSTRAINT ORION_TI_060_PK PRIMARY KEY (ID);
ALTER TABLE ORION.ORION_TI_072 ADD CONSTRAINT ORION_TI_072_PK PRIMARY KEY (ID);
```

### 3.2 Redundância de Status em `ORION_TI_040`

A tabela tem **quatro** campos representando status:

- `STATUS VARCHAR2(100)` — redundante com FK
- `ID_STATUS NUMBER(9,0)` → `ORION_TI_041` (correto)
- `STATUS_STR VARCHAR2(4000)` — propósito ambíguo
- `STATUS_CONTROLE VARCHAR2(20)` — propósito ambíguo

**Recomendação:** manter apenas `ID_STATUS` (FK) e, se `STATUS_CONTROLE` tiver significado distinto (ex: semáforo verde/amarelo/vermelho), criar tabela-domínio:

```sql
CREATE TABLE ORION.ORION_TI_041A (
    ID NUMBER(9,0) PRIMARY KEY,
    CODIGO VARCHAR2(20) NOT NULL,      -- VERDE/AMARELO/VERMELHO
    DESCRICAO VARCHAR2(100) NOT NULL,
    COR_HEX VARCHAR2(7)
);

ALTER TABLE ORION.ORION_TI_040 DROP COLUMN STATUS;
ALTER TABLE ORION.ORION_TI_040 DROP COLUMN STATUS_STR;
ALTER TABLE ORION.ORION_TI_040 MODIFY STATUS_CONTROLE NUMBER(9,0);
ALTER TABLE ORION.ORION_TI_040 ADD CONSTRAINT FK_040_SEMAFORO
    FOREIGN KEY (STATUS_CONTROLE) REFERENCES ORION.ORION_TI_041A(ID);
```

### 3.3 Tipos de dado inadequados

| Campo | Tipo atual | Tipo recomendado | Motivo |
|---|---|---|---|
| `ORION_TI_040.ROI` | `VARCHAR2(20)` | `NUMBER(10,4)` | ROI é numérico; dificulta ranking/relatórios |
| `ORION_TI_040.SQUAD_ALVO` | `VARCHAR2(20)` | FK para tabela de squads | Evita inconsistência de grafia |
| `ORION_TI_041.ATIVO` | `NUMBER(1,0)` | `CHAR(1) CHECK IN ('S','N')` ou manter + CHECK | Autodocumentação |
| `ORION_TI_070.HORA_INICIO` / `HORA_FIM` | `DATE` (separado) | `TIMESTAMP` único | Simplifica cálculos de duração |
| `ORION_TI_040.PROJETO_DIRETORIA` | `NUMBER(1,0)` | + `CHECK (VALUE IN (0,1))` | Garantir domínio |

### 3.4 Auditoria sistemática ausente

Apenas `ORION_TI_042` tem campo de usuário. Recomenda-se adicionar em **todas** as tabelas principais:

```sql
-- Template a aplicar em TI_040, TI_045, TI_046, TI_055, TI_065, TI_070, TI_071
ALTER TABLE ORION.ORION_TI_XXX ADD (
    CREATED_AT   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CREATED_BY   VARCHAR2(200),
    UPDATED_AT   TIMESTAMP,
    UPDATED_BY   VARCHAR2(200)
);
```

Complementar com **trigger genérica** ou controle pela camada de aplicação.

### 3.5 `ORION_TI_040` excessivamente "gorda"

Com 35 colunas misturando responsabilidades, ela concentra:
- **Charter** (objetivo, justificativa, contextualização)
- **Briefing** (problema, perguntas abertas, riscos-briefing)
- **Planejamento** (objetivo SMART, benefício, restrição, requisito, entregável)
- **Acompanhamento** (status, próximas ações, ação em andamento, data att. status)
- **Classificação** (área, depto, setor, origem, squad)

**Sugestão:** segregar em tabelas relacionadas 1:1 conforme a fase (ver seção 5 — Baselines e Charter).

---

## 4. Diagnóstico PMBOK — O que falta por Área de Conhecimento

### 4.1 Risk Management — CRÍTICO

**Hoje:** `RISCOS_BRIEFING` e `RISCO_ABERTURA` são `VARCHAR2(4000)` — texto livre, impossível de consultar, priorizar ou monitorar.

**PMBOK recomenda** Risk Register estruturado com: Risk ID, descrição, categoria, causa-raiz, trigger, probabilidade, impacto, score, owner, estratégia de resposta (avoid/transfer/mitigate/accept para ameaças; exploit/share/enhance/accept para oportunidades), status, risco residual.

### 4.2 Quality Management — AUSENTE

**Hoje:** nenhum campo ou tabela relacionada a qualidade.

**PMBOK recomenda:** Quality Management Plan, métricas de qualidade, critérios de aceitação por entregável, resultados de auditorias/inspeções, custo da qualidade.

### 4.3 Communications Management — AUSENTE

**Hoje:** nenhum plano de comunicação estruturado (somente relatos em `ORION_TI_042`).

**PMBOK recomenda:** Communications Management Plan (quem recebe o quê, com que frequência, em que canal), registro de artefatos comunicados (atas, releases, newsletters).

### 4.4 Procurement Management — QUASE AUSENTE

**Hoje:** `ORION_TI_065.PAGAR_PARA VARCHAR2(400)` — um campo texto não é gestão de aquisições.

**PMBOK recomenda:** SOW, tipo de contrato (FP, CR, T&M), RFP/RFQ, critérios de seleção de fornecedor, contrato, marcos de pagamento, controle de aditivos/claims.

### 4.5 Scope Management — Parcial

**Hoje:** `REQUISITO`, `ENTREGAVEL`, `EXCLUSAO_ESCOPO`, `MVPS` — todos `VARCHAR2(4000)`.

**PMBOK recomenda:** Requirements Traceability Matrix (RTM) com ID do requisito, fonte/stakeholder, prioridade, status, vínculo com entregável e com caso de teste.

### 4.6 Stakeholder Management — Parcial

**Hoje:** `PARTE_AFETADA VARCHAR2(4000)` + equipe em `ORION_TI_055`.

**PMBOK recomenda:** Stakeholder Register com poder, interesse, engajamento (unaware → resistant → neutral → supportive → leading), estratégia de engajamento.

### 4.7 Resource Management — Parcial

**Hoje:** `ORION_TI_055` tem 1 função por pessoa/projeto — **não é um RACI**.

**PMBOK recomenda:** RACI por atividade/entregável (uma pessoa pode ser `R` em uma tarefa e `C` em outra). Sem isso, accountability fica ambíguo.

### 4.8 Integration / Change Control — Parcial

**Hoje:** sem log formal de mudanças de escopo/prazo/custo.

**PMBOK recomenda:** Change Log com ID, solicitante, descrição, impacto (escopo/prazo/custo/qualidade/recursos), status (submitted → approved/rejected → implemented), CCB aprovador.

### 4.9 Cost Management — Parcial

**Hoje:** `ORION_TI_065` (orçamento previsto) e custo em `ORION_TI_070/071` (real apontado), mas **sem baseline** nem métricas EVM.

**PMBOK recomenda:** Cost Baseline + cálculo de PV/EV/AC → CPI/SPI/EAC/TCPI. Requer marcar **snapshot** do baseline ao aprovar o plano.

### 4.10 Schedule Management — Boa base, mas falta

**Hoje:** `ORION_TI_045` tem datas previstas; `ORION_TI_070` tem datas reais.

**Faltam:** (a) **dependências** entre atividades (predecessor/successor + tipo FS/SS/FF/SF + lag) para calcular caminho crítico (CPM); (b) **schedule baseline** congelado; (c) resource leveling.

### 4.11 Closing — Lessons Learned ausente

**Hoje:** nenhuma tabela para lições aprendidas (OPA — Organizational Process Assets).

**PMBOK recomenda:** repositório estruturado de lições aprendidas classificadas por categoria (técnica, de processo, de pessoas), pesquisável entre projetos.

---

## 5. Proposta Arquitetural — Novas Tabelas

A numeração sugerida segue o padrão `ORION_TI_0XX` já em uso.

### 5.1 Risk Register — `ORION_TI_080`

```sql
CREATE TABLE ORION.ORION_TI_080 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    CODIGO          VARCHAR2(20)  NOT NULL,        -- R-001, R-002
    DESCRICAO       VARCHAR2(1000) NOT NULL,
    CATEGORIA       VARCHAR2(50),                  -- Técnico, Cronograma, Custo, Externo
    CAUSA_RAIZ      VARCHAR2(1000),
    TRIGGER_SINTOMA VARCHAR2(1000),
    PROBABILIDADE   NUMBER(3,2) CHECK (PROBABILIDADE BETWEEN 0 AND 1),  -- 0.00 a 1.00
    IMPACTO         NUMBER(2,0) CHECK (IMPACTO BETWEEN 1 AND 10),
    SCORE           NUMBER(5,2) GENERATED ALWAYS AS (PROBABILIDADE * IMPACTO) VIRTUAL,
    TIPO            CHAR(1) CHECK (TIPO IN ('A','O')),  -- Ameaça ou Oportunidade
    ESTRATEGIA      VARCHAR2(20)
        CHECK (ESTRATEGIA IN ('AVOID','TRANSFER','MITIGATE','ACCEPT',
                              'EXPLOIT','SHARE','ENHANCE')),
    PLANO_RESPOSTA  VARCHAR2(2000),
    ID_OWNER        NUMBER(9,0),
    STATUS          VARCHAR2(20) CHECK (STATUS IN ('IDENTIFIED','ANALYZING','MITIGATING','CLOSED','OCCURRED')),
    RISCO_RESIDUAL  VARCHAR2(1000),
    DATA_IDENTIFICACAO DATE DEFAULT SYSDATE,
    CONSTRAINT ORION_TI_080_PK PRIMARY KEY (ID),
    CONSTRAINT FK_080_PROJETO  FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE,
    CONSTRAINT FK_080_OWNER    FOREIGN KEY (ID_OWNER)   REFERENCES ORION.ORION_001(ID)
);
```

### 5.2 Stakeholder Register — `ORION_TI_081`

```sql
CREATE TABLE ORION.ORION_TI_081 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    NOME            VARCHAR2(200) NOT NULL,
    ID_USUARIO      NUMBER(9,0),                   -- NULL se externo
    TIPO            CHAR(1) CHECK (TIPO IN ('I','E')), -- Interno / Externo
    PAPEL           VARCHAR2(200),
    PODER           NUMBER(1,0) CHECK (PODER BETWEEN 1 AND 5),
    INTERESSE       NUMBER(1,0) CHECK (INTERESSE BETWEEN 1 AND 5),
    INFLUENCIA      NUMBER(1,0) CHECK (INFLUENCIA BETWEEN 1 AND 5),
    ENGAJAMENTO_ATUAL  VARCHAR2(20)
        CHECK (ENGAJAMENTO_ATUAL IN ('UNAWARE','RESISTANT','NEUTRAL','SUPPORTIVE','LEADING')),
    ENGAJAMENTO_DESEJADO VARCHAR2(20)
        CHECK (ENGAJAMENTO_DESEJADO IN ('UNAWARE','RESISTANT','NEUTRAL','SUPPORTIVE','LEADING')),
    ESTRATEGIA_ENGAJAMENTO VARCHAR2(2000),
    EXPECTATIVAS    VARCHAR2(2000),
    CONSTRAINT ORION_TI_081_PK PRIMARY KEY (ID),
    CONSTRAINT FK_081_PROJETO FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE,
    CONSTRAINT FK_081_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES ORION.ORION_001(ID)
);
```

### 5.3 Requirements Traceability Matrix — `ORION_TI_082` + `ORION_TI_083`

```sql
-- Requisitos
CREATE TABLE ORION.ORION_TI_082 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    CODIGO          VARCHAR2(20) NOT NULL,         -- REQ-001
    DESCRICAO       VARCHAR2(2000) NOT NULL,
    TIPO            VARCHAR2(20) CHECK (TIPO IN ('FUNCIONAL','NAO_FUNCIONAL','NEGOCIO','REGULATORIO')),
    PRIORIDADE      VARCHAR2(10) CHECK (PRIORIDADE IN ('MUST','SHOULD','COULD','WONT')), -- MoSCoW
    ID_STAKEHOLDER_FONTE NUMBER(9,0),
    CRITERIO_ACEITACAO VARCHAR2(2000),
    STATUS          VARCHAR2(20) CHECK (STATUS IN ('RASCUNHO','APROVADO','EM_DESENV','ENTREGUE','REJEITADO')),
    CONSTRAINT ORION_TI_082_PK PRIMARY KEY (ID),
    CONSTRAINT FK_082_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE,
    CONSTRAINT FK_082_STAKE FOREIGN KEY (ID_STAKEHOLDER_FONTE) REFERENCES ORION.ORION_TI_081(ID)
);

-- Rastreabilidade: requisito ↔ entregável/atividade
CREATE TABLE ORION.ORION_TI_083 (
    ID              NUMBER(9,0) NOT NULL,
    ID_REQUISITO    NUMBER(9,0) NOT NULL,
    ID_ATIVIDADE    NUMBER(9,0),
    ID_ENTREGAVEL   NUMBER(9,0),                   -- Caso haja tabela de entregáveis no futuro
    TIPO_RELACAO    VARCHAR2(20),                  -- IMPLEMENTS / TESTS / VERIFIES
    CONSTRAINT ORION_TI_083_PK PRIMARY KEY (ID),
    CONSTRAINT FK_083_REQ  FOREIGN KEY (ID_REQUISITO) REFERENCES ORION.ORION_TI_082(ID) ON DELETE CASCADE,
    CONSTRAINT FK_083_ATIV FOREIGN KEY (ID_ATIVIDADE) REFERENCES ORION.ORION_TI_045(ID)
);
```

### 5.4 Change Control Log — `ORION_TI_084`

```sql
CREATE TABLE ORION.ORION_TI_084 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    CODIGO          VARCHAR2(20) NOT NULL,         -- CR-001
    DATA_SUBMISSAO  DATE DEFAULT SYSDATE,
    ID_SOLICITANTE  NUMBER(9,0),
    DESCRICAO       VARCHAR2(2000) NOT NULL,
    JUSTIFICATIVA   VARCHAR2(2000),
    IMPACTO_ESCOPO  VARCHAR2(1000),
    IMPACTO_PRAZO_DIAS  NUMBER(5,0),
    IMPACTO_CUSTO   NUMBER(12,2),
    IMPACTO_QUALIDADE   VARCHAR2(1000),
    IMPACTO_RECURSOS    VARCHAR2(1000),
    PRIORIDADE      VARCHAR2(10) CHECK (PRIORIDADE IN ('BAIXA','MEDIA','ALTA','CRITICA')),
    STATUS          VARCHAR2(20) CHECK (STATUS IN ('SUBMETIDA','EM_ANALISE','APROVADA','REJEITADA','IMPLEMENTADA')),
    ID_APROVADOR    NUMBER(9,0),
    DATA_DECISAO    DATE,
    DATA_IMPLEMENTACAO DATE,
    CONSTRAINT ORION_TI_084_PK PRIMARY KEY (ID),
    CONSTRAINT FK_084_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE
);
```

### 5.5 Quality Management — `ORION_TI_085` + `ORION_TI_086`

```sql
-- Métricas de qualidade planejadas
CREATE TABLE ORION.ORION_TI_085 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    METRICA         VARCHAR2(200) NOT NULL,        -- Ex: "Taxa de defeitos pós-deploy"
    META_VALOR      NUMBER(12,4),
    UNIDADE         VARCHAR2(20),                  -- "%", "defeitos/kloc"
    FREQUENCIA_MEDICAO VARCHAR2(50),               -- "Semanal", "Por release"
    METODO          VARCHAR2(500),
    CONSTRAINT ORION_TI_085_PK PRIMARY KEY (ID),
    CONSTRAINT FK_085_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE
);

-- Medições reais
CREATE TABLE ORION.ORION_TI_086 (
    ID              NUMBER(9,0) NOT NULL,
    ID_METRICA      NUMBER(9,0) NOT NULL,
    DATA_MEDICAO    DATE DEFAULT SYSDATE,
    VALOR_MEDIDO    NUMBER(12,4),
    CONFORME        NUMBER(1,0) CHECK (CONFORME IN (0,1)),
    OBSERVACAO      VARCHAR2(1000),
    CONSTRAINT ORION_TI_086_PK PRIMARY KEY (ID),
    CONSTRAINT FK_086_METRICA FOREIGN KEY (ID_METRICA) REFERENCES ORION.ORION_TI_085(ID) ON DELETE CASCADE
);
```

### 5.6 Baselines (Escopo, Prazo, Custo) — `ORION_TI_087`

```sql
CREATE TABLE ORION.ORION_TI_087 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    TIPO            VARCHAR2(20) CHECK (TIPO IN ('ESCOPO','PRAZO','CUSTO','INTEGRADO')),
    VERSAO          NUMBER(3,0) NOT NULL,
    DATA_CONGELAMENTO TIMESTAMP DEFAULT SYSTIMESTAMP,
    ID_APROVADOR    NUMBER(9,0),
    PAYLOAD_JSON    CLOB,                          -- snapshot do estado
    ATIVO           NUMBER(1,0) DEFAULT 1,
    CONSTRAINT ORION_TI_087_PK PRIMARY KEY (ID),
    CONSTRAINT FK_087_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE,
    CONSTRAINT UQ_087_VERSAO UNIQUE (ID_PROJETO, TIPO, VERSAO)
);
```

O `PAYLOAD_JSON` armazena o snapshot imutável (lista de atividades com datas/custos congelados no momento da aprovação). Permite cálculo posterior de CPI/SPI.

### 5.7 Dependências entre atividades (CPM) — `ORION_TI_088`

```sql
CREATE TABLE ORION.ORION_TI_088 (
    ID              NUMBER(9,0) NOT NULL,
    ID_ATIVIDADE_PREDECESSORA NUMBER(9,0) NOT NULL,
    ID_ATIVIDADE_SUCESSORA    NUMBER(9,0) NOT NULL,
    TIPO            VARCHAR2(2) CHECK (TIPO IN ('FS','SS','FF','SF')) DEFAULT 'FS',
    LAG_DIAS        NUMBER(5,0) DEFAULT 0,         -- pode ser negativo (lead)
    CONSTRAINT ORION_TI_088_PK PRIMARY KEY (ID),
    CONSTRAINT FK_088_PRED FOREIGN KEY (ID_ATIVIDADE_PREDECESSORA) REFERENCES ORION.ORION_TI_045(ID) ON DELETE CASCADE,
    CONSTRAINT FK_088_SUCC FOREIGN KEY (ID_ATIVIDADE_SUCESSORA)    REFERENCES ORION.ORION_TI_045(ID) ON DELETE CASCADE,
    CONSTRAINT CK_088_DIFF CHECK (ID_ATIVIDADE_PREDECESSORA <> ID_ATIVIDADE_SUCESSORA)
);
```

Com essa tabela você consegue, via query recursiva (`CONNECT BY` no Oracle), calcular **caminho crítico** e **float**.

### 5.8 RACI por Atividade — `ORION_TI_089`

```sql
CREATE TABLE ORION.ORION_TI_089 (
    ID              NUMBER(9,0) NOT NULL,
    ID_ATIVIDADE    NUMBER(9,0) NOT NULL,
    ID_USUARIO      NUMBER(9,0) NOT NULL,
    PAPEL           CHAR(1) CHECK (PAPEL IN ('R','A','C','I')),
    CONSTRAINT ORION_TI_089_PK PRIMARY KEY (ID),
    CONSTRAINT FK_089_ATIV FOREIGN KEY (ID_ATIVIDADE) REFERENCES ORION.ORION_TI_045(ID) ON DELETE CASCADE,
    CONSTRAINT FK_089_USU  FOREIGN KEY (ID_USUARIO)   REFERENCES ORION.ORION_001(ID)
);

-- Regra: apenas 1 "A" (Accountable) por atividade
CREATE UNIQUE INDEX UQ_089_ACCOUNTABLE
    ON ORION.ORION_TI_089 (ID_ATIVIDADE, CASE WHEN PAPEL = 'A' THEN 1 ELSE NULL END);
```

### 5.9 Lessons Learned — `ORION_TI_090`

```sql
CREATE TABLE ORION.ORION_TI_090 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    CATEGORIA       VARCHAR2(30) CHECK (CATEGORIA IN ('TECNICA','PROCESSO','PESSOAS','FORNECEDOR','COMUNICACAO')),
    TIPO            CHAR(1) CHECK (TIPO IN ('P','N')), -- Positiva / Negativa
    SITUACAO        VARCHAR2(2000) NOT NULL,
    ACAO_TOMADA     VARCHAR2(2000),
    RESULTADO       VARCHAR2(2000),
    RECOMENDACAO    VARCHAR2(2000),
    TAGS            VARCHAR2(500),                 -- busca entre projetos
    DATA_REGISTRO   DATE DEFAULT SYSDATE,
    ID_AUTOR        NUMBER(9,0),
    CONSTRAINT ORION_TI_090_PK PRIMARY KEY (ID),
    CONSTRAINT FK_090_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID)
);
```

### 5.10 Procurement — `ORION_TI_091`

```sql
CREATE TABLE ORION.ORION_TI_091 (
    ID              NUMBER(9,0) NOT NULL,
    ID_PROJETO      NUMBER(9,0) NOT NULL,
    FORNECEDOR      VARCHAR2(400) NOT NULL,
    CNPJ            VARCHAR2(20),
    TIPO_CONTRATO   VARCHAR2(10) CHECK (TIPO_CONTRATO IN ('FFP','FPIF','FPEPA','CPFF','CPIF','CPAF','TM')),
    SOW             CLOB,                          -- Statement of Work
    VALOR_CONTRATO  NUMBER(14,2),
    DATA_INICIO     DATE,
    DATA_FIM_PREVISTO DATE,
    DATA_FIM_REAL   DATE,
    STATUS          VARCHAR2(20) CHECK (STATUS IN ('RASCUNHO','ENVIADO','ATIVO','SUSPENSO','ENCERRADO')),
    DOCUMENTO_URL   VARCHAR2(1000),
    CONSTRAINT ORION_TI_091_PK PRIMARY KEY (ID),
    CONSTRAINT FK_091_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE
);
```

Vincule `ORION_TI_065.ID_CONTRATO` → `ORION_TI_091.ID` para itens de custo contratuais.

---

## 6. Normalização sugerida de `ORION_TI_040`

A tabela atual mistura Charter + Briefing + Planejamento + Acompanhamento. Proposta de segregação (mantendo compatibilidade):

```sql
-- Charter (1:1 com projeto)
CREATE TABLE ORION.ORION_TI_040A (
    ID_PROJETO       NUMBER(9,0) PRIMARY KEY,
    OBJETIVO_PROJETO VARCHAR2(4000),
    OBJETIVO_SMART   VARCHAR2(4000),
    JUSTIFICATIVA    VARCHAR2(4000),
    CONTEXTUALIZACAO VARCHAR2(4000),
    DESCRICAO_PROBLEMA VARCHAR2(4000),
    DATA_APROVACAO   DATE,
    ID_SPONSOR       NUMBER(9,0),
    CONSTRAINT FK_040A_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE
);

-- Acompanhamento (1:1 com projeto — dados voláteis)
CREATE TABLE ORION.ORION_TI_040B (
    ID_PROJETO         NUMBER(9,0) PRIMARY KEY,
    STATUS_CONTROLE    NUMBER(9,0),                -- FK semáforo (seção 3.2)
    PROXIMAS_ACOES     VARCHAR2(4000),
    ACAO_EM_ANDAMENTO  VARCHAR2(4000),
    DATA_ATT_STATUS    TIMESTAMP,
    CONSTRAINT FK_040B_PROJ FOREIGN KEY (ID_PROJETO) REFERENCES ORION.ORION_TI_040(ID) ON DELETE CASCADE
);
```

A tabela `ORION_TI_040` fica enxuta — apenas identificação e FKs principais.

---

## 7. Roadmap de Evolução Sugerido

### Sprint 1 — Sanitização (1–2 semanas)
- Adicionar PKs em `ORION_TI_060` e `ORION_TI_072`.
- Corrigir tipo de `ROI` (VARCHAR → NUMBER) — **atenção à migração de dados existentes**.
- Resolver redundância de status em `ORION_TI_040` (manter apenas `ID_STATUS`).
- Adicionar campos de auditoria (`CREATED_AT/BY`, `UPDATED_AT/BY`) em todas as tabelas principais.

### Sprint 2 — Gestão de Riscos e Stakeholders (2–3 semanas)
- Criar `ORION_TI_080` (Risk Register) — **maior ROI de aderência ao PMBOK**.
- Criar `ORION_TI_081` (Stakeholder Register).
- **Script de migração** dos campos-texto `RISCOS_BRIEFING` / `PARTE_AFETADA` para os novos modelos (parsing manual ou assistido por IA).
- Telas de CRUD de riscos e stakeholders.

### Sprint 3 — Escopo e Mudanças (2 semanas)
- Criar `ORION_TI_082` / `ORION_TI_083` (Requirements + RTM).
- Criar `ORION_TI_084` (Change Log).
- Política formal de CCB (Change Control Board).

### Sprint 4 — Planejamento Avançado (3 semanas)
- Criar `ORION_TI_088` (Dependências) + implementar cálculo de **caminho crítico** via `CONNECT BY`.
- Criar `ORION_TI_089` (RACI).
- Criar `ORION_TI_087` (Baselines) — congelar snapshot ao aprovar plano.

### Sprint 5 — Qualidade e EVM (2 semanas)
- Criar `ORION_TI_085`/`ORION_TI_086` (Qualidade).
- Implementar cálculo de **EVM** (PV, EV, AC, CPI, SPI, EAC) a partir de baseline + apontamentos.

### Sprint 6 — Encerramento e Aquisições (1–2 semanas)
- Criar `ORION_TI_090` (Lessons Learned) + busca full-text cross-project.
- Criar `ORION_TI_091` (Procurement).

### Sprint 7+ — Comunicações
- Plano de comunicação estruturado (matriz stakeholder × tipo de artefato × frequência × canal).

---

## 8. Entregas Colaterais Recomendadas

1. **Views analíticas** — criar VIEWs materializadas para:
   - Dashboard de portfólio (projetos × status × ROI × squad).
   - Matriz probabilidade × impacto de riscos agregada.
   - Engajamento de stakeholders atual vs. desejado.
   - CPI/SPI por projeto.

2. **Dicionário de dados formal** — documentar cada tabela e coluna com nome de negócio (ex: `ORION_TI_040` = "Projeto / Charter"). A nomenclatura numérica atual é um ativo técnico, mas é hostil para usuários de BI.

3. **Governança de domínios** — tabelas de lookup (`ORION_TI_041`, futuro `ORION_TI_041A` etc.) centralizadas com controle de ativação (`ATIVO = 0/1`) e versionamento se possível.

---

## 9. Conclusão

O modelo tem uma **boa espinha dorsal** para iniciação, planejamento básico e apontamento de horas. Os três gaps mais críticos — e que, se preenchidos, elevam o sistema a um patamar compatível com PMBOK — são:

1. **Risk Register estruturado** (substitui texto livre)
2. **Stakeholder Register com engajamento** (substitui texto livre)
3. **Baselines + EVM** (habilita medição real de desempenho)

Como quick wins imediatos, corrigir PKs faltantes, resolver a redundância de campos de status em `ORION_TI_040` e padronizar auditoria são ações de baixo custo com alto retorno em qualidade do dado.

---

**Próximos passos sugeridos:**
- Validar a numeração proposta (`ORION_TI_080` em diante) com o time que mantém o schema.
- Priorizar Sprints 1 e 2 — entregam o maior ganho de maturidade PMBOK com menor complexidade.
- Decidir estratégia de migração dos campos-texto legados (`RISCOS_BRIEFING`, `PARTE_AFETADA`, `REQUISITO`, `ENTREGAVEL`) — parse manual, parse assistido por IA, ou manter histórico e popular só a partir de projetos novos.
