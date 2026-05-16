# Conflitos e Decisões Pendentes — DW Live (Fase 2)

Atualizado em: 2026-05-06
Schemas processados: api, comercial, jma, live, ppcp, rh, stage, suprimentos, ti
Schemas pendentes: estoque, eventos, financeiro, homologacao, marft, rh_sci, sustentabilidade, temporario

> **Como usar:** Preencha o campo `Decisão:` de cada item antes de executar o plano de migração correspondente.
> Os IDs `DEC-xxx` do arquivo anterior foram mantidos para rastreabilidade. Novos itens recebem IDs sequenciais a partir de DEC-021.

---

## 🔴 Críticos (bloqueiam ETL ou causam perda de dados)

| # | ID | Schema | Tabela | Conflito | Decisão Sugerida | Status |
|---|---|--------|--------|----------|-----------------|--------|
| 1 | DEC-021 | jma | `ffaturamento_dev_inc` | **53 colunas em UPPER_CASE com aspas duplas** (`"PK_CLIENTE"`, `"DATA"`, etc.) — incompatível com qualquer query sem aspas; `numeric(38,10)` em todos os campos numéricos | Renomear todas as colunas para snake_case; reclassificar como `stg_faturamento_dev_inc`; reduzir tipos numéricos | ⏳ Pendente |
| 2 | DEC-022 | jma | `ffaturamento_eua` | **Colunas com nomes de funções SQL** (`"SUM(DADOS.QUANTIDADE)"`, `"SUM(DADOS.VALORDOLAR)"`) — nomes inválidos como identificadores de coluna | Renomear para `qt_quantidade` e `vl_valor_dolar` imediatamente | ⏳ Pendente |
| 3 | DEC-023 | suprimentos | `dfornecedor_produto` | **`"código produto"` e `"descrição"` com acento e espaço no nome** — impossível referenciar sem aspas duplas em todo e qualquer SQL | Renomear para `cod_produto` e `ds_descricao` via ALTER TABLE; prioridade máxima | ⏳ Pendente |
| 4 | DEC-024 | ppcp | `dcadastro_fornecedores`, `dhomologacao_fornecedores`, `dinfotec_fornecedores` | **`cnpj_forn varchar(184)`** — CNPJ com 184 caracteres; dados claramente malformados/corrompidos | Verificar dados reais; reformatar via `dw.fn_formatar_cnpj_cpf`; alterar para `varchar(16)` | ⏳ Pendente |
| 5 | DEC-007 | comercial, jma | `drepresentante`, `ffaturamento_dev_inc` | **CNPJ/CPF como `int8` ou `numeric`** — IN RFB 2.229/2024 permite CNPJ alfanumérico; dados existentes podem ser corrompidos na conversão | Opção B: criar coluna `cnpj_*_str varchar(16)` em paralelo; migrar pipeline; dropar a antiga | ⏳ Pendente |

---

## ⚠️ Alta Prioridade (afetam qualidade/consistência)

| # | ID | Schema | Tabela | Conflito | Decisão Sugerida | Status |
|---|---|--------|--------|----------|-----------------|--------|
| 6 | DEC-001 | jma, comercial | (schema inteiro) | **Schema `jma` — permanente ou temporário?** 71 tabelas com dimensões e fatos que parecem pertencer a `comercial` | Opção B: migrar tudo para `comercial` em 90 dias com views de compatibilidade | ⏳ Pendente |
| 7 | DEC-003 | comercial, jma, financeiro | `fpedido`, `ffaturamento_dev_inc`, `ftitulos_receber` | **`cod_cliente` com tipos inconsistentes**: `varchar(16)`, `varchar(20)`, `varchar(25)`, `text` — join entre tipos causa full scan silencioso no PostgreSQL | Executar `SELECT MAX(LENGTH(cod_cliente))` no banco de origem (Senior); padronizar para o tamanho real | ⏳ Pendente |
| 8 | DEC-004 | comercial | `fpedido` | **`fpedido` mistura cabeçalho e item** (`ped_*` e `itemped_*` na mesma tabela) — viola granularidade única de fatos | Opção C: criar `f_pedido_item` nova; deprecar `fpedido` em 180 dias | ⏳ Pendente |
| 9 | DEC-005 | comercial, jma | `fnotas_venda_produtos`, `ffaturamento_dev_inc`, `ffaturamento`, `ffaturamento_dev` | **3–4 tabelas de faturamento em schemas diferentes** — sobreposição desconhecida; risco de dupla contagem | Executar `SELECT COUNT(*), MIN(data), MAX(data)` em cada; comparar chaves antes de consolidar | ⏳ Pendente |
| 10 | DEC-006 | todos | dimensões com `pk_*` | **Business key como PK** em vez de surrogate key `bigserial` — padrão proposto não aplicado em tabelas já populadas | Opção A: adicionar `id bigserial`; manter `pk_` renomeado para `cod_` durante transição | ⏳ Pendente |
| 11 | DEC-009 | ppcp, jma | `fordens_reposicoes`, `fordens_em_producao`, `ftempo_tear` | **Colunas marcadas para DROP** — `ordemreposicaoformatted`, `qtde_programada`, `fk_produto` — irreversível sem confirmação das equipes | Opção B: adicionar comentário `DEPRECATED`; aguardar 90 dias antes de dropar | ⏳ Pendente |
| 12 | DEC-015 | temporario | (schema inteiro) | **Schema `temporario` com 584 tabelas** — maior schema do DW (60% do total); função exata desconhecida | Opção D: auditar uso em produção; depois decidir entre renomear (stg_*) ou migrar para `stage` | ⏳ Pendente |
| 13 | DEC-016 | todos | ~600+ tabelas | **Tabelas sem `updated_at`** — impossível carga incremental por watermark; ETLs provavelmente fazem TRUNCATE+INSERT full | Opção A para tabelas com alto volume; Opção C (carga full) para tabelas < 10k registros | ⏳ Pendente |
| 14 | DEC-017 | live, ppcp, estoque, comercial | `dproduto`, `dtecidos`, fatos de venda | **Identificador de produto divergente entre schemas** — SKU composto Systextil (`nivel.ref.tam.cor`) vs `cod_produto` no Live/Senior | Opção C: criar `d_produto_map (sku_produto, cod_produto_live, cod_produto_senior)` como tabela de bridge | ⏳ Pendente |
| 15 | DEC-025 | comercial | `fpedido` | **`ped_cdrep int4` e `fk_representante varchar(6)`** — duas colunas para o mesmo representante com tipos diferentes na mesma tabela | Consolidar em `cod_representante varchar(6)`; dropar `ped_cdrep` após validação | ⏳ Pendente |
| 16 | DEC-026 | comercial | `fpedido`, `fpedido_showroom` | **`fpedido` vs `fpedido_showroom`** — estrutura idêntica exceto por `showroom_id`; duplicação desnecessária | Consolidar em `f_pedido_item` com coluna `id_showroom nullable` | ⏳ Pendente |
| 17 | DEC-027 | live | `dcliente` | **`cnpj_cliente varchar(120)`** — 7,5x maior que o necessário (16 chars); pode conter CPFs misturados | Verificar dados; reformatar via `dw.fn_formatar_cnpj_cpf`; converter para `varchar(16)` | ⏳ Pendente |
| 18 | DEC-028 | live | `dlojas` | **`pk_cnpj varchar(35)`** — CNPJ com 35 chars, mais que o dobro do necessário | Reformatar e renomear para `cnpj_loja varchar(16)` | ⏳ Pendente |
| 19 | DEC-029 | live | `dproduto` | **`sku_produto varchar(120)`** — deve ser `varchar(30)` conforme padrão da seção 6.1 do BOAS_PRATICAS | Executar `SELECT MAX(LENGTH(sku_produto))` para validar; alterar para `varchar(30)` | ⏳ Pendente |
| 20 | DEC-030 | rh | `fhoras_trabalhadas`, `fponto_sintetico` | **Campos de data fracionados como `numeric(38,10)` ou `float8`** (`dat_dia`, `dat_mes`, `dat_ano_batida`) — tipo absurdo para componentes de data | Converter para `smallint`; derivar da coluna `dth_batida` no ETL | ⏳ Pendente |
| 21 | DEC-031 | rh | múltiplas tabelas | **`qtd_hora`, `qtd_paga`, `saldo_horas` como `varchar(10)`** — Senior armazena horas no formato `HH:MM` como texto; impede cálculos numéricos | Adicionar coluna derivada `nr_horas_min integer` paralela; manter varchar original por 90 dias | ⏳ Pendente |
| 22 | DEC-032 | ppcp | `fordens_corte` | **`cd_nivel99 float8`** — nível do produto como float8; deve ser `varchar(1)` | Converter no ETL antes de inserir; alterar coluna para `varchar(1)` | ⏳ Pendente |
| 23 | DEC-033 | ppcp | `fordens_produzidas` | **`cd_ordem_producao text`** — tipo text para número de OP; deve ser `integer` | Verificar se há dados não numéricos; converter para `integer` | ⏳ Pendente |
| 24 | DEC-034 | ppcp | `fproducao_seda` | **`turno numeric(38)`** — tipo absurdo para número de turno (0–3); deve ser `smallint` | Alterar para `smallint` | ⏳ Pendente |
| 25 | DEC-035 | ppcp | múltiplas tabelas de fato | **`fk_produto` com tamanhos inconsistentes** (`varchar(125)`, `varchar(150)`, `varchar(35)`) — mesma entidade produto com tamanhos diferentes | Padronizar para `sku_produto varchar(30)` em todas as tabelas do schema | ⏳ Pendente |
| 26 | DEC-036 | api | `vitrine_indicators_stores` | **`date_start`, `date_end`, `executiondate` como `varchar(50)`** — campos de data armazenados como texto; prejudica filtros e ordenação | ETL deve converter para `date` antes de inserir; alterar tipo da coluna | ⏳ Pendente |
| 27 | DEC-037 | suprimentos | múltiplas tabelas | **Colunas de data como `text`** em `d_lancamento_produto`, `d_lancamento_servico` e outras — mesmo problema que api; ETL deve normalizar | Converter para `date`/`timestamp` no ETL; alterar tipo das colunas | ⏳ Pendente |
| 28 | DEC-038 | jma | `fhists_mov_` (atual) | **Typo no nome da tabela** `fhists_mov_` (trailing underscore + typo) — nome proposto `f_historico_movimentacao` | Renomear + criar view de compatibilidade | ⏳ Pendente |
| 29 | DEC-039 | jma | `f_controle_partes`, `f_monitor_producao`, `f_movimentos_loja_microvix`, `f_requisicao_compra`, `f_pedido_congelado_motivo_bloqueio` | **5 tabelas sem `created_at`/`updated_at`** — auditoria ausente; impossível rastrear alterações ou fazer carga incremental | Adicionar colunas de auditoria via ALTER TABLE; preencher com timestamp da migração | ⏳ Pendente |
| 30 | DEC-040 | rh | `freajuste` | **`ultima_atualizacao date`** em vez de `timestamp` — único campo de auditoria sem hora; perda de granularidade temporal | Alterar para `timestamp DEFAULT current_timestamp` | ⏳ Pendente |
| 31 | DEC-041 | rh | `dfuncionario` | **`cpf varchar(11)` sem formatação** — CPF deve seguir formato `XXX.XXX.XXX-ZZ varchar(14)` ou ao menos ser processável via `dw.fn_formatar_cnpj_cpf` | Reformatar via função DW; alterar para `varchar(14)` | ⏳ Pendente |

---

## ℹ️ Média Prioridade (melhorias desejáveis)

| # | ID | Schema | Tabela | Conflito | Decisão Sugerida | Status |
|---|---|--------|--------|----------|-----------------|--------|
| 32 | DEC-002 | api, eventos | múltiplas | **Idioma das colunas** — `api` usa inglês (payload da API); `eventos` mistura idiomas | Manter inglês em `api` (rastreabilidade); converter `eventos` para português | ⏳ Pendente |
| 33 | DEC-008 | ppcp | `fmaquinas_divisao_externa` | **`maquina` sem prefixo** — join key (`cod_maquina`) ou código operacional (`id_maquina`)? | Verificar se há `JOIN ppcp.dmaquina ON maquina = ...` nas DAGs; se sim: `cod_maquina` | ⏳ Pendente |
| 34 | DEC-010 | ppcp | CSV de mapeamento | **Linha 207 sem tabela de origem** — `desc_empresa → nome_empresa` sem identificação da tabela destino | Verificar `information_schema.columns` para `ppcp.%` com coluna `desc_empresa` | ⏳ Pendente |
| 35 | DEC-011 | ppcp | `fsugestao_reserva_tecido` | **`fk_componente` — existe `d_componente`?** Se sim: `cod_componente`; se não: `id_componente` | Verificar `information_schema.tables WHERE table_name LIKE '%componente%'` | ⏳ Pendente |
| 36 | DEC-012 | ppcp | `fsugestao_cancelamento` | **`sugcancelproducao` — tipo semântico indefinido** — booleano, quantidade ou código? | Verificar tipo atual e semântica de negócio com equipe PPCP | ⏳ Pendente |
| 37 | DEC-013 | ppcp | `flista_prioridades` | **`faccao` — existe `d_faccao`?** Se sim: `cod_faccao`; se não: `id_faccao` | Verificar `information_schema.tables WHERE table_name LIKE '%faccao%'` | ⏳ Pendente |
| 38 | DEC-014 | jma, financeiro | `ddeposito`, `ftitulos_*` | **Tipo canônico de `cod_portador` indefinido** — `varchar(n)` (código bancário) ou `smallint` (código interno)? | Verificar tipo em `jma.ddeposito` e sistema de origem (Senior/bancário) | ⏳ Pendente |
| 39 | DEC-018 | jma | `confer_caixas`, `ped_cong_motivo_bloqueio` | **Tabelas sem prefixo de tipo** (`d_` ou `f_`) — função não classificada | Revisar semântica de cada tabela e aplicar prefixo correto | ⏳ Pendente |
| 40 | DEC-019 | todos | dimensões com `d_` | **SCD Tipo 2 para quais dimensões?** Nenhuma tem histórico; candidatas: `d_cliente`, `d_representante`, `d_produto` | Levantamento com equipe de BI: quais análises precisam de "estado na data da venda"? | ⏳ Pendente |
| 41 | DEC-020 | todos | — | **Ordem de carga para full load inicial** — dependências entre schemas não documentadas | Produzir grafo de dependências antes de executar migrações com TRUNCATE+RELOAD | ⏳ Pendente |
| 42 | DEC-042 | suprimentos | `f_compra_bi` | **`f_compra_bi` como tabela materializada** — pode ser view sobre `f_obc_sdcv_detalhe`? | Avaliar custo de manutenção vs benefício de materialização | ⏳ Pendente |
| 43 | DEC-043 | stage | `stg_movimento_loja_full` | **`stg_movimento_loja_full` vs `stg_movimento_loja`** — avaliar consolidação via flag `fl_full_load` | Analisar diferenças de schema; consolidar se idênticas | ⏳ Pendente |
| 44 | DEC-044 | rh | (schema inteiro) | **Mix de sistemas Employer vs Senior no mesmo schema** — dificulta rastreabilidade de origem | Considerar prefixos `d_*_senior` / `f_*_employer` ou sub-namespaces | ⏳ Pendente |
| 45 | DEC-045 | rh | `dfuncionario` e relacionadas | **Business key de colaborador muito longo** — `pk_funcionario varchar(122)` (empresa+tipo+cadastro concatenados) — dificulta joins | Definir `cod_colaborador varchar(20)` baseado em `cd_funcionario` | ⏳ Pendente |
| 46 | DEC-046 | jma | `d_produto_producao`, `f_faturamento` | **`numeric(38,10)` em múltiplos campos numéricos** — precisão absurda; causa desperdício de armazenamento e lentidão | Mapear todos os campos; reduzir para tipos semânticos (`numeric(15,3)`, `numeric(15,2)`, `smallint`) | ⏳ Pendente |
| 47 | DEC-047 | jma | `f_faturamento` | **`nf_cdrep float8`** — código de representante como ponto flutuante; deve ser `cod_representante varchar(6)` | Converter com `LPAD(nf_cdrep::integer::text, 6, '0')` após validação | ⏳ Pendente |
| 48 | DEC-048 | api | múltiplas tabelas Altervision | **`cod_loja` x `id_loja_api`** — `store`/`loja` pode ser código interno ou ID da API; não confirmado se equivale a `live.dlojas.pk_loja` | Confirmar com equipe de TI/dados se os valores são os mesmos | ⏳ Pendente |
| 49 | DEC-049 | jma | `f_tempo_metodo` | **`varchar` sem tamanho** nas colunas `tempo_homem` e `tempo_maquina` — tipo semanticamente incorreto; provavelmente `numeric(10,4)` | Investigar valores reais; converter para `numeric` | ⏳ Pendente |
| 50 | DEC-050 | ti | `fdemandas` (projetos) | **`id` e `cod_projeto` aparentemente com mesmo valor** — duplicação de coluna? | Verificar `SELECT id, cod_projeto FROM ti.fdemandas WHERE id <> cod_projeto LIMIT 10` | ⏳ Pendente |
| 51 | DEC-051 | stage | todas as tabelas `stg_*` | **Ausência de colunas de auditoria padronizadas** nas tabelas staging (`stg_*`) — sem `created_at`/`updated_at`/`dw_load_ts` | Adicionar `dw_load_ts timestamp DEFAULT current_timestamp` em todas as tabelas stg_* | ⏳ Pendente |
| 52 | DEC-052 | comercial | `fmeta_representante_orion`, `fmeta_representante` | **Duas tabelas de metas por representante** — possivelmente mesma fonte com origens diferentes (Orion vs sistema base) | Verificar `COUNT(*), MIN(data), MAX(data)` em ambas; consolidar em `f_meta_representante` com coluna `ds_origem` | ⏳ Pendente |
| 53 | DEC-053 | comercial | `fnotas_venda_produtos` | **`cod_representante int4`** — código de representante como inteiro; padrão do DW exige `varchar(6)` (LPAD com zeros à esquerda) | Converter para `varchar(6)` via `LPAD(cod_representante::text, 6, '0')` | ⏳ Pendente |
| 54 | DEC-054 | ppcp | `flista_prioridades` | **`id float8`** — chave primária como ponto flutuante; precisão indeterminada e arriscada | Converter para `integer` ou `bigint`; revisar pipeline de carga | ⏳ Pendente |
| 55 | DEC-055 | suprimentos | `fprojeto_obc` | **Colunas com espaço no nome** — impossível referenciar sem aspas duplas em SQL; viola padrão snake_case | Renomear todas as colunas via `ALTER TABLE ... RENAME COLUMN`; prioridade alta | ⏳ Pendente |
| 56 | DEC-056 | ti | `forus_resumo_sprint` | **3 colunas com espaço no nome** — impossível usar em queries sem aspas duplas | Renomear via `ALTER TABLE ... RENAME COLUMN` para snake_case | ⏳ Pendente |
| 57 | DEC-057 | jma | `fmeta_diario_loja`, `fmeta_semanal_loja`, `fmeta_mensal_loja`, `fmeta_loja` | **4 tabelas de metas com granularidades diferentes** — duplicação de lógica de cálculo; possíveis discrepâncias entre agregações | Consolidar em `f_meta_loja` com coluna `id_granularidade` (D/S/M); ou definir uma como fonte única e demais como views materializadas | ⏳ Pendente |
| 58 | DEC-058 | jma | `ffaturamento`, `ffaturamento_eua`, `ffaturamento_internacional`, `ffaturamento_nacional`, `ffaturamento_dev`, `ffaturamento_dev_inc` | **6 tabelas de faturamento com escopos diferentes** — risco de dupla contagem ou faturamento perdido entre escopos; sem visão unificada | Criar `f_faturamento` única com coluna `id_escopo` (NACIONAL/INTERNACIONAL/EUA/DEV); manter views por compatibilidade | ⏳ Pendente |
| 59 | DEC-059 | jma | `fmovimentos_loja`, `fmovimentosinteg`, `fmovimentoslojamicrovix` | **3 tabelas de movimentação de loja** — fontes (Systextil, integradores externos, Microvix) sem rastreabilidade clara em coluna `ds_origem` | Consolidar em `f_movimento_loja` com `id_sistema_origem`; manter origens preservadas | ⏳ Pendente |
| 60 | DEC-060 | jma | `dfuncionariosinteg` | **`cod_vendedor int4` sem dimensão `d_vendedor` consolidada** — campo tratado como business key sem dimensão de referência cross-schema | Avaliar elevação de `d_funcionario_integ` para dimensão canônica de vendedor; ou criar bridge `d_vendedor` cross-schema | ⏳ Pendente |
| 61 | DEC-061 | jma | `fpedidos_url`, `fvendas_url` | **Sufixo `_url` ambíguo** — sem documentação de qual é a "URL" referenciada; possivelmente origem ecommerce/site | Padronizar para `_ecommerce` ou `_site`; documentar fonte real dos dados | ⏳ Pendente |
| 62 | DEC-062 | jma | `confer_caixas` (sem prefixo) e `fconfer_caixas` | **Tabela sem prefixo coexiste com versão prefixada** — possível duplicação de carga; finalidade da tabela base sem prefixo desconhecida | Verificar conteúdo de ambas; consolidar em `f_conferencia_caixa`; deprecar a sem prefixo | ⏳ Pendente |
| 63 | DEC-063 | jma | múltiplas dimensões | **`pk_*` reutilizado como business key** em ~14 dimensões (`pk_aparelho`, `pk_grupo_contas`, `pk_historico`, `pk_familia`, `pk_periodo`, etc.) — viola padrão `id` (surrogate) + `cod_/id_` (business key) | Aplicar regra geral DEC-006 ao schema jma; cronograma específico por tabela | ⏳ Pendente |
| 64 | DEC-064 | jma | `dprodutoproducao`, `f_faturamento`, `f_movimento_loja_microvix`, várias tabelas | **`numeric(38,10)` espalhado em 30+ colunas** (legado da carga Oracle sem cast) — desperdício de armazenamento; precisão absurda | Mapear via `information_schema.columns WHERE numeric_precision = 38`; reduzir para tipos semânticos (Script 5.5 do DICIONARIO_DADOS_JMA.md) | ⏳ Pendente |
| 65 | DEC-065 | jma | `dnatureza_operacao`, `dsituacao_venda`, `dstatus_pedido`, `dsituacaopedido` | **4 dimensões de status/situação com escopos sobrepostos** — risco de inconsistência ao classificar pedido vs nota | Consolidar `dsituacaopedido` e `dstatus_pedido`; manter `dnatureza_operacao` separada (escopo fiscal) | ⏳ Pendente |
| 66 | DEC-066 | jma | `dtabelapreco` + `ftabelapreco` | **Mistura de dimensão e fato no mesmo conceito** — `dtabelapreco` é cabeçalho, `ftabelapreco` é item; nome confunde | Renomear para `d_tabela_preco` (cabeçalho) + `f_tabela_preco_item` (já contemplado no dicionário) | ⏳ Pendente |
| 67 | DEC-067 | jma | `dfuncionariosinteg.cnpj varchar(40)` | **CNPJ com 40 chars** — quase 3x maior que o necessário; possível mistura de `nm_loja` no campo | Validar `MAX(LENGTH(cnpj))`; reformatar via `dw.fn_formatar_cnpj_cpf`; renomear para `cnpj_loja varchar(16)` | ⏳ Pendente |
| 68 | DEC-068 | jma | `fdre_lojas`, `fdre_orcado_lojas` | **Realizado vs Orçado em tabelas separadas** — análises comparativas exigem JOIN custoso; possível desnormalização ineficiente | Avaliar consolidação em `f_dre_loja` com coluna `id_tipo` (REAL/ORCADO); ou criar view `vw_dre_realizado_vs_orcado` | ⏳ Pendente |

---

## 🔁 Duplicatas entre Schemas

| # | Tabela A | Tabela B | Overlap | Decisão Sugerida | Status |
|---|----------|----------|---------|-----------------|--------|
| 1 | `jma.dcanaldistribuicao` | `live.dcanaldistribuicao` | Estrutura e dados funcionalmente equivalentes | Deprecar `jma.dcanaldistribuicao`; unificar em `live.d_canal_distribuicao`; criar view em jma | ⏳ Pendente |
| 2 | `jma.dprodutoproducao` | `live.dproduto` | Sobreposição de atributos de produto | Manter `jma.d_produto_producao` como enriquecimento específico de produção; consolidar atributos comuns em `live.d_produto`; adicionar `fl_ativo_producao` | ⏳ Pendente |
| 3 | `ppcp.dcad_centro_custo` | `live.d_centro_custo` | Tabelas quase idênticas de centro de custo | Centralizar em `live.d_centro_custo`; criar view em `ppcp` para compatibilidade | ⏳ Pendente |
| 4 | `rh.fdre_lojas` | `jma.fdre_lojas` | Estrutura idêntica | Manter `jma.fdre_lojas` como tabela principal; criar view em `rh` | ⏳ Pendente |
| 5 | `suprimentos.fnota_entrada` | `suprimentos.fnota_entrada2` | Estrutura similar; dados possivelmente redundantes | Verificar `COUNT(*), MIN(data), MAX(data)` em ambas; se redundante, consolidar em `f_nota_entrada` e deprecar `fnota_entrada2` | ⏳ Pendente |
| 6 | `comercial.fpedido` | `comercial.fpedido_showroom` | Idênticas exceto por `showroom_id` | Consolidar em `f_pedido_item` com `id_showroom nullable` | ⏳ Pendente |
| 7 | `api.vitrine` | `api.vitrine_checklist` / `api.vitrine_questions` | Estrutura muito similar; `vitrine` pode ser view materializada redundante | Verificar se `vitrine` tem dados exclusivos; se não, deprecar e consolidar em `f_vitrine_checklist` | ⏳ Pendente |

---

## 📋 Decisões já tomadas / Encerradas

*(Nenhuma decisão foi oficialmente encerrada na Fase 2. Mover itens para esta seção ao concluir cada decisão.)*

---

## Resumo por Categoria

| Categoria | Qtd | Itens |
|-----------|-----|-------|
| 🔴 Críticos | 5 | DEC-007, DEC-021, DEC-022, DEC-023, DEC-024 |
| ⚠️ Alta Prioridade | 39 | DEC-001, DEC-003–006, DEC-009, DEC-015–016, DEC-025–041, DEC-052–054, DEC-055–056, DEC-057–064 |
| ℹ️ Média Prioridade | 24 | DEC-002, DEC-008, DEC-010–014, DEC-018–020, DEC-042–051, DEC-065–068 |
| 🔁 Duplicatas | 7 | jma/live (canal, produto, cc), rh/jma (fdre), suprimentos (notas), comercial (fpedido), api (vitrine) |
| **Total** | **75** | — |

---

## Detalhamento das Decisões Existentes (DEC-001 a DEC-020)

> As seções abaixo preservam o detalhamento original para consulta. O status consolidado está nas tabelas acima.

---

### DEC-001 — Schema `jma`: permanente ou temporário?

**Categoria:** Escopo | **Prioridade:** Alta

**Onde aparece:** 71 tabelas no schema `jma` com papéis de dimensão e fato que parecem pertencer ao schema `comercial`.

**Opções consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| A. Manter `jma` como schema permanente | Nenhuma DAG quebra imediatamente | Perpetua a confusão de onde está cada dado |
| B. Migrar tudo de `jma` para `comercial` | Schema único de vendas; governança mais clara | Impacto alto: ~40+ DAGs + ~70 tabelas |
| C. Migrar dimensões para `comercial`, manter fatos em `jma` temporariamente | Transição gradual | Período de ambiguidade prolongado |

**Recomendação:** Opção B com cronograma de 90 dias, usando views de compatibilidade.
**Impacto:** ~40+ DAGs afetadas; ~70 tabelas migradas.

**Decisão:** _______________________________________________

---

### DEC-002 — Idioma das colunas em `api` e `eventos`

**Categoria:** Nomenclatura | **Prioridade:** Média

**Onde aparece:** `api` (colunas em inglês do payload da API); `eventos` (mistura de idiomas).

**Recomendação:** Manter inglês em `api` (rastreabilidade com origem); converter `eventos` para português.
**Impacto:** `api`: 17 tabelas documentadas como exceção; `eventos`: ~180 colunas a renomear.

**Decisão:** _______________________________________________

---

### DEC-003 — Tipo canônico de `cod_cliente`: `varchar(20)` ou `varchar(25)`?

**Categoria:** Modelagem / Tipo de dado | **Prioridade:** Alta

**Onde aparece:**
- `comercial.fpedido`: `fk_cliente varchar(20)` / `varchar(25)` (inconsistente internamente)
- `jma.ffaturamento_dev_inc`: `"PK_CLIENTE" text`
- `live.dcliente`: `pk_cliente varchar(16)` → proposto `varchar(20)`

**Recomendação:** Executar `SELECT MAX(LENGTH(cod_cliente)) FROM systextil.clientes` no banco de origem antes de padronizar.
**Impacto:** ALTER TABLE em ~20+ tabelas; cast implícito atual pode gerar full scan.

**Decisão:** _______________________________________________

---

### DEC-004 — `comercial.fpedido` mistura cabeçalho e item — separar?

**Categoria:** Modelagem | **Prioridade:** Alta

**Onde aparece:** `comercial.fpedido` — colunas `ped_*` (cabeçalho) e `itemped_*` (item) na mesma tabela.

**Recomendação:** Opção C — criar `f_pedido_item` nova com granularidade correta; mapear BI para nova tabela antes de deprecar a antiga em 180 dias.
**Impacto:** ~15+ DAGs afetadas; todos os dashboards de pedidos precisam ser atualizados.

**Decisão:** _______________________________________________

---

### DEC-005 — `comercial.fnotas_venda_produtos` e `jma.ffaturamento_dev_inc` são duplicatas?

**Categoria:** Modelagem / Escopo | **Prioridade:** Alta

**Onde aparece:** `comercial.fnotas_venda_produtos`, `jma.ffaturamento_dev_inc`, `jma.ffaturamento`, `jma.ffaturamento_dev` — ao menos 3–4 tabelas de faturamento.

**Recomendação:** Executar `SELECT COUNT(*), MIN(data), MAX(data)` e comparar chaves para verificar sobreposição antes de consolidar.
**Impacto:** Alta — consolidação indevida pode resultar em perda de histórico.

**Decisão:** _______________________________________________

---

### DEC-006 — SK vs NK como PK em dimensões já populadas

**Categoria:** Modelagem | **Prioridade:** Alta

**Onde aparece:** `comercial.drepresentante`, `jma.dcliente`, `jma.dproduto`, `jma.ddeposito` e todos os schemas com dimensões.

**Recomendação:** Opção A — adicionar `id bigserial` sem remover a PK atual; renomear `pk_*` para `cod_*`; cronograma por schema.

**Decisão:** _______________________________________________

---

### DEC-007 — CNPJ/CPF: converter `int8`/`numeric` para `varchar(16)` em tabelas com dados

**Categoria:** Tipo de dado | **Prioridade:** Alta (🔴 Crítico — vide tabela acima)

**Onde aparece:** `comercial.drepresentante.cnpj_repres int8`, possivelmente outras dimensões.

**Recomendação:** Opção B — criar coluna `cnpj_*_str varchar(16)` em paralelo; migrar pipeline; dropar a antiga. IN RFB 2.229/2024 permite CNPJ alfanumérico.
**Impacto:** Parada de DAG durante ALTER; expressão de conversão deve ser validada por tipo de registro (CPF vs CNPJ).

**Decisão:** _______________________________________________

---

### DEC-008 — `maquina` em `ppcp.fmaquinas_divisao_externa`: join key ou operacional?

**Categoria:** Nomenclatura | **Prioridade:** Média

**Recomendação:** Verificar se há queries com `JOIN ppcp.dmaquina ON maquina = ...`. Se sim: `cod_maquina`. Se não: `id_maquina`.

**Decisão:** _______________________________________________

---

### DEC-009 — Colunas marcadas para DROP: confirmar exclusão

**Categoria:** Escopo | **Prioridade:** Alta

**Para cada coluna a ser dropada, confirmar:**
- [ ] `ppcp.fordens_reposicoes.ordemreposicaoformatted` — confirmar com equipe PPCP
- [ ] `ppcp.fordens_em_producao.qtde_programada` — confirmar com equipe PPCP
- [ ] `ppcp.ftempo_tear.fk_produto` — confirmar com equipe de BI

**Recomendação:** Opção B — adicionar comentário `DEPRECATED`; aguardar 90 dias.

**Decisão:** _______________________________________________

---

### DEC-010 — Linha sem tabela no mapeamento ppcp (linha 207 do CSV)

**Categoria:** Escopo | **Prioridade:** Média

**Ação necessária:** `SELECT table_name, column_name FROM information_schema.columns WHERE table_schema = 'ppcp' AND column_name IN ('desc_empresa', 'nome_empresa', 'empresa')`.

**Decisão:** _______________________________________________

---

### DEC-011 — `fk_componente` em `ppcp.fsugestao_reserva_tecido`: há dimensão `d_componente`?

**Recomendação:** `SELECT table_name FROM information_schema.tables WHERE table_schema = 'ppcp' AND table_name LIKE '%componente%'`.

**Decisão:** _______________________________________________

---

### DEC-012 — `sugcancelproducao` em `ppcp.fsugestao_cancelamento`

**Possibilidades:** booleano / quantidade / código. Verificar tipo atual e semântica com equipe PPCP.

**Decisão:** _______________________________________________

---

### DEC-013 — `faccao`: `id_faccao` ou `cod_faccao`? Há `d_faccao`?

**Recomendação:** `SELECT * FROM information_schema.tables WHERE table_name LIKE '%faccao%'`.

**Decisão:** _______________________________________________

---

### DEC-014 — Tipo canônico de `cod_portador`

**Onde aparece:** `jma.ddeposito`, `financeiro.*`. Pode ser `varchar(n)` (código bancário) ou `smallint` (código operacional interno).

**Decisão:** _______________________________________________

---

### DEC-015 — Schema `temporario` (584 tabelas): manter ou eliminar?

**Categoria:** Escopo | **Prioridade:** Alta

**Recomendação:** Opção D — auditar uso em produção primeiro; depois decidir entre renomear (`stg_<schema>_<entidade>`) ou migrar para `stage`.
**Impacto:** Muito alto — afeta 584 tabelas e todas as DAGs que as utilizam.

**Decisão:** _______________________________________________

---

### DEC-016 — Tabelas sem `updated_at`: estratégia de carga incremental

**Categoria:** ETL | **Prioridade:** Alta

**Estimativa:** ~600+ tabelas sem coluna de auditoria adequada.

**Recomendação:** Opção A para tabelas com alto volume + novas tabelas; Opção C (carga full) para tabelas < 10k registros.

**Decisão:** _______________________________________________

---

### DEC-017 — Unificação do identificador de produto entre schemas

**Categoria:** Modelagem | **Prioridade:** Alta

**Onde aparece:** `live.dproduto`, `ppcp.dtecidos`, `estoque.*`, `comercial.fnotas_venda_produtos`.

**Recomendação:** Opção C — criar `d_produto_map (sku_produto, cod_produto_live, cod_produto_senior)` como tabela de bridge.

**Decisão:** _______________________________________________

---

### DEC-018 — Tabelas de `jma` sem prefixo claro de tipo

**Onde aparece:** `jma.confer_caixas`, `jma.ped_cong_motivo_bloqueio` e possivelmente outros.

**Recomendação:** Revisar semântica de cada tabela sem prefixo e classificar como `d_`, `f_`, `stg_` ou `aux_`.

**Decisão:** _______________________________________________

---

### DEC-019 — SCD Tipo 2: implementar para quais dimensões?

**Candidatas:** `d_cliente` (histórico de segmento), `d_representante` (histórico de região), `d_produto` (histórico de preço de tabela).

**Recomendação:** Levantamento com equipe de BI sobre quais análises precisam de "estado na data da venda".

**Decisão:** _______________________________________________

---

### DEC-020 — Ordem de carga para carga inicial (full load)

**Ordem sugerida (preliminar):**
1. Staging (`temporario`, `stage`)
2. Dimensões de referência (`d_produto`, `d_cliente`, `d_representante`)
3. Dimensões de contexto (`d_deposito`, `d_tipo_movimento`, etc.)
4. Fatos (`f_pedido`, `f_faturamento`, `f_movimentos_*`)

**Recomendação:** Produzir grafo de dependências antes de executar qualquer migração com TRUNCATE + RELOAD.

**Decisão:** _______________________________________________

---

## 📑 Apêndice: Conflitos Identificados por Schema

> Esta seção organiza todos os conflitos por schema para facilitar revisão por área. Cada item referencia o `DEC-xxx` correspondente nas tabelas acima.

### Schema `api`

| Conflito | DEC | Status |
|----------|-----|--------|
| Duplicidade entre `vitrine`, `vitrine_checklist` e `vitrine_questions` — avaliar consolidar | Duplicatas #7 | ⏳ Pendente |
| Colunas de data como varchar em `vitrine_indicators_stores` (`date_start`, `date_end`, `executiondate`) | DEC-036 | ⏳ Pendente |
| Idioma em inglês mantido (rastreabilidade da API) | DEC-002 | ⏳ Pendente |

### Schema `comercial`

| Conflito | DEC | Status |
|----------|-----|--------|
| `fpedido.ped_cdrep (int4)` vs `fpedido.fk_representante (varchar(6))` — dois campos para mesmo representante com tipos diferentes | DEC-025 | ⏳ Pendente |
| `fpedido` vs `fpedido_showroom` — estruturas idênticas; consolidar | DEC-026 / Duplicatas #6 | ⏳ Pendente |
| `fmeta_representante_orion` vs `fmeta_representante` — verificar se mesma fonte | DEC-052 | ⏳ Pendente |
| `cod_representante int4` em `fnotas_venda_produtos` — converter para `varchar(6)` | DEC-053 | ⏳ Pendente |
| `fpedido` mistura cabeçalho e item — separar | DEC-004 | ⏳ Pendente |
| `cod_cliente` com tipos inconsistentes | DEC-003 | ⏳ Pendente |
| `cnpj_repres int8` em `drepresentante` — converter para `varchar(16)` | DEC-007 | ⏳ Pendente |

### Schema `live`

| Conflito | DEC | Status |
|----------|-----|--------|
| `dcliente.cnpj_cliente varchar(120)` — muito grande; reformatar para `varchar(16)` | DEC-027 | ⏳ Pendente |
| `dlojas.pk_cnpj varchar(35)` — reformatar para `cnpj_loja varchar(16)` | DEC-028 | ⏳ Pendente |
| `dproduto.sku_produto varchar(120)` — corrigir para `varchar(30)` | DEC-029 | ⏳ Pendente |
| `dcanaldistribuicao` duplicada em `live` e `jma` | Duplicatas #1 | ⏳ Pendente |
| `dproduto` vs `dprodutoproducao` (jma) — sobreposição | DEC-017 / Duplicatas #2 | ⏳ Pendente |
| `d_centro_custo` duplicado em `live` e `ppcp` | Duplicatas #3 | ⏳ Pendente |

### Schema `ppcp`

| Conflito | DEC | Status |
|----------|-----|--------|
| `dcad_centro_custo` duplicado em `ppcp` e `live` | Duplicatas #3 | ⏳ Pendente |
| `cnpj_forn varchar(184)` em múltiplas tabelas — reformatar | DEC-024 | ⏳ Pendente |
| `cd_nivel99 float8` em `fordens_corte` — deve ser `varchar(1)` | DEC-032 | ⏳ Pendente |
| `flista_prioridades.id float8` — deve ser `integer` | DEC-054 | ⏳ Pendente |
| `cd_ordem_producao text` em `fordens_produzidas` — converter para `integer` | DEC-033 | ⏳ Pendente |
| `turno numeric(38)` em `fproducao_seda` — alterar para `smallint` | DEC-034 | ⏳ Pendente |
| `fk_produto` com tamanhos inconsistentes — padronizar `sku_produto varchar(30)` | DEC-035 | ⏳ Pendente |
| `maquina` sem prefixo em `fmaquinas_divisao_externa` | DEC-008 | ⏳ Pendente |
| `fk_componente` — verificar existência de `d_componente` | DEC-011 | ⏳ Pendente |
| `sugcancelproducao` — tipo semântico indefinido | DEC-012 | ⏳ Pendente |
| `faccao` — verificar existência de `d_faccao` | DEC-013 | ⏳ Pendente |
| Colunas marcadas para DROP — confirmar exclusão | DEC-009 | ⏳ Pendente |

### Schema `rh`

| Conflito | DEC | Status |
|----------|-----|--------|
| `cod_colaborador` não está definido — derivar de `cd_funcionario varchar(9)` | DEC-045 | ⏳ Pendente |
| Campos hora como varchar (HH:MM) — definir conversão | DEC-031 | ⏳ Pendente |
| `fdre_lojas` duplicada em `rh` e `jma` | Duplicatas #4 | ⏳ Pendente |
| Mix de Senior RH e Employer no mesmo schema | DEC-044 | ⏳ Pendente |
| Campos de data fracionados como `numeric(38,10)`/`float8` | DEC-030 | ⏳ Pendente |
| `cpf varchar(11)` sem formatação | DEC-041 | ⏳ Pendente |
| `freajuste.ultima_atualizacao date` (deveria ser `timestamp`) | DEC-040 | ⏳ Pendente |

### Schema `suprimentos`

| Conflito | DEC | Status |
|----------|-----|--------|
| Colunas com acentos em `dfornecedor_produto` — renomear urgente | DEC-023 | 🔴 Crítico |
| Colunas com espaços em `fprojeto_obc` — renomear urgente | DEC-055 | ⏳ Pendente |
| `fnota_entrada` vs `fnota_entrada2` — verificar redundância | Duplicatas #5 | ⏳ Pendente |
| Colunas de data como `text` em múltiplas tabelas | DEC-037 | ⏳ Pendente |
| `f_compra_bi` materializada vs view sobre `f_obc_sdcv_detalhe` | DEC-042 | ⏳ Pendente |

### Schema `ti`

| Conflito | DEC | Status |
|----------|-----|--------|
| `forus_resumo_sprint` tem 3 colunas com espaço no nome — prioridade alta | DEC-056 | ⏳ Pendente |
| `dorion_projetos.id` vs `cod_projeto` — verificar se redundantes | DEC-050 | ⏳ Pendente |

### Schema `stage`

| Conflito | DEC | Status |
|----------|-----|--------|
| 4 tabelas de movimentação com estrutura similar — consolidar | DEC-043 | ⏳ Pendente |
| Ausência de colunas de auditoria padronizadas em `stg_*` | DEC-051 | ⏳ Pendente |

### Schema `jma`

> Conflitos identificados durante a criação de `dicionarios/DICIONARIO_DADOS_JMA.md` (71 tabelas).

| Conflito | DEC | Status |
|----------|-----|--------|
| `ffaturamento_dev_inc` — 53 colunas em UPPER_CASE com aspas duplas | DEC-021 | 🔴 Crítico |
| `ffaturamento_eua` — colunas com nomes de funções SQL (`SUM(DADOS.QUANTIDADE)`) | DEC-022 | 🔴 Crítico |
| `fhists_mov_` — typo no nome da tabela (trailing underscore) | DEC-038 | ⚠️ Alta |
| 5 tabelas sem `created_at`/`updated_at` (`f_controle_partes`, `f_monitor_producao`, `f_movimentos_loja_microvix`, `f_requisicao_compra`, `f_pedido_congelado_motivo_bloqueio`) | DEC-039 | ⚠️ Alta |
| `numeric(38,10)` em 30+ colunas (legado Oracle) | DEC-046 / DEC-064 | ⚠️ Alta |
| `nf_cdrep float8` em `f_faturamento` — deve ser `cod_representante varchar(6)` | DEC-047 | ⚠️ Alta |
| `f_tempo_metodo` — `varchar` sem tamanho em `tempo_homem`/`tempo_maquina` | DEC-049 | ⚠️ Alta |
| Schema `jma` — permanente ou temporário? 71 tabelas com aparência de pertencer a `comercial` | DEC-001 | ⚠️ Alta |
| `dcanaldistribuicao` duplicada com `live` | Duplicatas #1 | ⚠️ Alta |
| `dprodutoproducao` sobrepõe `live.dproduto` | Duplicatas #2 | ⚠️ Alta |
| `fdre_lojas` duplicada com `rh` | Duplicatas #4 | ⚠️ Alta |
| 4 tabelas de meta (`fmeta_diario_loja`, `fmeta_semanal_loja`, `fmeta_mensal_loja`, `fmeta_loja`) com granularidades diferentes | DEC-057 | ⚠️ Alta |
| 6 tabelas de faturamento com escopos diferentes (`ffaturamento`, `_eua`, `_internacional`, `_nacional`, `_dev`, `_dev_inc`) | DEC-058 | ⚠️ Alta |
| 3 tabelas de movimento de loja (`fmovimentos_loja`, `fmovimentosinteg`, `fmovimentoslojamicrovix`) | DEC-059 | ⚠️ Alta |
| `dfuncionariosinteg.cod_vendedor` sem dimensão `d_vendedor` consolidada | DEC-060 | ⚠️ Alta |
| `fpedidos_url`, `fvendas_url` — sufixo `_url` ambíguo | DEC-061 | ⚠️ Alta |
| `confer_caixas` (sem prefixo) coexiste com `fconfer_caixas` | DEC-062 / DEC-018 | ⚠️ Alta |
| `pk_*` reutilizado como business key em ~14 dimensões | DEC-063 / DEC-006 | ⚠️ Alta |
| 4 dimensões de status/situação com escopos sobrepostos | DEC-065 | ℹ️ Média |
| `dtabelapreco` (cabeçalho) + `ftabelapreco` (item) — nomenclatura confusa | DEC-066 | ℹ️ Média |
| `dfuncionariosinteg.cnpj varchar(40)` — quase 3x maior que necessário | DEC-067 | ℹ️ Média |
| `fdre_lojas` vs `fdre_orcado_lojas` — realizado vs orçado em tabelas separadas | DEC-068 | ℹ️ Média |
| `ped_cong_motivo_bloqueio` sem prefixo de tipo | DEC-018 | ℹ️ Média |
| Tipo canônico de `cod_portador` indefinido (`jma.ddeposito`) | DEC-014 | ℹ️ Média |
| Tabelas sem `updated_at` — estratégia de carga incremental | DEC-016 | ⚠️ Alta |

---

*Documento gerado em 2026-05-06 — Fase 2 de Padronização DW Live*
*Versão: 2.1 | Padrão: BOAS_PRATICAS_DW.md v2.0*
*Schemas com dicionário concluído: api, comercial, jma, live, ppcp, rh, stage, suprimentos, ti*
*Última atualização: adição de DEC-052 a DEC-068 + apêndice por schema (após geração do DICIONARIO_DADOS_JMA.md)*
