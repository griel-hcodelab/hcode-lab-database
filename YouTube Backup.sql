CREATE DATABASE  IF NOT EXISTS `youtube` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `youtube`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: database-developer-red.cmqfjroojfgj.us-east-2.rds.amazonaws.com    Database: youtube
-- ------------------------------------------------------
-- Server version	8.0.23

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `tb_channel`
--

DROP TABLE IF EXISTS `tb_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_channel` (
  `id_channel` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `channel_name` varchar(100) NOT NULL,
  `channel_url` varchar(45) NOT NULL,
  `subscription` bigint NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `channel_active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_channel`),
  UNIQUE KEY `channel_url_uq` (`channel_url`),
  KEY `fk_tb_channel_tb_users` (`id_user`),
  CONSTRAINT `fk_tb_channel_tb_users` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_channel`
--

LOCK TABLES `tb_channel` WRITE;
/*!40000 ALTER TABLE `tb_channel` DISABLE KEYS */;
INSERT INTO `tb_channel` VALUES (1,2,'Canal Sabe Tudo','Canal_Sabe_Tudo',0,'2021-08-24 00:53:53','2021-08-24 00:53:53',1),(2,3,'Churrasco Brasil','churrasco_brasil',0,'2021-08-24 02:04:58','2021-08-24 02:04:58',1),(3,4,'Games SP','games_sp',0,'2021-08-24 02:07:47','2021-08-24 02:07:47',1),(4,4,'Vida Saudavel','vida_saudavel',0,'2021-08-24 02:12:47','2021-08-24 02:12:47',0),(5,9,'Infotec Cursos','infotec_cursos',0,'2021-08-24 02:19:10','2021-08-24 02:19:10',1),(6,10,'Arte em tecido','arte_em_tecido',0,'2021-08-24 02:21:14','2021-08-24 02:21:14',1),(7,13,'Canal do Programador PHP','canal_do_programador_php',0,'2021-08-25 23:28:23','2021-08-25 23:28:23',1);
/*!40000 ALTER TABLE `tb_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_channel_settings`
--

DROP TABLE IF EXISTS `tb_channel_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_channel_settings` (
  `id_channel` int NOT NULL,
  `channel_banner_image` varchar(255) DEFAULT NULL,
  `channel_avatar_image` varchar(255) DEFAULT NULL,
  `channel_description` text,
  `channel_location` varchar(140) NOT NULL,
  `channel_video_trailer` int DEFAULT NULL,
  `channel_video_featured` int DEFAULT NULL,
  `channel_currency` varchar(4) NOT NULL DEFAULT 'BRL',
  `channel_keywords` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_channel`),
  CONSTRAINT `fk_tb_channel_banner_tb_channel` FOREIGN KEY (`id_channel`) REFERENCES `tb_channel` (`id_channel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_channel_settings`
--

LOCK TABLES `tb_channel_settings` WRITE;
/*!40000 ALTER TABLE `tb_channel_settings` DISABLE KEYS */;
INSERT INTO `tb_channel_settings` VALUES (1,'bannerphp8.webp','avatarphp8.webp','Aprenda PHP 8.1 com qualidade','Brasil',NULL,NULL,'USD','programação, php8.1');
/*!40000 ALTER TABLE `tb_channel_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_channel_upload_defaults`
--

DROP TABLE IF EXISTS `tb_channel_upload_defaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_channel_upload_defaults` (
  `id_channel` int NOT NULL,
  `video_title` varchar(255) DEFAULT NULL,
  `video_description` text,
  `video_visibility` enum('public','restricted','private') DEFAULT NULL,
  `video_tags` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_channel`),
  CONSTRAINT `fk_tb_channel_upload_defaults_tb_channel` FOREIGN KEY (`id_channel`) REFERENCES `tb_channel` (`id_channel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_channel_upload_defaults`
--

LOCK TABLES `tb_channel_upload_defaults` WRITE;
/*!40000 ALTER TABLE `tb_channel_upload_defaults` DISABLE KEYS */;
INSERT INTO `tb_channel_upload_defaults` VALUES (1,'TESTE','TESTE','','TESTE');
/*!40000 ALTER TABLE `tb_channel_upload_defaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_person`
--

DROP TABLE IF EXISTS `tb_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_person` (
  `id_user` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `fk_tb_person_tb_users1` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_person`
--

LOCK TABLES `tb_person` WRITE;
/*!40000 ALTER TABLE `tb_person` DISABLE KEYS */;
INSERT INTO `tb_person` VALUES (1,'Roberto G','1989-08-28'),(2,'José Cunha','2005-05-19'),(3,'Luis Fernando','1986-09-27'),(4,'Antonio Carlos','1976-11-07'),(5,'Joelma Cardoso','1986-03-01'),(6,'Jesus Carlos','1990-08-14'),(7,'Felipe Silva','1999-01-15'),(8,'Marcela Fernandes','2002-04-03'),(9,'Pedro Parimoski','1988-04-01'),(10,'Julia Luiza','1993-04-07'),(12,'Usuário do YouTube','1989-08-28'),(13,'José Antonio Silveira Gonçalves Dores','1975-08-28'),(14,'José Antonio Dores','1975-08-28'),(15,'Roberto Filho','1975-08-28');
/*!40000 ALTER TABLE `tb_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_playlist_video`
--

DROP TABLE IF EXISTS `tb_playlist_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_playlist_video` (
  `id_playlist` int NOT NULL,
  `id_video` int NOT NULL,
  PRIMARY KEY (`id_playlist`,`id_video`),
  KEY `fk_tb_playlist_video_tb_playlists_video_idx` (`id_video` DESC),
  KEY `fk_tb_playlist_video_tb_playlists_video` (`id_video`),
  CONSTRAINT `fk_tb_playlist_video_tb_playlists` FOREIGN KEY (`id_playlist`) REFERENCES `tb_playlists` (`id`),
  CONSTRAINT `fk_tb_playlist_video_tb_playlists_video` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_playlist_video`
--

LOCK TABLES `tb_playlist_video` WRITE;
/*!40000 ALTER TABLE `tb_playlist_video` DISABLE KEYS */;
INSERT INTO `tb_playlist_video` VALUES (1,81);
/*!40000 ALTER TABLE `tb_playlist_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_playlists`
--

DROP TABLE IF EXISTS `tb_playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_channel` int NOT NULL,
  `name` varchar(140) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `playlist_description` text,
  `playlist_visibility` enum('public','restricted','private') NOT NULL DEFAULT 'private',
  PRIMARY KEY (`id`),
  KEY `fk_tb_playlists_tb_channel_idx` (`id_channel` DESC),
  KEY `fk_tb_playlists_tb_channel` (`id_channel`),
  CONSTRAINT `fk_tb_playlists_tb_channel` FOREIGN KEY (`id_channel`) REFERENCES `tb_channel` (`id_channel`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_playlists`
--

LOCK TABLES `tb_playlists` WRITE;
/*!40000 ALTER TABLE `tb_playlists` DISABLE KEYS */;
INSERT INTO `tb_playlists` VALUES (1,1,'Mais Assistidos','2021-08-24 01:28:48','2021-08-24 01:28:48',NULL,'private'),(2,1,'Tutoriais','2021-08-24 01:28:52','2021-08-24 01:28:52',NULL,'private'),(3,2,'Os melhores churrascos','2021-08-24 02:42:26','2021-08-24 02:42:26',NULL,'private'),(4,2,'Preparo de Carne','2021-08-24 02:42:30','2021-08-24 02:42:30',NULL,'private'),(5,3,'Game Play','2021-08-24 02:43:39','2021-08-24 02:43:39',NULL,'private'),(6,3,'Os mais acessados','2021-08-24 02:43:42','2021-08-24 02:43:42',NULL,'private'),(7,3,'Lives','2021-08-24 02:43:44','2021-08-24 02:43:44',NULL,'private'),(8,4,'Receitas Caseiras','2021-08-24 02:44:27','2021-08-24 02:44:27',NULL,'private'),(9,4,'Exercicios para fazer em casa','2021-08-24 02:44:29','2021-08-24 02:44:29',NULL,'private'),(10,5,'Os cursos mais assistidos!','2021-08-24 02:55:12','2021-08-24 02:55:12',NULL,'private'),(11,5,'Dicas e truques','2021-08-24 02:55:16','2021-08-24 02:55:16',NULL,'private'),(12,6,'Coloração','2021-08-24 02:56:11','2021-08-24 02:56:11',NULL,'private'),(13,6,'Efeitos de Luz','2021-08-24 02:56:15','2021-08-24 02:56:15',NULL,'private'),(14,5,'C++ Developer','2021-08-24 04:01:45','2021-08-24 04:01:45',NULL,'private'),(15,5,'Database Developer','2021-08-24 04:13:34','2021-08-24 04:13:34',NULL,'private'),(16,5,'Node.JS Developer','2021-08-24 04:22:43','2021-08-24 04:22:43',NULL,'private'),(17,5,'Database Developer','2021-08-24 04:29:37','2021-08-24 04:29:37',NULL,'private');
/*!40000 ALTER TABLE `tb_playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_system_categories`
--

DROP TABLE IF EXISTS `tb_system_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_system_categories` (
  `id` tinyint NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_system_categories`
--

LOCK TABLES `tb_system_categories` WRITE;
/*!40000 ALTER TABLE `tb_system_categories` DISABLE KEYS */;
INSERT INTO `tb_system_categories` VALUES (1,'Filmes e animação'),(2,'Automóveis'),(3,'Música'),(4,'Animais'),(5,'Esportes'),(6,'Viagens e eventos'),(7,'Jogos'),(8,'Pessoas e blogs'),(9,'Comédia'),(10,'Entretenimento'),(11,'Notícias e política'),(12,'Instruções e estilo'),(13,'Educação'),(14,'Ciência e tecnologia'),(15,'Sem fins lucrativos e ativismo');
/*!40000 ALTER TABLE `tb_system_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_uq` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
INSERT INTO `tb_users` VALUES (1,'roberto@griel.com.br','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','2021-08-24 00:36:45'),(2,'josecunha@gmail.com','a180952d256e7bedad91fc00e77c9c8f83d61859e4a01e297cc801fe77b6a826','2021-08-24 00:36:48'),(3,'luisfernando@gmail.com','8946aad2668234a5f288d14c017bde6b2b537111db4b65fc26c978f54f741018','2021-08-24 02:03:48'),(4,'antoniocarlos@gmail.com','f0e488b5f451785e120ab569a6775ddacf96de1bd2dde94c242d342f80f4e882','2021-08-24 02:06:24'),(5,'joelmacardoso@gmail.com','07b1b3db08eb413ddf66e33daaa2e084449bedb5646a5fffbe426353b32206d3','2021-08-24 02:08:45'),(6,'jesuscarlos@gmail.com','8946aad2668234a5f288d14c017bde6b2b537111db4b65fc26c978f54f741018','2021-08-24 02:11:37'),(7,'felipesilva@gmail.com','f0526608555e39363514ec512c41b17e8abdb97ddaa8201973dc0a468793a5aa','2021-08-24 02:15:10'),(8,'marcelafernandes@gmail.com','3d2d8a8ef49121c527d772c4145891216e00b99da4d95e43f6f7cbba26bbb008','2021-08-24 02:16:01'),(9,'parimoski@gmail.com','0f6c65f0ad78fe0d9358f184dccf115ff764b3c9da9546dd6e43830fb95227ae','2021-08-24 02:18:26'),(10,'julialuiza@gmail.com','1dc4e8bd3688013101a61670005c20877a548907a0ad3d9ccb5dfcdaa5417ba1','2021-08-24 02:20:45'),(11,'usuario1@youtube.com.br','eb1cf34443212519fa9c5c77d864058653e3bc122490457b112a57f006f7704e','2021-08-25 22:42:22'),(12,'usuario2@youtube.com.br','eb1cf34443212519fa9c5c77d864058653e3bc122490457b112a57f006f7704e','2021-08-25 22:53:28'),(13,'josedasilva@gmail.com','cc7c7b2de7379f6980b0c4b70d83ab32552b7c6e4609641fe001f08af6272f45','2021-08-25 22:54:42'),(14,'apresentacao@youtube.com','cc7c7b2de7379f6980b0c4b70d83ab32552b7c6e4609641fe001f08af6272f45','2021-08-26 23:11:00'),(15,'roberto@youtube.com.br','cc7c7b2de7379f6980b0c4b70d83ab32552b7c6e4609641fe001f08af6272f45','2021-08-27 22:01:48');
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users_premium`
--

DROP TABLE IF EXISTS `tb_users_premium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users_premium` (
  `id_user` int NOT NULL,
  `valid_until` date NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `fk_tb_users_premium_tb_users` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users_premium`
--

LOCK TABLES `tb_users_premium` WRITE;
/*!40000 ALTER TABLE `tb_users_premium` DISABLE KEYS */;
INSERT INTO `tb_users_premium` VALUES (1,'2022-01-21','2021-08-27 02:37:02'),(2,'2021-09-23','2021-08-24 00:47:00'),(6,'2021-09-23','2021-08-24 02:11:59'),(8,'2021-09-23','2021-08-24 02:17:36'),(9,'2023-01-16','2021-08-27 02:37:15'),(10,'2021-09-23','2021-08-24 02:20:56'),(11,'2021-11-24','2021-08-26 00:14:07'),(13,'2022-05-22','2021-08-25 23:19:38'),(14,'2021-11-24','2021-08-27 02:36:46'),(15,'2021-09-26','2021-08-27 22:02:49');
/*!40000 ALTER TABLE `tb_users_premium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_video_category`
--

DROP TABLE IF EXISTS `tb_video_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_video_category` (
  `id_video` int NOT NULL,
  `id_category` tinyint NOT NULL,
  PRIMARY KEY (`id_video`,`id_category`),
  KEY `fk_tb_videos_category_tb_videos_idx` (`id_video` DESC),
  KEY `fk_tb_video_category_tb_system_categories_idx` (`id_category` DESC),
  CONSTRAINT `fk_tb_video_category_tb_system_categories` FOREIGN KEY (`id_category`) REFERENCES `tb_system_categories` (`id`),
  CONSTRAINT `fk_tb_videos_category_tb_videos` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_video_category`
--

LOCK TABLES `tb_video_category` WRITE;
/*!40000 ALTER TABLE `tb_video_category` DISABLE KEYS */;
INSERT INTO `tb_video_category` VALUES (81,1);
/*!40000 ALTER TABLE `tb_video_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_video_current_state`
--

DROP TABLE IF EXISTS `tb_video_current_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_video_current_state` (
  `id_video` int NOT NULL,
  `id_user` int NOT NULL,
  `current_state` time NOT NULL DEFAULT '00:00:00',
  KEY `fk_tb_videos_current_state_tb_videos_idx` (`id_video` DESC),
  KEY `fk_tb_videos_current_state_tb_user_idx` (`id_user` DESC),
  CONSTRAINT `fk_tb_videos_current_state_tb_user` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id`),
  CONSTRAINT `fk_tb_videos_current_state_tb_videos` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_video_current_state`
--

LOCK TABLES `tb_video_current_state` WRITE;
/*!40000 ALTER TABLE `tb_video_current_state` DISABLE KEYS */;
INSERT INTO `tb_video_current_state` VALUES (2,1,'00:00:55'),(1,1,'00:00:55');
/*!40000 ALTER TABLE `tb_video_current_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_video_deleted`
--

DROP TABLE IF EXISTS `tb_video_deleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_video_deleted` (
  `id_video` int NOT NULL,
  `deleted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TABELA DE HISTÓRICO DE EXCLUSÃO DE VIDEOS.\n\nIrá armazenar os dados do vídeo excluído, como o id do vídeo, o id do usuário que excluiu, a data de exclusão e o motivo, que pode ser exclusão proposital do usuário, strike ou denúncia por exemplo.'
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_video_deleted`
--

LOCK TABLES `tb_video_deleted` WRITE;
/*!40000 ALTER TABLE `tb_video_deleted` DISABLE KEYS */;
INSERT INTO `tb_video_deleted` VALUES (48,'2021-08-26 20:17:23'),(3,'2021-08-26 21:38:09'),(4,'2021-08-26 21:38:09'),(5,'2021-08-26 21:38:09'),(6,'2021-08-26 21:38:09'),(7,'2021-08-26 21:38:09'),(8,'2021-08-26 21:38:09'),(9,'2021-08-26 21:38:09'),(10,'2021-08-26 21:38:09'),(11,'2021-08-26 21:38:09'),(12,'2021-08-26 21:38:09'),(13,'2021-08-26 21:38:09'),(14,'2021-08-26 21:38:09'),(15,'2021-08-26 21:38:09'),(16,'2021-08-26 21:38:09'),(17,'2021-08-26 21:38:09'),(18,'2021-08-26 21:38:09'),(19,'2021-08-26 21:38:09'),(20,'2021-08-26 21:38:09'),(21,'2021-08-26 21:38:09'),(22,'2021-08-26 21:38:09'),(23,'2021-08-26 21:38:09'),(24,'2021-08-26 21:38:09'),(25,'2021-08-26 21:38:09'),(26,'2021-08-26 21:38:09'),(27,'2021-08-26 21:38:09'),(28,'2021-08-26 21:38:09'),(29,'2021-08-26 21:38:09'),(30,'2021-08-26 21:38:09'),(31,'2021-08-26 21:38:09'),(32,'2021-08-26 21:38:09'),(33,'2021-08-26 21:38:09'),(34,'2021-08-26 21:38:09'),(35,'2021-08-26 21:38:09'),(36,'2021-08-26 21:38:09'),(37,'2021-08-26 21:38:09'),(38,'2021-08-26 21:38:09'),(39,'2021-08-26 21:38:09'),(40,'2021-08-26 21:38:09'),(41,'2021-08-26 21:38:09'),(42,'2021-08-26 21:38:09'),(43,'2021-08-26 21:38:09'),(44,'2021-08-26 21:38:09'),(45,'2021-08-26 21:38:09'),(46,'2021-08-26 21:38:09'),(47,'2021-08-26 21:38:09'),(49,'2021-08-26 22:30:34'),(50,'2021-08-26 22:30:34'),(51,'2021-08-26 22:30:34'),(52,'2021-08-26 22:30:34'),(53,'2021-08-26 22:30:34'),(54,'2021-08-26 22:30:34'),(55,'2021-08-26 22:30:34'),(56,'2021-08-26 22:30:34'),(57,'2021-08-26 22:30:34'),(58,'2021-08-26 22:30:34'),(59,'2021-08-26 22:32:14'),(60,'2021-08-26 22:32:14'),(61,'2021-08-26 22:32:14'),(62,'2021-08-26 22:32:14'),(63,'2021-08-26 22:32:14'),(64,'2021-08-26 23:30:15'),(65,'2021-08-26 23:32:55'),(66,'2021-08-26 23:36:41'),(67,'2021-08-26 23:42:35'),(68,'2021-08-26 23:42:35'),(69,'2021-08-26 23:42:35'),(70,'2021-08-26 23:42:35'),(71,'2021-08-26 23:42:35'),(72,'2021-08-26 23:42:35'),(73,'2021-08-26 23:42:35'),(74,'2021-08-26 23:42:35'),(75,'2021-08-26 23:42:35'),(76,'2021-08-26 23:42:35'),(77,'2021-08-26 23:42:35'),(78,'2021-08-26 23:42:35'),(79,'2021-08-26 23:42:35'),(80,'2021-08-26 23:42:35'),(83,'2021-08-27 22:21:06'),(82,'2021-08-27 22:22:11');
/*!40000 ALTER TABLE `tb_video_deleted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_video_view`
--

DROP TABLE IF EXISTS `tb_video_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_video_view` (
  `id_view` int NOT NULL AUTO_INCREMENT,
  `id_video` int DEFAULT NULL,
  `id_user` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_view`),
  KEY `fk_tb_video_view_id_video_idx` (`id_video` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_video_view`
--

LOCK TABLES `tb_video_view` WRITE;
/*!40000 ALTER TABLE `tb_video_view` DISABLE KEYS */;
INSERT INTO `tb_video_view` VALUES (1,1,1,'2021-08-25 01:40:24'),(2,1,2,'2021-08-25 01:40:25'),(3,1,2,'2021-08-25 01:40:25'),(4,1,5,'2021-08-25 01:40:25'),(5,1,0,'2021-08-27 00:34:11'),(6,1,0,'2021-08-27 00:34:26'),(7,1,0,'2021-08-27 00:34:43'),(8,1,0,'2021-08-27 00:34:47'),(9,1,1,'2021-08-27 00:34:54'),(10,1,0,'2021-08-27 00:50:27'),(11,2,0,'2021-08-27 00:50:34'),(12,1,0,'2021-08-27 00:55:45'),(13,2,1,'2021-08-27 00:55:56'),(14,1,0,'2021-08-27 00:56:46'),(15,2,1,'2021-08-27 00:56:53'),(16,2,1,'2021-08-27 01:01:56'),(17,2,1,'2021-08-27 01:02:01'),(18,1,0,'2021-08-27 01:09:10'),(19,NULL,0,'2021-08-27 01:13:30'),(20,NULL,0,'2021-08-27 01:15:32'),(21,2,1,'2021-08-27 01:15:37'),(22,NULL,0,'2021-08-27 01:15:43'),(23,2,1,'2021-08-27 01:15:47'),(24,NULL,1,'2021-08-27 01:15:55'),(25,1,0,'2021-08-27 01:16:11'),(26,NULL,1,'2021-08-27 01:16:15'),(27,NULL,1,'2021-08-27 01:16:55'),(28,NULL,1,'2021-08-27 01:17:29'),(29,NULL,1,'2021-08-27 01:17:46'),(30,NULL,1,'2021-08-27 01:18:35'),(31,NULL,1,'2021-08-27 01:18:46'),(32,NULL,1,'2021-08-27 01:20:05'),(33,2,0,'2021-08-27 01:22:42'),(34,NULL,1,'2021-08-27 01:23:03'),(35,NULL,1,'2021-08-27 01:23:35'),(36,2,1,'2021-08-27 01:23:43'),(37,NULL,0,'2021-08-27 01:23:50'),(38,NULL,0,'2021-08-27 01:23:59'),(39,2,1,'2021-08-27 01:24:04'),(40,NULL,0,'2021-08-27 01:24:09'),(41,1,0,'2021-08-27 01:24:13'),(42,1,0,'2021-08-27 01:24:21'),(43,NULL,0,'2021-08-27 01:24:31'),(44,2,1,'2021-08-27 01:24:38'),(45,NULL,1,'2021-08-27 01:24:45'),(46,NULL,1,'2021-08-27 01:24:52'),(47,NULL,1,'2021-08-27 01:24:54'),(48,NULL,1,'2021-08-27 01:59:05'),(49,NULL,1,'2021-08-27 01:59:08'),(50,2,1,'2021-08-27 02:00:41'),(51,2,1,'2021-08-27 02:00:45'),(52,2,0,'2021-08-27 02:00:50'),(53,2,1,'2021-08-27 02:00:54'),(54,2,1,'2021-08-27 02:02:26'),(55,2,1,'2021-08-27 02:02:29'),(56,2,0,'2021-08-27 02:02:35'),(57,2,1,'2021-08-27 02:02:38'),(58,2,1,'2021-08-27 02:11:47'),(59,2,1,'2021-08-27 02:12:23'),(60,2,1,'2021-08-27 02:12:28'),(61,2,1,'2021-08-27 02:12:39'),(62,2,1,'2021-08-27 02:12:51'),(63,2,1,'2021-08-27 02:13:52'),(64,2,1,'2021-08-27 02:26:02'),(65,2,1,'2021-08-27 02:31:29'),(66,2,1,'2021-08-27 02:31:42'),(67,2,1,'2021-08-27 02:32:16'),(68,2,1,'2021-08-27 21:29:13'),(69,2,1,'2021-08-27 21:31:44'),(70,2,1,'2021-08-27 21:31:49'),(71,2,1,'2021-08-27 21:31:52'),(72,2,1,'2021-08-27 21:44:39'),(73,1,1,'2021-08-27 21:44:46'),(74,1,2,'2021-08-27 21:44:53'),(75,1,2,'2021-08-27 21:48:35'),(76,1,3,'2021-08-27 21:48:53'),(77,1,3,'2021-08-27 21:50:14'),(78,1,1,'2021-08-27 21:50:31'),(79,1,1,'2021-08-27 21:51:00'),(80,1,2,'2021-08-27 21:51:05'),(81,81,1,'2021-08-27 21:51:50'),(82,81,1,'2021-08-27 21:52:24'),(83,1,1,'2021-08-27 21:52:33'),(84,2,1,'2021-08-27 21:52:38'),(85,2,1,'2021-08-27 21:53:35'),(86,2,1,'2021-08-27 21:53:56'),(87,1,1,'2021-08-27 21:53:59'),(88,1,2,'2021-08-27 21:54:07'),(89,2,1,'2021-08-27 21:54:15'),(90,2,1,'2021-08-27 21:54:46'),(91,81,1,'2021-08-27 21:56:01'),(92,81,0,'2021-08-27 21:56:09'),(93,1,2,'2021-08-27 21:56:45'),(94,1,1,'2021-08-27 21:56:54'),(95,1,2,'2021-08-27 21:56:57'),(96,1,2,'2021-08-27 22:18:27');
/*!40000 ALTER TABLE `tb_video_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_videos`
--

DROP TABLE IF EXISTS `tb_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_videos` (
  `id_video` int NOT NULL AUTO_INCREMENT,
  `id_channel` int NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `video_name` varchar(140) NOT NULL,
  `uploaded_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `video_length` time NOT NULL,
  `video_tags` varchar(255) DEFAULT NULL,
  `video_is_restricted` tinyint NOT NULL DEFAULT '0',
  `paid_promotion` tinyint NOT NULL DEFAULT '0',
  `video_visibility` enum('public','restricted','private') NOT NULL DEFAULT 'private',
  `id_category` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_video`,`id_channel`),
  KEY `fk_tb_videos_tb_channel` (`id_channel` DESC),
  CONSTRAINT `fk_tb_videos_tb_channel` FOREIGN KEY (`id_channel`) REFERENCES `tb_channel` (`id_channel`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_videos`
--

LOCK TABLES `tb_videos` WRITE;
/*!40000 ALTER TABLE `tb_videos` DISABLE KEYS */;
INSERT INTO `tb_videos` VALUES (1,1,'fdsfsd','Novo nome','2021-08-24 23:32:22','00:05:01','Novas tags',0,0,'public',1),(2,2,'fdsfsd','2021 - Vendo meu Corsa','2021-08-24 23:32:22','00:12:45','corsa, vendo corsa, carro ruim',1,0,'public',1),(81,1,'fffffffffdsfsdg','Vídeo que eu quero apagar','2021-08-27 21:16:54','00:05:12','instalar',0,0,'public',1);
/*!40000 ALTER TABLE `tb_videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `tg_video_history` BEFORE DELETE ON `tb_videos` FOR EACH ROW BEGIN

			INSERT INTO tb_video_deleted VALUES (old.id_video, NOW());
        
        END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_videos_comments`
--

DROP TABLE IF EXISTS `tb_videos_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_videos_comments` (
  `id_comment` int NOT NULL AUTO_INCREMENT,
  `id_video` int NOT NULL,
  `id_user` int NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comment`,`id_video`,`id_user`),
  KEY `fk_tb_videos_comments_tb_users` (`id_user` DESC),
  KEY `fk_tb_videos_comments_tb_videos` (`id_video` DESC),
  CONSTRAINT `fk_tb_videos_comments_tb_users` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id`),
  CONSTRAINT `fk_tb_videos_comments_tb_videos` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_videos_comments`
--

LOCK TABLES `tb_videos_comments` WRITE;
/*!40000 ALTER TABLE `tb_videos_comments` DISABLE KEYS */;
INSERT INTO `tb_videos_comments` VALUES (3,1,3,'Ai que tudooooo','2021-08-25 01:53:03');
/*!40000 ALTER TABLE `tb_videos_comments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `tg_comment_history` BEFORE DELETE ON `tb_videos_comments` FOR EACH ROW BEGIN
        
			INSERT INTO tb_videos_comments_history VALUES (old.id_video, old.comment, NOW());
        
        END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_videos_comments_history`
--

DROP TABLE IF EXISTS `tb_videos_comments_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_videos_comments_history` (
  `id_video` int NOT NULL,
  `comment` text NOT NULL,
  `deleted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_videos_comments_history`
--

LOCK TABLES `tb_videos_comments_history` WRITE;
/*!40000 ALTER TABLE `tb_videos_comments_history` DISABLE KEYS */;
INSERT INTO `tb_videos_comments_history` VALUES (1,'Parabéns','2021-08-26 01:44:25'),(64,'Ótimo!','2021-08-26 23:25:19'),(64,'Ótimo!','2021-08-26 23:30:15'),(2,'Ai que tudooooo','2021-08-27 21:36:22'),(83,'Novo comentário','2021-08-27 22:20:39');
/*!40000 ALTER TABLE `tb_videos_comments_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_videos_descriptions`
--

DROP TABLE IF EXISTS `tb_videos_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_videos_descriptions` (
  `id_video` int NOT NULL,
  `description` text,
  PRIMARY KEY (`id_video`),
  CONSTRAINT `fk_tb_video_descriptions_tb_videos` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_videos_descriptions`
--

LOCK TABLES `tb_videos_descriptions` WRITE;
/*!40000 ALTER TABLE `tb_videos_descriptions` DISABLE KEYS */;
INSERT INTO `tb_videos_descriptions` VALUES (81,'descrição');
/*!40000 ALTER TABLE `tb_videos_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_videos_likes`
--

DROP TABLE IF EXISTS `tb_videos_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_videos_likes` (
  `id_video` int NOT NULL,
  `id_user` int NOT NULL,
  `video_like` enum('-1','1') DEFAULT NULL,
  PRIMARY KEY (`id_video`,`id_user`),
  KEY `fk_tb_videos_likes_tb_user_idx` (`id_user`),
  CONSTRAINT `fk_tb_videos_likes_tb_user` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id`),
  CONSTRAINT `fk_tb_videos_likes_tb_videos` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_videos_likes`
--

LOCK TABLES `tb_videos_likes` WRITE;
/*!40000 ALTER TABLE `tb_videos_likes` DISABLE KEYS */;
INSERT INTO `tb_videos_likes` VALUES (1,1,'1'),(1,2,'-1'),(1,3,'1'),(1,4,'1'),(2,1,'1'),(2,2,'1'),(81,1,'1'),(81,2,'1'),(81,3,'-1');
/*!40000 ALTER TABLE `tb_videos_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_videos_thumbs`
--

DROP TABLE IF EXISTS `tb_videos_thumbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_videos_thumbs` (
  `id_video` int NOT NULL,
  `video_thumb_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id_video`),
  CONSTRAINT `fk_tb_videos_thumbs_tb_videos` FOREIGN KEY (`id_video`) REFERENCES `tb_videos` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_videos_thumbs`
--

LOCK TABLES `tb_videos_thumbs` WRITE;
/*!40000 ALTER TABLE `tb_videos_thumbs` DISABLE KEYS */;
INSERT INTO `tb_videos_thumbs` VALUES (1,'thumb.webp'),(81,'thumb.webp');
/*!40000 ALTER TABLE `tb_videos_thumbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_all_active_channels`
--

DROP TABLE IF EXISTS `vw_all_active_channels`;
/*!50001 DROP VIEW IF EXISTS `vw_all_active_channels`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_all_active_channels` AS SELECT 
 1 AS `id`,
 1 AS `Nome do Canal`,
 1 AS `URL`,
 1 AS `Inscritos`,
 1 AS `Criado em`,
 1 AS `Ultima atualizacao`,
 1 AS `active`,
 1 AS `Criador do Canal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_all_channels`
--

DROP TABLE IF EXISTS `vw_all_channels`;
/*!50001 DROP VIEW IF EXISTS `vw_all_channels`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_all_channels` AS SELECT 
 1 AS `id`,
 1 AS `Nome do Canal`,
 1 AS `URL`,
 1 AS `Inscritos`,
 1 AS `Criado em`,
 1 AS `Ultima atualizacao`,
 1 AS `active`,
 1 AS `Criador do Canal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_categories`
--

DROP TABLE IF EXISTS `vw_categories`;
/*!50001 DROP VIEW IF EXISTS `vw_categories`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_categories` AS SELECT 
 1 AS `id`,
 1 AS `Categoria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_channel_settings`
--

DROP TABLE IF EXISTS `vw_channel_settings`;
/*!50001 DROP VIEW IF EXISTS `vw_channel_settings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_channel_settings` AS SELECT 
 1 AS `id`,
 1 AS `Banner do Canal`,
 1 AS `Icone do canal`,
 1 AS `Descricao`,
 1 AS `Pais do Canal`,
 1 AS `Banner`,
 1 AS `Moeda Padrao`,
 1 AS `Palavras Chave`,
 1 AS `Video em Destaque`,
 1 AS `Trailer do Canal`,
 1 AS `Nome do Canal`,
 1 AS `URL do Canal`,
 1 AS `Inscritos`,
 1 AS `Canal criado em`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_comments`
--

DROP TABLE IF EXISTS `vw_comments`;
/*!50001 DROP VIEW IF EXISTS `vw_comments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_comments` AS SELECT 
 1 AS `id`,
 1 AS `ID do Comentario`,
 1 AS `Comentario`,
 1 AS `Data do comentario`,
 1 AS `Vídeo do comentário`,
 1 AS `Autor do Comentario`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_playlists`
--

DROP TABLE IF EXISTS `vw_playlists`;
/*!50001 DROP VIEW IF EXISTS `vw_playlists`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_playlists` AS SELECT 
 1 AS `id`,
 1 AS `Canal`,
 1 AS `Nome da Plalist`,
 1 AS `Data de Criacao`,
 1 AS `Ultima Atualizacao`,
 1 AS `Descricao`,
 1 AS `Visibilidade`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_search_channel`
--

DROP TABLE IF EXISTS `vw_search_channel`;
/*!50001 DROP VIEW IF EXISTS `vw_search_channel`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_search_channel` AS SELECT 
 1 AS `name`,
 1 AS `Nome do canal`,
 1 AS `URL`,
 1 AS `Inscritos`,
 1 AS `Descricao`,
 1 AS `Banner`,
 1 AS `Avatar`,
 1 AS `tags`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_select_video`
--

DROP TABLE IF EXISTS `vw_select_video`;
/*!50001 DROP VIEW IF EXISTS `vw_select_video`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_select_video` AS SELECT 
 1 AS `id`,
 1 AS `Titulo do video`,
 1 AS `Data de Upload`,
 1 AS `Duracao`,
 1 AS `Visualizações`,
 1 AS `Comentarios`,
 1 AS `Categoria`,
 1 AS `Descricao`,
 1 AS `Miniatura`,
 1 AS `Curtidas`,
 1 AS `Descurtidas`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'youtube'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `e_clean_comment_history` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`admin`@`%`*/ /*!50106 EVENT `e_clean_comment_history` ON SCHEDULE EVERY 10 SECOND STARTS '2021-08-26 01:55:59' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Limpando o histórico de comentários' DO BEGIN

	DELETE FROM tb_videos_comments_history WHERE deleted_at > DATE_ADD(deleted_at, INTERVAL 10 SECOND);

END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `e_hourly` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`admin`@`%`*/ /*!50106 EVENT `e_hourly` ON SCHEDULE EVERY 10 SECOND STARTS '2021-08-26 02:06:06' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'TESTE' DO BEGIN

	SELECT "Testando";

END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'youtube'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_random` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_random`(p_quantity TINYINT) RETURNS varchar(255) CHARSET utf8mb4
    READS SQL DATA
BEGIN
		DECLARE v_code VARCHAR(255);
		select substring(RAND(),3,p_quantity) INTO v_code;
        RETURN v_code;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_channel_d` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_channel_d`(
    IN p_id_channel INT,
    IN p_id_user INT
)
BEGIN

	DECLARE done INT DEFAULT 0;
    DECLARE v_video_id INT;
    DECLARE result INT;
    DECLARE video_list CURSOR FOR SELECT id_video FROM tb_videos WHERE id_channel = p_id_channel;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    
    START TRANSACTION;

	IF EXISTS (SELECT id FROM tb_users WHERE id = p_id_user) THEN
    
		IF EXISTS (SELECT id_channel FROM tb_channel WHERE id_channel = p_id_channel AND id_user = p_id_user) THEN
        
           
            OPEN video_list;
            
            REPEAT
				FETCH video_list INTO result;
                IF NOT done AND result > 1 THEN
                SELECT result;
					call sp_videos_d(result, p_id_channel, p_id_user);
                    SET done = 0;
				ELSE
                
					SET done = 1;
                    
				END IF;
                
			UNTIL done END REPEAT;
            
            IF (done = 1) THEN
            
			DELETE FROM tb_playlists WHERE id_channel = p_id_channel;
            DELETE FROM tb_channel_upload_defaults WHERE id_channel = p_id_channel;
            DELETE FROM tb_channel_subscribers WHERE id_channel = p_id_channel;
            DELETE FROM tb_channel_settings WHERE id_channel = p_id_channel;
			DELETE FROM tb_channel WHERE id_channel = p_id_channel AND id_user = p_id_user;
            
            END IF;

            
			COMMIT;
			SELECT 'O canal foi apagado com sucesso, e com ele, os vídeos também foram removidos.' AS result;
            
			CLOSE video_list;
        
        ELSE
			
            ROLLBACK;
			SELECT 'Não foi possível executar essa ação. Você não é o dono deste canal ou o canal não existe.' AS result;
        
        END IF;
    
    ELSE
    
		ROLLBACK;
		SELECT 'Não foi possível executar essa exclusão. O usuário não existe.' AS result;
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_channel_i` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_channel_i`(
	IN p_id_user INT,
    IN p_channel_name VARCHAR(100),
	OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	SET last_insert_id = 0;
    SET action_message = 'action not executed!';
    
    IF ((p_id_user > 0) AND (length(Trim(p_channel_name))>0)) THEN
		INSERT INTO tb_channel (id_user, channel_name, channel_url) VALUES (p_id_user, p_channel_name, LOWER(REPLACE(p_channel_name, ' ', '_')));
		
        SELECT last_insert_id() INTO last_insert_id;
		SELECT concat('Seja bem-vindo(a) aos Canais do YouTube! Seu canal ', p_channel_name, ' foi criado e está esperando por vídeos incríveis!') INTO action_message;
	END IF;

    -- next line command to show demonstration procedure action executed
    SELECT last_insert_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_channel_settings_iu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_channel_settings_iu`(
	IN p_channel_id INT,
    IN p_channel_location VARCHAR(40),
    IN p_channel_currenty VARCHAR(4),
	IN p_channel_banner_image VARCHAR(255),
    IN p_channel_avatar_image VARCHAR(255),
    IN p_channel_description TEXT,	
    IN p_channel_video_trailer INT,
    IN p_channel_video_featured INT,    
    IN p_channel_keywords VARCHAR(255),
	OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	SET last_insert_id = 0;
    SET action_message = 'action not executed!';

	IF NOT EXISTS (SELECT id_channel FROM tb_channel_settings WHERE id_channel = p_channel_id) THEN
		INSERT INTO tb_channel_settings
        (id_channel, channel_banner_image, channel_avatar_image, channel_description, channel_location, channel_video_trailer, channel_video_featured, channel_currency, channel_keywords) 
        VALUES (p_channel_id, p_channel_banner_image, p_channel_avatar_image, p_channel_description, p_channel_location, p_channel_video_trailer, p_channel_video_featured, p_channel_currenty, p_channel_keywords);
        
        SELECT last_insert_id() INTO last_insert_id;
    ELSE
        SELECT p_channel_id INTO last_insert_id;
		UPDATE tb_channel_settings SET channel_banner_image = p_channel_banner_image, channel_avatar_image = p_channel_avatar_image, channel_description = p_channel_description, channel_location = p_channel_location, channel_video_trailer = p_channel_video_trailer, channel_video_featured = p_channel_video_featured, channel_currency = p_channel_currenty, channel_keywords = p_channel_keywords WHERE id_channel = p_channel_id;
    END IF;

    SELECT 'As configurações do canal foram atualizadas com sucesso.' INTO action_message;
    
    -- next line command to show demonstration procedure action executed
    SELECT last_insert_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_channel_u` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_channel_u`(
	IN p_id_channel INT,
	IN p_id_user INT,
    IN ch_name VARCHAR(255),
	OUT action_message VARCHAR(255)
)
BEGIN

	DECLARE cha_name VARCHAR(255);
    SET action_message = 'action not executed!';
	
	IF EXISTS (SELECT channel_name FROM tb_channel WHERE  id_channel = p_id_channel AND id_user = p_id_user) THEN
        
		UPDATE tb_channel SET channel_name = ch_name, channel_url = replace( ch_name, ' ', '_') WHERE  id_channel = p_id_channel AND id_user = p_id_user;
        
        SELECT channel_name INTO cha_name FROM tb_channel WHERE id_channel = p_id_channel AND id_user = p_id_user;
        
		SELECT concat('O nome do canal passou a ser: ', cha_name) INTO action_message;
        
	ELSE 
    
		SELECT concat('Erro ao alterar o nome do canal') INTO action_message;
        
    END IF;
    SELECT action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_channel_upload_defaults_iu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_channel_upload_defaults_iu`(
	IN p_channel_id INT,
	IN p_video_title VARCHAR(255),
    IN p_video_description TEXT,
    IN p_video_visibility ENUM('public', 'restricted', 'private'),
    IN p_video_tags VARCHAR(255),
    OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN    
		SELECT 0 INTO last_insert_id;
		SELECT 'action not executed!' INTO action_message;
    END;
    
	IF NOT EXISTS (SELECT id_channel FROM tb_channel_upload_defaults WHERE id_channel = p_channel_id) THEN
        INSERT INTO tb_channel_upload_defaults (id_channel, video_title, video_description, video_visibility, video_tags) VALUES (p_channel_id, p_video_title, p_video_description, p_video_visibility, p_video_tags);
        SELECT last_insert_id() INTO last_insert_id;
    ELSE
		UPDATE tb_channel_upload_defaults SET video_title = p_video_title, video_description = p_video_description, video_visibility = p_video_visibility, video_tags = p_video_tags WHERE id_channel = p_channel_id;
        SELECT p_channel_id INTO last_insert_id;
    END IF;

    SELECT 'Sua configuração padrão para novos uploads foi definida com sucesso.' INTO action_message;
    
    -- next line command to show demonstration procedure action executed
    SELECT last_insert_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comments_d` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_comments_d`(
	IN p_id_comment INT,
    IN p_id_video INT,
    IN p_id_user INT
)
BEGIN

	DELETE FROM tb_videos_comments WHERE id_comment = p_id_comment AND id_video = p_id_video AND p_id_user;
    
    SELECT 'Comentário excluído com sucesso' AS result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comments_i` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_comments_i`(
	IN p_id_video INT,
    IN p_id_user INT,
    IN p_comment TEXT,
	OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN

	SET last_insert_id = 0;

	IF EXISTS (SELECT id_video FROM tb_videos WHERE id_video = p_id_video) THEN
    
		INSERT INTO tb_videos_comments (id_video, id_user, comment) VALUES (p_id_video, p_id_user, p_comment);
        
        SELECT last_insert_id() INTO last_insert_id; 
        
        SELECT ('Comentário incluído com sucesso.') INTO action_message;
    
    ELSE
    
		SELECT ('Não foi possível comentar neste vídeo') INTO action_message;
    
    END IF;
    
    SELECT last_insert_id, action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comments_u` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_comments_u`(
	IN p_id_comment INT,
	IN p_id_video INT,
    IN p_id_user INT,
    IN p_comment TEXT,
	OUT action_message VARCHAR(255)
)
BEGIN

	IF EXISTS (SELECT id_video FROM tb_videos WHERE id_video = p_id_video) THEN
    
		UPDATE tb_videos_comments SET comment = p_comment  WHERE id_video = p_id_video AND id_user = p_id_user AND id_comment = p_id_comment;
        
        SELECT ('Seu comentário foi atualizado.') INTO action_message;
    
    ELSE
    
		SELECT ('Erro ao atualizar esse comentario') INTO action_message;
    
    END IF;
    
    SELECT action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_current_state` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_current_state`(
	 IN p_id_video INT,
     IN p_id_user INT,
     IN p_current_state TIME
     
)
BEGIN

	IF EXISTS (SELECT id_video FROM tb_video_current_state WHERE id_video = p_id_video) THEN
		UPDATE tb_video_current_state SET current_state = p_current_state WHERE id_video = p_id_video AND id_user = p_id_user;
	ELSE 
		INSERT INTO tb_video_current_state (id_video, id_user, current_state) VALUES (p_id_video, p_id_user, p_current_state);
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_person_u` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_person_u`(
	IN p_id_user INT,
    IN p_name VARCHAR(255),
	OUT action_message VARCHAR(255)
)
BEGIN

	DECLARE user_name VARCHAR(255);
    SET action_message = 'action not executed!';
	
	IF EXISTS (SELECT name FROM tb_person WHERE id_user = p_id_user) THEN
        
		UPDATE tb_person SET name = p_name WHERE id_user = p_id_user;
        
        SELECT name INTO user_name FROM tb_person WHERE id_user = p_id_user;
        
		SELECT concat('O nome do usuario passou agora a ser: ', user_name) INTO action_message;
	ELSE 
    
		SELECT concat('Erro ao alterar o nome do usuario') INTO action_message;
        
    END IF;
    SELECT action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_playlists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_playlists`(
	IN p_id_channel INT,
    IN p_playlist_name VARCHAR(140),
    IN p_playlist_description TEXT,
    IN p_playlist_visibility ENUM('public', 'restricted', 'private'),
    OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	SET last_insert_id = 0;
    SET action_message = 'action not executed!';
    
    IF ((p_id_channel > 0) AND (length(Trim(p_playlist_name))>0)) THEN
		INSERT INTO tb_playlists (tb_playlists.id_channel,tb_playlists.name, tb_playlists.playlist_description, tb_playlists.playlist_visibility) VALUES (p_id_channel, p_playlist_name, p_playlist_description, p_playlist_visibility);

		SELECT last_insert_id() INTO last_insert_id;
		SELECT concat('A Playlist ', p_playlist_name, ' foi criada e já pode receber seus vídeos favoritos!') INTO action_message;
	END IF;

    -- next line command to show demonstration procedure action executed
    SELECT last_insert_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_playlist_d` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_playlist_d`(
	IN p_id_playlist INT
)
BEGIN

	DECLARE v_name VARCHAR(140);

	IF EXISTS (SELECT name FROM tb_playlists WHERE id = p_id_playlist) THEN
    
		SELECT name INTO v_name FROM tb_playlists WHERE id = p_id_playlist;

		DELETE FROM tb_playlist_video WHERE id_playlist = p_id_playlist;
		
		DELETE FROM tb_playlists WHERE id = p_id_playlist;
		
		SELECT CONCAT('A Playlist ', v_name, ' foi apagada com sucesso.') AS result;
        
	ELSE 
    
		SELECT CONCAT('A Playlist não existe ou já foi apagada.') AS result;
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_playlist_up` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_playlist_up`(
	IN p_id_channel INT,
    IN p_playlist_name VARCHAR(140),
    IN p_playlist_description TEXT,
    IN p_playlist_visibility ENUM('public', 'restricted', 'private'),
	OUT action_message VARCHAR(255)
)
BEGIN
	DECLARE name_playlist VARCHAR(255);
    SET action_message = 'action not executed!';
    
    IF ((p_id_channel > 0) AND (length(Trim(p_playlist_name))>0)) THEN
    
		UPDATE tb_playlists SET name = p_playlist_name, playlist_description = p_playlist_description, playlist_visibility = p_playlist_visibility WHERE id_channel= p_id_channel;
		
        SELECT name INTO name_playlist FROM tb_playlist WHERE id_channel = p_id_channel;
		SELECT concat('A Playlist: ', name_playlist, ' e seus vídeos favoritos foram atualizadas!') INTO action_message;
        
	ELSE 
		SELECT concat('Erro ao atualizar os dados da playlist');
	END IF;

    -- next line command to show demonstration procedure action executed
    SELECT action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_playlist_video` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_playlist_video`(
	IN p_id_playlist INT,
	IN p_id_video INT,
	OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	SET last_insert_id = 0;
    SET action_message = 'action not executed!';

    IF EXISTS (SELECT id FROM tb_playlists WHERE id = p_id_playlist) AND (SELECT id_video FROM tb_videos WHERE id_video = p_id_video) THEN
    	INSERT INTO tb_playlist_video (id_playlist, id_video) VALUES (p_id_playlist, p_id_video);
        SELECT last_insert_id() INTO last_insert_id;
		SELECT 'Playlist atualizada com sucesso.' INTO action_message;
    END IF;
    
    -- next line command to show demonstration procedure action executed
    SELECT last_insert_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_playlist_video_up` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_playlist_video_up`(
	IN p_id_playlist INT,
	IN p_id_video INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	
    SET action_message = 'action not executed!';

    IF EXISTS (SELECT id FROM tb_playlists WHERE id = p_id_playlist) AND (SELECT id_video FROM tb_videos WHERE id_video = p_id_video) THEN
    
    	UPDATE tb_playlist_video SET id_playlist = p_id_playlist, id_video = p_id_video WHERE id_video =  p_id_video;
        
		SELECT concat('Playlist atualizada com sucesso.') INTO action_message;
        
	ELSE
    
		SELECT concat('Erro ao alterar o nome do canal') INTO action_message; 
        
    END IF;
    
    -- next line command to show demonstration procedure action executed
    SELECT action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_i` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_users_i`(
	IN p_user_email VARCHAR(255),
    IN p_user_password VARCHAR(255),
    IN p_user_name VARCHAR(255),
    IN p_user_birth_date DATE,
    OUT last_insert_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	SET last_insert_id = 0;
    SET action_message = 'action not executed!';
    -- Esta menssagem não constitui falha de segurança ao expor claramente o motivo da falha no Insert ?
	-- SET action_message = 'Este e-mail já está cadastrado. Se você esqueceu sua senha, você pode tentar recuperá-la.' AS result;

    IF NOT EXISTS (SELECT user_email FROM tb_users WHERE user_email = p_user_email) THEN
		START TRANSACTION;
        
		INSERT INTO tb_users (user_email, user_password) VALUES (p_user_email, sha2(p_user_password,256));
		SELECT last_insert_id() INTO last_insert_id;
        INSERT INTO tb_person (id_user, name, birth_date) VALUES (last_insert_id, p_user_name, p_user_birth_date);
        
        COMMIT;
        SELECT concat('Parabéns ', p_user_name, '! Você criou sua conta no YouTube e pode acessar sua conta com seu e-mail ') INTO action_message;
    END IF;

    -- next line command to show demonstration procedure action executed
    SELECT last_insert_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_premium` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_users_premium`(
	IN p_id_user INT, 
    OUT action_executed INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	DECLARE expires DATE;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN    
		SELECT 0 INTO action_executed;
		SELECT 'Ocorreu um erro durante esta requisição' INTO action_message;
    END;

    SELECT 0 INTO action_executed;
	SELECT 'not executed' INTO action_message;
    
    IF (SELECT id FROM tb_users WHERE id = p_id_user) THEN
        IF (SELECT valid_until FROM tb_users_premium WHERE id_user = p_id_user AND valid_until > CURRENT_TIMESTAMP)
		THEN
			UPDATE tb_users_premium SET valid_until = DATE_ADD(valid_until, INTERVAL 30 DAY), updated_at = CURRENT_TIMESTAMP WHERE id_user = p_id_user;
			SELECT valid_until INTO expires FROM tb_users_premium WHERE id_user = p_id_user;
			
			SELECT CONCAT('Sua assinatura foi extendida por mais 30 dias. Sua assinatura irá vencer em ', expires) INTO action_message;
		ELSE 
			INSERT INTO tb_users_premium (id_user, valid_until, updated_at) VALUES (p_id_user, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 30 DAY), CURRENT_TIMESTAMP);
			SELECT valid_until INTO expires FROM tb_users_premium WHERE id_user = p_id_user;
			
			SELECT CONCAT('Aproveite a sua assinatura YouTube Premium! Sua assinatura está válida até ', expires) INTO action_message;
		END IF;
        SELECT 1 INTO action_executed;
    ELSE 
		SELECT ('Não foi possível incluir uma assinatura Premium neste usuário') INTO action_message;
    END IF;
	
    -- next line command to show demonstration procedure action executed
    SELECT action_executed, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_u` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_users_u`(
	IN p_id_user INT,
    IN p_user_password VARCHAR(255),
	OUT action_message VARCHAR(255)
)
BEGIN

	DECLARE user_name VARCHAR(255);
	
    SET action_message = 'action not executed!';
	
	IF (p_id_user > 0) THEN
        
		UPDATE tb_users SET user_password = sha2(p_user_password, 256) WHERE id = p_id_user;
        
        SELECT name INTO user_name FROM tb_person WHERE id_user = p_id_user;
        
		SELECT concat('A senha do usuario ', user_name , ' foi alterada com sucesso') INTO action_message;

    END IF;
    SELECT action_message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_videos_d` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_videos_d`(
	IN p_video_id INT,
    IN p_id_channel INT,
    IN p_id_user INT
)
BEGIN

			START TRANSACTION;


	IF EXISTS (SELECT a.id_video, b.id_channel, c.id FROM tb_videos a INNER JOIN tb_channel b ON b.id_channel = a.id_channel INNER JOIN tb_users c ON c.id = b.id_user WHERE a.id_video = p_video_id AND b.id_channel = p_id_channel AND c.id = p_id_user) THEN

    
		DELETE FROM tb_playlist_video WHERE id_video = p_video_id;
        DELETE FROM tb_video_category WHERE id_video = p_video_id;
        DELETE FROM tb_video_current_state WHERE id_video = p_video_id;
        DELETE FROM tb_video_view WHERE id_video = p_video_id;
        DELETE FROM tb_videos_comments WHERE id_video = p_video_id;
        DELETE FROM tb_videos_descriptions WHERE id_video = p_video_id;
        DELETE FROM tb_videos_likes WHERE id_video = p_video_id;
        DELETE FROM tb_videos_thumbs WHERE id_video = p_video_id;
        DELETE FROM tb_videos WHERE id_video = p_video_id AND id_channel = p_id_channel;
        
		COMMIT;
		select 'O vídeo foi apagado com sucesso.' as result;
    
    ELSE
		
		select 'Não foi possível apagar este vídeo. Verifique se as suas credenciais estão corretas.' as result;
        
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_videos_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_videos_likes`(
	IN p_id_video INT,
    IN p_id_user INT,
    IN p_video_like ENUM('-1','1')
)
BEGIN
	DECLARE action_message VARCHAR(255);
	DECLARE v_status CHAR(2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET action_message = 'Não foi possível interagir com este vídeo';
    -- DECLARE EXIT HANDLER FOR 1452 -- O erro 1452 indica que uma inserção falhou porque uma restrição de chave estrangeira não pôde ser respeitada
    -- SQLEXCEPTION, cobre erros no INSERT, DELETE and UPDATE...

	SET action_message = 'action not executed!';    
    SET v_status = '0';

	SELECT video_like INTO v_status FROM tb_videos_likes WHERE id_video = p_id_video AND id_user = p_id_user;
    
	IF (v_status = '0') THEN
		INSERT INTO tb_videos_likes (id_video, id_user, video_like) VALUES (p_id_video, p_id_user, p_video_like);
    ELSE
		IF (v_status = p_video_like) THEN
			DELETE FROM tb_videos_likes WHERE id_video = p_id_video AND id_user = p_id_user;
		ELSE 
			UPDATE tb_videos_likes SET video_like = p_video_like WHERE id_video = p_id_video AND id_user = p_id_user;
		END IF;
    END IF;

	SELECT 'Interação feita com sucesso' INTO action_message;
    
    -- next line command to show demonstration procedure action executed
    SELECT action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_video_i` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_video_i`(
	IN p_id_channel INT,
	IN p_video_url VARCHAR(255),
	IN p_video_name VARCHAR(140),
    -- Esta sendo definido um valor aleatório automaticamente
	IN p_video_length TIME,
	IN p_video_tags VARCHAR(255),
	IN p_video_is_restricted TINYINT,
	IN p_paid_promotion TINYINT,
    -- Fazer teste enviando este parametro nulo
	IN p_video_visibility ENUM('public', 'restricted', 'private'),
	IN p_id_category TINYINT,
    -- param of the auxiliar database table 
	IN p_video_thumb VARCHAR(255),
	IN p_video_description TEXT,
	IN p_id_playlist INT,
    -- output parans
    OUT last_affected_id INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	DECLARE v_video_title VARCHAR(255);
    DECLARE v_video_description VARCHAR(255);
    -- v_video_visibility é um ENUM, teoricamente é um parâmetro obrigatório
    DECLARE v_video_visibility ENUM('public', 'restricted', 'private');
    DECLARE v_video_tags VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN    
		SET last_affected_id = 0;
		SET action_message = 'ocurred a error. action not executed!';
    END;

	SET last_affected_id = 0;
	SET action_message = 'action not executed!';

	-- only exist a channel, authorized to
	IF EXISTS (SELECT id_channel FROM tb_channel WHERE (id_channel = p_id_channel) AND (channel_active = 1)) THEN
    BEGIN
		DECLARE v_exist_default_config INT;
        
        SET v_exist_default_config = 0;

        -- if exists record to default values
        SELECT video_title, video_description, video_visibility, video_tags, 1
		INTO v_video_title, v_video_description, v_video_visibility, v_video_tags, v_exist_default_config
        FROM tb_channel_upload_defaults
        WHERE id_channel = p_id_channel;
        
        -- if exists record to default values
		IF (v_exist_default_config = 1) THEN
            
            -- check if exists empty params, case necessary set default values
            IF (LENGTH(TRIM(p_video_name)) = 0) THEN SELECT v_video_title INTO p_video_name; END IF;
            IF (LENGTH(TRIM(p_video_description)) = 0) THEN SELECT v_video_description INTO p_video_description; END IF;
            IF (LENGTH(TRIM(p_video_tags)) = 0) THEN SELECT v_video_tags INTO p_video_tags; END IF;
		END IF;

		START TRANSACTION;            
        INSERT INTO tb_videos (id_channel, video_url, video_name, uploaded_at, video_length, video_tags, video_is_restricted, paid_promotion, video_visibility, id_category)
		VALUES (p_id_channel, p_video_url, p_video_name, default, p_video_length, p_video_tags, p_video_is_restricted, p_paid_promotion, p_video_visibility, p_id_category);
		
		SELECT last_insert_id() INTO last_affected_id;
		
		INSERT INTO tb_videos_thumbs (id_video, video_thumb_url) VALUES (last_affected_id, p_video_thumb);
		INSERT INTO tb_videos_descriptions (id_video, description) VALUES (last_affected_id, p_video_description);
		INSERT INTO tb_video_category (id_category, id_video) VALUES (p_id_category, last_affected_id);
		INSERT INTO tb_playlist_video (id_playlist, id_video) VALUES (p_id_playlist, last_affected_id);
		COMMIT;

		SET action_message = 'O upload foi realizado com sucesso.';
        
		-- next line command to show demonstration procedure action executed
		SELECT 'O upload foi realizado com sucesso.' AS result, p_video_url AS url, v_id AS id;
	END;
    ELSE
		SET action_message = 'Este canal não existe ou está impedido de realizar uploads';
	END IF;
    
    -- next line command to show demonstration procedure action executed
    SELECT last_affected_id, action_message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_video_u` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_video_u`(
	IN p_id_video INT,
	IN p_id_channel INT,
	-- IN p_video_url VARCHAR(255),
	IN p_video_name VARCHAR(140),
    -- Esta sendo definido um valor aleatório automaticamente
	IN p_video_tags VARCHAR(255),
	IN p_video_is_restricted TINYINT,
	IN p_paid_promotion TINYINT,
    -- Fazer teste enviando este parametro nulo
	IN p_video_visibility ENUM('public', 'restricted', 'private'),
	IN p_id_category TINYINT,
    -- param of the auxiliar database table 
	IN p_video_thumb VARCHAR(255),
	IN p_video_description TEXT,
	IN p_id_playlist INT, -- Se vier NULL, precisa remover o video da play list associada, caso contrario apenas um Update
    -- output parans
	OUT action_executed INT,
	OUT action_message VARCHAR(255)
)
BEGIN
	DECLARE v_video_title VARCHAR(255);
    DECLARE v_video_description VARCHAR(255);
    -- v_video_visibility é um ENUM, teoricamente é um parâmetro obrigatório
    DECLARE v_video_visibility ENUM('public', 'restricted', 'private');
    DECLARE v_video_tags VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN    
		SELECT 0 INTO action_executed;
		SET action_message = 'action not executed!';
    END;
    
	SELECT 0 INTO action_executed;
	SELECT 'not executed' INTO action_message;

	-- only exist a channel, authorized to
	IF EXISTS (SELECT id_channel FROM tb_channel WHERE id_channel = p_id_channel) THEN
    BEGIN
		DECLARE v_exist_default_config INT;
        
        SET v_exist_default_config = 0;
        
        -- if exists record to default values
        SELECT video_title, video_description, video_visibility, video_tags, 1 INTO v_video_title, v_video_description, v_video_visibility, v_video_tags, v_exist_default_config
        FROM tb_channel_upload_defaults WHERE id_channel = p_id_channel;
        
        -- if exists record to default values
		IF (v_exist_default_config = 1) THEN
            -- check if exists empty params, case necessary set default values
            IF (LENGTH(TRIM(p_video_name)) = 0) THEN SELECT v_video_title INTO p_video_name; END IF;
            IF (LENGTH(TRIM(p_video_description)) = 0) THEN SELECT v_video_description INTO p_video_description; END IF;
            IF (LENGTH(TRIM(p_video_tags)) = 0) THEN SELECT v_video_tags INTO p_video_tags; END IF;
		END IF;
            
		START TRANSACTION;            
		
		UPDATE tb_videos SET	id_channel = p_id_channel,
                                video_name = p_video_name,
                                video_tags = p_video_tags,
                                video_is_restricted = p_video_is_restricted,
                                paid_promotion = p_paid_promotion,
                                video_visibility = p_video_visibility,
                                id_category = p_id_category WHERE (id_video = p_id_video);

		UPDATE tb_videos_thumbs SET video_thumb_url = p_video_thumb WHERE (id_video = p_id_video);
		UPDATE tb_videos_descriptions SET description = p_video_description WHERE (id_video = p_id_video);
		UPDATE tb_video_category SET id_category = p_id_category WHERE (id_video = p_id_video);
		UPDATE tb_playlist_video SET id_playlist = p_id_playlist WHERE (id_video = p_id_video);

		COMMIT;

		SELECT 1 INTO action_executed;
        SET action_message = 'Atualização realizado com sucesso.';
        
		-- next line command to show demonstration procedure action executed
		SELECT 'O upload foi realizado com sucesso.' AS result, p_video_url AS url, v_id AS id;
	END;
    ELSE
		SET action_message = 'Este canal não existe ou está impedido de realizar uploads';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_watch_video` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_watch_video`(
	IN p_id_user INT,
    IN p_id_video INT
)
BEGIN

	DECLARE v_id_user INT;
    DECLARE v_id_video INT;
    DECLARE v_video_result INT;
    DECLARE v_birth_date DATE;
    
    SET v_id_user = 0;
    SET v_video_result = 0;
    SET v_birth_date = 0;
    set v_id_video = 0;
    
    
    IF EXISTS (SELECT id_video FROM tb_videos WHERE id_video = p_id_video) THEN
		SET v_video_result = 1;
	END IF;
    
    IF (v_video_result = 1) THEN
    
		SELECT id INTO v_id_user FROM tb_users WHERE id = p_id_user;
		IF (v_id_user > 0) THEN
			
			SELECT birth_date INTO v_birth_date FROM tb_person WHERE id_user = p_id_user;
		
		END IF;
		
	   IF ((v_id_user > 0) AND (timestampdiff(YEAR, v_birth_date, CURDATE())) > 17) THEN
			SELECT id_video INTO v_id_video FROM tb_videos WHERE id_video = p_id_video LIMIT 0,1;
		ELSEIF ((v_id_user > 0) AND (timestampdiff(YEAR, v_birth_date, CURDATE())) < 18) THEN
			SELECT id_video INTO v_id_video FROM tb_videos WHERE id_video = p_id_video AND video_is_restricted = 0 LIMIT 0,1;
		ELSE
			SELECT id_video INTO v_id_video FROM tb_videos WHERE id_video = p_id_video AND video_is_restricted = 0 LIMIT 0,1;
		END IF;
        
        IF (v_id_video > 0) THEN
			INSERT INTO tb_video_view (id_video, id_user) VALUES (v_id_video, v_id_user);
			SELECT * FROM vw_select_video  WHERE id = v_id_video;
		ELSE 
			SELECT 'Devido às políticas de LGPD e restrições aplicadas ao vídeo, você não pode assistir este vídeo' AS result;
		END IF;
        
	ELSE
    
		SELECT 'Esse vídeo não existe' AS result;
		
	END IF;
    		

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_all_active_channels`
--

/*!50001 DROP VIEW IF EXISTS `vw_all_active_channels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_all_active_channels` AS select `a`.`id_channel` AS `id`,`a`.`channel_name` AS `Nome do Canal`,`a`.`channel_url` AS `URL`,`a`.`subscription` AS `Inscritos`,`a`.`created_at` AS `Criado em`,`a`.`updated_at` AS `Ultima atualizacao`,`a`.`channel_active` AS `active`,`b`.`name` AS `Criador do Canal` from (`tb_channel` `a` join `tb_person` `b` on((`a`.`id_user` = `b`.`id_user`))) where (`a`.`channel_active` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_all_channels`
--

/*!50001 DROP VIEW IF EXISTS `vw_all_channels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_all_channels` AS select `a`.`id_channel` AS `id`,`a`.`channel_name` AS `Nome do Canal`,`a`.`channel_url` AS `URL`,`a`.`subscription` AS `Inscritos`,`a`.`created_at` AS `Criado em`,`a`.`updated_at` AS `Ultima atualizacao`,`a`.`channel_active` AS `active`,`b`.`name` AS `Criador do Canal` from (`tb_channel` `a` join `tb_person` `b` on((`a`.`id_user` = `b`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_categories`
--

/*!50001 DROP VIEW IF EXISTS `vw_categories`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_categories` AS select `tb_system_categories`.`id` AS `id`,`tb_system_categories`.`name` AS `Categoria` from `tb_system_categories` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_channel_settings`
--

/*!50001 DROP VIEW IF EXISTS `vw_channel_settings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_channel_settings` AS select `a`.`id_channel` AS `id`,`a`.`channel_banner_image` AS `Banner do Canal`,`a`.`channel_avatar_image` AS `Icone do canal`,`a`.`channel_description` AS `Descricao`,`a`.`channel_location` AS `Pais do Canal`,`a`.`channel_banner_image` AS `Banner`,`a`.`channel_currency` AS `Moeda Padrao`,`a`.`channel_keywords` AS `Palavras Chave`,`a`.`channel_video_featured` AS `Video em Destaque`,`a`.`channel_video_trailer` AS `Trailer do Canal`,`b`.`channel_name` AS `Nome do Canal`,`b`.`channel_url` AS `URL do Canal`,`b`.`subscription` AS `Inscritos`,`b`.`created_at` AS `Canal criado em` from (`tb_channel_settings` `a` join `tb_channel` `b` on((`a`.`id_channel` = `b`.`id_channel`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_comments`
--

/*!50001 DROP VIEW IF EXISTS `vw_comments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_comments` AS select `a`.`id_video` AS `id`,`a`.`id_comment` AS `ID do Comentario`,`a`.`comment` AS `Comentario`,`a`.`created_at` AS `Data do comentario`,`b`.`video_name` AS `Vídeo do comentário`,`c`.`name` AS `Autor do Comentario` from ((`tb_videos_comments` `a` join `tb_videos` `b` on((`b`.`id_video` = `a`.`id_video`))) join `tb_person` `c` on((`c`.`id_user` = `a`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_playlists`
--

/*!50001 DROP VIEW IF EXISTS `vw_playlists`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_playlists` AS select `tb_playlists`.`id` AS `id`,`tb_playlists`.`id_channel` AS `Canal`,`tb_playlists`.`name` AS `Nome da Plalist`,`tb_playlists`.`created_at` AS `Data de Criacao`,`tb_playlists`.`updated_at` AS `Ultima Atualizacao`,`tb_playlists`.`playlist_description` AS `Descricao`,`tb_playlists`.`playlist_visibility` AS `Visibilidade` from `tb_playlists` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_search_channel`
--

/*!50001 DROP VIEW IF EXISTS `vw_search_channel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_search_channel` AS select `a`.`channel_name` AS `name`,`a`.`channel_name` AS `Nome do canal`,`a`.`channel_url` AS `URL`,`a`.`subscription` AS `Inscritos`,`b`.`channel_description` AS `Descricao`,`b`.`channel_banner_image` AS `Banner`,`b`.`channel_avatar_image` AS `Avatar`,`b`.`channel_keywords` AS `tags` from (`tb_channel` `a` left join `tb_channel_settings` `b` on((`b`.`id_channel` = `a`.`id_channel`))) where (`a`.`channel_active` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_select_video`
--

/*!50001 DROP VIEW IF EXISTS `vw_select_video`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_select_video` AS select `a`.`id_video` AS `id`,`a`.`video_name` AS `Titulo do video`,date_format(`a`.`uploaded_at`,'%d/%m/%Y') AS `Data de Upload`,`a`.`video_length` AS `Duracao`,(select count(`b`.`id_video`) from `tb_video_view` `b` where (`b`.`id_video` = `a`.`id_video`)) AS `Visualizações`,(select count(`c`.`id_video`) from `tb_videos_comments` `c` where (`c`.`id_video` = `a`.`id_video`)) AS `Comentarios`,`d`.`name` AS `Categoria`,`e`.`description` AS `Descricao`,`f`.`video_thumb_url` AS `Miniatura`,(select count(`g`.`video_like`) from `tb_videos_likes` `g` where ((`g`.`id_video` = `a`.`id_video`) and (`g`.`video_like` = '1'))) AS `Curtidas`,(select count(`g`.`video_like`) from `tb_videos_likes` `g` where ((`g`.`id_video` = `a`.`id_video`) and (`g`.`video_like` = '-1'))) AS `Descurtidas` from (((`tb_videos` `a` join `tb_system_categories` `d` on((`d`.`id` = `a`.`id_category`))) left join `tb_videos_descriptions` `e` on((`e`.`id_video` = `a`.`id_video`))) left join `tb_videos_thumbs` `f` on((`f`.`id_video` = `a`.`id_video`))) where ((`a`.`video_visibility` = 'public') and (`a`.`video_is_restricted` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-27 20:43:37
