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

