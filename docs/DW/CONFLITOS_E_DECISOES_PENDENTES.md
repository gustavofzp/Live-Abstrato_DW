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
| ⚠️ Alta Prioridade | 26 | DEC-001, DEC-003–006, DEC-009, DEC-015–016, DEC-025–041 |
| ℹ️ Média Prioridade | 20 | DEC-002, DEC-008, DEC-010–014, DEC-018–020, DEC-042–051 |
| 🔁 Duplicatas | 7 | jma/live (canal, produto, cc), rh/jma (fdre), suprimentos (notas), comercial (fpedido), api (vitrine) |
| **Total** | **58** | — |

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

*Documento gerado em 2026-05-06 — Fase 2 de Padronização DW Live*
*Versão: 2.0 | Padrão: BOAS_PRATICAS_DW.md v2.0*
*Schemas com dicionário concluído: api, comercial, jma, live, ppcp, rh, stage, suprimentos, ti*
