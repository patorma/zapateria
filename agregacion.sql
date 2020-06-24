 SELECT CONCAT(nombre," ",apellido) AS nombre_completo, "", pais_origen AS email FROM autores
 UNION
  SELECT CONCAT(nombre," ",apellidos) AS nombre_completo, email , "" FROM usuarios;