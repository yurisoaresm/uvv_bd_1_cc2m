/*
Descrição     : Projeto Elmasri de banco de dados apresentado no capítulo 5 do livro 
				      : "Sistemas de Bancos de Dados" de Elmasri e Navathe, 7ed.	
										
Autor         : Yuri Soares

Colaboradores : Pedro Lima
              : Roberto Souza
Orientador    : prof. Abrantes Araújo Silva Filho

Versão SGBD   : PostgreSQL 14.2
*/



/* --------------------------------------------------------------------------- */
/* EXECUÇÃO AUTOMÁTICA DO PROJETO                                              */
/* --------------------------------------------------------------------------- */
/* Este script é o único que deve ser executado. Ele executará automaticamente */
/* todos os outros scripts necessários na ordem correta.                       */
/* --------------------------------------------------------------------------- */

-- Recebe do usuário o caminho onde o repositório foi clonado:
\echo 
\echo Insira abaixo o caminho correto do repositório "uvv_bd_1_cc2m" (ou seja, o caminho onde este repositório foi clonado na sua máquina):
\prompt path

-- Executa o primeiro script para criação do projeto
\echo 
\echo Executando o primeiro script (1):
\i :path/pset1/postgresql/1-database_user.sql

-- Executa o segundo script para criação do projeto
\echo 
\echo Executando o segundo script (2):
\i :path/pset1/postgresql/2-schema_connection.sql

-- Executa o terceiro script para criação do projeto
\echo 
\echo Executando o terceiro script (3):
\i :path/pset1/postgresql/3-tables.sql

-- Executa o terceiro script para criação do projeto
\echo 
\echo Executando o quarto script (4):
\i :path/pset1/postgresql/4-insert_datas.sql
