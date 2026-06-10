--------------------------------------------------
-- fSaldoEstoqueAtual
--------------------------------------------------
SELECT
	dep.LOCAL_DEPOSITO AS CD_EMPRESA,
	est.DEPOSITO AS CD_DEPOSITO,
	est.CDITEM_NIVEL99 AS CD_NIVEL_ESTRUTURA,
	est.CDITEM_GRUPO || '-' || est.CDITEM_SUBGRUPO || '-' || est.CDITEM_ITEM || '-' || est.CDITEM_NIVEL99 AS FK_PRODUTO,
	TO_DATE(TO_CHAR(est.DATA_ULT_ENTRADA, 'dd/mm/yyyy'), 'dd/mm/yyyy') AS DT_ULT_ENTRADA,
	TO_DATE(TO_CHAR(est.DATA_ULT_SAIDA, 'dd/mm/yyyy'), 'dd/mm/yyyy') AS DT_ULT_SAIDA,
	est.qtde_empenhada AS QTD_EMPENHADA,
	est.QTDE_ESTOQUE_ATU AS QTD_EST_ATUAL,
	est.qtde_estoque_atu - est.qtde_empenhada AS QTD_DISPONIVEL,
	est.Qtde_Sugerida AS QTD_SUGERIDA,
	estprod.PRECO_MEDIO * est.QTDE_ESTOQUE_ATU AS VALOR_EM_ESTOQUE,
	estprod.CODIGO_BARRAS,
	SYSDATE AS ULTIMA_ATUALIZACAO
FROM systextil.ESTQ_040 est
	LEFT JOIN systextil.BASI_205 dep
		ON est.DEPOSITO = dep.CODIGO_DEPOSITO
	LEFT JOIN systextil.BASI_010 estprod
		ON estprod.NIVEL_ESTRUTURA = est.CDITEM_NIVEL99
		AND estprod.GRUPO_ESTRUTURA = est.CDITEM_GRUPO
		AND estprod.SUBGRU_ESTRUTURA = est.CDITEM_SUBGRUPO
		AND estprod.ITEM_ESTRUTURA = est.CDITEM_ITEM
WHERE 1=1
	AND est.qtde_estoque_atu <> 0
	AND to_number(TO_CHAR(est.DATA_ULT_ENTRADA, 'YYYY')) >= 
		CASE
			WHEN est.DEPOSITO = 999 THEN to_number(TO_CHAR(SYSDATE, 'YYYY'))
			ELSE to_number(TO_CHAR(SYSDATE, 'YYYY') - 2)
		END;