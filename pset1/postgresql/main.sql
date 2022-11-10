/*
Descrição     : Projeto de banco de dados apresentado no capítulo 5 do livro 
				      : "Sistemas de Bancos de Dados" de Elmasri e Navathe, 7ed.	
										
Autor         : Yuri Soares

Colaboradores : Pedro Lima
              : Roberto Souza
Orientador    : prof. Abrantes Araújo Silva Filho

Versão SGBD   : PostgreSQL 14.2
*/

/* =========================================================================== */
/* LIMPEZA GERAL:                                                              */
/* --------------------------------------------------------------------------- */
/* Esta seção do script faz uma "limpeza geral" no banco de dados, removendo o */
/* banco de dados "uvv", se ele existir, e o usuário "yuri", se ele existir.   */
/* =========================================================================== */

-- Remove o banco de dados "uvv", se existir:
\echo
\echo Removendo o banco de dados "uvv" e o usuário "yuri":
DROP DATABASE IF EXISTS uvv;

DROP USER IF EXISTS yuri;


/* =========================================================================== */
/* CRIA USUÁRIO E BANCO DE DADOS:                                              */
/* --------------------------------------------------------------------------- */
/* Agora que estamos com o banco de dados "zerado", precisamos recriar o       */
/* usuário "yuri" e o banco de dados "uvv".                                    */
/* =========================================================================== */

-- Cria o usuário "yuri", que será o dono do banco de dados "uvv". Por
-- segurança esse usuário não será um super-usuário. E como este é um
-- script de demonstração, usaremos a super-senha "123456".
\echo
\echo Criando o usuário "yuri":
CREATE USER yuri WITH
	NOSUPERUSER
	CREATEDB
	CREATEROLE
	LOGIN
	ENCRYPTED PASSWORD '123456'
;

COMMENT ON USER "yuri" IS 'Usuário criado para gerenciar o SGBD. Pode criar novos banco de dados, schemas, outros usuários, tabelas, modificá-las e inserir dados.'
;
	
-- Agora que o usuário já está criado, vamos criar o banco de dados "uvv" e
-- colocar o usuário "yuri" como o dono desse banco de dados. Além disso
-- configuraremos algumas opções de linguagem para o português do Brasil.
\echo
\echo Criando o banco de dados "uvv":
CREATE DATABASE uvv WITH
	OWNER      = yuri
	TEMPLATE   = template0
	ENCODING   = 'UTF-8'
	LC_COLLATE = 'pt_BR.UTF-8'
	LC_CTYPE   = 'pt_BR.UTF-8'
;

COMMENT ON DATABASE uvv IS 'Banco de Dados Universidade (UVV) do PSet 1.'
;


/* =========================================================================== */
/* CONEXÃO AO BANCO UVV E CRIAÇÃO DO SCHEMA ELMASRI:                           */
/* --------------------------------------------------------------------------- */
/* Com o usuário e o banco prontos, faremos a conexão ao banco "uvv" com o     */
/* usuário "yuri" e criaremos o schema "elmasri". Também ajustaremos o         */
/* SEARCH_PATH do usuário para manter o scheme "elmasri" como o padrão.        */
/* =========================================================================== */

-- Conexão ao banco "uvv" como usuário "yuri", passando a senha via string
-- de conexão. Obviamente isso só está sendo feito porque é um script de
-- demonstração, não se deve passar senhas em scripts em formato texto puro
-- (existem exceções, claro, mas considere que essa regra é válida na maioria
-- das vezes).
\echo
\echo Conectando ao novo banco de dados:
\c "dbname=uvv user=yuri password=123456"

-- Criação do schema "elmasri":
\echo
\echo Criando e configurando o schema "elmasri" restrito ao usuário "yuri":
CREATE SCHEMA elmasri AUTHORIZATION yuri;

COMMENT ON SCHEMA elmasri IS 'Esquema Elmasri para o PSet-1.';

-- Para que as novas tabelas criadas e dados inseridos estejam dentro do schema criado, é preciso alterar a variável de ambiente SEARCH_PATH.
-- Ajusta o SEARCH_PATH da conexão atual ao banco de dados:
SET SEARCH_PATH TO elmasri, "$user", public; 

-- Configura o SEARCH_PATH do usuário yuri (define qual será a SEARCH_PATH sempre que o usuário "yuri" se conectar):
ALTER USER yuri SET SEARCH_PATH TO elmasri, "$user", public;

-- Executa o terceiro script para criação do projeto
\echo 
\echo Executando o script de criação das tabelas:
\i :elmasri_tables.sql

-- Executa o terceiro script para criação do projeto
\echo 
\echo Executando o script de inserção dos dados:
\i :elmasri_inserts.sql
