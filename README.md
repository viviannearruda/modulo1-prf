# 🚗 Análise de Acidentes em Rodovias Federais Brasileiras — PRF 2025

## 📊 Sobre o projeto

Este repositório reúne as atividades práticas desenvolvidas ao longo do **Módulo 1 da Formação em Análise de Dados**, utilizando dados abertos da **Polícia Rodoviária Federal (PRF)** sobre acidentes registrados nas rodovias federais brasileiras no ano de 2025.

O projeto acompanha diferentes etapas do processo de análise de dados, desde a exploração e manipulação inicial da base até a utilização de ferramentas como **Excel, Google Sheets, SQL e Python** para tratamento, análise e preparação dos dados.

A base de dados utilizada contém informações sobre acidentes, incluindo localização, data, rodovia, tipo e causa do acidente, condições meteorológicas, quantidade de pessoas envolvidas, vítimas, veículos e outras características das ocorrências.

---

## 🎯 Objetivo

O principal objetivo do projeto é analisar os acidentes registrados nas rodovias federais brasileiras em 2025, buscando identificar padrões e características relevantes relacionados às ocorrências e à gravidade dos acidentes.

Ao longo das atividades, foram exploradas questões como:

* Quais estados apresentam maior quantidade de acidentes e vítimas;
* Quais rodovias concentram mais ocorrências;
* Quais são os principais tipos e causas dos acidentes;
* Como fatores como condições meteorológicas e fase do dia se relacionam com os acidentes;
* Como os acidentes variam ao longo do tempo;
* Quais variáveis podem ser utilizadas na construção de uma base analítica e, posteriormente, em modelos preditivos.

---

## 🗂️ Base de dados

A análise utiliza a base **DATATRAN 2025**, disponibilizada pela Polícia Rodoviária Federal.

A base contém informações como:

| Categoria                      | Variáveis                                                                   |
| ------------------------------ | --------------------------------------------------------------------------- |
| 🗓️ Tempo                      | `data_inversa`, `dia_semana`, `horario`, `fase_dia`                         |
| 📍 Localização                 | `uf`, `br`, `km`, `municipio`, `latitude`, `longitude`                      |
| 🚗 Características do acidente | `causa_acidente`, `tipo_acidente`, `classificacao_acidente`                 |
| 🛣️ Características da via     | `sentido_via`, `tipo_pista`, `tracado_via`, `uso_solo`                      |
| 🌦️ Ambiente                   | `condicao_metereologica`                                                    |
| 👥 Pessoas e vítimas           | `pessoas`, `mortos`, `feridos_leves`, `feridos_graves`, `ilesos`, `feridos` |
| 🚙 Veículos                    | `veiculos`                                                                  |
| 🏢 Estrutura operacional       | `regional`, `delegacia`, `uop`                                              |

---

## 📁 Estrutura do repositório

```text
modulo1-prf/
│
├── unidade1/
│   ├── README.md
│   └── unidade1_Dados PRF prévia.xlsx
│
├── unidade2/
│   ├── README.md
│   └── unidade_02_excel_prf_vivianne.xlsx
│
├── unidade3/
│   ├── README.me
│   ├── script_analise_prf_2025.sql
│   ├── resultado_uf.csv
│   ├── resultado_br.csv
│   ├── resultado_mes.csv
│   ├── resultado_tipo.csv
│   ├── resultado_causa.csv
│   ├── resultado_fase_dia.csv
│   ├── resultado_clima.csv
│   └── vw_indicadores_uf_br.csv
│
└── unidade4/
    ├── dados_tratados/
    │   ├── base_analitica_prf_2025.csv
    │   └── base_modelavel_prf_2025.csv
    │
    ├── logs/
    ├── README.md
    ├── dados_abertos_prf-datatran2025.csv
    └── notebook_modulo4.ipynb
```

---

# 📚 Unidades do projeto

## 🔹 Unidade 1 — Exploração inicial dos dados

Nesta etapa foi realizada a primeira exploração da base de dados da PRF.

As atividades tiveram como foco:

* compreensão da estrutura da base;
* identificação das principais variáveis;
* exploração de dados quantitativos e categóricos;
* aplicação de filtros e ordenação;
* identificação de padrões iniciais;
* registro de observações e hipóteses a partir dos dados.

📂 Arquivo principal: `unidade1_Dados PRF prévia.xlsx`

---

## 🔹 Unidade 2 — Análise de dados com planilhas

Nesta unidade, a base foi trabalhada utilizando **Microsoft Excel e/ou Google Sheets**.

Foram aplicadas técnicas de análise e manipulação de dados, incluindo:

* filtros e ordenação;
* remoção de duplicidades;
* cálculos e métricas;
* fórmulas condicionais;
* agregações;
* estatística descritiva;
* tabelas e visualizações;
* construção de análises para identificação de padrões nos acidentes.

Entre as funções e fórmulas utilizadas estão:

```text
CONT.VALORES
CONT.SE
CONT.SES
SOMA
SOMA.SE
SOMASES
MÉDIA
MÉDIA.SE
MEDIANA
MODA
QUARTIL
PROCV
MÁXIMO
MÍNIMO
```

Também foram desenvolvidos gráficos e dashboards para facilitar a interpretação dos indicadores.

📂 Arquivo principal: `unidade_02_excel_prf_vivianne.xlsx`

---

## 🔹 Unidade 3 — Análise com SQL e SQLite

Na terceira unidade, os dados foram analisados utilizando **SQL**, com foco em consultas, agregações e análises descritivas.

Foram desenvolvidas análises relacionadas a:

* indicadores por estado;
* ranking de rodovias;
* evolução mensal dos acidentes;
* tipos de acidentes;
* principais causas;
* fase do dia;
* condições meteorológicas;
* métricas de gravidade e letalidade;
* análise de fatores associados a acidentes fatais.

Os resultados das consultas foram exportados para arquivos CSV, permitindo a reutilização dos dados em outras ferramentas.

### 📄 Principais arquivos

* `script_analise_prf_2025.sql` — consultas SQL utilizadas na análise;
* `resultado_uf.csv` — indicadores agrupados por estado;
* `resultado_br.csv` — análise das rodovias;
* `resultado_mes.csv` — evolução mensal;
* `resultado_tipo.csv` — análise por tipo de acidente;
* `resultado_causa.csv` — análise por causa do acidente;
* `resultado_fase_dia.csv` — análise por fase do dia;
* `resultado_clima.csv` — análise por condição meteorológica;
* `vw_indicadores_uf_br.csv` — indicadores por UF e rodovia.

---

## 🔹 Unidade 4 — Preparação e modelagem dos dados com Python

A quarta unidade utiliza **Python** para realizar o tratamento e a preparação dos dados para análises mais avançadas.

O processo inclui:

* carregamento da base original;
* inspeção da estrutura dos dados;
* tratamento de valores ausentes;
* padronização de variáveis;
* criação de novas variáveis;
* preparação de uma base analítica;
* preparação de uma base específica para modelagem;
* prevenção de **data leakage**;
* preparação dos dados para análise exploratória, visualizações e modelos de classificação.

### 🎯 Variável-alvo

Foi criada a variável:

```text
acidente_fatal
```

Onde:

* `1` → acidente com pelo menos uma vítima fatal;
* `0` → acidente sem vítimas fatais.

A regra utilizada é:

```python
acidente_fatal = 1, se mortos >= 1
acidente_fatal = 0, caso contrário
```

### 📂 Bases geradas

#### `base_analitica_prf_2025.csv`

Base preparada para:

* Análise Exploratória de Dados (EDA);
* criação de visualizações;
* desenvolvimento de dashboards;
* utilização no Power BI;
* análise dos indicadores de acidentes e gravidade.

#### `base_modelavel_prf_2025.csv`

Base preparada especificamente para modelagem.

Nesta versão, foram excluídas variáveis que poderiam causar **vazamento de dados**, como informações diretamente relacionadas ao resultado do acidente, incluindo variáveis de vítimas e métricas derivadas da gravidade.

📓 Arquivo principal: `notebook_modulo4.ipynb`

---

# 🛠️ Tecnologias e ferramentas

* **Python**
* **SQL**
* **SQLite**
* **Microsoft Excel**
* **Google Sheets**
* **Jupyter Notebook**
* **Pandas**
* **Git**
* **GitHub**

---

# 📈 Principais competências desenvolvidas

Durante o desenvolvimento deste projeto, foram praticados conhecimentos em:

* Análise Exploratória de Dados (EDA);
* Limpeza e tratamento de dados;
* Manipulação de planilhas;
* Fórmulas e funções estatísticas;
* Visualização de dados;
* SQL e consultas analíticas;
* Agrupamentos e agregações;
* Criação de métricas e indicadores;
* Preparação de dados para dashboards;
* Criação de variáveis derivadas;
* Identificação e prevenção de data leakage;
* Preparação de bases para modelagem;
* Versionamento de projetos com Git e GitHub.

---

# 📌 Considerações metodológicas

As análises apresentadas neste projeto devem ser interpretadas de acordo com os dados disponíveis na base utilizada.

Foram aplicados cuidados para:

* diferenciar observações diretamente identificadas nos dados de hipóteses analíticas;
* tratar valores ausentes e inconsistências;
* selecionar variáveis adequadas para cada tipo de análise;
* evitar conclusões de causalidade quando os dados permitem apenas observar associações;
* evitar vazamento de informações na preparação da base para modelagem.

---

# 🚀 Como explorar o projeto

1. Comece pela **Unidade 1** para conhecer a exploração inicial da base;
2. Acesse a **Unidade 2** para visualizar as análises realizadas em planilhas;
3. Consulte a **Unidade 3** para acompanhar as consultas e resultados em SQL;
4. Explore a **Unidade 4** para entender o processo de tratamento e preparação dos dados com Python.

---

## 👩‍💻 Autora

**Vivianne Arruda**

Projeto desenvolvido como parte das atividades práticas da formação em **Análise de Dados**, utilizando dados abertos de acidentes da **Polícia Rodoviária Federal (PRF)** referentes ao ano de 2025.

🔗 Repositório: [modulo1-prf no GitHub](https://github.com/viviannearruda/modulo1-prf)

---

⭐ Se este projeto foi útil ou interessante, fique à vontade para explorar as análises e acompanhar a evolução do repositório!
