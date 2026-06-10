# Queries Alteradas — Delta para a Abstrato

Esta área armazena os arquivos `.sql` com as **queries do DW que foram alteradas desde a última atualização repassada para a Abstrato**.

A pasta funciona como um **delta versionado**: ao consolidar uma nova entrega para a Abstrato, o conteúdo é arquivado/limpo e o ciclo recomeça.

---

## Organização

Os arquivos são organizados por **schema do DW**, espelhando a estrutura lógica do banco:

```
Queries_Alteradas/
├── api/
├── comercial/
├── estoque/
├── eventos/
├── expedicao/
├── financeiro/
├── homologacao/
├── jma/
├── live/
├── marft/
├── ppcp/
├── rh/
├── rh_sci/
├── stage/
├── suprimentos/
├── sustentabilidade/
└── ti/
```

Cada subpasta contém os `.sql` daquele schema que foram criados ou modificados no ciclo atual.

---

## Convenção de nomenclatura dos arquivos

Sugestão (ajuste conforme necessário):

- `{tipo}_{nome_objeto}.sql` — ex: `view_f_vendas_mensal.sql`, `proc_atualiza_d_cliente.sql`
- Para alterações em objeto existente, sufixar com versão se houver múltiplas iterações: `view_f_vendas_mensal_v2.sql`

Use os prefixos já definidos em [docs/DW/BOAS_PRATICAS_DW.md](../docs/DW/BOAS_PRATICAS_DW.md): `d_`, `f_`, `stg_`, `brd_`, `aux_`, `tmp_`.

---

## Cabeçalho recomendado de cada arquivo `.sql`

Toda query nesta pasta deve começar com um cabeçalho **mínimo de 4 campos**:

```sql
-- =====================================================
-- Objeto: <schema>.<nome_objeto>      -- ex: ppcp.f_producao_diaria
-- Tipo:   <CREATE | ALTER | DROP | REFACTOR>
-- Ticket: <GLPI #xxxx | demanda livre>
-- Motivo: <1 linha explicando POR QUE essa mudança existe>
-- =====================================================
```

**Por que só esses 4 campos?** Tudo que o `git` já entrega bem (autor, data, histórico) fica fora — não duplicamos. Schema também não entra porque já está na subpasta. O cabeçalho responde só o que o git **não** responde direto: *que objeto é, que tipo de mudança, qual ticket, e o "por quê"*.

Use o arquivo [`_template.sql`](_template.sql) como ponto de partida.

### Exemplo preenchido

```sql
-- =====================================================
-- Objeto: ppcp.f_producao_diaria
-- Tipo:   ALTER
-- Ticket: GLPI #4892
-- Motivo: Adicionar coluna qtd_refugo solicitada pela qualidade
-- =====================================================
ALTER TABLE ppcp.f_producao_diaria
  ADD COLUMN qtd_refugo NUMERIC(12,2) DEFAULT 0;
```

---

## Fluxo de trabalho

1. **Alteração identificada no DW** → criar/atualizar o `.sql` na subpasta do schema correspondente
2. **Commit** → mensagem descrevendo a mudança e o motivo (ticket GLPI, demanda, etc.)
3. **Repasse para a Abstrato** → consolidar os arquivos da pasta na entrega
4. **Pós-entrega** → arquivar o conteúdo (mover para histórico ou limpar) para começar o próximo ciclo

---

## Relação com outras áreas

- **[docs/DW/BOAS_PRATICAS_DW.md](../docs/DW/BOAS_PRATICAS_DW.md)** — padrões que os scripts devem seguir
- **[documentacao_dw_queries.md](../documentacao_dw_queries.md)** — boas práticas de documentação de queries
- **[docs/DW/dicionarios/](../docs/DW/dicionarios/)** — dicionário de dados por schema
