 SELECT CONCAT(nombre," ",apellido) FROM autores
 UNION
  SELECT CONCAT(nombre," ",apellidos) FROM usuarios;