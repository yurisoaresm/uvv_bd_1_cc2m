# Problem Set 1
O _Problem Set_ 1 abrange desde o modelo lógico à implementação das relações do projeto e inserção dos dados em dois SGBDs (Sistemas de Gerenciamento de Bancos de Dados): [PostgreSQL](https://www.postgresql.org "Página Inicial PostgreSQL") e [MariaDB/MySQL](https://mariadb.org "Página Inicial MariaDB").

Este projeto foi desenvolvido com a **colaboração** de:
- [Pedro Lima](https://github.com/PedroLimaCarari "Perfil do Pedro Lima"), e
- [Roberto Souza](https://github.com/RobertoBSZ "Perfil do Roberto Souza").

E **orientado** por: [prof. Abrantes Araújo S. Filho](https://github.com/abrantesasf "Perfil do prof. Abrantes Araújo S. Filho").

Este documento explica o passo a passo para conseguir implementar o projeto completo conforme o "Pset 1".

## 1. Git e GitHub
Um pset é um problema extremamente difícil que facilmente leva dias para ser concluído. Para este contexto é preciso ter um SCV (Sistema de Controle de Versão) para auxiliar no processo. Neste problema foi (e é recomendável) usado o [Git](https://git-scm.com/book/pt-br/v2 "Documentação do Git") e o [GitHub](https://docs.github.com/pt "Documentação do GitHub").

## 2. Modelo Lógico
Um modelo lógico é um esquema do problema que ainda não foi implementado no banco de dados, contendo as tabelas e suas relações, atributos tipos de dados, comentários e restrições. Basicamente é o seu esqueleto inicial. A ferramenta usada para isso foi o [SQL Power Architect](http://www.bestofbi.com/page/architect "SQL Power Architect") para ambos os SGBDs.

Primeiramente criamos uma tabela de cada vez no programa e inserimos cada atributo com suas restrições, como NOT NULL e Primary Key (exceto a foreign key: esta vem por último), seu tipo (VARCHAR, CHAR, INTEGER...), tamanho (precision) e o comentário (remark) que será mostrado no banco de dados.

Uma vez completado esta parte, é o momento de fazer as relações entre cada tabela: ligar cada FK a sua respectiva PK e e definir seu **tipo de relacionamento** (1:N, 1:1 ...). Além disso, é preciso categorizar o relacionamento em **indentificado**, caso a PK seja também uma FK, ou **não identificado** (não que essa parte faça muita diferença, mas é bom saber e deixar explícito). Também é necessário incluir as chaves únicas (ou chaves alternativas) por meio de um index na tabela. 

Por fim, é importante fazer uma revisão geral para identificar possíveis problemas no projeto. Este modelo gerará os códigos de SQL com todos as formatações (com alguns poucos desajustes que serão corrigidos posteriormente).

## 3. Implementação no PostreSQL
O projeto foi pensado para ser rodado via um script.sql. Nele deve estar todos os códigos, na ordem correta, para serem executados e criar todo o esquema do modelo lógico no banco de dados.

A primeira coisa é criar um usuário para gerir o nosso banco de dados (não é recomendável usar o usuário padrão do SGBD que, neste caso, é o postgres). Para tanto, usa-se o comando [CREATE ROLE](https://www.postgresql.org/docs/14/sql-createrole.html "Documentação PostgreSQL: CREATE ROLE") com seus devidos privilégios para poder modificar o nosso projeto. Eu criei um **usuário** chamado yuri com **senha** '1234' (obviamente é apenas para teste). Depois, criamos o banco de dados com o usuário criado como proprietário, codificação UTF-8 e permissão para conexão com o comando [CREATE DATABASE](https://www.postgresql.org/docs/14/sql-createdatabase.html "Documentação PostgreSQL: CREATE DATABASE")  (neste projeto, o banco de dados é nomeado **uvv**).

Feito isso, contectamos em uvv com o nosso usuário e criamos o **esquema** chamado "elmasri" (ver [CREATE SCHEMA](https://www.postgresql.org/docs/14/sql-createschema.html "Documentação PostgreSQL: CREATE SCHEMA") ). Isso é preciso para evitar que todas as tabelas sejam criadas no esquema público para evitar conflitos como se, por exemplo, duas tabelas fossem criadas com o mesmo nome (bastaria criá-las em esquemas separados). 

Agora, ainda não estamos no esquema "elmasri". Portanto, tudo que for criado continuará no "public". Antes de criar as tabelas e ir para os próximos passos é preciso alterar o esquema padrão do nosso usuário para o desejado exercutando o comando seguinte:

    ALTER USER <nome do usuário> SET SEARCH_PATH TO elmasri, "$user", public;

Finalmente, é hora de criar as tabelas com todos os detalhes do modelo lógico. Como supracitado, o próprio Power Architect faz a codificação em SQL do projeto. É preciso apenas acrescentar algumas coisas, como as cláusulas CHECK para definir condições de inserção dos dados na tabela (exemplo: não deixar que um salário possua valor negativo), e adicionar os comandos administrativos próprios de cada SGBD.

Para concluir, inserimos os dados em cada tabela. É preciso se atentar a duas coisas: a) a data por padrão tem formato ANO-MÊS-DIA (YYYY-MM-DD), logo é preciso tomar cuidado ao adicioná-las nesse padrão; b) na tabela funcionário não será possível inserir um funcionário cujo cpf_supervisor ainda não tenha sido incluído como cpf, porque um valor de FK não pode ser criado antes que ele já exista como PK.

Para executar o script via terminal¹, basta rodar o comando ("postgre" é o superusuário; lembre-se de não ter nenhum usuário ou banco de dados com o mesmo nome): 

    psql -U postgre -W -f caminho/para/script.sql

Executando o arquivo deste repositório via shell a partir da home²: 

    $ psql -U postgre -W -f ~/uvv_bd_1_cc2m/pset1/scripts/elmasri-postgre.sql

------------

**Observações**: ¹ executar o script em intefaces gráficas (GUIs) pode ocasionar muitas dores de cabeça, pois alguns comandos não rodam sozinhos ou em conjunto, mas via terminal é bem mais simples e até rápido uma vez que todos os passos foram corretamente colocados no script; 

² "a partir da home" quero dizer que você clonou este repositório na sua home.

## 4. Implementação no MariaDB
A partir daqui fica mais fácil implementar o projeto no MariaDB. Voltando para o Power Architect, geramos o código do MySQL a partir do modelo lógico (novamente). O comando para inserir os dados serão exatamente os mesmos usados anteriormente.

Igualmente, antes das tabelas criamos um usuário e senha (idem, yuri e '1234'; observar que aqui o comando será distinto do PostgreSQL: ver [CREATE USER](https://dev.mysql.com/doc/refman/8.0/en/create-user.html "Documentação MySQL: CREATE USER")) e em seguida criar o banco de dados/esquema³ com codificação UTF-8. Pra finalizar este parte, dê as permissões de modificação do banco de dados uvv para o usuário criado.

O primeiro script está pronto e vamos ao segundo. Antes, a razão disso é que ao executar o script via terminal, no momento de alterar o usuário, o SGBD para de executar os comandos conseguintes (serão executados caso você retorne ao usuário root com _exit_). Então, usaremos um [novo script](https://github.com/yurisoaresm/uvv_bd_1_cc2m/blob/readme/pset1/scripts/2-elmasri-mysql.sql "2-elmasri-mysql.sql") para ser executado uma vez conectado ao novo usuário. Nele colocaremos os comandos gerados pelo Power Architect e de inserção. Atenção para alguns pontos importantes:

Como dito anteriormente, pode ser necessário fazer algumas alterações no código do Power Architect. Além das restrições como CHECK, eis as novas alterações: a) para fins de organização (muito necessário em bancos de dados), é preciso acrescentar um nome de indenticação para as restrições de chave primária (o código gerado do PostgreSQL o fez automaticamente) por meio do comando CONSTRAINT <nome_restrição> antes da declaração da PRIMARY KEY; b) nota-se que os comandos para adicionar comentários no MariaDB são feitos por meio de um `ALTER TABLE <nome_tabela> MODIFY COLUMN <nome_atributo> COMMENT`; o problema é que caso as restrições especificadas no CREATE TABLE não sejam novamente incluídas nesse comando, elas serão retiradas (isso mesmo, os NOT NULLs e os CHECKs sumirão, exceto as restrições de chave: elas serão mantidas). Portanto, corrigimos isso recolocando-os⁴. 

Para executarmos o código, usamos (note que primeiro nos conectamos com o root e depois indicamos o script):

    mysql -u root -p 
    mysql> source caminho/para/script1.sql
    // Após conecar-se com o usuário criado
    mysql> source caminho/para/script2.sql

Via shell a partir da home:

    $ mysql -u root -p 
    mysql> ~/uvv_bd_1_cc2m/pset1/scripts/1-elmasri-mysql.sql
    // Após conecar-se com o usuário criado
    mysql> ~/uvv_bd_1_cc2m/pset1/scripts/2-elmasri-mysql.sql

------------

**Observações**: ³ em MySQL não há uma distinção de _database_ e _schema_ como no PostgreSQL; dessa forma, não há diferença entre o comando CREATE DATABASE e CREATE SCHEMA (ver [CREATE DATABASE](https://dev.mysql.com/doc/refman/8.0/en/create-database.html "Documentação MySQL: CREATE DATABASE")).

⁴ a cláusula CHECK deve ser inserida após o COMMENT, ou seja, por última.