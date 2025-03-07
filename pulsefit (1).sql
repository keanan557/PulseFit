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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','$2b$10$toQ66iEHRh1J8qOjR3rOquQSR16WZiuFuU3e5wDNJCROHHQqMB5du','admin@gmail.com'),(2,'john','john','john@gmail.com'),(3,'joe','joe','joe@gmail.com'),(4,'Jack','$2b$10$E.zHmq9jhkzG2N42x04zxexDzoLeX5Kb2hQlLEfXjaKOv0OIgGBEO','Jack@gmail.com'),(6,'joness','$2b$10$b9Lvde.UVL0tg8m0FQd8q.ho71WTO52jYepoImF.S5nmjsgpZx.py','jones@gmail.com');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (3,'jorge','jorge@gmail.com','knkfdkfnk'),(4,'Mogale Kgasago','mogalekgasago17@gmail.com','hjkiolp[=-0987trdtyuiop[][poiuy'),(5,'anele','anele@gmail.com','hi'),(6,'sphele','sphele@gmail.com','i like mo....');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,NULL,NULL,'2025-02-27 12:59:14','[{\"name\": \"Dumbbell Set\", \"price\": 50, \"quantity\": 2, \"product_id\": 101}, {\"name\": \"Yoga Mat\", \"price\": 20, \"quantity\": 1, \"product_id\": 102}]','{\"fullName\":\"John Doe\",\"address\":\"123 Fitness St\",\"city\":\"New York\",\"zipCode\":\"10001\",\"country\":\"USA\"}','Credit Card',120.00),(2,8,NULL,NULL,'2025-03-03 08:17:24',NULL,'\"{\\\"fullName\\\":\\\"joe\\\",\\\"address\\\":\\\"6 hole red\\\",\\\"city\\\":\\\"joburg\\\",\\\"zipCode\\\":\\\"8890\\\",\\\"country\\\":\\\"South Africa\\\"}\"','PayPal',37995.00),(3,8,NULL,NULL,'2025-03-03 09:16:48',NULL,'{\"fullName\":\"Test User\",\"address\":\"123 Test Street\",\"city\":\"Test City\",\"zipCode\":\"12345\",\"country\":\"Test Country\"}','Credit Card',100.00),(4,8,NULL,NULL,'2025-03-03 09:18:28',NULL,'{\"fullName\":\"Test User\",\"address\":\"123 Test Street\",\"city\":\"Test City\",\"zipCode\":\"12345\",\"country\":\"Test Country\"}','Credit Card',100.00),(5,8,NULL,NULL,'2025-03-03 09:19:53','[{\"name\": \"Test Product 1\", \"image\": \"test1.jpg\", \"price\": 25, \"quantity\": 2, \"product_id\": 1}, {\"name\": \"Test Product 2\", \"image\": \"test2.jpg\", \"price\": 50, \"quantity\": 1, \"product_id\": 2}]','{\"fullName\":\"Test User\",\"address\":\"123 Test Street\",\"city\":\"Test City\",\"zipCode\":\"12345\",\"country\":\"Test Country\"}','Credit Card',100.00),(6,8,NULL,NULL,'2025-03-03 09:20:39','\"[{\\\"product_id\\\":4,\\\"name\\\":\\\"Impulse Commercial Multi-Gym Encore ES2000 (Multi-Functional Trainer)\\\",\\\"description\\\":\\\"The Impulse ES2000 is one of the best-selling products in the Impulse Strength Encore line. Purpose-built by an industry-leading team, the ES2000 Multi-Gym will help you train your chest, back, shoulders, arms and legs all in the comfort of your own home.\\\",\\\"price\\\":\\\"37995.00\\\",\\\"image\\\":\\\"https://res.cloudinary.com/fitnessnetwork/image/upload/c_scale,w_1000/f_auto/v1/products/urnhd5cvegbh5teny8gq?_a=AACnOBs\\\",\\\"quantity\\\":1}]\"','\"{\\\"fullName\\\":\\\"joe\\\",\\\"address\\\":\\\"6 hole red\\\",\\\"city\\\":\\\"joburg\\\",\\\"zipCode\\\":\\\"8890\\\",\\\"country\\\":\\\"South Africa\\\"}\"','PayPal',37995.00),(10,8,NULL,NULL,'2025-03-05 07:39:26','\"[{\\\"product_id\\\":4,\\\"name\\\":\\\"Impulse Commercial Multi-Gym Encore ES2000 (Multi-Functional Trainer)\\\",\\\"description\\\":\\\"The Impulse ES2000 is one of the best-selling products in the Impulse Strength Encore line. Purpose-built by an industry-leading team, the ES2000 Multi-Gym will help you train your chest, back, shoulders, arms and legs all in the comfort of your own home.\\\",\\\"price\\\":\\\"37995.00\\\",\\\"image\\\":\\\"https://res.cloudinary.com/fitnessnetwork/image/upload/c_scale,w_1000/f_auto/v1/products/urnhd5cvegbh5teny8gq?_a=AACnOBs\\\",\\\"quantity\\\":1},{\\\"product_id\\\":12,\\\"name\\\":\\\"Close Grip V-Handle Cable Attachment\\\",\\\"description\\\":\\\"Our Close Grip V-Handle Cable Attachment helps you unlock the true potential of a single cable motion machine station. The main muscle group that this awesome.\\\",\\\"price\\\":\\\"490.00\\\",\\\"image\\\":\\\"https://github.com/keanan557/pulsefit-assets/blob/main/images/Close-Grip-V-Handle-Cable-Attachment-LivePro.jpg?raw=true\\\",\\\"quantity\\\":1}]\"','\"{\\\"fullName\\\":\\\"kay\\\",\\\"address\\\":\\\"7 go rd\\\",\\\"city\\\":\\\"pt\\\",\\\"zipCode\\\":\\\"0984\\\",\\\"country\\\":\\\"usa\\\"}\"','PayPal',38485.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (4,'Impulse Commercial Multi-Gym Encore ES2000 (Multi-Functional Trainer)','The Impulse ES2000 is one of the best-selling products in the Impulse Strength Encore line. Purpose-built by an industry-leading team, the ES2000 Multi-Gym will help you train your chest, back, shoulders, arms and legs all in the comfort of your own home.',37995.00,'https://res.cloudinary.com/fitnessnetwork/image/upload/c_scale,w_1000/f_auto/v1/products/urnhd5cvegbh5teny8gq?_a=AACnOBs',19),(5,'Impulse Commercial Multi-Gym 3 Stack Station ES3000','The unique three-weight stack design allows multiple fitness enthusiasts to engage in their exercises simultaneously, fostering an environment of motivation and camaraderie. Dive into a multitude of exercise stations, including a versatile chest/shoulder press, a comprehensive lat pulldown/low row, and specialized leg routines.',99500.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/es3000.1.jpg?raw=true',15),(6,'Impulse IT7011 Multi Adjustable Gym Bench','The Impulse IT Multi-Adjustable Bench is the perfect choice for any facility looking to equip the strength area of the gym with high quality, commercial grade equipment.',8795.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Impulse-IT-Multi-Adjustable-Bench-Product-Image.jpg?raw=true',20),(7,'LivePro Squat Pad','The LivePro pad relieves the pressure on the shoulders and neck.',210.00,'https://maxfitsa.co.za/_next/image?url=http%3A%2F%2Fmaxfitsa.co.za%2Fmedia%2Fimages%2Fproducts%2F2024%2F11%2Fbarbell-squat-pad-sponge-cover-220821.webp&w=1920&q=75',30),(8,'Triceps Rubber V-Bar (2.5cm x 40cm)','Our High Quality Tricep V-bar Can Be Found In Gyms Across South Africa.',480.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/V-Bar-Tricep-Product-Image.jpeg?raw=true',33),(9,'Wide Grip Row Attachment','Add variation to your back & shoulder workout with our wide grip row attachment.',595.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/Wide-Grip-Row-Attachment.webp',5),(10,'Dual Tricep Rope','The perfect accessory to increase your arm day variations!',295.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Dual-Tricep-Rope-Product-Image-1.jpg?raw=true',14),(11,'Stirrup D Handle Attachment','Stirrup D-Handle - Machined to Last, Perfectly textured handle and an outstanding tool to increase your workout variations.',167.00,'https://gymgear.co.za/wp-content/uploads/2022/01/D-Hande-768x768.jpg',7),(12,'Close Grip V-Handle Cable Attachment','Our Close Grip V-Handle Cable Attachment helps you unlock the true potential of a single cable motion machine station. The main muscle group that this awesome.',490.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Close-Grip-V-Handle-Cable-Attachment-LivePro.jpg?raw=true',20),(13,'Shua X5R Light-Commercial Recumbent Bike','SHUA SH-B6500R recumbent carries out a comfortable and smooth workout. The creative walk-through design gives a stable and durable performance, allow users to easily get on and off the equipment. With the adjustable ergonomics seat design, users with different heights and ages can reach a effective, smooth and low impact workout. And the integrated console provides the most intuitive training experience.',17800.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/Shua-Recumbent-Bike-6500R.webp',10),(14,'Commercial use Elliptical','Experience a smooth and silent workout with the SH-E800 Commercial Elliptical. Featuring the SEEC Ultra-Drive System and 32 levels of resistance, this elliptical ensures a natural and comfortable motion for all users.',49990.00,'https://healthconcepts.co.za/wp-content/uploads/2023/11/42.png',12),(16,'NRG Apex Crosstrainer Elliptical SU7100','Our Striide Apex™ Cross-trainer Elliptical Machine offers a low-impact, calorie-burning workout for all levels of fitness enthusiasts, from beginners to pros. ',10800.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/c5dc4dcb-45b7-45a5-9c97-07cf65aa0c19.webp',5),(17,'Assault Bike Pro X (Belt Driven)','The ultimate cardio equipment for those looking for a powerful training experience. This 2-stage belt drive bike includes all of the amenities of the Classic and Elite models with additional features that will take your fitness to the next level.',25990.00,'https://res.cloudinary.com/fitnessnetwork/image/upload/c_scale,w_1000/f_auto/v1/products/vrqjdyikqgxouq2aiwxa?_a=AACnOBs',7),(18,'Assault Rower Pro DEMO','Perfect for HIIT, cardio, and endurance training, the Assault Rower Pro provides a total body workout that is second to none. Training on the Assault Rower Pro is completely scalable. From the average gym-goer to an elite athlete, it will challenge and tone any physique. ',20500.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/5f0ac886-68e5-4f26-94bf-1ea9f8b1d4d9.webp',8),(19,'Air Bike Classic','Designed by a dedicated team of fitness engineers with a consistent stream of feedback from enthusiasts, club owners, trainers and physical therapists, the Assault is truly the best-in-class fan bike available today.',16590.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/7210bc7a-abb8-4a4c-81cb-2e18867a94db.webp',12),(20,'Assault Airrunner Pro [Commercial]','The ASSAULT: PRO AIRRUNNER is the most versatile, easy-to-use and effective non-motorized treadmill available today. Powered by your own stride, the ASSAULT: PRO AIRRUNNER matches your output and then pushes you to give even more. It’s low-impact design also helps promote proper running form and even prevents injury.',98990.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/assault-pro-airrunner-commercial-1.webp',8),(21,'Powercore Motorless Curve Treadmill (Self Powered with resistance)','The Powercore Motorless Curve Treadmill offers a unique and challenging fitness experience. Powered solely by your own energy, this innovative treadmill features a curved running surface that mimics natural running gait, reducing impact and improving running form.',44990.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/72862e4d-e214-4dd2-8ffe-ef14e63031ce.webp',0),(22,'Concept 2 Model D Indoor RowErg® with PM5','The Concept2 Model D rower is undoubtedly the best rower in the world.',26995.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Concept2-Model-D-with-PM5-Monitor-Product-Image.jpg?raw=true',5),(23,'LivePro Aerobic Step – Non Slip','The LivePro Aerobic Step is a great piece of commercial gym equipment for convenient, quick and effective workouts.',1550.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-LP8240-Aerobic-Step-Product-Image.jpg?raw=true',30),(24,'LivePro Speed Jump Rope','The Speed Rope with and without additional weights is a professional training tool for strengthening the cardiovascular system, promoting the endurance.',185.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Speed-Jump-Rope-Product-Image.png?raw=true',80),(25,'LivePro Resistance Bands Set (Loop Bands)','The ultimate resistance band for stretching and strengthening exercises of the leg and hip muscles.',199.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Resistance-Loop-Bands-Set-Product-Image.png?raw=true',56),(26,'LivePro Booty Bands | Hip Bands','These Booty Bands Will Help You Shape Your Glutes, Secure Your Form and Increase Your Range of Motion',195.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Booty-Bands-Product-Image-General.png?raw=true',77),(27,'LivePro Yoga Mat – 10mm High Density Foam – Black & Blue','This sports mat is especially designed for Pilates and Yoga training.',495.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LP8228-4.jpg?raw=true',63),(28,'LivePro Resistance Bands (Super/Exercise Bands)','The LivePro Powerband is suitable for various sports.',495.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Super-Band-Product-Image.png?raw=true',12),(29,'Slam Balls – Rubber Textured (Black/Blue) | LivePro','The Slam Ball is suitable for various exercises during fitness- and functional training.',725.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/LivePro-Slam-Balls-Rubber-Textured-Product-Image-1.webp',14),(30,'LivePro Foam Roller (2 Different Sizes)','The LivePro Foam Roller is especially suitable for Pilates training.',500.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Foam-Roller-Product-Image-1.jpg?raw=true',18),(31,'LivePro NBR Workout Mat – 10mm High Density Foam – Blue & Grey','This sports mat is very popular in the aerobics and fitness sector.',330.00,'https://healthconcepts.co.za/wp-content/uploads/2023/09/36.png',32),(32,'LivePro Weighted Vest','The LivePro Weighted Vest is a premium weight vest that is made up of extra durable nylon material, with double stitching and extra padded shoulders.',1358.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Weighted-Vest-Product-Image.png?raw=true',35),(33,'Hexagonal Dumbbells Rubber Coated Pairs (Black & Silver)','Dumbbells are perfect as a full-body conditioning tool and can be used to target more than just the upper torso. Our dumbbells have an ergonomic handle and are made using highly durable rubber.',920.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Hex-Dumbs-Sized.jpg?raw=true',22),(34,'Tri Grip Olympic Rubber Weight Plate (Singles)','Weight Plates are perfect as a full-body conditioning tool and can be used to target more than just the upper torso.',1000.00,'https://gymstore.co.za/wp-content/uploads/2020/10/Matt-Olympic-Rubber-Tri-Grip-Weight-Plate-2.5kg-Product-Image.jpg',15),(35,'Kettlebells Cast Iron XF | | LivePro','The LivePro Kettlebell is produced from the highest quality of iron.',1705.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Kettlebell-Product-Image.jpg?raw=true',18),(36,'LivePro Rubber Bumper Weight Plate VR (SINGLE)','The LivePro Bumper Plate is a premium virgin rubber Olympic weight plate produced according to the latest manufacturing standards.',1675.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Rubber-Bumper-Plates-LP8026-Product-Image.jpg?raw=true',14),(37,'LivePro Black Rubber Bumper Plate (SINGLE)','The Rubber Granule Bumper Plate has a flanged inner ring made of stainless steel, which allows a fast and safe loading and unloading of the discs on any Olympia barbell.',1342.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Bumper-Plate.png?raw=true',15),(38,'LivePro Studio Dumbbells (Pair)','High quality studio dumbbell with vinyl coating.',1010.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/LivePro-Dumbbells-Product-Image.jpg?raw=true',25),(39,'Olympic Spring Collar – Pair','The Olympic Spring Collar pair is made for everyday use.',80.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Olympic-Spring-Collar-Pair-Product-Image.jpg?raw=true',35),(40,'Olympic Bar 20kg Spring Steel – 2.2m x 30mm (450kg Max)','The Olympic Bar will help you improve your squat, bench and deadlift capabilities .',2595.00,'https://raw.githubusercontent.com/keanan557/pulsefit-assets/refs/heads/main/images/Olympic-Bar-450KG-Product-Image-1.webp',9),(41,'LivePro 1.2m EZ Curl Bar','The LivePro 1.2m Olympic Curl Bar is a premium-quality EZ-Curl Bar for use both at home and gym or health club.',1270.00,'https://www.fleximuscles.co.za/cdn/shop/files/Mainimage_ead9e41d-f7c3-4000-911b-88ec256be18e_1800x1800.jpg?v=1691309040',44),(42,'LivePro Straight Round Rubber Barbell','Barbells are perfect as a full-body conditioning tool and can be used to target more than just the upper torso.',1270.00,'https://github.com/keanan557/pulsefit-assets/blob/main/images/Round-Fixed-Straight-Barbell-Product-Image.jpg?raw=true',75);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (3,123,456,4,'This product is fantastic! I highly recommend it.','2025-03-06 08:32:59'),(8,123,456,4,'This product is fantastic! I highly recommend it.','2025-03-06 08:38:06'),(9,4,8,4,'This product is fantastic! I highly recommend it.','2025-03-06 08:56:38'),(10,NULL,1,5,'hohoho','2025-03-06 09:26:45');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'james','james@gmail.com','$2b$10$VUMBfzq4I6eAgRcFDRYmzOJB2z26VUg6Xeita0M13EFuNgYIP/AIC'),(2,'johnny','johnny@gmail.com','$2b$10$X.pdRudyEDgQan9TH3lUAuuivftBpC8PrijhJJPchHnc1mOrGyGzS'),(3,'Mogale Kgasago','mogalekgasago17@gmail.com','$2b$10$zRxK1g2JwtEYGL5TY7ughOU815GrPhK2Cp.POMmTJHs.7M0QXQgFu'),(6,'keanan','keanan@gmail.com','$2b$10$EYxehyW3wFHbIiSypb1QduVpmj1bGGJ5ZtZdTi5gGRC2vuRkCeb7.'),(7,'rick','rick@gmail.com','$2b$10$nmpRKXpjQMTjaxxRKHxFKO/dXWgOsaa41S1IWZt3nykCYmowfFSXy'),(8,'johnson','johnson@gmail.com','$2b$10$kgSBf6DefoiU8AXLKY7G4.yE2CiSmcGbMEWBHsXF8XuW6XDfzUjVS'),(9,'anele','anelevenge39@gamil.com','$2b$10$zD091I.NbfAAyjRUeT5Rh.9E8KGVNxqKWxrBWGir61DZGtuLGjf/K'),(10,'Sphelele Lostile','lostilesphelele@gmail.com','$2b$10$CI6whmDYx5mILD/cF8p3Pec13E1LDhQLWdWZCsf3VGBEqQfOIC2UC');
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

-- Dump completed on 2025-03-06 13:35:37
