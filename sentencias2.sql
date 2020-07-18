SELECT
 au.autor_id,CONCAT(au.nombre," ", au.apellido) AS nombre_autor,
COUNT(l.autor_id)AS cantidad_libros 
 FROM autores AS au 
 INNER JOIN libros AS l ON au.autor_id = l.autor_id WHERE au.autor_id = 1 GROUP BY au.autor_id;


 SELECT COUNT(*) FROM libros WHERE autor_id = 1;