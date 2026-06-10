---------------------------------------------------------------------------------
-- rh_sci.fprov_bruto_colab
---------------------------------------------------------------------------------
SELECT
    func.numemp || '-' || func.numcad || '-' || func.tipcol as id_funcionario, 
    func.tipcon || '-' || func.codcar                       as id_cargo,
    situacao.tipsit                                         as tipo_situacao,
    situacao.dessit                                         as desc_situacao,
    ccusto.codloc                                           as centro_custo, 
    TO_NUMBER(
        SUBSTR(ccusto.codloc,INSTR(ccusto.codloc, '.', -1) + 1)
    )                                                       AS cod_ccusto,
    verba.numemp                                            as cod_empresa,  
    verba.numcad                                            as num_cadastro, 
    EXTRACT(YEAR FROM tabcalc.inicmp)                       AS ano,
    EXTRACT(MONTH FROM tabcalc.inicmp)                      AS mes,
    'proventos'                                             as tipo, 
    sum(verba.valeve)                                       as val_evento
    --sysdate                                                 as ultima_atualizacao
FROM vetorh.r046ver verba
    INNER JOIN VETORH.r008evc evcalc 
        ON  verba.tabeve = evcalc.codtab 
        AND verba.codeve = evcalc.codeve
    INNER JOIN vetorh.r044cal tabcalc 
        ON  verba.numemp   = tabcalc.numemp 
        AND tabcalc.codcal = verba.codcal
    INNER JOIN vetorh.R034FUN func
        on  verba.NUMEMP = func.NUMEMP
        AND verba.NUMCAD = func.NUMCAD
    INNER JOIN vetorh.R016HIE CCUSTO
        ON CCUSTO.NUMLOC = FUNC.NUMLOC
    LEFT JOIN vetorh.R010SIT SITUACAO 
        ON func.SITAFA = SITUACAO.CodSit
where 1 = 1
    AND ( SITUACAO.TipSit <> 7 
        OR (SITUACAO.TipSit = 7
            AND ( to_char(tabcalc.inicmp, 'YYYY') || '-' || to_char(tabcalc.inicmp, 'MM') = TO_CHAR(func.DATAFA, 'YYYY-MM') )
        )
    )
    AND evcalc.CODEVE IN (1,2,4,6,12,14,16,17,56,57,60,64,68,70,540,541,163,198,70,1007)
    --AND evcalc.CODEVE IN (1,2,4,6,12,14,16,17,18,26,27,28,29,32,34,35,53,56,57,60,64,65,68,70,163,198,268,475,483,507,540,541,1007,1142)
    AND func.TIPCOL = 1
    AND to_char(tabcalc.inicmp, 'YYYY-MM') >= TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1), 'YYYY-MM')
GROUP BY
    func.numemp || '-' || func.numcad || '-' || func.tipcol,
    func.tipcon || '-' || func.codcar,
    situacao.tipsit,
    situacao.dessit,
    ccusto.codloc,
    TO_NUMBER(SUBSTR(ccusto.codloc,INSTR(ccusto.codloc, '.', -1) + 1)),
    verba.numemp,
    verba.numcad,
    EXTRACT(YEAR FROM tabcalc.inicmp),
    EXTRACT(MONTH FROM tabcalc.inicmp);