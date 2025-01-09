-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: equiposClinica
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
-- Table structure for table `equiposCli`
--

DROP TABLE IF EXISTS `equiposCli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equiposCli` (
  `idEquip` int(11) NOT NULL AUTO_INCREMENT,
  `EquiposClinicaMacAddress` varchar(50) DEFAULT NULL,
  `EquiposClinicaIp` varchar(50) DEFAULT NULL,
  `EquiposClinicaDescripcion` varchar(50) DEFAULT NULL,
  `EquiposClinicaFechaActualizaci` datetime DEFAULT NULL,
  `EquiposClinicaEstado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEquip`)
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equiposCli`
--

LOCK TABLES `equiposCli` WRITE;
/*!40000 ALTER TABLE `equiposCli` DISABLE KEYS */;
INSERT INTO `equiposCli` VALUES
(329,'dc:a6:32:a7:59:bd','192.168.10.60','raspberrypi','2024-10-23 14:48:24','conectado'),
(330,NULL,NULL,NULL,NULL,'conectado'),
(331,NULL,NULL,NULL,NULL,'conectado'),
(332,NULL,NULL,NULL,NULL,'conectado'),
(333,NULL,NULL,NULL,NULL,'conectado'),
(334,'e4:5f:01:1a:3a:d8','192.168.10.191','consultorio','2024-11-16 14:56:39','conectado'),
(335,NULL,NULL,NULL,NULL,'conectado'),
(336,NULL,NULL,NULL,NULL,'conectado'),
(337,NULL,NULL,NULL,NULL,'conectado'),
(338,NULL,NULL,NULL,NULL,'conectado'),
(339,'e4:5f:01:1a:3a:d9','192.168.40.114','consultorio','2024-11-08 13:45:04','conectado'),
(340,NULL,NULL,NULL,NULL,'conectado'),
(341,NULL,NULL,NULL,NULL,'conectado'),
(342,NULL,NULL,NULL,NULL,'conectado'),
(343,NULL,NULL,NULL,NULL,'conectado');
/*!40000 ALTER TABLE `equiposCli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('-Fjlhh7Cuag9UXJ5VC9PD9_4dbw2Z_Dp',1732042037,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('-e_kr7uBpV7dwhYJJDS900Nd0L1Ep0IY',1732042546,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('0MHZWfMbQkE6LHcADjGdPpCGuhOJlHLF',1732044386,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('0ttj1xuKtcKrpH9nGvh20CxXseXZ8R23',1732046062,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('13ovdnMD1zSg2PYsIKnM5kHlu8qZ-vI0',1732126354,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('1TBOHJelDiTG5WjwNM3czvDtmr2kc2T-',1732046571,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('1a1FjGAqWa77_w_Zotu63SWDujBCmzRF',1732045314,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('4lk2YmTjKnGKSDeZkKsp2hfOHOp_f1F0',1732045197,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('5CW_dRTBxXgWXxG8t5C38YFC12RJiEdL',1732042948,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('5nSMIpCbXpusXebh0b60cHg3JKX2t7fO',1732043500,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6IK8g536Ej8FJhc7UHv6QKdXXDImGwo2',1732043787,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6RHFKdsWqSRTgRbBtDLvu1HkuvGWqseO',1732043525,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6VLeB86qCtHbrlOyp7fVk6_i4LYbXlOV',1732046849,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('74gv7CCnJRbUzhmt_e9M7R6B7nlAGGwN',1732047025,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('7rLqVsJ5LZnbat-_oo3mO-HFQYc8Wqqi',1732043351,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('8082V-AAX8BBc-qo0uET3UuquDxgkUQ3',1732043787,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('9kE-aQHDMIVHFdTnvaRhFHXtbJI0ER11',1732046523,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('A1jImDjtO2JVhtJXztDa1k6Y-cJ2R_4x',1732046849,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('AcZUdsdxE4wDYI0CemrMmMvmhZp01vMr',1732043756,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('BAqm0pyBRk36lCqgyUO9OJ7WW7w5HWBm',1732046270,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('C43t38ghyBF4SRJgRAoL3hqW4LBpUp-_',1732044680,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('CYnzJLXPLjo5RCr5Ui-3S4pAnZrXdlDg',1732041582,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('DuB8AuWEXUah2QX2pD2sb172uFU8DNzx',1732046484,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('GWlPsjNCg2kRhHHMxZNh2s-skp295RAA',1732045080,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Hs6qmHXUFRG9K7A4q0LmtCNzzvFiSWkA',1732046664,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('HuPQUmV3bTPCn7mYTy4qYsR58Hu1bpx8',1732044793,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('HvclxzNnYvgw9u7HBF2e9fq8BFAi3rin',1732044793,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('IFyFeOifwuMfD6S5aUbbiqbk47llImHI',1732045495,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('IQLHnZ5LyqYI6uE0AP4EVWyDM7HlvEgy',1732125970,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{\"message\":[{\"doctor\":\"Dra. Capach Alpire Selva Maria\",\"paciente\":\"Pinto Barja de Villavicencio Ana Maria\",\"lugar\":\"Consultorio 33 - 2A\",\"fecha\":\"2024-11-19 14:06:10\"}]}}'),
('LSe6EWRwE3J2aoBmz2d2xRdJ1HgHMKIK',1732045556,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('LUUSGYgBJWuSBt0zf_rMFA-JH01Ei7ec',1732043737,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('MJoaqfyFD-ukDJdrmjDtcxYFpaY4qPu9',1732043525,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('MpMK_GL75FsSGh899r9f_lLA40lCxufn',1732045016,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('N84nHF4kKTQj02XWf8OWYDhkesrQUuAR',1732046484,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('O8wbE8P0JixN3aKiYWGrPGJC8_LpeGyO',1732045336,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('OnJnKHICVWL-Iv2q8_X8EgMZaiu-kMDj',1732043787,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Oz3sdx4XvX8HO6ZQ6eZDH6TvMfdzmcgF',1732046443,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Pt-6gv4s_vPg7rNeHyHyoicZ7o6zASQH',1732046770,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('QsxVR-kjB0Tx4N3SqmPPgboCn2LUc0JE',1732044014,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('QxMoZ9MK7xguooyh7WmVBhNLGr-BBBg_',1732046800,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('TU1UKNsVtvsiXSLyCSwFWJhKw10FB261',1732045197,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('UKYVY-zithc_XWd4ZxhWVCNrsb7F4sEa',1732043737,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('VixE69l7OeqGQ5ZbE1PIV2M5YaYJF8jP',1732046849,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('VoXq7pgbBAzy_L9UwTM1u12oEllaPRRb',1732044014,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('WFQkM8Z-9De8tWRvCOKNe2Ccbme__L_E',1732046770,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('WRrS3m-Fwi1fRKMLsdU9KrlVj2PIMkAu',1732046770,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('WgFRsWjVWHkiv7FtJ94W7TEmRo4rl3p7',1732045197,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Wz2LIFJS_C_k0j9a0aFAOz4OV-qmOSYm',1732044095,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('XDn9sLwQU51xq547srxVb6yDDC_leXT3',1732046484,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('YAb0rKMDKcaKG2VcDUEKTDsAwWCPuxg3',1732042519,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('YC6IQjDQ7Txtm3j3o8lm2w5aXLxoWo4n',1732046062,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('YtDHDBhn-3VZFojTCUoVU0c0nfSx5tIK',1732044680,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('_EiPK-sjEzmRrFe7EiYaPWNrJPWocPaN',1732045889,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('a61lH8_ewCM0qFFs87FHAfkgJyE7OKHW',1732044014,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('ag8Ca7vvideTK4MgviBB8DiJEgwLJlAF',1732046123,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('bBHEfS7-X6Sggz9uQHfpEE_O_OBnuAeV',1732044793,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('bJXE_wsCbPjZmAA75_vdbrI5_aJvP9fn',1732046727,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('bTMhe_WUWExCTrfQlBzABnwW46VegfA-',1732040231,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('bu5-H3O0iXf2NzrUYGoiK50HQbfptLvB',1732044934,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('cmt8vKV0dOWe5HQirgHQI18rc0gJju_-',1732042948,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('e4PZNNrQ_8Fd2GRV59YgXnpM9wtA5IbO',1732043973,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('gC_AQ-NQeWzJjSXY28MjpZwBCj7KoYA7',1732045314,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('hES7ppKpVfBaJ6hU75KsDPmf1d0uwbEL',1732045521,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('iOuGljskwDs58XeT1KclOXS-L9R92SPU',1732045314,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('j2HJU9py_bMeY8KydVa8oMfl0jyV1YoR',1732044432,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('jBB26Bh9mIo_gkg8INNDhvudm8mpOadZ',1732044680,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('jPoNrzoe2Tq_7WXalJyZZW8n0DmWizBK',1732046800,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('kL1HKx_rzxc8sitAnYk-823TNlRBGXIE',1732043737,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('lRHBDfpGlwUHKzXIYgJW_ySm6jiZzwgv',1732045539,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('mvrhvw5qlkYALPZK1__mZ3_eisWuX_hO',1732046062,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('nX8GuepqXLQr_ea7Tw0wjlJD1fzl06px',1732045537,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('ngz8iTHxNQStQr9AKrhTMQ9gJfWC199M',1732043286,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('pDSFwmErpnXpnz-jfrI0MCXGbmTg7Hxm',1732125999,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{\"message\":[{\"doctor\":\"Dr. Altieri Mendez Luis Marcimio\",\"paciente\":\"Alvarez Gutierrez de Gutierrez Silvia\",\"lugar\":\"Consultorio 29 - 2A\",\"fecha\":\"2024-11-19 14:06:39\"}]}}'),
('pnPMNbYtRJnW6chjm2xygkH1EghXzIZe',1732044331,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('qiY_Eqde916dNS15T-QwATrND6y2FGvw',1732046800,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('rIH57_Ssn6EkQGBqxeCn31BKHvrAHFbe',1732045909,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('sO8-Fem9fmCCLH0ihjuZvX4Qz4YAqgdG',1732045521,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('st4RSkhUrJdI-FjRAUBGGekhlgypWEEF',1732046453,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('uRsC5yhd80sDWAS7ddMbrO5YRaJW35N8',1732046774,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('vOqGFl6ZpUagSZH59CD6shjv1TI4q3wL',1732044376,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('xPc5iGoQT35YOxAdeNtLGLSgoYwenf8g',1732043525,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('y-7qKT4w-ER16SpLeZ4o0De6vJWFH4A4',1732042708,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('yzK8uxxvhon1hTNHdxU2B711fuQHkwHj',1732045521,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('zTO29JgWw2AbbclQCoIzaiQK5CINBZ5N',1732042572,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('zTgQSiY49Nr5N8N_ccpXJ5LGY6IgxaFn',1732042948,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('zcRRbnxBw-Tqrbx0AENWs50aBXsP6JDN',1732045158,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-19 14:27:00
