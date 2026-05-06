-- Schema: estoque
-- Tabelas: 12

CREATE TABLE estoque.dtipo_movimentacaoestoque (
	codigo_transacao numeric(3) NULL,
	descricao text NULL,
	tipo_transacao text NULL
);

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

CREATE TABLE estoque.fentrada_op_estoque (
	data_movimento timestamp NULL,
	sku varchar(20) NULL,
	ordem_producao varchar(10) NULL,
	quantidade_entrada int8 NULL,
	valor_monetario_entrada numeric(18, 3) NULL
);

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

CREATE TABLE estoque.freserva_estoque (
	nivel_estrutura text NULL,
	grupo_estrutura text NULL,
	subgru_estrutura text NULL,
	item_estrutura text NULL,
	ordem_producao numeric(9) NULL,
	codigo_estagio numeric(5) NULL,
	quantidade_reservada numeric(38, 10) NULL
);

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