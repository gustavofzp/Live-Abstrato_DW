# 📘 Padronização de Nomenclatura de Tabelas – Data Warehouse

## 🎯 Objetivo
Estabelecer um padrão consistente para nomenclatura de tabelas no Data Warehouse (DW), garantindo:
- Clareza
- Facilidade de manutenção
- Escalabilidade
- Padronização entre equipes

---

## 🧱 Convenções Gerais

### 🔤 Formato
- Utilizar **snake_case** (letras minúsculas e separação por underscore `_`)
- Não utilizar acentos ou caracteres especiais
- Evitar abreviações ambíguas

**Exemplos:**
- `data_venda`
- `valor_total`

---

## 🏷️ Prefixos de Tabelas

### 📊 Tabelas Fato (`f`)
Representam eventos, medições ou transações.

**Regra:**
```
f<nome_do_evento>
```

**Exemplos:**
- `ffaturamento_lojas`
- `fvendas`
- `fmovimentacao_estoque`

---

### 📚 Tabelas Dimensão (`d`)
Representam descrições, atributos e contextos.

**Regra:**
```
d<entidade>
```

**Exemplos:**
- `dlojas`
- `dclientes`
- `dprodutos`

---

## 🧠 Boas Práticas

### ✅ Clareza
- Use nomes descritivos e completos
- Evite siglas pouco conhecidas

**Ruim:**
- `fvl`

**Bom:**
- `fvendas_lojas`

---

### 📏 Singular vs Plural
- Preferencialmente utilizar **plural** para tabelas

**Exemplos:**
- `dclientes`
- `ffaturamentos`

---

### 🔗 Consistência
- Mesma entidade deve manter o mesmo nome em todo o DW

**Exemplo:**
- `dclientes` (não variar para `dcliente`, `d_cli`, etc.)

---

### 🧩 Separação por Contexto
- Quando necessário, complementar o nome com contexto

**Exemplos:**
- `ffaturamento_lojas`
- `ffaturamento_online`

---

## 🚫 O que evitar

- ❌ CamelCase (`FaturamentoLojas`)
- ❌ Espaços (`faturamento lojas`)
- ❌ Prefixos inconsistentes (`fat_`, `dim_`)
- ❌ Nomes genéricos (`dados`, `tabela1`)

---

## 🧪 Exemplos Comparativos

| Tipo       | Nome Correto              | Nome Incorreto        |
|------------|--------------------------|-----------------------|
| Fato       | `ffaturamento_lojas`     | `FaturamentoLojas`    |
| Dimensão   | `dprodutos`              | `dim_produto`         |
| Fato       | `fvendas_online`         | `vendasOnline`        |
| Dimensão   | `dclientes`              | `cliente_dim`         |

---

## 🏁 Conclusão

A adoção desse padrão garante maior organização no Data Warehouse, facilita o entendimento por novos membros da equipe e reduz erros operacionais.

Este padrão deve ser seguido em **todas as novas tabelas** e aplicado gradualmente nas estruturas existentes quando possível.

