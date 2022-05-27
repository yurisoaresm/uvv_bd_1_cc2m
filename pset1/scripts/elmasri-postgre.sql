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

COMMENT ON DATABASE uvv IS 'Banco de Dados do PSet-1.';



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
\echo Criando e configurando o schema "elmasri":
CREATE SCHEMA elmasri AUTHORIZATION yuri;

COMMENT ON SCHEMA elmasri IS 'Schema para o PSet-1.';

-- Ajusta o SEARCH_PATH da conexão atual ao banco de dados:
SET SEARCH_PATH TO elmasri, "$user", public; 

-- Configura o SEARCH_PATH do usuário yuri:
ALTER USER yuri SET SEARCH_PATH TO elmasri, "$user", public;



/* --------------------------------------------------------------------------- */
/* FUNCIONÁRIO:                                                                */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "funcionario" e dos demais objetos  */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "funcionario":
\echo
\echo Criando a tabela "funcionario" e objetos relacionados:
CREATE TABLE funcionario (
                cpf                 CHAR(11)      CONSTRAINT nn_func_cpf       NOT NULL,
                primeiro_nome       VARCHAR(15)   CONSTRAINT nn_func_prim_nome NOT NULL,
                nome_meio           CHAR(1),
                ultimo_nome         VARCHAR(15)   CONSTRAINT nn_func_ult_nome  NOT NULL,
                data_nascimento     DATE,
                endereco            VARCHAR(40),
                sexo                CHAR(1),
                salario             DECIMAL(10,2),
                cpf_supervisor      CHAR(11),
                numero_departamento INTEGER       CONSTRAINT nn_func_num_dept  NOT NULL
);

-- Primary key da tabela "funcionario":
ALTER TABLE funcionario ADD CONSTRAINT pk_funcionario
PRIMARY KEY (cpf);

-- Foreign keys da tabela "funcionario":
ALTER TABLE funcionario ADD CONSTRAINT fk_cpf_superv_cpf
FOREIGN KEY (cpf_supervisor) REFERENCES funcionario (cpf);

-- Constraints adicionais da tabela "funcionario":
ALTER TABLE funcionario ADD CONSTRAINT ck_func_sexo
CHECK (sexo IN ('M', 'F'));

ALTER TABLE funcionario ADD CONSTRAINT ck_func_salario
CHECK (salario >= 0);

-- Comentários da tabela "funcionario":
COMMENT ON TABLE funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN funcionario.nome_meio IS 'Letra inicial do nome do meio.';
COMMENT ON COLUMN funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN funcionario.data_nascimento IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN funcionario.numero_departamento IS 'Número do departamento do funcionário.';



/* --------------------------------------------------------------------------- */
/* DEPENDENTE:                                                                 */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "dependente" e dos demais objetos   */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "dependente":
\echo
\echo Criando a tabela "dependente" e objetos relacionados:
CREATE TABLE dependente (
                cpf_funcionario CHAR(11)    CONSTRAINT nn_depend_cpf_func NOT NULL,
                nome_dependente VARCHAR(15) CONSTRAINT nn_depend_nome_dep NOT NULL,
                sexo            CHAR(1),
                data_nascimento DATE,
                parentesco      VARCHAR(15)
);

-- Primary key da tabela "dependente":
ALTER TABLE dependente ADD CONSTRAINT pk_dependente
PRIMARY KEY (cpf_funcionario, nome_dependente);

-- Foreign keys da tabela "dependente":
ALTER TABLE dependente ADD CONSTRAINT fk_cpf_func_cpf
FOREIGN KEY (cpf_funcionario) REFERENCES funcionario (cpf);

-- Constraints adicionais da tabela "dependente":
ALTER TABLE dependente ADD CONSTRAINT ck_depend_sexo
CHECK (sexo IN ('M', 'F'));

-- Comentários da tabela "dependente": 
COMMENT ON TABLE dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';



/* --------------------------------------------------------------------------- */
/* DEPARTAMENTO:                                                               */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "departamento" e dos demais objetos */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "departamento":
\echo
\echo Criando a tabela "departamento" e objetos relacionados:
CREATE TABLE departamento (
                numero_departamento INTEGER     CONSTRAINT nn_dept_num_dept   NOT NULL,
                nome_departamento   VARCHAR(15) CONSTRAINT nn_dept_nome_dept  NOT NULL,
                cpf_gerente         CHAR(11)    CONSTRAINT nn_dept_cpf_gerent NOT NULL,
                data_inicio_gerente DATE
);

-- Primary key da tabela "departamento":
ALTER TABLE departamento ADD CONSTRAINT pk_departamento
PRIMARY KEY (numero_departamento);

-- Foreign keys da tabela "departamento":
ALTER TABLE departamento ADD CONSTRAINT fk_cpf_ger_cpf
FOREIGN KEY (cpf_gerente) REFERENCES funcionario (cpf);

-- Constraints adicionais da tabela "departamento":
ALTER TABLE departamento ADD CONSTRAINT un_dept_nome_dept
UNIQUE (nome_departamento);

CREATE UNIQUE INDEX uidx_dept_nome_dept ON departamento (nome_departamento);

ALTER TABLE departamento ADD CONSTRAINT ck_dept_num_dept
CHECK (numero_departamento >= 1);

-- Comentários da tabela "departamento":
COMMENT ON TABLE departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';



/* --------------------------------------------------------------------------- */
/* PROJETO:                                                                    */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "projeto" e dos demais objetos      */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "projeto":
\echo
\echo Criando a tabela "projeto" e objetos relacionados:
CREATE TABLE projeto (
                numero_projeto      INTEGER      CONSTRAINT nn_proj_num_proj  NOT NULL,
                nome_projeto        VARCHAR(15)  CONSTRAINT nn_proj_nome_proj NOT NULL,
                local_projeto       VARCHAR(15),
                numero_departamento INTEGER      CONSTRAINT nn_proj_num_dept  NOT NULL
);

-- Primary key da tabela "projeto":
ALTER TABLE projeto ADD CONSTRAINT pk_projeto
PRIMARY KEY (numero_projeto);

-- Foreign keys da tabela "projeto":
ALTER TABLE projeto ADD CONSTRAINT fk_proj_num_dept_num_dept
FOREIGN KEY (numero_departamento) REFERENCES departamento (numero_departamento);

-- Constraints adicionais da tabela "projeto":
ALTER TABLE projeto ADD CONSTRAINT un_projeto_nome_projeto
UNIQUE (nome_projeto);

CREATE UNIQUE INDEX uidx_proj_nome_proj ON projeto (nome_projeto);

-- Comentários da tabela "projeto": 
COMMENT ON TABLE projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';



/* --------------------------------------------------------------------------- */
/* TRABALHA EM:                                                                */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "trabalha_em" e dos demais objetos  */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "trabalha_em":
\echo
\echo Criando a tabela "trabalha_em" e objetos relacionados:
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11)     CONSTRAINT nn_trab_em_cpf_func NOT NULL,
                numero_projeto  INTEGER      CONSTRAINT nn_trab_em_num_proj NOT NULL,
                horas           DECIMAL(3,1)
);

-- Primary key da tabela "trabalha_em":
ALTER TABLE trabalha_em ADD CONSTRAINT pk_trabalha_em
PRIMARY KEY (cpf_funcionario, numero_projeto);

-- Foreign keys da tabela "trabalha_em":
ALTER TABLE trabalha_em ADD CONSTRAINT fk_trab_em_cpf_func_cpf
FOREIGN KEY (cpf_funcionario) REFERENCES funcionario (cpf);

ALTER TABLE trabalha_em ADD CONSTRAINT fk_trab_em_num_proj_num_proj
FOREIGN KEY (numero_projeto) REFERENCES projeto (numero_projeto);

-- Constraints adicionais da tabela "trabalha_em":
ALTER TABLE trabalha_em ADD CONSTRAINT ck_trab_em_horas
CHECK (horas >= 0);

-- Comentários da tabela "trabalha_em":
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';



/* --------------------------------------------------------------------------- */
/* LOCALIZAÇÕES DO DEPARTAMENTO:                                               */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "localizacoes_departamento" e dos   */
/* demais objetos relacionados (constraints, chaves, checks, etc.).            */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "localizacoes_departamento":
\echo
\echo Criando a tabela "localizacoes_departamento" e objetos relacionados:
CREATE TABLE localizacoes_departamento (
                numero_departamento INTEGER     CONSTRAINT nn_loc_dept_num_dept NOT NULL,
                local               VARCHAR(15) CONSTRAINT nn_loc_dept_local    NOT NULL
);

-- Primary key da tabela "localizacoes_departamento":
ALTER TABLE localizacoes_departamento ADD CONSTRAINT pk_localizacoes_dept
PRIMARY KEY (numero_departamento, local);

-- Foreign keys da tabela "localizacoes_departamento":
ALTER TABLE localizacoes_departamento ADD CONSTRAINT fk_num_dept_num_dept
FOREIGN KEY (numero_departamento) REFERENCES departamento (numero_departamento);

-- Comentários da tabela "localizacoes_departamento":
COMMENT ON TABLE localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';



/* --------------------------------------------------------------------------- */
/* INSERÇÃO DE DADOS NAS TABELAS DO PROJETO DO ELMASRI:                        */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a inserção dos dados nas tabelas do projeto do Elmasri. */
/* --------------------------------------------------------------------------- */

-- Insere dados na tabela "funcionario":
\echo
\echo Inserindo dados na tabela "funcionario":
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) 
	VALUES 
	('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto,35,São Paulo,SP', 'M', 55000, null, 1),
	('Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa,34,São Paulo,SP', 'M', 40000, '88866555576', 5),
	('João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo,SP', 'M', 30000, '33344555587', 5),
	('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av. Arthur de Lima,54,SantoAndré,SP', 'F', 43000, '88866555576', 4),
	('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças,65,Piracicaba,SP', 'M', 38000, '33344555587', 5),
	('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes,74,São Paulo,SP', 'F', 25000, '33344555587', 5),
	('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbira,35,São Paulo,SP', 'M', 25000, '98765432168', 4),
	('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima,35,Curitiba,PR', 'F', 25000, '98765432168', 4)
;

-- Insere dados na tabela "departamento":
\echo
\echo Inserindo dados na tabela "departamento":
INSERT INTO departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) 
	VALUES
	('Pesquisa', 5, '33344555587', '1988-05-22'),
	('Administração', 4, '98765432168', '1995-01-01'),
	('Matriz', 1, '88866555576', '1981-06-19')
;
	
-- Insere dados na tabela "localizacoes_departamento":
\echo
\echo Inserindo dados na tabela "localizacoes_departamento":
INSERT INTO  localizacoes_departamento (numero_departamento, local) 
	VALUES
	(1, 'São Paulo'),
	(4, 'Mauá'),
	(5, 'Santo André'),
	(5, 'Itu'),
	(5, 'São Paulo')
;
	
-- Insere dados na tabela "projeto":
\echo
\echo Inserindo dados na tabela "projeto":
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
	VALUES
	('ProdutoX', 1, 'Santo André', 5),
	('ProdutoY', 2, 'Itu', 5),
	('ProdutoZ', 3, 'São Paulo', 5),
	('Informatização', 10, 'Maué', 4),
	('Reorganização', 20, 'São Paulo', 1),
	('Novosbenefícios', 30, 'Mauá', 4)
;
	
-- Insere dados na tabela "dependente":
\echo
\echo Inserindo dados na tabela "dependente":
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES
	('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
	('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
	('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
	('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
	('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
	('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
	('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa')
;
	
-- Insere dados na tabela "trabalha_em":
\echo
\echo Inserindo dados na tabela "trabalha_em":
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas)
	VALUES
	('12345678966', 1, 32.5),
	('12345678966', 2, 7.5),
	('66688444476', 3, 40.0),
	('45345345376', 1, 20.0),
	('45345345376', 2, 20.0),
	('33344555587', 2, 10.0),
	('33344555587', 3, 10.0),
	('33344555587', 10, 10.0),
	('33344555587', 20, 10.0),
	('99988777767', 30, 30.0),
	('99988777767', 10, 10.0),
	('98798798733', 10, 35.0),
	('98798798733', 30, 5.0),
	('98765432168', 30, 20.0),
	('98765432168', 20, 15.0),
	('88866555576', 20, null)
;
	