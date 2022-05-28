/*
Descrição     : Relatórios referentes ao projeto Elmasri do livro "Sistemas de Banco de Dados",
              : de Ramez Elmasri e Shamkant B. Navathe, 7ed.	
										
Autor         : Yuri Soares

Colaboradores : Pedro Lima
              : Roberto Souza
Orientador    : prof. Abrantes Araújo Silva Filho

Versão SGBD   : 
*/

-- 1. Relatório da média salarial dos funcionários de cada departamento:
\echo
\echo Relatório da média salarial dos funcionários de cada departamento:
SELECT d.nome_departamento AS departamento, 
       CAST(AVG(salario) AS DECIMAL (10,2)) AS media_salarial
FROM funcionario f
INNER JOIN departamento d ON (d.numero_departamento = f.numero_departamento)
GROUP BY d.nome_departamento;

-- 2. Relatório da média salarial dos homens e das mulheres:
\echo
\echo Relatório da média salarial dos homens e das mulheres:
SELECT CASE 
        WHEN (sexo = 'M') THEN 'Homens' 
        WHEN (sexo = 'F') THEN 'Mulheres'
        ELSE '?'
       END AS sexo, 
       CAST(AVG(salario) AS DECIMAL(10,2)) AS media_salarial
FROM funcionario
GROUP BY sexo;

-- 3. Relatório do nome do departamento e o nome completo, data de nascimento, idade e salário de cada funcionário:
\echo
\echo Relatório do nome do departamento e o nome completo, data de nascimento, idade e salário de cada funcionário:
SELECT d.nome_departamento AS departamento,
       f.primeiro_nome || ' ' || f.nome_meio || ' ' || f.ultimo_nome AS funcionario,
       TO_CHAR(f.data_nascimento, 'DD/MM/YYYY') AS data_nascimento, -- Oracle e PostgreSQL
       EXTRACT (YEAR FROM AGE(f.data_nascimento)) AS idade, 
       CAST(f.salario AS DECIMAL(10,2)) AS salario
FROM funcionario f 
INNER JOIN departamento d ON (f.numero_departamento = d.numero_departamento)
ORDER BY salario DESC; -- opcional

-- 4. Relatório que apresenta o nome completo dos funcionários, idade, salário atual e o salário reajustado em 20% caso o atual seja inferior à 35 mil ou em 15% caso seja igual ou superior a esse valor:
\echo
\echo Relatório com o nome completo dos funcionários, idade, salário atual e o salário reajustado em 20% para inferiores à 35 mil e em 15% caso superior ou igual a esse valor:
SELECT f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionario, 
       EXTRACT (YEAR FROM AGE(f.data_nascimento)) AS idade, 
       CAST(f.salario AS DECIMAL(10,2)) AS salario_atual, 
       CASE
        WHEN f.salario < 35000 THEN CAST(f.salario * 1.2 AS DECIMAL(10,2))
        WHEN f.salario >= 35000 THEN CAST(f.salario * 1.15 AS DECIMAL(10,2)) 
        ELSE null -- em caso de erro, retornar null
       END AS salario_reajustado
FROM funcionario f;


-- 5. Relatório com os nomes dos gerentes e dos funcionários de cada departamento e ordenados por nome do departamento (em ordem crescente) e pelo salário dos funcionários (em ordem decrescente):
\echo
\echo Relatório com os nomes dos gerentes e dos funcionários de cada departamento ordenados por departamento em ordem crescente e pelo salário dos funcionários em ordem decrescente:
SELECT d.nome_departamento AS departamento, 
       g.primeiro_nome ||' '|| g.nome_meio ||' '|| g.ultimo_nome AS gerente, 
       f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionario, 
       f.salario AS salario
FROM departamento d
INNER JOIN funcionario g ON (d.cpf_gerente = g.cpf)
INNER JOIN funcionario f ON (d.numero_departamento = f.numero_departamento)
ORDER BY d.nome_departamento ASC, 
         f.salario DESC;

-- 6. Relatório com o nome completo dos funcionários que possuem pelo menos um dependente, o departamento onde trabalham e o nome completo, idade e sexo do(s) dependente(s):
\echo
\echo Relatório com o nome completo dos funcionários que possuem pelo menos um dependente, o departamento onde trabalham e o nome completo, idade e sexo do(s) dependente(s):
SELECT dt.nome_departamento AS departamento, 
       f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionário, 
       dp.nome_dependente AS dependente, 
       EXTRACT (YEAR FROM AGE(dp.data_nascimento)) AS idade_dependente, 
       CASE 
        WHEN dp.sexo = 'M' THEN 'Masculino' 
        WHEN dp.sexo = 'F' THEN 'Feminino' 
       END AS sexo_dependente
FROM funcionario f
INNER JOIN dependente dp ON (dp.cpf_funcionario = f.cpf)
INNER JOIN departamento dt ON (dt.numero_departamento = f.numero_departamento);

-- 7. Relatório com o nome completo, departamento e salário de cada funcionário que não possui dependente:
\echo
\echo Relatório com o nome completo, departamento e salário de cada funcionário que não possui dependente:
SELECT f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionário, 
       d.nome_departamento AS departamento, 
       CAST(salario AS DECIMAL(10,2)) AS salario
FROM funcionario f
LEFT JOIN dependente dp ON (dp.cpf_funcionario = f.cpf)
INNER JOIN departamento d ON (d.numero_departamento = f.numero_departamento)
WHERE dp.nome_dependente IS NULL;

-- 8. Relatório que mostra, para cada departamento, os seus projetos e nome completo de cada funcionário alocado em cada projeto e o número de horas trabalhadas:
\echo
\echo Relatório dos projetos e nome completo de cada funcionário alocado em cada projeto para cada departamento e o número de horas trabalhadas:
SELECT d.nome_departamento AS departamento, 
       p.nome_projeto AS projeto, 
       f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionario,
       CAST(t.horas AS DECIMAL(3,1)) AS horas
FROM departamento d
INNER JOIN projeto p ON (p.numero_departamento = d.numero_departamento)
INNER JOIN trabalha_em t ON (t.numero_projeto = p.numero_projeto)
INNER JOIN funcionario f ON (t.cpf_funcionario = f.cpf)
ORDER BY departamento,
         projeto,
         funcionario;

-- 9. Relatório da soma total das horas de cada projeto em cada departamento, o nome do departamento e do projeto:
\echo
\echo Relatório com a soma total das horas trabalhadas de cada projeto em cada departamento, o nome do departamento e do projeto:
SELECT d.nome_departamento AS departamento, 
       p.nome_projeto AS projeto, 
       SUM(t.horas) AS horas
FROM departamento d
INNER JOIN projeto p ON (p.numero_departamento = d.numero_departamento)
INNER JOIN trabalha_em t ON (t.numero_projeto = p.numero_projeto)
GROUP BY departamento, -- sempre usar GROUP BY quando aplicado uma função de agregação
         projeto
ORDER BY departamento, 
         projeto;

-- 10. Relatório do nome completo do funcionário, nome do projeto em que ele trabalha e o valor que ele receberá referente às horas trabalhadas neles, considerando 50 reais por hora:
\echo
\echo Relatório com o nome completo do funcionário, projeto em que ele trabalha e o valor que receberá referente às horas trabalhadas neles, considerando 50 reais a hora:
SELECT f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionario, 
       p.nome_projeto AS projeto, 
       t.horas AS horas,
       CAST(t.horas * 50 AS DECIMAL (10,2)) AS valor_pagamento
FROM funcionario f
INNER JOIN trabalha_em t ON (t.cpf_funcionario = f.cpf)
INNER JOIN projeto p ON (p.numero_projeto = t.numero_projeto)
ORDER BY funcionario,
         projeto;

-- 11. Relatório que exibe o nome do departamento, do projeto e o nome dos funcionários que não registraram nenhuma hora trabalhada:
\echo
\echo Relatório que exibe o nome do departamento, do projeto e dos funcionários que não registraram nenhuma hora trabalhada:
SELECT d.nome_departamento AS departamento, 
       p.nome_projeto AS projeto, 
       CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS funcionario 
FROM departamento d
INNER JOIN projeto p ON (p.numero_departamento = d.numero_departamento)
INNER JOIN trabalha_em t ON (t.numero_projeto = p.numero_projeto)
INNER JOIN funcionario f ON (t.cpf_funcionario = f.cpf)
WHERE t.horas IS NULL
   OR t.horas = 0;

-- 12. Relatório que exibe o nome completo, sexo e idade de todos os funcionários e seus dependentes em ordem decrescente da idade em anos completos:
\echo
\echo Relatório que exibe o nome completo, sexo e idade de todos os funcionários e dependentes em ordem decrescente da idade em anos completos:
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome, 
       f.sexo AS sexo,  
       EXTRACT (YEAR FROM AGE(f.data_nascimento)) AS idade
FROM funcionario f
UNION
SELECT dp.nome_dependente AS nome, 
       dp.sexo AS sexo, 
       EXTRACT (YEAR FROM AGE(dp.data_nascimento)) AS idade
FROM dependente dp
ORDER BY idade DESC;

-- 13. Relatório que exibe a quantidade de funcionários de cada departamento:
\echo
\echo Relatório que exibe a quantidade de funcionários de cada departamento:
SELECT d.nome_departamento AS departamento, 
       COUNT(f.cpf) AS funcionarios
FROM funcionario f
INNER JOIN departamento d ON (d.numero_departamento = f.numero_departamento)
GROUP BY d.nome_departamento;

-- 14. Relatório com o nome completo dos funcionários, seu departamento e o nome dos projetos em que cada um está alocado:
\echo
\echo Relatório com o nome completo dos funcionários, seu departamento e projetos em que cada um está alocado:
SELECT f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome AS funcionario, 
       d.nome_departamento AS departamento, 
       p.nome_projeto AS projeto
FROM funcionario f
INNER JOIN departamento d ON (f.numero_departamento = d.numero_departamento)
INNER JOIN trabalha_em t ON (t.cpf_funcionario = f.cpf)
INNER JOIN projeto p ON (p.numero_projeto = t.numero_projeto)
ORDER BY funcionario ASC;
