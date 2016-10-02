-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Insurance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Insurance` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Insurance` (
  `InsuranceID` INT NOT NULL COMMENT '',
  `Insurance Name` VARCHAR(45) NULL COMMENT '',
  `InsuranceStartDate` DATE NULL COMMENT '',
  `InsuranceEndDate` DATE NULL COMMENT '',
  `InsuranceType` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`InsuranceID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Car Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Car Details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Car Details` (
  `ManufactrerID` INT NOT NULL COMMENT '',
  `ManufName` VARCHAR(45) NULL COMMENT '',
  `CarType` VARCHAR(45) NULL COMMENT '',
  `CarModel` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`ManufactrerID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Car` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Car` (
  `CarID` INT NOT NULL COMMENT '',
  `LicensePlateNo` VARCHAR(45) NULL COMMENT '',
  `ManufactrerID` INT NOT NULL COMMENT '',
  PRIMARY KEY (`CarID`, `ManufactrerID`)  COMMENT '',
  CONSTRAINT `fk_Car_Car Details1`
    FOREIGN KEY (`ManufactrerID`)
    REFERENCES `mydb`.`Car Details` (`ManufactrerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Person` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `PersonID` INT NOT NULL COMMENT '',
  `Name` VARCHAR(20) NULL COMMENT '',
  `Address` VARCHAR(45) NULL COMMENT '',
  `PhoneNo` INT NULL COMMENT '',
  `InsuranceID` INT NULL COMMENT '',
  `CarID` INT NULL COMMENT '',
  PRIMARY KEY (`PersonID`)  COMMENT '',
  CONSTRAINT `fk_Insurance`
    FOREIGN KEY (`InsuranceID`)
    REFERENCES `mydb`.`Insurance` (`InsuranceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carID`
    FOREIGN KEY (`CarID`)
    REFERENCES `mydb`.`Car` (`CarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Car Network`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Car Network` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Car Network` (
  `CarNetworkID` INT NOT NULL COMMENT '',
  `CarID` INT NOT NULL COMMENT '',
  `CarIP` VARCHAR(45) NULL COMMENT '',
  `HostName` VARCHAR(45) NULL COMMENT '',
  `Emergency` TINYINT(1) NULL COMMENT '',
  `Accident Sensor` TINYINT(1) NULL COMMENT '',
  PRIMARY KEY (`CarNetworkID`, `CarID`)  COMMENT '',
  CONSTRAINT `fk_Car Network_Car1`
    FOREIGN KEY (`CarID`)
    REFERENCES `mydb`.`Car` (`CarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Street`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Street` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Street` (
  `CrossingID` INT NOT NULL COMMENT '',
  `StreetName1` VARCHAR(45) NULL COMMENT '',
  `StreetName2` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`CrossingID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crossing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Crossing` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Crossing` (
  `CrossingID` INT NOT NULL COMMENT '',
  `CrossingLocation` VARCHAR(45) NULL COMMENT '',
  `CrossingType` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`CrossingID`)  COMMENT '',
  CONSTRAINT `fk_Crossing_Street1`
    FOREIGN KEY (`CrossingID`)
    REFERENCES `mydb`.`Street` (`CrossingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Accident`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Accident` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Accident` (
  `NetworkID` INT NULL COMMENT '',
  `CarIP` VARCHAR(45) NULL COMMENT '',
  `HostName` VARCHAR(45) NULL COMMENT '',
  `Emergency` TINYINT(1) NULL COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sensor Service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sensor Service` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Sensor Service` (
  `MaintID` INT NOT NULL COMMENT '',
  `CompanyName` VARCHAR(45) NULL COMMENT '',
  `Address` VARCHAR(45) NULL COMMENT '',
  `Supervisor` VARCHAR(45) NULL COMMENT '',
  `ContactNumber` INT NULL COMMENT '',
  PRIMARY KEY (`MaintID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sensor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sensor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Sensor` (
  `SensorID` INT NOT NULL COMMENT '',
  `MaintID` INT NOT NULL COMMENT '',
  `Status` TINYINT(1) NULL COMMENT '',
  PRIMARY KEY (`SensorID`, `MaintID`)  COMMENT '',
  CONSTRAINT `fk_maintenance`
    FOREIGN KEY (`MaintID`)
    REFERENCES `mydb`.`Sensor Service` (`MaintID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Measurement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Measurement` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Measurement` (
  `CrossingId` INT NOT NULL COMMENT '',
  `LaneType` VARCHAR(45) NOT NULL COMMENT '',
  `Density` INT NULL COMMENT '',
  `Urgency` INT NULL COMMENT '',
  `TimeStamp` TIMESTAMP(6) NULL COMMENT '',
  PRIMARY KEY (`CrossingId`, `LaneType`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lane Car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Lane Car` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Lane Car` (
  `CarNetworkID` INT NOT NULL COMMENT '',
  `SensorID` INT NULL COMMENT '',
  `Emergency` TINYINT(1) NULL COMMENT '',
  `CrossingId` INT NULL COMMENT '',
  `LaneType` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`CarNetworkID`)  COMMENT '',
  CONSTRAINT `fk_carNetwork`
    FOREIGN KEY (`CarNetworkID`)
    REFERENCES `mydb`.`Car Network` (`CarNetworkID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sensor`
    FOREIGN KEY (`SensorID`)
    REFERENCES `mydb`.`Sensor` (`SensorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crossing`
    FOREIGN KEY (`CrossingId`)
    REFERENCES `mydb`.`Street` (`CrossingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_measure`
    FOREIGN KEY (`CrossingId` , `LaneType`)
    REFERENCES `mydb`.`Measurement` (`CrossingId` , `LaneType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
