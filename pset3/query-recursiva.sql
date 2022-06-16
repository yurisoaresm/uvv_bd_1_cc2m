WITH RECURSIVE ListaClassificacao AS  
  (SELECT a.codigo, a.nome, a.codigo_pai, 1 AS nivel_classificacao
  FROM classificacao AS a
  WHERE a.codigo_pai IS NULL

  UNION ALL

  SELECT b.codigo, b.nome, b.codigo_pai, LC.nivel_classificacao + 1
  FROM classificacao AS b
  INNER JOIN ListaClassificacao AS LC
  ON b.codigo_pai = LC.codigo
  WHERE b.codigo_pai IS NOT NULL)
SELECT * FROM ListaClassificacao;