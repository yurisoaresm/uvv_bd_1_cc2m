/*
Descrição     : Projeto Elmasri de banco de dados apresentado no capítulo 5 do livro 
				      : "Sistemas de Bancos de Dados" de Elmasri e Navathe, 7ed.	
										
Autor         : Yuri Soares
Colaboradores : Pedro Lima
              : Roberto Souza
Orientador    : prof. Abrantes Araújo Silva Filho

Versão SGBD   : Oracle Database Express Edition Release - Version 21.3.0.0.0
*/

PROMPT 
PROMPT Insira a senha para o esquema Elmasri como parâmetro 1:
DEFINE pass     = &1
PROMPT 
PROMPT Insira a senha do seu SYS como parâmetro 2:
DEFINE pass_sys = &2
PROMPT 
PROMPT Insira a string de conexão ao pdb como parâmetro 3 (exemplo: localhost:1521/xepdb1): 
DEFINE connect_string     = &3 
PROMPT


/* ======================================================= */
/* Limpeza geral                                           */
/* ------------------------------------------------------- */
/* Remove o usuário, o esquema e todos os objetos          */
/* relacionados de forma automática antes de executar      */
/* o script.                                               */
/* ======================================================= */

DROP DATABASE elmasri CASCADE
DROP USER elmasri CASCADE;


/* ======================================================= */
/* Criação do usuário                                      */
/* ======================================================= */

-- Cria o usuário "elmasri" com a senha de entrada:
CREATE USER elmasri IDENTIFIED BY &pass
                    DEFAULT TABLESPACE users
                    QUOTA UNLIMITED ON users
                    TEMPORARY TABLESPACE temp
                    ACCOUNT UNLOCK 
                    ENABLE EDITIONS 
;

-- Concede funções/permisões (ROLES) ao usuário criado:
GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO elmasri;

GRANT AUTHENTICATEDUSER, CONNECT, CREATE DATABASE LINK, RESOURCE, UNLIMITED TABLESPACE TO elmasri;

CONNECT sys/&pass_sys@&connect_string AS SYSDBA;
GRANT execute ON sys.dbms_stats TO elmasri;


/* ======================================================= */
/* Criação dos objetos do esquema Elmasri                  */
/* ======================================================= */

CONNECT elmasri/&pass@&connect_string
ALTER SESSION SET nls_language="BRAZILIAN PORTUGUESE";
ALTER SESSION SET NLS_TERRITORY =BRAZIL;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';


/* ======================================================= */
/* Criação da estrutura do banco                           */
/* ------------------------------------------------------- */
/* Cria as tabelas, constraints, indexes, e outros objetos */
/* do esquema elmasri.                                     */
/* ======================================================= */

@elmasri_tables