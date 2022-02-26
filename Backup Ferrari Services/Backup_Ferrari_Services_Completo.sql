CREATE DATABASE  IF NOT EXISTS `ferrariservices` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ferrariservices`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: ferrariservices
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `number` varchar(20) NOT NULL,
  `complement` varchar(255) DEFAULT NULL,
  `district` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(128) NOT NULL,
  `country` varchar(100) NOT NULL,
  `zipcode` char(8) NOT NULL,
  `peopleId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fk_addresses` (`peopleId`),
  CONSTRAINT `index_fk_addresses` FOREIGN KEY (`peopleId`) REFERENCES `people` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'Avenida José Versolato','175','Andar 7','Centro','São Bernardo do Campo','São Paulo','Brasil','05214556',1),(2,'Avenida Paulista','1000','Andar 7, Apt 15','Bela Vista','São Paulo','São Paulo','Brasil','05214556',2),(3,'Rua São Carlos do Pinhal','525','Casa C','Bela Vista','São Paulo','São Paulo','Brasil','05214556',4),(4,'Rua das Laranjeiras','490','','Santa Luzia','São Bernardo do Campo','São Paulo','Brasil','05214556',5),(5,'Travessa Primeiro de Maio','430','','Jardim Europa','São José dos Pinhais','São Paulo','Brasil','05214556',6),(6,'Caixa Postal','23','Agência dos Correios','Parque Dona Gumercinda','Nova Serrana','Minas Gerais','Brasil','35524120',7);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwordrecoveries`
--

DROP TABLE IF EXISTS `passwordrecoveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passwordrecoveries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `userId` int NOT NULL,
  `active` tinyint DEFAULT NULL,
  `ip` char(15) DEFAULT NULL,
  `date_expire` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uq_token` (`token`),
  KEY `index_fk_passwordRecoveries` (`userId`),
  CONSTRAINT `index_fk_passwordRecoveries` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwordrecoveries`
--

LOCK TABLES `passwordrecoveries` WRITE;
/*!40000 ALTER TABLE `passwordrecoveries` DISABLE KEYS */;
INSERT INTO `passwordrecoveries` VALUES (1,'aaa64062dc39c0091b29f3c76f2071b29edf28aba45383d666f0a851dd66c3c9',7,0,'192.168.0.1','2021-08-20 00:10:04'),(2,'a3f955b8d22fb66bc1b2027f3e182f2150db36e40817b457e0fae2239b1a51aa',8,0,'192.168.0.15','2021-08-20 01:20:40');
/*!40000 ALTER TABLE `passwordrecoveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uq_payments` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'Boleto Bancário'),(5,'Cartão de Crédito'),(3,'Cartão de Débito'),(4,'Dinheiro a Vista'),(2,'PIX');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` char(16) NOT NULL,
  `document` char(13) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uq_people` (`document`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Glaucio Daniel','1990-05-10','11 32252222','14515625800','2021-08-10 19:38:35',NULL),(2,'Djalma Sindeaux','1981-01-30','1132252222','561515153','2021-08-10 19:44:14',NULL),(4,'João Rangel','1989-05-20','1140045566','561543153','2021-08-10 19:47:42',NULL),(5,'Ronaldo Braz','1990-05-01','1132252222','561999153','2021-08-10 19:50:39',NULL),(6,'Geisa Lima','1991-03-28','1197852222','365999153','2021-08-10 19:50:39',NULL),(7,'Roberto Griel Filho','1989-08-28','37991372222','398999153','2021-08-10 19:50:39',NULL),(8,'Nayane',NULL,'37991553707','00000000000','2021-08-12 19:29:35',NULL),(10,'Silvana',NULL,'37991553707','42343242','2021-08-12 19:41:02',NULL),(11,'José','2001-01-01','199999999','56561565','2021-08-12 20:27:19',NULL);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `peopleId` int NOT NULL,
  `timeOptionId` int NOT NULL,
  `paymentId` int NOT NULL,
  `billingAddressId` int NOT NULL,
  `schedule_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL,
  `installments` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fk_schedules_peopleId` (`peopleId`),
  KEY `index_fk_schedules_timeOption` (`timeOptionId`),
  KEY `index_fk_schedules_payment` (`paymentId`),
  KEY `index_fk_schedules_billingAddress` (`billingAddressId`),
  CONSTRAINT `index_fk_schedules_billingAddress` FOREIGN KEY (`billingAddressId`) REFERENCES `addresses` (`id`),
  CONSTRAINT `index_fk_schedules_payment` FOREIGN KEY (`paymentId`) REFERENCES `payments` (`id`),
  CONSTRAINT `index_fk_schedules_peopleId` FOREIGN KEY (`peopleId`) REFERENCES `people` (`id`),
  CONSTRAINT `index_fk_schedules_timeOption` FOREIGN KEY (`timeOptionId`) REFERENCES `time_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,4,2,5,4,'2021-08-11 09:00:00',1500.00,5),(2,1,19,4,1,'2021-08-13 11:00:00',5500.00,2),(3,5,13,2,4,'2021-08-11 16:00:00',1500.00,1);
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules_services`
--

DROP TABLE IF EXISTS `schedules_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules_services` (
  `schedulesId` int NOT NULL,
  `servicesId` int NOT NULL,
  PRIMARY KEY (`schedulesId`,`servicesId`),
  KEY `index_fk_schedules_schedulesServicesId` (`servicesId`),
  CONSTRAINT `index_fk_schedules_schedulesId` FOREIGN KEY (`schedulesId`) REFERENCES `schedules` (`id`),
  CONSTRAINT `index_fk_schedules_schedulesServicesId` FOREIGN KEY (`servicesId`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules_services`
--

LOCK TABLES `schedules_services` WRITE;
/*!40000 ALTER TABLE `schedules_services` DISABLE KEYS */;
INSERT INTO `schedules_services` VALUES (1,2),(1,3),(3,3),(2,4);
/*!40000 ALTER TABLE `schedules_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (2,'Alinhamento','Alinhamento e balanceamento dos pneus',1200.00),(3,'Filtros','Troca de filtros de ar e de combustível',989.99),(4,'Embreagem','Troca de discos de embreagem e cabos de apoio',2980.00),(5,'Freios','Troca de discos e fluidos de freio',780.00),(6,'Óleo de Câmbio','Troca de óleo do câmbio',450.10),(7,'Balanceamento','Balanceamento de Rodas',2500.00),(12,'Troca de Óleo','Troca do óleo e troca de filtros e outras coisa',2000.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_options`
--

DROP TABLE IF EXISTS `time_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `day` tinyint DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_options`
--

LOCK TABLES `time_options` WRITE;
/*!40000 ALTER TABLE `time_options` DISABLE KEYS */;
INSERT INTO `time_options` VALUES (1,1,'08:00:00'),(2,1,'09:00:00'),(3,1,'10:00:00'),(4,1,'11:00:00'),(5,1,'12:00:00'),(6,2,'08:00:00'),(7,2,'11:00:00'),(8,2,'13:00:00'),(9,2,'14:00:00'),(10,3,'13:00:00'),(11,3,'14:00:00'),(12,3,'15:00:00'),(13,3,'16:00:00'),(14,4,'13:00:00'),(15,4,'14:00:00'),(16,4,'15:00:00'),(17,4,'16:00:00'),(18,5,'08:00:00'),(19,5,'11:00:00'),(20,5,'13:00:00'),(21,5,'14:00:00'),(22,5,'17:00:00');
/*!40000 ALTER TABLE `time_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uq_user` (`email`),
  CONSTRAINT `index_fk_user` FOREIGN KEY (`id`) REFERENCES `people` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'glaucio@hcode.com','910b35b8f1565e76095ed4a0d64f2c412b7777d71832f773221ccf7763467150'),(2,'djalma@hcode.com','910b35b8f1565e76095ed4a0d64f2c412b7777d71832f773221ccf7763467150'),(4,'joao@hcode.com','2173efaeeaae3c333a28f1e0c6ee4e05dde0e2b98aa1a28f030d0a5ed7bf9ffa'),(5,'ronaldo@hcode.com','189cc14a11afd9558515569fdbd6e63c0edbccd16a1f761f7a3224168c780eb9'),(6,'geisa@hcode.com','7b79a12e4643c04bc6daf76c05c22d41d0c0315c159095242092b3c9c96efea2'),(7,'roberto@griel.com.br','teste_da_silva'),(8,'nayanefaria.ns@gmail.com','teste_da_silva'),(10,'silvana@gmail.com','769ebc5ef3cf057cd5bd0dc406acabbdb5ccadd6d2712d5c9480f9b847444800');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_people_millennials`
--

DROP TABLE IF EXISTS `v_people_millennials`;
/*!50001 DROP VIEW IF EXISTS `v_people_millennials`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_people_millennials` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `birth_date`,
 1 AS `phone`,
 1 AS `document`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_total`
--

DROP TABLE IF EXISTS `v_user_total`;
/*!50001 DROP VIEW IF EXISTS `v_user_total`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_total` AS SELECT 
 1 AS `Usuário`,
 1 AS `E-Mail`,
 1 AS `Quantidade`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'ferrariservices'
--

--
-- Dumping routines for database 'ferrariservices'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_get_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_get_token`(ptoken varchar(255)) RETURNS tinyint
    READS SQL DATA
begin
		declare vvalid tinyint;
		if exists(select token from passwordrecoveries where token = ptoken
        and active = 1 and date_expire >= current_timestamp()
        ) then
			set vvalid = 1;
		else
			set vvalid = 0;
        end if;
        return vvalid;        
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_people` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_people`(
	IN pName 		VARCHAR(255),
    IN pEmail 		VARCHAR(255),
    IN pPassword 	VARCHAR(255),
    IN pPhone		CHAR(16),
    IN pDocument	CHAR(13)
)
BEGIN
	DECLARE vId INT;
    
	IF NOT EXISTS (SELECT email FROM users WHERE email = pEmail) THEN
		-- INSERT
        
        START TRANSACTION;
        
        INSERT INTO people (name, phone, document) VALUES (pName, pPhone, pDocument);
        SELECT LAST_INSERT_ID() INTO vId;
        
        IF (vId > 0) THEN 
        
			INSERT INTO users VALUES (vId, pEmail, sha2(pPassword, 256));
			
			COMMIT;
			
			SELECT CONCAT('Usuário ', pName, ' cadastrado com sucesso!') as RESULT;
            
            ELSE
            
				SELECT CONCAT('Deu algum erro aqui!') as RESULT;
				
                ROLLBACK;
        
        END IF;
        

	ELSE 
		
        SELECT 'Usuário já cadastrado' AS result;
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_services` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_services`(
	IN pName VARCHAR(45),
	IN pDesc TEXT,
	IN pPrice dec(10,2))
BEGIN
	
    declare vId INT;
    SELECT id INTO vId FROM services WHERE name = pName;

	IF NOT EXISTS(SELECT name FROM services WHERE name = pName) THEN
		INSERT INTO services VALUES(NULL, pName, pDesc, pPrice);
		SELECT concat('Serviço ', pName, ' cadastrado com sucesso.') AS result;
	ELSE
		if (vId > 0) THEN
			UPDATE services SET name = pName, description = pDesc, price = pPrice WHERE id = vId;
			SELECT concat('Serviço ', pName, ' atualizado com sucesso.') AS result;
		END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_del_services` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_del_services`(
	IN pName VARCHAR(45))
BEGIN
	
    declare vId INT;
    SELECT id INTO vId FROM services WHERE name = pName;
    
	DELETE FROM schedules_services where servicesId = vId;
	DELETE FROM services WHERE id = vId;
    
	SELECT concat('Serviço ', pName, ' apagado com sucesso.') AS result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_recovery_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recovery_password`(
	IN pEmail VARCHAR(255),
    IN pIp CHAR(15)
)
BEGIN

	declare vId INT;
    DECLARE vToken VARCHAR(255);
    
    SET vToken = sha2(rand() * 10000, 256);
    
    SELECT id INTO vId FROM users WHERE email = pEmail;
    
    INSERT INTO passwordrecoveries VALUES (
		null, 
        vToken,
        vId,
        1,
        pIp,
        date_add(now(), interval 7 day));
        
	SELECT vToken AS result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upd_recoverypassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_upd_recoverypassword`(
	IN pEmail		VARCHAR(255),
    IN pToken		VARCHAR(255),
    IN pPassword 	VARCHAR(255)
)
BEGIN

	DECLARE vId INT;

	if (fn_get_token(pToken) = 1) THEN
    
		SELECT id INTO vId FROM users WHERE email = pEmail;
        
        UPDATE users SET password = pPassword WHERE id = vId;
        
        UPDATE passwordrecoveries SET active = 0 WHERE token = pToken;
        
        SELECT 'Senha alterada com sucesso!' AS result;
        
	ELSE 
    
		SELECT 'Esse link expirou!' AS result;
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_people_millennials`
--

/*!50001 DROP VIEW IF EXISTS `v_people_millennials`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_people_millennials` AS select `people`.`id` AS `id`,`people`.`name` AS `name`,`people`.`birth_date` AS `birth_date`,`people`.`phone` AS `phone`,`people`.`document` AS `document`,`people`.`created_at` AS `created_at`,`people`.`updated_at` AS `updated_at` from `people` where (`people`.`birth_date` >= '2000-01-01') */
/*!50002 WITH CASCADED CHECK OPTION */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_total`
--

/*!50001 DROP VIEW IF EXISTS `v_user_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_total` AS select `a`.`name` AS `Usuário`,`b`.`email` AS `E-Mail`,count(`c`.`peopleId`) AS `Quantidade`,sum(`c`.`total`) AS `Total` from ((`people` `a` join `users` `b` on((`a`.`id` = `b`.`id`))) join `schedules` `c` on((`a`.`id` = `c`.`peopleId`))) group by `c`.`peopleId` having (sum(`c`.`total`) > 2000) */;
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

-- Dump completed on 2021-08-12 22:54:37
