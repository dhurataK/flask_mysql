CREATE DATABASE  IF NOT EXISTS `loginregistration` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `loginregistration`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: loginregistration
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
  `pw_hash` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Dhurata','Kamberi','dhurata@kamberi.com','abc123','2016-10-12 23:41:29','2016-10-12 23:41:29'),(2,'Yllka ','Gojani','yllka@gojani.com','123','2016-10-13 00:10:28',NULL),(3,'Eriona','Kollqaku','eriona@kollqaku.com','hahaha','2016-10-13 00:13:05',NULL),(4,'Erblina','Hasani','erblina@hasani.com','123sd','2016-10-13 00:15:00',NULL),(5,'Egezona','Haziri','egezona@haziri.com','$2b$12$sEqpCw4Hr7MQncHiX6peXOOdEFtUsR/ZJhXwyKLryyaQ9e9VYNSo2','2016-10-13 00:56:37',NULL),(7,'sara','sadiku','sara@sadiku.com','$2b$12$qaM78jHsxQGoRxNmFwfaMuNot09EY0EWNG1RBMWJCgT.bju.8/zui','2016-10-13 02:36:00',NULL),(8,'Michael','Arbogast','marbogast@live.com','$2b$12$ttQGjeJceRRwZN3OjDiW5.cfnnkhQprfv4iC8z5Y1YhbxCc6bDtp6','2016-10-13 03:39:38',NULL),(9,'Argeta','Morina','argeta@morina.com','$2b$12$cV8K.jeMSbaAwcMkIJULlOHXSE1n0Mt6QHlTm99KPfZxiSUBvVslO','2016-10-13 03:41:21',NULL),(10,'Todd','Enders','todd@enders.com','$2b$12$z5qK2UlY3oF6Emg9w9rOyudS0MVc3cDzSBISS6I7VOZ60B5zFqgBa','2016-10-13 03:45:34',NULL);
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

-- Dump completed on 2016-10-13  3:47:34
