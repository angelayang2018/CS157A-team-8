-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: weed
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `sellerName` varchar(45) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (38,'1','1','0','1','1','0'),(39,'1','1','40','1','1','Angie'),(41,'sdfa','dfsafd','15','dsaf','Vape Pens','Angie'),(42,'dafs','dsaf','5','asfd','Pre-Roll','Angie'),(43,'adsf','asfd','sdaf','safd','Vape Pens','Angie'),(44,'sdfa','sdaf','asdf','sdaf','Vape Pen','Angie'),(45,'fdsaf','dsfds','dsf','fdsfd','Concentrates','Angie'),(46,'Weed','More weed','95','4','Concentrates','Angie'),(47,'Heroin','Purest Heroin fresh off the boat','9999','999','Ilegal substance','SwiftS'),(48,'CBD Hash Oil','CBD hash oil, heavenly pleasure on earth','10','68','Hash Oil','SwiftS'),(49,'THC Extract ','Dabbing is one of the best ways to smoke concentrates. All of your standard BHO or CO2 concentrates as well as things like rosin and live resin can be consumed through the process of dabbing. ','10','96','Concentrates','SwiftS'),(50,'Sativa','Cannabis sativa is an annual herbaceous flowering plant indigenous to Eastern Asia, but now of cosmopolitan distribution due to widespread cultivation. It has been cultivated throughout recorded history, used as a source of industrial fiber, seed oil, food, recreation, religious and spiritual moods and medicine','10','32','Flower','SwiftS'),(51,'Indica','Cannabis indica is an annual plant species in the family Cannabaceae which produces large amounts of tetrahydrocannabinol and is cultivated for purposes including hashish in India','45','54','Flower','SwiftS');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-02 13:23:21
