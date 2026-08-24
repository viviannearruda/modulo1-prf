# 🐍 Unidade 4 — Tratamento e Preparação de Dados com Python

## 📌 Sobre a unidade

Nesta unidade, os dados de acidentes da Polícia Rodoviária Federal (PRF) foram tratados e preparados utilizando Python.

O foco principal foi transformar a base original em conjuntos de dados mais adequados para análise exploratória e para futuras etapas de modelagem.

## 🎯 Objetivos

* Carregar e inspecionar a base original;
* Identificar problemas na qualidade dos dados;
* Tratar valores ausentes;
* Padronizar variáveis;
* Criar novas variáveis;
* Preparar uma base analítica;
* Preparar uma base específica para modelagem;
* Aplicar cuidados para evitar data leakage.

## 📂 Base original

A unidade utiliza a base:

```text
dados_abertos_prf-datatran2025.csv
```

A base contém registros de acidentes ocorridos em rodovias federais brasileiras durante o ano de 2025.

Entre as informações disponíveis estão:

* Data e horário;
* Estado;
* Município;
* Rodovia;
* Tipo de acidente;
* Causa do acidente;
* Condições meteorológicas;
* Características da via;
* Quantidade de pessoas;
* Quantidade de veículos;
* Número de mortos;
* Número de feridos.

## 🔄 Etapas do tratamento

### 1. Carregamento dos dados

A base original foi carregada e analisada para compreender sua estrutura, tipos de dados e principais variáveis.

### 2. Análise da qualidade dos dados

Foram verificadas questões como:

* Valores ausentes;
* Tipos de dados;
* Inconsistências;
* Variáveis disponíveis;
* Distribuição dos valores.

### 3. Tratamento e padronização

Foram realizadas transformações para preparar os dados para análise, incluindo tratamento de variáveis e criação de informações derivadas.

### 4. Criação da variável-alvo

Foi criada a variável:

```text
acidente_fatal
```

A variável indica se houve pelo menos uma morte no acidente.

A regra utilizada é:

```python
acidente_fatal = 1, se mortos >= 1
acidente_fatal = 0, caso contrário
```

Essa variável pode ser utilizada em análises relacionadas à classificação da gravidade dos acidentes.

## 📊 Bases geradas

### 🔹 Base analítica

Arquivo:

```text
dados_tratados/base_analitica_prf_2025.csv
```

Esta base foi preparada para:

* Análise Exploratória de Dados (EDA);
* Criação de gráficos;
* Visualização de indicadores;
* Desenvolvimento de dashboards;
* Análise de padrões e tendências.

### 🔹 Base modelável

Arquivo:

```text
dados_tratados/base_modelavel_prf_2025.csv
```

Esta base foi preparada para futuras aplicações de Machine Learning.

Durante sua construção, foram considerados cuidados para evitar **data leakage**, removendo informações que poderiam revelar diretamente o resultado que se deseja prever.

## ⚠️ Data Leakage

Data leakage acontece quando um modelo utiliza informações que não estariam disponíveis no momento da previsão ou que possuem relação direta com o resultado que está sendo previsto.

Como a variável-alvo está relacionada à ocorrência de mortes, variáveis que representam diretamente o resultado do acidente precisam ser analisadas com cuidado.

O objetivo é garantir que a base modelável contenha apenas informações que possam ser utilizadas de forma adequada na previsão.

## 🛠️ Tecnologias utilizadas

* Python;
* Pandas;
* Jupyter Notebook;
* Git;
* GitHub.

## 📓 Notebook

Todo o processo de tratamento e preparação dos dados está documentado no arquivo:

```text
notebook_modulo4.ipynb
```

O notebook apresenta as etapas de exploração, transformação e geração das bases finais.

## 📁 Estrutura da unidade

```text
unidade4/
│
├── dados_abertos_prf-datatran2025.csv
├── notebook_modulo4.ipynb
├── README.md
│
├── dados_tratados/
│   ├── base_analitica_prf_2025.csv
│   └── base_modelavel_prf_2025.csv
│
└── logs/
```

## 📚 Competências desenvolvidas

* Python para Análise de Dados;
* Pandas;
* Limpeza de dados;
* Tratamento de valores ausentes;
* Criação de variáveis;
* Preparação de bases analíticas;
* Preparação de dados para modelagem;
* Identificação de data leakage;
* Organização de projetos de dados.

## 👩‍💻 Autora

**Vivianne Arruda**

Atividade desenvolvida como parte da formação em Análise de Dados, utilizando dados abertos da Polícia Rodoviária Federal (PRF).
