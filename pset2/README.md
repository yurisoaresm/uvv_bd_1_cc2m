# Problem Set 2
O _Problem Set_ 2 é uma extensão do _[Problem Set 1](https://github.com/yurisoaresm/uvv_bd_1_cc2m/tree/pset2/pset1 "Pset1")_ Nele vamos exibir vários relatórios referentes ao banco de dados Elmasri feito anteriormente. O objetivo deste pset é "fazer o usuário aprender a usar a Structured Query Language (SQL) em nível básico e intermediário". Este script foi feito no SGBD **PostgreSQL** e com algumas funções específicas dele.

Este projeto foi desenvolvido com a **colaboração** de:
- [Pedro Lima](https://github.com/PedroLimaCarari "Perfil do Pedro Lima"), e
- [Roberto Souza](https://github.com/RobertoBSZ "Perfil do Roberto Souza").

E **orientado** por: [prof. Abrantes Araújo S. Filho](https://github.com/abrantesasf "Perfil do prof. Abrantes Araújo S. Filho").

## Modelo Relacional de Dados e SQL
O projeto Elmasri foi implementado no modelo lógico e relacional de dados. Este último é uma definição de dados baseada na álgebra relacional. Todos os comandos usados neste pset são fundamentados nesse conceito matemático.

Os comandos básicos que traduzem a álgebra relacional (matematicamente falando) para o código SQL são SELECT-FROM-WHERE. O SELECT faz uma operação de projeção: seleciona os atributos (colunas) que queremos; FROM indica de qual ou quais relações (tabelas) estamos tratando e; o WHERE faz a operação de seleção: define a condição para selecionarmos um conjunto de tuplas (linhas) específicas. Para as condições do WHERE, podemos usar tanto as operações de conjunto quanto de lógica matemática. 

Além desses comandos básicos, usamos também operações mais complexas: UNION (união: junta dados de duas ou mais relações que possuem os mesmos tipos de atributos) e o INNER JOIN (junção teta: cria uma relação a partir da junção de outras, ainda que seus atributos sejam de tipos diferentes; um exemplo disso é o primeiro relatório, onde o atributo nome_departamento da relação "departamento" foi posto ao lado do atributo média_salarial da tabela "funcionario").

## Execução no PostgreSQL
Para executar este script via terminal a partir da home (com o usuário criado no pset1):

    psql uvv -U yuri -W < ~/uvv_bd_1_cc2m/pset2/relatorios.sql

## Relatórios 

1. Relatório da média salarial dos funcionários de cada departamento;

2. Relatório da média salarial dos homens e das mulheres;

3. Relatório do nome do departamento e o nome completo, data de nascimento, idade e salário de cada funcionário;

4. Relatório que apresenta o nome completo dos funcionários, idade, salário atual e o salário reajustado em 20% caso o atual seja inferior à 35 mil ou em 15% caso seja superior a esse valor;

5. Relatório com a lista o nome do gerente e dos funcionários de cada departamento e ordena por nome do departamento (em ordem crescente) e pelo salário dos funcionários (em ordem decrescente);

6. Relatório com o nome completo dos funcionários que possuem pelo menos um dependente, o departamento onde trabalham e o nome completo, idade e sexo do(s) dependente(s);

7. Relatório com o nome completo, departamento e salário de cada funcionário que não possui dependente;

8. Relatório que mostra, para cada departamento, os seus projetos e nome completo de cada funcionário alocado em cada projeto e o número de horas trabalhadas;

9. Relatório da soma total das horas de cada projeto em cada departamento, o nome do departamento e do projeto;

10. Relatório do nome completo do funcionário, nome do projeto em que ele trabalha e o valor que ele receberá referente às horas trabalhadas neles, considerando 50 reais por hora;

11. Relatório que exibe o nome do departamento, do projeto e o nome dos funcionários que não registraram nenhuma hora trabalhada;

12. Relatório que exibe o nome completo, sexo e idade de todos os funcionários e seus dependentes em ordem decrescente da idade em anos completos;

13. Relatório que exibe a quantidade de funcionários de cada departamento;

14. Relatório com o nome completo dos funcionários, seu departamento e o nome dos projetos em que cada um está alocado.
