# Problem Set 1
O _Problem Set_ 1 desenvolve desde o modelo lógico à implementação das relações do projeto e inserção dos dados em dois SGBDs (Sistemas de Gerenciamento de Bancos de Dados): [PostgreSQL](https://www.postgresql.org "Página Inicial PostgreSQL") e [MariaDB/MySQL](https://mariadb.org "Página Inicial MariaDB").

Este projeto foi desenvolvido com a **colaboração** de:
- [Pedro Lima](https://github.com/PedroLimaCarari "Perfil do Pedro Lima"), e
- [Roberto Souza](https://github.com/RobertoBSZ "Perfil do Roberto Souza").

E **orientado** por: [prof. Abrantes Araújo S. Filho](https://github.com/abrantesasf "Perfil do prof. Abrantes Araújo S. Filho").

Este documento explica o passo a passo para conseguir implementar o projeto completo conforme o "Pset 1".

## 1. Git e GitHub
Um pset é um problema extremamente difícil que facilmente leva dias para ser concluído. Para este contexto é preciso ter um SCV (Sistema de Controle de Versão) para auxiliar no processo. Neste problema foi (e é recomendado) usado o Git e o GitHub.

## 2. Modelo Lógico
Um modelo lógico é um esquema do problema, que não foi implementado, contendo as tabelas e suas relações, os tipos dos dados, atributos, comentários e restrições. Basicamente é o seu esqueleto completo. A ferramenta usada para isso foi o [SQL Power Architect](http://www.bestofbi.com/page/architect "SQL Power Architect") para ambos os SGBDs.

Primeiramente cria-se uma tabela de cada vez e se insere cada atributo com suas restrições, como NOT NULL e Primary Key (exceto a foreign key: esta vem por último), seu tipo (VARCHAR, CHAR, INTEGER...), tamanho e o comentário (Remark) que será mostrado no banco de dados.

Uma vez completado esta parte, é o momento de fazer as relações entre cada tabela: ligar cada FK a sua respectiva PK e seu tipo de relacionamento (1:N, 1:1 ...). Além disso, é preciso categorizar o relacionamento em indentificado, caso a PK seja também uma FK, ou não identificado (não que esta última parte diferença, mas é bom saber e deixar explícito).

Por fim é importante fazer uma revisão geral para identificar possíveis problemas no projeto. Este modelo gerará os códigos de SQL com todos as formatações (com alguns poucos defeitos que serão ajustados posteriormente).

## 3. Implementação do PostreSQL
O projeto foi pensado para ser rodado via um script.sql. Nele deve estar todos os códigos, na ordem correta, para ser executado e conseguir criar todo o esquema do modelo lógico.

A primeira coisa é criar um usuário para gerir o nosso banco de dados (não é recomendável usar o usuário padrão do SGBD que neste caso é o postgres). Para tanto, usa-se o comando [CREATE ROLE](https://www.postgresql.org/docs/14/sql-createrole.html "Documentação PostgreSQL: CREATE ROLE") com seus devidos privilégios. No meu projeto foi criado um **usuário** yuri com **senha** '1234' (obviamente é apenas para teste) e criar o banco de dados  com o usuário criado como proprietário e codificação UTF-8 com o comando [CREATE DATABASE](https://www.postgresql.org/docs/14/sql-createdatabase.html "Documentação PostgreSQL: CREATE DATABASE")  (neste projeto, o banco de dados é nomeado **uvv**).

Feito isso, contecta-se em uvv com o nosso usuário e cria um **esquema** chamado _elmasri_ ([ver CREATE SCHEMA](https://www.postgresql.org/docs/14/sql-createschema.html "Documentação PostgreSQL: CREATE SCHEMA") ). Isso é preciso para evitar que todas as tabelas sejam criadas no esquema público para evitar conflitos como se uma nova tabela for criada com o mesmo nome de outra (basta criá-la em um esquema separado). 

Agora, ainda não estamos no esquema _elmasri_. Portanto, tudo que for criado continuará no _public_. Antes de criar as tabelas e ir para os próximos passos é preciso exercutar o comando seguinte para alterar o esquema atual para o desejado:

`SET SEARCH_PATH TO elmasri, "$user", public;`

Finalmente, é hora de criar as tabelas com todos os detalhes do modelo lógico. Como supracitado, o próprio Power Architect faz a codificação em SQL do projeto. É preciso apenas acrescentar algumas coisas, como as cláusulas CHECK para definir condições de inserção dos dados na tabela (exemplo: não deixar que um salário possua valor negativo).

Para concluir, inserimos os dados em cada tabela. É preciso se atentar a duas coisas: a data por padrão tem formato ANO-MÊS-DIA (YYYY-MM-DD; logo é preciso tomar cuidado ao inseri-la) e na tabela funcionário não será possível inserir um funcionário cujo cpf_supervisor ainda não tenha sido inserido como cpf, porque um valor de FK não pode ser criado antes de que a sua PK exista.