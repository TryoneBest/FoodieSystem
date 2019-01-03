-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: foodie_system
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content` (
  `content_id` int(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `rid` int(20) NOT NULL,
  `uid` int(20) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`content_id`),
  KEY `restaurant_content_idx` (`rid`),
  KEY `user_content_idx` (`uid`),
  CONSTRAINT `restaurant_content` FOREIGN KEY (`rid`) REFERENCES `restaurant` (`restaurant_id`),
  CONSTRAINT `user_content` FOREIGN KEY (`uid`) REFERENCES `system_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,'test',1,1,'2019-01-02 02:42:01'),(2,'test2',1,1,'2019-01-02 02:42:01'),(3,'temp',1,2,'2019-01-02 02:42:01'),(4,'timestamptest',2,2,'2019-01-03 01:12:24');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_image`
--

DROP TABLE IF EXISTS `content_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_image` (
  `content_id` int(20) NOT NULL,
  `image_id` int(20) NOT NULL,
  PRIMARY KEY (`content_id`,`image_id`),
  KEY `image_idx` (`image_id`),
  CONSTRAINT `content` FOREIGN KEY (`content_id`) REFERENCES `content` (`content_id`),
  CONSTRAINT `image` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_image`
--

LOCK TABLES `content_image` WRITE;
/*!40000 ALTER TABLE `content_image` DISABLE KEYS */;
INSERT INTO `content_image` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `content_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `food` (
  `food_id` int(20) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(50) DEFAULT NULL,
  `rid` int(20) DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `restaurant_food_idx` (`rid`),
  CONSTRAINT `restaurant_food` FOREIGN KEY (`rid`) REFERENCES `restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'蒜白炒蛋饭',1),(4,'蛋炒饭',1);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `image` (
  `image_id` int(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'test'),(2,'temp');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `restaurant` (
  `restaurant_id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_name` varchar(50) NOT NULL,
  `city_name` varchar(20) NOT NULL,
  `lng` decimal(20,10) NOT NULL,
  `lat` decimal(20,10) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'湘粤阁','上海市',121.2171770000,31.2873750000,'曹安公路4800号同济大学嘉定校区新天地2层'),(2,'古树咖啡(嘉实广场店)','上海市',121.2204120000,31.2881140000,'嘉松北路6130弄199号S6-101室'),(3,'时光咖啡(同济大学嘉定校区店)','上海市',121.2179330000,31.2872060000,'曹安公路4800号同济大学嘉定校区新天地商业街172号'),(4,'奇士客(同济大学店)','上海市',121.2177280000,31.2871900000,'安亭黄渡镇曹安公路4800号同济大学商业街116号'),(5,'乐惠(同济大学店)','上海市',121.2176030000,31.2871170000,'曹安公路4800号同济大学嘉定校区嘉实新天地');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_user`
--

DROP TABLE IF EXISTS `system_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `system_user` (
  `user_id` int(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user`
--

LOCK TABLES `system_user` WRITE;
/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO `system_user` VALUES (1,'cat','123456'),(2,'dog','123456'),(3,'Acat','123456'),(5,'Adog','123456'),(8,'AdogAcat','123456'),(9,'AdogCAT','123456');
/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_restaurant_stars`
--

DROP TABLE IF EXISTS `user_restaurant_stars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_restaurant_stars` (
  `restaurant_id` int(20) NOT NULL,
  `user_id` int(20) NOT NULL,
  `star_level` int(1) NOT NULL,
  PRIMARY KEY (`restaurant_id`,`user_id`),
  KEY `user_star_idx` (`user_id`),
  CONSTRAINT `restaurant_star` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`),
  CONSTRAINT `user_star` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_restaurant_stars`
--

LOCK TABLES `user_restaurant_stars` WRITE;
/*!40000 ALTER TABLE `user_restaurant_stars` DISABLE KEYS */;
INSERT INTO `user_restaurant_stars` VALUES (1,1,5),(1,2,2);
/*!40000 ALTER TABLE `user_restaurant_stars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_content_user`
--

DROP TABLE IF EXISTS `v_content_user`;
/*!50001 DROP VIEW IF EXISTS `v_content_user`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_content_user` AS SELECT 
 1 AS `cid`,
 1 AS `comment`,
 1 AS `rid`,
 1 AS `datetime`,
 1 AS `uname`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_content_user`
--

/*!50001 DROP VIEW IF EXISTS `v_content_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_content_user` AS select `content`.`content_id` AS `cid`,`content`.`content` AS `comment`,`content`.`rid` AS `rid`,`content`.`date` AS `datetime`,`system_user`.`user_name` AS `uname` from (`content` join `system_user` on((`content`.`uid` = `system_user`.`user_id`))) */;
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

-- Dump completed on 2019-01-03 14:46:59
