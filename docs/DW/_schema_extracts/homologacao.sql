-- Schema: homologacao
-- Tabelas: 2

CREATE TABLE homologacao.fvitrine_indicadores_loja (
	id int4 NOT NULL,
	company_id varchar(50) NULL,
	"name" varchar(255) NULL,
	date_start timestamp NULL,
	date_end timestamp NULL,
	store_id varchar(50) NULL,
	nm_store varchar(255) NULL,
	code int2 NULL,
	nm_group varchar(255) NULL,
	store_status varchar(30) NULL,
	aprovador varchar(30) NULL,
	executor varchar(50) NULL,
	comercial varchar(30) NULL,
	visualizador varchar(20) NULL,
	franqueado varchar(50) NULL,
	totalspace int2 NULL,
	totaldone int2 NULL,
	totalnotapply int2 NULL,
	done int2 NULL,
	notapply int2 NULL,
	notdone int2 NULL,
	executiondate timestamp NULL,
	ontime numeric(5, 2) NULL,
	storeexecutiontime varchar(20) NULL,
	storeapprovaltime varchar(20) NULL,
	notevaluatedontime int2 NULL,
	notevaluatedofftime int2 NULL,
	notsendontime int2 NULL,
	notsendofftime int2 NULL,
	quality numeric(5, 2) NULL,
	rework numeric(5, 2) NULL,
	CONSTRAINT fvitrine_indicadores_loja_pkey PRIMARY KEY (id)
);

CREATE TABLE homologacao.fvitrine_quality_by_space (
	store_id varchar(50) NOT NULL,
	space_id varchar(50) NOT NULL,
	"name" varchar(150) NULL,
	orientation text NULL,
	star numeric(5, 2) NULL,
	quality numeric(5, 2) NULL,
	notapply numeric(5, 2) NULL,
	notapplyreasons text NULL,
	approvedreasons text NULL,
	reprovedreasons text NULL,
	CONSTRAINT fvitrine_quality_by_space_pkey PRIMARY KEY (store_id, space_id)
);