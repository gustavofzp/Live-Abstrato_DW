-- Schema: ppcp
-- Tabelas: 52

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

CREATE TABLE ppcp.dmotivos_reposicao (
	codigo varchar(5) NULL,
	desc_motivo varchar(60) NULL,
	tipo varchar(3) NULL,
	estagio varchar(5) NULL,
	area_agrupadora varchar(5) NULL,
	desc_area varchar(60) NULL
);

CREATE TABLE ppcp.dobs_estagio (
	ordem_producao int4 NULL,
	ordem_confeccao int4 NULL,
	estagio int4 NULL,
	tamanho_ordem_confeccao varchar(15) NULL,
	tipo_obs varchar(200) NULL,
	observacao_adicional varchar(500) NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE ppcp.doperacao (
	desc_operacao varchar(50) NULL,
	pk_operacao int4 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE ppcp.dpolivalencia_maquinas (
	id int8 NULL,
	maquina_princ varchar(8) NULL,
	maquina_poli_1 varchar(8) NULL,
	maquina_poli_2 varchar(8) NULL,
	ultima_atualizacao timestamp NULL
);

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

CREATE TABLE ppcp.faprovacao_rolos_930 (
	lote varchar(10) NULL,
	rolo varchar(10) NULL,
	aprovado numeric(17, 2) NULL,
	id_motivo int4 NULL,
	desc_motivo varchar(60) NULL
);

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

CREATE TABLE ppcp.festagios_beneficiamento (
	seq_operacao numeric(4) NULL,
	codigo_estagio numeric(5) NULL,
	seq_estagio numeric(1) NULL,
	turno_producao numeric(1) NULL,
	data_inicio timestamp NULL,
	data_termino timestamp NULL
);

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

CREATE TABLE ppcp.fmaquinas_divisao_externa (
	divisao numeric(38, 10) NULL,
	nome_divisao text NULL,
	cnpj text NULL,
	cod_maquina text NULL,
	maquina text NULL,
	quantidade numeric(6) NULL,
	data_atualizacao timestamp NULL
);

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

CREATE TABLE ppcp.foperadores_divisao (
	data_operadoras timestamp NULL,
	turno_familia int2 NULL,
	divisao int4 NULL,
	numero_operadoras int2 NULL,
	ultima_atualizacao timestamp NULL
);

CREATE TABLE ppcp.fordem_producao_leadtime (
	periodo numeric(38, 10) NULL,
	ordem_producao numeric(9) NULL,
	codigo_estagio numeric(5) NULL,
	qtde_produzida numeric(38, 10) NULL,
	data_entrada_fase timestamp NULL,
	data_saida_fase timestamp NULL,
	lead_time numeric(38, 10) NULL
);

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

CREATE TABLE ppcp.fproducao_seda (
	turno numeric(38) NULL,
	nome text NULL,
	pedido numeric(9) NULL,
	qtdepecas numeric(38, 10) NULL,
	dataleitura timestamp NULL
);

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