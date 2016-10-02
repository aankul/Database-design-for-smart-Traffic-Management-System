-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- Create Tables


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
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`Measurement_history` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Measurement_history` (
  `CrossingId` INT NOT NULL COMMENT '',
  `LaneType` VARCHAR(45) NOT NULL COMMENT '',
  `Density` INT NULL COMMENT '',
  `Urgency` INT NULL COMMENT '',
  `TimeStamp` TIMESTAMP(6) NULL COMMENT '',
  PRIMARY KEY (`CrossingId`, `LaneType`)  COMMENT '')
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- TRIGGER

delimiter //
CREATE TRIGGER tgr_accident AFTER INSERT ON `Car Network`
FOR EACH ROW
BEGIN
IF NEW.`Accident Sensor` = 1 then
INSERT INTO Accident values (NEW.CarNetworkID,NEW.CarIP,NEW.HostName,NEW.`Accident Sensor`);
END IF;
END;//
delimiter ; 


-- STORED PROCEDURE

drop procedure if exists density_insert;
DELIMITER $$
CREATE PROCEDURE density_insert()
BEGIN 

drop table if exists temp_table;

CREATE TEMPORARY TABLE temp_table  AS (
SELECT CrossingId,LaneType,count(*) as Density,sum(Emergency) as Urgent FROM `Lane Car` GROUP BY CrossingId,LaneType);

INSERT INTO `Measurement`
select CrossingId,LaneType,Density,Urgent,sysdate() from temp_table order by Urgent desc,Density desc;


END $$
DELIMITER ;




select * from `Measurement`;




delimiter |
CREATE EVENT e_event
ON SCHEDULE
AT CURRENT_TIMESTAMP + INTERVAL 5 second
COMMENT 'MOVES DATA FROM CURRENT TABLE TO A HISTORICAL TABLE'
DO
BEGIN
SELECT * FROM measure INTO OUTFILE 'C:\Users\amuly\Desktop\Table entries' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';
truncate `Measurement`;
call density_insert;
END |
delimiter ;




drop procedure if exists update_tables;
delimiter |
CREATE procedure update_tables()
BEGIN
	INSERT INTO `Measurement_history` SELECT * FROM measure ;
	truncate `Measurement`;
	call density_insert;
END | 
delimiter ;


-- views


CREATE VIEW view_Ordered AS
select * from Measurement order by URGENCY desc,Density desc;



CREATE VIEW view_service_sensor AS
select distinct `Lane Car`.SensorID, `Sensor Service`.CompanyName, `Sensor Service`.Address, `Sensor Service`.ContactNumber, `Sensor Service`.Supervisor 
from `Lane Car` INNER JOIN Sensor 
ON `Lane Car`.SensorID = Sensor.SensorID  
INNER JOIN `Sensor Service` 
ON Sensor.MaintID = `Sensor Service`.MaintID; 



-- user privileges


CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost';


CREATE USER 'person'@'localhost' IDENTIFIED BY 'person';
GRANT SELECT ON `mydb`.`Person` TO 'person'@'localhost';
GRANT SELECT ON `mydb`.`Insurance` TO 'person'@'localhost';
GRANT SELECT ON `mydb`.`Car` TO 'person'@'localhost';


CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'analyst';
GRANT SELECT ON `mydb`.`Measurement` TO 'analyst'@'localhost';


CREATE USER 'emergency'@'localhost' IDENTIFIED BY 'emergency';
GRANT SELECT ON `mydb`.`Accident` TO 'emergency'@'localhost';


CREATE USER 'maintencance'@'localhost' IDENTIFIED BY 'maintencance';
GRANT SELECT ON `mydb`.`Sensor Service` TO 'maintencance'@'localhost';
GRANT SELECT ON `mydb`.`Sensor` TO 'maintencance'@'localhost';




truncate measurement;
truncate Accident;
call density_insert;
select * from measurement;
select * from Accident;
call update_tables;
select * from view_Ordered;
select * from view_service_sensor;



-- Insert into Tables


insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1001, 'Rebel Distributors Corp', '2015-04-04 16:19:50', '2017-05-22 01:39:29', 'TN');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1002, 'Lil'' Drug Store Products, Inc', '2015-05-17 04:34:59', '2018-05-31 21:35:40', 'ID');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1003, 'Valu Merchandisers Company (Best Choice)', '2015-08-29 22:14:37', '2018-09-26 15:55:09', 'AF');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1004, 'Anchor Supply Company', '2015-05-18 04:09:38', '2018-10-24 02:23:10', 'US');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1005, 'Cardinal Health', '2015-09-17 23:50:17', '2018-03-21 15:15:52', 'ID');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1006, 'Oceanside Pharmaceuticals', '2015-01-12 16:27:08', '2017-11-18 04:52:47', 'CN');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1007, 'Watson Laboratories, Inc.', '2015-11-05 13:21:22', '2017-01-08 15:44:37', 'AR');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1008, 'Mylan Pharmaceuticals Inc.', '2014-12-25 04:06:45', '2018-10-12 16:12:55', 'MY');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1009, 'PD-Rx Pharmaceuticals, Inc.', '2015-08-19 20:53:30', '2017-05-15 03:23:58', 'TH');
insert into Insurance (`InsuranceID`, `Insurance Name`, `InsuranceStartDate`, `InsuranceEndDate`, `InsuranceType`) values (1010, 'CVS Pharmacy', '2015-05-17 01:31:47', '2017-01-10 03:31:00', 'MX');




insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2000, 'Buzzdog', 'Cambodian', 'PL');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2001, 'Edgewire', 'Malaysian', 'PH');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2002, 'Shuffledrive', 'Blackfeet', 'AR');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2003, 'Tavu', 'American Indian and Alaska Native (AIAN)', 'UA');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2004, 'Jabbersphere', 'Yaqui', 'PT');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2005, 'Gabspot', 'Cuban', 'NZ');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2006, 'Browsecat', 'Hmong', 'ID');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2007, 'Janyx', 'Pueblo', 'MX');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2008, 'Brainbox', 'Bolivian', 'MY');
insert into `Car Details` (ManufactrerID, ManufName, CarType, CarModel) values (2009, 'Vidoo', 'Cherokee', 'ID');




insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3000, '837-39-2740', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3001, '371-22-9610', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3002, '453-32-1629', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3003, '836-34-2793', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3004, '770-89-9648', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3005, '123-26-6864', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3006, '480-39-6740', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3007, '688-24-2933', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3008, '677-36-8597', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3009, '966-45-4946', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3010, '918-84-1194', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3011, '384-35-7085', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3012, '736-66-3844', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3013, '219-11-1533', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3014, '841-45-7837', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3015, '486-78-1282', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3016, '318-60-7858', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3017, '451-89-5331', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3018, '177-34-3223', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3019, '970-08-0323', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3020, '969-58-5842', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3021, '994-12-4044', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3022, '628-64-4974', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3023, '435-77-9585', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3024, '885-70-5981', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3025, '152-58-4922', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3026, '769-50-9726', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3027, '220-94-0203', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3028, '126-64-6852', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3029, '596-36-0183', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3030, '469-25-6761', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3031, '447-24-1403', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3032, '577-07-5720', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3033, '532-79-7968', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3034, '857-12-5862', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3035, '877-30-2301', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3036, '740-27-9598', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3037, '935-99-4995', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3038, '372-97-6239', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3039, '239-15-5790', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3040, '759-89-7118', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3041, '832-56-1881', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3042, '255-99-0310', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3043, '134-31-3744', 2001);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3044, '379-71-7569', 2002);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3045, '811-42-8387', 2003);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3046, '432-85-3477', 2004);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3047, '544-90-0551', 2005);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3048, '828-86-5808', 2000);
insert into `Car` (`CarID`, `LicensePlateNo`, ManufactrerID) values (3049, '340-92-2432', 2001);


insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4000, 'Betty Mccoy', '75543 Elmside Junction', 15326, 1001, 3000);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4001, 'Janet Mason', '89 Fairview Pass', 15327, 1002, 3001);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4002, 'Roger Mendoza', '771 Clyde Gallagher Crossing', 15328, 1003, 3002);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4003, 'Tina Garcia', '5 Cascade Way', 15329, 1004, 3003);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4004, 'James Kim', '188 Garrison Pass', 15330, 1005, 3004);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4005, 'Jesse Gilbert', '92 Moulton Pass', 15331, 1006, 3005);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4006, 'Robert Boyd', '42707 Banding Point', 15332, 1007, 3006);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4007, 'Cynthia Lawson', '709 Darwin Street', 15333, 1008, 3007);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4008, 'Albert Rodriguez', '17292 Union Center', 15334, 1001, 3008);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4009, 'Donna Stevens', '288 Arrowood Lane', 15335, 1002, 3009);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4010, 'Helen Gonzalez', '641 Delaware Junction', 15336, 1003, 3010);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4011, 'Lillian Evans', '6267 Onsgard Point', 15337, 1004, 3011);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4012, 'Dennis Coleman', '76 Monterey Place', 15338, 1005, 3012);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4013, 'Sharon Ward', '0 Bluestem Court', 15339, 1006, 3013);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4014, 'Jeffrey Martinez', '439 Dahle Lane', 15340, 1007, 3014);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4015, 'Judith Hanson', '12561 Tomscot Pass', 15341, 1008, 3015);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4016, 'Stephanie Hunter', '49 Pankratz Place', 15342, 1001, 3016);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4017, 'Anthony Duncan', '10 Bayside Hill', 15343, 1002, 3017);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4018, 'Ruby Clark', '1 Arkansas Alley', 15344, 1003, 3018);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4019, 'Larry Foster', '13 Kingsford Crossing', 15345, 1004, 3019);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4020, 'Janet Moreno', '607 Steensland Center', 15346, 1005, 3020);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4021, 'Karen Williams', '3561 Randy Hill', 15347, 1006, 3021);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4022, 'Emily Griffin', '971 Fisk Way', 15348, 1007, 3022);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4023, 'Julia Mendoza', '1 Bartillon Pass', 15349, 1008, 3023);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4024, 'Samuel Payne', '75001 Westport Avenue', 15350, 1001, 3024);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4025, 'Wanda Gordon', '00 John Wall Circle', 15351, 1002, 3025);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4026, 'Harold Simpson', '69850 Hagan Court', 15352, 1003, 3026);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4027, 'Irene Dean', '10 Dunning Road', 15353, 1004, 3027);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4028, 'Marie Scott', '60 Merrick Alley', 15354, 1005, 3028);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4029, 'Christine Hamilton', '662 Oneill Plaza', 15355, 1006, 3029);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4030, 'Terry Hudson', '93491 Pond Park', 15356, 1007, 3030);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4031, 'Theresa Bell', '084 Spohn Park', 15357, 1008, 3031);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4032, 'Katherine Bryant', '3 Carberry Point', 15358, 1001, 3032);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4033, 'Paul Jordan', '881 Grim Street', 15359, 1002, 3033);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4034, 'Dorothy Reid', '7318 Center Drive', 15360, 1003, 3034);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4035, 'Joe Fox', '442 Aberg Way', 15361, 1004, 3035);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4036, 'Sandra Sims', '877 Homewood Junction', 15362, 1005, 3036);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4037, 'Jacqueline George', '59887 Fulton Terrace', 15363, 1006, 3037);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4038, 'Robin Taylor', '81589 Hudson Way', 15364, 1007, 3038);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4039, 'Harold Schmidt', '659 Bunting Parkway', 15365, 1008, 3039);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4040, 'Bobby Stevens', '1 Hagan Crossing', 15366, 1001, 3040);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4041, 'Justin Jenkins', '69582 Randy Circle', 15367, 1002, 3041);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4042, 'Gregory Ellis', '4 Melrose Center', 15368, 1003, 3042);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4043, 'Judith Payne', '0181 Green Terrace', 15369, 1004, 3043);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4044, 'Patrick Berry', '9 Orin Trail', 15370, 1005, 3044);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4045, 'Rose Riley', '4797 Clyde Gallagher Trail', 15371, 1006, 3045);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4046, 'Phyllis Hart', '7395 Melby Place', 15372, 1007, 3046);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4047, 'Susan Davis', '9 Toban Center', 15373, 1008, 3047);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4048, 'Albert Lane', '81233 Forest Dale Road', 15374, 1001, 3048);
insert into `Person` (`PersonID`, `Name`, `Address`, `PhoneNo`, `InsuranceID`, `CarID`) values (4049, 'Justin Carr', '8090 Anderson Point', 15375, 1002, 3049);




insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (1, 3000, 'a408:fe71:f94:3424:6df9:9d58:8b08:d933', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (2, 3001, '273b:885d:6394:4d76:4739:8cf7:f24d:70ba', 'edu', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (3, 3002, '4c08:9887:aa74:6735:9950:8954:3eca:6385', 'mil', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (4, 3003, 'cf6e:2549:7439:cc0d:70ff:bf10:8991:8eb9', 'biz', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (5, 3004, 'cbac:4026:763e:5428:7775:499d:f9fd:2379', 'com', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (6, 3005, '5b0:e7a3:3dd:1c35:f27b:3585:b74d:5b4b', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (7, 3006, '5c8d:e580:a67c:adcf:8ad5:e86d:cc28:b057', 'edu', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (8, 3007, '8003:7a4e:af27:7bf8:24c3:8d51:a983:7162', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (9, 3008, '52e:b9b4:e07b:51ba:368d:c91a:81e0:3f23', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (10, 3009, '34c9:4a8a:d0a6:42d1:9362:23cf:12a1:1ac7', 'gov', 0, 1);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (11, 3010, 'bf74:5809:aa0d:1937:708f:134d:1a51:70ef', 'com', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (12, 3011, '92ad:78fe:7932:c00d:819f:2db8:2897:c430', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (13, 3012, 'c349:1753:556a:1e43:d80:920a:54ba:1dc', 'edu', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (14, 3013, 'a950:f73a:30bb:6c84:d0fe:45d9:74d7:cf9c', 'edu', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (15, 3014, 'd354:d4fd:22f1:b3bd:c61e:30c5:2958:dd5a', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (16, 3015, 'd494:827:b425:5f01:c497:8ca6:33a:1e10', 'mil', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (17, 3016, '51f3:a5ef:aa7a:158a:4bb:d13d:86a2:ef7b', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (18, 3017, 'd2ea:b6f0:6bcd:292f:dcf4:dfaa:3930:a7f', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (19, 3018, '5272:8f0d:1a74:82f5:d701:2d6b:ae86:ac93', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (20, 3019, 'c305:4fd3:6a24:6e29:ef5e:46a7:1611:f0a9', 'org', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (21, 3020, 'e:d5b7:1971:c33:2e1c:4a02:e8cd:bf18', 'edu', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (22, 3021, 'dcf9:f891:a9e0:9587:102e:1c9f:cab1:c8eb', 'com', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (23, 3022, '8abb:e93a:a504:c611:a075:6f0c:54be:a648', 'org', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (24, 3023, '1f6f:f707:ec34:9b38:400a:3daa:9506:4652', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (25, 3024, 'e4d7:edf5:c10a:2412:de45:1daa:d601:219b', 'biz', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (26, 3025, '5e7a:181a:a312:827a:2ddb:9933:baca:6234', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (27, 3026, '8044:9625:4708:a900:b9b7:cadb:6248:6378', 'biz', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (28, 3027, 'd615:ce93:a631:d63c:bd4:caa5:9dac:7058', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (29, 3028, '9511:1ba4:d6a5:1d4c:55f8:d4c5:5536:7d7c', 'mil', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (30, 3029, '56eb:7dc0:8930:c0fa:d80a:ade7:7571:4be3', 'com', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (31, 3030, '8273:c9e7:fcb8:c747:1b9:f9f7:ea9d:d406', 'info', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (32, 3031, '7485:8872:b58e:e66:6cdc:7c1c:a60b:8527', 'org', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (33, 3032, 'bff5:2200:964a:16fc:e270:96ec:9da1:becb', 'edu', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (34, 3033, 'd692:4733:659d:8bdd:48e5:ae92:4661:8e4d', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (35, 3034, '5ede:f4e2:1f4f:a211:42c6:51d9:a37c:770c', 'info', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (36, 3035, '6067:5c50:cdf6:93f8:bf07:f1ba:5fb1:7e68', 'biz', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (37, 3036, 'eb67:c6b0:da93:89a9:76b6:55b8:3f0e:13d0', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (38, 3037, 'da85:d97c:519f:7a27:fabd:9701:98e2:bb9b', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (39, 3038, '4ad4:8537:2ef:b990:507e:e7fb:ad2d:81b9', 'org', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (40, 3039, '52e:2c4a:bec9:4b07:3fe3:8bdd:f6ee:2825', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (41, 3040, 'df98:e35a:26fa:3021:d510:c139:9138:da4b', 'biz', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (42, 3041, '5278:b294:5ade:9e8e:601d:df5b:c8ff:1df0', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (43, 3042, '550:16e2:bf0:41e1:e6ff:ee8:6cd6:8235', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (44, 3043, '9fee:24e3:42ae:669a:ae0a:2baf:6190:98b4', 'gov', 0, 1);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (45, 3044, 'c7c5:ab8b:767d:1ea0:e30b:7c1:79fc:d816', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (46, 3045, '7fca:8ac5:2f94:3551:d462:6d15:4332:4041', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (47, 3046, 'baa6:b8a4:faf0:5270:25eb:fa06:f4f0:4942', 'name', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (48, 3047, '3fd8:345c:f6b:aca5:dbc6:ba5c:15e6:c83e', 'gov', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (49, 3048, '2326:fd01:c47b:9b81:1abe:3d92:bade:e6cb', 'net', 0, 0);
insert into `Car Network` (`CarNetworkID`, `CarID`, `CarIP`, `HostName`, `Emergency`, `Accident Sensor`) values (50, 3049, '80a1:19b1:c228:43ea:e1d2:718d:e0c2:bfd0', 'com', 0, 0);



insert into Street (CrossingID, StreetName1, StreetName2) values (6000, 'William St', 'Anna St');
insert into Street (CrossingID, StreetName1, StreetName2) values (6001, 'Raymond St', 'Brenda St');



insert into Crossing (CrossingID, CrossingLocation, CrossingType) values (6000, 'Meadow Vale Parkway', '4 way');
insert into Crossing (CrossingID, CrossingLocation, CrossingType) values (6001, 'Lighthouse Bay Pass', '4 way');



insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (700, 'TOP CARE (Topco Associates LLC)', '3007 Sutteridge Parkway', 'Stephanie Hernandez', 15489);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (701, 'Amerisource Bergen', '19 Hanover Park', 'Evelyn Stewart', 15490);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (702, 'Cardinal Health', '57097 Cardinal Plaza', 'Roger Sims', 15491);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (703, 'Eduard Gerlach GmbH', '48 Myrtle Avenue', 'Willie Butler', 15492);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (704, 'Solco Healthcare US, LLC', '32 Union Terrace', 'Jeffrey Washington', 15493);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (705, 'Physicians Total Care, Inc.', '7976 Hudson Center', 'Mark Mendoza', 15494);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (706, 'Merck Sharp & Dohme Corp.', '3 Sunnyside Center', 'Carol Torres', 15495);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (707, 'Liberty Pharmaceuticals, Inc.', '41 Southridge Center', 'Gloria Bryant', 15496);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (708, 'Takeda Pharmaceuticals America, Inc.', '11122 Muir Street', 'Steven Peterson', 15497);
insert into `Sensor Service` (MaintID, CompanyName, Address, Supervisor, ContactNumber) values (709, 'IGI Labs, Inc.', '94046 Carey Circle', 'Mark Hudson', 15498);



insert into Sensor (SensorID, MaintID, Status) values (8000, 700, 0);
insert into Sensor (SensorID, MaintID, Status) values (8001, 701, 0);
insert into Sensor (SensorID, MaintID, Status) values (8002, 702, 0);
insert into Sensor (SensorID, MaintID, Status) values (8003, 703, 0);
insert into Sensor (SensorID, MaintID, Status) values (8004, 704, 0);
insert into Sensor (SensorID, MaintID, Status) values (8005, 705, 0);
insert into Sensor (SensorID, MaintID, Status) values (8006, 706, 0);
insert into Sensor (SensorID, MaintID, Status) values (8007, 707, 0);
insert into Sensor (SensorID, MaintID, Status) values (8008, 708, 0);
insert into Sensor (SensorID, MaintID, Status) values (8009, 700, 0);
insert into Sensor (SensorID, MaintID, Status) values (8010, 701, 0);
insert into Sensor (SensorID, MaintID, Status) values (8011, 702, 0);
insert into Sensor (SensorID, MaintID, Status) values (8012, 703, 0);
insert into Sensor (SensorID, MaintID, Status) values (8013, 704, 0);
insert into Sensor (SensorID, MaintID, Status) values (8014, 705, 0);
insert into Sensor (SensorID, MaintID, Status) values (8015, 706, 0);
insert into Sensor (SensorID, MaintID, Status) values (8016, 707, 0);
insert into Sensor (SensorID, MaintID, Status) values (8017, 708, 0);
insert into Sensor (SensorID, MaintID, Status) values (8018, 700, 0);
insert into Sensor (SensorID, MaintID, Status) values (8019, 701, 0);
insert into Sensor (SensorID, MaintID, Status) values (8020, 702, 0);
insert into Sensor (SensorID, MaintID, Status) values (8021, 703, 0);
insert into Sensor (SensorID, MaintID, Status) values (8022, 704, 0);
insert into Sensor (SensorID, MaintID, Status) values (8023, 705, 0);



insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (1, 8000, 0, 6000, 'L1');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (2, 8000, 0, 6000, 'L1');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (3, 8000, 0, 6000, 'L1');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (4, 8001, 0, 6000, 'L2');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (5, 8001, 0, 6000, 'L2');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (6, 8002, 0, 6000, 'L3');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (7, 8003, 0, 6000, 'L4');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (8, 8004, 1, 6000, 'L5');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (9, 8005, 0, 6000, 'L6');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (10, 8005, 0, 6000, 'L6');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (11, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (12, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (13, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (14, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (15, 8007, 0, 6000, 'L8');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (16, 8007, 0, 6000, 'L8');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (17, 8008, 0, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (18, 8008, 0, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (19, 8008, 0, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (20, 8008, 1, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (21, 8008, 0, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (22, 8008, 0, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (23, 8009, 0, 6000, 'L10');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (24, 8009, 0, 6000, 'L10');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (25, 8009, 0, 6000, 'L10');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (26, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (27, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (28, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (29, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (30, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (31, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (32, 8005, 0, 6000, 'L6');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (33, 8004, 0, 6000, 'L5');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (34, 8007, 0, 6000, 'L8');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (35, 8008, 0, 6000, 'L9');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (36, 8000, 0, 6000, 'L1');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (37, 8002, 0, 6000, 'L3');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (38, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (39, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (40, 8001, 0, 6000, 'L2');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (41, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (42, 8007, 0, 6000, 'L8');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (43, 8011, 0, 6000, 'L12');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (44, 8010, 0, 6000, 'L11');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (45, 8000, 0, 6000, 'L1');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (46, 8005, 0, 6000, 'L6');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (47, 8005, 0, 6000, 'L6');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (48, 8006, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (49, 8009, 0, 6000, 'L7');
insert into `Lane Car` (CarNetworkID, SensorID, Emergency, CrossingId, LaneType) values (50, 8003, 0, 6000, 'L4');




