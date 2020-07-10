-- generar procedimiento almacenado que permita prestar libros
-- con OUT Indicamos que obtendremos ese parametro despues que se haya generado el store procedure

DELIMITER  //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT,OUT cantidad INT)
BEGIN
    SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);

    IF cantidad > 0 THEN

        INSERT INTO libros_usuarios(libro_id,usuario_id) VALUES (libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

        SET cantidad = cantidad - 1;

    ELSE 
        SELECT "No es posible realizar el prestamo" AS mensaje_error;

    END IF;
   
    
END//

CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN

    -- OBTENER LA CANTIDAD DE LIBROS PRESTADOS POR EL USUARIO
    SET @cantidad =  (SELECT COUNT(*) FROM libros_usuarios
                            WHERE libros_usuarios.usuario_id = usuario_id);
    CASE
        WHEN @cantidad > 20 THEN
            SELECT "Fanatico" AS mensaje;
        WHEN @cantidad > 10 AND @cantidad < 20 THEN
            SELECT "Aficionado" AS mensaje;
        WHEN @cantidad > 5 AND @cantidad < 10 THEN
            SELECT "Promedio" AS mensaje;
        ELSE 
            SELECT "Nuevo" AS mensaje;
    END CASE;
END//

CREATE PROCEDURE libros_azar()
BEGIN
    SET @iteracion = 0;

    WHILE @iteracion < 5 DO
    --   Obtener un libro al azar
      SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
      SET @iteracion = @iteracion + 1;

    END WHILE;
END//


CREATE PROCEDURE libros_azar()
BEGIN
    SET @iteracion = 0;

    REPEAT
    --   Obtener un libro al azar
      SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
      SET @iteracion = @iteracion + 1;
    -- Se coloca nuestra condicion
    --  Para condicionar nuestro ciclo nos apoyaremos con UNTIL
        -- Nuestra ultima sentencia a ejecutar en nuestro ciclo
      UNTIL @iteracion >= 5
    END REPEAT;
END//
DELIMITER ;

-- Despues se ejecuta una variable despues de ejecutar el procedure con OUT 

-- eliminar un procedimiento:
-- DROP PROCEDURE nombreProcedimiento;

-- SET @cantidad = -1;

-- CALL prestamo(3,20,@cantidad);
-- SELECT @cantidad;


CREATE EVENT libros_gy
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
SET @cantidad = -1;
CALL prestamo(3,20,@cantidad);