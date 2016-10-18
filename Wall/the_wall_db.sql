CREATE DATABASE  IF NOT EXISTS `the_wall` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `the_wall`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: the_wall
-- ------------------------------------------------------
-- Server version	5.5.49-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `comment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_ibfk_1` (`user_id`),
  KEY `comments_ibfk_2` (`message_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,1,'Hi','2016-10-14 14:22:07','2016-10-14 14:22:07'),(6,4,8,'Hi Todd this is my comment Hi Todd this is my comment Hi Todd this is my comment Hi Todd this is my comment Hi Todd this is my comment Hi Todd this is my comment Hi Todd this is my comment ','2016-10-17 15:34:19',NULL),(7,9,6,'Hello Sara, how are you? This is my comment! ','2016-10-17 17:28:30',NULL),(8,7,6,'Hi Todd, what\'s up ?','2016-10-17 17:31:49',NULL),(9,1,6,'Hi Edisa waass upp ?','2016-10-17 18:00:38',NULL),(11,8,5,'Greetings Eriona welcome to the WALL !!!','2016-10-17 18:13:57',NULL),(12,1,2,'Hey what are you doing ?','2016-10-18 12:07:00',NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,'Hello there!','2016-10-14 14:18:33','2016-10-14 14:18:33'),(4,5,'This is my message. This is my message. This is my message. This is my message. This is my message.','2016-10-14 23:59:20',NULL),(5,3,'Hello, my name is Michael!','2016-10-15 01:19:25',NULL),(7,5,'Hello, my name is Todd! Hello, my name is Todd! Hello, my name is Todd! Hello, my name is Todd!Hello, my name is Todd!Hello, my name is Todd!Hello, my name is Todd!Hello, my name is Todd!','2016-10-15 02:54:10',NULL),(8,6,'Hello I\'m Eriona, I\'m new this is my first message!!','2016-10-17 15:03:00',NULL),(9,8,' Sara Sara Sara Sara Sara Sara Sara Sara Sara Sara Sara vvSara Sara Sara vSara Sara vvSara Sara v','2016-10-17 15:07:49',NULL),(10,2,'I just deleted a message yey !','2016-10-18 12:06:20',NULL);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Edisa','Heta','edisa@heta.com','edisa123','2016-10-14 14:16:43','2016-10-14 14:16:43'),(2,'Dhurata','kam','dhurata@kamberi.com','$2b$12$KtMsB4pQlSAKEWkGdM/5E.2WMVRK/qpSaeLSIdtTvrn37EceRY3ce','2016-10-14 18:10:42','2016-10-14 18:10:42'),(3,'Michael','Choi','michael@choi.com','$2b$12$w8zoGUReuoWQC6aCDgDVteChI1UNsA8hD0XYQYwALST2BO6UxK.y2','2016-10-14 22:57:27','2016-10-14 22:57:27'),(4,'eva','roa','eva@eva.com','$2b$12$GGgpp.D5NTiALT24NGnw8eAtmAJMqIuYSECIaSGpvPJUrteT0wpt.','2016-10-14 22:58:44','2016-10-14 22:58:44'),(5,'Todd','Enders','todd@enders.com','$2b$12$7PldfcLPJ8lN9lNrmB4h8.k//XEeDyV3G.zL4TAxB7Fe8CxChw.JS','2016-10-14 22:59:50','2016-10-14 22:59:50'),(6,'Eriona','Kollqaku','eriona@kollqaku.com','$2b$12$4R0CX4zJDnwh/gtAj.8F2.dzLM2SvyAl7NM43lrZX7dGFICR9iBcO','2016-10-17 14:59:15','2016-10-17 14:59:15'),(7,'Yll','Kamberi','ygi@live.com','$2b$12$AaTBGc8y9hsPHYGiNZlqSu2TU6xYS02vMMBDF9lpDCd85Un6DRksG','2016-10-17 15:01:31','2016-10-17 15:01:31'),(8,'Sara','Sadiku','sara@sadiku.com','$2b$12$52QwBDsqtHlZKCHN8W7Y5upR5OHnC3xfZYySPdleWoU44iBlWM4Q.','2016-10-17 15:07:01','2016-10-17 15:07:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-18 12:08:26
