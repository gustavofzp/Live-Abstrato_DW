# Dicionario de Dados — Schema `rh`

**Versao:** 1.0
**Data:** 2026-05-05
**Status:** Rascunho — aguarda revisao do time de dados
**Escopo:** 57 tabelas — RH: funcionarios, cargos, holerites, ponto, afastamentos, banco de horas, eSocial
**Responsavel:** Schema rh — dados de Recursos Humanos provenientes do sistema Senior: cadastro de colaboradores, controle de ponto, folha de pagamento, afastamentos e banco de horas. Inclui dados do sistema Employer (terceirizados).

---

## Contexto do Schema

O schema `rh` tem duas origens de dados:
1. **Senior RH** (sistema principal): Tabelas com nomes crípticos em portugues abreviado (ex: `cd_num_emp`, `vlr_hor`). Business key principal e `cod_colaborador` = `cd_num_emp::varchar + '-' + cd_tip_col::varchar + '-' + cd_num_col::varchar` ou simplificado.
2. **Employer** (plataforma terceirizada): Tabelas com nomes modernos em ingles/portugues (`id`, `id_empregado`, `data_admissao`).

A coluna `fk_colaborador` (varchar composta como `'empresa-tipo-cadastro'`) e o identificador de colaborador no Senior. Para o DW, o business key canonico deve ser `cod_colaborador varchar(20)` derivado desse composto.

---

## Sumario

| Tabela atual | Nome proposto | Tipo |
|---|---|---|
| `rh.dbanco_horas` | `rh.d_banco_horas` | dimensao |
| `rh.dcargo` | `rh.d_cargo` | dimensao |
| `rh.dcausa_demissao` | `rh.d_causa_demissao` | dimensao |
| `rh.dcodigo_calculo` | `rh.d_codigo_calculo` | dimensao |
| `rh.ddependente` | `rh.d_dependente` | dimensao |
| `rh.dempresa` | `rh.d_empresa_rh` | dimensao |
| `rh.dempresa_employer` | `rh.d_empresa_employer` | dimensao |
| `rh.descala` | `rh.d_escala` | dimensao |
| `rh.devento` | `rh.d_evento_rh` | dimensao |
| `rh.deventos_rh` | `rh.d_evento_rh_flag` | dimensao |
| `rh.dfilial` | `rh.d_filial` | dimensao |
| `rh.dfuncionario` | `rh.d_colaborador` | dimensao |
| `rh.dfuncionario_historico` | `rh.d_colaborador_historico` | dimensao |
| `rh.dgrau_instrucao` | `rh.d_grau_instrucao` | dimensao |
| `rh.dlocal_organograma` | `rh.d_local_organograma` | dimensao |
| `rh.dlocalizacao` | `rh.d_localizacao` | dimensao |
| `rh.dmotivo` | `rh.d_motivo_rh` | dimensao |
| `rh.dmotivo_reajuste` | `rh.d_motivo_reajuste` | dimensao |
| `rh.dsituacao` | `rh.d_situacao_rh` | dimensao |
| `rh.dstg_evento` | `rh.stg_evento_rh` | staging |
| `rh.dstg_evento_stage` | `rh.stg_evento_rh_stage` | staging |
| `rh.dusuario_antigo` | `rh.d_usuario_antigo` | dimensao |
| `rh.dusuario_colaborador` | `rh.d_usuario_colaborador` | dimensao |
| `rh.fabsenteismo` | `rh.f_absenteismo` | fato |
| `rh.facesso_sistema` | `rh.f_acesso_sistema` | fato |
| `rh.fafastamento` | `rh.f_afastamento` | fato |
| `rh.fafastamentos` | `rh.f_afastamento_senior` | fato |
| `rh.fafastamentos_employer` | `rh.f_afastamento_employer` | fato |
| `rh.fapuracao` | `rh.f_apuracao` | fato |
| `rh.fapuracao_col_situacao` | `rh.f_apuracao_situacao` | fato |
| `rh.fatestado` | `rh.f_atestado` | fato |
| `rh.fbanco_horas` | `rh.f_banco_horas` | fato |
| `rh.fdemissao` | `rh.f_demissao` | fato |
| `rh.fdepartamento_employer` | `rh.f_departamento_employer` | fato |
| `rh.fdre_lojas` | `rh.f_dre_loja` | fato |
| `rh.fesocial` | `rh.f_esocial` | fato |
| `rh.fesocial_intervalo` | `rh.f_esocial_intervalo` | fato |
| `rh.fferias` | `rh.f_ferias` | fato |
| `rh.fficha_empregados` | `rh.f_ficha_empregado` | fato |
| `rh.fficha_financeira` | `rh.f_ficha_financeira` | fato |
| `rh.fhistorico` | `rh.f_historico_colaborador` | fato |
| `rh.fholerite` | `rh.f_holerite` | fato |
| `rh.fhoras_trabalhadas` | `rh.f_horas_trabalhadas` | fato |
| `rh.flancamento_hora` | `rh.f_lancamento_hora` | fato |
| `rh.flog_alteracoes_ponto` | `rh.f_log_alteracao_ponto` | fato |
| `rh.fmarcacao_horario` | `rh.f_marcacao_horario` | fato |
| `rh.fmarcacoes` | `rh.f_marcacao` | fato |
| `rh.fmarcacoes_formato_live` | `rh.f_marcacao_live` | fato |
| `rh.fponto_detalhado` | `rh.f_ponto_detalhado` | fato |
| `rh.fponto_sintetico` | `rh.f_ponto_sintetico` | fato |
| `rh.fprovento_lojas` | `rh.f_provento_loja` | fato |
| `rh.freajuste` | `rh.f_reajuste` | fato |
| `rh.fregistro_acesso` | `rh.f_registro_acesso` | fato |
| `rh.fsaldo_banco_horas` | `rh.f_saldo_banco_horas` | fato |
| `rh.fsaldo_hora_extra` | `rh.f_saldo_hora_extra` | fato |
| `rh.fstg_historico` | `rh.stg_historico_colaborador` | staging |
| `rh.ftotalizador_horas` | `rh.f_totalizador_horas` | fato |

---

## Chave de Nomenclatura — Senior RH

O sistema Senior usa abreviacoes de 3-4 letras para seus campos. Mapeamento das mais comuns:

| Abreviacao | Significado | Novo nome padrao |
|---|---|---|
| `cd_num_emp` | Codigo da empresa | `id_empresa` |
| `cd_tip_col` | Tipo de colaborador | `id_tipo_colaborador` |
| `cd_num_col / cd_num_cad` | Numero de cadastro | `nr_cadastro` |
| `fk_colaborador` | Chave composta col. | `cod_colaborador` (simplificar) |
| `cd_fil / codfil / cd_filial` | Filial | `id_filial` |
| `vlr_hor` | Valor hora | `vl_hora` |
| `qtd_hor` | Quantidade hora | `qt_horas` |
| `dt_cmp / dt_compe` | Competencia | `dt_competencia` |
| `fg_ / fl_` | Flag | `fl_` |
| `dthora_atualizacao` | Data/hora atualizacao | `updated_at` |
| `pk_funcionario` | Chave composta func. | `cod_colaborador` (derivado) |
| `cd_nom_fun` | Nome funcionario | `nm_colaborador` |
| `cd_sit_afa` | Situacao afastamento | `id_situacao_afastamento` |

---

## Detalhamento por Tabela

---

### rh.dfuncionario

**Nome proposto:** `rh.d_colaborador`
**Tipo:** dimensao
**Descricao:** Dimensao principal de colaboradores com dados cadastrais, cargo, filial, admissao/demissao e situacao atual.
**Sistema de origem:** Senior RH

> `pk_funcionario` e uma chave composta (empresa+tipo+cadastro) como varchar(122). O business key canonico para o DW deve ser `cod_colaborador` derivado do campo `cd_funcionario` (sequencial numerico do funcionario).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cd_funcionario` | `varchar(9) NULL` | `cod_colaborador` | `varchar(20) NOT NULL` | [RENAME] [RETYPE] | **Business key** — codigo do colaborador; join key universal |
| `pk_funcionario` | `varchar(122) NULL` | `cod_colaborador_composto` | `varchar(122)` | [RENAME] | Chave composta legado — manter para referencia |
| `pk_funcionario_filial` | `varchar(163) NULL` | `cod_colaborador_filial` | `varchar(163)` | [RENAME] | Chave composta com filial |
| `nm_funcionario` | `varchar(40) NULL` | `nm_colaborador` | `varchar(40)` | [RENAME] | Nome |
| `cpf` | `varchar(11) NULL` | `cpf_colaborador` | `varchar(12)` | [RENAME] [RETYPE] | CPF formato `XXXXXXXXX-ZZ` |
| `cd_empresa` | `varchar(4) NULL` | `id_empresa` | `varchar(4)` | [RENAME] | Empresa |
| `cd_empresa_filial` | `varchar(81) NULL` | `cod_empresa_filial` | `varchar(81)` | [RENAME] | Empresa+filial composto |
| `cd_cargo` | `varchar(65) NULL` | `cod_cargo` | `varchar(30)` | [RENAME] [RETYPE] | Cargo; limitar |
| `nm_local` | `varchar(60) NULL` | `ds_local` | `varchar(60)` | [RENAME] | Local de trabalho |
| `dt_nascimento` | `timestamp NULL` | `dt_nascimento` | `date` | [RETYPE] | Data nascimento |
| `dt_admissao` | `timestamp NULL` | `dt_admissao` | `date` | [RETYPE] | Admissao |
| `fg_deficiente` | `varchar(1) NULL` | `fl_deficiente` | `boolean` | [RENAME] [RETYPE] | Deficiencia |
| `sexo` | `varchar(9) NULL` | `ds_sexo` | `varchar(9)` | [RENAME] | Sexo |
| `cd_tipo_funcionario` | `varchar(1) NULL` | `ds_tipo_colaborador` | `varchar(1)` | [RENAME] | Tipo |
| `cd_tipo_contrato` | `varchar(2) NULL` | `ds_tipo_contrato` | `varchar(2)` | [RENAME] | Tipo contrato |
| `endereco` | `varchar(100) NULL` | `end_logradouro` | `varchar(100)` | [RENAME] | Logradouro |
| `nr_cep` | `varchar(8) NULL` | `end_cep` | `char(8)` | [RENAME] [RETYPE] | CEP |
| `nr_telefone` | `varchar(20) NULL` | `nr_telefone` | `varchar(20)` | OK | Telefone |
| `nm_cidade` | `varchar(30) NULL` | `end_cidade` | `varchar(40)` | [RENAME] [RETYPE] | Cidade |
| `uf` | `varchar(2) NULL` | `end_uf` | `char(2)` | [RENAME] [RETYPE] | UF |
| `nm_bairro` | `varchar(40) NULL` | `end_bairro` | `varchar(40)` | [RENAME] | Bairro |
| `ds_tipo_contrato` | `varchar(32) NULL` | `ds_tipo_contrato_desc` | `varchar(32)` | [RENAME] | Descricao tipo contrato |
| `dt_afastamento_original` | `timestamp NULL` | `dt_afastamento` | `date` | [RENAME] [RETYPE] | Data afastamento |
| `faixa_etaria` | `varchar(12) NULL` | `ds_faixa_etaria` | `varchar(12)` | [RENAME] | Faixa etaria |
| `ds_situacao` | `varchar(30) NULL` | `ds_situacao` | `varchar(30)` | OK | Situacao |
| `cargo_atual` | `varchar(60) NULL` | `ds_cargo_atual` | `varchar(60)` | [RENAME] | Cargo atual por extenso |
| `nm_filial_atual` | `varchar(40) NULL` | `ds_filial_atual` | `varchar(40)` | [RENAME] | Filial atual |
| `dt_demissao` | `varchar(50) NULL` | `dt_demissao` | `date` | [RETYPE] | Converter varchar para date |
| `ds_causa_demissao` | `varchar(30) NULL` | `ds_causa_demissao` | `varchar(30)` | OK | Causa demissao |
| `ds_motivo_demissao` | `varchar(40) NULL` | `ds_motivo_demissao` | `varchar(40)` | OK | Motivo |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| `centrocusto` | `varchar(150) NULL` | `ds_centro_custo` | `varchar(150)` | [RENAME] | Centro de custo por extenso |
| `turno` | `varchar(15) NULL` | `ds_turno` | `varchar(15)` | [RENAME] | Turno |
| `cd_causa_demissao` | `varchar(30) NULL` | `id_causa_demissao` | `varchar(30)` | [RENAME] | Codigo causa |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

#### Chave primaria proposta

```sql
id bigserial PRIMARY KEY,
CONSTRAINT uq_d_colaborador UNIQUE (cod_colaborador)
```

#### Impacto no ETL

- `dt_demissao` esta como `varchar(50)` — o ETL deve converter para `date`.
- O `cpf_colaborador` deve ser formatado como `XXXXXXXXX-ZZ`.
- `cod_colaborador` deve ser derivado de `cd_funcionario` com LPAD para padrao `varchar(20)`.

#### Migracao SQL (principais)

```sql
ALTER TABLE rh.dfuncionario RENAME TO d_colaborador;
ALTER TABLE rh.d_colaborador ADD COLUMN id bigserial PRIMARY KEY;
ALTER TABLE rh.d_colaborador ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;
ALTER TABLE rh.d_colaborador RENAME COLUMN cd_funcionario TO cod_colaborador;
ALTER TABLE rh.d_colaborador ALTER COLUMN cod_colaborador TYPE varchar(20);
ALTER TABLE rh.d_colaborador ADD CONSTRAINT uq_d_colaborador UNIQUE (cod_colaborador);
ALTER TABLE rh.d_colaborador RENAME COLUMN pk_funcionario TO cod_colaborador_composto;
ALTER TABLE rh.d_colaborador RENAME COLUMN nm_funcionario TO nm_colaborador;
-- Converter dt_demissao de varchar para date:
ALTER TABLE rh.d_colaborador ADD COLUMN dt_demissao_dt date;
UPDATE rh.d_colaborador SET dt_demissao_dt = NULLIF(dt_demissao, '')::date WHERE dt_demissao ~ '^\d{4}-\d{2}-\d{2}';
ALTER TABLE rh.d_colaborador DROP COLUMN dt_demissao;
ALTER TABLE rh.d_colaborador RENAME COLUMN dt_demissao_dt TO dt_demissao;
ALTER TABLE rh.d_colaborador RENAME COLUMN ultima_atualizacao TO updated_at;
ALTER TABLE rh.d_colaborador ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE rh.d_colaborador ALTER COLUMN updated_at SET DEFAULT current_timestamp;
CREATE OR REPLACE VIEW rh.dfuncionario AS SELECT * FROM rh.d_colaborador;
COMMENT ON VIEW rh.dfuncionario IS 'DEPRECATED 2026-05-05: usar d_colaborador. Sera removido em 2026-08-03.';
```

---

### rh.dfuncionario_historico

**Nome proposto:** `rh.d_colaborador_historico`
**Tipo:** dimensao (SCD Tipo 2)
**Descricao:** Historico de mudancas do colaborador (transferencias, readmissoes). Estrutura identica a `d_colaborador` com campos adicionais de historico.

Campos adicionais em relacao a `d_colaborador`:
- `dt_nova_admissao timestamp NULL` → `dt_nova_admissao date`
- `fl_transferencia text NULL` → `fl_transferencia boolean`
- `nm_filial_anterior text NULL` → `ds_filial_anterior varchar(40)`

Segue as mesmas regras de renomeacao de `d_colaborador`.

---

### rh.dcargo

**Nome proposto:** `rh.d_cargo`
**Tipo:** dimensao
**Descricao:** Cargos/funcoes com codigo, titulo e situacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_cargo` | `varchar(30) NULL` | `cod_cargo` | `varchar(30) NOT NULL` | [RENAME] | Business key |
| `desc_cargo` | `varchar(125) NULL` | `ds_cargo` | `varchar(125)` | [RENAME] | Descricao completa |
| `desc_cargo_resum` | `varchar(60) NULL` | `ds_cargo_resumido` | `varchar(60)` | [RENAME] | Descricao curta |
| `cd_cargo` | `varchar(30) NULL` | `ds_cod_cargo` | `varchar(30)` | [RENAME] | Codigo/sigla |
| `cd_est_cargo` | `int4 NULL` | `id_situacao_cargo` | `integer` | [RENAME] | Situacao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.dcausa_demissao

**Nome proposto:** `rh.d_causa_demissao`
**Tipo:** dimensao
**Descricao:** Causas de demissao (CAGED/eSocial).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_causa_demissao` | `int2 NULL` | `id_causa_demissao` | `smallint NOT NULL` | [RENAME] | Business key |
| `desc_dem` | `varchar(50) NULL` | `ds_causa_demissao` | `varchar(50)` | [RENAME] | Descricao |
| `cd_cau_rai` | `int2 NULL` | `id_causa_rai` | `smallint` | [RENAME] | Codigo RAI (eSocial) |
| `cd_cag` | `int2 NULL` | `id_cag` | `smallint` | [RENAME] | Codigo CAG |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.dcodigo_calculo

**Nome proposto:** `rh.d_codigo_calculo`
**Tipo:** dimensao
**Descricao:** Codigos de calculo de folha (holerites, ferias, 13o, rescisao) com competencias e datas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_codigo_calculado` | `varchar(60) NULL` | `cod_codigo_calculo` | `varchar(60) NOT NULL` | [RENAME] | Business key |
| `cd_cal` | `int4 NULL` | `id_calculo` | `integer` | [RENAME] | Codigo do calculo |
| `cd_tip_cal` | `int2 NULL` | `id_tipo_calculo` | `smallint` | [RENAME] | Tipo (folha normal, ferias, 13o) |
| `cd_sit_cal` | `varchar(1) NULL` | `ds_situacao_calculo` | `varchar(1)` | [RENAME] | Situacao |
| `dt_per_ref` | `timestamp NULL` | `dt_referencia` | `date` | [RENAME] [RETYPE] | Competencia de referencia |
| `dt_pag` | `timestamp NULL` | `dt_pagamento` | `date` | [RENAME] [RETYPE] | Data pagamento |
| `dt_ini_cmp` | `timestamp NULL` | `dt_inicio_competencia` | `date` | [RENAME] [RETYPE] | Inicio competencia |
| `dt_fim_cmp` | `timestamp NULL` | `dt_fim_competencia` | `date` | [RENAME] [RETYPE] | Fim competencia |
| `dt_ani_apu` | `timestamp NULL` | `dt_inicio_apuracao` | `date` | [RENAME] [RETYPE] | Inicio apuracao |
| `dt_fim_apu` | `timestamp NULL` | `dt_fim_apuracao` | `date` | [RENAME] [RETYPE] | Fim apuracao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.ddependente

**Nome proposto:** `rh.d_dependente`
**Tipo:** dimensao
**Descricao:** Dependentes dos colaboradores com grau de parentesco, tipo e dados pessoais.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto | Justificativa |
|---|---|---|---|
| ADD | `id` | `bigserial NOT NULL` | Surrogate key |
| `pk_depedente` | `cod_dependente` | `varchar(170)` | Chave composta legado |
| `cd_pes` | `id_pessoa` | `integer` | Codigo da pessoa (colaborador) |
| `cd_dep` | `nr_sequencia_dependente` | `smallint` | Sequencia |
| `cd_nome_dep` | `nm_dependente` | `varchar(70)` | Nome |
| `cd_nome_mae` | `nm_mae` | `varchar(70)` | Mae |
| `cd_gra_par` | `id_grau_parentesco` | `smallint` | Grau parentesco |
| `cd_tip_dep` | `id_tipo_dependente` | `smallint` | Tipo |
| `cd_tip_sex` | `ds_sexo` | `varchar(2)` | Sexo |
| `cd_est_civ` | `id_estado_civil` | `smallint` | Estado civil |
| `cd_gra_ins` | `id_grau_instrucao` | `smallint` | Grau instrucao |
| `dt_nas` | `dt_nascimento` | `date` | Nascimento |
| `dt_obi` | `dt_obito` | `date` | Obito |
| `dthora_atualizacao` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### rh.dempresa

**Nome proposto:** `rh.d_empresa_rh`
**Tipo:** dimensao
**Descricao:** Empresas do grupo no contexto RH (Senior).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_empresa` | `int4 NULL` | `id_empresa` | `integer NOT NULL` | [RENAME] | Business key |
| `desc_empresa` | `varchar(60) NULL` | `ds_empresa` | `varchar(60)` | [RENAME] | Descricao |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.dempresa_employer

**Nome proposto:** `rh.d_empresa_employer`
**Tipo:** dimensao
**Descricao:** Empresas no sistema Employer (terceirizados) com CNPJ, grupo economico e status.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id_employer` | manter `id int4` | — | PK existente |
| `id` | `int4 NULL` | `id_empresa_employer` | `integer` | [RENAME] | Business key Employer |
| `id_grupo_economico` | `int4 NULL` | `id_grupo_economico` | `integer` | OK | Grupo |
| `grupo_economico` | `varchar(50) NULL` | `ds_grupo_economico` | `varchar(50)` | [RENAME] | Descricao |
| `cnpj` | `varchar(20) NULL` | `cnpj_empresa` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ formato DW |
| `razao_social` | `varchar(255) NULL` | `nm_razao_social` | `varchar(255)` | [RENAME] | Razao social |
| `porte_empresa` | `varchar(30) NULL` | `ds_porte` | `varchar(30)` | [RENAME] | Porte (MEI, ME, EPP...) |
| `data_cadastro` | `timestamp NULL` | `dth_cadastro` | `timestamp` | [RENAME] | Cadastro |
| `flag_inativo` | `varchar(10) NULL` | `fl_inativo` | `boolean` | [RENAME] [RETYPE] | Inativo |
| `data_atualizacao` | `timestamp DEFAULT CURRENT_TIMESTAMP NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.descala

**Nome proposto:** `rh.d_escala`
**Tipo:** dimensao
**Descricao:** Escalas de trabalho (jornadas) com tipo de horario, turno e tolerancias.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pk_escala int4` | `id_escala` | `integer NOT NULL` |
| `desc_nome varchar(50)` | `nm_escala` | `varchar(50)` |
| `cd_tip_esc varchar(1)` | `ds_tipo_escala` | `varchar(1)` |
| `cd_tur_esc int2` | `id_turno` | `smallint` |
| `cd_tip_jor int2` | `id_tipo_jornada` | `smallint` |
| `desc_jor varchar(200)` | `ds_jornada` | `varchar(200)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.devento

**Nome proposto:** `rh.d_evento_rh`
**Tipo:** dimensao
**Descricao:** Eventos de folha de pagamento (provento, desconto, informativo).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_evento` | `varchar(110) NULL` | `cod_evento` | `varchar(110)` | [RENAME] | Chave composta legado |
| `cd_evento` | `int4 NULL` | `id_evento` | `integer NOT NULL` | [RENAME] | Codigo do evento |
| `cd_tipo_evento` | `int2 NULL` | `id_tipo_evento` | `smallint` | [RENAME] | Tipo (provento/desconto) |
| `desc_evento` | `varchar(55) NULL` | `ds_evento` | `varchar(55)` | [RENAME] | Descricao |
| `cd_tabela` | `int4 NULL` | `id_tabela` | `integer` | [RENAME] | Tabela de referencia |
| `dthora_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.deventos_rh

**Nome proposto:** `rh.d_evento_rh_flag`
**Tipo:** dimensao
**Descricao:** Flags de classificacao de eventos de folha (absenteismo, extra, rescisao).

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `cd_tab` | `int8 NULL` | `id_tabela` | `integer` | [RENAME] [RETYPE] | Tabela |
| `cd_eve` | `int8 NULL` | `id_evento` | `integer` | [RENAME] [RETYPE] | Evento |
| `fg_normal` | `text NULL` | `fl_normal` | `boolean` | [RENAME] [RETYPE] | Flag normal |
| `fg_absenteismo` | `text NULL` | `fl_absenteismo` | `boolean` | [RENAME] [RETYPE] | Absenteismo |
| `fg_extra` | `text NULL` | `fl_extra` | `boolean` | [RENAME] [RETYPE] | Extra |
| `fg_rescisao` | `text NULL` | `fl_rescisao` | `boolean` | [RENAME] [RETYPE] | Rescisao |
| `fg_normalabsenteismo` | `text NULL` | `fl_normal_absenteismo` | `boolean` | [RENAME] [RETYPE] | Normal+absenteismo |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |
| ADD | — | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.dfilial

**Nome proposto:** `rh.d_filial`
**Tipo:** dimensao
**Descricao:** Filiais da empresa com CNPJ e dados cadastrais.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pk_filial varchar(120)` | `cod_filial` | `varchar(120)` |
| `cd_filial int4` | `id_filial` | `integer` |
| `cd_razao_social varchar(60)` | `nm_razao_social` | `varchar(60)` |
| `cd_nome_filial varchar(60)` | `nm_filial` | `varchar(60)` |
| `desc_nomcom varchar(100)` | `nm_fantasia` | `varchar(100)` |
| `pk_cnpj int8` | `cnpj_filial_int` | `bigint` (manter para referencia) |
| `cnpj varchar(20)` | `cnpj_filial` | `varchar(16)` (formato DW) |
| `cd_numcgc int8` | `cnpj_filial_legado` | `bigint` (legado) |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.dgrau_instrucao / rh.dlocal_organograma / rh.dlocalizacao / rh.dmotivo / rh.dmotivo_reajuste / rh.dsituacao

Sao dimensoes de dominio do Senior RH. Padrao de renomeacao para todas:
- `pk_*` → `id_*` (manter nome logico) + `id bigserial PRIMARY KEY`
- `desc_* / cd_ds_*` → `ds_*`
- `dthora_atualizacao / ultima_atualizacao` → `updated_at`
- Adicionar `created_at`

**rh.dgrau_instrucao:** `pk_grau_instrucao` → `id_grau_instrucao`, `desc_grau` → `ds_grau_instrucao`
**rh.dlocalizacao:** `pk_localizacao` → `id_localizacao`, `cd_nom_loc` → `nm_localizacao`
**rh.dmotivo:** `pk_motivo` → `id_motivo`, `desc_motivo` → `ds_motivo`
**rh.dmotivo_reajuste:** `pk_motivo_alteracao` → `id_motivo_reajuste`, `ds_motivo_alteracao` → `ds_motivo`
**rh.dsituacao:** `pk_situacao` → `id_situacao`, `desc_sit` → `ds_situacao`

---

### rh.dstg_evento / rh.dstg_evento_stage

**Nomes propostos:** `rh.stg_evento_rh`, `rh.stg_evento_rh_stage`
**Tipo:** staging
**Descricao:** Staging de eventos RH — transit para `rh.d_evento_rh`. Renomear colunas conforme padrao de `d_evento_rh`. Ver `stage.stg_evento` (identico).

---

### rh.fabsenteismo

**Nome proposto:** `rh.f_absenteismo`
**Tipo:** fato
**Descricao:** Absenteismo por colaborador, empresa, cargo e localizacao com horas.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cd_num_emp int4` | `id_empresa` | `integer` |
| `cd_fil int4` | `id_filial` | `integer` |
| `cd_num_cad int8` | `nr_cadastro` | `integer` |
| `cd_nom_fun varchar(60)` | `nm_colaborador` | `varchar(60)` |
| `fk_colaborador varchar(130)` | `cod_colaborador` | `varchar(130)` |
| `fk_empresa int4` | `id_empresa_fk` | `integer` |
| `fk_situacao int4` | `id_situacao` | `integer` |
| `fk_cargo varchar(24)` | `cod_cargo` | `varchar(24)` |
| `cd_sit_afa varchar(9)` | `ds_situacao_afastamento` | `varchar(9)` |
| `dt_ref timestamp` | `dt_referencia` | `date` |
| `cd_sit_lan int2` | `id_situacao_lancamento` | `smallint` |
| `vlr_tot_hor int8` | `qt_horas_total` | `numeric(10,2)` (converter) |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fafastamento

**Nome proposto:** `rh.f_afastamento`
**Tipo:** fato
**Descricao:** Afastamentos de funcionarios com inicio, fim e situacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `fk_funcionario` | `varchar(50) NULL` | `cod_colaborador` | `varchar(50)` | [RENAME] | Colaborador |
| `fk_data_afastamento` | `timestamp NULL` | `dt_afastamento` | `date` | [RENAME] [RETYPE] | Data |
| `fk_situacao_afastamento` | `varchar(6) NULL` | `ds_situacao_afastamento` | `varchar(6)` | [RENAME] | Situacao |
| `dt_ini_afastamento` | `timestamp NULL` | `dt_inicio_afastamento` | `date` | [RENAME] [RETYPE] | Inicio |
| `dt_fim_afastamento` | `timestamp NULL` | `dt_fim_afastamento` | `date` | [RENAME] [RETYPE] | Fim |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.fafastamentos

**Nome proposto:** `rh.f_afastamento_senior`
**Tipo:** fato
**Descricao:** Afastamentos detalhados do Senior com horas, causa de demissao e status.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_colaborador varchar(100)` | `cod_colaborador` | `varchar(100)` |
| `fk_empresa int4` | `id_empresa` | `integer` |
| `fk_situacao int4` | `id_situacao` | `integer` |
| `dt_afa timestamp` | `dt_inicio_afastamento` | `date` |
| `vlr_hor_afa int4` | `qt_horas_afastamento` | `integer` |
| `dt_ter timestamp` | `dt_termino_afastamento` | `date` |
| `dt_prv_ter timestamp` | `dt_previsao_termino` | `date` |
| `cd_dia_jus int2` | `nr_dias_justificados` | `smallint` |
| `desc_afa varchar(260)` | `ds_afastamento` | `varchar(260)` |
| `fk_cau_dem int2` | `id_causa_demissao` | `smallint` |
| `motivo_afastamento varchar(30)` | `ds_motivo_afastamento` | `varchar(30)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fafastamentos_employer

**Nome proposto:** `rh.f_afastamento_employer`
**Tipo:** fato
**Descricao:** Afastamentos do sistema Employer (terceirizados) com CID e datas.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `serial4 NOT NULL` | `id` | `bigserial NOT NULL` | [RETYPE] | PK — promover |
| `id_empregado` | `int4 NOT NULL` | `id_empregado` | `integer` | OK | FK empregado |
| `sigla_tipo_afastamento` | `varchar(10) NOT NULL` | `ds_sigla_tipo_afastamento` | `varchar(10)` | [RENAME] | Sigla |
| `tipo_afastamento` | `varchar(100) NOT NULL` | `ds_tipo_afastamento` | `varchar(100)` | [RENAME] | Tipo |
| `data_inicio` | `date NOT NULL` | `dt_inicio` | `date` | [RENAME] | Inicio |
| `data_fim` | `date NULL` | `dt_fim` | `date` | [RENAME] | Fim |
| `observacao` | `text NULL` | `obs_afastamento` | `text` | [RENAME] | Observacao |
| `data_cadastro` | `timestamp DEFAULT CURRENT_TIMESTAMP NULL` | `dth_cadastro` | `timestamp` | [RENAME] | Cadastro |
| `data_previsao_retorno` | `date NULL` | `dt_previsao_retorno` | `date` | [RENAME] | Previsao retorno |
| `codigo_cid` | `varchar(10) NULL` | `ds_cid` | `varchar(10)` | [RENAME] | CID da doenca |
| `ultima_atualizacao` | `date NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] [RETYPE] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.fapuracao

**Nome proposto:** `rh.f_apuracao`
**Tipo:** fato
**Descricao:** Apuracoes de ponto por colaborador e empresa.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `pk_apuracao varchar(150)` | `cod_apuracao` | `varchar(150)` |
| `fk_colaborador varchar(140)` | `cod_colaborador` | `varchar(140)` |
| `fk_empresa int4` | `id_empresa` | `integer` |
| `dt_apuracao timestamp` | `dt_apuracao` | `date` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fatestado

**Nome proposto:** `rh.f_atestado`
**Tipo:** fato
**Descricao:** Atestados medicos por funcionario com CID e situacao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `pk_funcionario` | `varchar(25) NULL` | `cod_colaborador` | `varchar(25)` | [RENAME] | Colaborador |
| `empresa int2` | `id_empresa` | `smallint` | Empresa |
| `cod_filial int4` | `id_filial` | `integer` | Filial |
| `cadastro int4` | `nr_cadastro` | `integer` | Cadastro |
| `data_afastamento timestamp` | `dt_afastamento` | `date` | Data |
| `situacao_afastamento int2` | `id_situacao_afastamento` | `smallint` | Situacao |
| `cid varchar(4)` | `ds_cid` | `varchar(4)` | CID |
| `desc_cid varchar(300)` | `ds_descricao_cid` | `varchar(300)` | Descricao CID |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | Auditoria |

---

### rh.fbanco_horas

**Nome proposto:** `rh.f_banco_horas`
**Tipo:** fato
**Descricao:** Lancamentos no banco de horas por funcionario com saldos.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_funcionario varchar(184)` | `cod_colaborador` | `varchar(184)` |
| `dt_lancamento timestamp` | `dth_lancamento` | `timestamp` |
| `cd_banco int4` | `id_banco_horas` | `integer` |
| `fk_situacao int4` | `id_situacao` | `integer` |
| `qtd_hora varchar(10)` | `ds_qtd_hora` | `varchar(10)` (manter varchar — formato Senior) |
| `saldo_horas varchar(10)` | `ds_saldo_horas` | `varchar(10)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

> **Decisao pendente:** `qtd_hora`, `qtd_paga`, `saldo_horas` sao `varchar(10)` — o Senior usa formato de hora HH:MM. Avaliar converter para `numeric` (minutos) ou manter varchar e converter no ETL.

---

### rh.fdemissao

**Nome proposto:** `rh.f_demissao`
**Tipo:** fato
**Descricao:** Registros de demissao com datas, cargo, filial e valor.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_funcionario varchar(80)` | `cod_colaborador` | `varchar(80)` |
| `fk_filial varchar(80)` | `cod_filial` | `varchar(80)` |
| `fk_empresa varchar(4)` | `id_empresa` | `varchar(4)` |
| `fk_cargo varchar(65)` | `cod_cargo` | `varchar(65)` |
| `dt_funcionario timestamp` | `dt_funcionario` | `date` |
| `dt_demissao timestamp` | `dt_demissao` | `date` |
| `vl_demissao numeric(18,3)` | `vl_demissao` | `numeric(15,2)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fdepartamento_employer

**Nome proposto:** `rh.f_departamento_employer`
**Tipo:** fato (historico departamento)
**Descricao:** Historico de departamentos por empregado no Employer.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `id int4` | `id_registro` | `integer` |
| `id_empregado varchar(30)` | `id_empregado` | `varchar(30)` |
| `id_departamento varchar(30)` | `id_departamento` | `varchar(30)` |
| `codigo_departamento varchar(30)` | `cod_departamento` | `varchar(30)` |
| `departamento varchar(100)` | `ds_departamento` | `varchar(100)` |
| `data_inicio_vigencia timestamp` | `dt_inicio_vigencia` | `date` |
| `data_fim_vigencia timestamp` | `dt_fim_vigencia` | `date` |
| `data_atualizacao timestamp DEFAULT CURRENT_TIMESTAMP` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fdre_lojas

**Nome proposto:** `rh.f_dre_loja`
**Tipo:** fato
**Descricao:** DRE de lojas com orcado, realizado e variacao, por mes e tipo de DRE.

> Esta tabela e identica a `jma.fdre_lojas`. Verificar duplicidade e consolidar.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id_registro` | (usar `id int4` como ID se ja existe) |
| `cnpj_loja varchar(18)` | `cnpj_loja` | `varchar(16)` |
| `apelido varchar(200)` | `nm_apelido_loja` | `varchar(100)` |
| `ano_dre int2` | `nr_ano` | `smallint` |
| `mes_dre int2` | `nr_mes` | `smallint` |
| `tipo_dre int2` | `id_tipo_dre` | `smallint` |
| `propriedade varchar(150)` | `ds_propriedade` | `varchar(150)` |
| `val_real numeric(18,3)` | `vl_real` | `numeric(15,2)` |
| `perc_real numeric(18,3)` | `pc_real` | `numeric(7,4)` |
| `val_orcado numeric(18,3)` | `vl_orcado` | `numeric(15,2)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fesocial / rh.fesocial_intervalo

**Nomes propostos:** `rh.f_esocial`, `rh.f_esocial_intervalo`
**Tipo:** fato
**Descricao:** Horarios e intervalos do eSocial por empresa.

Padrao de renomeacao:
- `fk_empresa int4` → `id_empresa integer`
- `cd_id_eint int4` → `id_eint integer` (identificador do horario eSocial)
- `vlr_dur_jor int4` → `nr_duracao_jornada_min integer`
- `cd_hor int4` → `id_horario integer`
- `cd_hor_eso varchar(50)` → `ds_horario_esocial varchar(50)`
- `dthora_atualizacao timestamp` → `updated_at`
- Para `fesocial_intervalo`: `qtd_dur_int int4` → `nr_duracao_intervalo_min`, `vlr_ini_int/vlr_fim_int int4` → `nr_inicio_intervalo_min/nr_fim_intervalo_min`

---

### rh.fferias

**Nome proposto:** `rh.f_ferias`
**Tipo:** fato
**Descricao:** Ferias dos colaboradores com periodo, dias de direito, tirados e saldo.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_funcionario varchar(50)` | `cod_colaborador` | `varchar(50)` |
| `dt_ini_periodo timestamp` | `dt_inicio_periodo` | `date` |
| `dt_fim_periodo timestamp` | `dt_fim_periodo` | `date` |
| `dt_ini_ferias timestamp` | `dt_inicio_ferias` | `date` |
| `dt_fim_ferias timestamp` | `dt_fim_ferias` | `date` |
| `qt_dias_direito numeric(7,2)` | `nr_dias_direito` | `numeric(7,2)` |
| `qt_dias_tirado numeric(18,3)` | `nr_dias_tirado` | `numeric(7,2)` |
| `qt_dias_saldo numeric(18,3)` | `nr_dias_saldo` | `numeric(7,2)` |
| `qt_dias_ferias numeric(18,3)` | `nr_dias_ferias` | `numeric(7,2)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fficha_empregados

**Nome proposto:** `rh.f_ficha_empregado`
**Tipo:** fato
**Descricao:** Ficha de empregados do Employer com dados de admissao, funcao e rescisao.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| `id` | `int4 NULL` | `id_empregado` | `integer` | [RENAME] | ID do empregado |
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key DW |
| `nome` | `varchar(255) NULL` | `nm_empregado` | `varchar(255)` | [RENAME] | Nome |
| `cpf` | `varchar(14) NULL` | `cpf_empregado` | `varchar(12)` | [RENAME] [RETYPE] | CPF formato DW |
| `matricula` | `varchar(50) NULL` | `nr_matricula` | `varchar(50)` | [RENAME] | Matricula |
| `data_admissao` | `date NULL` | `dt_admissao` | `date` | [RENAME] | Admissao |
| `empregado_inativo` | `bool NULL` | `fl_inativo` | `boolean` | [RENAME] | Inativo |
| `cnpj` | `varchar(20) NULL` | `cnpj_empresa` | `varchar(16)` | [RENAME] [RETYPE] | CNPJ formato DW |
| `empresa_cliente` | `varchar(200) NULL` | `nm_empresa` | `varchar(200)` | [RENAME] | Empresa |
| `departamento` | `varchar(50) NULL` | `ds_departamento` | `varchar(50)` | [RENAME] | Departamento |
| `funcao` | `varchar(50) NULL` | `ds_funcao` | `varchar(50)` | [RENAME] | Funcao |
| `turno` | `varchar(100) NULL` | `ds_turno` | `varchar(100)` | [RENAME] | Turno |
| `data_rescisao` | `date NULL` | `dt_rescisao` | `date` | [RENAME] | Rescisao |
| `motivo_rescisao` | `varchar(255) NULL` | `ds_motivo_rescisao` | `varchar(255)` | [RENAME] | Motivo |
| `updated_at` | `timestamp DEFAULT CURRENT_TIMESTAMP NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Tornar NOT NULL |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.fficha_financeira

**Nome proposto:** `rh.f_ficha_financeira`
**Tipo:** fato
**Descricao:** Ficha financeira por colaborador com eventos, valores de referencia e rubrica.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_empresa int4` | `id_empresa` | `integer` |
| `fk_colaborador varchar(122)` | `cod_colaborador` | `varchar(122)` |
| `cd_tab_eve int4` | `id_tabela_evento` | `integer` |
| `cd_eve int4` | `id_evento` | `integer` |
| `vlr_ref_eve numeric(13,2)` | `vl_referencia` | `numeric(13,2)` |
| `vlr_val_eve numeric(13,2)` | `vl_evento` | `numeric(13,2)` |
| `cd_rub int4` | `id_rubrica` | `integer` |
| `vlr_fat_rub numeric(8,2)` | `vl_fator_rubrica` | `numeric(8,2)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fhistorico

**Nome proposto:** `rh.f_historico_colaborador`
**Tipo:** fato
**Descricao:** Historico de alteracoes de cargo, filial, local e salario dos colaboradores.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_funcionario varchar(130)` | `cod_colaborador` | `varchar(130)` |
| `cd_funcionario varchar(25)` | `nr_cadastro_colaborador` | `varchar(25)` |
| `fk_cargo varchar(65)` | `cod_cargo` | `varchar(65)` |
| `fk_filial varchar(81)` | `cod_filial` | `varchar(81)` |
| `fk_empresa varchar(8)` | `id_empresa` | `varchar(8)` |
| `dt_ini_alteracao timestamp` | `dt_inicio_alteracao` | `date` |
| `dt_fim_alteracao timestamp` | `dt_fim_alteracao` | `date` |
| `fg_admissao varchar(2)` | `fl_admissao` | `boolean` |
| `fg_demissao varchar(2)` | `fl_demissao` | `boolean` |
| `dt_demissao timestamp` | `dt_demissao` | `date` |
| `dt_admissao timestamp` | `dt_admissao` | `date` |
| `fg_ativo varchar(10)` | `fl_ativo` | `boolean` |
| `vlr_sal numeric(18,3)` | `vl_salario` | `numeric(15,2)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fholerite

**Nome proposto:** `rh.f_holerite`
**Tipo:** fato
**Descricao:** Holerites por colaborador e codigo de calculo com salarios, bases e totais.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_colaborador varchar(130)` | `cod_colaborador` | `varchar(130)` |
| `fk_codigo_calculo varchar(90)` | `cod_codigo_calculo` | `varchar(90)` |
| `fk_empresa int4` | `id_empresa` | `integer` |
| `fk_cargo varchar(70)` | `cod_cargo` | `varchar(70)` |
| `cd_nome_com varchar(100)` | `nm_colaborador` | `varchar(100)` |
| `dt_per_ref timestamp` | `dt_referencia` | `date` |
| `dt_pag timestamp` | `dt_pagamento` | `date` |
| `vlr_sal_bas numeric(19,4)` | `vl_salario_base` | `numeric(15,2)` |
| `vlr_val_liq numeric(19,4)` | `vl_liquido` | `numeric(15,2)` |
| `vlr_bas_ins numeric(14,2)` | `vl_base_inss` | `numeric(15,2)` |
| `vlr_bas_irf numeric(14,2)` | `vl_base_irrf` | `numeric(15,2)` |
| `vlr_bas_fgt numeric(14,2)` | `vl_base_fgts` | `numeric(15,2)` |
| `vlr_fgt_mes numeric(14,2)` | `vl_fgts_mes` | `numeric(15,2)` |
| `vlr_tot_ven numeric(15,2)` | `vl_total_vencimentos` | `numeric(15,2)` |
| `vlr_tot_des numeric(15,2)` | `vl_total_descontos` | `numeric(15,2)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fhoras_trabalhadas

**Nome proposto:** `rh.f_horas_trabalhadas`
**Tipo:** fato
**Descricao:** Horas trabalhadas por usuario com totalizador.

> Varios campos com `numeric(38,10)` para datas — heranca de conversao de Oracle.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` | [ADD] | Surrogate key |
| `dat_batida` | `timestamp NULL` | `dth_batida` | `timestamp` | [RENAME] | Batida |
| `dat_dia_batida` | `numeric(38,10) NULL` | `nr_dia_batida` | `smallint` | [RENAME] [RETYPE] | Dia; `numeric(38,10)` inadequado |
| `dat_mes_batida` | `numeric(38,10) NULL` | `nr_mes_batida` | `smallint` | [RENAME] [RETYPE] | Mes |
| `dat_ano_batida` | `numeric(38,10) NULL` | `nr_ano_batida` | `smallint` | [RENAME] [RETYPE] | Ano |
| `chave_usuario` | `text NULL` | `cod_colaborador` | `text` | [RENAME] | Chave do usuario |
| `empresa` | `numeric(4) NULL` | `id_empresa` | `smallint` | [RENAME] [RETYPE] | Empresa |
| `usuario` | `numeric(9) NULL` | `nr_cadastro` | `integer` | [RENAME] [RETYPE] | Cadastro |
| `tot_horas_trb` | `text NULL` | `ds_horas_trabalhadas` | `text` | [RENAME] | Total horas (formato HH:MM) |
| `ultima_atualizacao` | `timestamp NULL` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RENAME] | Auditoria |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.flancamento_hora

**Nome proposto:** `rh.f_lancamento_hora`
**Tipo:** fato
**Descricao:** Lancamentos de horas no banco de horas por colaborador e competencia.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cd_num_emp int4` | `id_empresa` | `integer` |
| `cd_tip_col int2` | `id_tipo_colaborador` | `smallint` |
| `cd_num_col int8` | `nr_cadastro` | `integer` |
| `dt_lanca timestamp` | `dth_lancamento` | `timestamp` |
| `cd_ori_lanca varchar(4)` | `ds_origem_lancamento` | `varchar(4)` |
| `qtd_hor int8` | `qt_horas` | `bigint` (minutos) |
| `qtd_pag int8` | `qt_horas_pagas` | `bigint` |
| `dt_cmp timestamp` | `dt_competencia` | `date` |
| `fk_banco_horas int4` | `id_banco_horas` | `integer` |
| `fk_situacao int4` | `id_situacao` | `integer` |
| `fk_colaborador varchar(150)` | `cod_colaborador` | `varchar(150)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.flog_alteracoes_ponto

**Nome proposto:** `rh.f_log_alteracao_ponto`
**Tipo:** fato (log)
**Descricao:** Log de alteracoes de ponto com usuario, ajuste e mensagem.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `dt_apuracao timestamp` | `dth_apuracao` | `timestamp` |
| `cd_num_fun int8` | `nr_cadastro_colaborador` | `integer` |
| `cd_nom_fun varchar(50)` | `nm_colaborador` | `varchar(50)` |
| `cd_usu int8` | `id_usuario` | `integer` |
| `cd_nom_usu varchar(255)` | `nm_usuario` | `varchar(255)` |
| `cd_num_ajuste int8` | `id_ajuste` | `integer` |
| `cd_nom_ajuste varchar(50)` | `ds_ajuste` | `varchar(50)` |
| `descr_msg_log varchar(500)` | `obs_log` | `varchar(500)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| `fk_colaborador varchar(150)` | `cod_colaborador` | `varchar(150)` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fmarcacao_horario

**Nome proposto:** `rh.f_marcacao_horario`
**Tipo:** fato
**Descricao:** Configuracoes de marcacao de horario com tolerancias.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cd_hor int4` | `id_horario` | `integer` |
| `seq_mar int2` | `nr_seq_marcacao` | `smallint` |
| `cd_usobat int2` | `id_uso_batida` | `smallint` |
| `vlr_horbat int4` | `nr_horario_batida_min` | `integer` |
| `vlr_tolant int4` | `nr_tolerancia_antes_min` | `integer` |
| `vlr_tolapo int4` | `nr_tolerancia_apos_min` | `integer` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fmarcacoes

**Nome proposto:** `rh.f_marcacao`
**Tipo:** fato
**Descricao:** Marcacoes de ponto (Employer) com jornada, ocorrencias e bilhetes.

#### Colunas

| Coluna atual | Tipo atual | Nome proposto | Tipo proposto | Flags | Justificativa |
|---|---|---|---|---|---|
| ADD | — | `id` | `bigserial NOT NULL` (substituir `id int4`) | [RETYPE] | Promover |
| `id int4` | `id_marcacao` | `integer` | [RENAME] | ID original |
| `id_empregado int4` | `id_empregado` | `integer` | OK | Empregado |
| `id_empresa int4` | `id_empresa` | `integer` | OK | Empresa |
| `data_marcacao date` | `dt_marcacao` | `date` | [RENAME] | Data |
| `jornada varchar(100)` | `ds_jornada` | `varchar(100)` | [RENAME] | Jornada |
| `ocorrencia varchar(255)` | `ds_ocorrencia` | `varchar(255)` | [RENAME] | Ocorrencia |
| `horas_trabalhadas_diurnas varchar(20)` | `ds_horas_diurnas` | `varchar(20)` | [RENAME] | Formato HH:MM |
| `horas_trabalhadas_diurna_decimal numeric(10,2)` | `vl_horas_diurnas` | `numeric(10,2)` | [RENAME] | Decimal |
| `bilhete_1-6 time` | `dth_bilhete_1-6` | `time` | OK | Bilhetes de ponto |
| `afastamento_abonado bool` | `fl_afastamento_abonado` | `boolean` | [RENAME] | Abonado |
| `updated_at timestamp DEFAULT CURRENT_TIMESTAMP` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [RETYPE] | Tornar NOT NULL |
| ADD | — | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` | [ADD] | Auditoria |

---

### rh.fmarcacoes_formato_live

**Nome proposto:** `rh.f_marcacao_live`
**Tipo:** fato
**Descricao:** Marcacoes de ponto em formato Live (Senior) por empregado e empresa com tolerancias.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` (substituir `id int4`) |
| `id int4` | `id_marcacao` | `integer` |
| `id_empregado int4` | `id_empregado` | `integer` |
| `id_empresa int4` | `id_empresa` | `integer` |
| `data_marcacao timestamp` | `dth_marcacao` | `timestamp` |
| `horas_trabalhadas varchar(20)` | `ds_horas_trabalhadas` | `varchar(20)` |
| `sequencia_marcacao int4` | `nr_seq_marcacao` | `integer` |
| `marcacao_esperada time(3)` | `hr_esperada` | `time` |
| `marcacao_ponto time(3)` | `hr_ponto` | `time` |
| `dif_marcacao_minutos int4` | `nr_diferenca_min` | `integer` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fponto_detalhado

**Nome proposto:** `rh.f_ponto_detalhado`
**Tipo:** fato
**Descricao:** Ponto detalhado com batidas, previsoes e tolerancias.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `tipo_batida varchar(16)` | `ds_tipo_batida` | `varchar(16)` |
| `seq_batida int2` | `nr_seq_batida` | `smallint` |
| `chave_usuario varchar(154)` | `cod_colaborador` | `varchar(154)` |
| `empresa int2` | `id_empresa` | `smallint` |
| `usuario int4` | `nr_cadastro` | `integer` |
| `dat_batida timestamp` | `dth_batida` | `timestamp` |
| `dat_trabalho timestamp` | `dth_trabalho` | `timestamp` |
| `dat_dia_batida int2` | `nr_dia` | `smallint` |
| `dat_mes_batida int2` | `nr_mes` | `smallint` |
| `dat_ano_batida int2` | `nr_ano` | `smallint` |
| `dife int4` | `nr_diferenca_min` | `integer` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| `turno int2` | `id_turno` | `smallint` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fponto_sintetico

**Nome proposto:** `rh.f_ponto_sintetico`
**Tipo:** fato
**Descricao:** Ponto sintetico com horarios formatados.

#### Colunas (principais)

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `dat_batida timestamp` | `dth_batida` | `timestamp` |
| `dat_dia_batida float8` | `nr_dia` | `smallint` (converter de float8) |
| `dat_mes_batida float8` | `nr_mes` | `smallint` |
| `dat_ano_batida float8` | `nr_ano` | `smallint` |
| `chave_usuario varchar(60)` | `cod_colaborador` | `varchar(60)` |
| `empresa int2` | `id_empresa` | `smallint` |
| `usuario int4` | `nr_cadastro` | `integer` |
| `hor_batida_formatada varchar(400)` | `ds_horario_batida` | `varchar(400)` |
| `hor_escala_formatada varchar(30)` | `ds_horario_escala` | `varchar(30)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| `tip_colaborador int2` | `id_tipo_colaborador` | `smallint` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fprovento_lojas

**Nome proposto:** `rh.f_provento_loja`
**Tipo:** fato
**Descricao:** Proventos de funcionarios de lojas com evento, valor e mes/ano de referencia.

> Varios campos com `numeric(38,10)` — heranca Oracle.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_funcionario text` | `cod_colaborador` | `text` |
| `fk_cargo text` | `cod_cargo` | `text` |
| `cod_empresa numeric(4)` | `id_empresa` | `smallint` |
| `num_cadastro numeric(9)` | `nr_cadastro` | `integer` |
| `ano numeric(38,10)` | `nr_ano` | `smallint` |
| `mes numeric(38,10)` | `nr_mes` | `smallint` |
| `tipo text` | `ds_tipo_provento` | `text` |
| `val_evento numeric(38,10)` | `vl_evento` | `numeric(15,2)` |
| `ultima_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.freajuste

**Nome proposto:** `rh.f_reajuste`
**Tipo:** fato
**Descricao:** Historico de reajustes salariais por colaborador com percentual, salario anterior e motivo.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_funcionario varchar(122)` | `cod_colaborador` | `varchar(122)` |
| `fk_empresa varchar(6)` | `id_empresa` | `varchar(6)` |
| `dt_alteracao timestamp` | `dth_alteracao` | `timestamp` |
| `vlr_salario numeric(18,3)` | `vl_salario_novo` | `numeric(15,2)` |
| `pr_reajuste numeric(13,5)` | `pc_reajuste` | `numeric(7,4)` |
| `fk_motivo_alteracao varchar(7)` | `id_motivo_reajuste` | `varchar(7)` |
| `vlr_salario_anterior numeric(18,3)` | `vl_salario_anterior` | `numeric(15,2)` |
| `fk_filial varchar(30)` | `cod_filial` | `varchar(30)` |
| `ultima_atualizacao date` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fregistro_acesso

**Nome proposto:** `rh.f_registro_acesso`
**Tipo:** fato
**Descricao:** Registros de acesso de cartao por empresa.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `fk_empresa int4` | `id_empresa` | `integer` |
| `cd_num_cra int8` | `nr_cracha` | `integer` |
| `dt_cc timestamp` | `dth_acesso` | `timestamp` |
| `cd_seq_acc int2` | `nr_seq_acesso` | `smallint` |
| `cd_ori_acc varchar(1)` | `ds_origem_acesso` | `varchar(1)` |
| `cd_num_cad int4` | `nr_cadastro` | `integer` |
| `dt_apu timestamp` | `dth_apuracao` | `timestamp` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

### rh.fsaldo_banco_horas / rh.fsaldo_hora_extra

**Nomes propostos:** `rh.f_saldo_banco_horas`, `rh.f_saldo_hora_extra`
**Tipo:** fato
**Descricao:** Saldos de banco de horas e horas extras por colaborador e data de referencia.

Padrao de renomeacao (aplicar em ambas):
- `chave_usuario varchar(154/75)` → `cod_colaborador varchar(154/75)`
- `numemp int2` → `id_empresa smallint`
- `codfil int4` → `id_filial integer`
- `nomfil varchar(40)` → `ds_filial varchar(40)`
- `codloc varchar(150)` → `cod_local varchar(150)`
- `nomloc varchar(60)` → `ds_local varchar(60)`
- `codcar varchar(24)` → `cod_cargo varchar(24)`
- `titcar varchar(100)` → `ds_titulo_cargo varchar(100)`
- `numcad int4` → `nr_cadastro integer`
- `nomfun varchar(40)` → `nm_colaborador varchar(40)`
- `sitafa varchar(7)` → `ds_situacao_afastamento varchar(7)`
- `datref timestamp` → `dt_referencia date`
- Para banco horas: `sldatu int8` → `nr_saldo_horas integer`, `sldneg/sldpos` → `nr_saldo_negativo/positivo`
- Para hora extra: `qtdext int8` → `qt_horas_extra integer`
- `ultima_atualizacao` → `updated_at`

---

### rh.fstg_historico

**Nome proposto:** `rh.stg_historico_colaborador`
**Tipo:** staging
**Descricao:** Staging de historico de colaboradores (todos campos text/numeric(38,10) — tipagem frouxa de staging).

Renomear colunas principais: `fk_funcionario -> cod_colaborador`, `dt_alt -> dt_alteracao`, `vlr_sal -> vl_salario`, `dthora_atualizacao -> updated_at`.

---

### rh.ftotalizador_horas

**Nome proposto:** `rh.f_totalizador_horas`
**Tipo:** fato
**Descricao:** Totalizador de horas por colaborador e competencia, com horas pagas, descontadas e saldo.

#### Colunas

| Coluna atual | Nome proposto | Tipo proposto |
|---|---|---|
| ADD | `id` | `bigserial NOT NULL` |
| `cd_tip_col int2` | `id_tipo_colaborador` | `smallint` |
| `cd_num_col int4` | `nr_cadastro` | `integer` |
| `dt_compe_calc timestamp` | `dt_competencia` | `date` |
| `qtd_hor_pag int8` | `qt_horas_pagas` | `bigint` |
| `qtd_hor_des int8` | `qt_horas_descontadas` | `bigint` |
| `qtd_saldo int8` | `qt_saldo_horas` | `bigint` |
| `fk_banco_hora int4` | `id_banco_horas` | `integer` |
| `fk_colaborador varchar(150)` | `cod_colaborador` | `varchar(150)` |
| `fk_empresa int4` | `id_empresa` | `integer` |
| `vlr_hor_pag numeric(20,4)` | `vl_horas_pagas` | `numeric(15,4)` |
| `vlr_hor_des numeric(20,4)` | `vl_horas_descontadas` | `numeric(15,4)` |
| `vlr_hor_saldo numeric(20,4)` | `vl_saldo_horas` | `numeric(15,4)` |
| `dthora_atualizacao timestamp` | `updated_at` | `timestamp NOT NULL DEFAULT current_timestamp` |
| ADD | `created_at` | `timestamp NOT NULL DEFAULT current_timestamp` |

---

## Conflitos e Decisoes Pendentes — Schema `rh`

1. **`cod_colaborador` — definicao do business key**: O Senior usa chaves compostas (`pk_funcionario varchar(122)`, `fk_colaborador varchar(130)`) que concatenam empresa+tipo+cadastro. O DW precisa de um business key simples. Recomendacao: usar `cd_funcionario` (varchar(9)) como `cod_colaborador`, padronizar para varchar(20).
2. **Campos hora como varchar (qtd_hora, saldo_horas)**: O Senior armazena horas no formato `HH:MM` como texto. Decisao: manter varchar para visualizacao ou converter para minutos inteiros para calculo. Recomendacao: adicionar coluna derivada `nr_horas_min integer` paralela.
3. **`fdre_lojas` duplicada em `rh` e `jma`**: Mesma estrutura em dois schemas. Consolidar em `jma.fdre_lojas` (tabela principal) e criar view em `rh`.
4. **Tabelas Employer vs Senior**: Mix de sistemas no mesmo schema. Considerar separar em sub-namespaces ou prefixos diferentes (ex: `rh.d_colaborador_senior` vs `rh.f_ficha_empregado_employer`).
5. **`fhoras_trabalhadas.dat_dia/mes/ano_batida numeric(38,10)`**: Campos de data fracionados como numeric — absurdo. Converter para `smallint` e derivar da `dth_batida` no ETL.
6. **`fponto_sintetico.dat_dia/mes/ano_batida float8`**: Mesmo problema. Converter.
7. **`freajuste.ultima_atualizacao date`**: Unico campo de auditoria como `date` (sem hora) — converter para `timestamp`.
8. **CPF em `dfuncionario.cpf varchar(11)`**: Sem formatacao — formatar para `XXXXXXXXX-ZZ (varchar(12))` usando funcao DW.
