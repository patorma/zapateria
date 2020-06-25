 SELECT CONCAT(nombre," ",apellido) AS nombre_completo, "", pais_origen AS email FROM autores
 UNION
  SELECT CONCAT(nombre," ",apellidos) AS nombre_completo, email , "" FROM usuarios;

-- sin subconsultas
-- SELECT AVG(ventas) FROM libros;
-- --  273.4909
-- SET @promedio = (SELECT AVG(ventas) FROM libros);

-- SELECT 
-- autor_id 
-- FROM libros
--  GROUP BY autor_id 
--  HAVING SUM(ventas) >  @promedio;

SET @promedio = (SELECT AVG(ventas) FROM libros);

-- El orden en la que se ejecutan las subconsultas son del nivel mas bajo al mas alto

-- como es una lista se agrega IN 

SELECT CONCAT(nombre, " ", apellido) AS nombre
FROM autores
WHERE autor_id IN(
SELECT 
autor_id 
FROM libros
 GROUP BY autor_id 
 HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros));

 Disponible
 Agotado
 El hobbit

 SELECT IF(
   EXISTS(SELECT libro_id FROM libros WHERE titulo = 'El hobbit'),
   'Disponible',
   'No Disponible'
 ) AS mensaje;