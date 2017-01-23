/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.7.17-log : Database - jrelax-bi
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jrelax-bi` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jrelax-bi`;

/*Table structure for table `act_evt_log` */

DROP TABLE IF EXISTS `act_evt_log`;

CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_evt_log` */

/*Table structure for table `act_ge_bytearray` */

DROP TABLE IF EXISTS `act_ge_bytearray`;

CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_bytearray` */

/*Table structure for table `act_ge_property` */

DROP TABLE IF EXISTS `act_ge_property`;

CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_property` */

insert  into `act_ge_property`(`NAME_`,`VALUE_`,`REV_`) values 
('next.dbid','1',1),
('schema.history','create(5.18.0.1)',1),
('schema.version','5.18.0.1',1);

/*Table structure for table `act_hi_actinst` */

DROP TABLE IF EXISTS `act_hi_actinst`;

CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_actinst` */

/*Table structure for table `act_hi_attachment` */

DROP TABLE IF EXISTS `act_hi_attachment`;

CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_attachment` */

/*Table structure for table `act_hi_comment` */

DROP TABLE IF EXISTS `act_hi_comment`;

CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_comment` */

/*Table structure for table `act_hi_detail` */

DROP TABLE IF EXISTS `act_hi_detail`;

CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_detail` */

/*Table structure for table `act_hi_identitylink` */

DROP TABLE IF EXISTS `act_hi_identitylink`;

CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_identitylink` */

/*Table structure for table `act_hi_procinst` */

DROP TABLE IF EXISTS `act_hi_procinst`;

CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_procinst` */

/*Table structure for table `act_hi_taskinst` */

DROP TABLE IF EXISTS `act_hi_taskinst`;

CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_taskinst` */

/*Table structure for table `act_hi_varinst` */

DROP TABLE IF EXISTS `act_hi_varinst`;

CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_varinst` */

/*Table structure for table `act_id_group` */

DROP TABLE IF EXISTS `act_id_group`;

CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_group` */

/*Table structure for table `act_id_info` */

DROP TABLE IF EXISTS `act_id_info`;

CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_info` */

/*Table structure for table `act_id_membership` */

DROP TABLE IF EXISTS `act_id_membership`;

CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_membership` */

/*Table structure for table `act_id_user` */

DROP TABLE IF EXISTS `act_id_user`;

CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_user` */

/*Table structure for table `act_procdef_info` */

DROP TABLE IF EXISTS `act_procdef_info`;

CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_procdef_info` */

/*Table structure for table `act_re_deployment` */

DROP TABLE IF EXISTS `act_re_deployment`;

CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_deployment` */

/*Table structure for table `act_re_model` */

DROP TABLE IF EXISTS `act_re_model`;

CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_model` */

/*Table structure for table `act_re_procdef` */

DROP TABLE IF EXISTS `act_re_procdef`;

CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_procdef` */

/*Table structure for table `act_ru_event_subscr` */

DROP TABLE IF EXISTS `act_ru_event_subscr`;

CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_event_subscr` */

/*Table structure for table `act_ru_execution` */

DROP TABLE IF EXISTS `act_ru_execution`;

CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_execution` */

/*Table structure for table `act_ru_identitylink` */

DROP TABLE IF EXISTS `act_ru_identitylink`;

CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_identitylink` */

/*Table structure for table `act_ru_job` */

DROP TABLE IF EXISTS `act_ru_job`;

CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_job` */

/*Table structure for table `act_ru_task` */

DROP TABLE IF EXISTS `act_ru_task`;

CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_task` */

/*Table structure for table `act_ru_variable` */

DROP TABLE IF EXISTS `act_ru_variable`;

CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_variable` */

/*Table structure for table `bi_charts` */

DROP TABLE IF EXISTS `bi_charts`;

CREATE TABLE `bi_charts` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '名称',
  `type` varchar(50) NOT NULL COMMENT '类型',
  `configs` text NOT NULL COMMENT '配置',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` varchar(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义图表';

/*Data for the table `bi_charts` */

insert  into `bi_charts`(`id`,`name`,`type`,`configs`,`createUser`,`createTime`) values 
('4028b88158c368660158c36f62c60001','日访问量统计','line','{\"type\":\"line\",\"datasource\":[{\"id\":\"4028b88158c282ad0158c28c61550001\",\"name\":\"系统日访问量\",\"xAxis\":\"日期\",\"yAxis\":\"访问数\"}],\"charts\":{\"type\":\"line\",\"options\":{\"title\":{\"display\":false,\"text\":\"中文\",\"position\":\"top\"},\"legend\":{\"display\":false,\"position\":\"top\"},\"elements\":{\"line\":{\"fill\":false},\"point\":{\"radius\":\"3\"}}}}}','超级管理员','2016-12-03 14:46:46'),
('4028b88158c394ca0158c398392c0002','日志访问统计','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":false,\"text\":\"日期分布\",\"position\":\"top\"}}}}','超级管理员','2016-12-03 15:31:22'),
('4028b88158c394ca0158c39c387b0003','日志统计 - 环形','doughnut','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"},\"cutoutPercentage\":\"50\"}}}','超级管理员','2016-12-03 15:35:44'),
('4028b88158c394ca0158c3a36d140012','日志统计 - 极坐标图','polar-area','{\"type\":\"polarArea\",\"datasource\":[{\"id\":\"4028b88158b8da450158b94836200009\",\"name\":\"系统日志模块统计\",\"xAxis\":\"系统模块\",\"yAxis\":\"访问数量\"}],\"charts\":{\"type\":\"polarArea\",\"options\":{\"legend\":{\"display\":true},\"animation\":{\"animateScale\":true}}}}','超级管理员','2016-12-03 15:43:37'),
('4028b88158c394ca0158c3abc0fc001a','日志统计 - 雷达图','radar','{\"type\":\"radar\",\"datasource\":[{\"id\":\"4028b88158b8da450158b94836200009\",\"name\":\"系统日志模块统计\",\"xAxis\":\"系统模块\",\"yAxis\":\"访问数量\"}],\"charts\":{\"type\":\"radar\",\"options\":{\"legend\":{\"display\":false},\"animation\":{\"animateScale\":true}}}}','超级管理员','2016-12-03 15:52:42'),
('4028b88158c394ca0158c3c0d84f0025','气泡图-演示','bubble','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158c394ca0158c3bcb0180024\",\"name\":\"气泡图测试数据源\",\"xAxis\":\"x\",\"yAxis\":\"y\", \"rAxis\":\"r\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"title\":{\"display\":false,\"text\":\"测试图表\",\"position\":\"top\"}}}}','超级管理员','2016-12-03 16:15:45'),
('4028b88158cd06060158cddb966d0023','柱状图','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-05 15:21:09');

/*Table structure for table `bi_database` */

DROP TABLE IF EXISTS `bi_database`;

CREATE TABLE `bi_database` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '数据库名称',
  `type` varchar(10) NOT NULL COMMENT '数据库类型',
  `driver` varchar(100) NOT NULL COMMENT '数据库驱动',
  `host` varchar(50) NOT NULL COMMENT '主机地址',
  `port` int(11) NOT NULL COMMENT '端口',
  `dbName` varchar(50) NOT NULL COMMENT '数据库名',
  `url` varchar(100) NOT NULL COMMENT '数据库连接',
  `username` varchar(50) NOT NULL COMMENT '数据库用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '数据库密码',
  `invokes` int(11) NOT NULL DEFAULT '0' COMMENT '调用次数',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` varchar(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库';

/*Data for the table `bi_database` */

insert  into `bi_database`(`id`,`name`,`type`,`driver`,`host`,`port`,`dbName`,`url`,`username`,`password`,`invokes`,`createUser`,`createTime`) values 
('4028b88159b0b8760159b0c78bb40003','测试数据库','mysql','com.mysql.jdbc.Driver','localhost',3306,'test','jdbc:mysql://localhost:3306/test','root','pass',0,'超级管理员','2017-01-18 16:53:04');

/*Table structure for table `bi_datasource` */

DROP TABLE IF EXISTS `bi_datasource`;

CREATE TABLE `bi_datasource` (
  `id` varchar(50) NOT NULL,
  `db` varchar(32) NOT NULL DEFAULT 'local' COMMENT '目标数据库',
  `name` varchar(30) NOT NULL COMMENT '数据源名称',
  `sqlCmd` text NOT NULL COMMENT 'sql语句',
  `virtuald` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是虚拟数据源',
  `virtualLinkIds` varchar(500) DEFAULT NULL COMMENT '关联数据源id，多个用逗号隔开',
  `createUser` varchar(50) NOT NULL,
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_datasource` */

insert  into `bi_datasource`(`id`,`db`,`name`,`sqlCmd`,`virtuald`,`virtualLinkIds`,`createUser`,`createTime`) values 
('4028b88158af03570158af47b68e000b','local','测试数据源','select id, name, sex from bi_test1 where name like \'%{#姓名#}%\'',0,NULL,'superadmin','2016-11-29 16:51:02'),
('4028b88158af03570158af6adbf80011','local','测试数据源-无参','select * from bi_test1',0,NULL,'superadmin','2016-11-29 17:29:25'),
('4028b88158b8da450158b94836200009','local','系统日志模块统计','SELECT manipulatename AS \'系统模块\', COUNT(*) AS \'访问数量\' FROM sys_log GROUP BY manipulatename',0,NULL,'superadmin','2016-12-01 15:27:47'),
('4028b88158bd92010158be031c820003','local','系统日志IP统计','SELECT logip as IP地址 , COUNT(*) AS 数量 FROM sys_log where type=1 GROUP BY logip',0,NULL,'superadmin','2016-12-02 13:30:24'),
('4028b88158c282ad0158c28c61550001','local','系统日访问量','SELECT t AS \'日期\', c AS \'访问数\' FROM (SELECT LEFT(logtime, 10) AS t, COUNT(*) AS c FROM sys_log GROUP BY LEFT(logtime, 10) ORDER BY logtime DESC LIMIT 0, 7) AS a ORDER BY a.t ASC',0,NULL,'superadmin','2016-12-03 10:38:49'),
('4028b88158c394ca0158c3bcb0180024','local','气泡图测试数据源','select * from bi_test2',0,NULL,'superadmin','2016-12-03 16:11:12'),
('4028b8815977f53a01597805e6290001','local','统计表','select * from bi_test4',0,NULL,'superadmin','2017-01-07 16:22:49'),
('4028b88159b5499f0159b54be5230001','4028b88159b0b8760159b0c78bb40003','外部数据源-A','SELECT * FROM activity_cutting_detail',0,NULL,'superadmin','2017-01-19 13:56:06'),
('4028b88159bb1f7c0159bb2eec570005','local','虚拟数据源-DEMO1','select * from {0} as t1\nleft join {1} as t2 on t1.id = t2.x',1,'4028b88158af03570158af6adbf80011,4028b88158c394ca0158c3bcb0180024','superadmin','2017-01-20 17:22:10');

/*Table structure for table `bi_datasource_meta` */

DROP TABLE IF EXISTS `bi_datasource_meta`;

CREATE TABLE `bi_datasource_meta` (
  `id` varchar(32) NOT NULL,
  `dsId` varchar(32) NOT NULL COMMENT '资源ID',
  `name` varchar(50) NOT NULL COMMENT '字段名',
  `label` varchar(50) NOT NULL COMMENT '字段描述',
  `type` varchar(50) NOT NULL COMMENT '字段类型',
  PRIMARY KEY (`id`),
  KEY `FK_bi_datasource$bi_datasource_meta` (`dsId`),
  CONSTRAINT `FK_bi_datasource$bi_datasource_meta` FOREIGN KEY (`dsId`) REFERENCES `bi_datasource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_datasource_meta` */

insert  into `bi_datasource_meta`(`id`,`dsId`,`name`,`label`,`type`) values 
('4028b881590192ea01590193616a0001','4028b88158af03570158af47b68e000b','id','id','java.lang.Integer'),
('4028b881590192ea01590193616a0002','4028b88158af03570158af47b68e000b','name','name','java.lang.String'),
('4028b881590192ea01590193616a0003','4028b88158af03570158af47b68e000b','sex','sex','java.lang.String'),
('4028b8815945c4f9015945da425b0001','4028b88158af03570158af6adbf80011','id','id','java.lang.Integer'),
('4028b8815945c4f9015945da425c0002','4028b88158af03570158af6adbf80011','name','name','java.lang.String'),
('4028b8815945c4f9015945da425c0003','4028b88158af03570158af6adbf80011','sex','sex','java.lang.String'),
('4028b8815945c4f9015945dc1a2e0004','4028b88158b8da450158b94836200009','manipulatename','系统模块','java.lang.String'),
('4028b8815945c4f9015945dc1a2e0005','4028b88158b8da450158b94836200009','访问数量','访问数量','java.lang.Long'),
('4028b88159780b930159780df39e0002','4028b8815977f53a01597805e6290001','id','id','java.lang.Integer'),
('4028b88159780b930159780df39e0003','4028b8815977f53a01597805e6290001','day','day','java.sql.Date'),
('4028b88159780b930159780df39e0004','4028b8815977f53a01597805e6290001','c1_1','c1_1','java.lang.Integer'),
('4028b88159780b930159780df39e0005','4028b8815977f53a01597805e6290001','c1_2','c1_2','java.math.BigDecimal'),
('4028b88159780b930159780df39e0006','4028b8815977f53a01597805e6290001','c2_1','c2_1','java.lang.Integer'),
('4028b88159780b930159780df39e0007','4028b8815977f53a01597805e6290001','c2_2','c2_2','java.math.BigDecimal'),
('4028b88159780b930159780df39e0008','4028b8815977f53a01597805e6290001','c3_1','c3_1','java.lang.Integer'),
('4028b88159780b930159780df39e0009','4028b8815977f53a01597805e6290001','c3_2','c3_2','java.math.BigDecimal'),
('4028b88159780b930159780df39e000a','4028b8815977f53a01597805e6290001','c4_1','c4_1','java.lang.Integer'),
('4028b88159780b930159780df3a0000b','4028b8815977f53a01597805e6290001','c4_2','c4_2','java.math.BigDecimal'),
('4028b88159780b930159780df3a0000c','4028b8815977f53a01597805e6290001','c5_1','c5_1','java.lang.Integer'),
('4028b88159780b930159780df3a0000d','4028b8815977f53a01597805e6290001','c5_2','c5_2','java.math.BigDecimal'),
('4028b88159b553ce0159b56653330002','4028b88159b5499f0159b54be5230001','id','id','java.lang.Long'),
('4028b88159b553ce0159b56653340003','4028b88159b5499f0159b54be5230001','merchant_id','merchant_id','java.lang.Long'),
('4028b88159b553ce0159b56653340004','4028b88159b5499f0159b54be5230001','poritl','poritl','java.lang.String'),
('4028b88159b553ce0159b56653340005','4028b88159b5499f0159b54be5230001','name','name','java.lang.String'),
('4028b88159b553ce0159b56653340006','4028b88159b5499f0159b54be5230001','join_time','join_time','java.sql.Timestamp'),
('4028b88159b553ce0159b56653340007','4028b88159b5499f0159b54be5230001','label_key','label_key','java.lang.String'),
('4028b88159b553ce0159b56653340008','4028b88159b5499f0159b54be5230001','label','label','java.lang.String'),
('4028b88159b553ce0159b56653340009','4028b88159b5499f0159b54be5230001','type','type','java.lang.Integer'),
('4028b88159b553ce0159b5665334000a','4028b88159b5499f0159b54be5230001','price','price','java.math.BigDecimal'),
('4028b88159b553ce0159b5665334000b','4028b88159b5499f0159b54be5230001','out_trade_no','out_trade_no','java.lang.String'),
('4028b88159b553ce0159b5665334000c','4028b88159b5499f0159b54be5230001','demand','demand','java.lang.String'),
('4028b88159b553ce0159b5665335000d','4028b88159b5499f0159b54be5230001','transaction_id','transaction_id','java.lang.String'),
('4028b88159b553ce0159b5665335000e','4028b88159b5499f0159b54be5230001','openId','openId','java.lang.String'),
('4028b88159baf41f0159bb09b6340001','4028b88158bd92010158be031c820003','logip','IP地址','java.lang.String'),
('4028b88159baf41f0159bb09b6340002','4028b88158bd92010158be031c820003','数量','数量','java.lang.Long'),
('4028b88159baf41f0159bb1065930003','4028b88158c394ca0158c3bcb0180024','x','x','java.lang.Integer'),
('4028b88159baf41f0159bb1065930004','4028b88158c394ca0158c3bcb0180024','y','y','java.lang.Integer'),
('4028b88159baf41f0159bb1065930005','4028b88158c394ca0158c3bcb0180024','r','r','java.lang.Integer');

/*Table structure for table `bi_datasource_params` */

DROP TABLE IF EXISTS `bi_datasource_params`;

CREATE TABLE `bi_datasource_params` (
  `id` varchar(50) NOT NULL,
  `dsId` varchar(50) NOT NULL COMMENT '数据源',
  `field` varchar(50) NOT NULL COMMENT '字段',
  `defaultValue` varchar(255) DEFAULT NULL COMMENT '映射关系',
  PRIMARY KEY (`id`),
  KEY `FK_DS_MP_DS` (`dsId`),
  CONSTRAINT `FK_DS_MP_DS` FOREIGN KEY (`dsId`) REFERENCES `bi_datasource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_datasource_params` */

insert  into `bi_datasource_params`(`id`,`dsId`,`field`,`defaultValue`) values 
('4028b88158af03570158af47b68f000c','4028b88158af03570158af47b68e000b','姓名','A');

/*Table structure for table `bi_flow` */

DROP TABLE IF EXISTS `bi_flow`;

CREATE TABLE `bi_flow` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `content` text,
  `deployId` varchar(50) DEFAULT NULL,
  `version` varchar(2) DEFAULT NULL,
  `createUser` varchar(20) NOT NULL,
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_flow` */

/*Table structure for table `bi_form` */

DROP TABLE IF EXISTS `bi_form`;

CREATE TABLE `bi_form` (
  `id` varchar(50) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '表单名称',
  `tip` varchar(100) DEFAULT NULL COMMENT '表单完成提示',
  `primaryTable` varchar(50) DEFAULT NULL COMMENT '主表',
  `tableName` varchar(200) DEFAULT NULL COMMENT '对应生成的表名',
  `source` text COMMENT 'html源码，用于后期编辑',
  `content` text COMMENT '生成后的form表单内容',
  `version` varchar(20) DEFAULT NULL COMMENT '版本',
  `createUser` varchar(50) DEFAULT NULL,
  `createTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_form` */

insert  into `bi_form`(`id`,`name`,`tip`,`primaryTable`,`tableName`,`source`,`content`,`version`,`createUser`,`createTime`) values 
('297eb7974e044455014e046e5dc10005','人员信息',NULL,'bi_form_parent','bi_form_parent,bi_form_children','<div class=\"containers fd-view-drag-in\"><div id=\"v_formtitle\" fd-view=\"formtitle\" class=\"bb h4 pb5\" style=\"text-align: center;\">人员信息</div>\n<table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n    <tbody>\n        <tr>\n            <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\">\n                <table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" class=\"move\">\n                    <tbody>\n                        <tr>\n                            <td fd-view=\"table_td\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">　姓名1：</span>\n\n                            </td>\n                            <td fd-view=\"table_td\">\n                                <input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"name\" rules=\"chinese\" required=\"required\" id=\"\" placeholder=\"必须是中文\">\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </td>\n            <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\">\n                <table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" class=\"move\">\n                    <tbody>\n                        <tr>\n                            <td fd-view=\"table_td\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\" style=\"\">　　 年龄：</span>\n\n                            </td>\n                            <td fd-view=\"table_td\">\n                                <input type=\"text\" class=\"form-control\" fd-view=\"input\" rules=\"number2\" field=\"age\" required=\"required\" placeholder=\"必须是整数\">\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </td>\n            <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\">\n                \n            </td>\n        </tr>\n        <tr>\n            <td fd-view=\"table_td \" class=\"fd-view-drag-in\" style=\"width:25%; \">\n                <table fd-move=\" \" fd-view=\"label_input \" id=\"v_label_input \" class=\"move\">\n                    <tbody>\n                        <tr>\n                            <td fd-view=\"table_td\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">手机号：</span>\n\n                            </td>\n                            <td fd-view=\"table_td\">\n                                <input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"mobile\" required=\"required\" rules=\"mobile\" placeholder=\"11位手机号\">\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </td>\n            <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%; \" colspan=\"2\"><span contenteditable=\"true\" fd-view=\"label\" id=\"v_label\" class=\"\">出生日期：</span>\n\n                <input type=\"text\" class=\"form-control datepicker inline\" fd-view=\"datepicker\" id=\"v_datepicker\" style=\"width:250px\" data-date-format=\"yyyy年mm月dd日\" field=\"birthday\" required=\"required\" placeholder=\"yyyy年mm月dd日\">\n            </td>\n        </tr>\n        <tr>\n            <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%; \" colspan=\"3 \">\n                <table fd-move=\" \" fd-view=\"label_textarea\" id=\"v_label_textarea \" width=\"100% \" class=\"move\" style=\"text-align: left;\">\n                    <tbody>\n                        <tr>\n                            <td fd-view=\"table_td\" style=\"min-width: 5%; width: 50px;\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">住址：</span>\n\n                            </td>\n                            <td fd-view=\"table_td\">\n                                <textarea class=\"form-control\" fd-view=\"textarea\" style=\"width: 100%; margin-top: 0px; margin-bottom: 0px; height: 54px;\" field=\"address\" placeholder=\"现居地址\"></textarea>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </td>\n        </tr><tr>\n            <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%; \" colspan=\"3 \"><table fd-move=\"\" fd-view=\"label_textarea\" id=\"v_label_textarea\" class=\"move\">\n                    <tbody>\n                        <tr>\n                            <td fd-view=\"table_td\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">性别：</span>\n\n                            </td>\n                            <td fd-view=\"table_td\">\n                                <select class=\"form-control\" fd-view=\"select\" field=\"sex\">\n                                    <option value=\"男 \" selected=\"selected \">男</option>\n                                    <option value=\"女 \">女</option>\n                                </select>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table></td>\n        </tr>\n    </tbody>\n</table>\n<div class=\"row\" contenteditable=\"true\" fd-view=\"dynamicPanel\" id=\"v_cynamicPanel\" css_align=\"\" \":\"left=\"\" \"}\"=\"\" style=\"text-align: left;\">\n    <div class=\"p10\">\n        <div id=\"header\" class=\"bordered\">其他信息\n            <div class=\"pull-right\"><a href=\"javascript:;\" id=\"handler\" style=\"cursor: pointer;\"><i class=\"ti-plus\"></i> 添加</a>\n            </div>\n        </div>\n        <div id=\"content\" class=\"bl br bb p10\">\n            <div class=\"item mb5\">\n                <table style=\"width:100%\">\n                    <tbody>\n                        <tr>\n                            <td style=\"width:99%\">\n                                <div class=\"fd-view-drag-in\">\n                                    <table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\" class=\"move\">\n                                        <tbody>\n                                            <tr>\n                                                <td fd-view=\"table_td\"></td>\n                                                <td fd-view=\"table_td\"></td>\n                                                <td fd-view=\"table_td\"></td>\n                                            </tr>\n                                        </tbody>\n                                    </table>\n                                    <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\" style=\"width:100%\" \":\"width:100%=\"\" \"}\"=\"\">\n                                        <tbody>\n                                            <tr>\n                                                <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:50%\" \":\"width:50%=\"\" \",\"css_padding=\"\" \":\"8px=\"\" \"}\"=\"\">\n                                                    <table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\" class=\"move\">\n                                                        <tbody>\n                                                            <tr>\n                                                                <td fd-view=\"table_td\" style=\"min-width: 5%; width: 60px;\" class=\"\" css_width=\"\" \":\"60px=\"\" \"}\"=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\" css_width=\"\" \":\"60px=\"\" \"}\"=\"\" style=\"width: 60px;\">联系人：</span>\n                                                                </td>\n                                                                <td fd-view=\"table_td\">\n                                                                    <input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"wf_form_children.data_0\" \":\"wf_form_children.data_0=\"\" \",\"required=\"\" \":\"true=\"\" \",\"rules=\"\" \":[\"chinese=\"\" \"]}\"=\"\" required=\"required\" rules=\"chinese\">\n                                                                </td>\n                                                            </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                                <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:50%\" \":\"width:50%=\"\" \"}\"=\"\">\n                                                    <table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\" class=\"move\">\n                                                        <tbody>\n                                                            <tr>\n                                                                <td fd-view=\"table_td\" style=\"min-width: 5%; width: 60px;\" class=\"\" css_width=\"\" \":\"60px=\"\" \"}\"=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">电话：</span>\n                                                                </td>\n                                                                <td fd-view=\"table_td\">\n                                                                    <input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"wf_form_children.data_1\" \":\"wf_form_children.data_1=\"\" \",\"required=\"\" \":\"true=\"\" \",\"rules=\"\" \":[\"mobile=\"\" \"]}\"=\"\" required=\"required\" rules=\"mobile\">\n                                                                </td>\n                                                                <td fd-view=\"table_td\"></td>\n                                                            </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                        </tbody>\n                                    </table>\n                                </div>\n                            </td>\n                            <td>	<a id=\"closer\" class=\"hide\" style=\"cursor: pointer;\"><i class=\"ti-close\"></i> </a>\n\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n    </div>\n</div>\n<button type=\"submit\" class=\"btn btn-default btn-block\" fd-view=\"submit\" id=\"v_submit\" style=\"margin: 10px;\">立即保存</button></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\" />\n <div class=\"containers fd-view-drag-in\">\n  <div id=\"v_formtitle\" fd-view=\"formtitle\" class=\"bb h4 pb5\" style=\"text-align: center;\">\n   人员信息\n  </div> \n  <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n   <tbody> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"> \n      <table fd-view=\"label_input\" id=\"v_label_input\" class=\"move\"> \n       <tbody> \n        <tr> \n         <td fd-view=\"table_td\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">　姓名1：</span> </td> \n         <td fd-view=\"table_td\"> <input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"name\" rules=\"chinese\" required=\"required\" id=\"\" placeholder=\"必须是中文\" /> </td> \n        </tr> \n       </tbody> \n      </table> </td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"> \n      <table fd-view=\"label_input\" id=\"v_label_input\" class=\"move\"> \n       <tbody> \n        <tr> \n         <td fd-view=\"table_td\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\" style=\"\">　　 年龄：</span> </td> \n         <td fd-view=\"table_td\"> <input type=\"text\" class=\"form-control\" fd-view=\"input\" rules=\"number2\" name=\"age\" required=\"required\" placeholder=\"必须是整数\" /> </td> \n        </tr> \n       </tbody> \n      </table> </td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"> </td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td \" class=\"fd-view-drag-in\" style=\"width:25%; \"> \n      <table fd-view=\"label_input \" id=\"v_label_input \" class=\"move\"> \n       <tbody> \n        <tr> \n         <td fd-view=\"table_td\"><span fd-view=\"label\" fd-label=\"\" class=\"\">手机号：</span> </td> \n         <td fd-view=\"table_td\"> <input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"mobile\" required=\"required\" rules=\"mobile\" placeholder=\"11位手机号\" /> </td> \n        </tr> \n       </tbody> \n      </table> </td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%; \" colspan=\"2\"><span fd-view=\"label\" id=\"v_label\" class=\"\">出生日期：</span> <input type=\"text\" class=\"form-control datepicker inline\" fd-view=\"datepicker\" id=\"v_datepicker\" style=\"width:250px\" data-date-format=\"yyyy年mm月dd日\" name=\"birthday\" required=\"required\" placeholder=\"yyyy年mm月dd日\" /> </td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%; \" colspan=\"3 \"> \n      <table fd-view=\"label_textarea\" id=\"v_label_textarea \" width=\"100% \" class=\"move\" style=\"text-align: left;\"> \n       <tbody> \n        <tr> \n         <td fd-view=\"table_td\" style=\"min-width: 5%; width: 50px;\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">住址：</span> </td> \n         <td fd-view=\"table_td\"> <textarea class=\"form-control\" fd-view=\"textarea\" style=\"width: 100%; margin-top: 0px; margin-bottom: 0px; height: 54px;\" name=\"address\" placeholder=\"现居地址\"></textarea> </td> \n        </tr> \n       </tbody> \n      </table> </td> \n    </tr>\n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%; \" colspan=\"3 \">\n      <table fd-view=\"label_textarea\" id=\"v_label_textarea\" class=\"move\"> \n       <tbody> \n        <tr> \n         <td fd-view=\"table_td\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">性别：</span> </td> \n         <td fd-view=\"table_td\"> <select class=\"form-control\" fd-view=\"select\" name=\"sex\"> <option value=\"男 \" selected=\"selected \">男</option> <option value=\"女 \">女</option> </select> </td> \n        </tr> \n       </tbody> \n      </table></td> \n    </tr> \n   </tbody> \n  </table> \n  <div class=\"row\" fd-view=\"dynamicPanel\" id=\"v_cynamicPanel\" css_align=\"\" \":\"left=\"\" \"}\"=\"\" style=\"text-align: left;\"> \n   <div class=\"p10\"> \n    <div id=\"header\" class=\"bordered\">\n     其他信息 \n     <div class=\"pull-right\">\n      <a href=\"javascript:;\" id=\"handler\" style=\"cursor: pointer;\"><i class=\"ti-plus\"></i> 添加</a> \n     </div> \n    </div> \n    <div id=\"content\" class=\"bl br bb p10\"> \n     <div class=\"item mb5\"> \n      <table style=\"width:100%\"> \n       <tbody> \n        <tr> \n         <td style=\"width:99%\"> \n          <div class=\"fd-view-drag-in\"> \n           <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\" class=\"move\"> \n            <tbody> \n             <tr> \n              <td fd-view=\"table_td\"></td> \n              <td fd-view=\"table_td\"></td> \n              <td fd-view=\"table_td\"></td> \n             </tr> \n            </tbody> \n           </table> \n           <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\" style=\"width:100%\" \":\"width:100%=\"\" \"}\"=\"\"> \n            <tbody> \n             <tr> \n              <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:50%\" \":\"width:50%=\"\" \",\"css_padding=\"\" \":\"8px=\"\" \"}\"=\"\"> \n               <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\" class=\"move\"> \n                <tbody> \n                 <tr> \n                  <td fd-view=\"table_td\" style=\"min-width: 5%; width: 60px;\" class=\"\" css_width=\"\" \":\"60px=\"\" \"}\"=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\" css_width=\"\" \":\"60px=\"\" \"}\"=\"\" style=\"width: 60px;\">联系人：</span> </td> \n                  <td fd-view=\"table_td\"> <input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"wf_form_children.data_0\" \":\"wf_form_children.data_0=\"\" \",\"required=\"\" \":\"true=\"\" \",\"rules=\"\" \":[\"chinese=\"\" \"]}\"=\"\" required=\"required\" rules=\"chinese\" /> </td> \n                 </tr> \n                </tbody> \n               </table> </td> \n              <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:50%\" \":\"width:50%=\"\" \"}\"=\"\"> \n               <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\" class=\"move\"> \n                <tbody> \n                 <tr> \n                  <td fd-view=\"table_td\" style=\"min-width: 5%; width: 60px;\" class=\"\" css_width=\"\" \":\"60px=\"\" \"}\"=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">电话：</span> </td> \n                  <td fd-view=\"table_td\"> <input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"wf_form_children.data_1\" \":\"wf_form_children.data_1=\"\" \",\"required=\"\" \":\"true=\"\" \",\"rules=\"\" \":[\"mobile=\"\" \"]}\"=\"\" required=\"required\" rules=\"mobile\" /> </td> \n                  <td fd-view=\"table_td\"></td> \n                 </tr> \n                </tbody> \n               </table> </td> \n             </tr> \n            </tbody> \n           </table> \n          </div> </td> \n         <td> <a id=\"closer\" class=\"hide\" style=\"cursor: pointer;\"><i class=\"ti-close\"></i> </a> </td> \n        </tr> \n       </tbody> \n      </table> \n     </div> \n    </div> \n   </div> \n  </div> \n  <button type=\"submit\" class=\"btn btn-default btn-block\" fd-view=\"submit\" id=\"v_submit\" style=\"margin: 10px;\">立即保存</button>\n </div>\n</form>','2.0','superadmin','2015-06-19 15:47:45'),
('402838814ae76a71014ae76ad2fd0000','请假单','您的请假申请已经提交，请等待相关负责人审批！','bi_form_parent','bi_form_parent','<div class=\"design design-item\" tip=\"您的请假申请已经提交，请等待相关负责人审批！\"> \n <center> \n  <h4 class=\"bb\" id=\"formTitle\" t=\"label\" name=\"data_0\">请假单</h4> \n </center> \n <table class=\"table table-bordered no-m\" contenteditable=\"true\" t=\"table\"> \n  <tbody> \n   <tr> \n    <td class=\"design-item\" style=\"text-align: right;\">请假人</td> \n    <td class=\"design-item\"> <span class=\"disabled\" t=\"macros\" data-element=\"\" name=\"data_0\" macrostype=\"user_realname\">{宏控件}</span> </td> \n    <td class=\"design-item\">所在部门</td> \n    <td class=\"design-item\"> <span class=\"disabled\" t=\"macros\" data-element=\"\" name=\"data_1\" macrostype=\"user_unitname\">{宏控件}</span> </td> \n   </tr> \n   <tr> \n    <td class=\"design-item\">请假原因</td> \n    <td class=\"design-item\" colspan=\"3\"> <textarea name=\"data_2\" class=\"form-control\" placeholder=\"请输入请假原因...\" t=\"textarea\" data-element=\"\" data-required=\"true\">请输入请假原因...</textarea> </td> \n   </tr> \n   <tr> \n    <td class=\"design-item\">事项类型</td> \n    <td class=\"design-item\"> <select name=\"data_3\" class=\"form-control\" t=\"select\" data-element=\"\"> <option value=\"1\">事假</option> <option value=\"2\">病假</option> <option value=\"3\">带薪休假</option> </select> </td> \n    <td class=\"design-item\">请假时间</td> \n    <td class=\"design-item\"><span class=\"disabled\" t=\"macros\" data-element=\"\" name=\"data_4\" macrostype=\"dt_yyyy-MM-dd HH:mm:ss\">{宏控件}</span> </td> \n   </tr> \n   <tr> \n    <td class=\"design-item\" style=\"width: 196px;\"></td> \n    <td class=\"design-item selected\" colspan=\"3\"> <button class=\"btn btn-default btn-block\" type=\"submit\" t=\"button\">提 交</button> </td> \n   </tr> \n  </tbody> \n </table> \n</div>','<form action=\"#formAction\" method=\"post\" onsubmit=\"return _form_submit(this);\">\n <input type=\"hidden\" name=\"_formId\" value=\"402838814ae76a71014ae76ad2fd0000\" />\n <div class=\" \" tip=\"您的请假申请已经提交，请等待相关负责人审批！\"> \n  <center> \n   <h4 class=\"bb\" id=\"formTitle\" t=\"label\" name=\"data_0\">请假单</h4> \n  </center> \n  <table class=\"table table-bordered no-m\" t=\"table\"> \n   <tbody> \n    <tr> \n     <td style=\"text-align: right;\">请假人</td> \n     <td> <span name=\"data_0\">#user_realname#</span> </td> \n     <td>所在部门</td> \n     <td> <span name=\"data_1\">#user_unitname#</span> </td> \n    </tr> \n    <tr> \n     <td>请假原因</td> \n     <td colspan=\"3\"> <textarea name=\"data_2\" class=\"form-control\" placeholder=\"请输入请假原因...\" data-required=\"true\">请输入请假原因...</textarea> </td> \n    </tr> \n    <tr> \n     <td>事项类型</td> \n     <td> <select name=\"data_3\" class=\"form-control\"> <option value=\"1\">事假</option> <option value=\"2\">病假</option> <option value=\"3\">带薪休假</option> </select> </td> \n     <td>请假时间</td> \n     <td><span name=\"data_4\">#dt_yyyy-MM-dd HH:mm:ss#</span> </td> \n    </tr> \n    <tr> \n     <td style=\"width: 196px;\"></td> \n     <td class=\" \" colspan=\"3\"> <button class=\"btn btn-default btn-block\" type=\"submit\" t=\"button\">提 交</button> </td> \n    </tr> \n   </tbody> \n  </table> \n </div>\n</form>','1.0',NULL,'2015-01-15 16:36:35'),
('402881ee54a29b8b0154a2c6cc1b000b','测试表单1',NULL,'bi_test1','bi_test1','<div class=\"containers fd-view-drag-in\"><div id=\"v_formtitle\" fd-view=\"formtitle\" class=\"bb h4\" style=\"text-align: center;\">表单A</div><div class=\"row\" contenteditable=\"true\" fd-view=\"col12\" id=\"v_col12\" style=\"padding: 0px 0px 5px;\">\n													<div class=\"col-md-12 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\">姓名：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"name\" required=\"required\" rules=\"none\"></td>\n													</tr>\n												</tbody></table></div>\n												</div><div class=\"row\" contenteditable=\"true\" fd-view=\"col12\" id=\"v_col12\">\n													<div class=\"col-md-12 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_textarea\" id=\"v_label_textarea\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">性别：</span></td>\n														<td fd-view=\"table_td\"><select class=\"form-control\" fd-view=\"select\" \"=\"\" field=\"sex\"><option value=\"男\" selected=\"selected\">男</option><option value=\"女\">女</option></select></td>\n													</tr>\n												</tbody></table></div>\n												</div></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\">\n  <div id=\"v_formtitle\" fd-view=\"formtitle\" class=\"bb h4\" style=\"text-align: center;\">\n   表单A\n  </div>\n  <div class=\"row\" fd-view=\"col12\" id=\"v_col12\" style=\"padding: 0px 0px 5px;\"> \n   <div class=\"col-md-12 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span fd-view=\"label\" fd-label=\"\">姓名：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"name\" required rules=\"none\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n  <div class=\"row\" fd-view=\"col12\" id=\"v_col12\"> \n   <div class=\"col-md-12 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_textarea\" id=\"v_label_textarea\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">性别：</span></td> \n       <td fd-view=\"table_td\"><select class=\"form-control\" fd-view=\"select\" \"=\"\" name=\"sex\"><option value=\"男\" selected>男</option><option value=\"女\">女</option></select></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n </div>\n</form>','2.0','superadmin','2016-05-12 10:40:38'),
('4028b88158cd06060158cdb1a444001d','气泡数据录入',NULL,'bi_test2','bi_test2','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\"><h4 fd-view=\"formtitle\" class=\"\" style=\"text-align: center;\">气泡图数据录入</h4></div><div class=\"row\" contenteditable=\"true\" fd-view=\"col444\" id=\"v_col444\">\n													<div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"></div>\n													<div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">X：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"x\" required=\"required\" rules=\"integer\"></td>\n													</tr>\n												</tbody></table><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">Y：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"y\" required=\"required\" rules=\"integer\"></td>\n													</tr>\n												</tbody></table><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">R：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"r\" required=\"required\" rules=\"integer\"></td>\n													</tr>\n												</tbody></table></div>\n													<div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"></div>\n												</div></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\">\n   <h4 fd-view=\"formtitle\" class=\"\" style=\"text-align: center;\">气泡图数据录入</h4>\n  </div>\n  <div class=\"row\" fd-view=\"col444\" id=\"v_col444\"> \n   <div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"></div> \n   <div class=\"col-md-4 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span fd-view=\"label\" fd-label=\"\" class=\"\">X：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"x\" required rules=\"integer\"></td> \n      </tr> \n     </tbody>\n    </table>\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span fd-view=\"label\" fd-label=\"\" class=\"\">Y：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"y\" required rules=\"integer\"></td> \n      </tr> \n     </tbody>\n    </table>\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span fd-view=\"label\" fd-label=\"\" class=\"\">R：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"r\" required rules=\"integer\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n   <div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"></div> \n  </div>\n </div>\n</form>','2.0','superadmin','2016-12-05 14:35:23');

/*Table structure for table `bi_form_children` */

DROP TABLE IF EXISTS `bi_form_children`;

CREATE TABLE `bi_form_children` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT NULL COMMENT '外键ID',
  `data_0` varchar(50) DEFAULT NULL COMMENT '姓名',
  `data_1` varchar(50) DEFAULT NULL COMMENT '电话',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='人员信息 - 子表';

/*Data for the table `bi_form_children` */

insert  into `bi_form_children`(`id`,`fid`,`data_0`,`data_1`) values 
(12,18,'李四','18955185893'),
(13,18,'王五','15655157817'),
(14,18,'赵六','15655157817');

/*Table structure for table `bi_form_parent_ext` */

DROP TABLE IF EXISTS `bi_form_parent_ext`;

CREATE TABLE `bi_form_parent_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `columnType` varchar(100) NOT NULL COMMENT '字段类型',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `comments` varchar(500) DEFAULT NULL COMMENT '字段描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `bi_form_parent_ext` */

insert  into `bi_form_parent_ext`(`id`,`columnType`,`columnName`,`comments`) values 
(3,'varchar','ext1','扩展1'),
(5,'varchar','ext3','扩展3');

/*Table structure for table `bi_form_parent_ext_val` */

DROP TABLE IF EXISTS `bi_form_parent_ext_val`;

CREATE TABLE `bi_form_parent_ext_val` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '主表数据ID',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `columnVal` varchar(1000) DEFAULT NULL COMMENT '扩展字段值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_form_parent_ext_val` */

/*Table structure for table `bi_report` */

DROP TABLE IF EXISTS `bi_report`;

CREATE TABLE `bi_report` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '报表名称',
  `descript` varchar(200) DEFAULT NULL COMMENT '描述',
  `source` text COMMENT '源码',
  `content` text COMMENT '生成代码',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` varchar(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_report` */

insert  into `bi_report`(`id`,`name`,`descript`,`source`,`content`,`createUser`,`createTime`) values 
('40289f395935cd44015935d7886b0002','报表1','测试用','<table id=\"40289f395935cd44015935d7886b0002\" class=\"table table-bordered\" contenteditable=\"true\">\n                                                                                        <tbody><tr>\n                                                                                                <td class=\"rownum\" style=\"text-align: center;\" contenteditable=\"false\"></td>\n                                                                                                <td class=\"colnum\" style=\"text-align: center; cursor: col-resize;\" contenteditable=\"false\" width=\"284\">A</td>\n                                                                                                <td class=\"colnum\" style=\"text-align: center; cursor: default;\" contenteditable=\"false\">B</td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td class=\"rownum\" ds=\"4028b88158af03570158af47b68e000b\" code=\"id\" arrow=\"down\" contenteditable=\"false\">1</td>\n                                                                                                <td class=\"\" ds=\"4028b88158af03570158af47b68e000b\" code=\"name\" arrow=\"down\" width=\"284\" data-binder=\"true\" condition-symbo=\"<\" condition-value=\"60\" condition-type=\"backgroundColor\">#name-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b88158af03570158af47b68e000b\" code=\"sex\" arrow=\"down\" data-binder=\"true\">#sex-&gt;down#</td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td contenteditable=\"false\" class=\"rownum\">2</td>\n                                                                                                <td class=\"\" style=\"background-color: rgb(255, 255, 255);\" width=\"284\"><br></td>\n                                                                                                <td class=\"\"><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td contenteditable=\"false\" class=\"rownum\">3</td>\n                                                                                                <td width=\"284\"><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                    </tbody></table>','<table id=\"40289f395935cd44015935d7886b0002\" class=\"table table-bordered\">\n                                                                                        <tbody>\n                                                                                        <tr>\n                                                                                                \n                                                                                                <td ds=\"4028b88158af03570158af47b68e000b\" code=\"name\" arrow=\"down\" width=\"284\" data-binder=\"true\" condition-symbo=\"<\" condition-value=\"60\" condition-type=\"backgroundColor\"><br></td>\n                                                                                                <td ds=\"4028b88158af03570158af47b68e000b\" code=\"sex\" arrow=\"down\" data-binder=\"true\"><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                \n                                                                                                <td style=\"background-color: rgb(255, 255, 255);\" width=\"284\"><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                \n                                                                                                <td width=\"284\"><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                    </tbody></table>','超级管理员','2016-12-25 19:57:14'),
('4028b88159780b930159780c7ae30001','统计表-测试1','用于测试统计功能：合计，平均数等','<table id=\"4028b88159780b930159780c7ae30001\" class=\"table table-bordered\" contenteditable=\"true\">\n                                                                                        <tbody><tr><td contenteditable=\"false\" class=\"rownum\"><br></td><td class=\"colnum\" contenteditable=\"false\">A</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">B</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: col-resize;\">C</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">D</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">E</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: col-resize;\">F</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">G</td><td contenteditable=\"false\" class=\"colnum\">H</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">I</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">J</td><td contenteditable=\"false\" class=\"colnum\" style=\"cursor: default;\">K</td></tr><tr>\n                                                                                                <td contenteditable=\"false\" class=\"rownum\">1</td><td class=\"\" style=\"text-align: center;\"><b>日期</b></td><td class=\"\" style=\"text-align: left;\"><b>数据1-1</b></td>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>数据1-2</b></td>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>数据2-1</b></td>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>数据2-2</b></td><td class=\"\" style=\"text-align: left;\"><b>数据3-1</b></td><td class=\"\" style=\"text-align: left;\"><b>数据3-2</b></td><td class=\"\" style=\"text-align: left;\"><b>数据4-1</b></td><td class=\"\" style=\"text-align: left;\"><b>数据4-2</b></td><td class=\"\" style=\"text-align: left;\"><b>数据5-1</b></td><td class=\"\" style=\"text-align: left;\"><b>数据5-2</b></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td contenteditable=\"false\" class=\"rownum\">2</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"day\" arrow=\"down\" data-binder=\"true\" style=\"text-align: center; font-weight: bold; font-style: normal; font-size: 13px;\">#day-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_1\" arrow=\"down\" data-binder=\"true\" condition-symbo=\">\" condition-value=\"60\" condition-type=\"color\" condition-color=\"#00FF00\" condition-target=\"cell\">#c1_1-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_2\" arrow=\"down\" data-binder=\"true\" condition-symbo=\"<\" condition-value=\"1000\" condition-type=\"backgroundColor\" condition-color=\"#FF0000\" condition-target=\"row\">#c1_2-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_1\" arrow=\"down\" data-binder=\"true\" condition-symbo=\"==\" condition-value=\"0\" condition-type=\"borderColor\" condition-color=\"#FFFF00\" condition-target=\"cell\">#c2_1-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_2\" arrow=\"down\" data-binder=\"true\">#c2_2-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_1\" arrow=\"down\" data-binder=\"true\">#c3_1-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_2\" arrow=\"down\" data-binder=\"true\">#c3_2-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_1\" arrow=\"down\" data-binder=\"true\">#c4_1-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_2\" arrow=\"down\" data-binder=\"true\">#c4_2-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\">#c5_1-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\">#c5_1-&gt;down#</td>\n                                                                                            </tr>\n                                                                                        \n                                                                                        <tr>\n                                                                                                <td contenteditable=\"false\" class=\"rownum\">3</td><td class=\"\" style=\"text-align: center; font-weight: bold;\">合计：</td><td class=\"formula\" formula=\"max(B2,B3)\" style=\"font-weight: bold;\"></td>\n                                                                                                <td class=\"formula\" formula=\"avg(C2+)\" precision=\"2\"></td>\n                                                                                                <td class=\"formula\" formula=\"count(D2+)\" precision=\"2\"></td>\n                                                                                                <td class=\"\" formula=\"\"></td><td class=\"\" formula=\"\"></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td>\n                                                                                            </tr>\n                                                                                    </tbody></table>','<table id=\"4028b88159780b930159780c7ae30001\" class=\"table table-bordered\">\n                                                                                        <tbody><tr>\n                                                                                                <td style=\"text-align: center;\"><b>日期</b></td><td style=\"text-align: left;\"><b>数据1-1</b></td>\n                                                                                                <td style=\"text-align: left;\"><b>数据1-2</b></td>\n                                                                                                <td style=\"text-align: left;\"><b>数据2-1</b></td>\n                                                                                                <td style=\"text-align: left;\"><b>数据2-2</b></td><td style=\"text-align: left;\"><b>数据3-1</b></td><td style=\"text-align: left;\"><b>数据3-2</b></td><td style=\"text-align: left;\"><b>数据4-1</b></td><td style=\"text-align: left;\"><b>数据4-2</b></td><td style=\"text-align: left;\"><b>数据5-1</b></td><td style=\"text-align: left;\"><b>数据5-2</b></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"day\" arrow=\"down\" data-binder=\"true\" style=\"text-align: center; font-weight: bold; font-style: normal; font-size: 13px;\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_1\" arrow=\"down\" data-binder=\"true\" condition-symbo=\">\" condition-value=\"60\" condition-type=\"color\" condition-color=\"#00FF00\" condition-target=\"cell\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_2\" arrow=\"down\" data-binder=\"true\" condition-symbo=\"<\" condition-value=\"1000\" condition-type=\"backgroundColor\" condition-color=\"#FF0000\" condition-target=\"row\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_1\" arrow=\"down\" data-binder=\"true\" condition-symbo=\"==\" condition-value=\"0\" condition-type=\"borderColor\" condition-color=\"#FFFF00\" condition-target=\"cell\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_2\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_1\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_2\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_1\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_2\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\"><br></td>\n                                                                                            </tr>\n                                                                                        \n                                                                                        <tr>\n                                                                                                <td style=\"text-align: center; font-weight: bold;\">合计：</td><td formula=\"max(B2,B3)\" style=\"font-weight: bold;\"></td>\n                                                                                                <td formula=\"avg(C2+)\" precision=\"2\"></td>\n                                                                                                <td formula=\"count(D2+)\" precision=\"2\"></td>\n                                                                                                <td formula=\"\"></td><td formula=\"\"></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td>\n                                                                                            </tr>\n                                                                                    </tbody></table>','超级管理员','2017-01-07 16:30:00');

/*Table structure for table `bi_report_data` */

DROP TABLE IF EXISTS `bi_report_data`;

CREATE TABLE `bi_report_data` (
  `id` varchar(32) NOT NULL,
  `reportId` varchar(32) NOT NULL COMMENT '报表ID',
  `dsId` varchar(32) NOT NULL COMMENT '数据源ID',
  PRIMARY KEY (`id`),
  KEY `FK_bi_report_data$bi_report` (`reportId`),
  KEY `FK_bi_report_data$bi_datasource` (`dsId`),
  CONSTRAINT `FK_bi_report_data$bi_datasource` FOREIGN KEY (`dsId`) REFERENCES `bi_datasource` (`id`),
  CONSTRAINT `FK_bi_report_data$bi_report` FOREIGN KEY (`reportId`) REFERENCES `bi_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_report_data` */

/*Table structure for table `bi_test1` */

DROP TABLE IF EXISTS `bi_test1`;

CREATE TABLE `bi_test1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `sex` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `bi_test1` */

insert  into `bi_test1`(`id`,`name`,`sex`) values 
(1,'A','男'),
(2,'A','女'),
(3,'张三','男'),
(4,'AAAA','男'),
(5,'Hello','男');

/*Table structure for table `bi_test2` */

DROP TABLE IF EXISTS `bi_test2`;

CREATE TABLE `bi_test2` (
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `r` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_test2` */

insert  into `bi_test2`(`x`,`y`,`r`) values 
(20,30,15),
(40,10,10),
(45,15,40),
(1,2,3),
(1,9,35);

/*Table structure for table `bi_test3` */

DROP TABLE IF EXISTS `bi_test3`;

CREATE TABLE `bi_test3` (
  `id` varchar(32) NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `pass_word` varchar(20) DEFAULT NULL,
  `link_url` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_test3` */

/*Table structure for table `bi_test4` */

DROP TABLE IF EXISTS `bi_test4`;

CREATE TABLE `bi_test4` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` date DEFAULT NULL,
  `c1_1` int(11) DEFAULT NULL,
  `c1_2` decimal(10,2) DEFAULT NULL,
  `c2_1` int(11) DEFAULT NULL,
  `c2_2` decimal(10,2) DEFAULT NULL,
  `c3_1` int(11) DEFAULT NULL,
  `c3_2` decimal(10,2) DEFAULT NULL,
  `c4_1` int(11) DEFAULT NULL,
  `c4_2` decimal(10,2) DEFAULT NULL,
  `c5_1` int(11) DEFAULT NULL,
  `c5_2` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `bi_test4` */

insert  into `bi_test4`(`id`,`day`,`c1_1`,`c1_2`,`c2_1`,`c2_2`,`c3_1`,`c3_2`,`c4_1`,`c4_2`,`c5_1`,`c5_2`) values 
(1,'2016-11-01',1631,47245.00,8,19.56,726,2140.00,1,0.01,0,0.00),
(2,'2016-11-02',990,25322.00,22,71.44,367,1680.00,0,0.00,0,0.00),
(3,'2016-11-03',202,7863.00,11,70.59,204,1710.00,0,0.00,362,755174.91),
(4,'2016-11-04',117,4213.00,20,143.31,123,1350.00,0,0.00,0,0.00),
(5,'2016-11-05',182,8736.00,29,220.87,0,0.00,0,0.00,0,0.00),
(6,'2016-11-06',77,4348.00,14,74.28,0,0.00,0,0.00,0,0.00),
(7,'2016-11-07',192,66476.00,10,18.95,150,1880.00,0,0.00,0,0.00),
(8,'2016-11-08',89,4726.10,9,27.09,107,1330.00,0,0.00,0,0.00),
(9,'2016-11-09',76,15801.00,14,40.45,61,720.00,0,0.00,0,0.00),
(10,'2016-11-10',71,3541.00,2,8.89,59,630.00,0,0.00,231,198366.19),
(11,'2016-11-11',51,3608.00,8,25.67,64,680.00,0,0.00,0,0.00),
(12,'2016-11-12',45,2670.03,6,9.80,0,0.00,0,0.00,0,0.00),
(13,'2016-11-13',70,0.60,9,35.33,0,0.00,0,0.00,0,0.00),
(14,'2016-11-14',19,40378.07,2,0.02,0,0.00,0,0.00,0,0.00),
(15,'2016-11-15',23,746.14,3,0.90,85,1070.00,49,4900.00,0,0.00),
(16,'2016-11-16',26,1539.11,1,9.99,8,100.00,0,0.00,0,0.00),
(17,'2016-11-17',42,2859.50,0,0.00,12,180.00,0,0.00,0,0.00),
(18,'2016-11-18',45,2381.00,1,0.01,28,300.00,0,0.00,137,77478.93),
(19,'2016-11-19',57,1973.00,0,0.00,0,0.00,0,0.00,0,0.00),
(20,'2016-11-20',47,22426.00,0,0.00,0,0.00,0,0.00,0,0.00),
(21,'2016-11-21',31,23168.05,2,8.89,84,1040.00,0,0.00,0,0.00),
(22,'2016-11-22',25,18303.07,0,0.00,20,220.00,0,0.00,0,0.00),
(23,'2016-11-23',37,6843.02,1,0.01,14,180.00,0,0.00,0,0.00),
(24,'2016-11-24',35,54327.00,0,0.00,24,260.00,0,0.00,0,0.00),
(25,'2016-11-25',20,5218.20,0,0.00,26,270.00,0,0.00,103,78972.68),
(26,'2016-11-26',43,30226.00,0,0.00,0,0.00,0,0.00,0,0.00),
(27,'2016-11-27',61,12961.00,1,0.01,0,0.00,0,0.00,0,0.00),
(28,'2016-11-28',40,66298.11,2,15.54,94,1210.00,0,0.00,0,0.00),
(29,'2016-11-29',47,2330.40,0,0.00,18,260.00,0,0.00,0,0.00),
(30,'2016-11-30',20,1055.00,1,5.88,26,340.00,0,0.00,0,0.00);

/*Table structure for table `sys_btn` */

DROP TABLE IF EXISTS `sys_btn`;

CREATE TABLE `sys_btn` (
  `id` varchar(50) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `descript` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_btn` */

insert  into `sys_btn`(`id`,`code`,`name`,`enabled`,`descript`) values 
('4028388148bc169f0148bc5b25620001','btnAdd','新增',1,NULL),
('4028388148bc169f0148bc5b66bb0002','btnEdit','修改',1,NULL),
('4028388148bc169f0148bc5b8ae60003','btnDelete','删除',1,NULL),
('4028388148bc169f0148bc5bb1870004','btnDetail','查看',1,NULL);

/*Table structure for table `sys_config` */

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `id` varchar(50) NOT NULL,
  `k` varchar(255) NOT NULL,
  `v` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL COMMENT '1启用 0不启用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `k` (`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_config` */

insert  into `sys_config`(`id`,`k`,`v`,`enabled`) values 
('8a80868853a692ad0153a6ab86690003','faceRate','0.93',1),
('8a80868853a692ad0153a6ab86690004','sms.url','http://61.147.98.117:9001/servlet/UserServiceAPI?isLongSms=0&username=17730011432&password=Y2hlbWltaTUyMA&smstype=1&extenno=&method=sendSMS&',1),
('8a80868853a692ad0153a6ab867b0005','sms.method','POST',1),
('8a80868853a692ad0153a6ab86860006','sms.field.content','content',1),
('8a80868853a692ad0153a6ab868f0007','sms.field.mobile','mobile',1),
('8a80868853a692ad0153a6ab869a0008','sms.encoding','UTF-8',1),
('8a80868853a692ad0153a6ab869a0009','system.debug','true',1),
('8a80868853a692ad0153a6ab869a0010','system.app','jrelax-bi',1),
('8a80868853a692ad0153a6ab869a0011','system.respath',NULL,1),
('8a80868853a692ad0153a6ab869a0012','system.index.page','index-tabs',1),
('8a80868853a692ad0153a6ab869a0013','system.file.folder.root','/',1),
('8a80868853a692ad0153a6ab869a0014','system.page.rows','10',1),
('8a80868853a692ad0153a6ab869a0015','system.login.title','JRelax-BI',1),
('8a80868853a692ad0153a6ab869a0016','system.admin.title','JRelax-BI',1),
('8a80868853a692ad0153a6ab869a0017','upload.folder.root','/resources/upload/',1),
('8a80868853a692ad0153a6ab869a0018','upload.remote.enabled','false',1),
('8a80868853a692ad0153a6ab869a0019','upload.remote.rmi','rmi://localhost:10000/fs',1),
('8a80868853a692ad0153a6ab869a0020','upload.remote.view','http://localhost:8080/jrelax-fs',1),
('8a80868853a692ad0153a6ab869a0021','cache.memcached.url','192.168.0.109',1),
('8a80868853a692ad0153a6ab869a0022','cache.memcached.port','11211',1),
('8a80868853a692ad0153a6ab869a0023','cache.memcached.weight','3',1),
('8a80868853a692ad0153a6ab869a0024','cache.memcached.initConn','10',1),
('8a80868853a692ad0153a6ab869a0025','cache.memcached.maxConn','10',1),
('8a80868853a692ad0153a6ab869a0026','cache.memcached.minConn','10',1),
('8a80868853a692ad0153a6ab869a0027','cache.memcached.maxIdle','3600000',1),
('8a80868853a692ad0153a6ab869a0028','cache.memcached.maintSleep','60',1),
('8a80868853a692ad0153a6ab869a0029','mail.smtp.host','smtp.exmail.qq.com',1),
('8a80868853a692ad0153a6ab869a0030','mail.smtp.port','465',1),
('8a80868853a692ad0153a6ab869a0031','mail.smtp.socketFactory.port','465',1),
('8a80868853a692ad0153a6ab869a0032','mail.smtp.auth','true',1),
('8a80868853a692ad0153a6ab869a0033','mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory',1),
('8a80868853a692ad0153a6ab869a0034','mail.smtp.socketFactory.fallback','true',1),
('8a80868853a692ad0153a6ab869a0035','mail.smtp.username','service@nethsoft.com',1),
('8a80868853a692ad0153a6ab869a0036','mail.smtp.password','nethsoft2014',1),
('8a80868853a692ad0153a6ab869a0037','mail.period','50000',1);

/*Table structure for table `sys_datadict` */

DROP TABLE IF EXISTS `sys_datadict`;

CREATE TABLE `sys_datadict` (
  `id` varchar(50) NOT NULL,
  `category` varchar(50) DEFAULT NULL COMMENT '分类',
  `name` varchar(50) NOT NULL,
  `remarks` varchar(20) DEFAULT NULL,
  `createUser` varchar(50) NOT NULL,
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_datadict` */

insert  into `sys_datadict`(`id`,`category`,`name`,`remarks`,`createUser`,`createTime`) values 
('4028812856a0dfaa0156a12c4ab80017','系统','sys_themes','系统主题包','superadmin','2016-08-19 13:00:49'),
('402881ee52f2c20f0152f2fa36fb0008','系统','sys_status','状态','superadmin','2016-02-18 14:03:50'),
('402887d9535f625501535f73ff2b0009','系统','sys_exception','异常','superadmin','2016-03-10 15:35:50'),
('4028b88158b3bc850158b411f07b0003','自定义图表','bi_charts_type','图表类型','superadmin','2016-11-30 15:10:24'),
('4028b88159b070d70159b0a2b34e0001','数据源','bi_db_type','外部数据库类型','superadmin','2017-01-18 16:12:49'),
('4028b88159b070d70159b0ab81e30004','数据源','bi_db_driver','外部数据库驱动','superadmin','2017-01-18 16:22:27'),
('4028b88159b070d70159b0abea6e0005','数据源','bi_db_jdbc_url','外部数据库JDBC连接','superadmin','2017-01-18 16:22:53');

/*Table structure for table `sys_datadict_item` */

DROP TABLE IF EXISTS `sys_datadict_item`;

CREATE TABLE `sys_datadict_item` (
  `id` varchar(50) NOT NULL,
  `did` varchar(50) NOT NULL,
  `k` varchar(100) DEFAULT NULL,
  `v` varchar(100) NOT NULL,
  `location` int(11) DEFAULT NULL,
  `createUser` varchar(50) NOT NULL,
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sys_datadict_item` (`did`),
  CONSTRAINT `FK_sys_datadict_item` FOREIGN KEY (`did`) REFERENCES `sys_datadict` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_datadict_item` */

insert  into `sys_datadict_item`(`id`,`did`,`k`,`v`,`location`,`createUser`,`createTime`) values 
('4028812856a0dfaa0156a12e94150018','4028812856a0dfaa0156a12c4ab80017','默认风格','palette',1,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e94330019','4028812856a0dfaa0156a12c4ab80017','风格一','palette.2',2,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e9434001a','4028812856a0dfaa0156a12c4ab80017','风格二','palette.3',3,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e9434001b','4028812856a0dfaa0156a12c4ab80017','风格三','palette.4',4,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e9435001c','4028812856a0dfaa0156a12c4ab80017','风格四','palette.5',5,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e9435001d','4028812856a0dfaa0156a12c4ab80017','风格五','palette.6',6,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e9435001e','4028812856a0dfaa0156a12c4ab80017','风格六','palette.7',7,'superadmin','2016-08-19 13:03:19'),
('4028812856a0dfaa0156a12e9436001f','4028812856a0dfaa0156a12c4ab80017','风格七','palette.7',8,'superadmin','2016-08-19 13:03:19'),
('402887d9535f625501535f713d060001','402881ee52f2c20f0152f2fa36fb0008','0','启用',1,'superadmin','2016-03-10 15:32:50'),
('402887d9535f625501535f713d180002','402881ee52f2c20f0152f2fa36fb0008','1','禁用',2,'superadmin','2016-03-10 15:32:50'),
('402887d9535f625501535f7419c0000e','402887d9535f625501535f73ff2b0009','org.hibernate.exception.ConstraintViolationException','存在关联数据，无法执行此操作！',1,'superadmin','2016-03-10 15:35:57'),
('4028b88158c394ca0158c3ad98cf001b','4028b88158b3bc850158b411f07b0003','bar','柱状图',1,'superadmin','2016-12-03 15:54:43'),
('4028b88158c394ca0158c3ad98d0001c','4028b88158b3bc850158b411f07b0003','line','折线图',2,'superadmin','2016-12-03 15:54:43'),
('4028b88158c394ca0158c3ad98d0001d','4028b88158b3bc850158b411f07b0003','pie','饼状图',3,'superadmin','2016-12-03 15:54:43'),
('4028b88158c394ca0158c3ad98d0001e','4028b88158b3bc850158b411f07b0003','doughnut','环形图',4,'superadmin','2016-12-03 15:54:43'),
('4028b88158c394ca0158c3ad98d0001f','4028b88158b3bc850158b411f07b0003','polar-area','极坐标图',5,'superadmin','2016-12-03 15:54:43'),
('4028b88158c394ca0158c3ad98d00020','4028b88158b3bc850158b411f07b0003','radar','雷达图',6,'superadmin','2016-12-03 15:54:43'),
('4028b88158c394ca0158c3ad98d00021','4028b88158b3bc850158b411f07b0003','bubble','气泡图',7,'superadmin','2016-12-03 15:54:43'),
('4028b88159b070d70159b0a32f720002','4028b88159b070d70159b0a2b34e0001','mysql','MySQL数据库',1,'superadmin','2017-01-18 16:13:21'),
('4028b88159b070d70159b0a32f720003','4028b88159b070d70159b0a2b34e0001','oracle','Oracle数据库',2,'superadmin','2017-01-18 16:13:21'),
('4028b88159b070d70159b0ac98de0006','4028b88159b070d70159b0ab81e30004','mysql','com.mysql.jdbc.Driver',1,'superadmin','2017-01-18 16:23:38'),
('4028b88159b070d70159b0ac98de0007','4028b88159b070d70159b0ab81e30004','oracle','oracle.jdbc.driver.OracleDriver',2,'superadmin','2017-01-18 16:23:38'),
('4028b88159b070d70159b0adbad40008','4028b88159b070d70159b0abea6e0005','mysql','jdbc:mysql://${host}:${port}/${db}',1,'superadmin','2017-01-18 16:24:52'),
('4028b88159b070d70159b0adbad40009','4028b88159b070d70159b0abea6e0005','oracle','jdbc:oracle:thin:@localhost:1521:orcl',2,'superadmin','2017-01-18 16:24:52');

/*Table structure for table `sys_email` */

DROP TABLE IF EXISTS `sys_email`;

CREATE TABLE `sys_email` (
  `id` varchar(50) NOT NULL,
  `recipients` varchar(100) NOT NULL DEFAULT '' COMMENT '多个收件人用逗号隔开',
  `title` varchar(100) NOT NULL,
  `subtitle` varchar(100) DEFAULT NULL,
  `content` text,
  `sendTime` varchar(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1 待发送 2已发送 3 发送失败',
  `remarks` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `createUser` varchar(50) DEFAULT NULL,
  `createTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_email` */

insert  into `sys_email`(`id`,`recipients`,`title`,`subtitle`,`content`,`sendTime`,`state`,`remarks`,`weight`,`createUser`,`createTime`) values 
('402838814a9031f1014a9035471d0001','1077020759@qq.com,359921330@qq.com','title','subtitle','content','2014-12-28 19:54:12',2,'remarks',1,'4028388148e09a0d0148','2014-12-28 17:23:38'),
('402838814a90ea9b014a90ede26e0001','359921330@qq.com','测试程序 - 物业管理系统',NULL,'测试一下啊！！！','2014-12-28 20:45:19',2,NULL,1,'4028388148e09a0d0148','2014-12-28 20:45:16'),
('402838814a9429da014a9430140a0000','359921330@qq.com','测试程序 - 物业管理系统',NULL,'测试一下啊！！！','2014-12-29 12:07:47',2,NULL,1,'4028388148e09a0d0148','2014-12-29 11:56:26');

/*Table structure for table `sys_ip_address` */

DROP TABLE IF EXISTS `sys_ip_address`;

CREATE TABLE `sys_ip_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startIp` varchar(25) NOT NULL,
  `endIp` varchar(25) NOT NULL,
  `country` varchar(50) NOT NULL,
  `local` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_ip_address` */

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` varchar(50) NOT NULL,
  `type` int(11) NOT NULL,
  `content` text,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `logip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `logtime` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `manipulatename` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `classname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`type`,`content`,`username`,`logip`,`logtime`,`manipulatename`,`classname`) values 
('297e45605915bf15015915c08c990000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-19 14:24:17 017','系统登录','LogService'),
('297e45605915bf15015915c2357b0001',1,'访问机构列表','superadmin','localhost','2016-12-19 14:26:06 006','机构管理','LogService'),
('297e45605915bf15015915c247270002',1,'访问用户列表','superadmin','localhost','2016-12-19 14:26:10 010','用户管理','LogService'),
('297e45605915bf15015915c270eb0003',1,'访问角色列表','superadmin','localhost','2016-12-19 14:26:21 021','角色管理','LogService'),
('297e45605915bf15015915c284b00004',1,'访问菜单列表','superadmin','localhost','2016-12-19 14:26:26 026','菜单管理','LogService'),
('297e45605915c63f015915c6a1320000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-19 14:30:56 056','系统登录','LogService'),
('297e45605915c63f015915c6d6a00001',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-19 14:31:09 009','系统首页','LogService'),
('297e45605915c63f015915c75ae50002',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-19 14:31:43 043','系统首页','LogService'),
('297e45605915c63f015915c764a10003',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2016-12-19 14:31:46 046','系统首页','LogService'),
('297e45605915c63f015915c76bda0004',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-19 14:31:47 047','系统首页','LogService'),
('297e45605915c63f015915c772020005',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-19 14:31:49 049','系统首页','LogService'),
('297e45605915c63f015915c778a40006',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-12-19 14:31:51 051','系统首页','LogService'),
('297e45605915c63f015915c7814e0007',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-12-19 14:31:53 053','系统首页','LogService'),
('297e45605915c63f015915c785c40008',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-12-19 14:31:54 054','系统首页','LogService'),
('297e45605915c63f015915c78b4e0009',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-19 14:31:55 055','系统首页','LogService'),
('297e45605915c63f015915c7bed3000a',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-19 14:32:09 009','系统首页','LogService'),
('297e45605915c63f015915c81b02000b',1,'访问菜单列表','superadmin','localhost','2016-12-19 14:32:32 032','菜单管理','LogService'),
('297e45605915c63f015915c8720a000c',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-19 14:32:55 055','系统首页','LogService'),
('297e45605915c63f015915c8d9ea000d',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-19 14:33:21 021','系统首页','LogService'),
('297e45605915c63f015915c9fb23000e',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-19 14:34:35 035','系统首页','LogService'),
('297e45605915c63f015915cdd326000f',1,'访问角色列表','superadmin','localhost','2016-12-19 14:38:47 047','角色管理','LogService'),
('297e45605915c63f015915cf84290048',1,'编辑角色权限：[Id:4028388148d681830148d6857c71000d, Name:null]','superadmin','localhost','2016-12-19 14:40:38 038','角色管理','LogService'),
('297e45605915c63f015915cf93370049',1,'访问角色列表','superadmin','localhost','2016-12-19 14:40:42 042','角色管理','LogService'),
('297e45605915c63f015915cfd56c004a',1,'访问用户列表','superadmin','localhost','2016-12-19 14:40:59 059','用户管理','LogService'),
('297e45605915c63f015915cfd5d9004b',1,'访问机构列表','superadmin','localhost','2016-12-19 14:40:59 059','机构管理','LogService'),
('297e45605915c63f015915d0099d004c',1,'查看权限：[402881ee547f564d01547f7dd49b002e]','superadmin','localhost','2016-12-19 14:41:12 012','用户管理','LogService'),
('297e45605915c63f015915d04537004d',1,'查看权限：[402881ee547f564d01547f7e24910031]','superadmin','localhost','2016-12-19 14:41:27 027','用户管理','LogService'),
('297e988a592927040159292aae230000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 08:53:00 000','系统登录','LogService'),
('297e988a59292704015929551dc70001',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:39:21 021','系统登录','LogService'),
('297e988a592927040159295da04d0002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:48:38 038','系统登录','LogService'),
('297e988a592927040159295dcfa10003',3,'错误代码:404，访问路径:/index/bi/charts/drag','superadmin','localhost','2016-12-23 09:48:50 050','系统异常','LogService'),
('297e988a592927040159295e06730004',3,'错误代码:404，访问路径:/index/bi/charts/drag','superadmin','localhost','2016-12-23 09:49:05 005','系统异常','LogService'),
('297e988a592927040159295e12b40005',3,'错误代码:404，访问路径:/','superadmin','localhost','2016-12-23 09:49:08 008','系统异常','LogService'),
('297e988a59292704015929614e890006',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:52:40 040','系统登录','LogService'),
('297e988a5929270401592961ccae0007',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:53:12 012','系统登录','LogService'),
('297e988a592927040159296223080008',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:53:34 034','系统登录','LogService'),
('297e988a592927040159296293670009',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:54:03 003','系统登录','LogService'),
('297e988a5929270401592962c56e000a',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:54:16 016','系统登录','LogService'),
('297e988a5929278501592953eeba0000',3,'错误代码:404，访问路径:/favicon.ico','system','localhost','2016-12-23 09:38:03 003','系统异常','LogService'),
('297e988a5929278501592962c77d0001',3,'错误代码:404，访问路径:/favicon.ico','system','localhost','2016-12-23 09:54:16 016','系统异常','LogService'),
('2c90944358fb549c0158fb5512dc0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-14 11:16:46 046','系统登录','LogService'),
('2c90944358fb549c0158fb7881120001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 11:55:28 028','登录系统','LogService'),
('2c9094b858e2681b0158e26e45970000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-09 15:13:47 047','系统登录','LogService'),
('2c9094b858e2681b0158e275ad560001',1,'访问机构列表','superadmin','localhost','2016-12-09 15:21:52 052','机构管理','LogService'),
('2c9094b858e2681b0158e27660020002',1,'访问用户列表','superadmin','localhost','2016-12-09 15:22:38 038','用户管理','LogService'),
('2c9094b858e2681b0158e27676230003',1,'访问角色列表','superadmin','localhost','2016-12-09 15:22:44 044','角色管理','LogService'),
('2c9094b858e2681b0158e27697be0004',1,'访问菜单列表','superadmin','localhost','2016-12-09 15:22:52 052','菜单管理','LogService'),
('4028470359c621650159c628277f0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-22 20:30:37 037','系统登录','LogService'),
('4028470359c621650159c62b37d00001',1,'访问机构列表','superadmin','localhost','2017-01-22 20:33:58 058','机构管理','LogService'),
('4028470359c621650159c62bfc5b0002',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-22 20:34:48 048','退出系统','LogService'),
('402882ff592947b10159294b1e460000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 09:28:25 025','系统登录','LogService'),
('402882ff592947b10159294b48b80001',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 09:28:36 036','系统首页','LogService'),
('402882ff592947b10159294bb2990002',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','127.0.0.1','2016-12-23 09:29:03 003','请求出错','LogService'),
('402882ff592947b10159294bb2be0003',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cdb1a444001d','superadmin','localhost','2016-12-23 09:29:03 003','系统异常','LogService'),
('402882ff592947b10159294bb4170004',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','127.0.0.1','2016-12-23 09:29:04 004','请求出错','LogService'),
('402882ff592947b10159294bb4210005',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cdb1a444001d','superadmin','localhost','2016-12-23 09:29:04 004','系统异常','LogService'),
('402882ff592947b101592968e2be0006',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-23 10:00:56 056','登录系统','LogService'),
('402882ff592947b1015929dc579f0007',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 12:07:03 003','系统登录','LogService'),
('402882ff592947b1015929dc759a0008',1,'访问机构列表','superadmin','localhost','2016-12-23 12:07:11 011','机构管理','LogService'),
('402882ff592947b1015929dc97bf0009',1,'访问用户列表','superadmin','localhost','2016-12-23 12:07:19 019','用户管理','LogService'),
('402882ff592947b1015929dccbcf000a',1,'访问角色列表','superadmin','localhost','2016-12-23 12:07:33 033','角色管理','LogService'),
('402882ff592947b1015929dd1ab5000b',1,'访问角色列表','superadmin','localhost','2016-12-23 12:07:53 053','角色管理','LogService'),
('402882ff592947b1015929dd2956000c',1,'访问菜单列表','superadmin','localhost','2016-12-23 12:07:57 057','菜单管理','LogService'),
('402882ff592947b1015929e2f69d000d',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 12:14:17 017','系统异常','LogService'),
('402882ff592947b1015929e30dd4000e',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 12:14:23 023','系统异常','LogService'),
('402882ff592947b1015929e335fb000f',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 12:14:33 033','系统异常','LogService'),
('402882ff592947b101592a00e9b30010',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-23 12:47:00 000','登录系统','LogService'),
('402883eb5914cb7a015914fc2a200000',1,'用户：[test] 成功登录系统','test','localhost','2016-12-19 10:49:47 047','系统登录','LogService'),
('402883eb5914cb7a015914fc5e210001',1,'切换布局：[layout: small-menu]','test','localhost','2016-12-19 10:50:00 000','系统首页','LogService'),
('402883eb5914cb7a015914fc68720002',1,'切换布局：[layout: ]','test','localhost','2016-12-19 10:50:03 003','系统首页','LogService'),
('402883eb5914cb7a015914fcdc790003',1,'切换布局：[layout: small-menu]','test','localhost','2016-12-19 10:50:32 032','系统首页','LogService'),
('402883eb5914cb7a015914fd123e0004',1,'切换布局：[layout: ]','test','localhost','2016-12-19 10:50:46 046','系统首页','LogService'),
('402883eb5914cb7a015914fd76090005',1,'用户：[test] 退出系统','test','localhost','2016-12-19 10:51:12 012','退出系统','LogService'),
('402883eb5914cb7a015914fd878e0006',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-19 10:51:16 016','系统登录','LogService'),
('402883eb5914cb7a015914fe5f110007',1,'访问用户列表','superadmin','localhost','2016-12-19 10:52:11 011','用户管理','LogService'),
('402883eb5914cb7a015914fe90df0008',1,'访问机构列表','superadmin','localhost','2016-12-19 10:52:24 024','机构管理','LogService'),
('402883eb5914cb7a015914fea4e40009',1,'访问角色列表','superadmin','localhost','2016-12-19 10:52:29 029','角色管理','LogService'),
('402883eb5914cb7a015914feb4d3000a',1,'访问菜单列表','superadmin','localhost','2016-12-19 10:52:33 033','菜单管理','LogService'),
('402883eb5914cb7a015914ff326f000b',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-19 10:53:06 006','系统首页','LogService'),
('402883eb5914cb7a0159151f9294000c',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-19 11:28:27 027','退出系统','LogService'),
('402883eb5914cb7a0159151fe7d9000d',1,'用户：[hefei] 成功登录系统','hefei','localhost','2016-12-19 11:28:49 049','系统登录','LogService'),
('402883eb5914cb7a0159151feeaf000e',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','hefei','localhost','2016-12-19 11:28:51 051','系统异常','LogService'),
('402883eb5914cb7a0159151fef4b000f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','hefei','localhost','2016-12-19 11:28:51 051','系统异常','LogService'),
('402883eb5914cb7a0159151fef7a0010',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','hefei','localhost','2016-12-19 11:28:51 051','系统异常','LogService'),
('402883eb5914cb7a0159151fef7a0011',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','hefei','localhost','2016-12-19 11:28:51 051','系统异常','LogService'),
('402883eb5914cb7a0159151fefa90012',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','hefei','localhost','2016-12-19 11:28:51 051','系统异常','LogService'),
('402883eb5914cb7a0159151fefb80013',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','hefei','localhost','2016-12-19 11:28:51 051','系统异常','LogService'),
('402883eb5914cb7a0159152025eb0014',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','hefei','127.0.0.1','2016-12-19 11:29:05 005','请求出错','LogService'),
('402883eb5914cb7a0159152025eb0015',3,'错误代码:500，访问路径:/system/unit','hefei','localhost','2016-12-19 11:29:05 005','系统异常','LogService'),
('402883eb5914cb7a015915202d4e0016',1,'访问用户列表','hefei','localhost','2016-12-19 11:29:07 007','用户管理','LogService'),
('402883eb5914cb7a0159152031940017',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','hefei','127.0.0.1','2016-12-19 11:29:08 008','请求出错','LogService'),
('402883eb5914cb7a0159152041ef0018',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','hefei','127.0.0.1','2016-12-19 11:29:12 012','请求出错','LogService'),
('402883eb5914cb7a0159152041ef0019',3,'错误代码:500，访问路径:/system/role','hefei','localhost','2016-12-19 11:29:12 012','系统异常','LogService'),
('402883eb5914cb7a015915204990001a',1,'访问菜单列表','hefei','localhost','2016-12-19 11:29:14 014','菜单管理','LogService'),
('402883eb5914cb7a0159153ce839001b',1,'用户：hefei 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 12:00:30 030','登录系统','LogService'),
('402883eb5914cb7a015915a297d7001c',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-19 13:51:34 034','系统登录','LogService'),
('402883eb5914cb7a015915a2ae2e001d',1,'访问菜单列表','superadmin','localhost','2016-12-19 13:51:40 040','菜单管理','LogService'),
('402883eb5914cb7a015915a2fe9f001e',1,'访问菜单列表','superadmin','localhost','2016-12-19 13:52:00 000','菜单管理','LogService'),
('402883eb5914cb7a015915a30d17001f',1,'访问菜单列表','superadmin','localhost','2016-12-19 13:52:04 004','菜单管理','LogService'),
('402883eb5914cb7a015915a3f1d90020',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-19 13:53:02 002','系统首页','LogService'),
('402883eb5914cb7a015915a3fe4d0021',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-12-19 13:53:06 006','系统首页','LogService'),
('402883eb5914cb7a015915a407260022',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-19 13:53:08 008','系统首页','LogService'),
('402883eb5914cb7a015915a4105e0023',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-19 13:53:10 010','系统首页','LogService'),
('402883eb5914cb7a015915a4158e0024',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-19 13:53:12 012','系统首页','LogService'),
('402885b558f0a53e0158f0a5f07a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-12 09:29:16 016','系统登录','LogService'),
('402885b558f0a53e0158f0a61ebe0001',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','0:0:0:0:0:0:0:1','2016-12-12 09:29:28 028','请求出错','LogService'),
('402885b558f0a53e0158f0a61ed10002',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cdb1a444001d','superadmin','localhost','2016-12-12 09:29:28 028','系统异常','LogService'),
('402885b558f0a53e0158f0b1184e0004',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-12 09:41:27 027','系统首页','LogService'),
('402885b558f0a53e0158f0b2ea5a0005',1,'访问机构列表','superadmin','localhost','2016-12-12 09:43:27 027','机构管理','LogService'),
('402885b558f0a53e0158f0b307460006',1,'查看机构信息：[Id:40283881493c2aff01493c32e2a70000]','superadmin','localhost','2016-12-12 09:43:34 034','机构管理','LogService'),
('402885b558f0a53e0158f0b331110008',1,'新增机构：[Id:402885b558f0a53e0158f0b3303a0007,Name:aaa,ParentId:40283881493c2aff01493c32e2a70000]','superadmin','localhost','2016-12-12 09:43:45 045','机构管理','LogService'),
('402885b558f0a53e0158f0b34f010009',1,'编辑机构菜单：[Id:402885b558f0a53e0158f0b3303a0007,菜单数:3]','superadmin','localhost','2016-12-12 09:43:52 052','机构管理','LogService'),
('402885b558f0a53e0158f0b353e1000a',1,'访问机构列表','superadmin','localhost','2016-12-12 09:43:54 054','机构管理','LogService'),
('402885b558f0a53e0158f0b36c58000b',1,'访问角色列表','superadmin','localhost','2016-12-12 09:44:00 000','角色管理','LogService'),
('402885b558f0a53e0158f0b43e6c000c',3,'错误代码:404，访问路径:/office/email/inside/send','superadmin','localhost','2016-12-12 09:44:54 054','系统异常','LogService'),
('402885b558f0a53e0158f0b463f9000d',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-12 09:45:03 003','系统登录','LogService'),
('40289f39563c046701563c05d9d60000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-07-30 21:37:11 011','系统登录','LogService'),
('40289f39563c046701563c071d190001',1,'访问机构列表','superadmin','localhost','2016-07-30 21:38:34 034','机构管理','LogService'),
('40289f39563c046701563c0977e80002',1,'访问机构列表','superadmin','localhost','2016-07-30 21:41:08 008','机构管理','LogService'),
('40289f39563c046701563c09af880003',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-07-30 21:41:22 022','系统首页','LogService'),
('40289f39563c046701563c09ca0f0004',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-07-30 21:41:29 029','系统首页','LogService'),
('40289f39563c046701563c09d8170005',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-07-30 21:41:33 033','系统首页','LogService'),
('40289f39563c046701563c09df0e0006',1,'切换皮肤：[theme: palette.8]','superadmin','localhost','2016-07-30 21:41:35 035','系统首页','LogService'),
('40289f39563c046701563c09e4dd0007',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-07-30 21:41:36 036','系统首页','LogService'),
('40289f39563c046701563c0ac0790008',1,'访问机构列表','superadmin','localhost','2016-07-30 21:42:32 032','机构管理','LogService'),
('40289f39563c046701563c0b1b6c0009',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-07-30 21:42:56 056','系统首页','LogService'),
('40289f39563c046701563c0eb36e000a',1,'访问机构列表','superadmin','localhost','2016-07-30 21:46:51 051','机构管理','LogService'),
('40289f39563c046701563c0f4d31000b',3,'错误代码:404，访问路径:/framework/plugins/typeahead/form/typeahead.js-bootstrap.css','superadmin','localhost','2016-07-30 21:47:30 030','系统异常','LogService'),
('40289f39563c046701563c44d82f000c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-07-30 22:45:59 059','登录系统','LogService'),
('40289f39563c046701563c9d693d000d',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-07-31 00:22:44 044','系统登录','LogService'),
('40289f3958de59770158de5a82a90000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-08 20:13:43 043','系统登录','LogService'),
('40289f3958de59770158de5beacf0001',1,'访问菜单列表','superadmin','localhost','2016-12-08 20:15:15 015','菜单管理','LogService'),
('40289f3958de59770158de5cc56d0002',1,'访问菜单列表','superadmin','localhost','2016-12-08 20:16:11 011','菜单管理','LogService'),
('40289f3958de59770158de5cdefb0003',1,'删除角色：[Id:402881ee53a854a90153a859b2b70001]','superadmin','localhost','2016-12-08 20:16:18 018','菜单管理','LogService'),
('40289f3958de59770158de5d312b0004',1,'访问菜单列表','superadmin','localhost','2016-12-08 20:16:39 039','菜单管理','LogService'),
('40289f3958de59770158de5d59090005',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-08 20:16:49 049','系统登录','LogService'),
('40289f3958de59770158de5d8a140006',1,'访问菜单列表','superadmin','localhost','2016-12-08 20:17:01 001','菜单管理','LogService'),
('40289f3958de59770158de5daf0c0007',1,'访问菜单列表','superadmin','localhost','2016-12-08 20:17:11 011','菜单管理','LogService'),
('40289f3958de59770158de5dcc150008',1,'删除角色：[Id:297ec0504dfb4517014dfb7f6e3b0004]','superadmin','localhost','2016-12-08 20:17:18 018','菜单管理','LogService'),
('40289f3958de59770158de5de3a10009',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-08 20:17:24 024','系统登录','LogService'),
('40289f3958de59770158de5e71b2000a',1,'访问菜单列表','superadmin','localhost','2016-12-08 20:18:01 001','菜单管理','LogService'),
('40289f3958de59770158de5ec384000b',1,'删除角色：[Id:4028388148b2fe810148b32e9036002e]','superadmin','localhost','2016-12-08 20:18:22 022','菜单管理','LogService'),
('40289f3958de59770158de5edb20000c',1,'删除角色：[Id:402838814abaefca014abb31cf6b0011]','superadmin','localhost','2016-12-08 20:18:28 028','菜单管理','LogService'),
('40289f3958de59770158de5ef2dc000d',1,'删除角色：[Id:4028388149ebc54f0149ebcbf9e90000]','superadmin','localhost','2016-12-08 20:18:34 034','菜单管理','LogService'),
('40289f3958de59770158de5f1fcf000e',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-08 20:18:45 045','系统登录','LogService'),
('40289f3958de59770158de5f2fa9000f',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-12-08 20:18:49 049','系统首页','LogService'),
('40289f3958de59770158de5f3f290010',1,'锁定系统','superadmin','localhost','2016-12-08 20:18:53 053','个人中心','LogService'),
('40289f3958de59770158de5fb37e0011',1,'解锁系统','superadmin','localhost','2016-12-08 20:19:23 023','个人中心','LogService'),
('40289f3958de59770158de674a070012',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-08 20:27:40 040','系统首页','LogService'),
('40289f3958de59770158de674e230013',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-08 20:27:41 041','系统首页','LogService'),
('40289f3958de59770158de6751f10014',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-08 20:27:42 042','系统首页','LogService'),
('40289f3958de59770158de6755030015',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-08 20:27:43 043','系统首页','LogService'),
('40289f3958de59770158de67593d0016',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-08 20:27:44 044','系统首页','LogService'),
('40289f3958de59770158de675bf90017',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-08 20:27:45 045','系统首页','LogService'),
('40289f3958de59770158de6787d00018',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-12-08 20:27:56 056','系统首页','LogService'),
('40289f3958de59770158de678f740019',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-08 20:27:58 058','系统首页','LogService'),
('40289f3958de59770158de67956e001a',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-08 20:28:00 000','系统首页','LogService'),
('40289f3958de59770158de67990e001b',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-08 20:28:01 001','系统首页','LogService'),
('40289f3958de59770158de679ba5001c',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-08 20:28:01 001','系统首页','LogService'),
('40289f3958de59770158de67a06d001d',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-08 20:28:03 003','系统首页','LogService'),
('40289f3958de8c1d0158de8c9c640000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-08 21:08:26 026','系统登录','LogService'),
('40289f3958de8c1d0158de92fe3a0001',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-08 21:15:25 025','退出系统','LogService'),
('40289f39592b9d2f01592b9d851d0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 20:17:40 040','系统登录','LogService'),
('40289f39592b9d2f01592b9d8d600001',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:42 042','系统异常','LogService'),
('40289f39592b9d2f01592b9d8ec20002',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:43 043','系统异常','LogService'),
('40289f39592b9d2f01592b9d8f370003',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:43 043','系统异常','LogService'),
('40289f39592b9d2f01592b9d8f620004',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:43 043','系统异常','LogService'),
('40289f39592b9d2f01592b9d8f760005',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:43 043','系统异常','LogService'),
('40289f39592b9d2f01592b9d92700006',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:44 044','系统异常','LogService'),
('40289f39592b9d2f01592b9d927e0007',3,'错误代码:404，访问路径:/app/charts/datasource.js','superadmin','localhost','2016-12-23 20:17:44 044','系统异常','LogService'),
('40289f39592b9d2f01592ba176100008',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-23 20:21:58 058','退出系统','LogService'),
('40289f395935cd44015935cde5e30000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-25 19:46:43 043','系统登录','LogService'),
('40289f395935dd65015935ddce1f0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-25 20:04:05 005','系统登录','LogService'),
('40289f395935dd65015935df04510001',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-12-25 20:05:25 025','系统首页','LogService'),
('40289f395935dd65015935df13bb0002',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-12-25 20:05:29 029','系统首页','LogService'),
('40289f395935dd65015935df1d040003',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-25 20:05:31 031','系统首页','LogService'),
('40289f395935dd65015935e652f70004',1,'访问菜单列表','superadmin','localhost','2016-12-25 20:13:24 024','菜单管理','LogService'),
('40289f395935dd65015935e65e7c0005',1,'编辑菜单名称：[Id:402881ff500261d4015002732e960000, OldName:数据库管理工具, NewName:数据库管理]','superadmin','localhost','2016-12-25 20:13:27 027','菜单管理','LogService'),
('40289f395935dd65015935e685850006',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-25 20:13:37 037','退出系统','LogService'),
('40289f395935dd65015935e693be0007',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-25 20:13:40 040','系统登录','LogService'),
('40289f395935dd65015935e730210008',1,'锁定系统','superadmin','localhost','2016-12-25 20:14:20 020','个人中心','LogService'),
('40289f395935dd65015935e86ec50009',1,'解锁系统','superadmin','localhost','2016-12-25 20:15:42 042','个人中心','LogService'),
('40289f395935ee6e015935ef47a90000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-25 20:23:11 011','系统登录','LogService'),
('40289f395935ee6e015935ef79e70001',3,'错误代码:404，访问路径:/bi/report/design/40289f395935cd44015935d7886b0002','superadmin','localhost','2016-12-25 20:23:23 023','系统异常','LogService'),
('40289f39594027650159402e265b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-27 20:08:03 003','系统登录','LogService'),
('40289f39595009820159500a3e250000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-30 22:02:45 045','系统登录','LogService'),
('40289f395950098201595010886a0001',1,'锁定系统','superadmin','localhost','2016-12-30 22:09:37 037','个人中心','LogService'),
('40289f395950098201595010f7180002',1,'解锁系统','superadmin','localhost','2016-12-30 22:10:06 006','个人中心','LogService'),
('40289f39595009820159501172080003',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-30 22:10:37 037','退出系统','LogService'),
('40289f39595de7b501595dea71e10000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-02 14:42:42 042','系统登录','LogService'),
('40289f39598c757901598c76fe690000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-11 15:38:45 045','系统登录','LogService'),
('40289f39598c757901598c7733350001',1,'切换皮肤：[theme: palette]','superadmin','localhost','2017-01-11 15:38:59 059','系统首页','LogService'),
('40289f39598c757901598c773c400002',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2017-01-11 15:39:01 001','系统首页','LogService'),
('40289f39598c757901598cd82ff50003',1,'访问菜单列表','superadmin','localhost','2017-01-11 17:24:55 055','菜单管理','LogService'),
('40289f39598c757901598cd84cef0004',1,'编辑菜单名称：[Id:297ec0504dfb4517014dfb8441740006, OldName:自定义表单, NewName:表单管理]','superadmin','localhost','2017-01-11 17:25:02 002','菜单管理','LogService'),
('40289f39598c757901598cd85f0f0005',1,'编辑菜单名称：[Id:402881ee547ea15801547eb17d800004, OldName:自定义图表, NewName:图表管理]','superadmin','localhost','2017-01-11 17:25:07 007','菜单管理','LogService'),
('40289f39598c757901598cd8736c0006',1,'编辑菜单名称：[Id:4028b881592575a30159257a39290002, OldName:自定义报表, NewName:报表管理]','superadmin','localhost','2017-01-11 17:25:12 012','菜单管理','LogService'),
('40289f39598c757901598cd888060007',1,'编辑菜单名称：[Id:297ec0504dfb4517014dfb805a600005, OldName:自定义工作流, NewName:工作流管理]','superadmin','localhost','2017-01-11 17:25:17 017','菜单管理','LogService'),
('40289f39598c757901598cd89c300008',1,'编辑菜单名称：[Id:402881ee547ea15801547eb07a2f0002, OldName:自定义数据源, NewName:数据源管理]','superadmin','localhost','2017-01-11 17:25:23 023','菜单管理','LogService'),
('40289f39598c757901598cd8a5ff0009',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-11 17:25:25 025','退出系统','LogService'),
('40289f39598c757901598cd8a819000a',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-11 17:25:26 026','系统登录','LogService'),
('40289f39598c757901598cd8cf19000b',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2017-01-11 17:25:36 036','系统首页','LogService'),
('40289f39598c757901598cd91122000c',1,'访问菜单列表','superadmin','localhost','2017-01-11 17:25:53 053','菜单管理','LogService'),
('40289f39598c757901598cd927c9000d',1,'编辑菜单：[Id:4028b881592575a30159257a39290002, Name:报表管理, ParentId:-1]','superadmin','localhost','2017-01-11 17:25:58 058','菜单管理','LogService'),
('40289f39598c757901598cd92c51000e',1,'访问菜单列表','superadmin','localhost','2017-01-11 17:26:00 000','菜单管理','LogService'),
('40289f39598c757901598cd93d30000f',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-11 17:26:04 004','退出系统','LogService'),
('40289f39598c757901598cd93f4d0010',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-11 17:26:04 004','系统登录','LogService'),
('40289f39598c757901598cf533890011',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-11 17:56:36 036','登录系统','LogService'),
('40289f395992b9d4015992ba7d540000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-12 20:50:12 012','系统登录','LogService'),
('40289f395992b9d4015992bb0d560001',3,'错误代码:404，访问路径:/flow/form/save','superadmin','localhost','2017-01-12 20:50:49 049','系统异常','LogService'),
('40289f395992c350015992c3f1540000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-12 21:00:31 031','系统登录','LogService'),
('40289f395992c350015992c5b9b50001',1,'访问菜单列表','superadmin','localhost','2017-01-12 21:02:28 028','菜单管理','LogService'),
('40289f395992c350015992c676dd0003',1,'新增菜单：[Id:40289f395992c350015992c676300002, Name:表单管理2.0, ParentId:-1]','superadmin','localhost','2017-01-12 21:03:17 017','菜单管理','LogService'),
('40289f395992c350015992c67d2b0004',1,'访问菜单列表','superadmin','localhost','2017-01-12 21:03:18 018','菜单管理','LogService'),
('40289f395992c350015992c705bd0005',1,'编辑菜单：[Id:297ec0504dfb4517014dfb8441740006, Name:表单管理, ParentId:-1]','superadmin','localhost','2017-01-12 21:03:53 053','菜单管理','LogService'),
('40289f395992c350015992c70abe0006',1,'访问菜单列表','superadmin','localhost','2017-01-12 21:03:55 055','菜单管理','LogService'),
('40289f395992c350015992c71a060007',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-12 21:03:58 058','退出系统','LogService'),
('40289f395992c350015992c71c750008',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-12 21:03:59 059','系统登录','LogService'),
('40289f395992cc07015992ccaa010000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-12 21:10:03 003','系统登录','LogService'),
('40289f395992cc07015992cd14700001',3,'错误代码:404，访问路径:/flow/form/save','superadmin','localhost','2017-01-12 21:10:30 030','系统异常','LogService'),
('40289f395992cc07015992cdd9e90003',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:11:21 021','系统异常','LogService'),
('40289f395992cc07015992cddaab0004',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:11:21 021','系统异常','LogService'),
('40289f395992cc07015992cde0e10005',3,'错误代码:404，访问路径:/open/dev/formdesign/edit/40289f395992cc07015992cdca950002','superadmin','localhost','2017-01-12 21:11:23 023','系统异常','LogService'),
('40289f395992cc07015992ce296b0006',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:11:41 041','系统异常','LogService'),
('40289f395992cc07015992ce2a590007',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:11:41 041','系统异常','LogService'),
('40289f395992cc07015992ce2e3d0008',3,'错误代码:404，访问路径:/bi/form/design/edit/40289f395992cc07015992cdca950002','superadmin','localhost','2017-01-12 21:11:42 042','系统异常','LogService'),
('40289f395992cc07015992ce49860009',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:11:49 049','系统异常','LogService'),
('40289f395992cc07015992ce4aac000a',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:11:50 050','系统异常','LogService'),
('40289f395992cc07015992ce4fad000b',3,'错误代码:404，访问路径:/bi/form/design/40289f395992cc07015992cdca950002','superadmin','localhost','2017-01-12 21:11:51 051','系统异常','LogService'),
('40289f395992d1dc015992d248d00000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-12 21:16:11 011','系统登录','LogService'),
('40289f395992d1dc015992d2937f0001',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:16:30 030','系统异常','LogService'),
('40289f395992d1dc015992d294260002',3,'错误代码:404，访问路径:/app/formdesign/form/form.js','superadmin','localhost','2017-01-12 21:16:31 031','系统异常','LogService'),
('40289f395992d1dc015992d85f180005',3,'错误代码:404，访问路径:/bi/form/submit20','superadmin','localhost','2017-01-12 21:22:50 050','系统异常','LogService'),
('40289f395992d1dc015992d944390006',3,'错误代码:404，访问路径:/bi/form/design/v2/edit/40289f395992d1dc015992d82ec00004','superadmin','localhost','2017-01-12 21:23:49 049','系统异常','LogService'),
('4028b88158ae9f940158aea1233c0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-11-29 13:49:05 005','系统登录','LogService'),
('4028b88158aed64d0158aed7017c0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-11-29 14:47:56 056','系统登录','LogService'),
('4028b88158aed64d0158aee8f9b00001',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-11-29 15:07:33 033','系统首页','LogService'),
('4028b88158aed64d0158aee900780002',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-11-29 15:07:35 035','系统首页','LogService'),
('4028b88158aed64d0158aee904660003',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-11-29 15:07:36 036','系统首页','LogService'),
('4028b88158aed64d0158aee907bf0004',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2016-11-29 15:07:37 037','系统首页','LogService'),
('4028b88158aed64d0158aee90a040005',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-11-29 15:07:37 037','系统首页','LogService'),
('4028b88158aed64d0158aee90d910006',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-11-29 15:07:38 038','系统首页','LogService'),
('4028b88158aed64d0158aee911300007',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-11-29 15:07:39 039','系统首页','LogService'),
('4028b88158aed64d0158aee918f90008',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-11-29 15:07:41 041','系统首页','LogService'),
('4028b88158aed64d0158aee91bb00009',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-11-29 15:07:42 042','系统首页','LogService'),
('4028b88158aed64d0158aee91f0a000a',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-11-29 15:07:43 043','系统首页','LogService'),
('4028b88158aed64d0158aee92165000b',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-11-29 15:07:43 043','系统首页','LogService'),
('4028b88158aed64d0158aee9237b000c',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-11-29 15:07:44 044','系统首页','LogService'),
('4028b88158aed64d0158aee92594000d',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-11-29 15:07:44 044','系统首页','LogService'),
('4028b88158aed64d0158aee92762000e',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-11-29 15:07:45 045','系统首页','LogService'),
('4028b88158aed64d0158aee92d63000f',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-11-29 15:07:46 046','系统首页','LogService'),
('4028b88158aed64d0158aee959ce0010',1,'访问菜单列表','superadmin','localhost','2016-11-29 15:07:58 058','菜单管理','LogService'),
('4028b88158aed64d0158aee977140011',1,'删除角色：[Id:402838814ae123a1014ae2775ac00000]','superadmin','localhost','2016-11-29 15:08:05 005','菜单管理','LogService'),
('4028b88158aed64d0158aee98af20012',1,'删除角色：[Id:402838814abed6c8014abed963290000]','superadmin','localhost','2016-11-29 15:08:10 010','菜单管理','LogService'),
('4028b88158aed64d0158aee998fc0013',1,'删除角色：[Id:297eb7974e8581b9014e862d3cff0000]','superadmin','localhost','2016-11-29 15:08:14 014','菜单管理','LogService'),
('4028b88158aed64d0158aee9a8d10014',1,'删除角色：[Id:402881ee54622750015462288e8d0001]','superadmin','localhost','2016-11-29 15:08:18 018','菜单管理','LogService'),
('4028b88158aed64d0158aee9b7820015',1,'删除角色：[Id:402838814abaefca014abb166d8e0001]','superadmin','localhost','2016-11-29 15:08:22 022','菜单管理','LogService'),
('4028b88158aed64d0158aee9d53c0016',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-11-29 15:08:29 029','系统登录','LogService'),
('4028b88158af03570158af04f0700000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-11-29 15:38:06 006','系统登录','LogService'),
('4028b88158af03570158af0a7d870001',3,'错误代码:404，访问路径:/bi/ds/json/xml/402881ee54a29b8b0154a2d750cb000d','superadmin','localhost','2016-11-29 15:44:10 010','系统异常','LogService'),
('4028b88158af03570158af5fad86000d',3,'错误代码:404，访问路径:/bi/ds/data/json','superadmin','localhost','2016-11-29 17:17:12 012','系统异常','LogService'),
('4028b88158af03570158af603c16000e',3,'错误代码:404，访问路径:/bi/ds/data/json','superadmin','localhost','2016-11-29 17:17:49 049','系统异常','LogService'),
('4028b88158af03570158af60c1cf000f',3,'错误代码:404，访问路径:/bi/ds/data/json/','superadmin','localhost','2016-11-29 17:18:23 023','系统异常','LogService'),
('4028b88158af03570158af60dbcf0010',3,'错误代码:404，访问路径:/bi/ds/data/json/','superadmin','localhost','2016-11-29 17:18:30 030','系统异常','LogService'),
('4028b88158b3bc850158b3bd74440000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-11-30 13:38:07 007','系统登录','LogService'),
('4028b88158b3bc850158b3e5fd880001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-11-30 14:22:24 024','登录系统','LogService'),
('4028b88158b3bc850158b3f812ae0002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-11-30 14:42:09 009','系统登录','LogService'),
('4028b88158b3bc850158b42fedad0018',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-11-30 15:43:09 009','系统异常','LogService'),
('4028b88158b3bc850158b4307e290019',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-11-30 15:43:46 046','系统异常','LogService'),
('4028b88158b3bc850158b430cc15001a',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-11-30 15:44:06 006','系统异常','LogService'),
('4028b88158b3bc850158b430d5e0001b',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-11-30 15:44:09 009','系统异常','LogService'),
('4028b88158b3bc850158b44ab072001c',3,'错误代码:404，访问路径:/framework/js/select.js','superadmin','localhost','2016-11-30 16:12:23 023','系统异常','LogService'),
('4028b88158b3bc850158b44df1f2001d',3,'错误代码:404，访问路径:/bi/charts/add/step-3','superadmin','localhost','2016-11-30 16:15:56 056','系统异常','LogService'),
('4028b88158b8da450158b8db6dbb0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-01 13:28:58 058','系统登录','LogService'),
('4028b88158b8da450158b91b939d0001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-01 14:39:02 002','登录系统','LogService'),
('4028b88158b8da450158b93a77150002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-01 15:12:46 046','系统登录','LogService'),
('4028b88158b8da450158b9443e190004',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-01 15:23:27 027','退出系统','LogService'),
('4028b88158b8da450158b9445b4b0005',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-01 15:23:34 034','系统登录','LogService'),
('4028b88158b8da450158b94482250006',3,'错误代码:404，访问路径:/ibi/charts','superadmin','localhost','2016-12-01 15:23:44 044','系统异常','LogService'),
('4028b88158b8da450158b946c1370007',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-01 15:26:11 011','退出系统','LogService'),
('4028b88158b8da450158b947210e0008',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-01 15:26:36 036','系统登录','LogService'),
('4028b88158bd92010158bd92a4be0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-02 11:27:34 034','系统登录','LogService'),
('4028b88158bd92010158bdcdeab20001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-02 12:32:18 018','登录系统','LogService'),
('4028b88158bd92010158be010af90002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-02 13:28:09 009','系统登录','LogService'),
('4028b88158bd92010158bed29b2b0007',3,'错误代码:404，访问路径:/bi/charts/add/s4','superadmin','localhost','2016-12-02 17:17:03 003','系统异常','LogService'),
('4028b88158bd92010158bed2a5c00008',3,'错误代码:404，访问路径:/bi/charts/add/s4','superadmin','localhost','2016-12-02 17:17:05 005','系统异常','LogService'),
('4028b88158bd92010158bed2aeba0009',3,'错误代码:404，访问路径:/bi/charts/add/4','superadmin','localhost','2016-12-02 17:17:08 008','系统异常','LogService'),
('4028b88158c282ad0158c28338d10000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-03 10:28:49 049','系统登录','LogService'),
('4028b88158c368660158c36957b10000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-03 14:40:10 010','系统登录','LogService'),
('4028b88158c37f970158c3801d120000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-03 15:05:02 002','系统登录','LogService'),
('4028b88158c3820d0158c38ae5ee0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-03 15:16:49 049','系统登录','LogService'),
('4028b88158c394ca0158c3951f010000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-03 15:27:59 059','系统登录','LogService'),
('4028b88158c394ca0158c39545f20001',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-12-03 15:28:09 009','系统异常','LogService'),
('4028b88158c394ca0158c3ada8600022',3,'错误代码:404，访问路径:/app/charts/icon/bubble.png','superadmin','localhost','2016-12-03 15:54:47 047','系统异常','LogService'),
('4028b88158c394ca0158c3adea370023',3,'错误代码:404，访问路径:/app/charts/icon/bubble.png','superadmin','localhost','2016-12-03 15:55:04 004','系统异常','LogService'),
('4028b88158c3d1460158c3d1f45d0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-03 16:34:26 026','系统登录','LogService'),
('4028b88158c3d1460158c3d5b4fa0001',3,'错误代码:404，访问路径:/app/charts.js','superadmin','localhost','2016-12-03 16:38:32 032','系统异常','LogService'),
('4028b88158c3d1460158c3e102100003',3,'错误代码:404，访问路径:/bi/charts/’utils.js\'','superadmin','localhost','2016-12-03 16:50:53 053','系统异常','LogService'),
('4028b88158c3d1460158c3e102110004',3,'错误代码:404，访问路径:/bi/charts/’utils.js\'','superadmin','localhost','2016-12-03 16:50:53 053','系统异常','LogService'),
('4028b88158c3d1460158c3e5d6ad0005',3,'错误代码:404，访问路径:/bi/charts/$!basePath/app/charts/datasource.js','superadmin','localhost','2016-12-03 16:56:09 009','系统异常','LogService'),
('4028b88158c3d1460158c3e5d8970006',3,'错误代码:404，访问路径:/bi/charts/’$!basePath/app/charts/utils.js\'','superadmin','localhost','2016-12-03 16:56:10 010','系统异常','LogService'),
('4028b88158c3d1460158c3e5d89c0007',3,'错误代码:404，访问路径:/bi/charts/$!basePath/app/charts/datasource.js','superadmin','localhost','2016-12-03 16:56:10 010','系统异常','LogService'),
('4028b88158c3d1460158c3e5d8e70008',3,'错误代码:404，访问路径:/bi/charts/$!basePath/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-03 16:56:10 010','系统异常','LogService'),
('4028b88158c3d1460158c3e5da420009',3,'错误代码:404，访问路径:/bi/charts/’$!basePath/app/charts/utils.js\'','superadmin','localhost','2016-12-03 16:56:10 010','系统异常','LogService'),
('4028b88158c3d1460158c3e60c76000a',3,'错误代码:404，访问路径:/bi/charts/$!basePath/app/charts/datasource.js','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3e60c77000b',3,'错误代码:404，访问路径:/bi/charts/’$!basePath/app/charts/utils.js\'','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3e60c7b000c',3,'错误代码:404，访问路径:/bi/charts/$!basePath/app/charts/datasource.js','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3e60c7d000d',3,'错误代码:404，访问路径:/bi/charts/’$!basePath/app/charts/utils.js\'','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3e60c7f000e',3,'错误代码:404，访问路径:/bi/charts/’$!basePath/app/charts/utils.js\'','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3e60c8b000f',3,'错误代码:404，访问路径:/bi/charts/$!basePath/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3e60c8f0010',3,'错误代码:404，访问路径:/bi/charts/$!basePath/app/charts/datasource.js','superadmin','localhost','2016-12-03 16:56:23 023','系统异常','LogService'),
('4028b88158c3d1460158c3f1bcf20011',3,'错误代码:404，访问路径:/bi/charts/’http:/localhost:8080/jrelax-bi/app/charts/utils.js\'','superadmin','localhost','2016-12-03 17:09:09 009','系统异常','LogService'),
('4028b88158c3d1460158c3f1bfa40012',3,'错误代码:404，访问路径:/bi/charts/’http:/localhost:8080/jrelax-bi/app/charts/utils.js\'','superadmin','localhost','2016-12-03 17:09:10 010','系统异常','LogService'),
('4028b88158cd06060158cd06ebd00000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-05 11:28:52 052','系统登录','LogService'),
('4028b88158cd06060158cd07b6490001',3,'错误代码:404，访问路径:/bi/ds/preview/4028b88158c368660158c36f62c60001','superadmin','localhost','2016-12-05 11:29:44 044','系统异常','LogService'),
('4028b88158cd06060158cd09263c0002',3,'错误代码:404，访问路径:/bi/ds/preview','superadmin','localhost','2016-12-05 11:31:18 018','系统异常','LogService'),
('4028b88158cd06060158cd09538d0003',3,'错误代码:404，访问路径:/bi/ds/preview','superadmin','localhost','2016-12-05 11:31:30 030','系统异常','LogService'),
('4028b88158cd06060158cd09fe930004',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','localhost','2016-12-05 11:32:14 014','系统异常','LogService'),
('4028b88158cd06060158cd09fea10005',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-05 11:32:14 014','系统异常','LogService'),
('4028b88158cd06060158cd0a002a0006',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','localhost','2016-12-05 11:32:14 014','系统异常','LogService'),
('4028b88158cd06060158cd0a00520007',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-05 11:32:14 014','系统异常','LogService'),
('4028b88158cd06060158cd0eec090008',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-05 11:37:37 037','系统登录','LogService'),
('4028b88158cd06060158cd1eecfb000b',3,'错误代码:500，访问路径:/bi/form/design/v2/table','superadmin','localhost','2016-12-05 11:55:05 005','系统异常','LogService'),
('4028b88158cd06060158cd1fe8e0000c',3,'错误代码:500，访问路径:/bi/form/design/v2/table','superadmin','localhost','2016-12-05 11:56:10 010','系统异常','LogService'),
('4028b88158cd06060158cd23a9e6000e',3,'错误代码:400，访问路径:/bi/form/design/v2','superadmin','localhost','2016-12-05 12:00:16 016','系统异常','LogService'),
('4028b88158cd06060158cd23c7f30011',3,'错误代码:500，访问路径:/bi/form/design/v2','superadmin','localhost','2016-12-05 12:00:24 024','系统异常','LogService'),
('4028b88158cd06060158cd2408da0012',3,'错误代码:500，访问路径:/bi/form/design/v2','superadmin','localhost','2016-12-05 12:00:40 040','系统异常','LogService'),
('4028b88158cd06060158cd4bdba60014',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-05 12:44:10 010','登录系统','LogService'),
('4028b88158cd06060158cd648c130015',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-05 13:11:08 008','系统登录','LogService'),
('4028b88158cd06060158cd6cb23a0018',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cd6b08b10016','superadmin','localhost','2016-12-05 13:20:02 002','系统异常','LogService'),
('4028b88158cd06060158cd6d11e30019',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cd6b08b10016','superadmin','localhost','2016-12-05 13:20:27 027','系统异常','LogService'),
('4028b88158cd06060158cd6d2338001b',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cd6b08b10016','superadmin','localhost','2016-12-05 13:20:31 031','系统异常','LogService'),
('4028b88158cd06060158cdc9c16e001e',3,'错误代码:404，访问路径:/index/welcome','superadmin','localhost','2016-12-05 15:01:41 041','系统异常','LogService'),
('4028b88158cd06060158cdcdde1b001f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-05 15:06:10 010','系统异常','LogService'),
('4028b88158cd06060158cdcdde1e0020',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-05 15:06:10 010','系统异常','LogService'),
('4028b88158cd06060158cdcefab40021',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-05 15:07:23 023','系统异常','LogService'),
('4028b88158cd06060158cdcefbc30022',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-05 15:07:23 023','系统异常','LogService'),
('4028b88158cd06060158cde1bde10024',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-05 15:27:53 053','退出系统','LogService'),
('4028b88158d70c3c0158d70cd44e0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-07 10:11:32 032','系统登录','LogService'),
('4028b88158e14fd60158e15032a00000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-09 10:01:19 019','系统登录','LogService'),
('4028b88158fc5b240158fc5bb9a30000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-14 16:03:39 039','系统登录','LogService'),
('4028b88158fc5b240158fc77b0370001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:34:12 012','登录系统','LogService'),
('4028b88158fc5b240158fc7a566f0002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-14 16:37:05 005','系统登录','LogService'),
('4028b88158fc5b240158fc97c6240003',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 17:09:14 014','登录系统','LogService'),
('4028b88159016cbf0159016d23590000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-15 15:40:46 046','系统登录','LogService'),
('4028b88159016cbf0159017648680001',3,'错误代码:404，访问路径:/bs/metadata/4028b88158af03570158af47b68e000b','superadmin','localhost','2016-12-15 15:50:46 046','系统异常','LogService'),
('4028b88159016cbf0159017674180002',3,'错误代码:404，访问路径:/bi/bs/metadata/4028b88158af03570158af47b68e000b','superadmin','localhost','2016-12-15 15:50:57 057','系统异常','LogService'),
('4028b88159016cbf015901779dc60003',3,'错误代码:404，访问路径:/bi/bs/metadata/4028b88158af03570158af47b68e000b','superadmin','localhost','2016-12-15 15:52:13 013','系统异常','LogService'),
('4028b88159017ee70159017f572b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-15 16:00:39 039','系统登录','LogService'),
('4028b881590184650159018664030000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-15 16:08:21 021','系统登录','LogService'),
('4028b881590190e4015901912c260000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-15 16:20:08 008','系统登录','LogService'),
('4028b881590192ea0159019325ab0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-15 16:22:17 017','系统登录','LogService'),
('4028b881590192ea015901af58da0004',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 16:53:05 005','登录系统','LogService'),
('4028b881592476f401592477754d0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:58:45 045','系统登录','LogService'),
('4028b881592476f4015924781c240001',1,'访问用户列表','superadmin','localhost','2016-12-22 10:59:28 028','用户管理','LogService'),
('4028b881592476f40159247aaa420002',1,'访问机构列表','superadmin','localhost','2016-12-22 11:02:15 015','机构管理','LogService'),
('4028b881592476f40159247b4b6d0003',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-22 11:02:57 057','退出系统','LogService'),
('4028b881592476f40159247b539b0004',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 11:02:59 059','系统登录','LogService'),
('4028b881592476f40159247b771b0005',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-22 11:03:08 008','退出系统','LogService'),
('4028b8815925731c015925737a130000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 15:34:02 002','系统登录','LogService'),
('4028b881592575a301592575f7830000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 15:36:45 045','系统登录','LogService'),
('4028b881592575a30159257620580001',1,'访问菜单列表','superadmin','localhost','2016-12-22 15:36:55 055','菜单管理','LogService'),
('4028b881592575a30159257a39f40003',1,'新增菜单：[Id:4028b881592575a30159257a39290002, Name:自定以报表, ParentId:-1]','superadmin','localhost','2016-12-22 15:41:24 024','菜单管理','LogService'),
('4028b881592575a30159257a40770004',1,'访问菜单列表','superadmin','localhost','2016-12-22 15:41:26 026','菜单管理','LogService'),
('4028b881592575a30159257a71420005',1,'访问菜单列表','superadmin','localhost','2016-12-22 15:41:38 038','菜单管理','LogService'),
('4028b881592575a30159257a89080006',1,'编辑菜单名称：[Id:4028b881592575a30159257a39290002, OldName:自定以报表, NewName:自定义报表]','superadmin','localhost','2016-12-22 15:41:44 044','菜单管理','LogService'),
('4028b881592575a30159257a98120007',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-22 15:41:48 048','退出系统','LogService'),
('4028b881592575a30159257aa17c0008',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 15:41:50 050','系统登录','LogService'),
('4028b881592575a3015925a1d0ca0009',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 16:24:38 038','登录系统','LogService'),
('4028b88159299a7b0159299aee9f0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 10:55:36 036','系统登录','LogService'),
('4028b88159299a7b01592a07fb160001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-23 12:54:43 043','登录系统','LogService'),
('4028b88159299a7b01592a1c7b240002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 13:17:06 006','系统登录','LogService'),
('4028b881592a4ecf01592a4f17390000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 14:12:23 023','系统登录','LogService'),
('4028b881592a57ad01592a57f48b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 14:22:04 004','系统登录','LogService'),
('4028b881592a57ad01592a580b090001',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-23 14:22:10 010','系统首页','LogService'),
('4028b881592a57ad01592a5821560002',3,'java.lang.IllegalStateException: Ambiguous handler methods mapped for HTTP path \'http://localhost:8080/jrelax-bi/bi/report/data\': {public java.util.Map com.jrelax.web.controller.bi.BiReportController.data(com.jrelax.orm.query.PageBean), public java.lang.String com.jrelax.web.controller.bi.BiReportDataController.index(org.springframework.ui.Model,com.jrelax.orm.query.PageBean)}','superadmin','0:0:0:0:0:0:0:1','2016-12-23 14:22:15 015','请求出错','LogService'),
('4028b881592a57ad01592a5836f80003',3,'java.lang.IllegalStateException: Ambiguous handler methods mapped for HTTP path \'http://localhost:8080/jrelax-bi/bi/report/data\': {public java.util.Map com.jrelax.web.controller.bi.BiReportController.data(com.jrelax.orm.query.PageBean), public java.lang.String com.jrelax.web.controller.bi.BiReportDataController.index(org.springframework.ui.Model,com.jrelax.orm.query.PageBean)}','superadmin','0:0:0:0:0:0:0:1','2016-12-23 14:22:21 021','请求出错','LogService'),
('4028b881592a57ad01592a5970220004',3,'java.lang.IllegalStateException: Ambiguous handler methods mapped for HTTP path \'http://localhost:8080/jrelax-bi/bi/report/data\': {public java.util.Map com.jrelax.web.controller.bi.BiReportController.data(com.jrelax.orm.query.PageBean), public java.lang.String com.jrelax.web.controller.bi.BiReportDataController.index(org.springframework.ui.Model,com.jrelax.orm.query.PageBean)}','superadmin','0:0:0:0:0:0:0:1','2016-12-23 14:23:41 041','请求出错','LogService'),
('4028b881592a5aa801592a5af2780000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 14:25:20 020','系统登录','LogService'),
('4028b881592a5aa801592a773aa40001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-23 14:56:13 013','登录系统','LogService'),
('4028b881593eab9e01593eac61fa0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-27 13:06:41 041','系统登录','LogService'),
('4028b881593eab9e01593eac8c9c0001',1,'用户：[superadmin] 退出系统','superadmin','localhost','2016-12-27 13:06:52 052','退出系统','LogService'),
('4028b8815943f0a4015943f1955d0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 13:40:23 023','系统登录','LogService'),
('4028b8815944239901594423ee9a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 14:35:22 022','系统登录','LogService'),
('4028b8815944239901594476c91e0001',1,'访问菜单列表','superadmin','localhost','2016-12-28 16:05:52 052','菜单管理','LogService'),
('4028b88159448d0601594495936d0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 16:39:30 030','系统登录','LogService'),
('4028b88159448d06015944bdccfd0001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 17:23:26 026','登录系统','LogService'),
('4028b88159448d06015944eaec300002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 18:12:43 043','系统登录','LogService'),
('4028b88159457eb70159457f14070000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 20:54:33 033','系统登录','LogService'),
('4028b88159457eb70159459b37cb0001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 21:25:17 017','登录系统','LogService'),
('4028b88159457eb70159459ebe250002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 21:29:08 008','系统登录','LogService'),
('4028b8815945c4f9015945c546580000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-28 22:11:13 013','系统登录','LogService'),
('4028b8815967fafc015967fb80ce0000',3,'org.hibernate.exception.SQLGrammarException: error executing work','SYSTEM','0:0:0:0:0:0:0:1','2017-01-04 13:37:32 032','请求出错','LogService'),
('4028b8815967fafc015967fb813a0001',3,'错误代码:500，访问路径:/open/dev/code/step/3','system','localhost','2017-01-04 13:37:32 032','系统异常','LogService'),
('4028b8815967fafc01596805a0c80002',3,'错误代码:404，访问路径:/framework/js/form/form/js','system','localhost','2017-01-04 13:48:36 036','系统异常','LogService'),
('4028b8815967fafc01596805a2290003',3,'错误代码:404，访问路径:/framework/js/form/form/js','system','localhost','2017-01-04 13:48:36 036','系统异常','LogService'),
('4028b8815967fafc01596805b4350004',3,'错误代码:404，访问路径:/framework/js/form/form/js','system','localhost','2017-01-04 13:48:41 041','系统异常','LogService'),
('4028b8815967fafc01596805b5270005',3,'错误代码:404，访问路径:/framework/js/form/form/js','system','localhost','2017-01-04 13:48:41 041','系统异常','LogService'),
('4028b8815967fafc01596805c6cc0006',3,'错误代码:404，访问路径:/framework/js/form/form/js','system','localhost','2017-01-04 13:48:46 046','系统异常','LogService'),
('4028b8815973072b01597308d3250000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-06 17:07:55 055','系统登录','LogService'),
('4028b8815973156701597315b87b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-06 17:22:00 000','系统登录','LogService'),
('4028b88159773faf01597740488d0000',3,'org.hibernate.exception.SQLGrammarException: error executing work','SYSTEM','0:0:0:0:0:0:0:1','2017-01-07 12:46:58 058','请求出错','LogService'),
('4028b88159773faf0159774048900001',3,'错误代码:500，访问路径:/open/dev/code/step/3','system','localhost','2017-01-07 12:46:58 058','系统异常','LogService'),
('4028b8815977ade4015977ae5d2b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-07 14:47:12 012','系统登录','LogService'),
('4028b8815977f53a015977f59ba50000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-07 16:05:01 001','系统登录','LogService'),
('4028b88159780b930159780bec2f0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-07 16:29:24 024','系统登录','LogService'),
('4028b88159780b93015978184d42000e',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2017-01-07 16:42:55 055','系统首页','LogService'),
('4028b88159780b930159781853d2000f',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2017-01-07 16:42:57 057','系统首页','LogService'),
('4028b88159780b9301597818597d0010',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2017-01-07 16:42:58 058','系统首页','LogService'),
('4028b88159780b9301597818600c0011',1,'切换皮肤：[theme: palette]','superadmin','localhost','2017-01-07 16:43:00 000','系统首页','LogService'),
('4028b88159780b930159781863f50012',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2017-01-07 16:43:01 001','系统首页','LogService'),
('4028b88159780b930159781868130013',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2017-01-07 16:43:02 002','系统首页','LogService'),
('4028b8815982008001598200da680000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-09 14:53:31 031','系统登录','LogService'),
('4028b88159820080015982010de60001',1,'访问用户列表','superadmin','localhost','2017-01-09 14:53:44 044','用户管理','LogService'),
('4028b881598200800159820113c40002',1,'访问菜单列表','superadmin','localhost','2017-01-09 14:53:45 045','菜单管理','LogService'),
('4028b88159820080015982013d9a0003',1,'编辑菜单：[Id:4028b881592575a30159257a39290002, Name:自定义报表, ParentId:-1]','superadmin','localhost','2017-01-09 14:53:56 056','菜单管理','LogService'),
('4028b881598200800159820146610004',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-09 14:53:58 058','退出系统','LogService'),
('4028b88159820080015982014be80005',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-09 14:54:00 000','系统登录','LogService'),
('4028b8815982008001598201591f0006',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-09 14:54:03 003','系统登录','LogService'),
('4028b881598200800159820162a00007',1,'访问菜单列表','superadmin','localhost','2017-01-09 14:54:05 005','菜单管理','LogService'),
('4028b88159820080015982017d4e0008',1,'访问菜单列表','superadmin','localhost','2017-01-09 14:54:12 012','菜单管理','LogService'),
('4028b88159820421015982046d5a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-09 14:57:25 025','系统登录','LogService'),
('4028b88159820421015982049e020001',1,'访问菜单列表','superadmin','localhost','2017-01-09 14:57:37 037','菜单管理','LogService'),
('4028b8815982042101598204d7470002',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-09 14:57:52 052','退出系统','LogService'),
('4028b88159826422015982650a230000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-09 16:42:56 056','系统登录','LogService'),
('4028b8815986ded5015986df62230000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-10 13:35:03 003','系统登录','LogService'),
('4028b8815986e0d0015986e129820000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-10 13:37:00 000','系统登录','LogService'),
('4028b8815986e0d0015987110f630001',3,'错误代码:404，访问路径:/app/report/bi.table.js','superadmin','localhost','2017-01-10 14:29:19 019','系统异常','LogService'),
('4028b881598759ad0159875a06660000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-10 15:49:01 001','系统登录','LogService'),
('4028b8815996a846015996a8a4640000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-13 15:09:11 011','系统登录','LogService'),
('4028b88159a5b7ff0159a5bb3c500000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-16 13:23:48 048','系统登录','LogService'),
('4028b88159b070d70159b081b55a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-18 15:36:47 047','系统登录','LogService'),
('4028b88159b0b8760159b0b8cca70000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-18 16:36:58 058','系统登录','LogService'),
('4028b88159b0b8760159b0c18cbd0001',3,'org.springframework.web.method.annotation.MethodArgumentTypeMismatchException: Failed to convert value of type [java.lang.String] to required type [int]; nested exception is java.lang.NumberFormatException: For input string: \"\"','superadmin','0:0:0:0:0:0:0:1','2017-01-18 16:46:31 031','请求出错','LogService'),
('4028b88159b0b8760159b0c374c20002',3,'org.springframework.web.method.annotation.MethodArgumentTypeMismatchException: Failed to convert value of type [java.lang.String] to required type [int]; nested exception is java.lang.NumberFormatException: For input string: \"\"','superadmin','0:0:0:0:0:0:0:1','2017-01-18 16:48:36 036','请求出错','LogService'),
('4028b88159b0ce380159b0ced71a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-18 17:01:02 002','系统登录','LogService'),
('4028b88159b0dbac0159b0dbf5430000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-18 17:15:22 022','系统登录','LogService'),
('4028b88159b0de450159b0df8c9b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-18 17:19:17 017','系统登录','LogService'),
('4028b88159b4e6970159b53ac95c0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-19 13:37:25 025','系统登录','LogService'),
('4028b88159b5499f0159b54a3a150000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-19 13:54:17 017','系统登录','LogService'),
('4028b88159b553ce0159b554b0e40000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-19 14:05:43 043','系统登录','LogService'),
('4028b88159b553ce0159b56199a70001',3,'错误代码:404，访问路径:/bi/datasouce','superadmin','localhost','2017-01-19 14:19:49 049','系统异常','LogService'),
('4028b88159b56e680159b56ebb2a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-19 14:34:10 010','系统登录','LogService'),
('4028b88159b56e680159b56ecd880001',3,'错误代码:404，访问路径:/bi/ds/data/json/4028b88158c394ca0158c3bcb0180024','superadmin','localhost','2017-01-19 14:34:14 014','系统异常','LogService'),
('4028b88159b56e680159b56ecd890002',3,'错误代码:404，访问路径:/bi/ds/data/json/4028b88158c282ad0158c28c61550001','superadmin','localhost','2017-01-19 14:34:14 014','系统异常','LogService'),
('4028b88159b56e680159b56ecdaf0003',3,'错误代码:404，访问路径:/bi/ds/data/json/4028b88158bd92010158be031c820003','superadmin','localhost','2017-01-19 14:34:14 014','系统异常','LogService'),
('4028b88159b56e680159b56ed3a50004',3,'错误代码:404，访问路径:/bi/ds/data/json/4028b88158b8da450158b94836200009','superadmin','localhost','2017-01-19 14:34:16 016','系统异常','LogService'),
('4028b88159b56e680159b570e3db0005',3,'错误代码:404，访问路径:/bi/ds','superadmin','localhost','2017-01-19 14:36:31 031','系统异常','LogService'),
('4028b88159b579800159b57b1f100000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-19 14:47:42 042','系统登录','LogService'),
('4028b88159b9d91f0159b9e7c8520000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 11:24:52 052','系统登录','LogService'),
('4028b88159b9d91f0159b9fbc6c60001',1,'访问菜单列表','superadmin','localhost','2017-01-20 11:46:42 042','菜单管理','LogService'),
('4028b88159b9d91f0159b9fbdad00002',1,'编辑菜单名称：[Id:297ec0504dfb4517014dfb8441740006, OldName:表单管理, NewName:表单管理===========]','superadmin','localhost','2017-01-20 11:46:47 047','菜单管理','LogService'),
('4028b88159b9d91f0159b9fbe3e70003',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-20 11:46:49 049','退出系统','LogService'),
('4028b88159b9d91f0159b9fbe64c0004',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 11:46:50 050','系统登录','LogService'),
('4028b88159b9d91f0159b9fc38d60005',1,'访问菜单列表','superadmin','localhost','2017-01-20 11:47:11 011','菜单管理','LogService'),
('4028b88159b9d91f0159b9fc4aa60006',1,'编辑菜单名称：[Id:297ec0504dfb4517014dfb8441740006, OldName:表单管理===========, NewName:表单管理]','superadmin','localhost','2017-01-20 11:47:16 016','菜单管理','LogService'),
('4028b88159b9d91f0159b9fc52040007',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-20 11:47:18 018','退出系统','LogService'),
('4028b88159b9d91f0159b9fc54460008',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 11:47:18 018','系统登录','LogService'),
('4028b88159b9d91f0159ba281d240009',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-20 12:35:08 008','登录系统','LogService'),
('4028b88159b9d91f0159ba53fe9a000a',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 13:23:03 003','系统登录','LogService'),
('4028b88159b9d91f0159ba716987000b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-20 13:55:11 011','登录系统','LogService'),
('4028b88159ba79e00159ba7a69490000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 14:05:01 001','系统登录','LogService'),
('4028b88159bac55b0159bac5acfb0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 15:27:14 014','系统登录','LogService'),
('4028b88159bacd6b0159bacdbac40000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 15:36:01 001','系统登录','LogService'),
('4028b88159badecd0159badf2d220000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 15:55:05 005','系统登录','LogService'),
('4028b88159bae9e30159baea2b160000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 16:07:05 005','系统登录','LogService'),
('4028b88159baf41f0159baf4df9c0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 16:18:47 047','系统登录','LogService'),
('4028b88159bb1f7c0159bb2015a60000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 17:05:59 059','系统登录','LogService'),
('4028b88159bc3e1a0159bc3ea5020000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-20 22:18:59 059','系统登录','LogService'),
('4028b88159bc3e1a0159bc67a3f40001',3,'错误代码:404，访问路径:/framework/plugins/slider/bootstrap-slider.css','superadmin','localhost','2017-01-20 23:03:45 045','系统异常','LogService'),
('4028b88159bc3e1a0159bc67a8a10002',3,'错误代码:404，访问路径:/framework/plugins/slider/bootstrap-slider.css','superadmin','localhost','2017-01-20 23:03:47 047','系统异常','LogService'),
('4028b88159bc3e1a0159bd19238d0003',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-21 02:17:38 038','退出系统','LogService'),
('4028b88159bd1bc70159bd1f0e930000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-21 02:24:06 006','系统登录','LogService'),
('4028b88159bd1bc70159bd2305b50001',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-21 02:28:26 026','退出系统','LogService'),
('4028b88159c968040159c968426a0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-23 11:39:30 030','系统登录','LogService'),
('4028b88159c968040159c9685fd00001',1,'访问菜单列表','superadmin','localhost','2017-01-23 11:39:37 037','菜单管理','LogService'),
('4028b88159c968040159c9688ef50002',1,'删除角色：[Id:4028388148ac878b0148ac8820090000]','superadmin','localhost','2017-01-23 11:39:49 049','菜单管理','LogService'),
('4028b88159c968040159c9689e1d0003',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-23 11:39:53 053','退出系统','LogService'),
('4028b88159c968040159c9689e640004',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-23 11:39:53 053','系统登录','LogService'),
('4028b88159c968040159c9690c0e0005',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-23 11:40:21 021','退出系统','LogService'),
('4028b88159c96adc0159c96b25eb0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-23 11:42:39 039','系统登录','LogService'),
('4028b88159c96adc0159c96b3b5c0001',1,'访问用户列表','superadmin','localhost','2017-01-23 11:42:45 045','用户管理','LogService'),
('4028b88159c96adc0159c96b688e0002',1,'删除用户：[Id:402881ee54eff98b0154f02300670083,402881ee547f564d01547f7e24910031]','superadmin','localhost','2017-01-23 11:42:56 056','用户管理','LogService'),
('4028b88159c96adc0159c96bc8640003',1,'访问机构列表','superadmin','localhost','2017-01-23 11:43:21 021','机构管理','LogService'),
('4028b88159c96adc0159c96bdde20004',1,'删除机构：[Id:402885b558f0a53e0158f0b3303a0007]','superadmin','localhost','2017-01-23 11:43:26 026','机构管理','LogService'),
('4028b88159c96adc0159c96be4990005',1,'访问机构列表','superadmin','localhost','2017-01-23 11:43:28 028','机构管理','LogService'),
('4028b88159c96adc0159c96bf2340006',1,'访问角色列表','superadmin','localhost','2017-01-23 11:43:31 031','角色管理','LogService'),
('4028b88159c96adc0159c96c0c730007',1,'删除角色：[Id:402881ee54eff98b0154f01a1b890059]','superadmin','localhost','2017-01-23 11:43:38 038','角色管理','LogService'),
('4028b88159c96adc0159c96d83430008',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2017-01-23 11:45:14 014','请求出错','LogService'),
('4028b88159c96adc0159c96da1ff0009',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-23 11:45:22 022','退出系统','LogService'),
('4028b88159c96adc0159c96da8b8000a',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-23 11:45:24 024','系统登录','LogService'),
('4028b88159c96adc0159c96dbadb000b',1,'用户：[superadmin] 退出系统','superadmin','localhost','2017-01-23 11:45:28 028','退出系统','LogService'),
('4028b88159c96adc0159c96de24c000c',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2017-01-23 11:45:38 038','系统登录','LogService'),
('8af99cac58e359df0158e35b9e170000',1,'用户：[superadmin] 成功登录系统','superadmin','10.121.28.44','2016-12-09 19:33:02 002','系统登录','LogService'),
('8af99cac58e359df0158e35c00df0001',1,'用户：[superadmin] 成功登录系统','superadmin','10.121.58.43','2016-12-09 19:33:27 027','系统登录','LogService'),
('8af99cac58e359df0158e35c39b70002',1,'切换布局：[layout: ${layout}]','superadmin','10.121.58.43','2016-12-09 19:33:41 041','系统首页','LogService'),
('8af99cac58e359df0158e35ce9430003',1,'访问机构列表','superadmin','10.121.58.43','2016-12-09 19:34:26 026','机构管理','LogService'),
('8af99cac58e359df0158e35cec070004',1,'访问用户列表','superadmin','10.121.58.43','2016-12-09 19:34:27 027','用户管理','LogService'),
('8af99cac58e359df0158e35d0a180005',1,'访问角色列表','superadmin','10.121.58.43','2016-12-09 19:34:35 035','角色管理','LogService'),
('8af99cac58e359df0158e35d0bb40006',1,'访问菜单列表','superadmin','10.121.58.43','2016-12-09 19:34:35 035','菜单管理','LogService'),
('8af99cac58e359df0158e35d33400007',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','10.121.58.43','2016-12-09 19:34:45 045','系统异常','LogService'),
('faf185be591f696701591f6a42b60000',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 11:26:14 014','系统异常','LogService'),
('faf185be591f696701591f6a432b0001',3,'错误代码:404，访问路径:/framework/css/main.css','system','localhost','2016-12-21 11:26:14 014','系统异常','LogService'),
('faf185be591f696701591f6a47d40002',3,'错误代码:404，访问路径:/framework/img/logo.png','system','localhost','2016-12-21 11:26:16 016','系统异常','LogService'),
('faf185be591f696701591f6a482e0003',3,'错误代码:404，访问路径:/framework/css/skins/palette.css','system','localhost','2016-12-21 11:26:16 016','系统异常','LogService'),
('faf185be591f696701591f6a48300004',3,'错误代码:404，访问路径:/framework/css/font-awesome.css','system','localhost','2016-12-21 11:26:16 016','系统异常','LogService'),
('faf185be591f696701591f6a4bbf0005',3,'错误代码:404，访问路径:/framework/css/animate.min.css','system','localhost','2016-12-21 11:26:17 017','系统异常','LogService'),
('faf185be591f696701591f6a4ca20006',3,'错误代码:404，访问路径:/framework/bootstrap/css/bootstrap.min.css','system','localhost','2016-12-21 11:26:17 017','系统异常','LogService'),
('faf185be591f696701591f6a4d090007',3,'错误代码:404，访问路径:/framework/css/simple-line-icons.css','system','localhost','2016-12-21 11:26:17 017','系统异常','LogService'),
('faf185be591f696701591f6a50770008',3,'错误代码:404，访问路径:/framework/css/themify-icons.css','system','localhost','2016-12-21 11:26:18 018','系统异常','LogService'),
('faf185be591f696701591f6a514d0009',3,'错误代码:404，访问路径:/framework/plugins/jquery-1.11.1.min.js','system','localhost','2016-12-21 11:26:18 018','系统异常','LogService'),
('faf185be591f696701591f6a5159000a',3,'错误代码:404，访问路径:/framework/plugins/jquery-1.11.1.min.js','system','localhost','2016-12-21 11:26:18 018','系统异常','LogService'),
('faf185be591f696701591f6a5162000b',3,'错误代码:404，访问路径:/framework/plugins/jquery.form.js','system','localhost','2016-12-21 11:26:18 018','系统异常','LogService'),
('faf185be591f696701591f6a5165000c',3,'错误代码:404，访问路径:/framework/plugins/jquery.form.js','system','localhost','2016-12-21 11:26:18 018','系统异常','LogService'),
('faf185be591f696701591f6a5169000d',3,'错误代码:404，访问路径:/framework/css/signin/styles.css','system','localhost','2016-12-21 11:26:18 018','系统异常','LogService'),
('faf185be591f696701591f6a5ad7000e',3,'错误代码:404，访问路径:/framework/plugins/jquery.form.js','system','localhost','2016-12-21 11:26:20 020','系统异常','LogService'),
('faf185be591f696701591f6a5b01000f',3,'错误代码:404，访问路径:/framework/plugins/jquery-1.11.1.min.js','system','localhost','2016-12-21 11:26:20 020','系统异常','LogService'),
('faf185be591f696701591f6a5b070010',3,'错误代码:404，访问路径:/framework/css/signin/styles.css','system','localhost','2016-12-21 11:26:20 020','系统异常','LogService'),
('faf185be591fe5a601591fe607dc0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 13:41:26 026','系统登录','LogService'),
('faf185be591fe5a601591fe7fbe40001',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-12-21 13:43:34 034','系统首页','LogService'),
('faf185be591fe5a601591fe86bbc0002',3,'错误代码:404，访问路径:/office/email/inside/send','superadmin','localhost','2016-12-21 13:44:02 002','系统异常','LogService'),
('faf185be591fe5a601592009ef5a0004',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-21 14:20:39 039','登录系统','LogService'),
('faf185be591fe5a60159200ebacd0005',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 14:25:53 053','系统登录','LogService'),
('faf185be591fe5a60159200ebcdf0006',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','localhost','2016-12-21 14:25:53 053','系统异常','LogService'),
('faf185be591fe5a60159200ebcfe0007',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-21 14:25:53 053','系统异常','LogService'),
('faf185be591fe5a60159200ebd0e0008',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-21 14:25:53 053','系统异常','LogService'),
('faf185be591fe5a60159200ebd1e0009',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-21 14:25:53 053','系统异常','LogService'),
('faf185be591fe5a60159200ebd3d000a',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-21 14:25:53 053','系统异常','LogService'),
('faf185be591fe5a60159200ec1ee000b',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-21 14:25:55 055','系统异常','LogService'),
('faf185be591fe5a60159200f0f92000c',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-21 14:26:15 015','系统异常','LogService'),
('faf185be591fe5a60159200f0f92000d',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-21 14:26:15 015','系统异常','LogService'),
('faf185be591fe5a60159200f0f92000e',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','localhost','2016-12-21 14:26:15 015','系统异常','LogService'),
('faf185be591fe5a60159200f0fb2000f',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-21 14:26:15 015','系统异常','LogService'),
('faf185be591fe5a60159200f0fc10010',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-21 14:26:15 015','系统异常','LogService'),
('faf185be591fe5a60159200f0fd10011',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-21 14:26:15 015','系统异常','LogService'),
('faf185be591fe5a60159200fce560012',3,'错误代码:404，访问路径:/','superadmin','localhost','2016-12-21 14:27:03 003','系统异常','LogService'),
('faf185be591fe5a60159200fd9100013',3,'错误代码:404，访问路径:/','superadmin','localhost','2016-12-21 14:27:06 006','系统异常','LogService'),
('faf185be591fe5a60159200ff9da0014',3,'错误代码:404，访问路径:/','superadmin','localhost','2016-12-21 14:27:15 015','系统异常','LogService'),
('faf185be591fe5a6015920127db30015',3,'错误代码:404，访问路径:/flow/form/save','superadmin','localhost','2016-12-21 14:29:59 059','系统异常','LogService'),
('faf185be591fe5a6015920129d140016',3,'错误代码:404，访问路径:/flow/form/save','superadmin','localhost','2016-12-21 14:30:07 007','系统异常','LogService'),
('faf185be591fe5a601592015eb980018',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-21 14:33:44 044','系统首页','LogService'),
('faf185be591fe5a601592018aa9d0019',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-21 14:36:44 044','系统首页','LogService'),
('faf185be591fe5a60159201e2eab001a',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-21 14:42:46 046','系统首页','LogService'),
('faf185be591fe5a601592028fc5b001b',3,'错误代码:404，访问路径:/office/email/outside/send','superadmin','localhost','2016-12-21 14:54:34 034','系统异常','LogService'),
('faf185be591fe5a601592031b8d3001c',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 15:04:06 006','系统登录','LogService'),
('faf185be591fe5a6015920323e06001d',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-21 15:04:40 040','系统首页','LogService'),
('faf185be591fe5a60159203243d2001e',1,'切换皮肤：[theme: palette.7]','superadmin','localhost','2016-12-21 15:04:42 042','系统首页','LogService'),
('faf185be591fe5a6015920324add001f',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2016-12-21 15:04:43 043','系统首页','LogService'),
('faf185be591fe5a60159203251e60020',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-12-21 15:04:45 045','系统首页','LogService'),
('faf185be591fe5a60159203258970021',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-12-21 15:04:47 047','系统首页','LogService'),
('faf185be591fe5a6015920325d060022',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-12-21 15:04:48 048','系统首页','LogService'),
('faf185be591fe5a601592032629e0023',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-12-21 15:04:50 050','系统首页','LogService'),
('faf185be591fe5a60159203264ff0024',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-21 15:04:50 050','系统首页','LogService'),
('faf185be591fe5a601592032a38c0025',1,'访问机构列表','superadmin','localhost','2016-12-21 15:05:06 006','机构管理','LogService'),
('faf185be591fe5a601592032d5e80026',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-21 15:05:19 019','系统首页','LogService'),
('faf185be591fe5a601592032f0560027',1,'访问机构列表','superadmin','localhost','2016-12-21 15:05:26 026','机构管理','LogService'),
('faf185be591fe5a601592032fa840028',1,'访问用户列表','superadmin','localhost','2016-12-21 15:05:28 028','用户管理','LogService'),
('faf185be591fe5a60159204ce9350029',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-21 15:33:48 048','登录系统','LogService'),
('faf185be591fe5a60159204fb2f3002a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-21 15:36:51 051','登录系统','LogService'),
('faf185be591fe5a60159206361cb002b',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 15:58:21 021','系统登录','LogService'),
('faf185be591fe5a60159206690c2002c',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 16:01:49 049','系统异常','LogService'),
('faf185be591fe5a6015920669979002d',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 16:01:51 051','系统异常','LogService'),
('faf185be591fe5a601592066a2d3002e',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 16:01:54 054','系统异常','LogService'),
('faf185be591fe5a601592066bfb0002f',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 16:02:01 001','系统异常','LogService'),
('faf185be591fe5a601592066d21e0030',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 16:02:06 006','系统异常','LogService'),
('faf185be591fe5a601592066d8f80031',3,'错误代码:404，访问路径:/','system','localhost','2016-12-21 16:02:08 008','系统异常','LogService'),
('faf185be591fe5a601592067250a0032',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 16:02:27 027','系统登录','LogService'),
('faf185be591fe5a6015920674ce30033',3,'错误代码:404，访问路径:/','superadmin','localhost','2016-12-21 16:02:37 037','系统异常','LogService'),
('faf185be591fe5a6015920696dc70034',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-21 16:04:57 057','系统异常','LogService'),
('faf185be591fe5a601592069902f0035',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-21 16:05:06 006','系统异常','LogService'),
('faf185be59206ccb0159206d5afa0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 16:09:14 014','系统登录','LogService'),
('faf185be59206ccb0159206daef60001',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 16:09:36 036','系统登录','LogService'),
('faf185be59206ccb0159206dc1ae0002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 16:09:41 041','系统登录','LogService'),
('faf185be59206ccb0159206ddf960003',3,'错误代码:404，访问路径:/','superadmin','localhost','2016-12-21 16:09:48 048','系统异常','LogService'),
('faf185be59206ccb0159206e0e560004',3,'错误代码:404，访问路径:/bi','superadmin','localhost','2016-12-21 16:10:00 000','系统异常','LogService'),
('faf185be59206ccb0159206ee3c50005',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 16:10:55 055','系统登录','LogService'),
('faf185be592079ae0159207b597c0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 16:24:31 031','系统登录','LogService'),
('faf185be592079ae0159207ff61c0001',3,'错误代码:404，访问路径:/bi/form/drag','superadmin','localhost','2016-12-21 16:29:34 034','系统异常','LogService'),
('faf185be592079ae015920801d970002',3,'错误代码:404，访问路径:/bi/drag','superadmin','localhost','2016-12-21 16:29:44 044','系统异常','LogService'),
('faf185be592079ae0159208089420003',3,'错误代码:404，访问路径:/bi/char/charts/drag','superadmin','localhost','2016-12-21 16:30:11 011','系统异常','LogService'),
('faf185be592079ae0159208140900004',3,'错误代码:404，访问路径:/bi/char/charts/drag','superadmin','localhost','2016-12-21 16:30:58 058','系统异常','LogService'),
('faf185be592079ae015920a6419f0005',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-21 17:11:23 023','系统异常','LogService'),
('faf185be592079ae015920a641a90006',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:11:23 023','系统异常','LogService'),
('faf185be592079ae015920a6461a0007',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:11:24 024','系统异常','LogService'),
('faf185be592079ae015920a646800008',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-21 17:11:25 025','系统异常','LogService'),
('faf185be592079ae015920a646d80009',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:11:25 025','系统异常','LogService'),
('faf185be592079ae015920a64a7a000a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:11:26 026','系统异常','LogService'),
('faf185be592079ae015920a64abd000b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:11:26 026','系统异常','LogService'),
('faf185be592079ae015920a68917000c',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:11:42 042','系统异常','LogService'),
('faf185be592079ae015920a71591000d',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:12:18 018','系统异常','LogService'),
('faf185be592079ae015920a9778a000e',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-21 17:14:54 054','系统异常','LogService'),
('faf185be592079ae015920a97c43000f',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:14:55 055','系统异常','LogService'),
('faf185be592079ae015920a97c6f0010',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:14:55 055','系统异常','LogService'),
('faf185be592079ae015920a97cde0011',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:14:55 055','系统异常','LogService'),
('faf185be592079ae015920a980e70012',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:14:56 056','系统异常','LogService'),
('faf185be592079ae015920a9813a0013',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-21 17:14:56 056','系统异常','LogService'),
('faf185be592079ae015920a981a70014',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:14:56 056','系统异常','LogService'),
('faf185be592079ae015920ab448d0015',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-21 17:16:52 052','系统异常','LogService'),
('faf185be592079ae015920ab44c70016',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-21 17:16:52 052','系统异常','LogService'),
('faf185be592079ae015920ab49990017',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:16:53 053','系统异常','LogService'),
('faf185be592079ae015920ab49a80018',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:16:53 053','系统异常','LogService'),
('faf185be592079ae015920ab4a270019',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:16:53 053','系统异常','LogService'),
('faf185be592079ae015920ab4daa001a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:16:54 054','系统异常','LogService'),
('faf185be592079ae015920ab4dac001b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:16:54 054','系统异常','LogService'),
('faf185be592079ae015920ab4ef3001c',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-21 17:16:54 054','系统异常','LogService'),
('faf185be592079ae015920ab523f001d',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:16:55 055','系统异常','LogService'),
('faf185be592079ae015920ab7c65001e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab7c6c001f',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab7c6d0020',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab7c6e0021',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab7c7a0022',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab7ccd0023',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab7cfd0024',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:17:06 006','系统异常','LogService'),
('faf185be592079ae015920ab9c430025',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:17:14 014','系统异常','LogService'),
('faf185be592079ae015920ac2fd80026',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js/','superadmin','localhost','2016-12-21 17:17:52 052','系统异常','LogService'),
('faf185be592079ae015920ac479c0027',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:17:58 058','系统异常','LogService'),
('faf185be592079ae015920b2f63e0028',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:25:16 016','系统异常','LogService'),
('faf185be592079ae015920b32ee60029',3,'错误代码:404，访问路径:/tpl/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:25:30 030','系统异常','LogService'),
('faf185be592079ae015920b3357a002a',3,'错误代码:404，访问路径:/tpl/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:25:32 032','系统异常','LogService'),
('faf185be5920beb6015920bf1e700000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-21 17:38:33 033','系统登录','LogService'),
('faf185be5920beb6015920bf210c0001',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-21 17:38:33 033','系统异常','LogService'),
('faf185be5920beb6015920bf210d0002',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-21 17:38:33 033','系统异常','LogService'),
('faf185be5920beb6015920bf25ec0003',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:38:35 035','系统异常','LogService'),
('faf185be5920beb6015920bf26000004',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-21 17:38:35 035','系统异常','LogService'),
('faf185be5920beb6015920bf26070005',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-21 17:38:35 035','系统异常','LogService'),
('faf185be5920beb6015920bf2a540006',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:38:36 036','系统异常','LogService'),
('faf185be5920beb6015920bf2a9d0007',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:38:36 036','系统异常','LogService'),
('faf185be5920beb6015920bf2d490008',3,'错误代码:404，访问路径:/tpl/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:38:37 037','系统异常','LogService'),
('faf185be5920beb6015920bf32bb0009',3,'错误代码:404，访问路径:/tpl/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:38:38 038','系统异常','LogService'),
('faf185be5920beb6015920c01bce000a',3,'错误代码:404，访问路径:/tpl/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-21 17:39:38 038','系统异常','LogService'),
('faf185be592417f501592419646f0000',3,'错误代码:404，访问路径:/','system','localhost','2016-12-22 09:16:01 001','系统异常','LogService'),
('faf185be592417f50159241980e70001',3,'错误代码:404，访问路径:/','system','localhost','2016-12-22 09:16:08 008','系统异常','LogService'),
('faf185be592417f501592419cfd90002',3,'错误代码:404，访问路径:/bi','system','localhost','2016-12-22 09:16:28 028','系统异常','LogService'),
('faf185be592417f501592419da360003',3,'错误代码:404，访问路径:/','system','localhost','2016-12-22 09:16:31 031','系统异常','LogService'),
('faf185be592417f50159241aabdd0004',3,'错误代码:404，访问路径:/','system','localhost','2016-12-22 09:17:24 024','系统异常','LogService'),
('faf185be592417f50159241b4eff0005',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:18:06 006','系统登录','LogService'),
('faf185be592417f50159241b7db20006',3,'错误代码:404，访问路径:/index/bi/chart/drag','superadmin','localhost','2016-12-22 09:18:18 018','系统异常','LogService'),
('faf185be592417f50159241c15b60007',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:18:57 057','系统异常','LogService'),
('faf185be592417f50159241c15f40008',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:18:57 057','系统异常','LogService'),
('faf185be592417f50159241c15f70009',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:18:57 057','系统异常','LogService'),
('faf185be592417f50159241c1608000a',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:18:57 057','系统异常','LogService'),
('faf185be592417f50159241c1612000b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:18:57 057','系统异常','LogService'),
('faf185be592417f50159241c162e000c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:18:57 057','系统异常','LogService'),
('faf185be592417f50159241c591e000d',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:19:14 014','系统异常','LogService'),
('faf185be592417f50159241c5923000e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:19:14 014','系统异常','LogService'),
('faf185be592417f50159241c5947000f',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:19:14 014','系统异常','LogService'),
('faf185be592417f50159241c594f0010',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:19:14 014','系统异常','LogService'),
('faf185be592417f50159241c59520011',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:19:14 014','系统异常','LogService'),
('faf185be592417f50159241c59910012',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:19:14 014','系统异常','LogService'),
('faf185be592417f50159241c5e4a0013',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:19:16 016','系统异常','LogService'),
('faf185be59241ecc0159241f56660000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:22:30 030','系统登录','LogService'),
('faf185be59241ecc0159241f599b0001',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:22:31 031','系统异常','LogService'),
('faf185be59241ecc0159241f59a20002',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:22:31 031','系统异常','LogService'),
('faf185be59241ecc0159241f5dd00003',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:22:32 032','系统异常','LogService'),
('faf185be59241ecc0159241f5e940004',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:22:32 032','系统异常','LogService'),
('faf185be59241ecc0159241f5eda0005',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:22:32 032','系统异常','LogService'),
('faf185be59241ecc0159241f63610006',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:22:33 033','系统异常','LogService'),
('faf185be59241ecc0159241f64840007',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:22:34 034','系统异常','LogService'),
('faf185be59241ecc0159241fe64d0008',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159241fe6700009',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159241fe68b000a',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159241fe68f000b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159241fe6a5000c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159241fe703000d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159241fe70a000e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:23:07 007','系统异常','LogService'),
('faf185be59241ecc0159242008ff000f',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc0159242009380010',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc0159242009450011',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc01592420094c0012',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc0159242009520013',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc015924200a7b0014',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc015924200a9c0015',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:23:16 016','系统异常','LogService'),
('faf185be59241ecc01592420efd30016',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:24:15 015','系统登录','LogService'),
('faf185be59241ecc01592420f1500017',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:24:15 015','系统异常','LogService'),
('faf185be59241ecc01592420f19a0018',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:24:15 015','系统异常','LogService'),
('faf185be59241ecc01592420f1a70019',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:24:15 015','系统异常','LogService'),
('faf185be59241ecc01592420f1b0001a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:24:15 015','系统异常','LogService'),
('faf185be59241ecc01592420f1b2001b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:24:15 015','系统异常','LogService'),
('faf185be59241ecc01592420f278001c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:24:16 016','系统异常','LogService'),
('faf185be59241ecc01592420f2c4001d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:24:16 016','系统异常','LogService'),
('faf185be59241ecc015924211248001e',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:24:24 024','系统异常','LogService'),
('faf185be59241ecc015924211253001f',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:24:24 024','系统异常','LogService'),
('faf185be59241ecc0159242112730020',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:24:24 024','系统异常','LogService'),
('faf185be59241ecc0159242112790021',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:24:24 024','系统异常','LogService'),
('faf185be59241ecc01592421128b0022',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:24:24 024','系统异常','LogService'),
('faf185be59241ecc0159242112a90023',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:24:24 024','系统异常','LogService'),
('faf185be59241ecc0159242116fa0024',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:24:25 025','系统异常','LogService'),
('faf185be59241ecc01592422716f0025',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:25:54 054','系统异常','LogService'),
('faf185be59241ecc0159242271970026',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:25:54 054','系统异常','LogService'),
('faf185be59241ecc0159242276390027',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:25:55 055','系统异常','LogService'),
('faf185be59241ecc0159242276430028',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:25:55 055','系统异常','LogService'),
('faf185be59241ecc0159242276570029',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:25:55 055','系统异常','LogService'),
('faf185be59241ecc015924227ade002a',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:25:56 056','系统异常','LogService'),
('faf185be59241ecc015924227b0d002b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:25:56 056','系统异常','LogService'),
('faf185be59241ecc015924227b1c002c',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:25:56 056','系统异常','LogService'),
('faf185be59241ecc015924227f25002d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:25:57 057','系统异常','LogService'),
('faf185be59241ecc015924229396002e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:26:02 002','系统异常','LogService'),
('faf185be59241ecc0159242293a4002f',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:26:02 002','系统异常','LogService'),
('faf185be59241ecc0159242293b10030',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:26:02 002','系统异常','LogService'),
('faf185be59241ecc0159242293b50031',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:26:02 002','系统异常','LogService'),
('faf185be59241ecc0159242293bb0032',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:26:02 002','系统异常','LogService'),
('faf185be59241ecc01592422944c0033',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:26:03 003','系统异常','LogService'),
('faf185be59241ecc0159242294680034',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:26:03 003','系统异常','LogService'),
('faf185be59241ecc01592422a12b0035',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422a12d0036',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422a12e0037',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422a1430038',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422a1450039',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422a188003a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422a1bd003b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:26:06 006','系统异常','LogService'),
('faf185be59241ecc01592422b5bb003c',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:26:11 011','系统异常','LogService'),
('faf185be5924239701592423dd4e0000',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:27:27 027','系统异常','LogService'),
('faf185be5924239701592423e4b10001',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:27:29 029','系统异常','LogService'),
('faf185be5924239701592423f5a80002',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:27:33 033','系统异常','LogService'),
('faf185be5924239701592427fef20003',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:31:58 058','系统异常','LogService'),
('faf185be592423970159242807240004',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:32:00 000','系统异常','LogService'),
('faf185be592423970159242807720005',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:32:00 000','系统异常','LogService'),
('faf185be59242397015924280bf30006',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:01 001','系统异常','LogService'),
('faf185be59242397015924280bf30007',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:01 001','系统异常','LogService'),
('faf185be59242397015924280c430008',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:32:01 001','系统异常','LogService'),
('faf185be59242397015924280c520009',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:01 001','系统异常','LogService'),
('faf185be59242397015924280ec1000a',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be59242397015924280ecc000b',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be59242397015924280ed2000c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be59242397015924280edd000d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be59242397015924280ee3000e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be5924239701592428101a000f',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be592423970159242810a70010',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:02 002','系统异常','LogService'),
('faf185be592423970159242814840011',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be592423970159242815130012',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be592423970159242815500013',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be592423970159242815580014',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be5924239701592428155f0015',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be592423970159242815650016',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be5924239701592428156e0017',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:32:03 003','系统异常','LogService'),
('faf185be5924239701592428a8f60018',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:32:41 041','系统登录','LogService'),
('faf185be5924239701592428ad600019',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:32:42 042','系统异常','LogService'),
('faf185be5924239701592428adaf001a',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:32:42 042','系统异常','LogService'),
('faf185be5924239701592428adb3001b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:42 042','系统异常','LogService'),
('faf185be5924239701592428adb5001c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:32:42 042','系统异常','LogService'),
('faf185be5924239701592428adbe001d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:42 042','系统异常','LogService'),
('faf185be5924239701592428afdd001e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:32:43 043','系统异常','LogService'),
('faf185be5924239701592428afe4001f',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:32:43 043','系统异常','LogService'),
('faf185be5924239701592429cf420020',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:33:56 056','系统异常','LogService'),
('faf185be5924239701592429cf4b0021',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:33:56 056','系统异常','LogService'),
('faf185be5924239701592429d3870022',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:33:58 058','系统异常','LogService'),
('faf185be5924239701592429d3b90023',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:33:58 058','系统异常','LogService'),
('faf185be5924239701592429d3c10024',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:33:58 058','系统异常','LogService'),
('faf185be5924239701592429f17c0025',3,'错误代码:404，访问路径:/resources/framework/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:34:05 005','系统异常','LogService'),
('faf185be592423970159242ad1c00026',3,'错误代码:404，访问路径:/framework/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:35:03 003','系统异常','LogService'),
('faf185be592423970159242b68fb0027',3,'错误代码:404，访问路径:/framework/res/javascripts','superadmin','localhost','2016-12-22 09:35:41 041','系统异常','LogService'),
('faf185be592423970159242b7ee60028',3,'错误代码:404，访问路径:/framework/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:35:47 047','系统异常','LogService'),
('faf185be592423970159242df9fe0029',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:38:30 030','系统异常','LogService'),
('faf185be592423970159242df9fe002a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:38:30 030','系统异常','LogService'),
('faf185be592423970159242dfda5002b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:38:30 030','系统异常','LogService'),
('faf185be592423970159242dfe4d002c',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:38:31 031','系统异常','LogService'),
('faf185be592423970159242dfe63002d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:38:31 031','系统异常','LogService'),
('faf185be592423970159242dfe72002e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:38:31 031','系统异常','LogService'),
('faf185be59242ebc0159242f51890000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:39:57 057','系统登录','LogService'),
('faf185be59242ebc0159242f54770001',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:39:58 058','系统异常','LogService'),
('faf185be59242ebc0159242f54820002',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:39:58 058','系统异常','LogService'),
('faf185be59242ebc0159242f59400003',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:39:59 059','系统异常','LogService'),
('faf185be59242ebc0159242f59b90004',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:40:00 000','系统异常','LogService'),
('faf185be59242ebc0159242f59fe0005',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:40:00 000','系统异常','LogService'),
('faf185be59242ebc0159242f5e3f0006',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:40:01 001','系统异常','LogService'),
('faf185be59242ebc0159242f5e4c0007',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:40:01 001','系统异常','LogService'),
('faf185be59242ebc0159242f5e980008',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:40:01 001','系统异常','LogService'),
('faf185be59242ebc0159242f626e0009',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:40:02 002','系统异常','LogService'),
('faf185be59242ebc0159242f62b9000a',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:40:02 002','系统异常','LogService'),
('faf185be59242ebc0159242f62c0000b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:40:02 002','系统异常','LogService'),
('faf185be59242ebc0159242f62c2000c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:40:02 002','系统异常','LogService'),
('faf185be59242ebc0159242f62c8000d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:40:02 002','系统异常','LogService'),
('faf185be59242ebc0159242f6701000e',3,'错误代码:404，访问路径:/framework/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:40:03 003','系统异常','LogService'),
('faf185be59242ebc0159242f6f79000f',3,'错误代码:404，访问路径:/framework/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:40:05 005','系统异常','LogService'),
('faf185be59242ebc015924314e9f0010',3,'错误代码:404，访问路径:/framework/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:42:08 008','系统异常','LogService'),
('faf185be59242ebc01592434663f0011',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:45:30 030','系统异常','LogService'),
('faf185be59242ebc015924346b100012',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:32 032','系统异常','LogService'),
('faf185be59242ebc015924346b2d0013',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:45:32 032','系统异常','LogService'),
('faf185be59242ebc015924346b4f0014',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:32 032','系统异常','LogService'),
('faf185be59242ebc015924346fcd0015',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:33 033','系统异常','LogService'),
('faf185be59242ebc015924346fd20016',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:33 033','系统异常','LogService'),
('faf185be59242ebc015924346ff00017',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:33 033','系统异常','LogService'),
('faf185be59242ebc01592434735a0018',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc0159243473b60019',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc015924347412001a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc015924347418001b',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc01592434741b001c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc01592434741f001d',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc015924347429001e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:34 034','系统异常','LogService'),
('faf185be59242ebc01592434800f001f',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc0159243480170020',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc0159243480190021',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc01592434801a0022',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc01592434801a0023',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc0159243480950024',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc0159243480a50025',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:37 037','系统异常','LogService'),
('faf185be59242ebc0159243486800026',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:45:39 039','系统异常','LogService'),
('faf185be59242ebc0159243486810027',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:45:39 039','系统异常','LogService'),
('faf185be59242ebc0159243486950028',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:39 039','系统异常','LogService'),
('faf185be59242ebc0159243486960029',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:45:39 039','系统异常','LogService'),
('faf185be59242ebc0159243486a2002a',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:39 039','系统异常','LogService'),
('faf185be59242ebc01592434b704002b',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/sample.css','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be59242ebc01592434b713002c',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.js','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be59242ebc01592434b713002d',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be59242ebc01592434b715002e',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be59242ebc01592434b720002f',3,'错误代码:404，访问路径:/bi/charts/res/stylesheets/jquery.gridly.css','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be59242ebc01592434b74f0030',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/jquery.gridly.js','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be59242ebc01592434b7520031',3,'错误代码:404，访问路径:/bi/charts/res/javascripts/sample.js','superadmin','localhost','2016-12-22 09:45:51 051','系统异常','LogService'),
('faf185be5924387701592439ceb00000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:51:25 025','系统登录','LogService'),
('faf185be592438770159243c02270001',3,'错误代码:404，访问路径:/jrelax-bi/framework/css/simple-line-icons.css','superadmin','localhost','2016-12-22 09:53:49 049','系统异常','LogService'),
('faf185be59243d490159243da6620000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:55:37 037','系统登录','LogService'),
('faf185be59243d490159243e7f660001',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:56:32 032','系统登录','LogService'),
('faf185be59243d4901592440b7990002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 09:58:58 058','系统登录','LogService'),
('faf185be59243d4901592441db0d0003',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:00:12 012','系统登录','LogService'),
('faf185be59243d4901592443118e0004',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:01:32 032','系统登录','LogService'),
('faf185be592447ee01592451bc150000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:17:33 033','系统登录','LogService'),
('faf185be592447ee01592453f0480001',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:19:57 057','系统登录','LogService'),
('faf185be592447ee01592454cfc20002',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:20:55 055','系统登录','LogService'),
('faf185be592447ee0159245641820003',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:22:29 029','系统登录','LogService'),
('faf185be5924485401592451bfd40000',3,'错误代码:404，访问路径:/favicon.ico','system','localhost','2016-12-22 10:17:34 034','系统异常','LogService'),
('faf185be592459860159245a4d560000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:26:54 054','系统登录','LogService'),
('faf185be592459860159245a56c10001',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:26:57 057','系统异常','LogService'),
('faf185be592459860159245a583f0002',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:26:57 057','系统异常','LogService'),
('faf185be592459860159245a5c490003',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:26:58 058','系统异常','LogService'),
('faf185be592459860159245a5c4a0004',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:26:58 058','系统异常','LogService'),
('faf185be592459860159245a5d250005',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:26:58 058','系统异常','LogService'),
('faf185be592459860159245a5d290006',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:26:58 058','系统异常','LogService'),
('faf185be592459860159245a5d2a0007',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:26:58 058','系统异常','LogService'),
('faf185be592459860159245a78390008',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:27:05 005','系统异常','LogService'),
('faf185be592459860159245a92e70009',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:27:12 012','系统异常','LogService'),
('faf185be592459860159245a96cd000a',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:27:13 013','系统异常','LogService'),
('faf185be592459860159245a96d7000b',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:27:13 013','系统异常','LogService'),
('faf185be592459860159245a96df000c',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:27:13 013','系统异常','LogService'),
('faf185be592459860159245a96ea000d',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:27:13 013','系统异常','LogService'),
('faf185be592459860159245a96ee000e',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:27:13 013','系统异常','LogService'),
('faf185be592459860159245a96f0000f',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:27:13 013','系统异常','LogService'),
('faf185be592459860159245ab1720010',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:27:20 020','系统异常','LogService'),
('faf185be592459860159245ac1c90011',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:27:24 024','系统异常','LogService'),
('faf185be59245b630159245c210d0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:28:54 054','系统登录','LogService'),
('faf185be59245b630159245c2ccb0001',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:28:57 057','系统异常','LogService'),
('faf185be59245b630159245c2dad0002',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:28:57 057','系统异常','LogService'),
('faf185be59245b630159245c32790003',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:28:59 059','系统异常','LogService'),
('faf185be59245b630159245c32ac0004',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:28:59 059','系统异常','LogService'),
('faf185be59245b630159245c32d80005',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:28:59 059','系统异常','LogService'),
('faf185be59245b630159245c36cf0006',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:29:00 000','系统异常','LogService'),
('faf185be59245b630159245c36f40007',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:00 000','系统异常','LogService'),
('faf185be59245b630159245c374e0008',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:00 000','系统异常','LogService'),
('faf185be59245b630159245c3af90009',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:29:01 001','系统异常','LogService'),
('faf185be59245b630159245c3b6d000a',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:01 001','系统异常','LogService'),
('faf185be59245b630159245c581b000b',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:29:08 008','系统异常','LogService'),
('faf185be59245b630159245c6832000c',3,'错误代码:404，访问路径:/bi/form','superadmin','localhost','2016-12-22 10:29:12 012','系统异常','LogService'),
('faf185be59245b630159245c704a000d',3,'错误代码:404，访问路径:/bi/flow','superadmin','localhost','2016-12-22 10:29:14 014','系统异常','LogService'),
('faf185be59245b630159245ca85d000e',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:29:29 029','系统异常','LogService'),
('faf185be59245b630159245cab75000f',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:30 030','系统异常','LogService'),
('faf185be59245b630159245cac4c0010',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:30 030','系统异常','LogService'),
('faf185be59245b630159245cac4c0011',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:30 030','系统异常','LogService'),
('faf185be59245b630159245cac720012',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:30 030','系统异常','LogService'),
('faf185be59245b630159245cac750013',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:30 030','系统异常','LogService'),
('faf185be59245b630159245cac790014',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:30 030','系统异常','LogService'),
('faf185be59245b630159245cb5970015',3,'错误代码:404，访问路径:/bi/flow','superadmin','localhost','2016-12-22 10:29:32 032','系统异常','LogService'),
('faf185be59245b630159245cd91c0016',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:41 041','系统异常','LogService'),
('faf185be59245b630159245cd9c70017',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:41 041','系统异常','LogService'),
('faf185be59245b630159245cd9c80018',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:41 041','系统异常','LogService'),
('faf185be59245b630159245cd9d10019',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:41 041','系统异常','LogService'),
('faf185be59245b630159245cd9d6001a',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:41 041','系统异常','LogService'),
('faf185be59245b630159245cd9eb001b',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:41 041','系统异常','LogService'),
('faf185be59245b630159245cf913001c',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:29:49 049','系统异常','LogService'),
('faf185be59245b630159245cfd3b001d',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:51 051','系统异常','LogService'),
('faf185be59245b630159245cfd66001e',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:51 051','系统异常','LogService'),
('faf185be59245b630159245cfd68001f',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:51 051','系统异常','LogService'),
('faf185be59245b630159245cfd750020',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:51 051','系统异常','LogService'),
('faf185be59245b630159245cfd760021',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:51 051','系统异常','LogService'),
('faf185be59245b630159245cfd940022',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:29:51 051','系统异常','LogService'),
('faf185be59245b630159245d2e290023',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:30:03 003','系统异常','LogService'),
('faf185be59245b630159245d30e00024',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:30:04 004','系统异常','LogService'),
('faf185be59245b630159245d31e80025',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:30:04 004','系统异常','LogService'),
('faf185be59245b630159245d31ea0026',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:30:04 004','系统异常','LogService'),
('faf185be59245b630159245d31ec0027',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:30:04 004','系统异常','LogService'),
('faf185be59245b630159245d31f30028',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:30:04 004','系统异常','LogService'),
('faf185be59245b630159245d31f50029',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:30:04 004','系统异常','LogService'),
('faf185be59245f4701592460379b0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 10:33:22 022','系统登录','LogService'),
('faf185be59245f470159246040790001',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:33:24 024','系统异常','LogService'),
('faf185be59245f470159246042a80002',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-22 10:33:25 025','系统异常','LogService'),
('faf185be59245f470159246044150003',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:33:25 025','系统异常','LogService'),
('faf185be59245f470159246048450004',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:33:26 026','系统异常','LogService'),
('faf185be59245f470159246048bb0005',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:33:26 026','系统异常','LogService'),
('faf185be59245f470159246049250006',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:33:27 027','系统异常','LogService'),
('faf185be59245f470159246049280007',3,'错误代码:404，访问路径:/bi/charts/detail','superadmin','localhost','2016-12-22 10:33:27 027','系统异常','LogService'),
('faf185be59245f470159246052a10008',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:33:29 029','系统异常','LogService'),
('faf185be59245f470159246059790009',3,'错误代码:404，访问路径:/bi/flow','superadmin','localhost','2016-12-22 10:33:31 031','系统异常','LogService'),
('faf185be59245f4701592460666d000a',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:33:34 034','系统异常','LogService'),
('faf185be59245f470159246088d8000b',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:33:43 043','系统异常','LogService'),
('faf185be59245f47015924610c33000c',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:34:17 017','系统异常','LogService'),
('faf185be59245f470159246119d8000d',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:34:20 020','系统异常','LogService'),
('faf185be59245f4701592461270c000e',3,'错误代码:404，访问路径:/bi/charts','superadmin','localhost','2016-12-22 10:34:23 023','系统异常','LogService'),
('faf185be59245f470159247d31c3000f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 11:05:01 001','登录系统','LogService'),
('faf185be5924c973015924cfdb3c0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 12:35:18 018','系统登录','LogService'),
('faf185be5924c973015924d04aef0001',3,'错误代码:404，访问路径:/index/bi/drag','superadmin','localhost','2016-12-22 12:35:47 047','系统异常','LogService'),
('faf185be5924c973015924d0d24c0002',3,'错误代码:404，访问路径:/index/bi/charts/drag','superadmin','localhost','2016-12-22 12:36:22 022','系统异常','LogService'),
('faf185be5924c973015924ecf3ab0003',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 13:07:05 005','登录系统','LogService'),
('faf185be592515580159251843150000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 13:54:24 024','系统登录','LogService'),
('faf185be592515e00159251f11ec0000',3,'错误代码:404，访问路径:/favicon.ico','system','localhost','2016-12-22 14:01:50 050','系统异常','LogService'),
('faf185be592528ca01592537312c0000',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 14:28:11 011','系统异常','LogService'),
('faf185be592528ca01592537312d0001',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 14:28:11 011','系统异常','LogService'),
('faf185be592528ca0159253735bb0002',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 14:28:12 012','系统异常','LogService'),
('faf185be592528ca0159253735c20003',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 14:28:12 012','系统异常','LogService'),
('faf185be592528ca0159253735c50004',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 14:28:12 012','系统异常','LogService'),
('faf185be592528ca0159253735cf0005',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 14:28:12 012','系统异常','LogService'),
('faf185be592528ca015925386f850006',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 14:29:32 032','系统异常','LogService'),
('faf185be592528ca015925386fcd0007',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 14:29:32 032','系统异常','LogService'),
('faf185be592528ca01592538736a0008',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 14:29:33 033','系统异常','LogService'),
('faf185be592528ca01592538746e0009',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 14:29:33 033','系统异常','LogService'),
('faf185be592528ca015925387473000a',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 14:29:33 033','系统异常','LogService'),
('faf185be592528ca015925387478000b',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 14:29:33 033','系统异常','LogService'),
('faf185be592528ca01592538a9cf000c',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 14:29:47 047','系统异常','LogService'),
('faf185be592528ca01592538a9df000d',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 14:29:47 047','系统异常','LogService'),
('faf185be592528ca01592538a9e2000e',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 14:29:47 047','系统异常','LogService'),
('faf185be592528ca01592538aa05000f',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 14:29:47 047','系统异常','LogService'),
('faf185be592528ca01592538abc60010',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 14:29:48 048','系统异常','LogService'),
('faf185be592528ca0159253997560011',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:30:48 048','请求出错','LogService'),
('faf185be592528ca015925399ca30012',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:30:49 049','系统异常','LogService'),
('faf185be592528ca0159253bccf50013',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:33:13 013','请求出错','LogService'),
('faf185be592528ca0159253bd2160014',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:33:14 014','系统异常','LogService'),
('faf185be592528ca0159253cee130015',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:34:27 027','请求出错','LogService'),
('faf185be592528ca0159253cee300016',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:34:27 027','系统异常','LogService'),
('faf185be592528ca0159253d0fbd0017',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:34:35 035','请求出错','LogService'),
('faf185be592528ca0159253d0fd80018',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:34:35 035','系统异常','LogService'),
('faf185be592528ca0159253dbc4d0019',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:35:20 020','请求出错','LogService'),
('faf185be592528ca0159253dbc67001a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:35:20 020','系统异常','LogService'),
('faf185be592528ca0159253dcdf3001b',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 14:35:24 024','系统登录','LogService'),
('faf185be592528ca0159253de4ae001c',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 14:35:30 030','系统登录','LogService'),
('faf185be592528ca0159253e03ee001d',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 14:35:38 038','系统登录','LogService'),
('faf185be592528ca0159253e4745001e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:35:55 055','请求出错','LogService'),
('faf185be592528ca0159253e4777001f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:35:55 055','系统异常','LogService'),
('faf185be59254a220159254b002f0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 14:49:49 049','系统登录','LogService'),
('faf185be59254a220159254c2fbd0001',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:51:07 007','请求出错','LogService'),
('faf185be59254a220159254c2fea0002',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:51:07 007','系统异常','LogService'),
('faf185be59254a220159254d3d410003',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:52:16 016','请求出错','LogService'),
('faf185be59254a220159254d50e50004',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:52:21 021','请求出错','LogService'),
('faf185be59254a220159254d51090005',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:52:21 021','系统异常','LogService'),
('faf185be59254a220159254d84ab0006',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:52:34 034','请求出错','LogService'),
('faf185be59254a220159254d84bf0007',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:52:34 034','系统异常','LogService'),
('faf185be59254a220159254dd0b10008',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 14:52:53 053','请求出错','LogService'),
('faf185be59254a220159254dd0db0009',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 14:52:53 053','系统异常','LogService'),
('faf185be59254a220159254de325000a',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 14:52:58 058','系统登录','LogService'),
('faf185be59254a220159255752c6000b',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-22 15:03:16 016','系统登录','LogService'),
('faf185be59254a220159256bdfab000c',3,'错误代码:404，访问路径:/index/bi/chats/drag','superadmin','localhost','2016-12-22 15:25:43 043','系统异常','LogService'),
('faf185be59254a220159256bfdc5000d',3,'错误代码:404，访问路径:/index/bi/chart/drag','superadmin','localhost','2016-12-22 15:25:51 051','系统异常','LogService'),
('faf185be59254a220159256c1180000e',3,'错误代码:404，访问路径:/bi/chart/drag','superadmin','localhost','2016-12-22 15:25:56 056','系统异常','LogService'),
('faf185be59254a220159256c2fe2000f',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-22 15:26:04 004','系统首页','LogService'),
('faf185be59254a2201592578b76d0010',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b7710011',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b77e0012',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b78b0013',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b78b0014',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b95c0015',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b95e0016',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b9660017',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b9930018',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578b9ce0019',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:39:45 045','系统异常','LogService'),
('faf185be59254a2201592578ba6a001a',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:39:46 046','系统异常','LogService'),
('faf185be59254a2201592578bdb8001b',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:39:46 046','系统异常','LogService'),
('faf185be59254a220159257a42c7001c',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:41:26 026','系统异常','LogService'),
('faf185be59254a220159257a468c001d',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:41:27 027','系统异常','LogService'),
('faf185be59254a220159257a46b5001e',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:41:27 027','系统异常','LogService'),
('faf185be59254a220159257a47fb001f',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:41:27 027','系统异常','LogService'),
('faf185be59254a220159257b3b3f0020',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:42:30 030','系统异常','LogService'),
('faf185be59254a220159257b3b6d0021',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:42:30 030','系统异常','LogService'),
('faf185be59254a220159257b3bf80022',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:42:30 030','系统异常','LogService'),
('faf185be59254a220159257b40920023',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:42:31 031','系统异常','LogService'),
('faf185be59254a220159257c69190024',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:43:47 047','系统异常','LogService'),
('faf185be59254a220159257c6d830025',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:43:48 048','系统异常','LogService'),
('faf185be59254a220159257c6ddd0026',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:43:48 048','系统异常','LogService'),
('faf185be59254a220159257c6f1a0027',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:43:49 049','系统异常','LogService'),
('faf185be59254a220159257c7b0b0028',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:43:52 052','系统异常','LogService'),
('faf185be59254a220159257c7b170029',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:43:52 052','系统异常','LogService'),
('faf185be59254a220159257c7b26002a',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:43:52 052','系统异常','LogService'),
('faf185be59254a220159257c7b36002b',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:43:52 052','系统异常','LogService'),
('faf185be59254a220159257c7cf0002c',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:43:52 052','系统异常','LogService'),
('faf185be59254a220159257ed1d9002d',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:46:25 025','系统异常','LogService'),
('faf185be59254a220159257ed67d002e',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:46:26 026','系统异常','LogService'),
('faf185be59254a220159257ed68e002f',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:46:26 026','系统异常','LogService'),
('faf185be59254a220159257ed6980030',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:46:26 026','系统异常','LogService'),
('faf185be59254a220159257ed6a90031',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:46:26 026','系统异常','LogService'),
('faf185be59254a220159257edb470032',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:46:27 027','系统异常','LogService'),
('faf185be59254a2201592581cb710033',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:49:40 040','系统异常','LogService'),
('faf185be59254a2201592581cf220034',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:49:41 041','系统异常','LogService'),
('faf185be59254a2201592581cf6b0035',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:49:41 041','系统异常','LogService'),
('faf185be59254a2201592581d0110036',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:49:41 041','系统异常','LogService'),
('faf185be59254a2201592581d0190037',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:49:41 041','系统异常','LogService'),
('faf185be59254a22015925847dd80038',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:52:37 037','系统异常','LogService'),
('faf185be59254a220159258483320039',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:52:38 038','系统异常','LogService'),
('faf185be59254a2201592584836f003a',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:52:38 038','系统异常','LogService'),
('faf185be59254a22015925848371003b',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:52:38 038','系统异常','LogService'),
('faf185be59254a22015925848375003c',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:52:38 038','系统异常','LogService'),
('faf185be59254a220159258486e3003d',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:52:39 039','系统异常','LogService'),
('faf185be59254a2201592584941d003e',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:52:42 042','系统异常','LogService'),
('faf185be59254a22015925849437003f',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:52:42 042','系统异常','LogService'),
('faf185be59254a2201592584943e0040',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:52:42 042','系统异常','LogService'),
('faf185be59254a220159258494670041',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:52:42 042','系统异常','LogService'),
('faf185be59254a220159258494670042',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:52:42 042','系统异常','LogService'),
('faf185be59254a220159258496290043',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:52:43 043','系统异常','LogService'),
('faf185be59254a2201592584f8ff0044',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:53:08 008','系统异常','LogService'),
('faf185be59254a2201592584f9040045',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:53:08 008','系统异常','LogService'),
('faf185be59254a2201592584f9300046',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:53:08 008','系统异常','LogService'),
('faf185be59254a2201592584f9370047',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:53:08 008','系统异常','LogService'),
('faf185be59254a2201592584f9370048',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:53:08 008','系统异常','LogService'),
('faf185be59254a2201592584fafa0049',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:53:09 009','系统异常','LogService'),
('faf185be59254a22015925854fab004a',3,'错误代码:404，访问路径:/bi/charts/jrelax-bi/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:53:30 030','系统异常','LogService'),
('faf185be59254a2201592586a66f004b',3,'错误代码:404，访问路径:/bi/charts/app/charts/charts.js','superadmin','localhost','2016-12-22 15:54:58 058','系统异常','LogService'),
('faf185be59254a2201592586afae004c',3,'错误代码:404，访问路径:/bi/charts/app/charts/charts.js','superadmin','localhost','2016-12-22 15:55:00 000','系统异常','LogService'),
('faf185be59254a22015925878088004d',3,'错误代码:404，访问路径:/bi/charts/app/charts/charts.js','superadmin','localhost','2016-12-22 15:55:54 054','系统异常','LogService'),
('faf185be59254a2201592587bea3004e',3,'错误代码:404，访问路径:/bi/charts/app/charts/charts.js','superadmin','localhost','2016-12-22 15:56:10 010','系统异常','LogService'),
('faf185be59254a22015925880bbf004f',3,'错误代码:404，访问路径:/bi/charts/app/charts/charts.js','superadmin','localhost','2016-12-22 15:56:30 030','系统异常','LogService'),
('faf185be59254a220159258835ce0050',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:56:40 040','系统异常','LogService'),
('faf185be59254a220159258835d70051',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:56:40 040','系统异常','LogService'),
('faf185be59254a220159258835de0052',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:56:40 040','系统异常','LogService'),
('faf185be59254a22015925883dc60053',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:56:42 042','系统异常','LogService'),
('faf185be59254a22015925883dcb0054',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:56:42 042','系统异常','LogService'),
('faf185be59254a22015925883f870055',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:56:43 043','系统异常','LogService'),
('faf185be59254a22015925885b0c0056',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:56:50 050','系统异常','LogService'),
('faf185be59254a22015925885b1f0057',3,'错误代码:404，访问路径:/bi/charts/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','localhost','2016-12-22 15:56:50 050','系统异常','LogService'),
('faf185be59254a22015925885b280058',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:56:50 050','系统异常','LogService'),
('faf185be59254a2201592588767a0059',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/datasource.js','superadmin','localhost','2016-12-22 15:56:57 057','系统异常','LogService'),
('faf185be59254a2201592588767a005a',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:56:57 057','系统异常','LogService'),
('faf185be59254a2201592588767e005b',3,'错误代码:404，访问路径:/bi/charts/undefined/app/charts/utils.js','superadmin','localhost','2016-12-22 15:56:57 057','系统异常','LogService'),
('faf185be59254a2201592588784d005c',3,'错误代码:404，访问路径:/bi/charts/undefined/bi/charts/detail','superadmin','localhost','2016-12-22 15:56:57 057','系统异常','LogService'),
('faf185be59254a2201592588f54d005d',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 15:57:29 029','请求出错','LogService'),
('faf185be59254a2201592588f570005e',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 15:57:29 029','系统异常','LogService'),
('faf185be59254a220159258a4c88005f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 15:58:57 057','请求出错','LogService'),
('faf185be59254a220159258a4ef40060',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 15:58:58 058','系统异常','LogService'),
('faf185be59254a220159258f0da90061',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:04:09 009','请求出错','LogService'),
('faf185be59254a220159258f10250062',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:04:09 009','系统异常','LogService'),
('faf185be59254a220159258f91340063',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:04:42 042','请求出错','LogService'),
('faf185be59254a220159258f91540064',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:04:42 042','系统异常','LogService'),
('faf185be59254a2201592591725a0065',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:06:46 046','请求出错','LogService'),
('faf185be59254a220159259177d50066',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:06:47 047','系统异常','LogService'),
('faf185be59254a2201592591b2c60067',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:07:02 002','请求出错','LogService'),
('faf185be59254a2201592591b2d60068',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:07:02 002','系统异常','LogService'),
('faf185be59254a220159259ff8410069',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:22:37 037','请求出错','LogService'),
('faf185be59254a220159259ffb39006a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:22:38 038','系统异常','LogService'),
('faf185be59254a22015925a0864f006b',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:23:14 014','请求出错','LogService'),
('faf185be59254a22015925a08b60006c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:23:15 015','系统异常','LogService'),
('faf185be59254a22015925a0f306006d',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:23:42 042','请求出错','LogService'),
('faf185be59254a22015925a0f329006e',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:23:42 042','系统异常','LogService'),
('faf185be59254a22015925a47cba006f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:27:33 033','请求出错','LogService'),
('faf185be59254a22015925a47f570070',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:27:34 034','系统异常','LogService'),
('faf185be59254a22015925a50a950071',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:28:10 010','请求出错','LogService'),
('faf185be59254a22015925a529020072',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:28:18 018','系统异常','LogService'),
('faf185be59254a22015925a533150073',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:28:20 020','请求出错','LogService'),
('faf185be59254a22015925a567ff0074',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:28:34 034','系统异常','LogService'),
('faf185be59254a22015925a570a00075',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:28:36 036','请求出错','LogService'),
('faf185be59254a22015925a5ab590076',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:28:51 051','请求出错','LogService'),
('faf185be59254a22015925a5b0650077',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:28:52 052','系统异常','LogService'),
('faf185be59254a22015925a695280078',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:29:51 051','请求出错','LogService'),
('faf185be59254a22015925a69ef70079',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:29:53 053','系统异常','LogService'),
('faf185be59254a22015925a702c3007a',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:30:19 019','请求出错','LogService'),
('faf185be59254a22015925a707e7007b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:30:20 020','系统异常','LogService'),
('faf185be59254a22015925a78a90007c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:30:54 054','请求出错','LogService'),
('faf185be59254a22015925a78db1007d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:30:54 054','系统异常','LogService'),
('faf185be59254a22015925a867e5007e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:31:50 050','请求出错','LogService'),
('faf185be59254a22015925a86cf1007f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:31:52 052','系统异常','LogService'),
('faf185be59254a22015925aaa1b60080',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:34:16 016','请求出错','LogService'),
('faf185be59254a22015925aaa3e90081',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:34:17 017','系统异常','LogService'),
('faf185be59254a22015925aab4810082',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:34:21 021','请求出错','LogService'),
('faf185be59254a22015925aab7420083',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:34:22 022','系统异常','LogService'),
('faf185be59254a22015925ab557d0084',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:35:02 002','请求出错','LogService'),
('faf185be59254a22015925ab593e0085',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:35:03 003','系统异常','LogService'),
('faf185be59254a22015925ae54f80086',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:38:19 019','请求出错','LogService'),
('faf185be59254a22015925ae57e50087',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:38:19 019','系统异常','LogService'),
('faf185be59254a22015925b5635a0088',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:46:01 001','请求出错','LogService'),
('faf185be59254a22015925b565160089',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:46:02 002','系统异常','LogService'),
('faf185be59254a22015925b5e54f008a',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:46:34 034','请求出错','LogService'),
('faf185be59254a22015925b5e55c008b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:46:34 034','系统异常','LogService'),
('faf185be59254a22015925b7157d008c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:47:52 052','请求出错','LogService'),
('faf185be59254a22015925b716f9008d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:47:53 053','系统异常','LogService'),
('faf185be59254a22015925b739a2008e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:48:01 001','请求出错','LogService'),
('faf185be59254a22015925b73da9008f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:48:02 002','系统异常','LogService'),
('faf185be59254a22015925b76cb40090',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:48:15 015','请求出错','LogService'),
('faf185be59254a22015925b76cd50091',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:48:15 015','系统异常','LogService'),
('faf185be59254a22015925b95c420092',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:50:21 021','请求出错','LogService'),
('faf185be59254a22015925b95e340093',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:50:22 022','系统异常','LogService'),
('faf185be59254a22015925ba3f270094',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:51:19 019','请求出错','LogService'),
('faf185be59254a22015925ba430d0095',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:51:20 020','系统异常','LogService'),
('faf185be59254a22015925ba59f00096',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:51:26 026','请求出错','LogService'),
('faf185be59254a22015925ba5e010097',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:51:27 027','系统异常','LogService'),
('faf185be59254a22015925beb6910098',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:56:12 012','请求出错','LogService'),
('faf185be59254a22015925beb9c80099',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:56:13 013','系统异常','LogService'),
('faf185be59254a22015925bf68fe009a',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 16:56:58 058','请求出错','LogService'),
('faf185be59254a22015925bf6be6009b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 16:56:59 059','系统异常','LogService'),
('faf185be59254a22015925ce30ae009c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:13:06 006','请求出错','LogService'),
('faf185be59254a22015925ce3625009d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:13:08 008','系统异常','LogService'),
('faf185be59254a22015925d023f2009e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:15:14 014','请求出错','LogService'),
('faf185be59254a22015925d02597009f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:15:15 015','系统异常','LogService'),
('faf185be59254a22015925d04d6f00a0',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:15:25 025','请求出错','LogService'),
('faf185be59254a22015925d04d9d00a1',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:15:25 025','系统异常','LogService'),
('faf185be59254a22015925d0515600a2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:15:26 026','请求出错','LogService'),
('faf185be59254a22015925d0533600a3',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:15:26 026','请求出错','LogService'),
('faf185be59254a22015925d0550400a4',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:15:27 027','系统异常','LogService'),
('faf185be59254a22015925d055c800a5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:15:27 027','系统异常','LogService'),
('faf185be59254a22015925d869f000a6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:24:17 017','请求出错','LogService'),
('faf185be59254a22015925d86e7200a7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:24:18 018','系统异常','LogService'),
('faf185be59254a22015925d8f8e900a8',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:24:53 053','请求出错','LogService'),
('faf185be59254a22015925d8ff6c00a9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:24:55 055','系统异常','LogService'),
('faf185be59254a22015925d959ea00aa',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:25:18 018','请求出错','LogService'),
('faf185be59254a22015925d961ca00ab',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:25:20 020','系统异常','LogService'),
('faf185be59254a22015925dd8ea100ac',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:29:54 054','请求出错','LogService'),
('faf185be59254a22015925dd90ed00ad',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:29:54 054','系统异常','LogService'),
('faf185be59254a22015925ddad8800ae',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:01 001','请求出错','LogService'),
('faf185be59254a22015925ddb32200af',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:03 003','系统异常','LogService'),
('faf185be59254a22015925ddda3700b0',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:13 013','请求出错','LogService'),
('faf185be59254a22015925ddda4900b1',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:13 013','系统异常','LogService'),
('faf185be59254a22015925ddfde000b2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:22 022','请求出错','LogService'),
('faf185be59254a22015925ddfe1200b3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:22 022','系统异常','LogService'),
('faf185be59254a22015925de30e900b4',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:35 035','请求出错','LogService'),
('faf185be59254a22015925de39aa00b5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:37 037','系统异常','LogService'),
('faf185be59254a22015925de4e9400b6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:43 043','请求出错','LogService'),
('faf185be59254a22015925de4ebd00b7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:43 043','系统异常','LogService'),
('faf185be59254a22015925de679000b8',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:49 049','请求出错','LogService'),
('faf185be59254a22015925de67b000b9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:49 049','系统异常','LogService'),
('faf185be59254a22015925de776500ba',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:30:53 053','请求出错','LogService'),
('faf185be59254a22015925de7cba00bb',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:30:55 055','系统异常','LogService'),
('faf185be59254a22015925de99fe00bc',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:31:02 002','请求出错','LogService'),
('faf185be59254a22015925de9f4800bd',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:31:03 003','系统异常','LogService'),
('faf185be59254a22015925ded6d200be',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:31:18 018','请求出错','LogService'),
('faf185be59254a22015925ded6e100bf',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:31:18 018','系统异常','LogService'),
('faf185be59254a22015925dfa21b00c0',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:32:10 010','请求出错','LogService'),
('faf185be59254a22015925dfa22500c1',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:32:10 010','系统异常','LogService'),
('faf185be59254a22015925e0686300c2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:33:00 000','请求出错','LogService'),
('faf185be59254a22015925e07a2d00c3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:33:05 005','系统异常','LogService'),
('faf185be59254a22015925e2048f00c4',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:34:46 046','请求出错','LogService'),
('faf185be59254a22015925e20a1e00c5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:34:47 047','系统异常','LogService'),
('faf185be59254a22015925e76a7f00c6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:40:40 040','请求出错','LogService'),
('faf185be59254a22015925e76d6300c7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:40:40 040','系统异常','LogService'),
('faf185be59254a22015925e777e700c8',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:40:43 043','请求出错','LogService'),
('faf185be59254a22015925e77c8a00c9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:40:44 044','系统异常','LogService'),
('faf185be59254a22015925e78e1e00ca',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:40:49 049','请求出错','LogService'),
('faf185be59254a22015925e792b800cb',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:40:50 050','系统异常','LogService'),
('faf185be59254a22015925e7c04400cc',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:41:02 002','请求出错','LogService'),
('faf185be59254a22015925e7c50c00cd',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:41:03 003','系统异常','LogService'),
('faf185be59254a22015925e8547900ce',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:41:40 040','请求出错','LogService'),
('faf185be59254a22015925e854db00cf',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:41:40 040','系统异常','LogService'),
('faf185be59254a22015925e87bba00d0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:41:50 050','系统异常','LogService'),
('faf185be59254a22015925e87bc800d1',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:41:50 050','请求出错','LogService'),
('faf185be59254a22015925e8cdc400d2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:42:11 011','请求出错','LogService'),
('faf185be59254a22015925e8d2c300d3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:42:12 012','系统异常','LogService'),
('faf185be59254a22015925e8f08300d4',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','0:0:0:0:0:0:0:1','2016-12-22 17:42:20 020','请求出错','LogService'),
('faf185be59254a22015925e8f55700d5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 17:42:21 021','系统异常','LogService'),
('faf185be59254a22015926033e1200d6',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','localhost','2016-12-22 18:11:03 003','系统异常','LogService'),
('faf185be59254a2201592603424900d7',3,'org.springframework.transaction.CannotCreateTransactionException: Could not open Hibernate Session for transaction; nested exception is com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure\n\nThe last packet successfully received from the server was 21,502 milliseconds ago.  The last packet sent successfully to the server was 21,498 milliseconds ago.','superadmin','0:0:0:0:0:0:0:1','2016-12-22 18:11:04 004','请求出错','LogService'),
('faf185be59254a2201592603806000d8',3,'org.springframework.transaction.CannotCreateTransactionException: Could not open Hibernate Session for transaction; nested exception is com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure\n\nThe last packet successfully received from the server was 46,652 milliseconds ago.  The last packet sent successfully to the server was 22,927 milliseconds ago.','superadmin','0:0:0:0:0:0:0:1','2016-12-22 18:11:20 020','请求出错','LogService'),
('faf185be59254a220159260388c500d9',3,'org.springframework.transaction.CannotCreateTransactionException: Could not open Hibernate Session for transaction; nested exception is com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure\n\nThe last packet successfully received from the server was 48,984 milliseconds ago.  The last packet sent successfully to the server was 25,049 milliseconds ago.','superadmin','0:0:0:0:0:0:0:1','2016-12-22 18:11:22 022','请求出错','LogService'),
('faf185be592965c501592966aee40000',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:32 032','系统异常','LogService'),
('faf185be592965c501592966b9240001',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:35 035','系统异常','LogService'),
('faf185be592965c501592966bc760002',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:35 035','系统异常','LogService'),
('faf185be592965c501592966bd460003',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:36 036','系统异常','LogService'),
('faf185be592965c501592966be020004',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:36 036','系统异常','LogService'),
('faf185be592965c501592966c3520005',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:37 037','系统异常','LogService'),
('faf185be592965c501592966c3610006',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:37 037','系统异常','LogService'),
('faf185be592965c501592966c3620007',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:37 037','系统异常','LogService'),
('faf185be592965c501592966c36f0008',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:37 037','系统异常','LogService'),
('faf185be592965c501592966daee0009',3,'错误代码:404，访问路径:/bi/charts/drag','superadmin','localhost','2016-12-23 09:58:43 043','系统异常','LogService'),
('faf185be592967990159296875cf0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 10:00:28 028','系统登录','LogService'),
('faf185be592967990159297020050001',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 10:08:51 051','系统登录','LogService'),
('faf185be59297445015929751dab0000',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 10:14:18 018','系统登录','LogService'),
('faf185be5929744501592996f9890002',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-12-23 10:51:17 017','系统异常','LogService'),
('faf185be5929744501592997d1970003',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-12-23 10:52:12 012','系统异常','LogService'),
('faf185be592974450159299a8a6c0005',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','localhost','2016-12-23 10:55:10 010','系统异常','LogService'),
('faf185be592974450159299d4d7f0006',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-12-23 10:58:11 011','系统首页','LogService'),
('faf185be592974450159299d52360007',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-12-23 10:58:13 013','系统首页','LogService'),
('faf185be59297445015929af55e30008',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 11:17:53 053','系统异常','LogService'),
('faf185be59297445015929af61940009',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 11:17:56 056','系统异常','LogService'),
('faf185be59297445015929af6e8d000a',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 11:18:00 000','系统异常','LogService'),
('faf185be59297445015929d7e731000b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-23 12:02:12 012','登录系统','LogService'),
('faf185be5929744501592a1cc0f1000c',1,'用户：[superadmin] 成功登录系统','superadmin','localhost','2016-12-23 13:17:24 024','系统登录','LogService'),
('faf185be5929744501592a422e83000d',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 13:58:17 017','系统异常','LogService'),
('faf185be5929744501592a42d25c000e',3,'错误代码:404，访问路径:/bi/report','superadmin','localhost','2016-12-23 13:58:59 059','系统异常','LogService'),
('faf185be5929744501592a4b00e9000f',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 14:07:55 055','系统首页','LogService'),
('faf185be5929744501592a4b1e6c0010',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 14:08:03 003','系统首页','LogService'),
('faf185be5929744501592a4b26880011',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2016-12-23 14:08:05 005','系统首页','LogService'),
('faf185be5929744501592a4b2ac50012',1,'切换皮肤：[theme: palette.5]','superadmin','localhost','2016-12-23 14:08:06 006','系统首页','LogService'),
('faf185be5929744501592a4b2e990013',1,'切换皮肤：[theme: palette.6]','superadmin','localhost','2016-12-23 14:08:07 007','系统首页','LogService'),
('faf185be5929744501592a4b34fd0014',1,'切换皮肤：[theme: palette.2]','superadmin','localhost','2016-12-23 14:08:08 008','系统首页','LogService'),
('faf185be5929744501592a4b35670015',1,'切换皮肤：[theme: palette.4]','superadmin','localhost','2016-12-23 14:08:09 009','系统首页','LogService'),
('faf185be5929744501592a4b35e00016',1,'切换皮肤：[theme: palette.3]','superadmin','localhost','2016-12-23 14:08:09 009','系统首页','LogService'),
('faf185be5929744501592a4b36fd0017',1,'切换皮肤：[theme: palette]','superadmin','localhost','2016-12-23 14:08:09 009','系统首页','LogService'),
('faf185be5929744501592a4b4ecf0018',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 14:08:15 015','系统首页','LogService'),
('faf185be5929744501592a4b62ec0019',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 14:08:20 020','系统首页','LogService'),
('faf185be5929744501592a4b98c9001a',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 14:08:34 034','系统首页','LogService'),
('faf185be5929744501592a4ca990001b',1,'切换布局：[layout: ${layout}]','superadmin','localhost','2016-12-23 14:09:44 044','系统首页','LogService');

/*Table structure for table `sys_notify` */

DROP TABLE IF EXISTS `sys_notify`;

CREATE TABLE `sys_notify` (
  `id` varchar(50) NOT NULL,
  `content` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_notify` */

/*Table structure for table `sys_notify_user` */

DROP TABLE IF EXISTS `sys_notify_user`;

CREATE TABLE `sys_notify_user` (
  `id` varchar(50) NOT NULL,
  `userId` varchar(50) DEFAULT NULL,
  `notifyId` varchar(50) DEFAULT NULL,
  `businessId` varchar(50) DEFAULT NULL COMMENT '业务ID',
  `createTime` varchar(20) NOT NULL,
  `recread` tinyint(1) DEFAULT NULL,
  `readTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sys_notify$sys_notify_user` (`notifyId`),
  KEY `FK_sys_user$sys_notify` (`userId`),
  CONSTRAINT `FK_sys_notify$sys_notify_user` FOREIGN KEY (`notifyId`) REFERENCES `sys_notify` (`id`),
  CONSTRAINT `FK_sys_user$sys_notify` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_notify_user` */

/*Table structure for table `sys_res` */

DROP TABLE IF EXISTS `sys_res`;

CREATE TABLE `sys_res` (
  `id` varchar(50) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` varchar(50) DEFAULT NULL COMMENT '编码',
  `url` varchar(50) DEFAULT NULL,
  `icon` varchar(30) DEFAULT NULL,
  `location` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `descript` tinytext,
  `parentId` varchar(50) DEFAULT NULL,
  `hasChildren` tinyint(1) NOT NULL DEFAULT '0',
  `beta` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) NOT NULL DEFAULT '1',
  `newWindow` tinyint(1) NOT NULL DEFAULT '0',
  `createTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_res` */

insert  into `sys_res`(`id`,`name`,`code`,`url`,`icon`,`location`,`enabled`,`descript`,`parentId`,`hasChildren`,`beta`,`display`,`newWindow`,`createTime`) values 
('297ec0504dfb4517014dfb805a600005','工作流管理','006','/bi/flow','fa fa-sitemap',6,1,'','-1',0,0,1,0,'2015-06-16 16:33:22'),
('297ec0504dfb4517014dfb8441740006','表单管理','002','/bi/form','ti-pencil-alt',2,1,'表单管理1.0版本，直接设计表单，根据表单内容自动生成数据库表','-1',0,0,1,0,'2015-06-16 16:37:38'),
('40283881494264460149428484610000','仪表板','001','/index','glyphicon glyphicon-home',1,1,'集中显示各种数据，报表等。','-1',0,0,1,0,'2014-10-24 22:17:01'),
('402881ee547ea15801547eb07a2f0002','数据源管理','007','/bi/datasource','fa fa-database',7,1,'','-1',0,0,1,0,'2016-05-05 10:12:55'),
('402881ee547ea15801547eb17d800004','图表管理','004','/bi/charts','fa fa-pie-chart',4,1,'基于 自定义数据源 模块生成图表','-1',0,0,1,0,'2016-05-05 10:14:01'),
('402881ff500261d4015002732e960000','数据库管理','008','/bi/table','fa fa-table',8,1,'数据库表管理','-1',0,0,1,1,'2015-09-25 11:01:54'),
('40289f395992c350015992c676300002','表单管理2.0','003','/bi/form/v2','fa fa-check-square-o',3,1,'表单管理2.0版本，添加表单时必须先选择数据库表','-1',0,0,1,0,'2017-01-12 21:03:16'),
('4028b881592575a30159257a39290002','报表管理','005','/bi/report','fa fa-list-alt',5,1,'','-1',0,0,1,0,'2016-12-22 15:41:24');

/*Table structure for table `sys_res_column` */

DROP TABLE IF EXISTS `sys_res_column`;

CREATE TABLE `sys_res_column` (
  `id` varchar(32) NOT NULL,
  `resId` varchar(32) DEFAULT NULL COMMENT '关联资源表',
  `code` varchar(20) NOT NULL COMMENT '编码',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` varchar(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_sys_res_column$sys_res` (`resId`),
  CONSTRAINT `FK_sys_res_column$sys_res` FOREIGN KEY (`resId`) REFERENCES `sys_res` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源对应的字段';

/*Data for the table `sys_res_column` */

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(50) NOT NULL,
  `name` varchar(20) NOT NULL,
  `unitId` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `descript` text,
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`unitId`,`enabled`,`descript`,`createTime`) values 
('4028388148d681830148d6857c71000d','系统管理员','40283881493c2aff01493c32e2a70000',1,'拥有系统最高权限，所有资源权限，所有按钮权限','2014-10-03 22:59:05'),
('40283881497b0b0201497b2a16350004','普通角色','40283881493c2aff01493c32e2a70000',1,'具有一般权限','2014-11-04 22:16:36'),
('40283881497b0b0201497b2a16350005','文档共享中心','402838814956ea190149570336be0000',1,'',''),
('402838814a143628014a149ebc6e0002','合肥1','402838814a0ba80b014a0bb751020000',1,'','2014-12-04 17:25:54'),
('402838814ac3ffdc014ac414ee76000b','安徽网禾管理员','402838814956ea190149570336be0000',1,'','2015-01-07 19:08:33'),
('402881ee5374fb9b01537501c7680017','r','402881ee5374fb9b015374fcd8d80004',1,'','2016-03-14 20:02:44');

/*Table structure for table `sys_role_res` */

DROP TABLE IF EXISTS `sys_role_res`;

CREATE TABLE `sys_role_res` (
  `roleId` varchar(50) NOT NULL,
  `resId` varchar(50) NOT NULL,
  KEY `FK_sys_role_res_role` (`roleId`),
  KEY `FK_sys_role_res_res` (`resId`),
  CONSTRAINT `FK_sys_role_res_res` FOREIGN KEY (`resId`) REFERENCES `sys_res` (`id`),
  CONSTRAINT `FK_sys_role_res_role` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_res` */

insert  into `sys_role_res`(`roleId`,`resId`) values 
('402838814a143628014a149ebc6e0002','40283881494264460149428484610000'),
('40283881497b0b0201497b2a16350005','40283881494264460149428484610000'),
('402838814ac3ffdc014ac414ee76000b','40283881494264460149428484610000'),
('402881ee5374fb9b01537501c7680017','40283881494264460149428484610000'),
('40283881497b0b0201497b2a16350004','40283881494264460149428484610000'),
('40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000'),
('4028388148d681830148d6857c71000d','402881ee547ea15801547eb17d800004'),
('4028388148d681830148d6857c71000d','402881ee547ea15801547eb07a2f0002'),
('4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb805a600005'),
('4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb8441740006'),
('4028388148d681830148d6857c71000d','402881ff500261d4015002732e960000'),
('4028388148d681830148d6857c71000d','40283881494264460149428484610000');

/*Table structure for table `sys_role_res_btn` */

DROP TABLE IF EXISTS `sys_role_res_btn`;

CREATE TABLE `sys_role_res_btn` (
  `id` varchar(50) NOT NULL,
  `roleid` varchar(50) DEFAULT NULL,
  `resid` varchar(50) DEFAULT NULL,
  `btnid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sys_role_res_btn_role` (`roleid`),
  KEY `FK_sys_role_res_btn_res` (`resid`),
  KEY `FK_sys_role_res_btn` (`btnid`),
  CONSTRAINT `FK_sys_role_res_btn` FOREIGN KEY (`btnid`) REFERENCES `sys_btn` (`id`),
  CONSTRAINT `FK_sys_role_res_btn_res` FOREIGN KEY (`resid`) REFERENCES `sys_res` (`id`),
  CONSTRAINT `FK_sys_role_res_btn_role` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_res_btn` */

insert  into `sys_role_res_btn`(`id`,`roleid`,`resid`,`btnid`) values 
('297e45605915c63f015915cf705a0010','4028388148d681830148d6857c71000d','402881ee547ea15801547eb17d800004','4028388148bc169f0148bc5b25620001'),
('297e45605915c63f015915cf705a0011','4028388148d681830148d6857c71000d','402881ee547ea15801547eb17d800004','4028388148bc169f0148bc5b66bb0002'),
('297e45605915c63f015915cf705a0012','4028388148d681830148d6857c71000d','402881ee547ea15801547eb17d800004','4028388148bc169f0148bc5b8ae60003'),
('297e45605915c63f015915cf705a0013','4028388148d681830148d6857c71000d','402881ee547ea15801547eb17d800004','4028388148bc169f0148bc5bb1870004'),
('297e45605915c63f015915cf705b0014','4028388148d681830148d6857c71000d','402881ee547ea15801547eb07a2f0002','4028388148bc169f0148bc5b25620001'),
('297e45605915c63f015915cf705b0015','4028388148d681830148d6857c71000d','402881ee547ea15801547eb07a2f0002','4028388148bc169f0148bc5b66bb0002'),
('297e45605915c63f015915cf705d0016','4028388148d681830148d6857c71000d','402881ee547ea15801547eb07a2f0002','4028388148bc169f0148bc5b8ae60003'),
('297e45605915c63f015915cf705d0017','4028388148d681830148d6857c71000d','402881ee547ea15801547eb07a2f0002','4028388148bc169f0148bc5bb1870004'),
('297e45605915c63f015915cf705e0018','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb805a600005','4028388148bc169f0148bc5b25620001'),
('297e45605915c63f015915cf705e0019','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb805a600005','4028388148bc169f0148bc5b66bb0002'),
('297e45605915c63f015915cf705e001a','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb805a600005','4028388148bc169f0148bc5b8ae60003'),
('297e45605915c63f015915cf705e001b','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb805a600005','4028388148bc169f0148bc5bb1870004'),
('297e45605915c63f015915cf705e001c','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb8441740006','4028388148bc169f0148bc5b25620001'),
('297e45605915c63f015915cf7065001d','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb8441740006','4028388148bc169f0148bc5b66bb0002'),
('297e45605915c63f015915cf7065001e','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb8441740006','4028388148bc169f0148bc5b8ae60003'),
('297e45605915c63f015915cf7065001f','4028388148d681830148d6857c71000d','297ec0504dfb4517014dfb8441740006','4028388148bc169f0148bc5bb1870004'),
('297e45605915c63f015915cf70650020','4028388148d681830148d6857c71000d','402881ff500261d4015002732e960000','4028388148bc169f0148bc5b25620001'),
('297e45605915c63f015915cf70650021','4028388148d681830148d6857c71000d','402881ff500261d4015002732e960000','4028388148bc169f0148bc5b66bb0002'),
('297e45605915c63f015915cf70650022','4028388148d681830148d6857c71000d','402881ff500261d4015002732e960000','4028388148bc169f0148bc5b8ae60003'),
('297e45605915c63f015915cf70650023','4028388148d681830148d6857c71000d','402881ff500261d4015002732e960000','4028388148bc169f0148bc5bb1870004'),
('297e45605915c63f015915cf70650024','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('297e45605915c63f015915cf70650025','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('297e45605915c63f015915cf70650026','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('297e45605915c63f015915cf70650027','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7ce0028','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7ce0029','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7ce002a','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7cf002b','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402838814ac1fe5f014ac21590ac0000','40283881497b0b0201497b2a16350005','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402838814ac1fe5f014ac21590ad0001','40283881497b0b0201497b2a16350005','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402838814ac1fe5f014ac21590ad0002','40283881497b0b0201497b2a16350005','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402838814ac1fe5f014ac21590ad0003','40283881497b0b0201497b2a16350005','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402838814ac3ffdc014ac441b6d1009e','402838814ac3ffdc014ac414ee76000b','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402838814ac3ffdc014ac441b6d1009f','402838814ac3ffdc014ac414ee76000b','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402838814ac3ffdc014ac441b6d100a0','402838814ac3ffdc014ac414ee76000b','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402838814ac3ffdc014ac441b6d100a1','402838814ac3ffdc014ac414ee76000b','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402881ee5374fb9b01537501c7690018','402881ee5374fb9b01537501c7680017','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402881ee5374fb9b01537501c7690019','402881ee5374fb9b01537501c7680017','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402881ee5374fb9b01537501c769001a','402881ee5374fb9b01537501c7680017','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402881ee5374fb9b01537501c769001b','402881ee5374fb9b01537501c7680017','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402881ee547f564d01547fb4d9870083','40283881497b0b0201497b2a16350004','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402881ee547f564d01547fb4d9870084','40283881497b0b0201497b2a16350004','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402881ee547f564d01547fb4d9870085','40283881497b0b0201497b2a16350004','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402881ee547f564d01547fb4d9870086','40283881497b0b0201497b2a16350004','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402881ee547f564d01547fb4d98d00bb','40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000','4028388148bc169f0148bc5b25620001'),
('402881ee547f564d01547fb4d98d00bc','40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000','4028388148bc169f0148bc5b66bb0002'),
('402881ee547f564d01547fb4d98d00bd','40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000','4028388148bc169f0148bc5b8ae60003'),
('402881ee547f564d01547fb4d98d00be','40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000','4028388148bc169f0148bc5bb1870004');

/*Table structure for table `sys_role_res_column` */

DROP TABLE IF EXISTS `sys_role_res_column`;

CREATE TABLE `sys_role_res_column` (
  `id` varchar(32) NOT NULL,
  `roleId` varchar(32) NOT NULL COMMENT '角色',
  `resId` varchar(32) NOT NULL COMMENT '资源',
  `columnId` varchar(32) NOT NULL COMMENT '字段',
  PRIMARY KEY (`id`),
  KEY `FK_sys_role_res_column$sys_res` (`resId`),
  KEY `FK_sys_role_res_column$sys_res_column` (`columnId`),
  KEY `FK_sys_role_res_column$sys_role` (`roleId`),
  CONSTRAINT `FK_sys_role_res_column$sys_res` FOREIGN KEY (`resId`) REFERENCES `sys_res` (`id`),
  CONSTRAINT `FK_sys_role_res_column$sys_res_column` FOREIGN KEY (`columnId`) REFERENCES `sys_res_column` (`id`),
  CONSTRAINT `FK_sys_role_res_column$sys_role` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_res_column` */

/*Table structure for table `sys_sms` */

DROP TABLE IF EXISTS `sys_sms`;

CREATE TABLE `sys_sms` (
  `id` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `sendTime` varchar(20) DEFAULT NULL,
  `state` int(11) NOT NULL COMMENT '1 待发送 2已发送 3 发送失败',
  `remarks` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `createUser` varchar(20) DEFAULT NULL,
  `createTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_sms` */

/*Table structure for table `sys_test` */

DROP TABLE IF EXISTS `sys_test`;

CREATE TABLE `sys_test` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_test` */

/*Table structure for table `sys_unit` */

DROP TABLE IF EXISTS `sys_unit`;

CREATE TABLE `sys_unit` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL,
  `code` varchar(20) NOT NULL,
  `contact` varchar(20) DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(20) DEFAULT NULL,
  `address` text,
  `email` varchar(30) DEFAULT NULL,
  `web` varchar(50) DEFAULT NULL,
  `parentId` varchar(50) DEFAULT NULL,
  `hasChildren` tinyint(1) NOT NULL DEFAULT '0',
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_unit` */

insert  into `sys_unit`(`id`,`name`,`code`,`contact`,`mobile`,`address`,`email`,`web`,`parentId`,`hasChildren`,`system`,`enabled`,`createTime`) values 
('40283881493c2aff01493c32e2a70000','内置机构','001','曾超','','安徽·合肥','zengc@nethsoft.com','http://www.nethsoft.com','-1',0,1,1,'2014-10-23 16:50:07');

/*Table structure for table `sys_unit_res` */

DROP TABLE IF EXISTS `sys_unit_res`;

CREATE TABLE `sys_unit_res` (
  `unitId` varchar(50) NOT NULL,
  `resId` varchar(50) NOT NULL,
  KEY `FK_sys_res_unit` (`unitId`),
  CONSTRAINT `FK_sys_res_unit` FOREIGN KEY (`unitId`) REFERENCES `sys_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_unit_res` */

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `realname` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `qq` varchar(15) DEFAULT NULL,
  `pagestyle` varchar(10) DEFAULT NULL,
  `layout` varchar(10) DEFAULT NULL COMMENT '页面布局',
  `enabled` tinyint(1) DEFAULT '0',
  `online` tinyint(1) DEFAULT '0',
  `createtime` varchar(20) NOT NULL,
  `lastLoginTime` varchar(20) DEFAULT NULL,
  `lastloginip` varchar(30) DEFAULT NULL,
  `lastlogintype` int(11) DEFAULT NULL,
  `headImage` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`realname`,`mobile`,`email`,`qq`,`pagestyle`,`layout`,`enabled`,`online`,`createtime`,`lastLoginTime`,`lastloginip`,`lastlogintype`,`headImage`) values 
('402881ee547f564d01547f7dd49b002e','superadmin','C4CA4238A0B923820DCC509A6F75849B','超级管理员','','','','palette.6','${layout}',1,1,'2016-05-05 13:57:13','2017-01-23 11:45:38','localhost',1,NULL);

/*Table structure for table `sys_user_config` */

DROP TABLE IF EXISTS `sys_user_config`;

CREATE TABLE `sys_user_config` (
  `id` varchar(50) NOT NULL,
  `userId` varchar(50) NOT NULL,
  `k` varchar(50) NOT NULL,
  `v` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL COMMENT '1启用 0不启用',
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_userconfig_user` (`userId`),
  CONSTRAINT `FK_userconfig_user` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_config` */

/*Table structure for table `sys_user_email` */

DROP TABLE IF EXISTS `sys_user_email`;

CREATE TABLE `sys_user_email` (
  `id` varchar(50) NOT NULL,
  `userId` varchar(50) NOT NULL,
  `mailType` varchar(10) NOT NULL,
  `mailHost` varchar(50) NOT NULL,
  `mailPort` int(11) NOT NULL,
  `sslEnable` tinyint(1) NOT NULL,
  `mailUser` varchar(50) NOT NULL,
  `mailPass` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_email` */

insert  into `sys_user_email`(`id`,`userId`,`mailType`,`mailHost`,`mailPort`,`sslEnable`,`mailUser`,`mailPass`) values 
('402838814c217b07014c2197f5940000','402838814acc869e014accac95bf000c','imap','imap.exmail.qq.com',993,1,'zengc@nethsoft.com','Zengchao1992'),
('402838814c277f4d014c27a376ca0000','4028388148e09a0d0148e0d0af7d0002','pop','pop.qq.com',110,0,'service@nethsoft.com','nethsoft2014');

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `roleid` varchar(50) NOT NULL,
  `userid` varchar(50) NOT NULL,
  KEY `FK_sys_user_role_user` (`userid`),
  KEY `FK_sys_user_role_role` (`roleid`),
  CONSTRAINT `FK_sys_user_role_role` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `FK_sys_user_role_user` FOREIGN KEY (`userid`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`roleid`,`userid`) values 
('4028388148d681830148d6857c71000d','402881ee547f564d01547f7dd49b002e');

/*Table structure for table `sys_user_unit` */

DROP TABLE IF EXISTS `sys_user_unit`;

CREATE TABLE `sys_user_unit` (
  `userId` varchar(50) NOT NULL,
  `unitId` varchar(50) NOT NULL,
  KEY `FK_sys_user_unit` (`userId`),
  KEY `FK_sys_user_unit_unit` (`unitId`),
  CONSTRAINT `FK_sys_user_unit` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `FK_sys_user_unit_unit` FOREIGN KEY (`unitId`) REFERENCES `sys_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_unit` */

insert  into `sys_user_unit`(`userId`,`unitId`) values 
('402881ee547f564d01547f7dd49b002e','40283881493c2aff01493c32e2a70000');

/*Table structure for table `sys_version` */

DROP TABLE IF EXISTS `sys_version`;

CREATE TABLE `sys_version` (
  `id` varchar(50) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `build` varchar(50) DEFAULT NULL,
  `updateTime` varchar(50) DEFAULT NULL,
  `updateServer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_version` */

insert  into `sys_version`(`id`,`version`,`build`,`updateTime`,`updateServer`) values 
('1','1.0','49','2016-05-25 22:10','http://git.oschina.net/zengchao/JRelax-BI'),
('2','1.1','151','2017-01-09 14:18','http://git.oschina.net/zengchao/JRelax-BI'),
('3','1.2','198','2017-01-23 14:18','http://git.oschina.net/zengchao/JRelax-BI');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
