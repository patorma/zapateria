-- 1 Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días.

-- usuarios,libros_usuarios, libros

SELECT  DISTINCT
  u.usuario_id,
  CONCAT(u.nombre, " ", u.apellidos) AS nombre_usuario
  FROM usuarios AS u
  INNER JOIN libros_usuarios AS lu ON u.usuario_id = lu.usuario_id
            AND lu.fecha_creacion >= CURDATE() - INTERVAL 10 DAY
  INNER JOIN libros AS li ON lu.libro_id = li.libro_id; 


--2 Obtener a todos los usuarios que no ha realizado ningún préstamo.
SELECT 
    u.usuario_id,
    CONCAT(u.nombre, " ", u.apellidos) AS nombre_usuario,
    lu.libro_id
FROM libros_usuarios AS lu 
RIGHT JOIN usuarios AS u  ON lu.usuario_id = u.usuario_id
WHERE lu.libro_id IS NULL GROUP BY u.usuario_id;

-- 3 Listar de forma descendente a los cinco usuarios con más préstamos.

SELECT 
   u.usuario_id,
   CONCAT(u.nombre, " ", u.apellidos) AS nombre_usuario,
   lu.libro_id,
   COUNT(lu.libro_id) AS libros_prestados
FROM usuarios AS u 
INNER JOIN libros_usuarios AS lu ON u.usuario_id = lu.usuario_id 
INNER JOIN libros AS li ON lu.libro_id = li.libro_id GROUP BY u.usuario_id ORDER BY COUNT(lu.libro_id) DESC 
LIMIT 5;

-- 4 Listar 5 títulos con más préstamos en los últimos 30 días.
SELECT DISTINCT 
    li.libro_id,
    li.titulo,
    COUNT(lu.libro_id) AS libros_prestados
FROM libros_usuarios AS lu 
INNER JOIN libros AS li  ON li.libro_id = lu.libro_id 
 AND lu.fecha_creacion >= CURDATE() - INTERVAL 30 DAY
GROUP BY lu.libro_id
ORDER BY COUNT(lu.libro_id) DESC
LIMIT 5;

-- 5 Obtener el título de todos los libros que no han sido prestados.
SELECT DISTINCT 
li.libro_id,
    li.titulo
FROM libros AS li 
LEFT JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id
WHERE lu.libro_id IS NULL GROUP BY li.libro_id;


-- 6 Obtener la cantidad de libros prestados el día de hoy.
-- se pone la fecha_creacion dentro de DATE() para saber si es igualñm a la fecha de hoy

SELECT COUNT(lu.libro_id) 
FROM libros_usuarios AS lu 
INNER JOIN libros AS li  ON li.libro_id = lu.libro_id 
 AND DATE(lu.fecha_creacion) = CURDATE();

-- 7 Obtener la cantidad de libros prestados por el autor con id 1.
SELECT COUNT(lu.libro_id) AS cantidad
FROM libros_usuarios AS lu 
INNER JOIN libros AS li  ON li.libro_id = lu.libro_id WHERE li.autor_id = 1;

-- 8 Obtener el nombre completo de los cinco autores con más préstamos.
SELECT DISTINCT 
     au.autor_id,
     CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
    COUNT(lu.libro_id) AS libros_prestados
FROM autores AS au    
INNER JOIN libros  AS li ON au.autor_id = li.autor_id
INNER JOIN libros_usuarios AS lu  ON li.libro_id = lu.libro_id 
GROUP BY au.autor_id
ORDER BY COUNT(lu.libro_id) DESC
LIMIT 5;

-- 9 Obtener el título del libro con más préstamos esta semana.

SELECT DISTINCT 
    li.libro_id,
    li.titulo,
    COUNT(lu.libro_id) AS libros_prestados
FROM libros_usuarios AS lu 
INNER JOIN libros AS li  ON li.libro_id = lu.libro_id 
 AND lu.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY lu.libro_id
ORDER BY COUNT(lu.libro_id) DESC
LIMIT 0,1;



