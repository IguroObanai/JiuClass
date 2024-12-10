-- MySQL Script generated by MySQL Workbench
-- Tue Dec 10 07:40:25 2024
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`faixa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`faixa` (
  `idfaixa` INT NOT NULL,
  `faixa_cor` VARCHAR(45) NULL,
  `faixa_nivel` VARCHAR(45) NULL,
  PRIMARY KEY (`idfaixa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instrutor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instrutor` (
  `idInstrutor` INT NOT NULL,
  `Instrutor_nome` VARCHAR(45) NULL,
  `Instrutor_experiencia` INT NULL,
  `faixa_idfaixa` INT NOT NULL,
  PRIMARY KEY (`idInstrutor`),
  INDEX `fk_Instrutor_faixa1_idx` (`faixa_idfaixa` ASC) VISIBLE,
  CONSTRAINT `fk_Instrutor_faixa1`
    FOREIGN KEY (`faixa_idfaixa`)
    REFERENCES `mydb`.`faixa` (`idfaixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`interna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`interna` (
  `matricula` INT NOT NULL,
  PRIMARY KEY (`matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`externa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`externa` (
  `cpf` INT(11) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Aluno` (
  `idAluno` INT NOT NULL,
  `Aluno_nome` VARCHAR(100) NULL,
  `Aluno_telefone` INT(9) NULL,
  `Aluno_frequencia` VARCHAR(100) NULL,
  `Aluno_aniversario` DATE NULL,
  `Aluno_idturma` INT NULL,
  `Aluno_graduação` VARCHAR(45) NULL,
  `faixa_idfaixa` INT NOT NULL,
  `interna_matricula` INT NOT NULL,
  `externa_cpf` INT(11) NOT NULL,
  PRIMARY KEY (`idAluno`, `interna_matricula`, `externa_cpf`),
  INDEX `fk_Aluno_faixa1_idx` (`faixa_idfaixa` ASC) VISIBLE,
  INDEX `fk_Aluno_interna1_idx` (`interna_matricula` ASC) VISIBLE,
  INDEX `fk_Aluno_externa1_idx` (`externa_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_faixa1`
    FOREIGN KEY (`faixa_idfaixa`)
    REFERENCES `mydb`.`faixa` (`idfaixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_interna1`
    FOREIGN KEY (`interna_matricula`)
    REFERENCES `mydb`.`interna` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_externa1`
    FOREIGN KEY (`externa_cpf`)
    REFERENCES `mydb`.`externa` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Turma` (
  `idTurma` INT NOT NULL,
  `Turma_nome` VARCHAR(45) NULL,
  `Turma_nivel` VARCHAR(45) NULL,
  `Turma_horario` DATETIME NULL,
  `Turma_Alunos` VARCHAR(45) NULL,
  `Aluno_idAluno` INT NOT NULL,
  `Instrutor_idInstrutor` INT NOT NULL,
  PRIMARY KEY (`idTurma`),
  INDEX `fk_Turma_Aluno_idx` (`Aluno_idAluno` ASC) VISIBLE,
  INDEX `fk_Turma_Instrutor1_idx` (`Instrutor_idInstrutor` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_Aluno`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_Instrutor1`
    FOREIGN KEY (`Instrutor_idInstrutor`)
    REFERENCES `mydb`.`Instrutor` (`idInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Treinos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Treinos` (
  `Treinos_data` DATE NOT NULL,
  `Treinos_horarios` DATETIME NULL,
  `Treinos_lugar` VARCHAR(45) NULL,
  `Treinos_tipo` VARCHAR(45) NULL,
  `Instrutor_idInstrutor` INT NOT NULL,
  `Aluno_idAluno` INT NOT NULL,
  PRIMARY KEY (`Treinos_data`),
  INDEX `fk_Treinos_Instrutor1_idx` (`Instrutor_idInstrutor` ASC) VISIBLE,
  INDEX `fk_Treinos_Aluno1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  CONSTRAINT `fk_Treinos_Instrutor1`
    FOREIGN KEY (`Instrutor_idInstrutor`)
    REFERENCES `mydb`.`Instrutor` (`idInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treinos_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;