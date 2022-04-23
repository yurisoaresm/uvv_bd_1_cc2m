-- Criar um usuário para administrar o banco de dados uvv

CREATE USER 'yuri'@'localhost' IDENTIFIED BY '1234';

-- Criar o banco de dados e o esquema uvv (de acordo com o MySQL/MariaDB) 
-- com suporte a codificação UTF-8

CREATE SCHEMA uvv
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

-- Permitir todos os privilégios para o usuário gerir o banco de dados uvv e se conectando com ele 

GRANT ALL PRIVILEGES ON uvv.* TO 'yuri'@'localhost';
SYSTEM mysql -u yuri -p;