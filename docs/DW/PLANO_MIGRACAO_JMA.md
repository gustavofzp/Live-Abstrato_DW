# Plano de Migração — Schema `jma`

> Objetivo: eliminar o schema `jma` por completo, redistribuindo ou descartando cada tabela.
>
> **Ações possíveis:**
> - `MOVER → <schema>` — tabela será recriada em outro schema (com renomeação conforme BOAS_PRATICAS_DW.md)
> - `AJUSTAR` — tabela permanece temporariamente, mas precisa de correção antes de mover
> - `DELETAR` — tabela será descontinuada (dados obsoletos, duplicata, ou sem uso)
> - `AVALIAR` — decisão pendente, requer análise de uso

---

## Dimensões (d_*)

| Tabela atual (`jma.*`) | Tipo | Ação | Destino / Observação |
|------------------------|------|------|----------------------|
| `dcanaldistribuicao` | Dimensão | | Duplicata de `live.dcanaldistribuicao` |
| `dcentro_custo` | Dimensão | | Duplicata de `live.dcad_centro_custo` |
| `dcontas_estoque` | Dimensão | | |
| `ddeposito` | Dimensão | | |
| `dfamilia_materiais` | Dimensão | | |
| `dfuncionariosinteg` | Dimensão | | Integração externa — avaliar se duplica `rh.dfuncionario` |
| `dgrupo_contas` | Dimensão | | |
| `dhistorico_contabil` | Dimensão | | |
| `dmotivo_bloqueio` | Dimensão | | |
| `dmotivo_cancelamento` | Dimensão | | |
| `dnatureza_operacao` | Dimensão | | |
| `dparadasmaquinas_marft` | Dimensão | | Relacionada a MARFT (terceirizado) |
| `dperiodo_producao` | Dimensão | | Duplicata potencial de `ppcp` |
| `dprodutoproducao` | Dimensão | | Possível consolidação com `live.dproduto` |
| `dsituacao_venda` | Dimensão | | |
| `dsituacaopedido` | Dimensão | | |
| `dstatus_pedido` | Dimensão | | |
| `dtabelapreco` | Dimensão | | |
| `daparelho` | Dimensão | | |

---

## Fatos e Operacionais (f_* / outros)

| Tabela atual (`jma.*`) | Tipo | Ação | Destino / Observação |
|------------------------|------|------|----------------------|
| `confer_caixas` | Operacional | | Sem prefixo — verificar uso |
| `fconfer_caixas` | Fato | | |
| `fconfer_pecas_caixa` | Fato | | |
| `fconsignadainteg` | Fato | | Integração — verificar fonte |
| `fcontrole_partes` | Fato | | |
| `fdre_lojas` | Fato | | |
| `fdre_orcado_lojas` | Fato | | |
| `feficiencia_prod_marft` | Fato | | MARFT |
| `feficiencia_prod_operador_marft` | Fato | | MARFT |
| `festrutura_produto` | Fato | | |
| `ffaixas_comissao` | Fato | | |
| `ffaixas_comissao_omnichannel` | Fato | | |
| `ffaturamento` | Fato | | Principal fato de faturamento |
| `ffaturamento_dev` | Fato | | Devoluções |
| `ffaturamento_dev_inc` | Fato | | ⚠️ CRÍTICO: colunas UPPER_CASE com aspas — requer ajuste antes de mover |
| `ffaturamento_eua` | Fato | | ⚠️ Colunas SUM() calculadas — requer ajuste |
| `ffaturamento_internacional` | Fato | | |
| `ffaturamento_nacional` | Fato | | |
| `fhists_mov_` | Fato | | Nome inválido (termina com `_`) |
| `finspecao_qualidade` | Fato | | Duplicata potencial de `ppcp.finspecao_qualidade` |
| `flog_itens_transfer` | Fato | | |
| `flogpedidos` | Fato | | |
| `fmeta_diario_loja` | Fato | | |
| `fmeta_loja` | Fato | | |
| `fmeta_mensal_loja` | Fato | | |
| `fmeta_semanal_loja` | Fato | | |
| `fmetasestacoes` | Fato | | |
| `fmetasorcamento` | Fato | | |
| `fmonitor_producao` | Fato | | |
| `fmovimentacoesestoque` | Fato | | |
| `fmovimentos_loja` | Fato | | Principal fato de movimentações de loja |
| `fmovimentosinteg` | Fato | | Integração externa |
| `fmovimentoslojamicrovix` | Fato | | Fonte Microvix |
| `fordens_corte_congelado` | Fato | | Duplicata potencial de `ppcp.fordens_corte` |
| `fparametro_compra` | Fato | | |
| `fpedido_congelado` | Fato | | |
| `fpedidos_compra` | Fato | | |
| `fpedidos_embarque_previsto` | Fato | | |
| `fpedidos_url` | Fato | | |
| `fportal_lojas` | Fato | | |
| `fprioridade_beneficiamento_conge` | Fato | | |
| `fprioridade_tecelagem_conge` | Fato | | |
| `fprod_marft` | Fato | | MARFT |
| `freq_almoxarifado` | Fato | | |
| `frequisicoes_compra` | Fato | | Duplicata potencial de `suprimentos.frequisicoes_compra` |
| `froteiro` | Fato | | Duplicata potencial de `ppcp.froteiro` |
| `froteiro_em_producao` | Fato | | |
| `ftabelapreco` | Fato | | |
| `ftempo_metodos` | Fato | | |
| `ftitulos_receber` | Fato | | |
| `fvendas_url` | Fato | | |
| `ped_cong_motivo_bloqueio` | Operacional | | Sem prefixo `f_` — verificar uso |

---

## Resumo

| Categoria | Total |
|-----------|-------|
| Dimensões | 19 |
| Fatos / Operacionais | 52 |
| **Total** | **71** |

---

*Última atualização: 2026-05-06*
