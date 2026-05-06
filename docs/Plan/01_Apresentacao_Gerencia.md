# Projeto Base de Conhecimento Live! — Apresentação para a Gerência de TI

**Autor:** Gustavo Puchalski — Analista / Engenheiro de Dados (DW)
**Time:** Transformação Digital
**Versão:** 1.0 (abril/2026)

---

## 1. Resumo Executivo

O time de Transformação Digital da Live! está sendo formado com o objetivo de entregar projetos de IA que gerem valor real ao negócio. Antes de iniciar qualquer projeto de IA, precisamos enfrentar um bloqueio estrutural: **hoje não existe uma base de conhecimento consolidada sobre nossos sistemas, nosso Data Warehouse, nem sobre as regras de negócio que os governam**.

Este documento propõe a criação de uma **Base de Conhecimento corporativa da Live!**, começando pelo TI, usando um wiki em Docmost como camada de consumo e um pipeline de IA (Claude + Graphify) para acelerar a ingestão inicial a partir de ativos já existentes (códigos-fonte, DDLs, PDFs de regras de negócio anexados em chamados do GLPI e arquivos auxiliares).

---

## 2. Contexto Atual

A operação atual convive com um cenário de conhecimento fragmentado:

- Os sistemas que usamos **não possuem documentação** formal.
- O **Data Warehouse** não tem documentação — nem de modelo, nem de linhagem, nem de regras de cálculo.
- Os sistemas **desenvolvidos internamente** também não geram documentação.
- As **regras de negócio** chegam via time de Projetos como **PDFs anexados a tickets no GLPI**, sem consolidação, versionamento ou cruzamento com o sistema impactado.
- Não há um local único onde um novo integrante (ou um projeto de IA) consiga responder "como esse sistema funciona?", "o que essa tabela significa?" ou "qual regra rege esse cálculo?".

O conhecimento existe, mas está **disperso entre pessoas, repositórios, bancos e anexos de chamados**. Ele é recuperado sob demanda, por tribal knowledge, e se perde a cada rotatividade.

---

## 3. O Problema que Isso Cria

Sem uma base de conhecimento consolidada, o time de Transformação Digital enfrenta três riscos concretos:

**Risco 1 — Projetos de IA construídos sobre fundação frágil.**
Modelos de IA, agentes e assistentes internos dependem fortemente de contexto estruturado. Um projeto de IA que não consegue explicar nossas próprias regras de negócio corre alto risco de produzir respostas incorretas, alucinações ou decisões mal fundamentadas — gerando mais retrabalho do que valor.

**Risco 2 — Dependência de pessoas-chave.**
O conhecimento crítico hoje mora na cabeça de poucas pessoas. Qualquer saída, férias ou reorganização gera impacto desproporcional na operação e nos projetos.

**Risco 3 — Custo oculto permanente.**
Cada nova demanda, auditoria, integração ou onboarding paga o mesmo imposto: reconstruir contexto a partir do zero. Esse custo não aparece em nenhum indicador, mas consome horas de todos os times que tocam TI.

---

## 4. A Proposta

Construir uma **Base de Conhecimento Live!**, começando pelo TI, com três camadas:

**Camada 1 — Consolidação de Ativos.**
Reunir em um único repositório estruturado: repositórios de código dos sistemas, DDLs dos bancos de dados, dicionários e scripts do DW, arquivos auxiliares de apoio e os PDFs de regras de negócio extraídos dos chamados do GLPI.

**Camada 2 — Geração Assistida por IA.**
Usar o Claude, combinado com Graphify para construção de grafo de conhecimento, para processar os ativos consolidados e gerar uma **primeira versão de documentação** — descrições de sistemas, modelos de dados, fluxos e glossário de regras de negócio. Essa versão é um ponto de partida, não o produto final: será revisada por pessoas antes de virar fonte de verdade.

**Camada 3 — Wiki de Consumo (Docmost).**
A base viva onde o conhecimento consolidado é publicado, navegado, pesquisado, atualizado e versionado. É o lugar onde a organização passa a buscar antes de perguntar.

Em paralelo, estabelecer um **processo mínimo** para que novos sistemas e novas regras de negócio **nasçam já documentados** na base, evitando recriar o problema.

---

## 5. Por que Agora

Três motivos convergem no momento certo:

A formação do time de Transformação Digital cria uma **janela natural** para instituir boas práticas antes do primeiro projeto de IA entrar em produção.

Existem hoje **ferramentas de IA maduras** (Claude, construção de grafo de conhecimento) capazes de acelerar em ordens de grandeza a ingestão inicial — o que há dois anos seria um projeto de documentação manual de meses agora pode começar com uma base rascunhada automaticamente.

Quanto mais sistemas, dados e regras são acumulados **sem documentação**, **maior o custo futuro** de recuperá-los. Começar agora é a opção mais barata que existirá.

---

## 6. Benefícios Esperados

**Para o time de Transformação Digital:**
fundação sólida para projetos de IA (agentes internos, assistentes de dados, copilots de regra de negócio) que dependem de contexto estruturado.

**Para TI como um todo:**
redução de dependência de pessoas-chave, onboarding mais rápido, menos retrabalho em demandas recorrentes, rastreabilidade entre regras de negócio e sistemas impactados.

**Para o negócio:**
regras de negócio deixam de ser PDFs soltos em tickets e passam a ser ativos pesquisáveis, auditáveis e reutilizáveis. Quem faz a pergunta encontra a resposta sem depender de agenda alheia.

**Para a Live!:**
transformação de conhecimento tácito em ativo corporativo. Conhecimento que hoje é risco passa a ser patrimônio.

---

## 7. Escopo Inicial (Piloto)

**Orion como piloto principal, com uma fatia controlada do Systextil entrando junto como "caso de teste complementar"**. Explicando a lógica:

**Por que Orion e não Systextil como piloto principal.** Um piloto existe para validar o pipeline (coleta → grafo → Claude → Docmost → revisão humana), não para entregar cobertura. O melhor piloto é aquele que te permite errar barato e iterar rápido. Orion atende exatamente a isso:

* É desenvolvido internamente → vocês têm o código-fonte, histórico de commits, PRs, autores. Isso é ouro para IA gerar documentação de qualidade.
* Menor e menos complexo → ciclo curto entre "rodar o pipeline" e "ler o resultado e ajustar prompts/templates". Em um sistema grande, cada iteração consome dias só para processar.
* Menor risco reputacional → se o primeiro rascunho sair ruim, o custo de revisar é baixo e o projeto não perde credibilidade.
* Representa bem a categoria "sistemas internos da Live!", que é um dos eixos prioritários do piloto.

---

## 8. O que Está Fora de Escopo Nesta Fase

- Reengenharia dos sistemas documentados.
- Correção de dívidas técnicas descobertas no processo.
- Documentação automatizada em tempo real de código novo (pode virar evolução, não é requisito do piloto).
- Publicação externa da base fora da Live!.

---

## 9. Recursos e Ferramentas (visão rápida)

**Docmost** como wiki de consumo (open-source, self-hosted, suporta hierarquia, busca e permissões — alinhado ao perfil da Live!).
**Claude** como motor de geração e estruturação de conteúdo a partir dos ativos brutos.
**Graphify** como ferramenta de construção de grafo de conhecimento sobre os ativos consolidados, permitindo que o Claude navegue relações entre sistemas, tabelas e regras.
**GLPI** segue como fonte original das regras de negócio — a base não substitui, consolida e dá consumo amigável.

A justificativa detalhada de cada ferramenta está no documento de Roadmap.

---

## 10. Indicadores de Sucesso Propostos

Sugestão de métricas para a gerência acompanhar o valor entregue:

- Percentual dos sistemas de TI com página mínima viável publicada na base.
- Número de regras de negócio (PDFs do GLPI) indexadas e consultáveis.
- Tempo médio para responder "como essa regra/sistema/tabela funciona?" — antes vs. depois.
- Redução de perguntas repetidas direcionadas a pessoas-chave.
- Adoção: acessos únicos e buscas realizadas no Docmost.

---

## 11. Pedido à Gerência

1. **Patrocínio formal** do projeto como pré-requisito dos projetos de IA do time de Transformação Digital.
2. **Alinhamento com o time de Projetos** para que novas regras de negócio passem a alimentar a base, e não apenas o ticket.
3. 

---

## 12. Próximo Passo

Com o aceite desta proposta, o próximo passo é executar o **Roadmap de Alto Nível** (documento anexo) e retornar à gerência com a base piloto de TI publicada para avaliação.

---

*Documento preparado para suportar a conversa com a gerência de TI. O detalhamento técnico, arquitetura e fases de execução estão no documento `02_Roadmap_Alto_Nivel.md`.*
