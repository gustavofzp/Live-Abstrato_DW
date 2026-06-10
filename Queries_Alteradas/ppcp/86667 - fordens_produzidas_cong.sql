----------------------------------------------------------------
-- ppcp.fordens_produzidas_cong
----------------------------------------------------------------
WITH PRODUZIDO AS (
    SELECT
        PRODUCAO.ordem_producao
    FROM SYSTEXTIL.PCPC_040 PRODUCAO  
        LEFT JOIN SYSTEXTIL.pcpc_045 TEMPO
            ON  TEMPO.PCPC040_PERCONF = PRODUCAO.PERIODO_PRODUCAO
            AND TEMPO.PCPC040_ORDCONF = PRODUCAO.ordem_confeccao
            AND TEMPO.PCPC040_ESTCONF = PRODUCAO.codigo_estagio
    WHERE 1=1
        AND TEMPO.DATA_PRODUCAO = trunc(sysdate)
        AND PRODUCAO.codigo_estagio IN (1,2,80,90,3,4,5,85)
)
SELECT
    PRODUCAO.ordem_producao,   
    PRODUCAO.periodo_producao AS Periodo_Producao,
    CON.periodo_producao AS Periodo_Capa,
    PRODUCAO.ordem_confeccao AS Ordem_confeccao,
    PRODUCAO.PROCONF_GRUPO || '_' || PRODUCAO.PROCONF_ITEM AS REF_COR,
    PRODUCAO.codigo_estagio,
    TEMPO.DATA_PRODUCAO AS DATA_PRODUCAO,
    PRODUCAO.estagio_anterior AS Estagio_Anterior,
    TEMPO.qtde_produzida AS Qtd_Pecas_Produzida,
    PRODUCAO.qtde_em_producao_pacote AS Qtd_Em_Producao_Pacote,
    CASE TEMPO.TURNO_PRODUCAO
        WHEN 1 THEN 'Primeiro'
        WHEN 2 THEN 'Segundo'
        WHEN 3 THEN 'Terceiro'
        WHEN 4 THEN 'Normal'
        ELSE 'Sem Turno'
    END AS TURNO,
    sysdate as ultima_atualizacao
FROM SYSTEXTIL.PCPC_020 CON
    INNER JOIN SYSTEXTIL.PCPC_040 PRODUCAO  
        ON  CON.ORDEM_PRODUCAO = PRODUCAO.ORDEM_PRODUCAO
    INNER JOIN SYSTEXTIL.pcpc_045 TEMPO
        ON  TEMPO.PCPC040_PERCONF = PRODUCAO.PERIODO_PRODUCAO
        AND TEMPO.PCPC040_ORDCONF = PRODUCAO.ordem_confeccao
        AND TEMPO.PCPC040_ESTCONF = PRODUCAO.codigo_estagio
    INNER JOIN PRODUZIDO PR
        ON PR.ORDEM_PRODUCAO = PRODUCAO.ordem_producao
GROUP BY
    PRODUCAO.ordem_producao,   
    PRODUCAO.periodo_producao,
    CON.periodo_producao,
    PRODUCAO.ordem_confeccao,
    PRODUCAO.PROCONF_GRUPO || '_' || PRODUCAO.PROCONF_ITEM,
    PRODUCAO.codigo_estagio,
    TEMPO.DATA_PRODUCAO,
    PRODUCAO.estagio_anterior,
    TEMPO.qtde_produzida,
    PRODUCAO.qtde_em_producao_pacote,
    TEMPO.TURNO_PRODUCAO;