-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema transparencia
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `transparencia` DEFAULT CHARACTER SET utf8 ;
USE `transparencia` ;

-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_funcao` (
  `id_funcao` INT NOT NULL AUTO_INCREMENT,
  `nome_funcao` VARCHAR(500) NULL,
  PRIMARY KEY (`id_funcao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_ano_funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_ano_funcao` (
  `id_ano_funcao` INT NOT NULL,
  `ano` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ano_funcao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transparencia`.`fato_funcao_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`fato_funcao_total` (
  `dimensao_funcao_id_funcao` INT NOT NULL,
  `dimensao_ano_funcao_id_ano_funcao` INT NOT NULL,
  `valor_liquidado` DECIMAL(64,2) NULL,
  INDEX `fk_table1_dimensao_funcao_idx` (`dimensao_funcao_id_funcao` ASC) VISIBLE,
  INDEX `fk_table1_dimensao_ano_funcao1_idx` (`dimensao_ano_funcao_id_ano_funcao` ASC) VISIBLE,
  CONSTRAINT `fk_table1_dimensao_funcao`
    FOREIGN KEY (`dimensao_funcao_id_funcao`)
    REFERENCES `transparencia`.`dimensao_funcao` (`id_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_dimensao_ano_funcao1`
    FOREIGN KEY (`dimensao_ano_funcao_id_ano_funcao`)
    REFERENCES `transparencia`.`dimensao_ano_funcao` (`id_ano_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_programas` (
  `id_programas` INT NOT NULL AUTO_INCREMENT,
  `nome_programa` VARCHAR(500) NULL,
  PRIMARY KEY (`id_programas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_ano_programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_ano_programa` (
  `id_ano_programa` INT NOT NULL,
  `ano` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ano_programa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transparencia`.`fato_programa_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`fato_programa_total` (
  `valor_liquidado` DECIMAL(64,2) NULL,
  `dimensao_programa_id_programa` INT NOT NULL,
  `dimensao_ano_programa_id_ano_programa` INT NOT NULL,
  FOREIGN KEY (`dimensao_programa_id_programa`) REFERENCES `transparencia`.`dimensao_programas` (`id_programas`),
  FOREIGN KEY (`dimensao_ano_programa_id_ano_programa`) REFERENCES `transparencia`.`dimensao_ano_programa` (`id_ano_programa`)
  ) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_ano_orgao_superior`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_ano_orgao_superior` (
  `id_ano` INT NOT NULL,
  `ano` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ano`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_area_atuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_area_atuacao` (
  `id_dimensao_area_atuacao` INT NOT NULL AUTO_INCREMENT,
  `funcao` VARCHAR(500) NULL DEFAULT NULL,
  `subfuncao` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_dimensao_area_atuacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 745
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_orgao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_orgao` (
  `id_orgao` INT NOT NULL AUTO_INCREMENT,
  `orgao_superior` VARCHAR(500) NULL DEFAULT NULL,
  `orgao_subordinado` VARCHAR(500) NULL DEFAULT NULL,
  `unidade_orcamentaria` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_orgao`))
ENGINE = InnoDB
AUTO_INCREMENT = 725
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_orgao_superior`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_orgao_superior` (
  `id_orgao_superior` INT NOT NULL AUTO_INCREMENT,
  `nome_orgao_superior` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_orgao_superior`))
ENGINE = InnoDB
AUTO_INCREMENT = 64
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_programa` (
  `id_dimensao_programa` INT NOT NULL AUTO_INCREMENT,
  `programa_orcamentario` VARCHAR(500) NULL DEFAULT NULL,
  `acao` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_dimensao_programa`))
ENGINE = InnoDB
AUTO_INCREMENT = 3167
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`dimensao_temporal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`dimensao_temporal` (
  `id_dimensao_temporal` INT NOT NULL AUTO_INCREMENT,
  `mes` VARCHAR(500) NULL DEFAULT NULL,
  `ano` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_dimensao_temporal`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`fato_orcado_liquidado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`fato_orcado_liquidado` (
  `valor_orcado` DECIMAL(64,2) NULL DEFAULT NULL,
  `valor_liquidado` DECIMAL(64,2) NULL DEFAULT NULL,
  `dimensao_orgao_id_orgao` INT NOT NULL,
  `dimensao_programa_id_dimensao_programa` INT NOT NULL,
  `dimensao_area_atuacao_id_dimensao_area_atuacao` INT NOT NULL,
  `dimensao_temporal_id_dimensao_temporal` INT NOT NULL,
  INDEX `fk_fato_orcado_liquidado_dimensao_orgao_idx` (`dimensao_orgao_id_orgao` ASC) VISIBLE,
  INDEX `fk_fato_orcado_liquidado_dimensao_programa1_idx` (`dimensao_programa_id_dimensao_programa` ASC) VISIBLE,
  INDEX `fk_fato_orcado_liquidado_dimensao_area_atuacao1_idx` (`dimensao_area_atuacao_id_dimensao_area_atuacao` ASC) VISIBLE,
  INDEX `fk_fato_orcado_liquidado_dimensao_temporal1_idx` (`dimensao_temporal_id_dimensao_temporal` ASC) VISIBLE,
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_area_atuacao1`
    FOREIGN KEY (`dimensao_area_atuacao_id_dimensao_area_atuacao`)
    REFERENCES `transparencia`.`dimensao_area_atuacao` (`id_dimensao_area_atuacao`),
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_orgao`
    FOREIGN KEY (`dimensao_orgao_id_orgao`)
    REFERENCES `transparencia`.`dimensao_orgao` (`id_orgao`),
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_programa1`
    FOREIGN KEY (`dimensao_programa_id_dimensao_programa`)
    REFERENCES `transparencia`.`dimensao_programa` (`id_dimensao_programa`),
  CONSTRAINT `fk_fato_orcado_liquidado_dimensao_temporal1`
    FOREIGN KEY (`dimensao_temporal_id_dimensao_temporal`)
    REFERENCES `transparencia`.`dimensao_temporal` (`id_dimensao_temporal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transparencia`.`fato_orgao_superior_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transparencia`.`fato_orgao_superior_total` (
  `dimensao_orgao_superior_id_orgao_superior` INT NOT NULL,
  `total_liquidado` DECIMAL(64,2) NULL DEFAULT NULL,
  `dimensao_ano_orgao_superior_id_ano` INT NOT NULL,
  INDEX `fk_fato_orgao_superior_total_dimensao_orgao_superior_idx` (`dimensao_orgao_superior_id_orgao_superior` ASC) VISIBLE,
  INDEX `fk_fato_orgao_superior_total_dimensao_ano_orgao_superior1_idx` (`dimensao_ano_orgao_superior_id_ano` ASC) VISIBLE,
  CONSTRAINT `fk_fato_orgao_superior_total_dimensao_ano_orgao_superior1`
    FOREIGN KEY (`dimensao_ano_orgao_superior_id_ano`)
    REFERENCES `transparencia`.`dimensao_ano_orgao_superior` (`id_ano`),
  CONSTRAINT `fk_fato_orgao_superior_total_dimensao_orgao_superior`
    FOREIGN KEY (`dimensao_orgao_superior_id_orgao_superior`)
    REFERENCES `transparencia`.`dimensao_orgao_superior` (`id_orgao_superior`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
