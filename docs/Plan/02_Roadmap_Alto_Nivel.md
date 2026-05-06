# Roadmap de Alto Nível — Base de Conhecimento Live!

**Projeto:** Base de Conhecimento corporativa Live! — Piloto TI
**Autor:** Leonardo Cardoso — Analista / Engenheiro de Dados (DW)
**Time:** Transformação Digital
**Versão:** 1.0 (abril/2026)
**Documento complementar a:** `01_Apresentacao_Gerencia.md`

---

## 1. Objetivo do Roadmap

Descrever, em alto nível, as fases, entregáveis, arquitetura conceitual e ferramentas necessárias para construir a Base de Conhecimento da Live!, começando pelo piloto de TI. **Prazos não fazem parte deste documento**; serão definidos no detalhamento posterior após validação da gerência.

---

## 2. Princípios Norteadores

Estes princípios guiam todas as decisões do projeto:

**Conhecimento tácito deve virar ativo.** O objetivo é tirar conhecimento da cabeça das pessoas e de anexos de chamados e transformá-lo em algo pesquisável, versionado e reutilizável.

**Começar com o que já existe.** Não vamos escrever documentação do zero. A primeira versão será gerada por IA sobre os ativos brutos (código, DDL, PDFs) e depois revisada por humanos.

**Humano no loop.** IA acelera, não substitui. Nada vira "fonte de verdade" sem revisão humana.

**Piloto antes de escalar.** TI primeiro, prova de valor, depois expansão para outros domínios.

**Evitar recriar o problema.** Novos sistemas e novas regras de negócio precisam nascer já documentados na base — governança mínima desde o dia um.

**Ferramentas servem ao conhecimento, não ao contrário.** Escolhas de ferramentas são revisáveis; a base de conhecimento é o ativo permanente.

---

## 3. Arquitetura Conceitual

A solução tem quatro camadas lógicas:

**Camada 1 — Fontes (ativos brutos).**
Repositórios Git dos sistemas internos, DDLs e scripts do DW, arquivos auxiliares (planilhas, diagramas, anotações), PDFs de regras de negócio anexados nos tickets do GLPI.

**Camada 2 — Ingestão e Estruturação.**
Pipeline que coleta os ativos das fontes, normaliza formatos, extrai texto de PDFs, lê esquemas de banco e constrói um grafo de conhecimento (Graphify) representando relações entre sistemas, tabelas, regras e domínios.

**Camada 3 — Geração Assistida (IA).**
Claude consome o grafo de conhecimento + ativos brutos e produz a primeira versão de: descrições de sistemas, dicionário de dados, mapa de regras de negócio, glossário e cruzamentos (ex.: "essa regra afeta esse sistema, que usa essa tabela").

**Camada 4 — Consumo (Docmost).**
Wiki onde o conteúdo é publicado, revisado, versionado, navegado e pesquisado pelos times. Ponto único de entrada.

A fonte original continua existindo (GLPI segue sendo GLPI, código segue no Git); a base é um **derivado consolidado e consumível**, atualizado periodicamente.

---

## 4. Ferramentas Propostas — Justificativa

### 4.1 Docmost (Wiki de Consumo)

**Por que Docmost:**
open-source, self-hosted (dados da Live! ficam dentro da Live!), suporta hierarquia de espaços, permissões granulares, busca integrada, histórico de versões, editor rico em blocos e comentários colaborativos. Interface moderna familiar (estilo Notion/Confluence), curva de adoção baixa.

**Alternativas consideradas:**
*Confluence* (Atlassian): maduro e poderoso, mas proprietário, com custo de licença e dependência de ecossistema externo.
*Notion*: excelente UX, porém SaaS externo, com implicações de conformidade e custo por usuário.
*BookStack / Wiki.js*: também open-source; Docmost foi preferido pela UX mais moderna e pelo modelo de espaços.
*SharePoint*: opção caso a Live! já tenha padrão Microsoft corporativo — avaliar antes de decidir.

**Decisão pendente:** confirmar com a gerência se há preferência corporativa que anule Docmost (ex.: padrão Microsoft já contratado).

### 4.2 Claude (IA para Geração de Conteúdo)

**Por que Claude:**
janela de contexto longa, qualidade elevada em tarefas de síntese técnica e raciocínio sobre código/schemas, capacidade de seguir instruções estruturadas e de produzir saídas em formato markdown prontas para o Docmost. Adequado para gerar rascunhos de documentação a partir de repositórios, DDLs e PDFs.

**Uso concreto no projeto:**
geração da primeira versão de páginas de sistemas, dicionário de dados, glossário de regras, mapeamento entre regras e sistemas, resumos de PRs e resumos executivos de módulos complexos.

**Alternativa/complemento:**
outros modelos LLM podem ser usados pontualmente; a arquitetura não deve amarrar a base a um único provedor. A base de conhecimento final é markdown, portável, independente do modelo que a gerou.

### 4.3 Graphify (Grafo de Conhecimento)

**Por que Graphify:**
construir um grafo de entidades (sistemas, tabelas, colunas, regras, domínios, times) e relações (usa, depende de, impacta, deriva de) permite que o Claude navegue de forma estruturada pelos ativos, evitando respostas isoladas e gerando conteúdo com cruzamento real entre fontes. Também serve como índice semântico de longo prazo para futuros agentes internos.

**Uso concreto no projeto:**
montar o grafo a partir dos ativos consolidados antes da etapa de geração, fornecendo ao Claude um mapa navegável em vez de apenas uma pilha de arquivos.

**Observação importante:**
a escolha específica (Graphify vs. alternativas como Neo4j + LlamaIndex, Microsoft GraphRAG, ou soluções equivalentes) deve ser validada em uma prova de conceito curta dentro da Fase 1. O que importa no roadmap é a **camada de grafo de conhecimento**, não o produto específico.

### 4.4 GLPI (Fonte de Regras de Negócio)

**Por que manter o GLPI:**
já é a ferramenta oficial de chamados e segue viva. A proposta não substitui o GLPI — propõe um **conector / rotina de extração** que lê PDFs anexados a chamados e alimenta a Base de Conhecimento. O GLPI continua sendo a origem; a base é o consumo consolidado.

**Evolução futura possível:**
ajustar o processo do time de Projetos para que regras de negócio cheguem também em formato estruturado (além do PDF), facilitando ingestão — mas isso é evolução, não bloqueio.

### 4.5 Resumo das Decisões de Ferramenta

| Camada | Ferramenta Proposta | Status |
|---|---|---|
| Fonte de tickets/regras | GLPI (existente) | Mantém |
| Fontes de código/DW | Git + bancos (existente) | Mantém |
| Grafo de conhecimento | Graphify (a validar em PoC) | Proposta |
| Geração por IA | Claude | Proposta |
| Wiki de consumo | Docmost | Proposta |

---

## 5. Fases do Roadmap (Alto Nível, Sem Prazo)

### Fase 0 — Alinhamento e Patrocínio

**Objetivo:** garantir condições mínimas para iniciar.

**Entregáveis:**
- Apresentação aprovada pela gerência de TI.
- Escopo do piloto confirmado (domínio TI, sistemas prioritários escolhidos).
- Acessos liberados (repositórios, bancos para leitura de DDL, GLPI).
- Alinhamento com time de Projetos sobre fluxo de regras de negócio.
- Confirmação das ferramentas (ou substitutos corporativos aprovados).

**Critério de saída:** projeto formalmente patrocinado e desbloqueado para Fase 1.

---

### Fase 1 — Fundação e Prova de Conceito

**Objetivo:** montar a espinha dorsal técnica e validar a abordagem de IA em um escopo pequeno e controlado.

**Entregáveis:**
- Docmost instalado, acessível e com estrutura inicial de espaços definida (TI, DW, Sistemas, Regras de Negócio, Glossário, Governança).
- Repositório central de ativos consolidados (organização de pastas para código, DDLs, PDFs, auxiliares).
- PoC de ingestão: um sistema + DDL de uma área do DW + um conjunto pequeno de PDFs do GLPI processados via Graphify + Claude.
- Primeira página-padrão de sistema gerada e revisada, validando o template.
- Templates base definidos (sistema, tabela, regra de negócio, processo).

**Critério de saída:** prova de valor com uma amostra real; decisão de seguir para ingestão em escala.

---

### Fase 2 — Ingestão em Escala (Piloto TI)

**Objetivo:** rodar o pipeline de geração sobre toda a superfície prioritária de TI.

**Entregáveis:**
- Páginas geradas (rascunho) para todos os sistemas internos prioritários.
- Dicionário de dados do DW com tabelas centrais documentadas.
- Mapa de regras de negócio extraídas dos PDFs do GLPI, indexadas e classificadas por sistema/domínio afetado.
- Grafo de conhecimento populado e consultável.
- Estrutura de busca funcional no Docmost.

**Critério de saída:** conteúdo gerado disponível no Docmost em modo "rascunho IA", pronto para revisão humana.

---

### Fase 3 — Curadoria e Validação Humana

**Objetivo:** transformar os rascunhos de IA em conteúdo confiável.

**Entregáveis:**
- Fluxo de revisão definido (quem revisa o quê, como marcar "revisado", como tratar divergências).
- Páginas prioritárias revisadas e promovidas a "fonte de verdade".
- Correções e enriquecimentos aplicados (o que a IA errou, o que faltou, o que precisa de contexto humano).
- Feedback do pipeline: ajustes nos prompts e no grafo com base nos erros encontrados.
- Glossário corporativo inicial consolidado.

**Critério de saída:** TI consegue, de fato, responder perguntas operacionais consultando apenas a base.

---

### Fase 4 — Governança e Manutenção Viva

**Objetivo:** garantir que a base não morra.

**Entregáveis:**
- Política de atualização definida (quando re-rodar ingestão, quando atualizar páginas manualmente, quem é dono de cada espaço).
- Processo de "documentação já nasce na base" para novos sistemas e novas regras (gate antes do deploy / antes de encerrar chamado do time de Projetos).
- Integração mínima com GLPI para ingestão periódica automática de novos PDFs.
- Métricas de adoção monitoradas (acessos, buscas, páginas mais consultadas, páginas sem dono).
- Rituais leves de manutenção (ex.: revisão periódica de páginas críticas).

**Critério de saída:** base é rotineiramente usada e atualizada, sem depender de esforço heroico.

---

### Fase 5 — Expansão para Outros Domínios (Pós-Piloto)

**Objetivo:** levar a base para além do TI, com a abordagem já validada.

**Entregáveis (a detalhar após piloto):**
- Priorização dos próximos domínios (Comercial, Logística, Financeiro, etc.) com base em dor e patrocínio.
- Onboarding de donos por domínio.
- Eventuais ajustes de arquitetura para suportar domínios não técnicos.
- Aproveitamento da base para os projetos de IA do time de Transformação Digital (assistentes, agentes, copilots).

**Critério de saída:** base de conhecimento corporativa, não mais apenas de TI.

---

## 6. Fluxo de Trabalho Geral (por ativo)

Para cada ativo que entra na base, o fluxo padrão é:

1. **Coleta** — ativo bruto é puxado da fonte (repo, banco, GLPI).
2. **Normalização** — formato unificado, metadados mínimos aplicados.
3. **Indexação em grafo** — entidades e relações extraídas, grafo atualizado.
4. **Geração** — Claude produz rascunho de página seguindo template.
5. **Publicação como rascunho IA** — vai para o Docmost com etiqueta clara.
6. **Revisão humana** — dono da página revisa, corrige, promove a versão oficial.
7. **Manutenção** — atualizações futuras disparam re-geração ou edição manual.

---

## 7. Estrutura Inicial Proposta para o Docmost

Organização sugerida de espaços (ajustável):

- **TI — Visão Geral** (mapa dos sistemas, contatos, governança da base)
- **Sistemas** (uma página por sistema, com módulos, integrações, donos)
- **Data Warehouse** (arquitetura, camadas, fontes, dicionário de dados)
- **Regras de Negócio** (consolidadas a partir dos PDFs do GLPI, com links para o chamado original)
- **Processos de TI** (fluxos internos, padrões, checklists)
- **Glossário** (termos de negócio + termos técnicos)
- **Governança da Base** (como contribuir, padrões, donos, processo de revisão)

---

## 8. Riscos e Mitigações

**Risco: IA gera conteúdo incorreto que vira "fonte de verdade" sem revisão.**
Mitigação: toda página nasce marcada como "rascunho IA" e só é promovida após revisão humana explícita.

**Risco: projeto perde tração depois do piloto e a base envelhece.**
Mitigação: Fase 4 (governança) é condição de sucesso, não opcional. Métricas de adoção e donos por espaço.

**Risco: dependência excessiva de uma ferramenta (Docmost, Graphify, modelo).**
Mitigação: saída final é markdown + grafo portáveis. Ferramentas são trocáveis.

**Risco: time de Projetos não adere e continua entregando regras só como PDF em ticket.**
Mitigação: alinhamento formal na Fase 0; ingestão automática do GLPI garante que mesmo sem mudança de processo a base é alimentada.

**Risco: sensibilidade de dados enviados à IA.**
Mitigação: definir, ainda na Fase 1, política de classificação e o que pode/não pode ser enviado ao modelo; considerar opções self-hosted para partes sensíveis se necessário.

**Risco: "projeto de documentação" é historicamente visto como custo sem retorno.**
Mitigação: vincular explicitamente a base aos projetos de IA do time — ela deixa de ser fim em si mesmo e vira pré-requisito técnico de produtos posteriores.

---

## 9. Métricas de Sucesso

**Métricas de cobertura:**
percentual de sistemas de TI com página mínima viável; percentual de tabelas centrais do DW documentadas; número de regras de negócio indexadas.

**Métricas de qualidade:**
percentual de páginas revisadas por humano; taxa de correção nos rascunhos IA (indica maturidade do pipeline).

**Métricas de adoção:**
usuários ativos únicos no Docmost, buscas realizadas, páginas mais consultadas, perguntas recorrentes respondidas sem escalar para pessoa.

**Métricas de impacto:**
redução do tempo médio para responder "como isso funciona?"; redução de perguntas repetidas direcionadas a pessoas-chave; tempo de onboarding de novos membros.

---

## 10. Dependências e Decisões Abertas

Pontos que precisam de definição para destravar o detalhamento:

- Confirmação das ferramentas (Docmost, Graphify, Claude) ou indicação de substitutos corporativos.
- Alinhamento formal com o time de Projetos sobre fluxo de regras de negócio.
- Definição de donos por espaço na base (quem é responsável por manter).
- Política de classificação de dados (o que pode ser enviado à IA).
- Lista priorizada dos sistemas do piloto (quais entram primeiro).

---

## 11. Próximos Passos Imediatos

1. Apresentar este roadmap à gerência de TI junto com `01_Apresentacao_Gerencia.md`.
2. Colher decisões sobre as dependências abertas (seção 10).
3. Executar Fase 0 (alinhamento e patrocínio).
4. Iniciar Fase 1 (fundação + PoC) com escopo mínimo acordado.

---

*Este é um roadmap de alto nível por fases. O detalhamento operacional (tarefas, responsáveis, estimativas, prazos, riscos granulares e critérios de aceite por entregável) será produzido após o aceite desta proposta.*
