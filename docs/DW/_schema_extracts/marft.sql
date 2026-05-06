-- Schema: marft
-- Tabelas: 12

CREATE TABLE marft.dcelula_parada (
	codigo_celula int4 NULL,
	shift int2 NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	detalhes varchar(150) NULL,
	minutos int4 NULL,
	codigo_motivo int2 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE marft.dfunc_integracao (
	empresa varchar(10) NULL,
	cracha varchar(20) NULL,
	nome varchar(100) NULL,
	admissao timestamp NULL,
	cpf varchar(20) NULL,
	status varchar(20) NULL,
	origem varchar(60) NULL,
	dat_nasc timestamp NULL,
	dat_ult_alt timestamp NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE marft.dmotivo (
	codigo_motivo int2 NULL,
	nome varchar(40) NULL,
	descricao varchar(250) NULL,
	active int2 NULL,
	integrationcode varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE marft.doperador_falta (
	codigo_operador int4 NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	detalhes varchar(150) NULL,
	minutos int4 NULL,
	codigo_motivo int2 NULL,
	id int8 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE marft.doperador_parada (
	codigo_operador int4 NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos int4 NULL,
	codigo_motivo int2 NULL,
	detalhes varchar(150) NULL,
	descontar_tempo int2 NULL,
	ignorereport int2 NULL,
	id int8 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE marft.dvalores_premio (
	codigo_premio numeric(5) NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	nome text NULL,
	efic_min numeric(5, 2) NULL,
	ate numeric(5, 2) NULL,
	valor numeric(5, 2) NULL
);

CREATE TABLE marft.fdesempenho_operador_individual (
	"data" timestamp NULL,
	codigo_operador numeric(5) NULL,
	nome text NULL,
	cpf text NULL,
	cracha text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(5) NULL,
	"percent" numeric(5, 4) NULL,
	minutos numeric(38, 10) NULL,
	minutos_produzidos numeric(38, 10) NULL,
	eficiencia numeric(38, 10) NULL
);

CREATE TABLE marft.fdesempenho_operador_maquina (
	"data" timestamp NULL,
	codigo_operador numeric(5) NULL,
	nome text NULL,
	cpf text NULL,
	cracha text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(5) NULL,
	"percent" numeric(5, 4) NULL,
	minutos numeric(38, 10) NULL,
	minutos_produzidos numeric(38, 10) NULL,
	eficiencia numeric(38, 10) NULL
);

CREATE TABLE marft.foperador_status (
	operator_status_id int8 NULL,
	create_date timestamp NULL,
	codigo_operador int4 NULL,
	"DATA" timestamp NULL,
	codigo_sit_prof int4 NULL,
	codigo_funcao int2 NULL,
	codigo_celula int4 NULL,
	shift int2 NULL,
	codigo_premio int4 NULL,
	cost_center_code int4 NULL,
	tempo_celula int2 NULL,
	ativo int2 NULL,
	observacao varchar(250) NULL,
	codigo_empresa varchar(5) NULL,
	assiduityaward int2 NULL,
	leader int2 NULL,
	ultima_atualizacao timestamp NULL,
	award_coefficient_i numeric(18, 3) NULL,
	award_coefficient_c numeric(18, 3) NULL,
	award_individual_me numeric(18, 3) NULL,
	maximumefficiency numeric(18, 3) NULL
);

CREATE TABLE marft.fprod_oper (
	op numeric(10) NULL,
	os numeric(10) NULL,
	seq numeric(5) NULL,
	caixa text NULL,
	grupo text NULL,
	hora timestamp NULL,
	cod_oper text NULL,
	operacao text NULL,
	cod_operador numeric(5) NULL,
	operador text NULL,
	qtde numeric(5) NULL,
	tempo numeric(7, 2) NULL,
	carga numeric(38, 10) NULL,
	gd numeric(4, 2) NULL,
	cod_cel numeric(5) NULL,
	celula_os text NULL,
	turno numeric(5) NULL,
	referencia text NULL,
	produto text NULL,
	ultima_atualizacao timestamp NULL,
	"data" timestamp NULL,
	cpf text NULL
);

CREATE TABLE marft.fproducao_celula (
	codigo_celula int4 NULL,
	shift int2 NULL,
	"DATA" timestamp NULL,
	minutos_dia int4 NULL,
	operadores int2 NULL,
	total_minutos_parada int4 NULL,
	total_minutos_dia int8 NULL,
	total_minutos_produzidos numeric(18, 3) NULL,
	total_pecas_produzidas int8 NULL,
	eficiencia numeric(18, 3) NULL,
	rft numeric(18, 3) NULL,
	smo numeric(18, 3) NULL,
	eficiencia_peca numeric(18, 3) NULL,
	operational_eff int2 NULL,
	partial_parts int2 NULL,
	part_amount int2 NULL,
	message varchar(250) NULL,
	part_code int4 NULL,
	productivecapacity int8 NULL,
	availableminutes int8 NULL,
	holiday int2 NULL,
	realefficiency numeric(18, 3) NULL,
	lostefficiency numeric(18, 3) NULL,
	stoppercent numeric(18, 3) NULL,
	lostminutes int8 NULL,
	stopminutes int8 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE marft.fproducao_operador (
	codigo_operador int4 NULL,
	"data" timestamp NULL,
	codigo_celula int4 NULL,
	shift int2 NULL,
	operator_status_id int8 NULL,
	minutos int4 NULL,
	minutos_parada int4 NULL,
	minutos_falta int4 NULL,
	minutos_horario int4 NULL,
	total_minutos_dia int4 NULL,
	minutos_produzidos numeric(18, 3) NULL,
	total_minutos_produzidos numeric(18, 3) NULL,
	eficiencia numeric(18, 3) NULL,
	eficiencia_geral numeric(18, 3) NULL,
	rft numeric(18, 3) NULL,
	rft_geral numeric(18, 3) NULL,
	smo numeric(18, 3) NULL,
	smo_geral numeric(18, 3) NULL,
	message varchar(500) NULL,
	holiday int2 NULL,
	sourcecell int2 NULL,
	ultima_atualizacao timestamp NULL
);