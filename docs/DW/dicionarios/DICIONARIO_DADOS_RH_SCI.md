# Dicionario de Dados — Schema rh_sci

> **Versao:** 1.0 | **Data:** 2026-05-05
> **Autor:** Equipe DW
> **Status:** Em revisao
> **Escopo:** 7 tabelas do schema `rh_sci` (sistema Employer/SCI)

---

## Sumario

| Tabela atual | Tabela proposta | Tipo | Conflito |
|---|---|---|---|
| rh_sci.dhistorico_salario | rh_sci.f_historico_salario | fato | Sem conflito direto |
| rh_sci.fcontratos_lecom | rh_sci.f_contrato_lecom | fato | Sem conflito direto |
| rh_sci.ffolha_salarial | rh_sci.f_folha_salarial | fato | Sem conflito direto |
| rh_sci.fprov_bruto_colab | rh_sci.f_provento_bruto_colaborador | fato | [CONFLITO] rh.fprovento_lojas (estrutura identica) |
| rh_sci.fproventos_depto_employer | rh_sci.f_provento_departamento | fato | Sem conflito direto |
| rh_sci.freajuste | rh_sci.f_reajuste | fato | [CONFLITO] rh.freajuste (identica) |
| rh_sci.fsalario_employer | rh_sci.f_salario_employer | fato | Sem conflito direto |

---

## Observacoes Gerais

- Todas as tabelas carecem de surrogate key `id bigserial PRIMARY KEY` (exceto `fproventos_depto_employer`, que ja possui `id serial4`).
- Nenhuma tabela possui coluna `created_at` — adicionar em todas.
- `ultima_atualizacao` deve ser renomeado para `updated_at` em todas as tabelas.
- Prefixos `fk_` nas colunas indicam intencao de chave estrangeira, mas sem FK declarada no banco; renomear para `cod_` (business key) ou `id_` (operacional) conforme o caso.
- Os prefixos `vlr_`, `val_`, `pct_`, `pr_` e similares devem ser normalizados para `vl_` e `pc_` conforme boas praticas.
- `fcontratos_lecom` e uma tabela hibrida de contratos imobiliarios gerenciados pelo sistema Lecom — atipica no contexto de RH puro.

---

## Detalhamento por Tabela

---

### rh_sci.dhistorico_salario

**Nome proposto:** `rh_sci.f_historico_salario`
**Tipo:** fato
**Descricao:** Registra o historico de alteracoes salariais dos colaboradores no sistema Employer/SCI. Cada linha representa um evento de mudanca de salario, com data, sequencia, percentuais de reajuste e desempenho. Funciona como SCD Tipo 2 da perspectiva do salario do colaborador.
**Sistema de origem:** Employer/SCI

> **Nota de nomenclatura:** O prefixo `d` no nome atual e enganoso — a tabela nao e uma dimensao (nao tem chave natural unica, nao e lookup). Trata-se de um fato historico de mudancas salariais. Nome proposto usa prefixo `f_`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| fk_funcionario | varchar(184) NULL | cod_colaborador | varchar(20) NOT NULL | [RENAME] [RETYPE] | Business key do colaborador; padronizar com dicionario de entidades (secao 11 boas praticas). Reduzir para varchar(20) apos validar tamanho real na origem |
| dt_alteracao | timestamp NULL | dth_alteracao | timestamp NOT NULL | [RENAME] | Prefixo `dth_` para campos data+hora conforme boas praticas |
| sequencia | int2 NULL | nr_sequencia | smallint NULL | [RENAME] | Prefixo `nr_` para numero sequencial |
| sal_atual | numeric(17, 4) NULL | vl_salario_atual | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_` para valor monetario; precisao reduzida para 15,2 (padrao DW) |
| val_complementar | numeric(17, 4) NULL | vl_complementar | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao padronizada |
| classe_sal | varchar(5) NULL | ds_classe_salarial | varchar(5) NULL | [RENAME] | Prefixo `ds_` para descricao/codigo curto |
| nivel_sal | varchar(5) NULL | ds_nivel_salarial | varchar(5) NULL | [RENAME] | Prefixo `ds_` |
| pct_desempenho | numeric(7, 2) NULL | pc_desempenho | numeric(7,4) NULL | [RENAME] [RETYPE] | Prefixo `pc_` para percentual; 4 casas decimais conforme padrao |
| pct_reajuste_conced | numeric(13, 5) NULL | pc_reajuste_concedido | numeric(7,4) NULL | [RENAME] [RETYPE] | Prefixo `pc_`; nome completo sem abreviacao; precisao padronizada para 7,4 |
| _(ausente)_ | — | id | bigserial NOT NULL | [ADD] | Surrogate key obrigatoria conforme boas praticas |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Coluna de auditoria obrigatoria |
| _(ausente)_ | — | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Coluna de auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave de negocio (unicidade logica): `(cod_colaborador, dth_alteracao, nr_sequencia)` — sujeita a validacao na origem.

#### Relacionamentos propostos

```
rh_sci.f_historico_salario
  |- cod_colaborador -> rh.dfuncionario.pk_funcionario (equivalente a cod_colaborador)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_historico_salario_cod_colaborador ON rh_sci.f_historico_salario (cod_colaborador);
CREATE INDEX idx_f_historico_salario_dth_alteracao   ON rh_sci.f_historico_salario (dth_alteracao);
```

#### Impacto no ETL

- Renomear alias de todas as colunas no DAG de carga.
- Converter `fk_funcionario varchar(184)` para `cod_colaborador varchar(20)`: validar truncamento na origem antes de aplicar.
- Substituir `pct_` por `pc_` e ajustar tipos numericos no pipeline.
- Incluir `created_at` e `updated_at` nos inserts (ou omitir e usar DEFAULT do banco).
- Watermark de carga incremental: usar `updated_at` (mapeado de `dth_alteracao` enquanto nao houver campo de atualizacao proprio).

#### Migracao SQL

```sql
-- Etapa 1: renomear tabela atual
ALTER TABLE rh_sci.dhistorico_salario RENAME TO f_historico_salario;

-- Etapa 2: adicionar surrogate key
ALTER TABLE rh_sci.f_historico_salario
    ADD COLUMN id bigserial PRIMARY KEY;

-- Etapa 3: renomear colunas
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN fk_funcionario        TO cod_colaborador;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN dt_alteracao          TO dth_alteracao;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN sequencia             TO nr_sequencia;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN sal_atual             TO vl_salario_atual;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN val_complementar      TO vl_complementar;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN classe_sal            TO ds_classe_salarial;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN nivel_sal             TO ds_nivel_salarial;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN pct_desempenho        TO pc_desempenho;
ALTER TABLE rh_sci.f_historico_salario
    RENAME COLUMN pct_reajuste_conced   TO pc_reajuste_concedido;

-- Etapa 4: ajustar tipos
ALTER TABLE rh_sci.f_historico_salario
    ALTER COLUMN vl_salario_atual    TYPE numeric(15,2) USING vl_salario_atual::numeric(15,2),
    ALTER COLUMN vl_complementar     TYPE numeric(15,2) USING vl_complementar::numeric(15,2),
    ALTER COLUMN pc_desempenho       TYPE numeric(7,4)  USING pc_desempenho::numeric(7,4),
    ALTER COLUMN pc_reajuste_concedido TYPE numeric(7,4) USING pc_reajuste_concedido::numeric(7,4);

-- Etapa 5: colunas de auditoria
ALTER TABLE rh_sci.f_historico_salario
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp,
    ADD COLUMN updated_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 6: indices
CREATE INDEX idx_f_historico_salario_cod_colaborador ON rh_sci.f_historico_salario (cod_colaborador);
CREATE INDEX idx_f_historico_salario_dth_alteracao   ON rh_sci.f_historico_salario (dth_alteracao);

-- Etapa 7: view de compatibilidade (remover apos 90 dias)
CREATE OR REPLACE VIEW rh_sci.dhistorico_salario AS
    SELECT * FROM rh_sci.f_historico_salario;
COMMENT ON VIEW rh_sci.dhistorico_salario IS
    'DEPRECATED 2026-05-05: usar f_historico_salario. Sera removido em 2026-08-03.';
```

---

### rh_sci.fcontratos_lecom

**Nome proposto:** `rh_sci.f_contrato_lecom`
**Tipo:** fato
**Descricao:** Registra contratos imobiliarios (locacao de imoveis) gerenciados pelo sistema Lecom, vinculados a processos de RH corporativo. Contem dados de partes (CNPJ/CPF), endereco do imovel, vigencia, valores e condicoes comerciais. Estrutura hibrida: combina atributos de negocio de contrato com dados cadastrais que deveriam estar em dimensoes.
**Sistema de origem:** Lecom (via integracao SCI/Employer)

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| cod_processo_f | int4 NULL | nr_processo | integer NULL | [RENAME] | Numero de processo; prefixo `nr_`. Sufixo `_f` nao tem significado semantico claro |
| cod_etapa_f | int2 NULL | id_etapa | smallint NULL | [RENAME] | Codigo operacional de etapa; prefixo `id_` |
| cod_ciclo_f | int2 NULL | id_ciclo | smallint NULL | [RENAME] | Codigo operacional de ciclo; prefixo `id_` |
| nome_contrato | varchar(50) NULL | nm_contrato | varchar(50) NULL | [RENAME] | Prefixo `nm_` para nome |
| tipo_contrato | varchar(50) NULL | ds_tipo_contrato | varchar(50) NULL | [RENAME] | Prefixo `ds_` para descricao |
| cnpj | varchar(30) NULL | cnpj_contratada | varchar(16) NULL | [RENAME] [RETYPE] | Nome generico; especificar entidade. Reduzir para varchar(16) conforme padrao |
| cnpj_live | varchar(30) NULL | cnpj_live | varchar(16) NULL | [RETYPE] | Nome ja adequado; reduzir para varchar(16) |
| cnpj_filial | varchar(30) NULL | cnpj_filial | varchar(16) NULL | [RETYPE] | Reduzir para varchar(16) conforme padrao |
| grupo_live | varchar(200) NULL | nm_grupo_live | varchar(200) NULL | [RENAME] | Prefixo `nm_` |
| depart_solicitante | varchar(30) NULL | nm_departamento_solicitante | varchar(60) NULL | [RENAME] | Nome completo; ampliar tamanho para acomodar nomes reais |
| finalidade_locacao | varchar(50) NULL | ds_finalidade_locacao | varchar(50) NULL | [RENAME] | Prefixo `ds_` |
| nome_completo | varchar(80) NULL | nm_responsavel | varchar(80) NULL | [RENAME] | Nomear a entidade descrita (responsavel pelo contrato) |
| cpf | varchar(14) NULL | cpf_responsavel | varchar(12) NULL | [RENAME] [RETYPE] | Especificar entidade; varchar(12) conforme padrao CPF |
| cpf_rep_legal | varchar(14) NULL | cpf_representante_legal | varchar(12) NULL | [RENAME] [RETYPE] | Nome completo; varchar(12) |
| email | varchar(50) NULL | nm_email_responsavel | varchar(100) NULL | [RENAME] | Prefixo `nm_` para email; ampliar campo |
| nome_empreendimento | varchar(30) NULL | nm_empreendimento | varchar(50) NULL | [RENAME] | Prefixo `nm_`; ampliar tamanho |
| area_metros_quadrados | varchar(25) NULL | qt_area_m2 | numeric(10,2) NULL | [RENAME] [RETYPE] | Dado numerico armazenado como varchar; converter para numeric |
| endereco | varchar(50) NULL | end_logradouro | varchar(100) NULL | [RENAME] | Prefixo `end_`; ampliar tamanho |
| numero | varchar(10) NULL | end_numero | varchar(10) NULL | [RENAME] | Prefixo `end_` |
| bairro | varchar(50) NULL | end_bairro | varchar(50) NULL | [RENAME] | Prefixo `end_` |
| cep | varchar(12) NULL | end_cep | char(8) NULL | [RENAME] [RETYPE] | Prefixo `end_`; char(8) sem formatacao conforme padrao |
| cidade | varchar(50) NULL | end_cidade | varchar(50) NULL | [RENAME] | Prefixo `end_` |
| estado | varchar(2) NULL | end_uf | char(2) NULL | [RENAME] [RETYPE] | Prefixo `end_`; char(2) |
| pais | varchar(30) NULL | end_pais | varchar(30) NULL | [RENAME] | Prefixo `end_` |
| data_inicio_vigencia | timestamp NULL | dt_inicio_vigencia | date NULL | [RENAME] [RETYPE] | Prefixo `dt_`; apenas data (sem hora) — converter para date |
| data_fim_vigencia | timestamp NULL | dt_fim_vigencia | date NULL | [RENAME] [RETYPE] | Prefixo `dt_`; date |
| percentual_aluguel | varchar(25) NULL | pc_aluguel | numeric(7,4) NULL | [RENAME] [RETYPE] | Dado numerico em varchar; converter para numeric; prefixo `pc_` |
| indice_reajuste | varchar(255) NULL | ds_indice_reajuste | varchar(255) NULL | [RENAME] | Prefixo `ds_` |
| periodicidade_reajuste | varchar(25) NULL | ds_periodicidade_reajuste | varchar(25) NULL | [RENAME] | Prefixo `ds_` |
| carencia_aluguel | varchar(25) NULL | ds_carencia_aluguel | varchar(25) NULL | [RENAME] | Prefixo `ds_`; avaliar conversao para integer (meses) |
| fundo_promocao | varchar(25) NULL | ds_fundo_promocao | varchar(25) NULL | [RENAME] | Prefixo `ds_` |
| cdu | varchar(25) NULL | ds_cdu | varchar(25) NULL | [RENAME] | Prefixo `ds_`; CDU = Cessao de Direito de Uso |
| aluguel_escalonado | varchar(255) NULL | obs_aluguel_escalonado | text NULL | [RENAME] [RETYPE] | Campo texto livre; prefixo `obs_`; text |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [RENAME] | Auditoria padrao |
| cronograma_atividades | varchar(5500) NULL | obs_cronograma_atividades | text NULL | [RENAME] [RETYPE] | Texto livre; prefixo `obs_`; text sem limite arbitrario |
| tipo_imovel | varchar(207) NULL | ds_tipo_imovel | varchar(207) NULL | [RENAME] | Prefixo `ds_` |
| matriz_filial | varchar(200) NULL | ds_matriz_filial | varchar(200) NULL | [RENAME] | Prefixo `ds_` |
| tipo_solicitacao | varchar(200) NULL | ds_tipo_solicitacao | varchar(200) NULL | [RENAME] | Prefixo `ds_` |
| tipo_locacao | varchar(200) NULL | ds_tipo_locacao | varchar(200) NULL | [RENAME] | Prefixo `ds_`; verificar redundancia com `tipo_da_locacao` |
| tipo_da_locacao | varchar(200) NULL | ds_modalidade_locacao | varchar(200) NULL | [RENAME] | Distincao semantica de `tipo_locacao`; investigar duplicidade na origem |
| objeto_contrato | varchar(5500) NULL | obs_objeto_contrato | text NULL | [RENAME] [RETYPE] | Texto livre; text |
| valor_contratado | numeric(18, 3) NULL | vl_contratado | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| valor_multa | numeric(18, 3) NULL | vl_multa | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| _(ausente)_ | — | id | bigserial NOT NULL | [ADD] | Surrogate key obrigatoria |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave de negocio (unicidade logica): `(nr_processo, id_etapa, id_ciclo)` — validar na origem.

#### Relacionamentos propostos

```
rh_sci.f_contrato_lecom
  |- cnpj_live       -> rh.dempresa_employer.cnpj (empresa Live)
  |- cnpj_filial     -> rh.dfilial.cnpj (filial responsavel)
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_contrato_lecom_nr_processo    ON rh_sci.f_contrato_lecom (nr_processo);
CREATE INDEX idx_f_contrato_lecom_cnpj_live      ON rh_sci.f_contrato_lecom (cnpj_live);
CREATE INDEX idx_f_contrato_lecom_dt_ini_vigencia ON rh_sci.f_contrato_lecom (dt_inicio_vigencia);
CREATE INDEX idx_f_contrato_lecom_dt_fim_vigencia ON rh_sci.f_contrato_lecom (dt_fim_vigencia);
```

#### Impacto no ETL

- Conversao critica: `area_metros_quadrados varchar -> qt_area_m2 numeric(10,2)`. Requer tratamento de valores nao numericos (ex.: "120,5 m2" -> 120.50).
- Conversao critica: `percentual_aluguel varchar -> pc_aluguel numeric(7,4)`. Idem — limpar formatacao antes de converter.
- `data_inicio_vigencia` e `data_fim_vigencia`: truncar hora ao converter para `date`.
- Colunas `cep`: remover mascara de formatacao (pontos, hifens) antes do insert.
- Verificar duplicidade semantica entre `tipo_locacao` e `tipo_da_locacao` na origem antes de consolidar.

#### Migracao SQL

```sql
-- Etapa 1: renomear tabela
ALTER TABLE rh_sci.fcontratos_lecom RENAME TO f_contrato_lecom;

-- Etapa 2: surrogate key e auditoria
ALTER TABLE rh_sci.f_contrato_lecom
    ADD COLUMN id         bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 3: renomear colunas (selecao das mais criticas)
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cod_processo_f         TO nr_processo;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cod_etapa_f            TO id_etapa;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cod_ciclo_f            TO id_ciclo;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN nome_contrato          TO nm_contrato;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN tipo_contrato          TO ds_tipo_contrato;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cnpj                   TO cnpj_contratada;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN grupo_live             TO nm_grupo_live;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN depart_solicitante     TO nm_departamento_solicitante;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN finalidade_locacao     TO ds_finalidade_locacao;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN nome_completo          TO nm_responsavel;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cpf                    TO cpf_responsavel;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cpf_rep_legal          TO cpf_representante_legal;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN email                  TO nm_email_responsavel;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN nome_empreendimento    TO nm_empreendimento;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN endereco               TO end_logradouro;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN numero                 TO end_numero;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN bairro                 TO end_bairro;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cep                    TO end_cep;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cidade                 TO end_cidade;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN estado                 TO end_uf;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN pais                   TO end_pais;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN data_inicio_vigencia   TO dt_inicio_vigencia;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN data_fim_vigencia      TO dt_fim_vigencia;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN indice_reajuste        TO ds_indice_reajuste;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN periodicidade_reajuste TO ds_periodicidade_reajuste;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN carencia_aluguel       TO ds_carencia_aluguel;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN fundo_promocao         TO ds_fundo_promocao;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cdu                    TO ds_cdu;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN aluguel_escalonado     TO obs_aluguel_escalonado;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN ultima_atualizacao     TO updated_at;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN cronograma_atividades  TO obs_cronograma_atividades;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN tipo_imovel            TO ds_tipo_imovel;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN matriz_filial          TO ds_matriz_filial;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN tipo_solicitacao       TO ds_tipo_solicitacao;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN tipo_locacao           TO ds_tipo_locacao;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN tipo_da_locacao        TO ds_modalidade_locacao;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN objeto_contrato        TO obs_objeto_contrato;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN valor_contratado       TO vl_contratado;
ALTER TABLE rh_sci.f_contrato_lecom
    RENAME COLUMN valor_multa            TO vl_multa;

-- Etapa 4: ajustar tipos
ALTER TABLE rh_sci.f_contrato_lecom
    ALTER COLUMN cnpj_contratada     TYPE varchar(16),
    ALTER COLUMN cnpj_live           TYPE varchar(16),
    ALTER COLUMN cnpj_filial         TYPE varchar(16),
    ALTER COLUMN cpf_responsavel     TYPE varchar(12),
    ALTER COLUMN cpf_representante_legal TYPE varchar(12),
    ALTER COLUMN dt_inicio_vigencia  TYPE date USING dt_inicio_vigencia::date,
    ALTER COLUMN dt_fim_vigencia     TYPE date USING dt_fim_vigencia::date,
    ALTER COLUMN vl_contratado       TYPE numeric(15,2) USING vl_contratado::numeric(15,2),
    ALTER COLUMN vl_multa            TYPE numeric(15,2) USING vl_multa::numeric(15,2);

-- Etapa 5: indices
CREATE INDEX idx_f_contrato_lecom_nr_processo     ON rh_sci.f_contrato_lecom (nr_processo);
CREATE INDEX idx_f_contrato_lecom_cnpj_live       ON rh_sci.f_contrato_lecom (cnpj_live);
CREATE INDEX idx_f_contrato_lecom_dt_ini_vigencia ON rh_sci.f_contrato_lecom (dt_inicio_vigencia);
CREATE INDEX idx_f_contrato_lecom_dt_fim_vigencia ON rh_sci.f_contrato_lecom (dt_fim_vigencia);

-- Etapa 6: view de compatibilidade (remover apos 90 dias)
CREATE OR REPLACE VIEW rh_sci.fcontratos_lecom AS
    SELECT * FROM rh_sci.f_contrato_lecom;
COMMENT ON VIEW rh_sci.fcontratos_lecom IS
    'DEPRECATED 2026-05-05: usar f_contrato_lecom. Sera removido em 2026-08-03.';
```

---

### rh_sci.ffolha_salarial

**Nome proposto:** `rh_sci.f_folha_salarial`
**Tipo:** fato
**Descricao:** Registra os eventos da folha de pagamento por colaborador, contendo informacoes de emissao, referencia da folha, cargo, evento de pagamento e valores de vencimentos, descontos e outros. Granularidade: um registro por colaborador por evento de folha.
**Sistema de origem:** Employer/SCI

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| fk_funcionario | varchar(30) NULL | cod_colaborador | varchar(20) NOT NULL | [RENAME] [RETYPE] | Business key do colaborador; padronizar com dicionario de entidades |
| fk_filial | varchar(30) NULL | cod_filial | varchar(30) NULL | [RENAME] | Business key de filial; prefixo `cod_` |
| fk_empresa | varchar(6) NULL | id_empresa | smallint NULL | [RENAME] [RETYPE] | Codigo operacional de empresa; prefixo `id_`; smallint suficiente |
| data_emissao | timestamp NULL | dt_emissao | date NOT NULL | [RENAME] [RETYPE] | Apenas data; converter para date; NOT NULL em fatos |
| data_admissao | timestamp NULL | dt_admissao | date NULL | [RENAME] [RETYPE] | Apenas data; converter para date |
| cd_folha_referencia | numeric(18, 3) NULL | nr_folha_referencia | integer NULL | [RENAME] [RETYPE] | Numero de referencia; integer suficiente; prefixo `nr_` |
| fk_evento | varchar(25) NULL | cod_evento | varchar(25) NULL | [RENAME] | Business key do evento de folha; prefixo `cod_` |
| cd_origem_evento | varchar(1) NULL | ds_origem_evento | varchar(1) NULL | [RENAME] | Codigo/descricao de origem; prefixo `ds_` |
| vlr_evento | varchar(25) NULL | vl_evento | numeric(15,2) NULL | [RENAME] [RETYPE] | Valor numerico armazenado como varchar; converter para numeric |
| fk_cargo | varchar(65) NULL | cod_cargo | varchar(65) NULL | [RENAME] | Business key do cargo; prefixo `cod_` |
| vlr_vencimentos | numeric(18, 3) NULL | vl_vencimentos | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| vlr_descontos | numeric(18, 3) NULL | vl_descontos | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| vlr_outros | numeric(18, 3) NULL | vl_outros | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [RENAME] | Auditoria padrao |
| _(ausente)_ | — | id | bigserial NOT NULL | [ADD] | Surrogate key obrigatoria |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave de negocio (unicidade logica): `(cod_colaborador, nr_folha_referencia, cod_evento)`.

#### Relacionamentos propostos

```
rh_sci.f_folha_salarial
  |- cod_colaborador -> rh.dfuncionario.pk_funcionario
  |- cod_cargo       -> rh.dcargo.pk_cargo
  |- id_empresa      -> rh.dempresa.pk_empresa
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_folha_salarial_cod_colaborador    ON rh_sci.f_folha_salarial (cod_colaborador);
CREATE INDEX idx_f_folha_salarial_dt_emissao         ON rh_sci.f_folha_salarial (dt_emissao);
CREATE INDEX idx_f_folha_salarial_nr_folha_referencia ON rh_sci.f_folha_salarial (nr_folha_referencia);
CREATE INDEX idx_f_folha_salarial_cod_evento         ON rh_sci.f_folha_salarial (cod_evento);
```

#### Impacto no ETL

- Conversao critica: `vlr_evento varchar(25) -> vl_evento numeric(15,2)`. Tratar valores nao numericos e formatacao antes de converter.
- `data_emissao` e `data_admissao`: truncar hora ao converter para `date`.
- `fk_empresa varchar(6) -> id_empresa smallint`: validar que todos os valores sao numericos e caibam em smallint.
- Watermark incremental: `updated_at` (de `ultima_atualizacao`).

#### Migracao SQL

```sql
-- Etapa 1: renomear tabela
ALTER TABLE rh_sci.ffolha_salarial RENAME TO f_folha_salarial;

-- Etapa 2: surrogate key e auditoria
ALTER TABLE rh_sci.f_folha_salarial
    ADD COLUMN id         bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 3: renomear colunas
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN fk_funcionario       TO cod_colaborador;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN fk_filial            TO cod_filial;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN fk_empresa           TO id_empresa;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN data_emissao         TO dt_emissao;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN data_admissao        TO dt_admissao;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN cd_folha_referencia  TO nr_folha_referencia;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN fk_evento            TO cod_evento;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN cd_origem_evento     TO ds_origem_evento;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN fk_cargo             TO cod_cargo;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN vlr_vencimentos      TO vl_vencimentos;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN vlr_descontos        TO vl_descontos;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN vlr_outros           TO vl_outros;
ALTER TABLE rh_sci.f_folha_salarial
    RENAME COLUMN ultima_atualizacao   TO updated_at;

-- Etapa 4: ajustar tipos (executar em janela de manutencao)
ALTER TABLE rh_sci.f_folha_salarial
    ALTER COLUMN dt_emissao          TYPE date    USING dt_emissao::date,
    ALTER COLUMN dt_admissao         TYPE date    USING dt_admissao::date,
    ALTER COLUMN nr_folha_referencia TYPE integer USING nr_folha_referencia::integer,
    ALTER COLUMN vl_vencimentos      TYPE numeric(15,2) USING vl_vencimentos::numeric(15,2),
    ALTER COLUMN vl_descontos        TYPE numeric(15,2) USING vl_descontos::numeric(15,2),
    ALTER COLUMN vl_outros           TYPE numeric(15,2) USING vl_outros::numeric(15,2);

-- Etapa 5: vlr_evento requer limpeza antes de converter (fazer no pipeline)
ALTER TABLE rh_sci.f_folha_salarial
    ADD COLUMN vl_evento numeric(15,2) NULL;
-- Preencher vl_evento via UPDATE com CASE/NULLIF apos limpeza no pipeline
-- Depois: DROP COLUMN vlr_evento (coordenar com DAG)

-- Etapa 6: indices
CREATE INDEX idx_f_folha_salarial_cod_colaborador     ON rh_sci.f_folha_salarial (cod_colaborador);
CREATE INDEX idx_f_folha_salarial_dt_emissao          ON rh_sci.f_folha_salarial (dt_emissao);
CREATE INDEX idx_f_folha_salarial_nr_folha_referencia ON rh_sci.f_folha_salarial (nr_folha_referencia);
CREATE INDEX idx_f_folha_salarial_cod_evento          ON rh_sci.f_folha_salarial (cod_evento);

-- Etapa 7: view de compatibilidade
CREATE OR REPLACE VIEW rh_sci.ffolha_salarial AS
    SELECT * FROM rh_sci.f_folha_salarial;
COMMENT ON VIEW rh_sci.ffolha_salarial IS
    'DEPRECATED 2026-05-05: usar f_folha_salarial. Sera removido em 2026-08-03.';
```

---

### rh_sci.fprov_bruto_colab

**Nome proposto:** `rh_sci.f_provento_bruto_colaborador`
**Tipo:** fato
**Status:** [CONFLITO]
**Descricao:** Registra proventos brutos por colaborador com granularidade mensal, incluindo tipo de evento, centro de custo e situacao. Estrutura identica a `rh.fprovento_lojas` (mesmas colunas `fk_funcionario`, `fk_cargo`, `cod_empresa`, `num_cadastro`, `ano`, `mes`, `tipo`, `val_evento`, `centro_custo`, `cod_ccusto`, `ultima_atualizacao`, `tiposituacao`, `descricaosituacao`), diferindo apenas por ausencia de `data_demissao` e `codeve` presentes em `rh.fprovento_lojas`. Consolidacao em tabela unica deve ser avaliada.
**Sistema de origem:** Employer/SCI

> **CONFLITO DETECTADO:** `rh_sci.fprov_bruto_colab` e `rh.fprovento_lojas` possuem estrutura essencialmente identica. Ambas registram proventos por colaborador com as mesmas colunas de granularidade (empresa, cadastro, ano, mes, tipo, evento, centro de custo, situacao). A diferenca e que `rh.fprovento_lojas` possui adicionalmente `data_demissao` e `codeve`. Recomenda-se investigar se sao cargas de populacoes distintas (rh_sci = todos os colaboradores; rh = apenas lojas) ou se ha duplicidade genuina de dados. Se for populacao distinta, manter separadas porem com nomes e tipos harmonizados. Se for duplicidade, consolidar em tabela unica no schema `rh_sci` ou `rh`.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| fk_funcionario | text NULL | cod_colaborador | varchar(20) NOT NULL | [RENAME] [RETYPE] | Business key; text sem limite e inadequado — varchar(20) apos validacao |
| fk_cargo | text NULL | cod_cargo | varchar(65) NULL | [RENAME] [RETYPE] | Business key do cargo; text -> varchar(65) |
| cod_empresa | numeric(4) NULL | id_empresa | smallint NOT NULL | [RENAME] [RETYPE] | Codigo operacional; numeric(4) -> smallint |
| num_cadastro | numeric(9) NULL | nr_cadastro | integer NULL | [RENAME] [RETYPE] | Numero de cadastro; numeric(9) -> integer |
| ano | int4 NULL | ano | smallint NOT NULL | [RETYPE] | Ano de competencia; smallint suficiente (valores ate 9999) |
| mes | int2 NULL | mes | smallint NOT NULL | [OK] | Mes de competencia; tipo adequado |
| tipo | text NULL | ds_tipo_provento | varchar(60) NULL | [RENAME] [RETYPE] | Descricao do tipo de provento; text -> varchar com limite |
| val_evento | numeric(38, 10) NULL | vl_evento | numeric(15,2) NULL | [RENAME] [RETYPE] | Valor monetario; numeric(38,10) e excessivo — padronizar para 15,2 |
| centro_custo | varchar(30) NULL | ds_centro_custo | varchar(30) NULL | [RENAME] | Prefixo `ds_` |
| cod_ccusto | int8 NULL | id_centro_custo | integer NULL | [RENAME] [RETYPE] | Codigo operacional de centro de custo; int8 -> integer |
| ultima_atualizacao | date NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [RENAME] [RETYPE] | Auditoria padrao; date -> timestamp |
| tiposituacao | int8 NULL | id_situacao | smallint NULL | [RENAME] [RETYPE] | Codigo operacional de situacao; int8 -> smallint; snake_case |
| descricaosituacao | varchar(40) NULL | ds_situacao | varchar(40) NULL | [RENAME] | Prefixo `ds_`; snake_case |
| _(ausente)_ | — | id | bigserial NOT NULL | [ADD] | Surrogate key obrigatoria |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [CONFLITO]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave de negocio (unicidade logica): `(cod_colaborador, id_empresa, ano, mes, ds_tipo_provento)`.

#### Relacionamentos propostos

```
rh_sci.f_provento_bruto_colaborador
  |- cod_colaborador -> rh.dfuncionario.pk_funcionario
  |- cod_cargo       -> rh.dcargo.pk_cargo
  |- id_empresa      -> rh.dempresa.pk_empresa
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_provento_bruto_cod_colaborador ON rh_sci.f_provento_bruto_colaborador (cod_colaborador);
CREATE INDEX idx_f_provento_bruto_ano_mes         ON rh_sci.f_provento_bruto_colaborador (ano, mes);
CREATE INDEX idx_f_provento_bruto_id_empresa      ON rh_sci.f_provento_bruto_colaborador (id_empresa);
CREATE INDEX idx_f_provento_bruto_id_situacao     ON rh_sci.f_provento_bruto_colaborador (id_situacao);
```

#### Impacto no ETL

- `val_evento numeric(38,10)` -> `vl_evento numeric(15,2)`: risco de truncamento se houver valores com mais de 13 digitos inteiros. Validar antes de converter.
- `fk_funcionario text` -> `cod_colaborador varchar(20)`: validar tamanho maximo real na origem.
- `ultima_atualizacao date` -> `updated_at timestamp`: completar com horario (usar `CURRENT_TIMESTAMP` na carga).
- Resolver o conflito com `rh.fprovento_lojas` antes de executar a migracao.
- Tabela `temporario.rh_sci_fprov_bruto_colab` e `temporario.rh_sci_fprov_bruto_colab_inc` existem como staging — coordenar limpeza.

#### Migracao SQL

```sql
-- ATENCAO: resolver conflito com rh.fprovento_lojas antes de executar

-- Etapa 1: renomear tabela
ALTER TABLE rh_sci.fprov_bruto_colab RENAME TO f_provento_bruto_colaborador;

-- Etapa 2: surrogate key e auditoria
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    ADD COLUMN id         bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 3: renomear colunas
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN fk_funcionario    TO cod_colaborador;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN fk_cargo          TO cod_cargo;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN cod_empresa       TO id_empresa;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN num_cadastro      TO nr_cadastro;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN tipo              TO ds_tipo_provento;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN val_evento        TO vl_evento;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN centro_custo      TO ds_centro_custo;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN cod_ccusto        TO id_centro_custo;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN tiposituacao      TO id_situacao;
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    RENAME COLUMN descricaosituacao TO ds_situacao;

-- Etapa 4: ajustar tipos
ALTER TABLE rh_sci.f_provento_bruto_colaborador
    ALTER COLUMN id_empresa      TYPE smallint USING id_empresa::smallint,
    ALTER COLUMN nr_cadastro     TYPE integer  USING nr_cadastro::integer,
    ALTER COLUMN ano             TYPE smallint USING ano::smallint,
    ALTER COLUMN vl_evento       TYPE numeric(15,2) USING vl_evento::numeric(15,2),
    ALTER COLUMN id_centro_custo TYPE integer  USING id_centro_custo::integer,
    ALTER COLUMN updated_at      TYPE timestamp USING updated_at::timestamp,
    ALTER COLUMN id_situacao     TYPE smallint USING id_situacao::smallint;

-- Etapa 5: indices
CREATE INDEX idx_f_provento_bruto_cod_colaborador ON rh_sci.f_provento_bruto_colaborador (cod_colaborador);
CREATE INDEX idx_f_provento_bruto_ano_mes         ON rh_sci.f_provento_bruto_colaborador (ano, mes);
CREATE INDEX idx_f_provento_bruto_id_empresa      ON rh_sci.f_provento_bruto_colaborador (id_empresa);
CREATE INDEX idx_f_provento_bruto_id_situacao     ON rh_sci.f_provento_bruto_colaborador (id_situacao);

-- Etapa 6: view de compatibilidade
CREATE OR REPLACE VIEW rh_sci.fprov_bruto_colab AS
    SELECT * FROM rh_sci.f_provento_bruto_colaborador;
COMMENT ON VIEW rh_sci.fprov_bruto_colab IS
    'DEPRECATED 2026-05-05: usar f_provento_bruto_colaborador. Sera removido em 2026-08-03.';
```

---

### rh_sci.fproventos_depto_employer

**Nome proposto:** `rh_sci.f_provento_departamento`
**Tipo:** fato
**Descricao:** Registra o total de proventos salariais agrupados por departamento e competencia mensal, com valores de salario base, salario nominal, total e quantidade de pessoas. Fonte de dados para relatorios de custo de pessoal por departamento.
**Sistema de origem:** Employer

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| id | serial4 NOT NULL | id | bigserial NOT NULL | [RETYPE] | Ja e surrogate key; converter de serial4 para bigserial para consistencia com padrao DW |
| data_competencia | date NULL | dt_competencia | date NOT NULL | [RENAME] | Prefixo `dt_`; NOT NULL em fato de competencia |
| id_empresa | int4 NULL | id_empresa | smallint NULL | [RETYPE] | Codigo operacional; int4 -> smallint |
| departamento | varchar(255) NULL | nm_departamento | varchar(255) NULL | [RENAME] | Prefixo `nm_` para nome de departamento |
| valor_salario_base | numeric(15, 2) NULL | vl_salario_base | numeric(15,2) NULL | [RENAME] | Prefixo `vl_`; tipo ja adequado |
| valor_salario_nominal | numeric(15, 2) NULL | vl_salario_nominal | numeric(15,2) NULL | [RENAME] | Prefixo `vl_`; tipo ja adequado |
| valor_total | numeric(15, 2) NULL | vl_total | numeric(15,2) NULL | [RENAME] | Prefixo `vl_`; tipo ja adequado |
| qtde_pessoas | int4 NULL | qt_pessoas | integer NULL | [RENAME] | Prefixo `qt_`; tipo adequado (integer) |
| ultima_atualizacao | timestamp NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [RENAME] | Auditoria padrao |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [OK]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY  -- ja existe como serial4; ampliar para bigserial
```

Chave de negocio (unicidade logica): `(dt_competencia, id_empresa, nm_departamento)`.

#### Relacionamentos propostos

```
rh_sci.f_provento_departamento
  |- id_empresa    -> rh.dempresa.pk_empresa
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_provento_depto_dt_competencia ON rh_sci.f_provento_departamento (dt_competencia);
CREATE INDEX idx_f_provento_depto_id_empresa     ON rh_sci.f_provento_departamento (id_empresa);
CREATE INDEX idx_f_provento_depto_nm_departamento ON rh_sci.f_provento_departamento (nm_departamento);
```

#### Impacto no ETL

- Esta tabela e a mais bem estruturada do schema: ja possui PK (`id`), tipos `numeric(15,2)` corretos e campo `ultima_atualizacao`.
- Renomeacao de colunas e a principal acao; sem conversao de tipos critica.
- `id serial4 -> bigserial`: requer re-criar a sequence ou usar `ALTER SEQUENCE`. Avaliar impacto em inserts existentes.

#### Migracao SQL

```sql
-- Etapa 1: renomear tabela
ALTER TABLE rh_sci.fproventos_depto_employer RENAME TO f_provento_departamento;

-- Etapa 2: auditoria
ALTER TABLE rh_sci.f_provento_departamento
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 3: renomear colunas
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN data_competencia   TO dt_competencia;
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN departamento       TO nm_departamento;
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN valor_salario_base TO vl_salario_base;
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN valor_salario_nominal TO vl_salario_nominal;
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN valor_total        TO vl_total;
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN qtde_pessoas       TO qt_pessoas;
ALTER TABLE rh_sci.f_provento_departamento
    RENAME COLUMN ultima_atualizacao TO updated_at;

-- Etapa 4: ajustar tipos
ALTER TABLE rh_sci.f_provento_departamento
    ALTER COLUMN id_empresa TYPE smallint USING id_empresa::smallint;

-- Etapa 5: ampliar sequence de serial4 para bigserial (sem perda de dados)
ALTER SEQUENCE rh_sci.fproventos_depto_employer_id_seq AS bigint;
ALTER TABLE rh_sci.f_provento_departamento
    ALTER COLUMN id TYPE bigint USING id::bigint;

-- Etapa 6: indices
CREATE INDEX idx_f_provento_depto_dt_competencia  ON rh_sci.f_provento_departamento (dt_competencia);
CREATE INDEX idx_f_provento_depto_id_empresa      ON rh_sci.f_provento_departamento (id_empresa);
CREATE INDEX idx_f_provento_depto_nm_departamento ON rh_sci.f_provento_departamento (nm_departamento);

-- Etapa 7: view de compatibilidade
CREATE OR REPLACE VIEW rh_sci.fproventos_depto_employer AS
    SELECT * FROM rh_sci.f_provento_departamento;
COMMENT ON VIEW rh_sci.fproventos_depto_employer IS
    'DEPRECATED 2026-05-05: usar f_provento_departamento. Sera removido em 2026-08-03.';
```

---

### rh_sci.freajuste

**Nome proposto:** `rh_sci.f_reajuste`
**Tipo:** fato
**Status:** [CONFLITO]
**Descricao:** Registra os eventos de reajuste salarial dos colaboradores, contendo salario anterior, novo salario, percentual de reajuste, motivo e filial. Cada linha representa um evento de alteracao salarial. Estrutura identica a `rh.freajuste` — as duas tabelas possuem exatamente as mesmas colunas com os mesmos tipos e nomes.
**Sistema de origem:** Employer/SCI

> **CONFLITO CRITICO:** `rh_sci.freajuste` e `rh.freajuste` sao estruturalmente identicas (mesmas 11 colunas, mesmos tipos, mesmos nomes). Isto indica carga duplicada do mesmo sistema de origem para dois schemas diferentes, ou uma e subset da outra. Antes de qualquer migracao, e obrigatorio:
> 1. Verificar se os dados sao identicos (COUNT e checksum).
> 2. Se identicos: eliminar uma das tabelas e manter apenas uma (preferencialmente em `rh_sci`, onde o sistema de origem e mais especifico).
> 3. Se distintos: documentar a regra de negocio que justifica a separacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| fk_funcionario | varchar(122) NULL | cod_colaborador | varchar(20) NOT NULL | [RENAME] [RETYPE] | Business key; varchar(122) e excessivo — validar tamanho real |
| fk_empresa | varchar(6) NULL | id_empresa | smallint NOT NULL | [RENAME] [RETYPE] | Codigo operacional; varchar -> smallint |
| dt_alteracao | timestamp NULL | dth_alteracao | timestamp NOT NULL | [RENAME] | Prefixo `dth_` para data+hora |
| vlr_salario | numeric(18, 3) NULL | vl_salario | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| pr_reajuste | numeric(13, 5) NULL | pc_reajuste | numeric(7,4) NULL | [RENAME] [RETYPE] | Prefixo `pc_` para percentual; precisao 7,4 |
| cd_seq_alteracao | varchar(7) NULL | nr_sequencia_alteracao | varchar(7) NULL | [RENAME] | Prefixo `nr_`; manter varchar pois pode ter zeros a esquerda |
| fk_motivo_alteracao | varchar(7) NULL | cod_motivo_alteracao | varchar(7) NULL | [RENAME] | Business key de motivo; prefixo `cod_` |
| cd_tipo_salario | varchar(7) NULL | id_tipo_salario | varchar(7) NULL | [RENAME] | Codigo operacional; prefixo `id_` |
| vlr_salario_anterior | numeric(18, 3) NULL | vl_salario_anterior | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; precisao 15,2 |
| fk_filial | varchar(30) NULL | cod_filial | varchar(30) NULL | [RENAME] | Business key de filial; prefixo `cod_` |
| ultima_atualizacao | date NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [RENAME] [RETYPE] | Auditoria padrao; date -> timestamp |
| _(ausente)_ | — | id | bigserial NOT NULL | [ADD] | Surrogate key obrigatoria |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [CONFLITO]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave de negocio (unicidade logica): `(cod_colaborador, id_empresa, dth_alteracao, nr_sequencia_alteracao)`.

#### Relacionamentos propostos

```
rh_sci.f_reajuste
  |- cod_colaborador     -> rh.dfuncionario.pk_funcionario
  |- cod_motivo_alteracao -> rh.dmotivo_reajuste.pk_motivo_alteracao
  |- cod_filial          -> rh.dfilial.pk_filial
  |- id_empresa          -> rh.dempresa.pk_empresa
```

#### Indices recomendados

```sql
CREATE INDEX idx_f_reajuste_cod_colaborador ON rh_sci.f_reajuste (cod_colaborador);
CREATE INDEX idx_f_reajuste_dth_alteracao   ON rh_sci.f_reajuste (dth_alteracao);
CREATE INDEX idx_f_reajuste_id_empresa      ON rh_sci.f_reajuste (id_empresa);
```

#### Impacto no ETL

- Resolver conflito com `rh.freajuste` e prioridade maxima antes de qualquer migracao.
- `fk_empresa varchar(6) -> id_empresa smallint`: validar conversao numerica.
- `ultima_atualizacao date -> updated_at timestamp`: completar com horario na carga.
- Tabela `temporario.rh_sci_freajuste` existe como staging — coordenar limpeza.

#### Migracao SQL

```sql
-- ATENCAO: resolver conflito com rh.freajuste antes de executar
-- Query de auditoria sugerida:
-- SELECT COUNT(*) FROM rh_sci.freajuste
-- EXCEPT
-- SELECT COUNT(*) FROM rh.freajuste;

-- Etapa 1: renomear tabela
ALTER TABLE rh_sci.freajuste RENAME TO f_reajuste;

-- Etapa 2: surrogate key e auditoria
ALTER TABLE rh_sci.f_reajuste
    ADD COLUMN id         bigserial PRIMARY KEY,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 3: renomear colunas
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN fk_funcionario       TO cod_colaborador;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN fk_empresa           TO id_empresa;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN dt_alteracao         TO dth_alteracao;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN vlr_salario          TO vl_salario;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN pr_reajuste          TO pc_reajuste;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN cd_seq_alteracao     TO nr_sequencia_alteracao;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN fk_motivo_alteracao  TO cod_motivo_alteracao;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN cd_tipo_salario      TO id_tipo_salario;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN vlr_salario_anterior TO vl_salario_anterior;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN fk_filial            TO cod_filial;
ALTER TABLE rh_sci.f_reajuste
    RENAME COLUMN ultima_atualizacao   TO updated_at;

-- Etapa 4: ajustar tipos
ALTER TABLE rh_sci.f_reajuste
    ALTER COLUMN vl_salario          TYPE numeric(15,2) USING vl_salario::numeric(15,2),
    ALTER COLUMN pc_reajuste         TYPE numeric(7,4)  USING pc_reajuste::numeric(7,4),
    ALTER COLUMN vl_salario_anterior TYPE numeric(15,2) USING vl_salario_anterior::numeric(15,2),
    ALTER COLUMN updated_at          TYPE timestamp     USING updated_at::timestamp;

-- Etapa 5: indices
CREATE INDEX idx_f_reajuste_cod_colaborador ON rh_sci.f_reajuste (cod_colaborador);
CREATE INDEX idx_f_reajuste_dth_alteracao   ON rh_sci.f_reajuste (dth_alteracao);
CREATE INDEX idx_f_reajuste_id_empresa      ON rh_sci.f_reajuste (id_empresa);

-- Etapa 6: view de compatibilidade
CREATE OR REPLACE VIEW rh_sci.freajuste AS
    SELECT * FROM rh_sci.f_reajuste;
COMMENT ON VIEW rh_sci.freajuste IS
    'DEPRECATED 2026-05-05: usar f_reajuste. Sera removido em 2026-08-03.';
```

---

### rh_sci.fsalario_employer

**Nome proposto:** `rh_sci.f_salario_employer`
**Tipo:** fato
**Descricao:** Registra o salario vigente por contrato e departamento no sistema Employer. Cada linha representa um contrato de trabalho com seu respectivo departamento e salario atual. Funciona como snapshot do salario corrente (sem historico de alteracoes — para historico ver `f_historico_salario`).
**Sistema de origem:** Employer

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| id | int4 NULL | id | bigserial NOT NULL | [RETYPE] | Ja e identificador; mas e nullable (`int4 NULL`) e sem constraint — declarar como surrogate key `bigserial PRIMARY KEY` |
| cod_contrato | varchar(30) NULL | cod_contrato | varchar(30) NOT NULL | [OK] | Business key ja conforme padrao `cod_`; adicionar NOT NULL |
| contrato | varchar(50) NULL | nm_contrato | varchar(50) NULL | [RENAME] | Prefixo `nm_` para nome do contrato |
| id_departamento | int4 NULL | id_departamento | smallint NULL | [RETYPE] | Codigo operacional; int4 -> smallint |
| departamento | varchar(50) NULL | nm_departamento | varchar(50) NULL | [RENAME] | Prefixo `nm_` |
| salario | numeric NULL | vl_salario | numeric(15,2) NULL | [RENAME] [RETYPE] | Prefixo `vl_`; especificar precisao (numeric sem escala e impreciso) |
| updated_at | timestamp DEFAULT CURRENT_TIMESTAMP NULL | updated_at | timestamp NOT NULL DEFAULT current_timestamp | [OK] | Ja conforme padrao; adicionar NOT NULL |
| _(ausente)_ | — | created_at | timestamp NOT NULL DEFAULT current_timestamp | [ADD] | Auditoria obrigatoria |

**Flags:** [RENAME] [RETYPE] [ADD] [OK]

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY
```

Chave de negocio (unicidade logica): `cod_contrato UNIQUE NOT NULL`.

> **Observacao:** Se a tabela for um snapshot do contrato vigente (SCD Tipo 1), `cod_contrato` deve ter constraint UNIQUE. Se puder haver multiplos registros por contrato (ex.: historico de departamentos), a unicidade muda — validar com o time de negocio.

#### Relacionamentos propostos

```
rh_sci.f_salario_employer
  |- cod_contrato    -> rh.fficha_empregados (matricula — verificar join key adequada)
  |- id_departamento -> rh.fdepartamento_employer.id_departamento
```

#### Indices recomendados

```sql
CREATE UNIQUE INDEX idx_f_salario_employer_cod_contrato ON rh_sci.f_salario_employer (cod_contrato);
CREATE INDEX idx_f_salario_employer_id_departamento     ON rh_sci.f_salario_employer (id_departamento);
```

#### Impacto no ETL

- `id int4 NULL` sem PK: risco de duplicidade na carga atual. Validar antes de adicionar PK.
- `salario numeric` (sem precisao): verificar se ha valores com mais de 2 casas decimais na origem antes de converter para `numeric(15,2)`.
- Esta tabela ja possui `updated_at` com DEFAULT — e a mais avancada em conformidade com o padrao.

#### Migracao SQL

```sql
-- Etapa 1: renomear tabela
ALTER TABLE rh_sci.fsalario_employer RENAME TO f_salario_employer;

-- Etapa 2: verificar duplicidade de id antes de adicionar PK
-- SELECT id, COUNT(*) FROM rh_sci.f_salario_employer GROUP BY id HAVING COUNT(*) > 1;

-- Etapa 3: transformar id em surrogate key
ALTER TABLE rh_sci.f_salario_employer
    ALTER COLUMN id SET NOT NULL;
ALTER TABLE rh_sci.f_salario_employer
    ALTER COLUMN id TYPE bigint USING id::bigint;
-- Criar sequence se nao existir:
CREATE SEQUENCE IF NOT EXISTS rh_sci.f_salario_employer_id_seq;
ALTER TABLE rh_sci.f_salario_employer
    ALTER COLUMN id SET DEFAULT nextval('rh_sci.f_salario_employer_id_seq');
ALTER SEQUENCE rh_sci.f_salario_employer_id_seq OWNED BY rh_sci.f_salario_employer.id;
ALTER TABLE rh_sci.f_salario_employer
    ADD CONSTRAINT f_salario_employer_pkey PRIMARY KEY (id);

-- Etapa 4: auditoria
ALTER TABLE rh_sci.f_salario_employer
    ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- Etapa 5: renomear colunas
ALTER TABLE rh_sci.f_salario_employer
    RENAME COLUMN contrato     TO nm_contrato;
ALTER TABLE rh_sci.f_salario_employer
    RENAME COLUMN departamento TO nm_departamento;
ALTER TABLE rh_sci.f_salario_employer
    RENAME COLUMN salario      TO vl_salario;

-- Etapa 6: ajustar tipos
ALTER TABLE rh_sci.f_salario_employer
    ALTER COLUMN id_departamento TYPE smallint     USING id_departamento::smallint,
    ALTER COLUMN vl_salario      TYPE numeric(15,2) USING vl_salario::numeric(15,2);

-- Etapa 7: NOT NULL em colunas obrigatorias
ALTER TABLE rh_sci.f_salario_employer
    ALTER COLUMN cod_contrato SET NOT NULL,
    ALTER COLUMN updated_at   SET NOT NULL;

-- Etapa 8: indices
CREATE UNIQUE INDEX idx_f_salario_employer_cod_contrato ON rh_sci.f_salario_employer (cod_contrato);
CREATE INDEX idx_f_salario_employer_id_departamento     ON rh_sci.f_salario_employer (id_departamento);

-- Etapa 9: view de compatibilidade
CREATE OR REPLACE VIEW rh_sci.fsalario_employer AS
    SELECT * FROM rh_sci.f_salario_employer;
COMMENT ON VIEW rh_sci.fsalario_employer IS
    'DEPRECATED 2026-05-05: usar f_salario_employer. Sera removido em 2026-08-03.';
```

---

## Consolidacao de Conflitos

### Conflito 1 — rh_sci.freajuste x rh.freajuste

| Aspecto | rh_sci.freajuste | rh.freajuste |
|---|---|---|
| Colunas | 11 | 11 |
| Estrutura | Identica | Identica |
| Tipos | Identicos | Identicos |
| Origem provavel | Employer/SCI | Employer/SCI |

**Acao recomendada:** Auditar dados. Se identicos, deprecar `rh.freajuste` e manter apenas `rh_sci.f_reajuste` como fonte unica. Criar view `rh.freajuste` apontando para `rh_sci.f_reajuste` durante o periodo de transicao.

```sql
-- Auditoria de diferenca de dados
SELECT 'rh_sci' AS origem, COUNT(*) FROM rh_sci.freajuste
UNION ALL
SELECT 'rh', COUNT(*) FROM rh.freajuste;

-- Verificar registros exclusivos de rh_sci
SELECT * FROM rh_sci.freajuste
EXCEPT
SELECT * FROM rh.freajuste;

-- Verificar registros exclusivos de rh
SELECT * FROM rh.freajuste
EXCEPT
SELECT * FROM rh_sci.freajuste;
```

### Conflito 2 — rh_sci.fprov_bruto_colab x rh.fprovento_lojas

| Aspecto | rh_sci.fprov_bruto_colab | rh.fprovento_lojas |
|---|---|---|
| Colunas comuns | 13 | 13 de 15 |
| Colunas extras em rh | — | data_demissao, codeve |
| Populacao | Todos os colaboradores (suspeita) | Colaboradores de lojas (suspeita) |

**Acao recomendada:** Verificar se a populacao e distinta por segmento (lojas vs. matriz/fabrica). Se sim, manter separadas e harmonizar nomes/tipos entre os dois schemas. Se a populacao se sobrepoem, consolidar em tabela unica com coluna `ds_segmento` distinguindo a origem.

---

## Pendencias e Acoes Prioritarias

| Prioridade | Acao | Tabela | Responsavel |
|---|---|---|---|
| 1 | Auditar dados duplicados | rh_sci.freajuste x rh.freajuste | Engenharia de Dados |
| 2 | Auditar dados duplicados | rh_sci.fprov_bruto_colab x rh.fprovento_lojas | Engenharia de Dados |
| 3 | Converter vlr_evento (varchar->numeric) | rh_sci.ffolha_salarial | Pipeline ETL |
| 4 | Converter qt_area_m2 (varchar->numeric) | rh_sci.fcontratos_lecom | Pipeline ETL |
| 5 | Validar tamanho real de fk_funcionario | Todas as tabelas | Analise de origem |
| 6 | Adicionar created_at em todas as tabelas | Todas | Migracao DDL |
| 7 | Adicionar surrogate keys (id bigserial) | Todas (exceto fproventos_depto_employer) | Migracao DDL |
| 8 | Limpar staging temporario.rh_sci_* | temporario | Engenharia de Dados |
