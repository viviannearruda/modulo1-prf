-- ============================================================================
-- PROJETO: Data Analytics com Dados Abertos da PRF (2025)
-- MÓDULO: 3 - SQL com SQLite (SQLiteOnline)


-- ETAPA 1: INSPEÇÃO E CONFIGURAÇÃO DO AMBIENTE

-- 1. Verificar a versão do SQLite no navegador
-- Finalidade: Garantir compatibilidade dos comandos e funções de janela.
SELECT sqlite_version() AS versao_sqlite;

-- 2. Exibir a estrutura (colunas e tipos) da tabela importada
-- Finalidade: Inspecionar os metadados do dataset 'acidentes_prf_2025'.
PRAGMA table_info(acidentes_prf_2025);

-- 3. Contar o número total de registros/ocorrências da base
-- Finalidade: Validar se a importação do CSV foi concluída com sucesso.
SELECT COUNT(*) AS total_ocorrencias 
FROM acidentes_prf_2025;



-- ETAPA 2: REGRAS DE NEGÓCIO E CRIAÇÃO DA VIEW BASE


-- 4 & 5. Excluir e Criar a view base 'vw_acidentes_base'
-- Finalidade: Adicionar a variável binária 'acidente_fatal' (1 se mortos >= 1, senão 0)
-- CAST(mortos AS INTEGER): Converte o campo textual em inteiro.
-- CASE WHEN: Define a regra de negócio para indicar fatalidade.
DROP VIEW IF EXISTS vw_acidentes_base;

CREATE VIEW vw_acidentes_base AS
SELECT *,
    CASE
        WHEN CAST(mortos AS INTEGER) >= 1 THEN 1
        ELSE 0
    END AS acidente_fatal
FROM acidentes_prf_2025;


-- ETAPA 3: MÉTRICAS GERAIS E AGREGAÇÕES


-- 6. Calcular métricas gerais: total de acidentes, total de fatais e % de letalidade
-- 100.0 *: Força a divisão decimal no SQLite.
-- ROUND(..., 2): Arredonda a taxa para duas casas decimais.
SELECT
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base;


-- 7. Agregar acidentes, mortos e % de fatais por Estado (UF)
-- GROUP BY uf: Agrupa os dados por estado.
-- HAVING COUNT(*) >= 100: Garante relevância estatística filtrando UFs com pelo menos 100 casos.
-- ORDER BY perc_fatais DESC: Ordena das maiores taxas para as menores.
SELECT
    uf,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY uf
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;


-- 8. Listar as 30 rodovias (BRs) mais letais em número absoluto de mortos
-- WHERE br IS NOT NULL: Exclui registros sem identificação da rodovia.
-- ORDER BY total_mortos DESC LIMIT 30: Classifica pelas BRs com maior volume de vítimas fatais.
SELECT
    br,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
WHERE br IS NOT NULL
GROUP BY br
HAVING COUNT(*) >= 100
ORDER BY total_mortos DESC
LIMIT 30;


-- 9. Evolução temporal dos acidentes por Ano e Mês
-- strftime('%Y', data_inversa): Extrai o ano em 4 dígitos.
-- strftime('%m', data_inversa): Extrai o mês em 2 dígitos.
SELECT
    CAST(strftime('%Y', data_inversa) AS INTEGER) AS ano,
    CAST(strftime('%m', data_inversa) AS INTEGER) AS mes,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY ano, mes
ORDER BY ano, mes;



-- ETAPA 4: ANÁLISES BIVARIADAS (VARIÁVEIS EXPLICATIVAS X LETALIDADE)


-- 10. Relação bivariada entre Tipo de Acidente e % de ocorrências fatais
SELECT
    tipo_acidente,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY tipo_acidente
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;


-- 11. Analisar as 30 Principais Causas de Acidentes ordenadas pela maior taxa de letalidade
SELECT
    causa_acidente,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY causa_acidente
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC
LIMIT 30;


-- 12. Comparar a gravidade dos acidentes de acordo com a Fase do Dia
SELECT
    fase_dia,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY fase_dia
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;


-- 13. Avaliar a influência da Condição Meteorológica no % de acidentes fatais
-- Nota: Utilizada a coluna 'condicao_metereologica' conforme grafia do CSV original.
SELECT
    condicao_metereo AS condicao_metereo,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY condicao_metereo
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;


-- 14. Comparar a letalidade do acidente de acordo com o Tipo de Pista
SELECT
    tipo_pista,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY tipo_pista
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;



-- ETAPA 5: ANÁLISES AVANÇADAS (CRUZAMENTO DE FATORES E LIFT)


-- 15. Combinar dois fatores (Tipo de Pista + Fase do Dia) e calcular a Cobertura (%)
-- SUM(COUNT(*)) OVER (): Função de janela que calcula o total geral de registros agrupados.
-- cobertura_perc: Proporção do cenário analisado em relação ao total da base.
SELECT
    tipo_pista,
    fase_dia,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS cobertura_perc,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY tipo_pista, fase_dia
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;


-- 16. Calcular Confiança, Cobertura e o efeito 'Lift' por Tipo de Acidente
-- CTE 'taxa_global': Calcula previamente a taxa média de fatalidade de toda a base.
-- CROSS JOIN: Disponibiliza a taxa média global para cada linha de cálculo do grupo.
-- Lift: Razão entre a taxa de fatalidade do tipo e a taxa média geral (>1 indica maior gravidade que a média).
WITH taxa_global AS (
    SELECT 1.0 * SUM(acidente_fatal) / COUNT(*) AS taxa
    FROM vw_acidentes_base
)
SELECT
    tipo_acidente,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS cobertura_perc,
    ROUND(1.0 * SUM(acidente_fatal) / COUNT(*), 4) AS confianca,
    ROUND((1.0 * SUM(acidente_fatal) / COUNT(*)) / taxa, 2) AS lift
FROM vw_acidentes_base
CROSS JOIN taxa_global
GROUP BY tipo_acidente, taxa
HAVING COUNT(*) >= 100
ORDER BY lift DESC;



-- ETAPA 6: CONSTRUÇÃO DE VIEWS CONSOLIDADAS PARA DASHBOARDS


-- 17. Criar a view 'vw_indicadores_mensais' para relatórios e séries temporais
DROP VIEW IF EXISTS vw_indicadores_mensais;

CREATE VIEW vw_indicadores_mensais AS
SELECT
    CAST(strftime('%Y', data_inversa) AS INTEGER) AS ano,
    CAST(strftime('%m', data_inversa) AS INTEGER) AS mes,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY ano, mes;

-- Consulta de checagem da View Mensal
SELECT * FROM vw_indicadores_mensais ORDER BY ano, mes;


-- 18. Criar a view 'vw_indicadores_uf_br' consolidada por localização para Dashboards
DROP VIEW IF EXISTS vw_indicadores_uf_br;

CREATE VIEW vw_indicadores_uf_br AS
SELECT
    uf,
    br,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
WHERE br IS NOT NULL
GROUP BY uf, br;

-- Consulta de checagem da View UF/BR
SELECT * FROM vw_indicadores_uf_br ORDER BY total_mortos DESC;



-- ETAPA 7: RESOLUÇÃO DOS EXERCÍCIOS PROPOSTOS (APÊNDICE C)


-- Exercício 1: Top 20 municípios por total de acidentes
SELECT 
    municipio, 
    uf, 
    COUNT(*) AS total_acidentes
FROM vw_acidentes_base
GROUP BY municipio, uf
ORDER BY total_acidentes DESC
LIMIT 20;

-- Exercício 2: Total de mortos e % de fatalidade por dia da semana
SELECT 
    dia_semana,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY dia_semana
ORDER BY total_mortos DESC;

-- Exercício 3: Comparação da gravidade entre área urbana e rural (uso_solo)
SELECT 
    uso_solo,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY uso_solo;

-- Exercício 4: UFs com percentual de fatalidade superior à taxa global
WITH taxa_global AS (
    SELECT 100.0 * SUM(acidente_fatal) / COUNT(*) AS taxa 
    FROM vw_acidentes_base
)
SELECT 
    uf,
    COUNT(*) AS total_acidentes,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base, taxa_global
GROUP BY uf
HAVING perc_fatais > taxa_global.taxa
ORDER BY perc_fatais DESC;

-- Exercício 5: Criar view com indicadores consolidados por município e BR
DROP VIEW IF EXISTS vw_indicadores_municipio_br;

CREATE VIEW vw_indicadores_municipio_br AS
SELECT 
    uf,
    municipio,
    br,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
WHERE br IS NOT NULL
GROUP BY uf, municipio, br;

-- Exercício 6: Cobertura, Confiança e Lift para causa_acidente
WITH taxa_global AS (
    SELECT 1.0 * SUM(acidente_fatal) / COUNT(*) AS taxa 
    FROM vw_acidentes_base
)
SELECT 
    causa_acidente,
    COUNT(*) AS total_acidentes,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS cobertura_perc,
    ROUND(1.0 * SUM(acidente_fatal) / COUNT(*), 4) AS confianca,
    ROUND((1.0 * SUM(acidente_fatal) / COUNT(*)) / taxa, 2) AS lift
FROM vw_acidentes_base, taxa_global
GROUP BY causa_acidente, taxa
HAVING COUNT(*) >= 100
ORDER BY lift DESC;

-- Exercício 7: Série mensal separada por UF
SELECT 
    uf,
    CAST(strftime('%Y', data_inversa) AS INTEGER) AS ano,
    CAST(strftime('%m', data_inversa) AS INTEGER) AS mes,
    COUNT(*) AS total_acidentes,
    SUM(CAST(mortos AS INTEGER)) AS total_mortos
FROM vw_acidentes_base
GROUP BY uf, ano, mes
ORDER BY uf, ano, mes;

-- Exercício 8: Combinações de condição meteorológica e fase do dia (>= 100 casos)
SELECT 
    condicao_metereo AS condicao_meteoreo,
    fase_dia,
    COUNT(*) AS total_acidentes,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY condicao_metereo, fase_dia
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;

-- Exercício 9: Base analítica contendo apenas acidentes fatais
DROP VIEW IF EXISTS vw_acidentes_apenas_fatais;

CREATE VIEW vw_acidentes_apenas_fatais AS
SELECT *
FROM vw_acidentes_base
WHERE acidente_fatal = 1;

--Exercício 10: Associação observada em SQL 
--Uma associação encontrada no SQL indica apenas correlação (coocorrência de dados nos registros históricos),
-- e não causalidade.  O SQL faz apenas cálculos descritivos (GROUP BY, SUM, COUNT) 
-- e não consegue isolar outras variáveis ocultas (fatores de confusão como velocidade, consumo de álcool
-- ou estado da via). Para provar causa e efeito, seriam necessários experimentos controlados e 
-- modelos de inferência estatística/causal, e não apenas agregações em banco de dados.