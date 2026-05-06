-- Schema: expedicao
-- Tabelas: 6

CREATE TABLE expedicao.dondas_pwt (
	id_onda int4 NULL,
	descricao_onda text NULL,
	situacao_onda varchar(20) NULL,
	qtd_coletar_item numeric(15, 2) NULL,
	qtd_coletada_item numeric(15, 2) NULL,
	qtd_pedido numeric(15, 3) NULL,
	ultima_atualizacao timestamp NULL
);

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

CREATE TABLE expedicao.fondas_por_usuario (
	id_usuario int4 NULL,
	usuario varchar(100) NULL,
	data_onda date NULL,
	id_onda int4 NULL,
	qtdeitens int4 NULL,
	ultima_atualizacao timestamp NULL,
	id varchar(10) NULL
);

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