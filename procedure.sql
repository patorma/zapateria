-- generar procedimiento almacenado que permita prestar libros
DELIMITER  //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN
    INSERT INTO libros_usuarios(libro_id,usuario_id) VALUES (libro_id, usuario_id);
    UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
    
END//


DELIMITER ;



-- eliminar un procedimiento:
