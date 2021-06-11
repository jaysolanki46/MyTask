-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mytask
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

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'GENERAL'),(2,'SUPPORT'),(3,'SALES'),(4,'CORPORATE'),(5,'PRODUCTION'),(6,'SERVICE'),(7,'ACCOUNT'),(8,'MARKETING'),(9,'LICENSES');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_team`
--

DROP TABLE IF EXISTS `project_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project` int NOT NULL,
  `team_member` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_project_project_idx` (`project`),
  KEY `fk_team_member_project_team_idx` (`team_member`),
  CONSTRAINT `fk_project_project` FOREIGN KEY (`project`) REFERENCES `projects` (`id`),
  CONSTRAINT `fk_team_member_project_team` FOREIGN KEY (`team_member`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_team`
--

LOCK TABLES `project_team` WRITE;
/*!40000 ALTER TABLE `project_team` DISABLE KEYS */;
INSERT INTO `project_team` VALUES (11,101,1),(12,101,14),(13,101,15),(14,101,16),(15,102,14),(37,105,17),(38,105,20),(40,103,19),(41,103,15),(42,103,20),(43,103,11),(44,103,17),(55,106,18),(56,106,19),(57,106,15),(58,106,20),(59,106,11),(60,106,16),(61,106,13),(69,107,18),(70,107,11),(71,107,13),(72,107,1),(73,107,14),(74,104,11),(75,104,13),(76,104,12);
/*!40000 ALTER TABLE `project_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `department` int DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `status` tinyint DEFAULT '0' COMMENT 'DELETED(2),ARCHIVED(1),OPEN(0);',
  `created_on` date NOT NULL,
  `created_by` int NOT NULL,
  `updated_on` date NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_created_by_user_idx` (`created_by`),
  KEY `fk_updated_by_user_idx` (`updated_by`),
  KEY `fk_department_department_idx` (`department`),
  CONSTRAINT `fk_created_by_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_department_department` FOREIGN KEY (`department`) REFERENCES `departments` (`id`),
  CONSTRAINT `fk_updated_by_user` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (101,'POS Test',2,'POS Testing is defined as Testing of a Point of Sale Application. A POS or Point Of Sale software is a vital solution for retail businesses to carry out retail transactions effortlessly from anywhere.',0,'2021-02-09',1,'2021-06-09',1),(102,'IKR Certifications Expires',2,'International diplomas and certificates issued by other global karate federations shall normally be recognized only as confirmation of grades already certified..',0,'2021-01-09',1,'2021-06-09',1),(103,'Skyzer Innovation Meeting',1,'Innovation is the practical implementation of ideas that result in the introduction of new goods or services or improvement in offering goods or services. ISO TC 279 on innovation management proposes in the standards, ISO 56000:2020 to define innovation as \"a new or changed entity creating or redistributing value.',0,'2021-02-09',1,'2021-06-10',1),(104,'Chinese Payment',2,'AliPay and WeChat Pay are the Chinese equivalent of Visa and Mastercard, the difference being they are a mobile phone based digital wallet. ',0,'2020-06-09',1,'2021-06-11',1),(105,'Kiwibank',4,'Request for further support. If you\'ve already been receiving home loan or credit card support under Kiwibank\'s Relief and Resilience Programme, you can apply&#8203; ',0,'2021-05-09',20,'2021-06-09',20),(106,'Prject Test',1,'',2,'2021-06-10',1,'2021-06-10',1),(107,'Prject Test123123123123123',2,'',2,'2021-06-10',1,'2021-06-10',1);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_details`
--

DROP TABLE IF EXISTS `task_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task` int NOT NULL,
  `task_detail_date` date NOT NULL,
  `hours` int DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  `created_on` date NOT NULL,
  `created_by` int NOT NULL,
  `updated_on` date NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_created_by_user_idx` (`created_by`),
  KEY `fk_updated_by_user_idx` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_details`
--

LOCK TABLES `task_details` WRITE;
/*!40000 ALTER TABLE `task_details` DISABLE KEYS */;
INSERT INTO `task_details` VALUES (1,1,'2021-06-08',5,'Tevalis POS Test - 5','2021-06-09',14,'2021-06-09',14),(2,1,'2021-04-14',7,'Tevalis POS Test - 7','2021-06-09',14,'2021-06-09',14),(3,1,'2021-03-10',4,'Tevalis POS Test - 4','2021-06-09',14,'2021-06-09',14),(4,1,'2021-06-10',10,'Tevalis POS Test - 10','2021-06-09',14,'2021-06-09',14),(5,1,'2021-05-05',7,'Tevalis POS Test - 7','2021-06-09',14,'2021-06-09',14),(6,1,'2021-04-16',10,'Tevalis POS Test - 10','2021-06-09',14,'2021-06-09',14),(7,11,'2021-02-24',8,'Design Presentation - 8','2021-06-09',14,'2021-06-09',14),(8,11,'2021-03-31',7,'Design Presentation - 7','2021-06-09',14,'2021-06-09',14),(9,11,'2021-04-08',8,'Design Presentation - 8','2021-06-09',14,'2021-06-09',14),(10,11,'2021-04-29',9,'Design Presentation - 9','2021-06-09',14,'2021-06-09',14),(11,11,'2021-05-05',10,'Design Presentation - 10','2021-06-09',14,'2021-06-09',14),(12,11,'2021-05-21',5,'Design Presentation - 5','2021-06-09',14,'2021-06-09',14),(13,11,'2021-05-31',6,'Design Presentation - 6','2021-06-09',14,'2021-06-09',14),(14,11,'2021-06-07',9,'Design Presentation - COmpleted','2021-06-09',14,'2021-06-09',14),(15,5,'2021-01-13',5,'IKR Test for Teliums - 5','2021-06-09',14,'2021-06-09',14),(16,5,'2021-01-20',6,'IKR Test for Teliums - 6','2021-06-09',14,'2021-06-09',14),(17,5,'2021-04-07',8,'IKR Test for Teliums - 8','2021-06-09',14,'2021-06-09',14),(18,5,'2021-04-30',10,'IKR Test for Teliums - 10','2021-06-09',14,'2021-06-09',14),(19,5,'2021-05-03',11,'IKR Test for Teliums - 11','2021-06-09',14,'2021-06-09',14),(20,5,'2021-06-09',4,'IKR Test for Teliums - 4','2021-06-09',14,'2021-06-09',14),(21,6,'2021-05-11',12,'IKR Test for Tetra - 12','2021-06-09',14,'2021-06-09',14),(22,6,'2021-06-09',10,'IKR Test for Teliums - 10','2021-06-09',14,'2021-06-09',14),(23,7,'2021-04-07',10,'Upstair wall design 10','2021-06-09',15,'2021-06-09',15),(24,7,'2021-06-08',12,'Upstair wall design 12','2021-06-09',15,'2021-06-09',15),(25,3,'2021-04-15',9,'Prestashop POS Test 9','2021-06-09',15,'2021-06-09',15),(26,3,'2021-04-08',5,'Prestashop POS Test 5','2021-06-09',15,'2021-06-09',15),(27,3,'2021-04-29',6,'Prestashop POS Test 6','2021-06-09',15,'2021-06-09',15),(28,3,'2021-05-12',8,'Prestashop POS Test 8','2021-06-09',15,'2021-06-09',15),(29,3,'2021-06-02',11,'Prestashop POS Test 11','2021-06-09',15,'2021-06-09',15),(30,3,'2021-06-08',11,'Prestashop POS Test 11','2021-06-09',15,'2021-06-09',15),(31,8,'2021-06-07',7,'','2021-06-09',1,'2021-06-09',1);
/*!40000 ALTER TABLE `task_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `project` int NOT NULL,
  `team_member` int NOT NULL,
  `due_date` date DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `percentage` int DEFAULT '0',
  `status` tinyint DEFAULT '0' COMMENT 'DELETED(1),OPENED(0);',
  `created_on` date NOT NULL,
  `created_by` int NOT NULL,
  `updated_on` date NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_project_project_idx` (`project`),
  KEY `fk_team_member_idx` (`team_member`),
  KEY `fk_created_by_user_idx` (`created_by`),
  KEY `fk_updated_by_user_idx` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Tevalis POS Test',101,14,'2021-08-13','Welcome to the Tevalis Portal, the online platform where our customers access the Enterprise Suite containing all management modules. ',95,0,'2021-06-09',1,'2021-06-09',14),(2,'Swift POS Test',101,1,NULL,'Meta description preview:Built on Microsoft SQL, SwiftPOS is a real breakthrough in Hospitality Point of Sale and is a must have tool for your business.',0,0,'2021-06-09',1,'2021-06-09',1),(3,'Prestashop POS Test',101,15,NULL,'PrestaShop is an eCommerce website builder to create and manage your online business. You can launch your online store right now and start to sell online!',44,0,'2021-06-09',1,'2021-06-09',15),(4,'ABEL POS',101,16,'2021-07-08','Abel Software is a global leader in ERP business management software. We design flexible, integrated and affordable solutions for business of any size. Affordable. Scalable. Integrated.',0,0,'2021-06-09',1,'2021-06-09',1),(5,'IKR Test for Teliums',102,14,'2021-08-13','Certified knowledge, utterly quality awareness and high flexibility is what we are excelling at globally. ',99,0,'2021-06-09',1,'2021-06-09',14),(6,'IKR Test for Tetra',102,14,NULL,'Tetra: Certified knowledge, utterly quality awareness and high flexibility is what we are excelling at globally. ',100,0,'2021-06-09',1,'2021-06-09',14),(7,'Upstairs Wall design',103,15,'2021-07-08','Go for Large-Scale Art. Grant Gibson lets a 10\' x 6\' Peggy Wong photograph take center stage in a client\'s living room.',60,0,'2021-06-09',1,'2021-06-09',15),(8,'Blow Baloon',103,1,'2021-06-16','To blow up a balloon, start by pinching the neck of the balloon with your index finger and thumb.',80,0,'2021-06-09',1,'2021-06-09',1),(9,'Bring Food',103,12,NULL,'The peace and tranquillity that this dawning of the new day brings, offering all of Mother Nature\'s beauty when few are even awake to be aware of its existence.',0,0,'2021-06-09',1,'2021-06-09',1),(10,'Send Invites',103,11,'2021-06-25','Open the meeting request. In the Respond group on the ribbon, select Respond, then Forward. Add one or more recipients to the meeting request. ',0,0,'2021-06-09',1,'2021-06-09',1),(11,'Design Presentation',103,14,NULL,'Design Your Best Presentation With Thousands Of Templates & Elements. Free 30-Day Trial. Professionally Designed Templates Just For You. Sign Up Now. ',100,0,'2021-06-09',1,'2021-06-09',14),(12,'Alipay',104,12,'2021-06-23','Trust makes it simple. Experience fast, easy and safe online payments. Leader in online and mobile payments. 1,000,000,000 Users.',0,0,'2021-06-09',11,'2021-06-09',11),(13,'Wechat Payments',104,13,'2021-07-02','WeChat is a Chinese multi-purpose messaging, social media and mobile payment app developed by Tencent. First released in 2011, it became the world\'s largest standalone mobile app in 2018, with over 1 billion monthly active users.',0,0,'2021-06-09',11,'2021-06-09',11),(14,'Bring Cake',103,20,NULL,'Cake is a form of sweet food made from flour, sugar, and other ingredients, that is usually baked. In their oldest forms, cakes were modifications of bread, but cakes now cover a wide range of preparations',0,0,'2021-06-09',20,'2021-06-09',20),(15,'iOS Test on Lane3000',105,20,'2021-06-24','Automate iOS app testing on real devices with the Ranorex iOS testing tool! Easily integrate automated iOS tests with CI servers or any existing test environment.',0,0,'2021-06-09',20,'2021-06-09',20),(16,'Android Test on Lane3000',105,17,NULL,'Optimized for multilane checkouts, it enables a large number of payment options while boosting contactless payment through a dedicated card reader zone',0,0,'2021-06-09',20,'2021-06-09',20),(17,'IKR Certification Expired',107,14,'2021-06-17','',0,1,'2021-06-10',1,'2021-06-10',1),(18,'ghjgm',107,14,NULL,'',0,1,'2021-06-10',1,'2021-06-10',1);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `department` int DEFAULT NULL,
  `theme` varchar(45) NOT NULL COMMENT '0 - Skyzer Technologies\\n1 - Skyzer Payments',
  `user_type` int NOT NULL COMMENT '0 - Normal User\n1 - Master User',
  `email` varchar(50) DEFAULT NULL,
  `active` tinyint DEFAULT '0' COMMENT '0-Active\n1-Deactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jay','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(11,'Christine','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(12,'Nilesh','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(13,'Henry','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(14,'Kishan Rabari','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(15,'Axita','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(16,'Davinder','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(17,'Gareth','pass',4,'1',0,'jay.solanki@skyzer.co.nz',0),(18,'Aiswarya','pass',2,'0',0,'jay.solanki@skyzer.co.nz',0),(19,'Alan','pass',5,'0',0,'jay.solanki@skyzer.co.nz',0),(20,'Belinda','pass',4,'1',0,'jay.solanki@skyzer.co.nz',0),(21,'Harshi','pass',7,'0',0,'jay.solanki@skyzer.co.nz',0),(22,'Norman','pass',8,'0',0,'jay.solanki@skyzer.co.nz',0),(23,'Tony','pass',9,'0',0,'jay.solanki@skyzer.co.nz',0),(24,'Helen','pass',1,'0',0,'jay.solanki@skyzer.co.nz',0),(25,'Steve','pass',3,'0',0,'jay.solanki@skyzer.co.nz',0),(26,'Vineel','pass',3,'0',0,'jay.solanki@skyzer.co.nz',0),(27,'Mike','pass',1,'0',0,'jay.solanki@skyzer.co.nz',0),(28,'Sukhwinder','pass',5,'0',0,'jay.solanki@skyzer.co.nz',0),(29,'Raman','pass',5,'0',0,'jay.solanki@skyzer.co.nz',0);
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

-- Dump completed on 2021-06-11 17:11:21
