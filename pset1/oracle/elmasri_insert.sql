/* =========================================================================== */
/* INSERÇÃO DE DADOS NAS TABELAS DO PROJETO DO ELMASRI:                        */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a inserção dos dados nas tabelas do projeto do Elmasri. */
/* =========================================================================== */

-- Insere dados na tabela "funcionario":
\echo
\echo Inserindo dados na tabela "funcionario":
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'Jorge', 'E', 'Brito', '88866555576', DATE '10-11-1937', 'Rua do Horto,35,São Paulo,SP', 'M', 55000, null, 1
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'Fernando', 'T', 'Wong', '33344555587', DATE '08-12-1955', 'Rua da Lapa,34,São Paulo,SP', 'M', 40000, '88866555576', 5
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'João', 'B', 'Silva', '12345678966', DATE '09-01-1965', 'Rua das Flores, 751, São Paulo,SP', 'M', 30000, '33344555587', 5
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'Jennifer', 'S', 'Souza', '98765432168', DATE '20-06-1941', 'Av. Arthur de Lima,54,SantoAndré,SP', 'F', 43000, '88866555576', 4
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'Ronaldo', 'K', 'Lima', '66688444476', DATE '15-09-1962', 'Rua Rebouças,65,Piracicaba,SP', 'M', 38000, '33344555587', 5
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'Joice', 'A', 'Leite', '45345345376', DATE '31-07-1972', 'Av. Lucas Obes,74,São Paulo,SP', 'F', 25000, '33344555587', 5
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'André', 'V', 'Pereira', '98798798733', DATE '29-03-1969', 'Rua Timbira,35,São Paulo,SP', 'M', 25000, '98765432168', 4
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
	'Alice', 'J', 'Zelaya', '99988777767', DATE '19-01-1968', 'Rua Souza Lima,35,Curitiba,PR', 'F', 25000, '98765432168', 4
);

-- Insere dados na tabela "departamento":
\echo
\echo Inserindo dados na tabela "departamento":
INSERT INTO departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) VALUES (
	'Pesquisa', 5, '33344555587', DATE '22-05-1988'
);
INSERT INTO departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) VALUES (
	'Administração', 4, '98765432168', DATE '01-01-1995'
);
INSERT INTO departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) VALUES (
	'Matriz', 1, '88866555576', DATE '19-06-1981'
);

-- Insere dados na tabela "localizacoes_departamento":
\echo
\echo Inserindo dados na tabela "localizacoes_departamento":
INSERT INTO  localizacoes_departamento (numero_departamento, local) VALUES (
	1, 'São Paulo'
);
INSERT INTO  localizacoes_departamento (numero_departamento, local) VALUES (
	4, 'Mauá'
);
INSERT INTO  localizacoes_departamento (numero_departamento, local) VALUES (
	5, 'Santo André'
);
INSERT INTO  localizacoes_departamento (numero_departamento, local) VALUES (
	5, 'Itu'
);
INSERT INTO  localizacoes_departamento (numero_departamento, local) VALUES (
	5, 'São Paulo'
);
	
-- Insere dados na tabela "projeto":
\echo
\echo Inserindo dados na tabela "projeto":
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES (
	'ProdutoX', 1, 'Santo André', 5
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES (
	'ProdutoY', 2, 'Itu', 5
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES (
	'ProdutoZ', 3, 'São Paulo', 5
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES (
	'Informatização', 10, 'Maué', 4
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES (
	'Reorganização', 20, 'São Paulo', 1
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES (
	'Novosbenefícios', 30, 'Mauá', 4
);
	
-- Insere dados na tabela "dependente":
\echo
\echo Inserindo dados na tabela "dependente":
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'33344555587', 'Alicia', 'F', DATE '05-04-1986', 'Filha'
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'33344555587', 'Tiago', 'M', DATE '25-10-1983', 'Filho'
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'33344555587', 'Janaína', 'F', DATE '03-05-1958', 'Esposa'
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'98765432168', 'Antonio', 'M', DATE '28-02-1942', 'Marido'
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'12345678966', 'Michael', 'M', DATE '04-01-1988', 'Filho'
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'12345678966', 'Alicia', 'F', DATE '30-12-1988', 'Filha'
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES (
	'12345678966', 'Elizabeth', 'F', DATE '05-05-1967', 'Esposa'
);

-- Insere dados na tabela "trabalha_em":
\echo
\echo Inserindo dados na tabela "trabalha_em":
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'12345678966', 1, 32.5
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'12345678966', 2, 7.5
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'66688444476', 3, 40.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'45345345376', 1, 20.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'45345345376', 2, 20.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'33344555587', 2, 10.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'33344555587', 3, 10.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'33344555587', 10, 10.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'33344555587', 20, 10.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'99988777767', 30, 30.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'99988777767', 10, 10.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'98798798733', 10, 35.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'98798798733', 30, 5.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'98765432168', 30, 20.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'98765432168', 20, 15.0
);
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) VALUES (
	'88866555576', 20, null
);
