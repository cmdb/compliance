
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
DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `component` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Components';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `componentversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `componentversion` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `component` int(11) unsigned NOT NULL,
  `version` varchar(32) NOT NULL DEFAULT '0',
  `startdate` date NOT NULL,
  `enddate` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `component_version` (`component`,`version`),
  CONSTRAINT `component_id_fk` FOREIGN KEY (`component`) REFERENCES `component` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Component Versions';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `cpu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cpu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vendor` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `arch` enum('32','64') NOT NULL,
  `cores` tinyint(3) unsigned DEFAULT NULL,
  `htfactor` tinyint(3) unsigned DEFAULT '2',
  `frequency` decimal(5,2) unsigned DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `cpuvendorid_fk` (`vendor`),
  CONSTRAINT `cpuvendorid_fk` FOREIGN KEY (`vendor`) REFERENCES `vendor` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(64) NOT NULL,
  `vendor` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `model` int(11) unsigned NOT NULL,
  `serial` varchar(64) DEFAULT NULL,
  `cpucount` smallint(5) unsigned DEFAULT NULL,
  `cpu` int(11) unsigned NOT NULL,
  `ram` int(10) unsigned DEFAULT NULL,
  `os` int(11) unsigned DEFAULT NULL,
  `environment` int(11) unsigned DEFAULT NULL,
  `site` int(11) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `vendorid_fk` (`vendor`),
  KEY `modelid_fk` (`model`),
  KEY `siteid_fk` (`site`),
  KEY `cpuid_fk` (`cpu`),
  KEY `osid_fk` (`os`),
  KEY `environmentid_fk` (`environment`),
  CONSTRAINT `cpuid_fk` FOREIGN KEY (`cpu`) REFERENCES `cpu` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `environmentid_fk` FOREIGN KEY (`environment`) REFERENCES `environment` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `modelid_fk` FOREIGN KEY (`model`) REFERENCES `model` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `osid_fk` FOREIGN KEY (`os`) REFERENCES `os` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `siteid_fk` FOREIGN KEY (`site`) REFERENCES `site` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `vendorid_fk` FOREIGN KEY (`vendor`) REFERENCES `vendor` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `devicehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicehistory` (
  `id` int(11) unsigned NOT NULL,
  `uuid` varchar(64) NOT NULL,
  `vendor` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `model` int(11) unsigned NOT NULL,
  `serial` varchar(64) DEFAULT NULL,
  `cpucount` smallint(5) unsigned DEFAULT NULL,
  `cpu` int(11) unsigned NOT NULL,
  `ram` int(10) unsigned DEFAULT NULL,
  `os` int(11) unsigned DEFAULT NULL,
  `environment` int(11) unsigned DEFAULT NULL,
  `site` int(11) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id_timestamp` (`id`,`timestamp`),
  KEY `vendorid_fk` (`vendor`),
  KEY `modelid_fk` (`model`),
  KEY `siteid_fk` (`site`),
  KEY `cpuid_fk` (`cpu`),
  KEY `osid_fk` (`os`),
  KEY `environmentid_fk` (`environment`),
  CONSTRAINT `hcpuid_fk` FOREIGN KEY (`cpu`) REFERENCES `cpu` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `henvironmentid_fk` FOREIGN KEY (`environment`) REFERENCES `environment` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `hmodelid_fk` FOREIGN KEY (`model`) REFERENCES `model` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `hosid_fk` FOREIGN KEY (`os`) REFERENCES `os` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `hsiteid_fk` FOREIGN KEY (`site`) REFERENCES `site` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `hvendorid_fk` FOREIGN KEY (`vendor`) REFERENCES `vendor` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `devices`;
/*!50001 DROP VIEW IF EXISTS `devices`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `devices` (
  `device` tinyint NOT NULL,
  `vendor` tinyint NOT NULL,
  `os` tinyint NOT NULL,
  `site` tinyint NOT NULL,
  `timestamp` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `os` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vendor` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `arch` int(11) unsigned NOT NULL,
  `version` varchar(128) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vendor_name_version` (`vendor`,`name`,`version`),
  KEY `osvendorid_fk` (`vendor`),
  KEY `osarchid_fk` (`arch`),
  CONSTRAINT `osarchid_fk` FOREIGN KEY (`arch`) REFERENCES `osarch` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `osvendorid_fk` FOREIGN KEY (`vendor`) REFERENCES `vendor` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `osarch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osarch` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `city` int(11) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `cityid_fk` (`city`),
  CONSTRAINT `cityid_fk` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP TABLE IF EXISTS `devices`*/;
/*!50001 DROP VIEW IF EXISTS `devices`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`compliance`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `devices` AS select `device`.`name` AS `device`,`vendor`.`name` AS `vendor`,`os`.`name` AS `os`,`site`.`name` AS `site`,`device`.`timestamp` AS `timestamp` from (((`device` join `vendor` on((`device`.`vendor` = `vendor`.`id`))) join `site` on((`device`.`site` = `site`.`id`))) join `os` on((`device`.`os` = `os`.`id`))) order by `device`.`name` */;
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

