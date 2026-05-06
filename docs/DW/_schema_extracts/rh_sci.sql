-- Schema: rh_sci
-- Tabelas: 7

CREATE TABLE rh_sci.dhistorico_salario (
	fk_funcionario varchar(184) NULL,
	dt_alteracao timestamp NULL,
	sequencia int2 NULL,
	sal_atual numeric(17, 4) NULL,
	val_complementar numeric(17, 4) NULL,
	classe_sal varchar(5) NULL,
	nivel_sal varchar(5) NULL,
	pct_desempenho numeric(7, 2) NULL,
	pct_reajuste_conced numeric(13, 5) NULL
);

CREATE TABLE rh_sci.fcontratos_lecom (
	cod_processo_f int4 NULL,
	cod_etapa_f int2 NULL,
	cod_ciclo_f int2 NULL,
	nome_contrato varchar(50) NULL,
	tipo_contrato varchar(50) NULL,
	cnpj varchar(30) NULL,
	cnpj_live varchar(30) NULL,
	cnpj_filial varchar(30) NULL,
	grupo_live varchar(200) NULL,
	depart_solicitante varchar(30) NULL,
	finalidade_locacao varchar(50) NULL,
	nome_completo varchar(80) NULL,
	cpf varchar(14) NULL,
	cpf_rep_legal varchar(14) NULL,
	email varchar(50) NULL,
	nome_empreendimento varchar(30) NULL,
	area_metros_quadrados varchar(25) NULL,
	endereco varchar(50) NULL,
	numero varchar(10) NULL,
	bairro varchar(50) NULL,
	cep varchar(12) NULL,
	cidade varchar(50) NULL,
	estado varchar(2) NULL,
	pais varchar(30) NULL,
	data_inicio_vigencia timestamp NULL,
	data_fim_vigencia timestamp NULL,
	percentual_aluguel varchar(25) NULL,
	indice_reajuste varchar(255) NULL,
	periodicidade_reajuste varchar(25) NULL,
	carencia_aluguel varchar(25) NULL,
	fundo_promocao varchar(25) NULL,
	cdu varchar(25) NULL,
	aluguel_escalonado varchar(255) NULL,
	ultima_atualizacao timestamp NULL,
	cronograma_atividades varchar(5500) NULL,
	tipo_imovel varchar(207) NULL,
	matriz_filial varchar(200) NULL,
	tipo_solicitacao varchar(200) NULL,
	tipo_locacao varchar(200) NULL,
	tipo_da_locacao varchar(200) NULL,
	objeto_contrato varchar(5500) NULL,
	valor_contratado numeric(18, 3) NULL,
	valor_multa numeric(18, 3) NULL
);

CREATE TABLE rh_sci.ffolha_salarial (
	fk_funcionario varchar(30) NULL,
	fk_filial varchar(30) NULL,
	fk_empresa varchar(6) NULL,
	data_emissao timestamp NULL,
	data_admissao timestamp NULL,
	cd_folha_referencia numeric(18, 3) NULL,
	fk_evento varchar(25) NULL,
	cd_origem_evento varchar(1) NULL,
	vlr_evento varchar(25) NULL,
	fk_cargo varchar(65) NULL,
	vlr_vencimentos numeric(18, 3) NULL,
	vlr_descontos numeric(18, 3) NULL,
	vlr_outros numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE rh_sci.fprov_bruto_colab (
	fk_funcionario text NULL,
	fk_cargo text NULL,
	cod_empresa numeric(4) NULL,
	num_cadastro numeric(9) NULL,
	ano int4 NULL,
	mes int2 NULL,
	tipo text NULL,
	val_evento numeric(38, 10) NULL,
	centro_custo varchar(30) NULL,
	cod_ccusto int8 NULL,
	ultima_atualizacao date NULL,
	tiposituacao int8 NULL,
	descricaosituacao varchar(40) NULL
);

CREATE TABLE rh_sci.fproventos_depto_employer (
	id serial4 NOT NULL,
	data_competencia date NULL,
	id_empresa int4 NULL,
	departamento varchar(255) NULL,
	valor_salario_base numeric(15, 2) NULL,
	valor_salario_nominal numeric(15, 2) NULL,
	valor_total numeric(15, 2) NULL,
	qtde_pessoas int4 NULL,
	ultima_atualizacao timestamp NULL,
	CONSTRAINT fproventos_depto_employer_pkey PRIMARY KEY (id)
);

CREATE TABLE rh_sci.freajuste (
	fk_funcionario varchar(122) NULL,
	fk_empresa varchar(6) NULL,
	dt_alteracao timestamp NULL,
	vlr_salario numeric(18, 3) NULL,
	pr_reajuste numeric(13, 5) NULL,
	cd_seq_alteracao varchar(7) NULL,
	fk_motivo_alteracao varchar(7) NULL,
	cd_tipo_salario varchar(7) NULL,
	vlr_salario_anterior numeric(18, 3) NULL,
	fk_filial varchar(30) NULL,
	ultima_atualizacao date NULL
);

CREATE TABLE rh_sci.fsalario_employer (
	id int4 NULL,
	cod_contrato varchar(30) NULL,
	contrato varchar(50) NULL,
	id_departamento int4 NULL,
	departamento varchar(50) NULL,
	salario numeric NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL
);