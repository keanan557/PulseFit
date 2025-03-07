-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: pulsefit
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','$2b$10$toQ66iEHRh1J8qOjR3rOquQSR16WZiuFuU3e5wDNJCROHHQqMB5du','admin@gmail.com'),(2,'john','john','john@gmail.com'),(3,'joe','joe','joe@gmail.com'),(4,'Jack','$2b$10$E.zHmq9jhkzG2N42x04zxexDzoLeX5Kb2hQlLEfXjaKOv0OIgGBEO','Jack@gmail.com'),(6,'joness','$2b$10$b9Lvde.UVL0tg8m0FQd8q.ho71WTO52jYepoImF.S5nmjsgpZx.py','jones@gmail.com'),(7,'keanan','$2b$10$JMAQt2.6LwrlMo.UY/S40OUe56a7S1Gz7JKxT9QJ8a9CW2VIGSDRO','keanan@gmail.com'),(8,'doc','$2b$10$dXYlG8zk2Xttr0zqdF.EHeeYz4Z0Lu53Y79nuzFiQkUaJOj7x8exu','doc@gmail.com');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (4,'Mogale Kgasago','mogalekgasago17@gmail.com','hjkiolp[=-0987trdtyuiop[][poiuy'),(5,'anele','anele@gmail.com','hi'),(6,'sphele','sphele@gmail.com','i like mo....'),(10,'','',''),(11,'john','john@hotmail.com','hih'),(12,'','',''),(13,'ruth','ruth@lca.com','hi'),(14,'jyyyyyyyyyyyyyyy','jy@gmail.com','jy'),(15,'doc','doc@gmail.com','hsuhshuhd'),(16,'mogale','doc@gmail.com','fghjkdmlmesmfe');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `items` json DEFAULT NULL,
  `shipping_address` text NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (11,8,NULL,NULL,'2025-03-07 06:45:00','\"[{\\\"product_id\\\":5,\\\"name\\\":\\\"Impulse Commercial Multi-Gym 3 Stack Station ES3000\\\",\\\"description\\\":\\\"The unique three-weight stack design allows multiple fitness enthusiasts to engage in their exercises simultaneously, fostering an environment of motivation and camaraderie. Dive into a multitude of exercise stations, including a versatile chest/shoulder press, a comprehensive lat pulldown/low row, and specialized leg routines.\\\",\\\"price\\\":\\\"99500.00\\\",\\\"image\\\":\\\"https://github.com/keanan557/pulsefit-assets/blob/main/images/es3000.1.jpg?raw=true\\\",\\\"quantity\\\":1},{\\\"product_id\\\":17,\\\"name\\\":\\\"Assault Bike Pro X (Belt Driven)\\\",\\\"description\\\":\\\"The ultimate cardio equipment for those looking for a powerful training experience. This 2-stage belt drive bike includes all of the amenities of the Classic and Elite models with additional features that will take your fitness to the next level.\\\",\\\"price\\\":\\\"25990.00\\\",\\\"image\\\":\\\"https://res.cloudinary.com/fitnessnetwork/image/upload/c_scale,w_1000/f_auto/v1/products/vrqjdyikqgxouq2aiwxa?_a=AACnOBs\\\",\\\"quantity\\\":1},{\\\"product_id\\\":26,\\\"name\\\":\\\"LivePro Booty Bands | Hip Bands\\\",\\\"description\\\":\\\"These Booty Bands Will Help You Shape Your Glutes, Secure Your Form and Increase Your Range of Motion\\\",\\\"price\\\":\\\"195.00\\\",\\\"image\\\":\\\"https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Booty-Bands-Product-Image-General.png?raw=true\\\",\\\"quantity\\\":1},{\\\"product_id\\\":28,\\\"name\\\":\\\"LivePro Resistance Bands (Super/Exercise Bands)\\\",\\\"description\\\":\\\"The LivePro Powerband is suitable for various sports.\\\",\\\"price\\\":\\\"495.00\\\",\\\"image\\\":\\\"https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Super-Band-Product-Image.png?raw=true\\\",\\\"quantity\\\":1}]\"','\"{\\\"fullName\\\":\\\"johnson jones\\\",\\\"address\\\":\\\"6 rd works\\\",\\\"city\\\":\\\"cpt\\\",\\\"zipCode\\\":\\\"9090\\\",\\\"country\\\":\\\"aus\\\"}\"','PayPal',126180.00),(12,8,NULL,NULL,'2025-03-07 07:33:34','\"[{\\\"product_id\\\":17,\\\"name\\\":\\\"Assault Bike Pro X (Belt Driven)\\\",\\\"description\\\":\\\"The ultimate cardio equipment for those looking for a powerful training experience. This 2-stage belt drive bike includes all of the amenities of the Classic and Elite models with additional features that will take your fitness to the next level.\\\",\\\"price\\\":\\\"25990.00\\\",\\\"image\\\":\\\"https://res.cloudinary.com/fitnessnetwork/image/upload/c_scale,w_1000/f_auto/v1/products/vrqjdyikqgxouq2aiwxa?_a=AACnOBs\\\",\\\"quantity\\\":1}]\"','\"{\\\"fullName\\\":\\\"mogale\\\",\\\"address\\\":\\\"6 rd works\\\",\\\"city\\\":\\\"cpt\\\",\\\"zipCode\\\":\\\"9090\\\",\\\"country\\\":\\\"aus\\\"}\"','Bank Transfer',25990.00),(13,13,NULL,NULL,'2025-03-07 08:26:03','\"[{\\\"product_id\\\":6,\\\"name\\\":\\\"Impulse IT7011 Multi Adjustable Gym Bench\\\",\\\"description\\\":\\\"The Impulse IT Multi-Adjustable Bench is the perfect choice for any facility looking to equip the strength area of the gym with high quality, commercial grade equipment.\\\",\\\"price\\\":\\\"8795.00\\\",\\\"image\\\":\\\"https://github.com/keanan557/pulsefit-assets/blob/main/images/Impulse-IT-Multi-Adjustable-Bench-Product-Image.jpg?raw=true\\\",\\\"quantity\\\":1}]\"','\"{\\\"fullName\\\":\\\"kay kay\\\",\\\"address\\\":\\\"6 mogale str\\\",\\\"city\\\":\\\"cpt\\\",\\\"zipCode\\\":\\\"7760\\\",\\\"country\\\":\\\"zim\\\"}\"','PayPal',8795.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image` text,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'james','james@gmail.com','$2b$10$cIg08Wc0m1K3MBYaX51Vd.9nPj.5zZOTIfeIelwRlKfUDW.m9zSZe'),(2,'johnny','johnny@gmail.com','$2b$10$X.pdRudyEDgQan9TH3lUAuuivftBpC8PrijhJJPchHnc1mOrGyGzS'),(3,'Mogale Kgasago','mogalekgasago17@gmail.com','$2b$10$zRxK1g2JwtEYGL5TY7ughOU815GrPhK2Cp.POMmTJHs.7M0QXQgFu'),(6,'keanan','keanan@gmail.com','$2b$10$EYxehyW3wFHbIiSypb1QduVpmj1bGGJ5ZtZdTi5gGRC2vuRkCeb7.'),(7,'rick','rick@gmail.com','$2b$10$nmpRKXpjQMTjaxxRKHxFKO/dXWgOsaa41S1IWZt3nykCYmowfFSXy'),(8,'johnson','johnson@gmail.com','$2b$10$kgSBf6DefoiU8AXLKY7G4.yE2CiSmcGbMEWBHsXF8XuW6XDfzUjVS'),(9,'anele','anelevenge39@gamil.com','$2b$10$zD091I.NbfAAyjRUeT5Rh.9E8KGVNxqKWxrBWGir61DZGtuLGjf/K'),(10,'Sphelele Lostile','lostilesphelele@gmail.com','$2b$10$CI6whmDYx5mILD/cF8p3Pec13E1LDhQLWdWZCsf3VGBEqQfOIC2UC'),(13,'kay','kay@gmail.com','$2b$10$TlIoj9ZeWamGjcqe7Tfs/ezjgmLWv4X4oDOBRBmreD1sm5pXvqn3.'),(14,'doc','doc@gmail.com','$2b$10$.48Q6DFC9//SxAJ7fcMNFemANLiTA2oomtXWAw6HF14Zov2v6SrVS');
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

-- Dump completed on 2025-03-07 11:52:59
