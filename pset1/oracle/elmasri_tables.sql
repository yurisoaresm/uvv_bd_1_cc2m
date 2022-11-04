/* =========================================================================== */
/* Funcionário:                                                                */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "funcionario" e dos demais objetos  */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

-- Cria a tabela "funcionario":
\echo
\echo Criando a tabela "funcionario" e objetos relacionados:
CREATE TABLE funcionario (
                cpf                 CHAR(11)       CONSTRAINT nn_func_cpf       NOT NULL,
                primeiro_nome       VARCHAR2(15)   CONSTRAINT nn_func_prim_nome NOT NULL,
                nome_meio           CHAR(1),
                ultimo_nome         VARCHAR2(15)   CONSTRAINT nn_func_ult_nome  NOT NULL,
                data_nascimento     DATE,
                endereco            VARCHAR2(40),
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



/* =========================================================================== */
/* Dependente:                                                                 */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "dependente" e dos demais objetos   */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

-- Cria a tabela "dependente":
\echo
\echo Criando a tabela "dependente" e objetos relacionados:
CREATE TABLE dependente (
                cpf_funcionario CHAR(11)    CONSTRAINT nn_depend_cpf_func NOT NULL,
                nome_dependente VARCHAR2(15) CONSTRAINT nn_depend_nome_dep NOT NULL,
                sexo            CHAR(1),
                data_nascimento DATE,
                parentesco      VARCHAR2(15)
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



/* =========================================================================== */
/* Departamento:                                                               */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "departamento" e dos demais objetos */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

-- Cria a tabela "departamento":
\echo
\echo Criando a tabela "departamento" e objetos relacionados:
CREATE TABLE departamento (
                numero_departamento INTEGER     CONSTRAINT nn_dept_num_dept   NOT NULL,
                nome_departamento   VARCHAR2(15) CONSTRAINT nn_dept_nome_dept  NOT NULL,
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



/* =========================================================================== */
/* Projeto:                                                                    */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "projeto" e dos demais objetos      */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

-- Cria a tabela "projeto":
\echo
\echo Criando a tabela "projeto" e objetos relacionados:
CREATE TABLE projeto (
                numero_projeto      INTEGER      CONSTRAINT nn_proj_num_proj  NOT NULL,
                nome_projeto        VARCHAR2(15)  CONSTRAINT nn_proj_nome_proj NOT NULL,
                local_projeto       VARCHAR2(15),
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



/* =========================================================================== */
/* Trabalha em:                                                                */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "trabalha_em" e dos demais objetos  */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

-- Cria a tabela "trabalha_em":
\echo
\echo Criando a tabela "trabalha_em" e objetos relacionados:
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11)     CONSTRAINT nn_trab_em_cpf_func NOT NULL,
                numero_projeto  INTEGER      CONSTRAINT nn_trab_em_num_proj NOT NULL,
                horas           NUMBER(3,1)
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



/* =========================================================================== */
/* Localizações de departamento:                                               */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "localizacoes_departamento" e dos   */
/* demais objetos relacionados (constraints, chaves, checks, etc.).            */
/* =========================================================================== */

-- Cria a tabela "localizacoes_departamento":
\echo
\echo Criando a tabela "localizacoes_departamento" e objetos relacionados:
CREATE TABLE localizacoes_departamento (
                numero_departamento INTEGER     CONSTRAINT nn_loc_dept_num_dept NOT NULL,
                local               VARCHAR2(15) CONSTRAINT nn_loc_dept_local    NOT NULL
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