-- Schema: sustentabilidade
-- Tabelas: 5

CREATE TABLE sustentabilidade.fconsumo_energia (
	data_hora timestamp NULL,
	ativo_consumido numeric NULL,
	ativo_fornecido numeric NULL,
	reativo numeric NULL,
	periodo text NULL,
	hora_cheia bool NULL,
	consumo_hora_cheia numeric NULL
);

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