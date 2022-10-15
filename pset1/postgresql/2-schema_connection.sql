/* --------------------------------------------------------------------------- */
/* CONEXÃO AO BANCO UVV E CRIAÇÃO DO SCHEMA ELMASRI:                           */
/* --------------------------------------------------------------------------- */
/* Com o usuário e o banco prontos, faremos a conexão ao banco "uvv" com o     */
/* usuário "yuri" e criaremos o schema "elmasri". Também ajustaremos o         */
/* SEARCH_PATH do usuário para manter o scheme "elmasri" como o padrão.        */
/* --------------------------------------------------------------------------- */

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
