SELECT
    libros.titulo, 
    CONCAT(autores.nombre, " ", autores.apellido) AS nombre_autor,
    libros.fecha_creacion
 FROM libros 
INNER JOIN autores ON libros.autor_id = autores.autor_id
           AND autores.seudonimo IS NOT NULL;



LEFT JOIN 
LEFT OUTER JOIN son lo mismos

usuarios = a
libros_usuarios = b

SELECT 
    CONCAT(nombre," ",apellidos),
    libros_usuarios.libro_id 
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NULL;


libros_usuarios = a
usuarios = b

SELECT 
    CONCAT(nombre," ",apellidos),
    libros_usuarios.libro_id 
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NULL;


SELECT 
    CONCAT(nombre," ",apellidos),
    libros_usuarios.libro_id 
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id;

-- multiples join
-- ---------------------
-- 1 seleccionar nombres de usuarios
-- 2 obtener todos los usuarios que hayan realizado un prestamo
-- 3 listarlibros prestados con autores con seudonimo
-- 4  prestamos que fueron realizados el dia de hoy

SELECT DISTINCT
    CONCAT(usuarios.nombre, " ",usuarios.apellidos) AS nombre_usuario
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
            AND DATE(libros_usuarios.fecha_creacion) = CURDATE() 
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
INNER JOIN autores ON libros.autor_id = autores.autor_id 
            AND autores.seudonimo IS NOT NULL;

-- Productos Cartesianos
-- ------------------------------

-- Es el resultado de unir multiples tablas sin especificar ninguna condicion de union 
-- se trabaja con CROSS JOIN   

-- SE GENERARA UN PRODUCTO CARTESIANO ENTRE USUARIOS Y LIBROS  
 SELECT usuarios.username, libros.titulo FROM usuarios CROSS JOIN libros ORDER BY username DESC;   

--  Insertar el resultado de la query anterior dentro de una tabla mediante CROSS JOIN 

INSERT INTO libros_usuarios (libro_id,usuario_id) SELECT libro_id,usuario_id FROM usuarios CROSS JOIN libros;