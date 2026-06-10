------------------------------------------------------------
-- fvendas_lojas_porhora
------------------------------------------------------------
with transacoes as (
    SELECT 
        REPLACE(REPLACE(REPLACE(fmovi.cnpj_emp,'.',''),'/',''),'-','') as cnpj,
        fmovi.data_lancamento,
        cast(fmovi.hora_lancamento as time) as hora_lancamento,
        fmovi.cod_vendedor,
        fmovi.cod_vendedor || '-' || fmovi.loja as cod_vendedor_portal,   -- << || no lugar de concat
        fmovi.numnf,
        fmovi.operacao,
        CASE 
            WHEN fmovi.operacao = 'DS' THEN fmovi.qtde * -1 
            ELSE fmovi.qtde
        END AS quantidade_liquida,
        CASE 
            WHEN fmovi.operacao = 'DS' THEN fmovi.valor_liquido * -1 
            ELSE fmovi.valor_liquido
        END AS valor_liquido,
        fmovi.desconto,
        fmovi.doc_cliente 
    FROM jma.fmovimentosinteg AS fmovi
    WHERE
        fmovi.cancelado = 'N' AND 
        (
            (fmovi.operacao = 'S' AND fmovi.tipo_transacao = 'V' AND fmovi.considerarvenda = 'S')  
            OR  
            (fmovi.operacao = 'DS' AND fmovi.tipo_transacao = 'E')
        ) 
        and fmovi.data_lancamento >= date_trunc('year', current_date)
        and fmovi.data_lancamento < date_trunc('year', current_date) + interval '1 year'
        AND fmovi.fk_produto NOT LIKE 'M53%'
        AND fmovi.cod_vendedor NOT IN (2546, 4953)
)
select
    date_trunc('day', mov.data_lancamento),
    EXTRACT(HOUR FROM mov.hora_lancamento) as hora_lancamento,
    mov.cod_vendedor,
    func.cpf_vendedor,
    func.nome_vendedor,
    count(distinct case 
            when mov.operacao = 'S' 
            then mov.numnf || '-' || mov.data_lancamento     -- << || no lugar de concat
          end) as num_vendas,
    sum(mov.quantidade_liquida) as pecas_vendidas,
    sum(mov.valor_liquido) as valor_vendido
from transacoes mov
    inner join live.dlojas loj
        on mov.cnpj = loj.pk_cnpj
    inner join jma.dfuncionariosinteg func
        on mov.cod_vendedor = func.cod_vendedor
where 1=1 
    and mov.data_lancamento >= date_trunc('year', current_date)
    and mov.data_lancamento < date_trunc('year', current_date) + interval '1 year'
group by
    mov.data_lancamento,
    EXTRACT(HOUR FROM mov.hora_lancamento),
    mov.cod_vendedor,
    func.cpf_vendedor,
    func.nome_vendedor;