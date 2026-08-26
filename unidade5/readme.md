# 📊 Unidade 5 — Visualização e Análise de Dados

## 📌 Sobre a unidade

Nesta unidade, os dados de acidentes em rodovias federais brasileiras foram explorados por meio da criação de gráficos e indicadores utilizando Python.

A análise foi desenvolvida a partir da base de dados da Polícia Rodoviária Federal (PRF), com foco na visualização de padrões relacionados à severidade dos acidentes, fatalidades, fase do dia, participação de pedestres nos óbitos, causas associadas a acidentes fatais e quantidade de veículos envolvidos nas ocorrências.

O objetivo foi transformar os dados em visualizações que facilitassem a interpretação dos resultados e a identificação de padrões relevantes.

---

## 🎯 Objetivos

* Criar visualizações para análise dos dados;
* Explorar indicadores relacionados à gravidade dos acidentes;
* Analisar a distribuição dos acidentes fatais;
* Comparar diferentes tipos de acidentes;
* Identificar padrões relacionados às causas das ocorrências;
* Utilizar gráficos para comunicar informações de forma clara;
* Aplicar Python e bibliotecas de visualização de dados.

---

## 📂 Base de dados utilizada

A análise utiliza a base:

```text
dados_abertos_prf-datatran2025(1).csv
```

A base contém registros de acidentes ocorridos em rodovias federais brasileiras durante o ano de 2025.

Entre as variáveis utilizadas nas análises estão:

* `tipo_acidente`;
* `classificacao_acidente`;
* `causa_acidente`;
* `fase_dia`;
* `mortos`;
* `feridos_leves`;
* `feridos_graves`;
* `veiculos`;
* `acidente_fatal`.

---

# 📈 Visualizações desenvolvidas

## 1️⃣ Taxa de severidade de feridos por tipo de acidente

Foi calculada uma taxa de severidade considerando a proporção de feridos graves em relação ao total de feridos leves e graves.

A análise agrupa os dados por `tipo_acidente`, permitindo identificar os tipos de ocorrência com maior taxa de ferimentos graves.

Também foi incluída uma linha de referência com a média geral de severidade.

### 📊 Indicador utilizado

```text
Taxa de Severidade (%) =
Feridos Graves / (Feridos Leves + Feridos Graves) × 100
```

---

## 2️⃣ Distribuição dos acidentes fatais por fase do dia

Foi criado um gráfico de pizza para analisar como os acidentes fatais se distribuem entre os diferentes períodos do dia.

A análise utiliza:

* `acidente_fatal`;
* `fase_dia`.

O gráfico permite visualizar a participação de cada período do dia no total de acidentes fatais.

---

## 3️⃣ Participação dos atropelamentos de pedestres nos óbitos

Esta análise verifica a participação dos acidentes envolvendo pedestres no total de mortes registradas.

Foram comparados:

* Óbitos em acidentes classificados como atropelamento de pedestres;
* Óbitos registrados nos demais tipos de acidentes.

A visualização foi desenvolvida por meio de um gráfico de pizza em formato de rosca.

---

## 4️⃣ Fatalidade associada à ultrapassagem indevida e à contramão

Foi calculado o percentual de acidentes fatais entre as ocorrências relacionadas às causas:

* Transitar na contramão;
* Ultrapassagem indevida.

A análise compara o percentual de acidentes fatais e não fatais dentro desse grupo de ocorrências.

### 📊 Indicador utilizado

```text
Percentual de Fatalidade =
Quantidade de acidentes com pelo menos uma morte /
Total de acidentes relacionados à causa × 100
```

---

## 5️⃣ Média de veículos envolvidos por classificação do acidente

Foi calculada a média de veículos envolvidos nas ocorrências, agrupando os dados de acordo com a variável:

```text
classificacao_acidente
```

Também foi adicionada uma linha de referência com a média geral de veículos envolvidos em todos os acidentes da base.

Essa análise permite comparar o número médio de veículos envolvidos entre diferentes classificações de acidentes.

---

# 🛠️ Tecnologias e bibliotecas utilizadas

* Python;
* Pandas;
* Matplotlib;
* Seaborn;
* Jupyter Notebook.

---

# 📓 Notebook

Todo o processo de criação dos gráficos está disponível no arquivo:

```text
graficos.ipynb
```

O notebook reúne os códigos utilizados para:

* Agrupar e calcular indicadores;
* Filtrar os dados;
* Calcular taxas e percentuais;
* Criar gráficos de barras;
* Criar gráficos de pizza;
* Criar gráficos de rosca;
* Adicionar médias e valores de referência;
* Melhorar a apresentação visual dos resultados.

---


# 📚 Competências desenvolvidas

* Visualização de dados;
* Análise de indicadores;
* Manipulação de DataFrames com Pandas;
* Agrupamento e agregação de dados;
* Cálculo de taxas e percentuais;
* Filtragem de dados;
* Criação de gráficos com Matplotlib;
* Visualização de dados com Seaborn;
* Comunicação de resultados por meio de gráficos;
* Interpretação de padrões nos dados.

---

## 👩‍💻 Autora

**Vivianne Arruda**

Atividade desenvolvida como parte da formação em **Análise de Dados**, utilizando dados abertos da Polícia Rodoviária Federal (PRF).
