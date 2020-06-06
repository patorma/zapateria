DROP DATABASE IF EXISTS facturaciones;
CREATE DATABASE IF NOT EXISTS facturaciones;

USE facturaciones;

CREATE TABLE IF NOT EXISTS clientes(
    identificacion INT  UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    pais VARCHAR(45) NOT NULL
    
);

CREATE TABLE IF NOT EXISTS facturacion(
    id INT  UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descuento decimal(5,2) NULL,
    fecha_facturacion DATE NOT NULL,
    impuesto DECIMAL(5,2) NOT NULL,
    identificacion_clientes INT  UNSIGNED NOT NULL,
    FOREIGN KEY(identificacion_clientes) REFERENCES clientes(identificacion)
    ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS inventario(
    id INT  UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipo_movimiento ENUM('entrada', 'salida') NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL
);

CREATE TABLE IF NOT EXISTS productos (
     id INT  UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
     nombre VARCHAR(45) NOT NULL,
     presentacion VARCHAR(400) NOT NULL,
     valor DECIMAL(10,2) NOT NULL,
     id_inventario INT UNSIGNED  NOT NULL,
     id_facturacion INT UNSIGNED  NOT NULL,
     FOREIGN KEY(id_inventario) REFERENCES inventario (id)
      ON UPDATE CASCADE ON DELETE CASCADE,
     FOREIGN KEY(id_facturacion) REFERENCES facturacion (id)
      ON UPDATE CASCADE ON DELETE CASCADE
);



-- CREATE TABLE IF NOT EXISTS productos_comprados(
--     identificacion_clientes INT UNSIGNED  NOT NULL,
--     id_productos INT UNSIGNED  NOT  NULL,
--     PRIMARY KEY (identificacion_clientes, id_productos),
--     FOREIGN KEY (identificacion_clientes)
--     REFERENCES clientes(identificacion)
--     ON UPDATE CASCADE 
--     ON DELETE CASCADE,
--     FOREIGN KEY (id_productos)
--     REFERENCES productos(id)
--     ON UPDATE CASCADE 
--     ON DELETE CASCADE
-- );

-- INSERT INTO facturacion(descuento,fecha_facturacion,impuesto)
--   VALUES (0.3,'2020-03-15',0.19)


-- INSERT INTO clientes (nombre, pais)
--   VALUES()