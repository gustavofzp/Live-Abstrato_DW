---------------------------------------------------------------------------------
-- rh_sci.fprov_bruto_colab
---------------------------------------------------------------------------------
SELECT
    func.NUMEMP || '-' || func.NUMCAD || '-' || func.TIPCOL AS fk_funcionario,
    func.NOMFUN AS nome_funcionario,
    func.TIPCON || '-' || func.CODCAR AS fk_CARGO,
    SITUACAO.TipSit AS TipoSituacao,
    SITUACAO.DesSit AS Desc_Situacao,
    CCUSTO.CODLOC AS CENTRO_CUSTO,
    verba.numemp AS COD_EMPRESA,  
    verba.numcad AS NUM_CADASTRO,
    TO_NUMBER(to_char(tabcalc.inicmp, 'YYYY')) AS ANO, 
    TO_NUMBER(to_char(tabcalc.inicmp, 'MM')) AS MES,
    evcalc.CODEVE AS codigo_evento,
    evcalc.DESEVE AS desc_evento,
    verba.valeve AS VAL_EVENTO,
    sysdate as ultima_atualizacao
FROM VETORH.r046ver verba
    INNER JOIN VETORH.r008evc evcalc 
        ON  verba.tabeve = evcalc.codtab 
        AND verba.codeve = evcalc.codeve
    INNER JOIN VETORH.r044cal tabcalc 
        ON  verba.numemp   = tabcalc.numemp 
        AND tabcalc.codcal = verba.codcal
    INNER JOIN VETORH.R034FUN func
        on  verba.NUMEMP = func.NUMEMP
        AND verba.NUMCAD = func.NUMCAD
    INNER JOIN VETORH.R038HLO CCUSTO_HIST 
    ON CCUSTO_HIST.TIPCOL = FUNC.TIPCOL
    AND CCUSTO_HIST.NUMEMP = FUNC.NUMEMP
    AND CCUSTO_HIST.NUMCAD = FUNC.NUMCAD
    AND CCUSTO_HIST.DATALT = (
        SELECT MAX(DATALT) 
        FROM VETORH.R038HLO TAB 
        WHERE TAB.NUMEMP = CCUSTO_HIST.NUMEMP
            AND TAB.TIPCOL = CCUSTO_HIST.TIPCOL
            AND TAB.NUMCAD = CCUSTO_HIST.NUMCAD
            AND TAB.DATALT <= TABCALC.FIMCMP
    )
    -- E o relacionamento da tabela R016HIE deve ser feito com a R038HLO, 
    -- não sendo necessário relacionar as datas de inicio e fim, apenas tabela e local.
    INNER JOIN VETORH.R016HIE CCUSTO
        ON CCUSTO_HIST.TABORG = CCUSTO.TABORG
        --AND CCUSTO.NUMLOC = FUNC.NUMLOC
    LEFT JOIN VETORH.R010SIT SITUACAO 
        ON func.SITAFA = SITUACAO.CodSit
where 1 = 1
    AND evcalc.CODEVE IN (1,2,4,6,12,14,16,17,56,57,60,64,68,75,319,540,541,163,1007)
    --AND to_char(tabcalc.inicmp, 'YYYY-MM') >= TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -5), 'YYYY-MM')
    AND func.NOMFUN like 'ADRIANE DE MATOS LIMA BEHLING'
GROUP BY
    func.NUMEMP || '-' || func.NUMCAD || '-' || func.TIPCOL,
    func.NOMFUN,
    func.TIPCON || '-' || func.CODCAR,
    SITUACAO.TipSit,
    SITUACAO.DesSit,
    CCUSTO.CODLOC,
    verba.numemp, 
    verba.numcad,
    tabcalc.inicmp,
    TO_NUMBER(to_char(tabcalc.inicmp, 'YYYY')),
    TO_NUMBER(to_char(tabcalc.inicmp, 'MM')),
    evcalc.CODEVE,
    evcalc.DESEVE,
    verba.valeve
ORDER BY tabcalc.inicmp DESC;