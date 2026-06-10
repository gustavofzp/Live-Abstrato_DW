# Power BI — Relatórios e Dashboards

Esta área armazena os arquivos do Power BI (`.pbix`, `.pbit`) e documentação associada (fontes de dados, regras de negócio, instruções de uso).

---

## Git LFS — obrigatório

Arquivos `.pbix` são binários comprimidos que podem chegar a centenas de MB. Para evitar inchar o repositório, **este projeto usa Git LFS** para versionar esses arquivos.

### Antes do primeiro clone/pull

Garanta que o Git LFS esteja instalado e inicializado na sua máquina:

```bash
# Ubuntu / Pop!_OS
sudo apt install git-lfs

# Ativar no usuário (uma vez por máquina)
git lfs install
```

A regra de tracking está em `.gitattributes` na raiz do repo — você não precisa configurar nada por arquivo, só commitar normalmente.

### Verificando se está funcionando

```bash
git lfs ls-files
```

Deve listar os `.pbix` rastreados pelo LFS.

---

## Organização sugerida

```
PowerBI/
├── {area_negocio}/
│   ├── {nome_relatorio}.pbix
│   └── README.md         # contexto, fontes, regras
```

Exemplos de subpastas por área: `Comercial/`, `PPCP/`, `Financeiro/`, `RH/`.

---

## Padrões

- **Nomenclatura:** `snake_case` para nomes de arquivo, sem acentos
- **Fontes:** documentar conexões e schemas/tabelas consumidas no README de cada relatório
- **Sensibilidade:** nunca commitar `.pbix` com **credenciais embutidas** ou dados pessoais expostos — sempre publicar com parâmetros/gateways

---

## Relação com outras áreas

- **[docs/DW/dicionarios/](../docs/DW/dicionarios/)** — para entender as fontes de dados que os relatórios consomem
- **[Queries_Alteradas/](../Queries_Alteradas/)** — quando um relatório depende de uma view/proc nova ou alterada, registrar lá
