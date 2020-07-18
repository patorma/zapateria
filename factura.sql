DROP DATABASE IF EXISTS facturaciones;
CREATE DATABASE IF NOT EXISTS facturaciones;

USE facturaciones;

CREATE TABLE IF NOT EXISTS clientes(
    identificacion INT  UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    pais VARCHAR(45) NOT NULL
    
);

CREATE TABLE IF NOT EXISTS productos (
     id INT  UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
     nombre VARCHAR(45) NOT NULL,
     presentacion VARCHAR(400) NOT NULL,
     valor DECIMAL(10,2) NOT NULL
   
);

CREATE TABLE IF NOT EXISTS facturacion(
    id INT  UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
    descuento decimal(5,2) NULL,
    fecha_facturacion DATE NOT NULL,
    impuesto DECIMAL(5,2) NOT NULL,
    identificacion_clientes INT  UNSIGNED NOT NULL,
    id_producto INT  UNSIGNED NOT NULL
    FOREIGN KEY(id_producto) REFERENCES productos(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(identificacion_clientes) REFERENCES clientes(identificacion)
    ON UPDATE CASCADE ON DELETE CASCADE

);



CREATE TABLE IF NOT EXISTS inventario(
    id INT  UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
    tipo_movimiento ENUM('entrada', 'salida') NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
     id_producto INT  UNSIGNED NOT NULL,
     FOREIGN KEY (id_producto) REFERENCES productos(id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO clientes (nombre,pais) 
 VALUES ('Patricio Contreras','Chile'),
        ('Saul Palma','Chile'),
        ('Rodrigo Carrasco','Chile'),
        ('Cesar Guerrero','Argentina'),
        ('Rodrigo carrasco','Colombia'),
        ('Juan Perez','Chile'),
        ('Daniela Cifuentes','Bolivia'),
        ('Dammaris Torres','Argentina'),
        ('Fernando Suarez','Mexico'),
        ('Pablo Rodriguez','Chile');

-- se usa el valor de peso chileno en el registro de productos
INSERT INTO productos (nombre, presentacion,valor)
   VALUES ('zapatillas nike','son unas zapatillas blancas','35000'),
    ('zapatillas Topo','son unas zapatillas blancas','35000'),
    ('zapatillas bata','son unas zapatillas blancas','45000'),
    ('zapatos lady','son unas zapatos cafe de mujer','25000'),
    ('zapatos foca','son unos zapatos de color negro de hombre','35000'),
    ('zapatillas deport','son unas zapatillas blancas para correr','75000'),
    ('botines','son unos botines amariilos para el invierno','25000'),
    ('zapatillas caballo feliz','son unas zapatillas para caminar','18000'),
    ('botas Delfin','son unas botas cafes para el invierno','50000'),
    ('zapatillas rapidas','son unas zapatillas azules para bailar','65000');


-- se crea un procedimiento para que cuando se registre un producto se agregue al inventario
DELIMITER //
CREATE PROCEDURE registro(producto_id INT UNSIGNED,fecha DATE, cantidad INT ,movimiento VARCHAR(10))
BEGIN 
    INSERT INTO inventario(tipo_movimiento, fecha,cantidad,id_producto) VALUES (movimiento,fecha,cantidad,producto_id);
END//
DELIMITER ;

CALL registro(1,'2020-05-13',4,'entrada');
CALL registro(2,'2020-05-25',15,'entrada');
CALL registro(7,'2020-05-28',16,'entrada');

SELECT * FROM inventario;

-- se crea un procedimiento para que cuando se venda un producto y se elimine del  inventario
DELIMITER //

CREATE PROCEDURE venta(identificacion_cliente INT UNSIGNED,id_producto2 INT UNSIGNED, 
descuento decimal(5,2),fecha DATE,impuesto decimal(5,2),id_ventario INT UNSIGNED, movimiento VARCHAR(10),
id_factura INT UNSIGNED)
BEGIN
    INSERT INTO facturacion(descuento,fecha_facturacion, impuesto, identificacion_clientes,id_producto) VALUES(descuento,fecha ,impuesto,identificacion_cliente,id_producto2);
    UPDATE inventario SET cantidad = cantidad- 1, tipo_movimiento =movimiento  WHERE id= id and id_producto = id_producto2;
    -- UPDATE productos SET id_factura = id_factura WHERE id= id_producto2;

END//

DELIMITER ;

CALL venta(1,1,0.3,'2020-06-08',0.19,1,'salida',1);
CALL venta (1,7, 0.1, '2020-06-08',0.19,1,'salida',1);
CALL venta (2,2,0.4, '2020-06-18',0.19,2,'salida',2);
CALL venta (3,)
SELECT * FROM inventario;

SELECT * FROM productos;

SET @mensaje1 = 'Clientes y facturaciones asociadas';
SELECT @mensaje1;
SELECT (f.id) as id_factura,(f.fecha_facturacion)as fecha_factura,(f.id_producto)as id_producto,(p.nombre) as producto,(p.valor)as precio,
(f.impuesto) as impuesto,(f.descuento) as descuento,(p.valor + f.impuesto*p.valor - f.descuento)as Total,(c.identificacion) as identificacion,(c.nombre) as nombre_cliente, (c.pais) as pais
from clientes c inner join facturacion f on(c.identificacion = f.identificacion_clientes)
inner join productos p on(f.id_producto = p.id);

SET @mensaje2 ='Facturacion del cliente Patricio Contreras de id =1';
SELECT @mensaje2;
SELECT (f.id) as id_factura,(f.fecha_facturacion)as fecha_factura,(f.id_producto)as id_producto,(p.nombre) as producto,(p.valor)as precio,
(f.impuesto) as impuesto,(f.descuento) as descuento,(p.valor + f.impuesto*p.valor - f.descuento)as Total
from clientes c inner join facturacion f on(c.identificacion = f.identificacion_clientes)
inner join productos p on(f.id_producto = p.id) where c.identificacion = 1;


SET @mensaje3 ='Facturacion del producto zapatillas nike de id=1';
SELECT  @mensaje3 ;
SELECT (f.id) as id_factura,(f.fecha_facturacion)as fecha_factura, (p.id) as id_producto, (p.nombre)as producto,(p.valor)as precio,(f.impuesto) as impuesto,
(f.descuento) as descuento,(p.valor + f.impuesto*p.valor - f.descuento)as Total from productos p inner join facturacion f 
on(p.id = f.id_producto) where p.id= 1;

-- SET @mensaje4 = ''

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