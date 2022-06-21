/*
Descrição     : Consulta SQL usando o conceito de Queries Recursivas
              : (ou Hierárquicas) para retornar a hierarquia de classificação
              : de uma tabela de uma empresa real.
										
Autor         : Yuri Soares
Orientador    : prof. Abrantes Araújo Silva Filho
Versão SGBD   : PostgreSQL 14.2
*/

WITH RECURSIVE ListaClassificacao AS (
  SELECT a.codigo, 
         a.nome, 
         a.codigo_pai, 
         1 AS nivel_classificacao, 
         CAST(a.nome AS TEXT) AS classificacao
  FROM classificacao AS a
  WHERE a.codigo_pai IS NULL

  UNION ALL

  SELECT b.codigo, 
         b.nome, 
         b.codigo_pai, 
         lc.nivel_classificacao + 1,
         CAST(lc.classificacao || ' --> ' || b.nome AS TEXT) AS classificacao
  FROM classificacao AS b
  INNER JOIN ListaClassificacao AS lc
  ON b.codigo_pai = lc.codigo 
  WHERE b.codigo_pai IS NOT NULL
  )
SELECT classificacao AS "Classificação dos Produtos"
FROM ListaClassificacao
ORDER BY classificacao;
