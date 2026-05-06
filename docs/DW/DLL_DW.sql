-- DROP SCHEMA api;

CREATE SCHEMA api AUTHORIZATION "Live";
-- api.altervision_conversao definição

-- Drop table

-- DROP TABLE api.altervision_conversao;

CREATE TABLE api.altervision_conversao (
	store varchar NULL,
	uptime numeric NULL,
	localdate date NULL,
	visitors int4 NULL,
	nbsales int4 NULL,
	totalsales numeric NULL,
	ultima_atualizacao timestamp NULL
);


-- api.altervision_countperhour definição

-- Drop table

-- DROP TABLE api.altervision_countperhour;

CREATE TABLE api.altervision_countperhour (
	store_identifier varchar NULL,
	"day" date NULL,
	"hour" int4 NULL,
	count int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- api.altervision_getage definição

-- Drop table

-- DROP TABLE api.altervision_getage;

CREATE TABLE api.altervision_getage (
	"day" date NULL,
	loja varchar NULL,
	idade varchar NULL,
	count numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- api.altervision_getgender definição

-- Drop table

-- DROP TABLE api.altervision_getgender;

CREATE TABLE api.altervision_getgender (
	"day" date NULL,
	loja varchar NULL,
	genero varchar NULL,
	count numeric NULL,
	ultima_atualizacao timestamp NULL
);


-- api.altervision_getprofileperstore definição

-- Drop table

-- DROP TABLE api.altervision_getprofileperstore;

CREATE TABLE api.altervision_getprofileperstore (
	"day" date NULL,
	loja varchar NULL,
	genero varchar NULL,
	idade varchar NULL,
	count numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- api.altervision_weather definição

-- Drop table

-- DROP TABLE api.altervision_weather;

CREATE TABLE api.altervision_weather (
	"day" date NULL,
	loja varchar NULL,
	tipo_clima varchar NULL,
	clima varchar NULL,
	ultima_atualizacao timestamp NULL
);


-- api.boxlink_rastreio_encomendas definição

-- Drop table

-- DROP TABLE api.boxlink_rastreio_encomendas;

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


-- api.fevidencias definição

-- Drop table

-- DROP TABLE api.fevidencias;

CREATE TABLE api.fevidencias (
	answer_id int4 NULL,
	answer_evidence_type_id int4 NULL,
	answer_url text NULL,
	answer_evidence_type_id_ref int4 NULL,
	answer_evidence_type_name_ref text NULL
);


-- api.fplanos definição

-- Drop table

-- DROP TABLE api.fplanos;

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


-- api.vitrine definição

-- Drop table

-- DROP TABLE api.vitrine;

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


-- api.vitrine_checklist definição

-- Drop table

-- DROP TABLE api.vitrine_checklist;

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


-- api.vitrine_indicators definição

-- Drop table

-- DROP TABLE api.vitrine_indicators;

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


-- api.vitrine_indicators_stores definição

-- Drop table

-- DROP TABLE api.vitrine_indicators_stores;

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


-- api.vitrine_opcoes_respostas definição

-- Drop table

-- DROP TABLE api.vitrine_opcoes_respostas;

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


-- api.vitrine_qualitybyspace definição

-- Drop table

-- DROP TABLE api.vitrine_qualitybyspace;

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


-- api.vitrine_questions definição

-- Drop table

-- DROP TABLE api.vitrine_questions;

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


-- api.vitrine_respostas definição

-- Drop table

-- DROP TABLE api.vitrine_respostas;

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

-- DROP SCHEMA comercial;

CREATE SCHEMA comercial AUTHORIZATION postgres;
-- comercial.destacao_colecao_subcolecao definição

-- Drop table

-- DROP TABLE comercial.destacao_colecao_subcolecao;

CREATE TABLE comercial.destacao_colecao_subcolecao (
	cod_estacao numeric(9) NULL,
	desc_estacao text NULL,
	colecao numeric(3) NULL,
	desccolecao text NULL,
	subcolecao numeric(4) NULL,
	descsubcolecao text NULL
);


-- comercial.dlivepro_campaign_lists definição

-- Drop table

-- DROP TABLE comercial.dlivepro_campaign_lists;

CREATE TABLE comercial.dlivepro_campaign_lists (
	campaign_list_id int8 NULL,
	campaign_id int8 NULL,
	customer_cpf varchar(15) NULL,
	customer_name varchar(255) NULL,
	campaign_seller_cpf varchar(15) NULL,
	campaign_store_cnpj varchar(18) NULL,
	created_at timestamp NULL,
	contacted_at timestamp NULL,
	campaign_name varchar(255) NULL,
	campaign_name_ajusted varchar(255) NULL
);


-- comercial.dlivepro_campanha definição

-- Drop table

-- DROP TABLE comercial.dlivepro_campanha;

CREATE TABLE comercial.dlivepro_campanha (
	campaigns_id int8 NULL,
	campaigns_name text NULL,
	status bool NULL,
	contact_type int4 NULL,
	repick bool NULL,
	start_when_activate bool NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	next_impact int4 NULL,
	created_at timestamp NULL,
	audience_id int8 NULL,
	image_path text NULL,
	client_list_duration int4 NULL
);


-- comercial.dlivepro_transactions definição

-- Drop table

-- DROP TABLE comercial.dlivepro_transactions;

CREATE TABLE comercial.dlivepro_transactions (
	order_id text NULL,
	transaction_status_id int8 NULL,
	customer_cpf text NULL,
	store_cnpj text NULL,
	seller_cpf text NULL,
	order_date timestamp NULL,
	coupon_discount text NULL,
	coupon_seller text NULL,
	price_paid float8 NULL,
	amount int8 NULL
);


-- comercial.dperiodo_venda_previsao definição

-- Drop table

-- DROP TABLE comercial.dperiodo_venda_previsao;

CREATE TABLE comercial.dperiodo_venda_previsao (
	id int4 NULL,
	descricao varchar(100) NULL,
	colecao int4 NULL,
	col_tab_preco_sell_in int4 NULL,
	mes_tab_preco_sell_in int4 NULL,
	seq_tab_preco_sell_in int4 NULL,
	col_tab_preco_sell_out int4 NULL,
	mes_tab_preco_sell_out int4 NULL,
	seq_tab_preco_sell_out int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.dprevisao_venda_capa definição

-- Drop table

-- DROP TABLE comercial.dprevisao_venda_capa;

CREATE TABLE comercial.dprevisao_venda_capa (
	id varchar(50) NULL,
	id_previsao_vendas int4 NULL,
	grupo varchar(50) NULL,
	item varchar(50) NULL,
	valor_sell_in numeric(19, 6) NULL,
	valor_sell_out numeric(19, 6) NULL,
	grupo_base varchar(50) NULL,
	item_base varchar(50) NULL,
	qtde_vendida_base numeric(6) NULL,
	percentual_aplicar numeric(6, 2) NULL,
	qtde_previsao numeric(6) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.dprevisao_venda_item definição

-- Drop table

-- DROP TABLE comercial.dprevisao_venda_item;

CREATE TABLE comercial.dprevisao_venda_item (
	id varchar(60) NULL,
	id_previsao_vendas int4 NULL,
	id_item_previsao_vendas varchar(60) NULL,
	grupo varchar(30) NULL,
	item varchar(30) NULL,
	sub varchar(30) NULL,
	qtde_previsao numeric(6) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.dprevisoes_vendas_colecao definição

-- Drop table

-- DROP TABLE comercial.dprevisoes_vendas_colecao;

CREATE TABLE comercial.dprevisoes_vendas_colecao (
	cod_colecao int2 NULL,
	desc_colecao varchar(20) NULL,
	cod_subcolecao int2 NULL,
	desc_subcolecao varchar(20) NULL,
	classificacao int2 NULL,
	desc_classificacao varchar(6) NULL,
	abreviacao_col varchar(20) NULL,
	tipo_col varchar(20) NULL,
	data_inicio_sell_in timestamp NULL,
	data_fim_sell_in timestamp NULL,
	data_inicio_sell_out timestamp NULL,
	data_fim_sell_out timestamp NULL,
	data_inicio_producao timestamp NULL,
	data_fim_producao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.drepresentante definição

-- Drop table

-- DROP TABLE comercial.drepresentante;

CREATE TABLE comercial.drepresentante (
	pk_representante varchar(6) NULL,
	cnpj_repres int8 NULL,
	cod_empresa int2 NULL,
	cod_repres int2 NULL,
	nome_repres varchar(50) NULL,
	nome_fantasia varchar(50) NULL,
	tipo_repres int2 NULL,
	endereco varchar(60) NULL,
	bairro varchar(20) NULL,
	cidade varchar(40) NULL,
	regiao varchar(20) NULL,
	subregiao varchar(20) NULL,
	cep int4 NULL,
	ddd_celular int2 NULL,
	num_celular int4 NULL,
	fone_repres int4 NULL,
	inscricao_estadual varchar(14) NULL,
	email varchar(60) NULL,
	situacao int2 NULL,
	conta_banco varchar(15) NULL,
	cod_agencia varchar(15) NULL,
	cod_adm int2 NULL,
	ult_pedido timestamp NULL,
	dias_ult_pedido float8 NULL,
	dt_primeiro_pedido timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cod_cidade varchar(5) NULL
);


-- comercial.fcontratos_locacao_lecom definição

-- Drop table

-- DROP TABLE comercial.fcontratos_locacao_lecom;

CREATE TABLE comercial.fcontratos_locacao_lecom (
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
	cronograma_atividades varchar(206) NULL,
	tipo_imovel varchar(207) NULL,
	matriz_filial varchar(200) NULL,
	tipo_solicitacao varchar(200) NULL,
	tipo_locacao varchar(200) NULL,
	tipo_da_locacao varchar(200) NULL,
	objeto_contrato varchar(2000) NULL,
	valor_contratado numeric(18, 3) NULL,
	valor_multa numeric(18, 3) NULL,
	razao_social varchar(180) NULL,
	fiador varchar(120) NULL,
	ide_finalizado varchar(60) NULL
);


-- comercial.festoque_produtos definição

-- Drop table

-- DROP TABLE comercial.festoque_produtos;

CREATE TABLE comercial.festoque_produtos (
	fk_produto varchar(111) NULL,
	cod_erp varchar(111) NULL,
	conta_estoque int2 NULL,
	unidade_medida varchar(2) NULL,
	qtd_sugerida numeric(18, 3) NULL,
	qtd_empenhada numeric(18, 3) NULL,
	qtd_est_atual numeric(18, 3) NULL,
	qtd_disponivel numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.fitens_pedidos definição

-- Drop table

-- DROP TABLE comercial.fitens_pedidos;

CREATE TABLE comercial.fitens_pedidos (
	pedido_venda int4 NULL,
	seq_item int2 NULL,
	fk_produto varchar(35) NULL,
	cod_nat_op int2 NULL,
	descr_nat_oper varchar(40) NULL,
	qtd_sugerida numeric(18, 3) NULL,
	qtd_afaturar numeric(18, 3) NULL,
	qtd_faturada numeric(18, 3) NULL,
	valor_unitario numeric(19, 4) NULL,
	percentual_desc numeric(17, 2) NULL,
	situacao_fatu_it int2 NULL,
	cod_cancelamento int2 NULL,
	tabela_preco varchar(35) NULL,
	qtd_cancelada numeric(18, 3) NULL,
	valor_cancelado numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.flivepro_conversao_campanha definição

-- Drop table

-- DROP TABLE comercial.flivepro_conversao_campanha;

CREATE TABLE comercial.flivepro_conversao_campanha (
	order_id text NULL,
	order_date timestamp NULL,
	contacted_at timestamp NULL,
	campaign_list_id int8 NULL,
	campaign_id int8 NULL,
	tempo_conversao text NULL
);


-- comercial.flog_itens_transfer definição

-- Drop table

-- DROP TABLE comercial.flog_itens_transfer;

CREATE TABLE comercial.flog_itens_transfer (
	cd_pedido int4 NULL,
	cd_pedido_cliente varchar(100) NULL,
	seq_item_pedido int2 NULL,
	cd_item_trans varchar(60) NULL,
	cd_destino_venda int4 NULL,
	cd_destino_cliente varchar(100) NULL,
	seq_item_destino int4 NULL,
	qtd_transferida numeric(18, 3) NULL,
	controle int2 NULL,
	dt_hora_insercao timestamp NULL,
	usuario_alteracao varchar(100) NULL,
	nome_usuario varchar(120) NULL,
	empresa_usuario int2 NULL,
	situacao_usuario_empresa varchar(15) NULL,
	observacao_usuario varchar(120) NULL
);
CREATE INDEX idx_flog_itens_transfer_data ON comercial.flog_itens_transfer USING btree (cd_pedido, seq_item_pedido, dt_hora_insercao);


-- comercial.flog_pedidos_itens_cancelados definição

-- Drop table

-- DROP TABLE comercial.flog_pedidos_itens_cancelados;

CREATE TABLE comercial.flog_pedidos_itens_cancelados (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	sku text NULL,
	cod_cancelamento_capa numeric(3) NULL,
	cod_cancelamento_item numeric(3) NULL,
	qtdcancelada numeric(38, 10) NULL,
	data_ocorrencia timestamp NULL,
	nome_programa text NULL,
	aplicacao text NULL,
	usuario_rede text NULL
);


-- comercial.flog_pedidos_itens_transferidos definição

-- Drop table

-- DROP TABLE comercial.flog_pedidos_itens_transferidos;

CREATE TABLE comercial.flog_pedidos_itens_transferidos (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	desc_tipo_ocorrencia text NULL,
	sequencia_origem numeric(38, 10) NULL,
	sequencia_destino numeric(38, 10) NULL,
	produto_destino text NULL,
	pedido_destino numeric(38, 10) NULL,
	sku text NULL,
	qtd_transferida numeric(38, 10) NULL,
	cod_cancelamento numeric(38, 10) NULL,
	desc_canc_item text NULL,
	data_ocorr timestamp NULL,
	nome_programa text NULL,
	usuario_rede text NULL,
	nome_usuario text NULL
);
CREATE INDEX flog_pedidos_itens_transferidos_numero_pedido_idx ON comercial.flog_pedidos_itens_transferidos USING btree (numero_pedido, seq_item_pedido, data_ocorr);


-- comercial.fmeta_categorias_orion definição

-- Drop table

-- DROP TABLE comercial.fmeta_categorias_orion;

CREATE TABLE comercial.fmeta_categorias_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	id text NULL,
	cod_canal numeric(6) NULL,
	canal text NULL,
	cod_representante numeric(6) NULL,
	tipo_meta numeric(1) NULL,
	valor_categoria_1 numeric(12, 4) NULL,
	valor_categoria_2 numeric(12, 4) NULL,
	valor_categoria_3 numeric(12, 4) NULL,
	valor_categoria_4 numeric(12, 4) NULL,
	valor_categoria_5 numeric(12, 4) NULL,
	valor_categoria_6 numeric(12, 4) NULL,
	valor_categoria_7 numeric(12, 4) NULL,
	valor_categoria_8 numeric(12, 4) NULL,
	valor_categoria_9 numeric(12, 4) NULL,
	valor_categoria_10 numeric(12, 4) NULL
);


-- comercial.fmeta_estacao_orion definição

-- Drop table

-- DROP TABLE comercial.fmeta_estacao_orion;

CREATE TABLE comercial.fmeta_estacao_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	cod_canal numeric(6) NULL,
	canal text NULL,
	cod_representante numeric(6) NULL,
	descricao_rep text NULL,
	tipo_meta numeric(3) NULL,
	meta numeric(9, 2) NULL
);


-- comercial.fmeta_representante definição

-- Drop table

-- DROP TABLE comercial.fmeta_representante;

CREATE TABLE comercial.fmeta_representante (
	cod_estacao int4 NULL,
	descricao varchar(150) NULL,
	tabela_preco varchar(35) NULL,
	cod_representante int4 NULL,
	descricao_rep varchar(100) NULL,
	cod_canal int4 NULL,
	canal varchar(50) NULL,
	tipo_meta int2 NULL,
	meta numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.fmeta_representante_orion definição

-- Drop table

-- DROP TABLE comercial.fmeta_representante_orion;

CREATE TABLE comercial.fmeta_representante_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	cod_canal numeric(6) NULL,
	canal text NULL,
	cod_representante numeric(6) NULL,
	descricao_rep text NULL,
	tipo_meta numeric(3) NULL,
	meta numeric(9, 2) NULL
);


-- comercial.fmeta_tabpreco_orion definição

-- Drop table

-- DROP TABLE comercial.fmeta_tabpreco_orion;

CREATE TABLE comercial.fmeta_tabpreco_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	id text NULL,
	col_tab numeric(3) NULL,
	mes_tab numeric(3) NULL,
	seq_tab numeric(3) NULL
);


-- comercial.fmovimentos_lojas_usa definição

-- Drop table

-- DROP TABLE comercial.fmovimentos_lojas_usa;

CREATE TABLE comercial.fmovimentos_lojas_usa (
	id varchar(100) NULL,
	"name" varchar(50) NULL,
	createdat timestamp NULL,
	processedat timestamp NULL,
	customer varchar(100) NULL,
	sourceidentifier varchar(150) NULL,
	confirmed bool NULL,
	paymentgatewaynames varchar(255) NULL,
	currencycode varchar(20) NULL,
	financialstatus varchar(50) NULL,
	subtotalamount numeric(18, 3) NULL,
	totaldiscountsamount numeric(18, 3) NULL,
	totaltaxamount numeric(18, 3) NULL,
	valorfaturamento numeric(18, 3) NULL,
	valorrefund numeric(18, 3) NULL,
	valorcaixa numeric(18, 3) NULL,
	sku varchar(100) NULL,
	product varchar(200) NULL,
	quantity int4 NULL,
	originalunitpriceamount numeric(18, 3) NULL,
	store varchar(50) NULL
);


-- comercial.fnotas_canceladas definição

-- Drop table

-- DROP TABLE comercial.fnotas_canceladas;

CREATE TABLE comercial.fnotas_canceladas (
	serie_nota_fisc varchar(3) NULL,
	num_nota_fiscal int4 NULL,
	num_pedido int4 NULL,
	data_emissao timestamp NULL,
	cod_canc_nfisc int2 NULL,
	motivo_cancel varchar(30) NULL,
	situacao_duplic int2 NULL,
	situacao varchar(12) NULL,
	flag varchar(32) NULL,
	natur_operacao int2 NULL,
	descr_nat_oper varchar(40) NULL,
	pk_cliente varchar(4000) NULL,
	cod_forma_pagto int2 NULL,
	desc_forma_pagto varchar(30) NULL,
	cod_cond_pgto int2 NULL,
	desc_cond_pgto varchar(30) NULL,
	qtde_itens int4 NULL,
	valor_desconto numeric(18, 3) NULL,
	valor_itens_nfis numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.fnotas_venda_produtos definição

-- Drop table

-- DROP TABLE comercial.fnotas_venda_produtos;

CREATE TABLE comercial.fnotas_venda_produtos (
	nf_serienotafiscal varchar(3) NULL,
	nf_notafiscal int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_cdempresa int8 NULL,
	pk_cliente varchar(25) NULL,
	nf_dataemissao timestamp NULL,
	data_embarque timestamp NULL,
	desc_forma_pgto varchar(30) NULL,
	nf_condpgto int2 NULL,
	desc_condpgto varchar(30) NULL,
	nf_cod_situacao int8 NULL,
	nf_desc_situacao varchar(10) NULL,
	canal varchar(100) NULL,
	modalidade varchar(50) NULL,
	nf_cod_natureza int2 NULL,
	uf varchar(2) NULL,
	desc_nat_oper varchar(40) NULL,
	tipo_nota varchar(32) NULL,
	ultima_atualizacao timestamp NULL,
	pk_produto varchar(18) NULL,
	nf_nrseqitempedido int8 NULL,
	nf_formapgto int8 NULL,
	itemnf_qtdfaturada numeric(18, 3) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlr_contabil numeric(18, 3) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	itemnf_vlr_franchising numeric(18, 3) NULL,
	cod_representante int4 NULL
);


-- comercial.fpaypal_liberadas definição

-- Drop table

-- DROP TABLE comercial.fpaypal_liberadas;

CREATE TABLE comercial.fpaypal_liberadas (
	id numeric(9) NULL,
	usuario_liberador text NULL,
	data_liberacao timestamp NULL,
	data_insercao timestamp NULL,
	nota_fiscal numeric(9) NULL,
	serie_nota text NULL,
	status numeric(1) NULL,
	cliente text NULL,
	nome_cliente text NULL,
	cod_empresa text NULL,
	cgc_9 numeric(9) NULL,
	cgc_4 numeric(4) NULL,
	cgc_2 numeric(2) NULL,
	cond_pagamento text NULL,
	valor_nota numeric(38, 10) NULL,
	pedido_refaturamento numeric(38, 10) NULL,
	representante text NULL,
	tipo_cliente text NULL,
	origem text NULL,
	canal text NULL
);


-- comercial.fpaypal_nao_liberadas definição

-- Drop table

-- DROP TABLE comercial.fpaypal_nao_liberadas;

CREATE TABLE comercial.fpaypal_nao_liberadas (
	id numeric(9) NULL,
	usuario_liberador text NULL,
	data_liberacao timestamp NULL,
	data_insercao timestamp NULL,
	nota_fiscal numeric(9) NULL,
	serie_nota text NULL,
	status numeric(1) NULL,
	cpf_cnpj_cliente text NULL,
	nome_cliente text NULL,
	cod_empresa text NULL,
	cgc_9 numeric(9) NULL,
	cgc_4 numeric(4) NULL,
	cgc_2 numeric(2) NULL,
	cond_pagamento text NULL,
	valor_nota numeric(38, 10) NULL,
	pedido_refaturamento numeric(38, 10) NULL,
	representante text NULL,
	tipo_cliente text NULL,
	dias_emissao numeric(38, 10) NULL,
	origem text NULL,
	canal text NULL,
	volume numeric(38, 10) NULL
);


-- comercial.fpedido definição

-- Drop table

-- DROP TABLE comercial.fpedido;

CREATE TABLE comercial.fpedido (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX idx_cdpedido_ped ON comercial.fpedido USING btree (ped_cdpedido);
CREATE INDEX idx_live_pedido_o_d ON comercial.fpedido USING btree (ped_pedidoorigem, ped_dataembarque);
CREATE INDEX idx_pred_pedido ON comercial.fpedido USING btree (fk_produto, ped_cdpedido);


-- comercial.fpedido_showroom definição

-- Drop table

-- DROP TABLE comercial.fpedido_showroom;

CREATE TABLE comercial.fpedido_showroom (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL,
	showroom_id int4 NULL
);


-- comercial.fpedido_situacao_bloqueio definição

-- Drop table

-- DROP TABLE comercial.fpedido_situacao_bloqueio;

CREATE TABLE comercial.fpedido_situacao_bloqueio (
	pedido_venda numeric(9) NULL,
	seq_situacao numeric(2) NULL,
	codigo_situacao numeric(2) NULL,
	data_situacao timestamp NULL,
	flag_liberacao text NULL,
	desc_liberacao text NULL,
	data_liberacao timestamp NULL,
	responsavel text NULL,
	observacao text NULL,
	usuario_bloqueio text NULL,
	executa_trigger numeric(1) NULL
);


-- comercial.fpedidos_capa definição

-- Drop table

-- DROP TABLE comercial.fpedidos_capa;

CREATE TABLE comercial.fpedidos_capa (
	pedido_venda int4 NULL,
	codigo_empresa int2 NULL,
	data_emissao timestamp NULL,
	data_embarque timestamp NULL,
	cd_representante int4 NULL,
	descr_nat_oper varchar(40) NULL,
	tipo_carteira varchar(32) NULL,
	estado_atual varchar(10) NULL,
	cod_cancelamento int2 NULL,
	motivo varchar(60) NULL,
	canal varchar(100) NULL,
	desc_cond_pgto varchar(30) NULL,
	cod_forma_pagto int4 NULL,
	desc_forma_pgto varchar(30) NULL,
	situacao_venda int2 NULL,
	desc_situacao_venda varchar(37) NULL,
	tipo_comissao int2 NULL,
	percent_comissao numeric(18, 3) NULL,
	tabela_preco varchar(35) NULL,
	cod_cidade int4 NULL,
	qtde_saldo_pedi numeric(18, 3) NULL,
	qtde_total_pedi numeric(18, 3) NULL,
	valor_saldo_pedi numeric(17, 2) NULL,
	valor_liquido numeric(17, 2) NULL,
	valor_bruto numeric(17, 2) NULL,
	ultima_atualizacao timestamp NULL,
	cnpj_cliente varchar(30) NULL
);


-- comercial.fpedidos_em_aberto definição

-- Drop table

-- DROP TABLE comercial.fpedidos_em_aberto;

CREATE TABLE comercial.fpedidos_em_aberto (
	sku varchar(20) NULL,
	codigo_empresa varchar(3) NULL,
	data_emissao timestamp NULL,
	data_embarque timestamp NULL,
	descr_nat_oper varchar(60) NULL,
	cod_cancelamento varchar(3) NULL,
	motivo varchar(60) NULL,
	situacao_venda varchar(2) NULL,
	desc_situacao_venda varchar(40) NULL,
	estado_atual varchar(15) NULL,
	quantidade_pedido int8 NULL,
	qtdcancelada int8 NULL,
	qtdsaldopedido int8 NULL,
	ultima_atualizacao timestamp NULL,
	pedido_venda varchar(20) NULL,
	canal varchar(35) NULL
);


-- comercial.fpedidos_itens_cancelados definição

-- Drop table

-- DROP TABLE comercial.fpedidos_itens_cancelados;

CREATE TABLE comercial.fpedidos_itens_cancelados (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	desc_tipo_ocorrencia text NULL,
	sku text NULL,
	qtde_pedida_old numeric(16, 3) NULL,
	qtde_pedida_new numeric(16, 3) NULL,
	cod_cancelamento numeric(3) NULL,
	desc_canc_pedido text NULL,
	data_ocorr timestamp NULL,
	nome_programa text NULL,
	usuario_rede text NULL,
	nome_usuario text NULL,
	empresa_usuario numeric(3) NULL,
	situacao_usuario_empresa text NULL,
	observacao_usuario text NULL
);


-- comercial.fpedidos_refaturados definição

-- Drop table

-- DROP TABLE comercial.fpedidos_refaturados;

CREATE TABLE comercial.fpedidos_refaturados (
	pedido numeric(9) NULL,
	cnpj_cliente text NULL,
	notaref numeric(9) NULL,
	dataemissaoref text NULL,
	condpagtoref text NULL,
	notadevolucao numeric(9) NULL,
	motivo text NULL,
	usuariocardex text NULL,
	notageradaref numeric(9) NULL,
	dataemissaonotageradaref text NULL,
	condpagtonotageradaref text NULL,
	valornota numeric(13, 2) NULL
);


-- comercial.frastreio_entrega_loja definição

-- Drop table

-- DROP TABLE comercial.frastreio_entrega_loja;

CREATE TABLE comercial.frastreio_entrega_loja (
	pedido_venda int4 NULL,
	serie_nota_fiscal varchar(3) NULL,
	numero_nota_fiscal int4 NULL,
	numero_minuta int4 NULL,
	rastreador_tms varchar(100) NULL,
	ultima_atualizacao timestamp NULL,
	data_envio timestamp NULL
);


-- comercial.fregiao_representante definição

-- Drop table

-- DROP TABLE comercial.fregiao_representante;

CREATE TABLE comercial.fregiao_representante (
	cod_representante int4 NULL,
	cod_cidade int4 NULL,
	cod_adm int4 NULL,
	nome_adm varchar(40) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.fsaldos_estoque_mes definição

-- Drop table

-- DROP TABLE comercial.fsaldos_estoque_mes;

CREATE TABLE comercial.fsaldos_estoque_mes (
	codigo_deposito int2 NULL,
	desc_deposito varchar(30) NULL,
	pk_produto varchar(30) NULL,
	nivel_produto varchar(1) NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	mes_ano_movimento timestamp NULL,
	ano_movimento int2 NULL,
	mes_movimento int2 NULL,
	saldo_fisico numeric(18, 3) NULL,
	saldo_financeiro numeric(18, 3) NULL,
	saldo_financeiro_estimado numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- comercial.fshopify_movimentacoes_ecom_internacional definição

-- Drop table

-- DROP TABLE comercial.fshopify_movimentacoes_ecom_internacional;

CREATE TABLE comercial.fshopify_movimentacoes_ecom_internacional (
	numero_pedido numeric(20) NULL,
	order_date timestamp NULL,
	tms_tracker text NULL,
	carrier_tracker text NULL,
	trasnportadora text NULL,
	"type" text NULL,
	country_code text NULL,
	country text NULL,
	currency text NULL,
	shipping_value float8 NULL,
	current_total_duties float8 NULL,
	total_tax float8 NULL,
	total_discounts float8 NULL,
	current_subtotal_price float8 NULL,
	valor_total_pedido float8 NULL,
	valor_pago float8 NULL
);


-- comercial.fshopify_orders definição

-- Drop table

-- DROP TABLE comercial.fshopify_orders;

CREATE TABLE comercial.fshopify_orders (
	id int8 NULL,
	shopify_id int8 NULL,
	order_number int8 NULL,
	order_date timestamp NULL,
	customer_id int8 NULL,
	source_identifier varchar(200) NULL,
	confirmed int8 NULL,
	payment_gateway_names varchar(200) NULL,
	currency varchar(255) NULL,
	total_discounts numeric(18, 3) NULL,
	total_price numeric(18, 3) NULL
);


-- comercial.fshopify_orders_itens definição

-- Drop table

-- DROP TABLE comercial.fshopify_orders_itens;

CREATE TABLE comercial.fshopify_orders_itens (
	order_id int8 NULL,
	sku varchar(50) NULL,
	shopify_product_id int8 NULL,
	quantity int4 NULL,
	price numeric(17, 2) NULL,
	desconto_code varchar(40) NULL,
	desconto_valor numeric(17, 2) NULL
);


-- comercial.ftitulos_venda definição

-- Drop table

-- DROP TABLE comercial.ftitulos_venda;

CREATE TABLE comercial.ftitulos_venda (
	pedido_venda int4 NULL,
	serie_nota_fisc varchar(3) NULL,
	nf_notafiscal int4 NULL,
	num_nota_fiscal int8 NULL,
	sequencia int2 NULL,
	cod_forma_pagto int2 NULL,
	desc_forma_pgto varchar(30) NULL,
	situacao_duplic int2 NULL,
	desc_situacao varchar(12) NULL,
	valor_duplicata numeric(18, 3) NULL,
	saldo_duplicata numeric(18, 3) NULL,
	valor_pago numeric(18, 3) NULL,
	historico_pgto int2 NULL,
	historico_contab varchar(30) NULL,
	ultima_atualizacao timestamp NULL
);

-- DROP SCHEMA estoque;

CREATE SCHEMA estoque AUTHORIZATION postgres;
-- estoque.dtipo_movimentacaoestoque definição

-- Drop table

-- DROP TABLE estoque.dtipo_movimentacaoestoque;

CREATE TABLE estoque.dtipo_movimentacaoestoque (
	codigo_transacao numeric(3) NULL,
	descricao text NULL,
	tipo_transacao text NULL
);


-- estoque.fcigam_saldo_estoque_atual definição

-- Drop table

-- DROP TABLE estoque.fcigam_saldo_estoque_atual;

CREATE TABLE estoque.fcigam_saldo_estoque_atual (
	loja text NULL,
	cnpj text NULL,
	cod_barras text NULL,
	codigo_barras_ean text NULL,
	qtd_estoque numeric(6) NULL,
	data_estoque timestamp NULL,
	id_rede numeric(6) NULL,
	nome_loja text NULL,
	situacao numeric(1) NULL,
	mes_ano text NULL,
	ultima_atualizacao timestamp NULL
);


-- estoque.fentrada_op_estoque definição

-- Drop table

-- DROP TABLE estoque.fentrada_op_estoque;

CREATE TABLE estoque.fentrada_op_estoque (
	data_movimento timestamp NULL,
	sku varchar(20) NULL,
	ordem_producao varchar(10) NULL,
	quantidade_entrada int8 NULL,
	valor_monetario_entrada numeric(18, 3) NULL
);


-- estoque.finventario_contabil definição

-- Drop table

-- DROP TABLE estoque.finventario_contabil;

CREATE TABLE estoque.finventario_contabil (
	empresa int4 NULL,
	deposito int4 NULL,
	descr_deposito varchar(255) NULL,
	nivel varchar(50) NULL,
	grupo varchar(50) NULL,
	subgrupo varchar(50) NULL,
	item varchar(50) NULL,
	unidade_medida varchar(10) NULL,
	narrativa varchar(255) NULL,
	saldo_fisico numeric(18, 4) NULL,
	custo_medio numeric(18, 6) NULL,
	saldo numeric(18, 6) NULL,
	mes_ano_movimento date NULL,
	ultima_atualizacao date NULL
);


-- estoque.freserva_estoque definição

-- Drop table

-- DROP TABLE estoque.freserva_estoque;

CREATE TABLE estoque.freserva_estoque (
	nivel_estrutura text NULL,
	grupo_estrutura text NULL,
	subgru_estrutura text NULL,
	item_estrutura text NULL,
	ordem_producao numeric(9) NULL,
	codigo_estagio numeric(5) NULL,
	quantidade_reservada numeric(38, 10) NULL
);


-- estoque.freserva_tinturaria definição

-- Drop table

-- DROP TABLE estoque.freserva_tinturaria;

CREATE TABLE estoque.freserva_tinturaria (
	ordem_agrupamento varchar(10) NULL,
	ordem_de_producao varchar(10) NULL,
	data_de_emissao timestamp NULL,
	nivel_composicao varchar(3) NULL,
	grupo_composicao varchar(10) NULL,
	subgrupo_composicao varchar(10) NULL,
	item_composicao varchar(10) NULL,
	qtd_requistada numeric(18, 3) NULL,
	deposito varchar(10) NULL,
	data_emissao timestamp NULL,
	codigo_estagio varchar(5) NULL
);


-- estoque.frolos_estoq definição

-- Drop table

-- DROP TABLE estoque.frolos_estoq;

CREATE TABLE estoque.frolos_estoq (
	codigo_rolo int4 NULL,
	periodo_producao int2 NULL,
	turno_producao int2 NULL,
	cod_nuance varchar(3) NULL,
	numero_lote varchar(15) NULL,
	ordem_producao int4 NULL,
	tecido varchar(111) NULL,
	codigo_deposito int2 NULL,
	qualidade_rolo int2 NULL,
	endereco_rolo varchar(30) NULL,
	qualidade int2 NULL,
	data_entrada timestamp NULL,
	data_prod_tecel timestamp NULL,
	ultima_atualizacao timestamp NULL,
	ordem_producao_dm int4 NULL,
	area_producao int2 NULL,
	observacao varchar(500) NULL,
	rolo_estoque numeric(18, 3) NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	peso_bruto numeric(18, 3) NULL,
	peso_liquido_real numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	largura numeric(18, 3) NULL,
	gramatura numeric(18, 3) NULL,
	unidade_medida varchar(5) NULL
);


-- estoque.frolos_estoq_cong definição

-- Drop table

-- DROP TABLE estoque.frolos_estoq_cong;

CREATE TABLE estoque.frolos_estoq_cong (
	codigo_rolo int4 NULL,
	periodo_producao int2 NULL,
	turno_producao int2 NULL,
	cod_nuance varchar(3) NULL,
	numero_lote varchar(15) NULL,
	ordem_producao int4 NULL,
	tecido varchar(111) NULL,
	codigo_deposito int2 NULL,
	qualidade_rolo int2 NULL,
	endereco_rolo varchar(30) NULL,
	qualidade int2 NULL,
	data_entrada timestamp NULL,
	data_prod_tecel timestamp NULL,
	ultima_atualizacao timestamp NULL,
	ordem_producao_dm int4 NULL,
	area_producao int2 NULL,
	observacao varchar(500) NULL,
	rolo_estoque numeric(18, 3) NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	peso_bruto numeric(18, 3) NULL,
	peso_liquido_real numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	largura numeric(18, 3) NULL,
	gramatura numeric(18, 3) NULL,
	unidade_medida varchar(5) NULL
);


-- estoque.fsaldoestoqueatual definição

-- Drop table

-- DROP TABLE estoque.fsaldoestoqueatual;

CREATE TABLE estoque.fsaldoestoqueatual (
	cd_empresa int2 NULL,
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(3) NULL,
	fk_produto varchar(18) NULL,
	dt_ult_entrada timestamp NULL,
	dt_ult_saida timestamp NULL,
	ultima_atualizacao timestamp NULL,
	codigo_barras varchar(16) NULL,
	qtd_empenhada numeric(18, 3) NULL,
	qtd_est_atual numeric(18, 3) NULL,
	qtd_disponivel numeric(18, 3) NULL,
	qtd_sugerida numeric(18, 3) NULL,
	valor_em_estoque float8 NULL
);


-- estoque.fsaldoestoqueatual_cong definição

-- Drop table

-- DROP TABLE estoque.fsaldoestoqueatual_cong;

CREATE TABLE estoque.fsaldoestoqueatual_cong (
	cd_empresa numeric(3) NULL,
	cd_deposito numeric(3) NULL,
	cd_nivel_estrutura text NULL,
	fk_produto text NULL,
	dt_ult_entrada timestamp NULL,
	dt_ult_saida timestamp NULL,
	qtd_empenhada numeric(13, 3) NULL,
	qtd_est_atual numeric(13, 3) NULL,
	qtd_disponivel numeric(38, 10) NULL,
	qtd_sugerida numeric(13, 3) NULL,
	ultima_atualizacao timestamp NULL,
	data_congelamento timestamp NULL,
	valor_em_estoque numeric(38, 10) NULL,
	codigo_barras text NULL
);


-- estoque.fsaldoestoqueinteg definição

-- Drop table

-- DROP TABLE estoque.fsaldoestoqueinteg;

CREATE TABLE estoque.fsaldoestoqueinteg (
	loja varchar(5) NULL,
	cnpj varchar(20) NULL,
	cod_barras varchar(20) NULL,
	codigo_barras_ean varchar(30) NULL,
	qtd_estoque numeric(18, 3) NULL,
	data_estoque timestamp NULL,
	rede varchar(20) NULL,
	fantasia varchar(100) NULL,
	sku varchar(111) NULL,
	tamanho varchar(3) NULL,
	refcor varchar(11) NULL,
	situacao varchar(1) NULL,
	mes_ano varchar(75) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX idx_fsaldo_data_loja_sku ON estoque.fsaldoestoqueinteg USING btree (data_estoque, loja, sku);
CREATE INDEX idx_fsaldo_loja_data_desc ON estoque.fsaldoestoqueinteg USING btree (loja, data_estoque DESC);
CREATE INDEX idx_fsaldo_loja_data_qtd_neq0 ON estoque.fsaldoestoqueinteg USING btree (loja, data_estoque) WHERE (qtd_estoque <> (0)::numeric);
CREATE INDEX idx_fsaldoestoqueinteg_cod_barras_left11 ON estoque.fsaldoestoqueinteg USING btree ("left"((cod_barras)::text, 11));
CREATE INDEX idx_live_data_estoque ON estoque.fsaldoestoqueinteg USING btree (data_estoque);
CREATE INDEX idx_live_data_qtd_estoque ON estoque.fsaldoestoqueinteg USING btree (data_estoque, qtd_estoque);
CREATE INDEX idx_live_loja ON estoque.fsaldoestoqueinteg USING btree (loja);
CREATE INDEX idx_live_qtd_positivo_estoque ON estoque.fsaldoestoqueinteg USING btree (data_estoque) WHERE (qtd_estoque > (0)::numeric);


-- estoque.ftecidos_estoque definição

-- Drop table

-- DROP TABLE estoque.ftecidos_estoque;

CREATE TABLE estoque.ftecidos_estoque (
	cd_tecido varchar(30) NULL,
	nome_grupo varchar(30) NULL,
	nome_cor varchar(20) NULL,
	colecao varchar(20) NULL,
	linha varchar(40) NULL,
	artigo varchar(25) NULL,
	gramatura numeric(18, 3) NULL,
	certificacao_qualidade int2 NULL,
	codigo_deposito int2 NULL,
	rolo_estoque int2 NULL,
	codigo_rolo int4 NULL,
	unidade_medida varchar(2) NULL,
	qualidade_rolo int2 NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);

-- DROP SCHEMA eventos;

CREATE SCHEMA eventos AUTHORIZATION "Gustavo_Puc";

-- DROP SEQUENCE eventos.ditens_carrinho_id_seq;

CREATE SEQUENCE eventos.ditens_carrinho_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- eventos.dinfo_eventos definição

-- Drop table

-- DROP TABLE eventos.dinfo_eventos;

CREATE TABLE eventos.dinfo_eventos (
	id int8 NULL,
	nome_evento text NULL,
	nome text NULL,
	primeira_corrida text NULL,
	email text NULL,
	cpf varchar(20) NULL,
	cpf_responsavel varchar(20) NULL,
	data_aniversario date NULL,
	genero varchar(20) NULL,
	pcd int4 NULL,
	celular varchar(20) NULL,
	kit text NULL,
	subtotal numeric(12, 2) NULL,
	desconto numeric(12, 2) NULL,
	total numeric(12, 2) NULL,
	nome_time text NULL,
	informacao_adicional text NULL,
	status varchar(50) NULL,
	origem varchar(50) NULL,
	numer_peito varchar(50) NULL,
	check_in varchar(20) NULL,
	data_registro timestamp NULL
);


-- eventos.ditens_carrinho definição

-- Drop table

-- DROP TABLE eventos.ditens_carrinho;

CREATE TABLE eventos.ditens_carrinho (
	id serial4 NOT NULL,
	id_cart int4 NULL,
	order_id int4 NULL,
	event_id int4 NULL,
	order_date date NULL,
	"name" varchar(100) NULL,
	"size" varchar(20) NULL,
	price_full numeric NULL,
	price_paid numeric NULL,
	discount numeric NULL,
	CONSTRAINT ditens_carrinho_pkey PRIMARY KEY (id)
);


-- eventos.fcreditos_eventos definição

-- Drop table

-- DROP TABLE eventos.fcreditos_eventos;

CREATE TABLE eventos.fcreditos_eventos (
	cod_empresa numeric(3) NULL,
	exercicio numeric(4) NULL,
	numero_lanc numeric(9) NULL,
	seq_lanc numeric(5) NULL,
	origem numeric(2) NULL,
	lote numeric(5) NULL,
	periodo numeric(4) NULL,
	conta_contabil text NULL,
	conta_reduzida numeric(5) NULL,
	subconta numeric(4) NULL,
	centro_custo numeric(6) NULL,
	debito_credito text NULL,
	hist_contabil numeric(4) NULL,
	compl_histor1 text NULL,
	data_lancto timestamp NULL,
	valor_lancto numeric(15, 2) NULL,
	filial_lancto numeric(3) NULL,
	contabilizado numeric(1) NULL,
	data_contab timestamp NULL,
	documento numeric(9) NULL,
	datainsercao timestamp NULL
);


-- eventos.fdebitos_eventos definição

-- Drop table

-- DROP TABLE eventos.fdebitos_eventos;

CREATE TABLE eventos.fdebitos_eventos (
	cod_empresa numeric(3) NULL,
	exercicio numeric(4) NULL,
	numero_lanc numeric(9) NULL,
	seq_lanc numeric(5) NULL,
	origem numeric(2) NULL,
	lote numeric(5) NULL,
	periodo numeric(4) NULL,
	conta_contabil text NULL,
	conta_reduzida numeric(5) NULL,
	subconta numeric(4) NULL,
	centro_custo numeric(6) NULL,
	debito_credito text NULL,
	hist_contabil numeric(4) NULL,
	compl_histor1 text NULL,
	data_lancto timestamp NULL,
	valor_lancto numeric(15, 2) NULL,
	filial_lancto numeric(3) NULL,
	contabilizado numeric(1) NULL,
	data_contab timestamp NULL,
	documento numeric(9) NULL,
	datainsercao timestamp NULL
);


-- eventos.fexperience_events definição

-- Drop table

-- DROP TABLE eventos.fexperience_events;

CREATE TABLE eventos.fexperience_events (
	id int8 NULL,
	event_id int8 NULL,
	event_name text NULL,
	event_status text NULL,
	event_type text NULL,
	modality text NULL,
	registration_limit int8 NULL,
	distance text NULL,
	start_time text NULL,
	min_subscription_age int8 NULL,
	max_subscription_age int8 NULL,
	event_date date NULL,
	subscriptions_opened date NULL,
	subscriptions_closed date NULL,
	event_address text NULL,
	event_photo text NULL,
	results_link text NULL,
	start_location text NULL,
	"map" text NULL,
	event_description text NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL
);


-- eventos.fexperience_registrations definição

-- Drop table

-- DROP TABLE eventos.fexperience_registrations;

CREATE TABLE eventos.fexperience_registrations (
	id int8 NULL,
	event_id int8 NULL,
	modality text NULL,
	distance text NULL,
	chest_number text NULL,
	store_cnpj text NULL,
	store_name text NULL,
	cpf_cnpj text NULL,
	birthday date NULL,
	gender text NULL,
	order_date timestamp NULL,
	order_id text NULL,
	order_status text NULL,
	coupon text NULL,
	coupon_group text NULL,
	payment_type text NULL,
	kit text NULL,
	cart_items text NULL,
	price_paid float8 NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL
);


-- eventos.fnotas_compras_eventos definição

-- Drop table

-- DROP TABLE eventos.fnotas_compras_eventos;

CREATE TABLE eventos.fnotas_compras_eventos (
	serie text NULL,
	documento numeric(9) NULL,
	sequencia numeric(9) NULL,
	centro_custo numeric(9) NULL,
	nome_centro_custo text NULL,
	especie_docto text NULL,
	data_transacao timestamp NULL,
	data_emissao timestamp NULL,
	cod_produto text NULL,
	descricao_item text NULL,
	desc_natureza_oper text NULL,
	cod_situacao_nota numeric(1) NULL,
	desc_situacao_nota text NULL,
	codigo_cancelamento_pedido numeric(2) NULL,
	desc_cancelamento_pedido text NULL,
	data_canc_nfisc timestamp NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL,
	cod_tipo_fornecedor numeric(4) NULL,
	desc_tipo_fornecedor text NULL,
	desc_cond_pgto text NULL,
	unidade_medida text NULL,
	quantidade numeric(14, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	valor_total numeric(15, 2) NULL,
	data_atualizacao timestamp NULL
);


-- eventos.fpedidos_compra_eventos definição

-- Drop table

-- DROP TABLE eventos.fpedidos_compra_eventos;

CREATE TABLE eventos.fpedidos_compra_eventos (
	pedido_compra numeric(6) NULL,
	seq_item_pedido numeric(3) NULL,
	numero_compra_obc text NULL,
	num_requisicao numeric(6) NULL,
	centro_custo numeric(6) NULL,
	nome_centro_custo text NULL,
	data_prev_entr timestamp NULL,
	dt_emis_ped_comp timestamp NULL,
	cod_produto text NULL,
	descricao_item text NULL,
	cod_situacao_nota numeric(1) NULL,
	sts_pedido_desc text NULL,
	codigo_cancelamento_pedido numeric(2) NULL,
	desc_cancelamento_pedido text NULL,
	codigo_cancelamento_item numeric(2) NULL,
	desc_cancelamento_item text NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL,
	cod_tipo_fornecedor numeric(4) NULL,
	desc_tipo_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_saldo_item numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	preco_item_comp numeric(15, 5) NULL,
	data_atualizacao timestamp NULL
);


-- eventos.ftitulos_compras_eventos definição

-- Drop table

-- DROP TABLE eventos.ftitulos_compras_eventos;

CREATE TABLE eventos.ftitulos_compras_eventos (
	documento varchar(10) NULL,
	centro_custo varchar(10) NULL,
	nome_centro_custo varchar(40) NULL,
	especie_docto varchar(5) NULL,
	data_transacao timestamp NULL,
	data_emissao timestamp NULL,
	codigo_contabil varchar(10) NULL,
	codigo_cancelamento_pedido varchar(5) NULL,
	desc_cancelamento_pedido varchar(80) NULL,
	data_canc_tit timestamp NULL,
	cnpj_fornecedor varchar(15) NULL,
	nome_fornecedor varchar(60) NULL,
	cod_tipo_fornecedor varchar(4) NULL,
	forn_descricao varchar(40) NULL,
	cond_pagto varchar(3) NULL,
	valor_parcela numeric(17, 2) NULL
);

-- DROP SCHEMA expedicao;

CREATE SCHEMA expedicao AUTHORIZATION postgres;
-- expedicao.dondas_pwt definição

-- Drop table

-- DROP TABLE expedicao.dondas_pwt;

CREATE TABLE expedicao.dondas_pwt (
	id_onda int4 NULL,
	descricao_onda text NULL,
	situacao_onda varchar(20) NULL,
	qtd_coletar_item numeric(15, 2) NULL,
	qtd_coletada_item numeric(15, 2) NULL,
	qtd_pedido numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- expedicao.dondas_slim_sorter definição

-- Drop table

-- DROP TABLE expedicao.dondas_slim_sorter;

CREATE TABLE expedicao.dondas_slim_sorter (
	id_onda numeric(9) NULL,
	descricao_onda text NULL,
	situacao_pedido numeric(2) NULL,
	situacao_onda numeric(2) NULL,
	situacao_onda_desc text NULL,
	id_pedido numeric(9) NULL,
	id_item numeric(9) NULL,
	grupo text NULL,
	subgrupo text NULL,
	item text NULL,
	sku text NULL,
	qtd_coletar_item numeric(4) NULL,
	qtd_coletada_item numeric(4) NULL,
	situacao_item numeric(2) NULL,
	situacao_onda_item text NULL,
	usuario_situacao numeric(5) NULL,
	usuario_situacao_item text NULL,
	id_tag text NULL
);


-- expedicao.fondas_planejamento definição

-- Drop table

-- DROP TABLE expedicao.fondas_planejamento;

CREATE TABLE expedicao.fondas_planejamento (
	empresapedidoonda int4 NULL,
	dataemissaopedidoonda date NULL,
	pedidoonda int4 NULL,
	dataembarquepedidoonda date NULL,
	clientepedidoonda text NULL,
	qtdepedidoonda numeric(15, 2) NULL,
	representantepedidoonda text NULL,
	transportadorapedidoonda text NULL,
	endereco varchar(100) NULL,
	ultima_atualizacao timestamp NULL
);


-- expedicao.fondas_por_usuario definição

-- Drop table

-- DROP TABLE expedicao.fondas_por_usuario;

CREATE TABLE expedicao.fondas_por_usuario (
	id_usuario int4 NULL,
	usuario varchar(100) NULL,
	data_onda date NULL,
	id_onda int4 NULL,
	qtdeitens int4 NULL,
	ultima_atualizacao timestamp NULL,
	id varchar(10) NULL
);


-- expedicao.fondas_produtos_pendentes definição

-- Drop table

-- DROP TABLE expedicao.fondas_produtos_pendentes;

CREATE TABLE expedicao.fondas_produtos_pendentes (
	id_onda int4 NULL,
	nivel varchar(10) NULL,
	grupo varchar(10) NULL,
	subgrupo varchar(10) NULL,
	item varchar(10) NULL,
	qtd_coletar_item numeric(15, 2) NULL,
	endereco varchar(50) NULL,
	situacao_onda varchar(20) NULL,
	ultima_atualizacao date NULL
);


-- expedicao.fondas_pwt_resumo definição

-- Drop table

-- DROP TABLE expedicao.fondas_pwt_resumo;

CREATE TABLE expedicao.fondas_pwt_resumo (
	onda numeric(9) NULL,
	situacao text NULL,
	equipamento text NULL,
	data_situacao timestamp NULL,
	qtd_coletar numeric(38, 10) NULL,
	qtd_coletada numeric(38, 10) NULL,
	qtd_pedido numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);

-- DROP SCHEMA financeiro;

CREATE SCHEMA financeiro AUTHORIZATION postgres;
-- financeiro.dconsulta_nfs definição

-- Drop table

-- DROP TABLE financeiro.dconsulta_nfs;

CREATE TABLE financeiro.dconsulta_nfs (
	num_nota_fiscal varchar(50) NULL,
	serie_nota_fisc varchar(20) NULL,
	especie_docto varchar(20) NULL,
	data_base_fatur date NULL,
	data_saida date NULL,
	data_prevista date NULL,
	cod_rep_cliente varchar(50) NULL,
	pedido_venda varchar(50) NULL,
	usuario_digitacao varchar(100) NULL,
	valor_itens_nfis numeric(15, 2) NULL,
	valor_desconto numeric(15, 2) NULL,
	situacao_nfisc varchar(20) NULL
);


-- financeiro.dlancamentos_contabeis definição

-- Drop table

-- DROP TABLE financeiro.dlancamentos_contabeis;

CREATE TABLE financeiro.dlancamentos_contabeis (
	exercicio numeric(4) NULL,
	data_lancto timestamp NULL,
	cod_empresa numeric(3) NULL,
	desc_empresa text NULL,
	conta_contabil text NULL,
	conta_reduzida numeric(5) NULL,
	centro_custo numeric(6) NULL,
	desc_ccusto text NULL,
	chave numeric(9) NULL,
	seqchave numeric(5) NULL,
	cod_contabil numeric(4) NULL,
	desc_historico text NULL,
	complemento_historico text NULL,
	debito numeric(38, 10) NULL,
	credito numeric(38, 10) NULL,
	desc_plano_conta text NULL,
	ultima_atualizacao timestamp NULL
);


-- financeiro.fapuracao_notas_entrada definição

-- Drop table

-- DROP TABLE financeiro.fapuracao_notas_entrada;

CREATE TABLE financeiro.fapuracao_notas_entrada (
	codigo_empresa numeric(3) NULL,
	data_transacao timestamp NULL,
	codificacao_contabil numeric(38, 10) NULL,
	classificacao_fiscal text NULL,
	documento numeric(9) NULL,
	serie text NULL,
	cgc_cli_for_9 numeric(9) NULL,
	cgc_cli_for_4 numeric(4) NULL,
	cgc_cli_for_2 numeric(2) NULL,
	data_emissao timestamp NULL,
	tipo_valores_fiscal text NULL,
	situacao_entrada numeric(1) NULL,
	rateio_despesas numeric(15, 2) NULL,
	classif_contabil numeric(6) NULL,
	cod_natureza text NULL,
	descr_nat_oper text NULL,
	livros_fiscais numeric(1) NULL,
	divisao_natur numeric(2) NULL,
	natur_operacao numeric(3) NULL,
	estado_natoper text NULL,
	cod_vlfiscal_icm numeric(9) NULL,
	cod_vlfiscal_ipi numeric(9) NULL,
	base_diferenca numeric(15, 2) NULL,
	base_ipi numeric(15, 2) NULL,
	base_pis_cofins numeric(15, 2) NULL,
	base_icms_subs numeric(14, 2) NULL,
	base_icms numeric(15, 2) NULL,
	base_calc_icm numeric(15, 2) NULL,
	valor_total_ipi numeric(15, 2) NULL,
	valor_despesas numeric(15, 2) NULL,
	valor_frete numeric(15, 2) NULL,
	valor_desconto numeric(15, 2) NULL,
	valor_seguro numeric(15, 2) NULL,
	valor_ipi numeric(15, 2) NULL,
	valor_pis numeric(15, 2) NULL,
	valor_cofins numeric(15, 2) NULL,
	valor_icms numeric(15, 2) NULL,
	valor_total numeric(15, 2) NULL,
	valor_itens numeric(15, 2) NULL,
	desconta_ipi_icms numeric(15, 2) NULL
);


-- financeiro.fapuracao_notas_saida definição

-- Drop table

-- DROP TABLE financeiro.fapuracao_notas_saida;

CREATE TABLE financeiro.fapuracao_notas_saida (
	codigo_empresa numeric(3) NULL,
	codificacao_contabil numeric(6) NULL,
	classificacao_fiscal text NULL,
	num_nota_fiscal numeric(9) NULL,
	serie_nota_fisc text NULL,
	data_emissao timestamp NULL,
	situacao_nfisc numeric(1) NULL,
	cgc_9 numeric(9) NULL,
	cgc_4 numeric(4) NULL,
	cgc_2 numeric(2) NULL,
	tipo_nf_referenciada numeric(1) NULL,
	classif_contabil_nf_item numeric(6) NULL,
	desconta_ipi_icms numeric(1) NULL,
	classif_contabil numeric(6) NULL,
	cod_natureza text NULL,
	descr_nat_oper text NULL,
	livros_fiscais numeric(1) NULL,
	divisao_natur numeric(2) NULL,
	classific_fiscal text NULL,
	natopeno_nat_oper numeric(3) NULL,
	natopeno_est_oper text NULL,
	consiste_cvf_icms numeric(1) NULL,
	rateio_despesa numeric(15, 2) NULL,
	rateio_desc_propaganda numeric(15, 2) NULL,
	isento_outros numeric(15, 2) NULL,
	cod_justificativa numeric(1) NULL,
	cvf_icms numeric(2) NULL,
	cvf_ipi numeric(1) NULL,
	cvf_icm_diferenc numeric(9) NULL,
	base_icms numeric(15, 2) NULL,
	base_icms_difer numeric(15, 2) NULL,
	basi_pis_cofins numeric(15, 2) NULL,
	perc_icms numeric(6, 2) NULL,
	perc_ipi numeric(6, 2) NULL,
	perc_reducao_icm numeric(8, 4) NULL,
	perc_substituica numeric(5, 2) NULL,
	perc_iva_1 numeric(6, 2) NULL,
	valor_icms_difer numeric(11, 2) NULL,
	valor_ipi numeric(15, 2) NULL,
	valor_pis numeric(15, 2) NULL,
	valor_icms numeric(15, 2) NULL,
	valor_cofins numeric(15, 2) NULL,
	valor_faturado numeric(15, 2) NULL,
	valor_contabil numeric(15, 2) NULL,
	valor_unitario numeric(18, 5) NULL,
	qtde_item_fatur numeric(15, 3) NULL
);


-- financeiro.forion_orcamento definição

-- Drop table

-- DROP TABLE financeiro.forion_orcamento;

CREATE TABLE financeiro.forion_orcamento (
	id numeric(6) NULL,
	centro_custo text NULL,
	plano_ano numeric(38) NULL,
	conta text NULL,
	fornecedor text NULL,
	despesa text NULL,
	tipo_orcamento text NULL,
	cargo text NULL,
	ano numeric(4) NULL,
	mes numeric(38, 10) NULL,
	mes_ano timestamp NULL,
	quantidade numeric(3) NULL,
	valor_orcado numeric(10, 2) NULL
);


-- financeiro.ftitulos_receber_resumo definição

-- Drop table

-- DROP TABLE financeiro.ftitulos_receber_resumo;

CREATE TABLE financeiro.ftitulos_receber_resumo (
	num_titulo text NULL,
	cnpj_cliente text NULL,
	pk_cliente text NULL,
	nome_cliente text NULL,
	descricao text NULL,
	cod_situa_duplic numeric(1) NULL,
	val_desconto numeric(15, 2) NULL,
	val_pago numeric(38, 10) NULL,
	dat_ult_pagto_aux timestamp NULL
);

-- DROP SCHEMA homologacao;

CREATE SCHEMA homologacao AUTHORIZATION postgres;
-- homologacao.fvitrine_indicadores_loja definição

-- Drop table

-- DROP TABLE homologacao.fvitrine_indicadores_loja;

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


-- homologacao.fvitrine_quality_by_space definição

-- Drop table

-- DROP TABLE homologacao.fvitrine_quality_by_space;

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



-- DROP FUNCTION homologacao.sp_teste();

CREATE OR REPLACE FUNCTION homologacao.sp_teste()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
INSERT INTO homologacao.fordens_corte
	(
        cd_ordem_producao,	
        cd_nivel99,
        cd_grupo,
        cd_subgrupo,
        prod_rej_item,
        cd_estagio,
        periodo_producao, 
        cd_ordem_confeccao,
        qtd_pecas_progamada,
        qtd_pecas_produzida,
        qtd_conserto,
        qtd_pecas_2a,
        estagio_anterior,
        situacao_ordem,
        numero_ordem_externa,
        seq_ordem_serv,
        qtd_perdas,
        sequencia_estagio,
        usuario,
        seq_operacao,
        data_alteracao,
        qtd_em_producao_pacote,
        minutos_unitario,
        minutos_total,
        minutos_total_em_producao,
        tamanho,
        sequencia_tamanho,
        qtd_marcacoes,
        qtd_a_produzir,
        rowid,
        fk_produto,
        data_producao,
        fk_fornecedor, 
        dt_prevista,
        dthora_atualizacao,
        prioridade
    )
    SELECT
		cd_ordem_producao,	
		cd_nivel99,
		cd_grupo,
		cd_subgrupo,
		prod_rej_item,
		cd_estagio,
		periodo_producao, 
		cd_ordem_confeccao,
		qtd_pecas_progamada,
		qtd_pecas_produzida,
		qtd_conserto,
		qtd_pecas_2a,
		estagio_anterior,
		situacao_ordem,
		numero_ordem_externa,
		seq_ordem_serv,
		qtd_perdas,
		sequencia_estagio,
		usuario,
		seq_operacao,
		data_alteracao,
		qtd_em_producao_pacote,
		minutos_unitario,
		minutos_total,
		minutos_total_em_producao,
		tamanho,
		sequencia_tamanho,
		qtd_marcacoes,
		qtd_a_produzir,
		rowid,
		fk_produto,
		data_producao,
		fk_fornecedor, 
		dt_prevista,
		dthora_atualizacao,
		prioridade

FROM homologacao.fordens_corte_stage;
END;
$function$
;

-- DROP PROCEDURE homologacao.sp_teste2();

CREATE OR REPLACE PROCEDURE homologacao.sp_teste2()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    final_count INTEGER;
begin
INSERT INTO homologacao.fordens_corte
	(
        cd_ordem_producao,	
        cd_nivel99,
        cd_grupo,
        cd_subgrupo,
        prod_rej_item,
        cd_estagio,
        periodo_producao, 
        cd_ordem_confeccao,
        qtd_pecas_progamada,
        qtd_pecas_produzida,
        qtd_conserto,
        qtd_pecas_2a,
        estagio_anterior,
        situacao_ordem,
        numero_ordem_externa,
        seq_ordem_serv,
        qtd_perdas,
        sequencia_estagio,
        usuario,
        seq_operacao,
        data_alteracao,
        qtd_em_producao_pacote,
        minutos_unitario,
        minutos_total,
        minutos_total_em_producao,
        tamanho,
        sequencia_tamanho,
        qtd_marcacoes,
        qtd_a_produzir,
        rowid,
        fk_produto,
        data_producao,
        fk_fornecedor, 
        dt_prevista,
        dthora_atualizacao,
        prioridade
    )
    SELECT
		cd_ordem_producao,	
		cd_nivel99,
		cd_grupo,
		cd_subgrupo,
		prod_rej_item,
		cd_estagio,
		periodo_producao, 
		cd_ordem_confeccao,
		qtd_pecas_progamada,
		qtd_pecas_produzida,
		qtd_conserto,
		qtd_pecas_2a,
		estagio_anterior,
		situacao_ordem,
		numero_ordem_externa,
		seq_ordem_serv,
		qtd_perdas,
		sequencia_estagio,
		usuario,
		seq_operacao,
		data_alteracao,
		qtd_em_producao_pacote,
		minutos_unitario,
		minutos_total,
		minutos_total_em_producao,
		tamanho,
		sequencia_tamanho,
		qtd_marcacoes,
		qtd_a_produzir,
		rowid,
		fk_produto,
		data_producao,
		fk_fornecedor, 
		dt_prevista,
		dthora_atualizacao,
		prioridade

FROM homologacao.fordens_corte_stage;
	-- Analyze adicionado para deixar o commit NAO TIRAR
	analyze homologacao.fordens_corte;

	SELECT c.reltuples::bigint into final_count
	FROM   pg_class c
	JOIN   pg_namespace n ON n.oid = c.relnamespace
	WHERE  c.relname = 'fordens_corte'
	AND    n.nspname = 'homologacao';
	RAISE NOTICE 'Contagem Final: %', final_count;
END;
$procedure$
;

-- DROP SCHEMA inovacao;

CREATE SCHEMA inovacao AUTHORIZATION inovacao;

-- DROP SCHEMA jma;

CREATE SCHEMA jma AUTHORIZATION postgres;
-- jma.confer_caixas definição

-- Drop table

-- DROP TABLE jma.confer_caixas;

CREATE TABLE jma.confer_caixas (
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	data_abertura varchar(6) NULL,
	qtde_pecas_conferidas int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.daparelho definição

-- Drop table

-- DROP TABLE jma.daparelho;

CREATE TABLE jma.daparelho (
	pk_aparelho varchar(6) NULL,
	desc_aparelho varchar(50) NULL,
	obs_aparelho varchar(100) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dcanaldistribuicao definição

-- Drop table

-- DROP TABLE jma.dcanaldistribuicao;

CREATE TABLE jma.dcanaldistribuicao (
	id int4 NULL,
	descricao varchar(100) NULL,
	modalidade varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dcentro_custo definição

-- Drop table

-- DROP TABLE jma.dcentro_custo;

CREATE TABLE jma.dcentro_custo (
	cd_centro_custo int4 NULL,
	desc_centro_custo varchar(25) NULL,
	cd_desc varchar(70) NULL,
	cd_local_entrega int4 NULL,
	cd_tipo_mao_obra int2 NULL,
	cd_centro_custo_pai int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dcontas_estoque definição

-- Drop table

-- DROP TABLE jma.dcontas_estoque;

CREATE TABLE jma.dcontas_estoque (
	pk_conta_estoque int2 NULL,
	desc_conta_estoque varchar(40) NULL,
	tipo_produto_sped int2 NULL,
	itens_estoque int2 NULL,
	dthora_atualizacao timestamp NULL,
	tipo_conta_estoque int2 NULL
);


-- jma.ddeposito definição

-- Drop table

-- DROP TABLE jma.ddeposito;

CREATE TABLE jma.ddeposito (
	codigo_deposito int2 NULL,
	descricao varchar(30) NULL,
	local_deposito int2 NULL,
	cod_desc_deposito varchar(50) NULL,
	hora_atualizacao timestamp NULL
);


-- jma.dfamilia_materiais definição

-- Drop table

-- DROP TABLE jma.dfamilia_materiais;

CREATE TABLE jma.dfamilia_materiais (
	pk_familia int4 NULL,
	desc_familia varchar(25) NULL,
	desc_usuario_comprador varchar(250) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dfuncionariosinteg definição

-- Drop table

-- DROP TABLE jma.dfuncionariosinteg;

CREATE TABLE jma.dfuncionariosinteg (
	cod_vendedor int4 NULL,
	cpf_vendedor varchar(20) NULL,
	nome_vendedor varchar(100) NULL,
	cargo varchar(100) NULL,
	loja varchar(20) NULL,
	cnpj varchar(40) NULL,
	status varchar(10) NULL,
	data_admissao timestamp NULL,
	data_demissao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.dgrupo_contas definição

-- Drop table

-- DROP TABLE jma.dgrupo_contas;

CREATE TABLE jma.dgrupo_contas (
	tipo_grupo_contas int2 NULL,
	desc_grupo_contas varchar(60) NULL,
	dthora_atualizacao timestamp NULL,
	pk_grupo_contas int4 NULL,
	obs varchar(300) NULL,
	observacao_grupo_contas varchar(100) NULL
);


-- jma.dhistorico_contabil definição

-- Drop table

-- DROP TABLE jma.dhistorico_contabil;

CREATE TABLE jma.dhistorico_contabil (
	pk_historico numeric(4) NULL,
	desc_historico text NULL,
	flag_considera_regime text NULL,
	sinal_titulo numeric(1) NULL,
	sinal_diario numeric(1) NULL,
	sinal_comissao numeric(1) NULL,
	flag_entrada_saida text NULL,
	tipo_historico text NULL,
	flag_atualiza_comissao numeric(1) NULL,
	flag_atualiza_acc numeric(1) NULL,
	inf_custo numeric(1) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dmotivo_bloqueio definição

-- Drop table

-- DROP TABLE jma.dmotivo_bloqueio;

CREATE TABLE jma.dmotivo_bloqueio (
	cod_bloqueio numeric(3) NULL,
	descricao varchar(200) NULL,
	flag_bloqueio numeric(1) NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.dmotivo_cancelamento definição

-- Drop table

-- DROP TABLE jma.dmotivo_cancelamento;

CREATE TABLE jma.dmotivo_cancelamento (
	cod_canc_pedido numeric(3) NULL,
	desc_canc_pedido varchar(200) NULL,
	tp_cancelamento numeric(1) NULL,
	grupo_canc_ped numeric(3) NULL
);


-- jma.dnatureza_operacao definição

-- Drop table

-- DROP TABLE jma.dnatureza_operacao;

CREATE TABLE jma.dnatureza_operacao (
	pk_natureza int4 NULL,
	venda int2 NULL,
	devolucao int2 NULL,
	ranking int2 NULL,
	franchising int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dparadasmaquinas_marft definição

-- Drop table

-- DROP TABLE jma.dparadasmaquinas_marft;

CREATE TABLE jma.dparadasmaquinas_marft (
	"DATA" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos int4 NULL,
	codigo_motivo int2 NULL,
	motivo varchar(40) NULL,
	detalhes varchar(150) NULL,
	codigo_celula int4 NULL,
	nome_celula varchar(25) NULL,
	turno int2 NULL,
	ultima_atualizacao timestamp NULL,
	cod_operador int4 NULL,
	nome_operador varchar(50) NULL
);


-- jma.dperiodo_producao definição

-- Drop table

-- DROP TABLE jma.dperiodo_producao;

CREATE TABLE jma.dperiodo_producao (
	data_ini_periodo timestamp NULL,
	data_fim_periodo timestamp NULL,
	dias_uteis int4 NULL,
	cd_area_periodo int2 NULL,
	desc_situacao_periodo int2 NULL,
	dthora_atualizacao timestamp NULL,
	cd_periodo_producao int4 NULL,
	pk_periodo_producao varchar(85) NULL,
	cd_empresa int4 NULL,
	cd_deposito int4 NULL,
	data_ini_fatu timestamp NULL,
	data_fim_fatu timestamp NULL,
	descricao varchar(20) NULL
);
CREATE INDEX idx_dperiodo_producao_descr_ini_emp_periodo ON jma.dperiodo_producao USING btree (descricao, data_ini_periodo, cd_empresa, cd_periodo_producao);


-- jma.dprodutoproducao definição

-- Drop table

-- DROP TABLE jma.dprodutoproducao;

CREATE TABLE jma.dprodutoproducao (
	pk_produto varchar(25) NULL,
	pk_produto_cigam varchar(14) NULL,
	cd_produto varchar(16) NULL,
	cd_desc_prod varchar(80) NULL,
	nivel_estrutura int2 NULL,
	desc_nivel_estrutura varchar(30) NULL,
	cd_referencia varchar(5) NULL,
	desc_produto varchar(70) NULL,
	und_medida varchar(2) NULL,
	desc_unidade_medida varchar(20) NULL,
	nm_tamanho varchar(15) NULL,
	nm_cor varchar(25) NULL,
	cd_colecao int2 NULL,
	desc_colecao varchar(30) NULL,
	cod_linha text NULL,
	linha_produto varchar(40) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(30) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(30) NULL,
	cd_desc_referencia varchar(50) NULL,
	cod_desc_artigo varchar(50) NULL,
	cod_agrupador int2 NULL,
	desc_agrupador varchar(50) NULL,
	tipo_produto varchar(15) NULL,
	marca varchar(50) NULL,
	cd_conta_estoque int2 NULL,
	desc_conta_estoque varchar(50) NULL,
	desc_produto_narrativa varchar(90) NULL,
	cd_cor varchar(6) NULL,
	cd_tamanho varchar(5) NULL,
	desc_narrativa varchar(70) NULL,
	item_ativo int2 NULL,
	desc_referencia varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	publico_alvo varchar(60) NULL,
	faixa_etaria varchar(60) NULL,
	codigo_contabil int4 NULL,
	classific_fiscal varchar(15) NULL,
	descr_class_fisc varchar(40) NULL,
	serie_tamanho int2 NULL,
	desc_serie_tamanho varchar(10) NULL,
	obs_serie_tamanho varchar(60) NULL,
	sub_colecao varchar(20) NULL,
	familia1 varchar(80) NULL,
	familia2 varchar(80) NULL,
	familia3 varchar(80) NULL,
	familia4 varchar(80) NULL,
	familia5 varchar(80) NULL,
	dthora_atualizacao timestamp NULL,
	alternativa_item int8 NULL,
	preco_custo numeric(18, 3) NULL
);


-- jma.dsituacao_venda definição

-- Drop table

-- DROP TABLE jma.dsituacao_venda;

CREATE TABLE jma.dsituacao_venda (
	situacao_venda numeric(2) NULL,
	ultima_atualizacao timestamp NULL,
	descricao_situacao varchar(100) NULL
);


-- jma.dsituacaopedido definição

-- Drop table

-- DROP TABLE jma.dsituacaopedido;

CREATE TABLE jma.dsituacaopedido (
	cod_situacao_venda varchar(2) NULL,
	desc_situacao_venda varchar(70) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.dstatus_pedido definição

-- Drop table

-- DROP TABLE jma.dstatus_pedido;

CREATE TABLE jma.dstatus_pedido (
	status_pedido numeric(1) NULL,
	ultima_atualizacao timestamp NULL,
	descricao_status_pedido varchar(100) NULL
);


-- jma.dtabelapreco definição

-- Drop table

-- DROP TABLE jma.dtabelapreco;

CREATE TABLE jma.dtabelapreco (
	col_tabela_preco int2 NULL,
	mes_tabela_preco int2 NULL,
	seq_tabela_preco int2 NULL,
	data_inicio_tabela timestamp NULL,
	data_fim_tabela timestamp NULL,
	descricao varchar(20) NULL,
	cod_desc_tabela_preco varchar(34) NULL,
	tabela_preco int4 NULL,
	tabela_preco_cod varchar(11) NULL,
	desc_catalogo varchar(40) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.fconfer_caixas definição

-- Drop table

-- DROP TABLE jma.fconfer_caixas;

CREATE TABLE jma.fconfer_caixas (
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	qtde_pecas_conferidas int4 NULL,
	ultima_atualizacao timestamp NULL,
	data_abertura timestamp NULL
);


-- jma.fconfer_pecas_caixa definição

-- Drop table

-- DROP TABLE jma.fconfer_pecas_caixa;

CREATE TABLE jma.fconfer_pecas_caixa (
	tipo varchar(13) NULL,
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	codigo_barras varchar(16) NULL,
	produto varchar(65) NULL,
	data_bipagem timestamp NULL,
	data_bipagem_recebido timestamp NULL,
	situacao varchar(8) NULL,
	ultima_atualizacao timestamp NULL,
	sku varchar(80) NULL
);


-- jma.fconsignadainteg definição

-- Drop table

-- DROP TABLE jma.fconsignadainteg;

CREATE TABLE jma.fconsignadainteg (
	cd_loja varchar(6) NULL,
	dt_retirada timestamp NULL,
	dt_devol timestamp NULL,
	cd_status_devol varchar(8) NULL,
	qtd_consignada int4 NULL,
	vlr_preco_venda numeric(20, 4) NULL,
	vlr_perc_desconto numeric(20, 4) NULL,
	vlr_total numeric(20, 4) NULL,
	cd_vendido varchar(8) NULL,
	dthora_atualizacao timestamp NULL,
	cd_contr int4 NULL,
	dt_prev timestamp NULL,
	pk_consignado varchar(55) NULL,
	fk_produto varchar(20) NULL,
	cd_vendedor varchar(4) NULL,
	cd_loja_vendedor varchar(4) NULL,
	ds_cargo_vendedor varchar(100) NULL,
	status_vendedor varchar(10) NULL
);


-- jma.fcontrole_partes definição

-- Drop table

-- DROP TABLE jma.fcontrole_partes;

CREATE TABLE jma.fcontrole_partes (
	descricao_parte varchar(30) NULL,
	parte_conjunto int2 NULL,
	qtde_parte_peca int2 NULL,
	tipo_corte_peca int2 NULL,
	tipo_enfesto_1 int2 NULL,
	tipo_enfesto_2 int2 NULL,
	alternativa_item int2 NULL,
	sequencia int2 NULL,
	alternativa_comp int2 NULL,
	estagio int4 NULL,
	qtde_camadas int4 NULL,
	centro_custo int4 NULL,
	inf_casado int2 NULL,
	grupo_estrutura varchar(5) NULL,
	inf_sentido int2 NULL,
	inf_casado_1 int2 NULL,
	inf_desenho int2 NULL,
	referencia varchar(111) NULL,
	componente varchar(111) NULL,
	comprimento_debrum numeric(10, 2) NULL,
	largura_debrum numeric(11, 3) NULL
);


-- jma.fdre_lojas definição

-- Drop table

-- DROP TABLE jma.fdre_lojas;

CREATE TABLE jma.fdre_lojas (
	id int4 NULL,
	cnpj_loja varchar(18) NULL,
	apelido varchar(200) NULL,
	ano_dre int2 NULL,
	mes_dre int2 NULL,
	tipo_dre int2 NULL,
	propriedade varchar(150) NULL,
	val_real_ano_ant numeric(18, 3) NULL,
	perc_real_ano_ant numeric(18, 3) NULL,
	val_orcado numeric(18, 3) NULL,
	perc_orcado numeric(18, 3) NULL,
	val_real numeric(18, 3) NULL,
	perc_real numeric(18, 3) NULL,
	val_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_real_vig_ant numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	seq_consulta varchar(20) NULL
);


-- jma.fdre_orcado_lojas definição

-- Drop table

-- DROP TABLE jma.fdre_orcado_lojas;

CREATE TABLE jma.fdre_orcado_lojas (
	id int4 NULL,
	seq_consulta varchar(50) NULL,
	cnpj_loja varchar(18) NULL,
	apelido varchar(200) NULL,
	ano_orcamento int2 NULL,
	mes_orcamento int2 NULL,
	propriedade varchar(150) NULL,
	tipo_orcamento int2 NULL,
	valor_orcado numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.feficiencia_prod_marft definição

-- Drop table

-- DROP TABLE jma.feficiencia_prod_marft;

CREATE TABLE jma.feficiencia_prod_marft (
	"DATA" timestamp NULL,
	maquina varchar(25) NULL,
	turno int2 NULL,
	min_dispo int4 NULL,
	operador int2 NULL,
	capacidade numeric(18, 3) NULL,
	minutos_trabalhado numeric(18, 3) NULL,
	minutos_produzido numeric(18, 3) NULL,
	eficiencia numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	pecas_produzidas numeric(18, 3) NULL,
	minutos_parados numeric(18, 3) NULL,
	minutos_perdidos numeric(18, 3) NULL,
	real_eficiencia numeric(18, 3) NULL,
	perc_real_efic numeric(18, 3) NULL,
	perd_eficiencia numeric(18, 3) NULL,
	perc_perd_efic numeric(18, 3) NULL,
	parada numeric(18, 3) NULL,
	perc_parada numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	capacidade_ajustada numeric(18, 3) NULL
);


-- jma.feficiencia_prod_operador_marft definição

-- Drop table

-- DROP TABLE jma.feficiencia_prod_operador_marft;

CREATE TABLE jma.feficiencia_prod_operador_marft (
	"data" timestamp NULL,
	maquina text NULL,
	turno numeric(3) NULL,
	min_dispo numeric(5) NULL,
	operador numeric(3) NULL,
	codigo_operador numeric(5) NULL,
	nome_operador text NULL,
	capacidade numeric(10) NULL,
	minutos_trabalhado numeric(10) NULL,
	minutos_produzido numeric(8, 2) NULL,
	eficiencia numeric(6, 4) NULL,
	perc_eficiencia numeric(38, 10) NULL,
	pecas_produzidas numeric(10) NULL,
	minutos_parados numeric(10) NULL,
	minutos_perdidos numeric(10) NULL,
	real_eficiencia numeric(6, 4) NULL,
	perc_real_efic numeric(38, 10) NULL,
	perd_eficiencia numeric(6, 4) NULL,
	perc_perd_efic numeric(38, 10) NULL,
	parada numeric(5, 4) NULL,
	perc_parada numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.festrutura_produto definição

-- Drop table

-- DROP TABLE jma.festrutura_produto;

CREATE TABLE jma.festrutura_produto (
	pk_produto varchar(18) NULL,
	cod_referencia varchar(5) NULL,
	cod_componente varchar(18) NULL,
	fk_sequencia int4 NULL,
	fk_estagio int4 NULL,
	consumo numeric(18, 3) NULL,
	qtd_camadas numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.ffaixas_comissao definição

-- Drop table

-- DROP TABLE jma.ffaixas_comissao;

CREATE TABLE jma.ffaixas_comissao (
	tipo_info varchar(23) NULL,
	cod_loja float8 NULL,
	cargo float8 NULL,
	faixa float8 NULL,
	valor_inicio numeric(18, 3) NULL,
	valor_fim numeric(18, 3) NULL,
	percentual_inicio numeric(18, 3) NULL,
	percentual_fim numeric(18, 3) NULL,
	comissao numeric(18, 3) NULL,
	ultima_atualizao timestamp NULL
);


-- jma.ffaixas_comissao_omnichannel definição

-- Drop table

-- DROP TABLE jma.ffaixas_comissao_omnichannel;

CREATE TABLE jma.ffaixas_comissao_omnichannel (
	cod_loja int4 NULL,
	faixa int2 NULL,
	comissao numeric(18, 3) NULL,
	tempo_medio int2 NULL,
	valor_atingido numeric(18, 3) NULL,
	valor_nao_atingido numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.ffaturamento definição

-- Drop table

-- DROP TABLE jma.ffaturamento;

CREATE TABLE jma.ffaturamento (
	pk_cliente varchar(18) NULL,
	pk_produto varchar(18) NULL,
	nf_dataemissao timestamp NULL,
	nf_nrseqitempedido int2 NULL,
	data_embarque timestamp NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	tipo_nota varchar(11) NULL,
	nf_notafiscal int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_serienotafiscal varchar(4) NULL,
	nf_cdrep float8 NULL,
	ultima_atualizacao timestamp NULL,
	nf_origem int8 NULL,
	nf_tipo_1dev_0ven int2 NULL,
	nf_cdempresa float8 NULL,
	nf_condpgto int2 NULL,
	nf_cdcancelamento int2 NULL,
	cfop varchar(44) NULL,
	cod_devolucao numeric(40) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrfat numeric(18, 3) NULL,
	itemnf_vlrrateio numeric(18, 3) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	itemnf_pesoliquido numeric(18, 3) NULL,
	nf_cod_situacao int2 NULL,
	nf_desc_situacao varchar(11) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_vlr_contabil numeric(18, 3) NULL,
	data_transacao timestamp NULL,
	itemnf_qtdfaturada numeric(18, 3) NULL,
	nf_cod_natureza int8 NULL,
	itemnf_cod_natureza int8 NULL,
	natureza_venda varchar(3) NULL,
	codigo_deposito int8 NULL,
	cod_funcionario numeric(18, 3) NULL,
	vlr_desc_especial numeric(18, 3) NULL,
	itemnf_vlr_franchising numeric(21, 3) NULL,
	ped_vlr_desc_especial numeric(18, 3) NULL,
	pk_loja varchar(25) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX idx_ffaturamento_pedido_produto ON jma.ffaturamento USING btree (nf_nrpedidovenda, pk_produto, nf_dataemissao);
CREATE INDEX idx_live_ntnpn ON jma.ffaturamento USING btree (nf_dataemissao, tipo_nota, nf_cdempresa, pk_cliente, nf_desc_situacao);
CREATE INDEX idx_nf_serie ON jma.ffaturamento USING btree (nf_notafiscal, nf_serienotafiscal);
CREATE INDEX idx_pedido ON jma.ffaturamento USING btree (nf_nrpedidovenda);


-- jma.ffaturamento_dev definição

-- Drop table

-- DROP TABLE jma.ffaturamento_dev;

CREATE TABLE jma.ffaturamento_dev (
	pk_cliente varchar(17) NULL,
	pk_produto varchar(20) NULL,
	cd_barra varchar(18) NULL,
	nf_cdrep int4 NULL,
	nf_cdempresa int4 NULL,
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(3) NULL,
	nf_dataemissao varchar(10) NULL,
	nf_dtemissao timestamp NULL,
	nf_datadigitacao timestamp NULL,
	nf_condpgto int4 NULL,
	nf_cdcancelamento int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_nrseqitempedido int4 NULL,
	nf_origem int4 NULL,
	nf_tipo_1dev_0ven int4 NULL,
	nf_cod_situacao int4 NULL,
	nf_cod_natureza int4 NULL,
	itemnf_cod_natureza int4 NULL,
	natureza_venda varchar(5) NULL,
	nf_desc_situacao varchar(12) NULL,
	data_embarque timestamp NULL,
	cod_funcionario int4 NULL,
	cfop varchar(12) NULL,
	desc_nat_oper varchar(50) NULL,
	uf varchar(5) NULL,
	cod_devolucao varchar(50) NULL,
	mot_devolucao varchar(40) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_qtdfaturada numeric(8, 2) NULL,
	itemnf_vlrunit numeric(10, 2) NULL,
	itemnf_vlrfat numeric(10, 2) NULL,
	itemnf_vlr_contabil numeric(10, 2) NULL,
	itemnf_vlrrateio numeric(12, 2) NULL,
	itemnf_vlr_tot numeric(12, 2) NULL,
	valor_desconto numeric(12, 2) NULL,
	itemnf_vlripi numeric(12, 2) NULL,
	itemnf_vlricms numeric(12, 2) NULL,
	itemnf_vlricmsdiferido numeric(12, 2) NULL,
	itemnf_vlrpis numeric(12, 2) NULL,
	itemnf_vlrcofins numeric(12, 2) NULL,
	itemnf_pesoliquido numeric(12, 2) NULL,
	itemnf_vlr_franchising numeric(12, 2) NULL,
	perc_desc_fran numeric(12, 2) NULL,
	tipo_nota varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	data_transacao varchar(15) NULL,
	codigo_deposito numeric(12, 2) NULL,
	canal varchar(100) NULL,
	modalidade varchar(50) NULL,
	live_dt_entr_original timestamp NULL,
	nf_formapgto int8 NULL
);
CREATE INDEX indx_tipo_nota ON jma.ffaturamento_dev USING btree (tipo_nota);
COMMENT ON TABLE jma.ffaturamento_dev IS 'Está tabela é destinada para os dados de faturamento x devolução que tem objetivo de trazer as informações do faturamento líquido já com as regras e tratativas do financeiro e comercial aplicadas.';


-- jma.ffaturamento_dev_inc definição

-- Drop table

-- DROP TABLE jma.ffaturamento_dev_inc;

CREATE TABLE jma.ffaturamento_dev_inc (
	"PK_CLIENTE" text NULL,
	"PK_PRODUTO" text NULL,
	"CD_BARRA" text NULL,
	"NF_CDREP" numeric(38, 10) NULL,
	"NF_CDEMPRESA" numeric(38, 10) NULL,
	"NF_NOTAFISCAL" numeric(9) NULL,
	"NF_SERIENOTAFISCAL" text NULL,
	"NF_DATAEMISSAO" text NULL,
	"NF_DTEMISSAO" timestamp NULL,
	"NF_DATADIGITACAO" timestamp NULL,
	"NF_CONDPGTO" numeric(3) NULL,
	"NF_CDCANCELAMENTO" numeric(2) NULL,
	"NF_NRPEDIDOVENDA" numeric(9) NULL,
	"NF_NRSEQITEMPEDIDO" numeric(38, 10) NULL,
	"NF_ORIGEM" numeric(38, 10) NULL,
	"NF_TIPO_1DEV_0VEN" numeric(38, 10) NULL,
	"NF_COD_SITUACAO" numeric(38, 10) NULL,
	"NF_COD_NATUREZA" numeric(3) NULL,
	"ITEMNF_COD_NATUREZA" numeric(38, 10) NULL,
	"NATUREZA_VENDA" text NULL,
	"NF_DESC_SITUACAO" text NULL,
	"DATA_EMBARQUE" timestamp NULL,
	"COD_FUNCIONARIO" numeric(38, 10) NULL,
	"CFOP" text NULL,
	"DESC_NAT_OPER" text NULL,
	"UF" text NULL,
	"COD_DEVOLUCAO" text NULL,
	"MOT_DEVOLUCAO" text NULL,
	"EMITE_DUPLICATA" numeric(1) NULL,
	"FATURAMENTO" numeric(1) NULL,
	"ITEMNF_QTDFATURADA" numeric(38, 10) NULL,
	"ITEMNF_VLRUNIT" numeric(38, 10) NULL,
	"ITEMNF_VLRFAT" numeric(38, 10) NULL,
	"ITEMNF_VLR_CONTABIL" numeric(38, 10) NULL,
	"ITEMNF_VLRRATEIO" numeric(15, 2) NULL,
	"ITEMNF_VLR_TOT" numeric(38, 10) NULL,
	"VALOR_DESCONTO" numeric(38, 10) NULL,
	"ITEMNF_VLRIPI" numeric(15, 2) NULL,
	"ITEMNF_VLRICMS" numeric(15, 2) NULL,
	"ITEMNF_VLRICMSDIFERIDO" numeric(38, 10) NULL,
	"ITEMNF_VLRPIS" numeric(15, 2) NULL,
	"ITEMNF_VLRCOFINS" numeric(15, 2) NULL,
	"ITEMNF_PESOLIQUIDO" numeric(38, 10) NULL,
	"ITEMNF_VLR_FRANCHISING" numeric(38, 10) NULL,
	"PERC_DESC_FRAN" numeric(38, 10) NULL,
	"TIPO_NOTA" text NULL,
	"ULTIMA_ATUALIZACAO" timestamp NULL,
	"DATA_TRANSACAO" text NULL,
	"CODIGO_DEPOSITO" numeric(38, 10) NULL,
	"CANAL" text NULL,
	"MODALIDADE" text NULL,
	"LIVE_DT_ENTR_ORIGINAL" timestamp NULL
);


-- jma.ffaturamento_eua definição

-- Drop table

-- DROP TABLE jma.ffaturamento_eua;

CREATE TABLE jma.ffaturamento_eua (
	mes varchar(6) NULL,
	loja varchar(20) NULL,
	"SUM(DADOS.QUANTIDADE)" int8 NULL,
	ano varchar(5) NULL,
	ultima_atualizacao timestamp NULL,
	mes_ano varchar(20) NULL,
	"SUM(DADOS.VALORDOLAR)" numeric(12, 2) NULL,
	"SUM(DADOS.VALORREAL)" numeric(12, 2) NULL
);


-- jma.ffaturamento_internacional definição

-- Drop table

-- DROP TABLE jma.ffaturamento_internacional;

CREATE TABLE jma.ffaturamento_internacional (
	pk_loja_internacional int4 NULL,
	qtd_faturado int2 NULL,
	tickets int2 NULL,
	dthora_atualizacao timestamp NULL,
	desc_loja varchar(40) NULL,
	valor_dolar numeric(18, 3) NULL,
	valor_real numeric(18, 3) NULL,
	data_fat timestamp NULL
);


-- jma.ffaturamento_nacional definição

-- Drop table

-- DROP TABLE jma.ffaturamento_nacional;

CREATE TABLE jma.ffaturamento_nacional (
	tipo_faturamento varchar(20) NULL,
	exercicio int4 NULL,
	data_lancto timestamp NULL,
	cod_empresa int4 NULL,
	desc_empresa varchar(50) NULL,
	conta_contabil varchar(25) NULL,
	conta_reduzida int4 NULL,
	chave int4 NULL,
	seqchave int4 NULL,
	complemento_historico varchar(100) NULL,
	desc_plano_conta varchar(60) NULL,
	ultima_atualizacao timestamp NULL,
	canal_distr varchar(16) NULL,
	credito numeric(12, 2) NULL
);


-- jma.fhists_mov_ definição

-- Drop table

-- DROP TABLE jma.fhists_mov_;

CREATE TABLE jma.fhists_mov_ (
	periodo numeric(4) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	sequencia numeric(5) NULL,
	nivel text NULL,
	grupo text NULL,
	subgrupo text NULL,
	item text NULL,
	data_hora timestamp NULL,
	tipo text NULL,
	usuario text NULL,
	endereco text NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.finspecao_qualidade definição

-- Drop table

-- DROP TABLE jma.finspecao_qualidade;

CREATE TABLE jma.finspecao_qualidade (
	data_inspecao timestamp NULL,
	id_inspecao numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	periodo numeric(4) NULL,
	turno numeric(1) NULL,
	cod_estagio numeric(5) NULL,
	inspetor text NULL,
	pk_produto text NULL,
	grupo_maq_estamp text NULL,
	subgrupo_maq_estamp text NULL,
	revisor_origem text NULL,
	qtde_inspecionar_pcs numeric(6) NULL,
	perc_inspecionar_pcs numeric(3) NULL,
	qtde_inspecionada_pcs numeric(6) NULL,
	qtde_rejeitada_pcs numeric(6) NULL,
	perc_rejeitada_pcs numeric(3) NULL,
	tipo_inspecao numeric(1) NULL,
	id_lancamento numeric(9) NULL,
	cod_estagio_defeito numeric(5) NULL,
	cod_motivo numeric(3) NULL,
	motivo text NULL,
	qtd_inspecao numeric(6) NULL,
	cod_chave_inspecao_medidas numeric(9) NULL,
	cod_chave_inspecao numeric(9) NULL,
	cod_chave_lancamento numeric(9) NULL,
	tip_medida numeric(2) NULL,
	seq_inspecao numeric(3) NULL,
	des_inspecao text NULL,
	val_medida_padrao numeric(7, 3) NULL,
	val_medida_real numeric(7, 3) NULL,
	val_toler_minima numeric(6, 2) NULL,
	val_toler_maxima numeric(6, 2) NULL,
	val_variacao numeric(7, 3) NULL,
	cod_usuario text NULL,
	dat_hor_inspecao timestamp NULL,
	data_atualizacao timestamp NULL
);


-- jma.flog_itens_transfer definição

-- Drop table

-- DROP TABLE jma.flog_itens_transfer;

CREATE TABLE jma.flog_itens_transfer (
	cd_pedido int4 NULL,
	cd_pedido_cliente varchar(60) NULL,
	seq_item_pedido int4 NULL,
	cd_item_trans varchar(60) NULL,
	cd_destino_venda int4 NULL,
	cd_destino_cliente varchar(60) NULL,
	seq_item_destino int4 NULL,
	controle int2 NULL,
	dt_hora_insercao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cod_cancelamento int2 NULL,
	desc_canc_pedido varchar(20) NULL,
	qtd_transferida numeric(18, 3) NULL
);
CREATE INDEX idx_flog_itens_transfer_data ON jma.flog_itens_transfer USING btree (cd_pedido, seq_item_pedido, dt_hora_insercao);


-- jma.flogpedidos definição

-- Drop table

-- DROP TABLE jma.flogpedidos;

CREATE TABLE jma.flogpedidos (
	cd_pedido int4 NULL,
	data_alteracao timestamp NULL,
	usuario_alteracao varchar(60) NULL,
	data_embarque_old timestamp NULL,
	data_embarque_new timestamp NULL,
	dthora_atualizacao timestamp NULL,
	qtd_total_old numeric(18, 3) NULL,
	qtd_total_new numeric(18, 3) NULL,
	desconto1_old numeric(18, 3) NULL,
	desconto1_new numeric(18, 3) NULL,
	desconto2_old numeric(18, 3) NULL,
	desconto2_new numeric(18, 3) NULL,
	desconto3_old numeric(18, 3) NULL,
	desconto3_new numeric(18, 3) NULL,
	vlr_liq_itens_old numeric(18, 3) NULL,
	vlr_liq_itens_new numeric(18, 3) NULL,
	vlr_liq_pedido_old numeric(18, 3) NULL,
	vlr_liq_pedido_new numeric(18, 3) NULL
);
CREATE INDEX idx_flogpedidos_cd_pedido_data_alteracao ON jma.flogpedidos USING btree (cd_pedido, data_alteracao);


-- jma.fmeta_diario_loja definição

-- Drop table

-- DROP TABLE jma.fmeta_diario_loja;

CREATE TABLE jma.fmeta_diario_loja (
	pk_meta_dia varchar(20) NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	dia int2 NULL,
	mes_ano varchar(81) NULL,
	qtd_meta int4 NULL,
	valor_meta numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL,
	dt_meta timestamp NULL
);


-- jma.fmeta_loja definição

-- Drop table

-- DROP TABLE jma.fmeta_loja;

CREATE TABLE jma.fmeta_loja (
	pk_id_meta varchar(35) NULL,
	cd_loja int8 NULL,
	ano int8 NULL,
	mes int4 NULL,
	mes_ano varchar(86) NULL,
	qtd_meta int8 NULL,
	dthora_atualizacao timestamp NULL,
	vlr_meta numeric(17, 2) NULL
);


-- jma.fmeta_mensal_loja definição

-- Drop table

-- DROP TABLE jma.fmeta_mensal_loja;

CREATE TABLE jma.fmeta_mensal_loja (
	mes_ano varchar(8) NULL,
	pk_meta_mes varchar(20) NULL,
	dthora_atualizacao timestamp NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	qtd_meta int4 NULL,
	valor_meta numeric(18, 3) NULL
);


-- jma.fmeta_semanal_loja definição

-- Drop table

-- DROP TABLE jma.fmeta_semanal_loja;

CREATE TABLE jma.fmeta_semanal_loja (
	pk_meta_dia varchar(20) NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	mes_ano varchar(20) NULL,
	valor_meta numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL,
	dt_meta timestamp NULL,
	dt_inicio timestamp NULL,
	dt_fim timestamp NULL,
	semana int2 NULL
);


-- jma.fmetasestacoes definição

-- Drop table

-- DROP TABLE jma.fmetasestacoes;

CREATE TABLE jma.fmetasestacoes (
	cod_estacao varchar(9) NULL,
	descricao_estacao varchar(150) NULL,
	cod_representante varchar(6) NULL,
	descricao_rep varchar(100) NULL,
	tipo_meta varchar(3) NULL,
	mes varchar(2) NULL,
	ano varchar(4) NULL,
	cod_agrupador varchar(9) NULL,
	descricao varchar(50) NULL,
	colecao varchar(3) NULL,
	ultima_atualizacao timestamp NULL,
	valor_meta numeric(18, 3) NULL,
	perc_distribuicao numeric(18, 3) NULL,
	calc_meta numeric(18, 3) NULL
);


-- jma.fmetasorcamento definição

-- Drop table

-- DROP TABLE jma.fmetasorcamento;

CREATE TABLE jma.fmetasorcamento (
	tipo_meta varchar(1) NULL,
	desc_meta varchar(50) NULL,
	modalidade varchar(50) NULL,
	ano varchar(4) NULL,
	mes_venda varchar(9) NULL,
	ultima_atualizacao timestamp NULL,
	total numeric(18, 3) NULL,
	mes_ano varchar(15) NULL
);


-- jma.fmonitor_producao definição

-- Drop table

-- DROP TABLE jma.fmonitor_producao;

CREATE TABLE jma.fmonitor_producao (
	cod_operador int2 NULL,
	nome_operador varchar(40) NULL,
	min_trab numeric(18, 3) NULL,
	min_prod numeric(18, 3) NULL,
	efic numeric(18, 3) NULL,
	status varchar(7) NULL,
	celula_destino varchar(25) NULL,
	celula_origem varchar(25) NULL
);


-- jma.fmovimentacoesestoque definição

-- Drop table

-- DROP TABLE jma.fmovimentacoesestoque;

CREATE TABLE jma.fmovimentacoesestoque (
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(20) NULL,
	fk_produto varchar(20) NULL,
	codigo_transacao int2 NULL,
	dt_movimentacao timestamp NULL,
	tipo_movimento varchar(3) NULL,
	qtd_movimento numeric(18, 3) NULL,
	qtd_saldo_fisico numeric(18, 3) NULL,
	vlr_movimento_unitario numeric(18, 3) NULL,
	vlr_saldo_financeiro numeric(18, 3) NULL,
	flag_periodo varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	cod_empresa int8 NULL,
	nome_empresa varchar(60) NULL,
	referencia varchar(20) NULL,
	tamanho varchar(20) NULL,
	cor varchar(20) NULL
);


-- jma.fmovimentos_loja definição

-- Drop table

-- DROP TABLE jma.fmovimentos_loja;

CREATE TABLE jma.fmovimentos_loja (
	cod_empresa int4 NULL,
	fk_cliente_fornec varchar(23) NULL,
	fk_vendedor varchar(35) NULL,
	fk_produto varchar(41) NULL,
	cod_transacao int4 NULL,
	cod_usuario int4 NULL,
	cod_documento int4 NULL,
	cnpj varchar(14) NULL,
	cod_portal int4 NULL,
	dt_documento timestamp NULL,
	dt_lancamento timestamp NULL,
	serie varchar(10) NULL,
	qtd_movimento int8 NULL,
	forma_pagamento varchar(22) NULL,
	flag_cancelado varchar(1) NULL,
	flag_excluido varchar(1) NULL,
	desc_deposito varchar(100) NULL,
	natureza_operacao varchar(100) NULL,
	tabela_preco varchar(50) NULL,
	dthora_atualizacao timestamp NULL,
	cod_vale_troca varchar(9) NULL,
	motivo_troca varchar(60) NULL,
	valor_cofins numeric(15, 3) NULL,
	cfop varchar(5) NULL,
	operacao varchar(2) NULL,
	tipo_transacao varchar(1) NULL,
	num_vale varchar(200) NULL,
	fk_loja varchar(23) NULL,
	fk_loja_cigam varchar(40) NULL,
	cod_referencia varchar(20) NULL,
	tamanho varchar(50) NULL,
	desc_cor varchar(30) NULL,
	fk_produto_comercial varchar(102) NULL,
	identificador varchar(38) NULL,
	codigo_cliente int4 NULL,
	cod_vendedor int4 NULL,
	portal int4 NULL,
	loja varchar(50) NULL,
	pk_cigam_loja varchar(15) NULL,
	cnpj_original varchar(14) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_total numeric(18, 3) NULL,
	valor_frete numeric(18, 3) NULL,
	valor_preco_unitario numeric(18, 3) NULL,
	valor_vale_troca numeric(18, 3) NULL
);


-- jma.fmovimentosinteg definição

-- Drop table

-- DROP TABLE jma.fmovimentosinteg;

CREATE TABLE jma.fmovimentosinteg (
	portal int8 NULL,
	fk_cliente varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	fk_produto varchar(25) NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(3) NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	cnpj varchar(40) NULL,
	valor_bruto int8 NULL,
	cor varchar(6) NULL,
	tamanho varchar(5) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	descricao varchar(200) NULL,
	rede varchar(100) NULL,
	canal_distribuicao varchar(14) NULL,
	flag_movimentacao varchar(20) NULL,
	cst_icms varchar(15) NULL,
	cst_ipi varchar(15) NULL,
	cst_cofins varchar(15) NULL,
	cst_pis varchar(15) NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	qtde numeric(18, 3) NULL,
	data_lancamento timestamp NULL,
	datcancel timestamp NULL,
	cod_barra varchar(20) NULL,
	data_inicio_vigencia date NULL,
	data_fim_vigencia date NULL,
	cnpj_original varchar(40) NULL,
	cnpj_antigo varchar(18) NULL,
	de varchar(20) NULL,
	para varchar(20) NULL,
	loja_original varchar(30) NULL,
	situacao int2 NULL,
	identificador varchar(60) NULL,
	cnpj_emp varchar(20) NULL,
	loja varchar(5) NULL
);
CREATE INDEX idx_fmovimentosinteg_cnpj_data ON jma.fmovimentosinteg USING btree (cnpj, data_lancamento);
CREATE INDEX idx_fmovimentosinteg_cod_vendedor ON jma.fmovimentosinteg USING btree (cod_vendedor);
CREATE INDEX idx_fmovimentosinteg_vendas_ativas ON jma.fmovimentosinteg USING btree (operacao, tipo_transacao, considerarvenda, data_lancamento) WHERE ((cancelado)::text = 'N'::text);


-- jma.fmovimentoslojamicrovix definição

-- Drop table

-- DROP TABLE jma.fmovimentoslojamicrovix;

CREATE TABLE jma.fmovimentoslojamicrovix (
	cod_empresa int4 NULL,
	cod_transacao int4 NULL,
	rede varchar(50) NULL,
	desc_apelido varchar(200) NULL,
	data_lancamento timestamp NULL,
	id_cfop varchar(5) NULL,
	operacao varchar(2) NULL,
	desc_operacao varchar(200) NULL,
	numnf int4 NULL,
	loja varchar(100) NULL,
	cnpj_emp varchar(100) NULL,
	tipo_transacao varchar(1) NULL,
	transacao varchar(100) NULL,
	canal_distribuicao varchar(100) NULL,
	valorvendas numeric(18, 3) NULL,
	qtdepedidos numeric(18, 3) NULL,
	qtdedevolucao numeric(18, 3) NULL,
	qtdeitensvendida numeric(18, 3) NULL,
	valordesconto numeric(18, 3) NULL
);


-- jma.fordens_corte_congelado definição

-- Drop table

-- DROP TABLE jma.fordens_corte_congelado;

CREATE TABLE jma.fordens_corte_congelado (
	estagio int4 NULL,
	data_programacao timestamp NULL,
	simultaneo int4 NULL,
	op int4 NULL,
	oc int4 NULL,
	periodo int2 NULL,
	referencia text NULL,
	cor text NULL,
	prioridade int4 NULL,
	cor_prioridade text NULL,
	qtd_produzir numeric(18, 3) NULL,
	qtd_ajustada numeric(38, 18) NULL,
	tempo_produzir numeric(18, 3) NULL,
	tempo_costura numeric(38, 18) NULL,
	data_producao timestamp NULL,
	data_congelamento date NULL,
	data_entrada_estagio timestamp NULL
);


-- jma.fparametro_compra definição

-- Drop table

-- DROP TABLE jma.fparametro_compra;

CREATE TABLE jma.fparametro_compra (
	cod_empresa numeric(3) NULL,
	fk_produto text NULL,
	fk_familia_materiais numeric(5) NULL,
	estoque_minimo numeric(13, 3) NULL,
	estoque_maximo numeric(13, 3) NULL,
	tempo_reposicao numeric(5) NULL,
	lote_multiplo numeric(13, 3) NULL,
	cod_deposito numeric(3) NULL,
	bloqueia_compra numeric(1) NULL,
	dthora_atualizacao timestamp NULL,
	lote_minimo numeric(16, 3) NULL
);


-- jma.fpedido_congelado definição

-- Drop table

-- DROP TABLE jma.fpedido_congelado;

CREATE TABLE jma.fpedido_congelado (
	pedido_venda int4 NULL,
	data_entr_venda timestamp NULL,
	situacao_venda int2 NULL,
	cod_cancelamento int2 NULL,
	sit_aloc_pedi int2 NULL,
	sit_coletor int2 NULL,
	situacao_coleta int2 NULL,
	status_expedicao int2 NULL,
	status_homologacao int2 NULL,
	status_pedido int2 NULL,
	status_comercial int2 NULL,
	sit_conferencia int2 NULL,
	data_congelamento timestamp NULL,
	qtde_saldo_pedi numeric(18, 3) NULL,
	valor_saldo_pedi numeric(18, 3) NULL
);


-- jma.fpedidos_compra definição

-- Drop table

-- DROP TABLE jma.fpedidos_compra;

CREATE TABLE jma.fpedidos_compra (
	ped_compra numeric(8) NULL,
	itemped_seq_ped numeric(4) NULL,
	obs_pedido varchar(300) NULL,
	dt_emissao_compra timestamp NULL,
	dt_prev_entrega timestamp NULL,
	fk_cond_pgto numeric(3) NULL,
	ped_vendedor varchar(60) NULL,
	fk_comprador numeric(5) NULL,
	fk_grupo_contas numeric(5) NULL,
	fk_familia numeric(8) NULL,
	itemped_qtd_pedida numeric(15, 3) NULL,
	itemped_qtd_saldo numeric(15, 3) NULL,
	itemped_qtd_recebida numeric(15, 3) NULL,
	itemped_situacao_item varchar(13) NULL,
	itemped_preco numeric(15, 5) NULL,
	itemped_percentual_desc numeric(8, 2) NULL,
	itemped_percentual_ipi numeric(8, 2) NULL,
	itemped_centro_custo numeric(8) NULL,
	itemped_cod_cancelamento numeric(4) NULL,
	dt_cancelamento timestamp NULL,
	itemped_requisicao numeric(8) NULL,
	dthora_atualizacao timestamp NULL,
	fk_produto varchar(30) NULL,
	fk_fornecedor varchar(18) NULL,
	fk_conta_estoque varchar(5) NULL,
	codigo_contabil int4 NULL
);


-- jma.fpedidos_embarque_previsto definição

-- Drop table

-- DROP TABLE jma.fpedidos_embarque_previsto;

CREATE TABLE jma.fpedidos_embarque_previsto (
	pedido_venda numeric(9) NULL,
	data_entr_venda timestamp NULL,
	situacao_venda numeric(2) NULL,
	cod_cancelamento numeric(3) NULL,
	sit_aloc_pedi numeric(1) NULL,
	sit_coletor numeric(1) NULL,
	situacao_coleta numeric(1) NULL,
	status_expedicao numeric(1) NULL,
	status_homologacao numeric(1) NULL,
	status_pedido numeric(1) NULL,
	status_comercial numeric(1) NULL,
	sit_conferencia numeric(1) NULL,
	qtde_saldo_pedi numeric(15, 3) NULL,
	qtde_pedida numeric(15, 3) NULL,
	qtde_afaturar numeric(15, 3) NULL,
	val_liq_unt numeric(15, 3) NULL,
	valor_unitario numeric(15, 3) NULL,
	ultima_atualizacao date NULL,
	cnpj_cliente varchar(35) NULL,
	codigo_deposito int2 NULL,
	seq_item_pedido int2 NULL,
	fk_produto varchar(35) NULL,
	natureza_venda varchar(10) NULL,
	canal varchar(100) NULL,
	qtde_faturada numeric(18, 3) NULL,
	valor_saldo_pedi numeric(18, 3) NULL
);


-- jma.fpedidos_url definição

-- Drop table

-- DROP TABLE jma.fpedidos_url;

CREATE TABLE jma.fpedidos_url (
	"data" varchar(20) NULL,
	hora varchar(10) NULL,
	id_pedido int8 NULL,
	cliente varchar(150) NULL,
	id_vendedor int8 NULL,
	cpf_vendedor varchar(20) NULL,
	grupo_vendedor varchar(50) NULL,
	cnpj varchar(20) NULL,
	url_loja varchar(100) NULL,
	numero_nf varchar(20) NULL,
	serie_nf varchar(10) NULL,
	omnichannel varchar(10) NULL,
	ultima_atualizacao timestamp NULL,
	tipo varchar(30) NULL,
	cupom varchar(40) NULL,
	desconto_cupom varchar(40) NULL,
	codigo_vendedor varchar(40) NULL,
	desconto_vendedor varchar(40) NULL,
	status varchar(80) NULL,
	total_liquido numeric(18, 3) NULL,
	total_desconto numeric(18, 3) NULL,
	total_bruto numeric(18, 3) NULL,
	pagamento varchar(80) NULL,
	vendedor varchar(80) NULL
);


-- jma.fportal_lojas definição

-- Drop table

-- DROP TABLE jma.fportal_lojas;

CREATE TABLE jma.fportal_lojas (
	cn_id int8 NULL,
	cn_num_nota_fiscal int4 NULL,
	cn_inicio_conferencia_volumes timestamp NULL,
	cn_ultima_leitura_volumes timestamp NULL,
	cn_ultima_leitura_tags timestamp NULL,
	cn_status_volumes int2 NULL,
	cn_desc_status_volumes varchar(14) NULL,
	tcv_id int8 NULL,
	tcv_numero_volume int4 NULL,
	tcv_inicio_conferencia timestamp NULL,
	tcv_ultima_leitura timestamp NULL,
	tcv_status_pecas int2 NULL,
	tcv_desc_status_pecas varchar(14) NULL,
	ct_id int8 NULL,
	ct_data_bip timestamp NULL,
	ct_usuario varchar(55) NULL,
	ct_status int2 NULL,
	ct_pk_produto varchar(18) NULL,
	ct_desc_status varchar(14) NULL,
	cv_id int8 NULL,
	cv_data_bip timestamp NULL,
	cv_status int2 NULL,
	cv_desc_status varchar(14) NULL,
	ra_id int8 NULL,
	ra_cnpj varchar(17) NULL,
	ra_usuario_bipou varchar(55) NULL,
	ra_nome_usuario varchar(55) NULL,
	ra_tipo int2 NULL,
	ra_status int2 NULL,
	ra_codigo_bipado varchar(100) NULL,
	ra_acao varchar(2500) NULL,
	ra_data_bipagem timestamp NULL,
	ra_codigo_empresa int2 NULL,
	ra_serie_nota_fisc varchar(3) NULL,
	ra_desc_status varchar(14) NULL,
	usu_id int8 NULL,
	usu_nome varchar(55) NULL,
	usu_usuario varchar(55) NULL,
	usu_situacao int2 NULL,
	usu_cnpj varchar(18) NULL,
	ct_numero_tag varchar(60) NULL,
	tcv_tags_conferidas numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- jma.fprioridade_beneficiamento_conge definição

-- Drop table

-- DROP TABLE jma.fprioridade_beneficiamento_conge;

CREATE TABLE jma.fprioridade_beneficiamento_conge (
	prioridade numeric(3) NULL,
	work_order_id text NULL,
	work_center text NULL,
	planta text NULL,
	cliente text NULL,
	quantidade numeric(38, 10) NULL,
	sku text NULL,
	descricao_sku text NULL,
	tipo_wo text NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	familia_produto text NULL,
	tamanho text NULL,
	cor text NULL,
	referencia text NULL,
	periodo_producao numeric(4) NULL,
	ordem_producao numeric(9) NULL,
	pk_maquina text NULL,
	pk_maquina_num text NULL,
	qtde_quilos_prog numeric(13, 3) NULL,
	qtde_rolos_prog numeric(10, 2) NULL,
	qtde_rolos_prod numeric(9, 3) NULL,
	qtde_rolos_prog_1 numeric(10, 3) NULL,
	qtde_rolos_real numeric(6, 3) NULL,
	qtde_quilos_prod numeric(9, 3) NULL,
	situacao text NULL,
	data_atualizacao timestamp NULL
);


-- jma.fprioridade_tecelagem_conge definição

-- Drop table

-- DROP TABLE jma.fprioridade_tecelagem_conge;

CREATE TABLE jma.fprioridade_tecelagem_conge (
	prioridade numeric(9) NULL,
	work_order_id text NULL,
	work_center text NULL,
	planta text NULL,
	cliente text NULL,
	sku text NULL,
	descricao_sku text NULL,
	tipo_wo text NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	familia_produto text NULL,
	tamanho text NULL,
	cor text NULL,
	referencia text NULL,
	alternativa_item numeric(2) NULL,
	roteiro_opcional numeric(2) NULL,
	numero_lote text NULL,
	opcao_maquina numeric(3) NULL,
	periodo_producao numeric(4) NULL,
	ordem_producao numeric(6) NULL,
	pk_maquina text NULL,
	pk_maquina_num text NULL,
	quantidade numeric(38, 10) NULL,
	qtde_quilos_prog numeric(12, 3) NULL,
	qtde_rolos_prog numeric(8, 1) NULL,
	peso_rolo numeric(8, 3) NULL,
	qtde_unidades_prog numeric(15, 3) NULL,
	qtde_rolos_prog_1 numeric(8, 1) NULL,
	qtde_rolos_prod numeric(8, 1) NULL,
	cod_cancelamento numeric(3) NULL,
	data_atualizacao timestamp NULL
);


-- jma.fprod_marft definição

-- Drop table

-- DROP TABLE jma.fprod_marft;

CREATE TABLE jma.fprod_marft (
	op int4 NULL,
	os int4 NULL,
	tip_prod int2 NULL,
	hora timestamp NULL,
	seq int2 NULL,
	desc_prod varchar(50) NULL,
	referencia varchar(50) NULL,
	produto varchar(150) NULL,
	operacao varchar(80) NULL,
	operationcode varchar(20) NULL,
	tecido varchar(90) NULL,
	grupo varchar(70) NULL,
	"S.U." varchar(20) NULL,
	camada int2 NULL,
	tempo_total numeric(18, 3) NULL,
	tempo_peca numeric(18, 3) NULL,
	carga numeric(18, 3) NULL,
	oper int8 NULL,
	operador varchar(150) NULL,
	ultima_atualizacao timestamp NULL,
	"Data" timestamp NULL,
	temp_prep numeric(18, 3) NULL,
	temp_conclus numeric(18, 3) NULL,
	comp_total numeric(18, 3) NULL,
	tempo_tot_camada numeric(18, 3) NULL,
	tempo_camada numeric(18, 3) NULL,
	qtd_emenda numeric(18, 3) NULL,
	temp_emend numeric(18, 3) NULL,
	qtd_ton numeric(18, 3) NULL,
	tempo_ton numeric(18, 3) NULL,
	qtd_troca numeric(18, 3) NULL,
	tempo_troca_rolo numeric(18, 3) NULL
);


-- jma.freq_almoxarifado definição

-- Drop table

-- DROP TABLE jma.freq_almoxarifado;

CREATE TABLE jma.freq_almoxarifado (
	num_requisicao numeric(6) NULL,
	ordem_producao numeric(9) NULL,
	ccusto_destino int4 NULL,
	data_requis timestamp NULL,
	requisitante varchar(50) NULL,
	situacao_capa varchar(32) NULL,
	referencia varchar(5) NULL,
	conta_estoque int2 NULL,
	pk_produto varchar(25) NULL,
	um varchar(2) NULL,
	deposito int2 NULL,
	observacao varchar(120) NULL,
	qtde_requisitada numeric(18, 3) NULL,
	a_receber numeric(18, 3) NULL,
	estoque numeric(18, 3) NULL,
	ult_compra numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	situacao varchar(32) NULL,
	data_entregue timestamp NULL,
	codigo_transacao int2 NULL,
	usuario_receptor varchar(200) NULL,
	almoxarife varchar(20) NULL,
	sequencia int2 NULL
);


-- jma.frequisicoes_compra definição

-- Drop table

-- DROP TABLE jma.frequisicoes_compra;

CREATE TABLE jma.frequisicoes_compra (
	num_requisicao numeric(6) NULL,
	seq_item_req numeric(2) NULL,
	codigo_deposito numeric(3) NULL,
	data_requisicao timestamp NULL,
	nome_requisit text NULL,
	observacao_req text NULL,
	data_prev_entr_req timestamp NULL,
	situacao_codigo numeric(1) NULL,
	situacao text NULL,
	pedido_compra numeric(6) NULL,
	data_prev_entr_ped timestamp NULL,
	fk_produto text NULL,
	fk_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_requisitada numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	ultimaentrada timestamp NULL,
	ultimasaida timestamp NULL,
	estoqueatual numeric(38, 10) NULL,
	qtdsugerida numeric(38, 10) NULL,
	precoultentrada numeric(38, 10) NULL,
	estoquemin numeric(38, 10) NULL,
	estoquemax numeric(38, 10) NULL,
	consumomedmes numeric(38, 10) NULL,
	consumopordia numeric(38, 10) NULL,
	ult_forn text NULL,
	ult_ped numeric(6) NULL,
	qtd_ult_ped numeric(38, 10) NULL,
	quantidade_nf numeric(38, 10) NULL,
	valor_total_nf numeric(38, 10) NULL
);


-- jma.froteiro definição

-- Drop table

-- DROP TABLE jma.froteiro;

CREATE TABLE jma.froteiro (
	num_roteiro int2 NULL,
	seq_operacao int2 NULL,
	fk_operacao int4 NULL,
	fk_estagio int2 NULL,
	seq_estagio int2 NULL,
	estagio_depende int2 NULL,
	qtd_rolos int4 NULL,
	observacao_roteiro varchar(200) NULL,
	centro_custo int4 NULL,
	ccusto_homem int4 NULL,
	dthora_atualizacao timestamp NULL,
	qtd_cordas int4 NULL,
	minutos_roteiro numeric(18, 3) NULL,
	velocidade numeric(18, 3) NULL,
	minutos_homem numeric(18, 3) NULL,
	fk_produto varchar(20) NULL,
	alternativa_item int4 NULL
);


-- jma.froteiro_em_producao definição

-- Drop table

-- DROP TABLE jma.froteiro_em_producao;

CREATE TABLE jma.froteiro_em_producao (
	fk_produto varchar(111) NULL,
	numero_alternati int2 NULL,
	numero_roteiro int2 NULL,
	seq_operacao int2 NULL,
	codigo_operacao int4 NULL,
	codigo_estagio int4 NULL,
	nr_agulhas int2 NULL,
	tempo_maquina numeric(18, 3) NULL,
	custo_homem int4 NULL,
	custo_minuto numeric(18, 3) NULL,
	tempo_homem numeric(18, 3) NULL,
	fk_maquina varchar(39) NULL,
	ultima_atualizacao timestamp NULL
);


-- jma.ftabelapreco definição

-- Drop table

-- DROP TABLE jma.ftabelapreco;

CREATE TABLE jma.ftabelapreco (
	dthora_atualizacao timestamp NULL,
	grupo_estrutura varchar(10) NULL,
	tabela_preco varchar(10) NULL,
	tabela_preco_cod varchar(10) NULL,
	fk_produto varchar(50) NULL,
	vlr_com_desconto numeric(18, 3) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	tabela_preco_grupo numeric(25, 6) NULL
);


-- jma.ftempo_metodos definição

-- Drop table

-- DROP TABLE jma.ftempo_metodos;

CREATE TABLE jma.ftempo_metodos (
	pk_produto varchar(111) NULL,
	alt int2 NULL,
	rot int2 NULL,
	sub_grupo varchar(3) NULL,
	codigo_estagio int4 NULL,
	codigo_operacao int4 NULL,
	pk_maquina varchar(39) NULL,
	agulhas varchar(3) NULL,
	custo_homem numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	custo_minuto numeric(18, 3) NULL,
	tempo_homem varchar NULL,
	tempo_maquina varchar NULL
);
CREATE INDEX idx_ftempo_metodos_estagio_prod_alt ON jma.ftempo_metodos USING btree (codigo_estagio, pk_produto, alt);
CREATE INDEX idx_ftempo_metodos_operacao ON jma.ftempo_metodos USING btree (codigo_operacao);
CREATE INDEX idx_ftempo_metodos_pk_maquina ON jma.ftempo_metodos USING btree (pk_maquina);


-- jma.ftitulos_receber definição

-- Drop table

-- DROP TABLE jma.ftitulos_receber;

CREATE TABLE jma.ftitulos_receber (
	codigo_empresa numeric(3) NULL,
	num_duplicata numeric(9) NULL,
	seq_duplicatas numeric(2) NULL,
	cod_chave_nota text NULL,
	num_titulo text NULL,
	portador_duplic numeric(3) NULL,
	cod_rep_cliente numeric(5) NULL,
	data_emissao timestamp NULL,
	numero_remessa numeric(7) NULL,
	ind_previsao numeric(1) NULL,
	num_titulo_banco text NULL,
	num_pedido numeric(9) NULL,
	per_comiss numeric(6, 2) NULL,
	cod_motivo_cancel numeric(2) NULL,
	des_motivo_cancel text NULL,
	cod_forma_pagto numeric(2) NULL,
	dat_cancel timestamp NULL,
	dat_ult_pagto_aux timestamp NULL,
	cod_tipo_duplic numeric(2) NULL,
	des_tipo_duplic text NULL,
	des_cod_tipo_duplic text NULL,
	cod_posicao_duplic numeric(2) NULL,
	des_posicao_duplic text NULL,
	des_situa_duplic text NULL,
	des_situa_aberta_baixada text NULL,
	cod_situa_duplic numeric(1) NULL,
	cnpj_cliente text NULL,
	pk_cliente text NULL,
	cod_cidade numeric(5) NULL,
	dat_vencto_aux timestamp NULL,
	dat_vencto_original_aux timestamp NULL,
	sit_vencto text NULL,
	val_aberto numeric(15, 2) NULL,
	val_comiss numeric(15, 2) NULL,
	val_titulo numeric(15, 2) NULL,
	cod_conta_contabil numeric(6) NULL
);


-- jma.fvendas_url definição

-- Drop table

-- DROP TABLE jma.fvendas_url;

CREATE TABLE jma.fvendas_url (
	id numeric(10) NULL,
	pedido numeric(9) NULL,
	nota_fiscal numeric(9) NULL,
	quantidade numeric(15, 3) NULL,
	valor_faturado numeric(15, 3) NULL,
	canal varchar(100) NULL,
	cnpj varchar(15) NULL,
	serie_nota_fiscal varchar(3) NULL,
	pedido_cliente varchar(30) NULL,
	"DATA" timestamp NULL,
	data_emissao timestamp NULL,
	cupom varchar(35) NULL,
	loja varchar(65) NULL,
	cpf_vendedor varchar(11) NULL,
	cnpj_loja varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	nota_entrada float8 NULL,
	nota_saida float8 NULL,
	motivo_devolucao varchar(400) NULL,
	flag_tipo varchar(3) NULL,
	tipo_cliente varchar(100) NULL,
	cliente varchar(100) NULL,
	tipo_cupom varchar(100) NULL,
	vendedor varchar(255) NULL,
	valor_comissao numeric(18, 3) NULL,
	grupo_loja varchar(100) NULL,
	tela varchar(10) NULL,
	omnichannel varchar(3) NULL,
	fornecedor varchar(55) NULL,
	percentual_comissao numeric(18, 3) NULL,
	valor_comissao_ktl numeric(18, 3) NULL
);


-- jma.ped_cong_motivo_bloqueio definição

-- Drop table

-- DROP TABLE jma.ped_cong_motivo_bloqueio;

CREATE TABLE jma.ped_cong_motivo_bloqueio (
	pedido_venda int4 NULL,
	seq_situacao int2 NULL,
	codigo_situacao int2 NULL,
	flag_liberacao varchar(1) NULL,
	data_situacao timestamp NULL,
	data_liberacao timestamp NULL,
	data_congelamento timestamp NULL
);



-- DROP FUNCTION jma.live_fn_get_tempo_estagio(varchar, varchar, varchar, varchar, varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION jma.live_fn_get_tempo_estagio(p_nivel_produto character varying, p_grupo_produto character varying, p_subgrupo_produto character varying, p_item_produto character varying, p_alternativa_produto character varying, p_roteiro_produto character varying, p_estagio character varying)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
    	
DECLARE
    v_subgrupo_leitura 	VARCHAR(3) := p_subgrupo_produto;
    v_item_leitura 		VARCHAR(6) := p_item_produto;
    v_count 			INTEGER;
    v_tempo_roteiro 	NUMERIC;
BEGIN

    -- Primeira verificação com os valores iniciais
    SELECT 
    	COUNT(1)
      INTO v_count
    FROM jma.mqop_050
    
    WHERE mqop_050.nivel_estrutura 	= p_nivel_produto
    AND   mqop_050.grupo_estrutura 	= p_grupo_produto
    AND   mqop_050.subgru_estrutura = v_subgrupo_leitura
    AND   mqop_050.item_estrutura 	= v_item_leitura
    and   mqop_050.numero_alternati = p_alternativa_produto
    AND   mqop_050.numero_roteiro 	= p_roteiro_produto;

    IF v_count = 0 THEN
        v_item_leitura := '000000';

        -- Segunda verificação com item alterado
        SELECT COUNT(1)
          INTO v_count
          FROM jma.mqop_050
         WHERE mqop_050.nivel_estrutura = p_nivel_produto
           AND mqop_050.grupo_estrutura = p_grupo_produto
           AND mqop_050.subgru_estrutura = v_subgrupo_leitura
           AND mqop_050.item_estrutura = v_item_leitura
           AND mqop_050.numero_alternati = p_alternativa_produto
           AND mqop_050.numero_roteiro = p_roteiro_produto;

        IF v_count = 0 THEN
            v_subgrupo_leitura := '000';
            v_item_leitura := p_item_produto;

            -- Terceira verificação com subgrupo e item ajustados
            SELECT COUNT(1)
              INTO v_count
              FROM jma.mqop_050
             WHERE mqop_050.nivel_estrutura = p_nivel_produto
               AND mqop_050.grupo_estrutura = p_grupo_produto
               AND mqop_050.subgru_estrutura = v_subgrupo_leitura
               AND mqop_050.item_estrutura = v_item_leitura
               AND mqop_050.numero_alternati = p_alternativa_produto
               AND mqop_050.numero_roteiro = p_roteiro_produto;

            IF v_count = 0 THEN
                v_item_leitura := '000000';
            END IF;
        END IF;
    END IF;

    -- Cálculo do tempo total
    SELECT COALESCE(SUM(mqop_050.minutos_homem), 0)
      INTO v_tempo_roteiro
      FROM jma.mqop_050
      JOIN jma.mqop_040 ON mqop_050.codigo_operacao = mqop_040.codigo_operacao
     WHERE mqop_050.nivel_estrutura = p_nivel_produto
       AND mqop_050.grupo_estrutura = p_grupo_produto
       AND mqop_050.subgru_estrutura = v_subgrupo_leitura
       AND mqop_050.item_estrutura = v_item_leitura
       AND mqop_050.numero_alternati = p_alternativa_produto
       AND mqop_050.numero_roteiro = p_roteiro_produto
       AND mqop_050.codigo_estagio = p_estagio;

    RETURN v_tempo_roteiro;
END;
$function$
;

-- DROP PROCEDURE jma.mov_integ();

CREATE OR REPLACE PROCEDURE jma.mov_integ()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    final_count INTEGER;
begin
INSERT INTO jma.fmovimentosinteg
	(
	portal,
	fk_cliente,
	numorcamento,
	usuario,
	numnf,
	serie,
	chave_nf,
	fk_produto,
	hora_lancamento,
	codigo_cliente,
	doc_cliente,
	id_cfop,
	cod_vendedor,
	operacao,
	tipo_transacao,
	cancelado,
	seqitem,
	ultima_atualizacao,
	cnpj,
	valor_bruto,
	cor,
	tamanho,
	considerarvenda,
	desc_movimento,
	descricao,
	rede,
	canal_distribuicao,
	flag_movimentacao,
	cst_icms,
	cst_ipi,
	cst_cofins,
	cst_pis,
	desconto,
	preco_custo,
	valor_icms,
	aliquota_icms,
	base_icms,
	valor_ipi,
	aliquota_ipi,
	base_ipi,
	valor_cofins,
	aliquota_cofins,
	base_cofins,
	valor_pis,
	aliquota_pis,
	base_pis,
	valor_liquido,
	qtde,
	data_lancamento,
	datcancel,
	cod_barra,
	data_inicio_vigencia,
	data_fim_vigencia,
	cnpj_original,
	cnpj_antigo,
	de,
	para,
	loja_original,
	situacao,
	identificador,
	cnpj_emp,
	loja	
	)
SELECT
portal,
	fk_cliente,
	numorcamento,
	usuario,
	numnf,
	serie,
	chave_nf,
	fk_produto,
	hora_lancamento,
	codigo_cliente,
	doc_cliente,
	id_cfop,
	cod_vendedor,
	operacao,
	tipo_transacao,
	cancelado,
	seqitem,
	ultima_atualizacao,
	cnpj,
	valor_bruto,
	cor,
	tamanho,
	considerarvenda,
	desc_movimento,
	descricao,
	rede,
	canal_distribuicao,
	flag_movimentacao,
	cst_icms,
	cst_ipi,
	cst_cofins,
	cst_pis,
	desconto,
	preco_custo,
	valor_icms,
	aliquota_icms,
	base_icms,
	valor_ipi,
	aliquota_ipi,
	base_ipi,
	valor_cofins,
	aliquota_cofins,
	base_cofins,
	valor_pis,
	aliquota_pis,
	base_pis,
	valor_liquido,
	qtde,
	data_lancamento,
	datcancel,
	cod_barra,
	data_inicio_vigencia,
	data_fim_vigencia,
	cnpj_original,
	cnpj_antigo,
	de,
	para,
	loja_original,
	situacao,
	identificador,
	cnpj_emp,
	loja	
							
FROM stage.fmovimentosinteg_stage MOV

where not exists (select MOV2.identificador from jma.fmovimentosinteg mov2 where MOV2.identificador = MOV.identificador);


	-- Analyze adicionado para deixar o commit NAO TIRAR
	analyze STAGE.fmovimentosinteg_stage;
	-- Parte para debug da contagem final
	SELECT c.reltuples::bigint into final_count
	FROM   pg_class c
	JOIN   pg_namespace n ON n.oid = c.relnamespace
	WHERE  c.relname = 'fmovimentosinteg_stage'
	AND    n.nspname = 'jma';

	RAISE NOTICE 'Contagem Final da tabela: %', final_count;
END;
$procedure$
;

-- DROP PROCEDURE jma.sp_cong_ped();

CREATE OR REPLACE PROCEDURE jma.sp_cong_ped()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    -- Cursor para selecionar pedidos do dia anterior
    cur_pedidos CURSOR FOR
        SELECT a.pedido_venda, 
        	   a.data_entr_venda, 
        	   a.situacao_venda, 
        	   a.cod_cancelamento,
               a.sit_aloc_pedi, 
               a.sit_coletor, 
               a.situacao_coleta, 
               a.status_expedicao,
               a.status_homologacao, 
               a.status_pedido, 
               a.status_comercial, 
               a.sit_conferencia,
               a.qtde_saldo_pedi, 
               a.valor_saldo_pedi,
               a.ultima_atualizacao
               --live_data_entr_venda_original
               
          FROM stage.pedi100 a
          
          WHERE a.data_entr_venda = CURRENT_DATE - 1
          AND   a.qtde_total_pedi > 0
          and   not exists (select a.pedido_venda from jma.fpedido_congelado tem where a.pedido_venda = tem.pedido_venda);

    -- Cursor para selecionar os motivos de bloqueio para cada pedido
    cur_motiv_bloqueio CURSOR (p_pedido bigint) FOR
        SELECT a.pedido_venda, 
        	   a.seq_situacao, 
        	   a.codigo_situacao, 
        	   a.flag_liberacao,
               a.data_situacao, 
               a.data_liberacao,
               a.ultima_atualizacao
          FROM stage.pedi135 a
          
          WHERE a.pedido_venda = p_pedido;

BEGIN
    -- Loop sobre os pedidos do dia anterior
    FOR reg_pedidos IN cur_pedidos LOOP

        BEGIN
            -- Inserir na tabela orion_com_310
            INSERT INTO jma.fpedido_congelado (pedido_venda, data_entr_venda, situacao_venda, cod_cancelamento,
                                       sit_aloc_pedi, sit_coletor, situacao_coleta, status_expedicao,
                                       status_homologacao, status_pedido, status_comercial, sit_conferencia,
                                       qtde_saldo_pedi, valor_saldo_pedi, data_congelamento)
                                       
            VALUES (reg_pedidos.pedido_venda, reg_pedidos.data_entr_venda, reg_pedidos.situacao_venda,
                    reg_pedidos.cod_cancelamento, reg_pedidos.sit_aloc_pedi, reg_pedidos.sit_coletor,
                    reg_pedidos.situacao_coleta, reg_pedidos.status_expedicao, reg_pedidos.status_homologacao,
                    reg_pedidos.status_pedido, reg_pedidos.status_comercial, reg_pedidos.sit_conferencia,
                    reg_pedidos.qtde_saldo_pedi, reg_pedidos.valor_saldo_pedi, reg_pedidos.ultima_atualizacao);
        EXCEPTION
            WHEN OTHERS then null;
                -- Captura erros mas não faz nada
                RAISE NOTICE 'Erro ao inserir na jma.fpedido_congelado para pedido %', reg_pedidos.pedido_venda;
        END;

        -- Loop sobre os motivos de bloqueio para cada pedido
        FOR reg_motiv_bloqueio IN cur_motiv_bloqueio(reg_pedidos.pedido_venda) LOOP

            BEGIN
                -- Inserir na tabela orion_com_311
                INSERT INTO jma.ped_cong_motivo_bloqueio (pedido_venda, seq_situacao, codigo_situacao, flag_liberacao,
                                           data_situacao, data_liberacao, data_congelamento)
                VALUES (reg_motiv_bloqueio.pedido_venda, reg_motiv_bloqueio.seq_situacao,
                        reg_motiv_bloqueio.codigo_situacao, reg_motiv_bloqueio.flag_liberacao,
                        reg_motiv_bloqueio.data_situacao, reg_motiv_bloqueio.data_liberacao, reg_motiv_bloqueio.ultima_atualizacao);
            EXCEPTION
                WHEN OTHERS then null;
                    -- Captura erros mas não faz nada
                    RAISE NOTICE 'Erro ao inserir na jma.fpedido_situacao_congelado para pedido %', reg_motiv_bloqueio.pedido_venda;
            END;

        END LOOP;

        -- Confirmar as alterações (Commit)
        COMMIT;
    END LOOP;

END;
$procedure$
;

-- DROP PROCEDURE jma.sp_ordens_corte();

CREATE OR REPLACE PROCEDURE jma.sp_ordens_corte()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    final_count INTEGER;
begin
INSERT INTO ppcp.fordens_corte
	(
        cd_ordem_producao,	
        cd_nivel99,
        cd_grupo,
        cd_subgrupo,
        prod_rej_item,
        cd_estagio,
        periodo_producao, 
        cd_ordem_confeccao,
        qtd_pecas_progamada,
        qtd_pecas_produzida,
        qtd_conserto,
        qtd_pecas_2a,
        estagio_anterior,
        situacao_ordem,
        numero_ordem_externa,
        seq_ordem_serv,
        qtd_perdas,
        sequencia_estagio,
        usuario,
        seq_operacao,
        data_alteracao,
        qtd_em_producao_pacote,
        minutos_unitario,
        minutos_total,
        minutos_total_em_producao,
        tamanho,
        sequencia_tamanho,
        qtd_marcacoes,
        qtd_a_produzir,
        rowid,
        fk_produto,
        data_producao,
        fk_fornecedor, 
        dt_prevista,
        dthora_atualizacao,
        prioridade,
        data_programacao,       
		periodo_producao_capa,
		numero_programa,
		cod_cancelamento,
		alternativa_peca,
		deposito_entrada
    )
    SELECT
		cd_ordem_producao,	
		cd_nivel99,
		cd_grupo,
		cd_subgrupo,
		prod_rej_item,
		cd_estagio,
		periodo_producao, 
		cd_ordem_confeccao,
		qtd_pecas_progamada,
		qtd_pecas_produzida,
		qtd_conserto,
		qtd_pecas_2a,
		estagio_anterior,
		situacao_ordem,
		numero_ordem_externa,
		seq_ordem_serv,
		qtd_perdas,
		sequencia_estagio,
		usuario,
		seq_operacao,
		data_alteracao,
		qtd_em_producao_pacote,
		minutos_unitario,
		minutos_total,
		minutos_total_em_producao,
		tamanho,
		sequencia_tamanho,
		qtd_marcacoes,
		qtd_a_produzir,
		rowid,
		fk_produto,
		data_producao,
		fk_fornecedor, 
		dt_prevista,
		dthora_atualizacao,
		prioridade,
		data_programacao,
		periodo_producao_capa,
		numero_programa,
		cod_cancelamento,
		alternativa_peca,
		deposito_entrada
		

FROM stage.fordens_corte_stage;
	-- Analyze adicionado para deixar o commit NAO TIRAR
	analyze ppcp.fordens_corte;
	-- Parte para debug da contagem final
	SELECT c.reltuples::bigint into final_count
	FROM   pg_class c
	JOIN   pg_namespace n ON n.oid = c.relnamespace
	WHERE  c.relname = 'fordens_corte'
	AND    n.nspname = 'ppcp';

	RAISE NOTICE 'Contagem Final da tabela: %', final_count;
END;
$procedure$
;

-- DROP PROCEDURE jma.sp_ordens_corte_backup();

CREATE OR REPLACE PROCEDURE jma.sp_ordens_corte_backup()
 LANGUAGE plpgsql
AS $procedure$

BEGIN
    INSERT INTO jma.fordens_corte(
    	cd_Ordem_Producao,	
		cd_Nivel99,
		cd_Grupo,
		cd_Subgrupo,
		Prod_Rej_Item,
		Cd_Estagio,
		Periodo_Producao, 
		cd_Ordem_confeccao,
		Qtd_Pecas_Progamada,
		Qtd_Pecas_Produzida,
		Qtd_Conserto,
		Qtd_Pecas_2A,
		Estagio_Anterior,
		Situacao_Ordem,
		Numero_Ordem_Externa,
		Seq_Ordem_Serv,
		Qtd_Perdas,
		Sequencia_Estagio,
		Usuario,
		Seq_Operacao,
		Data_Alteracao,
		Qtd_Em_Producao_Pacote,
		Minutos_Unitario,
		Minutos_Total,
		Minutos_Total_EM_PRODUCAO,
		Tamanho,
		sequencia_tamanho,
		qtd_marcacoes,
		Qtd_a_produzir,
		ROWID,
		FK_PRODUTO,
		DATA_PRODUCAO,
		FK_FORNECEDOR, 
		dt_prevista,
		DTHORA_ATUALIZACAO,
		PRIORIDADE,
		con.DATA_PROGRAMACAO,
		PERIODO_PRODUCAO_CAPA,
		NUMERO_PROGRAMA,
		COD_CANCELAMENTO
		
    	)
    SELECT
		cd_Ordem_Producao,	
		cd_Nivel99,
		cd_Grupo,
		cd_Subgrupo,
		Prod_Rej_Item,
		Cd_Estagio,
		Periodo_Producao, 
		cd_Ordem_confeccao,
		Qtd_Pecas_Progamada,
		Qtd_Pecas_Produzida,
		Qtd_Conserto,
		Qtd_Pecas_2A,
		Estagio_Anterior,
		Situacao_Ordem,
		Numero_Ordem_Externa,
		Seq_Ordem_Serv,
		Qtd_Perdas,
		Sequencia_Estagio,
		Usuario,
		Seq_Operacao,
		Data_Alteracao,
		Qtd_Em_Producao_Pacote,
		Minutos_Unitario,
		Minutos_Total,
		Minutos_Total_EM_PRODUCAO,
		Tamanho,
		sequencia_tamanho,
		qtd_marcacoes,
		Qtd_a_produzir,
		ROWID,
		FK_PRODUTO,
		DATA_PRODUCAO,
		FK_FORNECEDOR, 
		dt_prevista,
		DTHORA_ATUALIZACAO,
		PRIORIDADE,
		con.DATA_PROGRAMACAO,
		PERIODO_PRODUCAO_CAPA,
		NUMERO_PROGRAMA,
		COD_CANCELAMENTO

FROM jma.fOrdens_Corte_Stage;
END;
$procedure$
;

-- DROP PROCEDURE jma.sp_tabelapreco();

CREATE OR REPLACE PROCEDURE jma.sp_tabelapreco()
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    INSERT INTO jma.ftabelapreco(
    	fk_produto, 
    	val_tabela_preco, 
    	tabela_preco
    	)
    SELECT 
    	DISTINCT
        fk_produto,
        val_tabela_preco,
        tabela_preco
    FROM jma.ftabelaprecostage;
END;
$procedure$
;

-- DROP SCHEMA live;

CREATE SCHEMA live AUTHORIZATION postgres;

-- DROP SEQUENCE live.dshowroom_id_seq;

CREATE SEQUENCE live.dshowroom_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- live.dbriefing definição

-- Drop table

-- DROP TABLE live.dbriefing;

CREATE TABLE live.dbriefing (
	referencia varchar(6) NULL,
	cor_venda varchar(6) NULL,
	ref_cor varchar(11) NULL,
	desc_colecao varchar(60) NULL,
	desc_sub_colecao varchar(100) NULL,
	linha_produto varchar(40) NULL,
	desc_segmento varchar(62) NULL,
	pilar varchar(64) NULL,
	artigo_produto varchar(25) NULL,
	desc_comercial varchar(100) NULL,
	desc_tamanhos varchar(10) NULL,
	grade varchar(700) NULL,
	mp_principal varchar(20) NULL,
	mp_principal_desc varchar(30) NULL,
	num_sku int4 NULL,
	ultima_atualizacao timestamp NULL,
	ano_venda int4 NULL,
	modalidade varchar(68) NULL,
	classificacao_permanentes varchar(20) NULL,
	tipo_producao varchar(70) NULL,
	categoria_produto varchar(72) NULL,
	sub_categoria_produto varchar(74) NULL,
	comprimento_entrepernas varchar(76) NULL,
	tipo_shape varchar(78) NULL,
	comprimento varchar(80) NULL,
	tipo_alca varchar(82) NULL,
	tipo_decote varchar(62) NULL,
	tipo_gola varchar(64) NULL,
	tipo_manga varchar(86) NULL,
	tipo_sustentacao varchar(68) NULL,
	decoracoes varchar(78) NULL,
	tipo_estampa varchar(80) NULL,
	capacidade varchar(82) NULL,
	fat_plan_fabrica date NULL,
	lancamento_plan_loja date NULL,
	live_familia varchar(62) NULL,
	live_conjunto varchar(255) NULL,
	piramide varchar(60) NULL,
	cluster_comercial varchar(10) NULL,
	aposta_criacao numeric(1) NULL,
	estoque_limitado numeric(1) NULL,
	grade_multipla numeric(1) NULL,
	live_run numeric(1) NULL,
	acao_varejo numeric(1) NULL,
	must_have numeric(1) NULL,
	nova_cor numeric(1) NULL,
	visual_merchandising numeric(1) NULL,
	tamanho_vitrine varchar(1) NULL,
	promocional numeric(1) NULL,
	tecido varchar(60) NULL,
	colecao varchar(200) NULL,
	abreviacao_colecao varchar(100) NULL,
	sub_colecao varchar(100) NULL,
	linha varchar(100) NULL,
	familia varchar(50) NULL,
	segmento varchar(50) NULL,
	nomenclatura varchar(50) NULL,
	estilista varchar(50) NULL,
	assistente_estilo varchar(100) NULL,
	unidade_medida varchar(100) NULL,
	tipo_artigo varchar(200) NULL,
	artigo_cotas varchar(200) NULL,
	comprado_fabricado varchar(200) NULL,
	modalidades varchar(200) NULL,
	high_lights varchar(4000) NULL,
	stylist varchar(4000) NULL,
	dt_integracao timestamp NULL,
	informacoes_marketing varchar(4000) NULL,
	caract_produto_port varchar(4000) NULL,
	descr_com_port varchar(4000) NULL,
	caract_produto_ing varchar(4000) NULL,
	descr_com_ing varchar(4000) NULL,
	descr_com_ecommerce_ing varchar(4000) NULL,
	caract_produto_esp varchar(4000) NULL,
	descr_com_esp varchar(100) NULL,
	descr_com_ecommerce_esp varchar(4000) NULL,
	neon numeric(1) NULL,
	look_book numeric(1) NULL,
	icone_acron varchar(3) NULL,
	texto_portugues varchar(1000) NULL,
	texto_ingles varchar(1000) NULL,
	texto_espanhol varchar(1000) NULL,
	descricao_classificacao varchar(50) NULL,
	descricao_base_releitura varchar(50) NULL,
	rede_vendas_indicado varchar(50) NULL
);


-- live.dcad_centro_custo definição

-- Drop table

-- DROP TABLE live.dcad_centro_custo;

CREATE TABLE live.dcad_centro_custo (
	centro_custo int4 NULL,
	descricao varchar(20) NULL,
	divisao_producao int2 NULL,
	custo_despesa int2 NULL,
	fixo_variavel int2 NULL,
	tipo_mao_obra int2 NULL,
	tipo_ccusto int2 NULL,
	situacao int2 NULL,
	tempo_turno1 int2 NULL,
	tempo_turno2 int2 NULL,
	tempo_turno3 int2 NULL,
	tempo_turno4 int2 NULL,
	local_entrega varchar(20) NULL,
	centro_custo_pai int4 NULL,
	data_alteracao timestamp NULL,
	validar_cc_empresa varchar(1) NULL,
	ultima_atualizacao timestamp NULL
);


-- live.dcalendario definição

-- Drop table

-- DROP TABLE live.dcalendario;

CREATE TABLE live.dcalendario (
	"data" date NULL,
	ano int4 NULL,
	mes int4 NULL,
	nummesano varchar(20) NULL,
	mes_ano varchar(20) NULL,
	nm_mes varchar(20) NULL,
	abrev_mes varchar(20) NULL,
	dia int4 NULL,
	nm_dia varchar(20) NULL,
	abrev_dia varchar(20) NULL,
	nr_dia_semana int4 NULL,
	numero_semana int4 NULL,
	semana_ano_tabela varchar(30) NULL,
	dia_do_ano int4 NULL,
	dia_semana int4 NULL,
	dia_util int4 NULL,
	dia_util_finan int4 NULL,
	ultima_atualizacao date NULL
);


-- live.dcanaldistribuicao definição

-- Drop table

-- DROP TABLE live.dcanaldistribuicao;

CREATE TABLE live.dcanaldistribuicao (
	id int4 NULL,
	descricao varchar(100) NULL,
	modalidade varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- live.dcidades definição

-- Drop table

-- DROP TABLE live.dcidades;

CREATE TABLE live.dcidades (
	cod_cidade varchar(5) NULL,
	nm_cidade varchar(60) NULL,
	uf varchar(2) NULL,
	ddd int2 NULL,
	cod_pais int2 NULL,
	cod_fiscal int4 NULL,
	cod_reg_mer_ex int2 NULL,
	populacao int4 NULL,
	cod_cidade_zona_franca int4 NULL,
	cod_cidade_ibge int4 NULL,
	cod_sub_regiao int2 NULL,
	sub_regiao varchar(40) NULL,
	cod_suframa int2 NULL,
	cep int4 NULL,
	dthora_atualizacao timestamp NULL,
	nm_pais varchar(30) NULL,
	estado_extenso varchar(30) NULL
);


-- live.dcliente definição

-- Drop table

-- DROP TABLE live.dcliente;

CREATE TABLE live.dcliente (
	pk_cliente varchar(16) NULL,
	cod_empresa int2 NULL,
	nm_cliente varchar(70) NULL,
	nm_fantasia varchar(70) NULL,
	fone_cliente int4 NULL,
	uf_cliente varchar(2) NULL,
	cep int4 NULL,
	cidade varchar(70) NULL,
	endereco varchar(70) NULL,
	bairro varchar(20) NULL,
	dt_cadastro timestamp NULL,
	cod_representante int2 NULL,
	nm_representante varchar(50) NULL,
	nm_subregiao_cliente varchar(20) NULL,
	tipo_cliente varchar(70) NULL,
	tipo_cliente_agrupamento varchar(60) NULL,
	dt_ult_compra timestamp NULL,
	vlr_ult_compra numeric(18, 3) NULL,
	prazo_medio numeric(9, 3) NULL,
	dt_ultima_fatura timestamp NULL,
	email_cliente varchar(100) NULL,
	grupo_economico varchar(60) NULL,
	cd_grupo_economico int4 NULL,
	situacao_cliente varchar(7) NULL,
	conceito_cliente varchar(20) NULL,
	modalidade_cliente varchar(30) NULL,
	pais_cliente varchar(25) NULL,
	regiao_cliente varchar(20) NULL,
	cod_cidade int4 NULL,
	dthora_atualizacao timestamp NULL,
	cnpj_cliente varchar(120) NULL
);


-- live.dcliente_fornec_loja definição

-- Drop table

-- DROP TABLE live.dcliente_fornec_loja;

CREATE TABLE live.dcliente_fornec_loja (
	pk_cliente_fornec varchar(21) NULL,
	nome_cliente varchar(60) NULL,
	razao_cliente varchar(60) NULL,
	tipo_cliente varchar(1) NULL,
	endereco varchar(250) NULL,
	pais varchar(80) NULL,
	fone_cliente varchar(20) NULL,
	email_cliente varchar(50) NULL,
	sexo varchar(1) NULL,
	dt_cadastro timestamp NULL,
	ativo varchar(1) NULL,
	dthora_atualizacao timestamp NULL
);


-- live.dcolecoes definição

-- Drop table

-- DROP TABLE live.dcolecoes;

CREATE TABLE live.dcolecoes (
	cod_colecao numeric(3) NULL,
	desc_colecao text NULL,
	sigla_colecao text NULL
);


-- live.dcolecoes_subcolecoes definição

-- Drop table

-- DROP TABLE live.dcolecoes_subcolecoes;

CREATE TABLE live.dcolecoes_subcolecoes (
	referencia text NULL,
	colecao numeric(3) NULL,
	desc_colecao text NULL,
	cod_subcolecao numeric(38, 10) NULL,
	desc_sub_colecao text NULL
);


-- live.dconjuntos definição

-- Drop table

-- DROP TABLE live.dconjuntos;

CREATE TABLE live.dconjuntos (
	cod_empresa int2 NULL,
	cor_ref_a varchar(6) NULL,
	cor_ref_b varchar(6) NULL,
	referencia_a varchar(5) NULL,
	referencia_b varchar(5) NULL,
	ultima_atualizacao timestamp NULL
);


-- live.dfornecedor definição

-- Drop table

-- DROP TABLE live.dfornecedor;

CREATE TABLE live.dfornecedor (
	pk_fornecedor varchar(25) NULL,
	nm_fornecedor varchar(60) NULL,
	cd_situacao_fornecedor int2 NULL,
	telefone_fornecedor int4 NULL,
	cep_fornecedor int4 NULL,
	endereco_fornecedor varchar(80) NULL,
	nr_endereco varchar(25) NULL,
	bairro_fornecedor varchar(40) NULL,
	cidade_fornecedor varchar(60) NULL,
	uf_fornecedor varchar(2) NULL,
	dt_cadastro_fornecedor timestamp NULL,
	dthora_atualizacao timestamp NULL,
	nm_fantasia varchar(80) NULL
);
CREATE INDEX idx_dfornecedor_pk ON live.dfornecedor USING btree (pk_fornecedor);


-- live.dimg_produtos definição

-- Drop table

-- DROP TABLE live.dimg_produtos;

CREATE TABLE live.dimg_produtos (
	id_produto varchar(20) NULL,
	referencia varchar(20) NULL,
	cor varchar(20) NULL,
	seq_imagem int8 NULL,
	imagem_url varchar(3000) NULL,
	imagem_base64 text NULL,
	ultima_atualizacao timestamp NULL
);


-- live.dlojas definição

-- Drop table

-- DROP TABLE live.dlojas;

CREATE TABLE live.dlojas (
	pk_loja int4 NULL,
	desc_loja varchar(200) NULL,
	desc_apelido varchar(200) NULL,
	desc_razao_social varchar(200) NULL,
	pk_cnpj varchar(35) NULL,
	cod_inscricao_estadual varchar(20) NULL,
	cod_funcionario int4 NULL,
	cep int4 NULL,
	desc_endereco varchar(200) NULL,
	telefone int8 NULL,
	cod_portal varchar(20) NULL,
	pk_portal int4 NULL,
	dt_inauguracao timestamp NULL,
	metragem numeric(7, 2) NULL,
	cod_regiao int4 NULL,
	cod_usuario int4 NULL,
	flag_abre_aos_domingos int2 NULL,
	omny_channel int2 NULL,
	cod_rede int4 NULL,
	porc_franchising numeric(7, 2) NULL,
	ponto_retirada int2 NULL,
	cupom_desconto_loja varchar(20) NULL,
	dt_cadastro timestamp NULL,
	dt_ult_alteracao timestamp NULL,
	cod_cidade int4 NULL,
	cidade varchar(40) NULL,
	estado varchar(2) NULL,
	regiao varchar(100) NULL,
	rede varchar(50) NULL,
	situacao varchar(7) NULL,
	dthora_atualizacao timestamp NULL
);


-- live.dperiodo_colecoes definição

-- Drop table

-- DROP TABLE live.dperiodo_colecoes;

CREATE TABLE live.dperiodo_colecoes (
	id int4 NULL,
	colecao int2 NULL,
	descr_colecao varchar(20) NULL,
	subcolecao int2 NULL,
	descr_sub_colecao varchar(20) NULL,
	classificacao int2 NULL,
	descr_classificacao varchar(6) NULL,
	data_inicio_sell_in timestamp NULL,
	data_fim_sell_in timestamp NULL,
	data_inicio_sell_out timestamp NULL,
	data_fim_sell_out timestamp NULL,
	data_inicio_producao timestamp NULL,
	data_fim_producao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- live.dproduto definição

-- Drop table

-- DROP TABLE live.dproduto;

CREATE TABLE live.dproduto (
	pk_produto varchar(25) NULL,
	pk_produto_cigam varchar(14) NULL,
	cd_produto varchar(16) NULL,
	cd_desc_prod varchar(80) NULL,
	nivel_estrutura int2 NULL,
	desc_nivel_estrutura varchar(30) NULL,
	cd_referencia varchar(5) NULL,
	desc_produto varchar(70) NULL,
	und_medida varchar(2) NULL,
	desc_unidade_medida varchar(20) NULL,
	nm_tamanho varchar(15) NULL,
	nm_cor varchar(25) NULL,
	cd_colecao int2 NULL,
	desc_colecao varchar(30) NULL,
	cod_linha int4 NULL,
	linha_produto varchar(40) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(30) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(30) NULL,
	cd_desc_referencia varchar(50) NULL,
	cod_desc_artigo varchar(50) NULL,
	cod_agrupador int2 NULL,
	desc_agrupador varchar(50) NULL,
	tipo_produto varchar(15) NULL,
	marca varchar(50) NULL,
	cd_conta_estoque int2 NULL,
	desc_conta_estoque varchar(50) NULL,
	desc_produto_narrativa varchar(90) NULL,
	cd_cor varchar(6) NULL,
	cd_tamanho varchar(5) NULL,
	desc_narrativa varchar(70) NULL,
	preco_custo numeric(18, 3) NULL,
	item_ativo int2 NULL,
	desc_referencia varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	publico_alvo varchar(60) NULL,
	faixa_etaria varchar(60) NULL,
	codigo_contabil int4 NULL,
	classific_fiscal varchar(15) NULL,
	descr_class_fisc varchar(40) NULL,
	serie_tamanho int2 NULL,
	desc_serie_tamanho varchar(10) NULL,
	obs_serie_tamanho varchar(60) NULL,
	sub_colecao varchar(20) NULL,
	familia1 varchar(80) NULL,
	familia2 varchar(80) NULL,
	familia3 varchar(80) NULL,
	familia4 varchar(80) NULL,
	familia5 varchar(80) NULL,
	dthora_atualizacao timestamp NULL,
	sku_produto varchar(120) NULL,
	cod_subcolecao int4 NULL,
	desc_sub_colecao varchar(20) NULL,
	origem_prod numeric(1) NULL
);


-- live.dproduto_loja definição

-- Drop table

-- DROP TABLE live.dproduto_loja;

CREATE TABLE live.dproduto_loja (
	pk_produto varchar(41) NULL,
	desc_produto varchar(80) NULL,
	cod_ncm varchar(20) NULL,
	cod_cest varchar(10) NULL,
	cod_referencia varchar(20) NULL,
	desc_unidade varchar(10) NULL,
	desc_tamanho varchar(50) NULL,
	desc_setor varchar(30) NULL,
	desc_linha varchar(30) NULL,
	desc_marca varchar(30) NULL,
	desc_cor varchar(30) NULL,
	desc_colecao varchar(50) NULL,
	desc_classificacao varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- live.dreferencias_mta definição

-- Drop table

-- DROP TABLE live.dreferencias_mta;

CREATE TABLE live.dreferencias_mta (
	referencia varchar(50) NULL,
	tamanho varchar(20) NULL,
	corvenda varchar(50) NULL,
	linkimagem text NULL,
	refcor varchar(50) NULL,
	colecao varchar(100) NULL,
	categoria varchar(100) NULL,
	mpprincipal varchar(100) NULL,
	sellin numeric(18, 2) NULL,
	sellout numeric(18, 2) NULL,
	lancamento date NULL,
	descricaocor varchar(255) NULL,
	linha varchar(50) NULL,
	descricaolinha varchar(255) NULL,
	codigoinformacao int4 NULL,
	descricaocodigo varchar(255) NULL,
	artigo varchar(50) NULL,
	desricaoartigo varchar(255) NULL,
	descricaocomercial varchar(255) NULL,
	dereferencias varchar(255) NULL,
	datainicio date NULL,
	datafim date NULL,
	ultima_atualizacao timestamp NULL,
	status varchar(15) NULL
);


-- live.dregiao_lojas definição

-- Drop table

-- DROP TABLE live.dregiao_lojas;

CREATE TABLE live.dregiao_lojas (
	cod_regiao int4 NULL,
	desc_regiao varchar(40) NULL,
	cod_cidade int4 NULL
);


-- live.dresponsavel_loja definição

-- Drop table

-- DROP TABLE live.dresponsavel_loja;

CREATE TABLE live.dresponsavel_loja (
	pk_responsavel varchar(80) NULL,
	cod_loja int4 NULL,
	desc_responsavel varchar(100) NULL,
	cargo varchar(200) NULL,
	cod_situacao int2 NULL,
	dthora_atualizacao timestamp NULL,
	email text NULL,
	cod_funcao int4 NULL
);


-- live.dshowroom definição

-- Drop table

-- DROP TABLE live.dshowroom;

CREATE TABLE live.dshowroom (
	id serial4 NOT NULL,
	nome_showroom varchar NULL,
	data_inicio date NULL, -- Início período para considerar pedidos deste showroom
	data_fim date NULL, -- Fim período para considerar pedidos deste showroom
	colecao _int4 NULL,
	subcolecao _int4 NULL,
	CONSTRAINT dshowroom_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN live.dshowroom.data_inicio IS 'Início período para considerar pedidos deste showroom';
COMMENT ON COLUMN live.dshowroom.data_fim IS 'Fim período para considerar pedidos deste showroom';

-- DROP SCHEMA marft;

CREATE SCHEMA marft AUTHORIZATION postgres;
-- marft.dcelula_parada definição

-- Drop table

-- DROP TABLE marft.dcelula_parada;

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


-- marft.dfunc_integracao definição

-- Drop table

-- DROP TABLE marft.dfunc_integracao;

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


-- marft.dmotivo definição

-- Drop table

-- DROP TABLE marft.dmotivo;

CREATE TABLE marft.dmotivo (
	codigo_motivo int2 NULL,
	nome varchar(40) NULL,
	descricao varchar(250) NULL,
	active int2 NULL,
	integrationcode varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- marft.doperador_falta definição

-- Drop table

-- DROP TABLE marft.doperador_falta;

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


-- marft.doperador_parada definição

-- Drop table

-- DROP TABLE marft.doperador_parada;

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
CREATE INDEX idx_doperador_parada_data_operador ON marft.doperador_parada USING btree (data, codigo_operador);
CREATE INDEX idx_doperador_parada_operador ON marft.doperador_parada USING btree (codigo_operador);


-- marft.dvalores_premio definição

-- Drop table

-- DROP TABLE marft.dvalores_premio;

CREATE TABLE marft.dvalores_premio (
	codigo_premio numeric(5) NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	nome text NULL,
	efic_min numeric(5, 2) NULL,
	ate numeric(5, 2) NULL,
	valor numeric(5, 2) NULL
);


-- marft.fdesempenho_operador_individual definição

-- Drop table

-- DROP TABLE marft.fdesempenho_operador_individual;

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


-- marft.fdesempenho_operador_maquina definição

-- Drop table

-- DROP TABLE marft.fdesempenho_operador_maquina;

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


-- marft.foperador_status definição

-- Drop table

-- DROP TABLE marft.foperador_status;

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
CREATE INDEX idx_foperador_status_operador_data_inc ON marft.foperador_status USING btree (codigo_operador, "DATA") INCLUDE (codigo_celula);


-- marft.fprod_oper definição

-- Drop table

-- DROP TABLE marft.fprod_oper;

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
CREATE INDEX idx_fprod_oper_codcel_data ON marft.fprod_oper USING btree (cod_cel, data);
CREATE INDEX idx_fprod_oper_op ON marft.fprod_oper USING btree (op);


-- marft.fproducao_celula definição

-- Drop table

-- DROP TABLE marft.fproducao_celula;

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


-- marft.fproducao_operador definição

-- Drop table

-- DROP TABLE marft.fproducao_operador;

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

-- DROP SCHEMA ppcp;

CREATE SCHEMA ppcp AUTHORIZATION postgres;
-- ppcp.dcad_centro_custo definição

-- Drop table

-- DROP TABLE ppcp.dcad_centro_custo;

CREATE TABLE ppcp.dcad_centro_custo (
	centro_custo numeric(6) NULL,
	descricao text NULL,
	divisao_producao numeric(4) NULL,
	custo_despesa numeric(1) NULL,
	fixo_variavel numeric(1) NULL,
	tipo_mao_obra numeric(1) NULL,
	tipo_ccusto numeric(1) NULL,
	situacao numeric(1) NULL,
	tempo_turno1 numeric(3) NULL,
	tempo_turno2 numeric(3) NULL,
	tempo_turno3 numeric(3) NULL,
	tempo_turno4 numeric(3) NULL,
	local_entrega numeric(3) NULL,
	centro_custo_pai numeric(6) NULL,
	data_alteracao timestamp NULL,
	validar_cc_empresa text NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX idx_centro_custo_pk ON ppcp.dcad_centro_custo USING btree (centro_custo);


-- ppcp.dcadastro_fornecedores definição

-- Drop table

-- DROP TABLE ppcp.dcadastro_fornecedores;

CREATE TABLE ppcp.dcadastro_fornecedores (
	cnpj_forn varchar(184) NULL,
	razao_social varchar(200) NULL,
	nome_fantasia varchar(200) NULL,
	rua varchar(200) NULL,
	numero int8 NULL,
	bairro varchar(100) NULL,
	cidade varchar(100) NULL,
	estado varchar(2) NULL,
	cep int8 NULL,
	email varchar(100) NULL,
	email_nfe varchar(100) NULL,
	data_cadastro timestamp NULL,
	data_aprovacao timestamp NULL,
	divisao_producao int4 NULL,
	status int2 NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.dcapacidade_fabrica definição

-- Drop table

-- DROP TABLE ppcp.dcapacidade_fabrica;

CREATE TABLE ppcp.dcapacidade_fabrica (
	referencia varchar(5) NULL,
	id_categoria int4 NULL,
	categoria varchar(80) NULL,
	id_agrupamento int4 NULL,
	nome_agrupamento varchar(80) NULL,
	capacidade_semanal_min numeric(18, 3) NULL,
	capacidade_semanal_pecas numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.ddivisao_producao definição

-- Drop table

-- DROP TABLE ppcp.ddivisao_producao;

CREATE TABLE ppcp.ddivisao_producao (
	divisao int8 NULL,
	cnpj varchar(25) NULL,
	nomefornecedor varchar(60) NULL,
	descricaodivisao varchar(20) NULL,
	area int8 NULL,
	descricaoarea varchar(20) NULL,
	centrocusto int8 NULL,
	descricaocentrocusto varchar(20) NULL,
	eficienciapadrao int8 NULL,
	abastecimento int2 NULL,
	rota int8 NULL,
	descricaorota varchar(40) NULL,
	tipolinha numeric(13, 3) NULL,
	tipo_recurso varchar(7) NULL,
	descricaotipolinha varchar(30) NULL,
	responsavel int8 NULL,
	descricaoresponsavel varchar(40) NULL,
	gerfac int8 NULL,
	operadores int8 NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.destagio definição

-- Drop table

-- DROP TABLE ppcp.destagio;

CREATE TABLE ppcp.destagio (
	pk_estagio int2 NULL,
	desc_estagio varchar(20) NULL,
	cod_deposito int2 NULL,
	area_producao int2 NULL,
	tipo_estagio int2 NULL,
	estagio_final int2 NULL,
	sequencia_calculo_fila int2 NULL,
	estagio_base_fila int2 NULL,
	responsavel_estagio varchar(20) NULL,
	dthora_atualizacao timestamp NULL
);
CREATE INDEX idx_destagio_pk ON ppcp.destagio USING btree (pk_estagio);


-- ppcp.dhomologacao_fornecedores definição

-- Drop table

-- DROP TABLE ppcp.dhomologacao_fornecedores;

CREATE TABLE ppcp.dhomologacao_fornecedores (
	cnpj_forn varchar(184) NULL,
	razao_social varchar(200) NULL,
	nome_fantasia varchar(200) NULL,
	id_area int2 NULL,
	nome_area varchar(20) NULL,
	centro_custo int4 NULL,
	nome_ccusto varchar(20) NULL,
	id_responsavel int4 NULL,
	nome varchar(40) NULL,
	data_cadastro timestamp NULL,
	data_aprovacao timestamp NULL,
	divisao_producao int4 NULL,
	status int2 NULL,
	desc_status varchar(19) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.dinfotec_fornecedores definição

-- Drop table

-- DROP TABLE ppcp.dinfotec_fornecedores;

CREATE TABLE ppcp.dinfotec_fornecedores (
	cnpj_forn varchar(184) NULL,
	cargo_operador int4 NULL,
	qdt_operador int4 NULL,
	grupo_maquina varchar(50) NULL,
	sub_grupo_maquina varchar(50) NULL,
	qdt_maquina int4 NULL,
	centro_custo int4 NULL,
	id_area int2 NULL,
	id_tipo_servico int4 NULL,
	id_responsavel int4 NULL,
	id_rota int2 NULL,
	is_empresa int2 NULL,
	is_maquina int2 NULL,
	prazo_abastecimento int2 NULL,
	utiliza_gerfac int2 NULL,
	custo_minuto numeric(19, 4) NULL,
	eficiencia_padrao numeric(18, 3) NULL,
	min_turno_01 numeric(18, 3) NULL,
	min_turno_02 numeric(18, 3) NULL,
	min_turno_03 numeric(18, 3) NULL,
	min_turno_04 numeric(18, 3) NULL,
	informacoes_complementares varchar(250) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX idx_dinfotec_centro_maquina ON ppcp.dinfotec_fornecedores USING btree (centro_custo, grupo_maquina, sub_grupo_maquina);


-- ppcp.dmaquina definição

-- Drop table

-- DROP TABLE ppcp.dmaquina;

CREATE TABLE ppcp.dmaquina (
	pk_maquina varchar(8) NULL,
	numero_maquina int4 NULL,
	cod_grupo_maquina varchar(4) NULL,
	desc_grupo_maquina varchar(60) NULL,
	unidade_medida varchar(2) NULL,
	subgrupo_maquina varchar(3) NULL,
	desc_subgrupo varchar(10) NULL,
	observacao_subgrupo varchar(180) NULL,
	cod_familia int2 NULL,
	desc_familia varchar(25) NULL,
	maquina_ativa int4 NULL,
	cod_centro_custo int8 NULL,
	observacao_maquina varchar(65) NULL,
	dthora_atualizacao timestamp NULL,
	numero_operadores numeric(18, 3) NULL,
	volume_maximo numeric(18, 3) NULL,
	volume_minimo numeric(18, 3) NULL,
	pk_maquina_num varchar(80) NULL,
	nome_maquina varchar(10) NULL,
	descricao_maquina varchar(144) NULL
);


-- ppcp.dmotivos_reposicao definição

-- Drop table

-- DROP TABLE ppcp.dmotivos_reposicao;

CREATE TABLE ppcp.dmotivos_reposicao (
	codigo varchar(5) NULL,
	desc_motivo varchar(60) NULL,
	tipo varchar(3) NULL,
	estagio varchar(5) NULL,
	area_agrupadora varchar(5) NULL,
	desc_area varchar(60) NULL
);


-- ppcp.dobs_estagio definição

-- Drop table

-- DROP TABLE ppcp.dobs_estagio;

CREATE TABLE ppcp.dobs_estagio (
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	estagio int4 NULL,
	tamanho_ordem_confeccao varchar(15) NULL,
	tipo_obs varchar(200) NULL,
	observacao_adicional varchar(500) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.doperacao definição

-- Drop table

-- DROP TABLE ppcp.doperacao;

CREATE TABLE ppcp.doperacao (
	desc_operacao varchar(50) NULL,
	pk_operacao int4 NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX idx_doperacao_pk ON ppcp.doperacao USING btree (pk_operacao);


-- ppcp.dpolivalencia_maquinas definição

-- Drop table

-- DROP TABLE ppcp.dpolivalencia_maquinas;

CREATE TABLE ppcp.dpolivalencia_maquinas (
	id int8 NULL,
	maquina_princ varchar(8) NULL,
	maquina_poli_1 varchar(8) NULL,
	maquina_poli_2 varchar(8) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.dprevisao_vendas definição

-- Drop table

-- DROP TABLE ppcp.dprevisao_vendas;

CREATE TABLE ppcp.dprevisao_vendas (
	id int4 NULL,
	descricao varchar(255) NULL,
	descricaocolecao varchar(255) NULL,
	descricaotabprecosellin varchar(255) NULL,
	descricaotabprecosellout varchar(255) NULL,
	ref_cor varchar(100) NULL,
	sku varchar(100) NULL,
	percentual_aplicar numeric(10, 4) NULL,
	qtde_previsao_item numeric(15, 4) NULL,
	valor_sell_in numeric(15, 4) NULL,
	valor_sell_out numeric(15, 4) NULL,
	qtde_previsao_capa numeric(15, 4) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.dtecidos definição

-- Drop table

-- DROP TABLE ppcp.dtecidos;

CREATE TABLE ppcp.dtecidos (
	ref_tecido varchar(5) NULL,
	descricao_tecido varchar(30) NULL,
	referencia varchar(5) NULL,
	cod_cor varchar(6) NULL,
	cod_tecido varchar(50) NULL,
	unidade_medida varchar(2) NULL,
	composicao varchar(300) NULL,
	tipo_produto varchar(9) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fapontamento_producao definição

-- Drop table

-- DROP TABLE ppcp.fapontamento_producao;

CREATE TABLE ppcp.fapontamento_producao (
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	oc int4 NULL,
	periodo_confeccao int2 NULL,
	nivel varchar(1) NULL,
	grupo varchar(5) NULL,
	subgrupo varchar(3) NULL,
	item varchar(6) NULL,
	codigo_estagio int4 NULL,
	data_insercao timestamp NULL,
	codigo_usuario int4 NULL,
	qtd_apontada numeric(18, 3) NULL,
	qtde_perdas numeric(18, 3) NULL,
	qtde_pecas_2a numeric(18, 3) NULL,
	qtde_conserto numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	pk_produto varchar(35) NULL
);


-- ppcp.faprovacao_rolos_930 definição

-- Drop table

-- DROP TABLE ppcp.faprovacao_rolos_930;

CREATE TABLE ppcp.faprovacao_rolos_930 (
	lote varchar(10) NULL,
	rolo varchar(10) NULL,
	aprovado numeric(17, 2) NULL,
	id_motivo int4 NULL,
	desc_motivo varchar(60) NULL
);


-- ppcp.faprovacoes_requisicao definição

-- Drop table

-- DROP TABLE ppcp.faprovacoes_requisicao;

CREATE TABLE ppcp.faprovacoes_requisicao (
	data_solicitacao timestamp NULL,
	ordem_producao int4 NULL,
	ordem_reposicao int4 NULL,
	estagio_solicitante int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	alternativa_peca int2 NULL,
	parte_peca varchar(30) NULL,
	quantidade int4 NULL,
	cod_motivo_reposicao int4 NULL,
	status int2 NULL,
	status_repo varchar(32) NULL,
	status_pcp int2 NULL,
	desc_status_pcp varchar(32) NULL,
	status_qualidade int2 NULL,
	desc_status_quali varchar(32) NULL,
	necessita_amostra int2 NULL,
	observacao varchar(500) NULL,
	obs_reprovacao varchar(500) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fbeneficiamento_acomp_prod definição

-- Drop table

-- DROP TABLE ppcp.fbeneficiamento_acomp_prod;

CREATE TABLE ppcp.fbeneficiamento_acomp_prod (
	ordem_producao int4 NULL,
	codigo_estagio int4 NULL,
	seq_operacao int4 NULL,
	codigo_operacao int4 NULL,
	grupo_maquina varchar(50) NULL,
	subgrupo_maquina varchar(50) NULL,
	numero_maquina int4 NULL,
	data_inicio date NULL,
	hora_inicio timestamp NULL,
	operador_inicio int4 NULL,
	data_termino date NULL,
	hora_termino timestamp NULL,
	operador_termino int4 NULL,
	minutos_unitario numeric(10, 2) NULL,
	motivo_rejeicao varchar(255) NULL,
	ordem_reprocesso varchar(50) NULL,
	prioridade_producao varchar(20) NULL,
	previsao_termino date NULL
);


-- ppcp.fconsumo_componente definição

-- Drop table

-- DROP TABLE ppcp.fconsumo_componente;

CREATE TABLE ppcp.fconsumo_componente (
	alternativa_item int2 NULL,
	fk_produto varchar(40) NULL,
	desc_produto varchar(70) NULL,
	fk_componente varchar(40) NULL,
	narrativa varchar(70) NULL,
	linha_produto int2 NULL,
	descr_colecao varchar(20) NULL,
	alternativa_comp int2 NULL,
	estagio int4 NULL,
	artigo_cotas int2 NULL,
	descr_tamanho varchar(10) NULL,
	tipo_produto int2 NULL,
	unidade_medida varchar(2) NULL,
	ref_produto varchar(5) NULL,
	tam_produto varchar(3) NULL,
	cor_produto varchar(6) NULL,
	nivel_produto varchar(1) NULL,
	ref_componente varchar(5) NULL,
	tam_componente varchar(3) NULL,
	cor_componente varchar(6) NULL,
	nivel_componente varchar(1) NULL,
	ultima_atualizacao timestamp NULL,
	colecao int2 NULL,
	consumo numeric(18, 3) NULL
);


-- ppcp.fdefeitos_producao definição

-- Drop table

-- DROP TABLE ppcp.fdefeitos_producao;

CREATE TABLE ppcp.fdefeitos_producao (
	cod_estagio numeric(5) NULL,
	cod_estagio_digitacao numeric(5) NULL,
	cod_motivo numeric(3) NULL,
	num_ordem_confeccao numeric(5) NULL,
	cod_periodo numeric(4) NULL,
	num_ordem_producao numeric(9) NULL,
	cod_agrupador numeric(4) NULL,
	pk_defeito numeric(4) NULL,
	ultima_atualizacao timestamp NULL,
	data_rejeicao timestamp NULL,
	pk_produto varchar(35) NULL,
	des_motivo varchar(60) NULL,
	des_cod_motivo varchar(132) NULL,
	obs_perda varchar(1000) NULL,
	qtd_perda numeric(18, 3) NULL,
	tip_lancto varchar(20) NULL,
	des_agrupador varchar(40) NULL,
	pk_motivo varchar(20) NULL
);
CREATE INDEX idx_fdefeitos_estagios_data ON ppcp.fdefeitos_producao USING btree (cod_estagio, cod_estagio_digitacao, data_rejeicao);
CREATE INDEX idx_fdefeitos_ordens ON ppcp.fdefeitos_producao USING btree (num_ordem_producao, num_ordem_confeccao);


-- ppcp.festagios_beneficiamento definição

-- Drop table

-- DROP TABLE ppcp.festagios_beneficiamento;

CREATE TABLE ppcp.festagios_beneficiamento (
	seq_operacao numeric(4) NULL,
	codigo_estagio numeric(5) NULL,
	seq_estagio numeric(1) NULL,
	turno_producao numeric(1) NULL,
	data_inicio timestamp NULL,
	data_termino timestamp NULL
);


-- ppcp.finspecao_qualidade definição

-- Drop table

-- DROP TABLE ppcp.finspecao_qualidade;

CREATE TABLE ppcp.finspecao_qualidade (
	data_inspecao timestamp NULL,
	id_inspecao numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	periodo numeric(4) NULL,
	turno numeric(1) NULL,
	cod_estagio numeric(2) NULL,
	inspetor text NULL,
	pk_produto text NULL,
	grupo_maq_estamp text NULL,
	subgrupo_maq_estamp text NULL,
	revisor_origem text NULL,
	qtde_inspecionar_pcs numeric(6) NULL,
	perc_inspecionar_pcs numeric(3) NULL,
	qtde_inspecionada_pcs numeric(6) NULL,
	qtde_rejeitada_pcs numeric(6) NULL,
	perc_rejeitada_pcs numeric(3) NULL,
	tipo_inspecao numeric(1) NULL,
	id_lancamento numeric(9) NULL,
	cod_estagio_defeito numeric(2) NULL,
	cod_motivo numeric(3) NULL,
	motivo text NULL,
	qtd_inspecao numeric(6) NULL,
	cod_chave_inspecao_medidas numeric(9) NULL,
	cod_chave_inspecao numeric(9) NULL,
	cod_chave_lancamento numeric(9) NULL,
	tip_medida numeric(2) NULL,
	seq_inspecao numeric(3) NULL,
	des_inspecao text NULL,
	val_medida_padrao numeric(7, 3) NULL,
	val_medida_real numeric(7, 3) NULL,
	val_toler_minima numeric(6, 2) NULL,
	val_toler_maxima numeric(6, 2) NULL,
	val_variacao numeric(7, 3) NULL,
	cod_usuario text NULL,
	dat_hor_inspecao timestamp NULL,
	data_atualizacao timestamp NULL
);
CREATE INDEX idx_finspecao_qualidade_estagio_defeito_data ON ppcp.finspecao_qualidade USING btree (cod_estagio, cod_estagio_defeito, data_inspecao);
CREATE INDEX idx_finspecao_qualidade_ordem_prod_confeccao ON ppcp.finspecao_qualidade USING btree (ordem_producao, ordem_confeccao);
CREATE INDEX idx_finspecao_qualidade_pk_produto ON ppcp.finspecao_qualidade USING btree (pk_produto);


-- ppcp.fitens_requisicao_almoxerifado definição

-- Drop table

-- DROP TABLE ppcp.fitens_requisicao_almoxerifado;

CREATE TABLE ppcp.fitens_requisicao_almoxerifado (
	empresa int2 NULL,
	desc_empresa varchar(35) NULL,
	divisao_producao int2 NULL,
	desc_divisao_producao varchar(20) NULL,
	centro_custo int4 NULL,
	desc_centro_custo varchar(20) NULL,
	cod_deposito int2 NULL,
	sequencia int2 NULL,
	material varchar(120) NULL,
	quantidade numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.flista_prioridades definição

-- Drop table

-- DROP TABLE ppcp.flista_prioridades;

CREATE TABLE ppcp.flista_prioridades (
	id float8 NULL,
	referencia varchar(5) NULL,
	descreferencia varchar(30) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	desccor varchar(20) NULL,
	ordemproducao int4 NULL,
	prioridadecor int4 NULL,
	ordemconfeccao int4 NULL,
	periodo int2 NULL,
	seqfilaestagio int2 NULL,
	seqestagio int2 NULL,
	seqoperacao int2 NULL,
	codestagio int4 NULL,
	codestagiodepende int4 NULL,
	descestagio varchar(20) NULL,
	pedidovenda int4 NULL,
	qtdeprogramada int4 NULL,
	qtdeemproducaopacote int4 NULL,
	emconserto numeric(21, 3) NULL,
	codfamilia int4 NULL,
	codfaccao varchar(100) NULL,
	descfaccao varchar(60) NULL,
	dataentradaestagio timestamp NULL,
	qtdeestagiossimultatendidos numeric(21, 3) NULL,
	familiaacabamento varchar(80) NULL,
	tempounit numeric(21, 3) NULL,
	qtdecarteira numeric(21, 3) NULL,
	qtdeestoque numeric(21, 3) NULL,
	qtdeemproducao numeric(21, 3) NULL,
	qtdesugerida numeric(21, 3) NULL,
	qtdecoletada numeric(21, 3) NULL,
	ultima_atualizacao date NULL
);


-- ppcp.fmaquinas_divisao_externa definição

-- Drop table

-- DROP TABLE ppcp.fmaquinas_divisao_externa;

CREATE TABLE ppcp.fmaquinas_divisao_externa (
	divisao numeric(38, 10) NULL,
	nome_divisao text NULL,
	cnpj text NULL,
	cod_maquina text NULL,
	maquina text NULL,
	quantidade numeric(6) NULL,
	data_atualizacao timestamp NULL
);
CREATE INDEX idx_maquinas_externa_maquina ON ppcp.fmaquinas_divisao_externa USING btree (maquina, cnpj, divisao);


-- ppcp.fmaquinas_divisao_interna definição

-- Drop table

-- DROP TABLE ppcp.fmaquinas_divisao_interna;

CREATE TABLE ppcp.fmaquinas_divisao_interna (
	cod_divisao numeric(38, 10) NULL,
	nome_divisao text NULL,
	centro_custo numeric(6) NULL,
	cod_maquina text NULL,
	cod_maquina_completo text NULL,
	descricao_ativo text NULL,
	divisao numeric(38, 10) NULL,
	tipo_maquina text NULL,
	tipo_operacao numeric(1) NULL,
	un_med_capacid text NULL,
	status_ativo text NULL,
	contagem_numero_serie numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX idx_maquinas_interna_maquina ON ppcp.fmaquinas_divisao_interna USING btree (cod_maquina_completo, cod_maquina, centro_custo, divisao);


-- ppcp.fmedidas_insumos definição

-- Drop table

-- DROP TABLE ppcp.fmedidas_insumos;

CREATE TABLE ppcp.fmedidas_insumos (
	referencia varchar(80) NULL,
	alternativa int4 NULL,
	sequencia int4 NULL,
	seq_estrutura int4 NULL,
	parte_conjunto int4 NULL,
	descricao varchar(180) NULL,
	proporcao int4 NULL,
	tolerancia_min int4 NULL,
	tolerancia_max int4 NULL,
	tamanho varchar(40) NULL,
	unidade_metrica varchar(25) NULL,
	medida numeric(15, 3) NULL,
	medida_pf varchar(80) NULL,
	tipo_medida int4 NULL
);


-- ppcp.fmovimentacao_enderecos definição

-- Drop table

-- DROP TABLE ppcp.fmovimentacao_enderecos;

CREATE TABLE ppcp.fmovimentacao_enderecos (
	produto text NULL,
	nivel text NULL,
	grupo text NULL,
	subgrupo text NULL,
	item text NULL,
	descricao text NULL,
	deposito numeric(3) NULL,
	situacaotag numeric(1) NULL,
	qtdeenderecado numeric(38, 10) NULL,
	qtdesemendereco numeric(38, 10) NULL
);


-- ppcp.foperadores_divisao definição

-- Drop table

-- DROP TABLE ppcp.foperadores_divisao;

CREATE TABLE ppcp.foperadores_divisao (
	data_operadoras timestamp NULL,
	turno_familia int2 NULL,
	divisao int4 NULL,
	numero_operadoras int2 NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fordem_producao_leadtime definição

-- Drop table

-- DROP TABLE ppcp.fordem_producao_leadtime;

CREATE TABLE ppcp.fordem_producao_leadtime (
	periodo numeric(38, 10) NULL,
	ordem_producao numeric(9) NULL,
	codigo_estagio numeric(5) NULL,
	qtde_produzida numeric(38, 10) NULL,
	data_entrada_fase timestamp NULL,
	data_saida_fase timestamp NULL,
	lead_time numeric(38, 10) NULL
);


-- ppcp.fordens_aproduzir_pacote definição

-- Drop table

-- DROP TABLE ppcp.fordens_aproduzir_pacote;

CREATE TABLE ppcp.fordens_aproduzir_pacote (
	ordem_producao numeric(9) NULL,
	periodo_producao numeric(4) NULL,
	cod_estagio numeric(5) NULL,
	seq_est numeric(3) NULL,
	cod_cor text NULL,
	cod_tam text NULL,
	qtde_pecas_prog numeric(38, 10) NULL,
	qtde_a_produzir_pacote numeric(38, 10) NULL
);


-- ppcp.fordens_beneficiamento definição

-- Drop table

-- DROP TABLE ppcp.fordens_beneficiamento;

CREATE TABLE ppcp.fordens_beneficiamento (
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	data_inicio timestamp NULL,
	data_termino timestamp NULL,
	atraso int4 NULL,
	cod_situacao int4 NULL,
	situacao varchar(15) NULL,
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	tipo_ordem varchar(1) NULL,
	ordem_agrupamento int4 NULL,
	codigo_estagio int4 NULL,
	situacao_receita varchar(1) NULL,
	grupo_tingimento varchar(102) NULL,
	tempo float8 NULL,
	seq_operacao float8 NULL,
	pk_produto varchar(50) NULL,
	um varchar(2) NULL,
	alternativa_item int2 NULL,
	ultima_atualizacao timestamp NULL,
	quilos_prod numeric(21, 3) NULL,
	rolos_prod numeric(21, 3) NULL,
	quilos_prog numeric(21, 3) NULL,
	rolos_prog numeric(21, 3) NULL,
	quilos_prep numeric(21, 3) NULL,
	rolos_prep numeric(21, 3) NULL,
	prioridade_onebit varchar(10) NULL
);


-- ppcp.fordens_corte definição

-- Drop table

-- DROP TABLE ppcp.fordens_corte;

CREATE TABLE ppcp.fordens_corte (
	cd_ordem_producao int4 NULL,
	cd_nivel99 float8 NULL,
	cd_grupo varchar(5) NULL,
	cd_subgrupo varchar(5) NULL,
	prod_rej_item varchar(6) NULL,
	cd_estagio int4 NULL,
	periodo_producao int2 NULL,
	cd_ordem_confeccao int4 NULL,
	qtd_pecas_progamada numeric(18, 3) NULL,
	qtd_pecas_produzida numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_pecas_2a numeric(18, 3) NULL,
	estagio_anterior int4 NULL,
	situacao_ordem int2 NULL,
	numero_ordem_externa int4 NULL,
	seq_ordem_serv int2 NULL,
	qtd_perdas numeric(18, 3) NULL,
	sequencia_estagio int2 NULL,
	usuario varchar(250) NULL,
	seq_operacao int2 NULL,
	data_alteracao timestamp NULL,
	qtd_em_producao_pacote numeric(18, 3) NULL,
	tamanho varchar(3) NULL,
	sequencia_tamanho int4 NULL,
	qtd_marcacoes numeric(18, 3) NULL,
	qtd_a_produzir numeric(18, 3) NULL,
	rowid varchar(100) NULL,
	fk_produto varchar(125) NULL,
	data_producao timestamp NULL,
	fk_fornecedor varchar(150) NULL,
	dt_lancamento timestamp NULL,
	dt_prevista timestamp NULL,
	dthora_atualizacao timestamp NULL,
	prioridade int4 NULL,
	data_programacao timestamp NULL,
	periodo_producao_capa int2 NULL,
	numero_programa int2 NULL,
	cod_cancelamento int2 NULL,
	alternativa_peca int2 NULL,
	deposito_entrada int2 NULL,
	data_entrada_estagio timestamp NULL,
	observacao text NULL
);
CREATE INDEX idx_fordens_corte_fk_fornecedor ON ppcp.fordens_corte USING btree (fk_fornecedor);
CREATE INDEX idx_fordens_corte_fk_produto_alt ON ppcp.fordens_corte USING btree (fk_produto, alternativa_peca);
CREATE INDEX idx_fordens_corte_prod_est_sit_cancel_periodo ON ppcp.fordens_corte USING btree (cd_estagio, situacao_ordem, cod_cancelamento, periodo_producao_capa) WHERE (qtd_em_producao_pacote > (0)::numeric);


-- ppcp.fordens_em_producao definição

-- Drop table

-- DROP TABLE ppcp.fordens_em_producao;

CREATE TABLE ppcp.fordens_em_producao (
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	codigo_estagio int4 NULL,
	sequencia_estagio int2 NULL,
	estagio_anterior int4 NULL,
	seq_operacao int2 NULL,
	prioridade_produ int4 NULL,
	alternativa_peca int2 NULL,
	fk_produto varchar(35) NULL,
	qtde_pecas_prog numeric(18, 3) NULL,
	qtde_pecas_prod numeric(18, 3) NULL,
	qtde_em_producao numeric(18, 3) NULL,
	qtde_programada numeric(18, 3) NULL,
	qtde_conserto numeric(18, 3) NULL,
	qtde_pecas_2a numeric(18, 3) NULL,
	qtde_perdas numeric(18, 3) NULL,
	numero_ordem int4 NULL,
	cnpj_fornecedor varchar(35) NULL,
	ultima_atualizacao timestamp NULL,
	data_alteracao timestamp NULL,
	qtde_pecas_prog_ktl numeric(18, 3) NULL,
	cod_cancelamento int8 NULL
);


-- ppcp.fordens_produzidas definição

-- Drop table

-- DROP TABLE ppcp.fordens_produzidas;

CREATE TABLE ppcp.fordens_produzidas (
	cd_nivel99 text NULL,
	cd_grupo text NULL,
	cd_subgrupo text NULL,
	cd_item text NULL,
	data_producao timestamp NULL,
	periodo_capa numeric(4) NULL,
	periodo_producao numeric(4) NULL,
	cd_estagio numeric(5) NULL,
	des_estagio text NULL,
	data_entrada_estagio timestamp NULL,
	turno text NULL,
	cd_ordem_producao text NULL,
	cd_ordem_confeccao numeric(5) NULL,
	nome_fornecedor text NULL,
	des_familia text NULL,
	qtd_produzidas numeric(38, 10) NULL,
	qtd_conserto numeric(6) NULL,
	qtd_perdas numeric(6) NULL,
	qtd_segunda numeric(6) NULL,
	tempo_unit numeric(38, 10) NULL,
	qtde_estampas numeric(38, 10) NULL,
	tempo_costura numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL,
	estagio_anterior varchar(30) NULL
);
CREATE INDEX idx_fordens_prod_cd_estagio_data ON ppcp.fordens_produzidas USING btree (cd_estagio, data_producao);
CREATE INDEX idx_fordens_prod_grupo_item_subgrupo_nivel ON ppcp.fordens_produzidas USING btree (cd_grupo, cd_subgrupo, cd_item, cd_nivel99);
CREATE INDEX idx_fordens_prod_ordem ON ppcp.fordens_produzidas USING btree (cd_ordem_producao, cd_ordem_confeccao);
CREATE INDEX idx_fordens_prod_periodo ON ppcp.fordens_produzidas USING btree (periodo_producao);


-- ppcp.fordens_produzidas_alt_item definição

-- Drop table

-- DROP TABLE ppcp.fordens_produzidas_alt_item;

CREATE TABLE ppcp.fordens_produzidas_alt_item (
	cd_nivel99 text NULL,
	cd_grupo text NULL,
	cd_subgrupo text NULL,
	cd_item text NULL,
	data_producao timestamp NULL,
	periodo_capa numeric(4) NULL,
	periodo_producao numeric(4) NULL,
	cd_estagio numeric(5) NULL,
	des_estagio text NULL,
	data_entrada_estagio timestamp NULL,
	turno text NULL,
	cd_ordem_producao numeric(9) NULL,
	cd_ordem_confeccao numeric(5) NULL,
	nome_fornecedor text NULL,
	des_familia text NULL,
	qtd_produzidas numeric(6) NULL,
	qtd_conserto numeric(6) NULL,
	qtd_perdas numeric(6) NULL,
	qtd_segunda numeric(6) NULL,
	tempo_unit numeric(38, 10) NULL,
	qtde_estampas numeric(38, 10) NULL,
	tempo_costura numeric(38, 10) NULL,
	alternativa_peca numeric(2) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fordens_reposicoes definição

-- Drop table

-- DROP TABLE ppcp.fordens_reposicoes;

CREATE TABLE ppcp.fordens_reposicoes (
	id_reposicao int4 NULL,
	ordemreposicaoformatted varchar(40) NULL,
	solicitacao_reposicao int4 NULL,
	ordemreposicao int4 NULL,
	ordemproducao int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(20) NULL,
	cor varchar(6) NULL,
	estagioformatted varchar(61) NULL,
	estagio int2 NULL,
	datageracao timestamp NULL,
	usuariogerador varchar(50) NULL,
	databaixaestagio timestamp NULL,
	usuariobaixaestagio varchar(50) NULL,
	situacao int2 NULL,
	observacao varchar(200) NULL,
	solicitante varchar(60) NULL,
	motivocancelamento varchar(100) NULL,
	diasfase numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	parte_peca varchar(30) NULL,
	cod_motivo_reposicao numeric(9) NULL,
	quantidade numeric(9) NULL
);


-- ppcp.fordens_servico definição

-- Drop table

-- DROP TABLE ppcp.fordens_servico;

CREATE TABLE ppcp.fordens_servico (
	numero_ordem int8 NULL,
	ordem_producao int8 NULL,
	nota_fiscal int8 NULL,
	cod_fornecedor varchar(20) NULL,
	data_emissao date NULL,
	data_entrega date NULL,
	codigo_servico int4 NULL,
	cod_tabela_serv int4 NULL,
	cod_canc_ordem int4 NULL,
	descr_canc_ordem varchar(255) NULL,
	cond_pgto varchar(50) NULL,
	situacao_ordem varchar(20) NULL,
	valor numeric(18, 2) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fordens_tecelagem definição

-- Drop table

-- DROP TABLE ppcp.fordens_tecelagem;

CREATE TABLE ppcp.fordens_tecelagem (
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	data_inicial timestamp NULL,
	data_final timestamp NULL,
	atraso int4 NULL,
	cod_situacao int4 NULL,
	situacao varchar(15) NULL,
	periodo_producao int2 NULL,
	ordem_tecelagem int4 NULL,
	codigo_estagio int4 NULL,
	seq_operacao int4 NULL,
	pk_produto varchar(85) NULL,
	um varchar(2) NULL,
	ultima_atualizacao timestamp NULL,
	quilos_prod numeric(21, 3) NULL,
	rolos_prod numeric(21, 3) NULL,
	quilos_prog numeric(21, 3) NULL,
	rolos_prog numeric(21, 3) NULL,
	saldo_quilos numeric(21, 3) NULL,
	saldo_rolos numeric(21, 3) NULL
);


-- ppcp.fpontualidade_beneficiamento definição

-- Drop table

-- DROP TABLE ppcp.fpontualidade_beneficiamento;

CREATE TABLE ppcp.fpontualidade_beneficiamento (
	periodo int4 NULL,
	codigo_estagio int4 NULL,
	termino_previsto timestamp NULL,
	data_congelamento timestamp NULL,
	ordem_beneficiamento int4 NULL,
	produto varchar(50) NULL,
	descricao varchar(255) NULL,
	data_termino timestamp NULL,
	data_inicio_fatu timestamp NULL,
	programado numeric(15, 3) NULL,
	produzido numeric(15, 3) NULL,
	kg_programados numeric(15, 3) NULL,
	kg_produzidos numeric(15, 3) NULL,
	quebra numeric(15, 3) NULL,
	percentual_pontualidade numeric(5, 2) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fpontualidade_confeccao definição

-- Drop table

-- DROP TABLE ppcp.fpontualidade_confeccao;

CREATE TABLE ppcp.fpontualidade_confeccao (
	periodo int4 NULL,
	data_ini_fatu timestamp NULL,
	codigo_estagio int4 NULL,
	sequencia int4 NULL,
	inicio_previsto timestamp NULL,
	termino_previsto timestamp NULL,
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	referencia varchar(50) NULL,
	tamanho varchar(20) NULL,
	cor varchar(50) NULL,
	descricao varchar(255) NULL,
	data_congelamento timestamp NULL,
	programado numeric(15, 3) NULL,
	produzido numeric(15, 3) NULL,
	qtde_pontual numeric(15, 3) NULL,
	percentual_pontualidade numeric(5, 2) NULL,
	a_produzir numeric(15, 3) NULL,
	em_producao numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fproducao_seda definição

-- Drop table

-- DROP TABLE ppcp.fproducao_seda;

CREATE TABLE ppcp.fproducao_seda (
	turno numeric(38) NULL,
	nome text NULL,
	pedido numeric(9) NULL,
	qtdepecas numeric(38, 10) NULL,
	dataleitura timestamp NULL
);


-- ppcp.fprodutividade_operador_marft definição

-- Drop table

-- DROP TABLE ppcp.fprodutividade_operador_marft;

CREATE TABLE ppcp.fprodutividade_operador_marft (
	"data" timestamp NULL,
	codigo_operador numeric(5) NULL,
	nome text NULL,
	cpf text NULL,
	cracha text NULL,
	status text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	"percent" numeric(5, 4) NULL,
	award_coefficient_c numeric(4, 2) NULL,
	award_coefficient_i numeric(4, 2) NULL,
	award_individual_me numeric(2, 2) NULL,
	status_marft varchar(25) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX idx_fprodop_codigo_celula ON ppcp.fprodutividade_operador_marft USING btree (codigo_celula);
CREATE INDEX idx_fprodop_nome_data ON ppcp.fprodutividade_operador_marft USING btree (nome, data DESC);


-- ppcp.fprodutos_bloqueados_venda definição

-- Drop table

-- DROP TABLE ppcp.fprodutos_bloqueados_venda;

CREATE TABLE ppcp.fprodutos_bloqueados_venda (
	linha numeric(3) NULL,
	artigo numeric(5) NULL,
	colecao numeric(4) NULL,
	pk_produto text NULL,
	sku_produto text NULL,
	per_ini_bloq timestamp NULL,
	per_fim_bloq timestamp NULL,
	observacao_bloq text NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fqtd_produzida definição

-- Drop table

-- DROP TABLE ppcp.fqtd_produzida;

CREATE TABLE ppcp.fqtd_produzida (
	ordem_producao int4 NULL,
	oc int4 NULL,
	codigo_estagio int4 NULL,
	data_producao timestamp NULL,
	ultima_atualizacao timestamp NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	qtd_programada int4 NULL,
	codigo_usuario int4 NULL,
	qtd_produzida numeric(18, 3) NULL
);


-- ppcp.frejeicao_pecas_tecido definição

-- Drop table

-- DROP TABLE ppcp.frejeicao_pecas_tecido;

CREATE TABLE ppcp.frejeicao_pecas_tecido (
	data_rejeicao timestamp NULL,
	ordem_producao int4 NULL,
	estagio int4 NULL,
	periodo int2 NULL,
	fk_tecido varchar(50) NULL,
	fk_produto varchar(50) NULL,
	parte_peca varchar(50) NULL,
	motivo int4 NULL,
	desc_motivo varchar(60) NULL,
	quantidade int2 NULL,
	ultima_atualizacao timestamp NULL,
	ordem_confeccao varchar(15) NULL,
	seq_operacao varchar(15) NULL
);
CREATE INDEX idx_frejeicao_estagio_data ON ppcp.frejeicao_pecas_tecido USING btree (estagio, data_rejeicao);
CREATE INDEX idx_frejeicao_ordem_prod ON ppcp.frejeicao_pecas_tecido USING btree (ordem_producao);


-- ppcp.frolos_reservados definição

-- Drop table

-- DROP TABLE ppcp.frolos_reservados;

CREATE TABLE ppcp.frolos_reservados (
	ordem_producao int4 NULL,
	codigo_rolo int4 NULL,
	deposito int2 NULL,
	cd_tecido varchar(35) NULL,
	qtde_reservada numeric(18, 3) NULL,
	qtde_necessaria numeric(18, 3) NULL,
	tipo_rolo numeric(12, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.froteiro definição

-- Drop table

-- DROP TABLE ppcp.froteiro;

CREATE TABLE ppcp.froteiro (
	num_roteiro int2 NULL,
	seq_operacao int2 NULL,
	fk_operacao int4 NULL,
	fk_estagio int2 NULL,
	seq_estagio int2 NULL,
	estagio_depende int2 NULL,
	qtd_rolos int4 NULL,
	observacao_roteiro varchar(200) NULL,
	centro_custo int4 NULL,
	ccusto_homem int4 NULL,
	dthora_atualizacao timestamp NULL,
	qtd_cordas int4 NULL,
	minutos_roteiro numeric(18, 3) NULL,
	velocidade numeric(18, 3) NULL,
	minutos_homem numeric(18, 3) NULL,
	fk_produto varchar(20) NULL,
	alternativa_item int4 NULL
);


-- ppcp.fstatus_requisicao_reposicoes definição

-- Drop table

-- DROP TABLE ppcp.fstatus_requisicao_reposicoes;

CREATE TABLE ppcp.fstatus_requisicao_reposicoes (
	data_geracao timestamp NULL,
	ordem_producao int4 NULL,
	ordem_reposicao int4 NULL,
	solicitacao_reposicao int4 NULL,
	estagio int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(20) NULL,
	cor varchar(6) NULL,
	situacao int2 NULL,
	desc_situacao varchar(32) NULL,
	observacao varchar(500) NULL,
	motivo_cancelamento varchar(100) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fsugestao_cancelamento definição

-- Drop table

-- DROP TABLE ppcp.fsugestao_cancelamento;

CREATE TABLE ppcp.fsugestao_cancelamento (
	referencia varchar(5) NULL,
	cor varchar(6) NULL,
	cod_colecao int2 NULL,
	desc_colecao varchar(20) NULL,
	id_motivo int8 NULL,
	sugcancelproducao varchar(28) NULL,
	desc_motivo varchar(30) NULL,
	ultima_atualizacao timestamp NULL
);


-- ppcp.fsugestao_reserva_tecido definição

-- Drop table

-- DROP TABLE ppcp.fsugestao_reserva_tecido;

CREATE TABLE ppcp.fsugestao_reserva_tecido (
	periodo_producao varchar(8) NULL,
	fk_componente varchar(40) NULL,
	unidade_medida varchar(2) NULL,
	familia_acabamento varchar(80) NULL,
	agrupmento_artigo varchar(80) NULL,
	cd_ordem_producao varchar(25) NULL,
	cd_estagio varchar(25) NULL,
	referencia varchar(25) NULL,
	cod_cor varchar(25) NULL,
	consumo_programado varchar(25) NULL,
	mt_lineares_prod numeric(17, 2) NULL,
	alternativa_peca int2 NULL,
	pecas_pacote numeric(18, 3) NULL,
	total_consumo numeric(18, 3) NULL
);


-- ppcp.ftempo_tear definição

-- Drop table

-- DROP TABLE ppcp.ftempo_tear;

CREATE TABLE ppcp.ftempo_tear (
	pk_produto text NULL,
	sku_produto text NULL,
	descr_referencia text NULL,
	numero_alternati numeric(2) NULL,
	numero_roteiro numeric(2) NULL,
	seq_operacao numeric(4) NULL,
	codigo_estagio numeric(5) NULL,
	codigo_operacao numeric(5) NULL,
	nome_operacao text NULL,
	nr_agulhas numeric(3) NULL,
	grupo_maquina text NULL,
	nome_grupo_maq text NULL,
	sub_maquina text NULL,
	tipo_carga numeric(1) NULL,
	un_med_capacid text NULL,
	man_automatica numeric(1) NULL,
	numero_cordas numeric(3) NULL,
	numero_rolos numeric(5) NULL,
	minutos_homem numeric(9, 4) NULL,
	tempo_maquina numeric(9, 4) NULL
);

-- DROP SCHEMA rh;

CREATE SCHEMA rh AUTHORIZATION postgres;

-- DROP SEQUENCE rh.fafastamentos_employer_id_seq;

CREATE SEQUENCE rh.fafastamentos_employer_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- rh.dbanco_horas definição

-- Drop table

-- DROP TABLE rh.dbanco_horas;

CREATE TABLE rh.dbanco_horas (
	descr_banco_horas varchar(50) NULL,
	dthora_atualizacao timestamp NULL,
	pk_banco_horas int4 NULL
);


-- rh.dcargo definição

-- Drop table

-- DROP TABLE rh.dcargo;

CREATE TABLE rh.dcargo (
	desc_cargo varchar(125) NULL,
	ds_cd_cargo varchar(70) NULL,
	desc_cargo_resum varchar(60) NULL,
	cd_cargo varchar(30) NULL,
	cd_est_cargo int4 NULL,
	pk_cargo varchar(30) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dcausa_demissao definição

-- Drop table

-- DROP TABLE rh.dcausa_demissao;

CREATE TABLE rh.dcausa_demissao (
	desc_dem varchar(50) NULL,
	cd_ds_dem varchar(70) NULL,
	cd_cau_rai int2 NULL,
	cd_cag int2 NULL,
	pk_causa_demissao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dcodigo_calculo definição

-- Drop table

-- DROP TABLE rh.dcodigo_calculo;

CREATE TABLE rh.dcodigo_calculo (
	pk_codigo_calculado varchar(60) NULL,
	cd_cal int4 NULL,
	cd_tip_cal int2 NULL,
	cd_sit_cal varchar(1) NULL,
	dt_per_ref timestamp NULL,
	dt_pag timestamp NULL,
	dt_ini_cmp timestamp NULL,
	dt_fim_cmp timestamp NULL,
	cd_ori int4 NULL,
	dt_ani_apu timestamp NULL,
	dt_fim_apu timestamp NULL,
	dt_ini_ace timestamp NULL,
	dt_fim_ace timestamp NULL,
	cd_tip_cao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.ddependente definição

-- Drop table

-- DROP TABLE rh.ddependente;

CREATE TABLE rh.ddependente (
	pk_depedente varchar(170) NULL,
	cd_nome_dep varchar(70) NULL,
	cd_nome_mae varchar(70) NULL,
	cd_gra_par int2 NULL,
	cd_tip_dep int2 NULL,
	cd_tip_sex varchar(2) NULL,
	cd_est_civ int2 NULL,
	cd_gra_ins int2 NULL,
	cd_lim_irf int2 NULL,
	cd_lim_saf int2 NULL,
	cd_avi_imp varchar(1) NULL,
	dt_nas timestamp NULL,
	dt_ent_cer timestamp NULL,
	cd_pai_nas int4 NULL,
	cd_est_nas varchar(4) NULL,
	dt_obi timestamp NULL,
	cd_nome_com varchar(70) NULL,
	cd_pes int4 NULL,
	cd_dep int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dempresa definição

-- Drop table

-- DROP TABLE rh.dempresa;

CREATE TABLE rh.dempresa (
	desc_empresa varchar(60) NULL,
	cd_ds_empresa varchar(100) NULL,
	pk_empresa int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dempresa_employer definição

-- Drop table

-- DROP TABLE rh.dempresa_employer;

CREATE TABLE rh.dempresa_employer (
	id int4 NULL,
	id_grupo_economico int4 NULL,
	grupo_economico varchar(50) NULL,
	cnpj varchar(20) NULL,
	cei varchar(50) NULL,
	codigo_empresa varchar(20) NULL,
	razao_social varchar(255) NULL,
	porte_empresa varchar(30) NULL,
	data_cadastro timestamp NULL,
	data_alteracao timestamp NULL,
	flag_inativo varchar(10) NULL,
	data_atualizacao timestamp DEFAULT CURRENT_TIMESTAMP NULL
);


-- rh.descala definição

-- Drop table

-- DROP TABLE rh.descala;

CREATE TABLE rh.descala (
	pk_escala int4 NULL,
	desc_nome varchar(50) NULL,
	cd_hor_dsr int8 NULL,
	cd_hor_sem int8 NULL,
	cd_hor_mes int8 NULL,
	cd_tip_fer varchar(3) NULL,
	cd_tab_fer int2 NULL,
	cd_tip_esc varchar(1) NULL,
	cd_tur_esc int2 NULL,
	cd_tip_jor int2 NULL,
	cd_tip_jos int2 NULL,
	desc_jor varchar(200) NULL,
	desc_sim varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.devento definição

-- Drop table

-- DROP TABLE rh.devento;

CREATE TABLE rh.devento (
	pk_evento varchar(110) NULL,
	cd_evento int4 NULL,
	cd_tipo_evento int2 NULL,
	desc_evento varchar(55) NULL,
	cd_ds_evento varchar(96) NULL,
	cd_tabela int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.deventos_rh definição

-- Drop table

-- DROP TABLE rh.deventos_rh;

CREATE TABLE rh.deventos_rh (
	cd_tab int8 NULL,
	cd_eve int8 NULL,
	fg_normal text NULL,
	fg_absenteismo text NULL,
	fg_extra text NULL,
	fg_rescisao text NULL,
	fg_normalabsenteismo text NULL
);


-- rh.dfilial definição

-- Drop table

-- DROP TABLE rh.dfilial;

CREATE TABLE rh.dfilial (
	cd_razao_social varchar(60) NULL,
	cd_nome_filial varchar(60) NULL,
	cd_desc_filial varchar(180) NULL,
	desc_atividade varchar(80) NULL,
	cd_edificio varchar(60) NULL,
	cd_endereco varchar(160) NULL,
	cd_tip_fil varchar(3) NULL,
	cd_numcgc int8 NULL,
	cd_insest varchar(18) NULL,
	cd_filctb int4 NULL,
	cd_ultfic int8 NULL,
	desc_nomcom varchar(100) NULL,
	cd_parpat varchar(3) NULL,
	pk_filial varchar(120) NULL,
	dthora_atualizacao timestamp NULL,
	cd_filial int4 NULL,
	pk_cnpj int8 NULL,
	cnpj varchar(20) NULL
);


-- rh.dfuncionario definição

-- Drop table

-- DROP TABLE rh.dfuncionario;

CREATE TABLE rh.dfuncionario (
	pk_funcionario varchar(122) NULL,
	pk_funcionario_filial varchar(163) NULL,
	nm_funcionario varchar(40) NULL,
	cd_nm_funcionario varchar(81) NULL,
	cpf varchar(11) NULL,
	cd_empresa varchar(4) NULL,
	cd_funcionario varchar(9) NULL,
	cd_empresa_filial varchar(81) NULL,
	cd_escolaridade varchar(2) NULL,
	cd_cargo varchar(65) NULL,
	nm_local varchar(60) NULL,
	cd_nacionalidade varchar(5) NULL,
	dt_nascimento timestamp NULL,
	dt_admissao timestamp NULL,
	fg_deficiente varchar(1) NULL,
	cotdef varchar(1) NULL,
	sexo varchar(9) NULL,
	cd_tipo_funcionario varchar(1) NULL,
	cd_tipo_contrato varchar(2) NULL,
	cd_endereco varchar(6) NULL,
	endereco varchar(100) NULL,
	nr_cep varchar(8) NULL,
	nr_telefone varchar(20) NULL,
	nm_cidade varchar(30) NULL,
	uf varchar(2) NULL,
	nr_cep_bairro varchar(8) NULL,
	nm_bairro varchar(40) NULL,
	ds_tipo_contrato varchar(32) NULL,
	cd_afastamento varchar(6) NULL,
	dt_afastamento_original timestamp NULL,
	faixa_etaria varchar(12) NULL,
	ds_situacao varchar(30) NULL,
	cargo_atual varchar(60) NULL,
	nm_filial_atual varchar(40) NULL,
	idade varchar(7) NULL,
	dt_demissao varchar(50) NULL,
	ds_causa_demissao varchar(30) NULL,
	ds_motivo_demissao varchar(40) NULL,
	ultima_atualizacao timestamp NULL,
	centrocusto varchar(150) NULL,
	turno varchar(15) NULL,
	cd_causa_demissao varchar(30) NULL
);
CREATE INDEX idx_dfuncionario_pk ON rh.dfuncionario USING btree (pk_funcionario);


-- rh.dfuncionario_historico definição

-- Drop table

-- DROP TABLE rh.dfuncionario_historico;

CREATE TABLE rh.dfuncionario_historico (
	pk_funcionario varchar(122) NULL,
	pk_funcionario_filial varchar(163) NULL,
	nm_funcionario varchar(40) NULL,
	cd_nm_funcionario varchar(81) NULL,
	cpf varchar(11) NULL,
	cd_empresa varchar(4) NULL,
	cd_funcionario varchar(9) NULL,
	cd_empresa_filial varchar(81) NULL,
	cd_escolaridade varchar(2) NULL,
	cd_cargo varchar(65) NULL,
	nm_local varchar(60) NULL,
	cd_nacionalidade varchar(5) NULL,
	dt_nascimento timestamp NULL,
	dt_admissao timestamp NULL,
	fg_deficiente varchar(1) NULL,
	cotdef varchar(1) NULL,
	sexo varchar(9) NULL,
	cd_tipo_funcionario varchar(1) NULL,
	cd_tipo_contrato varchar(2) NULL,
	cd_endereco varchar(6) NULL,
	endereco varchar(100) NULL,
	nr_cep varchar(8) NULL,
	nr_telefone varchar(20) NULL,
	nm_cidade varchar(30) NULL,
	uf varchar(2) NULL,
	nr_cep_bairro varchar(8) NULL,
	nm_bairro varchar(40) NULL,
	ds_tipo_contrato varchar(32) NULL,
	cd_afastamento varchar(6) NULL,
	dt_afastamento_original timestamp NULL,
	faixa_etaria varchar(12) NULL,
	ds_situacao varchar(30) NULL,
	cargo_atual varchar(60) NULL,
	nm_filial_atual varchar(40) NULL,
	idade varchar(7) NULL,
	dt_demissao varchar(50) NULL,
	ds_causa_demissao varchar(30) NULL,
	ds_motivo_demissao varchar(40) NULL,
	ultima_atualizacao timestamp NULL,
	dt_nova_admissao timestamp NULL,
	fl_transferencia text NULL,
	nm_filial_anterior text NULL
);


-- rh.dgrau_instrucao definição

-- Drop table

-- DROP TABLE rh.dgrau_instrucao;

CREATE TABLE rh.dgrau_instrucao (
	pk_grau_instrucao int2 NULL,
	desc_grau varchar(50) NULL,
	cd_insrai int2 NULL,
	cd_ds_grau varchar(90) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dlocal_organograma definição

-- Drop table

-- DROP TABLE rh.dlocal_organograma;

CREATE TABLE rh.dlocal_organograma (
	pk_local_organograma varchar(100) NULL,
	cd_taborg int4 NULL,
	cd_num_loc int8 NULL,
	cd_rat int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dlocalizacao definição

-- Drop table

-- DROP TABLE rh.dlocalizacao;

CREATE TABLE rh.dlocalizacao (
	pk_localizacao int4 NULL,
	cd_nom_loc varchar(60) NULL,
	cd_num_loc int4 NULL,
	cd_rat int4 NULL,
	cd_ds_loc varchar(101) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dmotivo definição

-- Drop table

-- DROP TABLE rh.dmotivo;

CREATE TABLE rh.dmotivo (
	pk_motivo int4 NULL,
	desc_motivo varchar(50) NULL,
	cd_ds_motivo varchar(70) NULL,
	cd_tip_motivo varchar(3) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dmotivo_reajuste definição

-- Drop table

-- DROP TABLE rh.dmotivo_reajuste;

CREATE TABLE rh.dmotivo_reajuste (
	pk_motivo_alteracao varchar(5) NULL,
	ds_motivo_alteracao varchar(30) NULL,
	tipo_motivo varchar(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.dsituacao definição

-- Drop table

-- DROP TABLE rh.dsituacao;

CREATE TABLE rh.dsituacao (
	pk_situacao int4 NULL,
	cd_ds_situacao varchar(80) NULL,
	desc_sit varchar(40) NULL,
	desc_abr varchar(6) NULL,
	cd_sit_cmp int4 NULL,
	cd_tip_sit int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dstg_evento definição

-- Drop table

-- DROP TABLE rh.dstg_evento;

CREATE TABLE rh.dstg_evento (
	pk_evento text NULL,
	cd_evento numeric(4) NULL,
	cd_tipo_evento numeric(1) NULL,
	ds_evento text NULL,
	ds_evento_codigo text NULL,
	ultima_atualizacao timestamp NULL,
	fg_normal text NULL,
	fg_absenteismo text NULL,
	fg_extra text NULL,
	fg_rescisao text NULL,
	fg_normalabsenteismo text NULL
);


-- rh.dstg_evento_stage definição

-- Drop table

-- DROP TABLE rh.dstg_evento_stage;

CREATE TABLE rh.dstg_evento_stage (
	pk_evento text NULL,
	cd_evento numeric(4) NULL,
	cd_tipo_evento numeric(1) NULL,
	ds_evento text NULL,
	ds_evento_codigo text NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.dusuario_antigo definição

-- Drop table

-- DROP TABLE rh.dusuario_antigo;

CREATE TABLE rh.dusuario_antigo (
	pk_usuario_antigo int8 NULL,
	cd_nom_usu varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.dusuario_colaborador definição

-- Drop table

-- DROP TABLE rh.dusuario_colaborador;

CREATE TABLE rh.dusuario_colaborador (
	cd_num_emp int4 NULL,
	cd_tip_col int2 NULL,
	cd_num_col int8 NULL,
	cd_cri_usu int2 NULL,
	cd_usu_ema_env varchar(4) NULL,
	desc_nm_com varchar(150) NULL,
	desc_usu varchar(150) NULL,
	dt_log timestamp NULL,
	dt_hr_log int4 NULL,
	dthora_ultima_atualizacao timestamp NULL,
	pk_usuario_colaborador int8 NULL
);


-- rh.fabsenteismo definição

-- Drop table

-- DROP TABLE rh.fabsenteismo;

CREATE TABLE rh.fabsenteismo (
	fk_empresa int4 NULL,
	fk_filial varchar(100) NULL,
	fk_situacao int4 NULL,
	fk_cargo varchar(24) NULL,
	fk_local_organograma varchar(100) NULL,
	fk_localizacao int8 NULL,
	fk_colaborador varchar(130) NULL,
	cd_tip_col int2 NULL,
	cd_num_cad int8 NULL,
	cd_nom_fun varchar(60) NULL,
	cd_num_emp int4 NULL,
	cd_fil int4 NULL,
	cd_num_cgc int8 NULL,
	cd_loc varchar(180) NULL,
	cd_nom_loc varchar(70) NULL,
	cd_car varchar(24) NULL,
	cd_tit_car varchar(60) NULL,
	cd_esc int4 NULL,
	cd_nom_esc varchar(30) NULL,
	cd_sit_afa varchar(9) NULL,
	dt_ref timestamp NULL,
	cd_sit_lan int2 NULL,
	cd_sit_nom varchar(30) NULL,
	vlr_tot_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.facesso_sistema definição

-- Drop table

-- DROP TABLE rh.facesso_sistema;

CREATE TABLE rh.facesso_sistema (
	cd_empresa int4 NULL,
	cd_num_cadastro int8 NULL,
	cd_num_cpf int8 NULL,
	dt_acesso_auxi timestamp NULL,
	qtd_minuto_acesso int4 NULL,
	dthora_atualizacao timestamp NULL,
	fk_usu int8 NULL,
	fk_colaborador varchar(50) NULL,
	codfil int4 NULL
);


-- rh.fafastamento definição

-- Drop table

-- DROP TABLE rh.fafastamento;

CREATE TABLE rh.fafastamento (
	fk_funcionario varchar(50) NULL,
	fk_data_afastamento timestamp NULL,
	fk_situacao_afastamento varchar(6) NULL,
	dt_ini_afastamento timestamp NULL,
	dt_fim_afastamento timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.fafastamentos definição

-- Drop table

-- DROP TABLE rh.fafastamentos;

CREATE TABLE rh.fafastamentos (
	fk_colaborador varchar(100) NULL,
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	dt_afa timestamp NULL,
	vlr_hor_afa int4 NULL,
	dt_ter timestamp NULL,
	vlr_hor_ter int4 NULL,
	dt_prv_ter timestamp NULL,
	cd_dia_jus int2 NULL,
	desc_afa varchar(260) NULL,
	cd_sta_atu int2 NULL,
	cd_dia_prv int4 NULL,
	fk_cau_dem int2 NULL,
	dthora_atualizacao timestamp NULL,
	motivo_afastamento varchar(30) NULL,
	oriafa int2 NULL
);
CREATE INDEX idx_fafastamentos_colaborador ON rh.fafastamentos USING btree (fk_colaborador);
CREATE INDEX idx_fafastamentos_dt_afa ON rh.fafastamentos USING btree (dt_afa);


-- rh.fafastamentos_employer definição

-- Drop table

-- DROP TABLE rh.fafastamentos_employer;

CREATE TABLE rh.fafastamentos_employer (
	id serial4 NOT NULL,
	id_empregado int4 NOT NULL,
	sigla_tipo_afastamento varchar(10) NOT NULL,
	tipo_afastamento varchar(100) NOT NULL,
	data_inicio date NOT NULL,
	data_fim date NULL,
	observacao text NULL,
	data_cadastro timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	data_previsao_retorno date NULL,
	codigo_cid varchar(10) NULL,
	ultima_atualizacao date NULL,
	CONSTRAINT fafastamentos_employer_pkey PRIMARY KEY (id)
);


-- rh.fapuracao definição

-- Drop table

-- DROP TABLE rh.fapuracao;

CREATE TABLE rh.fapuracao (
	pk_apuracao varchar(150) NULL,
	fk_colaborador varchar(140) NULL,
	fk_empresa int4 NULL,
	dt_apuracao timestamp NULL,
	dt_hr_apuracao int4 NULL,
	cd_desc int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fapuracao_col_situacao definição

-- Drop table

-- DROP TABLE rh.fapuracao_col_situacao;

CREATE TABLE rh.fapuracao_col_situacao (
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	fk_colaborador varchar(110) NULL,
	dt_apu timestamp NULL,
	qtd_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fatestado definição

-- Drop table

-- DROP TABLE rh.fatestado;

CREATE TABLE rh.fatestado (
	pk_funcionario varchar(25) NULL,
	pk_funcionario_filial varchar(30) NULL,
	empresa int2 NULL,
	cod_filial int4 NULL,
	cadastro int4 NULL,
	data_afastamento timestamp NULL,
	situacao_afastamento int2 NULL,
	cid varchar(4) NULL,
	desc_cid varchar(300) NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.fbanco_horas definição

-- Drop table

-- DROP TABLE rh.fbanco_horas;

CREATE TABLE rh.fbanco_horas (
	fk_funcionario varchar(184) NULL,
	dt_lancamento timestamp NULL,
	cd_banco int4 NULL,
	fk_situacao int4 NULL,
	origem_lancamento varchar(1) NULL,
	qtd_hora varchar(10) NULL,
	qtd_paga varchar(10) NULL,
	saldo_horas varchar(10) NULL,
	ultima_atualizacao timestamp NULL,
	tip_colaborador int2 NULL
);


-- rh.fdemissao definição

-- Drop table

-- DROP TABLE rh.fdemissao;

CREATE TABLE rh.fdemissao (
	fk_funcionario varchar(80) NULL,
	fk_filial varchar(80) NULL,
	fk_empresa varchar(4) NULL,
	fk_cargo varchar(65) NULL,
	dt_funcionario timestamp NULL,
	dt_demissao timestamp NULL,
	dt_inicio_mes timestamp NULL,
	dt_fim_mes timestamp NULL,
	vl_demissao numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.fdepartamento_employer definição

-- Drop table

-- DROP TABLE rh.fdepartamento_employer;

CREATE TABLE rh.fdepartamento_employer (
	id int4 NULL,
	id_empregado varchar(30) NULL,
	id_departamento varchar(30) NULL,
	codigo_departamento varchar(30) NULL,
	departamento varchar(100) NULL,
	data_inicio_vigencia timestamp NULL,
	data_fim_vigencia timestamp NULL,
	data_atualizacao timestamp DEFAULT CURRENT_TIMESTAMP NULL
);


-- rh.fdre_lojas definição

-- Drop table

-- DROP TABLE rh.fdre_lojas;

CREATE TABLE rh.fdre_lojas (
	id int4 NULL,
	cnpj_loja varchar(18) NULL,
	apelido varchar(200) NULL,
	ano_dre int2 NULL,
	mes_dre int2 NULL,
	tipo_dre int2 NULL,
	propriedade varchar(150) NULL,
	val_real_ano_ant numeric(18, 3) NULL,
	perc_real_ano_ant numeric(18, 3) NULL,
	val_orcado numeric(18, 3) NULL,
	perc_orcado numeric(18, 3) NULL,
	val_real numeric(18, 3) NULL,
	perc_real numeric(18, 3) NULL,
	val_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_real_vig_ant numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	seq_consulta varchar(20) NULL
);


-- rh.fesocial definição

-- Drop table

-- DROP TABLE rh.fesocial;

CREATE TABLE rh.fesocial (
	fk_empresa int4 NULL,
	cd_id_eint int4 NULL,
	dt_cmphor timestamp NULL,
	vlr_dur_jor int4 NULL,
	cd_hor int4 NULL,
	cd_ini_not int4 NULL,
	cd_fim_not int4 NULL,
	cd_hor_not varchar(3) NULL,
	cd_sc int4 NULL,
	cd_hor_eso varchar(50) NULL,
	cd_hor_ent int4 NULL,
	cd_hor_sai int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fesocial_intervalo definição

-- Drop table

-- DROP TABLE rh.fesocial_intervalo;

CREATE TABLE rh.fesocial_intervalo (
	fk_empresa int4 NULL,
	cd_id_eint int4 NULL,
	qtd_dur_int int4 NULL,
	vlr_ini_int int4 NULL,
	vlr_fim_int int4 NULL,
	cd_hor_eso varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fferias definição

-- Drop table

-- DROP TABLE rh.fferias;

CREATE TABLE rh.fferias (
	fk_funcionario varchar(50) NULL,
	fk_data_ferias timestamp NULL,
	dt_ini_periodo timestamp NULL,
	dt_fim_periodo timestamp NULL,
	dt_ini_ferias timestamp NULL,
	qt_dias_direito numeric(7, 2) NULL,
	qt_dias_tirado numeric(18, 3) NULL,
	qt_dias_saldo numeric(18, 3) NULL,
	qt_dias_ferias numeric(18, 3) NULL,
	dt_fim_ferias timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.fficha_empregados definição

-- Drop table

-- DROP TABLE rh.fficha_empregados;

CREATE TABLE rh.fficha_empregados (
	id int4 NULL,
	nome varchar(255) NULL,
	cpf varchar(14) NULL,
	matricula varchar(50) NULL,
	data_admissao date NULL,
	prazo_duracao_contrato int4 NULL,
	prazo_prorrogacao_contrato int4 NULL,
	empregado_inativo bool NULL,
	cnpj varchar(20) NULL,
	empresa_cliente varchar(200) NULL,
	id_empresa_cliente int4 NULL,
	cnpj_empresa_cliente varchar(18) NULL,
	departamento varchar(50) NULL,
	id_departamento varchar(10) NULL,
	grade_horaria varchar(50) NULL,
	funcao varchar(50) NULL,
	id_funcao varchar(100) NULL,
	motivo_funcao varchar(400) NULL,
	turno varchar(100) NULL,
	data_rescisao date NULL,
	motivo_rescisao varchar(255) NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL
);


-- rh.fficha_financeira definição

-- Drop table

-- DROP TABLE rh.fficha_financeira;

CREATE TABLE rh.fficha_financeira (
	fk_empresa int4 NULL,
	fk_colaborador varchar(122) NULL,
	cd_tab_eve int4 NULL,
	cd_eve int4 NULL,
	vlr_ref_eve numeric(13, 2) NULL,
	vlr_val_eve numeric(13, 2) NULL,
	cd_ori_eve varchar(1) NULL,
	cd_rub int4 NULL,
	vlr_fat_rub numeric(8, 2) NULL,
	fk_evento varchar(100) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fhistorico definição

-- Drop table

-- DROP TABLE rh.fhistorico;

CREATE TABLE rh.fhistorico (
	fk_funcionario varchar(130) NULL,
	cd_funcionario varchar(25) NULL,
	fk_cargo varchar(65) NULL,
	fk_filial varchar(81) NULL,
	fk_local varchar(10) NULL,
	dt_ini_alteracao timestamp NULL,
	dt_fim_alteracao timestamp NULL,
	fg_admissao varchar(2) NULL,
	fg_demissao varchar(2) NULL,
	dt_demissao timestamp NULL,
	dt_admissao timestamp NULL,
	dt_historico timestamp NULL,
	fg_ativo varchar(10) NULL,
	fk_empresa varchar(8) NULL,
	vlr_sal numeric(18, 3) NULL,
	fg_afastamento varchar(1) NULL,
	fg_ferias varchar(1) NULL,
	dt_ini_afastamento timestamp NULL,
	dt_fim_afastamento timestamp NULL,
	dt_ini_ferias timestamp NULL,
	dt_fim_ferias timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.fholerite definição

-- Drop table

-- DROP TABLE rh.fholerite;

CREATE TABLE rh.fholerite (
	fk_colaborador varchar(130) NULL,
	fk_codigo_calculo varchar(90) NULL,
	fk_empresa int4 NULL,
	fk_cargo varchar(70) NULL,
	cd_fil_mat int4 NULL,
	desc_razsoc varchar(120) NULL,
	cd_nome_com varchar(100) NULL,
	dt_nas timestamp NULL,
	cd_tit_car varchar(80) NULL,
	dt_per_ref timestamp NULL,
	dt_pag timestamp NULL,
	vlr_sal_bas numeric(19, 4) NULL,
	vlr_val_liq numeric(19, 4) NULL,
	vlr_bas_ins numeric(14, 2) NULL,
	vlr_bas_irf numeric(14, 2) NULL,
	vlr_bas_fgt numeric(14, 2) NULL,
	vlr_fgt_mes numeric(14, 2) NULL,
	cd_fai int4 NULL,
	cd_dep_irf int2 NULL,
	cd_dep_saf int2 NULL,
	cd_mod_pag varchar(3) NULL,
	desc_dmd_pag varchar(70) NULL,
	vlr_tot_ven numeric(15, 2) NULL,
	vlr_tot_des numeric(15, 2) NULL,
	cd_tip_cal int2 NULL,
	desc_dtp_cal varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fhoras_trabalhadas definição

-- Drop table

-- DROP TABLE rh.fhoras_trabalhadas;

CREATE TABLE rh.fhoras_trabalhadas (
	dat_batida timestamp NULL,
	dat_dia_batida numeric(38, 10) NULL,
	dat_mes_batida numeric(38, 10) NULL,
	dat_ano_batida numeric(38, 10) NULL,
	chave_usuario text NULL,
	empresa numeric(4) NULL,
	usuario numeric(9) NULL,
	tip_colaborador numeric(1) NULL,
	situacao_baixa text NULL,
	tot_horas_trb text NULL,
	ultima_atualizacao timestamp NULL
);


-- rh.flancamento_hora definição

-- Drop table

-- DROP TABLE rh.flancamento_hora;

CREATE TABLE rh.flancamento_hora (
	cd_num_emp int4 NULL,
	cd_tip_col int2 NULL,
	cd_num_col int8 NULL,
	dt_lanca timestamp NULL,
	cd_ori_lanca varchar(4) NULL,
	cd_sin_lan varchar(4) NULL,
	qtd_hor int8 NULL,
	qtd_pag int8 NULL,
	qtd_hor_cmp int8 NULL,
	dt_cmp timestamp NULL,
	dt_compe_lanc timestamp NULL,
	dthora_atualizacao timestamp NULL,
	fk_banco_horas int4 NULL,
	fk_situacao int4 NULL,
	fk_colaborador varchar(150) NULL
);


-- rh.flog_alteracoes_ponto definição

-- Drop table

-- DROP TABLE rh.flog_alteracoes_ponto;

CREATE TABLE rh.flog_alteracoes_ponto (
	dt_apuracao timestamp NULL,
	cd_num_fun int8 NULL,
	cd_nom_fun varchar(50) NULL,
	cd_usu int8 NULL,
	cd_nom_usu varchar(255) NULL,
	cd_num_ajuste int8 NULL,
	cd_nom_ajuste varchar(50) NULL,
	descr_msg_log varchar(500) NULL,
	dthora_atualizacao timestamp NULL,
	fk_colaborador varchar(150) NULL,
	fk_usuario_antigo int8 NULL
);


-- rh.fmarcacao_horario definição

-- Drop table

-- DROP TABLE rh.fmarcacao_horario;

CREATE TABLE rh.fmarcacao_horario (
	cd_hor int4 NULL,
	seq_mar int2 NULL,
	cd_usobat int2 NULL,
	vlr_horbat int4 NULL,
	cd_faimov int4 NULL,
	dthora_atualizacao timestamp NULL,
	vlr_tolant int4 NULL,
	vlr_tolapo int4 NULL
);


-- rh.fmarcacoes definição

-- Drop table

-- DROP TABLE rh.fmarcacoes;

CREATE TABLE rh.fmarcacoes (
	id int4 NULL,
	id_empregado int4 NULL,
	id_empresa int4 NULL,
	data_marcacao date NULL,
	jornada varchar(100) NULL,
	ocorrencia varchar(255) NULL,
	horas_trabalhadas_diurnas varchar(20) NULL,
	horas_trabalhadas_diurna_decimal numeric(10, 2) NULL,
	bilhete_1 time NULL,
	bilhete_2 time NULL,
	bilhete_3 time NULL,
	bilhete_4 time NULL,
	bilhete_5 time NULL,
	bilhete_6 time NULL,
	afastamento_abonado bool NULL,
	afastamento_data_inicio date NULL,
	afastamento_data_fim date NULL,
	afastamento_hora_inicio time NULL,
	afastamento_hora_fim time NULL,
	afastamento_parcial bool NULL,
	afastamento_sem_calculo bool NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	horastrabalhadasnoturnas varchar(20) NULL,
	horastrabalhadasnoturnas_decimal numeric(10, 2) NULL
);


-- rh.fmarcacoes_formato_live definição

-- Drop table

-- DROP TABLE rh.fmarcacoes_formato_live;

CREATE TABLE rh.fmarcacoes_formato_live (
	id int4 NULL,
	id_empregado int4 NULL,
	id_empresa int4 NULL,
	data_marcacao timestamp NULL,
	horas_trabalhadas varchar(20) NULL,
	sequencia_marcacao int4 NULL,
	marcacao_esperada time(3) NULL,
	marcacao_ponto time(3) NULL,
	dif_marcacao_minutos int4 NULL,
	ultima_atualizacao timestamp NULL,
	jornada varchar(100) NULL
);


-- rh.fponto_detalhado definição

-- Drop table

-- DROP TABLE rh.fponto_detalhado;

CREATE TABLE rh.fponto_detalhado (
	tipo_batida varchar(16) NULL,
	seq_batida int2 NULL,
	chave_usuario varchar(154) NULL,
	cod_escala int4 NULL,
	empresa int2 NULL,
	usuario int4 NULL,
	reg_ponto int4 NULL,
	prev_batida varchar(20) NULL,
	tole_antes varchar(20) NULL,
	tole_apos varchar(20) NULL,
	dat_batida timestamp NULL,
	dat_trabalho timestamp NULL,
	hor_batida varchar(4000) NULL,
	dat_dia_batida int2 NULL,
	dat_mes_batida int2 NULL,
	dat_ano_batida int2 NULL,
	dat_dia_trabalho int2 NULL,
	dat_mes_trabalho int2 NULL,
	dat_ano_trabalho int2 NULL,
	dife int4 NULL,
	ultima_atualizacao timestamp NULL,
	turno int2 NULL,
	dat_ajustada timestamp NULL,
	numnsr int4 NULL
);


-- rh.fponto_sintetico definição

-- Drop table

-- DROP TABLE rh.fponto_sintetico;

CREATE TABLE rh.fponto_sintetico (
	dat_batida timestamp NULL,
	dat_dia_batida float8 NULL,
	dat_mes_batida float8 NULL,
	dat_ano_batida float8 NULL,
	chave_usuario varchar(60) NULL,
	empresa int2 NULL,
	usuario int4 NULL,
	hor_batida_formatada varchar(400) NULL,
	hor_escala_formatada varchar(30) NULL,
	ultima_atualizacao timestamp NULL,
	tip_colaborador int2 NULL
);


-- rh.fprovento_lojas definição

-- Drop table

-- DROP TABLE rh.fprovento_lojas;

CREATE TABLE rh.fprovento_lojas (
	fk_funcionario text NULL,
	fk_cargo text NULL,
	tiposituacao numeric(2) NULL,
	descricaosituacao text NULL,
	centro_custo text NULL,
	cod_ccusto numeric(38, 10) NULL,
	cod_empresa numeric(4) NULL,
	num_cadastro numeric(9) NULL,
	ano numeric(38, 10) NULL,
	mes numeric(38, 10) NULL,
	tipo text NULL,
	val_evento numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL,
	data_demissao timestamp NULL,
	codeve numeric NULL
);


-- rh.freajuste definição

-- Drop table

-- DROP TABLE rh.freajuste;

CREATE TABLE rh.freajuste (
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


-- rh.fregistro_acesso definição

-- Drop table

-- DROP TABLE rh.fregistro_acesso;

CREATE TABLE rh.fregistro_acesso (
	fk_empresa int4 NULL,
	cd_num_cra int8 NULL,
	dt_cc timestamp NULL,
	dt_hr_cc int4 NULL,
	cd_seq_acc int2 NULL,
	cd_ori_acc varchar(1) NULL,
	cd_num_cad int4 NULL,
	dt_apu timestamp NULL,
	cd_num_nsr int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.fsaldo_banco_horas definição

-- Drop table

-- DROP TABLE rh.fsaldo_banco_horas;

CREATE TABLE rh.fsaldo_banco_horas (
	chave_usuario varchar(154) NULL,
	numemp int2 NULL,
	codfil int4 NULL,
	nomfil varchar(40) NULL,
	numcgc int8 NULL,
	codloc varchar(150) NULL,
	nomloc varchar(60) NULL,
	codcar varchar(24) NULL,
	titcar varchar(100) NULL,
	codesc int4 NULL,
	nomesc varchar(30) NULL,
	tipcol int2 NULL,
	numcad int4 NULL,
	nomfun varchar(40) NULL,
	sitafa varchar(7) NULL,
	datref timestamp NULL,
	sldatu int8 NULL,
	ultima_atualizacao timestamp NULL,
	sldneg numeric(15, 3) NULL,
	sldpos numeric(18, 3) NULL
);


-- rh.fsaldo_hora_extra definição

-- Drop table

-- DROP TABLE rh.fsaldo_hora_extra;

CREATE TABLE rh.fsaldo_hora_extra (
	chave_usuario varchar(75) NULL,
	numemp int2 NULL,
	codfil int4 NULL,
	nomfil varchar(40) NULL,
	numcgc int8 NULL,
	codloc varchar(150) NULL,
	nomloc varchar(60) NULL,
	codcar varchar(24) NULL,
	titcar varchar(100) NULL,
	codesc int4 NULL,
	nomesc varchar(30) NULL,
	tipcol int2 NULL,
	numcad int4 NULL,
	nomfun varchar(40) NULL,
	sitafa varchar(7) NULL,
	datref timestamp NULL,
	qtdext int8 NULL
);


-- rh.fstg_historico definição

-- Drop table

-- DROP TABLE rh.fstg_historico;

CREATE TABLE rh.fstg_historico (
	fk_funcionario text NULL,
	fk_cargo text NULL,
	cd_funcionario text NULL,
	fk_filial text NULL,
	fk_empresa text NULL,
	fk_local text NULL,
	dt_alt timestamp NULL,
	dt_adm timestamp NULL,
	vlr_sal numeric(38, 10) NULL,
	dthora_atualizacao timestamp NULL
);


-- rh.ftotalizador_horas definição

-- Drop table

-- DROP TABLE rh.ftotalizador_horas;

CREATE TABLE rh.ftotalizador_horas (
	cd_tip_col int2 NULL,
	cd_num_col int4 NULL,
	dt_compe_calc timestamp NULL,
	qtd_hor_pag int8 NULL,
	qtd_hor_des int8 NULL,
	qtd_saldo int8 NULL,
	dthora_atualizacao timestamp NULL,
	fk_banco_hora int4 NULL,
	fk_colaborador varchar(150) NULL,
	fk_empresa int4 NULL,
	vlr_hor_pag numeric(20, 4) NULL,
	vlr_hor_des numeric(20, 4) NULL,
	vlr_hor_saldo numeric(20, 4) NULL
);

-- DROP SCHEMA rh_sci;

CREATE SCHEMA rh_sci AUTHORIZATION postgres;

-- DROP SEQUENCE rh_sci.fproventos_depto_employer_id_seq;

CREATE SEQUENCE rh_sci.fproventos_depto_employer_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- rh_sci.dhistorico_salario definição

-- Drop table

-- DROP TABLE rh_sci.dhistorico_salario;

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


-- rh_sci.fcontratos_lecom definição

-- Drop table

-- DROP TABLE rh_sci.fcontratos_lecom;

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


-- rh_sci.ffolha_salarial definição

-- Drop table

-- DROP TABLE rh_sci.ffolha_salarial;

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


-- rh_sci.fprov_bruto_colab definição

-- Drop table

-- DROP TABLE rh_sci.fprov_bruto_colab;

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


-- rh_sci.fproventos_depto_employer definição

-- Drop table

-- DROP TABLE rh_sci.fproventos_depto_employer;

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


-- rh_sci.freajuste definição

-- Drop table

-- DROP TABLE rh_sci.freajuste;

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


-- rh_sci.fsalario_employer definição

-- Drop table

-- DROP TABLE rh_sci.fsalario_employer;

CREATE TABLE rh_sci.fsalario_employer (
	id int4 NULL,
	cod_contrato varchar(30) NULL,
	contrato varchar(50) NULL,
	id_departamento int4 NULL,
	departamento varchar(50) NULL,
	salario numeric NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL
);

-- DROP SCHEMA stage;

CREATE SCHEMA stage AUTHORIZATION postgres;
-- stage.dstg_evento_stage definição

-- Drop table

-- DROP TABLE stage.dstg_evento_stage;

CREATE TABLE stage.dstg_evento_stage (
	pk_evento text NULL,
	cd_evento numeric(4) NULL,
	cd_tipo_evento numeric(1) NULL,
	ds_evento text NULL,
	ds_evento_codigo text NULL,
	ultima_atualizacao timestamp NULL
);


-- stage.fmovimentosinteg_stage definição

-- Drop table

-- DROP TABLE stage.fmovimentosinteg_stage;

CREATE TABLE stage.fmovimentosinteg_stage (
	portal int8 NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(3) NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	fk_cliente varchar(40) NULL,
	cnpj varchar(40) NULL,
	valor_bruto int8 NULL,
	cor varchar(6) NULL,
	tamanho varchar(5) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	fk_produto varchar(25) NULL,
	descricao varchar(200) NULL,
	rede varchar(100) NULL,
	canal_distribuicao varchar(14) NULL,
	flag_movimentacao varchar(20) NULL,
	valor_liquido numeric(18, 3) NULL,
	qtde numeric(18, 3) NULL,
	cst_icms varchar(15) NULL,
	cst_ipi varchar(15) NULL,
	cst_cofins varchar(15) NULL,
	cst_pis varchar(15) NULL,
	data_lancamento timestamp NULL,
	datcancel timestamp NULL,
	cod_barra varchar(20) NULL,
	data_inicio_vigencia date NULL,
	data_fim_vigencia date NULL,
	cnpj_original varchar(40) NULL,
	cnpj_antigo varchar(18) NULL,
	de varchar(20) NULL,
	para varchar(20) NULL,
	loja_original varchar(30) NULL,
	situacao int2 NULL,
	identificador varchar(60) NULL,
	cnpj_emp varchar(20) NULL,
	loja varchar(5) NULL
);
CREATE INDEX idx_live_mov_cancelado ON stage.fmovimentosinteg_stage USING btree (cancelado);
CREATE INDEX idx_live_mov_oper_tp_trans ON stage.fmovimentosinteg_stage USING btree (operacao, tipo_transacao, considerarvenda);


-- stage.fordens_corte_hist_stage definição

-- Drop table

-- DROP TABLE stage.fordens_corte_hist_stage;

CREATE TABLE stage.fordens_corte_hist_stage (
	id varchar(25) NULL
);


-- stage.fordens_corte_stage definição

-- Drop table

-- DROP TABLE stage.fordens_corte_stage;

CREATE TABLE stage.fordens_corte_stage (
	cd_ordem_producao int4 NULL,
	cd_grupo varchar(5) NULL,
	prod_rej_item varchar(6) NULL,
	periodo_producao int2 NULL,
	cd_ordem_confeccao int4 NULL,
	situacao_ordem int2 NULL,
	numero_ordem_externa int4 NULL,
	data_alteracao timestamp NULL,
	tamanho varchar(3) NULL,
	data_producao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	dt_lancamento timestamp NULL,
	dt_prevista timestamp NULL,
	prioridade int4 NULL,
	data_programacao timestamp NULL,
	periodo_producao_capa int2 NULL,
	numero_programa int2 NULL,
	cod_cancelamento int2 NULL,
	cd_nivel99 float8 NULL,
	cd_subgrupo varchar(5) NULL,
	cd_estagio int4 NULL,
	qtd_pecas_progamada numeric(18, 3) NULL,
	qtd_pecas_produzida numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_pecas_2a numeric(18, 3) NULL,
	estagio_anterior int4 NULL,
	seq_ordem_serv int2 NULL,
	qtd_perdas numeric(18, 3) NULL,
	sequencia_estagio int2 NULL,
	usuario varchar(250) NULL,
	seq_operacao int2 NULL,
	qtd_em_producao_pacote numeric(18, 3) NULL,
	minutos_unitario numeric(18, 3) NULL,
	minutos_total numeric(18, 3) NULL,
	minutos_total_em_producao numeric(18, 3) NULL,
	sequencia_tamanho int4 NULL,
	qtd_marcacoes numeric(18, 3) NULL,
	qtd_a_produzir numeric(18, 3) NULL,
	rowid varchar(100) NULL,
	fk_produto varchar(125) NULL,
	fk_fornecedor varchar(150) NULL,
	alternativa_peca int4 NULL,
	deposito_entrada int4 NULL
);


-- stage.fstg_corte_40 definição

-- Drop table

-- DROP TABLE stage.fstg_corte_40;

CREATE TABLE stage.fstg_corte_40 (
	cd_ordem_producao int8 NULL,
	cd_nivel99 varchar(1) NULL,
	cd_grupo varchar(5) NULL,
	cd_subgrupo varchar(3) NULL,
	prod_rej_item varchar(6) NULL,
	cd_estagio int2 NULL,
	periodo_producao int4 NULL,
	cd_ordem_confeccao int4 NULL,
	qtd_pecas_progamada numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_pecas_2a numeric(18, 3) NULL,
	estagio_anterior int2 NULL,
	situacao_ordem int2 NULL,
	numero_ordem_externa int4 NULL,
	seq_ordem_serv int4 NULL,
	qtd_perdas numeric(18, 3) NULL,
	sequencia_estagio int4 NULL,
	usuario varchar(250) NULL,
	seq_operacao int2 NULL,
	data_alteracao timestamp NULL,
	qtd_em_producao_pacote numeric(18, 3) NULL,
	fk_produto varchar(18) NULL,
	dthora_atualizacao timestamp NULL,
	cd_barra varchar(18) NULL
);


-- stage.ftabelaprecogrupoest definição

-- Drop table

-- DROP TABLE stage.ftabelaprecogrupoest;

CREATE TABLE stage.ftabelaprecogrupoest (
	tabela_preco text NULL,
	tabela_preco_cod text NULL,
	grupo_estrutura text NULL,
	item_estrutura text NULL,
	subgru_estrutura text NULL,
	nivel_estrutura text NULL,
	val_tabela_preco numeric(19, 6) NULL
);


-- stage.ftabelaprecostage definição

-- Drop table

-- DROP TABLE stage.ftabelaprecostage;

CREATE TABLE stage.ftabelaprecostage (
	tabela_preco varchar(9) NULL,
	tabela_preco_cod varchar(11) NULL,
	fk_produto varchar(18) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	vlr_com_desconto numeric(18, 3) NULL,
	grupo_estrutura varchar(5) NULL,
	dthora_atualizacao timestamp NULL
);


-- stage.lojas_vigencia_stage definição

-- Drop table

-- DROP TABLE stage.lojas_vigencia_stage;

CREATE TABLE stage.lojas_vigencia_stage (
	id int4 NULL,
	data_fim_vigencia timestamp NULL,
	portal_antigo varchar(35) NULL,
	portal_novo varchar(35) NULL,
	ordem_troca varchar(35) NULL,
	id_portal_fixo varchar(35) NULL,
	data_criacao timestamp NULL,
	usuario_criacao varchar(35) NULL,
	ultima_atualizacao timestamp NULL,
	cnpj_antigo_completo varchar(15) NULL,
	cnpj_atual_completo varchar(15) NULL,
	cnpj_antigo varchar(14) NULL,
	cnpj_atual varchar(14) NULL,
	data_inicio_vigencia timestamp NULL
);


-- stage.pedi100 definição

-- Drop table

-- DROP TABLE stage.pedi100;

CREATE TABLE stage.pedi100 (
	pedido_venda numeric(9) NULL,
	data_entr_venda timestamp NULL,
	situacao_venda numeric(2) NULL,
	cod_cancelamento numeric(3) NULL,
	sit_aloc_pedi numeric(1) NULL,
	sit_coletor numeric(1) NULL,
	situacao_coleta numeric(1) NULL,
	status_expedicao numeric(1) NULL,
	status_homologacao numeric(1) NULL,
	status_pedido numeric(1) NULL,
	status_comercial numeric(1) NULL,
	sit_conferencia numeric(1) NULL,
	qtde_saldo_pedi numeric(15, 3) NULL,
	valor_saldo_pedi numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL,
	qtde_total_pedi numeric(15, 3) NULL,
	live_data_entr_venda_original timestamp NULL
);


-- stage.pedi135 definição

-- Drop table

-- DROP TABLE stage.pedi135;

CREATE TABLE stage.pedi135 (
	pedido_venda numeric(9) NULL,
	seq_situacao numeric(2) NULL,
	codigo_situacao numeric(2) NULL,
	flag_liberacao varchar(5) NULL,
	data_situacao timestamp NULL,
	data_liberacao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- stage.stage_movimentacoes_integ definição

-- Drop table

-- DROP TABLE stage.stage_movimentacoes_integ;

CREATE TABLE stage.stage_movimentacoes_integ (
	portal_movimentacao int8 NULL,
	identificador varchar(60) NULL,
	cnpj_movimentacao varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	qtde numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	fk_produto varchar(168) NULL,
	data_lancamento timestamp NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	cst_icms varchar(10) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	cst_ipi varchar(10) NULL,
	valor_ipi numeric(20, 5) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	cst_cofins varchar(10) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	cst_pis varchar(10) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(1) NULL,
	datcancel timestamp NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	valor_bruto numeric(18, 3) NULL,
	cor varchar(20) NULL,
	tamanho varchar(32) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	cod_barra varchar(20) NULL,
	loja_movimentacao varchar(30) NULL
);


-- stage.stg_cnpj_ativos_integ definição

-- Drop table

-- DROP TABLE stage.stg_cnpj_ativos_integ;

CREATE TABLE stage.stg_cnpj_ativos_integ (
	cnpj_antigo varchar(20) NULL,
	cnpj_atual varchar(20) NULL,
	data_inicio_vigencia date NULL,
	data_fim_vigencia date NULL,
	portal_antigo varchar(20) NULL,
	portal_atual varchar(20) NULL
);


-- stage.stg_evidencias definição

-- Drop table

-- DROP TABLE stage.stg_evidencias;

CREATE TABLE stage.stg_evidencias (
	answer_id varchar(100) NULL,
	answer_evidence_type_id varchar(100) NULL,
	answer_url text NULL,
	answer_evidence_type_id_ref varchar(100) NULL,
	answer_evidence_type_name_ref varchar(100) NULL
);


-- stage.stg_infos_lojas_integ definição

-- Drop table

-- DROP TABLE stage.stg_infos_lojas_integ;

CREATE TABLE stage.stg_infos_lojas_integ (
	id_loja int4 NULL,
	descricao varchar(200) NULL,
	apelido varchar(200) NULL,
	razao_social varchar(200) NULL,
	situacao int2 NULL,
	endereco varchar(200) NULL,
	cep int4 NULL,
	id_portal int4 NULL,
	data_inauguracao timestamp NULL,
	cnpj varchar(100) NULL,
	portal varchar(72) NULL,
	rede varchar(100) NULL
);


-- stage.stg_movimentos_integ definição

-- Drop table

-- DROP TABLE stage.stg_movimentos_integ;

CREATE TABLE stage.stg_movimentos_integ (
	portal int8 NULL,
	identificador varchar(60) NULL,
	cnpj_emp varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	fk_produto varchar(168) NULL,
	data_lancamento timestamp NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	cst_icms varchar(10) NULL,
	aliquota_icms numeric(20, 5) NULL,
	base_icms numeric(20, 5) NULL,
	cst_ipi varchar(10) NULL,
	valor_ipi numeric(20, 5) NULL,
	aliquota_ipi numeric(20, 5) NULL,
	base_ipi numeric(20, 5) NULL,
	cst_cofins varchar(10) NULL,
	valor_cofins numeric(20, 5) NULL,
	aliquota_cofins numeric(20, 5) NULL,
	base_cofins numeric(20, 5) NULL,
	cst_pis varchar(10) NULL,
	valor_pis numeric(20, 5) NULL,
	aliquota_pis numeric(20, 5) NULL,
	base_pis numeric(20, 5) NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(1) NULL,
	datcancel timestamp NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	valor_bruto float8 NULL,
	cor varchar(20) NULL,
	tamanho varchar(32) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	cod_barra varchar(20) NULL,
	loja_movimentacao varchar(10) NULL,
	qtde numeric(20, 5) NULL,
	valor_liquido numeric(20, 5) NULL,
	desconto numeric(20, 5) NULL,
	preco_custo numeric(20, 5) NULL,
	valor_icms numeric(20, 5) NULL
);


-- stage.stg_movimentos_integ_full definição

-- Drop table

-- DROP TABLE stage.stg_movimentos_integ_full;

CREATE TABLE stage.stg_movimentos_integ_full (
	portal numeric(10) NULL,
	identificador text NULL,
	cnpj_emp text NULL,
	numorcamento numeric(10) NULL,
	usuario numeric(10) NULL,
	numnf numeric(10) NULL,
	serie text NULL,
	chave_nf text NULL,
	qtde numeric(15, 5) NULL,
	valor_liquido numeric(15, 5) NULL,
	desconto numeric(15, 5) NULL,
	preco_custo numeric(15, 5) NULL,
	fk_produto text NULL,
	data_lancamento timestamp NULL,
	hora_lancamento text NULL,
	codigo_cliente numeric(10) NULL,
	doc_cliente text NULL,
	id_cfop text NULL,
	cod_vendedor numeric(10) NULL,
	cst_icms text NULL,
	valor_icms numeric(15, 5) NULL,
	aliquota_icms numeric(15, 5) NULL,
	base_icms numeric(15, 5) NULL,
	cst_ipi text NULL,
	valor_ipi numeric(15, 5) NULL,
	aliquota_ipi numeric(15, 5) NULL,
	base_ipi numeric(15, 5) NULL,
	cst_cofins text NULL,
	valor_cofins numeric(15, 5) NULL,
	aliquota_cofins numeric(15, 5) NULL,
	base_cofins numeric(15, 5) NULL,
	cst_pis text NULL,
	valor_pis numeric(15, 5) NULL,
	aliquota_pis numeric(15, 5) NULL,
	base_pis numeric(15, 5) NULL,
	operacao text NULL,
	tipo_transacao text NULL,
	cancelado text NULL,
	datcancel timestamp NULL,
	seqitem numeric(6) NULL,
	ultima_atualizacao timestamp NULL,
	valor_bruto numeric(38, 10) NULL,
	cor text NULL,
	tamanho text NULL,
	considerarvenda text NULL,
	desc_movimento text NULL,
	cod_barra text NULL,
	loja_movimentacao text NULL
);


-- stage.stg_paradasmaquinas_marft_oper definição

-- Drop table

-- DROP TABLE stage.stg_paradasmaquinas_marft_oper;

CREATE TABLE stage.stg_paradasmaquinas_marft_oper (
	cod_operador numeric(5) NULL,
	nome_operador text NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	motivo text NULL,
	detalhes text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- stage.stg_paradasmaquinas_marft_pmo definição

-- Drop table

-- DROP TABLE stage.stg_paradasmaquinas_marft_pmo;

CREATE TABLE stage.stg_paradasmaquinas_marft_pmo (
	cod_operador numeric(5) NULL,
	nome_operador text NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	motivo text NULL,
	detalhes text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- stage.stg_planos definição

-- Drop table

-- DROP TABLE stage.stg_planos;

CREATE TABLE stage.stg_planos (
	id varchar(100) NULL,
	task_code varchar(100) NULL,
	creator_user_id varchar(100) NULL,
	created_at varchar(100) NULL,
	updated_at varchar(100) NULL,
	checklist_execution_id varchar(100) NULL,
	question_id varchar(100) NULL,
	action_plan_state_id varchar(100) NULL,
	action_plan_state_name varchar(100) NULL,
	user_id varchar(100) NULL,
	user_name varchar(100) NULL,
	user_role varchar(100) NULL,
	answer_id varchar(100) NULL,
	answer_respondent_user_id varchar(100) NULL,
	answer_approver_user_id varchar(100) NULL,
	answer_answer varchar(1000) NULL
);


-- stage.stg_sugestao_reserva_tecido_oc definição

-- Drop table

-- DROP TABLE stage.stg_sugestao_reserva_tecido_oc;

CREATE TABLE stage.stg_sugestao_reserva_tecido_oc (
	cd_ordem_producao varchar(25) NULL,
	periodo_producao varchar(25) NULL,
	cd_estagio varchar(25) NULL,
	referencia varchar(5) NULL,
	cod_cor varchar(6) NULL,
	fk_produto varchar(40) NULL,
	fk_componente varchar(40) NULL,
	unidade_medida varchar(2) NULL,
	qtd_a_produzir numeric(17, 2) NULL,
	qtd_em_producao_pacote numeric(17, 2) NULL,
	qtd_pecas_progamada numeric(17, 2) NULL,
	consumo_programado numeric(17, 2) NULL
);

-- DROP SCHEMA suprimentos;

CREATE SCHEMA suprimentos AUTHORIZATION "Gustavo_Puc";
-- suprimentos.dfornecedor_produto definição

-- Drop table

-- DROP TABLE suprimentos.dfornecedor_produto;

CREATE TABLE suprimentos.dfornecedor_produto (
	"código produto" text NULL,
	descrição text NULL,
	"cnpj fornecedor" text NULL,
	nome_fornecedor text NULL,
	codigo_fornecedor text NULL,
	tempo_reposicao numeric(5) NULL,
	lote_multiplo numeric(12, 3) NULL,
	codigo_moeda numeric(2) NULL,
	unid_conv text NULL,
	fator_conv numeric(14, 6) NULL,
	qtde_por_embalagem numeric(13, 3) NULL,
	operador_calc text NULL,
	desc_referencia varchar(85) NULL
);


-- suprimentos.dlancamentos_produto definição

-- Drop table

-- DROP TABLE suprimentos.dlancamentos_produto;

CREATE TABLE suprimentos.dlancamentos_produto (
	produto text NULL,
	num_contabil numeric(9) NULL,
	documento numeric(9) NULL,
	centro_de_custo text NULL,
	ultima_atualizacao timestamp NULL
);


-- suprimentos.dlancamentos_servico definição

-- Drop table

-- DROP TABLE suprimentos.dlancamentos_servico;

CREATE TABLE suprimentos.dlancamentos_servico (
	produto text NULL,
	num_contabil numeric(9) NULL,
	nr_duplicata numeric(9) NULL,
	centro_de_custo text NULL,
	ultima_atualizacao timestamp NULL
);


-- suprimentos.dobc_empresas definição

-- Drop table

-- DROP TABLE suprimentos.dobc_empresas;

CREATE TABLE suprimentos.dobc_empresas (
	id_filial text NULL,
	filial_razao_social text NULL,
	filial_nome_fantasia text NULL,
	filial_status text NULL,
	filial_empresa text NULL,
	id_empresa text NULL,
	filial_status_nome text NULL
);


-- suprimentos.dobc_sdcv_detalhes definição

-- Drop table

-- DROP TABLE suprimentos.dobc_sdcv_detalhes;

CREATE TABLE suprimentos.dobc_sdcv_detalhes (
	sdcv_codigo numeric(15) NULL,
	sdcv_requisicao_erp text NULL,
	sdcv_prioridade text NULL,
	sdcv_motivo_urgencia text NULL,
	sdc_descricao_adicional text NULL,
	sdc_motivo_outro text NULL,
	sdc_descricao text NULL,
	comentario_uso_interno text NULL,
	sdcv_tipo text NULL,
	sdcv_tipo_registro text NULL,
	sdcv_tipo_compra text NULL,
	contrato_numero int4 NULL,
	sdcv_solicitante text NULL,
	sdcv_comprador text NULL,
	sdcv_c_custo_codigo text NULL,
	sdcv_c_custo_nome text NULL,
	sdcv_c_contabil_codigo text NULL,
	sdcv_c_contabil_nome text NULL,
	sdcv_empresa text NULL,
	sdcv_filial_nome text NULL,
	sdcv_filial_razao_social text NULL,
	sdcv_local_entrega_nome text NULL,
	sdcv_grupo_descricao text NULL,
	sdcv_quantidade numeric(38, 18) NULL,
	sdcv_unidade text NULL,
	sdcv_de_projeto text NULL,
	projeto_codigo int8 NULL,
	projeto_nome text NULL,
	projeto_fase_codigo int4 NULL,
	projeto_fase text NULL,
	categoria_nivel_1 text NULL,
	categoria_nivel_2 text NULL,
	categoria_nivel_3 text NULL,
	caracteristica_item text NULL,
	item_codigo int4 NULL,
	item_codigo_erp text NULL,
	item_nome text NULL,
	proposta_de_contrato text NULL,
	proposta_frete text NULL,
	proposta_valor_frete numeric(38, 18) NULL,
	proposta_vlr_unit numeric(38, 18) NULL,
	proposta_vlr_total numeric(38, 18) NULL,
	proposta_vlr_unit_inicial numeric(38, 18) NULL,
	proposta_vlr_total_inicial numeric(38, 18) NULL,
	proposta_custo_unit numeric(38, 18) NULL,
	proposta_custo_total numeric(38, 18) NULL,
	saving_vlr_valor_saving numeric(38, 18) NULL,
	saving_vlr_valor_base_saving numeric(38, 18) NULL,
	saving_vlr_percentual_saving numeric(38, 18) NULL,
	saving_cus_valor_saving numeric(38, 18) NULL,
	saving_cus_valor_base_saving numeric(38, 18) NULL,
	saving_cus_percentual_saving numeric(38, 18) NULL,
	proposta_saving_vlr numeric(38, 18) NULL,
	proposta_valor_base_para_saving numeric(38, 18) NULL,
	proposta_saving_percentual numeric(38, 18) NULL,
	proposta_saving_base_calculo text NULL,
	proposta_saving_tipo text NULL,
	proposta_vlr_considerado_analise_cotacao numeric(38, 18) NULL,
	proposta_cond_pagamento text NULL,
	proposta_prazo_medio_pagamento numeric(10, 2) NULL,
	proposta_moeda text NULL,
	proposta_renegociada text NULL,
	proposta_preenchida_por text NULL,
	proposta_justificativa_escolha text NULL,
	fornecedor_razao_social text NULL,
	fornecedor_fantasia text NULL,
	fornecedor_cnpj text NULL,
	fornecedor_cidade text NULL,
	fornecedor_estado text NULL,
	fornecedor_faturado text NULL,
	cnpj_faturado text NULL,
	compra_numero int4 NULL,
	pedido_numero text NULL,
	pedido_qtd_pedida numeric(38, 18) NULL,
	pedido_qtd_recebida numeric(38, 18) NULL,
	pedido_qtd_saldo numeric(38, 18) NULL,
	pedido_situacao_entrega text NULL,
	pedido_status_entrega text NULL,
	nf_numero text NULL,
	nf_serie text NULL,
	nf_data_emissao text NULL,
	nf_quantidade_entrega text NULL,
	data_compra_dia text NULL,
	data_compra_mes text NULL,
	data_compra_ano text NULL,
	data_criacao_sdcv text NULL,
	data_expectativa_sugerida text NULL,
	data_expectativa_informada text NULL,
	data_ultima_autorizacao text NULL,
	data_envio_aprovacao_cotacao text NULL,
	data_ultima_aprovacao_cotacao text NULL,
	data_integracao_erp text NULL,
	data_emissao_pedido text NULL,
	data_previsao_faturamento text NULL,
	data_previsao_entrega text NULL,
	data_primeira_entrega text NULL,
	data_ultima_entrega text NULL,
	prazo_sugerido int4 NULL,
	prazo_solicitante int4 NULL,
	tempo_entre_solicitacao_compra int4 NULL,
	tempo_entre_solicitacao_entrega int4 NULL,
	tempo_atendeu_prazo_solicitante text NULL,
	tempo_fornecedor_atendeu_prazo_pedido text NULL,
	quantidade_convites int4 NULL,
	quantidade_respostas int4 NULL,
	quantidade_declinadas int4 NULL,
	quantidade_nao_responderam int4 NULL,
	saving_uc_percentual numeric(38, 18) NULL,
	saving_uc_valor numeric(38, 18) NULL,
	saving_ge_percentual numeric(38, 18) NULL,
	saving_ge_valor numeric(38, 18) NULL,
	saving_gf_percentual numeric(38, 18) NULL,
	saving_gf_valor numeric(38, 18) NULL,
	saving_ce_percentual numeric(38, 18) NULL,
	saving_ce_valor numeric(38, 18) NULL,
	saving_ma_percentual numeric(38, 18) NULL,
	saving_ma_valor numeric(38, 18) NULL,
	compra_tipo_compra text NULL,
	sdc_for_exclusivo text NULL,
	tempo_criacao numeric(10, 2) NULL,
	tempo_triagem numeric(10, 2) NULL,
	tempo_convite numeric(10, 2) NULL,
	tempo_cotacao numeric(10, 2) NULL,
	tempo_aprovacao numeric(10, 2) NULL,
	tempo_aprovacao_pedido numeric(10, 2) NULL,
	tempo_pedido numeric(10, 2) NULL,
	tempo_faturamento numeric(10, 2) NULL,
	tempo_entrega numeric(10, 2) NULL,
	tempo_comprador numeric(10, 2) NULL,
	tempo_aprovador numeric(10, 2) NULL,
	tempo_solicitante numeric(10, 2) NULL,
	tempo_fornecedor numeric(10, 2) NULL,
	tempo_total numeric(10, 2) NULL,
	motivo_codigo_erp text NULL,
	motivo_descricao text NULL,
	centro_de_custo_cod text NULL,
	sdc_status text NULL,
	requisicao_grupo text NULL,
	cotacao_codigo int4 NULL,
	sequencial_pedido int4 NULL,
	compra_cond_pagamento text NULL,
	compra_prazo_medio_pagamento numeric(10, 2) NULL,
	sdcv_target numeric(18, 6) NULL,
	nota_primeiro_vencimento timestamp NULL,
	nota_item_valor numeric(38, 18) NULL,
	projeto_valor_aprovado numeric(38, 18) NULL
);


-- suprimentos.dobc_sdcv_resumo definição

-- Drop table

-- DROP TABLE suprimentos.dobc_sdcv_resumo;

CREATE TABLE suprimentos.dobc_sdcv_resumo (
	id_sdcv numeric(15) NULL,
	sdcv_status text NULL,
	sdcv_status_nome text NULL,
	sdcv_tipo text NULL,
	sdcv_prioridade text NULL,
	sdcv_tipo_registro text NULL,
	sdcv_tipo_compra text NULL,
	sdcv_qtdade numeric(38, 18) NULL,
	sdcv_valor_total numeric(38, 18) NULL,
	sdcv_vlr_frete_fornecedor numeric(38, 18) NULL,
	sdcv_saving_valor numeric(38, 18) NULL,
	sdcv_saving_percentual numeric(38, 18) NULL,
	sdcv_saving_tipo text NULL,
	sdcv_moeda text NULL,
	sdcv_data_criacao text NULL,
	sdcv_data_envio_cotacao text NULL,
	sdcv_data_envio_aprovacao text NULL,
	sdcv_data_compra text NULL,
	id_solicitante text NULL,
	id_comprador text NULL,
	id_item text NULL,
	sdcv_filial_razao text NULL,
	id_filial text NULL,
	sdcv_empresa_nome text NULL,
	id_projeto int8 NULL,
	id_fase_projeto int4 NULL,
	id_contrato int4 NULL,
	id_pedido text NULL,
	id_compra int4 NULL,
	id_cotacao int4 NULL,
	sdcv_motivo text NULL,
	sdcv_descricao_complementar text NULL,
	sdcv_descricao_interna text NULL,
	sdcv_motivo_escolha_fornecedor text NULL,
	sdcv_preenchedor_proposta text NULL,
	sdcv_renegociada text NULL,
	sdc_data_ult_movimentacao timestamp NULL,
	sdc_target numeric(18, 6) NULL
);


-- suprimentos.fauditorio_de_pedido_de_compra definição

-- Drop table

-- DROP TABLE suprimentos.fauditorio_de_pedido_de_compra;

CREATE TABLE suprimentos.fauditorio_de_pedido_de_compra (
	titulo numeric(9) NULL,
	tipo_titulo numeric(2) NULL,
	cnpj_titulo text NULL,
	emitente_titulo text NULL,
	centro_custo numeric(6) NULL,
	valor_titulo numeric(38, 10) NULL,
	pedido numeric(38, 10) NULL,
	valor_pedido numeric(38, 10) NULL,
	valor_diferenca numeric(38, 10) NULL,
	encontrado text NULL
);


-- suprimentos.fdados_bi definição

-- Drop table

-- DROP TABLE suprimentos.fdados_bi;

CREATE TABLE suprimentos.fdados_bi (
	sdcv_tipo text NULL,
	data_criacao_sdcv text NULL,
	data_ultima_entrega text NULL,
	centro_de_custo_cod text NULL,
	projeto_codigo int8 NULL,
	projeto_nome text NULL,
	projeto_fase_codigo int4 NULL,
	projeto_fase text NULL,
	sdcv_empresa text NULL,
	sdcv_c_contabil_codigo text NULL,
	sdcv_codigo numeric(15) NULL,
	pedido_numero text NULL,
	sdcv_solicitante text NULL,
	fornecedor_cnpj text NULL,
	fornecedor_razao_social text NULL,
	item_codigo_erp text NULL,
	item_nome text NULL,
	nf_numero text NULL,
	nota_item_valor numeric(38, 18) NULL,
	nf_data_emissao text NULL,
	nota_primeiro_vencimento timestamp NULL,
	sdc_descricao text NULL,
	sdcv_entrega_emissao text NULL,
	sdcv_entrega_numero_nf text NULL,
	sdcv_valor_total numeric(15, 3) NULL,
	proposta_vlr_unit numeric(15, 3) NULL
);


-- suprimentos.finvestimento_realizado definição

-- Drop table

-- DROP TABLE suprimentos.finvestimento_realizado;

CREATE TABLE suprimentos.finvestimento_realizado (
	empresa varchar(150) NULL,
	produto varchar(50) NULL,
	numero_nota int4 NULL,
	centro_de_custo varchar(150) NULL,
	fornecedor varchar(20) NULL,
	nome_fornecedor varchar(150) NULL,
	descricao_bem text NULL,
	cod_do_bem varchar(50) NULL,
	observacoes_do_bem text NULL,
	grupo_do_bem varchar(150) NULL,
	grupo_do_produto varchar(150) NULL,
	data_aquisicao date NULL,
	valor_bem numeric(15, 2) NULL,
	ultima_atualizacao timestamp NULL,
	descricao varchar(300) NULL
);


-- suprimentos.fitem_projeto_obc definição

-- Drop table

-- DROP TABLE suprimentos.fitem_projeto_obc;

CREATE TABLE suprimentos.fitem_projeto_obc (
	sdcv_codigo int8 NULL,
	prj_codigo int8 NULL,
	prj_nome text NULL,
	data_criacao_sdcv timestamp NULL,
	proposta_prazo_medio_pagamento int4 NULL,
	centro_de_custo_cod text NULL,
	sdcv_c_custo_nome text NULL,
	proposta_cond_pagamento text NULL,
	justificativa text NULL,
	pfa_codigo int8 NULL,
	pfa_descricao text NULL,
	pedido_numero text NULL,
	item_descricao text NULL,
	id_item int8 NULL,
	sdcv_tipo_registro text NULL,
	id_categoria_nivel1 int8 NULL,
	id_categoria_nivel2 int8 NULL,
	item_categoria_nivel1 text NULL,
	item_categoria_nivel2 text NULL,
	item_categoria_nivel3 text NULL,
	item_caracteristica text NULL,
	proposta_vlr_total numeric(18, 2) NULL,
	fornecedor_fantasia text NULL,
	fornecedor_cnpj text NULL,
	proposta_vlr_unit numeric(18, 2) NULL,
	sdcv_unidade text NULL,
	sdcv_quantidade numeric(18, 4) NULL,
	compra_numero int8 NULL,
	sdcv_tipo_compra text NULL,
	sdcv_solicitante text NULL,
	sdcv_comprador text NULL,
	prj_status text NULL,
	sdc_status text NULL,
	prv_valor_previsto numeric(18, 2) NULL,
	prj_valor_aprovado numeric(18, 2) NULL,
	prj_valor_base numeric(18, 2) NULL,
	prv_valor numeric(18, 2) NULL,
	descricao_status varchar(100) NULL,
	tipo varchar(30) NULL,
	etapa varchar(20) NULL,
	subetapa varchar(30) NULL,
	valor_previsto numeric(18, 3) NULL,
	valor_aprovado numeric(18, 3) NULL,
	valor_base numeric(18, 3) NULL,
	valor_unitario numeric(18, 3) NULL,
	valor_total numeric(18, 3) NULL,
	prazo_medio_pgto int4 NULL
);


-- suprimentos.fnota_entrada definição

-- Drop table

-- DROP TABLE suprimentos.fnota_entrada;

CREATE TABLE suprimentos.fnota_entrada (
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(5) NULL,
	nf_dataemissao timestamp NULL,
	fk_produto varchar(18) NULL,
	pedido_compra int8 NULL,
	seq_item_pedido_compra int8 NULL,
	fk_cliente varchar(20) NULL,
	fk_fornecedor varchar(20) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	itemnf_quantidade numeric(18, 3) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrdesconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	condicao_pagto int2 NULL,
	nf_origem int4 NULL,
	cfop varchar(44) NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	cd_emite_duplicata varchar(2) NULL,
	emite_duplicata varchar(3) NULL,
	fk_centro_custo int8 NULL,
	fk_conta_estoque int4 NULL,
	codigo_contabil int4 NULL,
	fk_grupo_contas int4 NULL,
	cod_familia int4 NULL,
	descricao_familia varchar(20) NULL,
	ultima_atualizacao timestamp NULL,
	data_digitacao timestamp NULL,
	data_transacao timestamp NULL,
	usuario_digitacao varchar(250) NULL,
	situacao_entrada int2 NULL,
	especie_docto varchar(5) NULL
);


-- suprimentos.fnota_entrada2 definição

-- Drop table

-- DROP TABLE suprimentos.fnota_entrada2;

CREATE TABLE suprimentos.fnota_entrada2 (
	nf_notafiscal numeric(9) NULL,
	nf_serienotafiscal text NULL,
	nf_dataemissao timestamp NULL,
	fk_produto text NULL,
	pedido_compra numeric(9) NULL,
	seq_item_pedido_compra numeric(9) NULL,
	fk_cliente text NULL,
	fk_fornecedor text NULL,
	itemnf_vlr_tot numeric(38, 10) NULL,
	itemnf_quantidade numeric(14, 3) NULL,
	itemnf_vlrunit numeric(20, 5) NULL,
	itemnf_vlrdesconto numeric(15, 2) NULL,
	itemnf_vlripi numeric(15, 2) NULL,
	itemnf_vlricms numeric(15, 2) NULL,
	itemnf_vlricmsdiferido numeric(15, 2) NULL,
	itemnf_vlrpis numeric(15, 2) NULL,
	itemnf_vlrcofins numeric(15, 2) NULL,
	condicao_pagto numeric(3) NULL,
	nf_origem numeric(9) NULL,
	cfop text NULL,
	desc_nat_oper text NULL,
	uf text NULL,
	cd_emite_duplicata text NULL,
	emite_duplicata text NULL,
	fk_centro_custo numeric(9) NULL,
	fk_conta_estoque numeric(2) NULL,
	codigo_contabil numeric(6) NULL,
	fk_grupo_contas numeric(3) NULL,
	cod_familia numeric(5) NULL,
	descricao_familia text NULL,
	dthora_atualizacao timestamp NULL,
	data_digitacao timestamp NULL,
	data_transacao timestamp NULL,
	usuario_digitacao text NULL,
	situacao_entrada numeric(1) NULL,
	especie_docto text NULL
);


-- suprimentos.fpendencias_acessorios definição

-- Drop table

-- DROP TABLE suprimentos.fpendencias_acessorios;

CREATE TABLE suprimentos.fpendencias_acessorios (
	empresa numeric(3) NULL,
	data_emissao timestamp NULL,
	nota_fiscal numeric(9) NULL,
	serie_nota_fiscal text NULL,
	ordem_servico numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL
);


-- suprimentos.fprojeto_obc definição

-- Drop table

-- DROP TABLE suprimentos.fprojeto_obc;

CREATE TABLE suprimentos.fprojeto_obc (
	projeto_codigo int8 NULL,
	projeto_nome text NULL,
	projeto_fase text NULL,
	projeto_fase_codigo int4 NULL,
	prj_data_ini date NULL,
	prj_data_fim date NULL,
	"valor total previsto" numeric(38, 18) NULL,
	"valor total orçado" numeric(38, 18) NULL,
	"valor total empenhado" numeric(38, 18) NULL,
	"valor total empenhado em contrato" numeric(38, 18) NULL,
	"valor total pedidos" numeric(38, 18) NULL,
	"valor total requisicoes de estoque" numeric(38, 18) NULL,
	"valor total notas fiscais" numeric(38, 18) NULL,
	"saldo total" numeric(38, 18) NULL
);


-- suprimentos.frequisicoes_compra definição

-- Drop table

-- DROP TABLE suprimentos.frequisicoes_compra;

CREATE TABLE suprimentos.frequisicoes_compra (
	num_requisicao numeric(6) NULL,
	seq_item_req numeric(2) NULL,
	codigo_deposito numeric(3) NULL,
	data_requisicao timestamp NULL,
	nome_requisit text NULL,
	observacao_req text NULL,
	data_prev_entr_req timestamp NULL,
	situacao_codigo numeric(1) NULL,
	cod_cancelamento numeric(2) NULL,
	descr_canc_comp text NULL,
	situacao text NULL,
	pedido_compra numeric(6) NULL,
	data_prev_entr_ped timestamp NULL,
	fk_produto text NULL,
	fk_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_requisitada numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	ultimaentrada timestamp NULL,
	ultimasaida timestamp NULL,
	estoqueatual numeric(38, 10) NULL,
	qtdsugerida numeric(38, 10) NULL,
	precoultentrada numeric(38, 10) NULL,
	estoquemin numeric(38, 10) NULL,
	estoquemax numeric(38, 10) NULL,
	consumomedmes numeric(38, 10) NULL,
	consumopordia numeric(38, 10) NULL
);

-- DROP SCHEMA sustentabilidade;

CREATE SCHEMA sustentabilidade AUTHORIZATION postgres;
-- sustentabilidade.fconsumo_energia definição

-- Drop table

-- DROP TABLE sustentabilidade.fconsumo_energia;

CREATE TABLE sustentabilidade.fconsumo_energia (
	data_hora timestamp NULL,
	ativo_consumido numeric NULL,
	ativo_fornecido numeric NULL,
	reativo numeric NULL,
	periodo text NULL,
	hora_cheia bool NULL,
	consumo_hora_cheia numeric NULL
);


-- sustentabilidade.fcontrole_energia definição

-- Drop table

-- DROP TABLE sustentabilidade.fcontrole_energia;

CREATE TABLE sustentabilidade.fcontrole_energia (
	"data" date NULL,
	goodwe_kwh numeric(12, 2) NULL,
	sunweg_kwh numeric(12, 2) NULL,
	geracao_total numeric(14, 2) NULL,
	ano numeric NULL,
	mes varchar(20) NULL,
	kwh_faturado numeric(12, 2) NULL,
	fatura_celesc numeric(12, 2) NULL,
	fatura_mle numeric(12, 2) NULL,
	fatura_total numeric(12, 2) NULL,
	rs_kwh_faturado numeric(12, 2) NULL,
	rs_kwh_distribuicao numeric(12, 2) NULL,
	rs_kwh_energia numeric(12, 2) NULL,
	pct_distribuicao numeric(7, 4) NULL,
	pct_energia numeric(7, 4) NULL,
	ufv_live numeric(12, 2) NULL,
	pct_geracao numeric(7, 4) NULL,
	rs_econ_ufv numeric(12, 2) NULL,
	kwh_real numeric(12, 2) NULL,
	fatura_sem_mle numeric(12, 2) NULL,
	rs_econ_mle numeric(12, 2) NULL,
	pct_economia_bruto_mle numeric(7, 4) NULL,
	taxas_mle numeric(12, 2) NULL,
	comissao_mle numeric(12, 2) NULL,
	venda_energia_mle numeric(12, 2) NULL,
	saldo_encargos_mle numeric(12, 2) NULL,
	liquido_mle numeric(12, 2) NULL,
	pct_economia_liquido_mle numeric(7, 4) NULL,
	rs_fatura_consumo_real numeric(12, 2) NULL,
	rs_fat_sem_ufv_mle numeric(12, 2) NULL,
	economia_operacao numeric(12, 2) NULL,
	economia_bruta numeric(12, 2) NULL,
	data_atualizacao timestamp NULL,
	ano_temp numeric NULL
);


-- sustentabilidade.fdescarte_residuos definição

-- Drop table

-- DROP TABLE sustentabilidade.fdescarte_residuos;

CREATE TABLE sustentabilidade.fdescarte_residuos (
	ultima_atualizacao timestamp NULL,
	id int4 NULL,
	data_descarte timestamp NULL,
	id_tipo_residuo int4 NULL,
	residuo varchar(100) NULL,
	unidade varchar(3) NULL,
	valor_unitario numeric(18, 3) NULL,
	quantidade numeric(18, 3) NULL
);


-- sustentabilidade.fnotas_energia definição

-- Drop table

-- DROP TABLE sustentabilidade.fnotas_energia;

CREATE TABLE sustentabilidade.fnotas_energia (
	serie text NULL,
	documento numeric(9) NULL,
	centro_custo numeric(9) NULL,
	codigo_contabil numeric(9) NULL,
	num_contabil numeric(9) NULL,
	data_emissao timestamp NULL,
	cnpj_comprador text NULL,
	nome_fornecedor text NULL,
	produto text NULL,
	descricao_item text NULL,
	unidade_medida text NULL,
	valor_unitario numeric(20, 5) NULL,
	quantidade numeric(14, 3) NULL,
	valor_total numeric(15, 2) NULL
);


-- sustentabilidade.fnotas_residuos definição

-- Drop table

-- DROP TABLE sustentabilidade.fnotas_residuos;

CREATE TABLE sustentabilidade.fnotas_residuos (
	codigo_empresa int2 NULL,
	serie_nota_fisc varchar(3) NULL,
	num_nota_fiscal int4 NULL,
	centro_custo int4 NULL,
	codigo_contabil int4 NULL,
	num_contabil int4 NULL,
	data_emissao timestamp NULL,
	cnpj_comprador varchar(120) NULL,
	nome_fornecedor varchar(60) NULL,
	natur_operacao int2 NULL,
	quantidade numeric(18, 3) NULL,
	valor_itens_nfis numeric(18, 3) NULL,
	produto varchar(111) NULL,
	descricao_item varchar(120) NULL,
	unidade_medida varchar(2) NULL,
	valor_unitario numeric(18, 3) NULL,
	qtde_item_fatur numeric(18, 3) NULL,
	valor_faturado numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);

-- DROP SCHEMA temporario;

CREATE SCHEMA temporario AUTHORIZATION postgres;
-- temporario.apex_fdebrum definição

-- Drop table

-- DROP TABLE temporario.apex_fdebrum;

CREATE TABLE temporario.apex_fdebrum (
	cod_risco int4 NULL,
	cod_refere_aux varchar(5) NULL,
	descri_refere_aux varchar(30) NULL,
	cod_alternativa int2 NULL,
	seq_estrutura int4 NULL,
	tempo_med_prep float8 NULL,
	tempo_med_corte float8 NULL,
	seq_variacao int2 NULL,
	colecao int2 NULL,
	nivel_comp varchar(1) NULL,
	grupo_comp varchar(5) NULL,
	sub_comp varchar(3) NULL,
	item_comp varchar(6) NULL,
	descr_referencia varchar(30) NULL,
	narrativa varchar(65) NULL,
	compr_debrum float8 NULL,
	temp_prep float8 NULL,
	tempo_tot_prep float8 NULL,
	largura_debrum float8 NULL,
	tempo_corte float8 NULL,
	tempo_total_corte float8 NULL,
	tempo_emb float8 NULL,
	tempo_total_emb float8 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.apex_fenfesto definição

-- Drop table

-- DROP TABLE temporario.apex_fenfesto;

CREATE TABLE temporario.apex_fenfesto (
	cod_risco int4 NULL,
	cod_refere_aux varchar(5) NULL,
	descri_refere_aux varchar(30) NULL,
	cod_alternativa int2 NULL,
	seq_estrutura int4 NULL,
	seq_variacao int2 NULL,
	cod_chave_produto varchar(111) NULL,
	descr_referencia varchar(30) NULL,
	narrativa varchar(65) NULL,
	colecao int2 NULL,
	grade_enfesto float8 NULL,
	grade_corte float8 NULL,
	comprimento numeric(8, 2) NULL,
	metragem float8 NULL,
	tempo_md_enf float8 NULL,
	tempo_enfesto float8 NULL,
	perim_corte float8 NULL,
	velocidade float8 NULL,
	tempo_medio float8 NULL,
	tempo_corte float8 NULL,
	tipo_corte_peca int2 NULL,
	tipo_corte varchar(32) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.apex_fgrade_p_custo definição

-- Drop table

-- DROP TABLE temporario.apex_fgrade_p_custo;

CREATE TABLE temporario.apex_fgrade_p_custo (
	cod_risco int4 NULL,
	cod_refere_aux varchar(139) NULL,
	cod_alternativa int2 NULL,
	seq_estrutura int4 NULL,
	seq_variacao int2 NULL,
	tamanho varchar(3) NULL,
	ordem_tamanho int2 NULL,
	qtde_marcacoes numeric(5, 1) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.apex_frevisao definição

-- Drop table

-- DROP TABLE temporario.apex_frevisao;

CREATE TABLE temporario.apex_frevisao (
	cod_risco int4 NULL,
	cod_refere varchar(5) NULL,
	descri_refere varchar(30) NULL,
	cod_alternativa int2 NULL,
	seq_estrutura int4 NULL,
	seq_variacao int2 NULL,
	nivel_comp varchar(1) NULL,
	grupo_comp varchar(5) NULL,
	sub_comp varchar(3) NULL,
	item_comp varchar(6) NULL,
	desc_tecido varchar(30) NULL,
	parte varchar(4000) NULL,
	tempo_unitario float8 NULL,
	partes float8 NULL,
	tempo_total float8 NULL,
	tempo_medio float8 NULL,
	grupo_estrutura varchar(5) NULL,
	tamanho varchar(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.apex_fseamless definição

-- Drop table

-- DROP TABLE temporario.apex_fseamless;

CREATE TABLE temporario.apex_fseamless (
	tecido varchar(200) NULL,
	ds_tipo_tecido varchar(5) NULL,
	qt_programada numeric NULL,
	qt_tempo numeric(5, 2) NULL,
	qt_tempo_total numeric(10, 2) NULL,
	grupo_comp varchar(30) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.apex_fsub_colecao definição

-- Drop table

-- DROP TABLE temporario.apex_fsub_colecao;

CREATE TABLE temporario.apex_fsub_colecao (
	cd_agrupador int2 NULL,
	ds_agrupador varchar(20) NULL,
	grupo_ref varchar(5) NULL,
	subgrupo_ref varchar(3) NULL,
	sub_colecao float8 NULL,
	ultima_atualizacao timestamp NULL,
	colecao int8 NULL
);


-- temporario.comercial_destacao_colecao_subcolecao definição

-- Drop table

-- DROP TABLE temporario.comercial_destacao_colecao_subcolecao;

CREATE TABLE temporario.comercial_destacao_colecao_subcolecao (
	cod_estacao numeric(9) NULL,
	desc_estacao text NULL,
	colecao numeric(3) NULL,
	desccolecao text NULL,
	subcolecao numeric(4) NULL,
	descsubcolecao text NULL
);


-- temporario.comercial_dlivepro_campaign_lists definição

-- Drop table

-- DROP TABLE temporario.comercial_dlivepro_campaign_lists;

CREATE TABLE temporario.comercial_dlivepro_campaign_lists (
	campaign_list_id int8 NULL,
	campaign_id int8 NULL,
	customer_cpf varchar(15) NULL,
	customer_name varchar(255) NULL,
	campaign_seller_cpf varchar(15) NULL,
	campaign_store_cnpj varchar(18) NULL,
	created_at timestamp NULL,
	contacted_at timestamp NULL,
	campaign_name varchar(255) NULL,
	campaign_name_ajusted varchar(255) NULL
);


-- temporario.comercial_dlivepro_campanha definição

-- Drop table

-- DROP TABLE temporario.comercial_dlivepro_campanha;

CREATE TABLE temporario.comercial_dlivepro_campanha (
	campaigns_id int8 NULL,
	campaigns_name text NULL,
	status bool NULL,
	contact_type int4 NULL,
	repick bool NULL,
	start_when_activate bool NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	next_impact int4 NULL,
	created_at timestamp NULL,
	audience_id int8 NULL,
	image_path text NULL,
	client_list_duration int4 NULL
);


-- temporario.comercial_dlivepro_transactions definição

-- Drop table

-- DROP TABLE temporario.comercial_dlivepro_transactions;

CREATE TABLE temporario.comercial_dlivepro_transactions (
	order_id text NULL,
	transaction_status_id int8 NULL,
	customer_cpf text NULL,
	store_cnpj text NULL,
	seller_cpf text NULL,
	order_date timestamp NULL,
	coupon_discount text NULL,
	coupon_seller text NULL,
	price_paid float8 NULL,
	amount int8 NULL
);


-- temporario.comercial_dperiodo_venda_previsao definição

-- Drop table

-- DROP TABLE temporario.comercial_dperiodo_venda_previsao;

CREATE TABLE temporario.comercial_dperiodo_venda_previsao (
	id int4 NULL,
	descricao varchar(100) NULL,
	colecao int4 NULL,
	col_tab_preco_sell_in int4 NULL,
	mes_tab_preco_sell_in int4 NULL,
	seq_tab_preco_sell_in int4 NULL,
	col_tab_preco_sell_out int4 NULL,
	mes_tab_preco_sell_out int4 NULL,
	seq_tab_preco_sell_out int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_dprevisao_venda_capa definição

-- Drop table

-- DROP TABLE temporario.comercial_dprevisao_venda_capa;

CREATE TABLE temporario.comercial_dprevisao_venda_capa (
	id varchar(50) NULL,
	id_previsao_vendas int4 NULL,
	grupo varchar(50) NULL,
	item varchar(50) NULL,
	valor_sell_in numeric(19, 6) NULL,
	valor_sell_out numeric(19, 6) NULL,
	grupo_base varchar(50) NULL,
	item_base varchar(50) NULL,
	qtde_vendida_base numeric(6) NULL,
	percentual_aplicar numeric(6, 2) NULL,
	qtde_previsao numeric(6) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_dprevisao_venda_item definição

-- Drop table

-- DROP TABLE temporario.comercial_dprevisao_venda_item;

CREATE TABLE temporario.comercial_dprevisao_venda_item (
	id varchar(60) NULL,
	id_previsao_vendas int4 NULL,
	id_item_previsao_vendas varchar(60) NULL,
	grupo varchar(30) NULL,
	item varchar(30) NULL,
	sub varchar(30) NULL,
	qtde_previsao numeric(6) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_dprevisoes_vendas_colecao definição

-- Drop table

-- DROP TABLE temporario.comercial_dprevisoes_vendas_colecao;

CREATE TABLE temporario.comercial_dprevisoes_vendas_colecao (
	cod_colecao int2 NULL,
	desc_colecao varchar(20) NULL,
	cod_subcolecao int2 NULL,
	desc_subcolecao varchar(20) NULL,
	classificacao int2 NULL,
	desc_classificacao varchar(6) NULL,
	abreviacao_col varchar(20) NULL,
	tipo_col varchar(20) NULL,
	data_inicio_sell_in timestamp NULL,
	data_fim_sell_in timestamp NULL,
	data_inicio_sell_out timestamp NULL,
	data_fim_sell_out timestamp NULL,
	data_inicio_producao timestamp NULL,
	data_fim_producao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_drepresentante definição

-- Drop table

-- DROP TABLE temporario.comercial_drepresentante;

CREATE TABLE temporario.comercial_drepresentante (
	pk_representante varchar(6) NULL,
	cnpj_repres int8 NULL,
	cod_empresa int2 NULL,
	cod_repres int2 NULL,
	nome_repres varchar(50) NULL,
	nome_fantasia varchar(50) NULL,
	tipo_repres int2 NULL,
	endereco varchar(60) NULL,
	bairro varchar(20) NULL,
	cidade varchar(40) NULL,
	regiao varchar(20) NULL,
	subregiao varchar(20) NULL,
	cep int4 NULL,
	ddd_celular int2 NULL,
	num_celular int4 NULL,
	fone_repres int4 NULL,
	inscricao_estadual varchar(14) NULL,
	email varchar(60) NULL,
	situacao int2 NULL,
	conta_banco varchar(15) NULL,
	cod_agencia varchar(15) NULL,
	cod_adm int2 NULL,
	ult_pedido timestamp NULL,
	dias_ult_pedido float8 NULL,
	dt_primeiro_pedido timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cod_cidade varchar(5) NULL
);


-- temporario.comercial_fcontratos_lecom definição

-- Drop table

-- DROP TABLE temporario.comercial_fcontratos_lecom;

CREATE TABLE temporario.comercial_fcontratos_lecom (
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
	cronograma_atividades varchar(206) NULL,
	tipo_imovel varchar(207) NULL,
	matriz_filial varchar(200) NULL,
	tipo_solicitacao varchar(200) NULL,
	tipo_locacao varchar(200) NULL,
	tipo_da_locacao varchar(200) NULL,
	objeto_contrato varchar(500) NULL,
	valor_contratado numeric(18, 3) NULL,
	valor_multa numeric(18, 3) NULL
);


-- temporario.comercial_fcontratos_locacao_lecom definição

-- Drop table

-- DROP TABLE temporario.comercial_fcontratos_locacao_lecom;

CREATE TABLE temporario.comercial_fcontratos_locacao_lecom (
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
	cronograma_atividades varchar(206) NULL,
	tipo_imovel varchar(207) NULL,
	matriz_filial varchar(200) NULL,
	tipo_solicitacao varchar(200) NULL,
	tipo_locacao varchar(200) NULL,
	tipo_da_locacao varchar(200) NULL,
	objeto_contrato varchar(2000) NULL,
	valor_contratado numeric(18, 3) NULL,
	valor_multa numeric(18, 3) NULL,
	razao_social varchar(180) NULL,
	fiador varchar(120) NULL,
	ide_finalizado varchar(60) NULL
);


-- temporario.comercial_festoque_produtos definição

-- Drop table

-- DROP TABLE temporario.comercial_festoque_produtos;

CREATE TABLE temporario.comercial_festoque_produtos (
	fk_produto varchar(111) NULL,
	cod_erp varchar(111) NULL,
	conta_estoque int2 NULL,
	unidade_medida varchar(2) NULL,
	qtd_sugerida numeric(18, 3) NULL,
	qtd_empenhada numeric(18, 3) NULL,
	qtd_est_atual numeric(18, 3) NULL,
	qtd_disponivel numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fitens_pedidos definição

-- Drop table

-- DROP TABLE temporario.comercial_fitens_pedidos;

CREATE TABLE temporario.comercial_fitens_pedidos (
	pedido_venda int4 NULL,
	seq_item int2 NULL,
	fk_produto varchar(35) NULL,
	cod_nat_op int2 NULL,
	descr_nat_oper varchar(40) NULL,
	qtd_sugerida numeric(18, 3) NULL,
	qtd_afaturar numeric(18, 3) NULL,
	qtd_faturada numeric(18, 3) NULL,
	valor_unitario numeric(19, 4) NULL,
	percentual_desc numeric(17, 2) NULL,
	situacao_fatu_it int2 NULL,
	cod_cancelamento int2 NULL,
	tabela_preco varchar(35) NULL,
	qtd_cancelada numeric(18, 3) NULL,
	valor_cancelado numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_flivepro_conversao_campanha definição

-- Drop table

-- DROP TABLE temporario.comercial_flivepro_conversao_campanha;

CREATE TABLE temporario.comercial_flivepro_conversao_campanha (
	order_id text NULL,
	order_date timestamp NULL,
	contacted_at timestamp NULL,
	campaign_list_id int8 NULL,
	campaign_id int8 NULL,
	tempo_conversao text NULL
);


-- temporario.comercial_flog_itens_transfer definição

-- Drop table

-- DROP TABLE temporario.comercial_flog_itens_transfer;

CREATE TABLE temporario.comercial_flog_itens_transfer (
	cd_pedido numeric(9) NULL,
	cd_pedido_cliente text NULL,
	seq_item_pedido numeric(3) NULL,
	cd_item_trans text NULL,
	cd_destino_venda numeric(9) NULL,
	cd_destino_cliente text NULL,
	seq_item_destino numeric(3) NULL,
	qtd_transferida numeric(15, 3) NULL,
	controle numeric(1) NULL,
	cod_cancelamento numeric(3) NULL,
	desc_canc_pedido text NULL,
	dt_hora_insercao timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.comercial_flog_itens_transfer_inc definição

-- Drop table

-- DROP TABLE temporario.comercial_flog_itens_transfer_inc;

CREATE TABLE temporario.comercial_flog_itens_transfer_inc (
	cd_pedido int4 NULL,
	cd_pedido_cliente varchar(100) NULL,
	seq_item_pedido int2 NULL,
	cd_item_trans varchar(60) NULL,
	cd_destino_venda int4 NULL,
	cd_destino_cliente varchar(100) NULL,
	seq_item_destino int4 NULL,
	qtd_transferida numeric(18, 3) NULL,
	controle int2 NULL,
	dt_hora_insercao timestamp NULL,
	usuario_alteracao varchar(100) NULL,
	nome_usuario varchar(120) NULL,
	empresa_usuario int2 NULL,
	situacao_usuario_empresa varchar(15) NULL,
	observacao_usuario varchar(120) NULL
);
CREATE INDEX comercial_flog_itens_transfer_cd_pedido_seq_item_pedido_dt__idx ON temporario.comercial_flog_itens_transfer_inc USING btree (cd_pedido, seq_item_pedido, dt_hora_insercao);


-- temporario.comercial_flog_pedidos_itens_cancelados definição

-- Drop table

-- DROP TABLE temporario.comercial_flog_pedidos_itens_cancelados;

CREATE TABLE temporario.comercial_flog_pedidos_itens_cancelados (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	sku text NULL,
	cod_cancelamento_capa numeric(3) NULL,
	cod_cancelamento_item numeric(3) NULL,
	qtdcancelada numeric(38, 10) NULL,
	data_ocorrencia timestamp NULL,
	nome_programa text NULL,
	aplicacao text NULL,
	usuario_rede text NULL
);


-- temporario.comercial_flog_pedidos_itens_cancelados_inc definição

-- Drop table

-- DROP TABLE temporario.comercial_flog_pedidos_itens_cancelados_inc;

CREATE TABLE temporario.comercial_flog_pedidos_itens_cancelados_inc (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	sku text NULL,
	cod_cancelamento_capa numeric(3) NULL,
	cod_cancelamento_item numeric(3) NULL,
	qtdcancelada numeric(38, 10) NULL,
	data_ocorrencia timestamp NULL,
	nome_programa text NULL,
	aplicacao text NULL,
	usuario_rede text NULL
);


-- temporario.comercial_flog_pedidos_itens_transferidos definição

-- Drop table

-- DROP TABLE temporario.comercial_flog_pedidos_itens_transferidos;

CREATE TABLE temporario.comercial_flog_pedidos_itens_transferidos (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	desc_tipo_ocorrencia text NULL,
	sequencia_origem numeric(38, 10) NULL,
	sequencia_destino numeric(38, 10) NULL,
	produto_destino text NULL,
	pedido_destino numeric(38, 10) NULL,
	sku text NULL,
	qtd_transferida numeric(38, 10) NULL,
	cod_cancelamento numeric(38, 10) NULL,
	desc_canc_item text NULL,
	data_ocorr timestamp NULL,
	nome_programa text NULL,
	usuario_rede text NULL,
	nome_usuario text NULL
);
CREATE INDEX comercial_flog_pedidos_itens__numero_pedido_seq_item_pedid_idx1 ON temporario.comercial_flog_pedidos_itens_transferidos USING btree (numero_pedido, seq_item_pedido, data_ocorr);


-- temporario.comercial_flog_pedidos_itens_transferidos_inc definição

-- Drop table

-- DROP TABLE temporario.comercial_flog_pedidos_itens_transferidos_inc;

CREATE TABLE temporario.comercial_flog_pedidos_itens_transferidos_inc (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	desc_tipo_ocorrencia text NULL,
	sequencia_origem numeric(38, 10) NULL,
	sequencia_destino numeric(38, 10) NULL,
	produto_destino text NULL,
	pedido_destino numeric(38, 10) NULL,
	sku text NULL,
	qtd_transferida numeric(38, 10) NULL,
	cod_cancelamento numeric(38, 10) NULL,
	desc_canc_item text NULL,
	data_ocorr timestamp NULL,
	nome_programa text NULL,
	usuario_rede text NULL,
	nome_usuario text NULL
);
CREATE INDEX comercial_flog_pedidos_itens__numero_pedido_seq_item_pedido_idx ON temporario.comercial_flog_pedidos_itens_transferidos_inc USING btree (numero_pedido, seq_item_pedido, data_ocorr);


-- temporario.comercial_fmeta_categorias_orion definição

-- Drop table

-- DROP TABLE temporario.comercial_fmeta_categorias_orion;

CREATE TABLE temporario.comercial_fmeta_categorias_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	id text NULL,
	cod_canal numeric(6) NULL,
	canal text NULL,
	cod_representante numeric(6) NULL,
	tipo_meta numeric(1) NULL,
	valor_categoria_1 numeric(12, 4) NULL,
	valor_categoria_2 numeric(12, 4) NULL,
	valor_categoria_3 numeric(12, 4) NULL,
	valor_categoria_4 numeric(12, 4) NULL,
	valor_categoria_5 numeric(12, 4) NULL,
	valor_categoria_6 numeric(12, 4) NULL,
	valor_categoria_7 numeric(12, 4) NULL,
	valor_categoria_8 numeric(12, 4) NULL,
	valor_categoria_9 numeric(12, 4) NULL,
	valor_categoria_10 numeric(12, 4) NULL
);


-- temporario.comercial_fmeta_estacao_orion definição

-- Drop table

-- DROP TABLE temporario.comercial_fmeta_estacao_orion;

CREATE TABLE temporario.comercial_fmeta_estacao_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	cod_canal numeric(6) NULL,
	canal text NULL,
	cod_representante numeric(6) NULL,
	descricao_rep text NULL,
	tipo_meta numeric(3) NULL,
	meta numeric(9, 2) NULL
);


-- temporario.comercial_fmeta_representante definição

-- Drop table

-- DROP TABLE temporario.comercial_fmeta_representante;

CREATE TABLE temporario.comercial_fmeta_representante (
	cod_estacao int4 NULL,
	descricao varchar(150) NULL,
	tabela_preco varchar(35) NULL,
	cod_representante int4 NULL,
	descricao_rep varchar(100) NULL,
	cod_canal int4 NULL,
	canal varchar(50) NULL,
	tipo_meta int2 NULL,
	meta numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fmeta_representante_orion definição

-- Drop table

-- DROP TABLE temporario.comercial_fmeta_representante_orion;

CREATE TABLE temporario.comercial_fmeta_representante_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	cod_canal numeric(6) NULL,
	canal text NULL,
	cod_representante numeric(6) NULL,
	descricao_rep text NULL,
	tipo_meta numeric(3) NULL,
	meta numeric(9, 2) NULL
);


-- temporario.comercial_fmeta_tabpreco_orion definição

-- Drop table

-- DROP TABLE temporario.comercial_fmeta_tabpreco_orion;

CREATE TABLE temporario.comercial_fmeta_tabpreco_orion (
	cod_estacao numeric(9) NULL,
	catalogo numeric(4) NULL,
	descricao text NULL,
	id text NULL,
	col_tab numeric(3) NULL,
	mes_tab numeric(3) NULL,
	seq_tab numeric(3) NULL
);


-- temporario.comercial_fnotas_canceladas definição

-- Drop table

-- DROP TABLE temporario.comercial_fnotas_canceladas;

CREATE TABLE temporario.comercial_fnotas_canceladas (
	serie_nota_fisc varchar(3) NULL,
	num_nota_fiscal int4 NULL,
	num_pedido int4 NULL,
	data_emissao timestamp NULL,
	cod_canc_nfisc int2 NULL,
	motivo_cancel varchar(30) NULL,
	situacao_duplic int2 NULL,
	situacao varchar(12) NULL,
	flag varchar(32) NULL,
	natur_operacao int2 NULL,
	descr_nat_oper varchar(40) NULL,
	pk_cliente varchar(4000) NULL,
	cod_forma_pagto int2 NULL,
	desc_forma_pagto varchar(30) NULL,
	cod_cond_pgto int2 NULL,
	desc_cond_pgto varchar(30) NULL,
	qtde_itens int4 NULL,
	valor_desconto numeric(18, 3) NULL,
	valor_itens_nfis numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fnotas_venda_produtos_inc definição

-- Drop table

-- DROP TABLE temporario.comercial_fnotas_venda_produtos_inc;

CREATE TABLE temporario.comercial_fnotas_venda_produtos_inc (
	nf_serienotafiscal varchar(3) NULL,
	nf_notafiscal int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_cdempresa int8 NULL,
	pk_cliente varchar(25) NULL,
	nf_dataemissao timestamp NULL,
	data_embarque timestamp NULL,
	desc_forma_pgto varchar(30) NULL,
	nf_condpgto int2 NULL,
	desc_condpgto varchar(30) NULL,
	nf_cod_situacao int8 NULL,
	nf_desc_situacao varchar(10) NULL,
	canal varchar(100) NULL,
	modalidade varchar(50) NULL,
	nf_cod_natureza int2 NULL,
	uf varchar(2) NULL,
	desc_nat_oper varchar(40) NULL,
	tipo_nota varchar(32) NULL,
	ultima_atualizacao timestamp NULL,
	pk_produto varchar(18) NULL,
	nf_nrseqitempedido int8 NULL,
	nf_formapgto int8 NULL,
	itemnf_qtdfaturada numeric(18, 3) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlr_contabil numeric(18, 3) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	itemnf_vlr_franchising numeric(18, 3) NULL,
	cod_representante int4 NULL
);


-- temporario.comercial_fpaypal_liberadas definição

-- Drop table

-- DROP TABLE temporario.comercial_fpaypal_liberadas;

CREATE TABLE temporario.comercial_fpaypal_liberadas (
	id numeric(9) NULL,
	usuario_liberador text NULL,
	data_liberacao timestamp NULL,
	data_insercao timestamp NULL,
	nota_fiscal numeric(9) NULL,
	serie_nota text NULL,
	status numeric(1) NULL,
	cliente text NULL,
	nome_cliente text NULL,
	cod_empresa text NULL,
	cgc_9 numeric(9) NULL,
	cgc_4 numeric(4) NULL,
	cgc_2 numeric(2) NULL,
	cond_pagamento text NULL,
	valor_nota numeric(38, 10) NULL,
	pedido_refaturamento numeric(38, 10) NULL,
	representante text NULL,
	tipo_cliente text NULL,
	origem text NULL,
	canal text NULL
);


-- temporario.comercial_fpaypal_nao_liberadas definição

-- Drop table

-- DROP TABLE temporario.comercial_fpaypal_nao_liberadas;

CREATE TABLE temporario.comercial_fpaypal_nao_liberadas (
	id numeric(9) NULL,
	usuario_liberador text NULL,
	data_liberacao timestamp NULL,
	data_insercao timestamp NULL,
	nota_fiscal numeric(9) NULL,
	serie_nota text NULL,
	status numeric(1) NULL,
	cpf_cnpj_cliente text NULL,
	nome_cliente text NULL,
	cod_empresa text NULL,
	cgc_9 numeric(9) NULL,
	cgc_4 numeric(4) NULL,
	cgc_2 numeric(2) NULL,
	cond_pagamento text NULL,
	valor_nota numeric(38, 10) NULL,
	pedido_refaturamento numeric(38, 10) NULL,
	representante text NULL,
	tipo_cliente text NULL,
	dias_emissao numeric(38, 10) NULL,
	origem text NULL,
	canal text NULL,
	volume numeric(38, 10) NULL
);


-- temporario.comercial_fpedido definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedido;

CREATE TABLE temporario.comercial_fpedido (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX comercial_fpedido_fk_produto_ped_cdpedido_idx ON temporario.comercial_fpedido USING btree (fk_produto, ped_cdpedido);
CREATE INDEX comercial_fpedido_ped_cdpedido_idx ON temporario.comercial_fpedido USING btree (ped_cdpedido);
CREATE INDEX comercial_fpedido_ped_pedidoorigem_ped_dataembarque_idx ON temporario.comercial_fpedido USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.comercial_fpedido_in1 definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedido_in1;

CREATE TABLE temporario.comercial_fpedido_in1 (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX comercial_fpedido_in1_fk_produto_ped_cdpedido_idx ON temporario.comercial_fpedido_in1 USING btree (fk_produto, ped_cdpedido);
CREATE INDEX comercial_fpedido_in1_ped_cdpedido_idx ON temporario.comercial_fpedido_in1 USING btree (ped_cdpedido);
CREATE INDEX comercial_fpedido_in1_ped_pedidoorigem_ped_dataembarque_idx ON temporario.comercial_fpedido_in1 USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.comercial_fpedido_in2 definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedido_in2;

CREATE TABLE temporario.comercial_fpedido_in2 (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX comercial_fpedido_in2_fk_produto_ped_cdpedido_idx ON temporario.comercial_fpedido_in2 USING btree (fk_produto, ped_cdpedido);
CREATE INDEX comercial_fpedido_in2_ped_cdpedido_idx ON temporario.comercial_fpedido_in2 USING btree (ped_cdpedido);
CREATE INDEX comercial_fpedido_in2_ped_pedidoorigem_ped_dataembarque_idx ON temporario.comercial_fpedido_in2 USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.comercial_fpedido_situacao_bloqueio definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedido_situacao_bloqueio;

CREATE TABLE temporario.comercial_fpedido_situacao_bloqueio (
	pedido_venda numeric(9) NULL,
	seq_situacao numeric(2) NULL,
	codigo_situacao numeric(2) NULL,
	data_situacao timestamp NULL,
	flag_liberacao text NULL,
	desc_liberacao text NULL,
	data_liberacao timestamp NULL,
	responsavel text NULL,
	observacao text NULL,
	usuario_bloqueio text NULL,
	executa_trigger numeric(1) NULL
);


-- temporario.comercial_fpedidos_abertos definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedidos_abertos;

CREATE TABLE temporario.comercial_fpedidos_abertos (
	ped_cdempresa int2 NULL,
	ped_cdpedido int4 NULL,
	ped_dataemissao varchar(10) NULL,
	ped_dataembarque timestamp NULL,
	ped_dataembarque_original timestamp NULL,
	data_embarque_original timestamp NULL,
	itemped_cod_natureza int2 NULL,
	fk_cliente varchar(17) NULL,
	fk_representante int4 NULL,
	ped_cod_situacao_venda int2 NULL,
	ped_codcancelamento int2 NULL,
	itemped_desccancel varchar(20) NULL,
	ped_tipo_carteira varchar(2) NULL,
	canal_distr varchar(100) NULL,
	itemped_cdcolecao int2 NULL,
	ped_cdcidade int4 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	desconto_adicional numeric(18, 3) NULL,
	desconto numeric(18, 3) NULL,
	qtdeliqpedido numeric(18, 3) NULL,
	qtdsaldopedido numeric(18, 3) NULL,
	valorliqpedido numeric(18, 3) NULL,
	vlrdescontoitens numeric(18, 3) NULL,
	vlrtotalbruto numeric(18, 3) NULL,
	valorsaldopedido numeric(18, 3) NULL,
	vlrtotalfaturado numeric(18, 3) NULL,
	qtdafaturar numeric(18, 3) NULL,
	vlrpedido numeric(18, 3) NULL,
	vlrfranchising numeric(18, 3) NULL,
	vlrunitbruto numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fpedidos_bloqueados definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedidos_bloqueados;

CREATE TABLE temporario.comercial_fpedidos_bloqueados (
	ped_cdempresa int2 NULL,
	ped_cdpedido int4 NULL,
	ped_dataemissao varchar(10) NULL,
	ped_dataembarque timestamp NULL,
	ped_dataembarque_original timestamp NULL,
	data_embarque_original timestamp NULL,
	itemped_cod_natureza int2 NULL,
	fk_cliente varchar(17) NULL,
	fk_representante int4 NULL,
	ped_cod_situacao_venda int2 NULL,
	ped_codcancelamento int2 NULL,
	itemped_desccancel varchar(20) NULL,
	ped_tipo_carteira varchar(2) NULL,
	canal_distr varchar(100) NULL,
	itemped_cdcolecao int2 NULL,
	ped_cdcidade int4 NULL,
	despesas_adicionais int8 NULL,
	desconto_adicional numeric(18, 3) NULL,
	desconto numeric(18, 3) NULL,
	qtdeliqpedido numeric(18, 3) NULL,
	qtdsaldopedido numeric(18, 3) NULL,
	valorliqpedido numeric(18, 3) NULL,
	vlrdescontoitens numeric(18, 3) NULL,
	vlrtotalbruto numeric(18, 3) NULL,
	valorsaldopedido numeric(18, 3) NULL,
	vlrtotalfaturado numeric(18, 3) NULL,
	qtdafaturar numeric(18, 3) NULL,
	vlrpedido numeric(18, 3) NULL,
	vlrfranchising numeric(18, 3) NULL,
	vlrunitbruto numeric(18, 3) NULL,
	seq_situacao int2 NULL,
	cod_situacao int2 NULL,
	dat_situacao_aux timestamp NULL,
	dat_liberacao_aux timestamp NULL,
	nom_responsavel varchar(250) NULL,
	obs_situacao varchar(500) NULL,
	des_situacao varchar(60) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fpedidos_capa definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedidos_capa;

CREATE TABLE temporario.comercial_fpedidos_capa (
	pedido_venda int4 NULL,
	codigo_empresa int2 NULL,
	data_emissao timestamp NULL,
	data_embarque timestamp NULL,
	cd_representante int4 NULL,
	descr_nat_oper varchar(40) NULL,
	tipo_carteira varchar(32) NULL,
	estado_atual varchar(10) NULL,
	cod_cancelamento int2 NULL,
	motivo varchar(60) NULL,
	canal varchar(100) NULL,
	desc_cond_pgto varchar(30) NULL,
	cod_forma_pagto int4 NULL,
	desc_forma_pgto varchar(30) NULL,
	situacao_venda int2 NULL,
	desc_situacao_venda varchar(37) NULL,
	tipo_comissao int2 NULL,
	percent_comissao numeric(18, 3) NULL,
	tabela_preco varchar(35) NULL,
	cod_cidade int4 NULL,
	qtde_saldo_pedi numeric(18, 3) NULL,
	qtde_total_pedi numeric(18, 3) NULL,
	valor_saldo_pedi numeric(17, 2) NULL,
	valor_liquido numeric(17, 2) NULL,
	valor_bruto numeric(17, 2) NULL,
	ultima_atualizacao timestamp NULL,
	cnpj_cliente varchar(30) NULL
);


-- temporario.comercial_fpedidos_em_aberto definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedidos_em_aberto;

CREATE TABLE temporario.comercial_fpedidos_em_aberto (
	sku varchar(20) NULL,
	codigo_empresa varchar(3) NULL,
	data_emissao timestamp NULL,
	data_embarque timestamp NULL,
	descr_nat_oper varchar(60) NULL,
	cod_cancelamento varchar(3) NULL,
	motivo varchar(60) NULL,
	situacao_venda varchar(2) NULL,
	desc_situacao_venda varchar(40) NULL,
	estado_atual varchar(15) NULL,
	quantidade_pedido int8 NULL,
	qtdcancelada int8 NULL,
	qtdsaldopedido int8 NULL,
	ultima_atualizacao timestamp NULL,
	pedido_venda varchar(20) NULL,
	canal varchar(35) NULL
);


-- temporario.comercial_fpedidos_itens_cancelados definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedidos_itens_cancelados;

CREATE TABLE temporario.comercial_fpedidos_itens_cancelados (
	numero_pedido numeric(9) NULL,
	seq_item_pedido numeric(3) NULL,
	tipo_ocorr text NULL,
	desc_tipo_ocorrencia text NULL,
	sku text NULL,
	qtde_pedida_old numeric(16, 3) NULL,
	qtde_pedida_new numeric(16, 3) NULL,
	cod_cancelamento numeric(3) NULL,
	desc_canc_pedido text NULL,
	data_ocorr timestamp NULL,
	nome_programa text NULL,
	usuario_rede text NULL,
	nome_usuario text NULL,
	empresa_usuario numeric(3) NULL,
	situacao_usuario_empresa text NULL,
	observacao_usuario text NULL
);


-- temporario.comercial_fpedidos_refaturados definição

-- Drop table

-- DROP TABLE temporario.comercial_fpedidos_refaturados;

CREATE TABLE temporario.comercial_fpedidos_refaturados (
	pedido numeric(9) NULL,
	cnpj_cliente text NULL,
	notaref numeric(9) NULL,
	dataemissaoref text NULL,
	condpagtoref text NULL,
	notadevolucao numeric(9) NULL,
	motivo text NULL,
	usuariocardex text NULL,
	notageradaref numeric(9) NULL,
	dataemissaonotageradaref text NULL,
	condpagtonotageradaref text NULL,
	valornota numeric(13, 2) NULL
);


-- temporario.comercial_frastreio_entrega_loja definição

-- Drop table

-- DROP TABLE temporario.comercial_frastreio_entrega_loja;

CREATE TABLE temporario.comercial_frastreio_entrega_loja (
	pedido_venda int4 NULL,
	serie_nota_fiscal varchar(3) NULL,
	numero_nota_fiscal int4 NULL,
	numero_minuta int4 NULL,
	rastreador_tms varchar(100) NULL,
	ultima_atualizacao timestamp NULL,
	data_envio timestamp NULL
);


-- temporario.comercial_fregiao_representante definição

-- Drop table

-- DROP TABLE temporario.comercial_fregiao_representante;

CREATE TABLE temporario.comercial_fregiao_representante (
	cod_representante int4 NULL,
	cod_cidade int4 NULL,
	cod_adm int4 NULL,
	nome_adm varchar(40) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fsaldos_estoque_mes definição

-- Drop table

-- DROP TABLE temporario.comercial_fsaldos_estoque_mes;

CREATE TABLE temporario.comercial_fsaldos_estoque_mes (
	codigo_deposito int2 NULL,
	desc_deposito varchar(30) NULL,
	pk_produto varchar(30) NULL,
	nivel_produto varchar(1) NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	mes_ano_movimento timestamp NULL,
	ano_movimento int2 NULL,
	mes_movimento int2 NULL,
	saldo_fisico numeric(18, 3) NULL,
	saldo_financeiro numeric(18, 3) NULL,
	saldo_financeiro_estimado numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_fshopify_movimentacoes_ecom_internacional definição

-- Drop table

-- DROP TABLE temporario.comercial_fshopify_movimentacoes_ecom_internacional;

CREATE TABLE temporario.comercial_fshopify_movimentacoes_ecom_internacional (
	numero_pedido numeric(20) NULL,
	order_date timestamp NULL,
	tms_tracker text NULL,
	carrier_tracker text NULL,
	trasnportadora text NULL,
	"type" text NULL,
	country_code text NULL,
	country text NULL,
	currency text NULL,
	shipping_value float8 NULL,
	current_total_duties float8 NULL,
	total_tax float8 NULL,
	total_discounts float8 NULL,
	current_subtotal_price float8 NULL,
	valor_total_pedido float8 NULL,
	valor_pago float8 NULL
);


-- temporario.comercial_fshopify_orders definição

-- Drop table

-- DROP TABLE temporario.comercial_fshopify_orders;

CREATE TABLE temporario.comercial_fshopify_orders (
	id int8 NULL,
	shopify_id int8 NULL,
	order_number int8 NULL,
	order_date timestamp NULL,
	customer_id int8 NULL,
	source_identifier varchar(200) NULL,
	confirmed int8 NULL,
	payment_gateway_names varchar(200) NULL,
	currency varchar(255) NULL,
	total_discounts numeric(18, 3) NULL,
	total_price numeric(18, 3) NULL
);


-- temporario.comercial_fshopify_orders_itens definição

-- Drop table

-- DROP TABLE temporario.comercial_fshopify_orders_itens;

CREATE TABLE temporario.comercial_fshopify_orders_itens (
	order_id int8 NULL,
	sku varchar(50) NULL,
	shopify_product_id int8 NULL,
	quantity int4 NULL,
	price numeric(17, 2) NULL,
	desconto_code varchar(40) NULL,
	desconto_valor numeric(17, 2) NULL
);


-- temporario.comercial_fsituacao_notas definição

-- Drop table

-- DROP TABLE temporario.comercial_fsituacao_notas;

CREATE TABLE temporario.comercial_fsituacao_notas (
	nf_serienotafiscal text NULL,
	nf_notafiscal numeric(9) NULL,
	nf_nrpedidovenda numeric(9) NULL,
	pk_cliente text NULL,
	nf_dataemissao text NULL,
	data_embarque timestamp NULL,
	nf_formapgto numeric(38, 10) NULL,
	desc_forma_pgto text NULL,
	nf_condpgto numeric(3) NULL,
	desc_condpgto text NULL,
	nf_cod_situacao numeric(38, 10) NULL,
	nf_desc_situacao text NULL,
	canal text NULL,
	modalidade text NULL,
	nf_cod_natureza numeric(3) NULL,
	desc_nat_oper text NULL,
	situacao text NULL,
	tipo_nota text NULL,
	itemnf_qtdfaturada numeric(38, 10) NULL,
	itemnf_vlrunit numeric(38, 10) NULL,
	itemnf_vlr_contabil numeric(38, 10) NULL,
	itemnf_vlr_tot numeric(38, 10) NULL,
	itemnf_vlr_franchising numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.comercial_ftitulos_venda definição

-- Drop table

-- DROP TABLE temporario.comercial_ftitulos_venda;

CREATE TABLE temporario.comercial_ftitulos_venda (
	pedido_venda int4 NULL,
	serie_nota_fisc varchar(3) NULL,
	nf_notafiscal int4 NULL,
	num_nota_fiscal int8 NULL,
	sequencia int2 NULL,
	cod_forma_pagto int2 NULL,
	desc_forma_pgto varchar(30) NULL,
	situacao_duplic int2 NULL,
	desc_situacao varchar(12) NULL,
	valor_duplicata numeric(18, 3) NULL,
	saldo_duplicata numeric(18, 3) NULL,
	valor_pago numeric(18, 3) NULL,
	historico_pgto int2 NULL,
	historico_contab varchar(30) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.daparelho definição

-- Drop table

-- DROP TABLE temporario.daparelho;

CREATE TABLE temporario.daparelho (
	pk_aparelho varchar(6) NULL,
	desc_aparelho varchar(50) NULL,
	obs_aparelho varchar(100) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dbanco_horas definição

-- Drop table

-- DROP TABLE temporario.dbanco_horas;

CREATE TABLE temporario.dbanco_horas (
	descr_banco_horas varchar(50) NULL,
	dthora_atualizacao timestamp NULL,
	pk_banco_horas int4 NULL
);


-- temporario.dbloqueio definição

-- Drop table

-- DROP TABLE temporario.dbloqueio;

CREATE TABLE temporario.dbloqueio (
	pedido int4 NULL,
	codigo_situacao int4 NULL,
	observacao varchar(300) NULL,
	seq_situacao varchar(2) NULL,
	ultima_atualizacao timestamp NULL,
	pk_bloqueio varchar(50) NULL
);


-- temporario.dcadastro_loja definição

-- Drop table

-- DROP TABLE temporario.dcadastro_loja;

CREATE TABLE temporario.dcadastro_loja (
	pk_loja int4 NULL,
	desc_loja varchar(200) NULL,
	desc_apelido varchar(200) NULL,
	desc_razao_social varchar(200) NULL,
	pk_cnpj varchar(17) NULL,
	cod_inscricao_estadual varchar(20) NULL,
	cod_funcionario int4 NULL,
	cep int4 NULL,
	desc_endereco varchar(200) NULL,
	telefone int8 NULL,
	cod_portal int4 NULL,
	pk_portal int4 NULL,
	dt_inauguracao timestamp NULL,
	cod_regiao int4 NULL,
	cod_usuario int4 NULL,
	flag_abre_aos_domingos int2 NULL,
	omny_channel int2 NULL,
	cod_rede int4 NULL,
	ponto_retirada int2 NULL,
	cupom_desconto_loja varchar(20) NULL,
	dt_cadastro timestamp NULL,
	dt_ult_alteracao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	regiao varchar(50) NULL,
	rede varchar(50) NULL,
	metragem numeric(7, 2) NULL,
	porc_franchising numeric(7, 2) NULL,
	situacao varchar(10) NULL
);
CREATE INDEX dcadastro_loja_pk_cnpj_idx ON temporario.dcadastro_loja USING btree (pk_cnpj);


-- temporario.dcanaldistribuicao definição

-- Drop table

-- DROP TABLE temporario.dcanaldistribuicao;

CREATE TABLE temporario.dcanaldistribuicao (
	id int4 NULL,
	descricao varchar(100) NULL,
	modalidade varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcausa_demissao definição

-- Drop table

-- DROP TABLE temporario.dcausa_demissao;

CREATE TABLE temporario.dcausa_demissao (
	desc_dem varchar(50) NULL,
	cd_ds_dem varchar(70) NULL,
	cd_cau_rai int2 NULL,
	cd_cag int2 NULL,
	pk_causa_demissao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcentro_custo definição

-- Drop table

-- DROP TABLE temporario.dcentro_custo;

CREATE TABLE temporario.dcentro_custo (
	cd_centro_custo int4 NULL,
	desc_centro_custo varchar(25) NULL,
	cd_desc varchar(70) NULL,
	cd_local_entrega int4 NULL,
	cd_tipo_mao_obra int2 NULL,
	cd_centro_custo_pai int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcidades definição

-- Drop table

-- DROP TABLE temporario.dcidades;

CREATE TABLE temporario.dcidades (
	cod_cidade varchar(5) NULL,
	nm_cidade varchar(60) NULL,
	uf varchar(2) NULL,
	ddd int2 NULL,
	cod_pais int2 NULL,
	cod_fiscal int4 NULL,
	cod_reg_mer_ex int2 NULL,
	populacao int4 NULL,
	cod_cidade_zona_franca int4 NULL,
	cod_cidade_ibge int4 NULL,
	cod_sub_regiao int2 NULL,
	sub_regiao varchar(40) NULL,
	cod_suframa int2 NULL,
	cep int4 NULL,
	dthora_atualizacao timestamp NULL,
	nm_pais varchar(30) NULL,
	estado_extenso varchar(30) NULL
);


-- temporario.dclassificacao_referencia definição

-- Drop table

-- DROP TABLE temporario.dclassificacao_referencia;

CREATE TABLE temporario.dclassificacao_referencia (
	cd_referencia varchar(8) NULL,
	desc_categoria varchar(90) NULL,
	dthora_atualizacao timestamp NULL,
	pk_classificacao_referencia varchar(8) NULL,
	ds_cd_classificacao_ref varchar(100) NULL
);


-- temporario.dcliente definição

-- Drop table

-- DROP TABLE temporario.dcliente;

CREATE TABLE temporario.dcliente (
	pk_cliente varchar(16) NULL,
	cod_empresa int2 NULL,
	nm_cliente varchar(70) NULL,
	nm_fantasia varchar(70) NULL,
	fone_cliente int4 NULL,
	uf_cliente varchar(2) NULL,
	cep int4 NULL,
	cidade varchar(40) NULL,
	endereco varchar(70) NULL,
	bairro varchar(20) NULL,
	dt_cadastro timestamp NULL,
	cod_representante int2 NULL,
	nm_representante varchar(50) NULL,
	nm_subregiao_cliente varchar(20) NULL,
	tipo_cliente varchar(40) NULL,
	tipo_cliente_agrupamento varchar(40) NULL,
	dt_ult_compra timestamp NULL,
	vlr_ult_compra numeric(18, 3) NULL,
	prazo_medio numeric(9, 3) NULL,
	dt_ultima_fatura timestamp NULL,
	email_cliente varchar(100) NULL,
	grupo_economico varchar(40) NULL,
	cd_grupo_economico int4 NULL,
	situacao_cliente varchar(7) NULL,
	conceito_cliente varchar(20) NULL,
	modalidade_cliente varchar(30) NULL,
	pais_cliente varchar(25) NULL,
	regiao_cliente varchar(20) NULL,
	cod_cidade int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dclientefornecedor definição

-- Drop table

-- DROP TABLE temporario.dclientefornecedor;

CREATE TABLE temporario.dclientefornecedor (
	portal int2 NULL,
	cod_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	razao_cliente varchar(150) NULL,
	nome_cliente varchar(100) NULL,
	tipo_cliente varchar(10) NULL,
	cidade_cliente varchar(40) NULL,
	uf_cliente varchar(4) NULL,
	pais varchar(50) NULL,
	data_cadastro timestamp NULL,
	email_cliente varchar(100) NULL,
	ativo varchar(2) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dcodigo_calculo definição

-- Drop table

-- DROP TABLE temporario.dcodigo_calculo;

CREATE TABLE temporario.dcodigo_calculo (
	pk_codigo_calculado varchar(60) NULL,
	cd_cal int4 NULL,
	cd_tip_cal int2 NULL,
	cd_sit_cal varchar(1) NULL,
	dt_per_ref timestamp NULL,
	dt_pag timestamp NULL,
	dt_ini_cmp timestamp NULL,
	dt_fim_cmp timestamp NULL,
	cd_ori int4 NULL,
	dt_ani_apu timestamp NULL,
	dt_fim_apu timestamp NULL,
	dt_ini_ace timestamp NULL,
	dt_fim_ace timestamp NULL,
	cd_tip_cao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcolaborador definição

-- Drop table

-- DROP TABLE temporario.dcolaborador;

CREATE TABLE temporario.dcolaborador (
	nm_col varchar(70) NULL,
	cd_nm_col varchar(100) NULL,
	cd_cpf int8 NULL,
	cd_num_emp int4 NULL,
	cd_num_col varchar(12) NULL,
	cd_escol int4 NULL,
	cd_cargo varchar(80) NULL,
	cd_nacio int4 NULL,
	dt_nascim timestamp NULL,
	dt_admissao timestamp NULL,
	fg_deficiente varchar(2) NULL,
	cd_sexo varchar(9) NULL,
	cd_tip_col int2 NULL,
	cd_tip_contrato int4 NULL,
	cd_afastamento int4 NULL,
	dt_afastamento_original timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cd_filial int4 NULL,
	pk_colaborador varchar(180) NULL
);


-- temporario.dcolaborador_auditoria definição

-- Drop table

-- DROP TABLE temporario.dcolaborador_auditoria;

CREATE TABLE temporario.dcolaborador_auditoria (
	pk_colaborador_auditoria varchar(180) NULL,
	seq_reg int8 NULL,
	cd_ver_seq int8 NULL,
	nm_col varchar(70) NULL,
	cd_nm_col varchar(100) NULL,
	cd_cpf int8 NULL,
	cd_num_emp int4 NULL,
	cd_num_col varchar(12) NULL,
	cd_cargo varchar(80) NULL,
	cd_nacio int4 NULL,
	dt_nascim timestamp NULL,
	dt_admissao timestamp NULL,
	cd_sexo varchar(9) NULL,
	cd_tip_col int2 NULL,
	cd_tip_contrato int4 NULL,
	cd_afastamento int4 NULL,
	dt_afastamento_original timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcolaboradores definição

-- Drop table

-- DROP TABLE temporario.dcolaboradores;

CREATE TABLE temporario.dcolaboradores (
	cd_empresa numeric(40) NULL,
	cd_funcionario numeric(40) NULL,
	nome_funcionario varchar(40) NULL,
	turno numeric(40) NULL,
	cd_cargo numeric(40) NULL,
	cd_centro_custo numeric(40) NULL,
	cpf_funcionario varchar(14) NULL,
	dt_nascimento timestamp NULL,
	dt_adimissao timestamp NULL,
	cd_setor_responsavel int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcomprador definição

-- Drop table

-- DROP TABLE temporario.dcomprador;

CREATE TABLE temporario.dcomprador (
	pk_comprador int4 NULL,
	nome_comprador varchar(30) NULL,
	email_comprador varchar(40) NULL,
	fone_ramal int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dcondicao_pagamento definição

-- Drop table

-- DROP TABLE temporario.dcondicao_pagamento;

CREATE TABLE temporario.dcondicao_pagamento (
	pk_cond_pgto int2 NULL,
	desc_cond_pgto varchar(20) NULL,
	status_exportacao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dconta_contabil definição

-- Drop table

-- DROP TABLE temporario.dconta_contabil;

CREATE TABLE temporario.dconta_contabil (
	codigo_contabil int4 NULL,
	tipo_contabil int2 NULL,
	descricao varchar(45) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dcontas_estoque definição

-- Drop table

-- DROP TABLE temporario.dcontas_estoque;

CREATE TABLE temporario.dcontas_estoque (
	pk_conta_estoque int2 NULL,
	desc_conta_estoque varchar(40) NULL,
	tipo_produto_sped int2 NULL,
	itens_estoque int2 NULL,
	dthora_atualizacao timestamp NULL,
	tipo_conta_estoque int2 NULL
);


-- temporario.ddependente definição

-- Drop table

-- DROP TABLE temporario.ddependente;

CREATE TABLE temporario.ddependente (
	pk_depedente varchar(170) NULL,
	cd_nome_dep varchar(70) NULL,
	cd_nome_mae varchar(70) NULL,
	cd_gra_par int2 NULL,
	cd_tip_dep int2 NULL,
	cd_tip_sex varchar(2) NULL,
	cd_est_civ int2 NULL,
	cd_gra_ins int2 NULL,
	cd_lim_irf int2 NULL,
	cd_lim_saf int2 NULL,
	cd_avi_imp varchar(1) NULL,
	dt_nas timestamp NULL,
	dt_ent_cer timestamp NULL,
	cd_pai_nas int4 NULL,
	cd_est_nas varchar(4) NULL,
	dt_obi timestamp NULL,
	cd_nome_com varchar(70) NULL,
	cd_pes int4 NULL,
	cd_dep int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.ddeposito definição

-- Drop table

-- DROP TABLE temporario.ddeposito;

CREATE TABLE temporario.ddeposito (
	codigo_deposito int2 NULL,
	descricao varchar(30) NULL,
	local_deposito int2 NULL,
	cod_desc_deposito varchar(50) NULL,
	hora_atualizacao timestamp NULL
);


-- temporario.ddesccancelamento definição

-- Drop table

-- DROP TABLE temporario.ddesccancelamento;

CREATE TABLE temporario.ddesccancelamento (
	cod_canc_pedido int2 NULL,
	desc_canc_pedido varchar(20) NULL,
	tp_cancelamento int2 NULL,
	grupo_canc_ped varchar(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dempresa definição

-- Drop table

-- DROP TABLE temporario.dempresa;

CREATE TABLE temporario.dempresa (
	desc_empresa varchar(60) NULL,
	cd_ds_empresa varchar(100) NULL,
	pk_empresa int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.denderecoprodutos definição

-- Drop table

-- DROP TABLE temporario.denderecoprodutos;

CREATE TABLE temporario.denderecoprodutos (
	pk_produto varchar(18) NULL,
	deposito int2 NULL,
	endereco varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.descala definição

-- Drop table

-- DROP TABLE temporario.descala;

CREATE TABLE temporario.descala (
	pk_escala int4 NULL,
	desc_nome varchar(50) NULL,
	cd_hor_dsr int8 NULL,
	cd_hor_sem int8 NULL,
	cd_hor_mes int8 NULL,
	cd_tip_fer varchar(3) NULL,
	cd_tab_fer int2 NULL,
	cd_tip_esc varchar(1) NULL,
	cd_tur_esc int2 NULL,
	cd_tip_jor int2 NULL,
	cd_tip_jos int2 NULL,
	desc_jor varchar(200) NULL,
	desc_sim varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.destagio definição

-- Drop table

-- DROP TABLE temporario.destagio;

CREATE TABLE temporario.destagio (
	pk_estagio int2 NULL,
	desc_estagio varchar(20) NULL,
	cod_deposito int2 NULL,
	area_producao int2 NULL,
	tipo_estagio int2 NULL,
	estagio_final int2 NULL,
	sequencia_calculo_fila int2 NULL,
	estagio_base_fila int2 NULL,
	responsavel_estagio varchar(20) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.devento definição

-- Drop table

-- DROP TABLE temporario.devento;

CREATE TABLE temporario.devento (
	pk_evento varchar(110) NULL,
	cd_evento int4 NULL,
	cd_tipo_evento int2 NULL,
	desc_evento varchar(55) NULL,
	cd_ds_evento varchar(96) NULL,
	cd_tabela int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dfamilia_materiais definição

-- Drop table

-- DROP TABLE temporario.dfamilia_materiais;

CREATE TABLE temporario.dfamilia_materiais (
	pk_familia int4 NULL,
	desc_familia varchar(25) NULL,
	desc_usuario_comprador varchar(250) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dfilial definição

-- Drop table

-- DROP TABLE temporario.dfilial;

CREATE TABLE temporario.dfilial (
	cd_razao_social varchar(60) NULL,
	cd_nome_filial varchar(60) NULL,
	cd_desc_filial varchar(180) NULL,
	desc_atividade varchar(80) NULL,
	cd_edificio varchar(60) NULL,
	cd_endereco varchar(160) NULL,
	cd_tip_fil varchar(3) NULL,
	cd_numcgc int8 NULL,
	cd_insest varchar(18) NULL,
	cd_filctb int4 NULL,
	cd_ultfic int8 NULL,
	desc_nomcom varchar(100) NULL,
	cd_parpat varchar(3) NULL,
	pk_filial varchar(120) NULL,
	dthora_atualizacao timestamp NULL,
	cd_filial int4 NULL,
	pk_cnpj int8 NULL,
	cnpj varchar(20) NULL
);


-- temporario.dfuncionariosinteg definição

-- Drop table

-- DROP TABLE temporario.dfuncionariosinteg;

CREATE TABLE temporario.dfuncionariosinteg (
	cod_vendedor int4 NULL,
	cpf_vendedor varchar(20) NULL,
	nome_vendedor varchar(100) NULL,
	cargo varchar(100) NULL,
	loja varchar(20) NULL,
	cnpj varchar(40) NULL,
	status varchar(10) NULL,
	data_admissao timestamp NULL,
	data_demissao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dgrau_instrucao definição

-- Drop table

-- DROP TABLE temporario.dgrau_instrucao;

CREATE TABLE temporario.dgrau_instrucao (
	pk_grau_instrucao int2 NULL,
	desc_grau varchar(50) NULL,
	cd_insrai int2 NULL,
	cd_ds_grau varchar(90) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dgrupo_contas definição

-- Drop table

-- DROP TABLE temporario.dgrupo_contas;

CREATE TABLE temporario.dgrupo_contas (
	tipo_grupo_contas int2 NULL,
	desc_grupo_contas varchar(60) NULL,
	dthora_atualizacao timestamp NULL,
	pk_grupo_contas int4 NULL,
	obs varchar(300) NULL,
	observacao_grupo_contas varchar(100) NULL
);


-- temporario.dgrupo_embarque definição

-- Drop table

-- DROP TABLE temporario.dgrupo_embarque;

CREATE TABLE temporario.dgrupo_embarque (
	grupo_embarque int4 NULL,
	data_entrega timestamp NULL,
	nivel varchar(1) NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	pk_produto varchar(60) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dhistorico_contabil definição

-- Drop table

-- DROP TABLE temporario.dhistorico_contabil;

CREATE TABLE temporario.dhistorico_contabil (
	pk_historico int4 NULL,
	desc_historico varchar(30) NULL,
	flag_considera_regime varchar(1) NULL,
	sinal_titulo int2 NULL,
	sinal_diario int2 NULL,
	sinal_comissao int2 NULL,
	flag_entrada_saida varchar(8) NULL,
	tipo_historico varchar(3) NULL,
	flag_atualiza_comissao int2 NULL,
	flag_atualiza_acc int2 NULL,
	inf_custo int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dlivepro_campaign_lists definição

-- Drop table

-- DROP TABLE temporario.dlivepro_campaign_lists;

CREATE TABLE temporario.dlivepro_campaign_lists (
	id int8 NULL,
	campaign_id int8 NULL,
	customer_cpf varchar(11) NULL,
	customer_name varchar(255) NULL,
	seller_cpf varchar(11) NULL,
	store_cnpj varchar(14) NULL,
	created_at timestamp NULL,
	contacted_at timestamp NULL,
	"name" varchar(255) NULL,
	name_ajust varchar(255) NULL
);


-- temporario.dlocal_organograma definição

-- Drop table

-- DROP TABLE temporario.dlocal_organograma;

CREATE TABLE temporario.dlocal_organograma (
	pk_local_organograma varchar(100) NULL,
	cd_taborg int4 NULL,
	cd_num_loc int8 NULL,
	cd_rat int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dlocalizacao definição

-- Drop table

-- DROP TABLE temporario.dlocalizacao;

CREATE TABLE temporario.dlocalizacao (
	pk_localizacao int4 NULL,
	cd_nom_loc varchar(60) NULL,
	cd_num_loc int4 NULL,
	cd_rat int4 NULL,
	cd_ds_loc varchar(101) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dmaquina definição

-- Drop table

-- DROP TABLE temporario.dmaquina;

CREATE TABLE temporario.dmaquina (
	pk_maquina varchar(8) NULL,
	numero_maquina int4 NULL,
	cod_grupo_maquina varchar(4) NULL,
	desc_grupo_maquina varchar(60) NULL,
	unidade_medida varchar(2) NULL,
	subgrupo_maquina varchar(3) NULL,
	desc_subgrupo varchar(10) NULL,
	observacao_subgrupo varchar(180) NULL,
	cod_familia int2 NULL,
	desc_familia varchar(25) NULL,
	maquina_ativa int4 NULL,
	cod_centro_custo int8 NULL,
	observacao_maquina varchar(65) NULL,
	dthora_atualizacao timestamp NULL,
	numero_operadores numeric(18, 3) NULL,
	volume_maximo numeric(18, 3) NULL,
	volume_minimo numeric(18, 3) NULL,
	pk_maquina_num varchar(80) NULL,
	nome_maquina varchar(10) NULL,
	descricao_maquina varchar(144) NULL
);


-- temporario.dmotivo definição

-- Drop table

-- DROP TABLE temporario.dmotivo;

CREATE TABLE temporario.dmotivo (
	pk_motivo int4 NULL,
	desc_motivo varchar(50) NULL,
	cd_ds_motivo varchar(70) NULL,
	cd_tip_motivo varchar(3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dmotivo_devolucao definição

-- Drop table

-- DROP TABLE temporario.dmotivo_devolucao;

CREATE TABLE temporario.dmotivo_devolucao (
	codigo_motivo int2 NULL,
	descr_motivo varchar(30) NULL,
	setor_responsav varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dnatureza_operacao definição

-- Drop table

-- DROP TABLE temporario.dnatureza_operacao;

CREATE TABLE temporario.dnatureza_operacao (
	pk_natureza int4 NULL,
	venda int2 NULL,
	devolucao int2 NULL,
	ranking int2 NULL,
	franchising int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dnotasenviadasinteg definição

-- Drop table

-- DROP TABLE temporario.dnotasenviadasinteg;

CREATE TABLE temporario.dnotasenviadasinteg (
	nota_fiscal int4 NULL,
	serie_nota varchar(4) NULL,
	pk_cliente varchar(18) NULL,
	data_hora_envio timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dnotaslojas definição

-- Drop table

-- DROP TABLE temporario.dnotaslojas;

CREATE TABLE temporario.dnotaslojas (
	codigo_empresa int2 NULL,
	pedido_venda int4 NULL,
	num_nota_fiscal int4 NULL,
	serie_nota_fisc varchar(3) NULL,
	num_sol_nf_loja int4 NULL,
	num_nf_loja int4 NULL,
	serie_loja varchar(3) NULL,
	pk_loja varchar(20) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.doperacao definição

-- Drop table

-- DROP TABLE temporario.doperacao;

CREATE TABLE temporario.doperacao (
	desc_operacao varchar(50) NULL,
	pk_operacao int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dperiodo_producao definição

-- Drop table

-- DROP TABLE temporario.dperiodo_producao;

CREATE TABLE temporario.dperiodo_producao (
	data_ini_periodo timestamp NULL,
	data_fim_periodo timestamp NULL,
	dias_uteis int4 NULL,
	cd_area_periodo int2 NULL,
	desc_situacao_periodo int2 NULL,
	dthora_atualizacao timestamp NULL,
	cd_periodo_producao int4 NULL,
	pk_periodo_producao varchar(85) NULL,
	cd_empresa int4 NULL,
	cd_deposito int4 NULL,
	data_ini_fatu timestamp NULL,
	data_fim_fatu timestamp NULL,
	descricao varchar(20) NULL
);


-- temporario.dportador definição

-- Drop table

-- DROP TABLE temporario.dportador;

CREATE TABLE temporario.dportador (
	desc_banco varchar(15) NULL,
	pk_portador int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dproduto definição

-- Drop table

-- DROP TABLE temporario.dproduto;

CREATE TABLE temporario.dproduto (
	pk_produto varchar(25) NULL,
	pk_produto_cigam varchar(14) NULL,
	cd_produto varchar(16) NULL,
	cd_desc_prod varchar(80) NULL,
	nivel_estrutura int2 NULL,
	desc_nivel_estrutura varchar(30) NULL,
	cd_referencia varchar(5) NULL,
	desc_produto varchar(70) NULL,
	und_medida varchar(2) NULL,
	desc_unidade_medida varchar(20) NULL,
	nm_tamanho varchar(15) NULL,
	nm_cor varchar(25) NULL,
	cd_colecao int2 NULL,
	desc_colecao varchar(30) NULL,
	cod_linha int4 NULL,
	linha_produto varchar(40) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(30) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(30) NULL,
	cd_desc_referencia varchar(50) NULL,
	cod_desc_artigo varchar(50) NULL,
	cod_agrupador int2 NULL,
	desc_agrupador varchar(50) NULL,
	tipo_produto varchar(15) NULL,
	marca varchar(50) NULL,
	cd_conta_estoque int2 NULL,
	desc_conta_estoque varchar(50) NULL,
	desc_produto_narrativa varchar(90) NULL,
	cd_cor varchar(6) NULL,
	cd_tamanho varchar(5) NULL,
	desc_narrativa varchar(70) NULL,
	item_ativo int2 NULL,
	desc_referencia varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	publico_alvo varchar(60) NULL,
	faixa_etaria varchar(60) NULL,
	codigo_contabil int4 NULL,
	classific_fiscal varchar(15) NULL,
	descr_class_fisc varchar(40) NULL,
	serie_tamanho int2 NULL,
	desc_serie_tamanho varchar(10) NULL,
	obs_serie_tamanho varchar(60) NULL,
	sub_colecao varchar(20) NULL,
	familia1 varchar(80) NULL,
	familia2 varchar(80) NULL,
	familia3 varchar(80) NULL,
	familia4 varchar(80) NULL,
	familia5 varchar(80) NULL,
	dthora_atualizacao timestamp NULL,
	alternativa_item int8 NULL,
	preco_custo numeric(18, 3) NULL
);


-- temporario.dreposicoes definição

-- Drop table

-- DROP TABLE temporario.dreposicoes;

CREATE TABLE temporario.dreposicoes (
	pk_reposicoes int8 NULL,
	cd_solicitacao int8 NULL,
	cd_ordem_producao int8 NULL,
	cd_est int4 NULL,
	dt_emissao timestamp NULL,
	cd_situacao_requisicao int2 NULL,
	desc_observacao varchar(2003) NULL,
	hora_gerada timestamp NULL,
	cd_empresa int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.drepresentante definição

-- Drop table

-- DROP TABLE temporario.drepresentante;

CREATE TABLE temporario.drepresentante (
	pk_representante varchar(6) NULL,
	cnpj_repres int8 NULL,
	cod_empresa int2 NULL,
	cod_repres int2 NULL,
	nome_repres varchar(50) NULL,
	nome_fantasia varchar(50) NULL,
	tipo_repres int2 NULL,
	endereco varchar(60) NULL,
	bairro varchar(20) NULL,
	cidade varchar(40) NULL,
	regiao varchar(20) NULL,
	subregiao varchar(20) NULL,
	cep int4 NULL,
	ddd_celular int2 NULL,
	num_celular int4 NULL,
	fone_repres int4 NULL,
	inscricao_estadual varchar(14) NULL,
	email varchar(60) NULL,
	situacao int2 NULL,
	conta_banco varchar(15) NULL,
	cod_agencia varchar(15) NULL,
	cod_adm int2 NULL,
	ult_pedido timestamp NULL,
	dias_ult_pedido float8 NULL,
	dt_primeiro_pedido timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cod_cidade varchar(5) NULL
);


-- temporario.dresponsavel_loja definição

-- Drop table

-- DROP TABLE temporario.dresponsavel_loja;

CREATE TABLE temporario.dresponsavel_loja (
	pk_responsavel varchar(80) NULL,
	cod_loja int4 NULL,
	desc_responsavel varchar(100) NULL,
	cod_funcao int2 NULL,
	email varchar(200) NULL,
	telefone varchar(30) NULL,
	cod_situacao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dsituacao definição

-- Drop table

-- DROP TABLE temporario.dsituacao;

CREATE TABLE temporario.dsituacao (
	pk_situacao int4 NULL,
	cd_ds_situacao varchar(80) NULL,
	desc_sit varchar(40) NULL,
	desc_abr varchar(6) NULL,
	cd_sit_cmp int4 NULL,
	cd_tip_sit int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dsituacaopedido definição

-- Drop table

-- DROP TABLE temporario.dsituacaopedido;

CREATE TABLE temporario.dsituacaopedido (
	cod_situacao_venda varchar(2) NULL,
	desc_situacao_venda varchar(70) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dsortimento definição

-- Drop table

-- DROP TABLE temporario.dsortimento;

CREATE TABLE temporario.dsortimento (
	pk_sortimento varchar(6) NULL,
	tipo_sortimento int2 NULL,
	desc_sortimento varchar(20) NULL,
	serie_cor int2 NULL,
	numero_quadro int2 NULL,
	cor_fundo varchar(6) NULL,
	sortimento_estampa varchar(6) NULL,
	obs_1 varchar(65) NULL,
	obs_2 varchar(65) NULL,
	tipo_tingimento varchar(1) NULL,
	tonalidade varchar(2) NULL,
	tonalidade_estampa varchar(2) NULL,
	cor_representativa varchar(15) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dtabelapreco definição

-- Drop table

-- DROP TABLE temporario.dtabelapreco;

CREATE TABLE temporario.dtabelapreco (
	col_tabela_preco int2 NULL,
	mes_tabela_preco int2 NULL,
	seq_tabela_preco int2 NULL,
	data_inicio_tabela timestamp NULL,
	data_fim_tabela timestamp NULL,
	descricao varchar(20) NULL,
	cod_desc_tabela_preco varchar(34) NULL,
	tabela_preco int4 NULL,
	tabela_preco_cod varchar(11) NULL,
	desc_catalogo varchar(40) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dtransacaoestoque definição

-- Drop table

-- DROP TABLE temporario.dtransacaoestoque;

CREATE TABLE temporario.dtransacaoestoque (
	codigo_transacao int2 NULL,
	descricao varchar(20) NULL,
	cod_desc_transacao varchar(50) NULL,
	entrada_saida varchar(1) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.dusuario_antigo definição

-- Drop table

-- DROP TABLE temporario.dusuario_antigo;

CREATE TABLE temporario.dusuario_antigo (
	pk_usuario_antigo int8 NULL,
	cd_nom_usu varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.dusuario_colaborador definição

-- Drop table

-- DROP TABLE temporario.dusuario_colaborador;

CREATE TABLE temporario.dusuario_colaborador (
	cd_num_emp int4 NULL,
	cd_tip_col int2 NULL,
	cd_num_col int8 NULL,
	cd_cri_usu int2 NULL,
	cd_usu_ema_env varchar(4) NULL,
	desc_nm_com varchar(150) NULL,
	desc_usu varchar(150) NULL,
	dt_log timestamp NULL,
	dt_hr_log int4 NULL,
	dthora_ultima_atualizacao timestamp NULL,
	pk_usuario_colaborador int8 NULL
);


-- temporario.estoque_dtipo_movimentacaoestoque definição

-- Drop table

-- DROP TABLE temporario.estoque_dtipo_movimentacaoestoque;

CREATE TABLE temporario.estoque_dtipo_movimentacaoestoque (
	codigo_transacao numeric(3) NULL,
	descricao text NULL,
	tipo_transacao text NULL
);


-- temporario.estoque_fcigam_saldo_estoque_atual definição

-- Drop table

-- DROP TABLE temporario.estoque_fcigam_saldo_estoque_atual;

CREATE TABLE temporario.estoque_fcigam_saldo_estoque_atual (
	loja text NULL,
	cnpj text NULL,
	cod_barras text NULL,
	codigo_barras_ean text NULL,
	qtd_estoque numeric(6) NULL,
	data_estoque timestamp NULL,
	id_rede numeric(6) NULL,
	nome_loja text NULL,
	situacao numeric(1) NULL,
	mes_ano text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.estoque_fentrada_op_estoque definição

-- Drop table

-- DROP TABLE temporario.estoque_fentrada_op_estoque;

CREATE TABLE temporario.estoque_fentrada_op_estoque (
	data_movimento timestamp NULL,
	sku varchar(20) NULL,
	ordem_producao varchar(10) NULL,
	quantidade_entrada int8 NULL,
	valor_monetario_entrada numeric(18, 3) NULL
);


-- temporario.estoque_finventario_contabil definição

-- Drop table

-- DROP TABLE temporario.estoque_finventario_contabil;

CREATE TABLE temporario.estoque_finventario_contabil (
	empresa int4 NULL,
	deposito int4 NULL,
	descr_deposito varchar(255) NULL,
	nivel varchar(50) NULL,
	grupo varchar(50) NULL,
	subgrupo varchar(50) NULL,
	item varchar(50) NULL,
	unidade_medida varchar(10) NULL,
	narrativa varchar(255) NULL,
	saldo_fisico numeric(18, 4) NULL,
	custo_medio numeric(18, 6) NULL,
	saldo numeric(18, 6) NULL,
	mes_ano_movimento date NULL,
	ultima_atualizacao date NULL
);


-- temporario.estoque_freserva_estoque definição

-- Drop table

-- DROP TABLE temporario.estoque_freserva_estoque;

CREATE TABLE temporario.estoque_freserva_estoque (
	nivel_estrutura text NULL,
	grupo_estrutura text NULL,
	subgru_estrutura text NULL,
	item_estrutura text NULL,
	ordem_producao numeric(9) NULL,
	codigo_estagio numeric(5) NULL,
	quantidade_reservada numeric(38, 10) NULL
);


-- temporario.estoque_freserva_tinturaria definição

-- Drop table

-- DROP TABLE temporario.estoque_freserva_tinturaria;

CREATE TABLE temporario.estoque_freserva_tinturaria (
	ordem_agrupamento varchar(10) NULL,
	ordem_de_producao varchar(10) NULL,
	data_de_emissao timestamp NULL,
	nivel_composicao varchar(3) NULL,
	grupo_composicao varchar(10) NULL,
	subgrupo_composicao varchar(10) NULL,
	item_composicao varchar(10) NULL,
	qtd_requistada numeric(18, 3) NULL,
	deposito varchar(10) NULL,
	data_emissao timestamp NULL,
	codigo_estagio varchar(5) NULL
);


-- temporario.estoque_frolos_estoq definição

-- Drop table

-- DROP TABLE temporario.estoque_frolos_estoq;

CREATE TABLE temporario.estoque_frolos_estoq (
	codigo_rolo int4 NULL,
	periodo_producao int2 NULL,
	turno_producao int2 NULL,
	cod_nuance varchar(3) NULL,
	numero_lote varchar(15) NULL,
	ordem_producao int4 NULL,
	tecido varchar(111) NULL,
	codigo_deposito int2 NULL,
	qualidade_rolo int2 NULL,
	endereco_rolo varchar(30) NULL,
	qualidade int2 NULL,
	data_entrada timestamp NULL,
	data_prod_tecel timestamp NULL,
	ultima_atualizacao timestamp NULL,
	ordem_producao_dm int4 NULL,
	area_producao int2 NULL,
	observacao varchar(500) NULL,
	rolo_estoque numeric(18, 3) NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	peso_bruto numeric(18, 3) NULL,
	peso_liquido_real numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	largura numeric(18, 3) NULL,
	gramatura numeric(18, 3) NULL,
	unidade_medida varchar(5) NULL
);


-- temporario.estoque_frolos_estoq_cong_inc definição

-- Drop table

-- DROP TABLE temporario.estoque_frolos_estoq_cong_inc;

CREATE TABLE temporario.estoque_frolos_estoq_cong_inc (
	codigo_rolo int4 NULL,
	periodo_producao int2 NULL,
	turno_producao int2 NULL,
	cod_nuance varchar(3) NULL,
	numero_lote varchar(15) NULL,
	ordem_producao int4 NULL,
	tecido varchar(111) NULL,
	codigo_deposito int2 NULL,
	qualidade_rolo int2 NULL,
	endereco_rolo varchar(30) NULL,
	qualidade int2 NULL,
	data_entrada timestamp NULL,
	data_prod_tecel timestamp NULL,
	ultima_atualizacao timestamp NULL,
	ordem_producao_dm int4 NULL,
	area_producao int2 NULL,
	observacao varchar(500) NULL,
	rolo_estoque numeric(18, 3) NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	peso_bruto numeric(18, 3) NULL,
	peso_liquido_real numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	largura numeric(18, 3) NULL,
	gramatura numeric(18, 3) NULL,
	unidade_medida varchar(5) NULL
);


-- temporario.estoque_fsaldoestoqueatual definição

-- Drop table

-- DROP TABLE temporario.estoque_fsaldoestoqueatual;

CREATE TABLE temporario.estoque_fsaldoestoqueatual (
	cd_empresa int2 NULL,
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(3) NULL,
	fk_produto varchar(18) NULL,
	dt_ult_entrada timestamp NULL,
	dt_ult_saida timestamp NULL,
	ultima_atualizacao timestamp NULL,
	codigo_barras varchar(16) NULL,
	qtd_empenhada numeric(18, 3) NULL,
	qtd_est_atual numeric(18, 3) NULL,
	qtd_disponivel numeric(18, 3) NULL,
	qtd_sugerida numeric(18, 3) NULL,
	valor_em_estoque float8 NULL
);


-- temporario.estoque_fsaldoestoqueinteg_inc definição

-- Drop table

-- DROP TABLE temporario.estoque_fsaldoestoqueinteg_inc;

CREATE TABLE temporario.estoque_fsaldoestoqueinteg_inc (
	loja varchar(5) NULL,
	cnpj varchar(20) NULL,
	cod_barras varchar(20) NULL,
	codigo_barras_ean varchar(30) NULL,
	qtd_estoque numeric(18, 3) NULL,
	data_estoque timestamp NULL,
	rede varchar(20) NULL,
	fantasia varchar(100) NULL,
	sku varchar(111) NULL,
	tamanho varchar(3) NULL,
	refcor varchar(11) NULL,
	situacao varchar(1) NULL,
	mes_ano varchar(75) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_data_estoque_idx ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (data_estoque);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_data_estoque_idx1 ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (data_estoque) WHERE (qtd_estoque > (0)::numeric);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_data_estoque_loja_sku_idx ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (data_estoque, loja, sku);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_data_estoque_qtd_estoque_idx ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (data_estoque, qtd_estoque);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_left_idx ON temporario.estoque_fsaldoestoqueinteg_inc USING btree ("left"((cod_barras)::text, 11));
CREATE INDEX estoque_fsaldoestoqueinteg_inc_loja_data_estoque_idx ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (loja, data_estoque DESC);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_loja_data_estoque_idx1 ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (loja, data_estoque) WHERE (qtd_estoque <> (0)::numeric);
CREATE INDEX estoque_fsaldoestoqueinteg_inc_loja_idx ON temporario.estoque_fsaldoestoqueinteg_inc USING btree (loja);


-- temporario.estoque_ftecidos_estoque definição

-- Drop table

-- DROP TABLE temporario.estoque_ftecidos_estoque;

CREATE TABLE temporario.estoque_ftecidos_estoque (
	cd_tecido varchar(30) NULL,
	nome_grupo varchar(30) NULL,
	nome_cor varchar(20) NULL,
	colecao varchar(20) NULL,
	linha varchar(40) NULL,
	artigo varchar(25) NULL,
	gramatura numeric(18, 3) NULL,
	certificacao_qualidade int2 NULL,
	codigo_deposito int2 NULL,
	rolo_estoque int2 NULL,
	codigo_rolo int4 NULL,
	unidade_medida varchar(2) NULL,
	qualidade_rolo int2 NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.eventos_dinfo_eventos definição

-- Drop table

-- DROP TABLE temporario.eventos_dinfo_eventos;

CREATE TABLE temporario.eventos_dinfo_eventos (
	id int8 NULL,
	nome_evento text NULL,
	nome text NULL,
	primeira_corrida text NULL,
	email text NULL,
	cpf varchar(20) NULL,
	cpf_responsavel varchar(20) NULL,
	data_aniversario date NULL,
	genero varchar(20) NULL,
	pcd int4 NULL,
	celular varchar(20) NULL,
	kit text NULL,
	subtotal numeric(12, 2) NULL,
	desconto numeric(12, 2) NULL,
	total numeric(12, 2) NULL,
	nome_time text NULL,
	informacao_adicional text NULL,
	status varchar(50) NULL,
	origem varchar(50) NULL,
	numer_peito varchar(50) NULL,
	check_in varchar(20) NULL,
	data_registro timestamp NULL
);


-- temporario.eventos_fcreditos_eventos definição

-- Drop table

-- DROP TABLE temporario.eventos_fcreditos_eventos;

CREATE TABLE temporario.eventos_fcreditos_eventos (
	cod_empresa numeric(3) NULL,
	exercicio numeric(4) NULL,
	numero_lanc numeric(9) NULL,
	seq_lanc numeric(5) NULL,
	origem numeric(2) NULL,
	lote numeric(5) NULL,
	periodo numeric(4) NULL,
	conta_contabil text NULL,
	conta_reduzida numeric(5) NULL,
	subconta numeric(4) NULL,
	centro_custo numeric(6) NULL,
	debito_credito text NULL,
	hist_contabil numeric(4) NULL,
	compl_histor1 text NULL,
	data_lancto timestamp NULL,
	valor_lancto numeric(15, 2) NULL,
	filial_lancto numeric(3) NULL,
	contabilizado numeric(1) NULL,
	data_contab timestamp NULL,
	documento numeric(9) NULL,
	datainsercao timestamp NULL
);


-- temporario.eventos_fdebitos_eventos definição

-- Drop table

-- DROP TABLE temporario.eventos_fdebitos_eventos;

CREATE TABLE temporario.eventos_fdebitos_eventos (
	cod_empresa numeric(3) NULL,
	exercicio numeric(4) NULL,
	numero_lanc numeric(9) NULL,
	seq_lanc numeric(5) NULL,
	origem numeric(2) NULL,
	lote numeric(5) NULL,
	periodo numeric(4) NULL,
	conta_contabil text NULL,
	conta_reduzida numeric(5) NULL,
	subconta numeric(4) NULL,
	centro_custo numeric(6) NULL,
	debito_credito text NULL,
	hist_contabil numeric(4) NULL,
	compl_histor1 text NULL,
	data_lancto timestamp NULL,
	valor_lancto numeric(15, 2) NULL,
	filial_lancto numeric(3) NULL,
	contabilizado numeric(1) NULL,
	data_contab timestamp NULL,
	documento numeric(9) NULL,
	datainsercao timestamp NULL
);


-- temporario.eventos_fexperience_events definição

-- Drop table

-- DROP TABLE temporario.eventos_fexperience_events;

CREATE TABLE temporario.eventos_fexperience_events (
	id int8 NULL,
	event_id int8 NULL,
	event_name text NULL,
	event_status text NULL,
	event_type text NULL,
	modality text NULL,
	registration_limit int8 NULL,
	distance text NULL,
	start_time text NULL,
	min_subscription_age int8 NULL,
	max_subscription_age int8 NULL,
	event_date date NULL,
	subscriptions_opened date NULL,
	subscriptions_closed date NULL,
	event_address text NULL,
	event_photo text NULL,
	results_link text NULL,
	start_location text NULL,
	"map" text NULL,
	event_description text NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL
);


-- temporario.eventos_fexperience_registrations definição

-- Drop table

-- DROP TABLE temporario.eventos_fexperience_registrations;

CREATE TABLE temporario.eventos_fexperience_registrations (
	id int8 NULL,
	event_id int8 NULL,
	modality text NULL,
	distance text NULL,
	chest_number text NULL,
	store_cnpj text NULL,
	store_name text NULL,
	cpf_cnpj text NULL,
	birthday date NULL,
	gender text NULL,
	order_date timestamp NULL,
	order_id text NULL,
	order_status text NULL,
	coupon text NULL,
	coupon_group text NULL,
	payment_type text NULL,
	kit text NULL,
	cart_items text NULL,
	price_paid float8 NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL
);


-- temporario.eventos_fexperience_registrations_inc definição

-- Drop table

-- DROP TABLE temporario.eventos_fexperience_registrations_inc;

CREATE TABLE temporario.eventos_fexperience_registrations_inc (
	id int8 NULL,
	event_id int8 NULL,
	modality text NULL,
	distance text NULL,
	chest_number text NULL,
	store_cnpj text NULL,
	store_name text NULL,
	cpf_cnpj text NULL,
	birthday date NULL,
	gender text NULL,
	order_date timestamp NULL,
	order_id text NULL,
	order_status text NULL,
	coupon text NULL,
	coupon_group text NULL,
	payment_type text NULL,
	kit text NULL,
	cart_items text NULL,
	price_paid float8 NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL
);


-- temporario.eventos_fnotas_compras_eventos definição

-- Drop table

-- DROP TABLE temporario.eventos_fnotas_compras_eventos;

CREATE TABLE temporario.eventos_fnotas_compras_eventos (
	serie text NULL,
	documento numeric(9) NULL,
	sequencia numeric(9) NULL,
	centro_custo numeric(9) NULL,
	nome_centro_custo text NULL,
	especie_docto text NULL,
	data_transacao timestamp NULL,
	data_emissao timestamp NULL,
	cod_produto text NULL,
	descricao_item text NULL,
	desc_natureza_oper text NULL,
	cod_situacao_nota numeric(1) NULL,
	desc_situacao_nota text NULL,
	codigo_cancelamento_pedido numeric(2) NULL,
	desc_cancelamento_pedido text NULL,
	data_canc_nfisc timestamp NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL,
	cod_tipo_fornecedor numeric(4) NULL,
	desc_tipo_fornecedor text NULL,
	desc_cond_pgto text NULL,
	unidade_medida text NULL,
	quantidade numeric(14, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	valor_total numeric(15, 2) NULL,
	data_atualizacao timestamp NULL
);


-- temporario.eventos_fnotas_compras_eventos_inc definição

-- Drop table

-- DROP TABLE temporario.eventos_fnotas_compras_eventos_inc;

CREATE TABLE temporario.eventos_fnotas_compras_eventos_inc (
	serie text NULL,
	documento numeric(9) NULL,
	sequencia numeric(9) NULL,
	centro_custo numeric(9) NULL,
	nome_centro_custo text NULL,
	especie_docto text NULL,
	data_transacao timestamp NULL,
	data_emissao timestamp NULL,
	cod_produto text NULL,
	descricao_item text NULL,
	desc_natureza_oper text NULL,
	cod_situacao_nota numeric(1) NULL,
	desc_situacao_nota text NULL,
	codigo_cancelamento_pedido numeric(2) NULL,
	desc_cancelamento_pedido text NULL,
	data_canc_nfisc timestamp NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL,
	cod_tipo_fornecedor numeric(4) NULL,
	desc_tipo_fornecedor text NULL,
	desc_cond_pgto text NULL,
	unidade_medida text NULL,
	quantidade numeric(14, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	valor_total numeric(15, 2) NULL,
	data_atualizacao timestamp NULL
);


-- temporario.eventos_fpedidos_compra_eventos definição

-- Drop table

-- DROP TABLE temporario.eventos_fpedidos_compra_eventos;

CREATE TABLE temporario.eventos_fpedidos_compra_eventos (
	pedido_compra numeric(6) NULL,
	seq_item_pedido numeric(3) NULL,
	numero_compra_obc text NULL,
	num_requisicao numeric(6) NULL,
	centro_custo numeric(6) NULL,
	nome_centro_custo text NULL,
	data_prev_entr timestamp NULL,
	dt_emis_ped_comp timestamp NULL,
	cod_produto text NULL,
	descricao_item text NULL,
	cod_situacao_nota numeric(1) NULL,
	sts_pedido_desc text NULL,
	codigo_cancelamento_pedido numeric(2) NULL,
	desc_cancelamento_pedido text NULL,
	codigo_cancelamento_item numeric(2) NULL,
	desc_cancelamento_item text NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL,
	cod_tipo_fornecedor numeric(4) NULL,
	desc_tipo_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_saldo_item numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	preco_item_comp numeric(15, 5) NULL,
	data_atualizacao timestamp NULL
);


-- temporario.eventos_fpedidos_compra_eventos_inc definição

-- Drop table

-- DROP TABLE temporario.eventos_fpedidos_compra_eventos_inc;

CREATE TABLE temporario.eventos_fpedidos_compra_eventos_inc (
	pedido_compra numeric(6) NULL,
	seq_item_pedido numeric(3) NULL,
	numero_compra_obc text NULL,
	num_requisicao numeric(6) NULL,
	centro_custo numeric(6) NULL,
	nome_centro_custo text NULL,
	data_prev_entr timestamp NULL,
	dt_emis_ped_comp timestamp NULL,
	cod_produto text NULL,
	descricao_item text NULL,
	cod_situacao_nota numeric(1) NULL,
	sts_pedido_desc text NULL,
	codigo_cancelamento_pedido numeric(2) NULL,
	desc_cancelamento_pedido text NULL,
	codigo_cancelamento_item numeric(2) NULL,
	desc_cancelamento_item text NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL,
	cod_tipo_fornecedor numeric(4) NULL,
	desc_tipo_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_saldo_item numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	preco_item_comp numeric(15, 5) NULL,
	data_atualizacao timestamp NULL
);


-- temporario.eventos_ftitulos_compras_eventos definição

-- Drop table

-- DROP TABLE temporario.eventos_ftitulos_compras_eventos;

CREATE TABLE temporario.eventos_ftitulos_compras_eventos (
	documento varchar(10) NULL,
	centro_custo varchar(10) NULL,
	nome_centro_custo varchar(40) NULL,
	especie_docto varchar(5) NULL,
	data_transacao timestamp NULL,
	data_emissao timestamp NULL,
	codigo_contabil varchar(10) NULL,
	codigo_cancelamento_pedido varchar(5) NULL,
	desc_cancelamento_pedido varchar(80) NULL,
	data_canc_tit timestamp NULL,
	cnpj_fornecedor varchar(15) NULL,
	nome_fornecedor varchar(60) NULL,
	cod_tipo_fornecedor varchar(4) NULL,
	forn_descricao varchar(40) NULL,
	cond_pagto varchar(3) NULL,
	valor_parcela numeric(17, 2) NULL
);


-- temporario.expedicao_dondas_pwt definição

-- Drop table

-- DROP TABLE temporario.expedicao_dondas_pwt;

CREATE TABLE temporario.expedicao_dondas_pwt (
	id_onda int4 NULL,
	descricao_onda text NULL,
	situacao_onda varchar(20) NULL,
	qtd_coletar_item numeric(15, 2) NULL,
	qtd_coletada_item numeric(15, 2) NULL,
	qtd_pedido numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.expedicao_dondas_slim_sorter definição

-- Drop table

-- DROP TABLE temporario.expedicao_dondas_slim_sorter;

CREATE TABLE temporario.expedicao_dondas_slim_sorter (
	id_onda numeric(9) NULL,
	descricao_onda text NULL,
	situacao_pedido numeric(2) NULL,
	situacao_onda numeric(2) NULL,
	situacao_onda_desc text NULL,
	id_pedido numeric(9) NULL,
	id_item numeric(9) NULL,
	grupo text NULL,
	subgrupo text NULL,
	item text NULL,
	sku text NULL,
	qtd_coletar_item numeric(4) NULL,
	qtd_coletada_item numeric(4) NULL,
	situacao_item numeric(2) NULL,
	situacao_onda_item text NULL,
	usuario_situacao numeric(5) NULL,
	usuario_situacao_item text NULL,
	id_tag text NULL
);


-- temporario.expedicao_fondas_planejamento definição

-- Drop table

-- DROP TABLE temporario.expedicao_fondas_planejamento;

CREATE TABLE temporario.expedicao_fondas_planejamento (
	empresapedidoonda int4 NULL,
	dataemissaopedidoonda date NULL,
	pedidoonda int4 NULL,
	dataembarquepedidoonda date NULL,
	clientepedidoonda text NULL,
	qtdepedidoonda numeric(15, 2) NULL,
	representantepedidoonda text NULL,
	transportadorapedidoonda text NULL,
	endereco varchar(100) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.expedicao_fondas_por_usuario definição

-- Drop table

-- DROP TABLE temporario.expedicao_fondas_por_usuario;

CREATE TABLE temporario.expedicao_fondas_por_usuario (
	id_usuario int4 NULL,
	usuario varchar(100) NULL,
	data_onda date NULL,
	id_onda int4 NULL,
	qtdeitens int4 NULL,
	ultima_atualizacao timestamp NULL,
	id varchar(10) NULL
);


-- temporario.expedicao_fondas_produtos_pendentes definição

-- Drop table

-- DROP TABLE temporario.expedicao_fondas_produtos_pendentes;

CREATE TABLE temporario.expedicao_fondas_produtos_pendentes (
	id_onda int4 NULL,
	nivel varchar(10) NULL,
	grupo varchar(10) NULL,
	subgrupo varchar(10) NULL,
	item varchar(10) NULL,
	qtd_coletar_item numeric(15, 2) NULL,
	endereco varchar(50) NULL,
	situacao_onda varchar(20) NULL,
	ultima_atualizacao date NULL
);


-- temporario.expedicao_fondas_pwt_resumo definição

-- Drop table

-- DROP TABLE temporario.expedicao_fondas_pwt_resumo;

CREATE TABLE temporario.expedicao_fondas_pwt_resumo (
	onda numeric(9) NULL,
	situacao text NULL,
	equipamento text NULL,
	data_situacao timestamp NULL,
	qtd_coletar numeric(38, 10) NULL,
	qtd_coletada numeric(38, 10) NULL,
	qtd_pedido numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.fabasfaccoesstage definição

-- Drop table

-- DROP TABLE temporario.fabasfaccoesstage;

CREATE TABLE temporario.fabasfaccoesstage (
	cod_chave_fornec varchar(70) NULL,
	desc_fornecedor varchar(40) NULL,
	dthora_atualizacao timestamp NULL,
	qtd_minutos_total numeric(18, 3) NULL,
	qtd_costureira numeric(18, 3) NULL,
	min_dia numeric(18, 3) NULL,
	dias_uteis numeric(18, 3) NULL,
	min_total numeric(18, 3) NULL,
	min_dia_enfic numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	min_prev_perc_efic numeric(18, 3) NULL,
	min_prev_ate_data numeric(18, 3) NULL,
	min_real numeric(18, 3) NULL,
	perc_capacidade numeric(18, 3) NULL,
	a_realizar numeric(18, 3) NULL,
	penden_prev numeric(18, 3) NULL,
	tempo_pendente numeric(18, 3) NULL,
	qtd_em_pendente numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL,
	dias_prod numeric(18, 3) NULL
);


-- temporario.fabastecimento_faccao definição

-- Drop table

-- DROP TABLE temporario.fabastecimento_faccao;

CREATE TABLE temporario.fabastecimento_faccao (
	cod_chave_fornec varchar(70) NULL,
	desc_fornecedor varchar(40) NULL,
	dthora_atualizacao timestamp NULL,
	dias_prod numeric(18, 3) NULL,
	qtd_minutos_total numeric(18, 3) NULL,
	qtd_costureira numeric(18, 3) NULL,
	min_dia numeric(18, 3) NULL,
	dias_uteis numeric(18, 3) NULL,
	min_total numeric(18, 3) NULL,
	min_dia_enfic numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	min_prev_perc_efic numeric(18, 3) NULL,
	min_prev_ate_data numeric(18, 3) NULL,
	min_real numeric(18, 3) NULL,
	perc_capacidade numeric(18, 3) NULL,
	a_realizar numeric(18, 3) NULL,
	penden_prev numeric(18, 3) NULL,
	tempo_pendente numeric(18, 3) NULL,
	qtd_em_pendente numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL
);


-- temporario.fabsenteismo definição

-- Drop table

-- DROP TABLE temporario.fabsenteismo;

CREATE TABLE temporario.fabsenteismo (
	fk_empresa int4 NULL,
	fk_filial varchar(100) NULL,
	fk_situacao int4 NULL,
	fk_cargo varchar(24) NULL,
	fk_local_organograma varchar(100) NULL,
	fk_localizacao int8 NULL,
	fk_colaborador varchar(130) NULL,
	cd_tip_col int2 NULL,
	cd_num_cad int8 NULL,
	cd_nom_fun varchar(60) NULL,
	cd_num_emp int4 NULL,
	cd_fil int4 NULL,
	cd_num_cgc int8 NULL,
	cd_loc varchar(180) NULL,
	cd_nom_loc varchar(70) NULL,
	cd_car varchar(24) NULL,
	cd_tit_car varchar(60) NULL,
	cd_esc int4 NULL,
	cd_nom_esc varchar(30) NULL,
	cd_sit_afa varchar(9) NULL,
	dt_ref timestamp NULL,
	cd_sit_lan int2 NULL,
	cd_sit_nom varchar(30) NULL,
	vlr_tot_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.facesso_sistema definição

-- Drop table

-- DROP TABLE temporario.facesso_sistema;

CREATE TABLE temporario.facesso_sistema (
	cd_empresa int4 NULL,
	cd_num_cadastro int8 NULL,
	cd_num_cpf int8 NULL,
	dt_acesso_auxi timestamp NULL,
	qtd_minuto_acesso int4 NULL,
	dthora_atualizacao timestamp NULL,
	fk_usu int8 NULL,
	fk_colaborador varchar(50) NULL,
	codfil int4 NULL
);


-- temporario.fafastamentos definição

-- Drop table

-- DROP TABLE temporario.fafastamentos;

CREATE TABLE temporario.fafastamentos (
	fk_colaborador varchar(100) NULL,
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	dt_afa timestamp NULL,
	vlr_hor_afa int4 NULL,
	dt_ter timestamp NULL,
	vlr_hor_ter int4 NULL,
	dt_prv_ter timestamp NULL,
	cd_dia_jus int2 NULL,
	desc_afa varchar(260) NULL,
	cd_sta_atu int2 NULL,
	cd_dia_prv int4 NULL,
	fk_cau_dem int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fapuracao definição

-- Drop table

-- DROP TABLE temporario.fapuracao;

CREATE TABLE temporario.fapuracao (
	pk_apuracao varchar(150) NULL,
	fk_colaborador varchar(140) NULL,
	fk_empresa int4 NULL,
	dt_apuracao timestamp NULL,
	dt_hr_apuracao int4 NULL,
	cd_desc int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fapuracao_col_situacao definição

-- Drop table

-- DROP TABLE temporario.fapuracao_col_situacao;

CREATE TABLE temporario.fapuracao_col_situacao (
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	fk_colaborador varchar(110) NULL,
	dt_apu timestamp NULL,
	qtd_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fbonus_vendedor definição

-- Drop table

-- DROP TABLE temporario.fbonus_vendedor;

CREATE TABLE temporario.fbonus_vendedor (
	cod_loja int4 NULL,
	nome_vendedor varchar(100) NULL,
	bonus_com_meta numeric(18, 3) NULL,
	bonus_sem_meta numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.fcarteira_pedido definição

-- Drop table

-- DROP TABLE temporario.fcarteira_pedido;

CREATE TABLE temporario.fcarteira_pedido (
	fk_produto varchar(20) NULL,
	cd_barra varchar(20) NULL,
	fk_cliente varchar(20) NULL,
	fk_representante int4 NULL,
	ped_tipo_carteira varchar(3) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(7) NULL,
	ped_dataemissao varchar(12) NULL,
	ped_dataembarque varchar(12) NULL,
	ped_dtembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int8 NULL,
	ped_periodo int4 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco varchar(12) NULL,
	ped_numerocontrole int4 NULL,
	ped_pedidovendaorigem int8 NULL,
	ped_pedidoorigem int8 NULL,
	ped_cfop varchar(20) NULL,
	ped_percomissaoped int8 NULL,
	ped_percdescped numeric(12, 2) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(5) NULL,
	permite_parcial varchar(5) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int4 NULL,
	ped_codigobanco int4 NULL,
	ped_percdescontotitulo numeric(8, 2) NULL,
	ped_pedidocliente varchar(40) NULL,
	itemped_qtdcancelada numeric(12, 2) NULL,
	itemped_valorcancelado numeric(12, 2) NULL,
	itemped_qtdsaldopedido numeric(12, 2) NULL,
	itemped_valorsaldopedido numeric(12, 2) NULL,
	itemped_qtdepedido numeric(12, 2) NULL,
	itemped_qtdeliqpedido numeric(12, 2) NULL,
	itemped_percdescontoitem numeric(12, 2) NULL,
	itemped_valorliqpedido numeric(12, 2) NULL,
	itemped_valorcomissao numeric(12, 2) NULL,
	itemped_valordescped numeric(12, 2) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento varchar(12) NULL,
	itemped_desccancel varchar(30) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int4 NULL,
	itemped_vlrdescontoitens numeric(12, 2) NULL,
	itemped_vlrtotalbruto numeric(12, 2) NULL,
	itemped_vlrtotalfaturado int8 NULL,
	itemped_valorunitario numeric(12, 2) NULL,
	itemped_seqitem int4 NULL,
	itemped_codigodeposito int4 NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(30) NULL,
	ped_cod_situacao_venda int4 NULL,
	itemped_qtdsugerida numeric(12, 2) NULL,
	itemped_qtdafaturar numeric(12, 2) NULL,
	itemped_qtd_faturada numeric(12, 2) NULL,
	ped_cod_natureza int4 NULL,
	itemped_cod_natureza int4 NULL,
	natureza_venda varchar(5) NULL,
	ped_desconto1 numeric(10, 2) NULL,
	ped_desconto2 numeric(10, 2) NULL,
	ped_desconto3 numeric(10, 2) NULL,
	ped_desconto_item_1 numeric(10, 2) NULL,
	ped_desconto_item_2 numeric(10, 2) NULL,
	ped_desconto_item_3 numeric(10, 2) NULL,
	ped_desconto_especial numeric(12, 2) NULL,
	ped_valor_despesas numeric(12, 2) NULL,
	itemped_vlr_franchising numeric(12, 2) NULL,
	itemped_valor_exportacao numeric(12, 2) NULL,
	itemped_valor_pedido numeric(12, 2) NULL,
	dthora_atualizacao timestamp NULL,
	canal varchar(150) NULL,
	canal_new varchar(150) NULL,
	live_dt_entr_original timestamp NULL,
	itemped_valorunitariobruto numeric(18, 3) NULL
);


-- temporario.fconfer_caixas definição

-- Drop table

-- DROP TABLE temporario.fconfer_caixas;

CREATE TABLE temporario.fconfer_caixas (
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	qtde_pecas_conferidas int4 NULL,
	ultima_atualizacao timestamp NULL,
	data_abertura timestamp NULL
);


-- temporario.fconfer_pecas_caixa definição

-- Drop table

-- DROP TABLE temporario.fconfer_pecas_caixa;

CREATE TABLE temporario.fconfer_pecas_caixa (
	tipo varchar(13) NULL,
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	codigo_barras varchar(16) NULL,
	produto varchar(65) NULL,
	data_bipagem timestamp NULL,
	data_bipagem_recebido timestamp NULL,
	situacao varchar(8) NULL,
	ultima_atualizacao timestamp NULL,
	sku varchar(80) NULL
);


-- temporario.fconsignadainteg definição

-- Drop table

-- DROP TABLE temporario.fconsignadainteg;

CREATE TABLE temporario.fconsignadainteg (
	cd_loja varchar(6) NULL,
	dt_retirada timestamp NULL,
	dt_devol timestamp NULL,
	cd_status_devol varchar(8) NULL,
	qtd_consignada int4 NULL,
	vlr_preco_venda numeric(20, 4) NULL,
	vlr_perc_desconto numeric(20, 4) NULL,
	vlr_total numeric(20, 4) NULL,
	cd_vendido varchar(8) NULL,
	dthora_atualizacao timestamp NULL,
	cd_contr int4 NULL,
	dt_prev timestamp NULL,
	pk_consignado varchar(55) NULL,
	fk_produto varchar(20) NULL,
	cd_vendedor varchar(4) NULL,
	cd_loja_vendedor varchar(4) NULL,
	ds_cargo_vendedor varchar(100) NULL,
	status_vendedor varchar(10) NULL
);


-- temporario.fconsumo_componente definição

-- Drop table

-- DROP TABLE temporario.fconsumo_componente;

CREATE TABLE temporario.fconsumo_componente (
	tecido varchar(5) NULL,
	descricao varchar(30) NULL,
	tamanho varchar(3) NULL,
	u_m varchar(2) NULL,
	pk_produto varchar(111) NULL,
	consumo numeric(21, 3) NULL,
	cod_linha_produto int2 NULL,
	cod_artigo int2 NULL,
	cod_publico_alvo int2 NULL,
	cod_estagio int4 NULL,
	pk_componente varchar(111) NULL,
	preco_informado numeric(21, 3) NULL,
	preco_ult_compra numeric(21, 3) NULL,
	preco_medio numeric(21, 3) NULL,
	situacao_comp varchar(32) NULL,
	um_componente varchar(2) NULL,
	ult_atualizacao timestamp NULL,
	composicao varchar(203) NULL,
	gramatura numeric(21, 3) NULL,
	largura numeric(21, 3) NULL,
	rendimento numeric(21, 3) NULL,
	conta_de_estoque varchar(100) NULL,
	colecao varchar(80) NULL,
	peso_rolo numeric(21, 3) NULL,
	data_cadastro timestamp NULL,
	alternativa_item int8 NULL
);
CREATE INDEX fconsumo_componente_consumo_situacao_comp_cod_estagio_pk_pr_idx ON temporario.fconsumo_componente USING btree (consumo, situacao_comp, cod_estagio, pk_produto);
CREATE INDEX fconsumo_componente_consumo_situacao_comp_descricao_coleca_idx1 ON temporario.fconsumo_componente USING btree (consumo, situacao_comp, descricao, colecao, cod_estagio, pk_componente);
CREATE INDEX fconsumo_componente_consumo_situacao_comp_descricao_colecao_idx ON temporario.fconsumo_componente USING btree (consumo, situacao_comp, descricao, colecao, cod_estagio, pk_componente);
CREATE INDEX fconsumo_componente_pk_componente_idx ON temporario.fconsumo_componente USING btree (pk_componente);


-- temporario.fdre_lojas definição

-- Drop table

-- DROP TABLE temporario.fdre_lojas;

CREATE TABLE temporario.fdre_lojas (
	pk_dre_lojas int4 NULL,
	seq_consulta varchar(80) NULL,
	cd_cnpj varchar(20) NULL,
	cd_ano_dre int4 NULL,
	cd_mes_dre int2 NULL,
	cd_tip_dre int2 NULL,
	desc_prop varchar(200) NULL,
	vlr_real_ano_ant numeric(15, 3) NULL,
	vlr_perc_real_ano_ant numeric(15, 3) NULL,
	vlr_orc numeric(15, 3) NULL,
	vlr_real numeric(15, 3) NULL,
	vlr_perc_real numeric(15, 3) NULL,
	vlr_dif_orc_real numeric(15, 3) NULL,
	vlr_perc_df_orc_real numeric(15, 3) NULL,
	vlr_df_real_vig_ant numeric(15, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fduplicatainteg definição

-- Drop table

-- DROP TABLE temporario.fduplicatainteg;

CREATE TABLE temporario.fduplicatainteg (
	documento int8 NULL,
	portal int8 NULL,
	loja varchar(20) NULL,
	cnpj_emp varchar(40) NULL,
	cod_cliente int8 NULL,
	numorcamento int8 NULL,
	codpgto varchar(10) NULL,
	forma_pgto varchar(50) NULL,
	qtde_parcelas int2 NULL,
	ordem_parcela int2 NULL,
	data_emissao timestamp NULL,
	data_vencimento timestamp NULL,
	data_baixa timestamp NULL,
	ultima_atualizacao timestamp NULL,
	identificador varchar(40) NULL,
	valor_fatura numeric(18, 3) NULL,
	valor_pago numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	valor_juros numeric(18, 3) NULL
);


-- temporario.feficiencia_prod_marft definição

-- Drop table

-- DROP TABLE temporario.feficiencia_prod_marft;

CREATE TABLE temporario.feficiencia_prod_marft (
	"DATA" timestamp NULL,
	maquina varchar(25) NULL,
	turno int2 NULL,
	min_dispo int4 NULL,
	operador int2 NULL,
	capacidade numeric(18, 3) NULL,
	minutos_trabalhado numeric(18, 3) NULL,
	minutos_produzido numeric(18, 3) NULL,
	eficiencia numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	pecas_produzidas numeric(18, 3) NULL,
	minutos_parados numeric(18, 3) NULL,
	minutos_perdidos numeric(18, 3) NULL,
	real_eficiencia numeric(18, 3) NULL,
	perc_real_efic numeric(18, 3) NULL,
	perd_eficiencia numeric(18, 3) NULL,
	perc_perd_efic numeric(18, 3) NULL,
	parada numeric(18, 3) NULL,
	perc_parada numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.fesocial definição

-- Drop table

-- DROP TABLE temporario.fesocial;

CREATE TABLE temporario.fesocial (
	fk_empresa int4 NULL,
	cd_id_eint int4 NULL,
	dt_cmphor timestamp NULL,
	vlr_dur_jor int4 NULL,
	cd_hor int4 NULL,
	cd_ini_not int4 NULL,
	cd_fim_not int4 NULL,
	cd_hor_not varchar(3) NULL,
	cd_sc int4 NULL,
	cd_hor_eso varchar(50) NULL,
	cd_hor_ent int4 NULL,
	cd_hor_sai int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.festrutura_produto definição

-- Drop table

-- DROP TABLE temporario.festrutura_produto;

CREATE TABLE temporario.festrutura_produto (
	pk_produto varchar(18) NULL,
	cod_referencia varchar(5) NULL,
	cod_componente varchar(18) NULL,
	fk_sequencia int4 NULL,
	fk_estagio int4 NULL,
	consumo numeric(18, 3) NULL,
	qtd_camadas numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.ffaixas_comissao definição

-- Drop table

-- DROP TABLE temporario.ffaixas_comissao;

CREATE TABLE temporario.ffaixas_comissao (
	tipo_info varchar(23) NULL,
	cod_loja float8 NULL,
	cargo float8 NULL,
	faixa float8 NULL,
	valor_inicio numeric(18, 3) NULL,
	valor_fim numeric(18, 3) NULL,
	percentual_inicio numeric(18, 3) NULL,
	percentual_fim numeric(18, 3) NULL,
	comissao numeric(18, 3) NULL,
	ultima_atualizao timestamp NULL
);


-- temporario.ffaixas_comissao_omnichannel definição

-- Drop table

-- DROP TABLE temporario.ffaixas_comissao_omnichannel;

CREATE TABLE temporario.ffaixas_comissao_omnichannel (
	cod_loja int4 NULL,
	faixa int2 NULL,
	comissao numeric(18, 3) NULL,
	tempo_medio int2 NULL,
	valor_atingido numeric(18, 3) NULL,
	valor_nao_atingido numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ffaturamento definição

-- Drop table

-- DROP TABLE temporario.ffaturamento;

CREATE TABLE temporario.ffaturamento (
	pk_cliente varchar(18) NULL,
	pk_produto varchar(18) NULL,
	nf_dataemissao timestamp NULL,
	nf_nrseqitempedido int2 NULL,
	data_embarque timestamp NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	tipo_nota varchar(11) NULL,
	nf_notafiscal int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_serienotafiscal varchar(4) NULL,
	nf_cdrep float8 NULL,
	ultima_atualizacao timestamp NULL,
	nf_origem int8 NULL,
	nf_tipo_1dev_0ven int2 NULL,
	nf_cdempresa float8 NULL,
	nf_condpgto int2 NULL,
	nf_cdcancelamento int2 NULL,
	cfop varchar(44) NULL,
	cod_devolucao numeric(40) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrfat numeric(18, 3) NULL,
	itemnf_vlrrateio numeric(18, 3) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	itemnf_pesoliquido numeric(18, 3) NULL,
	nf_cod_situacao int2 NULL,
	nf_desc_situacao varchar(11) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_vlr_contabil numeric(18, 3) NULL,
	data_transacao timestamp NULL,
	itemnf_qtdfaturada numeric(18, 3) NULL,
	nf_cod_natureza int8 NULL,
	itemnf_cod_natureza int8 NULL,
	natureza_venda varchar(3) NULL,
	codigo_deposito int8 NULL,
	cod_funcionario numeric(18, 3) NULL,
	vlr_desc_especial numeric(18, 3) NULL,
	itemnf_vlr_franchising numeric(21, 3) NULL,
	ped_vlr_desc_especial numeric(18, 3) NULL,
	pk_loja varchar(25) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX ffaturamento_nf_dataemissao_tipo_nota_nf_cdempresa_pk_clien_idx ON temporario.ffaturamento USING btree (nf_dataemissao, tipo_nota, nf_cdempresa, pk_cliente, nf_desc_situacao);
CREATE INDEX ffaturamento_nf_notafiscal_nf_serienotafiscal_idx ON temporario.ffaturamento USING btree (nf_notafiscal, nf_serienotafiscal);
CREATE INDEX ffaturamento_nf_nrpedidovenda_idx ON temporario.ffaturamento USING btree (nf_nrpedidovenda);


-- temporario.ffaturamento_dev definição

-- Drop table

-- DROP TABLE temporario.ffaturamento_dev;

CREATE TABLE temporario.ffaturamento_dev (
	pk_cliente varchar(17) NULL,
	pk_produto varchar(20) NULL,
	cd_barra varchar(18) NULL,
	nf_cdrep int4 NULL,
	nf_cdempresa int4 NULL,
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(3) NULL,
	nf_dataemissao varchar(10) NULL,
	nf_dtemissao timestamp NULL,
	nf_datadigitacao timestamp NULL,
	nf_condpgto int4 NULL,
	nf_cdcancelamento int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_nrseqitempedido int4 NULL,
	nf_origem int4 NULL,
	nf_tipo_1dev_0ven int4 NULL,
	nf_cod_situacao int4 NULL,
	nf_cod_natureza int4 NULL,
	itemnf_cod_natureza int4 NULL,
	natureza_venda varchar(5) NULL,
	nf_desc_situacao varchar(12) NULL,
	data_embarque timestamp NULL,
	cod_funcionario int4 NULL,
	cfop varchar(12) NULL,
	desc_nat_oper varchar(50) NULL,
	uf varchar(5) NULL,
	cod_devolucao varchar(50) NULL,
	mot_devolucao varchar(40) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_qtdfaturada numeric(8, 2) NULL,
	itemnf_vlrunit numeric(10, 2) NULL,
	itemnf_vlrfat numeric(10, 2) NULL,
	itemnf_vlr_contabil numeric(10, 2) NULL,
	itemnf_vlrrateio numeric(12, 2) NULL,
	itemnf_vlr_tot numeric(12, 2) NULL,
	valor_desconto numeric(12, 2) NULL,
	itemnf_vlripi numeric(12, 2) NULL,
	itemnf_vlricms numeric(12, 2) NULL,
	itemnf_vlricmsdiferido numeric(12, 2) NULL,
	itemnf_vlrpis numeric(12, 2) NULL,
	itemnf_vlrcofins numeric(12, 2) NULL,
	itemnf_pesoliquido numeric(12, 2) NULL,
	itemnf_vlr_franchising numeric(12, 2) NULL,
	perc_desc_fran numeric(12, 2) NULL,
	tipo_nota varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	data_transacao varchar(15) NULL,
	codigo_deposito numeric(12, 2) NULL,
	canal varchar(100) NULL,
	modalidade varchar(50) NULL,
	live_dt_entr_original timestamp NULL
);
CREATE INDEX ffaturamento_dev_tipo_nota_idx ON temporario.ffaturamento_dev USING btree (tipo_nota);


-- temporario.ffaturamento_eua definição

-- Drop table

-- DROP TABLE temporario.ffaturamento_eua;

CREATE TABLE temporario.ffaturamento_eua (
	mes varchar(6) NULL,
	loja varchar(20) NULL,
	"SUM(DADOS.QUANTIDADE)" int8 NULL,
	ano varchar(5) NULL,
	ultima_atualizacao timestamp NULL,
	mes_ano varchar(20) NULL,
	"SUM(DADOS.VALORDOLAR)" numeric(12, 2) NULL,
	"SUM(DADOS.VALORREAL)" numeric(12, 2) NULL
);


-- temporario.ffaturamento_internacional definição

-- Drop table

-- DROP TABLE temporario.ffaturamento_internacional;

CREATE TABLE temporario.ffaturamento_internacional (
	pk_loja_internacional int4 NULL,
	qtd_faturado int2 NULL,
	tickets int2 NULL,
	dthora_atualizacao timestamp NULL,
	desc_loja varchar(40) NULL,
	valor_dolar numeric(18, 3) NULL,
	valor_real numeric(18, 3) NULL,
	data_fat timestamp NULL
);


-- temporario.ffaturamento_nacional definição

-- Drop table

-- DROP TABLE temporario.ffaturamento_nacional;

CREATE TABLE temporario.ffaturamento_nacional (
	tipo_faturamento varchar(20) NULL,
	exercicio int4 NULL,
	data_lancto timestamp NULL,
	cod_empresa int4 NULL,
	desc_empresa varchar(50) NULL,
	conta_contabil varchar(25) NULL,
	conta_reduzida int4 NULL,
	chave int4 NULL,
	seqchave int4 NULL,
	complemento_historico varchar(100) NULL,
	desc_plano_conta varchar(60) NULL,
	ultima_atualizacao timestamp NULL,
	canal_distr varchar(16) NULL,
	credito numeric(12, 2) NULL
);


-- temporario.fhistorico definição

-- Drop table

-- DROP TABLE temporario.fhistorico;

CREATE TABLE temporario.fhistorico (
	fk_cargo varchar(65) NULL,
	fk_filial varchar(81) NULL,
	fk_situacao int2 NULL,
	fk_empresa int4 NULL,
	dt_alt timestamp NULL,
	dt_adm timestamp NULL,
	fk_local int8 NULL,
	vlr_sal numeric(17, 4) NULL,
	fk_colaborador varchar(130) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.financeiro_dconsulta_nfs definição

-- Drop table

-- DROP TABLE temporario.financeiro_dconsulta_nfs;

CREATE TABLE temporario.financeiro_dconsulta_nfs (
	num_nota_fiscal varchar(50) NULL,
	serie_nota_fisc varchar(20) NULL,
	especie_docto varchar(20) NULL,
	data_base_fatur date NULL,
	data_saida date NULL,
	data_prevista date NULL,
	cod_rep_cliente varchar(50) NULL,
	pedido_venda varchar(50) NULL,
	usuario_digitacao varchar(100) NULL,
	valor_itens_nfis numeric(15, 2) NULL,
	valor_desconto numeric(15, 2) NULL,
	situacao_nfisc varchar(20) NULL
);


-- temporario.financeiro_dlancamentos_contabeis definição

-- Drop table

-- DROP TABLE temporario.financeiro_dlancamentos_contabeis;

CREATE TABLE temporario.financeiro_dlancamentos_contabeis (
	exercicio numeric(4) NULL,
	data_lancto timestamp NULL,
	cod_empresa numeric(3) NULL,
	desc_empresa text NULL,
	conta_contabil text NULL,
	conta_reduzida numeric(5) NULL,
	centro_custo numeric(6) NULL,
	desc_ccusto text NULL,
	chave numeric(9) NULL,
	seqchave numeric(5) NULL,
	cod_contabil numeric(4) NULL,
	desc_historico text NULL,
	complemento_historico text NULL,
	debito numeric(38, 10) NULL,
	credito numeric(38, 10) NULL,
	desc_plano_conta text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.financeiro_fapuracao_notas_entrada definição

-- Drop table

-- DROP TABLE temporario.financeiro_fapuracao_notas_entrada;

CREATE TABLE temporario.financeiro_fapuracao_notas_entrada (
	codigo_empresa numeric(3) NULL,
	data_transacao timestamp NULL,
	codificacao_contabil numeric(38, 10) NULL,
	classificacao_fiscal text NULL,
	documento numeric(9) NULL,
	serie text NULL,
	cgc_cli_for_9 numeric(9) NULL,
	cgc_cli_for_4 numeric(4) NULL,
	cgc_cli_for_2 numeric(2) NULL,
	data_emissao timestamp NULL,
	tipo_valores_fiscal text NULL,
	situacao_entrada numeric(1) NULL,
	rateio_despesas numeric(15, 2) NULL,
	classif_contabil numeric(6) NULL,
	cod_natureza text NULL,
	descr_nat_oper text NULL,
	livros_fiscais numeric(1) NULL,
	divisao_natur numeric(2) NULL,
	natur_operacao numeric(3) NULL,
	estado_natoper text NULL,
	cod_vlfiscal_icm numeric(9) NULL,
	cod_vlfiscal_ipi numeric(9) NULL,
	base_diferenca numeric(15, 2) NULL,
	base_ipi numeric(15, 2) NULL,
	base_pis_cofins numeric(15, 2) NULL,
	base_icms_subs numeric(14, 2) NULL,
	base_icms numeric(15, 2) NULL,
	base_calc_icm numeric(15, 2) NULL,
	valor_total_ipi numeric(15, 2) NULL,
	valor_despesas numeric(15, 2) NULL,
	valor_frete numeric(15, 2) NULL,
	valor_desconto numeric(15, 2) NULL,
	valor_seguro numeric(15, 2) NULL,
	valor_ipi numeric(15, 2) NULL,
	valor_pis numeric(15, 2) NULL,
	valor_cofins numeric(15, 2) NULL,
	valor_icms numeric(15, 2) NULL,
	valor_total numeric(15, 2) NULL,
	valor_itens numeric(15, 2) NULL,
	desconta_ipi_icms numeric(15, 2) NULL
);


-- temporario.financeiro_fapuracao_notas_saida definição

-- Drop table

-- DROP TABLE temporario.financeiro_fapuracao_notas_saida;

CREATE TABLE temporario.financeiro_fapuracao_notas_saida (
	codigo_empresa numeric(3) NULL,
	codificacao_contabil numeric(6) NULL,
	classificacao_fiscal text NULL,
	num_nota_fiscal numeric(9) NULL,
	serie_nota_fisc text NULL,
	data_emissao timestamp NULL,
	situacao_nfisc numeric(1) NULL,
	cgc_9 numeric(9) NULL,
	cgc_4 numeric(4) NULL,
	cgc_2 numeric(2) NULL,
	tipo_nf_referenciada numeric(1) NULL,
	classif_contabil_nf_item numeric(6) NULL,
	desconta_ipi_icms numeric(1) NULL,
	classif_contabil numeric(6) NULL,
	cod_natureza text NULL,
	descr_nat_oper text NULL,
	livros_fiscais numeric(1) NULL,
	divisao_natur numeric(2) NULL,
	classific_fiscal text NULL,
	natopeno_nat_oper numeric(3) NULL,
	natopeno_est_oper text NULL,
	consiste_cvf_icms numeric(1) NULL,
	rateio_despesa numeric(15, 2) NULL,
	rateio_desc_propaganda numeric(15, 2) NULL,
	isento_outros numeric(15, 2) NULL,
	cod_justificativa numeric(1) NULL,
	cvf_icms numeric(2) NULL,
	cvf_ipi numeric(1) NULL,
	cvf_icm_diferenc numeric(9) NULL,
	base_icms numeric(15, 2) NULL,
	base_icms_difer numeric(15, 2) NULL,
	basi_pis_cofins numeric(15, 2) NULL,
	perc_icms numeric(6, 2) NULL,
	perc_ipi numeric(6, 2) NULL,
	perc_reducao_icm numeric(8, 4) NULL,
	perc_substituica numeric(5, 2) NULL,
	perc_iva_1 numeric(6, 2) NULL,
	valor_icms_difer numeric(11, 2) NULL,
	valor_ipi numeric(15, 2) NULL,
	valor_pis numeric(15, 2) NULL,
	valor_icms numeric(15, 2) NULL,
	valor_cofins numeric(15, 2) NULL,
	valor_faturado numeric(15, 2) NULL,
	valor_contabil numeric(15, 2) NULL,
	valor_unitario numeric(18, 5) NULL,
	qtde_item_fatur numeric(15, 3) NULL
);


-- temporario.financeiro_forion_orcamento definição

-- Drop table

-- DROP TABLE temporario.financeiro_forion_orcamento;

CREATE TABLE temporario.financeiro_forion_orcamento (
	id numeric(6) NULL,
	centro_custo text NULL,
	plano_ano numeric(38) NULL,
	conta text NULL,
	fornecedor text NULL,
	despesa text NULL,
	tipo_orcamento text NULL,
	cargo text NULL,
	ano numeric(4) NULL,
	mes numeric(38, 10) NULL,
	mes_ano timestamp NULL,
	quantidade numeric(3) NULL,
	valor_orcado numeric(10, 2) NULL
);


-- temporario.financeiro_ftitulos_receber_resumo definição

-- Drop table

-- DROP TABLE temporario.financeiro_ftitulos_receber_resumo;

CREATE TABLE temporario.financeiro_ftitulos_receber_resumo (
	num_titulo text NULL,
	cnpj_cliente text NULL,
	pk_cliente text NULL,
	nome_cliente text NULL,
	descricao text NULL,
	cod_situa_duplic numeric(1) NULL,
	val_desconto numeric(15, 2) NULL,
	val_pago numeric(38, 10) NULL,
	dat_ult_pagto_aux timestamp NULL
);


-- temporario.finformacoes_coleta definição

-- Drop table

-- DROP TABLE temporario.finformacoes_coleta;

CREATE TABLE temporario.finformacoes_coleta (
	fk_produto varchar(18) NULL,
	cod_usuario varchar(5) NULL,
	volume varchar(9) NULL,
	dt_montagem timestamp NULL,
	turno int2 NULL,
	situacao_volume int2 NULL,
	solicitacao_volume varchar(6) NULL,
	tipo_volume varchar(6) NULL,
	cod_empresa varchar(3) NULL,
	nota_fiscal varchar(9) NULL,
	ordem_confeccao varchar(5) NULL,
	periodo_ordem varchar(4) NULL,
	qtd_pecas_real int4 NULL,
	sequencia_item varchar(3) NULL,
	estoque_tag varchar(1) NULL,
	deposito varchar(3) NULL,
	data_tag timestamp NULL,
	qtd_pc_coletada int8 NULL,
	qtd_pc_mont_volume int4 NULL,
	qtd_pc_diferenca int4 NULL,
	qtd_pc_conf_volume int4 NULL,
	qtd_pc_fora_volume int4 NULL,
	observacao_volume varchar(100) NULL,
	peso_volume numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	fk_pedido int4 NULL
);


-- temporario.flancamento_contabil definição

-- Drop table

-- DROP TABLE temporario.flancamento_contabil;

CREATE TABLE temporario.flancamento_contabil (
	pk_contabil varchar(30) NULL,
	cd_empresa numeric(3) NULL,
	exercicio numeric(4) NULL,
	cd_lancamento numeric(9) NULL,
	seq_lancamento numeric(5) NULL,
	cd_origem numeric(2) NULL,
	cd_lote numeric(5) NULL,
	periodo numeric(4) NULL,
	cd_conta_contabil varchar(20) NULL,
	cd_conta_reduzida numeric(5) NULL,
	cd_centro_custo numeric(6) NULL,
	forma_pgto varchar(7) NULL,
	fk_historico numeric(4) NULL,
	fk_cliente varchar(17) NULL,
	data_lancamento timestamp NULL,
	vlr_lancamento numeric(15, 2) NULL,
	contabilizado numeric(3) NULL,
	data_contabil timestamp NULL,
	desc_usuario varchar(100) NULL,
	cd_banco numeric(3) NULL,
	cd_conta_corrente numeric(9) NULL,
	data_controle timestamp NULL,
	cd_documento numeric(9) NULL,
	data_insercao timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.flog_alteracoes_ponto definição

-- Drop table

-- DROP TABLE temporario.flog_alteracoes_ponto;

CREATE TABLE temporario.flog_alteracoes_ponto (
	dt_apuracao timestamp NULL,
	cd_num_fun int8 NULL,
	cd_nom_fun varchar(50) NULL,
	cd_usu int8 NULL,
	cd_nom_usu varchar(255) NULL,
	cd_num_ajuste int8 NULL,
	cd_nom_ajuste varchar(50) NULL,
	descr_msg_log varchar(500) NULL,
	dthora_atualizacao timestamp NULL,
	fk_colaborador varchar(150) NULL,
	fk_usuario_antigo int8 NULL
);


-- temporario.flog_itens_transfer definição

-- Drop table

-- DROP TABLE temporario.flog_itens_transfer;

CREATE TABLE temporario.flog_itens_transfer (
	cd_pedido int4 NULL,
	cd_pedido_cliente varchar(60) NULL,
	seq_item_pedido int4 NULL,
	cd_item_trans varchar(60) NULL,
	cd_destino_venda int4 NULL,
	cd_destino_cliente varchar(60) NULL,
	seq_item_destino int4 NULL,
	qtd_transferida numeric(18, 3) NULL,
	controle int2 NULL,
	dt_hora_insercao timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.flogpedidos definição

-- Drop table

-- DROP TABLE temporario.flogpedidos;

CREATE TABLE temporario.flogpedidos (
	cd_pedido int4 NULL,
	data_alteracao timestamp NULL,
	usuario_alteracao varchar(60) NULL,
	data_embarque_old timestamp NULL,
	data_embarque_new timestamp NULL,
	dthora_atualizacao timestamp NULL,
	qtd_total_old numeric(18, 3) NULL,
	qtd_total_new numeric(18, 3) NULL,
	desconto1_old numeric(18, 3) NULL,
	desconto1_new numeric(18, 3) NULL,
	desconto2_old numeric(18, 3) NULL,
	desconto2_new numeric(18, 3) NULL,
	desconto3_old numeric(18, 3) NULL,
	desconto3_new numeric(18, 3) NULL,
	vlr_liq_itens_old numeric(18, 3) NULL,
	vlr_liq_itens_new numeric(18, 3) NULL,
	vlr_liq_pedido_old numeric(18, 3) NULL,
	vlr_liq_pedido_new numeric(18, 3) NULL
);


-- temporario.fmarcacao_horario definição

-- Drop table

-- DROP TABLE temporario.fmarcacao_horario;

CREATE TABLE temporario.fmarcacao_horario (
	cd_hor int4 NULL,
	seq_mar int2 NULL,
	cd_usobat int2 NULL,
	vlr_horbat int4 NULL,
	cd_faimov int4 NULL,
	dthora_atualizacao timestamp NULL,
	vlr_tolant int4 NULL,
	vlr_tolapo int4 NULL
);


-- temporario.fmeta_diario_loja definição

-- Drop table

-- DROP TABLE temporario.fmeta_diario_loja;

CREATE TABLE temporario.fmeta_diario_loja (
	pk_meta_dia varchar(20) NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	dia int2 NULL,
	mes_ano varchar(81) NULL,
	qtd_meta int4 NULL,
	valor_meta numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL,
	dt_meta timestamp NULL
);


-- temporario.fmeta_loja definição

-- Drop table

-- DROP TABLE temporario.fmeta_loja;

CREATE TABLE temporario.fmeta_loja (
	pk_id_meta varchar(35) NULL,
	cd_loja int8 NULL,
	ano int8 NULL,
	mes int4 NULL,
	mes_ano varchar(86) NULL,
	qtd_meta int8 NULL,
	dthora_atualizacao timestamp NULL,
	vlr_meta numeric(17, 2) NULL
);


-- temporario.fmeta_mensal_loja definição

-- Drop table

-- DROP TABLE temporario.fmeta_mensal_loja;

CREATE TABLE temporario.fmeta_mensal_loja (
	mes_ano varchar(8) NULL,
	pk_meta_mes varchar(20) NULL,
	dthora_atualizacao timestamp NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	qtd_meta int4 NULL,
	valor_meta numeric(18, 3) NULL
);


-- temporario.fmeta_semanal_loja definição

-- Drop table

-- DROP TABLE temporario.fmeta_semanal_loja;

CREATE TABLE temporario.fmeta_semanal_loja (
	pk_meta_dia varchar(20) NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	mes_ano varchar(20) NULL,
	valor_meta numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL,
	dt_meta timestamp NULL,
	dt_inicio timestamp NULL,
	dt_fim timestamp NULL,
	semana int2 NULL
);


-- temporario.fmetasestacoes definição

-- Drop table

-- DROP TABLE temporario.fmetasestacoes;

CREATE TABLE temporario.fmetasestacoes (
	cod_estacao varchar(9) NULL,
	descricao_estacao varchar(150) NULL,
	cod_representante varchar(6) NULL,
	descricao_rep varchar(100) NULL,
	tipo_meta varchar(3) NULL,
	mes varchar(2) NULL,
	ano varchar(4) NULL,
	cod_agrupador varchar(9) NULL,
	descricao varchar(50) NULL,
	colecao varchar(3) NULL,
	ultima_atualizacao timestamp NULL,
	valor_meta numeric(18, 3) NULL,
	perc_distribuicao numeric(18, 3) NULL,
	calc_meta numeric(18, 3) NULL
);


-- temporario.fmetasorcamento definição

-- Drop table

-- DROP TABLE temporario.fmetasorcamento;

CREATE TABLE temporario.fmetasorcamento (
	tipo_meta varchar(1) NULL,
	desc_meta varchar(50) NULL,
	modalidade varchar(50) NULL,
	ano varchar(4) NULL,
	mes_venda varchar(9) NULL,
	ultima_atualizacao timestamp NULL,
	total numeric(18, 3) NULL,
	mes_ano varchar(15) NULL
);


-- temporario.fmonitor_producao definição

-- Drop table

-- DROP TABLE temporario.fmonitor_producao;

CREATE TABLE temporario.fmonitor_producao (
	cod_operador int2 NULL,
	nome_operador varchar(40) NULL,
	min_trab numeric(18, 3) NULL,
	min_prod numeric(18, 3) NULL,
	efic numeric(18, 3) NULL,
	status varchar(7) NULL,
	celula_destino varchar(25) NULL,
	celula_origem varchar(25) NULL
);


-- temporario.fmovimentacoesestoque definição

-- Drop table

-- DROP TABLE temporario.fmovimentacoesestoque;

CREATE TABLE temporario.fmovimentacoesestoque (
	cd_deposito numeric(3) NULL,
	cd_nivel_estrutura numeric(38, 10) NULL,
	fk_produto text NULL,
	codigo_transacao numeric(3) NULL,
	dt_movimentacao timestamp NULL,
	tipo_movimento text NULL,
	qtd_movimento numeric(12, 3) NULL,
	qtd_saldo_fisico numeric(15, 5) NULL,
	vlr_movimento_unitario numeric(18, 5) NULL,
	vlr_saldo_financeiro numeric(18, 5) NULL,
	flag_periodo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.fmovimentos_unificado definição

-- Drop table

-- DROP TABLE temporario.fmovimentos_unificado;

CREATE TABLE temporario.fmovimentos_unificado (
	portal int8 NULL,
	identificador varchar(40) NULL,
	numnf int8 NULL,
	serie varchar(15) NULL,
	id_cfop varchar(20) NULL,
	codigo_vendedor varchar(20) NULL,
	operacao varchar(20) NULL,
	flag_loja varchar(8) NULL,
	cnpj varchar(20) NULL,
	loja varchar(40) NULL,
	cod_transacao varchar(40) NULL,
	fk_produto varchar(40) NULL,
	codigo_cliente numeric(18, 3) NULL,
	qtd_tickets numeric(18, 3) NULL,
	qtd_movimento numeric(18, 3) NULL,
	qtd_pecas_pedido numeric(18, 3) NULL,
	qtd_pecas_devolucao numeric(18, 3) NULL,
	qtd_pecas_vendidas numeric(18, 3) NULL,
	pa numeric(18, 3) NULL,
	vlr_liquido numeric(18, 3) NULL,
	vlr_pedido numeric(18, 3) NULL,
	vlr_devolucao numeric(18, 3) NULL,
	data_lancamento varchar(30) NULL
);


-- temporario.fmovimentosinteg_stage definição

-- Drop table

-- DROP TABLE temporario.fmovimentosinteg_stage;

CREATE TABLE temporario.fmovimentosinteg_stage (
	portal int8 NULL,
	identificador varchar(40) NULL,
	loja varchar(8) NULL,
	fk_cliente varchar(40) NULL,
	cnpj_emp varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	fk_produto varchar(25) NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(3) NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	cnpj varchar(40) NULL,
	valor_bruto int8 NULL,
	cor varchar(6) NULL,
	tamanho varchar(5) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	descricao varchar(200) NULL,
	rede varchar(100) NULL,
	canal_distribuicao varchar(14) NULL,
	flag_movimentacao varchar(20) NULL,
	cst_icms varchar(15) NULL,
	cst_ipi varchar(15) NULL,
	cst_cofins varchar(15) NULL,
	cst_pis varchar(15) NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	qtde numeric(18, 3) NULL,
	data_lancamento timestamp NULL,
	datcancel timestamp NULL,
	cod_barra varchar(20) NULL
);


-- temporario.fnotas_entrada_loja definição

-- Drop table

-- DROP TABLE temporario.fnotas_entrada_loja;

CREATE TABLE temporario.fnotas_entrada_loja (
	empresa int2 NULL,
	nota_fiscal int4 NULL,
	serie varchar(3) NULL,
	data_emissao timestamp NULL,
	cnpj varchar(20) NULL,
	qtd_volume int2 NULL,
	pedido varchar(20) NULL,
	data_entrega timestamp NULL,
	cfop varchar(44) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.foperacao definição

-- Drop table

-- DROP TABLE temporario.foperacao;

CREATE TABLE temporario.foperacao (
	fk_operacao int4 NULL,
	fk_maquina varchar(8) NULL,
	tipo_operacao int2 NULL,
	pede_produto int2 NULL,
	fk_cargo int4 NULL,
	fk_aparelho varchar(6) NULL,
	operando int2 NULL,
	dthora_atualizacao timestamp NULL,
	tempo_maquina numeric(18, 3) NULL,
	tempo_homem numeric(18, 3) NULL,
	centimetros_linha numeric(18, 3) NULL
);


-- temporario.fordens_corte_hist definição

-- Drop table

-- DROP TABLE temporario.fordens_corte_hist;

CREATE TABLE temporario.fordens_corte_hist (
	id varchar(25) NULL
);


-- temporario.fordens_corte_stage definição

-- Drop table

-- DROP TABLE temporario.fordens_corte_stage;

CREATE TABLE temporario.fordens_corte_stage (
	cd_ordem_producao int4 NULL,
	cd_nivel99 int2 NULL,
	cd_grupo varchar(5) NULL,
	cd_subgrupo varchar(3) NULL,
	prod_rej_item varchar(6) NULL,
	cd_estagio int2 NULL,
	periodo_producao int2 NULL,
	cd_ordem_confeccao int4 NULL,
	qtd_pecas_progamada numeric(18, 3) NULL,
	qtd_pecas_produzida numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_pecas_2a numeric(18, 3) NULL,
	estagio_anterior int2 NULL,
	situacao_ordem int2 NULL,
	numero_ordem_externa int4 NULL,
	seq_ordem_serv int4 NULL,
	qtd_perdas numeric(18, 3) NULL,
	sequencia_estagio int4 NULL,
	usuario varchar(150) NULL,
	seq_operacao int4 NULL,
	data_alteracao timestamp NULL,
	qtd_em_producao_pacote numeric(18, 3) NULL,
	minutos_total numeric(18, 3) NULL,
	tamanho varchar(3) NULL,
	sequencia_tamanho int2 NULL,
	qtd_marcacoes numeric(6, 1) NULL,
	fk_produto varchar(18) NULL,
	data_producao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	rowid varchar(25) NULL,
	fk_fornecedor varchar(18) NULL,
	dt_lancamento timestamp NULL,
	dt_prevista timestamp NULL,
	minutos_unitario numeric(18, 3) NULL,
	minutos_total_em_producao numeric(18, 3) NULL,
	qtd_a_produzir int8 NULL,
	prioridade int4 NULL,
	data_programacao timestamp NULL
);


-- temporario.fordens_produzidas definição

-- Drop table

-- DROP TABLE temporario.fordens_produzidas;

CREATE TABLE temporario.fordens_produzidas (
	cd_nivel99 varchar(1) NULL,
	cd_grupo varchar(5) NULL,
	cd_subgrupo varchar(3) NULL,
	cd_item varchar(6) NULL,
	data_producao timestamp NULL,
	periodo_producao int2 NULL,
	cd_estagio int4 NULL,
	des_estagio varchar(20) NULL,
	turno varchar(32) NULL,
	cd_ordem_producao int4 NULL,
	cd_ordem_confeccao int4 NULL,
	nome_fornecedor varchar(40) NULL,
	des_familia varchar(40) NULL,
	ultima_atualizacao timestamp NULL,
	qtd_produzidas numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL,
	qtd_segunda numeric(18, 3) NULL,
	tempo_unit numeric(18, 3) NULL,
	tempo_costura numeric(18, 3) NULL,
	qtde_estampas numeric(18, 3) NULL,
	data_entrada_estagio timestamp NULL
);
CREATE INDEX fordens_produzidas_cd_estagio_data_producao_periodo_produca_idx ON temporario.fordens_produzidas USING btree (cd_estagio, data_producao, periodo_producao, qtd_produzidas);
CREATE INDEX fordens_produzidas_data_producao_idx ON temporario.fordens_produzidas USING btree (data_producao);


-- temporario.fpagar definição

-- Drop table

-- DROP TABLE temporario.fpagar;

CREATE TABLE temporario.fpagar (
	cd_duplicata int8 NULL,
	cd_parcela varchar(5) NULL,
	sequencia_pagamento int2 NULL,
	cd_tipo_titulo int2 NULL,
	cd_empresa int4 NULL,
	documento int8 NULL,
	cd_serie varchar(5) NULL,
	cd_contabil int8 NULL,
	nr_contabil int8 NULL,
	cd_transacao int4 NULL,
	situacao numeric(31) NULL,
	data_contrato timestamp NULL,
	data_vencimento timestamp NULL,
	data_pagamento timestamp NULL,
	data_baixa timestamp NULL,
	fk_cliente varchar(20) NULL,
	fk_portador int4 NULL,
	fk_departamento int8 NULL,
	fk_historico int8 NULL,
	vlr_parcela numeric(18, 3) NULL,
	vlr_pago numeric(18, 3) NULL,
	vlr_restante numeric(18, 3) NULL,
	vlr_irrf numeric(18, 3) NULL,
	vlr_abatimento numeric(18, 3) NULL,
	vlr_inss numeric(18, 3) NULL,
	vlr_inss_imposto numeric(18, 3) NULL,
	vlr_cofins numeric(18, 3) NULL,
	vlr_cls numeric(18, 3) NULL,
	vlr_pis numeric(18, 3) NULL,
	vlr_juros numeric(18, 3) NULL,
	vlr_desconto numeric(18, 3) NULL,
	desc_emitente_titulo varchar(40) NULL,
	data_transacao timestamp NULL,
	desc_origem_debito varchar(60) NULL,
	data_cancelamento timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fpedido definição

-- Drop table

-- DROP TABLE temporario.fpedido;

CREATE TABLE temporario.fpedido (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX fpedido_fk_produto_ped_cdpedido_idx ON temporario.fpedido USING btree (fk_produto, ped_cdpedido);
CREATE INDEX fpedido_ped_cdpedido_idx ON temporario.fpedido USING btree (ped_cdpedido);
CREATE INDEX fpedido_ped_pedidoorigem_ped_dataembarque_idx ON temporario.fpedido USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.fpedidos_url definição

-- Drop table

-- DROP TABLE temporario.fpedidos_url;

CREATE TABLE temporario.fpedidos_url (
	"data" varchar(20) NULL,
	hora varchar(10) NULL,
	id_pedido int8 NULL,
	cliente varchar(150) NULL,
	id_vendedor int8 NULL,
	cpf_vendedor varchar(20) NULL,
	grupo_vendedor varchar(50) NULL,
	cnpj varchar(20) NULL,
	url_loja varchar(100) NULL,
	numero_nf varchar(20) NULL,
	serie_nf varchar(10) NULL,
	omnichannel varchar(10) NULL,
	ultima_atualizacao timestamp NULL,
	tipo varchar(30) NULL,
	cupom varchar(40) NULL,
	desconto_cupom varchar(40) NULL,
	codigo_vendedor varchar(40) NULL,
	desconto_vendedor varchar(40) NULL,
	status varchar(80) NULL,
	total_liquido numeric(18, 3) NULL,
	total_desconto numeric(18, 3) NULL,
	total_bruto numeric(18, 3) NULL,
	pagamento varchar(80) NULL,
	vendedor varchar(80) NULL
);


-- temporario.fpedidosintegracao definição

-- Drop table

-- DROP TABLE temporario.fpedidosintegracao;

CREATE TABLE temporario.fpedidosintegracao (
	codigo_registro int4 NULL,
	cod_pedido_venda int4 NULL,
	tecido_peca int2 NULL,
	fk_cliente int8 NULL,
	fk_representante int4 NULL,
	pedido_cliente varchar(30) NULL,
	tabela_preco int4 NULL,
	situacao_importacao int2 NULL,
	data_importacao timestamp NULL,
	data_emissao timestamp NULL,
	data_digitacao timestamp NULL,
	fk_produto varchar(18) NULL,
	cod_deposito int2 NULL,
	seq_item_pedido int2 NULL,
	sit_importacao_item int2 NULL,
	dthora_atualizacao timestamp NULL,
	tipo_pedido int4 NULL,
	origem_pedido int4 NULL,
	id_pedido_forca_vendas varchar(100) NULL,
	qtd_pedida numeric(18, 3) NULL,
	valor_unitario numeric(18, 3) NULL,
	percentual_desc_item numeric(18, 3) NULL
);


-- temporario.fportal_lojas definição

-- Drop table

-- DROP TABLE temporario.fportal_lojas;

CREATE TABLE temporario.fportal_lojas (
	cn_id int8 NULL,
	cn_num_nota_fiscal int4 NULL,
	cn_inicio_conferencia_volumes timestamp NULL,
	cn_ultima_leitura_volumes timestamp NULL,
	cn_ultima_leitura_tags timestamp NULL,
	cn_status_volumes int2 NULL,
	cn_desc_status_volumes varchar(14) NULL,
	tcv_id int8 NULL,
	tcv_numero_volume int4 NULL,
	tcv_inicio_conferencia timestamp NULL,
	tcv_ultima_leitura timestamp NULL,
	tcv_status_pecas int2 NULL,
	tcv_desc_status_pecas varchar(14) NULL,
	ct_id int8 NULL,
	ct_data_bip timestamp NULL,
	ct_usuario varchar(55) NULL,
	ct_status int2 NULL,
	ct_pk_produto varchar(18) NULL,
	ct_desc_status varchar(14) NULL,
	cv_id int8 NULL,
	cv_data_bip timestamp NULL,
	cv_status int2 NULL,
	cv_desc_status varchar(14) NULL,
	ra_id int8 NULL,
	ra_cnpj varchar(17) NULL,
	ra_usuario_bipou varchar(55) NULL,
	ra_nome_usuario varchar(55) NULL,
	ra_tipo int2 NULL,
	ra_status int2 NULL,
	ra_codigo_bipado varchar(100) NULL,
	ra_acao varchar(2500) NULL,
	ra_data_bipagem timestamp NULL,
	ra_codigo_empresa int2 NULL,
	ra_serie_nota_fisc varchar(3) NULL,
	ra_desc_status varchar(14) NULL,
	usu_id int8 NULL,
	usu_nome varchar(55) NULL,
	usu_usuario varchar(55) NULL,
	usu_situacao int2 NULL,
	usu_cnpj varchar(18) NULL,
	ct_numero_tag varchar(60) NULL,
	tcv_tags_conferidas numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fprod_marft definição

-- Drop table

-- DROP TABLE temporario.fprod_marft;

CREATE TABLE temporario.fprod_marft (
	op int4 NULL,
	os int4 NULL,
	tip_prod int2 NULL,
	hora timestamp NULL,
	seq int2 NULL,
	desc_prod varchar(50) NULL,
	referencia varchar(50) NULL,
	produto varchar(150) NULL,
	operacao varchar(80) NULL,
	operationcode varchar(20) NULL,
	tecido varchar(90) NULL,
	grupo varchar(70) NULL,
	"S.U." varchar(20) NULL,
	camada int2 NULL,
	tempo_total numeric(18, 3) NULL,
	tempo_peca numeric(18, 3) NULL,
	carga numeric(18, 3) NULL,
	oper int8 NULL,
	operador varchar(150) NULL,
	ultima_atualizacao timestamp NULL,
	"Data" timestamp NULL,
	temp_prep numeric(18, 3) NULL,
	temp_conclus numeric(18, 3) NULL,
	comp_total numeric(18, 3) NULL,
	tempo_tot_camada numeric(18, 3) NULL,
	tempo_camada numeric(18, 3) NULL,
	qtd_emenda numeric(18, 3) NULL,
	temp_emend numeric(18, 3) NULL,
	qtd_ton numeric(18, 3) NULL,
	tempo_ton numeric(18, 3) NULL,
	qtd_troca numeric(18, 3) NULL,
	tempo_troca_rolo numeric(18, 3) NULL
);


-- temporario.fprod_oper_marft definição

-- Drop table

-- DROP TABLE temporario.fprod_oper_marft;

CREATE TABLE temporario.fprod_oper_marft (
	op int4 NULL,
	os int4 NULL,
	seq int2 NULL,
	caixa varchar(1) NULL,
	grupo varchar(50) NULL,
	hora timestamp NULL,
	cod_oper varchar(10) NULL,
	operacao varchar(60) NULL,
	cod_operador int2 NULL,
	operador varchar(40) NULL,
	cod_cel int2 NULL,
	celula_os varchar(25) NULL,
	turno int2 NULL,
	referencia varchar(30) NULL,
	produto varchar(100) NULL,
	ultima_atualizacao timestamp NULL,
	"DATA" date NULL,
	qtde numeric(18, 3) NULL,
	tempo numeric(18, 3) NULL,
	carga numeric(18, 3) NULL,
	gd numeric(18, 3) NULL
);


-- temporario.freceber definição

-- Drop table

-- DROP TABLE temporario.freceber;

CREATE TABLE temporario.freceber (
	pk_titulo varchar(30) NULL,
	cd_empresa int2 NULL,
	cd_duplicata int4 NULL,
	cd_tipo_titulo int4 NULL,
	cd_seq_duplicata int4 NULL,
	cd_seq_pagamento int4 NULL,
	cd_pedido_venda int8 NULL,
	cd_contabil int4 NULL,
	nr_contabil int8 NULL,
	cd_doc_pagamento int8 NULL,
	cd_transacao int4 NULL,
	cd_conta_concorrente int8 NULL,
	fk_cliente varchar(25) NULL,
	fk_historico int4 NULL,
	fk_portador int4 NULL,
	fk_representante int4 NULL,
	vlr_duplicata numeric(18, 3) NULL,
	vlr_pago numeric(18, 3) NULL,
	vlr_restante numeric(18, 3) NULL,
	vlr_juros numeric(18, 3) NULL,
	vlr_desconto numeric(18, 3) NULL,
	qtd_titulos numeric(18, 3) NULL,
	vlr_comissao numeric(18, 3) NULL,
	base_calc_comissao numeric(18, 3) NULL,
	data_emissao timestamp NULL,
	data_vencimento timestamp NULL,
	data_pagamento timestamp NULL,
	data_prorrogacao timestamp NULL,
	gap_data_pagamento float8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.fregistro_acesso definição

-- Drop table

-- DROP TABLE temporario.fregistro_acesso;

CREATE TABLE temporario.fregistro_acesso (
	fk_empresa int4 NULL,
	cd_num_cra int8 NULL,
	dt_cc timestamp NULL,
	dt_hr_cc int4 NULL,
	cd_seq_acc int2 NULL,
	cd_ori_acc varchar(1) NULL,
	cd_num_cad int4 NULL,
	dt_apu timestamp NULL,
	cd_num_nsr int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.froteiro definição

-- Drop table

-- DROP TABLE temporario.froteiro;

CREATE TABLE temporario.froteiro (
	num_roteiro int2 NULL,
	seq_operacao int2 NULL,
	fk_operacao int4 NULL,
	fk_estagio int2 NULL,
	seq_estagio int2 NULL,
	estagio_depende int2 NULL,
	qtd_rolos int4 NULL,
	observacao_roteiro varchar(200) NULL,
	centro_custo int4 NULL,
	ccusto_homem int4 NULL,
	dthora_atualizacao timestamp NULL,
	qtd_cordas int4 NULL,
	minutos_roteiro numeric(18, 3) NULL,
	velocidade numeric(18, 3) NULL,
	minutos_homem numeric(18, 3) NULL,
	fk_produto varchar(20) NULL
);


-- temporario.fsaldoestoqueatual definição

-- Drop table

-- DROP TABLE temporario.fsaldoestoqueatual;

CREATE TABLE temporario.fsaldoestoqueatual (
	cd_empresa int2 NULL,
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(3) NULL,
	fk_produto varchar(18) NULL,
	dt_ult_entrada timestamp NULL,
	dt_ult_saida timestamp NULL,
	ultima_atualizacao timestamp NULL,
	codigo_barras varchar(16) NULL,
	qtd_empenhada numeric(18, 3) NULL,
	qtd_est_atual numeric(18, 3) NULL,
	qtd_disponivel numeric(18, 3) NULL,
	qtd_sugerida numeric(18, 3) NULL
);


-- temporario.ftabelapreco definição

-- Drop table

-- DROP TABLE temporario.ftabelapreco;

CREATE TABLE temporario.ftabelapreco (
	tabela_preco_cod varchar(11) NULL,
	tabela_preco varchar(9) NULL,
	fk_produto varchar(18) NULL,
	dthora_atualizacao timestamp NULL,
	tabela_preco_grupo numeric(18, 3) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	vlr_com_desconto numeric(18, 3) NULL
);


-- temporario.ftabelaprecogrupoest definição

-- Drop table

-- DROP TABLE temporario.ftabelaprecogrupoest;

CREATE TABLE temporario.ftabelaprecogrupoest (
	grupo_estrutura varchar(5) NULL,
	item_estrutura varchar(6) NULL,
	subgru_estrutura varchar(3) NULL,
	nivel_estrutura varchar(1) NULL,
	tabela_preco varchar(9) NULL,
	tabela_preco_cod varchar(11) NULL,
	val_tabela_preco numeric(25, 6) NULL
);


-- temporario.ftabelaprecostage definição

-- Drop table

-- DROP TABLE temporario.ftabelaprecostage;

CREATE TABLE temporario.ftabelaprecostage (
	tabela_preco varchar(9) NULL,
	tabela_preco_cod varchar(11) NULL,
	fk_produto varchar(18) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	vlr_com_desconto numeric(18, 3) NULL,
	grupo_estrutura varchar(5) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.ftempo_metodos definição

-- Drop table

-- DROP TABLE temporario.ftempo_metodos;

CREATE TABLE temporario.ftempo_metodos (
	pk_produto varchar(111) NULL,
	alt int2 NULL,
	rot int2 NULL,
	sub_grupo varchar(3) NULL,
	codigo_estagio int4 NULL,
	codigo_operacao int4 NULL,
	pk_maquina varchar(39) NULL,
	agulhas varchar(3) NULL,
	custo_homem numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	custo_minuto numeric(18, 3) NULL
);


-- temporario.ftotalizador_horas definição

-- Drop table

-- DROP TABLE temporario.ftotalizador_horas;

CREATE TABLE temporario.ftotalizador_horas (
	cd_tip_col int2 NULL,
	cd_num_col int4 NULL,
	dt_compe_calc timestamp NULL,
	qtd_hor_pag int8 NULL,
	qtd_hor_des int8 NULL,
	qtd_saldo int8 NULL,
	dthora_atualizacao timestamp NULL,
	fk_banco_hora int4 NULL,
	fk_colaborador varchar(150) NULL,
	fk_empresa int4 NULL,
	vlr_hor_pag numeric(20, 4) NULL,
	vlr_hor_des numeric(20, 4) NULL,
	vlr_hor_saldo numeric(20, 4) NULL
);


-- temporario.fvendas_presenciais definição

-- Drop table

-- DROP TABLE temporario.fvendas_presenciais;

CREATE TABLE temporario.fvendas_presenciais (
	cd_colaborador varchar(30) NULL,
	nm_colaborador varchar(100) NULL,
	dt_venda varchar(30) NULL,
	hr_venda varchar(30) NULL,
	origem_venda varchar(30) NULL,
	tipo_venda varchar(30) NULL,
	cd_filial varchar(30) NULL,
	nm_filial varchar(100) NULL,
	dt_hora_venda timestamp NULL,
	dt_ult_atualizacao timestamp NULL,
	vlr_liquido numeric(18, 3) NULL,
	cd_ped varchar(50) NULL
);


-- temporario.fvendas_url definição

-- Drop table

-- DROP TABLE temporario.fvendas_url;

CREATE TABLE temporario.fvendas_url (
	id numeric(10) NULL,
	pedido numeric(9) NULL,
	nota_fiscal numeric(9) NULL,
	quantidade numeric(15, 3) NULL,
	valor_faturado numeric(15, 3) NULL,
	canal varchar(55) NULL,
	cnpj varchar(15) NULL,
	serie_nota_fiscal varchar(3) NULL,
	pedido_cliente varchar(30) NULL,
	"DATA" timestamp NULL,
	data_emissao timestamp NULL,
	cupom varchar(35) NULL,
	loja varchar(65) NULL,
	cpf_vendedor varchar(11) NULL,
	cnpj_loja varchar(15) NULL,
	tela varchar(32) NULL,
	omnichannel varchar(32) NULL,
	ultima_atualizacao timestamp NULL,
	nota_entrada float8 NULL,
	nota_saida float8 NULL,
	motivo_devolucao varchar(400) NULL,
	flag_tipo varchar(3) NULL,
	tipo_cliente varchar(56) NULL,
	cliente varchar(57) NULL,
	tipo_cupom varchar(58) NULL,
	vendedor varchar(59) NULL,
	percentual_comissao numeric(18, 3) NULL,
	valor_comissao numeric(18, 3) NULL,
	grupo_loja varchar(60) NULL,
	fornecedor varchar(61) NULL
);


-- temporario.fvolumes_notas definição

-- Drop table

-- DROP TABLE temporario.fvolumes_notas;

CREATE TABLE temporario.fvolumes_notas (
	codpedido numeric(11) NULL,
	notafiscal numeric(11) NULL,
	dataemissao timestamp NULL,
	datamontagem timestamp NULL,
	volumenota numeric(11) NULL,
	expedidor varchar(150) NULL,
	sit_vol_fat varchar(20) NULL,
	nivel varchar(3) NULL,
	grupo varchar(10) NULL,
	subgrupo varchar(5) NULL,
	item varchar(10) NULL,
	qtdepeca numeric(15) NULL,
	pesototalitem numeric(15, 3) NULL,
	pesovolume numeric(15, 3) NULL,
	pesoembalagem numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.homologacao_dcalendario definição

-- Drop table

-- DROP TABLE temporario.homologacao_dcalendario;

CREATE TABLE temporario.homologacao_dcalendario (
	"data" timestamp NULL,
	ano numeric(38, 10) NULL,
	mes numeric(38, 10) NULL,
	nummesano text NULL,
	mes_ano text NULL,
	nm_mes text NULL,
	abrev_mes text NULL,
	dia numeric(38, 10) NULL,
	nm_dia text NULL,
	abrev_dia text NULL,
	nr_dia_semana numeric(38, 10) NULL,
	numero_semana numeric(2) NULL,
	semana_ano_tabela text NULL,
	dia_do_ano numeric(38, 10) NULL,
	dia_semana numeric(1) NULL,
	dia_util numeric(1) NULL,
	dia_util_finan numeric(1) NULL
);


-- temporario.homologacao_fmovimentacoesestoque definição

-- Drop table

-- DROP TABLE temporario.homologacao_fmovimentacoesestoque;

CREATE TABLE temporario.homologacao_fmovimentacoesestoque (
	cd_deposito numeric(3) NULL,
	cd_nivel_estrutura numeric(38, 10) NULL,
	fk_produto text NULL,
	codigo_transacao numeric(3) NULL,
	dt_movimentacao timestamp NULL,
	tipo_movimento text NULL,
	qtd_movimento numeric(12, 3) NULL,
	qtd_saldo_fisico numeric(15, 5) NULL,
	vlr_movimento_unitario numeric(18, 5) NULL,
	vlr_saldo_financeiro numeric(18, 5) NULL,
	flag_periodo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.homologacao_fmovimentacoesestoque_12_meses definição

-- Drop table

-- DROP TABLE temporario.homologacao_fmovimentacoesestoque_12_meses;

CREATE TABLE temporario.homologacao_fmovimentacoesestoque_12_meses (
	cd_deposito numeric(3) NULL,
	cd_nivel_estrutura numeric(38, 10) NULL,
	fk_produto text NULL,
	codigo_transacao numeric(3) NULL,
	dt_movimentacao timestamp NULL,
	tipo_movimento text NULL,
	qtd_movimento numeric(12, 3) NULL,
	qtd_saldo_fisico numeric(15, 5) NULL,
	vlr_movimento_unitario numeric(18, 5) NULL,
	vlr_saldo_financeiro numeric(18, 5) NULL,
	flag_periodo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_carga_compras definição

-- Drop table

-- DROP TABLE temporario.jma_carga_compras;

CREATE TABLE temporario.jma_carga_compras (
	linhas int8 NULL,
	datamax timestamp NULL,
	tabela text NULL,
	dag_carga text NULL
);


-- temporario.jma_carga_mov_estoque definição

-- Drop table

-- DROP TABLE temporario.jma_carga_mov_estoque;

CREATE TABLE temporario.jma_carga_mov_estoque (
	linhas int8 NULL,
	datamax timestamp NULL,
	tabela text NULL,
	dag_carga text NULL
);


-- temporario.jma_carga_ordens definição

-- Drop table

-- DROP TABLE temporario.jma_carga_ordens;

CREATE TABLE temporario.jma_carga_ordens (
	linhas int8 NULL,
	datamax timestamp NULL,
	tabela text NULL,
	dag_carga text NULL
);


-- temporario.jma_carga_prod_marft definição

-- Drop table

-- DROP TABLE temporario.jma_carga_prod_marft;

CREATE TABLE temporario.jma_carga_prod_marft (
	linhas int8 NULL,
	datamax timestamp NULL,
	tabela text NULL,
	dag_carga text NULL
);


-- temporario.jma_carga_saldo_estoque_integ definição

-- Drop table

-- DROP TABLE temporario.jma_carga_saldo_estoque_integ;

CREATE TABLE temporario.jma_carga_saldo_estoque_integ (
	datamax timestamp NULL,
	tabela varchar(50) NULL,
	dag_carga varchar(50) NULL,
	ultimo_registro timestamp NULL,
	linhas numeric(18, 3) NULL
);


-- temporario.jma_carga_views_fat definição

-- Drop table

-- DROP TABLE temporario.jma_carga_views_fat;

CREATE TABLE temporario.jma_carga_views_fat (
	linhas int8 NULL,
	datamax timestamp NULL,
	tabela text NULL,
	dag_carga text NULL
);


-- temporario.jma_daparelho definição

-- Drop table

-- DROP TABLE temporario.jma_daparelho;

CREATE TABLE temporario.jma_daparelho (
	pk_aparelho varchar(6) NULL,
	desc_aparelho varchar(50) NULL,
	obs_aparelho varchar(100) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dbloqueio definição

-- Drop table

-- DROP TABLE temporario.jma_dbloqueio;

CREATE TABLE temporario.jma_dbloqueio (
	pedido varchar(9) NULL,
	codigo_situacao varchar(4) NULL,
	observacao varchar(300) NULL,
	seq_situacao varchar(2) NULL,
	ultima_atualizacao timestamp NULL,
	pk_bloqueio varchar(50) NULL
);


-- temporario.jma_dcadastro_loja definição

-- Drop table

-- DROP TABLE temporario.jma_dcadastro_loja;

CREATE TABLE temporario.jma_dcadastro_loja (
	pk_loja int4 NULL,
	desc_loja varchar(200) NULL,
	desc_apelido varchar(200) NULL,
	desc_razao_social varchar(200) NULL,
	cod_inscricao_estadual varchar(20) NULL,
	cod_funcionario int4 NULL,
	cep int4 NULL,
	desc_endereco varchar(200) NULL,
	telefone int8 NULL,
	cod_portal int4 NULL,
	pk_portal int4 NULL,
	dt_inauguracao timestamp NULL,
	cod_regiao int4 NULL,
	cod_usuario int4 NULL,
	flag_abre_aos_domingos int2 NULL,
	omny_channel int2 NULL,
	cod_rede int4 NULL,
	ponto_retirada int2 NULL,
	cupom_desconto_loja varchar(20) NULL,
	dt_cadastro timestamp NULL,
	dt_ult_alteracao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	rede varchar(50) NULL,
	cod_cidade int4 NULL,
	pk_cnpj varchar(35) NULL,
	metragem numeric(7, 2) NULL,
	porc_franchising numeric(7, 2) NULL,
	cidade varchar(40) NULL,
	estado varchar(2) NULL,
	regiao varchar(100) NULL,
	situacao varchar(7) NULL
);


-- temporario.jma_dcanaldistribuicao definição

-- Drop table

-- DROP TABLE temporario.jma_dcanaldistribuicao;

CREATE TABLE temporario.jma_dcanaldistribuicao (
	id int4 NULL,
	descricao varchar(100) NULL,
	modalidade varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dcargo definição

-- Drop table

-- DROP TABLE temporario.jma_dcargo;

CREATE TABLE temporario.jma_dcargo (
	pk_cargo int2 NULL,
	desc_cargo varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dcelula_parada definição

-- Drop table

-- DROP TABLE temporario.jma_dcelula_parada;

CREATE TABLE temporario.jma_dcelula_parada (
	codigo_celula numeric(5) NULL,
	shift numeric(3) NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	detalhes text NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dcentro_custo definição

-- Drop table

-- DROP TABLE temporario.jma_dcentro_custo;

CREATE TABLE temporario.jma_dcentro_custo (
	cd_centro_custo int4 NULL,
	desc_centro_custo varchar(25) NULL,
	cd_desc varchar(70) NULL,
	cd_local_entrega int4 NULL,
	cd_tipo_mao_obra int2 NULL,
	cd_centro_custo_pai int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dcidades definição

-- Drop table

-- DROP TABLE temporario.jma_dcidades;

CREATE TABLE temporario.jma_dcidades (
	cod_cidade varchar(5) NULL,
	nm_cidade varchar(60) NULL,
	uf varchar(2) NULL,
	ddd int2 NULL,
	cod_pais int2 NULL,
	cod_fiscal int4 NULL,
	cod_reg_mer_ex int2 NULL,
	populacao int4 NULL,
	cod_cidade_zona_franca int4 NULL,
	cod_cidade_ibge int4 NULL,
	cod_sub_regiao int2 NULL,
	sub_regiao varchar(40) NULL,
	cod_suframa int2 NULL,
	cep int4 NULL,
	dthora_atualizacao timestamp NULL,
	nm_pais varchar(30) NULL,
	estado_extenso varchar(30) NULL
);


-- temporario.jma_dclassificacao_referencia definição

-- Drop table

-- DROP TABLE temporario.jma_dclassificacao_referencia;

CREATE TABLE temporario.jma_dclassificacao_referencia (
	pk_classificacao_referencia varchar(8) NULL,
	cd_referencia varchar(8) NULL,
	desc_categoria varchar(90) NULL,
	ds_cd_classificacao_ref varchar(100) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dcliente definição

-- Drop table

-- DROP TABLE temporario.jma_dcliente;

CREATE TABLE temporario.jma_dcliente (
	pk_cliente varchar(16) NULL,
	cod_empresa int2 NULL,
	nm_cliente varchar(70) NULL,
	nm_fantasia varchar(70) NULL,
	fone_cliente int4 NULL,
	uf_cliente varchar(2) NULL,
	cep int4 NULL,
	cidade varchar(40) NULL,
	endereco varchar(70) NULL,
	bairro varchar(20) NULL,
	dt_cadastro timestamp NULL,
	cod_representante int2 NULL,
	nm_representante varchar(50) NULL,
	nm_subregiao_cliente varchar(20) NULL,
	tipo_cliente varchar(40) NULL,
	tipo_cliente_agrupamento varchar(40) NULL,
	dt_ult_compra timestamp NULL,
	vlr_ult_compra numeric(18, 3) NULL,
	prazo_medio numeric(9, 3) NULL,
	dt_ultima_fatura timestamp NULL,
	email_cliente varchar(100) NULL,
	grupo_economico varchar(40) NULL,
	cd_grupo_economico int4 NULL,
	situacao_cliente varchar(7) NULL,
	conceito_cliente varchar(20) NULL,
	modalidade_cliente varchar(30) NULL,
	pais_cliente varchar(25) NULL,
	regiao_cliente varchar(20) NULL,
	cod_cidade int4 NULL,
	dthora_atualizacao timestamp NULL,
	cnpj_cliente varchar(120) NULL
);


-- temporario.jma_dclientefornecedor definição

-- Drop table

-- DROP TABLE temporario.jma_dclientefornecedor;

CREATE TABLE temporario.jma_dclientefornecedor (
	portal numeric(38, 10) NULL,
	cod_cliente numeric(38, 10) NULL,
	razao_cliente text NULL,
	nome_cliente text NULL,
	doc_cliente text NULL,
	tipo_cliente text NULL,
	cidade_cliente text NULL,
	uf_cliente text NULL,
	pais text NULL,
	data_cadastro text NULL,
	email_cliente text NULL,
	ativo text NULL,
	ultima_atualizacao timestamp NULL,
	dt_update timestamp NULL,
	data_nascimento timestamp NULL,
	sexo text NULL
);


-- temporario.jma_dcolaboradores definição

-- Drop table

-- DROP TABLE temporario.jma_dcolaboradores;

CREATE TABLE temporario.jma_dcolaboradores (
	cd_empresa numeric(40) NULL,
	cd_funcionario numeric(40) NULL,
	nome_funcionario varchar(40) NULL,
	turno numeric(40) NULL,
	cd_cargo numeric(40) NULL,
	cd_centro_custo numeric(40) NULL,
	cpf_funcionario varchar(14) NULL,
	dt_nascimento timestamp NULL,
	dt_adimissao timestamp NULL,
	cd_setor_responsavel int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dcomprador definição

-- Drop table

-- DROP TABLE temporario.jma_dcomprador;

CREATE TABLE temporario.jma_dcomprador (
	pk_comprador int4 NULL,
	nome_comprador varchar(30) NULL,
	email_comprador varchar(40) NULL,
	fone_ramal int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dcondicao_pagamento definição

-- Drop table

-- DROP TABLE temporario.jma_dcondicao_pagamento;

CREATE TABLE temporario.jma_dcondicao_pagamento (
	pk_cond_pgto int2 NULL,
	desc_cond_pgto varchar(20) NULL,
	status_exportacao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dconjuntos definição

-- Drop table

-- DROP TABLE temporario.jma_dconjuntos;

CREATE TABLE temporario.jma_dconjuntos (
	cod_empresa int2 NULL,
	cor_ref_a varchar(6) NULL,
	cor_ref_b varchar(6) NULL,
	referencia_a varchar(5) NULL,
	referencia_b varchar(5) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dconta_contabil definição

-- Drop table

-- DROP TABLE temporario.jma_dconta_contabil;

CREATE TABLE temporario.jma_dconta_contabil (
	codigo_contabil int4 NULL,
	tipo_contabil int2 NULL,
	descricao varchar(45) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dcontas_estoque definição

-- Drop table

-- DROP TABLE temporario.jma_dcontas_estoque;

CREATE TABLE temporario.jma_dcontas_estoque (
	pk_conta_estoque int2 NULL,
	desc_conta_estoque varchar(40) NULL,
	tipo_produto_sped int2 NULL,
	itens_estoque int2 NULL,
	dthora_atualizacao timestamp NULL,
	tipo_conta_estoque int2 NULL
);


-- temporario.jma_ddeposito definição

-- Drop table

-- DROP TABLE temporario.jma_ddeposito;

CREATE TABLE temporario.jma_ddeposito (
	codigo_deposito int2 NULL,
	descricao varchar(30) NULL,
	local_deposito int2 NULL,
	cod_desc_deposito varchar(50) NULL,
	hora_atualizacao timestamp NULL
);


-- temporario.jma_ddesccancelamento definição

-- Drop table

-- DROP TABLE temporario.jma_ddesccancelamento;

CREATE TABLE temporario.jma_ddesccancelamento (
	cod_canc_pedido int2 NULL,
	desc_canc_pedido varchar(20) NULL,
	tp_cancelamento int2 NULL,
	grupo_canc_ped varchar(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_ddescricao_defeito definição

-- Drop table

-- DROP TABLE temporario.jma_ddescricao_defeito;

CREATE TABLE temporario.jma_ddescricao_defeito (
	cod_defeito int2 NULL,
	descr_defeito varchar(40) NULL,
	cod_desc_defeito varchar(112) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_denderecoprodutos definição

-- Drop table

-- DROP TABLE temporario.jma_denderecoprodutos;

CREATE TABLE temporario.jma_denderecoprodutos (
	pk_produto varchar(18) NULL,
	deposito int2 NULL,
	endereco varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_destagio definição

-- Drop table

-- DROP TABLE temporario.jma_destagio;

CREATE TABLE temporario.jma_destagio (
	pk_estagio int2 NULL,
	desc_estagio varchar(20) NULL,
	cod_deposito int2 NULL,
	area_producao int2 NULL,
	tipo_estagio int2 NULL,
	estagio_final int2 NULL,
	sequencia_calculo_fila int2 NULL,
	estagio_base_fila int2 NULL,
	responsavel_estagio varchar(20) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dfamilia_materiais definição

-- Drop table

-- DROP TABLE temporario.jma_dfamilia_materiais;

CREATE TABLE temporario.jma_dfamilia_materiais (
	pk_familia int4 NULL,
	desc_familia varchar(25) NULL,
	desc_usuario_comprador varchar(250) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dfuncionariosinteg definição

-- Drop table

-- DROP TABLE temporario.jma_dfuncionariosinteg;

CREATE TABLE temporario.jma_dfuncionariosinteg (
	cod_vendedor int4 NULL,
	cpf_vendedor varchar(20) NULL,
	nome_vendedor varchar(100) NULL,
	cargo varchar(100) NULL,
	loja varchar(20) NULL,
	cnpj varchar(40) NULL,
	status varchar(10) NULL,
	data_admissao timestamp NULL,
	data_demissao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dgrupo_contas definição

-- Drop table

-- DROP TABLE temporario.jma_dgrupo_contas;

CREATE TABLE temporario.jma_dgrupo_contas (
	tipo_grupo_contas int2 NULL,
	desc_grupo_contas varchar(60) NULL,
	dthora_atualizacao timestamp NULL,
	pk_grupo_contas int4 NULL,
	obs varchar(300) NULL,
	observacao_grupo_contas varchar(100) NULL
);


-- temporario.jma_dgrupo_embarque definição

-- Drop table

-- DROP TABLE temporario.jma_dgrupo_embarque;

CREATE TABLE temporario.jma_dgrupo_embarque (
	grupo_embarque numeric(11) NULL,
	data_entrega timestamp NULL,
	nivel text NULL,
	referencia text NULL,
	tamanho text NULL,
	cor text NULL,
	pk_produto text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dhistorico_contabil definição

-- Drop table

-- DROP TABLE temporario.jma_dhistorico_contabil;

CREATE TABLE temporario.jma_dhistorico_contabil (
	pk_historico numeric(4) NULL,
	desc_historico text NULL,
	flag_considera_regime text NULL,
	sinal_titulo numeric(1) NULL,
	sinal_diario numeric(1) NULL,
	sinal_comissao numeric(1) NULL,
	flag_entrada_saida text NULL,
	tipo_historico text NULL,
	flag_atualiza_comissao numeric(1) NULL,
	flag_atualiza_acc numeric(1) NULL,
	inf_custo numeric(1) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dmaquina definição

-- Drop table

-- DROP TABLE temporario.jma_dmaquina;

CREATE TABLE temporario.jma_dmaquina (
	pk_maquina varchar(8) NULL,
	numero_maquina int4 NULL,
	cod_grupo_maquina varchar(4) NULL,
	desc_grupo_maquina varchar(60) NULL,
	unidade_medida varchar(2) NULL,
	subgrupo_maquina varchar(3) NULL,
	desc_subgrupo varchar(10) NULL,
	observacao_subgrupo varchar(180) NULL,
	cod_familia int2 NULL,
	desc_familia varchar(25) NULL,
	maquina_ativa int4 NULL,
	cod_centro_custo int8 NULL,
	observacao_maquina varchar(65) NULL,
	dthora_atualizacao timestamp NULL,
	numero_operadores numeric(18, 3) NULL,
	volume_maximo numeric(18, 3) NULL,
	volume_minimo numeric(18, 3) NULL,
	pk_maquina_num varchar(80) NULL,
	nome_maquina varchar(10) NULL,
	descricao_maquina varchar(144) NULL
);


-- temporario.jma_dmotivo_bloqueio definição

-- Drop table

-- DROP TABLE temporario.jma_dmotivo_bloqueio;

CREATE TABLE temporario.jma_dmotivo_bloqueio (
	cod_bloqueio numeric(3) NULL,
	descricao varchar(200) NULL,
	flag_bloqueio numeric(1) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dmotivo_cancelamento definição

-- Drop table

-- DROP TABLE temporario.jma_dmotivo_cancelamento;

CREATE TABLE temporario.jma_dmotivo_cancelamento (
	cod_canc_pedido numeric(3) NULL,
	desc_canc_pedido varchar(200) NULL,
	tp_cancelamento numeric(1) NULL,
	grupo_canc_ped numeric(3) NULL
);


-- temporario.jma_dmotivo_defeito definição

-- Drop table

-- DROP TABLE temporario.jma_dmotivo_defeito;

CREATE TABLE temporario.jma_dmotivo_defeito (
	codigo_motivo numeric(3) NULL,
	codigo_estagio numeric(5) NULL,
	descricao text NULL,
	pk_motivo text NULL,
	cod_desc_motivo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dmotivo_devolucao definição

-- Drop table

-- DROP TABLE temporario.jma_dmotivo_devolucao;

CREATE TABLE temporario.jma_dmotivo_devolucao (
	codigo_motivo int2 NULL,
	descr_motivo varchar(30) NULL,
	setor_responsav varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dnatureza_operacao definição

-- Drop table

-- DROP TABLE temporario.jma_dnatureza_operacao;

CREATE TABLE temporario.jma_dnatureza_operacao (
	pk_natureza int4 NULL,
	venda int2 NULL,
	devolucao int2 NULL,
	ranking int2 NULL,
	franchising int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dnotasenviadasinteg definição

-- Drop table

-- DROP TABLE temporario.jma_dnotasenviadasinteg;

CREATE TABLE temporario.jma_dnotasenviadasinteg (
	nota_fiscal numeric(9) NULL,
	serie_nota text NULL,
	pk_cliente text NULL,
	data_hora_envio timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dnotaslojas definição

-- Drop table

-- DROP TABLE temporario.jma_dnotaslojas;

CREATE TABLE temporario.jma_dnotaslojas (
	codigo_empresa numeric(3) NULL,
	pedido_venda numeric(9) NULL,
	num_nota_fiscal numeric(9) NULL,
	serie_nota_fisc text NULL,
	num_sol_nf_loja numeric(9) NULL,
	num_nf_loja numeric(9) NULL,
	serie_loja text NULL,
	pk_loja text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_doperacao definição

-- Drop table

-- DROP TABLE temporario.jma_doperacao;

CREATE TABLE temporario.jma_doperacao (
	desc_operacao varchar(50) NULL,
	pk_operacao int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_doperador_parada definição

-- Drop table

-- DROP TABLE temporario.jma_doperador_parada;

CREATE TABLE temporario.jma_doperador_parada (
	codigo_operador numeric(5) NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	detalhes text NULL,
	descontar_tempo numeric(1) NULL,
	ignorereport numeric(1) NULL,
	id numeric(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dordem_servico_producao definição

-- Drop table

-- DROP TABLE temporario.jma_dordem_servico_producao;

CREATE TABLE temporario.jma_dordem_servico_producao (
	pk_ordens_servico_prod varchar(125) NULL,
	fk_ordens_servico_itens varchar(85) NULL,
	fk_tipo_entrada numeric(5) NULL,
	cd_nr_ordem numeric(9) NULL,
	seq numeric(3) NULL,
	seq_entrada numeric(6) NULL,
	qtd_ent numeric(18, 3) NULL,
	data_ent date NULL,
	cd_tipo_ent numeric(5) NULL,
	cd_nr_nf_ent numeric(12) NULL,
	cd_serie_nf_ent varchar(6) NULL,
	seq_item_nf_ent numeric(6) NULL,
	cd_periodo_prod numeric(7) NULL,
	cd_ordem_prod numeric(12) NULL,
	qtd_pag numeric(18, 3) NULL,
	cd_nr_titulo numeric(12) NULL,
	cd_sit_fechamento numeric(4) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dordens_conserto definição

-- Drop table

-- DROP TABLE temporario.jma_dordens_conserto;

CREATE TABLE temporario.jma_dordens_conserto (
	pk_ordens_conserto numeric(9) NULL,
	cd_solicitacao numeric(9) NULL,
	cd_est_ident_cons numeric(5) NULL,
	cd_est_cons numeric(5) NULL,
	cd_usuario text NULL,
	data_emissao timestamp NULL,
	cd_numero_ordem numeric(9) NULL,
	cd_situacao_solicitacao numeric(1) NULL,
	cd_cancelamento numeric(3) NULL,
	data_cancelamento timestamp NULL,
	desc_observacao text NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dordens_servico definição

-- Drop table

-- DROP TABLE temporario.jma_dordens_servico;

CREATE TABLE temporario.jma_dordens_servico (
	pk_ordens_servico numeric(9) NULL,
	fk_transacao numeric(3) NULL,
	fk_fornecedor text NULL,
	cd_nr_ordem numeric(9) NULL,
	data_emissao timestamp NULL,
	cd_canc_ordem numeric(2) NULL,
	cd_servico numeric(5) NULL,
	cd_tbl_serv numeric(2) NULL,
	cd_tbl_mes numeric(2) NULL,
	cd_tbl_seq numeric(2) NULL,
	cd_sit_ordem numeric(1) NULL,
	data_entrega timestamp NULL,
	cd_transacao numeric(3) NULL,
	cd_vlr_peso_env numeric(14, 3) NULL,
	cd_vlr_peso_rec numeric(14, 3) NULL,
	desc_observ text NULL,
	cd_moeda numeric(2) NULL,
	cd_cond_pgto numeric(3) NULL,
	cd_status_req numeric(1) NULL,
	cd_sit_fechamento numeric(1) NULL,
	seq_origem numeric(3) NULL,
	cd_nr_ordem_origem numeric(6) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dordens_tinturaria_produzidas definição

-- Drop table

-- DROP TABLE temporario.jma_dordens_tinturaria_produzidas;

CREATE TABLE temporario.jma_dordens_tinturaria_produzidas (
	pk_ordens_tinturaria_produzidas text NULL,
	fk_estagio numeric(5) NULL,
	cd_est numeric(5) NULL,
	seq_operacao numeric(4) NULL,
	data_inicio timestamp NULL,
	hora_inicio timestamp NULL,
	data_termino timestamp NULL,
	hora_termino timestamp NULL,
	cd_ordem_prod numeric(9) NULL,
	cd_usuario numeric(5) NULL,
	seq_estagio numeric(1) NULL,
	cd_turno_prod numeric(1) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dperiodo_colecoes definição

-- Drop table

-- DROP TABLE temporario.jma_dperiodo_colecoes;

CREATE TABLE temporario.jma_dperiodo_colecoes (
	id float8 NULL,
	colecao int2 NULL,
	descr_colecao varchar(20) NULL,
	subcolecao int2 NULL,
	descr_sub_colecao varchar(20) NULL,
	classificacao int2 NULL,
	descr_classificacao varchar(6) NULL,
	data_inicio_sell_in timestamp NULL,
	data_fim_sell_in timestamp NULL,
	data_inicio_sell_out timestamp NULL,
	data_fim_sell_out timestamp NULL,
	data_inicio_producao timestamp NULL,
	data_fim_producao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_dperiodo_producao definição

-- Drop table

-- DROP TABLE temporario.jma_dperiodo_producao;

CREATE TABLE temporario.jma_dperiodo_producao (
	data_ini_periodo timestamp NULL,
	data_fim_periodo timestamp NULL,
	dias_uteis int4 NULL,
	cd_area_periodo int2 NULL,
	desc_situacao_periodo int2 NULL,
	dthora_atualizacao timestamp NULL,
	cd_periodo_producao int4 NULL,
	pk_periodo_producao varchar(85) NULL,
	cd_empresa int4 NULL,
	cd_deposito int4 NULL,
	data_ini_fatu timestamp NULL,
	data_fim_fatu timestamp NULL,
	descricao varchar(20) NULL
);
CREATE INDEX jma_dperiodo_producao_descricao_data_ini_periodo_cd_empresa_idx ON temporario.jma_dperiodo_producao USING btree (descricao, data_ini_periodo, cd_empresa, cd_periodo_producao);


-- temporario.jma_dportador definição

-- Drop table

-- DROP TABLE temporario.jma_dportador;

CREATE TABLE temporario.jma_dportador (
	pk_portador numeric(3) NULL,
	desc_banco text NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dproduto definição

-- Drop table

-- DROP TABLE temporario.jma_dproduto;

CREATE TABLE temporario.jma_dproduto (
	pk_produto varchar(25) NULL,
	pk_produto_cigam varchar(14) NULL,
	cd_produto varchar(16) NULL,
	cd_desc_prod varchar(80) NULL,
	nivel_estrutura int2 NULL,
	desc_nivel_estrutura varchar(30) NULL,
	cd_referencia varchar(5) NULL,
	desc_produto varchar(70) NULL,
	und_medida varchar(2) NULL,
	desc_unidade_medida varchar(20) NULL,
	nm_tamanho varchar(15) NULL,
	nm_cor varchar(25) NULL,
	cd_colecao int2 NULL,
	desc_colecao varchar(30) NULL,
	cod_linha int4 NULL,
	linha_produto varchar(40) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(30) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(30) NULL,
	cd_desc_referencia varchar(50) NULL,
	cod_desc_artigo varchar(50) NULL,
	cod_agrupador int2 NULL,
	desc_agrupador varchar(50) NULL,
	tipo_produto varchar(15) NULL,
	marca varchar(50) NULL,
	cd_conta_estoque int2 NULL,
	desc_conta_estoque varchar(50) NULL,
	desc_produto_narrativa varchar(90) NULL,
	cd_cor varchar(6) NULL,
	cd_tamanho varchar(5) NULL,
	desc_narrativa varchar(70) NULL,
	item_ativo int2 NULL,
	desc_referencia varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	publico_alvo varchar(60) NULL,
	faixa_etaria varchar(60) NULL,
	codigo_contabil int4 NULL,
	classific_fiscal varchar(15) NULL,
	descr_class_fisc varchar(40) NULL,
	serie_tamanho int2 NULL,
	desc_serie_tamanho varchar(10) NULL,
	obs_serie_tamanho varchar(60) NULL,
	sub_colecao varchar(20) NULL,
	familia1 varchar(80) NULL,
	familia2 varchar(80) NULL,
	familia3 varchar(80) NULL,
	familia4 varchar(80) NULL,
	familia5 varchar(80) NULL,
	dthora_atualizacao timestamp NULL,
	alternativa_item int8 NULL,
	preco_custo numeric(18, 3) NULL
);


-- temporario.jma_dprodutoproducao definição

-- Drop table

-- DROP TABLE temporario.jma_dprodutoproducao;

CREATE TABLE temporario.jma_dprodutoproducao (
	pk_produto varchar(25) NULL,
	pk_produto_cigam varchar(14) NULL,
	cd_produto varchar(16) NULL,
	cd_desc_prod varchar(80) NULL,
	nivel_estrutura int2 NULL,
	desc_nivel_estrutura varchar(30) NULL,
	cd_referencia varchar(5) NULL,
	desc_produto varchar(70) NULL,
	und_medida varchar(2) NULL,
	desc_unidade_medida varchar(20) NULL,
	nm_tamanho varchar(15) NULL,
	nm_cor varchar(25) NULL,
	cd_colecao int2 NULL,
	desc_colecao varchar(30) NULL,
	cod_linha text NULL,
	linha_produto varchar(40) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(30) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(30) NULL,
	cd_desc_referencia varchar(50) NULL,
	cod_desc_artigo varchar(50) NULL,
	cod_agrupador int2 NULL,
	desc_agrupador varchar(50) NULL,
	tipo_produto varchar(15) NULL,
	marca varchar(50) NULL,
	cd_conta_estoque int2 NULL,
	desc_conta_estoque varchar(50) NULL,
	desc_produto_narrativa varchar(90) NULL,
	cd_cor varchar(6) NULL,
	cd_tamanho varchar(5) NULL,
	desc_narrativa varchar(70) NULL,
	item_ativo int2 NULL,
	desc_referencia varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	publico_alvo varchar(60) NULL,
	faixa_etaria varchar(60) NULL,
	codigo_contabil int4 NULL,
	classific_fiscal varchar(15) NULL,
	descr_class_fisc varchar(40) NULL,
	serie_tamanho int2 NULL,
	desc_serie_tamanho varchar(10) NULL,
	obs_serie_tamanho varchar(60) NULL,
	sub_colecao varchar(20) NULL,
	familia1 varchar(80) NULL,
	familia2 varchar(80) NULL,
	familia3 varchar(80) NULL,
	familia4 varchar(80) NULL,
	familia5 varchar(80) NULL,
	dthora_atualizacao timestamp NULL,
	alternativa_item int8 NULL,
	preco_custo numeric(18, 3) NULL
);


-- temporario.jma_dreposicoes definição

-- Drop table

-- DROP TABLE temporario.jma_dreposicoes;

CREATE TABLE temporario.jma_dreposicoes (
	pk_reposicoes numeric(9) NULL,
	cd_solicitacao numeric(9) NULL,
	cd_ordem_producao numeric(9) NULL,
	cd_est numeric(5) NULL,
	dt_emissao timestamp NULL,
	cd_situacao_requisicao numeric(1) NULL,
	desc_observacao text NULL,
	hora_gerada timestamp NULL,
	cd_empresa numeric(3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_drepresentante definição

-- Drop table

-- DROP TABLE temporario.jma_drepresentante;

CREATE TABLE temporario.jma_drepresentante (
	pk_representante varchar(6) NULL,
	cnpj_repres int8 NULL,
	cod_empresa int2 NULL,
	cod_repres int2 NULL,
	nome_repres varchar(50) NULL,
	nome_fantasia varchar(50) NULL,
	tipo_repres int2 NULL,
	endereco varchar(60) NULL,
	bairro varchar(20) NULL,
	cidade varchar(40) NULL,
	regiao varchar(20) NULL,
	subregiao varchar(20) NULL,
	cep int4 NULL,
	ddd_celular int2 NULL,
	num_celular int4 NULL,
	fone_repres int4 NULL,
	inscricao_estadual varchar(14) NULL,
	email varchar(60) NULL,
	situacao int2 NULL,
	conta_banco varchar(15) NULL,
	cod_agencia varchar(15) NULL,
	cod_adm int2 NULL,
	ult_pedido timestamp NULL,
	dias_ult_pedido float8 NULL,
	dt_primeiro_pedido timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cod_cidade varchar(5) NULL
);


-- temporario.jma_dresponsavel_loja definição

-- Drop table

-- DROP TABLE temporario.jma_dresponsavel_loja;

CREATE TABLE temporario.jma_dresponsavel_loja (
	pk_responsavel varchar(80) NULL,
	cod_loja int4 NULL,
	desc_responsavel varchar(100) NULL,
	cod_funcao int2 NULL,
	email varchar(200) NULL,
	telefone varchar(30) NULL,
	cod_situacao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dsituacao_venda definição

-- Drop table

-- DROP TABLE temporario.jma_dsituacao_venda;

CREATE TABLE temporario.jma_dsituacao_venda (
	situacao_venda numeric(2) NULL,
	ultima_atualizacao timestamp NULL,
	descricao_situacao varchar(100) NULL
);


-- temporario.jma_dsituacaopedido definição

-- Drop table

-- DROP TABLE temporario.jma_dsituacaopedido;

CREATE TABLE temporario.jma_dsituacaopedido (
	cod_situacao_venda varchar(2) NULL,
	desc_situacao_venda varchar(70) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dsortimento definição

-- Drop table

-- DROP TABLE temporario.jma_dsortimento;

CREATE TABLE temporario.jma_dsortimento (
	pk_sortimento varchar(6) NULL,
	tipo_sortimento int2 NULL,
	desc_sortimento varchar(20) NULL,
	serie_cor int2 NULL,
	numero_quadro int2 NULL,
	cor_fundo varchar(6) NULL,
	sortimento_estampa varchar(6) NULL,
	obs_1 varchar(65) NULL,
	obs_2 varchar(65) NULL,
	tipo_tingimento varchar(1) NULL,
	tonalidade varchar(2) NULL,
	tonalidade_estampa varchar(2) NULL,
	cor_representativa varchar(15) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dstatus_pedido definição

-- Drop table

-- DROP TABLE temporario.jma_dstatus_pedido;

CREATE TABLE temporario.jma_dstatus_pedido (
	status_pedido numeric(1) NULL,
	ultima_atualizacao timestamp NULL,
	descricao_status_pedido varchar(100) NULL
);


-- temporario.jma_dtabelapreco definição

-- Drop table

-- DROP TABLE temporario.jma_dtabelapreco;

CREATE TABLE temporario.jma_dtabelapreco (
	col_tabela_preco int2 NULL,
	mes_tabela_preco int2 NULL,
	seq_tabela_preco int2 NULL,
	data_inicio_tabela timestamp NULL,
	data_fim_tabela timestamp NULL,
	descricao varchar(20) NULL,
	cod_desc_tabela_preco varchar(34) NULL,
	tabela_preco int4 NULL,
	tabela_preco_cod varchar(11) NULL,
	desc_catalogo varchar(40) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_dtransacaoestoque definição

-- Drop table

-- DROP TABLE temporario.jma_dtransacaoestoque;

CREATE TABLE temporario.jma_dtransacaoestoque (
	codigo_transacao numeric(3) NULL,
	descricao text NULL,
	cod_desc_transacao text NULL,
	entrada_saida text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fabasfaccoesstage definição

-- Drop table

-- DROP TABLE temporario.jma_fabasfaccoesstage;

CREATE TABLE temporario.jma_fabasfaccoesstage (
	cod_chave_fornec text NULL,
	desc_fornecedor text NULL,
	qtd_minutos_total numeric(38, 10) NULL,
	qtd_costureira numeric(4) NULL,
	min_dia numeric(38, 10) NULL,
	dias_uteis numeric(38, 10) NULL,
	min_total numeric(38, 10) NULL,
	min_dia_enfic numeric(38, 10) NULL,
	perc_eficiencia numeric(6, 3) NULL,
	min_prev_perc_efic numeric(38, 10) NULL,
	min_prev_ate_data numeric(38, 10) NULL,
	min_real numeric(38, 10) NULL,
	perc_capacidade numeric(38, 10) NULL,
	a_realizar numeric(38, 10) NULL,
	penden_prev numeric(38, 10) NULL,
	tempo_pendente numeric(38, 10) NULL,
	qtd_em_pendente numeric(38, 10) NULL,
	qtd_conserto numeric(38, 10) NULL,
	qtd_perdas numeric(38, 10) NULL,
	dias_prod numeric(38, 10) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fabastecimento_faccao definição

-- Drop table

-- DROP TABLE temporario.jma_fabastecimento_faccao;

CREATE TABLE temporario.jma_fabastecimento_faccao (
	cod_chave_fornec varchar(70) NULL,
	desc_fornecedor varchar(40) NULL,
	dthora_atualizacao timestamp NULL,
	dias_prod numeric(18, 3) NULL,
	qtd_minutos_total numeric(18, 3) NULL,
	qtd_costureira numeric(18, 3) NULL,
	min_dia numeric(18, 3) NULL,
	dias_uteis numeric(18, 3) NULL,
	min_total numeric(18, 3) NULL,
	min_dia_enfic numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	min_prev_perc_efic numeric(18, 3) NULL,
	min_prev_ate_data numeric(18, 3) NULL,
	min_real numeric(18, 3) NULL,
	perc_capacidade numeric(18, 3) NULL,
	a_realizar numeric(18, 3) NULL,
	penden_prev numeric(18, 3) NULL,
	tempo_pendente numeric(18, 3) NULL,
	qtd_em_pendente numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL
);


-- temporario.jma_fabsenteismo_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fabsenteismo_inc;

CREATE TABLE temporario.jma_fabsenteismo_inc (
	fk_empresa int4 NULL,
	fk_filial varchar(100) NULL,
	fk_situacao int4 NULL,
	fk_cargo varchar(24) NULL,
	fk_local_organograma varchar(100) NULL,
	fk_localizacao int8 NULL,
	fk_colaborador varchar(130) NULL,
	cd_tip_col int2 NULL,
	cd_num_cad int8 NULL,
	cd_nom_fun varchar(60) NULL,
	cd_num_emp int4 NULL,
	cd_fil int4 NULL,
	cd_num_cgc int8 NULL,
	cd_loc varchar(180) NULL,
	cd_nom_loc varchar(70) NULL,
	cd_car varchar(24) NULL,
	cd_tit_car varchar(60) NULL,
	cd_esc int4 NULL,
	cd_nom_esc varchar(30) NULL,
	cd_sit_afa varchar(9) NULL,
	dt_ref timestamp NULL,
	cd_sit_lan int2 NULL,
	cd_sit_nom varchar(30) NULL,
	vlr_tot_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fbonus_vendedor definição

-- Drop table

-- DROP TABLE temporario.jma_fbonus_vendedor;

CREATE TABLE temporario.jma_fbonus_vendedor (
	cod_loja numeric(9) NULL,
	nome_vendedor text NULL,
	bonus_com_meta numeric(12, 2) NULL,
	bonus_sem_meta numeric(12, 2) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fcaixas_fio definição

-- Drop table

-- DROP TABLE temporario.jma_fcaixas_fio;

CREATE TABLE temporario.jma_fcaixas_fio (
	pk_caixas_fio text NULL,
	fk_produto text NULL,
	fk_deposito numeric(3) NULL,
	fk_transacao numeric(3) NULL,
	fk_fornecedor text NULL,
	cd_nr_caixa numeric(9) NULL,
	cd_turno numeric(1) NULL,
	cd_lote numeric(6) NULL,
	vlr_peso_embalagem numeric(7, 4) NULL,
	vlr_peso_lqd numeric(11, 3) NULL,
	vlr_peso_brt numeric(11, 3) NULL,
	cd_deposito numeric(3) NULL,
	data_producao timestamp NULL,
	cd_ender_caixa text NULL,
	desc_status_caixa numeric(1) NULL,
	vlr_qld_fio numeric(1) NULL,
	cd_trans_ent numeric(3) NULL,
	cd_nf numeric(9) NULL,
	cd_serie_nf text NULL,
	cd_pre_romaneio numeric(6) NULL,
	cd_ordem_prod numeric(9) NULL,
	cd_nf_ent numeric(9) NULL,
	cd_serie_nf_ent text NULL,
	cd_ordem_prod_beni numeric(9) NULL,
	cd_depos_prod numeric(3) NULL,
	cd_trans_prod numeric(3) NULL,
	cd_embalagem numeric(3) NULL,
	qtd_pecas_emb numeric(15, 3) NULL,
	cd_pediodo_prod numeric(4) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fcarteira_pedido definição

-- Drop table

-- DROP TABLE temporario.jma_fcarteira_pedido;

CREATE TABLE temporario.jma_fcarteira_pedido (
	fk_produto text NULL,
	cd_barra text NULL,
	fk_cliente text NULL,
	fk_representante numeric(5) NULL,
	ped_tipo_carteira text NULL,
	ped_cdempresa numeric(3) NULL,
	ped_cdrep numeric(5) NULL,
	ped_cdpedido numeric(9) NULL,
	ped_refproduto text NULL,
	ped_dataemissao text NULL,
	ped_dataembarque text NULL,
	ped_dtembarque timestamp NULL,
	ped_codcancelamento numeric(3) NULL,
	ped_prazomedio numeric(38, 10) NULL,
	ped_periodo numeric(4) NULL,
	ped_cdcidade numeric(5) NULL,
	ped_tabelapreco text NULL,
	ped_numerocontrole numeric(4) NULL,
	ped_pedidovendaorigem numeric(9) NULL,
	ped_pedidoorigem numeric(9) NULL,
	ped_cfop text NULL,
	ped_percomissaoped numeric(38, 10) NULL,
	ped_percdescped numeric(10, 2) NULL,
	ped_aceitaantecipacao numeric(1) NULL,
	ped_aceitaantecipacaodesc text NULL,
	permite_parcial text NULL,
	ped_tipofrete numeric(1) NULL,
	ped_condicaopagamento numeric(3) NULL,
	ped_codigobanco numeric(3) NULL,
	ped_percdescontotitulo numeric(6, 2) NULL,
	ped_pedidocliente text NULL,
	itemped_qtdcancelada numeric(38, 10) NULL,
	itemped_valorcancelado numeric(10, 2) NULL,
	itemped_qtdsaldopedido numeric(38, 10) NULL,
	itemped_valorsaldopedido numeric(38, 10) NULL,
	itemped_qtdepedido numeric(10, 2) NULL,
	itemped_qtdeliqpedido numeric(10, 2) NULL,
	itemped_percdescontoitem numeric(38, 10) NULL,
	itemped_valorliqpedido numeric(38, 10) NULL,
	itemped_valorcomissao numeric(38, 10) NULL,
	itemped_valordescped numeric(38, 10) NULL,
	itemped_codcancelamento numeric(3) NULL,
	itemped_datacancelamento text NULL,
	itemped_desccancel text NULL,
	itemped_tipocancelamento numeric(1) NULL,
	itemped_cdcolecao numeric(3) NULL,
	itemped_vlrdescontoitens numeric(38, 10) NULL,
	itemped_vlrtotalbruto numeric(38, 10) NULL,
	itemped_vlrtotalfaturado numeric(38, 10) NULL,
	itemped_valorunitario numeric(10, 2) NULL,
	itemped_seqitem numeric(3) NULL,
	itemped_codigodeposito numeric(3) NULL,
	ped_classificacao numeric(5) NULL,
	ped_funcionario numeric(6) NULL,
	ped_moeda text NULL,
	ped_cod_situacao_venda numeric(2) NULL,
	itemped_qtdsugerida numeric(12, 3) NULL,
	itemped_qtdafaturar numeric(15, 3) NULL,
	itemped_qtd_faturada numeric(15, 3) NULL,
	ped_cod_natureza numeric(3) NULL,
	itemped_cod_natureza numeric(4) NULL,
	natureza_venda text NULL,
	ped_desconto1 numeric(6, 2) NULL,
	ped_desconto2 numeric(6, 2) NULL,
	ped_desconto3 numeric(6, 2) NULL,
	ped_desconto_item_1 numeric(6, 2) NULL,
	ped_desconto_item_2 numeric(6, 2) NULL,
	ped_desconto_item_3 numeric(6, 2) NULL,
	ped_desconto_especial numeric(15, 2) NULL,
	ped_valor_despesas numeric(15, 2) NULL,
	itemped_vlr_franchising numeric(38, 10) NULL,
	itemped_valor_exportacao numeric(38, 10) NULL,
	itemped_valor_pedido numeric(38, 10) NULL,
	dthora_atualizacao timestamp NULL,
	canal text NULL,
	canal_new text NULL,
	live_dt_entr_original timestamp NULL,
	itemped_valorunitariobruto numeric(17, 4) NULL
);


-- temporario.jma_fcompras_cc definição

-- Drop table

-- DROP TABLE temporario.jma_fcompras_cc;

CREATE TABLE temporario.jma_fcompras_cc (
	nr_duplicata int4 NULL,
	numero_contrato int2 NULL,
	origem_debito varchar(60) NULL,
	cod_tipo_servico int4 NULL,
	servico int2 NULL,
	data_contrato varchar(75) NULL,
	data_vencimento varchar(75) NULL,
	data_emissao_nf varchar(75) NULL,
	data_transacao_nf varchar(75) NULL,
	serie varchar(3) NULL,
	documento int4 NULL,
	centro_custo int4 NULL,
	nome_centro_custo varchar(20) NULL,
	codigo_contabil int4 NULL,
	num_contabil int4 NULL,
	conta_estoque int2 NULL,
	codigo_transacao int2 NULL,
	pedido_compra int4 NULL,
	sequencia_pedido int4 NULL,
	nome_fornecedor varchar(70) NULL,
	cnpj_fornecedor varchar(4000) NULL,
	natur_operacao int2 NULL,
	descr_nat_oper varchar(40) NULL,
	codigo_produto varchar(111) NULL,
	quantidade numeric(17, 3) NULL,
	unidade_medida varchar(2) NULL,
	valor_unitario numeric(25, 5) NULL,
	parcela varchar(3) NULL,
	valor_parcela numeric(17, 2) NULL,
	valor_total numeric(17, 2) NULL,
	condicao_pagto int2 NULL
);


-- temporario.jma_fcompras_produtos definição

-- Drop table

-- DROP TABLE temporario.jma_fcompras_produtos;

CREATE TABLE temporario.jma_fcompras_produtos (
	pedido_compra int4 NULL,
	codigo_contabil int4 NULL,
	codigo_transacao int4 NULL,
	sequencia_pedido int4 NULL,
	fk_condicao_pagamento int2 NULL,
	serie varchar(3) NULL,
	documento int4 NULL,
	conta_estoque int2 NULL,
	ultima_atualizacao timestamp NULL,
	fk_fornecedor varchar(50) NULL,
	fk_grupo_contas int2 NULL,
	fk_produto varchar(60) NULL,
	unidade_medida varchar(2) NULL,
	data_emissao timestamp NULL,
	quantidade numeric(17, 3) NULL,
	valor_unitario numeric(25, 5) NULL,
	valor_total numeric(17, 2) NULL
);


-- temporario.jma_fconfer_caixas definição

-- Drop table

-- DROP TABLE temporario.jma_fconfer_caixas;

CREATE TABLE temporario.jma_fconfer_caixas (
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	qtde_pecas_conferidas int4 NULL,
	ultima_atualizacao timestamp NULL,
	data_abertura timestamp NULL
);


-- temporario.jma_fconfer_pecas_caixa definição

-- Drop table

-- DROP TABLE temporario.jma_fconfer_pecas_caixa;

CREATE TABLE temporario.jma_fconfer_pecas_caixa (
	tipo varchar(13) NULL,
	codigo_transferencia varchar(18) NULL,
	numero_caixa int4 NULL,
	codigo_barras varchar(16) NULL,
	produto varchar(65) NULL,
	data_bipagem timestamp NULL,
	data_bipagem_recebido timestamp NULL,
	situacao varchar(8) NULL,
	ultima_atualizacao timestamp NULL,
	sku varchar(80) NULL
);


-- temporario.jma_fconsertos definição

-- Drop table

-- DROP TABLE temporario.jma_fconsertos;

CREATE TABLE temporario.jma_fconsertos (
	num_conserto numeric(9) NULL,
	dat_emissao_aux timestamp NULL,
	cod_situa_conserto numeric(1) NULL,
	nom_usuario text NULL,
	cod_estagio_ident_conserto numeric(5) NULL,
	cod_estagio_para_conserto numeric(5) NULL,
	obs_conserto text NULL,
	num_ordem_servico numeric(9) NULL,
	seq_ordem_servico numeric(3) NULL,
	num_cnpj_fornec_9 numeric(38, 10) NULL,
	cnpj_fornec text NULL,
	cod_periodo_producao numeric(4) NULL,
	num_ordem_producao numeric(9) NULL,
	num_ordem_confeccao numeric(5) NULL,
	cod_refere_aux text NULL,
	qtd_pecas_conserto numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fconsignadainteg definição

-- Drop table

-- DROP TABLE temporario.jma_fconsignadainteg;

CREATE TABLE temporario.jma_fconsignadainteg (
	cd_loja varchar(6) NULL,
	dt_retirada timestamp NULL,
	dt_devol timestamp NULL,
	cd_status_devol varchar(8) NULL,
	qtd_consignada int4 NULL,
	vlr_preco_venda numeric(20, 4) NULL,
	vlr_perc_desconto numeric(20, 4) NULL,
	vlr_total numeric(20, 4) NULL,
	cd_vendido varchar(8) NULL,
	dthora_atualizacao timestamp NULL,
	cd_contr int4 NULL,
	dt_prev timestamp NULL,
	pk_consignado varchar(55) NULL,
	fk_produto varchar(20) NULL,
	cd_vendedor varchar(4) NULL,
	cd_loja_vendedor varchar(4) NULL,
	ds_cargo_vendedor varchar(100) NULL,
	status_vendedor varchar(10) NULL
);


-- temporario.jma_fconsumo_componente_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fconsumo_componente_inc;

CREATE TABLE temporario.jma_fconsumo_componente_inc (
	tecido varchar(5) NULL,
	descricao varchar(30) NULL,
	tamanho varchar(3) NULL,
	u_m varchar(2) NULL,
	pk_produto varchar(111) NULL,
	consumo numeric(21, 3) NULL,
	cod_linha_produto int2 NULL,
	cod_artigo int2 NULL,
	cod_publico_alvo int2 NULL,
	cod_estagio int4 NULL,
	pk_componente varchar(111) NULL,
	preco_informado numeric(21, 3) NULL,
	preco_ult_compra numeric(21, 3) NULL,
	preco_medio numeric(21, 3) NULL,
	situacao_comp varchar(32) NULL,
	um_componente varchar(2) NULL,
	ult_atualizacao timestamp NULL,
	composicao varchar(203) NULL,
	gramatura numeric(21, 3) NULL,
	largura numeric(21, 3) NULL,
	rendimento numeric(21, 3) NULL,
	conta_de_estoque varchar(100) NULL,
	colecao varchar(80) NULL,
	peso_rolo numeric(21, 3) NULL,
	data_cadastro timestamp NULL,
	alternativa_item int8 NULL
);
CREATE INDEX jma_fconsumo_componente_inc_consumo_situacao_comp_cod_estag_idx ON temporario.jma_fconsumo_componente_inc USING btree (consumo, situacao_comp, cod_estagio, pk_produto);
CREATE INDEX jma_fconsumo_componente_inc_consumo_situacao_comp_descrica_idx1 ON temporario.jma_fconsumo_componente_inc USING btree (consumo, situacao_comp, descricao, colecao, cod_estagio, pk_componente);
CREATE INDEX jma_fconsumo_componente_inc_consumo_situacao_comp_descricao_idx ON temporario.jma_fconsumo_componente_inc USING btree (consumo, situacao_comp, descricao, colecao, cod_estagio, pk_componente);
CREATE INDEX jma_fconsumo_componente_inc_pk_componente_idx ON temporario.jma_fconsumo_componente_inc USING btree (pk_componente);


-- temporario.jma_fcontrole_partes definição

-- Drop table

-- DROP TABLE temporario.jma_fcontrole_partes;

CREATE TABLE temporario.jma_fcontrole_partes (
	descricao_parte varchar(30) NULL,
	parte_conjunto int2 NULL,
	qtde_parte_peca int2 NULL,
	tipo_corte_peca int2 NULL,
	tipo_enfesto_1 int2 NULL,
	tipo_enfesto_2 int2 NULL,
	alternativa_item int2 NULL,
	sequencia int2 NULL,
	alternativa_comp int2 NULL,
	estagio int4 NULL,
	qtde_camadas int4 NULL,
	centro_custo int4 NULL,
	inf_casado int2 NULL,
	grupo_estrutura varchar(5) NULL,
	inf_sentido int2 NULL,
	inf_casado_1 int2 NULL,
	inf_desenho int2 NULL,
	referencia varchar(111) NULL,
	componente varchar(111) NULL,
	comprimento_debrum numeric(10, 2) NULL,
	largura_debrum numeric(11, 3) NULL
);


-- temporario.jma_fdefeitos_producao definição

-- Drop table

-- DROP TABLE temporario.jma_fdefeitos_producao;

CREATE TABLE temporario.jma_fdefeitos_producao (
	cod_estagio numeric(5) NULL,
	cod_estagio_digitacao numeric(5) NULL,
	cod_motivo numeric(3) NULL,
	num_ordem_confeccao numeric(5) NULL,
	cod_periodo numeric(4) NULL,
	num_ordem_producao numeric(9) NULL,
	cod_agrupador numeric(4) NULL,
	pk_defeito numeric(4) NULL,
	ultima_atualizacao timestamp NULL,
	data_rejeicao timestamp NULL,
	pk_produto varchar(35) NULL,
	des_motivo varchar(60) NULL,
	des_cod_motivo varchar(132) NULL,
	obs_perda varchar(1000) NULL,
	qtd_perda numeric(18, 3) NULL,
	tip_lancto varchar(20) NULL,
	des_agrupador varchar(40) NULL,
	pk_motivo varchar(20) NULL
);


-- temporario.jma_fdre_lojas definição

-- Drop table

-- DROP TABLE temporario.jma_fdre_lojas;

CREATE TABLE temporario.jma_fdre_lojas (
	id int4 NULL,
	cnpj_loja varchar(18) NULL,
	apelido varchar(200) NULL,
	ano_dre int2 NULL,
	mes_dre int2 NULL,
	tipo_dre int2 NULL,
	propriedade varchar(150) NULL,
	val_real_ano_ant numeric(18, 3) NULL,
	perc_real_ano_ant numeric(18, 3) NULL,
	val_orcado numeric(18, 3) NULL,
	perc_orcado numeric(18, 3) NULL,
	val_real numeric(18, 3) NULL,
	perc_real numeric(18, 3) NULL,
	val_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_real_vig_ant numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	seq_consulta varchar(20) NULL
);


-- temporario.jma_fdre_orcado_lojas definição

-- Drop table

-- DROP TABLE temporario.jma_fdre_orcado_lojas;

CREATE TABLE temporario.jma_fdre_orcado_lojas (
	id int4 NULL,
	seq_consulta varchar(50) NULL,
	cnpj_loja varchar(18) NULL,
	apelido varchar(200) NULL,
	ano_orcamento int2 NULL,
	mes_orcamento int2 NULL,
	propriedade varchar(150) NULL,
	tipo_orcamento int2 NULL,
	valor_orcado numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fduplicatainteg_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fduplicatainteg_inc;

CREATE TABLE temporario.jma_fduplicatainteg_inc (
	documento int8 NULL,
	portal int8 NULL,
	loja varchar(20) NULL,
	cnpj_emp varchar(40) NULL,
	cod_cliente int8 NULL,
	numorcamento int8 NULL,
	codpgto varchar(10) NULL,
	forma_pgto varchar(50) NULL,
	qtde_parcelas int2 NULL,
	ordem_parcela int2 NULL,
	data_emissao timestamp NULL,
	data_vencimento timestamp NULL,
	data_baixa timestamp NULL,
	ultima_atualizacao timestamp NULL,
	identificador varchar(40) NULL,
	valor_fatura numeric(18, 3) NULL,
	valor_pago numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	valor_juros numeric(18, 3) NULL
);


-- temporario.jma_feficiencia_prod_marft definição

-- Drop table

-- DROP TABLE temporario.jma_feficiencia_prod_marft;

CREATE TABLE temporario.jma_feficiencia_prod_marft (
	"DATA" timestamp NULL,
	maquina varchar(25) NULL,
	turno int2 NULL,
	min_dispo int4 NULL,
	operador int2 NULL,
	capacidade numeric(18, 3) NULL,
	minutos_trabalhado numeric(18, 3) NULL,
	minutos_produzido numeric(18, 3) NULL,
	eficiencia numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	pecas_produzidas numeric(18, 3) NULL,
	minutos_parados numeric(18, 3) NULL,
	minutos_perdidos numeric(18, 3) NULL,
	real_eficiencia numeric(18, 3) NULL,
	perc_real_efic numeric(18, 3) NULL,
	perd_eficiencia numeric(18, 3) NULL,
	perc_perd_efic numeric(18, 3) NULL,
	parada numeric(18, 3) NULL,
	perc_parada numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	capacidade_ajustada numeric(18, 3) NULL
);


-- temporario.jma_feficiencia_prod_operador_marft definição

-- Drop table

-- DROP TABLE temporario.jma_feficiencia_prod_operador_marft;

CREATE TABLE temporario.jma_feficiencia_prod_operador_marft (
	"data" timestamp NULL,
	maquina text NULL,
	turno numeric(3) NULL,
	min_dispo numeric(5) NULL,
	operador numeric(3) NULL,
	codigo_operador numeric(5) NULL,
	nome_operador text NULL,
	capacidade numeric(10) NULL,
	minutos_trabalhado numeric(10) NULL,
	minutos_produzido numeric(8, 2) NULL,
	eficiencia numeric(6, 4) NULL,
	perc_eficiencia numeric(38, 10) NULL,
	pecas_produzidas numeric(10) NULL,
	minutos_parados numeric(10) NULL,
	minutos_perdidos numeric(10) NULL,
	real_eficiencia numeric(6, 4) NULL,
	perc_real_efic numeric(38, 10) NULL,
	perd_eficiencia numeric(6, 4) NULL,
	perc_perd_efic numeric(38, 10) NULL,
	parada numeric(5, 4) NULL,
	perc_parada numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_festoque_produtos definição

-- Drop table

-- DROP TABLE temporario.jma_festoque_produtos;

CREATE TABLE temporario.jma_festoque_produtos (
	narrativa varchar(65) NULL,
	unidade_medida varchar(2) NULL,
	conta_estoque int2 NULL,
	deposito int2 NULL,
	fk_produto varchar(35) NULL,
	qtde_pedida_item numeric(18, 3) NULL,
	data_estoque timestamp NULL,
	cod_erp varchar(35) NULL,
	qtde_empenhada numeric(18, 3) NULL,
	qtde_estoque_atu numeric(18, 3) NULL,
	qtde_sugerida numeric(18, 3) NULL
);


-- temporario.jma_festrutura_produto definição

-- Drop table

-- DROP TABLE temporario.jma_festrutura_produto;

CREATE TABLE temporario.jma_festrutura_produto (
	pk_produto varchar(18) NULL,
	cod_referencia varchar(5) NULL,
	cod_componente varchar(18) NULL,
	fk_sequencia int4 NULL,
	fk_estagio int4 NULL,
	consumo numeric(18, 3) NULL,
	qtd_camadas numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_ffaixas_comissao definição

-- Drop table

-- DROP TABLE temporario.jma_ffaixas_comissao;

CREATE TABLE temporario.jma_ffaixas_comissao (
	tipo_info varchar(23) NULL,
	cod_loja float8 NULL,
	cargo float8 NULL,
	faixa float8 NULL,
	valor_inicio numeric(18, 3) NULL,
	valor_fim numeric(18, 3) NULL,
	percentual_inicio numeric(18, 3) NULL,
	percentual_fim numeric(18, 3) NULL,
	comissao numeric(18, 3) NULL,
	ultima_atualizao timestamp NULL
);


-- temporario.jma_ffaixas_comissao_omnichannel definição

-- Drop table

-- DROP TABLE temporario.jma_ffaixas_comissao_omnichannel;

CREATE TABLE temporario.jma_ffaixas_comissao_omnichannel (
	cod_loja int4 NULL,
	faixa int2 NULL,
	comissao numeric(18, 3) NULL,
	tempo_medio int2 NULL,
	valor_atingido numeric(18, 3) NULL,
	valor_nao_atingido numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_ffaturamento definição

-- Drop table

-- DROP TABLE temporario.jma_ffaturamento;

CREATE TABLE temporario.jma_ffaturamento (
	pk_cliente varchar(18) NULL,
	pk_produto varchar(18) NULL,
	nf_dataemissao timestamp NULL,
	nf_nrseqitempedido int2 NULL,
	data_embarque timestamp NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	tipo_nota varchar(11) NULL,
	nf_notafiscal int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_serienotafiscal varchar(4) NULL,
	nf_cdrep float8 NULL,
	ultima_atualizacao timestamp NULL,
	nf_origem int8 NULL,
	nf_tipo_1dev_0ven int2 NULL,
	nf_cdempresa float8 NULL,
	nf_condpgto int2 NULL,
	nf_cdcancelamento int2 NULL,
	cfop varchar(44) NULL,
	cod_devolucao numeric(40) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrfat numeric(18, 3) NULL,
	itemnf_vlrrateio numeric(18, 3) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	itemnf_pesoliquido numeric(18, 3) NULL,
	nf_cod_situacao int2 NULL,
	nf_desc_situacao varchar(11) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_vlr_contabil numeric(18, 3) NULL,
	data_transacao timestamp NULL,
	itemnf_qtdfaturada numeric(18, 3) NULL,
	nf_cod_natureza int8 NULL,
	itemnf_cod_natureza int8 NULL,
	natureza_venda varchar(3) NULL,
	codigo_deposito int8 NULL,
	cod_funcionario numeric(18, 3) NULL,
	vlr_desc_especial numeric(18, 3) NULL,
	itemnf_vlr_franchising numeric(21, 3) NULL,
	ped_vlr_desc_especial numeric(18, 3) NULL,
	pk_loja varchar(25) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX jma_ffaturamento_nf_dataemissao_tipo_nota_nf_cdempresa_pk_c_idx ON temporario.jma_ffaturamento USING btree (nf_dataemissao, tipo_nota, nf_cdempresa, pk_cliente, nf_desc_situacao);
CREATE INDEX jma_ffaturamento_nf_notafiscal_nf_serienotafiscal_idx ON temporario.jma_ffaturamento USING btree (nf_notafiscal, nf_serienotafiscal);
CREATE INDEX jma_ffaturamento_nf_nrpedidovenda_idx ON temporario.jma_ffaturamento USING btree (nf_nrpedidovenda);
CREATE INDEX jma_ffaturamento_nf_nrpedidovenda_pk_produto_nf_dataemissao_idx ON temporario.jma_ffaturamento USING btree (nf_nrpedidovenda, pk_produto, nf_dataemissao);


-- temporario.jma_ffaturamento_dev_inc definição

-- Drop table

-- DROP TABLE temporario.jma_ffaturamento_dev_inc;

CREATE TABLE temporario.jma_ffaturamento_dev_inc (
	pk_cliente varchar(17) NULL,
	pk_produto varchar(20) NULL,
	cd_barra varchar(18) NULL,
	nf_cdrep int4 NULL,
	nf_cdempresa int4 NULL,
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(3) NULL,
	nf_dataemissao varchar(10) NULL,
	nf_dtemissao timestamp NULL,
	nf_datadigitacao timestamp NULL,
	nf_condpgto int4 NULL,
	nf_cdcancelamento int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_nrseqitempedido int4 NULL,
	nf_origem int4 NULL,
	nf_tipo_1dev_0ven int4 NULL,
	nf_cod_situacao int4 NULL,
	nf_cod_natureza int4 NULL,
	itemnf_cod_natureza int4 NULL,
	natureza_venda varchar(5) NULL,
	nf_desc_situacao varchar(12) NULL,
	data_embarque timestamp NULL,
	cod_funcionario int4 NULL,
	cfop varchar(12) NULL,
	desc_nat_oper varchar(50) NULL,
	uf varchar(5) NULL,
	cod_devolucao varchar(50) NULL,
	mot_devolucao varchar(40) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_qtdfaturada numeric(8, 2) NULL,
	itemnf_vlrunit numeric(10, 2) NULL,
	itemnf_vlrfat numeric(10, 2) NULL,
	itemnf_vlr_contabil numeric(10, 2) NULL,
	itemnf_vlrrateio numeric(12, 2) NULL,
	itemnf_vlr_tot numeric(12, 2) NULL,
	valor_desconto numeric(12, 2) NULL,
	itemnf_vlripi numeric(12, 2) NULL,
	itemnf_vlricms numeric(12, 2) NULL,
	itemnf_vlricmsdiferido numeric(12, 2) NULL,
	itemnf_vlrpis numeric(12, 2) NULL,
	itemnf_vlrcofins numeric(12, 2) NULL,
	itemnf_pesoliquido numeric(12, 2) NULL,
	itemnf_vlr_franchising numeric(12, 2) NULL,
	perc_desc_fran numeric(12, 2) NULL,
	tipo_nota varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	data_transacao varchar(15) NULL,
	codigo_deposito numeric(12, 2) NULL,
	canal varchar(100) NULL,
	modalidade varchar(50) NULL,
	live_dt_entr_original timestamp NULL,
	nf_formapgto int8 NULL
);
CREATE INDEX jma_ffaturamento_dev_inc_tipo_nota_idx ON temporario.jma_ffaturamento_dev_inc USING btree (tipo_nota);


-- temporario.jma_ffaturamento_eua definição

-- Drop table

-- DROP TABLE temporario.jma_ffaturamento_eua;

CREATE TABLE temporario.jma_ffaturamento_eua (
	mes varchar(6) NULL,
	loja varchar(20) NULL,
	"SUM(DADOS.QUANTIDADE)" int8 NULL,
	ano varchar(5) NULL,
	ultima_atualizacao timestamp NULL,
	mes_ano varchar(20) NULL,
	"SUM(DADOS.VALORDOLAR)" numeric(12, 2) NULL,
	"SUM(DADOS.VALORREAL)" numeric(12, 2) NULL
);


-- temporario.jma_ffaturamento_inc definição

-- Drop table

-- DROP TABLE temporario.jma_ffaturamento_inc;

CREATE TABLE temporario.jma_ffaturamento_inc (
	pk_cliente varchar(18) NULL,
	pk_produto varchar(18) NULL,
	nf_dataemissao timestamp NULL,
	nf_nrseqitempedido int2 NULL,
	data_embarque timestamp NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	tipo_nota varchar(11) NULL,
	nf_notafiscal int4 NULL,
	nf_nrpedidovenda int4 NULL,
	nf_serienotafiscal varchar(4) NULL,
	nf_cdrep float8 NULL,
	ultima_atualizacao timestamp NULL,
	nf_origem int8 NULL,
	nf_tipo_1dev_0ven int2 NULL,
	nf_cdempresa float8 NULL,
	nf_condpgto int2 NULL,
	nf_cdcancelamento int2 NULL,
	cfop varchar(44) NULL,
	cod_devolucao numeric(40) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrfat numeric(18, 3) NULL,
	itemnf_vlrrateio numeric(18, 3) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	valor_desconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	itemnf_pesoliquido numeric(18, 3) NULL,
	nf_cod_situacao int2 NULL,
	nf_desc_situacao varchar(11) NULL,
	emite_duplicata int2 NULL,
	faturamento int2 NULL,
	itemnf_vlr_contabil numeric(18, 3) NULL,
	data_transacao timestamp NULL,
	itemnf_qtdfaturada numeric(18, 3) NULL,
	nf_cod_natureza int8 NULL,
	itemnf_cod_natureza int8 NULL,
	natureza_venda varchar(3) NULL,
	codigo_deposito int8 NULL,
	cod_funcionario numeric(18, 3) NULL,
	vlr_desc_especial numeric(18, 3) NULL,
	itemnf_vlr_franchising numeric(21, 3) NULL,
	ped_vlr_desc_especial numeric(18, 3) NULL,
	pk_loja varchar(25) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX jma_ffaturamento_inc_nf_dataemissao_tipo_nota_nf_cdempresa__idx ON temporario.jma_ffaturamento_inc USING btree (nf_dataemissao, tipo_nota, nf_cdempresa, pk_cliente, nf_desc_situacao);
CREATE INDEX jma_ffaturamento_inc_nf_notafiscal_nf_serienotafiscal_idx ON temporario.jma_ffaturamento_inc USING btree (nf_notafiscal, nf_serienotafiscal);
CREATE INDEX jma_ffaturamento_inc_nf_nrpedidovenda_idx ON temporario.jma_ffaturamento_inc USING btree (nf_nrpedidovenda);
CREATE INDEX jma_ffaturamento_inc_nf_nrpedidovenda_pk_produto_nf_dataemi_idx ON temporario.jma_ffaturamento_inc USING btree (nf_nrpedidovenda, pk_produto, nf_dataemissao);


-- temporario.jma_ffaturamento_internacional definição

-- Drop table

-- DROP TABLE temporario.jma_ffaturamento_internacional;

CREATE TABLE temporario.jma_ffaturamento_internacional (
	pk_loja_internacional int4 NULL,
	qtd_faturado int2 NULL,
	tickets int2 NULL,
	dthora_atualizacao timestamp NULL,
	desc_loja varchar(40) NULL,
	valor_dolar numeric(18, 3) NULL,
	valor_real numeric(18, 3) NULL,
	data_fat timestamp NULL
);


-- temporario.jma_ffaturamento_nacional definição

-- Drop table

-- DROP TABLE temporario.jma_ffaturamento_nacional;

CREATE TABLE temporario.jma_ffaturamento_nacional (
	tipo_faturamento varchar(20) NULL,
	exercicio int4 NULL,
	data_lancto timestamp NULL,
	cod_empresa int4 NULL,
	desc_empresa varchar(50) NULL,
	conta_contabil varchar(25) NULL,
	conta_reduzida int4 NULL,
	chave int4 NULL,
	seqchave int4 NULL,
	complemento_historico varchar(100) NULL,
	desc_plano_conta varchar(60) NULL,
	ultima_atualizacao timestamp NULL,
	canal_distr varchar(16) NULL,
	credito numeric(12, 2) NULL
);


-- temporario.jma_fhists_mov_estq_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fhists_mov_estq_inc;

CREATE TABLE temporario.jma_fhists_mov_estq_inc (
	periodo int2 NULL,
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	sequencia int4 NULL,
	nivel varchar(1) NULL,
	grupo varchar(5) NULL,
	subgrupo varchar(3) NULL,
	item varchar(6) NULL,
	data_hora timestamp NULL,
	tipo varchar(1) NULL,
	usuario varchar(100) NULL,
	endereco varchar(100) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_finformacoes_coleta_inc definição

-- Drop table

-- DROP TABLE temporario.jma_finformacoes_coleta_inc;

CREATE TABLE temporario.jma_finformacoes_coleta_inc (
	fk_produto varchar(18) NULL,
	cod_usuario varchar(5) NULL,
	volume varchar(9) NULL,
	dt_montagem timestamp NULL,
	turno int2 NULL,
	situacao_volume int2 NULL,
	solicitacao_volume varchar(6) NULL,
	tipo_volume varchar(6) NULL,
	cod_empresa varchar(3) NULL,
	nota_fiscal varchar(9) NULL,
	ordem_confeccao varchar(5) NULL,
	periodo_ordem varchar(4) NULL,
	qtd_pecas_real int4 NULL,
	sequencia_item varchar(3) NULL,
	estoque_tag varchar(1) NULL,
	deposito varchar(3) NULL,
	data_tag timestamp NULL,
	qtd_pc_coletada int8 NULL,
	qtd_pc_mont_volume int4 NULL,
	qtd_pc_diferenca int4 NULL,
	qtd_pc_conf_volume int4 NULL,
	qtd_pc_fora_volume int4 NULL,
	observacao_volume varchar(100) NULL,
	peso_volume numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	fk_pedido int4 NULL
);


-- temporario.jma_finspecao_qualidade definição

-- Drop table

-- DROP TABLE temporario.jma_finspecao_qualidade;

CREATE TABLE temporario.jma_finspecao_qualidade (
	data_inspecao timestamp NULL,
	id_inspecao numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	periodo numeric(4) NULL,
	turno numeric(1) NULL,
	cod_estagio numeric(5) NULL,
	inspetor text NULL,
	pk_produto text NULL,
	grupo_maq_estamp text NULL,
	subgrupo_maq_estamp text NULL,
	revisor_origem text NULL,
	qtde_inspecionar_pcs numeric(6) NULL,
	perc_inspecionar_pcs numeric(3) NULL,
	qtde_inspecionada_pcs numeric(6) NULL,
	qtde_rejeitada_pcs numeric(6) NULL,
	perc_rejeitada_pcs numeric(3) NULL,
	tipo_inspecao numeric(1) NULL,
	id_lancamento numeric(9) NULL,
	cod_estagio_defeito numeric(5) NULL,
	cod_motivo numeric(3) NULL,
	motivo text NULL,
	qtd_inspecao numeric(6) NULL,
	cod_chave_inspecao_medidas numeric(9) NULL,
	cod_chave_inspecao numeric(9) NULL,
	cod_chave_lancamento numeric(9) NULL,
	tip_medida numeric(2) NULL,
	seq_inspecao numeric(3) NULL,
	des_inspecao text NULL,
	val_medida_padrao numeric(7, 3) NULL,
	val_medida_real numeric(7, 3) NULL,
	val_toler_minima numeric(6, 2) NULL,
	val_toler_maxima numeric(6, 2) NULL,
	val_variacao numeric(7, 3) NULL,
	cod_usuario text NULL,
	dat_hor_inspecao timestamp NULL,
	data_atualizacao timestamp NULL
);


-- temporario.jma_finspecao_qualidade_inc definição

-- Drop table

-- DROP TABLE temporario.jma_finspecao_qualidade_inc;

CREATE TABLE temporario.jma_finspecao_qualidade_inc (
	data_inspecao timestamp NULL,
	id_inspecao numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	periodo numeric(4) NULL,
	turno numeric(1) NULL,
	cod_estagio numeric(2) NULL,
	inspetor text NULL,
	pk_produto text NULL,
	grupo_maq_estamp text NULL,
	subgrupo_maq_estamp text NULL,
	revisor_origem text NULL,
	qtde_inspecionar_pcs numeric(6) NULL,
	perc_inspecionar_pcs numeric(3) NULL,
	qtde_inspecionada_pcs numeric(6) NULL,
	qtde_rejeitada_pcs numeric(6) NULL,
	perc_rejeitada_pcs numeric(3) NULL,
	tipo_inspecao numeric(1) NULL,
	id_lancamento numeric(9) NULL,
	cod_estagio_defeito numeric(2) NULL,
	cod_motivo numeric(3) NULL,
	motivo text NULL,
	qtd_inspecao numeric(6) NULL,
	cod_chave_inspecao_medidas numeric(9) NULL,
	cod_chave_inspecao numeric(9) NULL,
	cod_chave_lancamento numeric(9) NULL,
	tip_medida numeric(2) NULL,
	seq_inspecao numeric(3) NULL,
	des_inspecao text NULL,
	val_medida_padrao numeric(7, 3) NULL,
	val_medida_real numeric(7, 3) NULL,
	val_toler_minima numeric(6, 2) NULL,
	val_toler_maxima numeric(6, 2) NULL,
	val_variacao numeric(7, 3) NULL,
	cod_usuario text NULL,
	dat_hor_inspecao timestamp NULL,
	data_atualizacao timestamp NULL
);


-- temporario.jma_flancamento_contabil_inc definição

-- Drop table

-- DROP TABLE temporario.jma_flancamento_contabil_inc;

CREATE TABLE temporario.jma_flancamento_contabil_inc (
	pk_contabil varchar(30) NULL,
	cd_empresa numeric(3) NULL,
	exercicio numeric(4) NULL,
	cd_lancamento numeric(9) NULL,
	seq_lancamento numeric(5) NULL,
	cd_origem numeric(2) NULL,
	cd_lote numeric(5) NULL,
	periodo numeric(4) NULL,
	cd_conta_contabil varchar(20) NULL,
	cd_conta_reduzida numeric(5) NULL,
	cd_centro_custo numeric(6) NULL,
	forma_pgto varchar(7) NULL,
	fk_historico numeric(4) NULL,
	fk_cliente varchar(17) NULL,
	data_lancamento timestamp NULL,
	vlr_lancamento numeric(15, 2) NULL,
	contabilizado numeric(3) NULL,
	data_contabil timestamp NULL,
	desc_usuario varchar(100) NULL,
	cd_banco numeric(3) NULL,
	cd_conta_corrente numeric(9) NULL,
	data_controle timestamp NULL,
	cd_documento numeric(9) NULL,
	data_insercao timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_flog_itens_transfer definição

-- Drop table

-- DROP TABLE temporario.jma_flog_itens_transfer;

CREATE TABLE temporario.jma_flog_itens_transfer (
	cd_pedido int4 NULL,
	cd_pedido_cliente varchar(60) NULL,
	seq_item_pedido int4 NULL,
	cd_item_trans varchar(60) NULL,
	cd_destino_venda int4 NULL,
	cd_destino_cliente varchar(60) NULL,
	seq_item_destino int4 NULL,
	controle int2 NULL,
	dt_hora_insercao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cod_cancelamento int2 NULL,
	desc_canc_pedido varchar(20) NULL,
	qtd_transferida numeric(18, 3) NULL
);
CREATE INDEX jma_flog_itens_transfer_cd_pedido_seq_item_pedido_dt_hora_i_idx ON temporario.jma_flog_itens_transfer USING btree (cd_pedido, seq_item_pedido, dt_hora_insercao);


-- temporario.jma_flogpedidos definição

-- Drop table

-- DROP TABLE temporario.jma_flogpedidos;

CREATE TABLE temporario.jma_flogpedidos (
	cd_pedido int4 NULL,
	data_alteracao timestamp NULL,
	usuario_alteracao varchar(60) NULL,
	data_embarque_old timestamp NULL,
	data_embarque_new timestamp NULL,
	dthora_atualizacao timestamp NULL,
	qtd_total_old numeric(18, 3) NULL,
	qtd_total_new numeric(18, 3) NULL,
	desconto1_old numeric(18, 3) NULL,
	desconto1_new numeric(18, 3) NULL,
	desconto2_old numeric(18, 3) NULL,
	desconto2_new numeric(18, 3) NULL,
	desconto3_old numeric(18, 3) NULL,
	desconto3_new numeric(18, 3) NULL,
	vlr_liq_itens_old numeric(18, 3) NULL,
	vlr_liq_itens_new numeric(18, 3) NULL,
	vlr_liq_pedido_old numeric(18, 3) NULL,
	vlr_liq_pedido_new numeric(18, 3) NULL
);
CREATE INDEX jma_flogpedidos_cd_pedido_data_alteracao_idx ON temporario.jma_flogpedidos USING btree (cd_pedido, data_alteracao);


-- temporario.jma_fmateriais_fornecedor definição

-- Drop table

-- DROP TABLE temporario.jma_fmateriais_fornecedor;

CREATE TABLE temporario.jma_fmateriais_fornecedor (
	fk_produto varchar(18) NULL,
	fk_fornecedor varchar(18) NULL,
	tempo_reposicao numeric(5) NULL,
	lote_multiplo numeric(12, 3) NULL,
	liberado_compra numeric(3) NULL,
	qtd_por_embalagem numeric(13, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fmeta_diario_loja definição

-- Drop table

-- DROP TABLE temporario.jma_fmeta_diario_loja;

CREATE TABLE temporario.jma_fmeta_diario_loja (
	pk_meta_dia varchar(20) NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	dia int2 NULL,
	mes_ano varchar(81) NULL,
	qtd_meta int4 NULL,
	valor_meta numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL,
	dt_meta timestamp NULL
);


-- temporario.jma_fmeta_loja definição

-- Drop table

-- DROP TABLE temporario.jma_fmeta_loja;

CREATE TABLE temporario.jma_fmeta_loja (
	pk_id_meta varchar(35) NULL,
	cd_loja int8 NULL,
	ano int8 NULL,
	mes int4 NULL,
	mes_ano varchar(86) NULL,
	qtd_meta int8 NULL,
	dthora_atualizacao timestamp NULL,
	vlr_meta numeric(17, 2) NULL
);


-- temporario.jma_fmeta_mensal_loja definição

-- Drop table

-- DROP TABLE temporario.jma_fmeta_mensal_loja;

CREATE TABLE temporario.jma_fmeta_mensal_loja (
	mes_ano varchar(8) NULL,
	pk_meta_mes varchar(20) NULL,
	dthora_atualizacao timestamp NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	qtd_meta int4 NULL,
	valor_meta numeric(18, 3) NULL
);


-- temporario.jma_fmeta_semanal_loja definição

-- Drop table

-- DROP TABLE temporario.jma_fmeta_semanal_loja;

CREATE TABLE temporario.jma_fmeta_semanal_loja (
	pk_meta_dia varchar(20) NULL,
	cod_loja int4 NULL,
	ano int2 NULL,
	mes int2 NULL,
	mes_ano varchar(20) NULL,
	valor_meta numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL,
	dt_meta timestamp NULL,
	dt_inicio timestamp NULL,
	dt_fim timestamp NULL,
	semana int2 NULL
);


-- temporario.jma_fmetasestacoes definição

-- Drop table

-- DROP TABLE temporario.jma_fmetasestacoes;

CREATE TABLE temporario.jma_fmetasestacoes (
	cod_estacao varchar(9) NULL,
	descricao_estacao varchar(150) NULL,
	cod_representante varchar(6) NULL,
	descricao_rep varchar(100) NULL,
	tipo_meta varchar(3) NULL,
	mes varchar(2) NULL,
	ano varchar(4) NULL,
	cod_agrupador varchar(9) NULL,
	descricao varchar(50) NULL,
	colecao varchar(3) NULL,
	ultima_atualizacao timestamp NULL,
	valor_meta numeric(18, 3) NULL,
	perc_distribuicao numeric(18, 3) NULL,
	calc_meta numeric(18, 3) NULL
);


-- temporario.jma_fmetasorcamento definição

-- Drop table

-- DROP TABLE temporario.jma_fmetasorcamento;

CREATE TABLE temporario.jma_fmetasorcamento (
	tipo_meta varchar(1) NULL,
	desc_meta varchar(50) NULL,
	modalidade varchar(50) NULL,
	ano varchar(4) NULL,
	mes_venda varchar(9) NULL,
	ultima_atualizacao timestamp NULL,
	total numeric(18, 3) NULL,
	mes_ano varchar(15) NULL
);


-- temporario.jma_fmonitor_producao definição

-- Drop table

-- DROP TABLE temporario.jma_fmonitor_producao;

CREATE TABLE temporario.jma_fmonitor_producao (
	cod_operador int2 NULL,
	nome_operador varchar(40) NULL,
	min_trab numeric(18, 3) NULL,
	min_prod numeric(18, 3) NULL,
	efic numeric(18, 3) NULL,
	status varchar(7) NULL,
	celula_destino varchar(25) NULL,
	celula_origem varchar(25) NULL
);


-- temporario.jma_fmov_estoque_compras_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fmov_estoque_compras_inc;

CREATE TABLE temporario.jma_fmov_estoque_compras_inc (
	data_movimento timestamp NULL,
	codigo_produto varchar(111) NULL,
	deposito int2 NULL,
	entrada_saida varchar(1) NULL,
	transac_entrada int2 NULL,
	tipo_consumo int2 NULL,
	tipo_transacao varchar(1) NULL,
	descricao varchar(20) NULL,
	centro_custo int4 NULL,
	codigo_deposito int2 NULL,
	codigo_transacao int2 NULL,
	numero_documento int4 NULL,
	sequencia_documento int2 NULL,
	numero_nf float8 NULL,
	servico int2 NULL,
	quantidade numeric(15, 3) NULL,
	saldo_fisico numeric(20, 5) NULL,
	dt_inventario timestamp NULL,
	preco_medio_unitario numeric(23, 5) NULL,
	valor_contabil_unitario numeric(23, 5) NULL,
	valor_total numeric(17, 2) NULL,
	saldo_financeiro numeric(23, 5) NULL,
	data_ult_entrada timestamp NULL
);


-- temporario.jma_fmovimentacao_est definição

-- Drop table

-- DROP TABLE temporario.jma_fmovimentacao_est;

CREATE TABLE temporario.jma_fmovimentacao_est (
	data_movimento timestamp NULL,
	codigo_produto varchar(111) NULL,
	deposito int2 NULL,
	entrada_saida varchar(1) NULL,
	transac_entrada int2 NULL,
	tipo_consumo int2 NULL,
	tipo_transacao varchar(1) NULL,
	descricao varchar(20) NULL,
	centro_custo int4 NULL,
	codigo_deposito int2 NULL,
	codigo_transacao int2 NULL,
	numero_documento int4 NULL,
	sequencia_documento int2 NULL,
	numero_nf float8 NULL,
	servico int2 NULL,
	quantidade numeric(15, 3) NULL,
	saldo_fisico numeric(20, 5) NULL,
	dt_inventario timestamp NULL,
	preco_medio_unitario numeric(23, 5) NULL,
	valor_contabil_unitario numeric(23, 5) NULL,
	valor_total numeric(17, 2) NULL,
	saldo_financeiro numeric(23, 5) NULL
);


-- temporario.jma_fmovimentacoesestoque_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fmovimentacoesestoque_inc;

CREATE TABLE temporario.jma_fmovimentacoesestoque_inc (
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(20) NULL,
	fk_produto varchar(20) NULL,
	codigo_transacao int2 NULL,
	dt_movimentacao timestamp NULL,
	tipo_movimento varchar(3) NULL,
	qtd_movimento numeric(18, 3) NULL,
	qtd_saldo_fisico numeric(18, 3) NULL,
	vlr_movimento_unitario numeric(18, 3) NULL,
	vlr_saldo_financeiro numeric(18, 3) NULL,
	flag_periodo varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	cod_empresa int8 NULL,
	nome_empresa varchar(60) NULL,
	referencia varchar(20) NULL,
	tamanho varchar(20) NULL,
	cor varchar(20) NULL
);


-- temporario.jma_fmovimentacoesestoque_inm definição

-- Drop table

-- DROP TABLE temporario.jma_fmovimentacoesestoque_inm;

CREATE TABLE temporario.jma_fmovimentacoesestoque_inm (
	cd_deposito int2 NULL,
	cd_nivel_estrutura int2 NULL,
	fk_produto varchar(20) NULL,
	codigo_transacao int2 NULL,
	dt_movimentacao timestamp NULL,
	tipo_movimento varchar(3) NULL,
	qtd_movimento numeric(18, 3) NULL,
	qtd_saldo_fisico numeric(18, 3) NULL,
	vlr_movimento_unitario numeric(18, 3) NULL,
	vlr_saldo_financeiro numeric(18, 3) NULL,
	flag_periodo varchar(15) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fmovimentos_unificado_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fmovimentos_unificado_inc;

CREATE TABLE temporario.jma_fmovimentos_unificado_inc (
	portal int8 NULL,
	identificador varchar(40) NULL,
	numnf int8 NULL,
	serie varchar(15) NULL,
	id_cfop varchar(20) NULL,
	codigo_vendedor varchar(20) NULL,
	operacao varchar(20) NULL,
	flag_loja varchar(8) NULL,
	cnpj varchar(20) NULL,
	loja varchar(40) NULL,
	cod_transacao varchar(40) NULL,
	fk_produto varchar(40) NULL,
	codigo_cliente numeric(18, 3) NULL,
	qtd_tickets numeric(18, 3) NULL,
	qtd_movimento numeric(18, 3) NULL,
	qtd_pecas_pedido numeric(18, 3) NULL,
	qtd_pecas_devolucao numeric(18, 3) NULL,
	qtd_pecas_vendidas numeric(18, 3) NULL,
	pa numeric(18, 3) NULL,
	vlr_liquido numeric(18, 3) NULL,
	vlr_pedido numeric(18, 3) NULL,
	vlr_devolucao numeric(18, 3) NULL,
	data_lancamento varchar(30) NULL
);


-- temporario.jma_fmovimentosinteg definição

-- Drop table

-- DROP TABLE temporario.jma_fmovimentosinteg;

CREATE TABLE temporario.jma_fmovimentosinteg (
	portal int8 NULL,
	fk_cliente varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	fk_produto varchar(25) NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(3) NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	cnpj varchar(40) NULL,
	valor_bruto int8 NULL,
	cor varchar(6) NULL,
	tamanho varchar(5) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	descricao varchar(200) NULL,
	rede varchar(100) NULL,
	canal_distribuicao varchar(14) NULL,
	flag_movimentacao varchar(20) NULL,
	cst_icms varchar(15) NULL,
	cst_ipi varchar(15) NULL,
	cst_cofins varchar(15) NULL,
	cst_pis varchar(15) NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	qtde numeric(18, 3) NULL,
	data_lancamento timestamp NULL,
	datcancel timestamp NULL,
	cod_barra varchar(20) NULL,
	data_inicio_vigencia date NULL,
	data_fim_vigencia date NULL,
	cnpj_original varchar(40) NULL,
	cnpj_antigo varchar(18) NULL,
	de varchar(20) NULL,
	para varchar(20) NULL,
	loja_original varchar(30) NULL,
	situacao int2 NULL,
	identificador varchar(60) NULL,
	cnpj_emp varchar(20) NULL,
	loja varchar(5) NULL
);
CREATE INDEX jma_fmovimentosinteg_cnpj_data_lancamento_idx ON temporario.jma_fmovimentosinteg USING btree (cnpj, data_lancamento);
CREATE INDEX jma_fmovimentosinteg_cod_vendedor_idx ON temporario.jma_fmovimentosinteg USING btree (cod_vendedor);
CREATE INDEX jma_fmovimentosinteg_operacao_tipo_transacao_considerarvend_idx ON temporario.jma_fmovimentosinteg USING btree (operacao, tipo_transacao, considerarvenda, data_lancamento) WHERE ((cancelado)::text = 'N'::text);


-- temporario.jma_fmovimentosinteg_stage definição

-- Drop table

-- DROP TABLE temporario.jma_fmovimentosinteg_stage;

CREATE TABLE temporario.jma_fmovimentosinteg_stage (
	portal int8 NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(3) NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	fk_cliente varchar(40) NULL,
	cnpj varchar(40) NULL,
	valor_bruto int8 NULL,
	cor varchar(6) NULL,
	tamanho varchar(5) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	fk_produto varchar(25) NULL,
	descricao varchar(200) NULL,
	rede varchar(100) NULL,
	canal_distribuicao varchar(14) NULL,
	flag_movimentacao varchar(20) NULL,
	valor_liquido numeric(18, 3) NULL,
	qtde numeric(18, 3) NULL,
	cst_icms varchar(15) NULL,
	cst_ipi varchar(15) NULL,
	cst_cofins varchar(15) NULL,
	cst_pis varchar(15) NULL,
	data_lancamento timestamp NULL,
	datcancel timestamp NULL,
	cod_barra varchar(20) NULL,
	data_inicio_vigencia date NULL,
	data_fim_vigencia date NULL,
	cnpj_original varchar(40) NULL,
	cnpj_antigo varchar(18) NULL,
	de varchar(20) NULL,
	para varchar(20) NULL,
	loja_original varchar(30) NULL,
	situacao int2 NULL,
	identificador varchar(60) NULL,
	cnpj_emp varchar(20) NULL,
	loja varchar(5) NULL
);
CREATE INDEX jma_fmovimentosinteg_stage_cancelado_idx ON temporario.jma_fmovimentosinteg_stage USING btree (cancelado);
CREATE INDEX jma_fmovimentosinteg_stage_operacao_tipo_transacao_consider_idx ON temporario.jma_fmovimentosinteg_stage USING btree (operacao, tipo_transacao, considerarvenda);


-- temporario.jma_fnota_entrada_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fnota_entrada_inc;

CREATE TABLE temporario.jma_fnota_entrada_inc (
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(5) NULL,
	nf_dataemissao timestamp NULL,
	fk_produto varchar(18) NULL,
	fk_cliente varchar(20) NULL,
	fk_fornecedor varchar(20) NULL,
	nf_origem int4 NULL,
	cfop varchar(44) NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	emite_duplicata varchar(3) NULL,
	dthora_atualizacao timestamp NULL,
	pedido_compra int8 NULL,
	seq_item_pedido_compra int8 NULL,
	fk_centro_custo int8 NULL,
	fk_conta_estoque int4 NULL,
	fk_grupo_contas int4 NULL,
	cd_emite_duplicata varchar(2) NULL,
	data_digitacao timestamp NULL,
	data_transacao timestamp NULL,
	usuario_digitacao varchar(250) NULL,
	situacao_entrada int2 NULL,
	especie_docto varchar(5) NULL,
	codigo_contabil int4 NULL,
	cod_familia int4 NULL,
	descricao_familia varchar(20) NULL,
	condicao_pagto int2 NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	itemnf_quantidade numeric(18, 3) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrdesconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL
);


-- temporario.jma_fnotas_entrada_loja definição

-- Drop table

-- DROP TABLE temporario.jma_fnotas_entrada_loja;

CREATE TABLE temporario.jma_fnotas_entrada_loja (
	empresa numeric(3) NULL,
	nota_fiscal numeric(9) NULL,
	serie text NULL,
	data_emissao timestamp NULL,
	cnpj text NULL,
	qtd_volume numeric(4) NULL,
	pedido text NULL,
	data_entrega timestamp NULL,
	cfop text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_foperacao definição

-- Drop table

-- DROP TABLE temporario.jma_foperacao;

CREATE TABLE temporario.jma_foperacao (
	fk_operacao int4 NULL,
	fk_maquina varchar(8) NULL,
	tipo_operacao int2 NULL,
	pede_produto int2 NULL,
	fk_cargo int4 NULL,
	fk_aparelho varchar(6) NULL,
	operando int2 NULL,
	dthora_atualizacao timestamp NULL,
	tempo_maquina numeric(18, 3) NULL,
	tempo_homem numeric(18, 3) NULL,
	centimetros_linha numeric(18, 3) NULL
);


-- temporario.jma_fordens_beneficiamento definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_beneficiamento;

CREATE TABLE temporario.jma_fordens_beneficiamento (
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	data_inicio timestamp NULL,
	data_termino timestamp NULL,
	atraso int4 NULL,
	cod_situacao int4 NULL,
	situacao varchar(15) NULL,
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	tipo_ordem varchar(1) NULL,
	ordem_agrupamento int4 NULL,
	codigo_estagio int4 NULL,
	situacao_receita varchar(1) NULL,
	grupo_tingimento varchar(102) NULL,
	tempo float8 NULL,
	seq_operacao float8 NULL,
	pk_produto varchar(50) NULL,
	um varchar(2) NULL,
	alternativa_item int2 NULL,
	ultima_atualizacao timestamp NULL,
	quilos_prod numeric(21, 3) NULL,
	rolos_prod numeric(21, 3) NULL,
	quilos_prog numeric(21, 3) NULL,
	rolos_prog numeric(21, 3) NULL,
	quilos_prep numeric(21, 3) NULL,
	rolos_prep numeric(21, 3) NULL,
	prioridade_onebit varchar(10) NULL
);


-- temporario.jma_fordens_corte_hist definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_corte_hist;

CREATE TABLE temporario.jma_fordens_corte_hist (
	id varchar(25) NULL
);


-- temporario.jma_fordens_corte_stage definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_corte_stage;

CREATE TABLE temporario.jma_fordens_corte_stage (
	cd_ordem_producao int4 NULL,
	cd_grupo varchar(5) NULL,
	prod_rej_item varchar(6) NULL,
	periodo_producao int2 NULL,
	cd_ordem_confeccao int4 NULL,
	situacao_ordem int2 NULL,
	numero_ordem_externa int4 NULL,
	data_alteracao timestamp NULL,
	tamanho varchar(3) NULL,
	data_producao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	dt_lancamento timestamp NULL,
	dt_prevista timestamp NULL,
	prioridade int4 NULL,
	data_programacao timestamp NULL,
	periodo_producao_capa int2 NULL,
	numero_programa int2 NULL,
	cod_cancelamento int2 NULL,
	cd_nivel99 float8 NULL,
	cd_subgrupo varchar(5) NULL,
	cd_estagio int4 NULL,
	qtd_pecas_progamada numeric(18, 3) NULL,
	qtd_pecas_produzida numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_pecas_2a numeric(18, 3) NULL,
	estagio_anterior int4 NULL,
	seq_ordem_serv int2 NULL,
	qtd_perdas numeric(18, 3) NULL,
	sequencia_estagio int2 NULL,
	usuario varchar(250) NULL,
	seq_operacao int2 NULL,
	qtd_em_producao_pacote numeric(18, 3) NULL,
	minutos_unitario numeric(18, 3) NULL,
	minutos_total numeric(18, 3) NULL,
	minutos_total_em_producao numeric(18, 3) NULL,
	sequencia_tamanho int4 NULL,
	qtd_marcacoes numeric(18, 3) NULL,
	qtd_a_produzir numeric(18, 3) NULL,
	rowid varchar(100) NULL,
	fk_produto varchar(125) NULL,
	fk_fornecedor varchar(150) NULL,
	alternativa_peca int4 NULL
);


-- temporario.jma_fordens_em_producao_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_em_producao_inc;

CREATE TABLE temporario.jma_fordens_em_producao_inc (
	periodo_producao numeric(4) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	codigo_estagio numeric(5) NULL,
	sequencia_estagio numeric(3) NULL,
	estagio_anterior numeric(5) NULL,
	seq_operacao numeric(4) NULL,
	prioridade_produ numeric(5) NULL,
	alternativa_peca numeric(2) NULL,
	fk_produto text NULL,
	qtde_pecas_prog numeric(6) NULL,
	qtde_pecas_prod numeric(6) NULL,
	qtde_em_producao numeric(9) NULL,
	qtde_programada numeric(6) NULL,
	qtde_conserto numeric(6) NULL,
	qtde_pecas_2a numeric(6) NULL,
	qtde_perdas numeric(6) NULL,
	numero_ordem numeric(9) NULL,
	cnpj_fornecedor text NULL,
	ultima_atualizacao timestamp NULL,
	data_alteracao timestamp NULL,
	cod_cancelamento numeric(3) NULL
);


-- temporario.jma_fordens_malharia definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_malharia;

CREATE TABLE temporario.jma_fordens_malharia (
	fk_produto varchar(21) NULL,
	fk_maquina varchar(11) NULL,
	fk_fornecedor varchar(21) NULL,
	fk_cliente varchar(20) NULL,
	fk_produto_pano varchar(21) NULL,
	fk_produto_acab varchar(21) NULL,
	flag_ordens_malharia varchar(14) NULL,
	cd_endereco_rolo varchar(33) NULL,
	vlr_mt_lineares numeric(18, 3) NULL,
	cd_nr_lote varchar(18) NULL,
	cd_maquina int4 NULL,
	cd_programa int4 NULL,
	cd_ordem_tecelagem int4 NULL,
	cd_periodo_producao int4 NULL,
	qtd_quilos_prod numeric(15, 3) NULL,
	seq_ordem_serv int4 NULL,
	cd_tipo_prod int4 NULL,
	qtd_quilos_acab numeric(15, 3) NULL,
	qtd_unid_prog int8 NULL,
	cd_rolo int8 NULL,
	cd_nr_rolo int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fordens_produzidas_alt_item_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_produzidas_alt_item_inc;

CREATE TABLE temporario.jma_fordens_produzidas_alt_item_inc (
	cd_nivel99 varchar(1) NULL,
	cd_grupo varchar(5) NULL,
	cd_subgrupo varchar(3) NULL,
	cd_item varchar(6) NULL,
	data_producao timestamp NULL,
	periodo_producao int2 NULL,
	cd_estagio int4 NULL,
	des_estagio varchar(20) NULL,
	turno varchar(32) NULL,
	cd_ordem_producao int4 NULL,
	cd_ordem_confeccao int4 NULL,
	nome_fornecedor varchar(40) NULL,
	des_familia varchar(40) NULL,
	qtd_produzidas numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL,
	qtd_segunda numeric(18, 3) NULL,
	tempo_unit numeric(18, 3) NULL,
	tempo_costura numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	qtde_estampas numeric(18, 3) NULL,
	alternativa_peca int2 NULL,
	data_entrada_estagio timestamp NULL
);


-- temporario.jma_fordens_produzidas_homologacao definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_produzidas_homologacao;

CREATE TABLE temporario.jma_fordens_produzidas_homologacao (
	cd_nivel99 text NULL,
	cd_grupo text NULL,
	cd_subgrupo text NULL,
	cd_item text NULL,
	data_producao timestamp NULL,
	periodo_producao numeric(4) NULL,
	cd_estagio numeric(5) NULL,
	des_estagio text NULL,
	data_entrada_estagio timestamp NULL,
	turno text NULL,
	cd_ordem_producao numeric(9) NULL,
	cd_ordem_confeccao numeric(5) NULL,
	nome_fornecedor text NULL,
	des_familia text NULL,
	qtd_produzidas numeric(6) NULL,
	qtd_conserto numeric(6) NULL,
	qtd_perdas numeric(6) NULL,
	qtd_segunda numeric(6) NULL,
	tempo_unit numeric(38, 10) NULL,
	qtde_estampas numeric(38, 10) NULL,
	tempo_costura numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fordens_produzidas_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_produzidas_inc;

CREATE TABLE temporario.jma_fordens_produzidas_inc (
	cd_nivel99 varchar(1) NULL,
	cd_grupo varchar(5) NULL,
	cd_subgrupo varchar(3) NULL,
	cd_item varchar(6) NULL,
	data_producao timestamp NULL,
	periodo_producao int2 NULL,
	cd_estagio int4 NULL,
	des_estagio varchar(20) NULL,
	turno varchar(32) NULL,
	cd_ordem_producao int4 NULL,
	cd_ordem_confeccao int4 NULL,
	nome_fornecedor varchar(40) NULL,
	des_familia varchar(40) NULL,
	ultima_atualizacao timestamp NULL,
	qtd_produzidas numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL,
	qtd_segunda numeric(18, 3) NULL,
	tempo_unit numeric(18, 3) NULL,
	tempo_costura numeric(18, 3) NULL,
	qtde_estampas numeric(18, 3) NULL,
	data_entrada_estagio timestamp NULL
);
CREATE INDEX jma_fordens_produzidas_inc_cd_estagio_data_producao_periodo_idx ON temporario.jma_fordens_produzidas_inc USING btree (cd_estagio, data_producao, periodo_producao, qtd_produzidas);
CREATE INDEX jma_fordens_produzidas_inc_data_producao_idx ON temporario.jma_fordens_produzidas_inc USING btree (data_producao);


-- temporario.jma_fordens_reposicoes definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_reposicoes;

CREATE TABLE temporario.jma_fordens_reposicoes (
	id_reposicao int4 NULL,
	ordemreposicaoformatted varchar(40) NULL,
	solicitacao_reposicao int4 NULL,
	ordemreposicao int4 NULL,
	ordemproducao int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(20) NULL,
	cor varchar(6) NULL,
	estagioformatted varchar(61) NULL,
	estagio int2 NULL,
	datageracao timestamp NULL,
	usuariogerador varchar(50) NULL,
	databaixaestagio timestamp NULL,
	usuariobaixaestagio varchar(50) NULL,
	situacao int2 NULL,
	observacao varchar(200) NULL,
	solicitante varchar(60) NULL,
	motivocancelamento varchar(100) NULL,
	diasfase numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fordens_servico definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_servico;

CREATE TABLE temporario.jma_fordens_servico (
	fk_ordens_servico int4 NULL,
	cd_nr_ordem int4 NULL,
	seq int4 NULL,
	cd_lote int4 NULL,
	dt_prev_areceber timestamp NULL,
	cd_sit_areceber int2 NULL,
	cd_nota_saida int8 NULL,
	cd_serie_saida varchar(6) NULL,
	seq_nota_saida int4 NULL,
	cd_ref_forne varchar(33) NULL,
	cd_nr_ordem_origem int4 NULL,
	seq_origem int4 NULL,
	seq_entrada int4 NULL,
	data_ent timestamp NULL,
	cd_tipo_ent int4 NULL,
	cd_nr_nf_ent int8 NULL,
	cd_serie_nf_ent varchar(6) NULL,
	seq_item_nf_ent int4 NULL,
	cd_periodo_prod int4 NULL,
	cd_ordem_prod int8 NULL,
	cd_nr_titulo int8 NULL,
	cd_sit_fechamento int2 NULL,
	dthora_atualizacao timestamp NULL,
	pk_ordens_servico varchar(125) NULL,
	vlr_servico numeric(22, 4) NULL,
	qtd_areceber numeric(20, 3) NULL,
	vlr_prod numeric(18, 2) NULL,
	qtd_real_ret numeric(20, 3) NULL,
	cd_perc_imposto numeric(11, 2) NULL,
	qtd_pag numeric(21, 3) NULL,
	qtd_ent numeric(21, 3) NULL
);


-- temporario.jma_fordens_servico_itens definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_servico_itens;

CREATE TABLE temporario.jma_fordens_servico_itens (
	pk_ordens_servico_itens varchar(84) NULL,
	fk_ordens_servico_capa varchar(9) NULL,
	cd_nr_ordem numeric(9) NULL,
	seq numeric(6) NULL,
	cd_lote numeric(6) NULL,
	dt_prev_areceber date NULL,
	vlr_servico numeric(18, 4) NULL,
	qtd_areceber numeric(17, 3) NULL,
	cd_sit_areceber numeric(4) NULL,
	vlr_prod numeric(16, 2) NULL,
	cd_nota_saida numeric(12) NULL,
	cd_serie_saida varchar(6) NULL,
	seq_nota_saida numeric(6) NULL,
	qtd_real_ret numeric(17, 3) NULL,
	cd_ref_forne varchar(33) NULL,
	cd_perc_imposto numeric(9, 2) NULL,
	qtd_pag numeric(18, 3) NULL,
	cd_nr_ordem_origem numeric(9) NULL,
	seq_origem numeric(6) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fordens_tecelagem definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_tecelagem;

CREATE TABLE temporario.jma_fordens_tecelagem (
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	data_inicial timestamp NULL,
	data_final timestamp NULL,
	atraso int4 NULL,
	cod_situacao int4 NULL,
	situacao varchar(15) NULL,
	periodo_producao int2 NULL,
	ordem_tecelagem int4 NULL,
	codigo_estagio int4 NULL,
	seq_operacao int4 NULL,
	pk_produto varchar(85) NULL,
	um varchar(2) NULL,
	ultima_atualizacao timestamp NULL,
	quilos_prod numeric(21, 3) NULL,
	rolos_prod numeric(21, 3) NULL,
	quilos_prog numeric(21, 3) NULL,
	rolos_prog numeric(21, 3) NULL,
	saldo_quilos numeric(21, 3) NULL,
	saldo_rolos numeric(21, 3) NULL
);


-- temporario.jma_fordens_tinturaria definição

-- Drop table

-- DROP TABLE temporario.jma_fordens_tinturaria;

CREATE TABLE temporario.jma_fordens_tinturaria (
	pk_ordens_tinturaria varchar(308) NULL,
	fk_produtos varchar(21) NULL,
	fk_maquina varchar(11) NULL,
	flag_ordens_tinturaria varchar(13) NULL,
	cd_ordem_prod int8 NULL,
	cd_deposito int4 NULL,
	cd_pedido_corte int2 NULL,
	seq_ordem_prod int4 NULL,
	cd_acomp int4 NULL,
	qtd_rolos_prog numeric(16, 3) NULL,
	qtd_quilos_prog numeric(19, 3) NULL,
	qtd_quilos_prod numeric(16, 3) NULL,
	qtd_rolos_prod numeric(16, 3) NULL,
	cd_roteiro int4 NULL,
	qtd_unidade_prog numeric(21, 3) NULL,
	cd_lote_acomp int4 NULL,
	seq int4 NULL,
	qtd_unidade numeric(16, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fpagar_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fpagar_inc;

CREATE TABLE temporario.jma_fpagar_inc (
	cd_duplicata int8 NULL,
	cd_parcela varchar(5) NULL,
	sequencia_pagamento int2 NULL,
	cd_tipo_titulo int2 NULL,
	cd_empresa int4 NULL,
	documento int8 NULL,
	cd_serie varchar(5) NULL,
	cd_contabil int8 NULL,
	nr_contabil int8 NULL,
	cd_transacao int4 NULL,
	situacao numeric(31) NULL,
	data_contrato timestamp NULL,
	data_vencimento timestamp NULL,
	data_pagamento timestamp NULL,
	data_baixa timestamp NULL,
	fk_cliente varchar(20) NULL,
	fk_portador int4 NULL,
	fk_departamento int8 NULL,
	fk_historico int8 NULL,
	vlr_parcela numeric(18, 3) NULL,
	vlr_pago numeric(18, 3) NULL,
	vlr_restante numeric(18, 3) NULL,
	vlr_irrf numeric(18, 3) NULL,
	vlr_abatimento numeric(18, 3) NULL,
	vlr_inss numeric(18, 3) NULL,
	vlr_inss_imposto numeric(18, 3) NULL,
	vlr_cofins numeric(18, 3) NULL,
	vlr_cls numeric(18, 3) NULL,
	vlr_pis numeric(18, 3) NULL,
	vlr_juros numeric(18, 3) NULL,
	vlr_desconto numeric(18, 3) NULL,
	desc_emitente_titulo varchar(60) NULL,
	data_transacao timestamp NULL,
	desc_origem_debito varchar(60) NULL,
	data_cancelamento timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fpainel_planejamento definição

-- Drop table

-- DROP TABLE temporario.jma_fpainel_planejamento;

CREATE TABLE temporario.jma_fpainel_planejamento (
	fk_produto text NULL,
	cd_periodo_prod numeric(4) NULL,
	cd_area_prod numeric(1) NULL,
	cd_nr_pedido_ordem numeric(9) NULL,
	seq_pedido_ordem numeric(6) NULL,
	cd_est numeric(5) NULL,
	qtd_reservada numeric(15, 5) NULL,
	qtd_areceber numeric(15, 5) NULL,
	vlr_consumo numeric(13, 7) NULL,
	cd_tipo_calculo numeric(2) NULL,
	seq_estrutura numeric(3) NULL,
	qtd_planejada numeric(15, 5) NULL,
	data_requirida timestamp NULL,
	cd_solici_almoxari numeric(6) NULL,
	cd_seq_almoxari numeric(4) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fparametro_compra definição

-- Drop table

-- DROP TABLE temporario.jma_fparametro_compra;

CREATE TABLE temporario.jma_fparametro_compra (
	cod_empresa numeric(3) NULL,
	fk_produto text NULL,
	fk_familia_materiais numeric(5) NULL,
	estoque_minimo numeric(13, 3) NULL,
	estoque_maximo numeric(13, 3) NULL,
	tempo_reposicao numeric(5) NULL,
	lote_multiplo numeric(13, 3) NULL,
	cod_deposito numeric(3) NULL,
	bloqueia_compra numeric(1) NULL,
	dthora_atualizacao timestamp NULL,
	lote_minimo numeric(16, 3) NULL
);


-- temporario.jma_fpedido_in1 definição

-- Drop table

-- DROP TABLE temporario.jma_fpedido_in1;

CREATE TABLE temporario.jma_fpedido_in1 (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX jma_fpedido_in1_fk_produto_ped_cdpedido_idx ON temporario.jma_fpedido_in1 USING btree (fk_produto, ped_cdpedido);
CREATE INDEX jma_fpedido_in1_ped_cdpedido_idx ON temporario.jma_fpedido_in1 USING btree (ped_cdpedido);
CREATE INDEX jma_fpedido_in1_ped_pedidoorigem_ped_dataembarque_idx ON temporario.jma_fpedido_in1 USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.jma_fpedido_in2 definição

-- Drop table

-- DROP TABLE temporario.jma_fpedido_in2;

CREATE TABLE temporario.jma_fpedido_in2 (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX jma_fpedido_in2_fk_produto_ped_cdpedido_idx ON temporario.jma_fpedido_in2 USING btree (fk_produto, ped_cdpedido);
CREATE INDEX jma_fpedido_in2_ped_cdpedido_idx ON temporario.jma_fpedido_in2 USING btree (ped_cdpedido);
CREATE INDEX jma_fpedido_in2_ped_pedidoorigem_ped_dataembarque_idx ON temporario.jma_fpedido_in2 USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.jma_fpedido_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fpedido_inc;

CREATE TABLE temporario.jma_fpedido_inc (
	fk_produto varchar(25) NULL,
	ped_cdempresa int2 NULL,
	ped_cdrep int4 NULL,
	ped_cdpedido int4 NULL,
	ped_refproduto varchar(5) NULL,
	ped_dataemissao timestamp NULL,
	ped_dataembarque timestamp NULL,
	ped_codcancelamento int2 NULL,
	ped_prazomedio int2 NULL,
	ped_periodo int2 NULL,
	ped_cdcidade int4 NULL,
	ped_tabelapreco int4 NULL,
	ped_numerocontrole int2 NULL,
	ped_pedidovendaorigem int4 NULL,
	ped_pedidoorigem int4 NULL,
	ped_cfop varchar(5) NULL,
	ped_percomissaoped numeric(18, 3) NULL,
	ped_percdescped numeric(18, 3) NULL,
	ped_aceitaantecipacao int2 NULL,
	ped_aceitaantecipacaodesc varchar(3) NULL,
	permite_parcial varchar(3) NULL,
	ped_tipofrete int2 NULL,
	ped_condicaopagamento int2 NULL,
	ped_codigobanco int2 NULL,
	ped_percdescontotitulo numeric(18, 3) NULL,
	ped_pedidocliente varchar(30) NULL,
	itemped_qtdcancelada float8 NULL,
	itemped_valorcancelado numeric(18, 3) NULL,
	itemped_qtdsaldopedido float8 NULL,
	itemped_valorsaldopedido numeric(18, 3) NULL,
	itemped_qtdepedido numeric(18, 3) NULL,
	itemped_qtdeliqpedido numeric(18, 3) NULL,
	itemped_percdescontoitem numeric(18, 3) NULL,
	itemped_valorliqpedido numeric(18, 3) NULL,
	itemped_valorcomissao numeric(18, 3) NULL,
	itemped_valordescped numeric(18, 3) NULL,
	itemped_codcancelamento int2 NULL,
	itemped_datacancelamento timestamp NULL,
	itemped_desccancel varchar(20) NULL,
	itemped_tipocancelamento int2 NULL,
	itemped_cdcolecao int2 NULL,
	itemped_vlrdescontoitens numeric(18, 3) NULL,
	itemped_vlrtotalbruto numeric(18, 3) NULL,
	itemped_vlrtotalfaturado numeric(18, 3) NULL,
	itemped_valorunitario numeric(18, 3) NULL,
	itemped_seqitem int2 NULL,
	itemped_codigodeposito int2 NULL,
	fk_cliente varchar(20) NULL,
	fk_representante varchar(6) NULL,
	ped_classificacao int4 NULL,
	ped_funcionario int4 NULL,
	ped_moeda varchar(20) NULL,
	ped_cod_situacao_venda varchar(2) NULL,
	dthora_atualizacao timestamp NULL,
	itemped_qtdsugerida numeric(15, 3) NULL,
	itemped_qtdafaturar numeric(18, 3) NULL,
	ped_cod_natureza int2 NULL,
	itemped_cod_natureza int2 NULL,
	ped_desconto1 numeric(18, 3) NULL,
	ped_desconto2 numeric(18, 3) NULL,
	ped_desconto3 numeric(18, 3) NULL,
	ped_desconto_especial numeric(18, 3) NULL,
	ped_valor_despesas numeric(18, 3) NULL,
	ped_desconto_item_1 numeric(18, 3) NULL,
	ped_desconto_item_2 numeric(18, 3) NULL,
	ped_desconto_item_3 numeric(18, 3) NULL,
	itemped_vlr_franchising numeric(18, 3) NULL,
	itemped_qtd_faturada numeric(18, 3) NULL,
	natureza_venda varchar(3) NULL,
	origem_pedido int2 NULL,
	tipo_cliente int2 NULL,
	despesas_adicionais numeric(18, 3) NULL,
	ped_tipo_carteira varchar(14) NULL,
	canal varchar(100) NULL,
	flag_regra varchar(14) NULL,
	itemped_valoruni_bruto numeric(18, 3) NULL,
	codigo_barras varchar(16) NULL
);
CREATE INDEX jma_fpedido_inc_fk_produto_ped_cdpedido_idx ON temporario.jma_fpedido_inc USING btree (fk_produto, ped_cdpedido);
CREATE INDEX jma_fpedido_inc_ped_cdpedido_idx ON temporario.jma_fpedido_inc USING btree (ped_cdpedido);
CREATE INDEX jma_fpedido_inc_ped_pedidoorigem_ped_dataembarque_idx ON temporario.jma_fpedido_inc USING btree (ped_pedidoorigem, ped_dataembarque);


-- temporario.jma_fpedidos_compra definição

-- Drop table

-- DROP TABLE temporario.jma_fpedidos_compra;

CREATE TABLE temporario.jma_fpedidos_compra (
	ped_compra numeric(8) NULL,
	itemped_seq_ped numeric(4) NULL,
	obs_pedido varchar(300) NULL,
	dt_emissao_compra timestamp NULL,
	dt_prev_entrega timestamp NULL,
	fk_cond_pgto numeric(3) NULL,
	ped_vendedor varchar(60) NULL,
	fk_comprador numeric(5) NULL,
	fk_grupo_contas numeric(5) NULL,
	fk_familia numeric(8) NULL,
	itemped_qtd_pedida numeric(15, 3) NULL,
	itemped_qtd_saldo numeric(15, 3) NULL,
	itemped_qtd_recebida numeric(15, 3) NULL,
	itemped_situacao_item varchar(13) NULL,
	itemped_preco numeric(15, 5) NULL,
	itemped_percentual_desc numeric(8, 2) NULL,
	itemped_percentual_ipi numeric(8, 2) NULL,
	itemped_centro_custo numeric(8) NULL,
	itemped_cod_cancelamento numeric(4) NULL,
	dt_cancelamento timestamp NULL,
	itemped_requisicao numeric(8) NULL,
	dthora_atualizacao timestamp NULL,
	fk_produto varchar(30) NULL,
	fk_fornecedor varchar(18) NULL,
	fk_conta_estoque varchar(5) NULL,
	codigo_contabil int4 NULL
);


-- temporario.jma_fpedidos_embarque_previsto definição

-- Drop table

-- DROP TABLE temporario.jma_fpedidos_embarque_previsto;

CREATE TABLE temporario.jma_fpedidos_embarque_previsto (
	pedido_venda numeric(9) NULL,
	data_entr_venda timestamp NULL,
	situacao_venda numeric(2) NULL,
	cod_cancelamento numeric(3) NULL,
	sit_aloc_pedi numeric(1) NULL,
	sit_coletor numeric(1) NULL,
	situacao_coleta numeric(1) NULL,
	status_expedicao numeric(1) NULL,
	status_homologacao numeric(1) NULL,
	status_pedido numeric(1) NULL,
	status_comercial numeric(1) NULL,
	sit_conferencia numeric(1) NULL,
	qtde_saldo_pedi numeric(15, 3) NULL,
	valor_saldo_pedi numeric(15, 2) NULL,
	fk_produto varchar(20) NULL,
	qtde_pedida numeric(15, 3) NULL,
	qtde_sugerida numeric(15, 3) NULL,
	qtde_afaturar numeric(15, 3) NULL,
	val_liq_unt numeric(15, 3) NULL,
	valor_unitario numeric(15, 3) NULL,
	ultima_atualizacao date NULL
);


-- temporario.jma_fpedidos_url definição

-- Drop table

-- DROP TABLE temporario.jma_fpedidos_url;

CREATE TABLE temporario.jma_fpedidos_url (
	"data" varchar(20) NULL,
	hora varchar(10) NULL,
	id_pedido int8 NULL,
	cliente varchar(150) NULL,
	id_vendedor int8 NULL,
	cpf_vendedor varchar(20) NULL,
	grupo_vendedor varchar(50) NULL,
	cnpj varchar(20) NULL,
	url_loja varchar(100) NULL,
	numero_nf varchar(20) NULL,
	serie_nf varchar(10) NULL,
	omnichannel varchar(10) NULL,
	ultima_atualizacao timestamp NULL,
	tipo varchar(30) NULL,
	cupom varchar(40) NULL,
	desconto_cupom varchar(40) NULL,
	codigo_vendedor varchar(40) NULL,
	desconto_vendedor varchar(40) NULL,
	status varchar(80) NULL,
	total_liquido numeric(18, 3) NULL,
	total_desconto numeric(18, 3) NULL,
	total_bruto numeric(18, 3) NULL,
	pagamento varchar(80) NULL,
	vendedor varchar(80) NULL
);


-- temporario.jma_fpedidosintegracao definição

-- Drop table

-- DROP TABLE temporario.jma_fpedidosintegracao;

CREATE TABLE temporario.jma_fpedidosintegracao (
	codigo_registro numeric(9) NULL,
	cod_pedido_venda numeric(9) NULL,
	tecido_peca numeric(38) NULL,
	fk_cliente numeric(38) NULL,
	fk_representante numeric(38) NULL,
	pedido_cliente text NULL,
	tabela_preco numeric(38) NULL,
	situacao_importacao numeric(1) NULL,
	data_importacao timestamp NULL,
	data_emissao timestamp NULL,
	data_digitacao timestamp NULL,
	tipo_pedido numeric(1) NULL,
	origem_pedido numeric(2) NULL,
	id_pedido_forca_vendas text NULL,
	fk_produto text NULL,
	cod_deposito numeric(3) NULL,
	seq_item_pedido numeric(4) NULL,
	qtd_pedida numeric(16, 2) NULL,
	valor_unitario numeric(19, 6) NULL,
	percentual_desc_item numeric(8, 2) NULL,
	sit_importacao_item numeric(1) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fpedidostemp definição

-- Drop table

-- DROP TABLE temporario.jma_fpedidostemp;

CREATE TABLE temporario.jma_fpedidostemp (
	pedido int4 NULL,
	tipo_ocorr varchar(1) NULL,
	data_ocorr timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fportal_lojas definição

-- Drop table

-- DROP TABLE temporario.jma_fportal_lojas;

CREATE TABLE temporario.jma_fportal_lojas (
	cn_id int8 NULL,
	cn_num_nota_fiscal int4 NULL,
	cn_inicio_conferencia_volumes timestamp NULL,
	cn_ultima_leitura_volumes timestamp NULL,
	cn_ultima_leitura_tags timestamp NULL,
	cn_status_volumes int2 NULL,
	cn_desc_status_volumes varchar(14) NULL,
	tcv_id int8 NULL,
	tcv_numero_volume int4 NULL,
	tcv_inicio_conferencia timestamp NULL,
	tcv_ultima_leitura timestamp NULL,
	tcv_status_pecas int2 NULL,
	tcv_desc_status_pecas varchar(14) NULL,
	ct_id int8 NULL,
	ct_data_bip timestamp NULL,
	ct_usuario varchar(55) NULL,
	ct_status int2 NULL,
	ct_pk_produto varchar(18) NULL,
	ct_desc_status varchar(14) NULL,
	cv_id int8 NULL,
	cv_data_bip timestamp NULL,
	cv_status int2 NULL,
	cv_desc_status varchar(14) NULL,
	ra_id int8 NULL,
	ra_cnpj varchar(17) NULL,
	ra_usuario_bipou varchar(55) NULL,
	ra_nome_usuario varchar(55) NULL,
	ra_tipo int2 NULL,
	ra_status int2 NULL,
	ra_codigo_bipado varchar(100) NULL,
	ra_acao varchar(2500) NULL,
	ra_data_bipagem timestamp NULL,
	ra_codigo_empresa int2 NULL,
	ra_serie_nota_fisc varchar(3) NULL,
	ra_desc_status varchar(14) NULL,
	usu_id int8 NULL,
	usu_nome varchar(55) NULL,
	usu_usuario varchar(55) NULL,
	usu_situacao int2 NULL,
	usu_cnpj varchar(18) NULL,
	ct_numero_tag varchar(60) NULL,
	tcv_tags_conferidas numeric(18, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_fprioridade_beneficiamento_congelado_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fprioridade_beneficiamento_congelado_inc;

CREATE TABLE temporario.jma_fprioridade_beneficiamento_congelado_inc (
	prioridade int2 NULL,
	work_order_id varchar(49) NULL,
	work_center varchar(92) NULL,
	planta varchar(32) NULL,
	cliente varchar(32) NULL,
	quantidade float8 NULL,
	sku varchar(14) NULL,
	descricao_sku varchar(41) NULL,
	tipo_wo varchar(32) NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	familia_produto varchar(25) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	referencia varchar(5) NULL,
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	qtde_quilos_prog numeric(16, 3) NULL,
	qtde_rolos_prog numeric(12, 2) NULL,
	qtde_rolos_prod numeric(12, 3) NULL,
	qtde_rolos_prog_1 numeric(13, 3) NULL,
	qtde_rolos_real numeric(9, 3) NULL,
	qtde_quilos_prod numeric(12, 3) NULL,
	situacao varchar(15) NULL,
	data_atualizacao timestamp NULL
);


-- temporario.jma_fprioridade_beneficiameto_congelado_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fprioridade_beneficiameto_congelado_inc;

CREATE TABLE temporario.jma_fprioridade_beneficiameto_congelado_inc (
	prioridade int2 NULL,
	work_order_id varchar(49) NULL,
	work_center varchar(92) NULL,
	planta varchar(32) NULL,
	cliente varchar(32) NULL,
	quantidade float8 NULL,
	sku varchar(14) NULL,
	descricao_sku varchar(41) NULL,
	tipo_wo varchar(32) NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	familia_produto varchar(25) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	referencia varchar(5) NULL,
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	qtde_quilos_prog numeric(16, 3) NULL,
	qtde_rolos_prog numeric(12, 2) NULL,
	qtde_rolos_prod numeric(12, 3) NULL,
	qtde_rolos_prog_1 numeric(13, 3) NULL,
	qtde_rolos_real numeric(9, 3) NULL,
	qtde_quilos_prod numeric(12, 3) NULL,
	situacao varchar(15) NULL
);


-- temporario.jma_fprioridade_prod definição

-- Drop table

-- DROP TABLE temporario.jma_fprioridade_prod;

CREATE TABLE temporario.jma_fprioridade_prod (
	prioridade numeric(38, 10) NULL,
	work_order_id text NULL,
	work_center text NULL,
	planta text NULL,
	cliente text NULL,
	quantidade numeric(38, 10) NULL,
	sku text NULL,
	pk_produto text NULL,
	tipo_wo text NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	tamanho text NULL,
	cor text NULL,
	referencia text NULL,
	periodo_producao numeric(4) NULL,
	ordem_producao numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fprioridade_prod_congelado definição

-- Drop table

-- DROP TABLE temporario.jma_fprioridade_prod_congelado;

CREATE TABLE temporario.jma_fprioridade_prod_congelado (
	prioridade float8 NULL,
	work_order_id varchar(49) NULL,
	work_center varchar(61) NULL,
	planta varchar(14) NULL,
	cliente varchar(7) NULL,
	sku varchar(14) NULL,
	tipo_wo varchar(5) NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	referencia varchar(6) NULL,
	periodo_producao int2 NULL,
	ordem_producao float8 NULL,
	ultima_atualizacao timestamp NULL,
	pk_produto varchar(18) NULL,
	quantidade numeric(18, 3) NULL
);


-- temporario.jma_fprioridade_prod_congelado_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fprioridade_prod_congelado_inc;

CREATE TABLE temporario.jma_fprioridade_prod_congelado_inc (
	prioridade float8 NULL,
	work_order_id varchar(49) NULL,
	work_center varchar(61) NULL,
	planta varchar(14) NULL,
	cliente varchar(7) NULL,
	quantidade numeric(18, 3) NULL,
	sku varchar(14) NULL,
	tipo_wo varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	referencia varchar(5) NULL,
	periodo_producao int2 NULL,
	ordem_producao float8 NULL,
	ultima_atualizacao timestamp NULL,
	pk_produto varchar(18) NULL,
	data_fim_periodo date NULL,
	data_atualizacao date NULL
);


-- temporario.jma_fprioridade_tecelagem_congelado_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fprioridade_tecelagem_congelado_inc;

CREATE TABLE temporario.jma_fprioridade_tecelagem_congelado_inc (
	prioridade int4 NULL,
	work_order_id varchar(49) NULL,
	work_center varchar(92) NULL,
	planta varchar(32) NULL,
	cliente varchar(32) NULL,
	sku varchar(14) NULL,
	descricao_sku varchar(41) NULL,
	tipo_wo varchar(32) NULL,
	data_fim_periodo timestamp NULL,
	data_termino timestamp NULL,
	familia_produto varchar(25) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	referencia varchar(5) NULL,
	alternativa_item int2 NULL,
	roteiro_opcional int2 NULL,
	numero_lote varchar(8) NULL,
	opcao_maquina int2 NULL,
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	quantidade float8 NULL,
	qtde_quilos_prog numeric(15, 3) NULL,
	qtde_rolos_prog numeric(9, 1) NULL,
	peso_rolo numeric(11, 3) NULL,
	qtde_unidades_prog numeric(18, 3) NULL,
	qtde_rolos_prog_1 numeric(9, 1) NULL,
	qtde_rolos_prod numeric(9, 1) NULL,
	cod_cancelamento int2 NULL,
	data_atualizacao timestamp NULL
);


-- temporario.jma_fprod_marft_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fprod_marft_inc;

CREATE TABLE temporario.jma_fprod_marft_inc (
	op int4 NULL,
	os int4 NULL,
	tip_prod int2 NULL,
	hora timestamp NULL,
	seq int2 NULL,
	desc_prod varchar(50) NULL,
	referencia varchar(50) NULL,
	produto varchar(150) NULL,
	operacao varchar(80) NULL,
	operationcode varchar(20) NULL,
	tecido varchar(90) NULL,
	grupo varchar(70) NULL,
	"S.U." varchar(20) NULL,
	camada int2 NULL,
	tempo_total numeric(18, 3) NULL,
	tempo_peca numeric(18, 3) NULL,
	carga numeric(18, 3) NULL,
	oper int8 NULL,
	operador varchar(150) NULL,
	ultima_atualizacao timestamp NULL,
	"Data" timestamp NULL,
	temp_prep numeric(18, 3) NULL,
	temp_conclus numeric(18, 3) NULL,
	comp_total numeric(18, 3) NULL,
	tempo_tot_camada numeric(18, 3) NULL,
	tempo_camada numeric(18, 3) NULL,
	qtd_emenda numeric(18, 3) NULL,
	temp_emend numeric(18, 3) NULL,
	qtd_ton numeric(18, 3) NULL,
	tempo_ton numeric(18, 3) NULL,
	qtd_troca numeric(18, 3) NULL,
	tempo_troca_rolo numeric(18, 3) NULL
);


-- temporario.jma_fprod_oper_marft_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fprod_oper_marft_inc;

CREATE TABLE temporario.jma_fprod_oper_marft_inc (
	op int4 NULL,
	os int4 NULL,
	seq int2 NULL,
	caixa varchar(1) NULL,
	grupo varchar(50) NULL,
	hora timestamp NULL,
	cod_oper varchar(10) NULL,
	operacao varchar(60) NULL,
	cod_operador int2 NULL,
	operador varchar(60) NULL,
	cod_cel int2 NULL,
	celula_os varchar(25) NULL,
	turno int2 NULL,
	referencia varchar(30) NULL,
	produto varchar(100) NULL,
	ultima_atualizacao timestamp NULL,
	"DATA" date NULL,
	qtde numeric(18, 3) NULL,
	tempo numeric(18, 3) NULL,
	carga numeric(18, 3) NULL,
	gd numeric(18, 3) NULL,
	cpf varchar(20) NULL
);


-- temporario.jma_freceber_inc definição

-- Drop table

-- DROP TABLE temporario.jma_freceber_inc;

CREATE TABLE temporario.jma_freceber_inc (
	pk_titulo varchar(30) NULL,
	cd_empresa int2 NULL,
	cd_duplicata int4 NULL,
	cd_tipo_titulo int4 NULL,
	cd_seq_duplicata int4 NULL,
	cd_seq_pagamento int4 NULL,
	cd_pedido_venda int8 NULL,
	cd_contabil int4 NULL,
	nr_contabil int8 NULL,
	cd_doc_pagamento int8 NULL,
	cd_transacao int4 NULL,
	cd_conta_concorrente int8 NULL,
	fk_cliente varchar(25) NULL,
	fk_historico int4 NULL,
	fk_portador int4 NULL,
	fk_representante int4 NULL,
	vlr_duplicata numeric(18, 3) NULL,
	vlr_pago numeric(18, 3) NULL,
	vlr_restante numeric(18, 3) NULL,
	vlr_juros numeric(18, 3) NULL,
	vlr_desconto numeric(18, 3) NULL,
	qtd_titulos numeric(18, 3) NULL,
	vlr_comissao numeric(18, 3) NULL,
	base_calc_comissao numeric(18, 3) NULL,
	data_emissao timestamp NULL,
	data_vencimento timestamp NULL,
	data_pagamento timestamp NULL,
	data_prorrogacao timestamp NULL,
	gap_data_pagamento float8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_frejeicoes_pecas definição

-- Drop table

-- DROP TABLE temporario.jma_frejeicoes_pecas;

CREATE TABLE temporario.jma_frejeicoes_pecas (
	fk_produtos varchar(21) NULL,
	fk_est_prod int4 NULL,
	data_rejeicao timestamp NULL,
	cd_est int4 NULL,
	cd_motivo int4 NULL,
	cd_classificacao int4 NULL,
	periodo_producao int4 NULL,
	cd_nr_ordem int8 NULL,
	desc_obs varchar(2003) NULL,
	cd_area_prod int2 NULL,
	cd_op int8 NULL,
	nr_tubete int4 NULL,
	cd_rolo int8 NULL,
	hora_inicio timestamp NULL,
	hora_final timestamp NULL,
	cd_lote int4 NULL,
	cd_num_maq int4 NULL,
	tipo_rejeicao int2 NULL,
	cd_turno int2 NULL,
	cd_est_digitacao int4 NULL,
	cd_analista int4 NULL,
	cd_motivo_forne int4 NULL,
	cd_ppr int2 NULL,
	cd_defeito_agrup int4 NULL,
	cd_mostragem int8 NULL,
	cd_pedido_venda int8 NULL,
	cd_procedimento int4 NULL,
	cd_parte_peca varchar(33) NULL,
	cd_tipo_apont int2 NULL,
	cd_familia int4 NULL,
	cd_intervalo int4 NULL,
	ordem_confeccao int4 NULL,
	dthora_atualizacao timestamp NULL,
	cd_maq varchar(7) NULL,
	cd_sub_maq varchar(6) NULL,
	qtd numeric(17, 3) NULL,
	qtd_defeitos numeric(17, 3) NULL,
	qtd_rolos numeric(12, 2) NULL,
	qtd_forne numeric(17, 3) NULL,
	qtd_perda_metros numeric(17, 3) NULL
);


-- temporario.jma_freq_almoxarifado_inc definição

-- Drop table

-- DROP TABLE temporario.jma_freq_almoxarifado_inc;

CREATE TABLE temporario.jma_freq_almoxarifado_inc (
	num_requisicao numeric(6) NULL,
	ordem_producao numeric(9) NULL,
	ccusto_destino int4 NULL,
	data_requis timestamp NULL,
	requisitante varchar(50) NULL,
	situacao_capa varchar(32) NULL,
	referencia varchar(5) NULL,
	conta_estoque int2 NULL,
	pk_produto varchar(25) NULL,
	um varchar(2) NULL,
	deposito int2 NULL,
	observacao varchar(120) NULL,
	qtde_requisitada numeric(18, 3) NULL,
	a_receber numeric(18, 3) NULL,
	estoque numeric(18, 3) NULL,
	ult_compra numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	situacao varchar(32) NULL,
	data_entregue timestamp NULL,
	codigo_transacao int2 NULL,
	usuario_receptor varchar(200) NULL,
	almoxarife varchar(20) NULL,
	sequencia int2 NULL
);


-- temporario.jma_frequisicoes_compra definição

-- Drop table

-- DROP TABLE temporario.jma_frequisicoes_compra;

CREATE TABLE temporario.jma_frequisicoes_compra (
	num_requisicao numeric(6) NULL,
	seq_item_req numeric(2) NULL,
	codigo_deposito numeric(3) NULL,
	data_requisicao timestamp NULL,
	nome_requisit text NULL,
	observacao_req text NULL,
	data_prev_entr_req timestamp NULL,
	situacao_codigo numeric(1) NULL,
	situacao text NULL,
	pedido_compra numeric(6) NULL,
	data_prev_entr_ped timestamp NULL,
	fk_produto text NULL,
	fk_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_requisitada numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	ultimaentrada timestamp NULL,
	ultimasaida timestamp NULL,
	estoqueatual numeric(38, 10) NULL,
	qtdsugerida numeric(38, 10) NULL,
	precoultentrada numeric(38, 10) NULL,
	estoquemin numeric(38, 10) NULL,
	estoquemax numeric(38, 10) NULL,
	consumomedmes numeric(38, 10) NULL,
	consumopordia numeric(38, 10) NULL,
	ult_forn text NULL,
	ult_ped numeric(6) NULL,
	qtd_ult_ped numeric(38, 10) NULL,
	quantidade_nf numeric(38, 10) NULL,
	valor_total_nf numeric(38, 10) NULL
);


-- temporario.jma_frolos definição

-- Drop table

-- DROP TABLE temporario.jma_frolos;

CREATE TABLE temporario.jma_frolos (
	pk_rolos varchar(204) NULL,
	fk_produtos_ini varchar(18) NULL,
	fk_produtos_fin varchar(21) NULL,
	cd_area_ordem int4 NULL,
	cd_codigo_deposito int4 NULL,
	data_sai_estq timestamp NULL,
	seq_ordem int4 NULL,
	cd_rolo int8 NULL,
	cd_rolo_acabado int8 NULL,
	cd_ordem_prod int8 NULL,
	cd_rolo_confi varchar(4) NULL,
	cd_user varchar(253) NULL,
	data_hora_conf timestamp NULL,
	cd_rolo_conferido varchar(4) NULL,
	cd_rolo_rateado varchar(4) NULL,
	dthora_atualizacao timestamp NULL,
	qtd_kg_inicial numeric(16, 3) NULL,
	qtd_kg_final numeric(15, 3) NULL
);


-- temporario.jma_frolos_estoq definição

-- Drop table

-- DROP TABLE temporario.jma_frolos_estoq;

CREATE TABLE temporario.jma_frolos_estoq (
	codigo_rolo int4 NULL,
	periodo_producao int2 NULL,
	turno_producao int2 NULL,
	cod_nuance varchar(3) NULL,
	numero_lote varchar(15) NULL,
	ordem_producao int4 NULL,
	tecido varchar(111) NULL,
	codigo_deposito int2 NULL,
	qualidade_rolo int2 NULL,
	endereco_rolo varchar(30) NULL,
	q int2 NULL,
	data_entrada timestamp NULL,
	data_prod_tecel timestamp NULL,
	ultima_atualizacao timestamp NULL,
	ordem_producao_dm int4 NULL,
	area_producao int2 NULL,
	observacao varchar(350) NULL,
	rolo_estoque numeric(18, 3) NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	peso_bruto numeric(18, 3) NULL,
	peso_liquido_real numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	largura numeric(18, 3) NULL,
	gramatura numeric(18, 3) NULL,
	unidade_medida varchar(5) NULL
);


-- temporario.jma_froteiro definição

-- Drop table

-- DROP TABLE temporario.jma_froteiro;

CREATE TABLE temporario.jma_froteiro (
	num_roteiro int2 NULL,
	seq_operacao int2 NULL,
	fk_operacao int4 NULL,
	fk_estagio int2 NULL,
	seq_estagio int2 NULL,
	estagio_depende int2 NULL,
	qtd_rolos int4 NULL,
	observacao_roteiro varchar(200) NULL,
	centro_custo int4 NULL,
	ccusto_homem int4 NULL,
	dthora_atualizacao timestamp NULL,
	qtd_cordas int4 NULL,
	minutos_roteiro numeric(18, 3) NULL,
	velocidade numeric(18, 3) NULL,
	minutos_homem numeric(18, 3) NULL,
	fk_produto varchar(20) NULL,
	alternativa_item int4 NULL
);


-- temporario.jma_froteiro_em_producao definição

-- Drop table

-- DROP TABLE temporario.jma_froteiro_em_producao;

CREATE TABLE temporario.jma_froteiro_em_producao (
	fk_produto varchar(111) NULL,
	numero_alternati int2 NULL,
	numero_roteiro int2 NULL,
	seq_operacao int2 NULL,
	codigo_operacao int4 NULL,
	codigo_estagio int4 NULL,
	nr_agulhas int2 NULL,
	tempo_maquina numeric(18, 3) NULL,
	custo_homem int4 NULL,
	custo_minuto numeric(18, 3) NULL,
	tempo_homem numeric(18, 3) NULL,
	fk_maquina varchar(39) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fsaldoestoqueatual definição

-- Drop table

-- DROP TABLE temporario.jma_fsaldoestoqueatual;

CREATE TABLE temporario.jma_fsaldoestoqueatual (
	cd_empresa int2 NULL,
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(3) NULL,
	fk_produto varchar(18) NULL,
	dt_ult_entrada timestamp NULL,
	dt_ult_saida timestamp NULL,
	ultima_atualizacao timestamp NULL,
	codigo_barras varchar(16) NULL,
	qtd_empenhada numeric(18, 3) NULL,
	qtd_est_atual numeric(18, 3) NULL,
	qtd_disponivel numeric(18, 3) NULL,
	qtd_sugerida numeric(18, 3) NULL
);


-- temporario.jma_fsaldoestoqueinteg_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fsaldoestoqueinteg_inc;

CREATE TABLE temporario.jma_fsaldoestoqueinteg_inc (
	loja varchar(5) NULL,
	cnpj varchar(20) NULL,
	cod_barras varchar(20) NULL,
	qtd_estoque numeric(18, 3) NULL,
	data_estoque timestamp NULL,
	ultima_atualizacao timestamp NULL,
	codigo_barras_ean varchar(30) NULL,
	rede text NULL,
	fantasia text NULL,
	sku text NULL,
	tamanho text NULL,
	refcor text NULL,
	situacao text NULL,
	mes_ano varchar(7) NULL
);
CREATE INDEX jma_fsaldoestoqueinteg_inc_data_estoque_idx ON temporario.jma_fsaldoestoqueinteg_inc USING btree (data_estoque);
CREATE INDEX jma_fsaldoestoqueinteg_inc_data_estoque_idx1 ON temporario.jma_fsaldoestoqueinteg_inc USING btree (data_estoque) WHERE (qtd_estoque > (0)::numeric);
CREATE INDEX jma_fsaldoestoqueinteg_inc_data_estoque_qtd_estoque_idx ON temporario.jma_fsaldoestoqueinteg_inc USING btree (data_estoque, qtd_estoque);
CREATE INDEX jma_fsaldoestoqueinteg_inc_left_idx ON temporario.jma_fsaldoestoqueinteg_inc USING btree ("left"((cod_barras)::text, 11));
CREATE INDEX jma_fsaldoestoqueinteg_inc_loja_idx ON temporario.jma_fsaldoestoqueinteg_inc USING btree (loja);


-- temporario.jma_fsaldoestoquemensal definição

-- Drop table

-- DROP TABLE temporario.jma_fsaldoestoquemensal;

CREATE TABLE temporario.jma_fsaldoestoquemensal (
	cd_empresa int2 NULL,
	cd_deposito int2 NULL,
	cd_nivel_estrutura varchar(3) NULL,
	fk_produto varchar(20) NULL,
	mes_ano_fechamento varchar(10) NULL,
	ultima_atualizacao timestamp NULL,
	codigo_barras varchar(16) NULL,
	qtd_saldo_fisico numeric(18, 3) NULL,
	vlr_saldo_financeiro numeric(18, 3) NULL,
	vlr_preco_medio_unit numeric(18, 3) NULL,
	vlr_total_estoque numeric(18, 3) NULL
);


-- temporario.jma_fsituacao_notas definição

-- Drop table

-- DROP TABLE temporario.jma_fsituacao_notas;

CREATE TABLE temporario.jma_fsituacao_notas (
	serie_nota_fisc text NULL,
	num_nota_fiscal numeric(9) NULL,
	num_pedido numeric(9) NULL,
	data_emissao timestamp NULL,
	data_venc_duplic timestamp NULL,
	numero_titulo numeric(9) NULL,
	num_seq_titulo numeric(9) NULL,
	cod_forma_pagto numeric(2) NULL,
	descricao text NULL,
	cond_pgto_venda numeric(3) NULL,
	descr_pg_cliente text NULL,
	cod_canc_nfisc numeric(2) NULL,
	qtde_itens numeric(5) NULL,
	valor_itens_nfis numeric(13, 2) NULL,
	valor_duplicata numeric(15, 2) NULL,
	situacao_nfisc numeric(1) NULL,
	cod_status text NULL,
	situacao_duplic numeric(1) NULL,
	situacao text NULL,
	flag text NULL,
	data_saida timestamp NULL,
	natur_operacao numeric(3) NULL,
	descr_nat_oper text NULL,
	fk_cliente text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_ftabelapreco definição

-- Drop table

-- DROP TABLE temporario.jma_ftabelapreco;

CREATE TABLE temporario.jma_ftabelapreco (
	dthora_atualizacao timestamp NULL,
	grupo_estrutura varchar(10) NULL,
	tabela_preco varchar(10) NULL,
	tabela_preco_cod varchar(10) NULL,
	fk_produto varchar(50) NULL,
	vlr_com_desconto numeric(18, 3) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	tabela_preco_grupo numeric(25, 6) NULL
);


-- temporario.jma_ftabelaprecogrupoest definição

-- Drop table

-- DROP TABLE temporario.jma_ftabelaprecogrupoest;

CREATE TABLE temporario.jma_ftabelaprecogrupoest (
	tabela_preco text NULL,
	tabela_preco_cod text NULL,
	grupo_estrutura text NULL,
	item_estrutura text NULL,
	subgru_estrutura text NULL,
	nivel_estrutura text NULL,
	val_tabela_preco numeric(19, 6) NULL
);


-- temporario.jma_ftabelaprecostage definição

-- Drop table

-- DROP TABLE temporario.jma_ftabelaprecostage;

CREATE TABLE temporario.jma_ftabelaprecostage (
	tabela_preco varchar(9) NULL,
	tabela_preco_cod varchar(11) NULL,
	fk_produto varchar(18) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	vlr_com_desconto numeric(18, 3) NULL,
	grupo_estrutura varchar(5) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.jma_ftempo_metodos definição

-- Drop table

-- DROP TABLE temporario.jma_ftempo_metodos;

CREATE TABLE temporario.jma_ftempo_metodos (
	pk_produto varchar(111) NULL,
	alt int2 NULL,
	rot int2 NULL,
	sub_grupo varchar(3) NULL,
	codigo_estagio int4 NULL,
	codigo_operacao int4 NULL,
	pk_maquina varchar(39) NULL,
	agulhas varchar(3) NULL,
	custo_homem numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	custo_minuto numeric(18, 3) NULL,
	tempo_homem varchar NULL,
	tempo_maquina varchar NULL
);
CREATE INDEX jma_ftempo_metodos_codigo_estagio_pk_produto_alt_idx ON temporario.jma_ftempo_metodos USING btree (codigo_estagio, pk_produto, alt);
CREATE INDEX jma_ftempo_metodos_codigo_operacao_idx ON temporario.jma_ftempo_metodos USING btree (codigo_operacao);
CREATE INDEX jma_ftempo_metodos_pk_maquina_idx ON temporario.jma_ftempo_metodos USING btree (pk_maquina);


-- temporario.jma_ftitulos_receber definição

-- Drop table

-- DROP TABLE temporario.jma_ftitulos_receber;

CREATE TABLE temporario.jma_ftitulos_receber (
	codigo_empresa int2 NULL,
	num_duplicata int4 NULL,
	seq_duplicatas int2 NULL,
	cod_chave_nota varchar(85) NULL,
	num_titulo varchar(81) NULL,
	portador_duplic int2 NULL,
	cod_rep_cliente int4 NULL,
	data_emissao timestamp NULL,
	numero_remessa int4 NULL,
	ind_previsao int2 NULL,
	num_titulo_banco varchar(21) NULL,
	num_pedido int4 NULL,
	cod_motivo_cancel int2 NULL,
	des_motivo_cancel varchar(20) NULL,
	cod_forma_pagto int2 NULL,
	dat_cancel timestamp NULL,
	dat_ult_pagto_aux timestamp NULL,
	cod_tipo_duplic int2 NULL,
	cod_posicao_duplic int2 NULL,
	des_situa_duplic varchar(15) NULL,
	des_situa_aberta_baixada varchar(9) NULL,
	cod_situa_duplic int2 NULL,
	cnpj_cliente varchar(120) NULL,
	cod_cidade int4 NULL,
	dat_vencto_aux timestamp NULL,
	dat_vencto_original_aux timestamp NULL,
	sit_vencto varchar(8) NULL,
	val_titulo numeric(18, 3) NULL,
	cod_conta_contabil int4 NULL,
	des_tipo_duplic varchar(20) NULL,
	pk_cliente varchar(17) NULL,
	des_cod_tipo_duplic varchar(61) NULL,
	des_posicao_duplic varchar(15) NULL,
	per_comiss numeric(18, 3) NULL,
	val_aberto numeric(18, 3) NULL,
	val_comiss numeric(18, 3) NULL,
	val_titulo_ktl numeric(18, 3) NULL
);


-- temporario.jma_fvendas_presenciais definição

-- Drop table

-- DROP TABLE temporario.jma_fvendas_presenciais;

CREATE TABLE temporario.jma_fvendas_presenciais (
	cd_colaborador varchar(30) NULL,
	nm_colaborador varchar(100) NULL,
	dt_venda varchar(30) NULL,
	hr_venda varchar(30) NULL,
	origem_venda varchar(30) NULL,
	tipo_venda varchar(30) NULL,
	cd_filial varchar(30) NULL,
	nm_filial varchar(100) NULL,
	dt_hora_venda timestamp NULL,
	dt_ult_atualizacao timestamp NULL,
	vlr_liquido numeric(18, 3) NULL,
	cd_ped varchar(50) NULL
);


-- temporario.jma_fvendas_url definição

-- Drop table

-- DROP TABLE temporario.jma_fvendas_url;

CREATE TABLE temporario.jma_fvendas_url (
	id numeric(10) NULL,
	pedido numeric(9) NULL,
	nota_fiscal numeric(9) NULL,
	quantidade numeric(15, 3) NULL,
	valor_faturado numeric(15, 3) NULL,
	canal varchar(100) NULL,
	cnpj varchar(15) NULL,
	serie_nota_fiscal varchar(3) NULL,
	pedido_cliente varchar(30) NULL,
	"DATA" timestamp NULL,
	data_emissao timestamp NULL,
	cupom varchar(35) NULL,
	loja varchar(65) NULL,
	cpf_vendedor varchar(11) NULL,
	cnpj_loja varchar(15) NULL,
	ultima_atualizacao timestamp NULL,
	nota_entrada float8 NULL,
	nota_saida float8 NULL,
	motivo_devolucao varchar(400) NULL,
	flag_tipo varchar(3) NULL,
	tipo_cliente varchar(100) NULL,
	cliente varchar(100) NULL,
	tipo_cupom varchar(100) NULL,
	vendedor varchar(255) NULL,
	valor_comissao numeric(18, 3) NULL,
	grupo_loja varchar(100) NULL,
	tela varchar(10) NULL,
	omnichannel varchar(3) NULL,
	fornecedor varchar(55) NULL,
	percentual_comissao numeric(18, 3) NULL,
	valor_comissao_ktl numeric(18, 3) NULL
);


-- temporario.jma_fvolumes_notas_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fvolumes_notas_inc;

CREATE TABLE temporario.jma_fvolumes_notas_inc (
	codpedido numeric(11) NULL,
	notafiscal numeric(11) NULL,
	dataemissao timestamp NULL,
	datamontagem timestamp NULL,
	volumenota numeric(11) NULL,
	expedidor varchar(150) NULL,
	sit_vol_fat varchar(20) NULL,
	nivel varchar(3) NULL,
	grupo varchar(10) NULL,
	subgrupo varchar(5) NULL,
	item varchar(10) NULL,
	qtdepeca numeric(15) NULL,
	pesototalitem numeric(15, 3) NULL,
	pesovolume numeric(15, 3) NULL,
	pesoembalagem numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_fweb_scraping_inc definição

-- Drop table

-- DROP TABLE temporario.jma_fweb_scraping_inc;

CREATE TABLE temporario.jma_fweb_scraping_inc (
	produto varchar(255) NULL,
	categoria varchar(100) NULL,
	tipo varchar(50) NULL,
	preco float8 NULL,
	preco_original float8 NULL,
	loja varchar(100) NULL,
	data_extracao date NULL
);


-- temporario.jma_ordens_prod_ultimos_7 definição

-- Drop table

-- DROP TABLE temporario.jma_ordens_prod_ultimos_7;

CREATE TABLE temporario.jma_ordens_prod_ultimos_7 (
	codigo_estagio int4 NULL,
	ordem_producao int4 NULL,
	periodo_producao int2 NULL,
	seq_operacao int2 NULL,
	produto varchar(111) NULL,
	tempo_producao int8 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_pedi100 definição

-- Drop table

-- DROP TABLE temporario.jma_pedi100;

CREATE TABLE temporario.jma_pedi100 (
	pedido_venda numeric(9) NULL,
	data_entr_venda timestamp NULL,
	situacao_venda numeric(2) NULL,
	cod_cancelamento numeric(3) NULL,
	sit_aloc_pedi numeric(1) NULL,
	sit_coletor numeric(1) NULL,
	situacao_coleta numeric(1) NULL,
	status_expedicao numeric(1) NULL,
	status_homologacao numeric(1) NULL,
	status_pedido numeric(1) NULL,
	status_comercial numeric(1) NULL,
	sit_conferencia numeric(1) NULL,
	qtde_saldo_pedi numeric(15, 3) NULL,
	valor_saldo_pedi numeric(15, 2) NULL,
	ultima_atualizacao timestamp NULL,
	qtde_total_pedi numeric(15, 3) NULL,
	live_data_entr_venda_original timestamp NULL
);


-- temporario.jma_pedi135 definição

-- Drop table

-- DROP TABLE temporario.jma_pedi135;

CREATE TABLE temporario.jma_pedi135 (
	pedido_venda numeric(9) NULL,
	seq_situacao numeric(2) NULL,
	codigo_situacao numeric(2) NULL,
	flag_liberacao text NULL,
	data_situacao timestamp NULL,
	data_liberacao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.jma_stage_movimentacoes_integ definição

-- Drop table

-- DROP TABLE temporario.jma_stage_movimentacoes_integ;

CREATE TABLE temporario.jma_stage_movimentacoes_integ (
	portal_movimentacao int8 NULL,
	identificador varchar(60) NULL,
	cnpj_movimentacao varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	qtde numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	fk_produto varchar(168) NULL,
	data_lancamento timestamp NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	cst_icms varchar(10) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	cst_ipi varchar(10) NULL,
	valor_ipi numeric(20, 5) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	cst_cofins varchar(10) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	cst_pis varchar(10) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(1) NULL,
	datcancel timestamp NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	valor_bruto numeric(18, 3) NULL,
	cor varchar(20) NULL,
	tamanho varchar(32) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	cod_barra varchar(20) NULL,
	loja_movimentacao varchar(30) NULL
);


-- temporario.jma_stg_infos_lojas_integ definição

-- Drop table

-- DROP TABLE temporario.jma_stg_infos_lojas_integ;

CREATE TABLE temporario.jma_stg_infos_lojas_integ (
	id_loja numeric(9) NULL,
	descricao text NULL,
	apelido text NULL,
	razao_social text NULL,
	cnpj text NULL,
	situacao numeric(1) NULL,
	endereco text NULL,
	cep numeric(8) NULL,
	id_portal numeric(9) NULL,
	portal text NULL,
	data_inauguracao timestamp NULL,
	rede text NULL
);


-- temporario.jma_stg_paradasmaquinas_marft_pmo definição

-- Drop table

-- DROP TABLE temporario.jma_stg_paradasmaquinas_marft_pmo;

CREATE TABLE temporario.jma_stg_paradasmaquinas_marft_pmo (
	cod_operador numeric(5) NULL,
	nome_operador text NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	motivo text NULL,
	detalhes text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.live_dbriefing definição

-- Drop table

-- DROP TABLE temporario.live_dbriefing;

CREATE TABLE temporario.live_dbriefing (
	referencia varchar(6) NULL,
	cor_venda varchar(6) NULL,
	ref_cor varchar(11) NULL,
	desc_colecao varchar(60) NULL,
	desc_sub_colecao varchar(100) NULL,
	linha_produto varchar(40) NULL,
	desc_segmento varchar(62) NULL,
	pilar varchar(64) NULL,
	artigo_produto varchar(25) NULL,
	desc_comercial varchar(100) NULL,
	desc_tamanhos varchar(10) NULL,
	grade varchar(700) NULL,
	mp_principal varchar(20) NULL,
	mp_principal_desc varchar(30) NULL,
	num_sku int4 NULL,
	ultima_atualizacao timestamp NULL,
	ano_venda int4 NULL,
	modalidade varchar(68) NULL,
	classificacao_permanentes varchar(20) NULL,
	tipo_producao varchar(70) NULL,
	categoria_produto varchar(72) NULL,
	sub_categoria_produto varchar(74) NULL,
	comprimento_entrepernas varchar(76) NULL,
	tipo_shape varchar(78) NULL,
	comprimento varchar(80) NULL,
	tipo_alca varchar(82) NULL,
	tipo_decote varchar(62) NULL,
	tipo_gola varchar(64) NULL,
	tipo_manga varchar(86) NULL,
	tipo_sustentacao varchar(68) NULL,
	decoracoes varchar(78) NULL,
	tipo_estampa varchar(80) NULL,
	capacidade varchar(82) NULL,
	fat_plan_fabrica date NULL,
	lancamento_plan_loja date NULL,
	live_familia varchar(62) NULL,
	live_conjunto varchar(255) NULL,
	piramide varchar(60) NULL,
	cluster_comercial varchar(10) NULL,
	aposta_criacao numeric(1) NULL,
	estoque_limitado numeric(1) NULL,
	grade_multipla numeric(1) NULL,
	live_run numeric(1) NULL,
	acao_varejo numeric(1) NULL,
	must_have numeric(1) NULL,
	nova_cor numeric(1) NULL,
	visual_merchandising numeric(1) NULL,
	tamanho_vitrine varchar(1) NULL,
	promocional numeric(1) NULL,
	tecido varchar(60) NULL,
	colecao varchar(200) NULL,
	abreviacao_colecao varchar(100) NULL,
	sub_colecao varchar(100) NULL,
	linha varchar(100) NULL,
	familia varchar(50) NULL,
	segmento varchar(50) NULL,
	nomenclatura varchar(50) NULL,
	estilista varchar(50) NULL,
	assistente_estilo varchar(100) NULL,
	unidade_medida varchar(100) NULL,
	tipo_artigo varchar(200) NULL,
	artigo_cotas varchar(200) NULL,
	comprado_fabricado varchar(200) NULL,
	modalidades varchar(200) NULL,
	high_lights varchar(4000) NULL,
	stylist varchar(4000) NULL,
	dt_integracao timestamp NULL,
	informacoes_marketing varchar(4000) NULL,
	caract_produto_port varchar(4000) NULL,
	descr_com_port varchar(4000) NULL,
	caract_produto_ing varchar(4000) NULL,
	descr_com_ing varchar(4000) NULL,
	descr_com_ecommerce_ing varchar(4000) NULL,
	caract_produto_esp varchar(4000) NULL,
	descr_com_esp varchar(100) NULL,
	descr_com_ecommerce_esp varchar(4000) NULL,
	neon numeric(1) NULL,
	look_book numeric(1) NULL,
	icone_acron varchar(3) NULL,
	texto_portugues varchar(1000) NULL,
	texto_ingles varchar(1000) NULL,
	texto_espanhol varchar(1000) NULL,
	descricao_classificacao varchar(50) NULL,
	descricao_base_releitura varchar(50) NULL,
	rede_vendas_indicado varchar(50) NULL
);


-- temporario.live_dcalendario definição

-- Drop table

-- DROP TABLE temporario.live_dcalendario;

CREATE TABLE temporario.live_dcalendario (
	"data" date NULL,
	ano int4 NULL,
	mes int4 NULL,
	nummesano varchar(20) NULL,
	mes_ano varchar(20) NULL,
	nm_mes varchar(20) NULL,
	abrev_mes varchar(20) NULL,
	dia int4 NULL,
	nm_dia varchar(20) NULL,
	abrev_dia varchar(20) NULL,
	nr_dia_semana int4 NULL,
	numero_semana int4 NULL,
	semana_ano_tabela varchar(30) NULL,
	dia_do_ano int4 NULL,
	dia_semana int4 NULL,
	dia_util int4 NULL,
	dia_util_finan int4 NULL,
	ultima_atualizacao date NULL
);


-- temporario.live_dcanaldistribuicao definição

-- Drop table

-- DROP TABLE temporario.live_dcanaldistribuicao;

CREATE TABLE temporario.live_dcanaldistribuicao (
	id int4 NULL,
	descricao varchar(100) NULL,
	modalidade varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.live_dcidades definição

-- Drop table

-- DROP TABLE temporario.live_dcidades;

CREATE TABLE temporario.live_dcidades (
	cod_cidade varchar(5) NULL,
	nm_cidade varchar(60) NULL,
	uf varchar(2) NULL,
	ddd int2 NULL,
	cod_pais int2 NULL,
	cod_fiscal int4 NULL,
	cod_reg_mer_ex int2 NULL,
	populacao int4 NULL,
	cod_cidade_zona_franca int4 NULL,
	cod_cidade_ibge int4 NULL,
	cod_sub_regiao int2 NULL,
	sub_regiao varchar(40) NULL,
	cod_suframa int2 NULL,
	cep int4 NULL,
	dthora_atualizacao timestamp NULL,
	nm_pais varchar(30) NULL,
	estado_extenso varchar(30) NULL
);


-- temporario.live_dcliente definição

-- Drop table

-- DROP TABLE temporario.live_dcliente;

CREATE TABLE temporario.live_dcliente (
	pk_cliente varchar(16) NULL,
	cod_empresa int2 NULL,
	nm_cliente varchar(70) NULL,
	nm_fantasia varchar(70) NULL,
	fone_cliente int4 NULL,
	uf_cliente varchar(2) NULL,
	cep int4 NULL,
	cidade varchar(70) NULL,
	endereco varchar(70) NULL,
	bairro varchar(20) NULL,
	dt_cadastro timestamp NULL,
	cod_representante int2 NULL,
	nm_representante varchar(50) NULL,
	nm_subregiao_cliente varchar(20) NULL,
	tipo_cliente varchar(70) NULL,
	tipo_cliente_agrupamento varchar(60) NULL,
	dt_ult_compra timestamp NULL,
	vlr_ult_compra numeric(18, 3) NULL,
	prazo_medio numeric(9, 3) NULL,
	dt_ultima_fatura timestamp NULL,
	email_cliente varchar(100) NULL,
	grupo_economico varchar(60) NULL,
	cd_grupo_economico int4 NULL,
	situacao_cliente varchar(7) NULL,
	conceito_cliente varchar(20) NULL,
	modalidade_cliente varchar(30) NULL,
	pais_cliente varchar(25) NULL,
	regiao_cliente varchar(20) NULL,
	cod_cidade int4 NULL,
	dthora_atualizacao timestamp NULL,
	cnpj_cliente varchar(120) NULL
);


-- temporario.live_dcolecoes definição

-- Drop table

-- DROP TABLE temporario.live_dcolecoes;

CREATE TABLE temporario.live_dcolecoes (
	cod_colecao numeric(3) NULL,
	desc_colecao text NULL,
	sigla_colecao text NULL
);


-- temporario.live_dcolecoes_subcolecoes definição

-- Drop table

-- DROP TABLE temporario.live_dcolecoes_subcolecoes;

CREATE TABLE temporario.live_dcolecoes_subcolecoes (
	referencia text NULL,
	colecao numeric(3) NULL,
	desc_colecao text NULL,
	cod_subcolecao numeric(38, 10) NULL,
	desc_sub_colecao text NULL
);


-- temporario.live_dconjuntos definição

-- Drop table

-- DROP TABLE temporario.live_dconjuntos;

CREATE TABLE temporario.live_dconjuntos (
	cod_empresa int2 NULL,
	cor_ref_a varchar(6) NULL,
	cor_ref_b varchar(6) NULL,
	referencia_a varchar(5) NULL,
	referencia_b varchar(5) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.live_dfornecedor definição

-- Drop table

-- DROP TABLE temporario.live_dfornecedor;

CREATE TABLE temporario.live_dfornecedor (
	pk_fornecedor varchar(25) NULL,
	nm_fornecedor varchar(60) NULL,
	cd_situacao_fornecedor int2 NULL,
	telefone_fornecedor int4 NULL,
	cep_fornecedor int4 NULL,
	endereco_fornecedor varchar(80) NULL,
	nr_endereco varchar(25) NULL,
	bairro_fornecedor varchar(40) NULL,
	cidade_fornecedor varchar(60) NULL,
	uf_fornecedor varchar(2) NULL,
	dt_cadastro_fornecedor timestamp NULL,
	dthora_atualizacao timestamp NULL,
	nm_fantasia varchar(80) NULL
);
CREATE INDEX live_dfornecedor_pk_fornecedor_idx ON temporario.live_dfornecedor USING btree (pk_fornecedor);


-- temporario.live_dimg_produtos definição

-- Drop table

-- DROP TABLE temporario.live_dimg_produtos;

CREATE TABLE temporario.live_dimg_produtos (
	id_produto varchar(20) NULL,
	referencia varchar(20) NULL,
	cor varchar(20) NULL,
	seq_imagem int8 NULL,
	imagem_url varchar(3000) NULL,
	imagem_base64 text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.live_dlojas definição

-- Drop table

-- DROP TABLE temporario.live_dlojas;

CREATE TABLE temporario.live_dlojas (
	pk_loja int4 NULL,
	desc_loja varchar(200) NULL,
	desc_apelido varchar(200) NULL,
	desc_razao_social varchar(200) NULL,
	pk_cnpj varchar(35) NULL,
	cod_inscricao_estadual varchar(20) NULL,
	cod_funcionario int4 NULL,
	cep int4 NULL,
	desc_endereco varchar(200) NULL,
	telefone int8 NULL,
	cod_portal varchar(20) NULL,
	pk_portal int4 NULL,
	dt_inauguracao timestamp NULL,
	metragem numeric(7, 2) NULL,
	cod_regiao int4 NULL,
	cod_usuario int4 NULL,
	flag_abre_aos_domingos int2 NULL,
	omny_channel int2 NULL,
	cod_rede int4 NULL,
	porc_franchising numeric(7, 2) NULL,
	ponto_retirada int2 NULL,
	cupom_desconto_loja varchar(20) NULL,
	dt_cadastro timestamp NULL,
	dt_ult_alteracao timestamp NULL,
	cod_cidade int4 NULL,
	cidade varchar(40) NULL,
	estado varchar(2) NULL,
	regiao varchar(100) NULL,
	rede varchar(50) NULL,
	situacao varchar(7) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.live_dperiodo_colecoes definição

-- Drop table

-- DROP TABLE temporario.live_dperiodo_colecoes;

CREATE TABLE temporario.live_dperiodo_colecoes (
	id int4 NULL,
	colecao int2 NULL,
	descr_colecao varchar(20) NULL,
	subcolecao int2 NULL,
	descr_sub_colecao varchar(20) NULL,
	classificacao int2 NULL,
	descr_classificacao varchar(6) NULL,
	data_inicio_sell_in timestamp NULL,
	data_fim_sell_in timestamp NULL,
	data_inicio_sell_out timestamp NULL,
	data_fim_sell_out timestamp NULL,
	data_inicio_producao timestamp NULL,
	data_fim_producao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.live_dproduto definição

-- Drop table

-- DROP TABLE temporario.live_dproduto;

CREATE TABLE temporario.live_dproduto (
	pk_produto varchar(25) NULL,
	pk_produto_cigam varchar(14) NULL,
	cd_produto varchar(16) NULL,
	cd_desc_prod varchar(80) NULL,
	nivel_estrutura int2 NULL,
	desc_nivel_estrutura varchar(30) NULL,
	cd_referencia varchar(5) NULL,
	desc_produto varchar(70) NULL,
	und_medida varchar(2) NULL,
	desc_unidade_medida varchar(20) NULL,
	nm_tamanho varchar(15) NULL,
	nm_cor varchar(25) NULL,
	cd_colecao int2 NULL,
	desc_colecao varchar(30) NULL,
	cod_linha int4 NULL,
	linha_produto varchar(40) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(30) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(30) NULL,
	cd_desc_referencia varchar(50) NULL,
	cod_desc_artigo varchar(50) NULL,
	cod_agrupador int2 NULL,
	desc_agrupador varchar(50) NULL,
	tipo_produto varchar(15) NULL,
	marca varchar(50) NULL,
	cd_conta_estoque int2 NULL,
	desc_conta_estoque varchar(50) NULL,
	desc_produto_narrativa varchar(90) NULL,
	cd_cor varchar(6) NULL,
	cd_tamanho varchar(5) NULL,
	desc_narrativa varchar(70) NULL,
	preco_custo numeric(18, 3) NULL,
	item_ativo int2 NULL,
	desc_referencia varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	publico_alvo varchar(60) NULL,
	faixa_etaria varchar(60) NULL,
	codigo_contabil int4 NULL,
	classific_fiscal varchar(15) NULL,
	descr_class_fisc varchar(40) NULL,
	serie_tamanho int2 NULL,
	desc_serie_tamanho varchar(10) NULL,
	obs_serie_tamanho varchar(60) NULL,
	sub_colecao varchar(20) NULL,
	familia1 varchar(80) NULL,
	familia2 varchar(80) NULL,
	familia3 varchar(80) NULL,
	familia4 varchar(80) NULL,
	familia5 varchar(80) NULL,
	dthora_atualizacao timestamp NULL,
	sku_produto varchar(120) NULL,
	cod_subcolecao int4 NULL,
	desc_sub_colecao varchar(20) NULL,
	origem_prod numeric(1) NULL
);


-- temporario.live_dreferencias_mta definição

-- Drop table

-- DROP TABLE temporario.live_dreferencias_mta;

CREATE TABLE temporario.live_dreferencias_mta (
	referencia varchar(50) NULL,
	tamanho varchar(20) NULL,
	corvenda varchar(50) NULL,
	linkimagem text NULL,
	refcor varchar(50) NULL,
	colecao varchar(100) NULL,
	categoria varchar(100) NULL,
	mpprincipal varchar(100) NULL,
	sellin numeric(18, 2) NULL,
	sellout numeric(18, 2) NULL,
	lancamento date NULL,
	descricaocor varchar(255) NULL,
	linha varchar(50) NULL,
	descricaolinha varchar(255) NULL,
	codigoinformacao int4 NULL,
	descricaocodigo varchar(255) NULL,
	artigo varchar(50) NULL,
	desricaoartigo varchar(255) NULL,
	descricaocomercial varchar(255) NULL,
	dereferencias varchar(255) NULL,
	datainicio date NULL,
	datafim date NULL,
	ultima_atualizacao timestamp NULL,
	status varchar(15) NULL
);


-- temporario.live_dresponsavel_loja definição

-- Drop table

-- DROP TABLE temporario.live_dresponsavel_loja;

CREATE TABLE temporario.live_dresponsavel_loja (
	pk_responsavel varchar(80) NULL,
	cod_loja int4 NULL,
	desc_responsavel varchar(100) NULL,
	cargo varchar(200) NULL,
	cod_situacao int2 NULL,
	dthora_atualizacao timestamp NULL,
	email text NULL,
	cod_funcao int4 NULL
);


-- temporario.log_log_pid_kill definição

-- Drop table

-- DROP TABLE temporario.log_log_pid_kill;

CREATE TABLE temporario.log_log_pid_kill (
	log_id int8 DEFAULT nextval('log.log_pid_kill_log_id_seq'::regclass) NOT NULL,
	pid_killed int4 NULL,
	usuario text NULL,
	banco text NULL,
	query_text text NULL,
	query_start timestamp NULL,
	tempo_executando interval NULL,
	data_acao timestamp DEFAULT now() NULL,
	motivo text NULL,
	CONSTRAINT log_log_pid_kill_pkey PRIMARY KEY (log_id)
);


-- temporario.marft_dcelula_parada definição

-- Drop table

-- DROP TABLE temporario.marft_dcelula_parada;

CREATE TABLE temporario.marft_dcelula_parada (
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


-- temporario.marft_dfunc_integracao definição

-- Drop table

-- DROP TABLE temporario.marft_dfunc_integracao;

CREATE TABLE temporario.marft_dfunc_integracao (
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


-- temporario.marft_dmotivo definição

-- Drop table

-- DROP TABLE temporario.marft_dmotivo;

CREATE TABLE temporario.marft_dmotivo (
	codigo_motivo int2 NULL,
	nome varchar(40) NULL,
	descricao varchar(250) NULL,
	active int2 NULL,
	integrationcode varchar(10) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.marft_doperador_falta definição

-- Drop table

-- DROP TABLE temporario.marft_doperador_falta;

CREATE TABLE temporario.marft_doperador_falta (
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


-- temporario.marft_doperador_parada definição

-- Drop table

-- DROP TABLE temporario.marft_doperador_parada;

CREATE TABLE temporario.marft_doperador_parada (
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
CREATE INDEX marft_doperador_parada_codigo_operador_idx ON temporario.marft_doperador_parada USING btree (codigo_operador);
CREATE INDEX marft_doperador_parada_data_codigo_operador_idx ON temporario.marft_doperador_parada USING btree (data, codigo_operador);


-- temporario.marft_dvalores_premio definição

-- Drop table

-- DROP TABLE temporario.marft_dvalores_premio;

CREATE TABLE temporario.marft_dvalores_premio (
	codigo_premio numeric(5) NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	nome text NULL,
	efic_min numeric(5, 2) NULL,
	ate numeric(5, 2) NULL,
	valor numeric(5, 2) NULL
);


-- temporario.marft_fdesempenho_operador_individual definição

-- Drop table

-- DROP TABLE temporario.marft_fdesempenho_operador_individual;

CREATE TABLE temporario.marft_fdesempenho_operador_individual (
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


-- temporario.marft_fdesempenho_operador_maquina definição

-- Drop table

-- DROP TABLE temporario.marft_fdesempenho_operador_maquina;

CREATE TABLE temporario.marft_fdesempenho_operador_maquina (
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


-- temporario.marft_foperador_status definição

-- Drop table

-- DROP TABLE temporario.marft_foperador_status;

CREATE TABLE temporario.marft_foperador_status (
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
CREATE INDEX "marft_foperador_status_codigo_operador_DATA_codigo_celula_idx" ON temporario.marft_foperador_status USING btree (codigo_operador, "DATA") INCLUDE (codigo_celula);


-- temporario.marft_fprod_oper definição

-- Drop table

-- DROP TABLE temporario.marft_fprod_oper;

CREATE TABLE temporario.marft_fprod_oper (
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


-- temporario.marft_fprod_oper_inc definição

-- Drop table

-- DROP TABLE temporario.marft_fprod_oper_inc;

CREATE TABLE temporario.marft_fprod_oper_inc (
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
CREATE INDEX marft_fprod_oper_inc_cod_cel_data_idx ON temporario.marft_fprod_oper_inc USING btree (cod_cel, data);
CREATE INDEX marft_fprod_oper_inc_op_idx ON temporario.marft_fprod_oper_inc USING btree (op);


-- temporario.marft_fproducao_celula definição

-- Drop table

-- DROP TABLE temporario.marft_fproducao_celula;

CREATE TABLE temporario.marft_fproducao_celula (
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


-- temporario.marft_fproducao_operador definição

-- Drop table

-- DROP TABLE temporario.marft_fproducao_operador;

CREATE TABLE temporario.marft_fproducao_operador (
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


-- temporario.ppcp_dcad_centro_custo definição

-- Drop table

-- DROP TABLE temporario.ppcp_dcad_centro_custo;

CREATE TABLE temporario.ppcp_dcad_centro_custo (
	centro_custo numeric(6) NULL,
	descricao text NULL,
	divisao_producao numeric(4) NULL,
	custo_despesa numeric(1) NULL,
	fixo_variavel numeric(1) NULL,
	tipo_mao_obra numeric(1) NULL,
	tipo_ccusto numeric(1) NULL,
	situacao numeric(1) NULL,
	tempo_turno1 numeric(3) NULL,
	tempo_turno2 numeric(3) NULL,
	tempo_turno3 numeric(3) NULL,
	tempo_turno4 numeric(3) NULL,
	local_entrega numeric(3) NULL,
	centro_custo_pai numeric(6) NULL,
	data_alteracao timestamp NULL,
	validar_cc_empresa text NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX ppcp_dcad_centro_custo_centro_custo_idx ON temporario.ppcp_dcad_centro_custo USING btree (centro_custo);


-- temporario.ppcp_dcadastro_fornecedores definição

-- Drop table

-- DROP TABLE temporario.ppcp_dcadastro_fornecedores;

CREATE TABLE temporario.ppcp_dcadastro_fornecedores (
	cnpj_forn varchar(184) NULL,
	razao_social varchar(200) NULL,
	nome_fantasia varchar(200) NULL,
	rua varchar(200) NULL,
	numero int8 NULL,
	bairro varchar(100) NULL,
	cidade varchar(100) NULL,
	estado varchar(2) NULL,
	cep int8 NULL,
	email varchar(100) NULL,
	email_nfe varchar(100) NULL,
	data_cadastro timestamp NULL,
	data_aprovacao timestamp NULL,
	divisao_producao int4 NULL,
	status int2 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_dcapacidade_fabrica definição

-- Drop table

-- DROP TABLE temporario.ppcp_dcapacidade_fabrica;

CREATE TABLE temporario.ppcp_dcapacidade_fabrica (
	referencia varchar(5) NULL,
	id_categoria int4 NULL,
	categoria varchar(80) NULL,
	id_agrupamento int4 NULL,
	nome_agrupamento varchar(80) NULL,
	capacidade_semanal_min numeric(18, 3) NULL,
	capacidade_semanal_pecas numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_ddivisao_producao definição

-- Drop table

-- DROP TABLE temporario.ppcp_ddivisao_producao;

CREATE TABLE temporario.ppcp_ddivisao_producao (
	divisao int8 NULL,
	cnpj varchar(25) NULL,
	nomefornecedor varchar(60) NULL,
	descricaodivisao varchar(20) NULL,
	area int8 NULL,
	descricaoarea varchar(20) NULL,
	centrocusto int8 NULL,
	descricaocentrocusto varchar(20) NULL,
	eficienciapadrao int8 NULL,
	abastecimento int2 NULL,
	rota int8 NULL,
	descricaorota varchar(40) NULL,
	tipolinha numeric(13, 3) NULL,
	tipo_recurso varchar(7) NULL,
	descricaotipolinha varchar(30) NULL,
	responsavel int8 NULL,
	descricaoresponsavel varchar(40) NULL,
	gerfac int8 NULL,
	operadores int8 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_destagio definição

-- Drop table

-- DROP TABLE temporario.ppcp_destagio;

CREATE TABLE temporario.ppcp_destagio (
	pk_estagio int2 NULL,
	desc_estagio varchar(20) NULL,
	cod_deposito int2 NULL,
	area_producao int2 NULL,
	tipo_estagio int2 NULL,
	estagio_final int2 NULL,
	sequencia_calculo_fila int2 NULL,
	estagio_base_fila int2 NULL,
	responsavel_estagio varchar(20) NULL,
	dthora_atualizacao timestamp NULL
);
CREATE INDEX ppcp_destagio_pk_estagio_idx ON temporario.ppcp_destagio USING btree (pk_estagio);


-- temporario.ppcp_dhomologacao_fornecedores definição

-- Drop table

-- DROP TABLE temporario.ppcp_dhomologacao_fornecedores;

CREATE TABLE temporario.ppcp_dhomologacao_fornecedores (
	cnpj_forn varchar(184) NULL,
	razao_social varchar(200) NULL,
	nome_fantasia varchar(200) NULL,
	id_area int2 NULL,
	nome_area varchar(20) NULL,
	centro_custo int4 NULL,
	nome_ccusto varchar(20) NULL,
	id_responsavel int4 NULL,
	nome varchar(40) NULL,
	data_cadastro timestamp NULL,
	data_aprovacao timestamp NULL,
	divisao_producao int4 NULL,
	status int2 NULL,
	desc_status varchar(19) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_dinfotec_fornecedores definição

-- Drop table

-- DROP TABLE temporario.ppcp_dinfotec_fornecedores;

CREATE TABLE temporario.ppcp_dinfotec_fornecedores (
	cnpj_forn varchar(184) NULL,
	cargo_operador int4 NULL,
	qdt_operador int4 NULL,
	grupo_maquina varchar(50) NULL,
	sub_grupo_maquina varchar(50) NULL,
	qdt_maquina int4 NULL,
	centro_custo int4 NULL,
	id_area int2 NULL,
	id_tipo_servico int4 NULL,
	id_responsavel int4 NULL,
	id_rota int2 NULL,
	is_empresa int2 NULL,
	is_maquina int2 NULL,
	prazo_abastecimento int2 NULL,
	utiliza_gerfac int2 NULL,
	custo_minuto numeric(19, 4) NULL,
	eficiencia_padrao numeric(18, 3) NULL,
	min_turno_01 numeric(18, 3) NULL,
	min_turno_02 numeric(18, 3) NULL,
	min_turno_03 numeric(18, 3) NULL,
	min_turno_04 numeric(18, 3) NULL,
	informacoes_complementares varchar(250) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX ppcp_dinfotec_fornecedores_centro_custo_grupo_maquina_sub_g_idx ON temporario.ppcp_dinfotec_fornecedores USING btree (centro_custo, grupo_maquina, sub_grupo_maquina);


-- temporario.ppcp_dmaquina definição

-- Drop table

-- DROP TABLE temporario.ppcp_dmaquina;

CREATE TABLE temporario.ppcp_dmaquina (
	pk_maquina varchar(8) NULL,
	numero_maquina int4 NULL,
	cod_grupo_maquina varchar(4) NULL,
	desc_grupo_maquina varchar(60) NULL,
	unidade_medida varchar(2) NULL,
	subgrupo_maquina varchar(3) NULL,
	desc_subgrupo varchar(10) NULL,
	observacao_subgrupo varchar(180) NULL,
	cod_familia int2 NULL,
	desc_familia varchar(25) NULL,
	maquina_ativa int4 NULL,
	cod_centro_custo int8 NULL,
	observacao_maquina varchar(65) NULL,
	dthora_atualizacao timestamp NULL,
	numero_operadores numeric(18, 3) NULL,
	volume_maximo numeric(18, 3) NULL,
	volume_minimo numeric(18, 3) NULL,
	pk_maquina_num varchar(80) NULL,
	nome_maquina varchar(10) NULL,
	descricao_maquina varchar(144) NULL
);


-- temporario.ppcp_dmotivos_reposicao definição

-- Drop table

-- DROP TABLE temporario.ppcp_dmotivos_reposicao;

CREATE TABLE temporario.ppcp_dmotivos_reposicao (
	codigo varchar(5) NULL,
	desc_motivo varchar(60) NULL,
	tipo varchar(3) NULL,
	estagio varchar(5) NULL,
	area_agrupadora varchar(5) NULL,
	desc_area varchar(60) NULL
);


-- temporario.ppcp_dobs_estagio definição

-- Drop table

-- DROP TABLE temporario.ppcp_dobs_estagio;

CREATE TABLE temporario.ppcp_dobs_estagio (
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	estagio int4 NULL,
	tamanho_ordem_confeccao varchar(15) NULL,
	tipo_obs varchar(200) NULL,
	observacao_adicional varchar(500) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_dondas_slim_sorter definição

-- Drop table

-- DROP TABLE temporario.ppcp_dondas_slim_sorter;

CREATE TABLE temporario.ppcp_dondas_slim_sorter (
	id_onda numeric(9) NULL,
	descricao_onda text NULL,
	situacao_pedido numeric(2) NULL,
	situacao_onda numeric(2) NULL,
	situacao_onda_desc text NULL,
	id_pedido numeric(9) NULL,
	id_item numeric(9) NULL,
	grupo text NULL,
	subgrupo text NULL,
	item text NULL,
	sku text NULL,
	qtd_coletar_item numeric(4) NULL,
	qtd_coletada_item numeric(4) NULL,
	situacao_item numeric(2) NULL,
	situacao_onda_item text NULL,
	usuario_situacao numeric(5) NULL,
	usuario_situacao_item text NULL,
	id_tag text NULL
);


-- temporario.ppcp_doperacao definição

-- Drop table

-- DROP TABLE temporario.ppcp_doperacao;

CREATE TABLE temporario.ppcp_doperacao (
	desc_operacao varchar(50) NULL,
	pk_operacao int4 NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX ppcp_doperacao_pk_operacao_idx ON temporario.ppcp_doperacao USING btree (pk_operacao);


-- temporario.ppcp_dpolivalencia_maquinas definição

-- Drop table

-- DROP TABLE temporario.ppcp_dpolivalencia_maquinas;

CREATE TABLE temporario.ppcp_dpolivalencia_maquinas (
	id int8 NULL,
	maquina_princ varchar(8) NULL,
	maquina_poli_1 varchar(8) NULL,
	maquina_poli_2 varchar(8) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_dprevisao_vendas definição

-- Drop table

-- DROP TABLE temporario.ppcp_dprevisao_vendas;

CREATE TABLE temporario.ppcp_dprevisao_vendas (
	id int4 NULL,
	descricao varchar(255) NULL,
	descricaocolecao varchar(255) NULL,
	descricaotabprecosellin varchar(255) NULL,
	descricaotabprecosellout varchar(255) NULL,
	ref_cor varchar(100) NULL,
	sku varchar(100) NULL,
	percentual_aplicar numeric(10, 4) NULL,
	qtde_previsao_item numeric(15, 4) NULL,
	valor_sell_in numeric(15, 4) NULL,
	valor_sell_out numeric(15, 4) NULL,
	qtde_previsao_capa numeric(15, 4) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_dtecidos definição

-- Drop table

-- DROP TABLE temporario.ppcp_dtecidos;

CREATE TABLE temporario.ppcp_dtecidos (
	ref_tecido varchar(5) NULL,
	descricao_tecido varchar(30) NULL,
	referencia varchar(5) NULL,
	cod_cor varchar(6) NULL,
	cod_tecido varchar(50) NULL,
	unidade_medida varchar(2) NULL,
	composicao varchar(300) NULL,
	tipo_produto varchar(9) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fapontamento_producao definição

-- Drop table

-- DROP TABLE temporario.ppcp_fapontamento_producao;

CREATE TABLE temporario.ppcp_fapontamento_producao (
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	oc int4 NULL,
	periodo_confeccao int2 NULL,
	nivel varchar(1) NULL,
	grupo varchar(5) NULL,
	subgrupo varchar(3) NULL,
	item varchar(6) NULL,
	codigo_estagio int4 NULL,
	data_insercao timestamp NULL,
	codigo_usuario int4 NULL,
	qtd_apontada numeric(18, 3) NULL,
	qtde_perdas numeric(18, 3) NULL,
	qtde_pecas_2a numeric(18, 3) NULL,
	qtde_conserto numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	pk_produto varchar(35) NULL
);


-- temporario.ppcp_faprovacao_rolos_930 definição

-- Drop table

-- DROP TABLE temporario.ppcp_faprovacao_rolos_930;

CREATE TABLE temporario.ppcp_faprovacao_rolos_930 (
	lote varchar(10) NULL,
	rolo varchar(10) NULL,
	aprovado numeric(17, 2) NULL,
	id_motivo int4 NULL,
	desc_motivo varchar(60) NULL
);


-- temporario.ppcp_faprovacoes_requisicao definição

-- Drop table

-- DROP TABLE temporario.ppcp_faprovacoes_requisicao;

CREATE TABLE temporario.ppcp_faprovacoes_requisicao (
	data_solicitacao timestamp NULL,
	ordem_producao int4 NULL,
	ordem_reposicao int4 NULL,
	estagio_solicitante int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	alternativa_peca int2 NULL,
	parte_peca varchar(30) NULL,
	quantidade int4 NULL,
	cod_motivo_reposicao int4 NULL,
	status int2 NULL,
	status_repo varchar(32) NULL,
	status_pcp int2 NULL,
	desc_status_pcp varchar(32) NULL,
	status_qualidade int2 NULL,
	desc_status_quali varchar(32) NULL,
	necessita_amostra int2 NULL,
	observacao varchar(500) NULL,
	obs_reprovacao varchar(500) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fbeneficiamento_acomp_prod definição

-- Drop table

-- DROP TABLE temporario.ppcp_fbeneficiamento_acomp_prod;

CREATE TABLE temporario.ppcp_fbeneficiamento_acomp_prod (
	ordem_producao int4 NULL,
	codigo_estagio int4 NULL,
	seq_operacao int4 NULL,
	codigo_operacao int4 NULL,
	grupo_maquina varchar(50) NULL,
	subgrupo_maquina varchar(50) NULL,
	numero_maquina int4 NULL,
	data_inicio date NULL,
	hora_inicio timestamp NULL,
	operador_inicio int4 NULL,
	data_termino date NULL,
	hora_termino timestamp NULL,
	operador_termino int4 NULL,
	minutos_unitario numeric(10, 2) NULL,
	motivo_rejeicao varchar(255) NULL,
	ordem_reprocesso varchar(50) NULL,
	prioridade_producao varchar(20) NULL,
	previsao_termino date NULL
);


-- temporario.ppcp_fconsumo_componente definição

-- Drop table

-- DROP TABLE temporario.ppcp_fconsumo_componente;

CREATE TABLE temporario.ppcp_fconsumo_componente (
	alternativa_item int2 NULL,
	fk_produto varchar(40) NULL,
	desc_produto varchar(70) NULL,
	fk_componente varchar(40) NULL,
	narrativa varchar(70) NULL,
	linha_produto int2 NULL,
	descr_colecao varchar(20) NULL,
	alternativa_comp int2 NULL,
	estagio int4 NULL,
	artigo_cotas int2 NULL,
	descr_tamanho varchar(10) NULL,
	tipo_produto int2 NULL,
	unidade_medida varchar(2) NULL,
	ref_produto varchar(5) NULL,
	tam_produto varchar(3) NULL,
	cor_produto varchar(6) NULL,
	nivel_produto varchar(1) NULL,
	ref_componente varchar(5) NULL,
	tam_componente varchar(3) NULL,
	cor_componente varchar(6) NULL,
	nivel_componente varchar(1) NULL,
	ultima_atualizacao timestamp NULL,
	colecao int2 NULL,
	consumo numeric(18, 3) NULL
);


-- temporario.ppcp_fconsumo_componente_inc definição

-- Drop table

-- DROP TABLE temporario.ppcp_fconsumo_componente_inc;

CREATE TABLE temporario.ppcp_fconsumo_componente_inc (
	tecido varchar(5) NULL,
	descricao varchar(30) NULL,
	tamanho varchar(3) NULL,
	u_m varchar(2) NULL,
	pk_produto varchar(35) NULL,
	consumo numeric(20, 7) NULL,
	cod_linha_produto int2 NULL,
	cod_artigo int2 NULL,
	cod_publico_alvo int2 NULL,
	cod_estagio int4 NULL,
	pk_componente varchar(100) NULL,
	ref_cor_componente varchar(6) NULL,
	ref_cor_produto varchar(6) NULL,
	preco_informado numeric(20, 5) NULL,
	preco_ult_compra numeric(20, 5) NULL,
	preco_medio numeric(20, 5) NULL,
	situacao_comp varchar(32) NULL,
	um_componente varchar(2) NULL,
	ult_atualizacao timestamp NULL,
	composicao varchar(100) NULL,
	gramatura numeric(18, 3) NULL,
	largura numeric(10, 3) NULL,
	rendimento numeric(10, 2) NULL,
	conta_de_estoque varchar(100) NULL,
	colecao varchar(60) NULL,
	peso_rolo numeric(18, 3) NULL,
	data_cadastro timestamp NULL,
	alternativa_item int2 NULL
);


-- temporario.ppcp_fdefeitos_producao definição

-- Drop table

-- DROP TABLE temporario.ppcp_fdefeitos_producao;

CREATE TABLE temporario.ppcp_fdefeitos_producao (
	cod_estagio numeric(5) NULL,
	cod_estagio_digitacao numeric(5) NULL,
	cod_motivo numeric(3) NULL,
	num_ordem_confeccao numeric(5) NULL,
	cod_periodo numeric(4) NULL,
	num_ordem_producao numeric(9) NULL,
	cod_agrupador numeric(4) NULL,
	pk_defeito numeric(4) NULL,
	ultima_atualizacao timestamp NULL,
	data_rejeicao timestamp NULL,
	pk_produto varchar(35) NULL,
	des_motivo varchar(60) NULL,
	des_cod_motivo varchar(132) NULL,
	obs_perda varchar(1000) NULL,
	qtd_perda numeric(18, 3) NULL,
	tip_lancto varchar(20) NULL,
	des_agrupador varchar(40) NULL,
	pk_motivo varchar(20) NULL
);
CREATE INDEX ppcp_fdefeitos_producao_cod_estagio_cod_estagio_digitacao_d_idx ON temporario.ppcp_fdefeitos_producao USING btree (cod_estagio, cod_estagio_digitacao, data_rejeicao);
CREATE INDEX ppcp_fdefeitos_producao_num_ordem_producao_num_ordem_confec_idx ON temporario.ppcp_fdefeitos_producao USING btree (num_ordem_producao, num_ordem_confeccao);


-- temporario.ppcp_festagios_beneficiamento definição

-- Drop table

-- DROP TABLE temporario.ppcp_festagios_beneficiamento;

CREATE TABLE temporario.ppcp_festagios_beneficiamento (
	seq_operacao numeric(4) NULL,
	codigo_estagio numeric(5) NULL,
	seq_estagio numeric(1) NULL,
	turno_producao numeric(1) NULL,
	data_inicio timestamp NULL,
	data_termino timestamp NULL
);


-- temporario.ppcp_finspecao_qualidade_inc definição

-- Drop table

-- DROP TABLE temporario.ppcp_finspecao_qualidade_inc;

CREATE TABLE temporario.ppcp_finspecao_qualidade_inc (
	data_inspecao timestamp NULL,
	id_inspecao numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	ordem_confeccao numeric(5) NULL,
	periodo numeric(4) NULL,
	turno numeric(1) NULL,
	cod_estagio numeric(2) NULL,
	inspetor text NULL,
	pk_produto text NULL,
	grupo_maq_estamp text NULL,
	subgrupo_maq_estamp text NULL,
	revisor_origem text NULL,
	qtde_inspecionar_pcs numeric(6) NULL,
	perc_inspecionar_pcs numeric(3) NULL,
	qtde_inspecionada_pcs numeric(6) NULL,
	qtde_rejeitada_pcs numeric(6) NULL,
	perc_rejeitada_pcs numeric(3) NULL,
	tipo_inspecao numeric(1) NULL,
	id_lancamento numeric(9) NULL,
	cod_estagio_defeito numeric(2) NULL,
	cod_motivo numeric(3) NULL,
	motivo text NULL,
	qtd_inspecao numeric(6) NULL,
	cod_chave_inspecao_medidas numeric(9) NULL,
	cod_chave_inspecao numeric(9) NULL,
	cod_chave_lancamento numeric(9) NULL,
	tip_medida numeric(2) NULL,
	seq_inspecao numeric(3) NULL,
	des_inspecao text NULL,
	val_medida_padrao numeric(7, 3) NULL,
	val_medida_real numeric(7, 3) NULL,
	val_toler_minima numeric(6, 2) NULL,
	val_toler_maxima numeric(6, 2) NULL,
	val_variacao numeric(7, 3) NULL,
	cod_usuario text NULL,
	dat_hor_inspecao timestamp NULL,
	data_atualizacao timestamp NULL
);
CREATE INDEX ppcp_finspecao_qualidade_inc_cod_estagio_cod_estagio_defeit_idx ON temporario.ppcp_finspecao_qualidade_inc USING btree (cod_estagio, cod_estagio_defeito, data_inspecao);
CREATE INDEX ppcp_finspecao_qualidade_inc_ordem_producao_ordem_confeccao_idx ON temporario.ppcp_finspecao_qualidade_inc USING btree (ordem_producao, ordem_confeccao);
CREATE INDEX ppcp_finspecao_qualidade_inc_pk_produto_idx ON temporario.ppcp_finspecao_qualidade_inc USING btree (pk_produto);


-- temporario.ppcp_fitens_requisicao_almoxerifado definição

-- Drop table

-- DROP TABLE temporario.ppcp_fitens_requisicao_almoxerifado;

CREATE TABLE temporario.ppcp_fitens_requisicao_almoxerifado (
	empresa int2 NULL,
	desc_empresa varchar(35) NULL,
	divisao_producao int2 NULL,
	desc_divisao_producao varchar(20) NULL,
	centro_custo int4 NULL,
	desc_centro_custo varchar(20) NULL,
	cod_deposito int2 NULL,
	sequencia int2 NULL,
	material varchar(120) NULL,
	quantidade numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_flista_prioridades definição

-- Drop table

-- DROP TABLE temporario.ppcp_flista_prioridades;

CREATE TABLE temporario.ppcp_flista_prioridades (
	id float8 NULL,
	referencia varchar(5) NULL,
	descreferencia varchar(30) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	desccor varchar(20) NULL,
	ordemproducao int4 NULL,
	prioridadecor int4 NULL,
	ordemconfeccao int4 NULL,
	periodo int2 NULL,
	seqfilaestagio int2 NULL,
	seqestagio int2 NULL,
	seqoperacao int2 NULL,
	codestagio int4 NULL,
	codestagiodepende int4 NULL,
	descestagio varchar(20) NULL,
	pedidovenda int4 NULL,
	qtdeprogramada int4 NULL,
	qtdeemproducaopacote int4 NULL,
	emconserto numeric(21, 3) NULL,
	codfamilia int4 NULL,
	codfaccao varchar(100) NULL,
	descfaccao varchar(60) NULL,
	dataentradaestagio timestamp NULL,
	qtdeestagiossimultatendidos numeric(21, 3) NULL,
	familiaacabamento varchar(80) NULL,
	tempounit numeric(21, 3) NULL,
	qtdecarteira numeric(21, 3) NULL,
	qtdeestoque numeric(21, 3) NULL,
	qtdeemproducao numeric(21, 3) NULL,
	qtdesugerida numeric(21, 3) NULL,
	qtdecoletada numeric(21, 3) NULL,
	ultima_atualizacao date NULL
);


-- temporario.ppcp_fmaquinas_divisao definição

-- Drop table

-- DROP TABLE temporario.ppcp_fmaquinas_divisao;

CREATE TABLE temporario.ppcp_fmaquinas_divisao (
	cnpj varchar(35) NULL,
	maquina varchar(75) NULL,
	divisao int8 NULL,
	quantidade int4 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fmaquinas_divisao_externa definição

-- Drop table

-- DROP TABLE temporario.ppcp_fmaquinas_divisao_externa;

CREATE TABLE temporario.ppcp_fmaquinas_divisao_externa (
	divisao numeric(38, 10) NULL,
	nome_divisao text NULL,
	cnpj text NULL,
	cod_maquina text NULL,
	maquina text NULL,
	quantidade numeric(6) NULL,
	data_atualizacao timestamp NULL
);
CREATE INDEX ppcp_fmaquinas_divisao_externa_maquina_cnpj_divisao_idx ON temporario.ppcp_fmaquinas_divisao_externa USING btree (maquina, cnpj, divisao);


-- temporario.ppcp_fmaquinas_divisao_interna definição

-- Drop table

-- DROP TABLE temporario.ppcp_fmaquinas_divisao_interna;

CREATE TABLE temporario.ppcp_fmaquinas_divisao_interna (
	cod_divisao numeric(38, 10) NULL,
	nome_divisao text NULL,
	centro_custo numeric(6) NULL,
	cod_maquina text NULL,
	cod_maquina_completo text NULL,
	descricao_ativo text NULL,
	divisao numeric(38, 10) NULL,
	tipo_maquina text NULL,
	tipo_operacao numeric(1) NULL,
	un_med_capacid text NULL,
	status_ativo text NULL,
	contagem_numero_serie numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX ppcp_fmaquinas_divisao_intern_cod_maquina_completo_cod_maqu_idx ON temporario.ppcp_fmaquinas_divisao_interna USING btree (cod_maquina_completo, cod_maquina, centro_custo, divisao);


-- temporario.ppcp_fmedidas_insumos definição

-- Drop table

-- DROP TABLE temporario.ppcp_fmedidas_insumos;

CREATE TABLE temporario.ppcp_fmedidas_insumos (
	referencia varchar(80) NULL,
	alternativa int4 NULL,
	sequencia int4 NULL,
	seq_estrutura int4 NULL,
	parte_conjunto int4 NULL,
	descricao varchar(180) NULL,
	proporcao int4 NULL,
	tolerancia_min int4 NULL,
	tolerancia_max int4 NULL,
	tamanho varchar(40) NULL,
	unidade_metrica varchar(25) NULL,
	medida numeric(15, 3) NULL,
	medida_pf varchar(80) NULL,
	tipo_medida int4 NULL
);


-- temporario.ppcp_fmovimentacao_enderecos definição

-- Drop table

-- DROP TABLE temporario.ppcp_fmovimentacao_enderecos;

CREATE TABLE temporario.ppcp_fmovimentacao_enderecos (
	produto text NULL,
	nivel text NULL,
	grupo text NULL,
	subgrupo text NULL,
	item text NULL,
	descricao text NULL,
	deposito numeric(3) NULL,
	situacaotag numeric(1) NULL,
	qtdeenderecado numeric(38, 10) NULL,
	qtdesemendereco numeric(38, 10) NULL
);


-- temporario.ppcp_foperacao definição

-- Drop table

-- DROP TABLE temporario.ppcp_foperacao;

CREATE TABLE temporario.ppcp_foperacao (
	fk_operacao int4 NULL,
	fk_maquina varchar(8) NULL,
	tipo_operacao int2 NULL,
	pede_produto int2 NULL,
	fk_cargo int4 NULL,
	fk_aparelho varchar(6) NULL,
	operando int2 NULL,
	dthora_atualizacao timestamp NULL,
	tempo_maquina numeric(18, 3) NULL,
	tempo_homem numeric(18, 3) NULL,
	centimetros_linha numeric(18, 3) NULL
);


-- temporario.ppcp_foperadores_divisao definição

-- Drop table

-- DROP TABLE temporario.ppcp_foperadores_divisao;

CREATE TABLE temporario.ppcp_foperadores_divisao (
	data_operadoras timestamp NULL,
	turno_familia int2 NULL,
	divisao int4 NULL,
	numero_operadoras int2 NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fordem_producao_leadtime definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordem_producao_leadtime;

CREATE TABLE temporario.ppcp_fordem_producao_leadtime (
	periodo numeric(38, 10) NULL,
	ordem_producao numeric(9) NULL,
	codigo_estagio numeric(5) NULL,
	qtde_produzida numeric(38, 10) NULL,
	data_entrada_fase timestamp NULL,
	data_saida_fase timestamp NULL,
	lead_time numeric(38, 10) NULL
);


-- temporario.ppcp_fordens_aproduzir definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_aproduzir;

CREATE TABLE temporario.ppcp_fordens_aproduzir (
	op_ordem_producao numeric(9) NULL,
	div_prod numeric(4) NULL,
	artigo numeric(4) NULL,
	referencia_peca text NULL,
	situacao numeric(1) NULL,
	qtde_programada numeric(6) NULL,
	situacao_corte numeric(1) NULL,
	codigo_empresa numeric(38, 10) NULL,
	prod_ordem_producao numeric(9) NULL,
	seq_operacao numeric(38, 10) NULL,
	cod_estagio numeric(5) NULL,
	qtde_pecas_prog numeric(38, 10) NULL,
	a_produzir numeric(38, 10) NULL,
	qtde_a_produzir_pacote numeric(38, 10) NULL,
	qtd_produzida numeric(38, 10) NULL,
	perc_produzido numeric(38, 10) NULL,
	qtde_2a numeric(38, 10) NULL,
	qtde_cons numeric(38, 10) NULL,
	qtde_perd numeric(38, 10) NULL
);


-- temporario.ppcp_fordens_aproduzir_pacote definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_aproduzir_pacote;

CREATE TABLE temporario.ppcp_fordens_aproduzir_pacote (
	ordem_producao numeric(9) NULL,
	periodo_producao numeric(4) NULL,
	cod_estagio numeric(5) NULL,
	seq_est numeric(3) NULL,
	cod_cor text NULL,
	cod_tam text NULL,
	qtde_pecas_prog numeric(38, 10) NULL,
	qtde_a_produzir_pacote numeric(38, 10) NULL
);


-- temporario.ppcp_fordens_beneficiamento definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_beneficiamento;

CREATE TABLE temporario.ppcp_fordens_beneficiamento (
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	data_inicio timestamp NULL,
	data_termino timestamp NULL,
	atraso int4 NULL,
	cod_situacao int4 NULL,
	situacao varchar(15) NULL,
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	tipo_ordem varchar(1) NULL,
	ordem_agrupamento int4 NULL,
	codigo_estagio int4 NULL,
	situacao_receita varchar(1) NULL,
	grupo_tingimento varchar(102) NULL,
	tempo float8 NULL,
	seq_operacao float8 NULL,
	pk_produto varchar(50) NULL,
	um varchar(2) NULL,
	alternativa_item int2 NULL,
	ultima_atualizacao timestamp NULL,
	quilos_prod numeric(21, 3) NULL,
	rolos_prod numeric(21, 3) NULL,
	quilos_prog numeric(21, 3) NULL,
	rolos_prog numeric(21, 3) NULL,
	quilos_prep numeric(21, 3) NULL,
	rolos_prep numeric(21, 3) NULL,
	prioridade_onebit varchar(10) NULL
);


-- temporario.ppcp_fordens_corte_hist definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_corte_hist;

CREATE TABLE temporario.ppcp_fordens_corte_hist (
	id varchar(25) NULL
);


-- temporario.ppcp_fordens_em_producao definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_em_producao;

CREATE TABLE temporario.ppcp_fordens_em_producao (
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	codigo_estagio int4 NULL,
	sequencia_estagio int2 NULL,
	estagio_anterior int4 NULL,
	seq_operacao int2 NULL,
	prioridade_produ int4 NULL,
	alternativa_peca int2 NULL,
	fk_produto varchar(35) NULL,
	qtde_pecas_prog numeric(18, 3) NULL,
	qtde_pecas_prod numeric(18, 3) NULL,
	qtde_em_producao numeric(18, 3) NULL,
	qtde_programada numeric(18, 3) NULL,
	qtde_conserto numeric(18, 3) NULL,
	qtde_pecas_2a numeric(18, 3) NULL,
	qtde_perdas numeric(18, 3) NULL,
	numero_ordem int4 NULL,
	cnpj_fornecedor varchar(35) NULL,
	ultima_atualizacao timestamp NULL,
	data_alteracao timestamp NULL,
	qtde_pecas_prog_ktl numeric(18, 3) NULL,
	cod_cancelamento int8 NULL
);


-- temporario.ppcp_fordens_em_producao_inc definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_em_producao_inc;

CREATE TABLE temporario.ppcp_fordens_em_producao_inc (
	periodo_producao int2 NULL,
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	codigo_estagio int4 NULL,
	sequencia_estagio int2 NULL,
	estagio_anterior int4 NULL,
	seq_operacao int2 NULL,
	prioridade_produ int4 NULL,
	alternativa_peca int2 NULL,
	fk_produto varchar(35) NULL,
	qtde_pecas_prog numeric(18, 3) NULL,
	qtde_pecas_prod numeric(18, 3) NULL,
	qtde_em_producao numeric(18, 3) NULL,
	qtde_programada numeric(18, 3) NULL,
	qtde_conserto numeric(18, 3) NULL,
	qtde_pecas_2a numeric(18, 3) NULL,
	qtde_perdas numeric(18, 3) NULL,
	numero_ordem int4 NULL,
	cnpj_fornecedor varchar(35) NULL,
	ultima_atualizacao timestamp NULL,
	data_alteracao timestamp NULL,
	qtde_pecas_prog_ktl numeric(18, 3) NULL,
	cod_cancelamento int8 NULL
);


-- temporario.ppcp_fordens_malharia definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_malharia;

CREATE TABLE temporario.ppcp_fordens_malharia (
	fk_produto varchar(21) NULL,
	fk_maquina varchar(11) NULL,
	fk_fornecedor varchar(21) NULL,
	fk_cliente varchar(20) NULL,
	fk_produto_pano varchar(21) NULL,
	fk_produto_acab varchar(21) NULL,
	flag_ordens_malharia varchar(14) NULL,
	cd_endereco_rolo varchar(33) NULL,
	vlr_mt_lineares numeric(18, 3) NULL,
	cd_nr_lote varchar(18) NULL,
	cd_maquina int4 NULL,
	cd_programa int4 NULL,
	cd_ordem_tecelagem int4 NULL,
	cd_periodo_producao int4 NULL,
	qtd_quilos_prod numeric(15, 3) NULL,
	seq_ordem_serv int4 NULL,
	cd_tipo_prod int4 NULL,
	qtd_quilos_acab numeric(15, 3) NULL,
	qtd_unid_prog int8 NULL,
	cd_rolo int8 NULL,
	cd_nr_rolo int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.ppcp_fordens_produzidas_alt_item_inc definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_produzidas_alt_item_inc;

CREATE TABLE temporario.ppcp_fordens_produzidas_alt_item_inc (
	cd_nivel99 text NULL,
	cd_grupo text NULL,
	cd_subgrupo text NULL,
	cd_item text NULL,
	data_producao timestamp NULL,
	periodo_capa numeric(4) NULL,
	periodo_producao numeric(4) NULL,
	cd_estagio numeric(5) NULL,
	des_estagio text NULL,
	data_entrada_estagio timestamp NULL,
	turno text NULL,
	cd_ordem_producao numeric(9) NULL,
	cd_ordem_confeccao numeric(5) NULL,
	nome_fornecedor text NULL,
	des_familia text NULL,
	qtd_produzidas numeric(6) NULL,
	qtd_conserto numeric(6) NULL,
	qtd_perdas numeric(6) NULL,
	qtd_segunda numeric(6) NULL,
	tempo_unit numeric(38, 10) NULL,
	qtde_estampas numeric(38, 10) NULL,
	tempo_costura numeric(38, 10) NULL,
	alternativa_peca numeric(2) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fordens_produzidas_inc definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_produzidas_inc;

CREATE TABLE temporario.ppcp_fordens_produzidas_inc (
	cd_nivel99 text NULL,
	cd_grupo text NULL,
	cd_subgrupo text NULL,
	cd_item text NULL,
	data_producao timestamp NULL,
	periodo_capa numeric(4) NULL,
	periodo_producao numeric(4) NULL,
	cd_estagio numeric(5) NULL,
	des_estagio text NULL,
	data_entrada_estagio timestamp NULL,
	turno text NULL,
	cd_ordem_producao text NULL,
	cd_ordem_confeccao numeric(5) NULL,
	nome_fornecedor text NULL,
	des_familia text NULL,
	qtd_produzidas numeric(38, 10) NULL,
	qtd_conserto numeric(6) NULL,
	qtd_perdas numeric(6) NULL,
	qtd_segunda numeric(6) NULL,
	tempo_unit numeric(38, 10) NULL,
	qtde_estampas numeric(38, 10) NULL,
	tempo_costura numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL,
	estagio_anterior varchar(30) NULL
);
CREATE INDEX ppcp_fordens_produzidas_inc_cd_estagio_data_producao_idx ON temporario.ppcp_fordens_produzidas_inc USING btree (cd_estagio, data_producao);
CREATE INDEX ppcp_fordens_produzidas_inc_cd_grupo_cd_subgrupo_cd_item_cd_idx ON temporario.ppcp_fordens_produzidas_inc USING btree (cd_grupo, cd_subgrupo, cd_item, cd_nivel99);
CREATE INDEX ppcp_fordens_produzidas_inc_cd_ordem_producao_cd_ordem_conf_idx ON temporario.ppcp_fordens_produzidas_inc USING btree (cd_ordem_producao, cd_ordem_confeccao);
CREATE INDEX ppcp_fordens_produzidas_inc_periodo_producao_idx ON temporario.ppcp_fordens_produzidas_inc USING btree (periodo_producao);


-- temporario.ppcp_fordens_reposicoes definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_reposicoes;

CREATE TABLE temporario.ppcp_fordens_reposicoes (
	id_reposicao int4 NULL,
	ordemreposicaoformatted varchar(40) NULL,
	solicitacao_reposicao int4 NULL,
	ordemreposicao int4 NULL,
	ordemproducao int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(20) NULL,
	cor varchar(6) NULL,
	estagioformatted varchar(61) NULL,
	estagio int2 NULL,
	datageracao timestamp NULL,
	usuariogerador varchar(50) NULL,
	databaixaestagio timestamp NULL,
	usuariobaixaestagio varchar(50) NULL,
	situacao int2 NULL,
	observacao varchar(200) NULL,
	solicitante varchar(60) NULL,
	motivocancelamento varchar(100) NULL,
	diasfase numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	parte_peca varchar(30) NULL,
	cod_motivo_reposicao numeric(9) NULL,
	quantidade numeric(9) NULL
);


-- temporario.ppcp_fordens_servico definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_servico;

CREATE TABLE temporario.ppcp_fordens_servico (
	numero_ordem int8 NULL,
	ordem_producao int8 NULL,
	nota_fiscal int8 NULL,
	cod_fornecedor varchar(20) NULL,
	data_emissao date NULL,
	data_entrega date NULL,
	codigo_servico int4 NULL,
	cod_tabela_serv int4 NULL,
	cod_canc_ordem int4 NULL,
	descr_canc_ordem varchar(255) NULL,
	cond_pgto varchar(50) NULL,
	situacao_ordem varchar(20) NULL,
	valor numeric(18, 2) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fordens_servico_itens definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_servico_itens;

CREATE TABLE temporario.ppcp_fordens_servico_itens (
	pk_ordens_servico_itens varchar(84) NULL,
	fk_ordens_servico_capa varchar(9) NULL,
	cd_nr_ordem numeric(9) NULL,
	seq numeric(6) NULL,
	cd_lote numeric(6) NULL,
	dt_prev_areceber date NULL,
	vlr_servico numeric(18, 4) NULL,
	qtd_areceber numeric(17, 3) NULL,
	cd_sit_areceber numeric(4) NULL,
	vlr_prod numeric(16, 2) NULL,
	cd_nota_saida numeric(12) NULL,
	cd_serie_saida varchar(6) NULL,
	seq_nota_saida numeric(6) NULL,
	qtd_real_ret numeric(17, 3) NULL,
	cd_ref_forne varchar(33) NULL,
	cd_perc_imposto numeric(9, 2) NULL,
	qtd_pag numeric(18, 3) NULL,
	cd_nr_ordem_origem numeric(9) NULL,
	seq_origem numeric(6) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.ppcp_fordens_tecelagem definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_tecelagem;

CREATE TABLE temporario.ppcp_fordens_tecelagem (
	pk_maquina varchar(39) NULL,
	pk_maquina_num varchar(111) NULL,
	data_inicial timestamp NULL,
	data_final timestamp NULL,
	atraso int4 NULL,
	cod_situacao int4 NULL,
	situacao varchar(15) NULL,
	periodo_producao int2 NULL,
	ordem_tecelagem int4 NULL,
	codigo_estagio int4 NULL,
	seq_operacao int4 NULL,
	pk_produto varchar(85) NULL,
	um varchar(2) NULL,
	ultima_atualizacao timestamp NULL,
	quilos_prod numeric(21, 3) NULL,
	rolos_prod numeric(21, 3) NULL,
	quilos_prog numeric(21, 3) NULL,
	rolos_prog numeric(21, 3) NULL,
	saldo_quilos numeric(21, 3) NULL,
	saldo_rolos numeric(21, 3) NULL
);


-- temporario.ppcp_fordens_tinturaria definição

-- Drop table

-- DROP TABLE temporario.ppcp_fordens_tinturaria;

CREATE TABLE temporario.ppcp_fordens_tinturaria (
	pk_ordens_tinturaria varchar(308) NULL,
	fk_produtos varchar(21) NULL,
	fk_maquina varchar(11) NULL,
	flag_ordens_tinturaria varchar(13) NULL,
	cd_ordem_prod int8 NULL,
	cd_deposito int4 NULL,
	cd_pedido_corte int2 NULL,
	seq_ordem_prod int4 NULL,
	cd_acomp int4 NULL,
	qtd_rolos_prog numeric(16, 3) NULL,
	qtd_quilos_prog numeric(19, 3) NULL,
	qtd_quilos_prod numeric(16, 3) NULL,
	qtd_rolos_prod numeric(16, 3) NULL,
	cd_roteiro int4 NULL,
	qtd_unidade_prog numeric(21, 3) NULL,
	cd_lote_acomp int4 NULL,
	seq int4 NULL,
	qtd_unidade numeric(16, 3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.ppcp_fpontualidade_beneficiamento definição

-- Drop table

-- DROP TABLE temporario.ppcp_fpontualidade_beneficiamento;

CREATE TABLE temporario.ppcp_fpontualidade_beneficiamento (
	periodo int4 NULL,
	codigo_estagio int4 NULL,
	termino_previsto timestamp NULL,
	data_congelamento timestamp NULL,
	ordem_beneficiamento int4 NULL,
	produto varchar(50) NULL,
	descricao varchar(255) NULL,
	data_termino timestamp NULL,
	data_inicio_fatu timestamp NULL,
	programado numeric(15, 3) NULL,
	produzido numeric(15, 3) NULL,
	kg_programados numeric(15, 3) NULL,
	kg_produzidos numeric(15, 3) NULL,
	quebra numeric(15, 3) NULL,
	percentual_pontualidade numeric(5, 2) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fpontualidade_confeccao definição

-- Drop table

-- DROP TABLE temporario.ppcp_fpontualidade_confeccao;

CREATE TABLE temporario.ppcp_fpontualidade_confeccao (
	periodo int4 NULL,
	data_ini_fatu timestamp NULL,
	codigo_estagio int4 NULL,
	sequencia int4 NULL,
	inicio_previsto timestamp NULL,
	termino_previsto timestamp NULL,
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	referencia varchar(50) NULL,
	tamanho varchar(20) NULL,
	cor varchar(50) NULL,
	descricao varchar(255) NULL,
	data_congelamento timestamp NULL,
	programado numeric(15, 3) NULL,
	produzido numeric(15, 3) NULL,
	qtde_pontual numeric(15, 3) NULL,
	percentual_pontualidade numeric(5, 2) NULL,
	a_produzir numeric(15, 3) NULL,
	em_producao numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fproducao_seda definição

-- Drop table

-- DROP TABLE temporario.ppcp_fproducao_seda;

CREATE TABLE temporario.ppcp_fproducao_seda (
	turno numeric(38) NULL,
	nome text NULL,
	pedido numeric(9) NULL,
	qtdepecas numeric(38, 10) NULL,
	dataleitura timestamp NULL
);


-- temporario.ppcp_fprodutividade_operador_marft definição

-- Drop table

-- DROP TABLE temporario.ppcp_fprodutividade_operador_marft;

CREATE TABLE temporario.ppcp_fprodutividade_operador_marft (
	"data" timestamp NULL,
	codigo_operador numeric(5) NULL,
	nome text NULL,
	cpf text NULL,
	cracha text NULL,
	status text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	"percent" numeric(5, 4) NULL,
	award_coefficient_c numeric(4, 2) NULL,
	award_coefficient_i numeric(4, 2) NULL,
	award_individual_me numeric(2, 2) NULL,
	status_marft varchar(25) NULL,
	ultima_atualizacao timestamp NULL
);
CREATE INDEX ppcp_fprodutividade_operador_marft_codigo_celula_idx ON temporario.ppcp_fprodutividade_operador_marft USING btree (codigo_celula);
CREATE INDEX ppcp_fprodutividade_operador_marft_nome_data_idx ON temporario.ppcp_fprodutividade_operador_marft USING btree (nome, data DESC);


-- temporario.ppcp_fprodutos_bloqueados_venda definição

-- Drop table

-- DROP TABLE temporario.ppcp_fprodutos_bloqueados_venda;

CREATE TABLE temporario.ppcp_fprodutos_bloqueados_venda (
	linha numeric(3) NULL,
	artigo numeric(5) NULL,
	colecao numeric(4) NULL,
	pk_produto text NULL,
	sku_produto text NULL,
	per_ini_bloq timestamp NULL,
	per_fim_bloq timestamp NULL,
	observacao_bloq text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fqtd_produzida definição

-- Drop table

-- DROP TABLE temporario.ppcp_fqtd_produzida;

CREATE TABLE temporario.ppcp_fqtd_produzida (
	ordem_producao int4 NULL,
	oc int4 NULL,
	codigo_estagio int4 NULL,
	data_producao timestamp NULL,
	ultima_atualizacao timestamp NULL,
	referencia varchar(5) NULL,
	tamanho varchar(3) NULL,
	cor varchar(6) NULL,
	qtd_programada int4 NULL,
	codigo_usuario int4 NULL,
	qtd_produzida numeric(18, 3) NULL
);


-- temporario.ppcp_fqtd_produzida_inc definição

-- Drop table

-- DROP TABLE temporario.ppcp_fqtd_produzida_inc;

CREATE TABLE temporario.ppcp_fqtd_produzida_inc (
	ordem_producao int4 NULL,
	oc int4 NULL,
	codigo_estagio int4 NULL,
	data_producao timestamp NULL,
	ultima_atualizacao timestamp NULL,
	periodo_producao int2 NULL,
	nivel varchar(1) NULL,
	grupo varchar(5) NULL,
	subgrupo varchar(3) NULL,
	item varchar(6) NULL,
	cod_usuario int4 NULL,
	pk_produto varchar(50) NULL,
	qtd_produzida int4 NULL
);


-- temporario.ppcp_frejeicao_pecas_tecido definição

-- Drop table

-- DROP TABLE temporario.ppcp_frejeicao_pecas_tecido;

CREATE TABLE temporario.ppcp_frejeicao_pecas_tecido (
	data_rejeicao timestamp NULL,
	ordem_producao int4 NULL,
	estagio int4 NULL,
	periodo int2 NULL,
	fk_tecido varchar(50) NULL,
	fk_produto varchar(50) NULL,
	parte_peca varchar(50) NULL,
	motivo int4 NULL,
	desc_motivo varchar(60) NULL,
	quantidade int2 NULL,
	ultima_atualizacao timestamp NULL,
	ordem_confeccao varchar(15) NULL,
	seq_operacao varchar(15) NULL
);
CREATE INDEX ppcp_frejeicao_pecas_tecido_estagio_data_rejeicao_idx ON temporario.ppcp_frejeicao_pecas_tecido USING btree (estagio, data_rejeicao);
CREATE INDEX ppcp_frejeicao_pecas_tecido_ordem_producao_idx ON temporario.ppcp_frejeicao_pecas_tecido USING btree (ordem_producao);


-- temporario.ppcp_frolos_reservados definição

-- Drop table

-- DROP TABLE temporario.ppcp_frolos_reservados;

CREATE TABLE temporario.ppcp_frolos_reservados (
	ordem_producao int4 NULL,
	codigo_rolo int4 NULL,
	deposito int2 NULL,
	cd_tecido varchar(35) NULL,
	qtde_reservada numeric(18, 3) NULL,
	qtde_necessaria numeric(18, 3) NULL,
	tipo_rolo numeric(12, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_froteiro definição

-- Drop table

-- DROP TABLE temporario.ppcp_froteiro;

CREATE TABLE temporario.ppcp_froteiro (
	num_roteiro int2 NULL,
	seq_operacao int2 NULL,
	fk_operacao int4 NULL,
	fk_estagio int2 NULL,
	seq_estagio int2 NULL,
	estagio_depende int2 NULL,
	qtd_rolos int4 NULL,
	observacao_roteiro varchar(200) NULL,
	centro_custo int4 NULL,
	ccusto_homem int4 NULL,
	dthora_atualizacao timestamp NULL,
	qtd_cordas int4 NULL,
	minutos_roteiro numeric(18, 3) NULL,
	velocidade numeric(18, 3) NULL,
	minutos_homem numeric(18, 3) NULL,
	fk_produto varchar(20) NULL,
	alternativa_item int4 NULL
);


-- temporario.ppcp_fstatus_requisicao_reposicoes definição

-- Drop table

-- DROP TABLE temporario.ppcp_fstatus_requisicao_reposicoes;

CREATE TABLE temporario.ppcp_fstatus_requisicao_reposicoes (
	data_geracao timestamp NULL,
	ordem_producao int4 NULL,
	ordem_reposicao int4 NULL,
	solicitacao_reposicao int4 NULL,
	estagio int4 NULL,
	periodo int2 NULL,
	referencia varchar(5) NULL,
	tamanho varchar(20) NULL,
	cor varchar(6) NULL,
	situacao int2 NULL,
	desc_situacao varchar(32) NULL,
	observacao varchar(500) NULL,
	motivo_cancelamento varchar(100) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fsugestao_cancelamento definição

-- Drop table

-- DROP TABLE temporario.ppcp_fsugestao_cancelamento;

CREATE TABLE temporario.ppcp_fsugestao_cancelamento (
	referencia varchar(5) NULL,
	cor varchar(6) NULL,
	cod_colecao int2 NULL,
	desc_colecao varchar(20) NULL,
	id_motivo int8 NULL,
	sugcancelproducao varchar(28) NULL,
	desc_motivo varchar(30) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_fsugestao_reserva_tecido definição

-- Drop table

-- DROP TABLE temporario.ppcp_fsugestao_reserva_tecido;

CREATE TABLE temporario.ppcp_fsugestao_reserva_tecido (
	periodo_producao varchar(8) NULL,
	fk_componente varchar(40) NULL,
	unidade_medida varchar(2) NULL,
	familia_acabamento varchar(80) NULL,
	agrupmento_artigo varchar(80) NULL,
	cd_ordem_producao varchar(25) NULL,
	cd_estagio varchar(25) NULL,
	referencia varchar(25) NULL,
	cod_cor varchar(25) NULL,
	consumo_programado varchar(25) NULL,
	mt_lineares_prod numeric(17, 2) NULL,
	alternativa_peca int2 NULL,
	pecas_pacote numeric(18, 3) NULL,
	total_consumo numeric(18, 3) NULL
);


-- temporario.ppcp_ftecidos_estoque definição

-- Drop table

-- DROP TABLE temporario.ppcp_ftecidos_estoque;

CREATE TABLE temporario.ppcp_ftecidos_estoque (
	cd_tecido varchar(30) NULL,
	nome_grupo varchar(30) NULL,
	nome_cor varchar(20) NULL,
	colecao varchar(20) NULL,
	linha varchar(40) NULL,
	artigo varchar(25) NULL,
	gramatura numeric(18, 3) NULL,
	certificacao_qualidade int2 NULL,
	codigo_deposito int2 NULL,
	rolo_estoque int2 NULL,
	codigo_rolo int4 NULL,
	unidade_medida varchar(2) NULL,
	qualidade_rolo int2 NULL,
	qtde_quilos_acab numeric(18, 3) NULL,
	mt_lineares_prod numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ppcp_ftempo_tear definição

-- Drop table

-- DROP TABLE temporario.ppcp_ftempo_tear;

CREATE TABLE temporario.ppcp_ftempo_tear (
	pk_produto text NULL,
	sku_produto text NULL,
	descr_referencia text NULL,
	numero_alternati numeric(2) NULL,
	numero_roteiro numeric(2) NULL,
	seq_operacao numeric(4) NULL,
	codigo_estagio numeric(5) NULL,
	codigo_operacao numeric(5) NULL,
	nome_operacao text NULL,
	nr_agulhas numeric(3) NULL,
	grupo_maquina text NULL,
	nome_grupo_maq text NULL,
	sub_maquina text NULL,
	tipo_carga numeric(1) NULL,
	un_med_capacid text NULL,
	man_automatica numeric(1) NULL,
	numero_cordas numeric(3) NULL,
	numero_rolos numeric(5) NULL,
	minutos_homem numeric(9, 4) NULL,
	tempo_maquina numeric(9, 4) NULL
);


-- temporario.produtos_dbriefing definição

-- Drop table

-- DROP TABLE temporario.produtos_dbriefing;

CREATE TABLE temporario.produtos_dbriefing (
	referencia varchar(5) NULL,
	cor_venda varchar(6) NULL,
	ref_cor varchar(11) NULL,
	cod_colecao int2 NULL,
	desc_colecao varchar(20) NULL,
	cod_subcolecao text NULL,
	desc_sub_colecao varchar(20) NULL,
	cod_linha int2 NULL,
	linha_produto varchar(40) NULL,
	desc_segmento varchar(60) NULL,
	pilar varchar(60) NULL,
	cod_processo int2 NULL,
	desc_processo varchar(9) NULL,
	faixa_etaria varchar(60) NULL,
	cod_artigo int2 NULL,
	desc_artigo varchar(25) NULL,
	artigos_cotas int2 NULL,
	desc_artigo_cotas varchar(25) NULL,
	desc_comercial varchar(30) NULL,
	desc_tamanhos varchar(10) NULL,
	grade varchar(4000) NULL,
	mp_principal varchar(5) NULL,
	mp_principal_desc varchar(30) NULL,
	mp_cor varchar(6) NULL,
	mp_composicao varchar(328) NULL,
	cod_cor varchar(6) NULL,
	nome_cor varchar(20) NULL,
	num_sku int4 NULL,
	desc_narrativa varchar(65) NULL,
	desc_produto varchar(20) NULL,
	preco_custo numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.produtos_dimg_produtos definição

-- Drop table

-- DROP TABLE temporario.produtos_dimg_produtos;

CREATE TABLE temporario.produtos_dimg_produtos (
	id_produto varchar(20) NULL,
	referencia varchar(20) NULL,
	cor varchar(20) NULL,
	seq_imagem int8 NULL,
	imagem_url varchar(500) NULL,
	imagem_base64 varchar(500) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_dbanco_horas definição

-- Drop table

-- DROP TABLE temporario.rh_dbanco_horas;

CREATE TABLE temporario.rh_dbanco_horas (
	descr_banco_horas varchar(50) NULL,
	dthora_atualizacao timestamp NULL,
	pk_banco_horas int4 NULL
);


-- temporario.rh_dcargo definição

-- Drop table

-- DROP TABLE temporario.rh_dcargo;

CREATE TABLE temporario.rh_dcargo (
	desc_cargo varchar(125) NULL,
	ds_cd_cargo varchar(70) NULL,
	desc_cargo_resum varchar(60) NULL,
	cd_cargo varchar(30) NULL,
	cd_est_cargo int4 NULL,
	pk_cargo varchar(30) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dcausa_demissao definição

-- Drop table

-- DROP TABLE temporario.rh_dcausa_demissao;

CREATE TABLE temporario.rh_dcausa_demissao (
	desc_dem varchar(50) NULL,
	cd_ds_dem varchar(70) NULL,
	cd_cau_rai int2 NULL,
	cd_cag int2 NULL,
	pk_causa_demissao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dcodigo_calculo definição

-- Drop table

-- DROP TABLE temporario.rh_dcodigo_calculo;

CREATE TABLE temporario.rh_dcodigo_calculo (
	pk_codigo_calculado varchar(60) NULL,
	cd_cal int4 NULL,
	cd_tip_cal int2 NULL,
	cd_sit_cal varchar(1) NULL,
	dt_per_ref timestamp NULL,
	dt_pag timestamp NULL,
	dt_ini_cmp timestamp NULL,
	dt_fim_cmp timestamp NULL,
	cd_ori int4 NULL,
	dt_ani_apu timestamp NULL,
	dt_fim_apu timestamp NULL,
	dt_ini_ace timestamp NULL,
	dt_fim_ace timestamp NULL,
	cd_tip_cao int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dcolaborador definição

-- Drop table

-- DROP TABLE temporario.rh_dcolaborador;

CREATE TABLE temporario.rh_dcolaborador (
	nm_col varchar(70) NULL,
	cd_nm_col varchar(100) NULL,
	cd_cpf int8 NULL,
	cd_num_emp int4 NULL,
	cd_num_col varchar(12) NULL,
	cd_escol int4 NULL,
	cd_cargo varchar(80) NULL,
	cd_nacio int4 NULL,
	dt_nascim timestamp NULL,
	dt_admissao timestamp NULL,
	fg_deficiente varchar(2) NULL,
	cd_sexo varchar(9) NULL,
	cd_tip_col int2 NULL,
	cd_tip_contrato int4 NULL,
	cd_afastamento int4 NULL,
	dt_afastamento_original timestamp NULL,
	dthora_atualizacao timestamp NULL,
	cd_filial int4 NULL,
	pk_colaborador varchar(180) NULL,
	centrocusto varchar(150) NULL
);


-- temporario.rh_dcolaborador_auditoria definição

-- Drop table

-- DROP TABLE temporario.rh_dcolaborador_auditoria;

CREATE TABLE temporario.rh_dcolaborador_auditoria (
	pk_colaborador_auditoria varchar(180) NULL,
	seq_reg int8 NULL,
	cd_ver_seq int8 NULL,
	nm_col varchar(70) NULL,
	cd_nm_col varchar(100) NULL,
	cd_cpf int8 NULL,
	cd_num_emp int4 NULL,
	cd_num_col varchar(12) NULL,
	cd_cargo varchar(80) NULL,
	cd_nacio int4 NULL,
	dt_nascim timestamp NULL,
	dt_admissao timestamp NULL,
	cd_sexo varchar(9) NULL,
	cd_tip_col int2 NULL,
	cd_tip_contrato int4 NULL,
	cd_afastamento int4 NULL,
	dt_afastamento_original timestamp NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_ddependente definição

-- Drop table

-- DROP TABLE temporario.rh_ddependente;

CREATE TABLE temporario.rh_ddependente (
	pk_depedente varchar(170) NULL,
	cd_nome_dep varchar(70) NULL,
	cd_nome_mae varchar(70) NULL,
	cd_gra_par int2 NULL,
	cd_tip_dep int2 NULL,
	cd_tip_sex varchar(2) NULL,
	cd_est_civ int2 NULL,
	cd_gra_ins int2 NULL,
	cd_lim_irf int2 NULL,
	cd_lim_saf int2 NULL,
	cd_avi_imp varchar(1) NULL,
	dt_nas timestamp NULL,
	dt_ent_cer timestamp NULL,
	cd_pai_nas int4 NULL,
	cd_est_nas varchar(4) NULL,
	dt_obi timestamp NULL,
	cd_nome_com varchar(70) NULL,
	cd_pes int4 NULL,
	cd_dep int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dempresa definição

-- Drop table

-- DROP TABLE temporario.rh_dempresa;

CREATE TABLE temporario.rh_dempresa (
	desc_empresa varchar(60) NULL,
	cd_ds_empresa varchar(100) NULL,
	pk_empresa int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_descala definição

-- Drop table

-- DROP TABLE temporario.rh_descala;

CREATE TABLE temporario.rh_descala (
	pk_escala int4 NULL,
	desc_nome varchar(50) NULL,
	cd_hor_dsr int8 NULL,
	cd_hor_sem int8 NULL,
	cd_hor_mes int8 NULL,
	cd_tip_fer varchar(3) NULL,
	cd_tab_fer int2 NULL,
	cd_tip_esc varchar(1) NULL,
	cd_tur_esc int2 NULL,
	cd_tip_jor int2 NULL,
	cd_tip_jos int2 NULL,
	desc_jor varchar(200) NULL,
	desc_sim varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_devento definição

-- Drop table

-- DROP TABLE temporario.rh_devento;

CREATE TABLE temporario.rh_devento (
	pk_evento varchar(110) NULL,
	cd_evento int4 NULL,
	cd_tipo_evento int2 NULL,
	desc_evento varchar(55) NULL,
	cd_ds_evento varchar(96) NULL,
	cd_tabela int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dfilial definição

-- Drop table

-- DROP TABLE temporario.rh_dfilial;

CREATE TABLE temporario.rh_dfilial (
	cd_razao_social varchar(60) NULL,
	cd_nome_filial varchar(60) NULL,
	cd_desc_filial varchar(180) NULL,
	desc_atividade varchar(80) NULL,
	cd_edificio varchar(60) NULL,
	cd_endereco varchar(160) NULL,
	cd_tip_fil varchar(3) NULL,
	cd_numcgc int8 NULL,
	cd_insest varchar(18) NULL,
	cd_filctb int4 NULL,
	cd_ultfic int8 NULL,
	desc_nomcom varchar(100) NULL,
	cd_parpat varchar(3) NULL,
	pk_filial varchar(120) NULL,
	dthora_atualizacao timestamp NULL,
	cd_filial int4 NULL,
	pk_cnpj int8 NULL,
	cnpj varchar(20) NULL
);


-- temporario.rh_dfuncionario definição

-- Drop table

-- DROP TABLE temporario.rh_dfuncionario;

CREATE TABLE temporario.rh_dfuncionario (
	pk_funcionario varchar(122) NULL,
	pk_funcionario_filial varchar(163) NULL,
	nm_funcionario varchar(40) NULL,
	cd_nm_funcionario varchar(81) NULL,
	cpf varchar(11) NULL,
	cd_empresa varchar(4) NULL,
	cd_funcionario varchar(9) NULL,
	cd_empresa_filial varchar(81) NULL,
	cd_escolaridade varchar(2) NULL,
	cd_cargo varchar(65) NULL,
	nm_local varchar(60) NULL,
	cd_nacionalidade varchar(5) NULL,
	dt_nascimento timestamp NULL,
	dt_admissao timestamp NULL,
	fg_deficiente varchar(1) NULL,
	cotdef varchar(1) NULL,
	sexo varchar(9) NULL,
	cd_tipo_funcionario varchar(1) NULL,
	cd_tipo_contrato varchar(2) NULL,
	cd_endereco varchar(6) NULL,
	endereco varchar(100) NULL,
	nr_cep varchar(8) NULL,
	nr_telefone varchar(20) NULL,
	nm_cidade varchar(30) NULL,
	uf varchar(2) NULL,
	nr_cep_bairro varchar(8) NULL,
	nm_bairro varchar(40) NULL,
	ds_tipo_contrato varchar(32) NULL,
	cd_afastamento varchar(6) NULL,
	dt_afastamento_original timestamp NULL,
	faixa_etaria varchar(12) NULL,
	ds_situacao varchar(30) NULL,
	cargo_atual varchar(60) NULL,
	nm_filial_atual varchar(40) NULL,
	idade varchar(7) NULL,
	dt_demissao varchar(50) NULL,
	ds_causa_demissao varchar(30) NULL,
	ds_motivo_demissao varchar(40) NULL,
	ultima_atualizacao timestamp NULL,
	centrocusto varchar(150) NULL,
	turno varchar(15) NULL,
	cd_causa_demissao varchar(30) NULL
);
CREATE INDEX rh_dfuncionario_pk_funcionario_idx ON temporario.rh_dfuncionario USING btree (pk_funcionario);


-- temporario.rh_dfuncionario_historico definição

-- Drop table

-- DROP TABLE temporario.rh_dfuncionario_historico;

CREATE TABLE temporario.rh_dfuncionario_historico (
	pk_funcionario varchar(122) NULL,
	pk_funcionario_filial varchar(163) NULL,
	nm_funcionario varchar(40) NULL,
	cd_nm_funcionario varchar(81) NULL,
	cpf varchar(11) NULL,
	cd_empresa varchar(4) NULL,
	cd_funcionario varchar(9) NULL,
	cd_empresa_filial varchar(81) NULL,
	cd_escolaridade varchar(2) NULL,
	cd_cargo varchar(65) NULL,
	nm_local varchar(60) NULL,
	cd_nacionalidade varchar(5) NULL,
	dt_nascimento timestamp NULL,
	dt_admissao timestamp NULL,
	fg_deficiente varchar(1) NULL,
	cotdef varchar(1) NULL,
	sexo varchar(9) NULL,
	cd_tipo_funcionario varchar(1) NULL,
	cd_tipo_contrato varchar(2) NULL,
	cd_endereco varchar(6) NULL,
	endereco varchar(100) NULL,
	nr_cep varchar(8) NULL,
	nr_telefone varchar(20) NULL,
	nm_cidade varchar(30) NULL,
	uf varchar(2) NULL,
	nr_cep_bairro varchar(8) NULL,
	nm_bairro varchar(40) NULL,
	ds_tipo_contrato varchar(32) NULL,
	cd_afastamento varchar(6) NULL,
	dt_afastamento_original timestamp NULL,
	faixa_etaria varchar(12) NULL,
	ds_situacao varchar(30) NULL,
	cargo_atual varchar(60) NULL,
	nm_filial_atual varchar(40) NULL,
	idade varchar(7) NULL,
	dt_demissao varchar(50) NULL,
	ds_causa_demissao varchar(30) NULL,
	ds_motivo_demissao varchar(40) NULL,
	ultima_atualizacao timestamp NULL,
	dt_nova_admissao timestamp NULL,
	fl_transferencia text NULL,
	nm_filial_anterior text NULL
);


-- temporario.rh_dgrau_instrucao definição

-- Drop table

-- DROP TABLE temporario.rh_dgrau_instrucao;

CREATE TABLE temporario.rh_dgrau_instrucao (
	pk_grau_instrucao int2 NULL,
	desc_grau varchar(50) NULL,
	cd_insrai int2 NULL,
	cd_ds_grau varchar(90) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dlocal_organograma definição

-- Drop table

-- DROP TABLE temporario.rh_dlocal_organograma;

CREATE TABLE temporario.rh_dlocal_organograma (
	pk_local_organograma varchar(100) NULL,
	cd_taborg int4 NULL,
	cd_num_loc int8 NULL,
	cd_rat int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dlocalizacao definição

-- Drop table

-- DROP TABLE temporario.rh_dlocalizacao;

CREATE TABLE temporario.rh_dlocalizacao (
	pk_localizacao int4 NULL,
	cd_nom_loc varchar(60) NULL,
	cd_num_loc int4 NULL,
	cd_rat int4 NULL,
	cd_ds_loc varchar(101) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dmotivo definição

-- Drop table

-- DROP TABLE temporario.rh_dmotivo;

CREATE TABLE temporario.rh_dmotivo (
	pk_motivo int4 NULL,
	desc_motivo varchar(50) NULL,
	cd_ds_motivo varchar(70) NULL,
	cd_tip_motivo varchar(3) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dmotivo_reajuste definição

-- Drop table

-- DROP TABLE temporario.rh_dmotivo_reajuste;

CREATE TABLE temporario.rh_dmotivo_reajuste (
	pk_motivo_alteracao varchar(5) NULL,
	ds_motivo_alteracao varchar(30) NULL,
	tipo_motivo varchar(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_dsituacao definição

-- Drop table

-- DROP TABLE temporario.rh_dsituacao;

CREATE TABLE temporario.rh_dsituacao (
	pk_situacao int4 NULL,
	cd_ds_situacao varchar(80) NULL,
	desc_sit varchar(40) NULL,
	desc_abr varchar(6) NULL,
	cd_sit_cmp int4 NULL,
	cd_tip_sit int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dstg_evento definição

-- Drop table

-- DROP TABLE temporario.rh_dstg_evento;

CREATE TABLE temporario.rh_dstg_evento (
	pk_evento text NULL,
	cd_evento numeric(4) NULL,
	cd_tipo_evento numeric(1) NULL,
	ds_evento text NULL,
	ds_evento_codigo text NULL,
	ultima_atualizacao timestamp NULL,
	fg_normal text NULL,
	fg_absenteismo text NULL,
	fg_extra text NULL,
	fg_rescisao text NULL,
	fg_normalabsenteismo text NULL
);


-- temporario.rh_dstg_evento_stage definição

-- Drop table

-- DROP TABLE temporario.rh_dstg_evento_stage;

CREATE TABLE temporario.rh_dstg_evento_stage (
	pk_evento text NULL,
	cd_evento numeric(4) NULL,
	cd_tipo_evento numeric(1) NULL,
	ds_evento text NULL,
	ds_evento_codigo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_dusuario_antigo definição

-- Drop table

-- DROP TABLE temporario.rh_dusuario_antigo;

CREATE TABLE temporario.rh_dusuario_antigo (
	pk_usuario_antigo int8 NULL,
	cd_nom_usu varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_dusuario_colaborador definição

-- Drop table

-- DROP TABLE temporario.rh_dusuario_colaborador;

CREATE TABLE temporario.rh_dusuario_colaborador (
	cd_num_emp int4 NULL,
	cd_tip_col int2 NULL,
	cd_num_col int8 NULL,
	cd_cri_usu int2 NULL,
	cd_usu_ema_env varchar(4) NULL,
	desc_nm_com varchar(150) NULL,
	desc_usu varchar(150) NULL,
	dt_log timestamp NULL,
	dt_hr_log int4 NULL,
	dthora_ultima_atualizacao timestamp NULL,
	pk_usuario_colaborador int8 NULL
);


-- temporario.rh_fabsenteismo_inc definição

-- Drop table

-- DROP TABLE temporario.rh_fabsenteismo_inc;

CREATE TABLE temporario.rh_fabsenteismo_inc (
	fk_empresa int4 NULL,
	fk_filial varchar(100) NULL,
	fk_situacao int4 NULL,
	fk_cargo varchar(24) NULL,
	fk_local_organograma varchar(100) NULL,
	fk_localizacao int8 NULL,
	fk_colaborador varchar(130) NULL,
	cd_tip_col int2 NULL,
	cd_num_cad int8 NULL,
	cd_nom_fun varchar(60) NULL,
	cd_num_emp int4 NULL,
	cd_fil int4 NULL,
	cd_num_cgc int8 NULL,
	cd_loc varchar(180) NULL,
	cd_nom_loc varchar(70) NULL,
	cd_car varchar(24) NULL,
	cd_tit_car varchar(60) NULL,
	cd_esc int4 NULL,
	cd_nom_esc varchar(30) NULL,
	cd_sit_afa varchar(9) NULL,
	dt_ref timestamp NULL,
	cd_sit_lan int2 NULL,
	cd_sit_nom varchar(30) NULL,
	vlr_tot_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_facesso_sistema definição

-- Drop table

-- DROP TABLE temporario.rh_facesso_sistema;

CREATE TABLE temporario.rh_facesso_sistema (
	cd_empresa int4 NULL,
	cd_num_cadastro int8 NULL,
	cd_num_cpf int8 NULL,
	dt_acesso_auxi timestamp NULL,
	qtd_minuto_acesso int4 NULL,
	dthora_atualizacao timestamp NULL,
	fk_usu int8 NULL,
	fk_colaborador varchar(50) NULL,
	codfil int4 NULL
);


-- temporario.rh_fafastamento definição

-- Drop table

-- DROP TABLE temporario.rh_fafastamento;

CREATE TABLE temporario.rh_fafastamento (
	fk_funcionario varchar(50) NULL,
	fk_data_afastamento timestamp NULL,
	fk_situacao_afastamento varchar(6) NULL,
	dt_ini_afastamento timestamp NULL,
	dt_fim_afastamento timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_fafastamentos definição

-- Drop table

-- DROP TABLE temporario.rh_fafastamentos;

CREATE TABLE temporario.rh_fafastamentos (
	fk_colaborador varchar(100) NULL,
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	dt_afa timestamp NULL,
	vlr_hor_afa int4 NULL,
	dt_ter timestamp NULL,
	vlr_hor_ter int4 NULL,
	dt_prv_ter timestamp NULL,
	cd_dia_jus int2 NULL,
	desc_afa varchar(260) NULL,
	cd_sta_atu int2 NULL,
	cd_dia_prv int4 NULL,
	fk_cau_dem int2 NULL,
	dthora_atualizacao timestamp NULL,
	motivo_afastamento varchar(30) NULL,
	oriafa int2 NULL
);
CREATE INDEX rh_fafastamentos_dt_afa_idx ON temporario.rh_fafastamentos USING btree (dt_afa);
CREATE INDEX rh_fafastamentos_fk_colaborador_idx ON temporario.rh_fafastamentos USING btree (fk_colaborador);


-- temporario.rh_fapuracao definição

-- Drop table

-- DROP TABLE temporario.rh_fapuracao;

CREATE TABLE temporario.rh_fapuracao (
	pk_apuracao varchar(150) NULL,
	fk_colaborador varchar(140) NULL,
	fk_empresa int4 NULL,
	dt_apuracao timestamp NULL,
	dt_hr_apuracao int4 NULL,
	cd_desc int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fapuracao_col_situacao definição

-- Drop table

-- DROP TABLE temporario.rh_fapuracao_col_situacao;

CREATE TABLE temporario.rh_fapuracao_col_situacao (
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	fk_colaborador varchar(110) NULL,
	dt_apu timestamp NULL,
	qtd_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fatestado definição

-- Drop table

-- DROP TABLE temporario.rh_fatestado;

CREATE TABLE temporario.rh_fatestado (
	pk_funcionario varchar(25) NULL,
	pk_funcionario_filial varchar(30) NULL,
	empresa int2 NULL,
	cod_filial int4 NULL,
	cadastro int4 NULL,
	data_afastamento timestamp NULL,
	situacao_afastamento int2 NULL,
	cid varchar(4) NULL,
	desc_cid varchar(300) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_fbanco_horas definição

-- Drop table

-- DROP TABLE temporario.rh_fbanco_horas;

CREATE TABLE temporario.rh_fbanco_horas (
	fk_funcionario varchar(184) NULL,
	dt_lancamento timestamp NULL,
	cd_banco int4 NULL,
	fk_situacao int4 NULL,
	origem_lancamento varchar(1) NULL,
	qtd_hora varchar(10) NULL,
	qtd_paga varchar(10) NULL,
	saldo_horas varchar(10) NULL,
	ultima_atualizacao timestamp NULL,
	tip_colaborador int2 NULL
);


-- temporario.rh_fdemissao definição

-- Drop table

-- DROP TABLE temporario.rh_fdemissao;

CREATE TABLE temporario.rh_fdemissao (
	fk_funcionario varchar(80) NULL,
	fk_filial varchar(80) NULL,
	fk_empresa varchar(4) NULL,
	fk_cargo varchar(65) NULL,
	dt_funcionario timestamp NULL,
	dt_demissao timestamp NULL,
	dt_inicio_mes timestamp NULL,
	dt_fim_mes timestamp NULL,
	vl_demissao numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_fdre_lojas definição

-- Drop table

-- DROP TABLE temporario.rh_fdre_lojas;

CREATE TABLE temporario.rh_fdre_lojas (
	id int4 NULL,
	cnpj_loja varchar(18) NULL,
	apelido varchar(200) NULL,
	ano_dre int2 NULL,
	mes_dre int2 NULL,
	tipo_dre int2 NULL,
	propriedade varchar(150) NULL,
	val_real_ano_ant numeric(18, 3) NULL,
	perc_real_ano_ant numeric(18, 3) NULL,
	val_orcado numeric(18, 3) NULL,
	perc_orcado numeric(18, 3) NULL,
	val_real numeric(18, 3) NULL,
	perc_real numeric(18, 3) NULL,
	val_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_orcado_real numeric(18, 3) NULL,
	perc_diferenca_real_vig_ant numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL,
	seq_consulta varchar(20) NULL
);


-- temporario.rh_fesocial definição

-- Drop table

-- DROP TABLE temporario.rh_fesocial;

CREATE TABLE temporario.rh_fesocial (
	fk_empresa int4 NULL,
	cd_id_eint int4 NULL,
	dt_cmphor timestamp NULL,
	vlr_dur_jor int4 NULL,
	cd_hor int4 NULL,
	cd_ini_not int4 NULL,
	cd_fim_not int4 NULL,
	cd_hor_not varchar(3) NULL,
	cd_sc int4 NULL,
	cd_hor_eso varchar(50) NULL,
	cd_hor_ent int4 NULL,
	cd_hor_sai int2 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fesocial_intervalo definição

-- Drop table

-- DROP TABLE temporario.rh_fesocial_intervalo;

CREATE TABLE temporario.rh_fesocial_intervalo (
	fk_empresa int4 NULL,
	cd_id_eint int4 NULL,
	qtd_dur_int int4 NULL,
	vlr_ini_int int4 NULL,
	vlr_fim_int int4 NULL,
	cd_hor_eso varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fferias definição

-- Drop table

-- DROP TABLE temporario.rh_fferias;

CREATE TABLE temporario.rh_fferias (
	fk_funcionario varchar(50) NULL,
	fk_data_ferias timestamp NULL,
	dt_ini_periodo timestamp NULL,
	dt_fim_periodo timestamp NULL,
	dt_ini_ferias timestamp NULL,
	qt_dias_direito numeric(7, 2) NULL,
	qt_dias_tirado numeric(18, 3) NULL,
	qt_dias_saldo numeric(18, 3) NULL,
	qt_dias_ferias numeric(18, 3) NULL,
	dt_fim_ferias timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_fficha_financeira definição

-- Drop table

-- DROP TABLE temporario.rh_fficha_financeira;

CREATE TABLE temporario.rh_fficha_financeira (
	fk_empresa int4 NULL,
	fk_colaborador varchar(122) NULL,
	cd_tab_eve int4 NULL,
	cd_eve int4 NULL,
	vlr_ref_eve numeric(13, 2) NULL,
	vlr_val_eve numeric(13, 2) NULL,
	cd_ori_eve varchar(1) NULL,
	cd_rub int4 NULL,
	vlr_fat_rub numeric(8, 2) NULL,
	fk_evento varchar(100) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fhistorico definição

-- Drop table

-- DROP TABLE temporario.rh_fhistorico;

CREATE TABLE temporario.rh_fhistorico (
	fk_funcionario varchar(130) NULL,
	cd_funcionario varchar(25) NULL,
	fk_cargo varchar(65) NULL,
	fk_filial varchar(81) NULL,
	fk_local varchar(10) NULL,
	dt_ini_alteracao timestamp NULL,
	dt_fim_alteracao timestamp NULL,
	fg_admissao varchar(2) NULL,
	fg_demissao varchar(2) NULL,
	dt_demissao timestamp NULL,
	dt_admissao timestamp NULL,
	dt_historico timestamp NULL,
	fg_ativo varchar(10) NULL,
	fk_empresa varchar(8) NULL,
	vlr_sal numeric(18, 3) NULL,
	fg_afastamento varchar(1) NULL,
	fg_ferias varchar(1) NULL,
	dt_ini_afastamento timestamp NULL,
	dt_fim_afastamento timestamp NULL,
	dt_ini_ferias timestamp NULL,
	dt_fim_ferias timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_fhistorico_inc definição

-- Drop table

-- DROP TABLE temporario.rh_fhistorico_inc;

CREATE TABLE temporario.rh_fhistorico_inc (
	fk_funcionario varchar(130) NULL,
	cd_funcionario varchar(25) NULL,
	fk_cargo varchar(65) NULL,
	fk_filial varchar(81) NULL,
	fk_local varchar(10) NULL,
	dt_ini_alteracao timestamp NULL,
	dt_fim_alteracao timestamp NULL,
	fg_admissao varchar(2) NULL,
	fg_demissao varchar(2) NULL,
	dt_demissao timestamp NULL,
	dt_admissao timestamp NULL,
	dt_historico timestamp NULL,
	fg_ativo varchar(10) NULL,
	fk_empresa varchar(8) NULL,
	vlr_sal numeric(18, 3) NULL,
	fg_afastamento varchar(1) NULL,
	fg_ferias varchar(1) NULL,
	dt_ini_afastamento timestamp NULL,
	dt_fim_afastamento timestamp NULL,
	dt_ini_ferias timestamp NULL,
	dt_fim_ferias timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_fholerite definição

-- Drop table

-- DROP TABLE temporario.rh_fholerite;

CREATE TABLE temporario.rh_fholerite (
	fk_colaborador varchar(130) NULL,
	fk_codigo_calculo varchar(90) NULL,
	fk_empresa int4 NULL,
	fk_cargo varchar(70) NULL,
	cd_fil_mat int4 NULL,
	desc_razsoc varchar(120) NULL,
	cd_nome_com varchar(100) NULL,
	dt_nas timestamp NULL,
	cd_tit_car varchar(80) NULL,
	dt_per_ref timestamp NULL,
	dt_pag timestamp NULL,
	vlr_sal_bas numeric(19, 4) NULL,
	vlr_val_liq numeric(19, 4) NULL,
	vlr_bas_ins numeric(14, 2) NULL,
	vlr_bas_irf numeric(14, 2) NULL,
	vlr_bas_fgt numeric(14, 2) NULL,
	vlr_fgt_mes numeric(14, 2) NULL,
	cd_fai int4 NULL,
	cd_dep_irf int2 NULL,
	cd_dep_saf int2 NULL,
	cd_mod_pag varchar(3) NULL,
	desc_dmd_pag varchar(70) NULL,
	vlr_tot_ven numeric(15, 2) NULL,
	vlr_tot_des numeric(15, 2) NULL,
	cd_tip_cal int2 NULL,
	desc_dtp_cal varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fhoras_trabalhadas definição

-- Drop table

-- DROP TABLE temporario.rh_fhoras_trabalhadas;

CREATE TABLE temporario.rh_fhoras_trabalhadas (
	dat_batida timestamp NULL,
	dat_dia_batida numeric(38, 10) NULL,
	dat_mes_batida numeric(38, 10) NULL,
	dat_ano_batida numeric(38, 10) NULL,
	chave_usuario text NULL,
	empresa numeric(4) NULL,
	usuario numeric(9) NULL,
	tip_colaborador numeric(1) NULL,
	situacao_baixa text NULL,
	tot_horas_trb text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.rh_flancamento_hora definição

-- Drop table

-- DROP TABLE temporario.rh_flancamento_hora;

CREATE TABLE temporario.rh_flancamento_hora (
	cd_num_emp int4 NULL,
	cd_tip_col int2 NULL,
	cd_num_col int8 NULL,
	dt_lanca timestamp NULL,
	cd_ori_lanca varchar(4) NULL,
	cd_sin_lan varchar(4) NULL,
	qtd_hor int8 NULL,
	qtd_pag int8 NULL,
	qtd_hor_cmp int8 NULL,
	dt_cmp timestamp NULL,
	dt_compe_lanc timestamp NULL,
	dthora_atualizacao timestamp NULL,
	fk_banco_horas int4 NULL,
	fk_situacao int4 NULL,
	fk_colaborador varchar(150) NULL
);


-- temporario.rh_flog_alteracoes_ponto definição

-- Drop table

-- DROP TABLE temporario.rh_flog_alteracoes_ponto;

CREATE TABLE temporario.rh_flog_alteracoes_ponto (
	dt_apuracao timestamp NULL,
	cd_num_fun int8 NULL,
	cd_nom_fun varchar(50) NULL,
	cd_usu int8 NULL,
	cd_nom_usu varchar(255) NULL,
	cd_num_ajuste int8 NULL,
	cd_nom_ajuste varchar(50) NULL,
	descr_msg_log varchar(500) NULL,
	dthora_atualizacao timestamp NULL,
	fk_colaborador varchar(150) NULL,
	fk_usuario_antigo int8 NULL
);


-- temporario.rh_fmarcacao_horario definição

-- Drop table

-- DROP TABLE temporario.rh_fmarcacao_horario;

CREATE TABLE temporario.rh_fmarcacao_horario (
	cd_hor int4 NULL,
	seq_mar int2 NULL,
	cd_usobat int2 NULL,
	vlr_horbat int4 NULL,
	cd_faimov int4 NULL,
	dthora_atualizacao timestamp NULL,
	vlr_tolant int4 NULL,
	vlr_tolapo int4 NULL
);


-- temporario.rh_fmarcacoes_formato_live definição

-- Drop table

-- DROP TABLE temporario.rh_fmarcacoes_formato_live;

CREATE TABLE temporario.rh_fmarcacoes_formato_live (
	id int4 NULL,
	id_empregado int4 NULL,
	id_empresa int4 NULL,
	data_marcacao timestamp NULL,
	horas_trabalhadas varchar(20) NULL,
	sequencia_marcacao int4 NULL,
	marcacao_esperada time(3) NULL,
	marcacao_ponto time(3) NULL,
	dif_marcacao_minutos int4 NULL,
	ultima_atualizacao timestamp NULL,
	jornada varchar(100) NULL
);


-- temporario.rh_fponto_detalhado definição

-- Drop table

-- DROP TABLE temporario.rh_fponto_detalhado;

CREATE TABLE temporario.rh_fponto_detalhado (
	tipo_batida varchar(16) NULL,
	seq_batida int2 NULL,
	chave_usuario varchar(154) NULL,
	cod_escala int4 NULL,
	empresa int2 NULL,
	usuario int4 NULL,
	reg_ponto int4 NULL,
	prev_batida varchar(20) NULL,
	tole_antes varchar(20) NULL,
	tole_apos varchar(20) NULL,
	dat_batida timestamp NULL,
	dat_trabalho timestamp NULL,
	hor_batida varchar(4000) NULL,
	dat_dia_batida int2 NULL,
	dat_mes_batida int2 NULL,
	dat_ano_batida int2 NULL,
	dat_dia_trabalho int2 NULL,
	dat_mes_trabalho int2 NULL,
	dat_ano_trabalho int2 NULL,
	dife int4 NULL,
	ultima_atualizacao timestamp NULL,
	turno int2 NULL,
	dat_ajustada timestamp NULL,
	numnsr int4 NULL
);


-- temporario.rh_fponto_sintetico definição

-- Drop table

-- DROP TABLE temporario.rh_fponto_sintetico;

CREATE TABLE temporario.rh_fponto_sintetico (
	dat_batida timestamp NULL,
	dat_dia_batida float8 NULL,
	dat_mes_batida float8 NULL,
	dat_ano_batida float8 NULL,
	chave_usuario varchar(60) NULL,
	empresa int2 NULL,
	usuario int4 NULL,
	hor_batida_formatada varchar(400) NULL,
	hor_escala_formatada varchar(30) NULL,
	ultima_atualizacao timestamp NULL,
	tip_colaborador int2 NULL
);


-- temporario.rh_fprovento_lojas definição

-- Drop table

-- DROP TABLE temporario.rh_fprovento_lojas;

CREATE TABLE temporario.rh_fprovento_lojas (
	fk_funcionario text NULL,
	fk_cargo text NULL,
	tiposituacao numeric(2) NULL,
	descricaosituacao text NULL,
	centro_custo text NULL,
	cod_ccusto numeric(38, 10) NULL,
	cod_empresa numeric(4) NULL,
	num_cadastro numeric(9) NULL,
	ano numeric(38, 10) NULL,
	mes numeric(38, 10) NULL,
	tipo text NULL,
	val_evento numeric(38, 10) NULL,
	ultima_atualizacao timestamp NULL,
	data_demissao timestamp NULL,
	codeve numeric NULL
);


-- temporario.rh_freajuste definição

-- Drop table

-- DROP TABLE temporario.rh_freajuste;

CREATE TABLE temporario.rh_freajuste (
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


-- temporario.rh_fregistro_acesso definição

-- Drop table

-- DROP TABLE temporario.rh_fregistro_acesso;

CREATE TABLE temporario.rh_fregistro_acesso (
	fk_empresa int4 NULL,
	cd_num_cra int8 NULL,
	dt_cc timestamp NULL,
	dt_hr_cc int4 NULL,
	cd_seq_acc int2 NULL,
	cd_ori_acc varchar(1) NULL,
	cd_num_cad int4 NULL,
	dt_apu timestamp NULL,
	cd_num_nsr int4 NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_fsaldo_banco_horas definição

-- Drop table

-- DROP TABLE temporario.rh_fsaldo_banco_horas;

CREATE TABLE temporario.rh_fsaldo_banco_horas (
	chave_usuario varchar(154) NULL,
	numemp int2 NULL,
	codfil int4 NULL,
	nomfil varchar(40) NULL,
	numcgc int8 NULL,
	codloc varchar(150) NULL,
	nomloc varchar(60) NULL,
	codcar varchar(24) NULL,
	titcar varchar(100) NULL,
	codesc int4 NULL,
	nomesc varchar(30) NULL,
	tipcol int2 NULL,
	numcad int4 NULL,
	nomfun varchar(40) NULL,
	sitafa varchar(7) NULL,
	datref timestamp NULL,
	sldatu int8 NULL,
	ultima_atualizacao timestamp NULL,
	sldneg numeric(15, 3) NULL,
	sldpos numeric(18, 3) NULL
);


-- temporario.rh_fsaldo_hora_extra definição

-- Drop table

-- DROP TABLE temporario.rh_fsaldo_hora_extra;

CREATE TABLE temporario.rh_fsaldo_hora_extra (
	chave_usuario varchar(75) NULL,
	numemp int2 NULL,
	codfil int4 NULL,
	nomfil varchar(40) NULL,
	numcgc int8 NULL,
	codloc varchar(150) NULL,
	nomloc varchar(60) NULL,
	codcar varchar(24) NULL,
	titcar varchar(100) NULL,
	codesc int4 NULL,
	nomesc varchar(30) NULL,
	tipcol int2 NULL,
	numcad int4 NULL,
	nomfun varchar(40) NULL,
	sitafa varchar(7) NULL,
	datref timestamp NULL,
	qtdext int8 NULL
);


-- temporario.rh_fstg_historico definição

-- Drop table

-- DROP TABLE temporario.rh_fstg_historico;

CREATE TABLE temporario.rh_fstg_historico (
	fk_funcionario text NULL,
	fk_cargo text NULL,
	cd_funcionario text NULL,
	fk_filial text NULL,
	fk_empresa text NULL,
	fk_local text NULL,
	dt_alt timestamp NULL,
	dt_adm timestamp NULL,
	vlr_sal numeric(38, 10) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.rh_ftotalizador_horas definição

-- Drop table

-- DROP TABLE temporario.rh_ftotalizador_horas;

CREATE TABLE temporario.rh_ftotalizador_horas (
	cd_tip_col int2 NULL,
	cd_num_col int4 NULL,
	dt_compe_calc timestamp NULL,
	qtd_hor_pag int8 NULL,
	qtd_hor_des int8 NULL,
	qtd_saldo int8 NULL,
	dthora_atualizacao timestamp NULL,
	fk_banco_hora int4 NULL,
	fk_colaborador varchar(150) NULL,
	fk_empresa int4 NULL,
	vlr_hor_pag numeric(20, 4) NULL,
	vlr_hor_des numeric(20, 4) NULL,
	vlr_hor_saldo numeric(20, 4) NULL
);


-- temporario.rh_sci_dcolaborador definição

-- Drop table

-- DROP TABLE temporario.rh_sci_dcolaborador;

CREATE TABLE temporario.rh_sci_dcolaborador (
	fk_funcionario varchar(184) NULL,
	fk_cargo varchar(96) NULL,
	cpf int8 NULL,
	status_func varchar(7) NULL,
	causa_demissao varchar(30) NULL,
	cod_escala int4 NULL,
	centro_custo varchar(18) NULL,
	dt_admissao timestamp NULL,
	val_sal_simulad numeric(17, 4) NULL,
	pct_desempenho numeric(7, 2) NULL,
	ult_sal numeric(17, 4) NULL,
	ult_alteracao_sal timestamp NULL,
	sal_complementar numeric(17, 4) NULL,
	val_suplementar numeric(13, 2) NULL,
	pct_reajuste numeric(13, 5) NULL,
	gratificacao varchar(1) NULL
);


-- temporario.rh_sci_dhistorico_salario definição

-- Drop table

-- DROP TABLE temporario.rh_sci_dhistorico_salario;

CREATE TABLE temporario.rh_sci_dhistorico_salario (
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


-- temporario.rh_sci_fcontratos_lecom definição

-- Drop table

-- DROP TABLE temporario.rh_sci_fcontratos_lecom;

CREATE TABLE temporario.rh_sci_fcontratos_lecom (
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


-- temporario.rh_sci_ffolha_salarial definição

-- Drop table

-- DROP TABLE temporario.rh_sci_ffolha_salarial;

CREATE TABLE temporario.rh_sci_ffolha_salarial (
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


-- temporario.rh_sci_fprov_bruto_colab definição

-- Drop table

-- DROP TABLE temporario.rh_sci_fprov_bruto_colab;

CREATE TABLE temporario.rh_sci_fprov_bruto_colab (
	fk_funcionario text NULL,
	fk_cargo text NULL,
	cod_empresa numeric(4) NULL,
	num_cadastro numeric(9) NULL,
	ano numeric(38, 10) NULL,
	mes numeric(38, 10) NULL,
	tipo text NULL,
	val_evento numeric(38, 10) NULL,
	data_registro date NULL,
	centro_custo varchar(30) NULL
);


-- temporario.rh_sci_fprov_bruto_colab_inc definição

-- Drop table

-- DROP TABLE temporario.rh_sci_fprov_bruto_colab_inc;

CREATE TABLE temporario.rh_sci_fprov_bruto_colab_inc (
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


-- temporario.rh_sci_freajuste definição

-- Drop table

-- DROP TABLE temporario.rh_sci_freajuste;

CREATE TABLE temporario.rh_sci_freajuste (
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


-- temporario.stage_fabasfaccoesstage definição

-- Drop table

-- DROP TABLE temporario.stage_fabasfaccoesstage;

CREATE TABLE temporario.stage_fabasfaccoesstage (
	cod_chave_fornec varchar(70) NULL,
	desc_fornecedor varchar(40) NULL,
	dthora_atualizacao timestamp NULL,
	qtd_minutos_total numeric(18, 3) NULL,
	qtd_costureira numeric(18, 3) NULL,
	min_dia numeric(18, 3) NULL,
	dias_uteis numeric(18, 3) NULL,
	min_total numeric(18, 3) NULL,
	min_dia_enfic numeric(18, 3) NULL,
	perc_eficiencia numeric(18, 3) NULL,
	min_prev_perc_efic numeric(18, 3) NULL,
	min_prev_ate_data numeric(18, 3) NULL,
	min_real numeric(18, 3) NULL,
	perc_capacidade numeric(18, 3) NULL,
	a_realizar numeric(18, 3) NULL,
	penden_prev numeric(18, 3) NULL,
	tempo_pendente numeric(18, 3) NULL,
	qtd_em_pendente numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_perdas numeric(18, 3) NULL,
	dias_prod numeric(18, 3) NULL
);


-- temporario.stage_fmovimentosinteg_stage definição

-- Drop table

-- DROP TABLE temporario.stage_fmovimentosinteg_stage;

CREATE TABLE temporario.stage_fmovimentosinteg_stage (
	portal int8 NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(3) NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	valor_ipi numeric(18, 3) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	fk_cliente varchar(40) NULL,
	cnpj varchar(40) NULL,
	valor_bruto int8 NULL,
	cor varchar(6) NULL,
	tamanho varchar(5) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	fk_produto varchar(25) NULL,
	descricao varchar(200) NULL,
	rede varchar(100) NULL,
	canal_distribuicao varchar(14) NULL,
	flag_movimentacao varchar(20) NULL,
	valor_liquido numeric(18, 3) NULL,
	qtde numeric(18, 3) NULL,
	cst_icms varchar(15) NULL,
	cst_ipi varchar(15) NULL,
	cst_cofins varchar(15) NULL,
	cst_pis varchar(15) NULL,
	data_lancamento timestamp NULL,
	datcancel timestamp NULL,
	cod_barra varchar(20) NULL,
	data_inicio_vigencia date NULL,
	data_fim_vigencia date NULL,
	cnpj_original varchar(40) NULL,
	cnpj_antigo varchar(18) NULL,
	de varchar(20) NULL,
	para varchar(20) NULL,
	loja_original varchar(30) NULL,
	situacao int2 NULL,
	identificador varchar(60) NULL,
	cnpj_emp varchar(20) NULL,
	loja varchar(5) NULL
);
CREATE INDEX stage_fmovimentosinteg_stage_cancelado_idx ON temporario.stage_fmovimentosinteg_stage USING btree (cancelado);
CREATE INDEX stage_fmovimentosinteg_stage_operacao_tipo_transacao_consid_idx ON temporario.stage_fmovimentosinteg_stage USING btree (operacao, tipo_transacao, considerarvenda);


-- temporario.stage_fordens_corte_stage definição

-- Drop table

-- DROP TABLE temporario.stage_fordens_corte_stage;

CREATE TABLE temporario.stage_fordens_corte_stage (
	cd_ordem_producao int4 NULL,
	cd_grupo varchar(5) NULL,
	prod_rej_item varchar(6) NULL,
	periodo_producao int2 NULL,
	cd_ordem_confeccao int4 NULL,
	situacao_ordem int2 NULL,
	numero_ordem_externa int4 NULL,
	data_alteracao timestamp NULL,
	tamanho varchar(3) NULL,
	data_producao timestamp NULL,
	dthora_atualizacao timestamp NULL,
	dt_lancamento timestamp NULL,
	dt_prevista timestamp NULL,
	prioridade int4 NULL,
	data_programacao timestamp NULL,
	periodo_producao_capa int2 NULL,
	numero_programa int2 NULL,
	cod_cancelamento int2 NULL,
	cd_nivel99 float8 NULL,
	cd_subgrupo varchar(5) NULL,
	cd_estagio int4 NULL,
	qtd_pecas_progamada numeric(18, 3) NULL,
	qtd_pecas_produzida numeric(18, 3) NULL,
	qtd_conserto numeric(18, 3) NULL,
	qtd_pecas_2a numeric(18, 3) NULL,
	estagio_anterior int4 NULL,
	seq_ordem_serv int2 NULL,
	qtd_perdas numeric(18, 3) NULL,
	sequencia_estagio int2 NULL,
	usuario varchar(250) NULL,
	seq_operacao int2 NULL,
	qtd_em_producao_pacote numeric(18, 3) NULL,
	minutos_unitario numeric(18, 3) NULL,
	minutos_total numeric(18, 3) NULL,
	minutos_total_em_producao numeric(18, 3) NULL,
	sequencia_tamanho int4 NULL,
	qtd_marcacoes numeric(18, 3) NULL,
	qtd_a_produzir numeric(18, 3) NULL,
	rowid varchar(100) NULL,
	fk_produto varchar(125) NULL,
	fk_fornecedor varchar(150) NULL,
	alternativa_peca int4 NULL,
	deposito_entrada int4 NULL
);


-- temporario.stage_ftabelaprecogrupoest definição

-- Drop table

-- DROP TABLE temporario.stage_ftabelaprecogrupoest;

CREATE TABLE temporario.stage_ftabelaprecogrupoest (
	tabela_preco text NULL,
	tabela_preco_cod text NULL,
	grupo_estrutura text NULL,
	item_estrutura text NULL,
	subgru_estrutura text NULL,
	nivel_estrutura text NULL,
	val_tabela_preco numeric(19, 6) NULL
);


-- temporario.stage_ftabelaprecostage definição

-- Drop table

-- DROP TABLE temporario.stage_ftabelaprecostage;

CREATE TABLE temporario.stage_ftabelaprecostage (
	tabela_preco varchar(9) NULL,
	tabela_preco_cod varchar(11) NULL,
	fk_produto varchar(18) NULL,
	val_tabela_preco numeric(18, 3) NULL,
	vlr_com_desconto numeric(18, 3) NULL,
	grupo_estrutura varchar(5) NULL,
	dthora_atualizacao timestamp NULL
);


-- temporario.stage_lojas_vigencia_stage definição

-- Drop table

-- DROP TABLE temporario.stage_lojas_vigencia_stage;

CREATE TABLE temporario.stage_lojas_vigencia_stage (
	id int4 NULL,
	data_fim_vigencia timestamp NULL,
	portal_antigo varchar(35) NULL,
	portal_novo varchar(35) NULL,
	ordem_troca varchar(35) NULL,
	id_portal_fixo varchar(35) NULL,
	data_criacao timestamp NULL,
	usuario_criacao varchar(35) NULL,
	ultima_atualizacao timestamp NULL,
	cnpj_antigo_completo varchar(15) NULL,
	cnpj_atual_completo varchar(15) NULL,
	cnpj_antigo varchar(14) NULL,
	cnpj_atual varchar(14) NULL,
	data_inicio_vigencia timestamp NULL
);


-- temporario.stage_pedi100 definição

-- Drop table

-- DROP TABLE temporario.stage_pedi100;

CREATE TABLE temporario.stage_pedi100 (
	pedido_venda numeric(9) NULL,
	data_entr_venda timestamp NULL,
	situacao_venda numeric(2) NULL,
	cod_cancelamento numeric(3) NULL,
	sit_aloc_pedi numeric(1) NULL,
	sit_coletor numeric(1) NULL,
	situacao_coleta numeric(1) NULL,
	status_expedicao numeric(1) NULL,
	status_homologacao numeric(1) NULL,
	status_pedido numeric(1) NULL,
	status_comercial numeric(1) NULL,
	sit_conferencia numeric(1) NULL,
	qtde_saldo_pedi numeric(15, 3) NULL,
	valor_saldo_pedi numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL,
	qtde_total_pedi numeric(15, 3) NULL,
	live_data_entr_venda_original timestamp NULL
);


-- temporario.stage_pedi135 definição

-- Drop table

-- DROP TABLE temporario.stage_pedi135;

CREATE TABLE temporario.stage_pedi135 (
	pedido_venda numeric(9) NULL,
	seq_situacao numeric(2) NULL,
	codigo_situacao numeric(2) NULL,
	flag_liberacao varchar(5) NULL,
	data_situacao timestamp NULL,
	data_liberacao timestamp NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.stage_stage_movimentacoes_integ definição

-- Drop table

-- DROP TABLE temporario.stage_stage_movimentacoes_integ;

CREATE TABLE temporario.stage_stage_movimentacoes_integ (
	portal_movimentacao int8 NULL,
	identificador varchar(60) NULL,
	cnpj_movimentacao varchar(40) NULL,
	numorcamento int8 NULL,
	usuario int8 NULL,
	numnf int8 NULL,
	serie varchar(10) NULL,
	chave_nf varchar(100) NULL,
	qtde numeric(18, 3) NULL,
	valor_liquido numeric(18, 3) NULL,
	desconto numeric(18, 3) NULL,
	preco_custo numeric(18, 3) NULL,
	fk_produto varchar(168) NULL,
	data_lancamento timestamp NULL,
	hora_lancamento varchar(20) NULL,
	codigo_cliente int8 NULL,
	doc_cliente varchar(20) NULL,
	id_cfop varchar(20) NULL,
	cod_vendedor int8 NULL,
	cst_icms varchar(10) NULL,
	valor_icms numeric(18, 3) NULL,
	aliquota_icms numeric(18, 3) NULL,
	base_icms numeric(18, 3) NULL,
	cst_ipi varchar(10) NULL,
	valor_ipi numeric(20, 5) NULL,
	aliquota_ipi numeric(18, 3) NULL,
	base_ipi numeric(18, 3) NULL,
	cst_cofins varchar(10) NULL,
	valor_cofins numeric(18, 3) NULL,
	aliquota_cofins numeric(18, 3) NULL,
	base_cofins numeric(18, 3) NULL,
	cst_pis varchar(10) NULL,
	valor_pis numeric(18, 3) NULL,
	aliquota_pis numeric(18, 3) NULL,
	base_pis numeric(18, 3) NULL,
	operacao varchar(10) NULL,
	tipo_transacao varchar(10) NULL,
	cancelado varchar(1) NULL,
	datcancel timestamp NULL,
	seqitem int4 NULL,
	ultima_atualizacao timestamp NULL,
	valor_bruto numeric(18, 3) NULL,
	cor varchar(20) NULL,
	tamanho varchar(32) NULL,
	considerarvenda varchar(1) NULL,
	desc_movimento varchar(255) NULL,
	cod_barra varchar(20) NULL,
	loja_movimentacao varchar(30) NULL
);


-- temporario.stage_stg_infos_lojas_integ definição

-- Drop table

-- DROP TABLE temporario.stage_stg_infos_lojas_integ;

CREATE TABLE temporario.stage_stg_infos_lojas_integ (
	id_loja int4 NULL,
	descricao varchar(200) NULL,
	apelido varchar(200) NULL,
	razao_social varchar(200) NULL,
	situacao int2 NULL,
	endereco varchar(200) NULL,
	cep int4 NULL,
	id_portal int4 NULL,
	data_inauguracao timestamp NULL,
	cnpj varchar(100) NULL,
	portal varchar(72) NULL,
	rede varchar(100) NULL
);


-- temporario.stage_stg_paradasmaquinas_marft_oper definição

-- Drop table

-- DROP TABLE temporario.stage_stg_paradasmaquinas_marft_oper;

CREATE TABLE temporario.stage_stg_paradasmaquinas_marft_oper (
	cod_operador numeric(5) NULL,
	nome_operador text NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	motivo text NULL,
	detalhes text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.stage_stg_paradasmaquinas_marft_pmo definição

-- Drop table

-- DROP TABLE temporario.stage_stg_paradasmaquinas_marft_pmo;

CREATE TABLE temporario.stage_stg_paradasmaquinas_marft_pmo (
	cod_operador numeric(5) NULL,
	nome_operador text NULL,
	"data" timestamp NULL,
	hora_inicio timestamp NULL,
	hora_fim timestamp NULL,
	minutos numeric(5) NULL,
	codigo_motivo numeric(3) NULL,
	motivo text NULL,
	detalhes text NULL,
	codigo_celula numeric(5) NULL,
	nome_celula text NULL,
	turno numeric(3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.stage_stg_sugestao_reserva_tecido_oc definição

-- Drop table

-- DROP TABLE temporario.stage_stg_sugestao_reserva_tecido_oc;

CREATE TABLE temporario.stage_stg_sugestao_reserva_tecido_oc (
	cd_ordem_producao varchar(25) NULL,
	periodo_producao varchar(25) NULL,
	cd_estagio varchar(25) NULL,
	referencia varchar(5) NULL,
	cod_cor varchar(6) NULL,
	fk_produto varchar(40) NULL,
	fk_componente varchar(40) NULL,
	unidade_medida varchar(2) NULL,
	qtd_a_produzir numeric(17, 2) NULL,
	qtd_em_producao_pacote numeric(17, 2) NULL,
	qtd_pecas_progamada numeric(17, 2) NULL,
	consumo_programado numeric(17, 2) NULL
);


-- temporario.suprimentos_dfornecedor_produto definição

-- Drop table

-- DROP TABLE temporario.suprimentos_dfornecedor_produto;

CREATE TABLE temporario.suprimentos_dfornecedor_produto (
	"código produto" text NULL,
	descrição text NULL,
	"cnpj fornecedor" text NULL,
	nome_fornecedor text NULL,
	codigo_fornecedor text NULL,
	tempo_reposicao numeric(5) NULL,
	lote_multiplo numeric(12, 3) NULL,
	codigo_moeda numeric(2) NULL,
	unid_conv text NULL,
	fator_conv numeric(14, 6) NULL,
	qtde_por_embalagem numeric(13, 3) NULL,
	operador_calc text NULL,
	desc_referencia varchar(85) NULL
);


-- temporario.suprimentos_dlancamentos_produto definição

-- Drop table

-- DROP TABLE temporario.suprimentos_dlancamentos_produto;

CREATE TABLE temporario.suprimentos_dlancamentos_produto (
	produto text NULL,
	num_contabil numeric(9) NULL,
	documento numeric(9) NULL,
	centro_de_custo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.suprimentos_dlancamentos_servico definição

-- Drop table

-- DROP TABLE temporario.suprimentos_dlancamentos_servico;

CREATE TABLE temporario.suprimentos_dlancamentos_servico (
	produto text NULL,
	num_contabil numeric(9) NULL,
	nr_duplicata numeric(9) NULL,
	centro_de_custo text NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.suprimentos_dobc_empresas definição

-- Drop table

-- DROP TABLE temporario.suprimentos_dobc_empresas;

CREATE TABLE temporario.suprimentos_dobc_empresas (
	id_filial text NULL,
	filial_razao_social text NULL,
	filial_nome_fantasia text NULL,
	filial_status text NULL,
	filial_empresa text NULL,
	id_empresa text NULL,
	filial_status_nome text NULL
);


-- temporario.suprimentos_dobc_sdcv_detalhes definição

-- Drop table

-- DROP TABLE temporario.suprimentos_dobc_sdcv_detalhes;

CREATE TABLE temporario.suprimentos_dobc_sdcv_detalhes (
	sdcv_codigo numeric(15) NULL,
	sdcv_requisicao_erp text NULL,
	sdcv_prioridade text NULL,
	sdcv_motivo_urgencia text NULL,
	sdc_descricao_adicional text NULL,
	sdc_motivo_outro text NULL,
	sdc_descricao text NULL,
	comentario_uso_interno text NULL,
	sdcv_tipo text NULL,
	sdcv_tipo_registro text NULL,
	sdcv_tipo_compra text NULL,
	contrato_numero int4 NULL,
	sdcv_solicitante text NULL,
	sdcv_comprador text NULL,
	sdcv_c_custo_codigo text NULL,
	sdcv_c_custo_nome text NULL,
	sdcv_c_contabil_codigo text NULL,
	sdcv_c_contabil_nome text NULL,
	sdcv_empresa text NULL,
	sdcv_filial_nome text NULL,
	sdcv_filial_razao_social text NULL,
	sdcv_local_entrega_nome text NULL,
	sdcv_grupo_descricao text NULL,
	sdcv_quantidade numeric(38, 18) NULL,
	sdcv_unidade text NULL,
	sdcv_de_projeto text NULL,
	projeto_codigo int8 NULL,
	projeto_nome text NULL,
	projeto_fase_codigo int4 NULL,
	projeto_fase text NULL,
	categoria_nivel_1 text NULL,
	categoria_nivel_2 text NULL,
	categoria_nivel_3 text NULL,
	caracteristica_item text NULL,
	item_codigo int4 NULL,
	item_codigo_erp text NULL,
	item_nome text NULL,
	proposta_de_contrato text NULL,
	proposta_frete text NULL,
	proposta_valor_frete numeric(38, 18) NULL,
	proposta_vlr_unit numeric(38, 18) NULL,
	proposta_vlr_total numeric(38, 18) NULL,
	proposta_vlr_unit_inicial numeric(38, 18) NULL,
	proposta_vlr_total_inicial numeric(38, 18) NULL,
	proposta_custo_unit numeric(38, 18) NULL,
	proposta_custo_total numeric(38, 18) NULL,
	saving_vlr_valor_saving numeric(38, 18) NULL,
	saving_vlr_valor_base_saving numeric(38, 18) NULL,
	saving_vlr_percentual_saving numeric(38, 18) NULL,
	saving_cus_valor_saving numeric(38, 18) NULL,
	saving_cus_valor_base_saving numeric(38, 18) NULL,
	saving_cus_percentual_saving numeric(38, 18) NULL,
	proposta_saving_vlr numeric(38, 18) NULL,
	proposta_valor_base_para_saving numeric(38, 18) NULL,
	proposta_saving_percentual numeric(38, 18) NULL,
	proposta_saving_base_calculo text NULL,
	proposta_saving_tipo text NULL,
	proposta_vlr_considerado_analise_cotacao numeric(38, 18) NULL,
	proposta_cond_pagamento text NULL,
	proposta_prazo_medio_pagamento numeric(10, 2) NULL,
	proposta_moeda text NULL,
	proposta_renegociada text NULL,
	proposta_preenchida_por text NULL,
	proposta_justificativa_escolha text NULL,
	fornecedor_razao_social text NULL,
	fornecedor_fantasia text NULL,
	fornecedor_cnpj text NULL,
	fornecedor_cidade text NULL,
	fornecedor_estado text NULL,
	fornecedor_faturado text NULL,
	cnpj_faturado text NULL,
	compra_numero int4 NULL,
	pedido_numero text NULL,
	pedido_qtd_pedida numeric(38, 18) NULL,
	pedido_qtd_recebida numeric(38, 18) NULL,
	pedido_qtd_saldo numeric(38, 18) NULL,
	pedido_situacao_entrega text NULL,
	pedido_status_entrega text NULL,
	nf_numero text NULL,
	nf_serie text NULL,
	nf_data_emissao text NULL,
	nf_quantidade_entrega text NULL,
	data_compra_dia text NULL,
	data_compra_mes text NULL,
	data_compra_ano text NULL,
	data_criacao_sdcv text NULL,
	data_expectativa_sugerida text NULL,
	data_expectativa_informada text NULL,
	data_ultima_autorizacao text NULL,
	data_envio_aprovacao_cotacao text NULL,
	data_ultima_aprovacao_cotacao text NULL,
	data_integracao_erp text NULL,
	data_emissao_pedido text NULL,
	data_previsao_faturamento text NULL,
	data_previsao_entrega text NULL,
	data_primeira_entrega text NULL,
	data_ultima_entrega text NULL,
	prazo_sugerido int4 NULL,
	prazo_solicitante int4 NULL,
	tempo_entre_solicitacao_compra int4 NULL,
	tempo_entre_solicitacao_entrega int4 NULL,
	tempo_atendeu_prazo_solicitante text NULL,
	tempo_fornecedor_atendeu_prazo_pedido text NULL,
	quantidade_convites int4 NULL,
	quantidade_respostas int4 NULL,
	quantidade_declinadas int4 NULL,
	quantidade_nao_responderam int4 NULL,
	saving_uc_percentual numeric(38, 18) NULL,
	saving_uc_valor numeric(38, 18) NULL,
	saving_ge_percentual numeric(38, 18) NULL,
	saving_ge_valor numeric(38, 18) NULL,
	saving_gf_percentual numeric(38, 18) NULL,
	saving_gf_valor numeric(38, 18) NULL,
	saving_ce_percentual numeric(38, 18) NULL,
	saving_ce_valor numeric(38, 18) NULL,
	saving_ma_percentual numeric(38, 18) NULL,
	saving_ma_valor numeric(38, 18) NULL,
	compra_tipo_compra text NULL,
	sdc_for_exclusivo text NULL,
	tempo_criacao numeric(10, 2) NULL,
	tempo_triagem numeric(10, 2) NULL,
	tempo_convite numeric(10, 2) NULL,
	tempo_cotacao numeric(10, 2) NULL,
	tempo_aprovacao numeric(10, 2) NULL,
	tempo_aprovacao_pedido numeric(10, 2) NULL,
	tempo_pedido numeric(10, 2) NULL,
	tempo_faturamento numeric(10, 2) NULL,
	tempo_entrega numeric(10, 2) NULL,
	tempo_comprador numeric(10, 2) NULL,
	tempo_aprovador numeric(10, 2) NULL,
	tempo_solicitante numeric(10, 2) NULL,
	tempo_fornecedor numeric(10, 2) NULL,
	tempo_total numeric(10, 2) NULL,
	motivo_codigo_erp text NULL,
	motivo_descricao text NULL,
	centro_de_custo_cod text NULL,
	sdc_status text NULL,
	requisicao_grupo text NULL,
	cotacao_codigo int4 NULL,
	sequencial_pedido int4 NULL,
	compra_cond_pagamento text NULL,
	compra_prazo_medio_pagamento numeric(10, 2) NULL,
	sdcv_target numeric(18, 6) NULL,
	nota_primeiro_vencimento timestamp NULL,
	nota_item_valor numeric(38, 18) NULL,
	projeto_valor_aprovado numeric(38, 18) NULL
);


-- temporario.suprimentos_dobc_sdcv_resumo definição

-- Drop table

-- DROP TABLE temporario.suprimentos_dobc_sdcv_resumo;

CREATE TABLE temporario.suprimentos_dobc_sdcv_resumo (
	id_sdcv numeric(15) NULL,
	sdcv_status text NULL,
	sdcv_status_nome text NULL,
	sdcv_tipo text NULL,
	sdcv_prioridade text NULL,
	sdcv_tipo_registro text NULL,
	sdcv_tipo_compra text NULL,
	sdcv_qtdade numeric(38, 18) NULL,
	sdcv_valor_total numeric(38, 18) NULL,
	sdcv_vlr_frete_fornecedor numeric(38, 18) NULL,
	sdcv_saving_valor numeric(38, 18) NULL,
	sdcv_saving_percentual numeric(38, 18) NULL,
	sdcv_saving_tipo text NULL,
	sdcv_moeda text NULL,
	sdcv_data_criacao text NULL,
	sdcv_data_envio_cotacao text NULL,
	sdcv_data_envio_aprovacao text NULL,
	sdcv_data_compra text NULL,
	id_solicitante text NULL,
	id_comprador text NULL,
	id_item text NULL,
	sdcv_filial_razao text NULL,
	id_filial text NULL,
	sdcv_empresa_nome text NULL,
	id_projeto int8 NULL,
	id_fase_projeto int4 NULL,
	id_contrato int4 NULL,
	id_pedido text NULL,
	id_compra int4 NULL,
	id_cotacao int4 NULL,
	sdcv_motivo text NULL,
	sdcv_descricao_complementar text NULL,
	sdcv_descricao_interna text NULL,
	sdcv_motivo_escolha_fornecedor text NULL,
	sdcv_preenchedor_proposta text NULL,
	sdcv_renegociada text NULL,
	sdc_data_ult_movimentacao timestamp NULL,
	sdc_target numeric(18, 6) NULL
);


-- temporario.suprimentos_fauditorio_de_pedido_de_compra definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fauditorio_de_pedido_de_compra;

CREATE TABLE temporario.suprimentos_fauditorio_de_pedido_de_compra (
	titulo numeric(9) NULL,
	tipo_titulo numeric(2) NULL,
	cnpj_titulo text NULL,
	emitente_titulo text NULL,
	centro_custo numeric(6) NULL,
	valor_titulo numeric(38, 10) NULL,
	pedido numeric(38, 10) NULL,
	valor_pedido numeric(38, 10) NULL,
	valor_diferenca numeric(38, 10) NULL,
	encontrado text NULL
);


-- temporario.suprimentos_fdados_bi definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fdados_bi;

CREATE TABLE temporario.suprimentos_fdados_bi (
	sdcv_tipo text NULL,
	data_criacao_sdcv text NULL,
	data_ultima_entrega text NULL,
	centro_de_custo_cod text NULL,
	projeto_codigo int8 NULL,
	projeto_nome text NULL,
	projeto_fase_codigo int4 NULL,
	projeto_fase text NULL,
	sdcv_empresa text NULL,
	sdcv_c_contabil_codigo text NULL,
	sdcv_codigo numeric(15) NULL,
	pedido_numero text NULL,
	sdcv_solicitante text NULL,
	fornecedor_cnpj text NULL,
	fornecedor_razao_social text NULL,
	item_codigo_erp text NULL,
	item_nome text NULL,
	nf_numero text NULL,
	nota_item_valor numeric(38, 18) NULL,
	nf_data_emissao text NULL,
	nota_primeiro_vencimento timestamp NULL,
	sdc_descricao text NULL,
	sdcv_entrega_emissao text NULL,
	sdcv_entrega_numero_nf text NULL,
	sdcv_valor_total numeric(15, 3) NULL,
	proposta_vlr_unit numeric(15, 3) NULL
);


-- temporario.suprimentos_finvestimento_realizado definição

-- Drop table

-- DROP TABLE temporario.suprimentos_finvestimento_realizado;

CREATE TABLE temporario.suprimentos_finvestimento_realizado (
	empresa varchar(150) NULL,
	produto varchar(50) NULL,
	numero_nota int4 NULL,
	centro_de_custo varchar(150) NULL,
	fornecedor varchar(20) NULL,
	nome_fornecedor varchar(150) NULL,
	descricao_bem text NULL,
	cod_do_bem varchar(50) NULL,
	observacoes_do_bem text NULL,
	grupo_do_bem varchar(150) NULL,
	grupo_do_produto varchar(150) NULL,
	data_aquisicao date NULL,
	valor_bem numeric(15, 2) NULL,
	ultima_atualizacao timestamp NULL,
	descricao varchar(300) NULL
);


-- temporario.suprimentos_fitem_projeto_obc definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fitem_projeto_obc;

CREATE TABLE temporario.suprimentos_fitem_projeto_obc (
	sdcv_codigo int8 NULL,
	prj_codigo int8 NULL,
	prj_nome text NULL,
	data_criacao_sdcv timestamp NULL,
	proposta_prazo_medio_pagamento int4 NULL,
	centro_de_custo_cod text NULL,
	sdcv_c_custo_nome text NULL,
	proposta_cond_pagamento text NULL,
	justificativa text NULL,
	pfa_codigo int8 NULL,
	pfa_descricao text NULL,
	pedido_numero int8 NULL,
	item_descricao text NULL,
	id_item int8 NULL,
	sdcv_tipo_registro text NULL,
	id_categoria_nivel1 int8 NULL,
	id_categoria_nivel2 int8 NULL,
	item_categoria_nivel1 text NULL,
	item_categoria_nivel2 text NULL,
	item_categoria_nivel3 text NULL,
	item_caracteristica text NULL,
	proposta_vlr_total numeric(18, 2) NULL,
	fornecedor_fantasia text NULL,
	fornecedor_cnpj text NULL,
	proposta_vlr_unit numeric(18, 2) NULL,
	sdcv_unidade text NULL,
	sdcv_quantidade numeric(18, 4) NULL,
	compra_numero int8 NULL,
	sdcv_tipo_compra text NULL,
	sdcv_solicitante text NULL,
	sdcv_comprador text NULL,
	prj_status text NULL,
	sdc_status text NULL,
	prv_valor_previsto numeric(18, 2) NULL,
	prj_valor_aprovado numeric(18, 2) NULL,
	prj_valor_base numeric(18, 2) NULL,
	prv_valor numeric(18, 2) NULL
);


-- temporario.suprimentos_fnota_entrada definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fnota_entrada;

CREATE TABLE temporario.suprimentos_fnota_entrada (
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(5) NULL,
	nf_dataemissao timestamp NULL,
	fk_produto varchar(18) NULL,
	pedido_compra int8 NULL,
	seq_item_pedido_compra int8 NULL,
	fk_cliente varchar(20) NULL,
	fk_fornecedor varchar(20) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	itemnf_quantidade numeric(18, 3) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrdesconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	condicao_pagto int2 NULL,
	nf_origem int4 NULL,
	cfop varchar(44) NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	cd_emite_duplicata varchar(2) NULL,
	emite_duplicata varchar(3) NULL,
	fk_centro_custo int8 NULL,
	fk_conta_estoque int4 NULL,
	codigo_contabil int4 NULL,
	fk_grupo_contas int4 NULL,
	cod_familia int4 NULL,
	descricao_familia varchar(20) NULL,
	ultima_atualizacao timestamp NULL,
	data_digitacao timestamp NULL,
	data_transacao timestamp NULL,
	usuario_digitacao varchar(250) NULL,
	situacao_entrada int2 NULL,
	especie_docto varchar(5) NULL
);


-- temporario.suprimentos_fnota_entrada_inc definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fnota_entrada_inc;

CREATE TABLE temporario.suprimentos_fnota_entrada_inc (
	nf_notafiscal int4 NULL,
	nf_serienotafiscal varchar(5) NULL,
	nf_dataemissao timestamp NULL,
	fk_produto varchar(18) NULL,
	pedido_compra int8 NULL,
	seq_item_pedido_compra int8 NULL,
	fk_cliente varchar(20) NULL,
	fk_fornecedor varchar(20) NULL,
	itemnf_vlr_tot numeric(18, 3) NULL,
	itemnf_quantidade numeric(18, 3) NULL,
	itemnf_vlrunit numeric(18, 3) NULL,
	itemnf_vlrdesconto numeric(18, 3) NULL,
	itemnf_vlripi numeric(18, 3) NULL,
	itemnf_vlricms numeric(18, 3) NULL,
	itemnf_vlricmsdiferido numeric(18, 3) NULL,
	itemnf_vlrpis numeric(18, 3) NULL,
	itemnf_vlrcofins numeric(18, 3) NULL,
	condicao_pagto int2 NULL,
	nf_origem int4 NULL,
	cfop varchar(44) NULL,
	desc_nat_oper varchar(40) NULL,
	uf varchar(2) NULL,
	cd_emite_duplicata varchar(2) NULL,
	emite_duplicata varchar(3) NULL,
	fk_centro_custo int8 NULL,
	fk_conta_estoque int4 NULL,
	codigo_contabil int4 NULL,
	fk_grupo_contas int4 NULL,
	cod_familia int4 NULL,
	descricao_familia varchar(20) NULL,
	ultima_atualizacao timestamp NULL,
	data_digitacao timestamp NULL,
	data_transacao timestamp NULL,
	usuario_digitacao varchar(250) NULL,
	situacao_entrada int2 NULL,
	especie_docto varchar(5) NULL
);


-- temporario.suprimentos_fpendencias_acessorios definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fpendencias_acessorios;

CREATE TABLE temporario.suprimentos_fpendencias_acessorios (
	empresa numeric(3) NULL,
	data_emissao timestamp NULL,
	nota_fiscal numeric(9) NULL,
	serie_nota_fiscal text NULL,
	ordem_servico numeric(9) NULL,
	ordem_producao numeric(9) NULL,
	cnpj_fornecedor text NULL,
	nome_fornecedor text NULL
);


-- temporario.suprimentos_fprojeto_obc definição

-- Drop table

-- DROP TABLE temporario.suprimentos_fprojeto_obc;

CREATE TABLE temporario.suprimentos_fprojeto_obc (
	projeto_codigo int8 NULL,
	projeto_nome text NULL,
	projeto_fase text NULL,
	projeto_fase_codigo int4 NULL,
	prj_data_ini date NULL,
	prj_data_fim date NULL,
	"valor total previsto" numeric(38, 18) NULL,
	"valor total orçado" numeric(38, 18) NULL,
	"valor total empenhado" numeric(38, 18) NULL,
	"valor total empenhado em contrato" numeric(38, 18) NULL,
	"valor total pedidos" numeric(38, 18) NULL,
	"valor total requisicoes de estoque" numeric(38, 18) NULL,
	"valor total notas fiscais" numeric(38, 18) NULL,
	"saldo total" numeric(38, 18) NULL
);


-- temporario.suprimentos_frequisicoes_compra definição

-- Drop table

-- DROP TABLE temporario.suprimentos_frequisicoes_compra;

CREATE TABLE temporario.suprimentos_frequisicoes_compra (
	num_requisicao numeric(6) NULL,
	seq_item_req numeric(2) NULL,
	codigo_deposito numeric(3) NULL,
	data_requisicao timestamp NULL,
	nome_requisit text NULL,
	observacao_req text NULL,
	data_prev_entr_req timestamp NULL,
	situacao_codigo numeric(1) NULL,
	cod_cancelamento numeric(2) NULL,
	descr_canc_comp text NULL,
	situacao text NULL,
	pedido_compra numeric(6) NULL,
	data_prev_entr_ped timestamp NULL,
	fk_produto text NULL,
	fk_fornecedor text NULL,
	unidade_medida text NULL,
	qtde_requisitada numeric(15, 3) NULL,
	qtde_pedida_item numeric(15, 3) NULL,
	valor_unitario numeric(20, 5) NULL,
	ultimaentrada timestamp NULL,
	ultimasaida timestamp NULL,
	estoqueatual numeric(38, 10) NULL,
	qtdsugerida numeric(38, 10) NULL,
	precoultentrada numeric(38, 10) NULL,
	estoquemin numeric(38, 10) NULL,
	estoquemax numeric(38, 10) NULL,
	consumomedmes numeric(38, 10) NULL,
	consumopordia numeric(38, 10) NULL
);


-- temporario.sustentabilidade_fdescarte_residuos definição

-- Drop table

-- DROP TABLE temporario.sustentabilidade_fdescarte_residuos;

CREATE TABLE temporario.sustentabilidade_fdescarte_residuos (
	ultima_atualizacao timestamp NULL,
	id int4 NULL,
	data_descarte timestamp NULL,
	id_tipo_residuo int4 NULL,
	residuo varchar(100) NULL,
	unidade varchar(3) NULL,
	valor_unitario numeric(18, 3) NULL,
	quantidade numeric(18, 3) NULL
);


-- temporario.sustentabilidade_fnotas_energia definição

-- Drop table

-- DROP TABLE temporario.sustentabilidade_fnotas_energia;

CREATE TABLE temporario.sustentabilidade_fnotas_energia (
	serie text NULL,
	documento numeric(9) NULL,
	centro_custo numeric(9) NULL,
	codigo_contabil numeric(9) NULL,
	num_contabil numeric(9) NULL,
	data_emissao timestamp NULL,
	cnpj_comprador text NULL,
	nome_fornecedor text NULL,
	produto text NULL,
	descricao_item text NULL,
	unidade_medida text NULL,
	valor_unitario numeric(20, 5) NULL,
	quantidade numeric(14, 3) NULL,
	valor_total numeric(15, 2) NULL
);


-- temporario.sustentabilidade_fnotas_residuos definição

-- Drop table

-- DROP TABLE temporario.sustentabilidade_fnotas_residuos;

CREATE TABLE temporario.sustentabilidade_fnotas_residuos (
	codigo_empresa int2 NULL,
	serie_nota_fisc varchar(3) NULL,
	num_nota_fiscal int4 NULL,
	centro_custo int4 NULL,
	codigo_contabil int4 NULL,
	num_contabil int4 NULL,
	data_emissao timestamp NULL,
	cnpj_comprador varchar(120) NULL,
	nome_fornecedor varchar(60) NULL,
	natur_operacao int2 NULL,
	quantidade numeric(18, 3) NULL,
	valor_itens_nfis numeric(18, 3) NULL,
	produto varchar(111) NULL,
	descricao_item varchar(120) NULL,
	unidade_medida varchar(2) NULL,
	valor_unitario numeric(18, 3) NULL,
	qtde_item_fatur numeric(18, 3) NULL,
	valor_faturado numeric(18, 3) NULL,
	ultima_atualizacao timestamp NULL
);


-- temporario.ti_dglpi_filas definição

-- Drop table

-- DROP TABLE temporario.ti_dglpi_filas;

CREATE TABLE temporario.ti_dglpi_filas (
	id int4 NULL,
	"name" varchar(255) NULL,
	"comment" text NULL,
	fase varchar(255) NULL,
	etapa varchar(255) NULL
);


-- temporario.ti_dglpi_grupos definição

-- Drop table

-- DROP TABLE temporario.ti_dglpi_grupos;

CREATE TABLE temporario.ti_dglpi_grupos (
	id int8 NULL,
	groups_id int8 NULL,
	completename text NULL,
	area text NULL,
	departamento text NULL,
	setor text NULL
);


-- temporario.ti_dorion_projetos definição

-- Drop table

-- DROP TABLE temporario.ti_dorion_projetos;

CREATE TABLE temporario.ti_dorion_projetos (
	id varchar(9) NULL,
	cod_projeto varchar(9) NULL,
	data_criacao timestamp NULL,
	origem_projeto varchar(150) NULL,
	descricao varchar(400) NULL,
	descricao_problema varchar(4000) NULL,
	objetivo_projeto varchar(4000) NULL,
	pendencias varchar(4000) NULL,
	acao_em_andamento varchar(4000) NULL,
	proximas_acoes varchar(4000) NULL,
	status varchar(50) NULL
);


-- temporario.ti_forus_atendimento definição

-- Drop table

-- DROP TABLE temporario.ti_forus_atendimento;

CREATE TABLE temporario.ti_forus_atendimento (
	sprint_id int8 NULL,
	sprint_number int4 NULL,
	status_sprint varchar(50) NULL,
	ticket_number int4 NULL,
	id int4 NULL,
	created_at timestamp NULL,
	"type" varchar(50) NULL,
	team varchar(50) NULL,
	nome_dev varchar(200) NULL,
	fase_atual varchar(100) NULL,
	planejado int4 NULL,
	total_concluidas int4 NULL,
	total_em_aberto int4 NULL,
	horas_planejadas numeric(10, 2) NULL,
	horas_apontadas numeric(10, 2) NULL
);


-- temporario.ti_forus_desvios_formais definição

-- Drop table

-- DROP TABLE temporario.ti_forus_desvios_formais;

CREATE TABLE temporario.ti_forus_desvios_formais (
	sprint_id int4 NULL,
	sprint_number int4 NULL,
	status varchar(50) NULL,
	ticket_number int4 NULL,
	"type" varchar(50) NULL,
	team varchar(50) NULL,
	nome_dev varchar(200) NULL,
	tipo_desvio varchar(50) NULL,
	horas_apontadas numeric(10, 2) NULL
);


-- temporario.ti_forus_desvios_informais definição

-- Drop table

-- DROP TABLE temporario.ti_forus_desvios_informais;

CREATE TABLE temporario.ti_forus_desvios_informais (
	sprint_id int4 NULL,
	sprint_number int4 NULL,
	status_sprint varchar(50) NULL,
	ticket_number int4 NULL,
	id int4 NULL,
	descricao_id varchar(100) NULL,
	created_at timestamp NULL,
	"type" varchar(50) NULL,
	team varchar(50) NULL,
	nome_dev varchar(200) NULL,
	fase_atual varchar(100) NULL,
	horas_apontadas numeric(10, 2) NULL
);


-- temporario.ti_forus_melhoria definição

-- Drop table

-- DROP TABLE temporario.ti_forus_melhoria;

CREATE TABLE temporario.ti_forus_melhoria (
	sprint_id int4 NULL,
	sprint_number int4 NULL,
	status varchar(50) NULL,
	ticket_number int4 NULL,
	"type" varchar(50) NULL,
	team varchar(100) NULL,
	nome_dev varchar(200) NULL,
	current_phase_name varchar(100) NULL,
	planejado int4 NULL,
	total_concluidas int4 NULL,
	total_em_aberto int4 NULL,
	horas_planejadas numeric(15, 3) NULL,
	horas_apontadas numeric(15, 3) NULL
);


-- temporario.ti_forus_resumo_sprint definição

-- Drop table

-- DROP TABLE temporario.ti_forus_resumo_sprint;

CREATE TABLE temporario.ti_forus_resumo_sprint (
	id numeric(10) NULL,
	sprint_number numeric(38) NULL,
	status text NULL,
	ticket_number numeric(10) NULL,
	team text NULL,
	"nome dev" text NULL,
	current_phase_name text NULL,
	planejado numeric(38, 10) NULL,
	total_concluidas numeric(38, 10) NULL,
	total_em_aberto numeric(38, 10) NULL,
	"horas planejadas" numeric(38, 10) NULL,
	"horas apontadas" numeric(38, 10) NULL
);


-- temporario.ti_forus_sprint definição

-- Drop table

-- DROP TABLE temporario.ti_forus_sprint;

CREATE TABLE temporario.ti_forus_sprint (
	id int4 NULL,
	sprint_number int4 NULL,
	active int4 NULL,
	"name" varchar(150) NULL,
	description text NULL,
	start_date date NULL,
	end_date date NULL,
	status varchar(50) NULL,
	team varchar(50) NULL,
	available_hours numeric(10, 2) NULL,
	total_hours numeric(10, 2) NULL,
	worked_hours numeric(10, 2) NULL
);

-- DROP SCHEMA ti;

CREATE SCHEMA ti AUTHORIZATION "Gustavo_Puc";

-- DROP SEQUENCE ti.dfilas_times_glpi_id_seq;

CREATE SEQUENCE ti.dfilas_times_glpi_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.dglpi_estagios_id_seq;

CREATE SEQUENCE ti.dglpi_estagios_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.dorion_demandas_id_demanda_seq;

CREATE SEQUENCE ti.dorion_demandas_id_demanda_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.dorion_iniciativas_id_iniciativa_seq;

CREATE SEQUENCE ti.dorion_iniciativas_id_iniciativa_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.dorion_map_processos_id_map_seq;

CREATE SEQUENCE ti.dorion_map_processos_id_map_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.forion_demandas_id_seq;

CREATE SEQUENCE ti.forion_demandas_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.forion_entrega_projetos_id_seq;

CREATE SEQUENCE ti.forion_entrega_projetos_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.forion_setor_demandas_id_seq;

CREATE SEQUENCE ti.forion_setor_demandas_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.forion_setor_projetos_id_seq;

CREATE SEQUENCE ti.forion_setor_projetos_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.sistemas_glpi_sistemas_id_seq;

CREATE SEQUENCE ti.sistemas_glpi_sistemas_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ti.sla_glpi_id_seq;

CREATE SEQUENCE ti.sla_glpi_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- ti.ddescricao_prioridade definição

-- Drop table

-- DROP TABLE ti.ddescricao_prioridade;

CREATE TABLE ti.ddescricao_prioridade (
	prioridade_id int4 NOT NULL,
	desc_prioridade text NOT NULL,
	CONSTRAINT ddescricao_prioridade_pkey PRIMARY KEY (prioridade_id)
);


-- ti.ddescricao_status definição

-- Drop table

-- DROP TABLE ti.ddescricao_status;

CREATE TABLE ti.ddescricao_status (
	status_id int4 NOT NULL,
	descricao_status text NOT NULL,
	CONSTRAINT ddescricao_status_pkey PRIMARY KEY (status_id)
);


-- ti.dglpi_categorias definição

-- Drop table

-- DROP TABLE ti.dglpi_categorias;

CREATE TABLE ti.dglpi_categorias (
	id int4 NOT NULL,
	itilcategories_id int4 NULL,
	categoria_nome varchar(100) DEFAULT NULL::character varying NULL,
	completename varchar(255) DEFAULT NULL::character varying NULL,
	subcategoria varchar(50) DEFAULT NULL::character varying NULL,
	tipo_sistema varchar(50) DEFAULT NULL::character varying NULL,
	CONSTRAINT dglpi_categorias_pkey PRIMARY KEY (id)
);


-- ti.dglpi_estagios definição

-- Drop table

-- DROP TABLE ti.dglpi_estagios;

CREATE TABLE ti.dglpi_estagios (
	id int4 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	depto varchar(50) NULL,
	tipo varchar(50) NULL,
	fase varchar(100) NULL,
	etapa varchar(100) NULL,
	id_tecnico int4 NULL,
	tecnico varchar(100) NULL,
	responsavel varchar(50) NULL,
	resp_tecnico varchar(50) NULL,
	"time" varchar(50) NULL,
	CONSTRAINT dglpi_estagios_pkey PRIMARY KEY (id)
);


-- ti.dglpi_filas definição

-- Drop table

-- DROP TABLE ti.dglpi_filas;

CREATE TABLE ti.dglpi_filas (
	id int4 NULL,
	"name" varchar(255) NULL,
	"comment" text NULL,
	fase varchar(255) NULL,
	etapa varchar(255) NULL
);


-- ti.dglpi_grupos definição

-- Drop table

-- DROP TABLE ti.dglpi_grupos;

CREATE TABLE ti.dglpi_grupos (
	id int8 NULL,
	groups_id int8 NULL,
	completename text NULL,
	area text NULL,
	departamento text NULL,
	setor text NULL
);


-- ti.dglpi_sistemas definição

-- Drop table

-- DROP TABLE ti.dglpi_sistemas;

CREATE TABLE ti.dglpi_sistemas (
	sistemas_id int4 DEFAULT nextval('ti.sistemas_glpi_sistemas_id_seq'::regclass) NOT NULL,
	sistema varchar(255) NOT NULL,
	categoria varchar(255) NOT NULL,
	CONSTRAINT sistemas_glpi_pkey PRIMARY KEY (sistemas_id)
);


-- ti.dglpi_sla definição

-- Drop table

-- DROP TABLE ti.dglpi_sla;

CREATE TABLE ti.dglpi_sla (
	id int4 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	tipo_chamado varchar(20) NULL,
	categoria varchar(20) NULL,
	estagio varchar(50) NULL,
	sla int4 NULL,
	CONSTRAINT sla_glpi_pkey PRIMARY KEY (id)
);


-- ti.dglpi_subcategoria_sistemas definição

-- Drop table

-- DROP TABLE ti.dglpi_subcategoria_sistemas;

CREATE TABLE ti.dglpi_subcategoria_sistemas (
	sub_categoria_id int4 NOT NULL,
	subcategoria_desc varchar(255) NOT NULL,
	categoria_id int4 NOT NULL,
	CONSTRAINT dim_subcategoria_sistemas_glpi_pkey PRIMARY KEY (sub_categoria_id)
);


-- ti.dglpi_times definição

-- Drop table

-- DROP TABLE ti.dglpi_times;

CREATE TABLE ti.dglpi_times (
	id int4 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	fila_glpi varchar(50) NULL,
	"time" varchar(50) NULL,
	CONSTRAINT dfilas_times_glpi_pkey PRIMARY KEY (id)
);


-- ti.dorion_demandas definição

-- Drop table

-- DROP TABLE ti.dorion_demandas;

CREATE TABLE ti.dorion_demandas (
	id_demanda int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	titulo varchar(255) NULL,
	sistema varchar(255) NULL,
	data_criacao date NULL,
	data_vencimento date NULL,
	descricao text NULL,
	tipo varchar(50) NULL,
	coluna int4 NULL,
	ordem int4 NULL,
	chamados _int4 NULL,
	prioridade varchar NULL,
	data_solucao date NULL,
	CONSTRAINT dorion_demandas_pkey PRIMARY KEY (id_demanda)
);


-- ti.dorion_iniciativas definição

-- Drop table

-- DROP TABLE ti.dorion_iniciativas;

CREATE TABLE ti.dorion_iniciativas (
	id_iniciativa int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	titulo varchar(255) NULL,
	sistema varchar(255) NULL,
	data_criacao date NULL,
	id_autor int4 NULL,
	id_responsavel int4 NULL,
	descricao text NULL,
	tipo varchar(50) NULL,
	coluna int4 NULL,
	ordem int4 NULL,
	chamados _int4 NULL,
	CONSTRAINT dorion_iniciativas_pkey PRIMARY KEY (id_iniciativa)
);


-- ti.dorion_map_processos definição

-- Drop table

-- DROP TABLE ti.dorion_map_processos;

CREATE TABLE ti.dorion_map_processos (
	id_map int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	setor varchar(50) NULL,
	processo int4 NULL,
	processo_map int4 NULL,
	subprocesso int4 NULL,
	subprocesso_map int4 NULL,
	detalhe_subprocesso int4 NULL,
	detalhe_subprocesso_map int4 NULL,
	CONSTRAINT dorion_map_processos_pkey PRIMARY KEY (id_map)
);


-- ti.dorion_projetos definição

-- Drop table

-- DROP TABLE ti.dorion_projetos;

CREATE TABLE ti.dorion_projetos (
	id varchar(9) NULL,
	cod_projeto varchar(9) NULL,
	data_criacao timestamp NULL,
	origem_projeto varchar(150) NULL,
	descricao varchar(400) NULL,
	descricao_problema varchar(4000) NULL,
	objetivo_projeto varchar(4000) NULL,
	pendencias varchar(4000) NULL,
	acao_em_andamento varchar(4000) NULL,
	proximas_acoes varchar(4000) NULL,
	status varchar(50) NULL
);


-- ti.dsquads definição

-- Drop table

-- DROP TABLE ti.dsquads;

CREATE TABLE ti.dsquads (
	squad_id int4 NOT NULL,
	squad_name varchar NULL,
	responsavel varchar NULL,
	backlog int4 NULL,
	icone varchar(50) NULL,
	CONSTRAINT squad_pk PRIMARY KEY (squad_id)
);


-- ti.dsquads_composicao definição

-- Drop table

-- DROP TABLE ti.dsquads_composicao;

CREATE TABLE ti.dsquads_composicao (
	id int4 NOT NULL,
	nome varchar NULL,
	squad_id int4 NULL,
	analista_id int4 NULL
);


-- ti.fat_comentarios_glpi definição

-- Drop table

-- DROP TABLE ti.fat_comentarios_glpi;

CREATE TABLE ti.fat_comentarios_glpi (
	chamado_id int4 NOT NULL,
	titulo_chamado varchar(500) NULL,
	data_ultimo_post timestamp NULL,
	post_texto text NULL,
	user_post varchar(200) NULL,
	CONSTRAINT fat_comentarios_glpi_pkey PRIMARY KEY (chamado_id)
);


-- ti.fglpi_chamados definição

-- Drop table

-- DROP TABLE ti.fglpi_chamados;

CREATE TABLE ti.fglpi_chamados (
	id int4 NOT NULL,
	"date" timestamp NULL,
	closedate timestamp NULL,
	solvedate timestamp NULL,
	tempo_para_solucao timestamp NULL,
	status int4 NULL,
	slas_id_tto int4 NULL,
	slas_id_ttr int4 NULL,
	sla_waiting_duration int4 NULL,
	slalevels_id_ttr int4 NULL,
	priority int4 NULL,
	id_solicitante int4 NULL,
	urgencia int4 NULL,
	tipo_prioridade varchar(50) NULL,
	impacto int4 NULL,
	prioridade_cs float8 NULL,
	gut int4 NULL,
	categoria_id int4 NULL,
	categoria varchar(50) NULL,
	id_tecnico int4 NULL,
	tecnico varchar(50) NULL,
	solicitante varchar(50) NULL,
	titulo varchar(255) NULL,
	horas_resolucao float8 NULL,
	horas_solucao float8 NULL,
	sla_esperado int4 NULL,
	sla varchar(20) NULL,
	nota_survey int4 NULL,
	comentario_survey text NULL,
	data_survey timestamp NULL,
	link_chamado varchar(255) NULL,
	tipo_chamado varchar(50) NULL,
	id_grupo_solicitante varchar(7) NULL,
	sprint int8 NULL,
	valor_orcamento numeric(15, 3) NULL,
	CONSTRAINT fglpi_chamados_pkey PRIMARY KEY (id)
);


-- ti.forion_demandas definição

-- Drop table

-- DROP TABLE ti.forion_demandas;

CREATE TABLE ti.forion_demandas (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	mes date NULL,
	squad_id int4 NULL,
	tipo varchar(20) NULL,
	chamado_id int4 NULL,
	descricao varchar(255) NULL,
	comentario varchar(255) NULL,
	is_check bool DEFAULT false NULL,
	ordem int4 DEFAULT 0 NULL,
	CONSTRAINT forion_demandas_pkey PRIMARY KEY (id)
);


-- ti.forion_entrega_projetos definição

-- Drop table

-- DROP TABLE ti.forion_entrega_projetos;

CREATE TABLE ti.forion_entrega_projetos (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	mes date NULL,
	squad_id int4 NULL,
	tipo varchar(2) NULL,
	projeto_id int4 NULL,
	prioridade int4 NULL,
	comentario varchar(255) NULL,
	texto varchar(255) NULL,
	is_check bool NULL,
	ordem int4 DEFAULT 0 NULL,
	CONSTRAINT forion_entrega_projetos_pkey PRIMARY KEY (id)
);


-- ti.forion_setor_demandas definição

-- Drop table

-- DROP TABLE ti.forion_setor_demandas;

CREATE TABLE ti.forion_setor_demandas (
	id serial4 NOT NULL,
	tipo varchar(50) NOT NULL,
	chamado_id int4 NULL,
	descricao text DEFAULT ''::text NOT NULL,
	comentario text DEFAULT ''::text NOT NULL,
	setor_id int4 NOT NULL,
	mes date NOT NULL,
	is_check bool DEFAULT false NOT NULL,
	ordem int4 DEFAULT 0 NOT NULL,
	CONSTRAINT forion_setor_demandas_pkey PRIMARY KEY (id)
);


-- ti.forion_setor_projetos definição

-- Drop table

-- DROP TABLE ti.forion_setor_projetos;

CREATE TABLE ti.forion_setor_projetos (
	id serial4 NOT NULL,
	mes date NOT NULL,
	setor_id int4 NOT NULL,
	projeto_id int4 DEFAULT 0 NOT NULL,
	prioridade int4 DEFAULT 0 NOT NULL,
	comentario text DEFAULT ''::text NOT NULL,
	texto text DEFAULT ''::text NOT NULL,
	is_check bool DEFAULT false NOT NULL,
	ordem int4 DEFAULT 0 NOT NULL,
	CONSTRAINT forion_setor_projetos_pkey PRIMARY KEY (id)
);


-- ti.forus_atendimento definição

-- Drop table

-- DROP TABLE ti.forus_atendimento;

CREATE TABLE ti.forus_atendimento (
	sprint_id int8 NULL,
	sprint_number int4 NULL,
	status_sprint varchar(50) NULL,
	ticket_number int4 NULL,
	id int4 NULL,
	created_at timestamp NULL,
	"type" varchar(50) NULL,
	team varchar(50) NULL,
	nome_dev varchar(200) NULL,
	fase_atual varchar(100) NULL,
	planejado int4 NULL,
	total_concluidas int4 NULL,
	total_em_aberto int4 NULL,
	horas_planejadas numeric(10, 2) NULL,
	horas_apontadas numeric(10, 2) NULL
);


-- ti.forus_desvios_formais definição

-- Drop table

-- DROP TABLE ti.forus_desvios_formais;

CREATE TABLE ti.forus_desvios_formais (
	sprint_id int4 NULL,
	sprint_number int4 NULL,
	status varchar(50) NULL,
	ticket_number int4 NULL,
	"type" varchar(50) NULL,
	team varchar(50) NULL,
	nome_dev varchar(200) NULL,
	tipo_desvio varchar(50) NULL,
	horas_apontadas numeric(10, 2) NULL
);


-- ti.forus_desvios_informais definição

-- Drop table

-- DROP TABLE ti.forus_desvios_informais;

CREATE TABLE ti.forus_desvios_informais (
	sprint_id int4 NULL,
	sprint_number int4 NULL,
	status_sprint varchar(50) NULL,
	ticket_number int4 NULL,
	id int4 NULL,
	descricao_id varchar(100) NULL,
	created_at timestamp NULL,
	"type" varchar(50) NULL,
	team varchar(50) NULL,
	nome_dev varchar(200) NULL,
	fase_atual varchar(100) NULL,
	horas_apontadas numeric(10, 2) NULL
);


-- ti.forus_melhoria definição

-- Drop table

-- DROP TABLE ti.forus_melhoria;

CREATE TABLE ti.forus_melhoria (
	sprint_id int4 NULL,
	sprint_number int4 NULL,
	status varchar(50) NULL,
	ticket_number int4 NULL,
	"type" varchar(50) NULL,
	team varchar(100) NULL,
	nome_dev varchar(200) NULL,
	current_phase_name varchar(100) NULL,
	planejado int4 NULL,
	total_concluidas int4 NULL,
	total_em_aberto int4 NULL,
	horas_planejadas numeric(15, 3) NULL,
	horas_apontadas numeric(15, 3) NULL
);


-- ti.forus_resumo_sprint definição

-- Drop table

-- DROP TABLE ti.forus_resumo_sprint;

CREATE TABLE ti.forus_resumo_sprint (
	id numeric(10) NULL,
	sprint_number numeric(38) NULL,
	status text NULL,
	ticket_number numeric(10) NULL,
	team text NULL,
	"nome dev" text NULL,
	current_phase_name text NULL,
	planejado numeric(38, 10) NULL,
	total_concluidas numeric(38, 10) NULL,
	total_em_aberto numeric(38, 10) NULL,
	"horas planejadas" numeric(38, 10) NULL,
	"horas apontadas" numeric(38, 10) NULL
);


-- ti.forus_sprint definição

-- Drop table

-- DROP TABLE ti.forus_sprint;

CREATE TABLE ti.forus_sprint (
	id int4 NULL,
	sprint_number int4 NULL,
	active int4 NULL,
	"name" varchar(150) NULL,
	description text NULL,
	start_date date NULL,
	end_date date NULL,
	status varchar(50) NULL,
	team varchar(50) NULL,
	available_hours numeric(10, 2) NULL,
	total_hours numeric(10, 2) NULL,
	worked_hours numeric(10, 2) NULL
);