-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`dimensao_orgao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dimensao_orgao` (
  `id_orgao` INT NOT NULL,
  `orgao_superior` VARCHAR(45) NULL,
  `orgao_subordinado` VARCHAR(45) NULL,
  `unidade_orcamentaria` VARCHAR(45) NULL,
  PRIMARY KEY (`id_orgao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dimensao_programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dimensao_programa` (
  `id_dimensao_programa` INT NOT NULL,
  `programa_orcamentario` VARCHAR(45) NULL,
  `acao` VARCHAR(45) NULL,
  PRIMARY KEY (`id_dimensao_programa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dimensao_area_atuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dimensao_area_atuacao` (
  `id_dimensao_area_atuacao` INT NOT NULL,
  `funcao` VARCHAR(45) NULL,
  `subfuncao` VARCHAR(45) NULL,
  PRIMARY KEY (`id_dimensao_area_atuacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dimensao_temporal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dimensao_temporal` (
  `id_dimensao_temporal` INT NOT NULL,
  `mes` VARCHAR(45) NULL,
  `ano` VARCHAR(45) NULL,
  PRIMARY KEY (`id_dimensao_temporal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fato_orcado_liquidado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fato_orcado_liquidado` (
  `valor_orcado` VARCHAR(45) NULL,
  `valor_liquidado` VARCHAR(45) NULL,
  `dimensao_orgao_id_orgao` INT NOT NULL,
  `dimensao_programa_id_dimensao_programa` INT NOT NULL,
  `dimensao_area_atuacao_id_dimensao_area_atuacao` INT NOT NULL,
  `dimensao_temporal_id_dimensao_temporal` INT NOT NULL,
  INDEX `fk_fato_orcado_liquidado_dimensao_orgao_idx` (`dimensao_orgao_id_orgao` ASC) VISIBLE,
  INDEX `fk_fato_orcado_liquidado_dimensao_programa1_idx` (`dimensao_programa_id_dimensao_programa` ASC) VISIBLE,
  INDEX `fk_fato_orcado_liquidado_dimensao_area_atuacao1_idx` (`dimensao_area_atuacao_id_dimensao_area_atuacao` ASC) VISIBLE,
  INDEX `fk_fato_orcado_liquidado_dimensao_temporal1_idx` (`dimensao_temporal_id_dimensao_temporal` ASC) VISIBLE,
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_orgao`
    FOREIGN KEY (`dimensao_orgao_id_orgao`)
    REFERENCES `mydb`.`dimensao_orgao` (`id_orgao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_programa1`
    FOREIGN KEY (`dimensao_programa_id_dimensao_programa`)
    REFERENCES `mydb`.`dimensao_programa` (`id_dimensao_programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_area_atuacao1`
    FOREIGN KEY (`dimensao_area_atuacao_id_dimensao_area_atuacao`)
    REFERENCES `mydb`.`dimensao_area_atuacao` (`id_dimensao_area_atuacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_temporal1`
    FOREIGN KEY (`dimensao_temporal_id_dimensao_temporal`)
    REFERENCES `mydb`.`dimensao_temporal` (`id_dimensao_temporal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
