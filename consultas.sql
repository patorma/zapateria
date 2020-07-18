-- 1 Consulta que obtenga todos los profesores de un colegio ordenados por nombre.
SELECT 
(p.nombre)AS nombre_profesor,p.fecha_nacimiento, p.activo
FROM colegios AS col 
INNER JOIN 
profesores p ON col.id  = p.colegio_id
WHERE col.id =1
GROUP BY p.id ORDER BY p.nombre;

-- 2 Consulta que obtenga todos los alumnos con promedio rojo por asignatura.


SELECT 
(asig.nombre)AS asignatura, (al.nombre) AS alumno, (als.nota) AS nota_alumno
FROM asignaturas AS asig 
INNER JOIN alumnos_asignaturas als ON asig.id = als.asignatura_id 
INNER JOIN alumnos AS al ON als.alumno_id = al.id
WHERE als.nota < 4.00
GROUP BY al.id;

-- 3 Consulta que contenga el alumno con mejor nota por asignatura.
SELECT 
(asig.nombre)AS asignatura, (al.nombre) AS alumno, MAX(als.nota) AS nota_alumno
FROM asignaturas AS asig 
INNER JOIN alumnos_asignaturas als ON asig.id = als.asignatura_id 
INNER JOIN alumnos AS al ON als.alumno_id = al.id;