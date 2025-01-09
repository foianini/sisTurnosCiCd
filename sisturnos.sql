-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: sisturnos
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitacora` (
  `idBit` int(11) NOT NULL AUTO_INCREMENT,
  `idLlamada` int(11) DEFAULT NULL,
  `idConfiguracion` int(11) DEFAULT NULL,
  `fechaModificacion` date DEFAULT NULL,
  `culpable` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idBit`),
  KEY `idConfiguracion` (`idConfiguracion`),
  KEY `idLlamada` (`idLlamada`),
  CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`idConfiguracion`) REFERENCES `configuraciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bitacora_ibfk_2` FOREIGN KEY (`idLlamada`) REFERENCES `llamadas` (`codigo_llamada`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuraciones`
--

DROP TABLE IF EXISTS `configuraciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuraciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `estilo` varchar(100) NOT NULL,
  `volumen_video` float NOT NULL,
  `limite_consulta` int(11) NOT NULL,
  `sonido_alerta` varchar(100) NOT NULL,
  `volumen_sonido_alerta` float NOT NULL,
  `tiempo_notificacion` int(11) NOT NULL,
  `habilitada` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuraciones`
--

LOCK TABLES `configuraciones` WRITE;
/*!40000 ALTER TABLE `configuraciones` DISABLE KEYS */;
INSERT INTO `configuraciones` VALUES
(1,'Triaje - Emergencias','http://127.0.0.1/css/estilo_triaje/estilos.css',0.05,1,'./recursos/sonidos/sonido1.mp3',1,20000,0),
(2,'Principal','http://127.0.0.1/css/estilo_principal/estilos.css',0.05,6,'./recursos/sonidos/sonido1.mp3',1,5000,1),
(3,'Secundario','http://127.0.0.1/css/estilo_secundario/estilos.css',0.2,4,'./recursos/sonidos/sonido2.mp3',0.5,8000,0);
/*!40000 ALTER TABLE `configuraciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `llamadas`
--

DROP TABLE IF EXISTS `llamadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `llamadas` (
  `codigo_llamada` int(11) NOT NULL AUTO_INCREMENT,
  `paciente` varchar(50) NOT NULL,
  `doctor` varchar(50) NOT NULL,
  `lugar` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`codigo_llamada`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llamadas`
--

LOCK TABLES `llamadas` WRITE;
/*!40000 ALTER TABLE `llamadas` DISABLE KEYS */;
INSERT INTO `llamadas` VALUES
(479,'Pinto Barja de Villavicencio Ana Maria','Dra. Capach Alpire Selva Maria','Consultorio 33 - 2A','2024-11-19 14:06:10'),
(480,'Alvarez Gutierrez de Gutierrez Silvia','Dr. Altieri Mendez Luis Marcimio','Consultorio 29 - 2A','2024-11-19 14:06:39');
/*!40000 ALTER TABLE `llamadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajes`
--

DROP TABLE IF EXISTS `mensajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mensajes` (
  `idMen` int(11) NOT NULL AUTO_INCREMENT,
  `mensaje` varchar(200) DEFAULT NULL,
  `fechaMen` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  PRIMARY KEY (`idMen`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-19 14:27:32
