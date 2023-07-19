-- MariaDB dump 10.19  Distrib 10.5.16-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: cumbum
-- ------------------------------------------------------
-- Server version	10.5.16-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Admin_Officer`
--

DROP TABLE IF EXISTS `Admin_Officer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admin_Officer` (
  `Admin_ID` int(11) NOT NULL,
  `Center_Number` int(11) NOT NULL,
  `Prison_Block` char(1) NOT NULL,
  PRIMARY KEY (`Admin_ID`),
  KEY `PK_Admin_Rehab_Center` (`Prison_Block`,`Center_Number`),
  CONSTRAINT `FK_Admin_ID_Staff` FOREIGN KEY (`Admin_ID`) REFERENCES `Staff` (`Staff_Id`),
  CONSTRAINT `PK_Admin_Rehab_Center` FOREIGN KEY (`Prison_Block`, `Center_Number`) REFERENCES `Rehab_Center` (`Security_Level`, `Center_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin_Officer`
--

LOCK TABLES `Admin_Officer` WRITE;
/*!40000 ALTER TABLE `Admin_Officer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Admin_Officer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dependent`
--

DROP TABLE IF EXISTS `Dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dependent` (
  `Block_Code` char(1) NOT NULL,
  `Prisoner_Id` int(11) NOT NULL,
  `First_Name` varchar(100) NOT NULL,
  `Last_Name` varchar(100) NOT NULL,
  `Relation` varchar(20) NOT NULL,
  PRIMARY KEY (`Block_Code`,`Prisoner_Id`,`First_Name`,`Last_Name`),
  CONSTRAINT `FK_Dependent_Prisoner` FOREIGN KEY (`Block_Code`, `Prisoner_Id`) REFERENCES `Prisoner` (`Block_Code`, `Prisoner_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dependent`
--

LOCK TABLES `Dependent` WRITE;
/*!40000 ALTER TABLE `Dependent` DISABLE KEYS */;
/*!40000 ALTER TABLE `Dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Gun_Servicing`
--

DROP TABLE IF EXISTS `Gun_Servicing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Gun_Servicing` (
  `Weapon_Model` varchar(20) NOT NULL,
  `Servicing_Period` int(11) NOT NULL,
  PRIMARY KEY (`Weapon_Model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Gun_Servicing`
--

LOCK TABLES `Gun_Servicing` WRITE;
/*!40000 ALTER TABLE `Gun_Servicing` DISABLE KEYS */;
INSERT INTO `Gun_Servicing` VALUES ('Assault Rifle',49),('Deagle',60),('Glock',76),('Handgun',23),('Machine Gun',123),('Rifle',30),('Sawed Shotgun',32),('Shotgun',45),('SMG',13);
/*!40000 ALTER TABLE `Gun_Servicing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monitors`
--

DROP TABLE IF EXISTS `Monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitors` (
  `Admin_ID` int(11) NOT NULL,
  `Block_Code` char(1) NOT NULL,
  `Center_Number` int(11) NOT NULL,
  `Prisoner_Id` int(11) NOT NULL,
  PRIMARY KEY (`Admin_ID`,`Block_Code`,`Prisoner_Id`,`Center_Number`),
  KEY `FK_Monitor_Center` (`Block_Code`,`Center_Number`),
  KEY `FK_Monitor_Prisoner` (`Block_Code`,`Prisoner_Id`),
  CONSTRAINT `FK_Monitor_Center` FOREIGN KEY (`Block_Code`, `Center_Number`) REFERENCES `Rehab_Center` (`Security_Level`, `Center_Number`),
  CONSTRAINT `FK_Monitor_Prisoner` FOREIGN KEY (`Block_Code`, `Prisoner_Id`) REFERENCES `Prisoner` (`Block_Code`, `Prisoner_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitors`
--

LOCK TABLES `Monitors` WRITE;
/*!40000 ALTER TABLE `Monitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `Monitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prison_Block`
--

DROP TABLE IF EXISTS `Prison_Block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prison_Block` (
  `Security_Level` char(1) NOT NULL,
  PRIMARY KEY (`Security_Level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prison_Block`
--

LOCK TABLES `Prison_Block` WRITE;
/*!40000 ALTER TABLE `Prison_Block` DISABLE KEYS */;
INSERT INTO `Prison_Block` VALUES ('1'),('2'),('3'),('4'),('5'),('6');
/*!40000 ALTER TABLE `Prison_Block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `Prison_Block_View`
--

DROP TABLE IF EXISTS `Prison_Block_View`;
/*!50001 DROP VIEW IF EXISTS `Prison_Block_View`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Prison_Block_View` (
  `Prison_Block` tinyint NOT NULL,
  `Count(*)` tinyint NOT NULL,
  `SUM(Credit_Score)` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Prison_Cell`
--

DROP TABLE IF EXISTS `Prison_Cell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prison_Cell` (
  `Security_Level` char(1) NOT NULL,
  `Cell_Number` int(11) NOT NULL,
  `Occupancy_Status` int(11) DEFAULT 0,
  PRIMARY KEY (`Security_Level`,`Cell_Number`),
  KEY `FK_CellNumber` (`Cell_Number`),
  CONSTRAINT `FK_CellNumber` FOREIGN KEY (`Cell_Number`) REFERENCES `Prison_Occupancy` (`Cell_Number`),
  CONSTRAINT `FK_PCell_PBlock` FOREIGN KEY (`Security_Level`) REFERENCES `Prison_Block` (`Security_Level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prison_Cell`
--

LOCK TABLES `Prison_Cell` WRITE;
/*!40000 ALTER TABLE `Prison_Cell` DISABLE KEYS */;
INSERT INTO `Prison_Cell` VALUES ('1',1,6),('1',2,6),('1',3,6),('1',4,6),('1',5,6),('1',6,6),('1',7,1),('1',8,1),('1',9,0),('1',10,0),('1',11,0),('1',12,0),('1',13,0),('1',14,0),('1',15,0),('1',16,0),('1',17,0),('1',18,0),('1',19,0),('2',1,6),('2',2,6),('2',3,6),('2',4,6),('2',5,6),('2',6,6),('2',7,1),('2',8,1),('2',9,0),('2',10,0),('2',11,0),('2',12,0),('2',13,0),('2',14,0),('2',15,0),('2',16,0),('2',17,0),('2',18,0),('2',19,0),('3',1,6),('3',2,6),('3',3,6),('3',4,6),('3',5,6),('3',6,6),('3',7,1),('3',8,1),('3',9,0),('3',10,0),('3',11,0),('3',12,0),('3',13,0),('3',14,0),('3',15,0),('3',16,0),('3',17,0),('3',18,0),('3',19,0),('4',1,6),('4',2,6),('4',3,6),('4',4,6),('4',5,6),('4',6,6),('4',7,1),('4',8,1),('4',9,0),('4',10,0),('4',11,0),('4',12,0),('4',13,0),('4',14,0),('4',15,0),('4',16,0),('4',17,0),('4',18,0),('4',19,0),('5',1,6),('5',2,6),('5',3,6),('5',4,6),('5',5,6),('5',6,6),('5',7,1),('5',8,1),('5',9,0),('5',10,0),('5',11,0),('5',12,0),('5',13,0),('5',14,0),('5',15,0),('5',16,0),('5',17,0),('5',18,0),('5',19,0),('6',1,6),('6',2,6),('6',3,6),('6',4,6),('6',5,6),('6',6,6),('6',7,1),('6',8,1),('6',9,0),('6',10,0),('6',11,0),('6',12,0),('6',13,0),('6',14,0),('6',15,0),('6',16,0),('6',17,0),('6',18,0),('6',19,0);
/*!40000 ALTER TABLE `Prison_Cell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prison_Guard`
--

DROP TABLE IF EXISTS `Prison_Guard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prison_Guard` (
  `Guard_ID` int(11) NOT NULL,
  `Prison_Block` char(1) NOT NULL,
  PRIMARY KEY (`Guard_ID`),
  KEY `FK_PGuard_PBlock` (`Prison_Block`),
  CONSTRAINT `FK_Guard_ID_Staff` FOREIGN KEY (`Guard_ID`) REFERENCES `Staff` (`Staff_Id`),
  CONSTRAINT `FK_PGuard_PBlock` FOREIGN KEY (`Prison_Block`) REFERENCES `Prison_Block` (`Security_Level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prison_Guard`
--

LOCK TABLES `Prison_Guard` WRITE;
/*!40000 ALTER TABLE `Prison_Guard` DISABLE KEYS */;
/*!40000 ALTER TABLE `Prison_Guard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prison_Occupancy`
--

DROP TABLE IF EXISTS `Prison_Occupancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prison_Occupancy` (
  `Cell_Number` int(11) NOT NULL AUTO_INCREMENT,
  `Occupancy_Type` int(11) NOT NULL,
  PRIMARY KEY (`Cell_Number`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prison_Occupancy`
--

LOCK TABLES `Prison_Occupancy` WRITE;
/*!40000 ALTER TABLE `Prison_Occupancy` DISABLE KEYS */;
INSERT INTO `Prison_Occupancy` VALUES (1,2),(2,3),(3,4),(4,1),(5,2),(6,3),(7,4),(8,1),(9,2),(10,3),(11,4),(12,1),(13,2),(14,3),(15,4),(16,1),(17,2),(18,3),(19,4);
/*!40000 ALTER TABLE `Prison_Occupancy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prisoner`
--

DROP TABLE IF EXISTS `Prisoner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prisoner` (
  `Block_Code` char(1) NOT NULL,
  `Cell_Number` int(11) NOT NULL,
  `Prisoner_Id` int(11) NOT NULL,
  `Aadhar_Card` int(11) NOT NULL,
  `First_Name` varchar(100) NOT NULL,
  `Last_Name` varchar(100) NOT NULL,
  `Crime` varchar(100) NOT NULL,
  `Credit_Score` int(11) DEFAULT 0,
  `Address` text NOT NULL,
  `Execution_Date` date DEFAULT NULL,
  `Release_Date` date DEFAULT NULL,
  `Incarceration_Date` date DEFAULT curdate(),
  PRIMARY KEY (`Block_Code`,`Prisoner_Id`),
  KEY `FK_Prisoner_PCell` (`Block_Code`,`Cell_Number`),
  CONSTRAINT `FK_Prisoner_PCell` FOREIGN KEY (`Block_Code`, `Cell_Number`) REFERENCES `Prison_Cell` (`Security_Level`, `Cell_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prisoner`
--

LOCK TABLES `Prisoner` WRITE;
/*!40000 ALTER TABLE `Prisoner` DISABLE KEYS */;
INSERT INTO `Prisoner` VALUES ('1',3,1,327325,'Harmonie','Mozelle','Assault',66,'1196Alyse Gregory',NULL,'2023-11-20','2022-11-20'),('1',6,2,549952,'Rafa','Arden','Murder',7,'274Jemmie Solana','2023-02-27',NULL,'2022-11-23'),('1',2,3,372646,'Eleanora','Dulcinea','Robbery',92,'1687Ardelle O\'Mahony',NULL,'2023-02-22','2022-11-24'),('1',1,4,352058,'Jerrie','Tavi','Murder',84,'984Rori Callida','2022-12-09',NULL,'2022-11-17'),('2',5,1,125399,'Ashlan','Obie','Robbery',63,'1475Patrice Eirena',NULL,'2023-02-24','2022-11-26'),('2',6,2,917998,'Heath','Epp','Murder',17,'730Andeee Tica','2023-01-26',NULL,'2022-11-26'),('2',5,3,405592,'Theresina','Louie','Assault',26,'1714Carine Boyer',NULL,'2023-11-17','2022-11-17'),('2',2,4,446303,'Jaime','Darrill','Robbery',51,'1337Merilee Ries',NULL,'2023-02-18','2022-11-20'),('2',5,5,980573,'Oralla','Cleavland','Assault',8,'1279Nola Sigmund',NULL,'2023-11-27','2022-11-27'),('2',6,6,635992,'Saudra','Toscano','Robbery',22,'466Rhodie Teddie',NULL,'2023-02-17','2022-11-19'),('2',4,7,754035,'Lisabeth','Tobin','Robbery',10,'709Trixi Belford',NULL,'2023-02-18','2022-11-20'),('3',1,1,115708,'Tricia','Lilithe','Assault',29,'1214Hetty Gard',NULL,'2023-11-26','2022-11-26'),('3',5,2,704696,'Salli','Norah','Murder',50,'1718Felipa Constant','2023-02-01',NULL,'2022-11-19'),('3',1,3,304460,'Ysabel','Lorraine','Robbery',100,'1132Chelsie Pettifer',NULL,'2023-02-23','2022-11-25'),('3',6,4,690832,'Tildie','Pressey','Robbery',23,'1573Hortensia Tommi',NULL,'2023-02-18','2022-11-20'),('3',8,5,453,'Rax','ma','4t43v',0,'fddsf4 4353','2022-11-28',NULL,'2022-11-27'),('4',4,1,458027,'Kirby','Perdita','Murder',30,'148Una Gambrill','2023-01-10',NULL,'2022-11-17'),('4',2,2,340985,'Karla','Deryl','Murder',21,'326Anjela Madonna','2023-02-08',NULL,'2022-11-19'),('4',3,3,555993,'Cecilla','Corbet','Murder',22,'373Gretal O\'Toole','2023-01-31',NULL,'2022-11-20'),('4',4,4,925025,'Kristi','Pansy','Murder',9,'653Karola Granoff','2022-12-31',NULL,'2022-11-20'),('4',3,5,293883,'Golda','Shere','Robbery',18,'1127Doris Lomasi',NULL,'2023-02-19','2022-11-21'),('4',3,6,964617,'Calypso','Meyer','Murder',81,'1147Alicia Ardis','2023-01-27',NULL,'2022-11-18'),('4',2,7,630000,'Brandise','Korney','Assault',39,'227Agathe Babita',NULL,'2023-11-27','2022-11-27'),('4',5,8,349660,'Laetitia','Furie','Robbery',85,'1716Jacquelyn Pinebrook',NULL,'2023-02-18','2022-11-20'),('5',4,1,251569,'Allianora','Emilee','Assault',66,'278Lindsey Curzon',NULL,'2023-11-26','2022-11-26'),('5',2,2,947733,'Nalani','Beitnes','Assault',10,'1151Kalinda Cointon',NULL,'2023-11-22','2022-11-22'),('5',5,3,789916,'Wilhelmina','Gamber','Assault',40,'1062Clarette Ashlin',NULL,'2023-11-20','2022-11-20'),('5',1,4,520919,'Ethelda','Manus','Robbery',95,'472Barbe Christianna',NULL,'2023-02-22','2022-11-24'),('5',3,5,450968,'Jacklyn','Erida','Assault',65,'1824Rebe Erine',NULL,'2023-11-17','2022-11-17'),('6',2,1,686395,'Lynnell','Nette','Assault',82,'879Celisse Dane',NULL,'2023-11-24','2022-11-24'),('6',1,2,639666,'Cherish','Lawry','Murder',91,'1028Bibbye Kreda','2023-02-13',NULL,'2022-11-27'),('6',1,3,274128,'Darice','Haskins','Assault',74,'744Connie Zsa',NULL,'2023-11-27','2022-11-27'),('6',6,4,631926,'Ethyl','Finstad','Robbery',34,'539Dyan Wallach',NULL,'2023-02-19','2022-11-21'),('6',4,5,657525,'Phillie','Harlen','Murder',59,'1186Yvonne Gordon','2023-01-02',NULL,'2022-11-19'),('6',3,6,843424,'Devi','Tager','Murder',73,'182Lea Zales','2022-12-07',NULL,'2022-11-25'),('6',4,7,556757,'Allene','Melissa','Murder',93,'350Maribeth Tade','2023-01-15',NULL,'2022-11-26'),('6',6,8,492084,'Carmel','Jinny','Murder',90,'351Frieda Rosenberg','2022-12-24',NULL,'2022-11-23');
/*!40000 ALTER TABLE `Prisoner` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`cumbum`@`localhost`*/ /*!50003 TRIGGER Prisoner_PrisonerID BEFORE INSERT ON Prisoner 
FOR EACH ROW SET NEW.Prisoner_Id = (SELECT IFNULL(MAX(Prisoner_ID), 0) + 1 
	FROM Prisoner WHERE Block_Code = NEW.Block_Code) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`cumbum`@`localhost`*/ /*!50003 TRIGGER Credit_On_Update
    AFTER UPDATE ON Prisoner FOR EACH ROW
    UPDATE Prison_Block SET Total_Credit = Total_Credit - OLD.Credit_Score + NEW.Credit_Score */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Rehab_Activity`
--

DROP TABLE IF EXISTS `Rehab_Activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rehab_Activity` (
  `Center_Number` int(11) NOT NULL,
  `Activity_Type` varchar(50) NOT NULL,
  PRIMARY KEY (`Center_Number`,`Activity_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rehab_Activity`
--

LOCK TABLES `Rehab_Activity` WRITE;
/*!40000 ALTER TABLE `Rehab_Activity` DISABLE KEYS */;
INSERT INTO `Rehab_Activity` VALUES (12,'swimming'),(19,'physical therapy'),(19,'Psychological therapy'),(21,'swimming'),(22,'gym'),(23,'gym'),(30,'cardio'),(34,'cardio'),(45,'therapist');
/*!40000 ALTER TABLE `Rehab_Activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rehab_Center`
--

DROP TABLE IF EXISTS `Rehab_Center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rehab_Center` (
  `Security_Level` char(1) NOT NULL,
  `Center_Number` int(11) NOT NULL,
  PRIMARY KEY (`Security_Level`,`Center_Number`),
  KEY `FK_RehabAct` (`Center_Number`),
  CONSTRAINT `FK_RehabAct` FOREIGN KEY (`Center_Number`) REFERENCES `Rehab_Activity` (`Center_Number`),
  CONSTRAINT `FK_Rehab_Center_PBlock` FOREIGN KEY (`Security_Level`) REFERENCES `Prison_Block` (`Security_Level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rehab_Center`
--

LOCK TABLES `Rehab_Center` WRITE;
/*!40000 ALTER TABLE `Rehab_Center` DISABLE KEYS */;
INSERT INTO `Rehab_Center` VALUES ('1',45),('2',19),('3',12),('3',21),('4',22),('5',23),('5',30),('6',34);
/*!40000 ALTER TABLE `Rehab_Center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `Staff_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Aadhar_Card` int(11) NOT NULL,
  `First_Name` varchar(100) NOT NULL,
  `Last_Name` varchar(100) NOT NULL,
  `Start_Date` date NOT NULL,
  `Address` text NOT NULL,
  `Prison_Block` char(1) DEFAULT NULL,
  `Supervisor_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Staff_Id`),
  KEY `FK_Staff_PBlock` (`Prison_Block`),
  KEY `FK_Staff_Supervisor` (`Supervisor_ID`),
  CONSTRAINT `FK_Staff_PBlock` FOREIGN KEY (`Prison_Block`) REFERENCES `Prison_Block` (`Security_Level`)
) ENGINE=InnoDB AUTO_INCREMENT=917 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (109,47316735,'Austin','Mendez','2014-08-28','833 Marcel Way, Suite 226, 14700, Mantefurt, Vermont, United States','3',132),(111,65478823,'Nicholas','Schroeder','2015-10-30','449 Ortiz Drive, Apt. 816, 39790, North Nick, Georgia, United States','5',137),(132,66015660,'Kimberly','Flores','2019-05-04','157 Gail Port, Apt. 584, 17645-7341, North Lucio, Wisconsin, United States','1',109),(137,40605126,'Tony','Cannon','2021-06-24','7709 Eryn Parks, Suite 449, 58443-1532, Erikside, Rhode Island, United States','2',519),(148,68316171,'Amanda','Romero','2021-04-02','037 Schamberger Heights, Suite 398, 23752, New Dewaynemouth, Rhode Island, United States','1',832),(185,62707725,'Juan','Anderson','2014-11-21','34413 Delmer Spurs, Apt. 297, 20867-9041, North Elijah, Indiana, United States','2',766),(263,89336010,'Corey','Hutchinson','2016-09-16','8742 Gutkowski Lane, Suite 817, 28797, North Demetris, Alabama, United States','3',410),(355,42418343,'Jennifer','Keller','2019-03-04','74333 Danika Extensions, Suite 372, 89950, Jeanneland, Vermont, United States','1',519),(407,81943393,'Nicole','Pena','2015-07-06','201 Morgan Mission, Apt. 968, 33845, North Domingoside, Wisconsin, United States','2',766),(410,15419112,'Joseph','Caldwell','2019-07-23','7859 Kattie Skyway, Apt. 683, 07924, New Carrollmouth, Alabama, United States','6',NULL),(519,25721832,'Timothy','Russell','2017-11-11','394 Schneider Islands, Suite 436, 41757-6049, Shieldston, Wyoming, United States','5',185),(541,44356381,'Oscar','Jones','2019-04-02','00470 Rod Point, Apt. 120, 62848, South Adalberto, Texas, United States','3',410),(550,84845435,'Frederick','Knapp','2017-01-21','327 Stephany Plaza, Apt. 464, 90179-4461, East Lavina, Tennessee, United States','2',111),(668,42807500,'Christina','Ruiz','2022-07-04','61012 Reinger Track, Apt. 853, 64260-1955, Mustafaview, Arkansas, United States','3',675),(675,27440002,'Robert','Peterson','2021-01-12','7258 Kassulke Rapids, Suite 955, 43441-7666, North Dashawn, Kansas, United States','3',745),(685,27612400,'Lori','Stout','2017-02-05','40679 Greenholt Coves, Suite 002, 82532-2388, New Rosario, California, United States','6',916),(745,20283328,'Shawn','Bradley','2020-08-30','256 Chad Corner, Suite 598, 14060-3848, North Elta, Hawaii, United States','6',111),(766,51684636,'Sherry','Smith','2018-10-25','43375 Botsford Well, Suite 682, 15301, Veumport, North Carolina, United States','5',675),(832,89801487,'Karen','West','2021-05-01','6047 Conroy Islands, Apt. 122, 08338, South Alvera, Wisconsin, United States','6',668),(916,20035357,'Timothy','Logan','2021-06-03','60305 Fay Station, Apt. 696, 58149-9989, Rosalindastad, Mississippi, United States','5',111);
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Weapon`
--

DROP TABLE IF EXISTS `Weapon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Weapon` (
  `Guard_ID` int(11) NOT NULL,
  `Weapon_Model` varchar(20) NOT NULL,
  `Last_Service` date NOT NULL,
  PRIMARY KEY (`Guard_ID`,`Weapon_Model`),
  KEY `FK_Weapon_Model` (`Weapon_Model`),
  CONSTRAINT `FK_Weapon_Guard` FOREIGN KEY (`Guard_ID`) REFERENCES `Prison_Guard` (`Guard_ID`),
  CONSTRAINT `FK_Weapon_Model` FOREIGN KEY (`Weapon_Model`) REFERENCES `Gun_Servicing` (`Weapon_Model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Weapon`
--

LOCK TABLES `Weapon` WRITE;
/*!40000 ALTER TABLE `Weapon` DISABLE KEYS */;
/*!40000 ALTER TABLE `Weapon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `Prison_Block_View`
--

/*!50001 DROP TABLE IF EXISTS `Prison_Block_View`*/;
/*!50001 DROP VIEW IF EXISTS `Prison_Block_View`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`cumbum`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Prison_Block_View` AS select `Prisoner`.`Block_Code` AS `Prison_Block`,count(0) AS `Count(*)`,sum(`Prisoner`.`Credit_Score`) AS `SUM(Credit_Score)` from `Prisoner` group by `Prisoner`.`Block_Code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-27 22:38:29
