/* --------------------------------------------------------------------------- */
/* LIMPEZA GERAL:                                                              */
/* --------------------------------------------------------------------------- */
/* Esta seção do script faz uma "limpeza geral" no banco de dados, removendo o */
/* banco de dados "uvv", se ele existir, e o usuário "yuri", se ele existir.   */
/* --------------------------------------------------------------------------- */

-- Remove o banco de dados "uvv", se existir:
\echo
\echo Removendo o banco de dados "uvv" e o usuário "yuri":
DROP DATABASE IF EXISTS uvv;

-- Remove o usuário "yuri", se existir:
DROP USER IF EXISTS yuri;



/* --------------------------------------------------------------------------- */
/* CRIA USUÁRIO E BANCO DE DADOS:                                              */
/* --------------------------------------------------------------------------- */
/* Agora que estamos com o banco de dados "zerado", precisamos recriar o       */
/* usuário "yuri" e o banco de dados "uvv".                                    */
/* --------------------------------------------------------------------------- */

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
