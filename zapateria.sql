-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zapateria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zapateria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zapateria` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema zapateria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zapateria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zapateria` DEFAULT CHARACTER SET utf8 ;
USE `zapateria` ;

-- -----------------------------------------------------
-- Table `zapateria`.`facturacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zapateria`.`facturacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descuento` DECIMAL(5,2) NULL,
  `fecha_facturacion` DATE NOT NULL,
  `impuesto` DECIMAL(5,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zapateria`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zapateria`.`inventario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_movimiento` ENUM('entrada', 'salida') NOT NULL,
  `fecha` DATE NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zapateria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zapateria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `presentacion` VARCHAR(400) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `id_facturacion` INT NULL,
  `id_inventario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productos_facturacion1_idx` (`id_facturacion` ASC) VISIBLE,
  INDEX `fk_productos_inventario1_idx` (`id_inventario` ASC) VISIBLE,
  CONSTRAINT `fk_productos_facturacion1`
    FOREIGN KEY (`id_facturacion`)
    REFERENCES `zapateria`.`facturacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_inventario1`
    FOREIGN KEY (`id_inventario`)
    REFERENCES `zapateria`.`inventario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zapateria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zapateria`.`clientes` (
  `identificacion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`identificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zapateria`.`productos_comprados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zapateria`.`productos_comprados` (
  `identificacion_clientes` INT NOT NULL,
  `id_productos` INT NOT NULL,
  PRIMARY KEY (`identificacion_clientes`, `id_productos`),
  INDEX `fk_clientes_has_productos_productos1_idx` (`id_productos` ASC) VISIBLE,
  INDEX `fk_clientes_has_productos_clientes_idx` (`identificacion_clientes` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_has_productos_clientes`
    FOREIGN KEY (`identificacion_clientes`)
    REFERENCES `zapateria`.`clientes` (`identificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_productos_productos1`
    FOREIGN KEY (`id_productos`)
    REFERENCES `zapateria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `zapateria` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
