/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.7.16-log : Database - jrelax-bi
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

/*Table structure for table `bi_datasource` */

DROP TABLE IF EXISTS `bi_datasource`;

CREATE TABLE `bi_datasource` (
  `id` varchar(50) NOT NULL,
  `name` varchar(30) NOT NULL,
  `sqlCmd` text NOT NULL,
  `createUser` varchar(50) NOT NULL,
  `createTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_datasource` */

insert  into `bi_datasource`(`id`,`name`,`sqlCmd`,`createUser`,`createTime`) values 
('4028b88158af03570158af47b68e000b','测试数据源','select id, name, sex from bi_test1 where name = \'{#姓名#}\'','superadmin','2016-11-29 16:51:02'),
('4028b88158af03570158af6adbf80011','测试数据源-无参','select * from bi_test1','superadmin','2016-11-29 17:29:25'),
('4028b88158b8da450158b94836200009','系统日志模块统计','SELECT manipulatename AS \'系统模块\', COUNT(*) AS \'访问数量\' FROM sys_log GROUP BY manipulatename','superadmin','2016-12-01 15:27:47'),
('4028b88158bd92010158be031c820003','系统日志IP统计','SELECT logip as IP地址 , COUNT(*) AS 数量 FROM sys_log where type=1 GROUP BY logip','superadmin','2016-12-02 13:30:24'),
('4028b88158c282ad0158c28c61550001','系统日访问量','SELECT t AS \'日期\', c AS \'访问数\' FROM (SELECT LEFT(logtime, 10) AS t, COUNT(*) AS c FROM sys_log GROUP BY LEFT(logtime, 10) ORDER BY logtime DESC LIMIT 0, 7) AS a ORDER BY a.t ASC','superadmin','2016-12-03 10:38:49'),
('4028b88158c394ca0158c3bcb0180024','气泡图测试数据源','select * from bi_test2','superadmin','2016-12-03 16:11:12');

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

/*Table structure for table `bi_form_parent` */

DROP TABLE IF EXISTS `bi_form_parent`;

CREATE TABLE `bi_form_parent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `birthday` varchar(50) DEFAULT NULL COMMENT '出生日期',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='人员信息表';

/*Data for the table `bi_form_parent` */

insert  into `bi_form_parent`(`id`,`name`,`age`,`sex`,`mobile`,`birthday`,`address`) values 
(18,'张三',11,'男 ','13655559420','2015年06月03日','安徽省合肥市'),
(19,'中文',NULL,NULL,NULL,NULL,NULL),
(20,NULL,NULL,'中文',NULL,NULL,NULL);

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

/*Table structure for table `bi_test2_ext` */

DROP TABLE IF EXISTS `bi_test2_ext`;

CREATE TABLE `bi_test2_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `columnType` varchar(100) NOT NULL COMMENT '字段类型',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `comments` varchar(500) DEFAULT NULL COMMENT '字段描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_test2_ext` */

/*Table structure for table `bi_test2_ext_val` */

DROP TABLE IF EXISTS `bi_test2_ext_val`;

CREATE TABLE `bi_test2_ext_val` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '主表数据ID',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `columnVal` varchar(1000) DEFAULT NULL COMMENT '扩展字段值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_test2_ext_val` */

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
('8a80868853a692ad0153a6ab869a0009','system.debug','false',1),
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
('4028b88158b3bc850158b411f07b0003','自定义图表','bi_charts_type','图表类型','superadmin','2016-11-30 15:10:24');

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
('4028b88158c394ca0158c3ad98d00021','4028b88158b3bc850158b411f07b0003','bubble','气泡图',7,'superadmin','2016-12-03 15:54:43');

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
('8a1076ae58e159050158e159efce0000',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 10:11:57 057','系统登录','LogService'),
('8a1076ae58e159050158e15a4d6c0001',1,'访问菜单列表','superadmin','60.173.220.146','2016-12-09 10:12:21 021','菜单管理','LogService'),
('8a1076ae58e159050158e15a66930002',1,'禁用菜单：[Id:4028388148ac878b0148ac8820090000]','superadmin','60.173.220.146','2016-12-09 10:12:27 027','菜单管理','LogService'),
('8a1076ae58e159050158e15a6f8f0003',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 10:12:30 030','系统登录','LogService'),
('8a1076ae58e15d3e0158e168e0db0000',1,'用户：[superadmin] 退出系统','superadmin','60.173.220.146','2016-12-09 10:28:16 016','退出系统','LogService'),
('8a1076ae58e15d3e0158e16993090001',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 10:29:02 002','系统登录','LogService'),
('8a1076ae58e15d3e0158e17263750002',3,'错误代码:404，访问路径:/favicon.ico','system','60.173.220.146','2016-12-09 10:38:39 039','系统异常','LogService'),
('8a1076ae58e172f20158e1739ac30000',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 10:39:59 059','系统登录','LogService'),
('8a1076ae58e172f20158e173e5f50001',1,'用户：[superadmin] 退出系统','superadmin','60.173.220.146','2016-12-09 10:40:18 018','退出系统','LogService'),
('8a1076ae58e172f20158e178e28b0002',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 10:45:45 045','系统登录','LogService'),
('8a1076ae58e172f20158e17990060003',1,'锁定系统','superadmin','60.173.220.146','2016-12-09 10:46:30 030','个人中心','LogService'),
('8a1076ae58e172f20158e179a22a0004',1,'解锁系统','superadmin','60.173.220.146','2016-12-09 10:46:34 034','个人中心','LogService'),
('8a1076ae58e172f20158e17a46050005',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-09 10:47:16 016','系统异常','LogService'),
('8a1076ae58e17c030158e17d78420000',3,'错误代码:404，访问路径:/system/plugins','superadmin','60.173.220.146','2016-12-09 10:50:46 046','系统异常','LogService'),
('8a1076ae58e17c030158e17da2d80001',1,'com.jrelax.ext.plugins.AutoVersionPlugin插件装载成功！','superadmin','60.173.220.146','2016-12-09 10:50:57 057','插件管理','LogService'),
('8a1076ae58e17ec30158e17f6f390000',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:54 054','系统异常','LogService'),
('8a1076ae58e17ec30158e17f6f3a0001',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','60.173.220.146','2016-12-09 10:52:54 054','系统异常','LogService'),
('8a1076ae58e17ec30158e17f6f3a0002',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:54 054','系统异常','LogService'),
('8a1076ae58e17ec30158e17f6f400003',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:54 054','系统异常','LogService'),
('8a1076ae58e17ec30158e17f6fd30004',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f6fe20005',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f6fef0006',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f70290007',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f70620008',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f70c90009',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f70cc000a',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f70dd000b',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f70e6000c',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f7115000d',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f7153000e',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f71a6000f',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f721d0010',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f722a0011',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f722e0012',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72340013',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72840014',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72890015',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72bf0016',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72cb0017',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72ce0018',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f72fc0019',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f7331001a',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','60.173.220.146','2016-12-09 10:52:55 055','系统异常','LogService'),
('8a1076ae58e17ec30158e17f736f001b',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f7371001c',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f737c001d',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f73bc001e',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f73cd001f',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f73d40020',3,'错误代码:404，访问路径:/undefined/framework/plugins/jquery-1.11.1.min.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f73e00021',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f74130022',3,'错误代码:404，访问路径:/undefined/framework/plugins/charts/chartjs/Chart.min.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f74180023',3,'错误代码:404，访问路径:/undefined/app/charts/datasource.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f74490024',3,'错误代码:404，访问路径:/undefined/app/charts/utils.js','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f75470025',3,'错误代码:404，访问路径:/undefined/bi/charts/detail','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e17ec30158e17f75b10026',3,'错误代码:404，访问路径:/undefined/bi/charts/detail','superadmin','60.173.220.146','2016-12-09 10:52:56 056','系统异常','LogService'),
('8a1076ae58e181450158e1823a080000',1,'切换布局：[layout: ${layout}]','superadmin','60.173.220.146','2016-12-09 10:55:57 057','系统首页','LogService'),
('8a1076ae58e181450158e18247080001',1,'切换布局：[layout: ${layout}]','superadmin','60.173.220.146','2016-12-09 10:56:01 001','系统首页','LogService'),
('8a1076ae58e181450158e18255290002',1,'切换布局：[layout: ${layout}]','superadmin','60.173.220.146','2016-12-09 10:56:04 004','系统首页','LogService'),
('8a1076ae58e181450158e1826d530003',3,'错误代码:404，访问路径:/open/doc','superadmin','60.173.220.146','2016-12-09 10:56:11 011','系统异常','LogService'),
('8a1076ae58e181450158e182ad790004',1,'用户：[superadmin] 退出系统','superadmin','60.173.220.146','2016-12-09 10:56:27 027','退出系统','LogService'),
('8a1076ae58e181450158e1877d580005',3,'错误代码:404，访问路径:/testproxy.php','system','185.25.148.240','2016-12-09 11:01:42 042','系统异常','LogService'),
('8a1076ae58e181450158e18a84000006',1,'用户：[superadmin] 成功登录系统','superadmin','60.208.139.35','2016-12-09 11:05:01 001','系统登录','LogService'),
('8a1076ae58e181450158e18a92640007',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.208.139.35','2016-12-09 11:05:04 004','系统异常','LogService'),
('8a1076ae58e181450158e18ae7210008',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 11:05:26 026','登录系统','LogService'),
('8a1076ae58e181450158e18af9b20009',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','60.208.139.35','2016-12-09 11:05:31 031','请求出错','LogService'),
('8a1076ae58e181450158e18af9c2000a',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cdb1a444001d','superadmin','60.208.139.35','2016-12-09 11:05:31 031','系统异常','LogService'),
('8a1076ae58e181450158e18b5148000b',1,'切换布局：[layout: ${layout}]','superadmin','60.208.139.35','2016-12-09 11:05:53 053','系统首页','LogService'),
('8a1076ae58e181450158e18c4302000c',1,'用户：[superadmin] 成功登录系统','superadmin','180.139.143.215','2016-12-09 11:06:55 055','系统登录','LogService'),
('8a1076ae58e181450158e18c5559000d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','180.139.143.215','2016-12-09 11:07:00 000','系统异常','LogService'),
('8a1076ae58e181450158e18cbd77000e',3,'错误代码:404，访问路径:/open/doc','superadmin','60.208.139.35','2016-12-09 11:07:26 026','系统异常','LogService'),
('8a1076ae58e181450158e18ccb07000f',1,'切换布局：[layout: ${layout}]','superadmin','180.139.143.215','2016-12-09 11:07:30 030','系统首页','LogService'),
('8a1076ae58e181450158e19da58f0010',1,'用户：[superadmin] 成功登录系统','superadmin','119.137.54.235','2016-12-09 11:25:54 054','系统登录','LogService'),
('8a1076ae58e181450158e19db7600011',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.137.54.235','2016-12-09 11:25:59 059','系统异常','LogService'),
('8a1076ae58e181450158e19db7a80012',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.137.54.235','2016-12-09 11:25:59 059','请求出错','LogService'),
('8a1076ae58e181450158e19db7ef0013',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.137.54.235','2016-12-09 11:25:59 059','请求出错','LogService'),
('8a1076ae58e181450158e19db8010014',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.137.54.235','2016-12-09 11:25:59 059','系统异常','LogService'),
('8a1076ae58e181450158e19db82c0015',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.137.54.235','2016-12-09 11:25:59 059','请求出错','LogService'),
('8a1076ae58e181450158e19db84a0016',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.137.54.235','2016-12-09 11:25:59 059','系统异常','LogService'),
('8a1076ae58e181450158e19db86a0017',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.137.54.235','2016-12-09 11:25:59 059','请求出错','LogService'),
('8a1076ae58e181450158e19db8910018',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.137.54.235','2016-12-09 11:25:59 059','系统异常','LogService'),
('8a1076ae58e181450158e19db8ae0019',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.137.54.235','2016-12-09 11:25:59 059','请求出错','LogService'),
('8a1076ae58e181450158e19db8d0001a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.137.54.235','2016-12-09 11:25:59 059','系统异常','LogService'),
('8a1076ae58e181450158e19db914001b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.137.54.235','2016-12-09 11:25:59 059','系统异常','LogService'),
('8a1076ae58e181450158e1a622a3001c',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-09 11:35:11 011','系统异常','LogService'),
('8a1076ae58e181450158e1a91e05001d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 11:38:26 026','登录系统','LogService');

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
('297ec0504dfb4517014dfb805a600005','自定义工作流','004','/bi/flow','fa fa-sitemap',4,1,'','-1',0,0,1,0,'2015-06-16 16:33:22'),
('297ec0504dfb4517014dfb8441740006','自定义表单','002','/bi/form','ti-pencil-alt',2,1,'','-1',0,0,1,0,'2015-06-16 16:37:38'),
('4028388148ac878b0148ac8820090000','系统管理','008','/system','glyphicon glyphicon-cog',8,0,'管理系统中的用户、角色、菜单等','-1',1,0,1,0,'2014-09-25 19:17:54'),
('4028388148acb42f0148acccd58d0001','角色管理','008003','/system/role','fa fa-group',3,1,'','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-09-25 20:32:58'),
('4028388148acb42f0148acd9a6170005','用户管理','008002','/system/user','ti-user',2,1,'','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-09-25 20:46:58'),
('4028388148b2fe810148b32ebc0d002f','组织架构','008001','/system/unit','fa fa-sitemap',1,1,'软件内部的组织结构，也可以是公司内部的组织结构','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-09-27 02:17:37'),
('4028388148b2fe810148b32ef7120030','菜单管理','008004','/system/res','ti-menu-alt',4,1,'','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-09-27 02:17:52'),
('40283881494264460149428484610000','仪表板','001','/index','glyphicon glyphicon-home',1,1,'集中显示各种数据，报表等。','-1',0,0,1,0,'2014-10-24 22:17:01'),
('4028388149428faf0149429c02770000','系统日志','008009','/system/log','fa fa-history',9,1,'查看系统日志信息，包含所有功能的操作日志。','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-10-24 22:42:40'),
('402838814a192f8c014a1995ace60000','通知中心','008006','/system/notify','fa fa-bell-o',6,1,'集中系统的各种通知','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-12-05 16:34:07'),
('402838814a512e0b014a5135c3720000','数据字典','008008','/system/datadict','fa fa-database',8,1,'系统数据字典，公共数据配置/存储中心','4028388148ac878b0148ac8820090000',0,0,1,0,'2014-12-16 11:48:05'),
('402881ee547ea15801547eb07a2f0002','自定义数据源','005','/bi/ds','fa fa-database',5,1,'','-1',0,0,1,0,'2016-05-05 10:12:55'),
('402881ee547ea15801547eb17d800004','自定义图表','003','/bi/charts','fa fa-pie-chart',3,1,'基于 自定义数据源 模块生成图表','-1',0,0,1,0,'2016-05-05 10:14:01'),
('402881ff500261d4015002732e960000','数据库管理工具','007','/bi/table','fa fa-table',7,1,'数据库表管理','-1',0,0,1,1,'2015-09-25 11:01:54');

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
('402881ee5374fb9b01537501c7680017','r','402881ee5374fb9b015374fcd8d80004',1,'','2016-03-14 20:02:44'),
('402881ee54eff98b0154f01a1b890059','项目测试组','40283881493c2aff01493c32e2a70000',1,'项目管理方面','2016-05-27 10:45:23');

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
('402838814a143628014a149ebc6e0002','4028388148ac878b0148ac8820090000'),
('402838814a143628014a149ebc6e0002','4028388148acb42f0148acccd58d0001'),
('402838814a143628014a149ebc6e0002','4028388148acb42f0148acd9a6170005'),
('402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ebc0d002f'),
('402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ef7120030'),
('402838814a143628014a149ebc6e0002','40283881494264460149428484610000'),
('402838814a143628014a149ebc6e0002','4028388149428faf0149429c02770000'),
('4028388148d681830148d6857c71000d','4028388148ac878b0148ac8820090000'),
('4028388148d681830148d6857c71000d','4028388148acb42f0148acccd58d0001'),
('4028388148d681830148d6857c71000d','4028388148acb42f0148acd9a6170005'),
('4028388148d681830148d6857c71000d','4028388148b2fe810148b32ebc0d002f'),
('4028388148d681830148d6857c71000d','4028388148b2fe810148b32ef7120030'),
('4028388148d681830148d6857c71000d','40283881494264460149428484610000'),
('4028388148d681830148d6857c71000d','4028388149428faf0149429c02770000'),
('4028388148d681830148d6857c71000d','402838814a192f8c014a1995ace60000'),
('40283881497b0b0201497b2a16350005','40283881494264460149428484610000'),
('402838814ac3ffdc014ac414ee76000b','40283881494264460149428484610000'),
('402881ee5374fb9b01537501c7680017','40283881494264460149428484610000'),
('40283881497b0b0201497b2a16350004','40283881494264460149428484610000'),
('40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000'),
('402881ee54eff98b0154f01a1b890059','40283881494264460149428484610000');

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
('402838814a143628014a14a5b7ca0010','402838814a143628014a149ebc6e0002','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7ca0011','402838814a143628014a149ebc6e0002','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7cb0012','402838814a143628014a149ebc6e0002','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7cb0013','402838814a143628014a149ebc6e0002','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7cb0014','402838814a143628014a149ebc6e0002','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7cb0015','402838814a143628014a149ebc6e0002','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7cb0016','402838814a143628014a149ebc6e0002','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7cc0017','402838814a143628014a149ebc6e0002','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7cc0018','402838814a143628014a149ebc6e0002','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7cc0019','402838814a143628014a149ebc6e0002','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7cc001a','402838814a143628014a149ebc6e0002','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7cc001b','402838814a143628014a149ebc6e0002','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7cd0020','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7cd0021','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7cd0022','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7ce0023','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7ce0024','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7ce0025','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7ce0026','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7ce0027','402838814a143628014a149ebc6e0002','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7ce0028','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7ce0029','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7ce002a','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7cf002b','402838814a143628014a149ebc6e0002','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402838814a143628014a14a5b7cf002c','402838814a143628014a149ebc6e0002','4028388149428faf0149429c02770000','4028388148bc169f0148bc5b25620001'),
('402838814a143628014a14a5b7cf002d','402838814a143628014a149ebc6e0002','4028388149428faf0149429c02770000','4028388148bc169f0148bc5b66bb0002'),
('402838814a143628014a14a5b7cf002e','402838814a143628014a149ebc6e0002','4028388149428faf0149429c02770000','4028388148bc169f0148bc5b8ae60003'),
('402838814a143628014a14a5b7cf002f','402838814a143628014a149ebc6e0002','4028388149428faf0149429c02770000','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c32b0001','4028388148d681830148d6857c71000d','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c32c0002','4028388148d681830148d6857c71000d','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c32c0003','4028388148d681830148d6857c71000d','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c32c0004','4028388148d681830148d6857c71000d','4028388148ac878b0148ac8820090000','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c32c0005','4028388148d681830148d6857c71000d','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c32c0006','4028388148d681830148d6857c71000d','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c32c0007','4028388148d681830148d6857c71000d','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c32d0008','4028388148d681830148d6857c71000d','4028388148acb42f0148acccd58d0001','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c32d0009','4028388148d681830148d6857c71000d','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c32d000a','4028388148d681830148d6857c71000d','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c32d000b','4028388148d681830148d6857c71000d','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c32d000c','4028388148d681830148d6857c71000d','4028388148acb42f0148acd9a6170005','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c33a003d','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c33a003e','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c33a003f','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c33a0040','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ebc0d002f','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c33b0041','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c33b0042','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c33b0043','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c33b0044','4028388148d681830148d6857c71000d','4028388148b2fe810148b32ef7120030','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c33b0045','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c33c0046','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c33c0047','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c33c0048','4028388148d681830148d6857c71000d','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c33c0049','4028388148d681830148d6857c71000d','4028388149428faf0149429c02770000','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c33d004a','4028388148d681830148d6857c71000d','4028388149428faf0149429c02770000','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c33d004b','4028388148d681830148d6857c71000d','4028388149428faf0149429c02770000','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c33d004c','4028388148d681830148d6857c71000d','4028388149428faf0149429c02770000','4028388148bc169f0148bc5bb1870004'),
('402838814a192f8c014a1996c3430061','4028388148d681830148d6857c71000d','402838814a192f8c014a1995ace60000','4028388148bc169f0148bc5b25620001'),
('402838814a192f8c014a1996c3430062','4028388148d681830148d6857c71000d','402838814a192f8c014a1995ace60000','4028388148bc169f0148bc5b66bb0002'),
('402838814a192f8c014a1996c3430063','4028388148d681830148d6857c71000d','402838814a192f8c014a1995ace60000','4028388148bc169f0148bc5b8ae60003'),
('402838814a192f8c014a1996c3430064','4028388148d681830148d6857c71000d','402838814a192f8c014a1995ace60000','4028388148bc169f0148bc5bb1870004'),
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
('402881ee547f564d01547fb4d98d00be','40283881497b0b0201497b2a16350004','402881ff500261d4015002732e960000','4028388148bc169f0148bc5bb1870004'),
('402881ee54eff98b0154f01a1b8c0066','402881ee54eff98b0154f01a1b890059','40283881494264460149428484610000','4028388148bc169f0148bc5b25620001'),
('402881ee54eff98b0154f01a1b8d0067','402881ee54eff98b0154f01a1b890059','40283881494264460149428484610000','4028388148bc169f0148bc5b66bb0002'),
('402881ee54eff98b0154f01a1b8d0068','402881ee54eff98b0154f01a1b890059','40283881494264460149428484610000','4028388148bc169f0148bc5b8ae60003'),
('402881ee54eff98b0154f01a1b8d0069','402881ee54eff98b0154f01a1b890059','40283881494264460149428484610000','4028388148bc169f0148bc5bb1870004');

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
('40283881493c2aff01493c32e2a70000','内置组织','001','曾超','18955185893','','zengc@nethsoft.com','http://www.nethsoft.com','-1',0,1,1,'2014-10-23 16:50:07');

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
('40283881493dcf8901493dd072210000','nethsoft','E10ADC3949BA59ABBE56E057F20F883E','安徽网禾信息','18955185893','office@nethsoft.com','359921330','palette',NULL,1,0,'2014-10-24 00:21:51',NULL,NULL,0,NULL),
('402838814a143628014a149f19d20003','hefei','C4CA4238A0B923820DCC509A6F75849B','合肥分公司','','','','palette',NULL,1,1,'2014-12-04 17:26:18',NULL,NULL,0,NULL),
('402838814ac1fe5f014ac215e2b6000c','doc','C4CA4238A0B923820DCC509A6F75849B','文档共享中心','','','','palette',NULL,1,0,'2015-01-07 09:50:21',NULL,NULL,0,NULL),
('402881ee5374fb9b0153750220d70033','r1','C4CA4238A0B923820DCC509A6F75849B','','','','','palette',NULL,1,0,'2016-03-14 20:03:07','2016-03-14 20:03:22','localhost',1,NULL),
('402881ee547f564d01547f7dd49b002e','superadmin','C4CA4238A0B923820DCC509A6F75849B','超级管理员','','','','palette.6','${layout}',1,0,'2016-05-05 13:57:13','2016-12-09 11:25:54','119.137.54.235',1,NULL),
('402881ee547f564d01547f7e24910031','zengc','C4CA4238A0B923820DCC509A6F75849B','曾超','','','','palette',NULL,1,0,'2016-05-05 13:57:33','2016-05-05 14:57:43','localhost',1,NULL),
('402881ee54eff98b0154f02300670083','test','C4CA4238A0B923820DCC509A6F75849B','项目测试','','','','palette.5',NULL,1,1,'2016-05-27 10:55:06','2016-05-27 15:42:31','192.168.1.126',1,NULL);

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
('402838814a143628014a149ebc6e0002','402838814a143628014a149f19d20003'),
('40283881497b0b0201497b2a16350005','402838814ac1fe5f014ac215e2b6000c'),
('40283881497b0b0201497b2a16350005','40283881493dcf8901493dd072210000'),
('402838814ac3ffdc014ac414ee76000b','40283881493dcf8901493dd072210000'),
('402881ee5374fb9b01537501c7680017','402881ee5374fb9b0153750220d70033'),
('4028388148d681830148d6857c71000d','402881ee547f564d01547f7dd49b002e'),
('40283881497b0b0201497b2a16350004','402881ee547f564d01547f7e24910031'),
('402881ee54eff98b0154f01a1b890059','402881ee54eff98b0154f02300670083');

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
('402881ee547f564d01547f7dd49b002e','40283881493c2aff01493c32e2a70000'),
('402881ee547f564d01547f7e24910031','40283881493c2aff01493c32e2a70000'),
('402881ee54eff98b0154f02300670083','40283881493c2aff01493c32e2a70000');

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
('1','1.0','49','2016-05-25 22:10','svn://svn.nethsoft.com/jrelax/trunk');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
