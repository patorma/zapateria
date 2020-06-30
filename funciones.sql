DELIMITER //
CREATE FUNCTION agregar_dias(fecha DATE,dias INT)
-- Se indica que tipo de dato retorna la funcion
RETURNS DATE
BEGIN
    RETURN fecha + INTERVAL dias DAY;
END//
-- SELECT RAND(); NUMEROS ALETORIOS ENTRE 0  Y 1

-- SELECT ROUND() NUMEROS ALEATORIOS ENTRE  0 Y 100

CREATE FUNCTION obtener_paginas()
RETURNS INT
BEGIN
  SET @paginas = (SELECT (ROUND( RAND() * 100 ) * 4 ));
  RETURN @paginas;
END//

CREATE FUNCTION obtener_ventas() 
RETURNS INT
BEGIN
  SET @paginas = (SELECT (ROUND( RAND() * 100000) * 6));
  RETURN @paginas;
END//

DELIMITER ;


UPDATE libros SET paginas = obtener_paginas();
UPDATE libros SET ventas = obtener_ventas();