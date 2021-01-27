DROP DATABASE IF EXISTS gastos_agenda;
CREATE DATABASE IF NOT EXISTS gastos_agenda CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

USE gastos_agenda;

CREATE TABLE IF NOT EXISTS roles(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    activo TINYINT(1) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS usuarios(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    email  VARCHAR(255) NOT NULL,
    contrasena VARCHAR(12) NOT NULL,
    estado ENUM('activo','pendiente','inactivo') NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    rol_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE CASCADE

)ENGINE=INNODB;

-- CREATE TABLE IF NOT EXISTS tipos(
--     id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
--     tipo VARCHAR(50) NOT NULL,
--     fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
-- )ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS gastos(
     id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
     nombre VARCHAR(60) NOT NULL,
     valor INT UNSIGNED NOT NULL,
     tipo ENUM ('GASTO_COMUN','OTROS') NOT NULL,
     descripcion VARCHAR(400) NOT NULL,
     cantidad INT UNSIGNED NOT NULL,
     nombre_local VARCHAR(60) NOT NULL,
     ciudad  VARCHAR(45) NOT NULL,
     fecha_gasto DATE NOT NULL,
     usuario_id INT UNSIGNED NOT NULL,
     FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
)ENGINE=INNODB;


/*
CREATE TABLE IF NOT EXISTS detalle_gastos(
     id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
     descripcion VARCHAR(400) NOT NULL,
     cantidad INT UNSIGNED NOT NULL,
     nombre_local VARCHAR(60) NOT NULL,
     ciudad  VARCHAR(45) NOT NULL,
     gasto_id INT UNSIGNED NOT NULL,
     FOREIGN KEY (gasto_id) REFERENCES gastos(id) ON DELETE CASCADE 

)ENGINE=INNODB;*/

CREATE TABLE IF NOT EXISTS notas(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(400) NOT NULL,
    fecha DATE NOT NULL,
    usuario_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE 
)ENGINE=INNODB;

-- CREA LOS ROLES INICIALES DE ADMINISTRADOR E INVITADO
INSERT INTO roles (nombre,activo) VALUES ('ADMINISTRADOR',1), ('GUEST',1);

-- CREA EL USUARIO ADMINISTRADOR DEL SISTEMA
INSERT INTO usuarios(nombre, apellidos,email, contrasena,estado,rol_id) 
        VALUES('Patricio', 'Contreras', 'patorma@yahoo.com','golotopo','activo',1);

-- ACTUALIZA LA TABLA PARA QUE POR DEFECTO
-- TODOS LOS USUARIOS SEAN INVITADOS
ALTER TABLE usuarios ALTER COLUMN rol_id SET DEFAULT 2;

INSERT INTO usuarios(nombre, apellidos,email, contrasena,estado) 
        VALUES('Carlos', 'Suarez', 'gato@gmail.com','poto','activo');
-- INSERT INTO gastos (nombre,valor,fecha_gasto,usuario_id ) VALUES()

-- Crea los tipos de gastos
-- INSERT INTO tipos (tipo) VALUES ('gasto común');
-- INSERT INTO tipos (tipo) VALUES ('supermercado');
-- INSERT INTO tipos (tipo) VALUES ('ferreteria');
-- INSERT INTO tipos (tipo) VALUES ('vega');

-- Crea gastos de ejemplos
INSERT INTO gastos (nombre,valor,tipo,fecha_gasto, descripcion,cantidad,nombre_local,ciudad,usuario_id) 
VALUES ('Luz',17000,'GASTO_COMUN','2021-01-13','Se fue a pagar la boleta de luz de frontel',1,'sucursal frontel','Laja',2);

INSERT INTO gastos (nombre,valor,tipo,fecha_gasto, descripcion,cantidad,nombre_local,ciudad,usuario_id) 
VALUES ('Agua',7000,'GASTO_COMUN','2021-01-10','Se fue a pagar la boleta del agua',1,'supermercado unico','Laja',2);

INSERT INTO gastos (nombre,valor,tipo,fecha_gasto, descripcion,cantidad,nombre_local,ciudad,usuario_id) 
VALUES ('Supermercado',25000,'OTROS','2021-01-25','Se compro carne, botella de limon, sarten y bolsas de yogurt',4,'supermercado unimarc','Laja',2);

-- INSERT INTO detalle_gastos (descripcion,cantidad,nombre_local,ciudad,gasto_id) 
-- VALUES ('Se fue a pagar la boleta de luz de frontel',1,'sucursal frontel','Laja',1);

-- INSERT INTO detalle_gastos (descripcion,cantidad,nombre_local,ciudad,gasto_id) 
-- VALUES ('Se fue a pagar la boleta del agua',1,'supermercado unico','Laja',2);

-- INSERT INTO detalle_gastos (descripcion,cantidad,nombre_local,ciudad,gasto_id) 
-- VALUES ('Se compro carne, botella de limon, sarten y bolsas de yogurt',4,'supermercado unimarc','Laja',3);

SELECT (g.tipo) AS tipo, (g.nombre) AS gasto,(g.valor) AS valor, (g.descripcion) AS descripcion, (g.cantidad) AS cantidad,(g.nombre_local ) AS local,(g.ciudad) AS ciudad ,(g.fecha_gasto) AS fecha FROM gastos g;

-- SELECT (d.descripcion) AS descripcion, (d.cantidad) AS cantidad,(d.nombre_local ) AS local,(d.ciudad) AS ciudad from detalle_gastos AS d;

-- SELECT (g.tipo) AS tipo,(g.nombre) AS gasto,(g.valor) AS valor,(d.descripcion) AS
--  descripcion,
-- (d.cantidad) AS cantidad,(d.nombre_local) AS local,(d.ciudad) AS ciudad, (g.fecha_gasto) AS fecha
--  FROM  gastos AS g INNER JOIN  detalle_gastos AS d ON(g.id = d.gasto_id);
