CREATE DATABASE  IF NOT EXISTS `livraria` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `livraria`;
-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: livraria
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idcliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
   role VARCHAR(50) DEFAULT 'user' , 
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `idcompra` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `cliente_idcliente` int NOT NULL,
  PRIMARY KEY (`idcompra`),
  KEY `fk_compra_cliente1_idx` (`cliente_idcliente`),
  CONSTRAINT `fk_compra_cliente1` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra_has_livro`
--

DROP TABLE IF EXISTS `compra_has_livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra_has_livro` (
  `idcompra` int NOT NULL,
  `idlivro` int NOT NULL,
  PRIMARY KEY (`idcompra`,`idlivro`),
  KEY `fk_compra_has_livro_livro1_idx` (`idlivro`),
  KEY `fk_compra_has_livro_compra1_idx` (`idcompra`),
  CONSTRAINT `fk_compra_has_livro_compra1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`),
  CONSTRAINT `fk_compra_has_livro_livro1` FOREIGN KEY (`idlivro`) REFERENCES `livro` (`idlivro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_has_livro`
--

LOCK TABLES `compra_has_livro` WRITE;
/*!40000 ALTER TABLE `compra_has_livro` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra_has_livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `idlivro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `autor` varchar(45) NOT NULL,
  `genero` varchar(45) NOT NULL,
  `descricao` mediumtext NOT NULL,
  `data_publicacao` year NOT NULL,
  `estoque` int NOT NULL,
  `paginas` int NOT NULL,
  PRIMARY KEY (`idlivro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro_has_cliente`
--

DROP TABLE IF EXISTS `livro_has_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro_has_cliente` (
  `idlivro` int NOT NULL,
  `idcliente` int NOT NULL,
  PRIMARY KEY (`idlivro`,`idcliente`),
  KEY `fk_livro_has_cliente_cliente1_idx` (`idcliente`),
  KEY `fk_livro_has_cliente_livro_idx` (`idlivro`),
  CONSTRAINT `fk_livro_has_cliente_cliente1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `fk_livro_has_cliente_livro` FOREIGN KEY (`idlivro`) REFERENCES `livro` (`idlivro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro_has_cliente`
--

LOCK TABLES `livro_has_cliente` WRITE;
/*!40000 ALTER TABLE `livro_has_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `livro_has_cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-06 23:49:28
