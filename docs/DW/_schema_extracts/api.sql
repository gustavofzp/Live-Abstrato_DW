-- Schema: api
-- Tabelas: 17

CREATE TABLE api.altervision_conversao (
	store varchar NULL,
	uptime numeric NULL,
	localdate date NULL,
	visitors int4 NULL,
	nbsales int4 NULL,
	totalsales numeric NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE api.altervision_countperhour (
	store_identifier varchar NULL,
	"day" date NULL,
	"hour" int4 NULL,
	count int4 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE api.altervision_getage (
	"day" date NULL,
	loja varchar NULL,
	idade varchar NULL,
	count numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE api.altervision_getgender (
	"day" date NULL,
	loja varchar NULL,
	genero varchar NULL,
	count numeric NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE api.altervision_getprofileperstore (
	"day" date NULL,
	loja varchar NULL,
	genero varchar NULL,
	idade varchar NULL,
	count numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE api.altervision_weather (
	"day" date NULL,
	loja varchar NULL,
	tipo_clima varchar NULL,
	clima varchar NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE api.boxlink_rastreio_encomendas (
	pedido_venda varchar(20) NULL,
	serie_nota_fiscal varchar(10) NULL,
	numero_nota_fiscal varchar(30) NULL,
	numero_minuta int4 NULL,
	rastreador_tms varchar(90) NULL,
	ultima_atualizacao timestamp NULL,
	data_envio timestamp NULL,
	entrega_estimada timestamp NULL,
	status varchar(120) NULL
);

CREATE TABLE api.fevidencias (
	answer_id int4 NULL,
	answer_evidence_type_id int4 NULL,
	answer_url text NULL,
	answer_evidence_type_id_ref int4 NULL,
	answer_evidence_type_name_ref text NULL
);

CREATE TABLE api.fplanos (
	id int4 NULL,
	task_code varchar(50) NULL,
	creator_user_id varchar(100) NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL,
	checklist_execution_id int4 NULL,
	question_id int4 NULL,
	action_plan_state_id int4 NULL,
	action_plan_state_name text NULL,
	user_id varchar(100) NULL,
	user_name text NULL,
	user_role text NULL,
	answer_id int4 NULL,
	answer_respondent_user_id varchar(100) NULL,
	answer_approver_user_id varchar(100) NULL,
	answer varchar(1000) NULL
);

CREATE TABLE api.vitrine (
	checklist_title varchar(50) NULL,
	checklist_id int4 NULL,
	recurrence_start_date timestamp NULL,
	recurrence_end_date timestamp NULL,
	"groups" varchar(100) NULL,
	checklist_execution_state_name varchar(50) NULL,
	checklist_execution_start_date timestamp NULL,
	checklist_execution_end_date timestamp NULL,
	user_id varchar(50) NULL,
	user_name varchar(100) NULL,
	is_audit varchar(50) NULL,
	question_description varchar(200) NULL,
	action_plan_amount varchar(9) NULL,
	opportunities varchar(9) NULL,
	question_id varchar(9) NULL,
	business_unit_id int8 NULL,
	business_unit_code int8 NULL,
	checklist_execution_id varchar(7) NULL,
	score varchar(9) NULL,
	score_max varchar(9) NULL,
	score_rate varchar(9) NULL,
	question_answers varchar(2500) NULL,
	answer varchar(2500) NULL,
	group_names varchar(300) NULL,
	commercial_names varchar(300) NULL,
	question_title varchar(300) NULL,
	text_evidence varchar(300) NULL,
	category_name varchar(300) NULL,
	department_names varchar(300) NULL,
	business_unit_name varchar(300) NULL
);

CREATE TABLE api.vitrine_checklist (
	checklist_id int4 NULL,
	checklist_title varchar(50) NULL,
	business_unit_id int8 NULL,
	business_unit_name varchar(207) NULL,
	business_unit_code int8 NULL,
	group_names varchar(200) NULL,
	checklist_execution_id int8 NULL,
	checklist_execution_state_name varchar(50) NULL,
	user_id varchar(50) NULL,
	user_name varchar(100) NULL,
	score_rate float8 NULL,
	action_plan_amount int8 NULL,
	opportunities int4 NULL,
	is_audit varchar(50) NULL,
	question_id int8 NULL,
	question_title varchar(202) NULL,
	question_description varchar(203) NULL,
	text_evidence varchar(204) NULL,
	score int8 NULL,
	score_max int8 NULL,
	department_names varchar(205) NULL,
	category_name varchar(206) NULL,
	icon varchar(200) NULL,
	label_cod varchar(100) NULL,
	answer varchar(2500) NULL,
	question_score varchar(200) NULL,
	ultima_atualizacao timestamp NULL,
	checklist_execution_end_date timestamp NULL,
	checklist_execution_start_date timestamp NULL,
	recurrence_end_date timestamp NULL,
	recurrence_start_date timestamp NULL,
	commercial_names varchar(300) NULL
);

CREATE TABLE api.vitrine_indicators (
	company_id varchar(200) NULL,
	id int4 NULL,
	"name" varchar(200) NULL,
	date_start timestamp NULL,
	date_end timestamp NULL,
	store_id varchar(200) NULL,
	nm_store varchar(200) NULL,
	code varchar(200) NULL,
	nm_group varchar(200) NULL,
	store_status varchar(200) NULL,
	aprovador varchar(200) NULL,
	executor varchar(200) NULL,
	comercial varchar(200) NULL,
	visualizador varchar(200) NULL,
	franqueado varchar(200) NULL,
	totalspace int4 NULL,
	totaldone numeric(15, 3) NULL,
	totalnotapply numeric(15, 3) NULL,
	done int4 NULL,
	notapply numeric(15, 3) NULL,
	notdone numeric(15, 3) NULL,
	executiondate timestamp NULL,
	ontime int4 NULL,
	storeexecutiontime varchar(200) NULL,
	storeapprovaltime varchar(200) NULL,
	notevaluatedontime numeric(12, 3) NULL,
	notevaluatedofftime numeric(42, 33) NULL,
	notsendontime numeric(12, 3) NULL,
	notsendofftime numeric(12, 3) NULL,
	quality numeric(12, 3) NULL,
	rework numeric(12, 3) NULL,
	quality_id varchar(100) NULL,
	quality_name varchar(300) NULL,
	star numeric(15, 3) NULL,
	question_quality numeric(15, 3) NULL,
	not_apply numeric(15, 3) NULL,
	orientation varchar(2000) NULL,
	not_apply_reasons varchar(2000) NULL,
	approved_reasons varchar(2000) NULL,
	reproved_reasons varchar(2000) NULL
);

CREATE TABLE api.vitrine_indicators_stores (
	company_id varchar(200) NULL,
	id int4 NULL,
	"name" varchar(200) NULL,
	store_id varchar(200) NULL,
	nm_store varchar(200) NULL,
	code varchar(200) NULL,
	nm_group varchar(200) NULL,
	store_status varchar(200) NULL,
	aprovador varchar(200) NULL,
	executor varchar(200) NULL,
	comercial varchar(200) NULL,
	visualizador varchar(200) NULL,
	franqueado varchar(200) NULL,
	ontime int4 NULL,
	storeexecutiontime varchar(200) NULL,
	storeapprovaltime varchar(200) NULL,
	notevaluatedontime int4 NULL,
	notevaluatedofftime int4 NULL,
	notsendontime int4 NULL,
	notsendofftime int4 NULL,
	quality int4 NULL,
	rework int4 NULL,
	quality_id varchar(200) NULL,
	totalspace int4 NULL,
	done int4 NULL,
	date_start varchar(50) NULL,
	date_end varchar(50) NULL,
	executiondate varchar(50) NULL,
	totaldone numeric(12, 3) NULL,
	totalnotapply numeric(12, 3) NULL,
	notapply numeric(12, 3) NULL,
	notdone numeric(12, 3) NULL
);

CREATE TABLE api.vitrine_opcoes_respostas (
	checklist_id int8 NULL,
	checklist_execution_id int8 NULL,
	business_unit_id int8 NULL,
	question_id int8 NULL,
	icon varchar(200) NULL,
	label_cod varchar(100) NULL,
	"label" varchar(200) NULL,
	score varchar(200) NULL
);

CREATE TABLE api.vitrine_qualitybyspace (
	id int4 NULL,
	quality_id varchar(100) NULL,
	"name" varchar(300) NULL,
	orientation varchar(2000) NULL,
	star numeric(12, 3) NULL,
	quality numeric(12, 3) NULL,
	not_apply numeric(12, 3) NULL,
	not_apply_reasons varchar(2000) NULL,
	approved_reasons varchar(2000) NULL,
	reproved_reasons varchar(2000) NULL,
	company_id varchar(100) NULL,
	store_id varchar(100) NULL
);

CREATE TABLE api.vitrine_questions (
	checklist_id int4 NULL,
	recurrence_start_date timestamp NULL,
	recurrence_end_date timestamp NULL,
	checklist_title varchar(50) NULL,
	business_unit_id int8 NULL,
	checklist_execution_id int8 NULL,
	checklist_execution_state_name varchar(50) NULL,
	checklist_execution_start_date timestamp NULL,
	checklist_execution_end_date timestamp NULL,
	user_name varchar(100) NULL,
	score_rate float8 NULL,
	opportunities int4 NULL,
	is_audit varchar(50) NULL,
	question_id int8 NULL,
	score_max int8 NULL,
	score int8 NULL,
	business_unit_code int8 NULL,
	action_plan_amount int8 NULL,
	user_id varchar(50) NULL,
	answer varchar(2500) NULL,
	question_title varchar(202) NULL,
	question_description varchar(203) NULL,
	text_evidence varchar(204) NULL,
	department_names varchar(205) NULL,
	category_name varchar(206) NULL,
	business_unit_name varchar(207) NULL,
	group_names varchar(300) NULL,
	commercial_names varchar(300) NULL
);

CREATE TABLE api.vitrine_respostas (
	icon varchar(200) NULL,
	"label" varchar(200) NULL,
	score varchar(200) NULL,
	evidences varchar(200) NULL,
	checklist_id varchar(200) NULL,
	business_unit_id varchar(200) NULL,
	checklist_execution_id varchar(200) NULL,
	question_id varchar(200) NULL,
	recurrence_start_date date NULL,
	recurrence_end_date date NULL
);