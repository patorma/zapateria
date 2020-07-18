DROP DATABASE IF EXISTS colegio_prueba;
CREATE DATABASE IF NOT EXISTS colegio_prueba CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

USE colegio_prueba;

CREATE TABLE IF NOT EXISTS colegios(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME DEFAULT current_timestamp
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS asignaturas(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS profesores(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    colegio_id INT UNSIGNED NOT NULL,
    asignatura_id INT UNSIGNED NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    activo TINYINT(1),
    FOREIGN KEY (colegio_id) REFERENCES colegios(id) ON DELETE CASCADE,
    FOREIGN KEY (asignatura_id) REFERENCES asignaturas(id) ON DELETE CASCADE   
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS alumnos(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
     nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS alumnos_asignaturas(
     alumno_id INT UNSIGNED NOT NULL,
     asignatura_id INT UNSIGNED NOT NULL,
     nota DECIMAL(5,2) NOT NULL,
     PRIMARY KEY(alumno_id,asignatura_id),
     FOREIGN KEY (alumno_id) REFERENCES alumnos(id) ON DELETE CASCADE,
     FOREIGN KEY (asignatura_id) REFERENCES asignaturas(id) ON DELETE CASCADE,
     fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
    --  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=INNODB;

-- CREATE TABLE IF NOT EXISTS notas(
--     id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
--     nota DECIMAL(5,2) NOT NULL,
--     alumno_id INT UNSIGNED NOT NULL,
--     FOREIGN KEY (alumno_id) REFERENCES alumnos(id) ON DELETE CASCADE
-- )ENGINE=INNODB;


INSERT INTO colegios(direccion,nombre) 
    VALUES  ('San Martin#345','School pokemon'),
            ('Los Acacios#110','Abejas con miel'),
            ('San Ramon#34','Centro Basico'),
            ('Pedro Valdivia#1010','Teteras Voladoras'),
            ('Las Monjas#11','Super Sayayin'),
            ('Gabriela Mistral#789','Auroro Comilon'),
            ('Balmaceda#80','Focas de agua'),
            ('Ejercito#234','Mariposas Observadoras');

INSERT INTO asignaturas (nombre) 
    VALUES ('Matematicas'),
            ('Quimica'),
            ('Algebra'),
            ('Ciencias Naturales'),
            ('Religion'),
            ('Ingles'),
            ('Castellano'),
            ('Fisica'),
            ('Biologia');

INSERT INTO profesores(nombre,activo,fecha_nacimiento,colegio_id,asignatura_id) 
     VALUES ('Patricio',1,'1981-09-15',1,1),
            ('Daniel',1,'1985-11-24',1,2),
            ('Ivan',1,'1983-09-15',1,9),
            ('Leslie',1,'1995-11-24',2,1),
            ('Pablo',0,'1990-05-06',8,7),
            ('Mario',0,'1980-12-30',8,4),
            ('Mauricio',1,'1981-03-28',7,3),
            ('Pamela',1,'1985-05-06',7,5);


INSERT INTO alumnos(nombre,fecha_nacimiento)
            VALUES('Patricio Contreras', '2004-12-30'),
                  ('Pablo Torres',  '2003-11-24'),
                  ('Saul Palma', '2019-09-15'),
                  ('Daniela Contreras', '2004-03-28'),
                  ('Alex Fernandez','2005-05-06'),
                  ('Iris Marlene','1990-12-30'),
                  ('Daniela Torres', '1981-11-24'),
                  ('Ivan Palma','1995-09-15'),
                  ('Juan Ortiz', '1969-03-28'),
                  ('Fernando Fernando','2019-05-06'),
                  ('Patricio Contreras', '2019-12-30'),
                  ('Maria Cifuentes', '2020-11-24'),
                  ('Pedro Palma', '2008-09-15'),
                  ('Eduardo Yañez', '2007-03-28'),
                  ('Alexia Perez','2006-05-06'),
                  ('Tamara Torres', '2005-12-30'),
                  ('Rodrigo Ortiz', '2006-11-24'),
                  ('Samuel Carrasco','2002-09-15'),
                  ('Sebastian Contreras','2005-03-28'),
                  ('Leslie Fernandez','2019-05-06'),
                  ('Patricio Suarez','2019-12-30'),
                  ('Lorena Suarez',  '2019-11-24'),
                  ('Felicia Palma', '2019-09-15');



INSERT INTO alumnos_asignaturas(alumno_id,asignatura_id,nota)
            VALUES (1, 1,4.5), (2, 1,5.6), (3, 1,1.5),
        (23, 3,3.4), (19, 3,6.8), (16, 3,5.6),
        (17, 3,4.5), (15, 3,6.8), (16, 5,4.0),
        (4, 5, 6.7), (5, 5,6.6), (6, 5,6.9),
         (12, 4, 4.9), (12, 3,3.9), (7, 5,5.9),
        (2, 4,5.5), (2, 6,5.8), (7, 9,6.2);


SOURCE Downloads/zapateria/consultas.sql;
            
