-- Schema: rh
-- Tabelas: 57

CREATE TABLE rh.dbanco_horas (
	descr_banco_horas varchar(50) NULL,
	dthora_atualizacao timestamp NULL,
	pk_banco_horas int4 NULL
);

CREATE TABLE rh.dcargo (
	desc_cargo varchar(125) NULL,
	ds_cd_cargo varchar(70) NULL,
	desc_cargo_resum varchar(60) NULL,
	cd_cargo varchar(30) NULL,
	cd_est_cargo int4 NULL,
	pk_cargo varchar(30) NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.dcausa_demissao (
	desc_dem varchar(50) NULL,
	cd_ds_dem varchar(70) NULL,
	cd_cau_rai int2 NULL,
	cd_cag int2 NULL,
	pk_causa_demissao int2 NULL,
	dthora_atualizacao timestamp NULL
);

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

CREATE TABLE rh.dempresa (
	desc_empresa varchar(60) NULL,
	cd_ds_empresa varchar(100) NULL,
	pk_empresa int4 NULL,
	dthora_atualizacao timestamp NULL
);

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

CREATE TABLE rh.devento (
	pk_evento varchar(110) NULL,
	cd_evento int4 NULL,
	cd_tipo_evento int2 NULL,
	desc_evento varchar(55) NULL,
	cd_ds_evento varchar(96) NULL,
	cd_tabela int4 NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.deventos_rh (
	cd_tab int8 NULL,
	cd_eve int8 NULL,
	fg_normal text NULL,
	fg_absenteismo text NULL,
	fg_extra text NULL,
	fg_rescisao text NULL,
	fg_normalabsenteismo text NULL
);

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

CREATE TABLE rh.dgrau_instrucao (
	pk_grau_instrucao int2 NULL,
	desc_grau varchar(50) NULL,
	cd_insrai int2 NULL,
	cd_ds_grau varchar(90) NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.dlocal_organograma (
	pk_local_organograma varchar(100) NULL,
	cd_taborg int4 NULL,
	cd_num_loc int8 NULL,
	cd_rat int8 NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.dlocalizacao (
	pk_localizacao int4 NULL,
	cd_nom_loc varchar(60) NULL,
	cd_num_loc int4 NULL,
	cd_rat int4 NULL,
	cd_ds_loc varchar(101) NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.dmotivo (
	pk_motivo int4 NULL,
	desc_motivo varchar(50) NULL,
	cd_ds_motivo varchar(70) NULL,
	cd_tip_motivo varchar(3) NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.dmotivo_reajuste (
	pk_motivo_alteracao varchar(5) NULL,
	ds_motivo_alteracao varchar(30) NULL,
	tipo_motivo varchar(3) NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE rh.dsituacao (
	pk_situacao int4 NULL,
	cd_ds_situacao varchar(80) NULL,
	desc_sit varchar(40) NULL,
	desc_abr varchar(6) NULL,
	cd_sit_cmp int4 NULL,
	cd_tip_sit int2 NULL,
	dthora_atualizacao timestamp NULL
);

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

CREATE TABLE rh.dstg_evento_stage (
	pk_evento text NULL,
	cd_evento numeric(4) NULL,
	cd_tipo_evento numeric(1) NULL,
	ds_evento text NULL,
	ds_evento_codigo text NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE rh.dusuario_antigo (
	pk_usuario_antigo int8 NULL,
	cd_nom_usu varchar(300) NULL,
	dthora_atualizacao timestamp NULL
);

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

CREATE TABLE rh.fafastamento (
	fk_funcionario varchar(50) NULL,
	fk_data_afastamento timestamp NULL,
	fk_situacao_afastamento varchar(6) NULL,
	dt_ini_afastamento timestamp NULL,
	dt_fim_afastamento timestamp NULL,
	ultima_atualizacao timestamp NULL
);

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

CREATE TABLE rh.fapuracao (
	pk_apuracao varchar(150) NULL,
	fk_colaborador varchar(140) NULL,
	fk_empresa int4 NULL,
	dt_apuracao timestamp NULL,
	dt_hr_apuracao int4 NULL,
	cd_desc int8 NULL,
	dthora_atualizacao timestamp NULL
);

CREATE TABLE rh.fapuracao_col_situacao (
	fk_empresa int4 NULL,
	fk_situacao int4 NULL,
	fk_colaborador varchar(110) NULL,
	dt_apu timestamp NULL,
	qtd_hor int8 NULL,
	dthora_atualizacao timestamp NULL
);

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

CREATE TABLE rh.fesocial_intervalo (
	fk_empresa int4 NULL,
	cd_id_eint int4 NULL,
	qtd_dur_int int4 NULL,
	vlr_ini_int int4 NULL,
	vlr_fim_int int4 NULL,
	cd_hor_eso varchar(50) NULL,
	dthora_atualizacao timestamp NULL
);

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