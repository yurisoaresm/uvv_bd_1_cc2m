# Problem Set 3

O objetivo deste pset é utilizar um conceito complexo de consultas em SQL: `Queries Hierárquicas` (ou Recursivas). Esse tipo de consulta se baseia na ideia de hierarquia e não é facilmente intuitiva (pelo menos não a princípio). 

Este projeto foi **orientado** por: [prof. Abrantes Araújo S. Filho](https://github.com/abrantesasf "Perfil do prof. Abrantes Araújo S. Filho").

## Dependência do Pset1 e a Tabela Classificação

Este projeto depende do banco de dados criado no script do [pset1](https://github.com/yurisoaresm/uvv_bd_1_cc2m/blob/master/pset1/scripts/elmasri-postgre.sql "Script do projeto do Pset1"). Porém, é preciso adicionar uma nova tabela ao projeto, que é o arquivo pset3.sql deste repositório. Ele criará uma tabela chamda "classificacao", com 3 atributos: código, código de pai e produto; além disso, ela também insere os dados na tabela.

Essa tabela existe apenas para o conceito deste pset, e representa uma lista de produtos de uma empresa. Alguns produtos são **"derivados"** de outros produtos (ou seja, pertencem a uma classificação/um tipo de produto). Estes são chamados de "filhos". Os produtos que não derivam de nenhum outro são chamados de "pai". Na tabela, os produtos "pai" possuem `codigo_pai = NULL`, e os "filhos" possuem `codigo_pai = codigo`, onde "codigo" é evidentemente o atributo que identifica seu "pai".

