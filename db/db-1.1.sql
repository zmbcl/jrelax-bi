/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.7.17 : Database - jrelax-bi-demo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jrelax-bi-demo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jrelax-bi-demo`;

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
('2c91647d5900bf85015901f0641f0072','kkk','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2016-12-15 18:04:08'),
('2c91647d5900bf85015902ebb20a008e','666','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158af03570158af6adbf80011\",\"name\":\"测试数据源-无参\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-15 22:38:38'),
('2c91647d5900bf850159058dd75100b7','qwe','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":true,\"text\":\"11\",\"position\":\"left\"}}}}','超级管理员','2016-12-16 10:54:58'),
('2c91647d5900bf8501590681868600d0','13213','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2016-12-16 15:21:08'),
('2c91647d5900bf85015906828c6900d2','11111','bubble','{\"type\":\"bubble\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"title\":{\"display\":true,\"text\":\"123121\",\"position\":\"top\"}}}}','超级管理员','2016-12-16 15:22:16'),
('2c91647d5914e621015915d97220005c','213','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"123\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2016-12-19 14:51:29'),
('2c91647d5914e6210159168c43480078','5','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":true,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2016-12-19 18:06:48'),
('2c91647d5914e62101591a19a40300a9','ss','line','{\"type\":\"line\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"line\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"},\"legend\":{\"display\":false,\"position\":\"top\"},\"elements\":{\"line\":{\"fill\":true},\"point\":{\"radius\":\"3\"}}}}}','超级管理员','2016-12-20 10:40:05'),
('2c91647d591a463c01591a8132fa0005','11','bubble','{\"type\":\"bubble\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-20 12:33:11'),
('2c91647d5935027501593892ea9a0012','555','bubble','{\"type\":\"bubble\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"},{\"id\":\"4028b88158af03570158af6adbf80011\",\"name\":\"测试数据源-无参\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-26 08:41:09'),
('2c91647d59350275015939ac74190024','test','bubble','{\"type\":\"bubble\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"test\",\"xAxis\":\"id\",\"yAxis\":\"name\",\"rAxis\":\"sex\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"title\":{\"display\":true,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2016-12-26 13:48:40'),
('2c91647d59350275015939cc6c020029','几','line','{\"type\":\"line\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"line\",\"options\":{\"legend\":{\"display\":false},\"elements\":{\"line\":{\"fill\":false},\"point\":{\"radius\":3}}}}}','超级管理员','2016-12-26 14:23:35'),
('2c91647d59350275015939cd3563002a','付费电视','bubble','{\"type\":\"bubble\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"sex\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"title\":{\"display\":true,\"text\":\"分单萨芬\",\"position\":\"bottom\"}}}}','超级管理员','2016-12-26 14:24:26'),
('2c91647d594fedd0015967fbed1a00a7','1','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2017-01-04 13:38:00'),
('2c91647d594fedd001596c9a0a5800f0','访问量','line','{\"type\":\"line\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"line\",\"options\":{\"legend\":{\"display\":false},\"elements\":{\"line\":{\"fill\":false},\"point\":{\"radius\":3}}}}}','超级管理员','2017-01-05 11:09:11'),
('4028b88158c394ca0158c398392c0002','日志访问统计','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":false,\"text\":\"日期分布\",\"position\":\"top\"}}}}','超级管理员','2016-12-03 15:31:22'),
('4028b88158c394ca0158c39c387b0003','日志统计 - 环形','doughnut','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"},\"cutoutPercentage\":\"50\"}}}','超级管理员','2016-12-03 15:35:44'),
('4028b88158c394ca0158c3a36d140012','日志统计 - 极坐标图','polar-area','{\"type\":\"polarArea\",\"datasource\":[{\"id\":\"4028b88158b8da450158b94836200009\",\"name\":\"系统日志模块统计\",\"xAxis\":\"系统模块\",\"yAxis\":\"访问数量\"}],\"charts\":{\"type\":\"polarArea\",\"options\":{\"legend\":{\"display\":true},\"animation\":{\"animateScale\":true}}}}','超级管理员','2016-12-03 15:43:37'),
('4028b88158c394ca0158c3abc0fc001a','日志统计 - 雷达图','radar','{\"type\":\"radar\",\"datasource\":[{\"id\":\"4028b88158b8da450158b94836200009\",\"name\":\"系统日志模块统计\",\"xAxis\":\"系统模块\",\"yAxis\":\"访问数量\"}],\"charts\":{\"type\":\"radar\",\"options\":{\"legend\":{\"display\":false},\"animation\":{\"animateScale\":true}}}}','超级管理员','2016-12-03 15:52:42'),
('4028b88158c394ca0158c3c0d84f0025','气泡图-演示','bubble','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158c394ca0158c3bcb0180024\",\"name\":\"气泡图测试数据源\",\"xAxis\":\"x\",\"yAxis\":\"y\", \"rAxis\":\"r\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"title\":{\"display\":false,\"text\":\"测试图表\",\"position\":\"top\"}}}}','超级管理员','2016-12-03 16:15:45'),
('4028b88158cd06060158cddb966d0023','柱状图','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158bd92010158be031c820003\",\"name\":\"系统日志IP统计\",\"xAxis\":\"IP地址\",\"yAxis\":\"数量\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-05 15:21:09'),
('8a1076ae58e79bc80158ed5f0a1d013c','kk','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158c394ca0158c3bcb0180024\",\"name\":\"气泡图测试数据源\",\"xAxis\":\"x\",\"yAxis\":\"y\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-11 18:12:58'),
('8a1076ae58f0abd60158f0f735780021','aaaaaaaaaaaa','bubble','{\"type\":\"bubble\",\"datasource\":[{\"id\":\"4028b88158c394ca0158c3bcb0180024\",\"name\":\"气泡图测试数据源\",\"xAxis\":\"x\",\"yAxis\":\"y\"}],\"charts\":{\"type\":\"bubble\",\"options\":{\"legend\":{\"display\":true,\"reverse\":true}}}}','超级管理员','2016-12-12 10:58:02'),
('8a1076ae58f0abd60158f13c94d40036','12121','line','{\"type\":\"line\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"sex\"}],\"charts\":{\"type\":\"line\",\"options\":{\"title\":{\"display\":true,\"text\":\"\",\"position\":\"top\"},\"legend\":{\"display\":true,\"position\":\"top\"},\"elements\":{\"line\":{\"fill\":true},\"point\":{\"radius\":\"0\"}}}}}','超级管理员','2016-12-12 12:13:49'),
('8a1076ae58f0abd60158f218440e00a2','','bar','{\"type\":\"bar\",\"datasource\":[{\"id\":\"4028b88158c394ca0158c3bcb0180024\",\"name\":\"气泡图测试数据源\",\"xAxis\":\"x\",\"yAxis\":\"y\"}],\"charts\":{\"type\":\"bar\",\"options\":{\"title\":{\"display\":false,\"text\":\"\",\"position\":\"top\"}}}}','超级管理员','2016-12-12 16:13:46'),
('8a1076ae58f0abd60158f235ae2000af','aaa','doughnut','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"},{\"id\":\"4028b88158af03570158af6adbf80011\",\"name\":\"测试数据源-无参\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":true,\"text\":\"aaa\",\"position\":\"top\"},\"cutoutPercentage\":\"\"}}}','超级管理员','2016-12-12 16:45:54'),
('8a1076ae58f0abd60158f2640b4500dc','啊啊奋斗的','pie','{\"type\":\"pie\",\"datasource\":[{\"id\":\"4028b88158af03570158af47b68e000b\",\"name\":\"测试数据源\",\"xAxis\":\"id\",\"yAxis\":\"name\"}],\"charts\":{\"type\":\"pie\",\"options\":{\"title\":{\"display\":true,\"text\":\"阿斯蒂芬\",\"position\":\"top\"}}}}','超级管理员','2016-12-12 17:36:32');

/*Table structure for table `bi_charts_ext` */

DROP TABLE IF EXISTS `bi_charts_ext`;

CREATE TABLE `bi_charts_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `columnType` varchar(100) NOT NULL COMMENT '字段类型',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `comments` varchar(500) DEFAULT NULL COMMENT '字段描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_charts_ext` */

/*Table structure for table `bi_charts_ext_ext` */

DROP TABLE IF EXISTS `bi_charts_ext_ext`;

CREATE TABLE `bi_charts_ext_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `columnType` varchar(100) NOT NULL COMMENT '字段类型',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `comments` varchar(500) DEFAULT NULL COMMENT '字段描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_charts_ext_ext` */

/*Table structure for table `bi_charts_ext_ext_val` */

DROP TABLE IF EXISTS `bi_charts_ext_ext_val`;

CREATE TABLE `bi_charts_ext_ext_val` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '主表数据ID',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `columnVal` varchar(1000) DEFAULT NULL COMMENT '扩展字段值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_charts_ext_ext_val` */

/*Table structure for table `bi_charts_ext_val` */

DROP TABLE IF EXISTS `bi_charts_ext_val`;

CREATE TABLE `bi_charts_ext_val` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '主表数据ID',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `columnVal` varchar(1000) DEFAULT NULL COMMENT '扩展字段值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_charts_ext_val` */

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
('4028b88158b8da450158b94836200009','系统日志模块统计','SELECT manipulatename AS \'系统模块\', COUNT(*) AS \'访问数量\' FROM sys_log where type < 3 GROUP BY manipulatename','superadmin','2016-12-01 15:27:47'),
('4028b88158bd92010158be031c820003','系统日志IP统计','SELECT logip as IP地址 , COUNT(*) AS 数量 FROM sys_log where type=1 GROUP BY logip','superadmin','2016-12-02 13:30:24'),
('4028b88158c282ad0158c28c61550001','系统日访问量','SELECT t AS \'日期\', c AS \'访问数\' FROM (SELECT LEFT(logtime, 10) AS t, COUNT(*) AS c FROM sys_log GROUP BY LEFT(logtime, 10) ORDER BY logtime DESC LIMIT 0, 7) AS a ORDER BY a.t ASC','superadmin','2016-12-03 10:38:49');

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
('2c91647d5914e62101591a225cbc00af','ceshi ',NULL,'bi_datasource','bi_charts,bi_datasource,bi_datasource_params','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\"><h4 fd-view=\"formtitle\">表单标题</h4></div><table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n																										<tbody><tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																									</tbody></table></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\">\n   <h4 fd-view=\"formtitle\">表单标题</h4>\n  </div>\n  <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n   <tbody>\n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n   </tbody>\n  </table>\n </div>\n</form>','2.0','superadmin','2016-12-20 10:49:42'),
('2c91647d592426b9015924a701e1001c','DDD',NULL,'bi_charts','bi_charts,bi_datasource,bi_datasource_params,bi_flow,bi_form,bi_form_children,bi_form_parent,bi_form_parent_ext,bi_form_parent_ext_val,bi_test1,bi_test2,bi_test2_ext,bi_test2_ext_val','<div class=\"containers fd-view-drag-in\" style=\"background-color: rgb(255, 0, 0);\">\n							<div class=\"hide\" id=\"script\"></div>\n						<table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n																										<tbody><tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"><span contenteditable=\"true\" fd-view=\"label\" id=\"v_label\">标签：</span></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"><input type=\"text\" class=\"form-control inline\" fd-view=\"input\" id=\"v_input\" style=\"width:200px\" placeholder=\"\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"><input type=\"password\" class=\"form-control inline\" fd-view=\"password\" id=\"v_password\" style=\"width:200px\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\" editable=\"true\"></td> 													</tr>\n																									</tbody></table></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\" style=\"background-color: rgb(255, 0, 0);\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n   <tbody>\n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"><span fd-view=\"label\" id=\"v_label\">标签：</span></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"><input type=\"text\" class=\"form-control inline\" fd-view=\"input\" id=\"v_input\" style=\"width:200px\" placeholder=\"\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"><input type=\"password\" class=\"form-control inline\" fd-view=\"password\" id=\"v_password\" style=\"width:200px\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\" editable=\"true\"></td> \n    </tr> \n   </tbody>\n  </table>\n </div>\n</form>','2.0','superadmin','2016-12-26 14:14:10'),
('2c91647d593af28c01593e286d180050','mytest',NULL,'bi_form','bi_form','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<span contenteditable=\"true\" fd-view=\"label\" id=\"v_label\">标签：</span><input type=\"text\" class=\"form-control inline\" fd-view=\"input\" id=\"v_input\" style=\"width:200px\"><input type=\"password\" class=\"form-control inline\" fd-view=\"password\" id=\"v_password\" style=\"width:200px\"><select class=\"form-control\" fd-view=\"select\" id=\"v_select\" style=\"width:200px\" field=\"tableName\" required=\"required\">\n													<option>选项一</option>\n													<option>选项二</option>\n												</select></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <span fd-view=\"label\" id=\"v_label\">标签：</span>\n  <input type=\"text\" class=\"form-control inline\" fd-view=\"input\" id=\"v_input\" style=\"width:200px\">\n  <input type=\"password\" class=\"form-control inline\" fd-view=\"password\" id=\"v_password\" style=\"width:200px\">\n  <select class=\"form-control\" fd-view=\"select\" id=\"v_select\" style=\"width:200px\" name=\"tableName\" required> <option>选项一</option> <option>选项二</option> </select>\n </div>\n</form>','2.0','superadmin','2016-12-27 10:42:33'),
('2c91647d594fedd001596d3fcea10126','12345',NULL,'bi_charts_ext','bi_charts_ext','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\"><h4 fd-view=\"formtitle\">表单标题</h4></div><table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n																										<tbody><tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																									</tbody></table><div class=\"row\" contenteditable=\"true\" fd-view=\"col66\" id=\"v_col66\">\n													<div class=\"col-md-6 fd-view-drag-in fd-view-bordered\"></div>\n													<div class=\"col-md-6 fd-view-drag-in fd-view-bordered\"></div>\n												</div><select class=\"form-control\" fd-view=\"select\" id=\"v_select\" style=\"width:200px\">\n													<option>选项一</option>\n													<option>选项二</option>\n												</select><label class=\"radio-inline\"> <input type=\"radio\" fd-view=\"radio\" id=\"v_radio\"> <span fd-view=\"label\" contenteditable=\"true\">单选按钮</span>\n												</label><input type=\"file\" class=\"form-control inline\" fd-view=\"fileupload\" id=\"v_fileupload\"></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\">\n   <h4 fd-view=\"formtitle\">表单标题</h4>\n  </div>\n  <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n   <tbody>\n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n    <tr> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n     <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n    </tr> \n   </tbody>\n  </table>\n  <div class=\"row\" fd-view=\"col66\" id=\"v_col66\"> \n   <div class=\"col-md-6 fd-view-drag-in fd-view-bordered\"></div> \n   <div class=\"col-md-6 fd-view-drag-in fd-view-bordered\"></div> \n  </div>\n  <select class=\"form-control\" fd-view=\"select\" id=\"v_select\" style=\"width:200px\"> <option>选项一</option> <option>选项二</option> </select>\n  <label class=\"radio-inline\"> <input type=\"radio\" fd-view=\"radio\" id=\"v_radio\"> <span fd-view=\"label\">单选按钮</span> </label>\n  <input type=\"file\" class=\"form-control inline\" fd-view=\"fileupload\" id=\"v_fileupload\">\n </div>\n</form>','2.0','superadmin','2017-01-05 14:10:15'),
('2c91647d594fedd0015973e3b8cb0182','aaa',NULL,'bi_charts','bi_charts','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<div class=\"row\" contenteditable=\"true\" fd-view=\"col12\" id=\"v_col12\">\n													<div class=\"col-md-12 fd-view-drag-in fd-view-bordered\"><table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n																										<tbody><tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																									</tbody></table></div>\n												</div><div class=\"row\" contenteditable=\"true\" fd-view=\"col66\" id=\"v_col66\">\n													<div class=\"col-md-6 fd-view-drag-in fd-view-bordered\"><table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n																										<tbody><tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																									</tbody></table></div>\n													<div class=\"col-md-6 fd-view-drag-in fd-view-bordered\"><table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\">\n																										<tbody><tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																										<tr>\n																												<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 														<td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> 													</tr>\n																									</tbody></table></div>\n												</div></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <div class=\"row\" fd-view=\"col12\" id=\"v_col12\"> \n   <div class=\"col-md-12 fd-view-drag-in fd-view-bordered\">\n    <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n  <div class=\"row\" fd-view=\"col66\" id=\"v_col66\"> \n   <div class=\"col-md-6 fd-view-drag-in fd-view-bordered\">\n    <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n   <div class=\"col-md-6 fd-view-drag-in fd-view-bordered\">\n    <table id=\"v_table\" fd-view=\"table\" class=\"table table-bordered\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n      <tr> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n       <td fd-view=\"table_td\" class=\"fd-view-drag-in\" style=\"width:25%;\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n </div>\n</form>','2.0','superadmin','2017-01-06 21:07:00'),
('402838814ae76a71014ae76ad2fd0000','请假单','您的请假申请已经提交，请等待相关负责人审批！','bi_form_parent','bi_form_parent','<div class=\"design design-item\" tip=\"您的请假申请已经提交，请等待相关负责人审批！\"> \n <center> \n  <h4 class=\"bb\" id=\"formTitle\" t=\"label\" name=\"data_0\">请假单</h4> \n </center> \n <table class=\"table table-bordered no-m\" contenteditable=\"true\" t=\"table\"> \n  <tbody> \n   <tr> \n    <td class=\"design-item\" style=\"text-align: right;\">请假人</td> \n    <td class=\"design-item\"> <span class=\"disabled\" t=\"macros\" data-element=\"\" name=\"data_0\" macrostype=\"user_realname\">{宏控件}</span> </td> \n    <td class=\"design-item\">所在部门</td> \n    <td class=\"design-item\"> <span class=\"disabled\" t=\"macros\" data-element=\"\" name=\"data_1\" macrostype=\"user_unitname\">{宏控件}</span> </td> \n   </tr> \n   <tr> \n    <td class=\"design-item\">请假原因</td> \n    <td class=\"design-item\" colspan=\"3\"> <textarea name=\"data_2\" class=\"form-control\" placeholder=\"请输入请假原因...\" t=\"textarea\" data-element=\"\" data-required=\"true\">请输入请假原因...</textarea> </td> \n   </tr> \n   <tr> \n    <td class=\"design-item\">事项类型</td> \n    <td class=\"design-item\"> <select name=\"data_3\" class=\"form-control\" t=\"select\" data-element=\"\"> <option value=\"1\">事假</option> <option value=\"2\">病假</option> <option value=\"3\">带薪休假</option> </select> </td> \n    <td class=\"design-item\">请假时间</td> \n    <td class=\"design-item\"><span class=\"disabled\" t=\"macros\" data-element=\"\" name=\"data_4\" macrostype=\"dt_yyyy-MM-dd HH:mm:ss\">{宏控件}</span> </td> \n   </tr> \n   <tr> \n    <td class=\"design-item\" style=\"width: 196px;\"></td> \n    <td class=\"design-item selected\" colspan=\"3\"> <button class=\"btn btn-default btn-block\" type=\"submit\" t=\"button\">提 交</button> </td> \n   </tr> \n  </tbody> \n </table> \n</div>','<form action=\"#formAction\" method=\"post\" onsubmit=\"return _form_submit(this);\">\n <input type=\"hidden\" name=\"_formId\" value=\"402838814ae76a71014ae76ad2fd0000\" />\n <div class=\" \" tip=\"您的请假申请已经提交，请等待相关负责人审批！\"> \n  <center> \n   <h4 class=\"bb\" id=\"formTitle\" t=\"label\" name=\"data_0\">请假单</h4> \n  </center> \n  <table class=\"table table-bordered no-m\" t=\"table\"> \n   <tbody> \n    <tr> \n     <td style=\"text-align: right;\">请假人</td> \n     <td> <span name=\"data_0\">#user_realname#</span> </td> \n     <td>所在部门</td> \n     <td> <span name=\"data_1\">#user_unitname#</span> </td> \n    </tr> \n    <tr> \n     <td>请假原因</td> \n     <td colspan=\"3\"> <textarea name=\"data_2\" class=\"form-control\" placeholder=\"请输入请假原因...\" data-required=\"true\">请输入请假原因...</textarea> </td> \n    </tr> \n    <tr> \n     <td>事项类型</td> \n     <td> <select name=\"data_3\" class=\"form-control\"> <option value=\"1\">事假</option> <option value=\"2\">病假</option> <option value=\"3\">带薪休假</option> </select> </td> \n     <td>请假时间</td> \n     <td><span name=\"data_4\">#dt_yyyy-MM-dd HH:mm:ss#</span> </td> \n    </tr> \n    <tr> \n     <td style=\"width: 196px;\"></td> \n     <td class=\" \" colspan=\"3\"> <button class=\"btn btn-default btn-block\" type=\"submit\" t=\"button\">提 交</button> </td> \n    </tr> \n   </tbody> \n  </table> \n </div>\n</form>','1.0',NULL,'2015-01-15 16:36:35'),
('402881ee54a29b8b0154a2c6cc1b000b','测试表单1',NULL,'bi_test1','bi_test1','<div class=\"containers fd-view-drag-in\"><div id=\"v_formtitle\" fd-view=\"formtitle\" class=\"bb h4\" style=\"text-align: center;\">表单A</div><div class=\"row\" contenteditable=\"true\" fd-view=\"col12\" id=\"v_col12\" style=\"padding: 0px 0px 5px;\">\n													<div class=\"col-md-12 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\">姓名：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"name\" required=\"required\" rules=\"none\"></td>\n													</tr>\n												</tbody></table></div>\n												</div><div class=\"row\" contenteditable=\"true\" fd-view=\"col12\" id=\"v_col12\">\n													<div class=\"col-md-12 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_textarea\" id=\"v_label_textarea\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">性别：</span></td>\n														<td fd-view=\"table_td\"><select class=\"form-control\" fd-view=\"select\" \"=\"\" field=\"sex\"><option value=\"男\" selected=\"selected\">男</option><option value=\"女\">女</option></select></td>\n													</tr>\n												</tbody></table></div>\n												</div></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\">\n  <div id=\"v_formtitle\" fd-view=\"formtitle\" class=\"bb h4\" style=\"text-align: center;\">\n   表单A\n  </div>\n  <div class=\"row\" fd-view=\"col12\" id=\"v_col12\" style=\"padding: 0px 0px 5px;\"> \n   <div class=\"col-md-12 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span fd-view=\"label\" fd-label=\"\">姓名：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"name\" required rules=\"none\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n  <div class=\"row\" fd-view=\"col12\" id=\"v_col12\"> \n   <div class=\"col-md-12 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_textarea\" id=\"v_label_textarea\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">性别：</span></td> \n       <td fd-view=\"table_td\"><select class=\"form-control\" fd-view=\"select\" \"=\"\" name=\"sex\"><option value=\"男\" selected>男</option><option value=\"女\">女</option></select></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n </div>\n</form>','2.0','superadmin','2016-05-12 10:40:38'),
('4028b88158cd06060158cdb1a444001d','气泡数据录入',NULL,'bi_test2','bi_test2','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\"><h4 fd-view=\"formtitle\" class=\"\" style=\"text-align: center;\">气泡图数据录入</h4></div><div class=\"row\" contenteditable=\"true\" fd-view=\"col444\" id=\"v_col444\" style=\"\">\n													<div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"></div>\n													<div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">X：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"x\" required=\"required\" rules=\"integer\"></td>\n													</tr>\n												</tbody></table><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">Y：</span></td>\n														<td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"y\" required=\"required\" rules=\"integer\"></td>\n													</tr>\n												</tbody></table><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span contenteditable=\"true\" fd-view=\"label\" fd-label=\"\" class=\"\">R：</span></td>\n														<td fd-view=\"table_td\" class=\"\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" field=\"r\" required=\"required\" rules=\"integer\"></td>\n													</tr>\n												</tbody></table></div>\n													<div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"><table fd-move=\"\" fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"></td>\n														<td fd-view=\"table_td\"></td>\n													</tr>\n												</tbody></table><table fd-move=\"\" fd-view=\"label_password\" id=\"v_label_password\" style=\"width:100%\">\n													<tbody><tr>\n														<td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"></td>\n														<td fd-view=\"table_td\"></td>\n													</tr>\n												</tbody></table></div>\n												</div></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <div id=\"v_formtitle\" fd-view=\"\" class=\"bb h4\">\n   <h4 fd-view=\"formtitle\" class=\"\" style=\"text-align: center;\">气泡图数据录入</h4>\n  </div>\n  <div class=\"row\" fd-view=\"col444\" id=\"v_col444\" style=\"\"> \n   <div class=\"col-md-4 fd-view-drag-in fd-view-bordered\"></div> \n   <div class=\"col-md-4 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span fd-view=\"label\" fd-label=\"\" class=\"\">X：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"x\" required rules=\"integer\"></td> \n      </tr> \n     </tbody>\n    </table>\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"><span fd-view=\"label\" fd-label=\"\" class=\"\">Y：</span></td> \n       <td fd-view=\"table_td\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"y\" required rules=\"integer\"></td> \n      </tr> \n     </tbody>\n    </table>\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"><span fd-view=\"label\" fd-label=\"\" class=\"\">R：</span></td> \n       <td fd-view=\"table_td\" class=\"\"><input type=\"text\" class=\"form-control\" fd-view=\"input\" name=\"r\" required rules=\"integer\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n   <div class=\"col-md-4 fd-view-drag-in fd-view-bordered\">\n    <table fd-view=\"label_input\" id=\"v_label_input\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\" class=\"\"></td> \n       <td fd-view=\"table_td\"></td> \n      </tr> \n     </tbody>\n    </table>\n    <table fd-view=\"label_password\" id=\"v_label_password\" style=\"width:100%\"> \n     <tbody>\n      <tr> \n       <td fd-view=\"table_td\" style=\"min-width:5%;width:8%\"></td> \n       <td fd-view=\"table_td\"></td> \n      </tr> \n     </tbody>\n    </table>\n   </div> \n  </div>\n </div>\n</form>','2.0','superadmin','2016-12-10 16:51:47'),
('8a1076ae58fafc4b0158fc9c03dd00e4','a',NULL,'bi_charts','bi_charts,bi_datasource','<div class=\"containers fd-view-drag-in\">\n							<div class=\"hide\" id=\"script\"></div>\n						<div class=\"row\" fd-view=\"col3333\" id=\"v_col3333\" contenteditable=\"true\">\n													<div class=\"col-md-3 fd-view-drag-in fd-view-bordered\"><span fd-view=\"label\" id=\"v_label\" contenteditable=\"true\">标签：</span><input class=\"form-control inline\" fd-view=\"input\" id=\"v_input\" style=\"width:200px\" type=\"text\"></div>\n													<div class=\"col-md-3 fd-view-drag-in fd-view-bordered\"><textarea class=\"form-control\" fd-view=\"textarea\" id=\"v_textarea\"></textarea></div>\n													<div class=\"col-md-3 fd-view-drag-in fd-view-bordered\"></div>\n													<div class=\"col-md-3 fd-view-drag-in fd-view-bordered\"></div>\n												</div></div>','<form action=\"#formAction#\" method=\"post\" onsubmit=\"return fd.run.submit(this)\">\n <input type=\"hidden\" name=\"$formId\" value=\"#tid#\">\n <div class=\"containers fd-view-drag-in\"> \n  <div class=\"hide\" id=\"script\"></div> \n  <div class=\"row\" fd-view=\"col3333\" id=\"v_col3333\"> \n   <div class=\"col-md-3 fd-view-drag-in fd-view-bordered\">\n    <span fd-view=\"label\" id=\"v_label\">标签：</span>\n    <input class=\"form-control inline\" fd-view=\"input\" id=\"v_input\" style=\"width:200px\" type=\"text\">\n   </div> \n   <div class=\"col-md-3 fd-view-drag-in fd-view-bordered\">\n    <textarea class=\"form-control\" fd-view=\"textarea\" id=\"v_textarea\"></textarea>\n   </div> \n   <div class=\"col-md-3 fd-view-drag-in fd-view-bordered\"></div> \n   <div class=\"col-md-3 fd-view-drag-in fd-view-bordered\"></div> \n  </div>\n </div>\n</form>','2.0','superadmin','2016-12-14 17:33:54');

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

/*Table structure for table `bi_form_ext` */

DROP TABLE IF EXISTS `bi_form_ext`;

CREATE TABLE `bi_form_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `columnType` varchar(100) NOT NULL COMMENT '字段类型',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `comments` varchar(500) DEFAULT NULL COMMENT '字段描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `bi_form_ext` */

insert  into `bi_form_ext`(`id`,`columnType`,`columnName`,`comments`) values 
(1,'text','fsfw',''),
(2,'varchar','1ww',''),
(3,'varchar','23242','');

/*Table structure for table `bi_form_ext_val` */

DROP TABLE IF EXISTS `bi_form_ext_val`;

CREATE TABLE `bi_form_ext_val` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '主表数据ID',
  `columnName` varchar(100) NOT NULL COMMENT '扩展字段',
  `columnVal` varchar(1000) DEFAULT NULL COMMENT '扩展字段值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bi_form_ext_val` */

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='人员信息表';

/*Data for the table `bi_form_parent` */

insert  into `bi_form_parent`(`id`,`name`,`age`,`sex`,`mobile`,`birthday`,`address`) values 
(18,'张三',11,'男 ','13655559420','2015年06月03日','安徽省合肥市'),
(19,'中文',NULL,NULL,NULL,NULL,NULL),
(20,NULL,NULL,'中文',NULL,NULL,NULL),
(22,NULL,NULL,NULL,NULL,NULL,NULL),
(23,NULL,NULL,NULL,NULL,NULL,NULL),
(24,NULL,NULL,NULL,NULL,NULL,NULL);

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
('40289f395935cd44015935d7886b0002','报表1','测试用','<table id=\"40289f395935cd44015935d7886b0002\" class=\"table table-bordered\" contenteditable=\"true\">\n                                                                                        <tbody><tr>\n                                                                                                <td class=\"\" style=\"text-align: center;\"><b>序号</b></td>\n                                                                                                <td class=\"\" style=\"text-align: center;\"><b>姓名</b></td>\n                                                                                                <td class=\"\" style=\"text-align: center;\"><b>性别</b></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td class=\"\" ds=\"4028b88158af03570158af47b68e000b\" code=\"id\" arrow=\"down\"><div class=\"debug hide\" style=\"text-align: center;\">#id-&gt;down#</div></td>\n                                                                                                <td class=\"\" ds=\"4028b88158af03570158af47b68e000b\" code=\"name\" arrow=\"down\"><div class=\"debug hide\">#name-&gt;down#</div></td>\n                                                                                                <td class=\"\" ds=\"4028b88158af03570158af47b68e000b\" code=\"sex\" arrow=\"down\"><div class=\"debug hide\">#sex-&gt;down#</div></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                    </tbody></table>','<table id=\"40289f395935cd44015935d7886b0002\" class=\"table table-bordered\">\n                                                                                        <tbody><tr>\n                                                                                                <td style=\"text-align: center;\"><b>序号</b></td>\n                                                                                                <td style=\"text-align: center;\"><b>姓名</b></td>\n                                                                                                <td style=\"text-align: center;\"><b>性别</b></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td ds=\"4028b88158af03570158af47b68e000b\" code=\"id\" arrow=\"down\"><div class=\"debug hide\" style=\"text-align: center;\">#id-&gt;down#</div></td>\n                                                                                                <td ds=\"4028b88158af03570158af47b68e000b\" code=\"name\" arrow=\"down\"><div class=\"debug hide\">#name-&gt;down#</div></td>\n                                                                                                <td ds=\"4028b88158af03570158af47b68e000b\" code=\"sex\" arrow=\"down\"><div class=\"debug hide\">#sex-&gt;down#</div></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                \n                                                                                                \n                                                                                            </tr>\n                                                                                    </tbody></table>','超级管理员','2016-12-25 19:57:14'),
('4028b88159780b930159780c7ae30001','统计表-测试1','用于测试统计功能：合计，平均数等','<table id=\"4028b88159780b930159780c7ae30001\" class=\"table table-bordered\" contenteditable=\"true\">\n                                                                                        <tbody><tr>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>日期</b></td><td class=\"\" style=\"text-align: left;\"><b>数据1-1</b></td>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>数据1-2</b></td>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>数据2-1</b></td>\n                                                                                                <td class=\"\" style=\"text-align: left;\"><b>数据2-2</b></td><td class=\"\" style=\"text-align: left;\"><b>数据3-1</b></td><td class=\"\" style=\"text-align: left;\"><b>数据3-2</b></td><td class=\"\" style=\"text-align: left;\"><b>数据4-1</b></td><td class=\"\" style=\"text-align: left;\"><b>数据4-2</b></td><td class=\"\" style=\"text-align: left;\"><b>数据5-1</b></td><td class=\"\" style=\"text-align: left;\"><b>数据5-2</b></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"day\" arrow=\"down\" data-binder=\"true\" style=\"text-align: center;\">#day-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_1\" arrow=\"down\" data-binder=\"true\">#c1_1-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_2\" arrow=\"down\" data-binder=\"true\">#c1_2-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_1\" arrow=\"down\" data-binder=\"true\">#c2_1-&gt;down#</td>\n                                                                                                <td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_2\" arrow=\"down\" data-binder=\"true\">#c2_2-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_1\" arrow=\"down\" data-binder=\"true\">#c3_1-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_2\" arrow=\"down\" data-binder=\"true\">#c3_2-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_1\" arrow=\"down\" data-binder=\"true\">#c4_1-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_2\" arrow=\"down\" data-binder=\"true\">#c4_2-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\">#c5_1-&gt;down#</td><td class=\"\" ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\">#c5_1-&gt;down#</td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td class=\"\"><br></td>\n                                                                                                <td class=\"\"><br></td>\n                                                                                                <td class=\"\"><br></td>\n                                                                                                <td class=\"\"><br></td>\n                                                                                                <td class=\"\"><br></td><td class=\"\"><br></td><td class=\"\"><br></td><td class=\"\"><br></td><td class=\"\"><br></td><td class=\"\"><br></td><td class=\"\"><br></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td class=\"\" style=\"text-align: center;\">合计：</td>\n                                                                                                <td class=\"\"><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td>\n                                                                                            </tr>\n                                                                                    </tbody></table>','<table id=\"4028b88159780b930159780c7ae30001\" class=\"table table-bordered\">\n                                                                                        <tbody><tr>\n                                                                                                <td style=\"text-align: left;\"><b>日期</b></td><td style=\"text-align: left;\"><b>数据1-1</b></td>\n                                                                                                <td style=\"text-align: left;\"><b>数据1-2</b></td>\n                                                                                                <td style=\"text-align: left;\"><b>数据2-1</b></td>\n                                                                                                <td style=\"text-align: left;\"><b>数据2-2</b></td><td style=\"text-align: left;\"><b>数据3-1</b></td><td style=\"text-align: left;\"><b>数据3-2</b></td><td style=\"text-align: left;\"><b>数据4-1</b></td><td style=\"text-align: left;\"><b>数据4-2</b></td><td style=\"text-align: left;\"><b>数据5-1</b></td><td style=\"text-align: left;\"><b>数据5-2</b></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"day\" arrow=\"down\" data-binder=\"true\" style=\"text-align: center;\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_1\" arrow=\"down\" data-binder=\"true\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c1_2\" arrow=\"down\" data-binder=\"true\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_1\" arrow=\"down\" data-binder=\"true\"><br></td>\n                                                                                                <td ds=\"4028b8815977f53a01597805e6290001\" code=\"c2_2\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_1\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c3_2\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_1\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c4_2\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\"><br></td><td ds=\"4028b8815977f53a01597805e6290001\" code=\"c5_1\" arrow=\"down\" data-binder=\"true\"><br></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td>\n                                                                                            </tr>\n                                                                                        <tr>\n                                                                                                <td style=\"text-align: center;\">合计：</td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td>\n                                                                                                <td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td>\n                                                                                            </tr>\n                                                                                    </tbody></table>','超级管理员','2017-01-07 16:30:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `bi_test1` */

insert  into `bi_test1`(`id`,`name`,`sex`) values 
(1,'A','男'),
(2,'A','女'),
(3,'张三','男'),
(4,'AAAA','男'),
(5,'Hello','男'),
(6,'aaa','男'),
(7,'啥时','男');

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
(1,9,35),
(55,33,67),
(2,3,4),
(1,1,1),
(1,1,1),
(1,1,1),
(1,1,1),
(88,88,88),
(1,2,3),
(1,11,22),
(123,11,22),
(12,34,5677);

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
('2c91647d5900bf85015900c25a1a0000',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-15 12:34:14 014','系统登录','LogService'),
('2c91647d5900bf85015900c2763f0001',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-15 12:34:21 021','系统异常','LogService'),
('2c91647d5900bf85015900c279630002',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.173.220.146','2016-12-15 12:34:22 022','请求出错','LogService'),
('2c91647d5900bf85015900c279ec0003',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-15 12:34:22 022','系统异常','LogService'),
('2c91647d5900bf85015900c2ac6e0004',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-15 12:34:35 035','系统异常','LogService'),
('2c91647d5900bf85015900c2acbe0005',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-15 12:34:35 035','系统异常','LogService'),
('2c91647d5900bf85015900c4849f0006',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-15 12:36:36 036','系统异常','LogService'),
('2c91647d5900bf85015900cb61cf0007',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-15 12:44:05 005','系统登录','LogService'),
('2c91647d5900bf85015900cb66a70008',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-15 12:44:07 007','系统异常','LogService'),
('2c91647d5900bf85015900cb67550009',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-15 12:44:07 007','系统异常','LogService'),
('2c91647d5900bf85015900cba106000a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-15 12:44:22 022','系统异常','LogService'),
('2c91647d5900bf85015900cfd9a6000b',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.243.171','2016-12-15 12:48:58 058','系统登录','LogService'),
('2c91647d5900bf85015900cff84b000c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.243.171','2016-12-15 12:49:06 006','系统异常','LogService'),
('2c91647d5900bf85015900e09e30000d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 13:07:17 017','登录系统','LogService'),
('2c91647d5900bf85015900e8dbd5000e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 13:16:17 017','登录系统','LogService'),
('2c91647d5900bf85015900eb41cc000f',1,'用户：[superadmin] 成功登录系统','superadmin','116.52.7.134','2016-12-15 13:18:54 054','系统登录','LogService'),
('2c91647d5900bf85015900eb61e00010',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.52.7.134','2016-12-15 13:19:03 003','系统异常','LogService'),
('2c91647d5900bf85015900ec858d0011',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 13:20:17 017','登录系统','LogService'),
('2c91647d5900bf85015900ec87640012',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.69.128','2016-12-15 13:20:18 018','系统异常','LogService'),
('2c91647d5900bf85015900ef47610013',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-15 13:23:18 018','系统异常','LogService'),
('2c91647d5900bf85015900f93e5f0014',1,'切换布局：[layout: ${layout}]','superadmin','116.52.7.134','2016-12-15 13:34:11 011','系统首页','LogService'),
('2c91647d5900bf85015900fd1f210015',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-15 13:38:25 025','系统异常','LogService'),
('2c91647d5900bf85015901011e050016',1,'用户：[superadmin] 成功登录系统','superadmin','223.255.10.50','2016-12-15 13:42:47 047','系统登录','LogService'),
('2c91647d5900bf85015901013c2f0017',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.255.10.50','2016-12-15 13:42:55 055','系统异常','LogService'),
('2c91647d5900bf85015901013ce80018',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.255.10.50','2016-12-15 13:42:55 055','系统异常','LogService'),
('2c91647d5900bf850159010199670019',1,'用户：[superadmin] 成功登录系统','superadmin','223.255.10.50','2016-12-15 13:43:19 019','系统登录','LogService'),
('2c91647d5900bf8501590101b6cd001a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.255.10.50','2016-12-15 13:43:26 026','系统异常','LogService'),
('2c91647d5900bf8501590101e5ec001b',1,'切换布局：[layout: ${layout}]','superadmin','223.255.10.50','2016-12-15 13:43:38 038','系统首页','LogService'),
('2c91647d5900bf8501590101f89c001c',1,'切换布局：[layout: ${layout}]','superadmin','223.255.10.50','2016-12-15 13:43:43 043','系统首页','LogService'),
('2c91647d5900bf850159010e1a79001d',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.242.182','2016-12-15 13:56:58 058','系统登录','LogService'),
('2c91647d5900bf850159010e3fbb001e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:57:08 008','系统异常','LogService'),
('2c91647d5900bf850159010e406c001f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:57:08 008','系统异常','LogService'),
('2c91647d5900bf850159010e585c0020',1,'切换布局：[layout: ${layout}]','superadmin','36.5.242.182','2016-12-15 13:57:14 014','系统首页','LogService'),
('2c91647d5900bf850159010e5e680021',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:57:16 016','系统异常','LogService'),
('2c91647d5900bf850159010e6e850022',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','36.5.242.182','2016-12-15 13:57:20 020','请求出错','LogService'),
('2c91647d5900bf850159010e6e900023',3,'错误代码:500，访问路径:/bi/form/datalist20/8a1076ae58fafc4b0158fc9c03dd00e4','superadmin','36.5.242.182','2016-12-15 13:57:20 020','系统异常','LogService'),
('2c91647d5900bf850159010e82c90024',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:57:25 025','系统异常','LogService'),
('2c91647d5900bf850159010ecbcd0025',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-15 13:57:44 044','系统异常','LogService'),
('2c91647d5900bf85015901105b570026',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:26 026','系统异常','LogService'),
('2c91647d5900bf85015901105dbd0027',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:26 026','系统异常','LogService'),
('2c91647d5900bf850159011061880028',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:27 027','系统异常','LogService'),
('2c91647d5900bf85015901106d1f0029',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:30 030','系统异常','LogService'),
('2c91647d5900bf85015901107024002a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:31 031','系统异常','LogService'),
('2c91647d5900bf8501590110bc03002b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:51 051','系统异常','LogService'),
('2c91647d5900bf8501590110bda4002c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.242.182','2016-12-15 13:59:51 051','系统异常','LogService'),
('2c91647d5900bf8501590114cf70002d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:04:18 018','登录系统','LogService'),
('2c91647d5900bf8501590116327a002e',1,'用户：[superadmin] 成功登录系统','superadmin','122.224.141.202','2016-12-15 14:05:49 049','系统登录','LogService'),
('2c91647d5900bf850159011651df002f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','122.224.141.202','2016-12-15 14:05:57 057','系统异常','LogService'),
('2c91647d5900bf850159011696cb0030',1,'用户：[superadmin] 成功登录系统','superadmin','180.173.240.62','2016-12-15 14:06:14 014','系统登录','LogService'),
('2c91647d5900bf8501590116b7980031',3,'错误代码:404，访问路径:/favicon.ico','superadmin','180.173.240.62','2016-12-15 14:06:23 023','系统异常','LogService'),
('2c91647d5900bf8501590117f8230032',1,'切换布局：[layout: ${layout}]','superadmin','180.173.240.62','2016-12-15 14:07:45 045','系统首页','LogService'),
('2c91647d5900bf8501590118a7f20033',1,'用户：[superadmin] 成功登录系统','superadmin','117.100.212.84','2016-12-15 14:08:30 030','系统登录','LogService'),
('2c91647d5900bf8501590118c3da0034',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.100.212.84','2016-12-15 14:08:37 037','系统异常','LogService'),
('2c91647d5900bf850159011d0d130035',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:13:18 018','登录系统','LogService'),
('2c91647d5900bf850159011df7b80036',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:14:18 018','登录系统','LogService'),
('2c91647d5900bf8501590120726f0037',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-15 14:17:00 000','系统异常','LogService'),
('2c91647d5900bf850159012c9e3d0038',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:30:18 018','登录系统','LogService'),
('2c91647d5900bf850159013307230039',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:37:18 018','登录系统','LogService'),
('2c91647d5900bf8501590134dc06003a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:39:18 018','登录系统','LogService'),
('2c91647d5900bf8501590134dc0a003b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 14:39:18 018','登录系统','LogService'),
('2c91647d5900bf8501590143762d003c',1,'用户：[superadmin] 成功登录系统','superadmin','61.140.25.209','2016-12-15 14:55:15 015','系统登录','LogService'),
('2c91647d5900bf85015901439215003d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.140.25.209','2016-12-15 14:55:22 022','系统异常','LogService'),
('2c91647d5900bf850159014578b2003f',1,'切换布局：[layout: ${layout}]','superadmin','61.140.25.209','2016-12-15 14:57:27 027','系统首页','LogService'),
('2c91647d5900bf8501590155f53c0040',3,'错误代码:404，访问路径:/favicon.ico','system','175.0.131.237','2016-12-15 15:15:27 027','系统异常','LogService'),
('2c91647d5900bf850159015621970041',1,'用户：[superadmin] 成功登录系统','superadmin','222.244.144.163','2016-12-15 15:15:39 039','系统登录','LogService'),
('2c91647d5900bf8501590156f2b50042',1,'切换布局：[layout: ${layout}]','superadmin','222.244.144.163','2016-12-15 15:16:32 032','系统首页','LogService'),
('2c91647d5900bf850159015c5a7f0043',3,'错误代码:404，访问路径:/\'+ s.iframeSrc +\'','system','119.147.146.60','2016-12-15 15:22:26 026','系统异常','LogService'),
('2c91647d5900bf850159015ef4880044',1,'用户：[superadmin] 成功登录系统','superadmin','42.243.109.158','2016-12-15 15:25:17 017','系统登录','LogService'),
('2c91647d5900bf850159015f15d80045',3,'错误代码:404，访问路径:/favicon.ico','superadmin','42.243.109.158','2016-12-15 15:25:25 025','系统异常','LogService'),
('2c91647d5900bf85015901607b360046',1,'用户：[superadmin] 成功登录系统','superadmin','101.95.153.34','2016-12-15 15:26:57 057','系统登录','LogService'),
('2c91647d5900bf850159016100860047',1,'切换布局：[layout: ${layout}]','superadmin','101.95.153.34','2016-12-15 15:27:31 031','系统首页','LogService'),
('2c91647d5900bf850159016139740048',1,'锁定系统','superadmin','101.95.153.34','2016-12-15 15:27:46 046','个人中心','LogService'),
('2c91647d5900bf8501590161543a0049',1,'用户：[superadmin] 成功登录系统','superadmin','59.42.128.3','2016-12-15 15:27:52 052','系统登录','LogService'),
('2c91647d5900bf850159016168b8004a',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','112.96.161.126','2016-12-15 15:27:58 058','请求出错','LogService'),
('2c91647d5900bf85015901616d3f004b',3,'错误代码:404，访问路径:/favicon.ico','system','112.96.161.126','2016-12-15 15:27:59 059','系统异常','LogService'),
('2c91647d5900bf85015901617b4a004c',1,'解锁系统','superadmin','101.95.153.34','2016-12-15 15:28:02 002','个人中心','LogService'),
('2c91647d5900bf85015901617ef9004d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','59.42.128.3','2016-12-15 15:28:03 003','系统异常','LogService'),
('2c91647d5900bf8501590161982d004e',1,'切换布局：[layout: ${layout}]','superadmin','59.42.128.3','2016-12-15 15:28:10 010','系统首页','LogService'),
('2c91647d5900bf85015901619e1d004f',1,'用户：[superadmin] 退出系统','superadmin','101.95.153.34','2016-12-15 15:28:11 011','退出系统','LogService'),
('2c91647d5900bf8501590161aaff0050',1,'切换布局：[layout: ${layout}]','superadmin','59.42.128.3','2016-12-15 15:28:15 015','系统首页','LogService'),
('2c91647d5900bf8501590161b9da0051',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 15:28:18 018','登录系统','LogService'),
('2c91647d5900bf85015901642a6e0052',1,'用户：[superadmin] 成功登录系统','superadmin','211.157.180.170','2016-12-15 15:30:58 058','系统登录','LogService'),
('2c91647d5900bf85015901645cf40053',3,'错误代码:404，访问路径:/favicon.ico','superadmin','211.157.180.170','2016-12-15 15:31:11 011','系统异常','LogService'),
('2c91647d5900bf8501590164c00e0054',1,'切换布局：[layout: ${layout}]','superadmin','211.157.180.170','2016-12-15 15:31:37 037','系统首页','LogService'),
('2c91647d5900bf85015901704adb0055',1,'用户：[superadmin] 成功登录系统','superadmin','61.145.96.90','2016-12-15 15:44:13 013','系统登录','LogService'),
('2c91647d5900bf85015901731f790056',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 15:47:19 019','登录系统','LogService'),
('2c91647d5900bf850159017c96fe0057',1,'用户：[superadmin] 成功登录系统','superadmin','113.106.79.26','2016-12-15 15:57:39 039','系统登录','LogService'),
('2c91647d5900bf850159017cf5460058',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.106.79.26','2016-12-15 15:58:03 003','系统异常','LogService'),
('2c91647d5900bf850159017d31fc0059',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 15:58:19 019','登录系统','LogService'),
('2c91647d5900bf850159017e1c79005a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 15:59:19 019','登录系统','LogService'),
('2c91647d5900bf850159017e536c005b',1,'用户：[superadmin] 成功登录系统','superadmin','60.174.249.18','2016-12-15 15:59:33 033','系统登录','LogService'),
('2c91647d5900bf850159017ee56f005c',1,'切换布局：[layout: ${layout}]','superadmin','60.174.249.18','2016-12-15 16:00:10 010','系统首页','LogService'),
('2c91647d5900bf8501590181c627005d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 16:03:19 019','登录系统','LogService'),
('2c91647d5900bf85015901821b61005e',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','61.145.96.90','2016-12-15 16:03:41 041','系统异常','LogService'),
('2c91647d5900bf8501590187fba4005f',1,'用户：[superadmin] 成功登录系统','superadmin','222.94.202.203','2016-12-15 16:10:06 006','系统登录','LogService'),
('2c91647d5900bf850159018819430060',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.94.202.203','2016-12-15 16:10:13 013','系统异常','LogService'),
('2c91647d5900bf850159018894810061',1,'切换布局：[layout: ${layout}]','superadmin','222.94.202.203','2016-12-15 16:10:45 045','系统首页','LogService'),
('2c91647d5900bf8501590188a40a0062',1,'切换布局：[layout: ${layout}]','superadmin','222.94.202.203','2016-12-15 16:10:49 049','系统首页','LogService'),
('2c91647d5900bf850159019996280063',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 16:29:19 019','登录系统','LogService'),
('2c91647d5900bf850159019a80ba0064',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 16:30:19 019','登录系统','LogService'),
('2c91647d5900bf850159019e2a5d0065',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 16:34:19 019','登录系统','LogService'),
('2c91647d5900bf850159019e3a930066',1,'用户：[superadmin] 成功登录系统','superadmin','116.231.223.32','2016-12-15 16:34:24 024','系统登录','LogService'),
('2c91647d5900bf850159019e57980067',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.231.223.32','2016-12-15 16:34:31 031','系统异常','LogService'),
('2c91647d5900bf85015901a83df60068',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 16:45:20 020','登录系统','LogService'),
('2c91647d5900bf85015901b0b7610069',1,'用户：[superadmin] 成功登录系统','superadmin','117.84.174.66','2016-12-15 16:54:35 035','系统登录','LogService'),
('2c91647d5900bf85015901b0d540006a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.84.174.66','2016-12-15 16:54:43 043','系统异常','LogService'),
('2c91647d5900bf85015901b0d544006b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.84.174.66','2016-12-15 16:54:43 043','系统异常','LogService'),
('2c91647d5900bf85015901bb7974006c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 17:06:20 020','登录系统','LogService'),
('2c91647d5900bf85015901cce024006d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 17:25:21 021','登录系统','LogService'),
('2c91647d5900bf85015901e93d71006e',1,'用户：[superadmin] 成功登录系统','superadmin','211.152.41.186','2016-12-15 17:56:19 019','系统登录','LogService'),
('2c91647d5900bf85015901e95d5e006f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','211.152.41.186','2016-12-15 17:56:28 028','系统异常','LogService'),
('2c91647d5900bf85015901ebc5060070',1,'切换布局：[layout: ${layout}]','superadmin','58.247.110.210','2016-12-15 17:59:05 005','系统首页','LogService'),
('2c91647d5900bf85015901ebf0700071',3,'错误代码:404，访问路径:/open/doc','superadmin','58.247.110.210','2016-12-15 17:59:16 016','系统异常','LogService'),
('2c91647d5900bf85015902032b3a0073',1,'用户：[superadmin] 成功登录系统','superadmin','111.37.0.44','2016-12-15 18:24:39 039','系统登录','LogService'),
('2c91647d5900bf850159020360040074',3,'错误代码:404，访问路径:/favicon.ico','system','111.37.0.44','2016-12-15 18:24:52 052','系统异常','LogService'),
('2c91647d5900bf850159020377330075',3,'错误代码:404，访问路径:/favicon.ico','system','111.37.0.44','2016-12-15 18:24:58 058','系统异常','LogService'),
('2c91647d5900bf850159020387cd0076',3,'错误代码:404，访问路径:/favicon.ico','system','111.37.0.44','2016-12-15 18:25:02 002','系统异常','LogService'),
('2c91647d5900bf8501590203a66b0077',3,'错误代码:404，访问路径:/favicon.ico','system','111.37.0.44','2016-12-15 18:25:10 010','系统异常','LogService'),
('2c91647d5900bf850159020402d40078',1,'切换布局：[layout: ${layout}]','superadmin','111.37.0.44','2016-12-15 18:25:34 034','系统首页','LogService'),
('2c91647d5900bf850159020cf9c20079',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 18:35:21 021','登录系统','LogService'),
('2c91647d5900bf85015902211f97007a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 18:57:22 022','登录系统','LogService'),
('2c91647d5900bf85015902479ee0007b',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-15 19:39:25 025','系统异常','LogService'),
('2c91647d5900bf85015902568c9b007c',1,'用户：[superadmin] 成功登录系统','superadmin','101.107.69.25','2016-12-15 19:55:43 043','系统登录','LogService'),
('2c91647d5900bf8501590256aaf6007d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.107.69.25','2016-12-15 19:55:51 051','系统异常','LogService'),
('2c91647d5900bf850159027388b3007e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 20:27:23 023','登录系统','LogService'),
('2c91647d5900bf850159029fa843007f',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-15 21:15:34 034','系统异常','LogService'),
('2c91647d5900bf85015902a9abe40080',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-15 21:26:31 031','系统异常','LogService'),
('2c91647d5900bf85015902c497e30081',1,'用户：[superadmin] 成功登录系统','superadmin','180.175.93.236','2016-12-15 21:55:55 055','系统登录','LogService'),
('2c91647d5900bf85015902c4b51d0082',3,'错误代码:404，访问路径:/favicon.ico','superadmin','180.175.93.236','2016-12-15 21:56:02 002','系统异常','LogService'),
('2c91647d5900bf85015902e1695b0083',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 22:27:24 024','登录系统','LogService'),
('2c91647d5900bf85015902e681560084',1,'用户：[superadmin] 成功登录系统','superadmin','117.156.4.220','2016-12-15 22:32:57 057','系统登录','LogService'),
('2c91647d5900bf85015902e69dc00085',3,'错误代码:404，访问路径:/favicon.ico','system','117.156.4.220','2016-12-15 22:33:05 005','系统异常','LogService'),
('2c91647d5900bf85015902e69f640086',3,'错误代码:404，访问路径:/favicon.ico','system','117.156.4.220','2016-12-15 22:33:05 005','系统异常','LogService'),
('2c91647d5900bf85015902e6a7370087',3,'错误代码:404，访问路径:/favicon.ico','system','117.156.4.220','2016-12-15 22:33:07 007','系统异常','LogService'),
('2c91647d5900bf85015902e6a9420088',3,'错误代码:404，访问路径:/favicon.ico','system','117.156.4.220','2016-12-15 22:33:08 008','系统异常','LogService'),
('2c91647d5900bf85015902e6ac0f0089',3,'错误代码:404，访问路径:/favicon.ico','system','117.156.4.220','2016-12-15 22:33:08 008','系统异常','LogService'),
('2c91647d5900bf85015902e7243e008a',1,'切换布局：[layout: ${layout}]','superadmin','117.156.4.220','2016-12-15 22:33:39 039','系统首页','LogService'),
('2c91647d5900bf85015902e9a6f4008b',1,'用户：[superadmin] 成功登录系统','superadmin','180.174.156.92','2016-12-15 22:36:24 024','系统登录','LogService'),
('2c91647d5900bf85015902e9c51d008c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','180.174.156.92','2016-12-15 22:36:31 031','系统异常','LogService'),
('2c91647d5900bf85015902e9f4ab008d',1,'切换布局：[layout: ${layout}]','superadmin','180.174.156.92','2016-12-15 22:36:44 044','系统首页','LogService'),
('2c91647d5900bf85015903034b02008f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 23:04:24 024','登录系统','LogService'),
('2c91647d5900bf8501590307e0190090',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 23:09:24 024','登录系统','LogService'),
('2c91647d5900bf850159030c0bd70091',1,'用户：[superadmin] 成功登录系统','superadmin','223.209.16.114','2016-12-15 23:13:58 058','系统登录','LogService'),
('2c91647d5900bf850159030c2b300092',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.209.16.114','2016-12-15 23:14:06 006','系统异常','LogService'),
('2c91647d5900bf850159030c2caa0093',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.209.16.114','2016-12-15 23:14:06 006','系统异常','LogService'),
('2c91647d5900bf850159030c84060094',1,'切换布局：[layout: ${layout}]','superadmin','223.209.16.114','2016-12-15 23:14:28 028','系统首页','LogService'),
('2c91647d5900bf8501590328d7540095',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 23:45:25 025','登录系统','LogService'),
('2c91647d5900bf8501590333fcd50096',1,'用户：[superadmin] 成功登录系统','superadmin','120.198.62.69','2016-12-15 23:57:35 035','系统登录','LogService'),
('2c91647d5900bf85015903343c0e0097',3,'错误代码:404，访问路径:/favicon.ico','superadmin','120.198.62.69','2016-12-15 23:57:52 052','系统异常','LogService'),
('2c91647d5900bf85015903348c1b0098',1,'切换布局：[layout: ${layout}]','superadmin','120.198.62.69','2016-12-15 23:58:12 012','系统首页','LogService'),
('2c91647d5900bf8501590345b3080099',1,'用户：[superadmin] 成功登录系统','superadmin','183.48.35.108','2016-12-16 00:16:56 056','系统登录','LogService'),
('2c91647d5900bf8501590345df53009a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.48.35.108','2016-12-16 00:17:07 007','系统异常','LogService'),
('2c91647d5900bf850159035121b8009b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 00:29:25 025','登录系统','LogService'),
('2c91647d5900bf85015903619e2f009c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 00:47:26 026','登录系统','LogService'),
('2c91647d5900bf85015903cd9693009d',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','172.82.166.210','2016-12-16 02:45:22 022','系统异常','LogService'),
('2c91647d5900bf85015904ea5761009e',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.57.251','2016-12-16 07:56:23 023','系统异常','LogService'),
('2c91647d5900bf85015905098f2b009f',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2016-12-16 08:30:29 029','系统异常','LogService'),
('2c91647d5900bf8501590512ce4f00a0',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-16 08:40:35 035','系统异常','LogService'),
('2c91647d5900bf850159051e97d300a1',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','94.102.49.174','2016-12-16 08:53:28 028','系统异常','LogService'),
('2c91647d5900bf8501590521c6d600a2',1,'用户：[superadmin] 成功登录系统','superadmin','42.63.70.159','2016-12-16 08:56:56 056','系统登录','LogService'),
('2c91647d5900bf8501590521e39f00a3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','42.63.70.159','2016-12-16 08:57:04 004','系统异常','LogService'),
('2c91647d5900bf8501590521e47900a4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','42.63.70.159','2016-12-16 08:57:04 004','系统异常','LogService'),
('2c91647d5900bf850159052c840000a5',1,'用户：[superadmin] 成功登录系统','superadmin','101.95.155.218','2016-12-16 09:08:40 040','系统登录','LogService'),
('2c91647d5900bf850159052ca0a000a6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.95.155.218','2016-12-16 09:08:47 047','系统异常','LogService'),
('2c91647d5900bf850159052e695500a7',1,'用户：[superadmin] 成功登录系统','superadmin','1.85.221.5','2016-12-16 09:10:44 044','系统登录','LogService'),
('2c91647d5900bf850159052e852a00a8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','1.85.221.5','2016-12-16 09:10:51 051','系统异常','LogService'),
('2c91647d5900bf850159053dbdfd00a9',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 09:27:29 029','登录系统','LogService'),
('2c91647d5900bf85015905432d8800aa',1,'用户：[superadmin] 成功登录系统','superadmin','221.227.44.98','2016-12-16 09:33:25 025','系统登录','LogService'),
('2c91647d5900bf8501590543318500ab',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.227.44.98','2016-12-16 09:33:26 026','系统异常','LogService'),
('2c91647d5900bf850159054356c000ac',1,'切换布局：[layout: ${layout}]','superadmin','221.227.44.98','2016-12-16 09:33:36 036','系统首页','LogService'),
('2c91647d5900bf8501590548bbea00ad',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 09:39:29 029','登录系统','LogService'),
('2c91647d5900bf850159054c662b00ae',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 09:43:30 030','登录系统','LogService'),
('2c91647d5900bf850159055fa21f00af',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 10:04:30 030','登录系统','LogService'),
('2c91647d5900bf850159057b9e6900b0',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-16 10:35:04 004','系统异常','LogService'),
('2c91647d5900bf85015905891e1400b1',1,'用户：[superadmin] 成功登录系统','superadmin','222.187.22.214','2016-12-16 10:49:49 049','系统登录','LogService'),
('2c91647d5900bf85015905893cd600b2',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.187.22.214','2016-12-16 10:49:57 057','系统异常','LogService'),
('2c91647d5900bf850159058c258800b3',1,'用户：[superadmin] 成功登录系统','superadmin','114.248.235.242','2016-12-16 10:53:07 007','系统登录','LogService'),
('2c91647d5900bf850159058c425c00b4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','114.248.235.242','2016-12-16 10:53:15 015','系统异常','LogService'),
('2c91647d5900bf850159058c56fc00b5',1,'切换布局：[layout: ${layout}]','superadmin','114.248.235.242','2016-12-16 10:53:20 020','系统首页','LogService'),
('2c91647d5900bf850159058ce1ab00b6',1,'切换布局：[layout: ${layout}]','superadmin','114.248.235.242','2016-12-16 10:53:56 056','系统首页','LogService'),
('2c91647d5900bf850159058e200700b8',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','114.248.235.242','2016-12-16 10:55:17 017','请求出错','LogService'),
('2c91647d5900bf850159058e3cc900b9',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','114.248.235.242','2016-12-16 10:55:24 024','请求出错','LogService'),
('2c91647d5900bf85015905a5383500ba',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 11:20:31 031','登录系统','LogService'),
('2c91647d5900bf85015905aab7d600bb',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 11:26:31 031','登录系统','LogService'),
('2c91647d5900bf85015905d1411900bc',1,'用户：[superadmin] 成功登录系统','superadmin','219.146.150.182','2016-12-16 12:08:36 036','系统登录','LogService'),
('2c91647d5900bf85015905d1630200bd',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.146.150.182','2016-12-16 12:08:45 045','系统异常','LogService'),
('2c91647d5900bf85015905ecd72000be',1,'用户：[superadmin] 成功登录系统','superadmin','123.122.101.234','2016-12-16 12:38:44 044','系统登录','LogService'),
('2c91647d5900bf85015905ee794600bf',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 12:40:31 031','登录系统','LogService'),
('2c91647d5900bf85015905eefbdb00c0',1,'切换布局：[layout: ${layout}]','superadmin','123.122.101.234','2016-12-16 12:41:05 005','系统首页','LogService'),
('2c91647d5900bf850159060adcdf00c1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 13:11:32 032','登录系统','LogService'),
('2c91647d5900bf850159061a6b4400c2',3,'错误代码:404，访问路径:/show.html','system','123.56.155.154','2016-12-16 13:28:31 031','系统异常','LogService'),
('2c91647d5900bf850159064e5a2e00c3',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.99.84','2016-12-16 14:25:15 015','系统登录','LogService'),
('2c91647d5900bf850159064e7b0f00c4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.17.99.84','2016-12-16 14:25:23 023','系统异常','LogService'),
('2c91647d5900bf8501590659939a00c5',1,'用户：[superadmin] 成功登录系统','superadmin','58.210.227.147','2016-12-16 14:37:30 030','系统登录','LogService'),
('2c91647d5900bf8501590659b0ff00c6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.210.227.147','2016-12-16 14:37:38 038','系统异常','LogService'),
('2c91647d5900bf850159066b021500c7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 14:56:33 033','登录系统','LogService'),
('2c91647d5900bf85015906729ff900c8',1,'用户：[superadmin] 成功登录系统','superadmin','183.33.184.95','2016-12-16 15:04:52 052','系统登录','LogService'),
('2c91647d5900bf8501590678bfb400c9',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 15:11:33 033','登录系统','LogService'),
('2c91647d5900bf850159067fb6a600ca',1,'用户：[superadmin] 成功登录系统','superadmin','183.214.201.22','2016-12-16 15:19:10 010','系统登录','LogService'),
('2c91647d5900bf850159067fd71700cb',1,'用户：[superadmin] 成功登录系统','superadmin','116.249.127.138','2016-12-16 15:19:18 018','系统登录','LogService'),
('2c91647d5900bf850159067fd77600cc',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.214.201.22','2016-12-16 15:19:18 018','系统异常','LogService'),
('2c91647d5900bf850159067ff8dd00cd',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.249.127.138','2016-12-16 15:19:27 027','系统异常','LogService'),
('2c91647d5900bf8501590681012800ce',1,'切换布局：[layout: ${layout}]','superadmin','183.214.201.22','2016-12-16 15:20:34 034','系统首页','LogService'),
('2c91647d5900bf85015906811b2e00cf',1,'切换布局：[layout: ${layout}]','superadmin','183.214.201.22','2016-12-16 15:20:41 041','系统首页','LogService'),
('2c91647d5900bf85015906820e8400d1',3,'org.hibernate.exception.SQLGrammarException: error executing work','superadmin','116.249.127.138','2016-12-16 15:21:43 043','请求出错','LogService'),
('2c91647d5900bf850159068ebaa900d3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 15:35:34 034','登录系统','LogService'),
('2c91647d5900bf8501590699699f00d4',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','183.214.201.22','2016-12-16 15:47:14 014','请求出错','LogService'),
('2c91647d5900bf850159069999d000d5',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','183.214.201.22','2016-12-16 15:47:26 026','请求出错','LogService'),
('2c91647d5900bf850159069f35d100d6',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 15:53:34 034','登录系统','LogService'),
('2c91647d5900bf85015906b5738700d7',1,'用户：[superadmin] 成功登录系统','superadmin','119.145.137.45','2016-12-16 16:17:52 052','系统登录','LogService'),
('2c91647d5900bf85015906bec31500d8',1,'用户：[superadmin] 成功登录系统','superadmin','111.47.14.99','2016-12-16 16:28:02 002','系统登录','LogService'),
('2c91647d5900bf85015906bedf0400d9',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.47.14.99','2016-12-16 16:28:09 009','系统异常','LogService'),
('2c91647d5900bf85015906c02c2000da',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 16:29:34 034','登录系统','LogService'),
('2c91647d5900bf85015906c0c71d00db',1,'切换布局：[layout: ${layout}]','superadmin','111.47.14.99','2016-12-16 16:30:14 014','系统首页','LogService'),
('2c91647d5900bf85015906c2cb2a00dc',1,'用户：[superadmin] 成功登录系统','superadmin','117.191.53.122','2016-12-16 16:32:26 026','系统登录','LogService'),
('2c91647d5900bf85015906c324ba00dd',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.191.53.122','2016-12-16 16:32:49 049','系统异常','LogService'),
('2c91647d5900bf85015906d27d1900de',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 16:49:35 035','登录系统','LogService'),
('2c91647d5900bf85015906d2c7e900df',1,'用户：[superadmin] 成功登录系统','superadmin','117.82.105.32','2016-12-16 16:49:54 054','系统登录','LogService'),
('2c91647d5900bf85015906d2e54700e0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.82.105.32','2016-12-16 16:50:01 001','系统异常','LogService'),
('2c91647d5900bf85015906d6259d00e1',1,'切换布局：[layout: ${layout}]','superadmin','117.82.105.32','2016-12-16 16:53:34 034','系统首页','LogService'),
('2c91647d5900bf85015906d7147e00e2',3,'错误代码:404，访问路径:/open/doc','superadmin','117.82.105.32','2016-12-16 16:54:35 035','系统异常','LogService'),
('2c91647d5900bf85015906dc905400e3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 17:00:35 035','登录系统','LogService'),
('2c91647d5900bf85015906e20ff400e4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 17:06:35 035','登录系统','LogService'),
('2c91647d5900bf85015906e7d8ff00e5',1,'用户：[superadmin] 成功登录系统','superadmin','124.127.41.130','2016-12-16 17:12:54 054','系统登录','LogService'),
('2c91647d5900bf85015906e877e500e6',1,'切换布局：[layout: ${layout}]','superadmin','124.127.41.130','2016-12-16 17:13:35 035','系统首页','LogService'),
('2c91647d5900bf85015906e8c0c600e7',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','124.127.41.130','2016-12-16 17:13:54 054','请求出错','LogService'),
('2c91647d5900bf85015906f376c100e8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 17:25:36 036','登录系统','LogService'),
('2c91647d5900bf8501590704dd3000e9',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 17:44:36 036','登录系统','LogService'),
('2c91647d5900bf850159070c765700ea',1,'用户：[superadmin] 成功登录系统','superadmin','202.105.72.250','2016-12-16 17:52:54 054','系统登录','LogService'),
('2c91647d5900bf850159070c939900eb',3,'错误代码:404，访问路径:/favicon.ico','superadmin','202.105.72.250','2016-12-16 17:53:01 001','系统异常','LogService'),
('2c91647d5900bf850159072b52be00ec',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 18:26:36 036','登录系统','LogService'),
('2c91647d5900bf8501590736d24700ed',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-16 18:39:10 010','系统异常','LogService'),
('2c91647d5900bf8501590745a6aa00ee',1,'用户：[superadmin] 成功登录系统','superadmin','182.139.173.234','2016-12-16 18:55:22 022','系统登录','LogService'),
('2c91647d5900bf8501590745c38600ef',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.139.173.234','2016-12-16 18:55:29 029','系统异常','LogService'),
('2c91647d5900bf8501590746665900f0',1,'切换布局：[layout: ${layout}]','superadmin','182.139.173.234','2016-12-16 18:56:11 011','系统首页','LogService'),
('2c91647d5900bf850159076243dd00f1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 19:26:37 037','登录系统','LogService'),
('2c91647d5900bf85015907ddb8be00f2',1,'用户：[superadmin] 成功登录系统','superadmin','103.244.255.206','2016-12-16 21:41:28 028','系统登录','LogService'),
('2c91647d5900bf85015907dddca500f3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','103.244.255.206','2016-12-16 21:41:37 037','系统异常','LogService'),
('2c91647d5900bf85015907fb2d5b00f4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-16 22:13:38 038','登录系统','LogService'),
('2c91647d5900bf8501590837d91b00f5',1,'用户：[superadmin] 成功登录系统','superadmin','27.155.248.199','2016-12-16 23:19:54 054','系统登录','LogService'),
('2c91647d5900bf8501590837f6cc00f6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.155.248.199','2016-12-16 23:20:02 002','系统异常','LogService'),
('2c91647d5900bf850159083cac6e00f7',1,'切换布局：[layout: ${layout}]','superadmin','27.155.248.199','2016-12-16 23:25:11 011','系统首页','LogService'),
('2c91647d5900bf850159083cc04f00f8',1,'切换布局：[layout: ${layout}]','superadmin','27.155.248.199','2016-12-16 23:25:16 016','系统首页','LogService'),
('2c91647d5900bf850159083ced6b00f9',1,'切换布局：[layout: ${layout}]','superadmin','27.155.248.199','2016-12-16 23:25:27 027','系统首页','LogService'),
('2c91647d5914e621015914e6f1eb0000',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-19 10:26:36 036','系统登录','LogService'),
('2c91647d5914e621015914e6fa2b0001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-19 10:26:38 038','系统异常','LogService'),
('2c91647d5914e621015914e75fad0002',1,'用户：[superadmin] 退出系统','superadmin','60.173.220.146','2016-12-19 10:27:04 004','退出系统','LogService'),
('2c91647d5914e621015914f79dc20003',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-19 10:44:49 049','系统异常','LogService'),
('2c91647d5914e621015914fb5a550004',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.96.106','2016-12-19 10:48:54 054','系统登录','LogService'),
('2c91647d5914e621015914fb67e20005',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.96.106','2016-12-19 10:48:57 057','系统登录','LogService'),
('2c91647d5914e621015914fb76740006',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.96.106','2016-12-19 10:49:01 001','系统登录','LogService'),
('2c91647d5914e621015914fb88cb0007',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.96.106','2016-12-19 10:49:05 005','系统登录','LogService'),
('2c91647d5914e621015914fc145e0008',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.96.106','2016-12-19 10:49:41 041','系统登录','LogService'),
('2c91647d5914e621015914feec170009',3,'错误代码:404，访问路径:/show.html','system','123.56.155.154','2016-12-19 10:52:48 048','系统异常','LogService'),
('2c91647d5914e62101591502656f000a',1,'用户：[superadmin] 成功登录系统','superadmin','49.77.167.90','2016-12-19 10:56:35 035','系统登录','LogService'),
('2c91647d5914e621015915059ad0000b',1,'用户：[superadmin] 成功登录系统','superadmin','218.94.14.30','2016-12-19 11:00:05 005','系统登录','LogService'),
('2c91647d5914e62101591515a60f000c',1,'用户：[superadmin] 成功登录系统','superadmin','49.77.227.106','2016-12-19 11:17:37 037','系统登录','LogService'),
('2c91647d5914e621015915173936000d',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.42.130','2016-12-19 11:19:20 020','系统登录','LogService'),
('2c91647d5914e621015915181bb8000e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 11:20:18 018','登录系统','LogService'),
('2c91647d5914e6210159151e9d5d000f',3,'错误代码:404，访问路径:/open/doc','superadmin','115.236.42.130','2016-12-19 11:27:25 025','系统异常','LogService'),
('2c91647d5914e6210159151eed110010',1,'用户：[superadmin] 成功登录系统','superadmin','222.133.32.70','2016-12-19 11:27:45 045','系统登录','LogService'),
('2c91647d5914e6210159151f0b1c0011',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.133.32.70','2016-12-19 11:27:53 053','系统异常','LogService'),
('2c91647d5914e6210159151f6f150012',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 11:28:18 018','登录系统','LogService'),
('2c91647d5914e6210159151ffdf60013',1,'切换布局：[layout: ${layout}]','superadmin','222.133.32.70','2016-12-19 11:28:55 055','系统首页','LogService'),
('2c91647d5914e62101591521cee20014',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.42.130','2016-12-19 11:30:54 054','系统登录','LogService'),
('2c91647d5914e621015915222e680015',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 11:31:18 018','登录系统','LogService'),
('2c91647d5914e62101591522defb0016',3,'错误代码:404，访问路径:/favicon.ico','system','115.236.42.130','2016-12-19 11:32:03 003','系统异常','LogService'),
('2c91647d5914e62101591522f30c0017',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.42.130','2016-12-19 11:32:09 009','系统登录','LogService'),
('2c91647d5914e6210159152310e80018',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.236.42.130','2016-12-19 11:32:16 016','系统异常','LogService'),
('2c91647d5914e6210159152312350019',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.236.42.130','2016-12-19 11:32:17 017','系统异常','LogService'),
('2c91647d5914e62101591532a9c7001a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 11:49:18 018','登录系统','LogService'),
('2c91647d5914e6210159153ae77c001b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 11:58:19 019','登录系统','LogService'),
('2c91647d5914e6210159153bd1f4001c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 11:59:19 019','登录系统','LogService'),
('2c91647d5914e6210159153e9154001d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 12:02:19 019','登录系统','LogService'),
('2c91647d5914e6210159153e9155001e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 12:02:19 019','登录系统','LogService'),
('2c91647d5914e621015915521200001f',1,'用户：[superadmin] 成功登录系统','superadmin','220.168.28.10','2016-12-19 12:23:37 037','系统登录','LogService'),
('2c91647d5914e621015915522d910020',3,'错误代码:404，访问路径:/favicon.ico','superadmin','220.168.28.10','2016-12-19 12:23:44 044','系统异常','LogService'),
('2c91647d5914e621015915533f9a0021',1,'切换布局：[layout: ${layout}]','superadmin','220.168.28.10','2016-12-19 12:24:54 054','系统首页','LogService'),
('2c91647d5914e62101591557c8110022',1,'切换布局：[layout: ${layout}]','superadmin','220.168.28.10','2016-12-19 12:29:51 051','系统首页','LogService'),
('2c91647d5914e62101591563fc480023',1,'用户：[superadmin] 成功登录系统','superadmin','150.255.249.205','2016-12-19 12:43:11 011','系统登录','LogService'),
('2c91647d5914e62101591566803e0024',1,'切换布局：[layout: ${layout}]','superadmin','150.255.249.205','2016-12-19 12:45:56 056','系统首页','LogService'),
('2c91647d5914e62101591573acd10025',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 13:00:19 019','登录系统','LogService'),
('2c91647d5914e6210159157c11a00026',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.42.130','2016-12-19 13:09:29 029','系统登录','LogService'),
('2c91647d5914e6210159158253440027',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 13:16:19 019','登录系统','LogService'),
('2c91647d5914e621015915887b7a0028',1,'用户：[superadmin] 成功登录系统','superadmin','218.25.32.210','2016-12-19 13:23:03 003','系统登录','LogService'),
('2c91647d5914e621015915889b060029',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.25.32.210','2016-12-19 13:23:11 011','系统异常','LogService'),
('2c91647d5914e6210159158a8fe1002a',1,'用户：[superadmin] 成功登录系统','superadmin','118.26.73.2','2016-12-19 13:25:19 019','系统登录','LogService'),
('2c91647d5914e6210159158aaf51002b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.26.73.2','2016-12-19 13:25:27 027','系统异常','LogService'),
('2c91647d5914e6210159158c1353002c',3,'错误代码:404，访问路径:/favicon.ico','system','119.187.120.188','2016-12-19 13:26:58 058','系统异常','LogService'),
('2c91647d5914e6210159158c3f91002d',1,'用户：[superadmin] 成功登录系统','superadmin','119.187.120.188','2016-12-19 13:27:09 009','系统登录','LogService'),
('2c91647d5914e6210159158c66b7002e',1,'切换布局：[layout: ${layout}]','superadmin','119.187.120.188','2016-12-19 13:27:19 019','系统首页','LogService'),
('2c91647d5914e621015915929ebd002f',3,'错误代码:404，访问路径:/\'+ s.iframeSrc +\'','system','119.147.146.73','2016-12-19 13:34:07 007','系统异常','LogService'),
('2c91647d5914e621015915984d430030',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 13:40:19 019','登录系统','LogService'),
('2c91647d5914e621015915a7ddcc0031',1,'用户：[superadmin] 成功登录系统','superadmin','222.183.232.73','2016-12-19 13:57:19 019','系统登录','LogService'),
('2c91647d5914e621015915a8c88e0032',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 13:58:20 020','登录系统','LogService'),
('2c91647d5914e621015915a8c89b0033',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 13:58:20 020','登录系统','LogService'),
('2c91647d5914e621015915a95cd20034',1,'切换布局：[layout: ${layout}]','superadmin','222.183.232.73','2016-12-19 13:58:58 058','系统首页','LogService'),
('2c91647d5914e621015915a9b3120035',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 13:59:20 020','登录系统','LogService'),
('2c91647d5914e621015915ad2b4e0036',1,'用户：[superadmin] 成功登录系统','superadmin','180.173.244.172','2016-12-19 14:03:07 007','系统登录','LogService'),
('2c91647d5914e621015915ad90270037',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:33 033','请求出错','LogService'),
('2c91647d5914e621015915ad98fc0038',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:35 035','请求出错','LogService'),
('2c91647d5914e621015915ad9fbc0039',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:37 037','请求出错','LogService'),
('2c91647d5914e621015915ada432003a',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:38 038','请求出错','LogService'),
('2c91647d5914e621015915ada7a8003b',1,'切换布局：[layout: ${layout}]','superadmin','222.183.232.73','2016-12-19 14:03:39 039','系统首页','LogService'),
('2c91647d5914e621015915ada7c8003c',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:39 039','请求出错','LogService'),
('2c91647d5914e621015915adba56003d',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:44 044','请求出错','LogService'),
('2c91647d5914e621015915adbc13003e',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:44 044','请求出错','LogService'),
('2c91647d5914e621015915adbd29003f',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:44 044','请求出错','LogService'),
('2c91647d5914e621015915adbe120040',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:45 045','请求出错','LogService'),
('2c91647d5914e621015915adc0d30041',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:45 045','请求出错','LogService'),
('2c91647d5914e621015915adc0f10042',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','180.173.244.172','2016-12-19 14:03:45 045','请求出错','LogService'),
('2c91647d5914e621015915ae18f80043',1,'用户：[superadmin] 退出系统','superadmin','222.183.232.73','2016-12-19 14:04:08 008','退出系统','LogService'),
('2c91647d5914e621015915aeff670044',1,'切换布局：[layout: ${layout}]','superadmin','180.173.244.172','2016-12-19 14:05:07 007','系统首页','LogService'),
('2c91647d5914e621015915af45d60045',1,'锁定系统','superadmin','180.173.244.172','2016-12-19 14:05:25 025','个人中心','LogService'),
('2c91647d5914e621015915af56050046',1,'解锁系统','superadmin','180.173.244.172','2016-12-19 14:05:29 029','个人中心','LogService'),
('2c91647d5914e621015915bbd8320047',1,'用户：[superadmin] 成功登录系统','superadmin','222.133.32.70','2016-12-19 14:19:09 009','系统登录','LogService'),
('2c91647d5914e621015915bbf7ee0048',1,'切换布局：[layout: ${layout}]','superadmin','222.133.32.70','2016-12-19 14:19:17 017','系统首页','LogService'),
('2c91647d5914e621015915bcd0040049',1,'切换布局：[layout: ${layout}]','superadmin','222.133.32.70','2016-12-19 14:20:12 012','系统首页','LogService'),
('2c91647d5914e621015915beeeb5004a',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-19 14:22:31 031','系统登录','LogService'),
('2c91647d5914e621015915befdbd004b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-19 14:22:35 035','系统异常','LogService'),
('2c91647d5914e621015915c6ef87004c',1,'用户：[superadmin] 成功登录系统','superadmin','110.249.218.124','2016-12-19 14:31:16 016','系统登录','LogService'),
('2c91647d5914e621015915c70bc4004d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','110.249.218.124','2016-12-19 14:31:23 023','系统异常','LogService'),
('2c91647d5914e621015915c84950004e',1,'切换布局：[layout: ${layout}]','superadmin','110.249.218.124','2016-12-19 14:32:44 044','系统首页','LogService'),
('2c91647d5914e621015915c8834c004f',1,'锁定系统','superadmin','110.249.218.124','2016-12-19 14:32:59 059','个人中心','LogService'),
('2c91647d5914e621015915c88f9d0050',1,'解锁系统','superadmin','110.249.218.124','2016-12-19 14:33:02 002','个人中心','LogService'),
('2c91647d5914e621015915c890f00051',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','110.249.218.124','2016-12-19 14:33:02 002','请求出错','LogService'),
('2c91647d5914e621015915c891e30052',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','110.249.218.124','2016-12-19 14:33:03 003','请求错误','LogService'),
('2c91647d5914e621015915cb95170053',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 14:36:20 020','登录系统','LogService'),
('2c91647d5914e621015915d618710054',1,'用户：[superadmin] 成功登录系统','superadmin','58.213.68.62','2016-12-19 14:47:49 049','系统登录','LogService'),
('2c91647d5914e621015915d65be80055',1,'切换布局：[layout: ${layout}]','superadmin','58.213.68.62','2016-12-19 14:48:06 006','系统首页','LogService'),
('2c91647d5914e621015915d6bfb40056',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.49.236','2016-12-19 14:48:32 032','系统登录','LogService'),
('2c91647d5914e621015915d6e4360057',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.236.66.108','2016-12-19 14:48:41 041','系统异常','LogService'),
('2c91647d5914e621015915d82c840058',3,'错误代码:404，访问路径:/open/doc','superadmin','58.213.68.62','2016-12-19 14:50:05 005','系统异常','LogService'),
('2c91647d5914e621015915d850ce0059',3,'错误代码:404，访问路径:/open/doc','system','140.207.185.107','2016-12-19 14:50:15 015','系统异常','LogService'),
('2c91647d5914e621015915d85cc4005a',1,'切换布局：[layout: ${layout}]','superadmin','58.213.68.62','2016-12-19 14:50:18 018','系统首页','LogService'),
('2c91647d5914e621015915d866b7005b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 14:50:20 020','登录系统','LogService'),
('2c91647d5914e621015915d99257005d',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','221.12.10.130','2016-12-19 14:51:37 037','请求出错','LogService'),
('2c91647d5914e621015915d9b77d005e',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','221.12.10.130','2016-12-19 14:51:46 046','请求出错','LogService'),
('2c91647d5914e621015915db2710005f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 14:53:21 021','登录系统','LogService'),
('2c91647d5914e621015915e4501a0060',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 15:03:21 021','登录系统','LogService'),
('2c91647d5914e621015915f3e2ae0061',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 15:20:21 021','登录系统','LogService'),
('2c91647d5914e621015915f5b8d40062',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 15:22:22 022','登录系统','LogService'),
('2c91647d5914e621015915fef77a0063',1,'用户：[superadmin] 成功登录系统','superadmin','111.47.14.99','2016-12-19 15:32:28 028','系统登录','LogService'),
('2c91647d5914e621015915ff1bb40064',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.47.14.99','2016-12-19 15:32:37 037','系统异常','LogService'),
('2c91647d5914e621015915ff35a00065',1,'用户：[superadmin] 退出系统','superadmin','111.47.14.99','2016-12-19 15:32:44 044','退出系统','LogService'),
('2c91647d5914e6210159163c5bda0066',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.197.218','2016-12-19 16:39:31 031','系统登录','LogService'),
('2c91647d5914e6210159163c7b7f0067',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.17.197.218','2016-12-19 16:39:39 039','系统异常','LogService'),
('2c91647d5914e621015916458d0e0068',1,'用户：[superadmin] 成功登录系统','superadmin','115.201.8.42','2016-12-19 16:49:33 033','系统登录','LogService'),
('2c91647d5914e62101591645a9b10069',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.201.8.42','2016-12-19 16:49:41 041','系统异常','LogService'),
('2c91647d5914e62101591645aaba006a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.201.8.42','2016-12-19 16:49:41 041','系统异常','LogService'),
('2c91647d5914e6210159164a278d006b',1,'切换布局：[layout: ${layout}]','superadmin','115.201.8.42','2016-12-19 16:54:35 035','系统首页','LogService'),
('2c91647d5914e6210159164ae209006c',3,'错误代码:404，访问路径:/favicon.ico','system','39.130.111.77','2016-12-19 16:55:23 023','系统异常','LogService'),
('2c91647d5914e6210159164b11b6006d',1,'用户：[superadmin] 成功登录系统','superadmin','39.130.111.77','2016-12-19 16:55:35 035','系统登录','LogService'),
('2c91647d5914e6210159164b49ce006e',1,'切换布局：[layout: ${layout}]','superadmin','39.130.111.77','2016-12-19 16:55:49 049','系统首页','LogService'),
('2c91647d5914e6210159164b80b2006f',3,'错误代码:404，访问路径:/open/doc','superadmin','115.201.8.42','2016-12-19 16:56:04 004','系统异常','LogService'),
('2c91647d5914e6210159164c1a3a0070',1,'切换布局：[layout: ${layout}]','superadmin','39.130.111.77','2016-12-19 16:56:43 043','系统首页','LogService'),
('2c91647d5914e621015916589d260071',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 17:10:23 023','登录系统','LogService'),
('2c91647d5914e62101591667451c0072',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 17:26:23 023','登录系统','LogService'),
('2c91647d5914e6210159166cc4d20073',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 17:32:24 024','登录系统','LogService'),
('2c91647d5914e62101591670fd730074',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.57.251','2016-12-19 17:37:00 000','系统异常','LogService'),
('2c91647d5914e6210159168a47f80075',3,'错误代码:404，访问路径:/favicon.ico','system','42.199.133.18','2016-12-19 18:04:38 038','系统异常','LogService'),
('2c91647d5914e6210159168a48850076',3,'错误代码:404，访问路径:/favicon.ico','system','42.199.133.18','2016-12-19 18:04:38 038','系统异常','LogService'),
('2c91647d5914e6210159168a691e0077',1,'用户：[superadmin] 成功登录系统','superadmin','42.199.133.18','2016-12-19 18:04:46 046','系统登录','LogService'),
('2c91647d5914e621015916aa1ea60079',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 18:39:24 024','登录系统','LogService'),
('2c91647d5914e621015916ef22e2007a',1,'用户：[superadmin] 成功登录系统','superadmin','118.250.172.174','2016-12-19 19:54:47 047','系统登录','LogService'),
('2c91647d5914e621015916ef41b5007b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.250.172.174','2016-12-19 19:54:55 055','系统异常','LogService'),
('2c91647d5914e621015916ef5055007c',1,'切换布局：[layout: ${layout}]','superadmin','118.250.172.174','2016-12-19 19:54:59 059','系统首页','LogService'),
('2c91647d5914e621015916f8ba34007d',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-19 20:05:16 016','系统异常','LogService'),
('2c91647d5914e621015916fa14ce007e',3,'错误代码:404，访问路径:/favicon.ico','system','120.132.68.142','2016-12-19 20:06:45 045','系统异常','LogService'),
('2c91647d5914e6210159170c1802007f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 20:26:25 025','登录系统','LogService'),
('2c91647d5914e6210159170f0b2c0080',3,'错误代码:404，访问路径:/favicon.ico','system','14.215.170.104','2016-12-19 20:29:38 038','系统异常','LogService'),
('2c91647d5914e6210159170f0da30081',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','14.215.170.104','2016-12-19 20:29:39 039','请求出错','LogService'),
('2c91647d5914e6210159170f0db20082',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','14.215.170.104','2016-12-19 20:29:39 039','请求错误','LogService'),
('2c91647d5914e6210159170f67260083',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','14.215.170.104','2016-12-19 20:30:02 002','请求出错','LogService'),
('2c91647d5914e6210159170f67330084',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','14.215.170.104','2016-12-19 20:30:02 002','请求错误','LogService'),
('2c91647d5914e6210159170fa6c10085',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','14.215.170.104','2016-12-19 20:30:18 018','请求出错','LogService'),
('2c91647d5914e6210159170fa6d00086',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','SYSTEM','14.215.170.104','2016-12-19 20:30:18 018','请求错误','LogService'),
('2c91647d5914e6210159171af83e0087',1,'用户：[superadmin] 成功登录系统','superadmin','183.198.231.163','2016-12-19 20:42:40 040','系统登录','LogService'),
('2c91647d5914e6210159173721ea0088',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-19 21:13:26 026','登录系统','LogService'),
('2c91647d5914e6210159174942a90089',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2016-12-19 21:33:14 014','系统异常','LogService'),
('2c91647d5914e6210159181833ef008a',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','SYSTEM','113.71.241.253','2016-12-20 01:19:16 016','请求错误','LogService'),
('2c91647d5914e621015918183422008b',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','SYSTEM','113.71.241.253','2016-12-20 01:19:16 016','请求出错','LogService'),
('2c91647d5914e621015918185aef008c',3,'错误代码:404，访问路径:/favicon.ico','system','113.71.241.253','2016-12-20 01:19:26 026','系统异常','LogService'),
('2c91647d5914e62101591818a785008d',1,'用户：[superadmin] 成功登录系统','superadmin','113.71.241.253','2016-12-20 01:19:46 046','系统登录','LogService'),
('2c91647d5914e6210159181953ea008e',1,'切换布局：[layout: ${layout}]','superadmin','113.71.241.253','2016-12-20 01:20:30 030','系统首页','LogService'),
('2c91647d5914e6210159181962a9008f',1,'切换布局：[layout: ${layout}]','superadmin','113.71.241.253','2016-12-20 01:20:33 033','系统首页','LogService'),
('2c91647d5914e6210159182164fe0090',1,'切换布局：[layout: ${layout}]','superadmin','113.71.241.253','2016-12-20 01:29:18 018','系统首页','LogService'),
('2c91647d5914e621015918307f5f0091',1,'用户：[superadmin] 成功登录系统','superadmin','110.152.82.220','2016-12-20 01:45:48 048','系统登录','LogService'),
('2c91647d5914e62101591830a17d0092',3,'错误代码:404，访问路径:/favicon.ico','superadmin','110.152.82.220','2016-12-20 01:45:57 057','系统异常','LogService'),
('2c91647d5914e6210159183d016c0093',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 01:59:28 028','登录系统','LogService'),
('2c91647d5914e6210159184115510094',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-20 02:03:55 055','系统异常','LogService'),
('2c91647d5914e6210159184e68510095',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 02:18:28 028','登录系统','LogService'),
('2c91647d5914e6210159199b899c0096',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','212.47.246.179','2016-12-20 08:22:20 020','系统异常','LogService'),
('2c91647d5914e621015919b2f0080097',1,'用户：[superadmin] 成功登录系统','superadmin','221.2.164.8','2016-12-20 08:47:54 054','系统登录','LogService'),
('2c91647d5914e621015919d2a1300098',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 09:22:31 031','登录系统','LogService'),
('2c91647d5914e621015919d967570099',1,'用户：[superadmin] 成功登录系统','superadmin','14.23.33.67','2016-12-20 09:29:55 055','系统登录','LogService'),
('2c91647d5914e621015919d983a7009a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','14.23.33.67','2016-12-20 09:30:02 002','系统异常','LogService'),
('2c91647d5914e621015919da0e9c009b',1,'切换布局：[layout: ${layout}]','superadmin','14.23.33.67','2016-12-20 09:30:38 038','系统首页','LogService'),
('2c91647d5914e621015919e68056009c',1,'用户：[superadmin] 成功登录系统','superadmin','182.150.24.208','2016-12-20 09:44:13 013','系统登录','LogService'),
('2c91647d5914e621015919e69b91009d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.150.24.208','2016-12-20 09:44:20 020','系统异常','LogService'),
('2c91647d5914e621015919e86708009e',1,'切换布局：[layout: ${layout}]','superadmin','182.150.24.208','2016-12-20 09:46:18 018','系统首页','LogService'),
('2c91647d5914e621015919e88a67009f',1,'锁定系统','superadmin','182.150.24.208','2016-12-20 09:46:27 027','个人中心','LogService'),
('2c91647d5914e621015919e8a7c000a0',1,'解锁系统','superadmin','182.150.24.208','2016-12-20 09:46:34 034','个人中心','LogService'),
('2c91647d5914e621015919f7427400a1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 10:02:31 031','登录系统','LogService'),
('2c91647d5914e621015919f81e0100a2',1,'用户：[superadmin] 成功登录系统','superadmin','112.255.225.234','2016-12-20 10:03:28 028','系统登录','LogService'),
('2c91647d5914e621015919f83b2300a3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.255.225.234','2016-12-20 10:03:35 035','系统异常','LogService'),
('2c91647d5914e62101591a04ffa900a4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 10:17:32 032','登录系统','LogService'),
('2c91647d5914e62101591a14908500a5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 10:34:32 032','登录系统','LogService'),
('2c91647d5914e62101591a15ea9a00a6',1,'用户：[superadmin] 成功登录系统','superadmin','220.248.107.116','2016-12-20 10:36:01 001','系统登录','LogService'),
('2c91647d5914e62101591a1666f600a7',1,'切换布局：[layout: ${layout}]','superadmin','220.248.107.116','2016-12-20 10:36:32 032','系统首页','LogService'),
('2c91647d5914e62101591a1987c800a8',1,'用户：[superadmin] 成功登录系统','superadmin','115.238.92.179','2016-12-20 10:39:57 057','系统登录','LogService'),
('2c91647d5914e62101591a19aa4400aa',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.238.92.179','2016-12-20 10:40:06 006','系统异常','LogService'),
('2c91647d5914e62101591a1a72e900ab',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','220.248.107.116','2016-12-20 10:40:58 058','请求出错','LogService'),
('2c91647d5914e62101591a1ad50e00ac',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','220.248.107.116','2016-12-20 10:41:23 023','请求出错','LogService'),
('2c91647d5914e62101591a1b106c00ad',1,'切换布局：[layout: ${layout}]','superadmin','115.238.92.179','2016-12-20 10:41:38 038','系统首页','LogService'),
('2c91647d5914e62101591a1b6dac00ae',1,'切换布局：[layout: ${layout}]','superadmin','115.238.92.179','2016-12-20 10:42:02 002','系统首页','LogService'),
('2c91647d5914e62101591a3d4cf800b0',1,'用户：[superadmin] 成功登录系统','superadmin','202.105.201.10','2016-12-20 11:19:02 002','系统登录','LogService'),
('2c91647d5914e62101591a3d6ab600b1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','202.105.201.10','2016-12-20 11:19:09 009','系统异常','LogService'),
('2c91647d5914e62101591a4083c200b2',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 11:22:32 032','登录系统','LogService'),
('2c91647d591a463c01591a481ab10000',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-20 11:30:50 050','系统异常','LogService'),
('2c91647d591a463c01591a52a62d0001',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 11:42:21 021','登录系统','LogService'),
('2c91647d591a463c01591a59f9840002',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 11:50:21 021','登录系统','LogService'),
('2c91647d591a463c01591a801ebc0003',1,'用户：[superadmin] 成功登录系统','superadmin','124.193.121.2','2016-12-20 12:32:01 001','系统登录','LogService'),
('2c91647d591a463c01591a803c1d0004',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.193.121.2','2016-12-20 12:32:08 008','系统异常','LogService'),
('2c91647d591a463c01591a8169220006',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','124.193.121.2','2016-12-20 12:33:25 025','请求出错','LogService'),
('2c91647d591a463c01591a8296020007',1,'切换布局：[layout: ${layout}]','superadmin','124.193.121.2','2016-12-20 12:34:42 042','系统首页','LogService'),
('2c91647d591a463c01591a8c06560008',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','124.193.121.2','2016-12-20 12:45:01 001','请求出错','LogService'),
('2c91647d591a463c01591a8c06880009',3,'错误代码:500，访问路径:/bi/form/datalist20/2c91647d5914e62101591a225cbc00af','superadmin','124.193.121.2','2016-12-20 12:45:01 001','系统异常','LogService'),
('2c91647d591a463c01591a8c44f2000a',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','124.193.121.2','2016-12-20 12:45:17 017','请求出错','LogService'),
('2c91647d591a463c01591a8c450a000b',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cdb1a444001d','superadmin','124.193.121.2','2016-12-20 12:45:17 017','系统异常','LogService'),
('2c91647d591a463c01591a8c7826000c',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','124.193.121.2','2016-12-20 12:45:30 030','请求出错','LogService'),
('2c91647d591a463c01591a8c783c000d',3,'错误代码:500，访问路径:/bi/form/datalist20/402881ee54a29b8b0154a2c6cc1b000b','superadmin','124.193.121.2','2016-12-20 12:45:30 030','系统异常','LogService'),
('2c91647d591a463c01591a8ca277000e',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','124.193.121.2','2016-12-20 12:45:41 041','请求出错','LogService'),
('2c91647d591a463c01591a8ca290000f',3,'错误代码:500，访问路径:/bi/form/datalist20/402881ee54a29b8b0154a2c6cc1b000b','superadmin','124.193.121.2','2016-12-20 12:45:41 041','系统异常','LogService'),
('2c91647d591a463c01591aa392f80010',1,'用户：[superadmin] 成功登录系统','superadmin','220.248.107.116','2016-12-20 13:10:44 044','系统登录','LogService'),
('2c91647d591a463c01591aa3ecda0011',3,'错误代码:404，访问路径:/bi','superadmin','220.248.107.116','2016-12-20 13:11:07 007','系统异常','LogService'),
('2c91647d591a463c01591aa8b8c10012',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 13:16:22 022','登录系统','LogService'),
('2c91647d591a463c01591ab1ce630013',1,'用户：[superadmin] 成功登录系统','superadmin','59.42.26.159','2016-12-20 13:26:17 017','系统登录','LogService'),
('2c91647d591a463c01591ab1efa50014',3,'错误代码:404，访问路径:/favicon.ico','superadmin','59.42.26.159','2016-12-20 13:26:25 025','系统异常','LogService'),
('2c91647d591a463c01591ab36f0d0015',1,'切换布局：[layout: ${layout}]','superadmin','59.42.26.159','2016-12-20 13:28:04 004','系统首页','LogService'),
('2c91647d591a463c01591ab772a50016',3,'错误代码:404，访问路径:/favicon.ico','system','175.0.130.238','2016-12-20 13:32:27 027','系统异常','LogService'),
('2c91647d591a463c01591ab7a5240017',1,'用户：[superadmin] 成功登录系统','superadmin','222.244.67.97','2016-12-20 13:32:40 040','系统登录','LogService'),
('2c91647d591a463c01591ac087f10018',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 13:42:22 022','登录系统','LogService'),
('2c91647d591a463c01591ac136320019',1,'用户：[superadmin] 成功登录系统','superadmin','221.224.28.150','2016-12-20 13:43:07 007','系统登录','LogService'),
('2c91647d591a463c01591ac154c6001a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.224.28.150','2016-12-20 13:43:14 014','系统异常','LogService'),
('2c91647d591a463c01591ac18fca001b',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','221.224.28.150','2016-12-20 13:43:29 029','请求出错','LogService'),
('2c91647d591a463c01591ac18fd3001c',3,'错误代码:500，访问路径:/bi/form/datalist20/2c91647d5914e62101591a225cbc00af','superadmin','221.224.28.150','2016-12-20 13:43:30 030','系统异常','LogService'),
('2c91647d591a463c01591aca3abb001d',1,'用户：[superadmin] 成功登录系统','superadmin','124.193.121.2','2016-12-20 13:52:58 058','系统登录','LogService'),
('2c91647d591a463c01591acafd83001e',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','124.193.121.2','2016-12-20 13:53:47 047','请求出错','LogService'),
('2c91647d591a463c01591acafd9c001f',3,'错误代码:500，访问路径:/bi/form/datalist20/2c91647d5914e62101591a225cbc00af','superadmin','124.193.121.2','2016-12-20 13:53:47 047','系统异常','LogService'),
('2c91647d591a463c01591ad1ee460020',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 14:01:22 022','登录系统','LogService'),
('2c91647d591a463c01591ad3b4800021',1,'用户：[superadmin] 成功登录系统','superadmin','61.142.247.146','2016-12-20 14:03:19 019','系统登录','LogService'),
('2c91647d591a463c01591ad3b78d0022',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.142.247.146','2016-12-20 14:03:19 019','系统异常','LogService'),
('2c91647d591a463c01591ad3c3290023',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-20 14:03:22 022','登录系统','LogService'),
('2c91647d591a463c01591ad3cbf10024',1,'切换布局：[layout: ${layout}]','superadmin','61.142.247.146','2016-12-20 14:03:25 025','系统首页','LogService'),
('2c91647d591a463c01591ad4dd280025',1,'切换布局：[layout: ${layout}]','superadmin','61.142.247.146','2016-12-20 14:04:34 034','系统首页','LogService'),
('2c91647d591a463c01591ad6c4930026',3,'错误代码:404，访问路径:/manager/html','system','139.129.236.53','2016-12-20 14:06:39 039','系统异常','LogService'),
('2c91647d592426b90159245e33fe0000',1,'用户：[superadmin] 成功登录系统','superadmin','113.128.109.138','2016-12-22 10:31:10 010','系统登录','LogService'),
('2c91647d592426b90159246f9e3c0001',3,'错误代码:404，访问路径:/robots.txt','system','203.208.60.203','2016-12-22 10:50:11 011','系统异常','LogService'),
('2c91647d592426b901592470602f0002',1,'用户：[superadmin] 成功登录系统','superadmin','219.147.26.158','2016-12-22 10:51:01 001','系统登录','LogService'),
('2c91647d592426b9015924707fc70003',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.147.26.158','2016-12-22 10:51:09 009','系统异常','LogService'),
('2c91647d592426b901592474d6840004',1,'用户：[superadmin] 成功登录系统','superadmin','222.92.60.74','2016-12-22 10:55:53 053','系统登录','LogService'),
('2c91647d592426b901592474f4ab0005',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.92.60.74','2016-12-22 10:56:01 001','系统异常','LogService'),
('2c91647d592426b90159247570660006',1,'切换布局：[layout: ${layout}]','superadmin','222.92.60.74','2016-12-22 10:56:33 033','系统首页','LogService'),
('2c91647d592426b9015924795e410007',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-22 11:00:50 050','系统异常','LogService'),
('2c91647d592426b90159247a8a7a0008',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 11:02:07 007','登录系统','LogService'),
('2c91647d592426b90159247e16910009',1,'用户：[superadmin] 成功登录系统','superadmin','112.228.125.203','2016-12-22 11:06:00 000','系统登录','LogService'),
('2c91647d592426b90159247e342b000a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.234.245.0','2016-12-22 11:06:07 007','系统异常','LogService'),
('2c91647d592426b90159247e350c000b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.233.230.156','2016-12-22 11:06:08 008','系统异常','LogService'),
('2c91647d592426b90159248dc566000c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 11:23:08 008','登录系统','LogService'),
('2c91647d592426b901592496040a000d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 11:32:08 008','登录系统','LogService'),
('2c91647d592426b90159249a98ae000e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 11:37:08 008','登录系统','LogService'),
('2c91647d592426b9015924a0ebf0000f',1,'用户：[superadmin] 成功登录系统','superadmin','113.108.152.98','2016-12-22 11:44:03 003','系统登录','LogService'),
('2c91647d592426b9015924a10b0c0010',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.108.152.98','2016-12-22 11:44:11 011','系统异常','LogService'),
('2c91647d592426b9015924a2d8d10011',1,'用户：[superadmin] 成功登录系统','superadmin','121.28.132.18','2016-12-22 11:46:09 009','系统登录','LogService'),
('2c91647d592426b9015924a2fafe0012',3,'错误代码:404，访问路径:/favicon.ico','superadmin','121.28.132.18','2016-12-22 11:46:17 017','系统异常','LogService'),
('2c91647d592426b9015924a462b20013',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','121.28.132.18','2016-12-22 11:47:50 050','请求出错','LogService'),
('2c91647d592426b9015924a462e20014',3,'错误代码:500，访问路径:/bi/form/datalist20/2c91647d5914e62101591a225cbc00af','superadmin','121.28.132.18','2016-12-22 11:47:50 050','系统异常','LogService'),
('2c91647d592426b9015924a498260015',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','121.28.132.18','2016-12-22 11:48:03 003','请求出错','LogService'),
('2c91647d592426b9015924a4982e0016',3,'错误代码:500，访问路径:/bi/form/datalist20/4028b88158cd06060158cdb1a444001d','superadmin','121.28.132.18','2016-12-22 11:48:03 003','系统异常','LogService'),
('2c91647d592426b9015924a4dae20017',1,'切换布局：[layout: ${layout}]','superadmin','121.28.132.18','2016-12-22 11:48:20 020','系统首页','LogService'),
('2c91647d592426b9015924a54e130018',1,'锁定系统','superadmin','121.28.132.18','2016-12-22 11:48:50 050','个人中心','LogService'),
('2c91647d592426b9015924a55f160019',1,'解锁系统','superadmin','121.28.132.18','2016-12-22 11:48:54 054','个人中心','LogService'),
('2c91647d592426b9015924a5a2ff001a',3,'org.hibernate.exception.SQLGrammarException: could not extract ResultSet','superadmin','121.28.132.18','2016-12-22 11:49:12 012','请求出错','LogService'),
('2c91647d592426b9015924a5a332001b',3,'错误代码:500，访问路径:/bi/form/datalist20/297eb7974e044455014e046e5dc10005','superadmin','121.28.132.18','2016-12-22 11:49:12 012','系统异常','LogService'),
('2c91647d592426b9015924a82d12001d',1,'切换布局：[layout: ${layout}]','superadmin','121.28.132.18','2016-12-22 11:51:58 058','系统首页','LogService'),
('2c91647d592426b9015924a8b151001e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','121.28.132.18','2016-12-22 11:52:32 032','系统异常','LogService'),
('2c91647d592426b9015924a8eca4001f',3,'错误代码:404，访问路径:/index/charts/app/charts/charts.js','superadmin','121.28.132.18','2016-12-22 11:52:47 047','系统异常','LogService'),
('2c91647d592426b9015924a92b430020',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','121.28.132.18','2016-12-22 11:53:03 003','请求出错','LogService'),
('2c91647d592426b9015924bf394f0021',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 12:17:08 008','登录系统','LogService'),
('2c91647d592426b9015924c4b7f20022',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-22 12:23:09 009','登录系统','LogService'),
('2c91647d592426b9015924e323a90023',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-22 12:56:22 022','系统异常','LogService'),
('2c91647d592426b9015924ea4e7a0024',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-22 13:04:12 012','系统异常','LogService'),
('2c91647d592426b901592508c5860025',1,'用户：[superadmin] 成功登录系统','superadmin','59.172.61.82','2016-12-22 13:37:28 028','系统登录','LogService'),
('2c91647d592426b901592508e11c0026',3,'错误代码:404，访问路径:/favicon.ico','superadmin','59.172.61.82','2016-12-22 13:37:36 036','系统异常','LogService'),
('2c91647d592426b90159250915850027',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','59.172.61.82','2016-12-22 13:37:49 049','请求出错','LogService'),
('2c91647d592426b9015925093aea0028',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','59.172.61.82','2016-12-22 13:37:59 059','请求出错','LogService'),
('2c91647d592426b90159250958480029',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','59.172.61.82','2016-12-22 13:38:06 006','请求出错','LogService'),
('2c91647d593502750159350389570000',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.148.254','2016-12-25 16:05:41 041','系统登录','LogService'),
('2c91647d5935027501593503b03a0001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.148.254','2016-12-25 16:05:51 051','系统异常','LogService'),
('2c91647d5935027501593503c9900002',1,'用户：[superadmin] 退出系统','superadmin','36.5.148.254','2016-12-25 16:05:57 057','退出系统','LogService'),
('2c91647d59350275015935e0ca8c0003',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-25 20:07:21 021','系统异常','LogService'),
('2c91647d59350275015935f2be650004',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.148.254','2016-12-25 20:26:58 058','系统登录','LogService'),
('2c91647d59350275015935f2c6920005',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.148.254','2016-12-25 20:27:00 000','系统异常','LogService'),
('2c91647d593502750159360fa8340006',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-25 20:58:32 032','登录系统','LogService'),
('2c91647d59350275015936310e5d0007',3,'错误代码:404，访问路径:/manager/html','system','139.196.139.161','2016-12-25 21:35:01 001','系统异常','LogService'),
('2c91647d593502750159364b6f2d0008',1,'用户：[superadmin] 成功登录系统','superadmin','125.88.25.46','2016-12-25 22:03:50 050','系统登录','LogService'),
('2c91647d593502750159364b8d740009',3,'错误代码:404，访问路径:/favicon.ico','superadmin','125.88.25.46','2016-12-25 22:03:58 058','系统异常','LogService'),
('2c91647d5935027501593664a9af000a',1,'切换布局：[layout: ${layout}]','superadmin','125.88.25.46','2016-12-25 22:31:23 023','系统首页','LogService'),
('2c91647d593502750159368131af000b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-25 23:02:33 033','登录系统','LogService'),
('2c91647d593502750159376a5c6d000c',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-26 03:17:14 014','系统异常','LogService'),
('2c91647d593502750159376a60f7000d',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-26 03:17:15 015','系统异常','LogService'),
('2c91647d5935027501593891389f000e',1,'用户：[superadmin] 成功登录系统','superadmin','27.26.235.124','2016-12-26 08:39:18 018','系统登录','LogService'),
('2c91647d593502750159389154e8000f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.26.235.124','2016-12-26 08:39:25 025','系统异常','LogService'),
('2c91647d5935027501593892470c0010',3,'错误代码:404，访问路径:/open/doc','superadmin','27.26.235.124','2016-12-26 08:40:27 027','系统异常','LogService'),
('2c91647d59350275015938928d170011',3,'错误代码:404，访问路径:/open/doc','system','180.153.214.176','2016-12-26 08:40:45 045','系统异常','LogService'),
('2c91647d59350275015938a028020013',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.69.128','2016-12-26 08:55:37 037','系统异常','LogService'),
('2c91647d59350275015938afb7cc0014',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-26 09:12:37 037','登录系统','LogService'),
('2c91647d59350275015938b738ff0015',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','94.102.49.174','2016-12-26 09:20:48 048','系统异常','LogService'),
('2c91647d59350275015938e645a20016',1,'用户：[superadmin] 成功登录系统','superadmin','120.209.197.250','2016-12-26 10:12:12 012','系统登录','LogService'),
('2c91647d593502750159390309ed0017',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-26 10:43:37 037','登录系统','LogService'),
('2c91647d5935027501593928be260018',1,'用户：[superadmin] 成功登录系统','superadmin','36.251.248.177','2016-12-26 11:24:48 048','系统登录','LogService'),
('2c91647d593502750159392926490019',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.251.248.177','2016-12-26 11:25:15 015','系统异常','LogService'),
('2c91647d593502750159392b2a59001a',1,'用户：[superadmin] 成功登录系统','superadmin','221.224.11.234','2016-12-26 11:27:27 027','系统登录','LogService'),
('2c91647d593502750159392b4af5001b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.224.11.234','2016-12-26 11:27:35 035','系统异常','LogService'),
('2c91647d59350275015939312bb9001c',1,'切换布局：[layout: ${layout}]','superadmin','221.224.11.234','2016-12-26 11:34:00 000','系统首页','LogService'),
('2c91647d59350275015939313980001d',1,'切换布局：[layout: ${layout}]','superadmin','221.224.11.234','2016-12-26 11:34:04 004','系统首页','LogService'),
('2c91647d5935027501593934e589001e',3,'错误代码:404，访问路径:/favicon.ico','system','112.251.224.155','2016-12-26 11:38:05 005','系统异常','LogService'),
('2c91647d5935027501593946cb73001f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-26 11:57:38 038','登录系统','LogService'),
('2c91647d593502750159394e1f0f0020',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-26 12:05:38 038','登录系统','LogService'),
('2c91647d59350275015939a3de420021',1,'用户：[superadmin] 成功登录系统','superadmin','219.139.130.123','2016-12-26 13:39:17 017','系统登录','LogService'),
('2c91647d59350275015939a3fcf50022',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.136.223.34','2016-12-26 13:39:25 025','系统异常','LogService'),
('2c91647d59350275015939a733160023',1,'切换布局：[layout: ${layout}]','superadmin','219.139.130.123','2016-12-26 13:42:56 056','系统首页','LogService'),
('2c91647d59350275015939c217e40025',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','219.139.130.123','2016-12-26 14:12:18 018','请求出错','LogService'),
('2c91647d59350275015939ca12fe0026',1,'用户：[superadmin] 成功登录系统','superadmin','171.221.129.18','2016-12-26 14:21:01 001','系统登录','LogService'),
('2c91647d59350275015939ca3b650027',3,'错误代码:404，访问路径:/favicon.ico','superadmin','171.221.129.18','2016-12-26 14:21:11 011','系统异常','LogService'),
('2c91647d59350275015939ca86dd0028',1,'切换布局：[layout: ${layout}]','superadmin','171.221.129.18','2016-12-26 14:21:31 031','系统首页','LogService'),
('2c91647d59350275015939d2f8c9002b',1,'用户：[superadmin] 成功登录系统','superadmin','58.240.93.226','2016-12-26 14:30:44 044','系统登录','LogService'),
('2c91647d59350275015939d3188d002c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.240.93.226','2016-12-26 14:30:52 052','系统异常','LogService'),
('2c91647d593af28c01593af3be180000',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.148.254','2016-12-26 19:46:09 009','系统登录','LogService'),
('2c91647d593af28c01593af3c5590001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.148.254','2016-12-26 19:46:11 011','系统异常','LogService'),
('2c91647d593af28c01593af3d2470002',1,'用户：[superadmin] 退出系统','superadmin','36.5.148.254','2016-12-26 19:46:14 014','退出系统','LogService'),
('2c91647d593af28c01593af638160003',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.148.254','2016-12-26 19:48:51 051','系统登录','LogService'),
('2c91647d593af28c01593af63f310004',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.148.254','2016-12-26 19:48:53 053','系统异常','LogService'),
('2c91647d593af28c01593af664cb0005',1,'访问菜单列表','superadmin','36.5.148.254','2016-12-26 19:49:03 003','菜单管理','LogService'),
('2c91647d593af28c01593af677aa0006',1,'禁用菜单：[Id:402881ff500261d4015002732e960000]','superadmin','36.5.148.254','2016-12-26 19:49:08 008','菜单管理','LogService'),
('2c91647d593af28c01593af695500007',1,'用户：[superadmin] 退出系统','superadmin','36.5.148.254','2016-12-26 19:49:15 015','退出系统','LogService'),
('2c91647d593af28c01593af69b540008',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.148.254','2016-12-26 19:49:17 017','系统登录','LogService'),
('2c91647d593af28c01593af6d7af0009',1,'锁定系统','superadmin','36.5.148.254','2016-12-26 19:49:32 032','个人中心','LogService'),
('2c91647d593af28c01593af6f15c000a',1,'解锁系统','superadmin','36.5.148.254','2016-12-26 19:49:39 039','个人中心','LogService'),
('2c91647d593af28c01593af702d3000b',1,'用户：[superadmin] 退出系统','superadmin','36.5.148.254','2016-12-26 19:49:43 043','退出系统','LogService'),
('2c91647d593af28c01593b142604000c',3,'错误代码:404，访问路径:/manager/html','system','101.201.71.45','2016-12-26 20:21:33 033','系统异常','LogService'),
('2c91647d593af28c01593b2e76bb000d',1,'用户：[superadmin] 成功登录系统','superadmin','114.252.55.50','2016-12-26 20:50:17 017','系统登录','LogService'),
('2c91647d593af28c01593b2e985c000e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','114.252.55.50','2016-12-26 20:50:26 026','系统异常','LogService'),
('2c91647d593af28c01593b2f071a000f',1,'切换布局：[layout: ${layout}]','superadmin','114.252.55.50','2016-12-26 20:50:54 054','系统首页','LogService'),
('2c91647d593af28c01593b4b39230010',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-26 21:21:42 042','登录系统','LogService'),
('2c91647d593af28c01593b5a8c800011',3,'错误代码:404，访问路径:/myipha.php','system','62.221.93.129','2016-12-26 21:38:27 027','系统异常','LogService'),
('2c91647d593af28c01593b5a8f280012',3,'错误代码:404，访问路径:/myiphd.php','system','62.221.93.129','2016-12-26 21:38:27 027','系统异常','LogService'),
('2c91647d593af28c01593b5a91dc0013',3,'错误代码:404，访问路径:/myiphd.php','system','62.221.93.129','2016-12-26 21:38:28 028','系统异常','LogService'),
('2c91647d593af28c01593b5a94940014',3,'错误代码:404，访问路径:/myiphc.php','system','62.221.93.129','2016-12-26 21:38:29 029','系统异常','LogService'),
('2c91647d593af28c01593b71aace0015',3,'错误代码:404，访问路径:/myipha.php','system','62.221.93.129','2016-12-26 22:03:42 042','系统异常','LogService'),
('2c91647d593af28c01593b71b02b0016',3,'错误代码:404，访问路径:/myiphd.php','system','62.221.93.129','2016-12-26 22:03:43 043','系统异常','LogService'),
('2c91647d593af28c01593b7a94120017',3,'错误代码:404，访问路径:/manager/html','system','139.196.139.161','2016-12-26 22:13:26 026','系统异常','LogService'),
('2c91647d593af28c01593b9757940018',1,'用户：[superadmin] 成功登录系统','superadmin','36.149.135.38','2016-12-26 22:44:51 051','系统登录','LogService'),
('2c91647d593af28c01593b97bc290019',3,'错误代码:404，访问路径:/bi/','superadmin','36.149.135.38','2016-12-26 22:45:16 016','系统异常','LogService'),
('2c91647d593af28c01593bb4851c001a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-26 23:16:43 043','登录系统','LogService'),
('2c91647d593af28c01593bd1b37b001b',3,'错误代码:404，访问路径:/myipha.php','system','62.221.93.129','2016-12-26 23:48:35 035','系统异常','LogService'),
('2c91647d593af28c01593bd1b62d001c',3,'错误代码:404，访问路径:/myiphd.php','system','62.221.93.129','2016-12-26 23:48:36 036','系统异常','LogService'),
('2c91647d593af28c01593bd1b8ca001d',3,'错误代码:404，访问路径:/myiphd.php','system','62.221.93.129','2016-12-26 23:48:37 037','系统异常','LogService'),
('2c91647d593af28c01593bd1bb80001e',3,'错误代码:404，访问路径:/myiphc.php','system','62.221.93.129','2016-12-26 23:48:37 037','系统异常','LogService'),
('2c91647d593af28c01593bd3c54f001f',1,'用户：[superadmin] 成功登录系统','superadmin','14.157.172.24','2016-12-26 23:50:51 051','系统登录','LogService'),
('2c91647d593af28c01593bd3e3290020',3,'错误代码:404，访问路径:/favicon.ico','superadmin','14.157.172.24','2016-12-26 23:50:59 059','系统异常','LogService'),
('2c91647d593af28c01593be4920e0021',3,'错误代码:404，访问路径:/manager/html','system','106.14.57.245','2016-12-27 00:09:12 012','系统异常','LogService'),
('2c91647d593af28c01593bef66480022',1,'用户：[superadmin] 成功登录系统','superadmin','125.88.25.46','2016-12-27 00:21:02 002','系统登录','LogService'),
('2c91647d593af28c01593bef96130023',3,'错误代码:404，访问路径:/favicon.ico','superadmin','125.88.25.46','2016-12-27 00:21:14 014','系统异常','LogService'),
('2c91647d593af28c01593bf2c85b0024',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 00:24:43 043','登录系统','LogService'),
('2c91647d593af28c01593bff98820025',3,'错误代码:404，访问路径:/myipha.php','system','62.221.93.129','2016-12-27 00:38:43 043','系统异常','LogService'),
('2c91647d593af28c01593bff9d770026',3,'错误代码:404，访问路径:/myiphd.php','system','62.221.93.129','2016-12-27 00:38:44 044','系统异常','LogService'),
('2c91647d593af28c01593c0b812a0027',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 00:51:44 044','登录系统','LogService'),
('2c91647d593af28c01593c1138c90028',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-27 00:57:58 058','系统异常','LogService'),
('2c91647d593af28c01593c562e070029',1,'用户：[superadmin] 成功登录系统','superadmin','114.117.21.227','2016-12-27 02:13:17 017','系统登录','LogService'),
('2c91647d593af28c01593c5649cd002a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','114.117.21.227','2016-12-27 02:13:25 025','系统异常','LogService'),
('2c91647d593af28c01593c567ab6002b',1,'切换布局：[layout: ${layout}]','superadmin','114.117.21.227','2016-12-27 02:13:37 037','系统首页','LogService'),
('2c91647d593af28c01593c5688f3002c',1,'切换布局：[layout: ${layout}]','superadmin','114.117.21.227','2016-12-27 02:13:41 041','系统首页','LogService'),
('2c91647d593af28c01593c615d07002d',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','114.117.21.227','2016-12-27 02:25:30 030','请求出错','LogService'),
('2c91647d593af28c01593c615d1d002e',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','114.117.21.227','2016-12-27 02:25:30 030','请求错误','LogService'),
('2c91647d593af28c01593c61ab16002f',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','114.117.21.227','2016-12-27 02:25:50 050','系统异常','LogService'),
('2c91647d593af28c01593c7edff10030',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 02:57:44 044','登录系统','LogService'),
('2c91647d593af28c01593ceff8d10031',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.83.40','2016-12-27 05:01:16 016','系统异常','LogService'),
('2c91647d593af28c01593d5374b30032',3,'错误代码:404，访问路径:/proxyjudge.php','system','204.152.218.49','2016-12-27 06:49:56 056','系统异常','LogService'),
('2c91647d593af28c01593dc072a70033',1,'用户：[superadmin] 成功登录系统','superadmin','113.69.100.34','2016-12-27 08:48:59 059','系统登录','LogService'),
('2c91647d593af28c01593dc096c80034',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.69.100.34','2016-12-27 08:49:08 008','系统异常','LogService'),
('2c91647d593af28c01593ddca3c00035',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 09:19:47 047','登录系统','LogService'),
('2c91647d593af28c01593de7d89d0036',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.122.82','2016-12-27 09:32:01 001','系统登录','LogService'),
('2c91647d593af28c01593de7f3e00037',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.17.122.82','2016-12-27 09:32:08 008','系统异常','LogService'),
('2c91647d593af28c01593de830d90038',1,'切换布局：[layout: ${layout}]','superadmin','218.17.122.82','2016-12-27 09:32:24 024','系统首页','LogService'),
('2c91647d593af28c01593de91af10039',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-27 09:33:24 024','系统登录','LogService'),
('2c91647d593af28c01593de93664003a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-27 09:33:31 031','系统异常','LogService'),
('2c91647d593af28c01593dee01d7003b',3,'错误代码:404，访问路径:/favicon.ico','system','36.251.248.177','2016-12-27 09:38:45 045','系统异常','LogService'),
('2c91647d593af28c01593e0402e7003c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 10:02:47 047','登录系统','LogService'),
('2c91647d593af28c01593e04ed5c003d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 10:03:47 047','登录系统','LogService'),
('2c91647d593af28c01593e07bb58003e',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.42.130','2016-12-27 10:06:51 051','系统登录','LogService'),
('2c91647d593af28c01593e08beb8003f',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','115.236.42.130','2016-12-27 10:07:57 057','请求出错','LogService'),
('2c91647d593af28c01593e08e3830040',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','115.236.42.130','2016-12-27 10:08:07 007','请求出错','LogService'),
('2c91647d593af28c01593e09c59b0041',3,'错误代码:404，访问路径:/open/doc','superadmin','115.236.42.130','2016-12-27 10:09:04 004','系统异常','LogService'),
('2c91647d593af28c01593e0b04f40042',1,'切换布局：[layout: ${layout}]','superadmin','115.236.42.130','2016-12-27 10:10:26 026','系统首页','LogService'),
('2c91647d593af28c01593e0b89310043',1,'用户：[superadmin] 成功登录系统','superadmin','118.26.22.126','2016-12-27 10:11:00 000','系统登录','LogService'),
('2c91647d593af28c01593e0ba96b0044',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.26.22.126','2016-12-27 10:11:08 008','系统异常','LogService'),
('2c91647d593af28c01593e0bdb630045',1,'切换布局：[layout: ${layout}]','superadmin','118.26.22.126','2016-12-27 10:11:21 021','系统首页','LogService'),
('2c91647d593af28c01593e0cba030046',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','115.236.42.130','2016-12-27 10:12:18 018','请求出错','LogService'),
('2c91647d593af28c01593e0cdf3e0047',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','115.236.42.130','2016-12-27 10:12:28 028','请求出错','LogService'),
('2c91647d593af28c01593e0d43020048',1,'用户：[superadmin] 退出系统','superadmin','115.236.42.130','2016-12-27 10:12:53 053','退出系统','LogService'),
('2c91647d593af28c01593e136ccd0049',1,'用户：[superadmin] 成功登录系统','superadmin','60.194.65.154','2016-12-27 10:19:37 037','系统登录','LogService'),
('2c91647d593af28c01593e138e06004a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.194.65.154','2016-12-27 10:19:46 046','系统异常','LogService'),
('2c91647d593af28c01593e1e43d0004b',1,'用户：[superadmin] 成功登录系统','superadmin','112.53.82.55','2016-12-27 10:31:27 027','系统登录','LogService'),
('2c91647d593af28c01593e1e92d6004c',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-27 10:31:48 048','请求出错','LogService'),
('2c91647d593af28c01593e1e92e9004d',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-27 10:31:48 048','请求错误','LogService'),
('2c91647d593af28c01593e2695e0004e',1,'用户：[superadmin] 成功登录系统','superadmin','111.47.64.145','2016-12-27 10:40:33 033','系统登录','LogService'),
('2c91647d593af28c01593e27b8b6004f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 10:41:47 047','登录系统','LogService'),
('2c91647d593af28c01593e2ff6630051',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 10:50:47 047','登录系统','LogService'),
('2c91647d593af28c01593e3af3400052',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 11:02:47 047','登录系统','LogService'),
('2c91647d593af28c01593e4506c20053',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 11:13:48 048','登录系统','LogService'),
('2c91647d593af28c01593e5080570054',1,'用户：[superadmin] 成功登录系统','superadmin','36.251.248.177','2016-12-27 11:26:20 020','系统登录','LogService'),
('2c91647d593af28c01593e50a15b0055',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.251.248.177','2016-12-27 11:26:28 028','系统异常','LogService'),
('2c91647d593af28c01593e525c500056',1,'用户：[zengc] 成功登录系统','zengc','115.236.42.130','2016-12-27 11:28:22 022','系统登录','LogService'),
('2c91647d593af28c01593e52fb3b0057',1,'用户：[zengc] 退出系统','zengc','115.236.42.130','2016-12-27 11:29:02 002','退出系统','LogService'),
('2c91647d593af28c01593e5315f00058',1,'用户：[hefei] 成功登录系统','hefei','115.236.42.130','2016-12-27 11:29:09 009','系统登录','LogService'),
('2c91647d593af28c01593e534e6b0059',1,'锁定系统','hefei','115.236.42.130','2016-12-27 11:29:24 024','个人中心','LogService'),
('2c91647d593af28c01593e5d8371005a',3,'错误代码:404，访问路径:/\'+ s.iframeSrc +\'','system','119.147.146.73','2016-12-27 11:40:33 033','系统异常','LogService'),
('2c91647d593af28c01593e700fa3005b',1,'用户：hefei 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 12:00:48 048','登录系统','LogService'),
('2c91647d593af28c01593e73b94c005c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 12:04:48 048','登录系统','LogService'),
('2c91647d593af28c01593ebbc852005d',1,'用户：[superadmin] 成功登录系统','superadmin','124.205.89.158','2016-12-27 13:23:31 031','系统登录','LogService'),
('2c91647d593af28c01593ebbf146005e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.205.89.158','2016-12-27 13:23:41 041','系统异常','LogService'),
('2c91647d593af28c01593ec01c98005f',1,'切换布局：[layout: ${layout}]','superadmin','124.205.89.158','2016-12-27 13:28:14 014','系统首页','LogService'),
('2c91647d593af28c01593ec0dde00060',1,'用户：[superadmin] 退出系统','superadmin','124.205.89.158','2016-12-27 13:29:04 004','退出系统','LogService'),
('2c91647d593af28c01593ec150140061',1,'用户：[superadmin] 成功登录系统','superadmin','125.88.25.13','2016-12-27 13:29:33 033','系统登录','LogService'),
('2c91647d593af28c01593ec159800062',3,'错误代码:404，访问路径:/favicon.ico','superadmin','125.88.25.13','2016-12-27 13:29:35 035','系统异常','LogService'),
('2c91647d593af28c01593edd057f0063',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 13:59:49 049','登录系统','LogService'),
('2c91647d593af28c01593efd79090064',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.187.160','2016-12-27 14:35:16 016','系统异常','LogService'),
('2c91647d593af28c01593efe83f40065',1,'用户：[superadmin] 成功登录系统','superadmin','221.215.31.50','2016-12-27 14:36:24 024','系统登录','LogService'),
('2c91647d593af28c01593efea0e50066',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.215.31.50','2016-12-27 14:36:31 031','系统异常','LogService'),
('2c91647d593af28c01593f0025be0067',3,'错误代码:404，访问路径:/favicon.ico','system','221.215.31.50','2016-12-27 14:38:11 011','系统异常','LogService'),
('2c91647d593af28c01593f00397c0068',1,'用户：[superadmin] 成功登录系统','superadmin','221.215.31.50','2016-12-27 14:38:16 016','系统登录','LogService'),
('2c91647d593af28c01593f02882a0069',1,'切换布局：[layout: ${layout}]','superadmin','221.215.31.50','2016-12-27 14:40:47 047','系统首页','LogService'),
('2c91647d593af28c01593f0374fc006a',1,'用户：[superadmin] 成功登录系统','superadmin','221.215.31.50','2016-12-27 14:41:48 048','系统登录','LogService'),
('2c91647d593af28c01593f1c3357006b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 15:08:49 049','登录系统','LogService'),
('2c91647d593af28c01593f1e088a006c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 15:10:49 049','登录系统','LogService'),
('2c91647d593af28c01593f1fddd3006d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 15:12:50 050','登录系统','LogService'),
('2c91647d593af28c01593f209d07006e',1,'用户：[superadmin] 成功登录系统','superadmin','116.228.114.126','2016-12-27 15:13:39 039','系统登录','LogService'),
('2c91647d593af28c01593f20bb39006f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.228.114.126','2016-12-27 15:13:46 046','系统异常','LogService'),
('2c91647d593af28c01593f2113aa0070',1,'切换布局：[layout: ${layout}]','superadmin','116.228.114.126','2016-12-27 15:14:09 009','系统首页','LogService'),
('2c91647d593af28c01593f2150e50071',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','116.228.114.126','2016-12-27 15:14:25 025','请求出错','LogService'),
('2c91647d593af28c01593f42a9810072',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 15:50:50 050','登录系统','LogService'),
('2c91647d593af28c01593f49e3b70073',1,'用户：[superadmin] 成功登录系统','superadmin','117.88.226.205','2016-12-27 15:58:44 044','系统登录','LogService'),
('2c91647d593af28c01593f4a06230074',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.88.226.205','2016-12-27 15:58:52 052','系统异常','LogService'),
('2c91647d593af28c01593f4a0e820075',1,'切换布局：[layout: ${layout}]','superadmin','117.88.226.205','2016-12-27 15:58:55 055','系统首页','LogService'),
('2c91647d593af28c01593f551df70076',1,'用户：[superadmin] 成功登录系统','superadmin','58.62.204.66','2016-12-27 16:10:59 059','系统登录','LogService'),
('2c91647d593af28c01593f553b790077',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.62.204.66','2016-12-27 16:11:07 007','系统异常','LogService'),
('2c91647d593af28c01593f5d862d0078',3,'错误代码:404，访问路径:/manager/html','system','114.215.41.44','2016-12-27 16:20:10 010','系统异常','LogService'),
('2c91647d593af28c01593f73314f0079',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 16:43:50 050','登录系统','LogService'),
('2c91647d593af28c01593f733177007a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 16:43:51 051','登录系统','LogService'),
('2c91647d593af28c01593f770453007b',1,'用户：[superadmin] 成功登录系统','superadmin','36.251.248.177','2016-12-27 16:48:01 001','系统登录','LogService'),
('2c91647d593af28c01593f770d0d007c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.251.248.177','2016-12-27 16:48:03 003','系统异常','LogService'),
('2c91647d593af28c01593f773881007d',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','36.251.248.177','2016-12-27 16:48:14 014','请求出错','LogService'),
('2c91647d593af28c01593f776266007e',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','36.251.248.177','2016-12-27 16:48:25 025','请求出错','LogService'),
('2c91647d593af28c01593f7e835f007f',1,'用户：[superadmin] 成功登录系统','superadmin','118.112.188.39','2016-12-27 16:56:12 012','系统登录','LogService'),
('2c91647d593af28c01593f7e9fcb0080',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.112.188.39','2016-12-27 16:56:20 020','系统异常','LogService'),
('2c91647d593af28c01593f8cc71c0081',1,'用户：[superadmin] 成功登录系统','superadmin','112.199.123.100','2016-12-27 17:11:47 047','系统登录','LogService'),
('2c91647d593af28c01593f8d3cdd0082',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.199.123.100','2016-12-27 17:12:17 017','系统异常','LogService'),
('2c91647d593af28c01593f8db7d10083',1,'用户：[superadmin] 成功登录系统','superadmin','218.90.160.146','2016-12-27 17:12:49 049','系统登录','LogService'),
('2c91647d593af28c01593f8dd4b60084',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.90.160.146','2016-12-27 17:12:56 056','系统异常','LogService'),
('2c91647d593af28c01593f8dd5b70085',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.90.160.146','2016-12-27 17:12:57 057','系统异常','LogService'),
('2c91647d593af28c01593f8e0e4c0086',1,'切换布局：[layout: ${layout}]','superadmin','218.90.160.146','2016-12-27 17:13:11 011','系统首页','LogService'),
('2c91647d593af28c01593f8e8dde0087',1,'切换布局：[layout: ${layout}]','superadmin','112.199.123.100','2016-12-27 17:13:44 044','系统首页','LogService'),
('2c91647d593af28c01593f8e98a20088',1,'切换布局：[layout: ${layout}]','superadmin','112.199.123.100','2016-12-27 17:13:46 046','系统首页','LogService'),
('2c91647d593af28c01593f92aff50089',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','112.199.123.100','2016-12-27 17:18:15 015','请求出错','LogService'),
('2c91647d593af28c01593f92cfc8008a',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','112.199.123.100','2016-12-27 17:18:23 023','请求出错','LogService'),
('2c91647d593af28c01593f97d1a8008b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 17:23:51 051','登录系统','LogService'),
('2c91647d593af28c01593f98f433008c',1,'用户：[superadmin] 成功登录系统','superadmin','106.121.72.149','2016-12-27 17:25:05 005','系统登录','LogService'),
('2c91647d593af28c01593f991495008d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','106.121.72.149','2016-12-27 17:25:14 014','系统异常','LogService'),
('2c91647d593af28c01593f9f24eb008e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 17:31:51 051','登录系统','LogService'),
('2c91647d593af28c01593f9ffbf9008f',1,'锁定系统','superadmin','106.121.72.149','2016-12-27 17:32:46 046','个人中心','LogService'),
('2c91647d593af28c01593fa0090e0090',1,'解锁系统','superadmin','106.121.72.149','2016-12-27 17:32:49 049','个人中心','LogService'),
('2c91647d593af28c01593fa027060091',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','106.121.72.149','2016-12-27 17:32:57 057','请求出错','LogService'),
('2c91647d593af28c01593fa027430092',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','106.121.72.149','2016-12-27 17:32:57 057','请求错误','LogService'),
('2c91647d593af28c01593fa083550093',1,'切换布局：[layout: ${layout}]','superadmin','106.121.72.149','2016-12-27 17:33:21 021','系统首页','LogService'),
('2c91647d593af28c01593fa17f0c0094',3,'org.hibernate.exception.SQLGrammarException: error executing work','superadmin','106.121.72.149','2016-12-27 17:34:25 025','请求出错','LogService'),
('2c91647d593af28c01593fab0ca20095',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 17:44:51 051','登录系统','LogService'),
('2c91647d593af28c01593fb609d00096',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 17:56:51 051','登录系统','LogService'),
('2c91647d593af28c01593fb9696f0097',1,'用户：[superadmin] 成功登录系统','superadmin','124.65.231.110','2016-12-27 18:00:32 032','系统登录','LogService'),
('2c91647d593af28c01593fb986700098',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.65.231.110','2016-12-27 18:00:40 040','系统异常','LogService'),
('2c91647d593af28c01593fb989960099',1,'切换布局：[layout: ${layout}]','superadmin','124.65.231.110','2016-12-27 18:00:41 041','系统首页','LogService'),
('2c91647d593af28c01593fbd5dda009a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 18:04:52 052','登录系统','LogService'),
('2c91647d593af28c01593fc486e1009b',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-27 18:12:41 041','系统异常','LogService'),
('2c91647d593af28c01593fd7ebd9009c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 18:33:52 052','登录系统','LogService'),
('2c91647d593af28c01593ff4a240009d',3,'错误代码:404，访问路径:/manager/html','system','114.215.159.6','2016-12-27 19:05:14 014','系统异常','LogService'),
('2c91647d593af28c01594092137e009e',1,'用户：[superadmin] 成功登录系统','superadmin','114.249.239.18','2016-12-27 21:57:12 012','系统登录','LogService'),
('2c91647d593af28c0159409467d7009f',1,'用户：[superadmin] 退出系统','superadmin','114.249.239.18','2016-12-27 21:59:44 044','退出系统','LogService'),
('2c91647d593af28c015940a3d06e00a0',3,'错误代码:404，访问路径:/axis2','system','211.147.118.94','2016-12-27 22:16:34 034','系统异常','LogService'),
('2c91647d593af28c015940c1f3a800a1',1,'用户：[superadmin] 成功登录系统','superadmin','27.46.5.223','2016-12-27 22:49:29 029','系统登录','LogService'),
('2c91647d593af28c015940c22ef500a2',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.250.255.109','2016-12-27 22:49:44 044','系统异常','LogService'),
('2c91647d593af28c015940db04f100a3',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-27 23:16:52 052','系统异常','LogService'),
('2c91647d593af28c015940deb45a00a4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-27 23:20:54 054','登录系统','LogService'),
('2c91647d593af28c0159410cfbdc00a5',1,'用户：[superadmin] 成功登录系统','superadmin','58.244.246.106','2016-12-28 00:11:27 027','系统登录','LogService'),
('2c91647d593af28c0159410d1a3a00a6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.244.246.106','2016-12-28 00:11:34 034','系统异常','LogService'),
('2c91647d593af28c01594129c94400a7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 00:42:54 054','登录系统','LogService'),
('2c91647d593af28c01594149320200a8',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.69.128','2016-12-28 01:17:13 013','系统异常','LogService'),
('2c91647d593af28c0159415ba0de00a9',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','94.102.49.174','2016-12-28 01:37:21 021','系统异常','LogService'),
('2c91647d593af28c015941a694ab00aa',3,'错误代码:404，访问路径:/show.html','system','123.56.155.154','2016-12-28 02:59:13 013','系统异常','LogService'),
('2c91647d593af28c015941cd4f5300ab',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2016-12-28 03:41:31 031','系统异常','LogService'),
('2c91647d593af28c015942b7cf4400ac',1,'用户：[superadmin] 成功登录系统','superadmin','222.248.36.56','2016-12-28 07:57:39 039','系统登录','LogService'),
('2c91647d593af28c015942b7ede200ad',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.248.36.56','2016-12-28 07:57:47 047','系统异常','LogService'),
('2c91647d593af28c015942dadedf00ae',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 08:35:57 057','登录系统','LogService'),
('2c91647d593af28c015942f5ba7600af',1,'用户：[superadmin] 成功登录系统','superadmin','113.128.218.58','2016-12-28 09:05:17 017','系统登录','LogService'),
('2c91647d593af28c015942f5de0900b0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.128.218.58','2016-12-28 09:05:26 026','系统异常','LogService'),
('2c91647d593af28c015942fbf66300b1',1,'用户：[superadmin] 成功登录系统','superadmin','117.141.114.158','2016-12-28 09:12:05 005','系统登录','LogService'),
('2c91647d593af28c015942fc133600b2',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.141.114.158','2016-12-28 09:12:13 013','系统异常','LogService'),
('2c91647d593af28c01594302488500b3',1,'用户：[superadmin] 成功登录系统','superadmin','180.213.74.30','2016-12-28 09:19:00 000','系统登录','LogService'),
('2c91647d593af28c0159430295c300b4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','180.213.74.30','2016-12-28 09:19:20 020','系统异常','LogService'),
('2c91647d593af28c01594302c2d400b5',1,'切换布局：[layout: ${layout}]','superadmin','180.213.74.30','2016-12-28 09:19:31 031','系统首页','LogService'),
('2c91647d593af28c0159430b411400b6',1,'切换布局：[layout: ${layout}]','superadmin','180.213.74.30','2016-12-28 09:28:48 048','系统首页','LogService'),
('2c91647d593af28c01594312b9f700b7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 09:36:57 057','登录系统','LogService'),
('2c91647d593af28c0159431a0db600b8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 09:44:58 058','登录系统','LogService'),
('2c91647d593af28c015943271d5100b9',1,'用户：[superadmin] 成功登录系统','superadmin','103.30.97.114','2016-12-28 09:59:14 014','系统登录','LogService'),
('2c91647d593af28c015943273abc00ba',3,'错误代码:404，访问路径:/favicon.ico','superadmin','103.30.97.114','2016-12-28 09:59:21 021','系统异常','LogService'),
('2c91647d593af28c01594327c9ad00bb',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 09:59:58 058','登录系统','LogService'),
('2c91647d593af28c015943288f7000bc',3,'org.hibernate.exception.SQLGrammarException: error executing work','superadmin','103.30.97.114','2016-12-28 10:00:48 048','请求出错','LogService'),
('2c91647d593af28c01594328cbaa00bd',1,'切换布局：[layout: ${layout}]','superadmin','103.30.97.114','2016-12-28 10:01:04 004','系统首页','LogService'),
('2c91647d593af28c0159432c7d3b00be',1,'用户：[superadmin] 成功登录系统','superadmin','111.121.116.18','2016-12-28 10:05:06 006','系统登录','LogService'),
('2c91647d593af28c0159432ca1ca00bf',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.121.116.18','2016-12-28 10:05:15 015','系统异常','LogService'),
('2c91647d593af28c01594342f06b00c0',1,'用户：[superadmin] 成功登录系统','superadmin','116.228.89.206','2016-12-28 10:29:37 037','系统登录','LogService'),
('2c91647d593af28c015943430fcc00c1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.228.89.206','2016-12-28 10:29:45 045','系统异常','LogService'),
('2c91647d593af28c01594345147b00c2',1,'切换布局：[layout: ${layout}]','superadmin','116.228.89.206','2016-12-28 10:31:57 057','系统首页','LogService'),
('2c91647d593af28c01594345167500c3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 10:31:58 058','登录系统','LogService'),
('2c91647d593af28c015943457ea900c4',1,'切换布局：[layout: ${layout}]','superadmin','116.228.89.206','2016-12-28 10:32:25 025','系统首页','LogService'),
('2c91647d593af28c01594348c01600c5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 10:35:58 058','登录系统','LogService'),
('2c91647d593af28c01594364388a00c6',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 11:05:58 058','登录系统','LogService'),
('2c91647d593af28c0159436698be00c7',1,'用户：[superadmin] 成功登录系统','superadmin','36.251.248.177','2016-12-28 11:08:34 034','系统登录','LogService'),
('2c91647d593af28c015943669f4a00c8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.251.248.177','2016-12-28 11:08:36 036','系统异常','LogService'),
('2c91647d593af28c01594366e38200c9',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','36.251.248.177','2016-12-28 11:08:53 053','请求出错','LogService'),
('2c91647d593af28c01594366fea900ca',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','36.251.248.177','2016-12-28 11:09:00 000','请求出错','LogService'),
('2c91647d593af28c0159437afd7500cb',3,'错误代码:404，访问路径:/nice ports,/Trinity.txt.bak','system','43.241.237.140','2016-12-28 11:30:50 050','系统异常','LogService'),
('2c91647d593af28c015943835a8400cc',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 11:39:58 058','登录系统','LogService'),
('2c91647d593af28c015943c08b3d00cd',1,'用户：[superadmin] 成功登录系统','superadmin','119.136.233.59','2016-12-28 12:46:49 049','系统登录','LogService'),
('2c91647d593af28c015943c0b50e00ce',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.136.233.59','2016-12-28 12:46:59 059','系统异常','LogService'),
('2c91647d593af28c015943c0b63a00cf',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.136.233.59','2016-12-28 12:47:00 000','系统异常','LogService'),
('2c91647d593af28c015943ce887800d0',1,'用户：[superadmin] 成功登录系统','superadmin','120.42.36.66','2016-12-28 13:02:05 005','系统登录','LogService'),
('2c91647d593af28c015943cea5d400d1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','120.42.36.66','2016-12-28 13:02:13 013','系统异常','LogService'),
('2c91647d593af28c015943cea76000d2',3,'错误代码:404，访问路径:/favicon.ico','superadmin','120.42.36.66','2016-12-28 13:02:13 013','系统异常','LogService'),
('2c91647d593af28c015943da9bb500d3',1,'用户：[superadmin] 成功登录系统','superadmin','180.166.124.254','2016-12-28 13:15:17 017','系统登录','LogService'),
('2c91647d593af28c015943dd15d200d4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 13:17:59 059','登录系统','LogService'),
('2c91647d593af28c015943eca69a00d5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 13:34:59 059','登录系统','LogService'),
('2c91647d593af28c0159440909ae00d6',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-28 14:06:00 000','登录系统','LogService'),
('2c91647d593af28c0159440afa1f00d7',1,'用户：[superadmin] 成功登录系统','superadmin','112.53.82.55','2016-12-28 14:08:07 007','系统登录','LogService'),
('2c91647d593af28c0159440b5ab800d8',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:08:31 031','请求出错','LogService'),
('2c91647d593af28c0159440b5ac000d9',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:08:31 031','请求错误','LogService'),
('2c91647d593af28c0159440b90c600da',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.53.82.55','2016-12-28 14:08:45 045','系统异常','LogService'),
('2c91647d593af28c0159440be1a000db',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:09:06 006','请求出错','LogService'),
('2c91647d593af28c0159440be1a400dc',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:09:06 006','请求出错','LogService'),
('2c91647d593af28c0159440be2b100dd',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:09:06 006','请求出错','LogService'),
('2c91647d593af28c0159440be2d000de',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:09:06 006','请求错误','LogService'),
('2c91647d593af28c0159440be2d500df',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:09:06 006','请求错误','LogService'),
('2c91647d593af28c0159440be2d700e0',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketTimeoutException','superadmin','112.53.82.55','2016-12-28 14:09:06 006','请求错误','LogService'),
('2c91647d593af28c01594423ee3000e1',1,'用户：[superadmin] 成功登录系统','superadmin','36.251.248.177','2016-12-28 14:35:22 022','系统登录','LogService'),
('2c91647d593af28c015944277a4e00e2',1,'用户：[superadmin] 成功登录系统','superadmin','171.221.129.18','2016-12-28 14:39:15 015','系统登录','LogService'),
('2c91647d594fedd001594ff0243b0000',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.144.79','2016-12-30 21:34:15 015','系统登录','LogService'),
('2c91647d594fedd001594ff0308c0001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.144.79','2016-12-30 21:34:18 018','系统异常','LogService'),
('2c91647d594fedd001594ff3a3760002',1,'锁定系统','superadmin','36.5.144.79','2016-12-30 21:38:04 004','个人中心','LogService'),
('2c91647d594fedd001594ff56f5c0003',1,'解锁系统','superadmin','36.5.144.79','2016-12-30 21:40:02 002','个人中心','LogService'),
('2c91647d594fedd00159501165110004',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-30 22:10:34 034','登录系统','LogService'),
('2c91647d594fedd00159502ec9910005',3,'错误代码:404，访问路径:/manager/html','system','120.25.195.181','2016-12-30 22:42:40 040','系统异常','LogService'),
('2c91647d594fedd00159507fc0ff0006',1,'用户：[superadmin] 成功登录系统','superadmin','115.212.105.84','2016-12-31 00:11:06 006','系统登录','LogService'),
('2c91647d594fedd00159507fe1db0007',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.212.105.84','2016-12-31 00:11:15 015','系统异常','LogService'),
('2c91647d594fedd0015950813f790008',3,'错误代码:404，访问路径:/show.html','system','123.56.155.154','2016-12-31 00:12:44 044','系统异常','LogService'),
('2c91647d594fedd0015950a03ba80009',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 00:46:35 035','登录系统','LogService'),
('2c91647d594fedd001595179b605000a',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-31 04:44:08 008','系统异常','LogService'),
('2c91647d594fedd00159523a47a8000b',3,'错误代码:404，访问路径:/myiphb.php','system','37.26.138.104','2016-12-31 08:14:28 028','系统异常','LogService'),
('2c91647d594fedd00159528095fe000c',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','94.102.49.174','2016-12-31 09:31:15 015','系统异常','LogService'),
('2c91647d594fedd001595286c666000d',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.187.149','2016-12-31 09:38:01 001','系统异常','LogService'),
('2c91647d594fedd0015953733121000e',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-31 13:56:15 015','系统异常','LogService'),
('2c91647d594fedd0015953ed864a000f',1,'用户：[superadmin] 成功登录系统','superadmin','116.2.140.131','2016-12-31 16:09:52 052','系统登录','LogService'),
('2c91647d594fedd0015953f191710010',1,'切换布局：[layout: ${layout}]','superadmin','116.2.140.131','2016-12-31 16:14:17 017','系统首页','LogService'),
('2c91647d594fedd0015953f9dac70011',3,'错误代码:404，访问路径:/\'+ s.iframeSrc +\'','system','119.147.146.60','2016-12-31 16:23:20 020','系统异常','LogService'),
('2c91647d594fedd00159540d641f0012',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 16:44:40 040','登录系统','LogService'),
('2c91647d594fedd00159541dc1f60013',1,'用户：[superadmin] 成功登录系统','superadmin','115.235.111.141','2016-12-31 17:02:33 033','系统登录','LogService'),
('2c91647d594fedd00159541de0260014',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.235.111.141','2016-12-31 17:02:41 041','系统异常','LogService'),
('2c91647d594fedd00159543fc1bb0015',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 17:39:41 041','登录系统','LogService'),
('2c91647d594fedd00159544e27b70016',3,'错误代码:404，访问路径:/manager/html','system','120.25.195.181','2016-12-31 17:55:25 025','系统异常','LogService'),
('2c91647d594fedd0015954d3f4fd0017',3,'错误代码:404，访问路径:/manager/html','system','139.196.139.161','2016-12-31 20:21:34 034','系统异常','LogService'),
('2c91647d594fedd0015955203e200018',3,'错误代码:404，访问路径:/favicon.ico','system','171.44.170.252','2016-12-31 21:44:53 053','系统异常','LogService'),
('2c91647d594fedd001595520a1200019',1,'用户：[superadmin] 成功登录系统','superadmin','171.44.170.252','2016-12-31 21:45:18 018','系统登录','LogService'),
('2c91647d594fedd001595520ff34001a',1,'切换布局：[layout: ${layout}]','superadmin','171.44.170.252','2016-12-31 21:45:42 042','系统首页','LogService'),
('2c91647d594fedd001595535c094001b',1,'用户：[superadmin] 成功登录系统','superadmin','116.2.140.131','2016-12-31 22:08:23 023','系统登录','LogService'),
('2c91647d594fedd001595535d657001c',1,'用户：[superadmin] 成功登录系统','superadmin','123.191.161.12','2016-12-31 22:08:28 028','系统登录','LogService'),
('2c91647d594fedd001595535daa0001d',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.176.108','2016-12-31 22:08:29 029','系统登录','LogService'),
('2c91647d594fedd0015955360876001e',1,'用户：[superadmin] 成功登录系统','superadmin','59.46.57.38','2016-12-31 22:08:41 041','系统登录','LogService'),
('2c91647d594fedd0015955362894001f',1,'用户：[superadmin] 成功登录系统','superadmin','116.2.140.131','2016-12-31 22:08:49 049','系统登录','LogService'),
('2c91647d594fedd0015955362f8a0020',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.191.161.12','2016-12-31 22:08:51 051','系统异常','LogService'),
('2c91647d594fedd001595536f76b0021',1,'用户：[superadmin] 成功登录系统','superadmin','113.232.181.83','2016-12-31 22:09:42 042','系统登录','LogService'),
('2c91647d594fedd00159553d61b20022',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:16:43 043','登录系统','LogService'),
('2c91647d594fedd00159555186770023',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:38:43 043','登录系统','LogService'),
('2c91647d594fedd00159555270f10024',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:39:43 043','登录系统','LogService'),
('2c91647d594fedd00159555271300025',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:39:43 043','登录系统','LogService'),
('2c91647d594fedd0015955535bad0026',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:40:43 043','登录系统','LogService'),
('2c91647d594fedd0015955535be00027',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:40:43 043','登录系统','LogService'),
('2c91647d594fedd001595554465b0028',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-31 22:41:43 043','登录系统','LogService'),
('2c91647d594fedd0015955b9a2c70029',3,'错误代码:404，访问路径:/script','system','114.215.103.153','2017-01-01 00:32:26 026','系统异常','LogService'),
('2c91647d594fedd0015955bb0874002a',3,'错误代码:404，访问路径:/script','system','118.184.35.43','2017-01-01 00:33:57 057','系统异常','LogService'),
('2c91647d594fedd00159568e9b78002b',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2017-01-01 04:25:03 003','系统异常','LogService'),
('2c91647d594fedd0015956ece615002c',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.188.118','2017-01-01 06:08:03 003','系统异常','LogService'),
('2c91647d594fedd00159570a0dad002d',3,'错误代码:404，访问路径:/favicon.ico','system','103.37.148.222','2017-01-01 06:39:53 053','系统异常','LogService'),
('2c91647d594fedd0015958243f52002e',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2017-01-01 11:48:07 007','系统异常','LogService'),
('2c91647d594fedd00159587173be002f',3,'错误代码:404，访问路径:/manager/html','system','139.196.139.161','2017-01-01 13:12:27 027','系统异常','LogService'),
('2c91647d594fedd001595902416f0030',1,'用户：[superadmin] 成功登录系统','superadmin','218.82.182.177','2017-01-01 15:50:37 037','系统登录','LogService'),
('2c91647d594fedd00159590251550031',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.82.182.177','2017-01-01 15:50:41 041','系统异常','LogService'),
('2c91647d594fedd00159591eda580032',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-01 16:21:51 051','登录系统','LogService'),
('2c91647d594fedd0015959e5cd710033',3,'错误代码:404，访问路径:/manager/html','system','120.25.195.181','2017-01-01 19:59:09 009','系统异常','LogService'),
('2c91647d594fedd0015959f914be0034',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.187.160','2017-01-01 20:20:13 013','系统异常','LogService'),
('2c91647d594fedd001595a0e77c00035',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2017-01-01 20:43:34 034','系统异常','LogService'),
('2c91647d594fedd001595a5620db0036',1,'用户：[superadmin] 成功登录系统','superadmin','223.20.151.55','2017-01-01 22:01:51 051','系统登录','LogService'),
('2c91647d594fedd001595a563c3c0037',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.20.151.55','2017-01-01 22:01:58 058','系统异常','LogService'),
('2c91647d594fedd001595a728dd30038',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-01 22:32:53 053','登录系统','LogService'),
('2c91647d594fedd001595a7b23f60039',1,'用户：[superadmin] 成功登录系统','superadmin','115.195.183.224','2017-01-01 22:42:16 016','系统登录','LogService'),
('2c91647d594fedd001595a981826003a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-01 23:13:54 054','登录系统','LogService'),
('2c91647d594fedd001595bb26c66003b',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2017-01-02 04:22:16 016','系统异常','LogService'),
('2c91647d594fedd001595c22028c003c',3,'错误代码:404，访问路径:/favicon.ico','system','120.132.60.88','2017-01-02 06:24:09 009','系统异常','LogService'),
('2c91647d594fedd001595c986dda003d',1,'用户：[superadmin] 成功登录系统','superadmin','116.238.110.8','2017-01-02 08:33:30 030','系统登录','LogService'),
('2c91647d594fedd001595c988aa8003e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.238.110.8','2017-01-02 08:33:37 037','系统异常','LogService'),
('2c91647d594fedd001595c98e3d5003f',1,'切换布局：[layout: ${layout}]','superadmin','116.238.110.8','2017-01-02 08:34:00 000','系统首页','LogService'),
('2c91647d594fedd001595c99142f0040',3,'错误代码:404，访问路径:/open/doc','superadmin','116.238.110.8','2017-01-02 08:34:13 013','系统异常','LogService'),
('2c91647d594fedd001595c995a580041',3,'错误代码:404，访问路径:/open/doc','system','180.153.212.13','2017-01-02 08:34:31 031','系统异常','LogService'),
('2c91647d594fedd001595c995ea70042',3,'错误代码:404，访问路径:/open/doc','system','101.226.33.219','2017-01-02 08:34:32 032','系统异常','LogService'),
('2c91647d594fedd001595cb53d120043',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-02 09:04:58 058','登录系统','LogService'),
('2c91647d594fedd001595ce0ca0e0044',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2017-01-02 09:52:32 032','系统异常','LogService'),
('2c91647d594fedd001595d6304400045',3,'错误代码:404，访问路径:/script','system','115.29.234.54','2017-01-02 12:14:47 047','系统异常','LogService'),
('2c91647d594fedd001595dc7d1910046',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.145.230','2017-01-02 14:04:53 053','系统登录','LogService'),
('2c91647d594fedd001595dc7e5d90047',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.145.230','2017-01-02 14:04:58 058','系统异常','LogService'),
('2c91647d594fedd001595de44e230048',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-02 14:36:00 000','登录系统','LogService'),
('2c91647d594fedd001595e268e790049',1,'用户：[superadmin] 成功登录系统','superadmin','182.245.86.183','2017-01-02 15:48:22 022','系统登录','LogService'),
('2c91647d594fedd001595e26adaf004a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.245.86.183','2017-01-02 15:48:30 030','系统异常','LogService'),
('2c91647d594fedd001595e274716004b',1,'切换布局：[layout: ${layout}]','superadmin','182.245.86.183','2017-01-02 15:49:09 009','系统首页','LogService'),
('2c91647d594fedd001595e438807004c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-02 16:20:01 001','登录系统','LogService'),
('2c91647d594fedd001595e476362004d',3,'错误代码:404，访问路径:/manager/html','system','120.25.195.181','2017-01-02 16:24:13 013','系统异常','LogService'),
('2c91647d594fedd001595e5ed365004e',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.234.10','2017-01-02 16:49:49 049','系统登录','LogService'),
('2c91647d594fedd001595e5ef6a2004f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.191.234.10','2017-01-02 16:49:58 058','系统异常','LogService'),
('2c91647d594fedd001595e6071e20050',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','60.191.234.10','2017-01-02 16:51:36 036','请求出错','LogService'),
('2c91647d594fedd001595e60ca540051',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','60.191.234.10','2017-01-02 16:51:58 058','请求出错','LogService'),
('2c91647d594fedd001595e7a357d0052',1,'用户：[superadmin] 成功登录系统','superadmin','182.107.47.162','2017-01-02 17:19:44 044','系统登录','LogService'),
('2c91647d594fedd001595e7a52a30053',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.107.47.162','2017-01-02 17:19:51 051','系统异常','LogService'),
('2c91647d594fedd001595e7a90470054',1,'切换布局：[layout: ${layout}]','superadmin','182.107.47.162','2017-01-02 17:20:07 007','系统首页','LogService'),
('2c91647d594fedd001595e7d37b10055',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-02 17:23:01 001','登录系统','LogService'),
('2c91647d594fedd001595e96dae00056',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-02 17:51:01 001','登录系统','LogService'),
('2c91647d594fedd001595efe2a290057',3,'错误代码:404，访问路径:/script','system','115.29.234.54','2017-01-02 19:43:52 052','系统异常','LogService'),
('2c91647d594fedd001595f04f4560058',3,'错误代码:404，访问路径:/robots.txt','system','66.249.75.9','2017-01-02 19:51:17 017','系统异常','LogService'),
('2c91647d594fedd001595f555fc30059',3,'错误代码:404，访问路径:/show.html','system','123.56.155.154','2017-01-02 21:19:07 007','系统异常','LogService'),
('2c91647d594fedd001595f5d1f19005a',1,'用户：[superadmin] 成功登录系统','superadmin','118.81.25.80','2017-01-02 21:27:35 035','系统登录','LogService'),
('2c91647d594fedd001595f5d3bb5005b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.81.25.80','2017-01-02 21:27:42 042','系统异常','LogService'),
('2c91647d594fedd001595f7ad7d7005c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-02 22:00:03 003','登录系统','LogService'),
('2c91647d594fedd001595fcd472c005d',3,'错误代码:404，访问路径:/cgi/common.cgi','system','187.21.172.41','2017-01-02 23:30:05 005','系统异常','LogService'),
('2c91647d594fedd001595fcd4b04005e',3,'错误代码:404，访问路径:/stssys.htm','system','187.21.172.41','2017-01-02 23:30:06 006','系统异常','LogService'),
('2c91647d594fedd001595fcd52af005f',3,'错误代码:404，访问路径:/command.php','system','187.21.172.41','2017-01-02 23:30:08 008','系统异常','LogService'),
('2c91647d594fedd00159602035a10060',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2017-01-03 01:00:40 040','系统异常','LogService'),
('2c91647d594fedd00159602643230061',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.187.155','2017-01-03 01:07:17 017','系统异常','LogService'),
('2c91647d594fedd0015960c40cfd0062',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2017-01-03 03:59:38 038','系统异常','LogService'),
('2c91647d594fedd0015961a1c6290063',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2017-01-03 08:01:49 049','系统异常','LogService'),
('2c91647d594fedd0015961eff1a80064',1,'用户：[superadmin] 成功登录系统','superadmin','110.84.115.154','2017-01-03 09:27:12 012','系统登录','LogService'),
('2c91647d594fedd0015961f010720065',3,'错误代码:404，访问路径:/favicon.ico','superadmin','110.84.115.154','2017-01-03 09:27:19 019','系统异常','LogService'),
('2c91647d594fedd0015961f0276a0066',1,'切换布局：[layout: ${layout}]','superadmin','110.84.115.154','2017-01-03 09:27:25 025','系统首页','LogService'),
('2c91647d594fedd0015961f033620067',1,'切换布局：[layout: ${layout}]','superadmin','110.84.115.154','2017-01-03 09:27:28 028','系统首页','LogService'),
('2c91647d594fedd00159620d2d770068',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 09:59:07 007','登录系统','LogService'),
('2c91647d594fedd00159626cd6b80069',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','163.172.173.181','2017-01-03 11:43:37 037','系统异常','LogService'),
('2c91647d594fedd001596297bd8b006a',3,'错误代码:404，访问路径:/favicon.ico','system','115.236.42.130','2017-01-03 12:30:28 028','系统异常','LogService'),
('2c91647d594fedd0015962ca4e2f006b',1,'用户：[superadmin] 成功登录系统','superadmin','223.11.212.96','2017-01-03 13:25:42 042','系统登录','LogService'),
('2c91647d594fedd0015962ca69d7006c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.11.212.96','2017-01-03 13:25:49 049','系统异常','LogService'),
('2c91647d594fedd0015962cb2947006d',1,'切换布局：[layout: ${layout}]','superadmin','223.11.212.96','2017-01-03 13:26:38 038','系统首页','LogService'),
('2c91647d594fedd0015962cb914e006e',1,'切换布局：[layout: ${layout}]','superadmin','223.11.212.96','2017-01-03 13:27:05 005','系统首页','LogService'),
('2c91647d594fedd0015962e0a056006f',3,'错误代码:404，访问路径:/myiphc.php','system','95.153.122.183','2017-01-03 13:50:05 005','系统异常','LogService'),
('2c91647d594fedd0015962e0a3070070',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-03 13:50:06 006','系统异常','LogService'),
('2c91647d594fedd0015962e0a5a60071',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-03 13:50:06 006','系统异常','LogService'),
('2c91647d594fedd0015962e33b040072',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.69.128','2017-01-03 13:52:56 056','系统异常','LogService'),
('2c91647d594fedd0015962e805450073',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 13:58:09 009','登录系统','LogService'),
('2c91647d594fedd001596302e7a90074',3,'错误代码:404，访问路径:/robots.txt','system','66.249.79.83','2017-01-03 14:27:31 031','系统异常','LogService'),
('2c91647d594fedd001596313cd100075',1,'用户：[superadmin] 成功登录系统','superadmin','61.161.168.44','2017-01-03 14:45:59 059','系统登录','LogService'),
('2c91647d594fedd001596313e9580076',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.161.168.44','2017-01-03 14:46:06 006','系统异常','LogService'),
('2c91647d594fedd0015963305aac0077',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 15:17:10 010','登录系统','LogService'),
('2c91647d594fedd0015963609c8d0078',1,'用户：[superadmin] 成功登录系统','superadmin','125.65.97.92','2017-01-03 16:09:53 053','系统登录','LogService'),
('2c91647d594fedd001596360b9a10079',3,'错误代码:404，访问路径:/favicon.ico','superadmin','125.65.97.92','2017-01-03 16:10:00 000','系统异常','LogService'),
('2c91647d594fedd001596361dc18007a',1,'用户：[superadmin] 成功登录系统','superadmin','183.28.28.187','2017-01-03 16:11:14 014','系统登录','LogService'),
('2c91647d594fedd001596361f9c1007b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.28.28.187','2017-01-03 16:11:22 022','系统异常','LogService'),
('2c91647d594fedd00159636a12f0007c',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2017-01-03 16:20:13 013','系统登录','LogService'),
('2c91647d594fedd00159636a2f0f007d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2017-01-03 16:20:20 020','系统异常','LogService'),
('2c91647d594fedd00159637d43dc007e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 16:41:10 010','登录系统','LogService'),
('2c91647d594fedd00159637f18bc007f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 16:43:10 010','登录系统','LogService'),
('2c91647d594fedd00159639168ab0080',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 17:03:11 011','登录系统','LogService'),
('2c91647d594fedd0015963accc4d0081',3,'错误代码:404，访问路径:/favicon.ico','system','115.236.42.130','2017-01-03 17:33:05 005','系统异常','LogService'),
('2c91647d594fedd0015963e4e8590082',3,'错误代码:404，访问路径:/script','system','218.93.205.112','2017-01-03 18:34:23 023','系统异常','LogService'),
('2c91647d594fedd0015963fab3f90083',3,'错误代码:404，访问路径:/favicon.ico','system','125.118.132.86','2017-01-03 18:58:11 011','系统异常','LogService'),
('2c91647d594fedd00159644a8edd0084',1,'用户：[superadmin] 成功登录系统','superadmin','106.39.84.163','2017-01-03 20:25:24 024','系统登录','LogService'),
('2c91647d594fedd00159644aaeff0085',3,'错误代码:404，访问路径:/favicon.ico','superadmin','106.39.84.163','2017-01-03 20:25:33 033','系统异常','LogService'),
('2c91647d594fedd00159644ab6710086',1,'切换布局：[layout: ${layout}]','superadmin','106.39.84.163','2017-01-03 20:25:35 035','系统首页','LogService'),
('2c91647d594fedd00159644ee9470087',1,'用户：[superadmin] 成功登录系统','superadmin','219.143.248.173','2017-01-03 20:30:10 010','系统登录','LogService'),
('2c91647d594fedd00159644f05fd0088',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.143.248.173','2017-01-03 20:30:17 017','系统异常','LogService'),
('2c91647d594fedd001596466c1130089',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 20:56:12 012','登录系统','LogService'),
('2c91647d594fedd00159646b556f008a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 21:01:12 012','登录系统','LogService'),
('2c91647d594fedd00159646f96c9008b',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-03 21:05:51 051','系统异常','LogService'),
('2c91647d594fedd0015964916217008c',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-03 21:42:46 046','系统异常','LogService'),
('2c91647d594fedd0015964c5fe8b008d',1,'用户：[superadmin] 成功登录系统','superadmin','113.120.82.98','2017-01-03 22:40:14 014','系统登录','LogService'),
('2c91647d594fedd0015964e25d0f008e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-03 23:11:13 013','登录系统','LogService'),
('2c91647d594fedd00159650bab5f008f',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-03 23:56:20 020','系统异常','LogService'),
('2c91647d594fedd00159654c6b890090',3,'错误代码:404，访问路径:/manager/html','system','114.215.78.59','2017-01-04 01:07:04 004','系统异常','LogService'),
('2c91647d594fedd00159654fd21f0091',3,'错误代码:404，访问路径:/favicon.ico','system','203.208.60.206','2017-01-04 01:10:47 047','系统异常','LogService'),
('2c91647d594fedd00159662c1cd90092',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2017-01-04 05:11:24 024','系统异常','LogService'),
('2c91647d594fedd00159663062310093',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2017-01-04 05:16:04 004','系统异常','LogService'),
('2c91647d594fedd00159664ee96a0094',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-04 05:49:24 024','系统异常','LogService'),
('2c91647d594fedd00159666c32140095',3,'错误代码:404，访问路径:/phpmyadmin/index.php','system','101.201.237.213','2017-01-04 06:21:23 023','系统异常','LogService'),
('2c91647d594fedd0015966841c6f0096',3,'错误代码:404，访问路径:/phpmyadmin/index.php','system','101.201.237.213','2017-01-04 06:47:31 031','系统异常','LogService'),
('2c91647d594fedd0015966f373df0097',3,'错误代码:404，访问路径:/phpmyadmin/index.php','system','112.74.202.226','2017-01-04 08:49:08 008','系统异常','LogService'),
('2c91647d594fedd001596701166b0098',3,'错误代码:404，访问路径:/robots.txt','system','203.208.60.206','2017-01-04 09:04:01 001','系统异常','LogService'),
('2c91647d594fedd00159670117060099',3,'错误代码:404，访问路径:/mobile/','system','203.208.60.206','2017-01-04 09:04:01 001','系统异常','LogService'),
('2c91647d594fedd0015967017b47009a',3,'错误代码:404，访问路径:/favicon.ico','system','115.236.42.130','2017-01-04 09:04:27 027','系统异常','LogService'),
('2c91647d594fedd00159676d6634009b',1,'用户：[superadmin] 成功登录系统','superadmin','113.240.251.178','2017-01-04 11:02:19 019','系统登录','LogService'),
('2c91647d594fedd00159676d904e009c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.240.251.178','2017-01-04 11:02:30 030','系统异常','LogService'),
('2c91647d594fedd00159678c7c6c009d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 11:36:17 017','登录系统','LogService'),
('2c91647d594fedd0015967a62741009e',1,'用户：[superadmin] 成功登录系统','superadmin','60.14.99.2','2017-01-04 12:04:19 019','系统登录','LogService'),
('2c91647d594fedd0015967a6477f009f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.14.99.2','2017-01-04 12:04:27 027','系统异常','LogService'),
('2c91647d594fedd0015967aae04300a0',1,'用户：[superadmin] 成功登录系统','superadmin','115.192.115.112','2017-01-04 12:09:28 028','系统登录','LogService'),
('2c91647d594fedd0015967aafd0700a1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.192.115.112','2017-01-04 12:09:36 036','系统异常','LogService'),
('2c91647d594fedd0015967c5413d00a2',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 12:38:17 017','登录系统','LogService'),
('2c91647d594fedd0015967c7164c00a3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 12:40:17 017','登录系统','LogService'),
('2c91647d594fedd0015967f9f9d100a4',1,'用户：[superadmin] 成功登录系统','superadmin','42.243.52.15','2017-01-04 13:35:52 052','系统登录','LogService'),
('2c91647d594fedd0015967fa1d7000a5',3,'错误代码:404，访问路径:/favicon.ico','superadmin','42.243.52.15','2017-01-04 13:36:01 001','系统异常','LogService'),
('2c91647d594fedd0015967fa1e6a00a6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','42.243.52.15','2017-01-04 13:36:02 002','系统异常','LogService'),
('2c91647d594fedd0015967fc264400a8',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','42.243.52.15','2017-01-04 13:38:15 015','请求出错','LogService'),
('2c91647d594fedd001596817a97e00a9',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 14:08:18 018','登录系统','LogService'),
('2c91647d594fedd00159683e1f3900aa',3,'错误代码:404，访问路径:/script','system','211.147.112.5','2017-01-04 14:50:18 018','系统异常','LogService'),
('2c91647d594fedd001596860fe8b00ab',3,'错误代码:404，访问路径:/console/j_security_check','system','120.77.211.93','2017-01-04 15:28:24 024','系统异常','LogService'),
('2c91647d594fedd001596865c17500ac',1,'用户：[superadmin] 成功登录系统','superadmin','218.109.25.164','2017-01-04 15:33:36 036','系统登录','LogService'),
('2c91647d594fedd001596865dd9e00ad',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.109.25.164','2017-01-04 15:33:43 043','系统异常','LogService'),
('2c91647d594fedd0015968758f3a00ae',3,'错误代码:404，访问路径:/favicon.ico','system','61.161.158.202','2017-01-04 15:50:51 051','系统异常','LogService'),
('2c91647d594fedd001596875bd2d00af',1,'用户：[superadmin] 成功登录系统','superadmin','61.161.158.202','2017-01-04 15:51:03 003','系统登录','LogService'),
('2c91647d594fedd00159687657ab00b0',1,'切换布局：[layout: ${layout}]','superadmin','61.161.158.202','2017-01-04 15:51:43 043','系统首页','LogService'),
('2c91647d594fedd001596883b45f00b1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 16:06:18 018','登录系统','LogService'),
('2c91647d594fedd00159688621a200b2',1,'用户：[superadmin] 成功登录系统','superadmin','121.62.48.49','2017-01-04 16:08:58 058','系统登录','LogService'),
('2c91647d594fedd0015968863efa00b3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','121.62.48.49','2017-01-04 16:09:05 005','系统异常','LogService'),
('2c91647d594fedd00159688d811300b4',1,'用户：[superadmin] 成功登录系统','superadmin','182.242.230.106','2017-01-04 16:17:01 001','系统登录','LogService'),
('2c91647d594fedd00159688da19900b5',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.242.230.106','2017-01-04 16:17:09 009','系统异常','LogService'),
('2c91647d594fedd0015968922de900b6',1,'切换布局：[layout: ${layout}]','superadmin','182.242.230.106','2017-01-04 16:22:07 007','系统首页','LogService'),
('2c91647d594fedd0015968925ab100b7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 16:22:19 019','登录系统','LogService'),
('2c91647d594fedd00159689286ac00b8',1,'切换布局：[layout: ${layout}]','superadmin','182.242.230.106','2017-01-04 16:22:30 030','系统首页','LogService'),
('2c91647d594fedd001596892a57f00b9',1,'锁定系统','superadmin','182.242.230.106','2017-01-04 16:22:38 038','个人中心','LogService'),
('2c91647d594fedd001596892d24800ba',1,'解锁系统','superadmin','182.242.230.106','2017-01-04 16:22:49 049','个人中心','LogService'),
('2c91647d594fedd001596895c78700bb',1,'用户：[superadmin] 退出系统','superadmin','182.242.230.106','2017-01-04 16:26:03 003','退出系统','LogService'),
('2c91647d594fedd0015968a1ebbe00bc',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 16:39:19 019','登录系统','LogService'),
('2c91647d594fedd0015968ad0bd700bd',1,'用户：[superadmin] 成功登录系统','superadmin','115.231.66.170','2017-01-04 16:51:28 028','系统登录','LogService'),
('2c91647d594fedd0015968ad28fd00be',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.231.66.170','2017-01-04 16:51:35 035','系统异常','LogService'),
('2c91647d594fedd0015968ad31af00bf',1,'切换布局：[layout: ${layout}]','superadmin','115.231.66.170','2017-01-04 16:51:38 038','系统首页','LogService'),
('2c91647d594fedd0015968c94b3100c0',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 17:22:19 019','登录系统','LogService'),
('2c91647d594fedd0015969aee37600c1',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','172.82.166.210','2017-01-04 21:33:06 006','系统异常','LogService'),
('2c91647d594fedd0015969caaed200c2',1,'用户：[superadmin] 成功登录系统','superadmin','113.76.35.36','2017-01-04 22:03:27 027','系统登录','LogService'),
('2c91647d594fedd0015969cacaef00c3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.76.35.36','2017-01-04 22:03:35 035','系统异常','LogService'),
('2c91647d594fedd0015969cf468200c4',1,'切换布局：[layout: ${layout}]','superadmin','113.76.35.36','2017-01-04 22:08:28 028','系统首页','LogService'),
('2c91647d594fedd0015969eb8a9700c5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-04 22:39:21 021','登录系统','LogService'),
('2c91647d594fedd001596a304f4600c6',1,'用户：[superadmin] 成功登录系统','superadmin','223.73.57.192','2017-01-04 23:54:28 028','系统登录','LogService'),
('2c91647d594fedd001596a3077a900c7',1,'切换布局：[layout: ${layout}]','superadmin','223.73.57.192','2017-01-04 23:54:38 038','系统首页','LogService'),
('2c91647d594fedd001596a30b7ae00c8',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','223.73.57.192','2017-01-04 23:54:54 054','请求出错','LogService'),
('2c91647d594fedd001596a30d91600c9',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','223.73.57.192','2017-01-04 23:55:03 003','请求出错','LogService'),
('2c91647d594fedd001596a3176a400ca',1,'切换布局：[layout: ${layout}]','superadmin','223.73.57.192','2017-01-04 23:55:43 043','系统首页','LogService'),
('2c91647d594fedd001596a4d424100cb',1,'用户：[superadmin] 成功登录系统','superadmin','27.152.156.122','2017-01-05 00:26:05 005','系统登录','LogService'),
('2c91647d594fedd001596a4d666900cc',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.152.156.122','2017-01-05 00:26:14 014','系统异常','LogService'),
('2c91647d594fedd001596a4d82ab00cd',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 00:26:21 021','登录系统','LogService'),
('2c91647d594fedd001596a4df6c800ce',1,'切换布局：[layout: ${layout}]','superadmin','27.152.156.122','2017-01-05 00:26:51 051','系统首页','LogService'),
('2c91647d594fedd001596a4f19e600cf',1,'切换布局：[layout: ${layout}]','superadmin','27.152.156.122','2017-01-05 00:28:05 005','系统首页','LogService'),
('2c91647d594fedd001596a6bb9e800d0',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 00:59:21 021','登录系统','LogService'),
('2c91647d594fedd001596a7d916600d1',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-05 01:18:51 051','系统异常','LogService'),
('2c91647d594fedd001596a7d966000d2',3,'错误代码:404，访问路径:/myiphb.php','system','95.153.122.183','2017-01-05 01:18:52 052','系统异常','LogService'),
('2c91647d594fedd001596b2511bc00d3',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2017-01-05 04:21:48 048','系统异常','LogService'),
('2c91647d594fedd001596b828bab00d4',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2017-01-05 06:03:54 054','系统异常','LogService'),
('2c91647d594fedd001596becd03800d5',1,'用户：[superadmin] 成功登录系统','superadmin','218.82.182.177','2017-01-05 07:59:59 059','系统登录','LogService'),
('2c91647d594fedd001596becd61900d6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.82.182.177','2017-01-05 08:00:00 000','系统异常','LogService'),
('2c91647d594fedd001596bff36aa00d7',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.5','2017-01-05 08:20:04 004','系统登录','LogService'),
('2c91647d594fedd001596bff567a00d8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.85.244.5','2017-01-05 08:20:13 013','系统异常','LogService'),
('2c91647d594fedd001596bffc53900d9',1,'切换布局：[layout: ${layout}]','superadmin','223.85.244.5','2017-01-05 08:20:41 041','系统首页','LogService'),
('2c91647d594fedd001596c09947b00da',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 08:31:24 024','登录系统','LogService'),
('2c91647d594fedd001596c1be4c500db',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 08:51:24 024','登录系统','LogService'),
('2c91647d594fedd001596c44306b00dc',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','94.102.49.174','2017-01-05 09:35:25 025','系统异常','LogService'),
('2c91647d594fedd001596c45fcc800dd',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2017-01-05 09:37:23 023','系统异常','LogService'),
('2c91647d594fedd001596c6a358100de',1,'用户：[superadmin] 成功登录系统','superadmin','218.28.72.156','2017-01-05 10:16:56 056','系统登录','LogService'),
('2c91647d594fedd001596c6a618f00df',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.28.72.156','2017-01-05 10:17:08 008','系统异常','LogService'),
('2c91647d594fedd001596c6b22d100e0',1,'切换布局：[layout: ${layout}]','superadmin','218.28.72.156','2017-01-05 10:17:57 057','系统首页','LogService'),
('2c91647d594fedd001596c87efdb00e1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 10:49:25 025','登录系统','LogService'),
('2c91647d594fedd001596c8a007f00e2',1,'用户：[superadmin] 成功登录系统','superadmin','219.234.142.106','2017-01-05 10:51:40 040','系统登录','LogService'),
('2c91647d594fedd001596c8a481f00e3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.234.142.106','2017-01-05 10:51:58 058','系统异常','LogService'),
('2c91647d594fedd001596c8a497b00e4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.234.142.106','2017-01-05 10:51:59 059','系统异常','LogService'),
('2c91647d594fedd001596c97882500e5',1,'用户：[superadmin] 成功登录系统','superadmin','221.226.4.187','2017-01-05 11:06:27 027','系统登录','LogService'),
('2c91647d594fedd001596c97b15700e6',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:06:37 037','系统异常','LogService'),
('2c91647d594fedd001596c97cdca00e7',3,'错误代码:404，访问路径:/open/doc','superadmin','221.226.4.187','2017-01-05 11:06:45 045','系统异常','LogService'),
('2c91647d594fedd001596c98558400e8',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:07:19 019','系统异常','LogService'),
('2c91647d594fedd001596c98867b00e9',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:07:32 032','系统异常','LogService'),
('2c91647d594fedd001596c988a0d00ea',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:07:33 033','系统异常','LogService'),
('2c91647d594fedd001596c98c3c200eb',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:07:48 048','系统异常','LogService'),
('2c91647d594fedd001596c98e92a00ec',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:07:57 057','系统异常','LogService'),
('2c91647d594fedd001596c9997b600ed',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:08:42 042','系统异常','LogService'),
('2c91647d594fedd001596c999af500ee',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:08:43 043','系统异常','LogService'),
('2c91647d594fedd001596c99cfd000ef',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:08:56 056','系统异常','LogService'),
('2c91647d594fedd001596c9a18b200f1',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:15 015','系统异常','LogService'),
('2c91647d594fedd001596c9a486500f2',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:27 027','系统异常','LogService'),
('2c91647d594fedd001596c9a6fac00f3',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:37 037','系统异常','LogService'),
('2c91647d594fedd001596c9a72e400f4',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:38 038','系统异常','LogService'),
('2c91647d594fedd001596c9a88d700f5',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:44 044','系统异常','LogService'),
('2c91647d594fedd001596c9a8d9c00f6',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:45 045','系统异常','LogService'),
('2c91647d594fedd001596c9aa84b00f7',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:52 052','系统异常','LogService'),
('2c91647d594fedd001596c9aab1700f8',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:52 052','系统异常','LogService'),
('2c91647d594fedd001596c9ac4c100f9',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:09:59 059','系统异常','LogService'),
('2c91647d594fedd001596c9ac9ca00fa',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:10:00 000','系统异常','LogService'),
('2c91647d594fedd001596c9b2e5f00fb',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:10:26 026','系统异常','LogService'),
('2c91647d594fedd001596c9c451000fc',1,'用户：[superadmin] 成功登录系统','superadmin','139.189.67.41','2017-01-05 11:11:37 037','系统登录','LogService'),
('2c91647d594fedd001596c9c60de00fd',3,'错误代码:404，访问路径:/favicon.ico','superadmin','139.189.67.41','2017-01-05 11:11:44 044','系统异常','LogService'),
('2c91647d594fedd001596c9c785200fe',1,'切换布局：[layout: ${layout}]','superadmin','139.189.67.41','2017-01-05 11:11:50 050','系统首页','LogService'),
('2c91647d594fedd001596c9c88d300ff',1,'切换布局：[layout: ${layout}]','superadmin','139.189.67.41','2017-01-05 11:11:55 055','系统首页','LogService'),
('2c91647d594fedd001596c9cbe320100',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:12:08 008','系统异常','LogService'),
('2c91647d594fedd001596c9cedbe0101',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:12:20 020','系统异常','LogService'),
('2c91647d594fedd001596c9cf1490102',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:12:21 021','系统异常','LogService'),
('2c91647d594fedd001596c9cf3f80103',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:12:22 022','系统异常','LogService'),
('2c91647d594fedd001596c9cf6c60104',3,'错误代码:404，访问路径:/favicon.ico','system','221.226.4.187','2017-01-05 11:12:23 023','系统异常','LogService'),
('2c91647d594fedd001596ca711b30105',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 11:23:25 025','登录系统','LogService'),
('2c91647d594fedd001596cb37df20106',3,'错误代码:404，访问路径:/nice ports,/Trinity.txt.bak','system','123.151.93.104','2017-01-05 11:36:59 059','系统异常','LogService'),
('2c91647d594fedd001596cb8779f0107',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 11:42:25 025','登录系统','LogService'),
('2c91647d594fedd001596cb962100108',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 11:43:25 025','登录系统','LogService'),
('2c91647d594fedd001596cbc00580109',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 11:46:17 017','系统登录','LogService'),
('2c91647d594fedd001596cbcd57e010a',1,'用户：[superadmin] 成功登录系统','superadmin','113.76.3.39','2017-01-05 11:47:11 011','系统登录','LogService'),
('2c91647d594fedd001596cbcf7a1010b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.76.3.39','2017-01-05 11:47:20 020','系统异常','LogService'),
('2c91647d594fedd001596cbfe4b0010c',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 11:50:32 032','系统登录','LogService'),
('2c91647d594fedd001596cbfea28010d',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 11:50:33 033','系统登录','LogService'),
('2c91647d594fedd001596cc00d5f010e',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Connection reset by peer','superadmin','183.31.213.164','2017-01-05 11:50:42 042','请求错误','LogService'),
('2c91647d594fedd001596cc00d60010f',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Connection reset by peer','superadmin','183.31.213.164','2017-01-05 11:50:42 042','请求出错','LogService'),
('2c91647d594fedd001596cc00f030110',3,'错误代码:404，访问路径:/flow/form/save','superadmin','113.76.3.39','2017-01-05 11:50:43 043','系统异常','LogService'),
('2c91647d594fedd001596cc031620111',3,'错误代码:404，访问路径:/flow/form/save','superadmin','113.76.3.39','2017-01-05 11:50:52 052','系统异常','LogService'),
('2c91647d594fedd001596cc079550112',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.31.213.164','2017-01-05 11:51:10 010','系统异常','LogService'),
('2c91647d594fedd001596cc104f00113',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 11:51:46 046','系统登录','LogService'),
('2c91647d594fedd001596cc11bf80114',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','183.31.213.164','2017-01-05 11:51:52 052','请求出错','LogService'),
('2c91647d594fedd001596cc11c020115',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','183.31.213.164','2017-01-05 11:51:52 052','请求错误','LogService'),
('2c91647d594fedd001596cc11d9b0116',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','183.31.213.164','2017-01-05 11:51:52 052','请求出错','LogService'),
('2c91647d594fedd001596cc11da70117',3,'org.apache.catalina.connector.ClientAbortException: java.io.IOException: Broken pipe','superadmin','183.31.213.164','2017-01-05 11:51:52 052','请求错误','LogService'),
('2c91647d594fedd001596cc131c40118',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.31.213.164','2017-01-05 11:51:57 057','系统异常','LogService'),
('2c91647d594fedd001596cc71c5f0119',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 11:58:25 025','系统登录','LogService'),
('2c91647d594fedd001596cc7392b011a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.31.213.164','2017-01-05 11:58:32 032','系统异常','LogService'),
('2c91647d594fedd001596cc74f68011b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.31.213.164','2017-01-05 11:58:38 038','系统异常','LogService'),
('2c91647d594fedd001596cdd1805011c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 12:22:26 026','登录系统','LogService'),
('2c91647d594fedd001596cdd181a011d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 12:22:26 026','登录系统','LogService'),
('2c91647d594fedd001596cdeed2e011e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 12:24:26 026','登录系统','LogService'),
('2c91647d594fedd001596cdfd79c011f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 12:25:26 026','登录系统','LogService'),
('2c91647d594fedd001596ce1acc50120',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 12:27:26 026','登录系统','LogService'),
('2c91647d594fedd001596ce381ed0121',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 12:29:26 026','登录系统','LogService'),
('2c91647d594fedd001596d10247c0122',1,'用户：[superadmin] 成功登录系统','superadmin','183.237.48.231','2017-01-05 13:18:11 011','系统登录','LogService'),
('2c91647d594fedd001596d1041a20123',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.237.48.231','2017-01-05 13:18:19 019','系统异常','LogService'),
('2c91647d594fedd001596d114e800124',1,'用户：[superadmin] 退出系统','superadmin','183.237.48.231','2017-01-05 13:19:27 027','退出系统','LogService'),
('2c91647d594fedd001596d3e88da0125',1,'用户：[superadmin] 成功登录系统','superadmin','183.237.48.231','2017-01-05 14:08:51 051','系统登录','LogService'),
('2c91647d594fedd001596d4c387b0127',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 14:23:48 048','系统登录','LogService'),
('2c91647d594fedd001596d52899e0128',1,'用户：[superadmin] 成功登录系统','superadmin','121.35.180.51','2017-01-05 14:30:42 042','系统登录','LogService'),
('2c91647d594fedd001596d52a9b20129',3,'错误代码:404，访问路径:/favicon.ico','superadmin','121.35.180.51','2017-01-05 14:30:51 051','系统异常','LogService'),
('2c91647d594fedd001596d5334d0012a',1,'切换布局：[layout: ${layout}]','superadmin','121.35.180.51','2017-01-05 14:31:26 026','系统首页','LogService'),
('2c91647d594fedd001596d5c5e8e012b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 14:41:27 027','登录系统','LogService'),
('2c91647d594fedd001596d5f9a76012c',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-05 14:44:59 059','系统异常','LogService'),
('2c91647d594fedd001596d60f497012d',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-05 14:46:27 027','系统异常','LogService'),
('2c91647d594fedd001596d6a1b0c012e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 14:56:27 027','登录系统','LogService'),
('2c91647d594fedd001596d6f9a04012f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 15:02:27 027','登录系统','LogService'),
('2c91647d594fedd001596d92a9370130',1,'用户：[superadmin] 成功登录系统','superadmin','182.242.230.106','2017-01-05 15:40:45 045','系统登录','LogService'),
('2c91647d594fedd001596d92df7f0131',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.242.230.106','2017-01-05 15:40:59 059','系统异常','LogService'),
('2c91647d594fedd001596da159fa0132',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.188.118','2017-01-05 15:56:47 047','系统异常','LogService'),
('2c91647d594fedd001596daec7bb0133',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 16:11:28 028','登录系统','LogService'),
('2c91647d594fedd001596dc05ea20134',1,'用户：[superadmin] 成功登录系统','superadmin','113.76.3.39','2017-01-05 16:30:40 040','系统登录','LogService'),
('2c91647d594fedd001596dc32bd90135',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-05 16:33:44 044','系统异常','LogService'),
('2c91647d594fedd001596dd6a8530136',1,'用户：[superadmin] 成功登录系统','superadmin','183.31.213.164','2017-01-05 16:55:01 001','系统登录','LogService'),
('2c91647d594fedd001596de0395f0137',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 17:05:28 028','登录系统','LogService'),
('2c91647d594fedd001596df2899d0138',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 17:25:28 028','登录系统','LogService'),
('2c91647d594fedd001596e0a4e5d0139',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-05 17:51:26 026','系统异常','LogService'),
('2c91647d594fedd001596e1e4beb013a',1,'用户：[superadmin] 成功登录系统','superadmin','123.126.111.10','2017-01-05 18:13:16 016','系统登录','LogService'),
('2c91647d594fedd001596e1e693a013b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.126.111.10','2017-01-05 18:13:23 023','系统异常','LogService'),
('2c91647d594fedd001596e1e9b09013c',1,'切换布局：[layout: ${layout}]','superadmin','123.126.111.10','2017-01-05 18:13:36 036','系统首页','LogService'),
('2c91647d594fedd001596e2f74c7013d',3,'错误代码:404，访问路径:/show.html','system','123.56.155.154','2017-01-05 18:32:00 000','系统异常','LogService'),
('2c91647d594fedd001596e5302bc013e',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-05 19:10:51 051','系统异常','LogService'),
('2c91647d594fedd001596e548240013f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 19:12:29 029','登录系统','LogService'),
('2c91647d594fedd001596e82e67f0140',1,'用户：[superadmin] 成功登录系统','superadmin','111.196.68.27','2017-01-05 20:03:09 009','系统登录','LogService'),
('2c91647d594fedd001596e8303340141',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.196.68.27','2017-01-05 20:03:16 016','系统异常','LogService'),
('2c91647d594fedd001596e9f970e0142',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 20:34:29 029','登录系统','LogService'),
('2c91647d594fedd001596f12ff4c0143',1,'用户：[superadmin] 成功登录系统','superadmin','218.14.157.177','2017-01-05 22:40:33 033','系统登录','LogService'),
('2c91647d594fedd001596f131be50144',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.14.157.177','2017-01-05 22:40:40 040','系统异常','LogService'),
('2c91647d594fedd001596f131cb90145',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.14.157.177','2017-01-05 22:40:40 040','系统异常','LogService'),
('2c91647d594fedd001596f1b7eb20146',3,'错误代码:404，访问路径:/robots.txt','system','203.208.60.203','2017-01-05 22:49:50 050','系统异常','LogService'),
('2c91647d594fedd001596f1faf480147',3,'错误代码:404，访问路径:/script','system','117.34.74.218','2017-01-05 22:54:24 024','系统异常','LogService'),
('2c91647d594fedd001596f28f13c0148',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-05 23:04:31 031','系统异常','LogService'),
('2c91647d594fedd001596f30420c0149',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-05 23:12:30 030','登录系统','LogService'),
('2c91647d594fedd001596f654978014a',1,'用户：[superadmin] 成功登录系统','superadmin','219.82.218.155','2017-01-06 00:10:26 026','系统登录','LogService'),
('2c91647d594fedd001596f656b0e014b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.82.218.155','2017-01-06 00:10:34 034','系统异常','LogService'),
('2c91647d594fedd001596f6c702a014c',1,'用户：[superadmin] 成功登录系统','superadmin','36.107.163.190','2017-01-06 00:18:14 014','系统登录','LogService'),
('2c91647d594fedd001596f6c8b9d014d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.107.163.190','2017-01-06 00:18:21 021','系统异常','LogService'),
('2c91647d594fedd001596f6c8c9f014e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.107.163.190','2017-01-06 00:18:21 021','系统异常','LogService'),
('2c91647d594fedd001596f6e4b36014f',3,'错误代码:404，访问路径:/flow/form/save','superadmin','36.107.163.190','2017-01-06 00:20:16 016','系统异常','LogService'),
('2c91647d594fedd001596f71e1390150',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','36.107.163.190','2017-01-06 00:24:11 011','请求出错','LogService'),
('2c91647d594fedd001596f72049b0151',1,'切换布局：[layout: ${layout}]','superadmin','36.107.163.190','2017-01-06 00:24:20 020','系统首页','LogService'),
('2c91647d594fedd001596f720f370152',1,'切换布局：[layout: ${layout}]','superadmin','36.107.163.190','2017-01-06 00:24:23 023','系统首页','LogService'),
('2c91647d594fedd001596f81bf800153',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 00:41:31 031','登录系统','LogService'),
('2c91647d594fedd001596f8e915f0154',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 00:55:31 031','登录系统','LogService'),
('2c91647d594fedd001596fd974130155',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-06 02:17:19 019','系统异常','LogService'),
('2c91647d594fedd001596fe088890156',1,'用户：[superadmin] 成功登录系统','superadmin','101.38.30.102','2017-01-06 02:25:03 003','系统登录','LogService'),
('2c91647d594fedd001596fe0a56f0157',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.38.30.102','2017-01-06 02:25:10 010','系统异常','LogService'),
('2c91647d594fedd001596fe16d7f0158',1,'切换布局：[layout: ${layout}]','superadmin','101.38.30.102','2017-01-06 02:26:01 001','系统首页','LogService'),
('2c91647d594fedd001596ffd5b550159',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 02:56:32 032','登录系统','LogService'),
('2c91647d594fedd00159708dbd49015a',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2017-01-06 05:34:14 014','系统异常','LogService'),
('2c91647d594fedd0015970ea0393015b',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','172.82.166.210','2017-01-06 07:15:01 001','系统异常','LogService'),
('2c91647d594fedd0015970f32d55015c',3,'错误代码:404，访问路径:/myiphb.php','system','95.153.122.183','2017-01-06 07:25:02 002','系统异常','LogService'),
('2c91647d594fedd00159710e3be9015d',3,'错误代码:404，访问路径:/myiphb.php','system','95.153.122.183','2017-01-06 07:54:35 035','系统异常','LogService'),
('2c91647d594fedd00159713df2a3015e',3,'错误代码:404，访问路径:/myiphb.php','system','95.153.122.183','2017-01-06 08:46:42 042','系统异常','LogService'),
('2c91647d594fedd0015971c3b562015f',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.57.251','2017-01-06 11:12:48 048','系统异常','LogService'),
('2c91647d594fedd0015971d809250160',1,'用户：[superadmin] 成功登录系统','superadmin','123.233.247.119','2017-01-06 11:35:00 000','系统登录','LogService'),
('2c91647d594fedd0015971d824f90161',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.233.247.119','2017-01-06 11:35:07 007','系统异常','LogService'),
('2c91647d594fedd0015971d825b50162',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.233.247.119','2017-01-06 11:35:07 007','系统异常','LogService'),
('2c91647d594fedd0015971d85c0b0163',1,'切换布局：[layout: ${layout}]','superadmin','123.233.247.119','2017-01-06 11:35:21 021','系统首页','LogService'),
('2c91647d594fedd0015971f249750164',3,'错误代码:404，访问路径:/nice ports,/Trinity.txt.bak','system','123.151.92.176','2017-01-06 12:03:41 041','系统异常','LogService'),
('2c91647d594fedd0015971f408c90165',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 12:05:35 035','登录系统','LogService'),
('2c91647d594fedd001597237f71b0166',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.42.130','2017-01-06 13:19:47 047','系统登录','LogService'),
('2c91647d594fedd001597239920f0167',3,'错误代码:404，访问路径:/open/doc','superadmin','115.236.42.130','2017-01-06 13:21:32 032','系统异常','LogService'),
('2c91647d594fedd00159723a2d700168',1,'切换布局：[layout: ${layout}]','superadmin','115.236.42.130','2017-01-06 13:22:12 012','系统首页','LogService'),
('2c91647d594fedd00159725264a50169',1,'用户：[superadmin] 成功登录系统','superadmin','112.16.142.250','2017-01-06 13:48:39 039','系统登录','LogService'),
('2c91647d594fedd0015972528367016a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.16.142.250','2017-01-06 13:48:47 047','系统异常','LogService'),
('2c91647d594fedd0015972568032016b',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2017-01-06 13:53:08 008','系统异常','LogService'),
('2c91647d594fedd001597256eb93016c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 13:53:36 036','登录系统','LogService'),
('2c91647d594fedd00159726eba4c016d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 14:19:36 036','登录系统','LogService'),
('2c91647d594fedd0015972cf334d016e',1,'用户：[superadmin] 成功登录系统','superadmin','180.111.103.247','2017-01-06 16:04:58 058','系统登录','LogService'),
('2c91647d594fedd0015972cf500b016f',3,'错误代码:404，访问路径:/favicon.ico','system','180.111.103.247','2017-01-06 16:05:06 006','系统异常','LogService'),
('2c91647d594fedd0015972cf50cf0170',3,'错误代码:404，访问路径:/favicon.ico','system','180.111.103.247','2017-01-06 16:05:06 006','系统异常','LogService'),
('2c91647d594fedd0015972cf631e0171',3,'错误代码:404，访问路径:/favicon.ico','system','180.111.103.247','2017-01-06 16:05:11 011','系统异常','LogService'),
('2c91647d594fedd0015972cfeebf0172',3,'错误代码:404，访问路径:/favicon.ico','system','180.111.103.247','2017-01-06 16:05:46 046','系统异常','LogService'),
('2c91647d594fedd0015972cff1c50173',3,'错误代码:404，访问路径:/favicon.ico','system','180.111.103.247','2017-01-06 16:05:47 047','系统异常','LogService'),
('2c91647d594fedd0015972cff4620174',1,'切换布局：[layout: ${layout}]','superadmin','180.111.103.247','2017-01-06 16:05:48 048','系统首页','LogService'),
('2c91647d594fedd0015972ec2b1f0175',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 16:36:37 037','登录系统','LogService'),
('2c91647d594fedd0015972f19ba90176',3,'错误代码:404，访问路径:/robots.txt','system','203.208.60.207','2017-01-06 16:42:33 033','系统异常','LogService'),
('2c91647d594fedd0015972f19c180177',3,'错误代码:404，访问路径:/m/','system','203.208.60.207','2017-01-06 16:42:33 033','系统异常','LogService'),
('2c91647d594fedd00159731083d30178',1,'用户：[superadmin] 成功登录系统','superadmin','222.66.111.98','2017-01-06 17:16:19 019','系统登录','LogService'),
('2c91647d594fedd001597310a16e0179',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.66.111.98','2017-01-06 17:16:26 026','系统异常','LogService'),
('2c91647d594fedd00159732c42ed017a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 17:46:37 037','登录系统','LogService'),
('2c91647d594fedd0015973338b2e017b',1,'用户：[superadmin] 成功登录系统','superadmin','118.192.135.180','2017-01-06 17:54:34 034','系统登录','LogService'),
('2c91647d594fedd0015973338de8017c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.192.135.180','2017-01-06 17:54:35 035','系统异常','LogService'),
('2c91647d594fedd001597353a26a017d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 18:29:38 038','登录系统','LogService'),
('2c91647d594fedd0015973aba38d017e',1,'用户：[superadmin] 成功登录系统','superadmin','119.96.84.244','2017-01-06 20:05:45 045','系统登录','LogService'),
('2c91647d594fedd0015973c7eb35017f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 20:36:38 038','登录系统','LogService'),
('2c91647d594fedd0015973e17c1d0180',1,'用户：[superadmin] 成功登录系统','superadmin','183.48.35.103','2017-01-06 21:04:34 034','系统登录','LogService'),
('2c91647d594fedd0015973e199460181',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.48.89.251','2017-01-06 21:04:41 041','系统异常','LogService'),
('2c91647d594fedd0015973eb0d860183',3,'错误代码:404，访问路径:/script','system','39.109.18.219','2017-01-06 21:15:01 001','系统异常','LogService'),
('2c91647d594fedd0015973f277fd0184',3,'错误代码:404，访问路径:/myiphb.php','system','95.153.122.183','2017-01-06 21:23:07 007','系统异常','LogService'),
('2c91647d594fedd0015973f279aa0185',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.122.183','2017-01-06 21:23:07 007','系统异常','LogService'),
('2c91647d594fedd0015973f27bb50186',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-06 21:23:08 008','系统异常','LogService'),
('2c91647d594fedd0015973f27dcb0187',3,'错误代码:404，访问路径:/myipha.php','system','95.153.122.183','2017-01-06 21:23:08 008','系统异常','LogService'),
('2c91647d594fedd001597400b0370188',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-06 21:38:39 039','登录系统','LogService'),
('2c91647d594fedd0015974261b600189',3,'错误代码:404，访问路径:/script','system','39.109.18.219','2017-01-06 22:19:31 031','系统异常','LogService'),
('2c91647d594fedd00159743fc7ee018a',3,'错误代码:404，访问路径:/script','system','39.109.18.219','2017-01-06 22:47:34 034','系统异常','LogService'),
('2c91647d594fedd001597460ef24018b',3,'错误代码:404，访问路径:/script','system','39.109.18.219','2017-01-06 23:23:46 046','系统异常','LogService'),
('2c91647d594fedd0015974bf554c018c',3,'错误代码:404，访问路径:/script','system','39.109.18.219','2017-01-07 01:06:53 053','系统异常','LogService'),
('2c91647d594fedd001597522bd23018d',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2017-01-07 02:55:28 028','系统异常','LogService'),
('2c91647d594fedd001597523e29d018e',3,'错误代码:404，访问路径:/mobile/','system','66.249.65.254','2017-01-07 02:56:43 043','系统异常','LogService'),
('2c91647d594fedd001597602c662018f',3,'错误代码:404，访问路径:/script','system','182.18.72.142','2017-01-07 07:00:10 010','系统异常','LogService'),
('2c91647d594fedd00159765e19510190',3,'错误代码:404，访问路径:/manager/html','system','139.196.122.6','2017-01-07 08:39:55 055','系统异常','LogService'),
('2c91647d594fedd0015976b1aeee0191',1,'用户：[superadmin] 成功登录系统','superadmin','121.69.29.98','2017-01-07 10:11:13 013','系统登录','LogService'),
('2c91647d594fedd0015976b1cbc30192',3,'错误代码:404，访问路径:/favicon.ico','superadmin','121.69.29.98','2017-01-07 10:11:20 020','系统异常','LogService'),
('2c91647d594fedd0015976cb373c0193',3,'错误代码:404，访问路径:/proxyjudge.php','system','204.152.218.49','2017-01-07 10:39:06 006','系统异常','LogService'),
('2c91647d594fedd0015976ce86bb0194',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 10:42:43 043','登录系统','LogService'),
('2c91647d594fedd0015977b22ee20195',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.187.149','2017-01-07 14:51:23 023','系统异常','LogService'),
('2c91647d594fedd001597810824b0196',1,'用户：[superadmin] 成功登录系统','superadmin','111.194.3.148','2017-01-07 16:34:24 024','系统登录','LogService'),
('2c91647d594fedd0015978109d680197',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.194.3.148','2017-01-07 16:34:31 031','系统异常','LogService'),
('2c91647d594fedd00159782a01180198',1,'用户：[superadmin] 成功登录系统','superadmin','113.142.133.49','2017-01-07 17:02:15 015','系统登录','LogService'),
('2c91647d594fedd00159782a20620199',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.142.133.49','2017-01-07 17:02:23 023','系统异常','LogService'),
('2c91647d594fedd00159782ad207019a',1,'切换布局：[layout: ${layout}]','superadmin','113.142.133.49','2017-01-07 17:03:09 009','系统首页','LogService'),
('2c91647d594fedd00159782d3793019b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 17:05:46 046','登录系统','LogService'),
('2c91647d594fedd00159782f29d2019c',3,'错误代码:404，访问路径:/console/j_security_check','system','121.42.24.226','2017-01-07 17:07:53 053','系统异常','LogService'),
('2c91647d594fedd00159782f46be019d',1,'用户：[superadmin] 成功登录系统','superadmin','116.66.38.138','2017-01-07 17:08:01 001','系统登录','LogService'),
('2c91647d594fedd00159782f62fb019e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.66.38.138','2017-01-07 17:08:08 008','系统异常','LogService'),
('2c91647d594fedd0015978388bd4019f',3,'错误代码:404，访问路径:/open/doc','superadmin','116.66.38.138','2017-01-07 17:18:08 008','系统异常','LogService'),
('2c91647d594fedd0015978398f1801a0',1,'切换布局：[layout: ${layout}]','superadmin','116.66.38.138','2017-01-07 17:19:15 015','系统首页','LogService'),
('2c91647d594fedd001597839982101a1',1,'切换布局：[layout: ${layout}]','superadmin','116.66.38.138','2017-01-07 17:19:17 017','系统首页','LogService'),
('2c91647d594fedd001597839bbb201a2',1,'切换布局：[layout: ${layout}]','superadmin','116.66.38.138','2017-01-07 17:19:26 026','系统首页','LogService'),
('2c91647d594fedd001597839d33801a3',1,'锁定系统','superadmin','116.66.38.138','2017-01-07 17:19:32 032','个人中心','LogService'),
('2c91647d594fedd00159783a294401a4',1,'解锁系统','superadmin','116.66.38.138','2017-01-07 17:19:54 054','个人中心','LogService'),
('2c91647d594fedd00159783f4c3101a5',3,'错误代码:404，访问路径:/open/doc','superadmin','116.66.38.138','2017-01-07 17:25:31 031','系统异常','LogService'),
('2c91647d594fedd00159783f51a501a6',1,'用户：[superadmin] 成功登录系统','superadmin','118.192.135.180','2017-01-07 17:25:32 032','系统登录','LogService'),
('2c91647d594fedd00159783f6f8601a7',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.192.135.180','2017-01-07 17:25:40 040','系统异常','LogService'),
('2c91647d594fedd001597846db0e01a8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 17:33:46 046','登录系统','LogService'),
('2c91647d594fedd0015978543ec201a9',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','172.82.166.210','2017-01-07 17:48:24 024','系统异常','LogService'),
('2c91647d594fedd00159785bea8301aa',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 17:56:46 046','登录系统','LogService'),
('2c91647d594fedd00159785cd4f401ab',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 17:57:46 046','登录系统','LogService'),
('2c91647d594fedd00159786739ec01ac',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2017-01-07 18:09:08 008','系统异常','LogService'),
('2c91647d594fedd0015978ea129701ad',1,'用户：[superadmin] 成功登录系统','superadmin','61.153.203.186','2017-01-07 20:32:03 003','系统登录','LogService'),
('2c91647d594fedd0015978ea468201ae',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.153.203.186','2017-01-07 20:32:16 016','系统异常','LogService'),
('2c91647d594fedd0015978ea4a6201af',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.153.203.186','2017-01-07 20:32:17 017','系统异常','LogService'),
('2c91647d594fedd0015978ea6cfa01b0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.153.203.186','2017-01-07 20:32:26 026','系统异常','LogService'),
('2c91647d594fedd0015978ea774c01b1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.153.203.186','2017-01-07 20:32:29 029','系统异常','LogService'),
('2c91647d594fedd0015978fd1a7201b2',1,'用户：[superadmin] 成功登录系统','superadmin','222.223.99.49','2017-01-07 20:52:50 050','系统登录','LogService'),
('2c91647d594fedd0015978fd416d01b3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.223.99.49','2017-01-07 20:53:00 000','系统异常','LogService'),
('2c91647d594fedd00159790638b001b4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 21:02:47 047','登录系统','LogService'),
('2c91647d594fedd001597919737c01b5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2017-01-07 21:23:48 048','登录系统','LogService'),
('2c91647d594fedd0015979248fd201b6',1,'用户：[superadmin] 成功登录系统','superadmin','27.191.152.98','2017-01-07 21:35:56 056','系统登录','LogService'),
('2c91647d594fedd001597924b5fd01b7',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.191.152.98','2017-01-07 21:36:06 006','系统异常','LogService'),
('2c91647d594fedd00159792609a601b8',1,'切换布局：[layout: ${layout}]','superadmin','27.191.152.98','2017-01-07 21:37:33 033','系统首页','LogService'),
('2c91647d594fedd00159792664eb01b9',1,'切换布局：[layout: ${layout}]','superadmin','27.191.152.98','2017-01-07 21:37:56 056','系统首页','LogService'),
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
('8a1076ae58e181450158e1a91e05001d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 11:38:26 026','登录系统','LogService'),
('8a1076ae58e181450158e1b3304c001e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 11:49:26 026','登录系统','LogService'),
('8a1076ae58e181450158e1b9990a001f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 11:56:26 026','登录系统','LogService'),
('8a1076ae58e181450158e1f9153a0020',3,'错误代码:404，访问路径:/myipha.php','system','95.153.117.28','2016-12-09 13:05:47 047','系统异常','LogService'),
('8a1076ae58e181450158e1f917cc0021',3,'错误代码:404，访问路径:/myiphc.php','system','95.153.117.28','2016-12-09 13:05:47 047','系统异常','LogService'),
('8a1076ae58e181450158e2010af30022',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.122.82','2016-12-09 13:14:28 028','系统登录','LogService'),
('8a1076ae58e181450158e2011a520023',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.17.122.82','2016-12-09 13:14:32 032','请求出错','LogService'),
('8a1076ae58e181450158e2011a620024',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.17.122.82','2016-12-09 13:14:32 032','请求出错','LogService'),
('8a1076ae58e181450158e2011a6a0025',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.17.122.82','2016-12-09 13:14:32 032','系统异常','LogService'),
('8a1076ae58e181450158e2011a6f0026',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.17.122.82','2016-12-09 13:14:32 032','请求出错','LogService'),
('8a1076ae58e181450158e2011a730027',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.17.122.82','2016-12-09 13:14:32 032','请求出错','LogService'),
('8a1076ae58e181450158e2011a810028',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.17.122.82','2016-12-09 13:14:32 032','请求出错','LogService'),
('8a1076ae58e181450158e2011a880029',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.17.122.82','2016-12-09 13:14:32 032','系统异常','LogService'),
('8a1076ae58e181450158e2011acf002a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.17.122.82','2016-12-09 13:14:33 033','系统异常','LogService'),
('8a1076ae58e181450158e2011b0d002b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.17.122.82','2016-12-09 13:14:33 033','系统异常','LogService'),
('8a1076ae58e181450158e2011b45002c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.17.122.82','2016-12-09 13:14:33 033','系统异常','LogService'),
('8a1076ae58e181450158e2011b7e002d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.17.122.82','2016-12-09 13:14:33 033','系统异常','LogService'),
('8a1076ae58e181450158e2015222002e',1,'切换布局：[layout: ${layout}]','superadmin','218.17.122.82','2016-12-09 13:14:47 047','系统首页','LogService'),
('8a1076ae58e181450158e2019596002f',1,'切换布局：[layout: ${layout}]','superadmin','218.17.122.82','2016-12-09 13:15:04 004','系统首页','LogService'),
('8a1076ae58e181450158e2053a9e0030',1,'切换布局：[layout: ${layout}]','superadmin','218.17.122.82','2016-12-09 13:19:03 003','系统首页','LogService'),
('8a1076ae58e181450158e205431b0031',1,'切换布局：[layout: ${layout}]','superadmin','218.17.122.82','2016-12-09 13:19:05 005','系统首页','LogService'),
('8a1076ae58e181450158e205543a0032',1,'用户：[superadmin] 退出系统','superadmin','218.17.122.82','2016-12-09 13:19:09 009','退出系统','LogService'),
('8a1076ae58e181450158e2056a140033',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.122.82','2016-12-09 13:19:15 015','系统登录','LogService'),
('8a1076ae58e181450158e205ce6d0034',3,'错误代码:404，访问路径:/flow/form/save','superadmin','218.17.122.82','2016-12-09 13:19:41 041','系统异常','LogService'),
('8a1076ae58e181450158e205ee8c0035',3,'错误代码:404，访问路径:/flow/form/save','superadmin','218.17.122.82','2016-12-09 13:19:49 049','系统异常','LogService'),
('8a1076ae58e181450158e2077b380036',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.17.122.82','2016-12-09 13:21:30 030','系统异常','LogService'),
('8a1076ae58e181450158e207fb950037',1,'锁定系统','superadmin','218.17.122.82','2016-12-09 13:22:03 003','个人中心','LogService'),
('8a1076ae58e181450158e2081aa50038',1,'解锁系统','superadmin','218.17.122.82','2016-12-09 13:22:11 011','个人中心','LogService'),
('8a1076ae58e181450158e2112b910039',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-09 13:32:05 005','系统异常','LogService'),
('8a1076ae58e181450158e223cdf4003a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 13:52:27 027','登录系统','LogService'),
('8a1076ae58e181450158e225cd7e003b',1,'用户：[superadmin] 成功登录系统','superadmin','180.102.26.133','2016-12-09 13:54:38 038','系统登录','LogService'),
('8a1076ae58e181450158e225dc91003c',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:41 041','系统异常','LogService'),
('8a1076ae58e181450158e225de0d003d',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:42 042','系统异常','LogService'),
('8a1076ae58e181450158e225ded7003e',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:42 042','系统异常','LogService'),
('8a1076ae58e181450158e225df26003f',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:42 042','系统异常','LogService'),
('8a1076ae58e181450158e225df7b0040',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:42 042','系统异常','LogService'),
('8a1076ae58e181450158e225dfcf0041',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:42 042','系统异常','LogService'),
('8a1076ae58e181450158e225e02c0042',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:42 042','系统异常','LogService'),
('8a1076ae58e181450158e225e8d90043',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:45 045','系统异常','LogService'),
('8a1076ae58e181450158e22606920044',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.26.133','2016-12-09 13:54:52 052','系统异常','LogService'),
('8a1076ae58e181450158e22e48d70045',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 14:03:53 053','系统登录','LogService'),
('8a1076ae58e181450158e22e55c20046',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-09 14:03:57 057','系统异常','LogService'),
('8a1076ae58e181450158e22f59f70047',1,'用户：[superadmin] 退出系统','superadmin','60.173.220.146','2016-12-09 14:05:03 003','退出系统','LogService'),
('8a1076ae58e181450158e242ef0c0048',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 14:26:27 027','登录系统','LogService'),
('8a1076ae58e181450158e247890f0049',1,'用户：[superadmin] 成功登录系统','superadmin','180.102.164.234','2016-12-09 14:31:28 028','系统登录','LogService'),
('8a1076ae58e181450158e2479632004a',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e24796a3004b',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e2479818004c',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e24798ca004d',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e24798f0004e',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e247994b004f',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e247997b0050',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:32 032','系统异常','LogService'),
('8a1076ae58e181450158e247c07f0051',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:42 042','系统异常','LogService'),
('8a1076ae58e181450158e247d8250052',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:49 049','系统异常','LogService'),
('8a1076ae58e181450158e247e73a0053',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:52 052','系统异常','LogService'),
('8a1076ae58e181450158e247e9830054',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:53 053','系统异常','LogService'),
('8a1076ae58e181450158e247f4440055',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:31:56 056','系统异常','LogService'),
('8a1076ae58e181450158e24820610056',1,'用户：[superadmin] 成功登录系统','superadmin','183.203.215.118','2016-12-09 14:32:07 007','系统登录','LogService'),
('8a1076ae58e181450158e24832740057',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.203.215.118','2016-12-09 14:32:12 012','系统异常','LogService'),
('8a1076ae58e181450158e2487f670058',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.203.215.118','2016-12-09 14:32:31 031','系统异常','LogService'),
('8a1076ae58e181450158e249a2d40059',1,'切换布局：[layout: ${layout}]','superadmin','180.102.164.234','2016-12-09 14:33:46 046','系统首页','LogService'),
('8a1076ae58e181450158e249ad65005a',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:33:49 049','系统异常','LogService'),
('8a1076ae58e181450158e249b112005b',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:33:50 050','系统异常','LogService'),
('8a1076ae58e181450158e249b403005c',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:33:50 050','系统异常','LogService'),
('8a1076ae58e181450158e249b806005d',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:33:51 051','系统异常','LogService'),
('8a1076ae58e181450158e24a2635005e',3,'错误代码:404，访问路径:/open/doc','superadmin','180.102.164.234','2016-12-09 14:34:20 020','系统异常','LogService'),
('8a1076ae58e181450158e24a4d3c005f',3,'错误代码:404，访问路径:/open/doc','system','180.153.211.172','2016-12-09 14:34:30 030','系统异常','LogService'),
('8a1076ae58e181450158e24bfd9c0060',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-09 14:36:20 020','系统异常','LogService'),
('8a1076ae58e181450158e24cc99b0061',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:37:12 012','系统异常','LogService'),
('8a1076ae58e181450158e24ccde30062',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:37:14 014','系统异常','LogService'),
('8a1076ae58e181450158e24cd1190063',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:37:14 014','系统异常','LogService'),
('8a1076ae58e181450158e24cd3dc0064',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:37:15 015','系统异常','LogService'),
('8a1076ae58e181450158e24db29c0065',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:38:12 012','系统异常','LogService'),
('8a1076ae58e181450158e24db5e90066',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:38:13 013','系统异常','LogService'),
('8a1076ae58e181450158e24dba1f0067',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:38:14 014','系统异常','LogService'),
('8a1076ae58e181450158e24dcf160068',1,'切换布局：[layout: ${layout}]','superadmin','180.102.164.234','2016-12-09 14:38:19 019','系统首页','LogService'),
('8a1076ae58e181450158e250393a0069',3,'错误代码:404，访问路径:/\'+ s.iframeSrc +\'','system','119.147.146.60','2016-12-09 14:40:58 058','系统异常','LogService'),
('8a1076ae58e181450158e250e704006a',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:41:42 042','系统异常','LogService'),
('8a1076ae58e181450158e250ecce006b',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:41:44 044','系统异常','LogService'),
('8a1076ae58e181450158e250f143006c',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:41:45 045','系统异常','LogService'),
('8a1076ae58e181450158e250f520006d',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 14:41:46 046','系统异常','LogService'),
('8a1076ae58e181450158e25128af006e',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.177.147','2016-12-09 14:41:59 059','系统登录','LogService'),
('8a1076ae58e181450158e2513a08006f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','223.104.177.147','2016-12-09 14:42:03 003','请求出错','LogService'),
('8a1076ae58e181450158e2513a570070',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.104.177.147','2016-12-09 14:42:03 003','系统异常','LogService'),
('8a1076ae58e181450158e2513aaf0071',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.104.177.147','2016-12-09 14:42:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2513b210072',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.104.177.147','2016-12-09 14:42:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2513b970073',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.104.177.147','2016-12-09 14:42:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2513c110074',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.104.177.147','2016-12-09 14:42:04 004','系统异常','LogService'),
('8a1076ae58e181450158e25219a90075',3,'错误代码:404，访问路径:/favicon.ico','system','223.104.177.147','2016-12-09 14:43:01 001','系统异常','LogService'),
('8a1076ae58e181450158e2521bf40076',3,'错误代码:404，访问路径:/favicon.ico','system','223.104.177.147','2016-12-09 14:43:01 001','系统异常','LogService'),
('8a1076ae58e181450158e25220f80077',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.177.147','2016-12-09 14:43:03 003','系统登录','LogService'),
('8a1076ae58e181450158e253b2880078',3,'错误代码:404，访问路径:/flow/form/save','superadmin','223.104.177.147','2016-12-09 14:44:45 045','系统异常','LogService'),
('8a1076ae58e181450158e254c8b60079',1,'切换布局：[layout: ${layout}]','superadmin','223.104.177.147','2016-12-09 14:45:57 057','系统首页','LogService'),
('8a1076ae58e181450158e259fd70007a',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.69.128','2016-12-09 14:51:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2616ce8007b',3,'错误代码:404，访问路径:/robots.txt','system','203.208.60.217','2016-12-09 14:59:45 045','系统异常','LogService'),
('8a1076ae58e181450158e266a4d6007c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:05:27 027','登录系统','LogService'),
('8a1076ae58e181450158e26d0e4d007d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:12:27 027','登录系统','LogService'),
('8a1076ae58e181450158e26d0e50007e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:12:27 027','登录系统','LogService'),
('8a1076ae58e181450158e26d2d36007f',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-09 15:12:35 035','系统异常','LogService'),
('8a1076ae58e181450158e2709af20080',1,'用户：[superadmin] 成功登录系统','superadmin','125.70.231.103','2016-12-09 15:16:20 020','系统登录','LogService'),
('8a1076ae58e181450158e270f7e90081',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.70.231.103','2016-12-09 15:16:44 044','请求出错','LogService'),
('8a1076ae58e181450158e270f7ec0082',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.70.231.103','2016-12-09 15:16:44 044','请求出错','LogService'),
('8a1076ae58e181450158e270f7f10083',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.70.231.103','2016-12-09 15:16:44 044','请求出错','LogService'),
('8a1076ae58e181450158e270f7fa0084',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.70.231.103','2016-12-09 15:16:44 044','请求出错','LogService'),
('8a1076ae58e181450158e270f8040085',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.70.231.103','2016-12-09 15:16:44 044','请求出错','LogService'),
('8a1076ae58e181450158e270f8450086',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.70.231.103','2016-12-09 15:16:44 044','系统异常','LogService'),
('8a1076ae58e181450158e270f8d50087',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.70.231.103','2016-12-09 15:16:44 044','系统异常','LogService'),
('8a1076ae58e181450158e270f92e0088',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.70.231.103','2016-12-09 15:16:44 044','系统异常','LogService'),
('8a1076ae58e181450158e270f9930089',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.70.231.103','2016-12-09 15:16:44 044','系统异常','LogService'),
('8a1076ae58e181450158e270f9e3008a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.70.231.103','2016-12-09 15:16:44 044','系统异常','LogService'),
('8a1076ae58e181450158e271a24b008b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:17:27 027','登录系统','LogService'),
('8a1076ae58e181450158e272fd4e008c',1,'用户：[superadmin] 成功登录系统','superadmin','60.191.66.218','2016-12-09 15:18:56 056','系统登录','LogService'),
('8a1076ae58e181450158e2734bc1008d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.191.66.218','2016-12-09 15:19:16 016','系统异常','LogService'),
('8a1076ae58e181450158e27351ac008e',1,'用户：[superadmin] 成功登录系统','superadmin','113.111.90.155','2016-12-09 15:19:18 018','系统登录','LogService'),
('8a1076ae58e181450158e2736201008f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.111.90.155','2016-12-09 15:19:22 022','系统异常','LogService'),
('8a1076ae58e181450158e273a0d60090',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.111.90.155','2016-12-09 15:19:38 038','系统异常','LogService'),
('8a1076ae58e181450158e273e9940091',1,'用户：[superadmin] 成功登录系统','superadmin','221.133.242.138','2016-12-09 15:19:57 057','系统登录','LogService'),
('8a1076ae58e181450158e27404400092',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.133.242.138','2016-12-09 15:20:03 003','系统异常','LogService'),
('8a1076ae58e181450158e27404490093',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.133.242.138','2016-12-09 15:20:03 003','请求出错','LogService'),
('8a1076ae58e181450158e27404620094',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.133.242.138','2016-12-09 15:20:03 003','请求出错','LogService'),
('8a1076ae58e181450158e274046c0095',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.133.242.138','2016-12-09 15:20:03 003','系统异常','LogService'),
('8a1076ae58e181450158e274048a0096',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.133.242.138','2016-12-09 15:20:03 003','请求出错','LogService'),
('8a1076ae58e181450158e274048e0097',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.133.242.138','2016-12-09 15:20:03 003','系统异常','LogService'),
('8a1076ae58e181450158e274049e0098',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.133.242.138','2016-12-09 15:20:03 003','请求出错','LogService'),
('8a1076ae58e181450158e27404b60099',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.133.242.138','2016-12-09 15:20:04 004','系统异常','LogService'),
('8a1076ae58e181450158e27404c2009a',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.133.242.138','2016-12-09 15:20:04 004','请求出错','LogService'),
('8a1076ae58e181450158e27404fe009b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.133.242.138','2016-12-09 15:20:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2740518009c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.133.242.138','2016-12-09 15:20:04 004','系统异常','LogService'),
('8a1076ae58e181450158e278560c009d',1,'用户：[superadmin] 成功登录系统','superadmin','60.253.255.150','2016-12-09 15:24:46 046','系统登录','LogService'),
('8a1076ae58e181450158e2786548009e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.253.255.150','2016-12-09 15:24:50 050','系统异常','LogService'),
('8a1076ae58e181450158e2786594009f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.253.255.150','2016-12-09 15:24:50 050','请求出错','LogService'),
('8a1076ae58e181450158e27865ea00a0',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.253.255.150','2016-12-09 15:24:51 051','请求出错','LogService'),
('8a1076ae58e181450158e27865f000a1',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.253.255.150','2016-12-09 15:24:51 051','系统异常','LogService'),
('8a1076ae58e181450158e278664000a2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.253.255.150','2016-12-09 15:24:51 051','请求出错','LogService'),
('8a1076ae58e181450158e278664700a3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.253.255.150','2016-12-09 15:24:51 051','系统异常','LogService'),
('8a1076ae58e181450158e278669b00a4',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.253.255.150','2016-12-09 15:24:51 051','请求出错','LogService'),
('8a1076ae58e181450158e27866a400a5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.253.255.150','2016-12-09 15:24:51 051','系统异常','LogService'),
('8a1076ae58e181450158e27866f400a6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.253.255.150','2016-12-09 15:24:51 051','请求出错','LogService'),
('8a1076ae58e181450158e278670300a7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.253.255.150','2016-12-09 15:24:51 051','系统异常','LogService'),
('8a1076ae58e181450158e278676200a8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.253.255.150','2016-12-09 15:24:51 051','系统异常','LogService'),
('8a1076ae58e181450158e278827c00a9',1,'切换布局：[layout: ${layout}]','superadmin','125.70.231.103','2016-12-09 15:24:58 058','系统首页','LogService'),
('8a1076ae58e181450158e27b95ce00aa',3,'错误代码:404，访问路径:/open/doc','superadmin','60.253.255.150','2016-12-09 15:28:19 019','系统异常','LogService'),
('8a1076ae58e181450158e27bbb6900ab',1,'锁定系统','superadmin','60.253.255.150','2016-12-09 15:28:29 029','个人中心','LogService'),
('8a1076ae58e181450158e27bd88000ac',1,'解锁系统','superadmin','60.253.255.150','2016-12-09 15:28:36 036','个人中心','LogService'),
('8a1076ae58e181450158e27f773000ad',1,'用户：[superadmin] 成功登录系统','superadmin','116.228.137.34','2016-12-09 15:32:34 034','系统登录','LogService'),
('8a1076ae58e181450158e280cc8500ae',1,'切换布局：[layout: ${layout}]','superadmin','116.228.137.34','2016-12-09 15:34:01 001','系统首页','LogService'),
('8a1076ae58e181450158e284acf900af',1,'切换布局：[layout: ${layout}]','superadmin','60.253.255.150','2016-12-09 15:38:15 015','系统首页','LogService'),
('8a1076ae58e181450158e287c9c100b0',1,'用户：[superadmin] 退出系统','superadmin','60.253.255.150','2016-12-09 15:41:39 039','退出系统','LogService'),
('8a1076ae58e181450158e288bdcc00b1',1,'用户：[superadmin] 成功登录系统','superadmin','60.190.7.82','2016-12-09 15:42:42 042','系统登录','LogService'),
('8a1076ae58e181450158e28c523100b2',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.122.82','2016-12-09 15:46:36 036','系统登录','LogService'),
('8a1076ae58e181450158e28c67bb00b3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.17.122.82','2016-12-09 15:46:42 042','系统异常','LogService'),
('8a1076ae58e181450158e28eed4a00b4',3,'错误代码:404，访问路径:/myiphc.php','system','95.153.117.28','2016-12-09 15:49:27 027','系统异常','LogService'),
('8a1076ae58e181450158e28fd9cf00b5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:50:28 028','登录系统','LogService'),
('8a1076ae58e181450158e29001ec00b6',1,'切换布局：[layout: ${layout}]','superadmin','218.17.122.82','2016-12-09 15:50:38 038','系统首页','LogService'),
('8a1076ae58e181450158e290c43c00b7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:51:28 028','登录系统','LogService'),
('8a1076ae58e181450158e293448300b8',1,'用户：[superadmin] 成功登录系统','superadmin','113.108.152.98','2016-12-09 15:54:11 011','系统登录','LogService'),
('8a1076ae58e181450158e293555200b9',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','113.108.152.98','2016-12-09 15:54:16 016','请求出错','LogService'),
('8a1076ae58e181450158e293557100ba',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.108.152.98','2016-12-09 15:54:16 016','系统异常','LogService'),
('8a1076ae58e181450158e293560f00bb',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','113.108.152.98','2016-12-09 15:54:16 016','请求出错','LogService'),
('8a1076ae58e181450158e293569100bc',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','113.108.152.98','2016-12-09 15:54:16 016','系统异常','LogService'),
('8a1076ae58e181450158e293569800bd',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','113.108.152.98','2016-12-09 15:54:16 016','请求出错','LogService'),
('8a1076ae58e181450158e293574600be',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','113.108.152.98','2016-12-09 15:54:16 016','系统异常','LogService'),
('8a1076ae58e181450158e293574a00bf',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','113.108.152.98','2016-12-09 15:54:16 016','请求出错','LogService'),
('8a1076ae58e181450158e293577800c0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','113.108.152.98','2016-12-09 15:54:16 016','系统异常','LogService'),
('8a1076ae58e181450158e293578200c1',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','113.108.152.98','2016-12-09 15:54:16 016','请求出错','LogService'),
('8a1076ae58e181450158e29357ae00c2',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','113.108.152.98','2016-12-09 15:54:16 016','系统异常','LogService'),
('8a1076ae58e181450158e29357e400c3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','113.108.152.98','2016-12-09 15:54:16 016','系统异常','LogService'),
('8a1076ae58e181450158e2935b3b00c4',1,'用户：[superadmin] 成功登录系统','superadmin','222.180.192.1','2016-12-09 15:54:17 017','系统登录','LogService'),
('8a1076ae58e181450158e2936c5b00c5',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.180.192.1','2016-12-09 15:54:22 022','请求出错','LogService'),
('8a1076ae58e181450158e2936c5f00c6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.180.192.1','2016-12-09 15:54:22 022','系统异常','LogService'),
('8a1076ae58e181450158e2936c9e00c7',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.180.192.1','2016-12-09 15:54:22 022','请求出错','LogService'),
('8a1076ae58e181450158e2936ca200c8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.180.192.1','2016-12-09 15:54:22 022','系统异常','LogService'),
('8a1076ae58e181450158e2936ce500c9',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.180.192.1','2016-12-09 15:54:22 022','请求出错','LogService'),
('8a1076ae58e181450158e2936cf300ca',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.180.192.1','2016-12-09 15:54:22 022','系统异常','LogService'),
('8a1076ae58e181450158e2936d3400cb',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.180.192.1','2016-12-09 15:54:22 022','请求出错','LogService'),
('8a1076ae58e181450158e2936d3e00cc',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.180.192.1','2016-12-09 15:54:22 022','系统异常','LogService'),
('8a1076ae58e181450158e2936d7f00cd',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.180.192.1','2016-12-09 15:54:22 022','请求出错','LogService'),
('8a1076ae58e181450158e2936d9000ce',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.180.192.1','2016-12-09 15:54:22 022','系统异常','LogService'),
('8a1076ae58e181450158e2936de000cf',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.180.192.1','2016-12-09 15:54:22 022','系统异常','LogService'),
('8a1076ae58e181450158e293837300d0',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 15:54:28 028','登录系统','LogService'),
('8a1076ae58e181450158e293bc9000d1',1,'切换布局：[layout: ${layout}]','superadmin','222.180.192.1','2016-12-09 15:54:42 042','系统首页','LogService'),
('8a1076ae58e181450158e294a18100d2',1,'切换布局：[layout: ${layout}]','superadmin','113.108.152.98','2016-12-09 15:55:41 041','系统首页','LogService'),
('8a1076ae58e181450158e294c4ba00d3',1,'锁定系统','superadmin','113.108.152.98','2016-12-09 15:55:50 050','个人中心','LogService'),
('8a1076ae58e181450158e294d14200d4',1,'解锁系统','superadmin','113.108.152.98','2016-12-09 15:55:53 053','个人中心','LogService'),
('8a1076ae58e181450158e295745700d5',1,'切换布局：[layout: ${layout}]','superadmin','222.180.192.1','2016-12-09 15:56:35 035','系统首页','LogService'),
('8a1076ae58e181450158e29760ba00d6',3,'错误代码:404，访问路径:/favicon.ico','system','180.102.164.234','2016-12-09 15:58:41 041','系统异常','LogService'),
('8a1076ae58e181450158e297878000d7',1,'用户：[superadmin] 成功登录系统','superadmin','180.102.164.234','2016-12-09 15:58:51 051','系统登录','LogService'),
('8a1076ae58e181450158e299029000d8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:00:28 028','登录系统','LogService'),
('8a1076ae58e181450158e29978d500d9',1,'用户：[superadmin] 成功登录系统','superadmin','27.156.91.17','2016-12-09 16:00:58 058','系统登录','LogService'),
('8a1076ae58e181450158e299853a00da',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.156.91.17','2016-12-09 16:01:01 001','系统异常','LogService'),
('8a1076ae58e181450158e29985ef00db',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','27.156.91.17','2016-12-09 16:01:01 001','请求出错','LogService'),
('8a1076ae58e181450158e299861a00dc',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','27.156.91.17','2016-12-09 16:01:01 001','请求出错','LogService'),
('8a1076ae58e181450158e299861e00dd',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.156.91.17','2016-12-09 16:01:01 001','系统异常','LogService'),
('8a1076ae58e181450158e299864700de',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','27.156.91.17','2016-12-09 16:01:02 002','请求出错','LogService'),
('8a1076ae58e181450158e299865000df',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.156.91.17','2016-12-09 16:01:02 002','系统异常','LogService'),
('8a1076ae58e181450158e299867500e0',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','27.156.91.17','2016-12-09 16:01:02 002','请求出错','LogService'),
('8a1076ae58e181450158e299868200e1',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.156.91.17','2016-12-09 16:01:02 002','系统异常','LogService'),
('8a1076ae58e181450158e29986a200e2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','27.156.91.17','2016-12-09 16:01:02 002','请求出错','LogService'),
('8a1076ae58e181450158e29986b200e3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.156.91.17','2016-12-09 16:01:02 002','系统异常','LogService'),
('8a1076ae58e181450158e29986e400e4',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.156.91.17','2016-12-09 16:01:02 002','系统异常','LogService'),
('8a1076ae58e181450158e299e38900e5',3,'错误代码:404，访问路径:/robots.txt','system','157.55.39.200','2016-12-09 16:01:25 025','系统异常','LogService'),
('8a1076ae58e181450158e29baa9100e6',3,'java.lang.NullPointerException','SYSTEM','199.19.249.196','2016-12-09 16:03:22 022','请求出错','LogService'),
('8a1076ae58e181450158e29bbe6e00e7',1,'用户：[superadmin] 成功登录系统','superadmin','15.203.233.75','2016-12-09 16:03:27 027','系统登录','LogService'),
('8a1076ae58e181450158e29bd37f00e8',3,'错误代码:404，访问路径:/echo.php','system','139.162.81.62','2016-12-09 16:03:32 032','系统异常','LogService'),
('8a1076ae58e181450158e29bf77b00e9',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','15.203.233.75','2016-12-09 16:03:42 042','请求出错','LogService'),
('8a1076ae58e181450158e29bf98e00ea',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','15.203.233.75','2016-12-09 16:03:42 042','请求出错','LogService'),
('8a1076ae58e181450158e29bf99b00eb',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','15.203.233.75','2016-12-09 16:03:42 042','系统异常','LogService'),
('8a1076ae58e181450158e29bfbc500ec',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','15.203.233.75','2016-12-09 16:03:43 043','系统异常','LogService'),
('8a1076ae58e181450158e29bfdaa00ed',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','15.203.233.75','2016-12-09 16:03:43 043','请求出错','LogService'),
('8a1076ae58e181450158e29bfdd700ee',3,'错误代码:404，访问路径:/favicon.ico','superadmin','15.203.233.75','2016-12-09 16:03:43 043','系统异常','LogService'),
('8a1076ae58e181450158e29bffb800ef',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','15.203.233.75','2016-12-09 16:03:44 044','系统异常','LogService'),
('8a1076ae58e181450158e29bffbc00f0',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','15.203.233.75','2016-12-09 16:03:44 044','请求出错','LogService'),
('8a1076ae58e181450158e29c01d900f1',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','15.203.233.75','2016-12-09 16:03:44 044','系统异常','LogService'),
('8a1076ae58e181450158e29c01dd00f2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','15.203.233.75','2016-12-09 16:03:44 044','请求出错','LogService'),
('8a1076ae58e181450158e29c03ed00f3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','15.203.233.75','2016-12-09 16:03:45 045','系统异常','LogService'),
('8a1076ae58e181450158e29cbd1800f4',1,'切换布局：[layout: ${layout}]','superadmin','27.156.91.17','2016-12-09 16:04:32 032','系统首页','LogService'),
('8a1076ae58e181450158e29cd09000f5',1,'切换布局：[layout: ${layout}]','superadmin','27.156.91.17','2016-12-09 16:04:37 037','系统首页','LogService'),
('8a1076ae58e181450158e29d969000f6',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:05:28 028','登录系统','LogService'),
('8a1076ae58e181450158e29fc61e00f7',1,'锁定系统','superadmin','15.203.233.75','2016-12-09 16:07:51 051','个人中心','LogService'),
('8a1076ae58e181450158e29fe38a00f8',1,'解锁系统','superadmin','15.203.233.75','2016-12-09 16:07:59 059','个人中心','LogService'),
('8a1076ae58e181450158e2a0145800f9',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'GET\' not supported','SYSTEM','199.19.249.196','2016-12-09 16:08:11 011','请求出错','LogService'),
('8a1076ae58e181450158e2a02c7800fa',1,'锁定系统','superadmin','15.203.233.75','2016-12-09 16:08:17 017','个人中心','LogService'),
('8a1076ae58e181450158e2a0540700fb',1,'解锁系统','superadmin','15.203.233.75','2016-12-09 16:08:27 027','个人中心','LogService'),
('8a1076ae58e181450158e2a4ea6300fc',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:13:28 028','登录系统','LogService'),
('8a1076ae58e181450158e2a9631900fd',1,'用户：[superadmin] 成功登录系统','superadmin','125.70.231.103','2016-12-09 16:18:21 021','系统登录','LogService'),
('8a1076ae58e181450158e2ad28bb00fe',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:22:28 028','登录系统','LogService'),
('8a1076ae58e181450158e2b1bd6500ff',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:27:28 028','登录系统','LogService'),
('8a1076ae58e181450158e2b392fe0100',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:29:29 029','登录系统','LogService'),
('8a1076ae58e181450158e2b43ee50101',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-09 16:30:13 013','系统异常','LogService'),
('8a1076ae58e181450158e2b9122e0102',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:35:29 029','登录系统','LogService'),
('8a1076ae58e181450158e2bcbc7e0103',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:39:29 029','登录系统','LogService'),
('8a1076ae58e181450158e2bcbc840104',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:39:29 029','登录系统','LogService'),
('8a1076ae58e181450158e2c096070105',1,'用户：[superadmin] 成功登录系统','superadmin','117.71.53.71','2016-12-09 16:43:41 041','系统登录','LogService'),
('8a1076ae58e181450158e2c0a4770106',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.71.53.71','2016-12-09 16:43:45 045','系统异常','LogService'),
('8a1076ae58e181450158e2c2a5020107',3,'错误代码:404，访问路径:/open/doc','superadmin','117.71.53.71','2016-12-09 16:45:56 056','系统异常','LogService'),
('8a1076ae58e181450158e2c385860108',1,'切换布局：[layout: ${layout}]','superadmin','117.71.53.71','2016-12-09 16:46:54 054','系统首页','LogService'),
('8a1076ae58e181450158e2c5e468010a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-09 16:49:29 029','登录系统','LogService'),
('8a1076ae58e181450158e2c64903010b',1,'切换布局：[layout: ${layout}]','superadmin','117.71.53.71','2016-12-09 16:49:55 055','系统首页','LogService'),
('8a1076ae58e181450158e2c70f21010c',1,'用户：[superadmin] 退出系统','superadmin','117.71.53.71','2016-12-09 16:50:46 046','退出系统','LogService'),
('8a1076ae58e181450158e2c7691c010d',1,'用户：[superadmin] 成功登录系统','superadmin','117.71.53.71','2016-12-09 16:51:09 009','系统登录','LogService'),
('8a1076ae58e181450158e2c7fc0e010e',1,'用户：[superadmin] 成功登录系统','superadmin','219.142.20.254','2016-12-09 16:51:46 046','系统登录','LogService'),
('8a1076ae58e181450158e2c80deb010f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.142.20.254','2016-12-09 16:51:51 051','系统异常','LogService'),
('8a1076ae58e181450158e2c83b360110',1,'切换布局：[layout: ${layout}]','superadmin','219.142.20.254','2016-12-09 16:52:02 002','系统首页','LogService'),
('8a1076ae58e181450158e2c8ab520111',1,'用户：[superadmin] 成功登录系统','superadmin','222.173.114.158','2016-12-09 16:52:31 031','系统登录','LogService'),
('8a1076ae58e181450158e2c8b8f00112',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.173.114.158','2016-12-09 16:52:35 035','系统异常','LogService'),
('8a1076ae58e181450158e2c905d20113',1,'用户：[superadmin] 成功登录系统','superadmin','111.11.116.46','2016-12-09 16:52:54 054','系统登录','LogService'),
('8a1076ae58e181450158e2c938cc0114',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.11.116.46','2016-12-09 16:53:07 007','系统异常','LogService'),
('8a1076ae58e181450158e2c9b1b40115',1,'锁定系统','superadmin','222.173.114.158','2016-12-09 16:53:38 038','个人中心','LogService'),
('8a1076ae58e181450158e2c9d51c0116',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.11.116.46','2016-12-09 16:53:47 047','系统异常','LogService'),
('8a1076ae58e181450158e2c9ebe20117',1,'解锁系统','superadmin','222.173.114.158','2016-12-09 16:53:53 053','个人中心','LogService'),
('8a1076ae58e181450158e2ca5c540118',3,'java.lang.NullPointerException','SYSTEM','180.153.214.180','2016-12-09 16:54:22 022','请求出错','LogService'),
('8a1076ae58e181450158e2ca90dd0119',3,'错误代码:404，访问路径:/flow/form/save','superadmin','219.142.20.254','2016-12-09 16:54:35 035','系统异常','LogService'),
('8a1076ae58e181450158e2cabac7011a',1,'用户：[superadmin] 成功登录系统','superadmin','60.174.249.164','2016-12-09 16:54:46 046','系统登录','LogService'),
('8a1076ae58e181450158e2cb2b74011b',1,'用户：[superadmin] 成功登录系统','superadmin','60.174.249.164','2016-12-09 16:55:15 015','系统登录','LogService'),
('8a1076ae58e181450158e2cb55c6011c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:55:26 026','请求出错','LogService'),
('8a1076ae58e181450158e2cb564e011d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:26 026','系统异常','LogService'),
('8a1076ae58e181450158e2cb56aa011e',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:26 026','系统异常','LogService'),
('8a1076ae58e181450158e2cb5712011f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:26 026','系统异常','LogService'),
('8a1076ae58e181450158e2cb574f0120',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:26 026','系统异常','LogService'),
('8a1076ae58e181450158e2cb58d40121',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:27 027','系统异常','LogService'),
('8a1076ae58e181450158e2cb6eea0122',1,'用户：[superadmin] 成功登录系统','superadmin','60.174.249.164','2016-12-09 16:55:32 032','系统登录','LogService'),
('8a1076ae58e181450158e2cb829e0123',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.174.249.164','2016-12-09 16:55:37 037','系统异常','LogService'),
('8a1076ae58e181450158e2cb839b0124',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:55:38 038','请求出错','LogService'),
('8a1076ae58e181450158e2cb83c00125',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:55:38 038','请求出错','LogService'),
('8a1076ae58e181450158e2cb83c50126',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2cb83e40127',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:55:38 038','请求出错','LogService'),
('8a1076ae58e181450158e2cb83ee0128',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2cb84100129',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:55:38 038','请求出错','LogService'),
('8a1076ae58e181450158e2cb8417012a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2cb842f012b',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:55:38 038','请求出错','LogService'),
('8a1076ae58e181450158e2cb843f012c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2cb8476012d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:55:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2cbdf22012e',1,'用户：[superadmin] 成功登录系统','superadmin','58.246.176.10','2016-12-09 16:56:01 001','系统登录','LogService'),
('8a1076ae58e181450158e2cbed2d012f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.246.176.10','2016-12-09 16:56:05 005','系统异常','LogService'),
('8a1076ae58e181450158e2ccc6330130',1,'切换布局：[layout: ${layout}]','superadmin','58.246.176.10','2016-12-09 16:57:00 000','系统首页','LogService'),
('8a1076ae58e181450158e2ce2a1c0131',1,'用户：[superadmin] 成功登录系统','superadmin','60.174.249.164','2016-12-09 16:58:31 031','系统登录','LogService'),
('8a1076ae58e181450158e2ce43c70132',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:58:38 038','系统异常','LogService'),
('8a1076ae58e181450158e2ce47d10133',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:58:39 039','系统异常','LogService'),
('8a1076ae58e181450158e2ce51860134',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:58:41 041','系统异常','LogService'),
('8a1076ae58e181450158e2ce51a20135',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:58:41 041','请求出错','LogService'),
('8a1076ae58e181450158e2ce528d0136',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:58:42 042','请求出错','LogService'),
('8a1076ae58e181450158e2ce528d0137',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:58:42 042','请求出错','LogService'),
('8a1076ae58e181450158e2ce528e0138',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:58:42 042','系统异常','LogService'),
('8a1076ae58e181450158e2ce529b0139',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:58:42 042','请求出错','LogService'),
('8a1076ae58e181450158e2ce52a2013a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:58:42 042','系统异常','LogService'),
('8a1076ae58e181450158e2ce52a3013b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:58:42 042','系统异常','LogService'),
('8a1076ae58e181450158e2ce52be013c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.174.249.164','2016-12-09 16:58:42 042','请求出错','LogService'),
('8a1076ae58e181450158e2ce53aa013d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.174.249.164','2016-12-09 16:58:42 042','系统异常','LogService'),
('8a1076ae58e181450158e2cee0a4013e',1,'用户：[superadmin] 成功登录系统','superadmin','171.43.212.220','2016-12-09 16:59:18 018','系统登录','LogService'),
('8a1076ae58e181450158e2cf18b2013f',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:32 032','系统异常','LogService'),
('8a1076ae58e181450158e2cf1f500140',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:34 034','系统异常','LogService'),
('8a1076ae58e181450158e2cf243d0141',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:35 035','系统异常','LogService'),
('8a1076ae58e181450158e2cf29560142',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:37 037','系统异常','LogService'),
('8a1076ae58e181450158e2cf427b0143',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:43 043','系统异常','LogService'),
('8a1076ae58e181450158e2cf610f0144',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:51 051','系统异常','LogService'),
('8a1076ae58e181450158e2cf63490145',3,'错误代码:404，访问路径:/favicon.ico','system','60.174.249.164','2016-12-09 16:59:52 052','系统异常','LogService'),
('8a1076ae58e181450158e2cf70d80146',1,'切换布局：[layout: ${layout}]','superadmin','60.174.249.164','2016-12-09 16:59:55 055','系统首页','LogService'),
('8a1076ae58e181450158e2cf71b90147',1,'用户：[superadmin] 成功登录系统','superadmin','60.174.249.164','2016-12-09 16:59:55 055','系统登录','LogService'),
('8a1076ae58e181450158e2cf7b2d0148',1,'切换布局：[layout: ${layout}]','superadmin','60.174.249.164','2016-12-09 16:59:58 058','系统首页','LogService'),
('8a1076ae58e181450158e2cf8d1a0149',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','171.43.212.220','2016-12-09 17:00:02 002','请求出错','LogService'),
('8a1076ae58e181450158e2cf9124014a',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','171.43.212.220','2016-12-09 17:00:03 003','请求出错','LogService'),
('8a1076ae58e181450158e2cf9127014b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','171.43.212.220','2016-12-09 17:00:03 003','系统异常','LogService'),
('8a1076ae58e181450158e2cf917f014c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','171.43.212.220','2016-12-09 17:00:03 003','请求出错','LogService'),
('8a1076ae58e181450158e2cf9210014d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','171.43.212.220','2016-12-09 17:00:03 003','系统异常','LogService'),
('8a1076ae58e181450158e2cf9214014e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','171.43.212.220','2016-12-09 17:00:03 003','请求出错','LogService'),
('8a1076ae58e181450158e2cf928c014f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','171.43.212.220','2016-12-09 17:00:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2cf92940150',3,'错误代码:404，访问路径:/favicon.ico','superadmin','171.43.212.220','2016-12-09 17:00:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2cf92980151',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','171.43.212.220','2016-12-09 17:00:04 004','请求出错','LogService'),
('8a1076ae58e181450158e2cf93160152',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','171.43.212.220','2016-12-09 17:00:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2cf93a00153',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','171.43.212.220','2016-12-09 17:00:04 004','系统异常','LogService'),
('8a1076ae58e181450158e2d1d7a70154',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 17:02:32 032','系统登录','LogService'),
('8a1076ae58e181450158e2d1dd270155',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-09 17:02:34 034','系统异常','LogService'),
('8a1076ae58e181450158e2d529f20156',1,'用户：[superadmin] 退出系统','superadmin','60.173.220.146','2016-12-09 17:06:10 010','退出系统','LogService'),
('8a1076ae58e181450158e2d590650157',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-09 17:06:36 036','系统登录','LogService'),
('8a1076ae58e181450158e2d5a8580158',1,'用户：[superadmin] 退出系统','superadmin','222.173.114.158','2016-12-09 17:06:42 042','退出系统','LogService'),
('8a1076ae58e181450158e2d853330159',1,'用户：[superadmin] 成功登录系统','superadmin','125.122.223.255','2016-12-09 17:09:37 037','系统登录','LogService'),
('8a1076ae58e181450158e2d85ffb015a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','125.122.223.255','2016-12-09 17:09:40 040','系统异常','LogService'),
('8a1076ae58e181450158e2dacc23015b',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.122.223.255','2016-12-09 17:12:19 019','请求出错','LogService'),
('8a1076ae58e181450158e2dacc56015c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.122.223.255','2016-12-09 17:12:19 019','系统异常','LogService'),
('8a1076ae58e79bc80158e79c83f50000',1,'用户：[superadmin] 成功登录系统','superadmin','36.5.149.74','2016-12-10 15:22:24 024','系统登录','LogService'),
('8a1076ae58e79bc80158e79c96f90001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.5.149.74','2016-12-10 15:22:28 028','系统异常','LogService'),
('8a1076ae58e79bc80158e79cc85e0002',1,'锁定系统','superadmin','36.5.149.74','2016-12-10 15:22:41 041','个人中心','LogService'),
('8a1076ae58e79bc80158e79ce78f0003',1,'解锁系统','superadmin','36.5.149.74','2016-12-10 15:22:49 049','个人中心','LogService'),
('8a1076ae58e79bc80158e79d6ead0004',1,'用户：[superadmin] 退出系统','superadmin','36.5.149.74','2016-12-10 15:23:24 024','退出系统','LogService'),
('8a1076ae58e79bc80158e7c4293e0005',1,'用户：[superadmin] 成功登录系统','superadmin','175.0.184.239','2016-12-10 16:05:42 042','系统登录','LogService'),
('8a1076ae58e79bc80158e7dd45180006',1,'用户：[superadmin] 成功登录系统','superadmin','111.161.172.88','2016-12-10 16:33:07 007','系统登录','LogService'),
('8a1076ae58e79bc80158e7dd52940007',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.161.172.88','2016-12-10 16:33:11 011','系统异常','LogService'),
('8a1076ae58e79bc80158e7de4fa00008',1,'用户：[superadmin] 成功登录系统','superadmin','101.30.76.80','2016-12-10 16:34:16 016','系统登录','LogService'),
('8a1076ae58e79bc80158e7de63890009',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:34:21 021','系统异常','LogService'),
('8a1076ae58e79bc80158e7dea972000a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:34:39 039','系统异常','LogService'),
('8a1076ae58e79bc80158e7ded8c2000b',1,'切换布局：[layout: ${layout}]','superadmin','101.30.76.80','2016-12-10 16:34:51 051','系统首页','LogService'),
('8a1076ae58e79bc80158e7dedde7000c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:34:52 052','系统异常','LogService'),
('8a1076ae58e79bc80158e7e0100e000d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 16:36:10 010','登录系统','LogService'),
('8a1076ae58e79bc80158e7e259de000e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:38:40 040','系统异常','LogService'),
('8a1076ae58e79bc80158e7e26090000f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:38:42 042','系统异常','LogService'),
('8a1076ae58e79bc80158e7e2e0150010',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:39:15 015','系统异常','LogService'),
('8a1076ae58e79bc80158e7e33d200011',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:39:39 039','系统异常','LogService'),
('8a1076ae58e79bc80158e7e488a20012',1,'切换布局：[layout: ${layout}]','superadmin','111.161.172.88','2016-12-10 16:41:03 003','系统首页','LogService'),
('8a1076ae58e79bc80158e7ea18310013',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Connection reset','SYSTEM','112.5.238.179','2016-12-10 16:47:08 008','请求出错','LogService'),
('8a1076ae58e79bc80158e7ea18390014',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Connection reset','SYSTEM','112.5.238.179','2016-12-10 16:47:08 008','请求错误','LogService'),
('8a1076ae58e79bc80158e7eae5a00015',1,'用户：[superadmin] 退出系统','superadmin','101.30.76.80','2016-12-10 16:48:00 000','退出系统','LogService'),
('8a1076ae58e79bc80158e7eaf0bb0016',1,'用户：[superadmin] 成功登录系统','superadmin','101.30.76.80','2016-12-10 16:48:03 003','系统登录','LogService'),
('8a1076ae58e79bc80158e7eaf5580017',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.30.76.80','2016-12-10 16:48:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e7ec97980018',1,'用户：[superadmin] 成功登录系统','superadmin','116.31.26.43','2016-12-10 16:49:52 052','系统登录','LogService'),
('8a1076ae58e79bc80158e7eca8780019',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.31.26.43','2016-12-10 16:49:56 056','系统异常','LogService'),
('8a1076ae58e79bc80158e7eca8bb001a',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','116.31.26.43','2016-12-10 16:49:56 056','请求出错','LogService'),
('8a1076ae58e79bc80158e7eca913001b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','116.31.26.43','2016-12-10 16:49:56 056','系统异常','LogService'),
('8a1076ae58e79bc80158e7ecf1ce001c',1,'切换布局：[layout: ${layout}]','superadmin','116.31.26.43','2016-12-10 16:50:15 015','系统首页','LogService'),
('8a1076ae58e79bc80158e7ed7e39001d',1,'用户：[superadmin] 成功登录系统','superadmin','60.14.99.2','2016-12-10 16:50:51 051','系统登录','LogService'),
('8a1076ae58e79bc80158e7ed9466001e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.14.99.2','2016-12-10 16:50:56 056','系统异常','LogService'),
('8a1076ae58e79bc80158e7ed946c001f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.14.99.2','2016-12-10 16:50:56 056','请求出错','LogService'),
('8a1076ae58e79bc80158e7ed94a20020',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.14.99.2','2016-12-10 16:50:56 056','系统异常','LogService'),
('8a1076ae58e79bc80158e806846c0021',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 17:18:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e80a2dfa0022',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 17:22:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e80ced2f0023',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 17:25:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e80ced330024',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 17:25:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e80ceff60025',1,'用户：[superadmin] 成功登录系统','superadmin','103.37.140.10','2016-12-10 17:25:11 011','系统登录','LogService'),
('8a1076ae58e79bc80158e80d69150026',1,'切换布局：[layout: ${layout}]','superadmin','103.37.140.10','2016-12-10 17:25:42 042','系统首页','LogService'),
('8a1076ae58e79bc80158e8294f560027',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 17:56:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e82d82480028',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'HEAD\' not supported','SYSTEM','59.111.32.13','2016-12-10 18:00:46 046','请求出错','LogService'),
('8a1076ae58e79bc80158e82d825a0029',3,'错误代码:400，访问路径:/index','system','59.111.32.13','2016-12-10 18:00:46 046','系统异常','LogService'),
('8a1076ae58e79bc80158e844fb51002a',1,'用户：[superadmin] 成功登录系统','superadmin','220.115.235.120','2016-12-10 18:26:24 024','系统登录','LogService'),
('8a1076ae58e79bc80158e8450f71002b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','220.115.235.120','2016-12-10 18:26:29 029','系统异常','LogService'),
('8a1076ae58e79bc80158e8451097002c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','220.115.235.120','2016-12-10 18:26:30 030','系统异常','LogService'),
('8a1076ae58e79bc80158e8453226002d',1,'切换布局：[layout: ${layout}]','superadmin','220.115.235.120','2016-12-10 18:26:38 038','系统首页','LogService'),
('8a1076ae58e79bc80158e849aa77002e',1,'切换布局：[layout: ${layout}]','superadmin','220.115.235.120','2016-12-10 18:31:31 031','系统首页','LogService'),
('8a1076ae58e79bc80158e84a4948002f',1,'切换布局：[layout: ${layout}]','superadmin','220.115.235.120','2016-12-10 18:32:12 012','系统首页','LogService'),
('8a1076ae58e79bc80158e863e16b0030',1,'用户：[superadmin] 成功登录系统','superadmin','202.119.250.155','2016-12-10 19:00:09 009','系统登录','LogService'),
('8a1076ae58e79bc80158e863f6890031',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','202.119.250.155','2016-12-10 19:00:15 015','请求出错','LogService'),
('8a1076ae58e79bc80158e863f6fc0032',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','202.119.250.155','2016-12-10 19:00:15 015','系统异常','LogService'),
('8a1076ae58e79bc80158e86422e00033',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:00:26 026','系统异常','LogService'),
('8a1076ae58e79bc80158e8648a760034',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:00:52 052','系统异常','LogService'),
('8a1076ae58e79bc80158e864932a0035',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:00:55 055','系统异常','LogService'),
('8a1076ae58e79bc80158e864ab4b0036',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:01 001','系统异常','LogService'),
('8a1076ae58e79bc80158e864adbc0037',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:02 002','系统异常','LogService'),
('8a1076ae58e79bc80158e864b17d0038',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:02 002','系统异常','LogService'),
('8a1076ae58e79bc80158e864b5a60039',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e864b67e003a',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e864b6e1003b',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e864b849003c',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e864b8ea003d',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e864bc50003e',3,'错误代码:404，访问路径:/favicon.ico','system','202.119.250.155','2016-12-10 19:01:05 005','系统异常','LogService'),
('8a1076ae58e79bc80158e869667b003f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 19:06:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e86fe9140040',3,'错误代码:404，访问路径:/favicon.ico','system','45.32.24.11','2016-12-10 19:13:18 018','系统异常','LogService'),
('8a1076ae58e79bc80158e86ff92e0041',3,'java.lang.NullPointerException','SYSTEM','45.32.24.11','2016-12-10 19:13:22 022','请求出错','LogService'),
('8a1076ae58e79bc80158e86ff93b0042',3,'错误代码:500，访问路径:/signin/do','system','45.32.24.11','2016-12-10 19:13:22 022','系统异常','LogService'),
('8a1076ae58e79bc80158e86ffebe0043',3,'java.lang.NullPointerException','SYSTEM','45.32.24.11','2016-12-10 19:13:23 023','请求出错','LogService'),
('8a1076ae58e79bc80158e86ffec50044',3,'错误代码:500，访问路径:/signin/do','system','45.32.24.11','2016-12-10 19:13:23 023','系统异常','LogService'),
('8a1076ae58e79bc80158e87021da0045',1,'用户：[superadmin] 成功登录系统','superadmin','45.32.24.11','2016-12-10 19:13:32 032','系统登录','LogService'),
('8a1076ae58e79bc80158e8706d3f0046',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','45.32.24.11','2016-12-10 19:13:51 051','请求出错','LogService'),
('8a1076ae58e79bc80158e8706ea40047',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','45.32.24.11','2016-12-10 19:13:52 052','系统异常','LogService'),
('8a1076ae58e79bc80158e879f0b80048',1,'用户：[superadmin] 成功登录系统','superadmin','171.13.240.78','2016-12-10 19:24:15 015','系统登录','LogService'),
('8a1076ae58e79bc80158e87a78be0049',3,'错误代码:404，访问路径:/favicon.ico','superadmin','171.13.240.78','2016-12-10 19:24:50 050','系统异常','LogService'),
('8a1076ae58e79bc80158e87a798a004a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','171.13.240.78','2016-12-10 19:24:50 050','系统异常','LogService'),
('8a1076ae58e79bc80158e8813495004b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 19:32:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e88c313a004c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 19:44:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e899ed06004d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 19:59:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e8a57300004e',1,'用户：[superadmin] 成功登录系统','superadmin','125.93.203.68','2016-12-10 20:11:46 046','系统登录','LogService'),
('8a1076ae58e79bc80158e8a582b9004f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','125.93.203.68','2016-12-10 20:11:50 050','请求出错','LogService'),
('8a1076ae58e79bc80158e8a582f00050',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','125.93.203.68','2016-12-10 20:11:50 050','系统异常','LogService'),
('8a1076ae58e79bc80158e8a5ce050051',3,'错误代码:404，访问路径:/favicon.ico','system','125.93.203.68','2016-12-10 20:12:10 010','系统异常','LogService'),
('8a1076ae58e79bc80158e8a5fd650052',3,'错误代码:404，访问路径:/favicon.ico','system','125.93.203.68','2016-12-10 20:12:22 022','系统异常','LogService'),
('8a1076ae58e79bc80158e8a8700b0053',1,'用户：[superadmin] 成功登录系统','superadmin','111.41.238.173','2016-12-10 20:15:02 002','系统登录','LogService'),
('8a1076ae58e79bc80158e8a874310054',3,'错误代码:404，访问路径:/favicon.ico','system','125.93.203.68','2016-12-10 20:15:03 003','系统异常','LogService'),
('8a1076ae58e79bc80158e8a874dd0055',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.41.238.173','2016-12-10 20:15:03 003','系统异常','LogService'),
('8a1076ae58e79bc80158e8a8ea400056',1,'切换布局：[layout: ${layout}]','superadmin','125.93.203.68','2016-12-10 20:15:33 033','系统首页','LogService'),
('8a1076ae58e79bc80158e8aa36b70057',1,'用户：[superadmin] 成功登录系统','superadmin','124.205.91.74','2016-12-10 20:16:59 059','系统登录','LogService'),
('8a1076ae58e79bc80158e8aa9b4f0058',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','124.205.91.74','2016-12-10 20:17:24 024','请求出错','LogService'),
('8a1076ae58e79bc80158e8aa9cd60059',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','124.205.91.74','2016-12-10 20:17:25 025','系统异常','LogService'),
('8a1076ae58e79bc80158e8aaa27b005a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.205.91.74','2016-12-10 20:17:26 026','系统异常','LogService'),
('8a1076ae58e79bc80158e8c4f535005c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 20:46:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e8c7b463005d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 20:49:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e8ca738e005e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 20:52:11 011','登录系统','LogService'),
('8a1076ae58e79bc80158e8d6f5e0005f',1,'用户：[superadmin] 成功登录系统','superadmin','113.142.109.206','2016-12-10 21:05:51 051','系统登录','LogService'),
('8a1076ae58e79bc80158e8d6ffb50060',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.142.109.206','2016-12-10 21:05:54 054','系统异常','LogService'),
('8a1076ae58e79bc80158e8d730870061',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.142.109.206','2016-12-10 21:06:06 006','系统异常','LogService'),
('8a1076ae58e79bc80158e8d7610c0062',1,'切换布局：[layout: ${layout}]','superadmin','113.142.109.206','2016-12-10 21:06:19 019','系统首页','LogService'),
('8a1076ae58e79bc80158e8d816d00063',1,'切换布局：[layout: ${layout}]','superadmin','113.142.109.206','2016-12-10 21:07:05 005','系统首页','LogService'),
('8a1076ae58e79bc80158e8d833a20064',1,'用户：[superadmin] 退出系统','superadmin','113.142.109.206','2016-12-10 21:07:12 012','退出系统','LogService'),
('8a1076ae58e79bc80158e8ded2990065',1,'用户：[superadmin] 成功登录系统','superadmin','111.22.72.171','2016-12-10 21:14:26 026','系统登录','LogService'),
('8a1076ae58e79bc80158e8dee01c0066',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.22.72.171','2016-12-10 21:14:30 030','系统异常','LogService'),
('8a1076ae58e79bc80158e8e1aeb90067',1,'用户：[superadmin] 成功登录系统','superadmin','113.142.109.206','2016-12-10 21:17:34 034','系统登录','LogService'),
('8a1076ae58e79bc80158e8e2fec40068',1,'切换布局：[layout: ${layout}]','superadmin','113.142.109.206','2016-12-10 21:19:00 000','系统首页','LogService'),
('8a1076ae58e79bc80158e8e30abd0069',1,'切换布局：[layout: ${layout}]','superadmin','113.142.109.206','2016-12-10 21:19:03 003','系统首页','LogService'),
('8a1076ae58e79bc80158e8e32400006a',1,'锁定系统','superadmin','113.142.109.206','2016-12-10 21:19:09 009','个人中心','LogService'),
('8a1076ae58e79bc80158e8e33276006b',1,'解锁系统','superadmin','113.142.109.206','2016-12-10 21:19:13 013','个人中心','LogService'),
('8a1076ae58e79bc80158e8e40268006c',1,'用户：[superadmin] 退出系统','superadmin','113.142.109.206','2016-12-10 21:20:06 006','退出系统','LogService'),
('8a1076ae58e79bc80158e8ea8b2a006d',1,'用户：[superadmin] 成功登录系统','superadmin','180.155.224.145','2016-12-10 21:27:14 014','系统登录','LogService'),
('8a1076ae58e79bc80158e8ea98ac006e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','180.155.224.145','2016-12-10 21:27:18 018','系统异常','LogService'),
('8a1076ae58e79bc80158e8eb3029006f',1,'切换布局：[layout: ${layout}]','superadmin','180.155.224.145','2016-12-10 21:27:57 057','系统首页','LogService'),
('8a1076ae58e79bc80158e8fafac00070',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 21:45:12 012','登录系统','LogService'),
('8a1076ae58e79bc80158e907ccdc0071',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 21:59:12 012','登录系统','LogService'),
('8a1076ae58e79bc80158e909ba0e0072',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.101.43','2016-12-10 22:01:18 018','系统登录','LogService'),
('8a1076ae58e79bc80158e909c28e0073',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.101.43','2016-12-10 22:01:20 020','系统登录','LogService'),
('8a1076ae58e79bc80158e909d2a10074',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.101.43','2016-12-10 22:01:24 024','系统登录','LogService'),
('8a1076ae58e79bc80158e91231e90075',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','SYSTEM','223.104.101.11','2016-12-10 22:10:33 033','请求错误','LogService'),
('8a1076ae58e79bc80158e91231ea0076',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','SYSTEM','223.104.101.11','2016-12-10 22:10:33 033','请求出错','LogService'),
('8a1076ae58e79bc80158e9123c2a0077',1,'用户：[superadmin] 成功登录系统','superadmin','223.104.101.11','2016-12-10 22:10:36 036','系统登录','LogService'),
('8a1076ae58e79bc80158e9123e380078',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.104.101.11','2016-12-10 22:10:36 036','系统异常','LogService'),
('8a1076ae58e79bc80158e9123f070079',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.104.101.11','2016-12-10 22:10:36 036','系统异常','LogService'),
('8a1076ae58e79bc80158e91262c1007a',3,'java.lang.NullPointerException','SYSTEM','180.163.2.118','2016-12-10 22:10:46 046','请求出错','LogService'),
('8a1076ae58e79bc80158e91371cb007b',1,'用户：[superadmin] 成功登录系统','superadmin','183.69.215.103','2016-12-10 22:11:55 055','系统登录','LogService'),
('8a1076ae58e79bc80158e913865f007c',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:00 000','系统异常','LogService'),
('8a1076ae58e79bc80158e91394fa007d',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:04 004','系统异常','LogService'),
('8a1076ae58e79bc80158e9139aeb007e',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:05 005','系统异常','LogService'),
('8a1076ae58e79bc80158e913d079007f',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:19 019','系统异常','LogService'),
('8a1076ae58e79bc80158e913e91d0080',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:26 026','系统异常','LogService'),
('8a1076ae58e79bc80158e913f9940081',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:30 030','系统异常','LogService'),
('8a1076ae58e79bc80158e913fc4b0082',3,'错误代码:404，访问路径:/favicon.ico','system','183.69.215.103','2016-12-10 22:12:30 030','系统异常','LogService'),
('8a1076ae58e79bc80158e914146f0083',1,'切换布局：[layout: ${layout}]','superadmin','183.69.215.103','2016-12-10 22:12:37 037','系统首页','LogService'),
('8a1076ae58e79bc80158e92604520084',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 22:32:12 012','登录系统','LogService'),
('8a1076ae58e79bc80158e929e1cb0085',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.187.155','2016-12-10 22:36:25 025','系统异常','LogService'),
('8a1076ae58e79bc80158e92e42830086',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 22:41:12 012','登录系统','LogService'),
('8a1076ae58e79bc80158e93018040087',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 22:43:13 013','登录系统','LogService'),
('8a1076ae58e79bc80158e948ea4a0088',1,'用户：[superadmin] 成功登录系统','superadmin','111.161.172.88','2016-12-10 23:10:19 019','系统登录','LogService'),
('8a1076ae58e79bc80158e948ec700089',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.161.172.88','2016-12-10 23:10:20 020','系统异常','LogService'),
('8a1076ae58e79bc80158e94b6c36008a',1,'用户：[superadmin] 成功登录系统','superadmin','222.35.243.47','2016-12-10 23:13:04 004','系统登录','LogService'),
('8a1076ae58e79bc80158e94b7a78008b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.35.243.47','2016-12-10 23:13:07 007','系统异常','LogService'),
('8a1076ae58e79bc80158e94bc01b008c',1,'切换布局：[layout: ${layout}]','superadmin','222.35.243.47','2016-12-10 23:13:25 025','系统首页','LogService'),
('8a1076ae58e79bc80158e94df39d008d',1,'锁定系统','superadmin','222.35.243.47','2016-12-10 23:15:49 049','个人中心','LogService'),
('8a1076ae58e79bc80158e94e0d43008e',1,'解锁系统','superadmin','222.35.243.47','2016-12-10 23:15:56 056','个人中心','LogService'),
('8a1076ae58e79bc80158e94e29b5008f',1,'锁定系统','superadmin','222.35.243.47','2016-12-10 23:16:03 003','个人中心','LogService'),
('8a1076ae58e79bc80158e95053720090',1,'解锁系统','superadmin','222.35.243.47','2016-12-10 23:18:25 025','个人中心','LogService'),
('8a1076ae58e79bc80158e9506a360091',1,'切换布局：[layout: ${layout}]','superadmin','222.35.243.47','2016-12-10 23:18:31 031','系统首页','LogService'),
('8a1076ae58e79bc80158e954b2910092',1,'用户：[superadmin] 成功登录系统','superadmin','101.41.160.67','2016-12-10 23:23:11 011','系统登录','LogService'),
('8a1076ae58e79bc80158e95555a90093',1,'用户：[superadmin] 成功登录系统','superadmin','101.41.160.67','2016-12-10 23:23:53 053','系统登录','LogService'),
('8a1076ae58e79bc80158e955c0a50094',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:21 021','请求出错','LogService'),
('8a1076ae58e79bc80158e955c0b00095',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:21 021','请求错误','LogService'),
('8a1076ae58e79bc80158e955c1a90096',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:21 021','请求出错','LogService'),
('8a1076ae58e79bc80158e955c1b30097',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:21 021','请求错误','LogService'),
('8a1076ae58e79bc80158e955c6580098',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:22 022','请求出错','LogService'),
('8a1076ae58e79bc80158e955c65f0099',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:22 022','请求错误','LogService'),
('8a1076ae58e79bc80158e955c72e009a',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:22 022','请求错误','LogService'),
('8a1076ae58e79bc80158e955c72f009b',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','superadmin','101.41.160.67','2016-12-10 23:24:22 022','请求出错','LogService'),
('8a1076ae58e79bc80158e956568a009c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','101.41.160.67','2016-12-10 23:24:59 059','请求出错','LogService'),
('8a1076ae58e79bc80158e9565813009d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','101.41.160.67','2016-12-10 23:24:59 059','系统异常','LogService'),
('8a1076ae58e79bc80158e9631e0f009e',1,'用户：[superadmin] 成功登录系统','superadmin','220.250.18.244','2016-12-10 23:38:56 056','系统登录','LogService'),
('8a1076ae58e79bc80158e96333e3009f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','220.250.18.244','2016-12-10 23:39:02 002','请求出错','LogService'),
('8a1076ae58e79bc80158e963344000a0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','220.250.18.244','2016-12-10 23:39:02 002','系统异常','LogService'),
('8a1076ae58e79bc80158e9661d7000a1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 23:42:13 013','登录系统','LogService'),
('8a1076ae58e79bc80158e96c86d500a2',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 23:49:13 013','登录系统','LogService'),
('8a1076ae58e79bc80158e9711b8d00a3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 23:54:13 013','登录系统','LogService'),
('8a1076ae58e79bc80158e97205e900a4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-10 23:55:13 013','登录系统','LogService'),
('8a1076ae58e79bc80158e976b16700a5',1,'用户：[superadmin] 成功登录系统','superadmin','117.152.92.201','2016-12-11 00:00:19 019','系统登录','LogService'),
('8a1076ae58e79bc80158e976bfcf00a6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.152.92.201','2016-12-11 00:00:23 023','系统异常','LogService'),
('8a1076ae58e79bc80158e97fc29000a7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 00:10:14 014','登录系统','LogService'),
('8a1076ae58e79bc80158e98477aa00a8',1,'用户：[superadmin] 成功登录系统','superadmin','49.77.234.119','2016-12-11 00:15:22 022','系统登录','LogService'),
('8a1076ae58e79bc80158e984849f00a9',3,'错误代码:404，访问路径:/favicon.ico','superadmin','49.77.234.119','2016-12-11 00:15:25 025','系统异常','LogService'),
('8a1076ae58e79bc80158e9850e3d00aa',3,'错误代码:404，访问路径:/favicon.ico','superadmin','49.77.234.119','2016-12-11 00:16:01 001','系统异常','LogService'),
('8a1076ae58e79bc80158e9850f2100ab',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','49.77.234.119','2016-12-11 00:16:01 001','请求出错','LogService'),
('8a1076ae58e79bc80158e9850f4b00ac',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','49.77.234.119','2016-12-11 00:16:01 001','系统异常','LogService'),
('8a1076ae58e79bc80158e985fd7e00ad',1,'切换布局：[layout: ${layout}]','superadmin','49.77.234.119','2016-12-11 00:17:02 002','系统首页','LogService'),
('8a1076ae58e79bc80158e9862c2a00ae',1,'切换布局：[layout: ${layout}]','superadmin','49.77.234.119','2016-12-11 00:17:14 014','系统首页','LogService'),
('8a1076ae58e79bc80158e98c4ccd00af',3,'错误代码:404，访问路径:/testproxy.php','system','91.196.50.33','2016-12-11 00:23:55 055','系统异常','LogService'),
('8a1076ae58e79bc80158e992b00e00b0',1,'用户：[superadmin] 成功登录系统','superadmin','1.80.147.34','2016-12-11 00:30:54 054','系统登录','LogService'),
('8a1076ae58e79bc80158e992bf9f00b1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','1.80.147.34','2016-12-11 00:30:58 058','系统异常','LogService'),
('8a1076ae58e79bc80158e992d21100b2',1,'切换布局：[layout: ${layout}]','superadmin','1.80.147.34','2016-12-11 00:31:03 003','系统首页','LogService'),
('8a1076ae58e79bc80158e992fcb100b3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 00:31:14 014','登录系统','LogService'),
('8a1076ae58e79bc80158e9959c0200b4',1,'用户：[superadmin] 成功登录系统','superadmin','222.76.10.124','2016-12-11 00:34:05 005','系统登录','LogService'),
('8a1076ae58e79bc80158e995a95a00b5',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.76.10.124','2016-12-11 00:34:09 009','系统异常','LogService'),
('8a1076ae58e79bc80158e995a9d200b6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.76.10.124','2016-12-11 00:34:09 009','请求出错','LogService'),
('8a1076ae58e79bc80158e995aa0d00b7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.76.10.124','2016-12-11 00:34:09 009','系统异常','LogService'),
('8a1076ae58e79bc80158e9a28dfe00b8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 00:48:14 014','登录系统','LogService'),
('8a1076ae58e79bc80158e9af601700b9',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 01:02:14 014','登录系统','LogService'),
('8a1076ae58e79bc80158e9b30a5e00ba',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 01:06:14 014','登录系统','LogService'),
('8a1076ae58e79bc80158e9bbd7c600bb',1,'用户：[superadmin] 成功登录系统','superadmin','116.23.230.200','2016-12-11 01:15:51 051','系统登录','LogService'),
('8a1076ae58e79bc80158e9bc6fb800bc',1,'用户：[superadmin] 成功登录系统','superadmin','116.23.230.200','2016-12-11 01:16:30 030','系统登录','LogService'),
('8a1076ae58e79bc80158e9bc85db00bd',1,'用户：[superadmin] 成功登录系统','superadmin','116.23.230.200','2016-12-11 01:16:36 036','系统登录','LogService'),
('8a1076ae58e79bc80158e9bd04b000be',1,'用户：[superadmin] 成功登录系统','superadmin','116.23.230.200','2016-12-11 01:17:08 008','系统登录','LogService'),
('8a1076ae58e79bc80158e9d894dd00bf',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 01:47:15 015','登录系统','LogService'),
('8a1076ae58e79bc80158e9e029c400c0',1,'用户：[superadmin] 成功登录系统','superadmin','106.37.76.236','2016-12-11 01:55:31 031','系统登录','LogService'),
('8a1076ae58e79bc80158e9e035c500c1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','106.37.76.236','2016-12-11 01:55:34 034','系统异常','LogService'),
('8a1076ae58e79bc80158e9e036b300c2',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','106.37.76.236','2016-12-11 01:55:35 035','请求出错','LogService'),
('8a1076ae58e79bc80158e9e036cc00c3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','106.37.76.236','2016-12-11 01:55:35 035','系统异常','LogService'),
('8a1076ae58e79bc80158e9ff09b800c4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 02:29:15 015','登录系统','LogService'),
('8a1076ae58e79bc80158ea33186700c5',3,'错误代码:404，访问路径:/manager/html','system','112.250.44.101','2016-12-11 03:26:06 006','系统异常','LogService'),
('8a1076ae58e79bc80158ea5b4fbb00c6',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','93.174.93.136','2016-12-11 04:10:02 002','系统异常','LogService'),
('8a1076ae58e79bc80158eb01bdcf00c7',1,'用户：[superadmin] 成功登录系统','superadmin','112.87.144.54','2016-12-11 07:11:49 049','系统登录','LogService'),
('8a1076ae58e79bc80158eb01cd9600c8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','112.87.144.54','2016-12-11 07:11:53 053','系统异常','LogService'),
('8a1076ae58e79bc80158eb01ee5a00c9',1,'切换布局：[layout: ${layout}]','superadmin','112.87.144.54','2016-12-11 07:12:02 002','系统首页','LogService'),
('8a1076ae58e79bc80158eb03b31d00ca',1,'锁定系统','superadmin','112.87.144.54','2016-12-11 07:13:58 058','个人中心','LogService'),
('8a1076ae58e79bc80158eb0c373300cb',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','80.82.78.38','2016-12-11 07:23:16 016','系统异常','LogService'),
('8a1076ae58e79bc80158eb1f717f00cc',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 07:44:16 016','登录系统','LogService'),
('8a1076ae58e79bc80158eb2e06b600cd',3,'错误代码:404，访问路径:/robots.txt','system','66.249.69.178','2016-12-11 08:00:11 011','系统异常','LogService'),
('8a1076ae58e79bc80158eb3dced700ce',1,'用户：[superadmin] 成功登录系统','superadmin','111.199.184.186','2016-12-11 08:17:26 026','系统登录','LogService'),
('8a1076ae58e79bc80158eb3ddbb100cf',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','111.199.184.186','2016-12-11 08:17:29 029','请求出错','LogService'),
('8a1076ae58e79bc80158eb3ddbd000d0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','111.199.184.186','2016-12-11 08:17:29 029','系统异常','LogService'),
('8a1076ae58e79bc80158eb3ddbea00d1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.199.184.186','2016-12-11 08:17:29 029','系统异常','LogService'),
('8a1076ae58e79bc80158eb3e52b500d2',1,'切换布局：[layout: ${layout}]','superadmin','111.199.184.186','2016-12-11 08:17:59 059','系统首页','LogService'),
('8a1076ae58e79bc80158eb511e6900d3',1,'用户：[superadmin] 成功登录系统','superadmin','219.159.78.28','2016-12-11 08:38:31 031','系统登录','LogService'),
('8a1076ae58e79bc80158eb51710c00d4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.159.78.28','2016-12-11 08:38:52 052','系统异常','LogService'),
('8a1076ae58e79bc80158eb51711400d5',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.159.78.28','2016-12-11 08:38:52 052','系统异常','LogService'),
('8a1076ae58e79bc80158eb51723700d6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.159.78.28','2016-12-11 08:38:53 053','系统异常','LogService'),
('8a1076ae58e79bc80158eb5a0ac000d7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 08:48:16 016','登录系统','LogService'),
('8a1076ae58e79bc80158eb5e0b3800d8',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','172.82.166.210','2016-12-11 08:52:38 038','系统异常','LogService'),
('8a1076ae58e79bc80158eb5ea6f600d9',1,'用户：[superadmin] 成功登录系统','superadmin','219.82.59.23','2016-12-11 08:53:18 018','系统登录','LogService'),
('8a1076ae58e79bc80158eb5eb71c00da',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','219.82.59.23','2016-12-11 08:53:22 022','请求出错','LogService'),
('8a1076ae58e79bc80158eb5eb72000db',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.82.59.23','2016-12-11 08:53:22 022','系统异常','LogService'),
('8a1076ae58e79bc80158eb5eb74200dc',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','219.82.59.23','2016-12-11 08:53:22 022','系统异常','LogService'),
('8a1076ae58e79bc80158eb5f84c700dd',1,'切换布局：[layout: ${layout}]','superadmin','219.82.59.23','2016-12-11 08:54:15 015','系统首页','LogService'),
('8a1076ae58e79bc80158eb611a5400de',1,'锁定系统','superadmin','219.82.59.23','2016-12-11 08:55:59 059','个人中心','LogService'),
('8a1076ae58e79bc80158eb6161cf00df',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','219.82.59.23','2016-12-11 08:56:17 017','系统异常','LogService'),
('8a1076ae58e79bc80158eb61634800e0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','219.82.59.23','2016-12-11 08:56:17 017','系统异常','LogService'),
('8a1076ae58e79bc80158eb61ace800e1',1,'解锁系统','superadmin','219.82.59.23','2016-12-11 08:56:36 036','个人中心','LogService'),
('8a1076ae58e79bc80158eb62181f00e2',1,'锁定系统','superadmin','219.82.59.23','2016-12-11 08:57:04 004','个人中心','LogService'),
('8a1076ae58e79bc80158eb6227b800e3',1,'解锁系统','superadmin','219.82.59.23','2016-12-11 08:57:08 008','个人中心','LogService'),
('8a1076ae58e79bc80158eb6254dd00e4',1,'锁定系统','superadmin','219.82.59.23','2016-12-11 08:57:19 019','个人中心','LogService'),
('8a1076ae58e79bc80158eb6266aa00e5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','219.82.59.23','2016-12-11 08:57:24 024','系统异常','LogService'),
('8a1076ae58e79bc80158eb627f4f00e6',1,'解锁系统','superadmin','219.82.59.23','2016-12-11 08:57:30 030','个人中心','LogService'),
('8a1076ae58e79bc80158eb629f4700e7',1,'锁定系统','superadmin','219.82.59.23','2016-12-11 08:57:38 038','个人中心','LogService'),
('8a1076ae58e79bc80158eb62a7da00e8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','219.82.59.23','2016-12-11 08:57:41 041','系统异常','LogService'),
('8a1076ae58e79bc80158eb62a96600e9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','219.82.59.23','2016-12-11 08:57:41 041','系统异常','LogService'),
('8a1076ae58e79bc80158eb6a244a00ea',1,'解锁系统','superadmin','219.82.59.23','2016-12-11 09:05:51 051','个人中心','LogService'),
('8a1076ae58e79bc80158eb6f1a5200eb',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 09:11:16 016','登录系统','LogService'),
('8a1076ae58e79bc80158eb87d36000ec',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 09:38:17 017','登录系统','LogService'),
('8a1076ae58e79bc80158eb9f54fe00ed',1,'用户：[superadmin] 成功登录系统','superadmin','219.82.59.23','2016-12-11 10:03:57 057','系统登录','LogService'),
('8a1076ae58e79bc80158eb9f635000ee',3,'错误代码:404，访问路径:/favicon.ico','superadmin','219.82.59.23','2016-12-11 10:04:01 001','系统异常','LogService'),
('8a1076ae58e79bc80158eba0045400ef',1,'切换布局：[layout: ${layout}]','superadmin','219.82.59.23','2016-12-11 10:04:42 042','系统首页','LogService'),
('8a1076ae58e79bc80158ebb11e2f00f0',1,'用户：[superadmin] 成功登录系统','superadmin','123.232.54.74','2016-12-11 10:23:23 023','系统登录','LogService'),
('8a1076ae58e79bc80158ebb129de00f1',1,'用户：[superadmin] 成功登录系统','superadmin','123.232.54.74','2016-12-11 10:23:26 026','系统登录','LogService'),
('8a1076ae58e79bc80158ebb13f4b00f2',1,'用户：[superadmin] 成功登录系统','superadmin','123.232.54.74','2016-12-11 10:23:31 031','系统登录','LogService'),
('8a1076ae58e79bc80158ebb14da100f3',1,'用户：[superadmin] 成功登录系统','superadmin','123.232.54.74','2016-12-11 10:23:35 035','系统登录','LogService'),
('8a1076ae58e79bc80158ebb168a700f4',1,'用户：[superadmin] 成功登录系统','superadmin','123.232.54.74','2016-12-11 10:23:42 042','系统登录','LogService'),
('8a1076ae58e79bc80158ebb21e0d00f5',1,'用户：[superadmin] 成功登录系统','superadmin','123.232.54.74','2016-12-11 10:24:28 028','系统登录','LogService'),
('8a1076ae58e79bc80158ebb246fd00f6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','123.232.54.74','2016-12-11 10:24:39 039','请求出错','LogService'),
('8a1076ae58e79bc80158ebb2473000f7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','123.232.54.74','2016-12-11 10:24:39 039','系统异常','LogService'),
('8a1076ae58e79bc80158ebb24a9e00f8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.232.54.74','2016-12-11 10:24:40 040','系统异常','LogService'),
('8a1076ae58e79bc80158ebb26ed400f9',1,'切换布局：[layout: ${layout}]','superadmin','123.232.54.74','2016-12-11 10:24:49 049','系统首页','LogService'),
('8a1076ae58e79bc80158ebb72b2900fa',1,'切换布局：[layout: ${layout}]','superadmin','123.232.54.74','2016-12-11 10:29:59 059','系统首页','LogService'),
('8a1076ae58e79bc80158ebbcee6a00fb',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 10:36:17 017','登录系统','LogService'),
('8a1076ae58e79bc80158ebca242e00fc',3,'错误代码:404，访问路径:/manager/html','system','211.147.113.164','2016-12-11 10:50:43 043','系统异常','LogService'),
('8a1076ae58e79bc80158ebcd6a0a00fd',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 10:54:17 017','登录系统','LogService'),
('8a1076ae58e79bc80158ebd2e91500fe',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 11:00:17 017','登录系统','LogService'),
('8a1076ae58e79bc80158ebe8f9eb00ff',1,'用户：[superadmin] 成功登录系统','superadmin','39.128.179.178','2016-12-11 11:24:23 023','系统登录','LogService'),
('8a1076ae58e79bc80158ebe90a190100',3,'错误代码:404，访问路径:/favicon.ico','superadmin','39.128.179.178','2016-12-11 11:24:28 028','系统异常','LogService'),
('8a1076ae58e79bc80158ebe90a620101',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','39.128.179.178','2016-12-11 11:24:28 028','请求出错','LogService'),
('8a1076ae58e79bc80158ebe90ab40102',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','39.128.179.178','2016-12-11 11:24:28 028','系统异常','LogService'),
('8a1076ae58e79bc80158ec062f560103',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 11:56:18 018','登录系统','LogService'),
('8a1076ae58e79bc80158ec19117e0104',1,'用户：[superadmin] 成功登录系统','superadmin','14.153.244.219','2016-12-11 12:16:55 055','系统登录','LogService'),
('8a1076ae58e79bc80158ec1929f00105',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','14.153.244.219','2016-12-11 12:17:01 001','请求出错','LogService'),
('8a1076ae58e79bc80158ec192a120106',3,'错误代码:404，访问路径:/favicon.ico','superadmin','14.153.244.219','2016-12-11 12:17:01 001','系统异常','LogService'),
('8a1076ae58e79bc80158ec192a300107',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','14.153.244.219','2016-12-11 12:17:02 002','系统异常','LogService'),
('8a1076ae58e79bc80158ec23e3020108',1,'用户：[superadmin] 成功登录系统','superadmin','101.229.36.179','2016-12-11 12:28:44 044','系统登录','LogService'),
('8a1076ae58e79bc80158ec23f1750109',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.229.36.179','2016-12-11 12:28:48 048','系统异常','LogService'),
('8a1076ae58e79bc80158ec2432fd010a',1,'切换布局：[layout: ${layout}]','superadmin','101.229.36.179','2016-12-11 12:29:05 005','系统首页','LogService'),
('8a1076ae58e79bc80158ec2469a0010b',1,'切换布局：[layout: ${layout}]','superadmin','101.229.36.179','2016-12-11 12:29:19 019','系统首页','LogService'),
('8a1076ae58e79bc80158ec247399010c',1,'切换布局：[layout: ${layout}]','superadmin','101.229.36.179','2016-12-11 12:29:21 021','系统首页','LogService'),
('8a1076ae58e79bc80158ec35cc1f010d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 12:48:18 018','登录系统','LogService'),
('8a1076ae58e79bc80158ec3a13c9010e',3,'错误代码:404，访问路径:/favicon.ico','system','27.16.95.193','2016-12-11 12:52:58 058','系统异常','LogService'),
('8a1076ae58e79bc80158ec3a2ebc010f',1,'用户：[superadmin] 成功登录系统','superadmin','27.16.95.193','2016-12-11 12:53:05 005','系统登录','LogService'),
('8a1076ae58e79bc80158ec3a3e420110',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.16.95.193','2016-12-11 12:53:09 009','系统异常','LogService'),
('8a1076ae58e79bc80158ec3a57470111',1,'锁定系统','superadmin','27.16.95.193','2016-12-11 12:53:16 016','个人中心','LogService'),
('8a1076ae58e79bc80158ec3a80180112',1,'解锁系统','superadmin','27.16.95.193','2016-12-11 12:53:26 026','个人中心','LogService'),
('8a1076ae58e79bc80158ec3a843e0113',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.16.95.193','2016-12-11 12:53:27 027','系统异常','LogService'),
('8a1076ae58e79bc80158ec3ba5af0114',3,'错误代码:404，访问路径:/testproxy.php','system','91.196.50.33','2016-12-11 12:54:41 041','系统异常','LogService'),
('8a1076ae58e79bc80158ec40c9810115',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 13:00:18 018','登录系统','LogService'),
('8a1076ae58e79bc80158ec5a6cf60116',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 13:28:18 018','登录系统','LogService'),
('8a1076ae58e79bc80158ec67f58c0117',3,'错误代码:404，访问路径:/favicon.ico','system','27.37.151.25','2016-12-11 13:43:05 005','系统异常','LogService'),
('8a1076ae58e79bc80158ec67f9330118',3,'错误代码:404，访问路径:/favicon.ico','system','27.37.151.25','2016-12-11 13:43:06 006','系统异常','LogService'),
('8a1076ae58e79bc80158ec68a8570119',1,'用户：[superadmin] 成功登录系统','superadmin','27.37.151.25','2016-12-11 13:43:51 051','系统登录','LogService'),
('8a1076ae58e79bc80158ec848b4f011a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 14:14:19 019','登录系统','LogService'),
('8a1076ae58e79bc80158ec8989d7011b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','system','219.82.59.23','2016-12-11 14:19:46 046','系统异常','LogService'),
('8a1076ae58e79bc80158ec98dfa7011c',1,'用户：[superadmin] 成功登录系统','superadmin','183.238.76.65','2016-12-11 14:36:31 031','系统登录','LogService'),
('8a1076ae58e79bc80158ec998305011d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.238.76.65','2016-12-11 14:37:13 013','系统异常','LogService'),
('8a1076ae58e79bc80158ec99830a011e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.238.76.65','2016-12-11 14:37:13 013','系统异常','LogService'),
('8a1076ae58e79bc80158ecb15a96011f',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','94.102.49.174','2016-12-11 15:03:15 015','系统异常','LogService'),
('8a1076ae58e79bc80158ecb31dd50120',1,'用户：[superadmin] 成功登录系统','superadmin','175.190.14.46','2016-12-11 15:05:11 011','系统登录','LogService'),
('8a1076ae58e79bc80158ecb3262f0121',1,'用户：[superadmin] 成功登录系统','superadmin','175.190.14.46','2016-12-11 15:05:13 013','系统登录','LogService'),
('8a1076ae58e79bc80158ecb331f10122',1,'用户：[superadmin] 成功登录系统','superadmin','175.190.14.46','2016-12-11 15:05:16 016','系统登录','LogService'),
('8a1076ae58e79bc80158ecb3422d0123',1,'用户：[superadmin] 成功登录系统','superadmin','175.190.14.46','2016-12-11 15:05:20 020','系统登录','LogService'),
('8a1076ae58e79bc80158ecb370720124',1,'用户：[superadmin] 成功登录系统','superadmin','175.190.14.46','2016-12-11 15:05:32 032','系统登录','LogService'),
('8a1076ae58e79bc80158ecb387310125',1,'用户：[superadmin] 成功登录系统','superadmin','175.190.14.46','2016-12-11 15:05:38 038','系统登录','LogService'),
('8a1076ae58e79bc80158ecb5fce40126',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 15:08:19 019','登录系统','LogService'),
('8a1076ae58e79bc80158ecba5a9d0127',1,'用户：[superadmin] 成功登录系统','superadmin','106.38.84.21','2016-12-11 15:13:05 005','系统登录','LogService'),
('8a1076ae58e79bc80158ecc4d7120128',1,'用户：[superadmin] 成功登录系统','superadmin','183.238.76.65','2016-12-11 15:24:32 032','系统登录','LogService'),
('8a1076ae58e79bc80158ecc5255f0129',3,'错误代码:404，访问路径:/favicon.ico','system','119.187.120.188','2016-12-11 15:24:52 052','系统异常','LogService'),
('8a1076ae58e79bc80158ecc5419f012a',1,'用户：[superadmin] 成功登录系统','superadmin','119.187.120.188','2016-12-11 15:25:00 000','系统登录','LogService'),
('8a1076ae58e79bc80158eccfa05b012b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 15:36:19 019','登录系统','LogService'),
('8a1076ae58e79bc80158ecd6f428012c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 15:44:20 020','登录系统','LogService'),
('8a1076ae58e79bc80158ece10707012d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 15:55:20 020','登录系统','LogService'),
('8a1076ae58e79bc80158ece1f167012e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 15:56:20 020','登录系统','LogService'),
('8a1076ae58e79bc80158ed0ee7a5012f',1,'用户：[superadmin] 成功登录系统','superadmin','222.174.115.93','2016-12-11 16:45:26 026','系统登录','LogService'),
('8a1076ae58e79bc80158ed0ef5170130',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.174.115.93','2016-12-11 16:45:30 030','系统异常','LogService'),
('8a1076ae58e79bc80158ed0f6c820131',1,'切换布局：[layout: ${layout}]','superadmin','222.174.115.93','2016-12-11 16:46:00 000','系统首页','LogService'),
('8a1076ae58e79bc80158ed285a640132',1,'用户：[superadmin] 成功登录系统','superadmin','114.254.91.153','2016-12-11 17:13:14 014','系统登录','LogService'),
('8a1076ae58e79bc80158ed28684d0133',3,'错误代码:404，访问路径:/favicon.ico','superadmin','114.254.91.153','2016-12-11 17:13:18 018','系统异常','LogService'),
('8a1076ae58e79bc80158ed2c1b350134',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 17:17:20 020','登录系统','LogService'),
('8a1076ae58e79bc80158ed3382a10135',1,'用户：[superadmin] 成功登录系统','superadmin','121.35.181.8','2016-12-11 17:25:25 025','系统登录','LogService'),
('8a1076ae58e79bc80158ed3390860136',3,'错误代码:404，访问路径:/favicon.ico','superadmin','121.35.181.8','2016-12-11 17:25:29 029','系统异常','LogService'),
('8a1076ae58e79bc80158ed46a90f0137',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 17:46:20 020','登录系统','LogService'),
('8a1076ae58e79bc80158ed51a6610138',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 17:58:21 021','登录系统','LogService'),
('8a1076ae58e79bc80158ed59b4450139',1,'用户：[superadmin] 成功登录系统','superadmin','42.80.199.79','2016-12-11 18:07:08 008','系统登录','LogService'),
('8a1076ae58e79bc80158ed59c274013a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','42.80.199.79','2016-12-11 18:07:12 012','系统异常','LogService'),
('8a1076ae58e79bc80158ed59fe3b013b',1,'切换布局：[layout: ${layout}]','superadmin','42.80.199.79','2016-12-11 18:07:27 027','系统首页','LogService'),
('8a1076ae58e79bc80158ed6322f5013d',3,'错误代码:404，访问路径:/script','system','222.186.34.119','2016-12-11 18:17:27 027','系统异常','LogService'),
('8a1076ae58e79bc80158ed652559013e',1,'用户：[superadmin] 退出系统','superadmin','42.80.199.79','2016-12-11 18:19:38 038','退出系统','LogService'),
('8a1076ae58e79bc80158ed907f76013f',1,'用户：[superadmin] 成功登录系统','superadmin','223.74.152.61','2016-12-11 19:06:59 059','系统登录','LogService'),
('8a1076ae58e79bc80158ed908c690140',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.74.152.61','2016-12-11 19:07:03 003','系统异常','LogService'),
('8a1076ae58e79bc80158ed908d0f0141',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','223.74.152.61','2016-12-11 19:07:03 003','请求出错','LogService'),
('8a1076ae58e79bc80158ed908d430142',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.74.152.61','2016-12-11 19:07:03 003','系统异常','LogService'),
('8a1076ae58e79bc80158ed9e0b8e0143',1,'用户：[superadmin] 成功登录系统','superadmin','211.101.129.210','2016-12-11 19:21:47 047','系统登录','LogService'),
('8a1076ae58e79bc80158ed9eaf880144',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','211.101.129.210','2016-12-11 19:22:29 029','请求出错','LogService'),
('8a1076ae58e79bc80158ed9eaf8c0145',3,'错误代码:404，访问路径:/favicon.ico','superadmin','211.101.129.210','2016-12-11 19:22:29 029','系统异常','LogService'),
('8a1076ae58e79bc80158ed9eafc10146',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','211.101.129.210','2016-12-11 19:22:29 029','系统异常','LogService'),
('8a1076ae58e79bc80158eda2e1920147',1,'用户：[superadmin] 成功登录系统','superadmin','118.199.153.147','2016-12-11 19:27:04 004','系统登录','LogService'),
('8a1076ae58e79bc80158eda30dee0148',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.199.153.147','2016-12-11 19:27:15 015','系统异常','LogService'),
('8a1076ae58e79bc80158eda30e8d0149',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','118.199.153.147','2016-12-11 19:27:16 016','请求出错','LogService'),
('8a1076ae58e79bc80158eda30ee9014a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','118.199.153.147','2016-12-11 19:27:16 016','系统异常','LogService'),
('8a1076ae58e79bc80158edac4b10014b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 19:37:21 021','登录系统','LogService'),
('8a1076ae58e79bc80158edbb1f20014c',3,'错误代码:404，访问路径:/computer/','system','43.251.16.38','2016-12-11 19:53:33 033','系统异常','LogService'),
('8a1076ae58e79bc80158edbf85d7014d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 19:58:21 021','登录系统','LogService'),
('8a1076ae58e79bc80158edbf85da014e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 19:58:21 021','登录系统','LogService'),
('8a1076ae58e79bc80158edc79155014f',3,'错误代码:404，访问路径:/axis2','system','106.111.79.84','2016-12-11 20:07:08 008','系统异常','LogService'),
('8a1076ae58e79bc80158edce53c10150',1,'用户：[superadmin] 成功登录系统','superadmin','14.150.64.57','2016-12-11 20:14:31 031','系统登录','LogService'),
('8a1076ae58e79bc80158edce61530151',3,'错误代码:404，访问路径:/favicon.ico','superadmin','14.150.64.57','2016-12-11 20:14:35 035','系统异常','LogService'),
('8a1076ae58e79bc80158edce61da0152',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','14.150.64.57','2016-12-11 20:14:35 035','请求出错','LogService'),
('8a1076ae58e79bc80158edce62300153',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','14.150.64.57','2016-12-11 20:14:35 035','系统异常','LogService'),
('8a1076ae58e79bc80158edd985cf0155',1,'用户：[superadmin] 成功登录系统','superadmin','27.44.23.86','2016-12-11 20:26:45 045','系统登录','LogService'),
('8a1076ae58e79bc80158ede20f120156',3,'错误代码:404，访问路径:/favicon.ico','system','120.132.49.91','2016-12-11 20:36:05 005','系统异常','LogService'),
('8a1076ae58e79bc80158edec63650157',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 20:47:21 021','登录系统','LogService'),
('8a1076ae58e79bc80158edf58bf80158',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 20:57:22 022','登录系统','LogService'),
('8a1076ae58e79bc80158ee481dcc0159',1,'用户：[superadmin] 成功登录系统','superadmin','183.11.142.207','2016-12-11 22:27:33 033','系统登录','LogService'),
('8a1076ae58e79bc80158ee482abb015a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.11.142.207','2016-12-11 22:27:36 036','系统异常','LogService'),
('8a1076ae58e79bc80158ee5d90e8015b',1,'用户：[superadmin] 成功登录系统','superadmin','223.73.55.183','2016-12-11 22:50:59 059','系统登录','LogService'),
('8a1076ae58e79bc80158ee5d9f84015c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.73.55.183','2016-12-11 22:51:02 002','系统异常','LogService'),
('8a1076ae58e79bc80158ee5dee74015d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.73.55.183','2016-12-11 22:51:23 023','系统异常','LogService'),
('8a1076ae58e79bc80158ee645510015e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 22:58:22 022','登录系统','LogService'),
('8a1076ae58e79bc80158ee652d5e015f',1,'用户：[superadmin] 成功登录系统','superadmin','221.222.203.198','2016-12-11 22:59:17 017','系统登录','LogService'),
('8a1076ae58e79bc80158ee653f5d0160',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.222.203.198','2016-12-11 22:59:22 022','系统异常','LogService'),
('8a1076ae58e79bc80158ee6548ba0161',1,'切换布局：[layout: ${layout}]','superadmin','221.222.203.198','2016-12-11 22:59:24 024','系统首页','LogService'),
('8a1076ae58e79bc80158ee65ff1a0162',1,'切换布局：[layout: ${layout}]','superadmin','221.222.203.198','2016-12-11 23:00:11 011','系统首页','LogService'),
('8a1076ae58e79bc80158ee722f340163',1,'用户：[superadmin] 成功登录系统','superadmin','223.20.161.158','2016-12-11 23:13:30 030','系统登录','LogService'),
('8a1076ae58e79bc80158ee723ed60164',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.20.161.158','2016-12-11 23:13:34 034','系统异常','LogService'),
('8a1076ae58e79bc80158ee723f0d0165',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','223.20.161.158','2016-12-11 23:13:34 034','请求出错','LogService'),
('8a1076ae58e79bc80158ee723f5d0166',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.20.161.158','2016-12-11 23:13:34 034','系统异常','LogService'),
('8a1076ae58e79bc80158ee7371150167',1,'切换布局：[layout: ${layout}]','superadmin','223.73.55.183','2016-12-11 23:14:52 052','系统首页','LogService'),
('8a1076ae58e79bc80158ee828c6d0168',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 23:31:22 022','登录系统','LogService'),
('8a1076ae58e79bc80158ee8e74120169',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-11 23:44:23 023','登录系统','LogService'),
('8a1076ae58e79bc80158ee9d1ae1016a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 00:00:23 023','登录系统','LogService'),
('8a1076ae58e79bc80158eee8e3b7016b',1,'用户：[superadmin] 成功登录系统','superadmin','58.49.49.251','2016-12-12 01:23:09 009','系统登录','LogService'),
('8a1076ae58e79bc80158eee8f2fc016c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.49.49.251','2016-12-12 01:23:13 013','系统异常','LogService'),
('8a1076ae58f0abd60158f0bdf0020000',1,'用户：[superadmin] 成功登录系统','superadmin','120.42.94.53','2016-12-12 09:55:29 029','系统登录','LogService'),
('8a1076ae58f0abd60158f0be03280001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','120.42.94.53','2016-12-12 09:55:34 034','系统异常','LogService'),
('8a1076ae58f0abd60158f0c375e20002',1,'用户：[superadmin] 成功登录系统','superadmin','122.10.232.11','2016-12-12 10:01:31 031','系统登录','LogService'),
('8a1076ae58f0abd60158f0c386e30003',3,'错误代码:404，访问路径:/favicon.ico','superadmin','122.10.232.11','2016-12-12 10:01:35 035','系统异常','LogService'),
('8a1076ae58f0abd60158f0c386ef0004',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','122.10.232.11','2016-12-12 10:01:35 035','请求出错','LogService'),
('8a1076ae58f0abd60158f0c387170005',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','122.10.232.11','2016-12-12 10:01:35 035','系统异常','LogService'),
('8a1076ae58f0abd60158f0ca8c5b0006',1,'用户：[superadmin] 成功登录系统','superadmin','221.237.152.61','2016-12-12 10:09:15 015','系统登录','LogService'),
('8a1076ae58f0abd60158f0ca9b470007',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.237.152.61','2016-12-12 10:09:19 019','系统异常','LogService'),
('8a1076ae58f0abd60158f0ca9b770008',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.237.152.61','2016-12-12 10:09:19 019','请求出错','LogService'),
('8a1076ae58f0abd60158f0ca9bc60009',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.237.152.61','2016-12-12 10:09:19 019','系统异常','LogService'),
('8a1076ae58f0abd60158f0d25e6c000a',1,'用户：[superadmin] 成功登录系统','superadmin','222.132.53.254','2016-12-12 10:17:48 048','系统登录','LogService'),
('8a1076ae58f0abd60158f0d26a37000b',3,'错误代码:404，访问路径:/favicon.ico','system','222.132.53.254','2016-12-12 10:17:51 051','系统异常','LogService'),
('8a1076ae58f0abd60158f0d26b76000c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.132.53.254','2016-12-12 10:17:51 051','请求出错','LogService'),
('8a1076ae58f0abd60158f0d26b93000d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.132.53.254','2016-12-12 10:17:51 051','系统异常','LogService'),
('8a1076ae58f0abd60158f0d36234000e',3,'错误代码:404，访问路径:/favicon.ico','system','222.132.53.254','2016-12-12 10:18:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f0e07ac6000f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 10:33:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f0e083bc0010',1,'用户：[superadmin] 成功登录系统','superadmin','183.14.134.175','2016-12-12 10:33:15 015','系统登录','LogService'),
('8a1076ae58f0abd60158f0e095860011',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.14.134.175','2016-12-12 10:33:20 020','系统异常','LogService'),
('8a1076ae58f0abd60158f0e241530012',1,'切换布局：[layout: ${layout}]','superadmin','183.14.134.175','2016-12-12 10:35:09 009','系统首页','LogService'),
('8a1076ae58f0abd60158f0e2be6d0013',1,'用户：[superadmin] 成功登录系统','superadmin','221.237.112.3','2016-12-12 10:35:41 041','系统登录','LogService'),
('8a1076ae58f0abd60158f0e2d0630014',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.237.112.3','2016-12-12 10:35:46 046','系统异常','LogService'),
('8a1076ae58f0abd60158f0e2d0880015',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.237.112.3','2016-12-12 10:35:46 046','请求出错','LogService'),
('8a1076ae58f0abd60158f0e2d0c70016',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.237.112.3','2016-12-12 10:35:46 046','系统异常','LogService'),
('8a1076ae58f0abd60158f0e7cdf30017',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 10:41:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f0e8b85c0018',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 10:42:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f0e98ff30019',3,'错误代码:404，访问路径:/manager/html','system','139.196.155.17','2016-12-12 10:43:08 008','系统异常','LogService'),
('8a1076ae58f0abd60158f0ebafd5001a',1,'用户：[superadmin] 成功登录系统','superadmin','222.44.86.166','2016-12-12 10:45:27 027','系统登录','LogService'),
('8a1076ae58f0abd60158f0ebde4f001b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.44.86.166','2016-12-12 10:45:39 039','系统异常','LogService'),
('8a1076ae58f0abd60158f0ec862c001c',1,'切换布局：[layout: ${layout}]','superadmin','222.44.86.166','2016-12-12 10:46:22 022','系统首页','LogService'),
('8a1076ae58f0abd60158f0ecfd1e001d',1,'切换布局：[layout: ${layout}]','superadmin','222.44.86.166','2016-12-12 10:46:52 052','系统首页','LogService'),
('8a1076ae58f0abd60158f0f00b85001e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 10:50:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f0f13d52001f',1,'用户：[superadmin] 成功登录系统','superadmin','58.56.115.212','2016-12-12 10:51:31 031','系统登录','LogService'),
('8a1076ae58f0abd60158f0f5a63e0020',1,'切换布局：[layout: ${layout}]','superadmin','58.56.115.212','2016-12-12 10:56:20 020','系统首页','LogService'),
('8a1076ae58f0abd60158f0feb1cc0022',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 11:06:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f0ff9c380023',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 11:07:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f104d6c90024',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.195.120','2016-12-12 11:12:56 056','系统登录','LogService'),
('8a1076ae58f0abd60158f104e4870025',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.195.120','2016-12-12 11:12:59 059','系统异常','LogService'),
('8a1076ae58f0abd60158f104f8ab0026',1,'切换布局：[layout: ${layout}]','superadmin','60.173.195.120','2016-12-12 11:13:04 004','系统首页','LogService'),
('8a1076ae58f0abd60158f10505bb0027',1,'切换布局：[layout: ${layout}]','superadmin','60.173.195.120','2016-12-12 11:13:08 008','系统首页','LogService'),
('8a1076ae58f0abd60158f105f4d10028',1,'锁定系统','superadmin','60.173.195.120','2016-12-12 11:14:09 009','个人中心','LogService'),
('8a1076ae58f0abd60158f10604d70029',1,'解锁系统','superadmin','60.173.195.120','2016-12-12 11:14:13 013','个人中心','LogService'),
('8a1076ae58f0abd60158f11595a8002a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 11:31:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f11854d4002b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 11:34:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f11c48d6002c',1,'用户：[superadmin] 成功登录系统','superadmin','101.247.188.149','2016-12-12 11:38:32 032','系统登录','LogService'),
('8a1076ae58f0abd60158f11c58d7002d',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','101.247.188.149','2016-12-12 11:38:36 036','请求出错','LogService'),
('8a1076ae58f0abd60158f11c5941002e',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','101.247.188.149','2016-12-12 11:38:36 036','系统异常','LogService'),
('8a1076ae58f0abd60158f1252ef3002f',1,'用户：[superadmin] 成功登录系统','superadmin','183.239.173.98','2016-12-12 11:48:15 015','系统登录','LogService'),
('8a1076ae58f0abd60158f126be220030',1,'切换布局：[layout: ${layout}]','superadmin','183.239.173.98','2016-12-12 11:49:57 057','系统首页','LogService'),
('8a1076ae58f0abd60158f12aa5610031',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 11:54:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f136f24e0032',1,'用户：[superadmin] 成功登录系统','superadmin','220.249.99.169','2016-12-12 12:07:39 039','系统登录','LogService'),
('8a1076ae58f0abd60158f1372baa0033',3,'错误代码:404，访问路径:/favicon.ico','superadmin','220.249.99.169','2016-12-12 12:07:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f1372c180034',3,'错误代码:404，访问路径:/favicon.ico','superadmin','220.249.99.169','2016-12-12 12:07:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f138613d0035',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 12:09:13 013','登录系统','LogService'),
('8a1076ae58f0abd60158f1435ea40037',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 12:21:14 014','登录系统','LogService'),
('8a1076ae58f0abd60158f1472a980038',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1472aac0039',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1472aad003a',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1472ab2003b',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1472ac7003c',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1472ae1003d',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1472b03003e',3,'错误代码:404，访问路径:/favicon.ico','system','123.232.54.74','2016-12-12 12:25:22 022','系统异常','LogService'),
('8a1076ae58f0abd60158f1555d2b003f',1,'用户：[superadmin] 成功登录系统','superadmin','123.126.19.50','2016-12-12 12:40:53 053','系统登录','LogService'),
('8a1076ae58f0abd60158f155ca230040',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.126.19.50','2016-12-12 12:41:21 021','系统异常','LogService'),
('8a1076ae58f0abd60158f1586e410041',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 12:44:14 014','登录系统','LogService'),
('8a1076ae58f0abd60158f161beb70042',1,'用户：[superadmin] 成功登录系统','superadmin','223.255.14.108','2016-12-12 12:54:24 024','系统登录','LogService'),
('8a1076ae58f0abd60158f161d25b0043',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','223.255.14.108','2016-12-12 12:54:29 029','请求出错','LogService'),
('8a1076ae58f0abd60158f161d2c20044',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.255.14.108','2016-12-12 12:54:29 029','系统异常','LogService'),
('8a1076ae58f0abd60158f162d2520045',1,'切换布局：[layout: ${layout}]','superadmin','223.255.14.108','2016-12-12 12:55:35 035','系统首页','LogService'),
('8a1076ae58f0abd60158f16fceb30046',1,'用户：[superadmin] 成功登录系统','superadmin','117.36.116.220','2016-12-12 13:09:46 046','系统登录','LogService'),
('8a1076ae58f0abd60158f17019ab0047',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.36.116.220','2016-12-12 13:10:05 005','系统异常','LogService'),
('8a1076ae58f0abd60158f17019dd0048',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.36.116.220','2016-12-12 13:10:05 005','系统异常','LogService'),
('8a1076ae58f0abd60158f174d1570049',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 13:15:14 014','登录系统','LogService'),
('8a1076ae58f0abd60158f17abadf004a',1,'用户：[superadmin] 成功登录系统','superadmin','115.195.164.93','2016-12-12 13:21:42 042','系统登录','LogService'),
('8a1076ae58f0abd60158f17ac961004b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.195.164.93','2016-12-12 13:21:45 045','系统异常','LogService'),
('8a1076ae58f0abd60158f17ac970004c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','115.195.164.93','2016-12-12 13:21:45 045','请求出错','LogService'),
('8a1076ae58f0abd60158f17ac99a004d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','115.195.164.93','2016-12-12 13:21:45 045','系统异常','LogService'),
('8a1076ae58f0abd60158f17e7147004e',1,'用户：[superadmin] 成功登录系统','superadmin','101.81.77.203','2016-12-12 13:25:45 045','系统登录','LogService'),
('8a1076ae58f0abd60158f17e7e0c004f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.81.77.203','2016-12-12 13:25:48 048','系统异常','LogService'),
('8a1076ae58f0abd60158f17e7e130050',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','101.81.77.203','2016-12-12 13:25:48 048','请求出错','LogService'),
('8a1076ae58f0abd60158f17e7e5e0051',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','101.81.77.203','2016-12-12 13:25:48 048','系统异常','LogService'),
('8a1076ae58f0abd60158f17e8f690052',1,'切换布局：[layout: ${layout}]','superadmin','101.81.77.203','2016-12-12 13:25:53 053','系统首页','LogService'),
('8a1076ae58f0abd60158f17ee3a30053',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 13:26:14 014','登录系统','LogService'),
('8a1076ae58f0abd60158f18149b30054',1,'用户：[superadmin] 成功登录系统','superadmin','218.26.251.139','2016-12-12 13:28:51 051','系统登录','LogService'),
('8a1076ae58f0abd60158f1839c3c0055',1,'用户：[superadmin] 成功登录系统','superadmin','116.231.216.218','2016-12-12 13:31:24 024','系统登录','LogService'),
('8a1076ae58f0abd60158f183a9420056',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.231.216.218','2016-12-12 13:31:27 027','系统异常','LogService'),
('8a1076ae58f0abd60158f183aa160057',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','116.231.216.218','2016-12-12 13:31:27 027','请求出错','LogService'),
('8a1076ae58f0abd60158f183aa4a0058',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','116.231.216.218','2016-12-12 13:31:27 027','系统异常','LogService'),
('8a1076ae58f0abd60158f18ca038005a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 13:41:14 014','登录系统','LogService'),
('8a1076ae58f0abd60158f18f8952005b',1,'用户：[superadmin] 成功登录系统','superadmin','61.183.129.187','2016-12-12 13:44:25 025','系统登录','LogService'),
('8a1076ae58f0abd60158f18fe563005c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.183.129.187','2016-12-12 13:44:49 049','系统异常','LogService'),
('8a1076ae58f0abd60158f190b6cc005d',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:45:42 042','系统首页','LogService'),
('8a1076ae58f0abd60158f19105e1005e',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:46:03 003','系统首页','LogService'),
('8a1076ae58f0abd60158f1962d10005f',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:51:40 040','系统首页','LogService'),
('8a1076ae58f0abd60158f19640380060',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-12 13:51:45 045','系统登录','LogService'),
('8a1076ae58f0abd60158f19645b40061',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-12 13:51:47 047','系统异常','LogService'),
('8a1076ae58f0abd60158f19664030062',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:51:54 054','系统首页','LogService'),
('8a1076ae58f0abd60158f196b2a20063',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 13:52:15 015','登录系统','LogService'),
('8a1076ae58f0abd60158f196f9d80064',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:52:33 033','系统首页','LogService'),
('8a1076ae58f0abd60158f19add840065',1,'用户：[superadmin] 成功登录系统','superadmin','113.247.228.202','2016-12-12 13:56:48 048','系统登录','LogService'),
('8a1076ae58f0abd60158f19af4a80066',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.247.228.202','2016-12-12 13:56:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f19af5890067',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.247.228.202','2016-12-12 13:56:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f19bdded0068',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:57:53 053','系统首页','LogService'),
('8a1076ae58f0abd60158f19c08350069',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 13:58:04 004','系统首页','LogService'),
('8a1076ae58f0abd60158f19c3108006a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 13:58:15 015','登录系统','LogService'),
('8a1076ae58f0abd60158f19d71f0006b',1,'切换布局：[layout: ${layout}]','superadmin','113.247.228.202','2016-12-12 13:59:37 037','系统首页','LogService'),
('8a1076ae58f0abd60158f19fb665006c',1,'切换布局：[layout: ${layout}]','superadmin','61.183.129.187','2016-12-12 14:02:05 005','系统首页','LogService'),
('8a1076ae58f0abd60158f1a0c4f9006d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:03:15 015','登录系统','LogService'),
('8a1076ae58f0abd60158f1a384df006e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:06:15 015','登录系统','LogService'),
('8a1076ae58f0abd60158f1a91806006f',3,'错误代码:404，访问路径:/testproxy.php','system','91.196.50.33','2016-12-12 14:12:20 020','系统异常','LogService'),
('8a1076ae58f0abd60158f1aa6f2b0070',1,'用户：[superadmin] 成功登录系统','superadmin','117.91.5.112','2016-12-12 14:13:48 048','系统登录','LogService'),
('8a1076ae58f0abd60158f1aab7870071',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.91.5.112','2016-12-12 14:14:06 006','系统异常','LogService'),
('8a1076ae58f0abd60158f1aac72c0072',1,'切换布局：[layout: ${layout}]','superadmin','117.91.5.112','2016-12-12 14:14:10 010','系统首页','LogService'),
('8a1076ae58f0abd60158f1ac5c390073',1,'用户：[superadmin] 成功登录系统','superadmin','182.148.24.199','2016-12-12 14:15:54 054','系统登录','LogService'),
('8a1076ae58f0abd60158f1ac6a450074',3,'错误代码:404，访问路径:/favicon.ico','superadmin','182.148.24.199','2016-12-12 14:15:58 058','系统异常','LogService'),
('8a1076ae58f0abd60158f1ac6aef0075',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','182.148.24.199','2016-12-12 14:15:58 058','请求出错','LogService'),
('8a1076ae58f0abd60158f1ac6b2e0076',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','182.148.24.199','2016-12-12 14:15:58 058','系统异常','LogService'),
('8a1076ae58f0abd60158f1b316970077',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:23:15 015','登录系统','LogService'),
('8a1076ae58f0abd60158f1ba6a750078',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:31:15 015','登录系统','LogService'),
('8a1076ae58f0abd60158f1bc3ff80079',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:33:16 016','登录系统','LogService'),
('8a1076ae58f0abd60158f1c73d58007a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:45:16 016','登录系统','LogService'),
('8a1076ae58f0abd60158f1c912d8007b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 14:47:16 016','登录系统','LogService'),
('8a1076ae58f0abd60158f1ce4885007c',3,'错误代码:404，访问路径:/bi/','system','122.10.232.11','2016-12-12 14:52:57 057','系统异常','LogService'),
('8a1076ae58f0abd60158f1ce8efb007d',1,'用户：[superadmin] 成功登录系统','superadmin','122.10.232.11','2016-12-12 14:53:15 015','系统登录','LogService'),
('8a1076ae58f0abd60158f1e8894c007e',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','122.10.232.11','2016-12-12 15:21:38 038','系统异常','LogService'),
('8a1076ae58f0abd60158f1e9fa0a007f',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','122.10.232.11','2016-12-12 15:23:12 012','系统异常','LogService'),
('8a1076ae58f0abd60158f1f2cc8f0080',1,'用户：[superadmin] 成功登录系统','superadmin','218.17.197.218','2016-12-12 15:32:50 050','系统登录','LogService'),
('8a1076ae58f0abd60158f1f2dbe00081',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.17.197.218','2016-12-12 15:32:54 054','请求出错','LogService'),
('8a1076ae58f0abd60158f1f2dc2c0082',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.17.197.218','2016-12-12 15:32:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f1fce5eb0083',1,'用户：[superadmin] 成功登录系统','superadmin','61.178.118.37','2016-12-12 15:43:52 052','系统登录','LogService'),
('8a1076ae58f0abd60158f1fcf7ed0084',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:43:57 057','系统异常','LogService'),
('8a1076ae58f0abd60158f1fcf80a0085',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','61.178.118.37','2016-12-12 15:43:57 057','请求出错','LogService'),
('8a1076ae58f0abd60158f1fcf88b0086',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','61.178.118.37','2016-12-12 15:43:57 057','系统异常','LogService'),
('8a1076ae58f0abd60158f1fd09230087',1,'切换布局：[layout: ${layout}]','superadmin','61.178.118.37','2016-12-12 15:44:01 001','系统首页','LogService'),
('8a1076ae58f0abd60158f1fd10b80088',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:03 003','系统异常','LogService'),
('8a1076ae58f0abd60158f1fd1e5c0089',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:07 007','系统异常','LogService'),
('8a1076ae58f0abd60158f1fd2287008a',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:08 008','系统异常','LogService'),
('8a1076ae58f0abd60158f1fdb9b0008b',1,'切换布局：[layout: ${layout}]','superadmin','61.178.118.37','2016-12-12 15:44:47 047','系统首页','LogService'),
('8a1076ae58f0abd60158f1fdc67d008c',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:50 050','系统异常','LogService'),
('8a1076ae58f0abd60158f1fdcb7d008d',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:51 051','系统异常','LogService'),
('8a1076ae58f0abd60158f1fdd025008e',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:52 052','系统异常','LogService'),
('8a1076ae58f0abd60158f1fdd337008f',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:44:53 053','系统异常','LogService'),
('8a1076ae58f0abd60158f1fe434e0090',1,'切换布局：[layout: ${layout}]','superadmin','61.178.118.37','2016-12-12 15:45:22 022','系统首页','LogService'),
('8a1076ae58f0abd60158f1fe69b70091',3,'错误代码:404，访问路径:/favicon.ico','system','61.178.118.37','2016-12-12 15:45:32 032','系统异常','LogService'),
('8a1076ae58f0abd60158f2066b550092',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 15:54:16 016','登录系统','LogService'),
('8a1076ae58f0abd60158f2107e720093',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:05:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f2111fe30094',1,'用户：[superadmin] 成功登录系统','superadmin','125.77.254.154','2016-12-12 16:05:58 058','系统登录','LogService'),
('8a1076ae58f0abd60158f2112f2e0095',3,'错误代码:404，访问路径:/favicon.ico','superadmin','125.77.254.154','2016-12-12 16:06:02 002','系统异常','LogService'),
('8a1076ae58f0abd60158f21292380096',1,'用户：[superadmin] 成功登录系统','superadmin','124.117.227.78','2016-12-12 16:07:33 033','系统登录','LogService'),
('8a1076ae58f0abd60158f21340f70097',3,'错误代码:404，访问路径:/flow/form/save','superadmin','125.77.254.154','2016-12-12 16:08:17 017','系统异常','LogService'),
('8a1076ae58f0abd60158f21419d60098',1,'切换布局：[layout: ${layout}]','superadmin','124.117.227.78','2016-12-12 16:09:13 013','系统首页','LogService'),
('8a1076ae58f0abd60158f21482ef0099',1,'用户：[superadmin] 成功登录系统','superadmin','119.109.4.24','2016-12-12 16:09:40 040','系统登录','LogService'),
('8a1076ae58f0abd60158f2149dcb009a',1,'用户：[superadmin] 成功登录系统','superadmin','49.113.152.43','2016-12-12 16:09:47 047','系统登录','LogService'),
('8a1076ae58f0abd60158f214b9b6009b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.109.4.24','2016-12-12 16:09:54 054','系统异常','LogService'),
('8a1076ae58f0abd60158f214c357009c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','49.113.152.43','2016-12-12 16:09:56 056','请求出错','LogService'),
('8a1076ae58f0abd60158f214c3da009d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','49.113.152.43','2016-12-12 16:09:56 056','系统异常','LogService'),
('8a1076ae58f0abd60158f214c48b009e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','49.113.152.43','2016-12-12 16:09:57 057','系统异常','LogService'),
('8a1076ae58f0abd60158f214c879009f',1,'切换布局：[layout: ${layout}]','superadmin','119.109.4.24','2016-12-12 16:09:58 058','系统首页','LogService'),
('8a1076ae58f0abd60158f214d27a00a0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.117.227.78','2016-12-12 16:10:00 000','系统异常','LogService'),
('8a1076ae58f0abd60158f2154dcf00a1',1,'切换布局：[layout: ${layout}]','superadmin','49.113.152.43','2016-12-12 16:10:32 032','系统首页','LogService'),
('8a1076ae58f0abd60158f21a917500a3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:16:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f21afe2d00a4',1,'用户：[superadmin] 成功登录系统','superadmin','123.139.50.112','2016-12-12 16:16:45 045','系统登录','LogService'),
('8a1076ae58f0abd60158f21b0f3400a5',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.139.50.112','2016-12-12 16:16:49 049','系统异常','LogService'),
('8a1076ae58f0abd60158f21f75bc00a6',1,'切换布局：[layout: ${layout}]','superadmin','125.77.254.154','2016-12-12 16:21:37 037','系统首页','LogService'),
('8a1076ae58f0abd60158f231760b00a7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:41:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f231762500a8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:41:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f23435eb00a9',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:44:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f234c24700aa',1,'用户：[superadmin] 成功登录系统','superadmin','119.96.204.181','2016-12-12 16:44:53 053','系统登录','LogService'),
('8a1076ae58f0abd60158f234d10800ab',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.96.204.181','2016-12-12 16:44:57 057','请求出错','LogService'),
('8a1076ae58f0abd60158f234d14600ac',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.96.204.181','2016-12-12 16:44:57 057','系统异常','LogService'),
('8a1076ae58f0abd60158f234d19500ad',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.96.204.181','2016-12-12 16:44:57 057','系统异常','LogService'),
('8a1076ae58f0abd60158f234ffac00ae',1,'切换布局：[layout: ${layout}]','superadmin','119.96.204.181','2016-12-12 16:45:09 009','系统首页','LogService'),
('8a1076ae58f0abd60158f236f51600b0',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:47:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f23c742100b1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 16:53:17 017','登录系统','LogService'),
('8a1076ae58f0abd60158f23cae4700b2',1,'用户：[superadmin] 成功登录系统','superadmin','221.133.242.138','2016-12-12 16:53:32 032','系统登录','LogService'),
('8a1076ae58f0abd60158f23cbef200b3',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.133.242.138','2016-12-12 16:53:37 037','系统异常','LogService'),
('8a1076ae58f0abd60158f23cbf0c00b4',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.133.242.138','2016-12-12 16:53:37 037','系统异常','LogService'),
('8a1076ae58f0abd60158f242fb4400b5',1,'用户：[superadmin] 成功登录系统','superadmin','218.57.223.166','2016-12-12 17:00:25 025','系统登录','LogService'),
('8a1076ae58f0abd60158f24337cf00b6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','218.57.223.166','2016-12-12 17:00:41 041','请求出错','LogService'),
('8a1076ae58f0abd60158f2433e4600b7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.57.223.166','2016-12-12 17:00:42 042','系统异常','LogService'),
('8a1076ae58f0abd60158f24348f400b8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.57.223.166','2016-12-12 17:00:45 045','系统异常','LogService'),
('8a1076ae58f0abd60158f243703f00b9',1,'用户：[superadmin] 成功登录系统','superadmin','36.110.30.170','2016-12-12 17:00:55 055','系统登录','LogService'),
('8a1076ae58f0abd60158f2437e6800ba',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','36.110.30.170','2016-12-12 17:00:59 059','请求出错','LogService'),
('8a1076ae58f0abd60158f2437e9100bb',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','36.110.30.170','2016-12-12 17:00:59 059','系统异常','LogService'),
('8a1076ae58f0abd60158f2437f8600bc',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.110.30.170','2016-12-12 17:00:59 059','系统异常','LogService'),
('8a1076ae58f0abd60158f2438b6700bd',3,'错误代码:404，访问路径:/open/doc','superadmin','218.57.223.166','2016-12-12 17:01:02 002','系统异常','LogService'),
('8a1076ae58f0abd60158f243b01f00be',3,'错误代码:404，访问路径:/open/doc','system','180.153.214.192','2016-12-12 17:01:12 012','系统异常','LogService'),
('8a1076ae58f0abd60158f243ca2900bf',1,'用户：[superadmin] 成功登录系统','superadmin','36.47.163.200','2016-12-12 17:01:18 018','系统登录','LogService'),
('8a1076ae58f0abd60158f243e05400c0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','36.47.163.200','2016-12-12 17:01:24 024','系统异常','LogService'),
('8a1076ae58f0abd60158f243e0b000c1',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','36.47.163.200','2016-12-12 17:01:24 024','请求出错','LogService'),
('8a1076ae58f0abd60158f243e0fa00c2',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','36.47.163.200','2016-12-12 17:01:24 024','系统异常','LogService'),
('8a1076ae58f0abd60158f245ab1400c3',1,'切换布局：[layout: ${layout}]','superadmin','36.110.30.170','2016-12-12 17:03:21 021','系统首页','LogService'),
('8a1076ae58f0abd60158f247f76c00c4',1,'切换布局：[layout: ${layout}]','superadmin','221.133.242.138','2016-12-12 17:05:52 052','系统首页','LogService'),
('8a1076ae58f0abd60158f24a303d00c5',1,'用户：[superadmin] 成功登录系统','superadmin','202.103.38.82','2016-12-12 17:08:18 018','系统登录','LogService'),
('8a1076ae58f0abd60158f24a4e3000c6',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','202.103.38.82','2016-12-12 17:08:25 025','请求出错','LogService'),
('8a1076ae58f0abd60158f24a4e6d00c7',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','202.103.38.82','2016-12-12 17:08:25 025','系统异常','LogService'),
('8a1076ae58f0abd60158f24a4ef300c8',3,'错误代码:404，访问路径:/favicon.ico','superadmin','202.103.38.82','2016-12-12 17:08:25 025','系统异常','LogService'),
('8a1076ae58f0abd60158f2512b2f00c9',1,'用户：[superadmin] 成功登录系统','superadmin','120.85.77.143','2016-12-12 17:15:55 055','系统登录','LogService'),
('8a1076ae58f0abd60158f251402c00ca',3,'错误代码:404，访问路径:/favicon.ico','superadmin','120.85.77.143','2016-12-12 17:16:00 000','系统异常','LogService'),
('8a1076ae58f0abd60158f25208f800cb',3,'错误代码:404，访问路径:/favicon.ico','superadmin','120.85.77.143','2016-12-12 17:16:52 052','系统异常','LogService'),
('8a1076ae58f0abd60158f2526d6a00cc',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:17:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f257109e00cd',1,'用户：[superadmin] 成功登录系统','superadmin','171.88.141.166','2016-12-12 17:22:21 021','系统登录','LogService'),
('8a1076ae58f0abd60158f25f130300ce',1,'用户：[superadmin] 成功登录系统','superadmin','101.95.155.218','2016-12-12 17:31:06 006','系统登录','LogService'),
('8a1076ae58f0abd60158f25f1f9000cf',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','101.95.155.218','2016-12-12 17:31:10 010','请求出错','LogService'),
('8a1076ae58f0abd60158f25f1fae00d0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','101.95.155.218','2016-12-12 17:31:10 010','系统异常','LogService'),
('8a1076ae58f0abd60158f25f203d00d1',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.95.155.218','2016-12-12 17:31:10 010','系统异常','LogService'),
('8a1076ae58f0abd60158f261146e00d2',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:33:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f261fed500d3',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:34:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f261fedb00d4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:34:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f262494400d5',1,'用户：[superadmin] 成功登录系统','superadmin','116.22.34.243','2016-12-12 17:34:37 037','系统登录','LogService'),
('8a1076ae58f0abd60158f262681b00d6',3,'错误代码:404，访问路径:/favicon.ico','system','116.22.34.243','2016-12-12 17:34:45 045','系统异常','LogService'),
('8a1076ae58f0abd60158f262735d00d7',3,'错误代码:404，访问路径:/favicon.ico','system','116.22.34.243','2016-12-12 17:34:48 048','系统异常','LogService'),
('8a1076ae58f0abd60158f2627c2700d8',3,'错误代码:404，访问路径:/favicon.ico','system','116.22.34.243','2016-12-12 17:34:50 050','系统异常','LogService'),
('8a1076ae58f0abd60158f26281b800d9',3,'错误代码:404，访问路径:/favicon.ico','system','116.22.34.243','2016-12-12 17:34:51 051','系统异常','LogService'),
('8a1076ae58f0abd60158f262d2c000da',3,'错误代码:404，访问路径:/favicon.ico','system','116.22.34.243','2016-12-12 17:35:12 012','系统异常','LogService'),
('8a1076ae58f0abd60158f262f38000db',1,'切换布局：[layout: ${layout}]','superadmin','116.22.34.243','2016-12-12 17:35:20 020','系统首页','LogService'),
('8a1076ae58f0abd60158f266938800dd',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:39:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f26cfcf400de',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:46:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f26de75900df',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:47:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f273666300e0',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 17:53:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f273f1c900e1',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','SYSTEM','113.66.148.73','2016-12-12 17:53:54 054','请求出错','LogService'),
('8a1076ae58f0abd60158f273f1d900e2',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Broken pipe (Write failed)','SYSTEM','113.66.148.73','2016-12-12 17:53:54 054','请求错误','LogService'),
('8a1076ae58f0abd60158f2742b6f00e3',1,'用户：[superadmin] 成功登录系统','superadmin','113.66.148.73','2016-12-12 17:54:09 009','系统登录','LogService'),
('8a1076ae58f0abd60158f275a38900e4',3,'错误代码:404，访问路径:/open/doc','superadmin','113.66.148.73','2016-12-12 17:55:45 045','系统异常','LogService'),
('8a1076ae58f0abd60158f275c25800e5',1,'用户：[superadmin] 退出系统','superadmin','113.66.148.73','2016-12-12 17:55:53 053','退出系统','LogService'),
('8a1076ae58f0abd60158f27a328c00e6',1,'用户：[superadmin] 成功登录系统','superadmin','114.119.117.176','2016-12-12 18:00:44 044','系统登录','LogService'),
('8a1076ae58f0abd60158f27a3f7900e7',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','114.119.117.176','2016-12-12 18:00:47 047','请求出错','LogService'),
('8a1076ae58f0abd60158f27a400900e8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','114.119.117.176','2016-12-12 18:00:47 047','系统异常','LogService'),
('8a1076ae58f0abd60158f27a40b900e9',3,'错误代码:404，访问路径:/favicon.ico','superadmin','114.119.117.176','2016-12-12 18:00:48 048','系统异常','LogService'),
('8a1076ae58f0abd60158f27a4d1900ea',1,'切换布局：[layout: ${layout}]','superadmin','114.119.117.176','2016-12-12 18:00:51 051','系统首页','LogService'),
('8a1076ae58f0abd60158f27a68c600eb',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','114.119.117.176','2016-12-12 18:00:58 058','请求出错','LogService'),
('8a1076ae58f0abd60158f27a6a2200ec',3,'org.springframework.web.HttpRequestMethodNotSupportedException: Request method \'POST\' not supported','superadmin','114.119.117.176','2016-12-12 18:00:58 058','请求出错','LogService'),
('8a1076ae58f0abd60158f27ba3e000ed',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 18:02:18 018','登录系统','LogService'),
('8a1076ae58f0abd60158f280389400ee',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 18:07:19 019','登录系统','LogService'),
('8a1076ae58f0abd60158f292bd3600ef',1,'用户：[superadmin] 成功登录系统','superadmin','1.28.91.251','2016-12-12 18:27:32 032','系统登录','LogService'),
('8a1076ae58f0abd60158f292f51f00f0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','1.28.91.251','2016-12-12 18:27:47 047','系统异常','LogService'),
('8a1076ae58f0abd60158f2935aa400f1',1,'切换布局：[layout: ${layout}]','superadmin','1.28.91.251','2016-12-12 18:28:13 013','系统首页','LogService'),
('8a1076ae58f0abd60158f2971cff00f2',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 18:32:19 019','登录系统','LogService'),
('8a1076ae58f0abd60158f2a1f30800f3',3,'错误代码:404，访问路径:/cache/global/img/gs.gif','system','212.47.246.179','2016-12-12 18:44:09 009','系统异常','LogService'),
('8a1076ae58f0abd60158f2aeebb600f4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 18:58:19 019','登录系统','LogService'),
('8a1076ae58f0abd60158f2b13fb000f5',1,'用户：[superadmin] 成功登录系统','superadmin','120.42.94.53','2016-12-12 19:00:52 052','系统登录','LogService'),
('8a1076ae58f0abd60158f2c38cad00f6',3,'错误代码:404，访问路径:/script','system','49.116.106.116','2016-12-12 19:20:51 051','系统异常','LogService'),
('8a1076ae58f0abd60158f2cef7e000f7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 19:33:19 019','登录系统','LogService'),
('8a1076ae58f0abd60158f309521e00f8',3,'错误代码:404，访问路径:/favicon.ico','system','60.191.66.218','2016-12-12 20:37:04 004','系统异常','LogService'),
('8a1076ae58f0abd60158f3130fea00f9',1,'用户：[superadmin] 成功登录系统','superadmin','123.114.46.98','2016-12-12 20:47:42 042','系统登录','LogService'),
('8a1076ae58f0abd60158f3131c8300fa',3,'错误代码:404，访问路径:/favicon.ico','superadmin','123.114.46.98','2016-12-12 20:47:45 045','系统异常','LogService'),
('8a1076ae58f0abd60158f315399b00fb',3,'错误代码:404，访问路径:/bi/charts/add/step-2','superadmin','123.114.46.98','2016-12-12 20:50:04 004','系统异常','LogService'),
('8a1076ae58f0abd60158f331da3700fc',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 21:21:20 020','登录系统','LogService'),
('8a1076ae58f0abd60158f3335fb700fd',1,'用户：[superadmin] 成功登录系统','superadmin','153.101.231.57','2016-12-12 21:23:00 000','系统登录','LogService'),
('8a1076ae58f0abd60158f333bea000fe',1,'切换布局：[layout: ${layout}]','superadmin','153.101.231.57','2016-12-12 21:23:24 024','系统首页','LogService'),
('8a1076ae58f0abd60158f35011bb00ff',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 21:54:20 020','登录系统','LogService'),
('8a1076ae58f0abd60158f37a87890100',1,'用户：[superadmin] 成功登录系统','superadmin','117.139.10.16','2016-12-12 22:40:43 043','系统登录','LogService'),
('8a1076ae58f0abd60158f37aac760101',1,'切换布局：[layout: ${layout}]','superadmin','117.139.10.16','2016-12-12 22:40:52 052','系统首页','LogService'),
('8a1076ae58f0abd60158f38945ba0102',3,'错误代码:404，访问路径:/script','system','43.251.16.38','2016-12-12 22:56:49 049','系统异常','LogService'),
('8a1076ae58f0abd60158f38ac01d0103',1,'用户：[superadmin] 成功登录系统','superadmin','101.4.137.11','2016-12-12 22:58:26 026','系统登录','LogService'),
('8a1076ae58f0abd60158f38ad4c40104',3,'错误代码:404，访问路径:/favicon.ico','superadmin','101.4.137.11','2016-12-12 22:58:31 031','系统异常','LogService'),
('8a1076ae58f0abd60158f39b25b80105',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 23:16:21 021','登录系统','LogService'),
('8a1076ae58f0abd60158f39ee83c0106',3,'错误代码:404，访问路径:/favicon.ico','system','111.227.106.241','2016-12-12 23:20:27 027','系统异常','LogService'),
('8a1076ae58f0abd60158f3a0dd8f0107',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Connection reset','SYSTEM','221.11.20.107','2016-12-12 23:22:35 035','请求错误','LogService'),
('8a1076ae58f0abd60158f3a0dd950108',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Connection reset','SYSTEM','221.11.20.107','2016-12-12 23:22:35 035','请求出错','LogService'),
('8a1076ae58f0abd60158f3a9cc530109',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-12 23:32:21 021','登录系统','LogService'),
('8a1076ae58f0abd60158f3ab828c010a',1,'用户：[superadmin] 成功登录系统','superadmin','119.136.154.154','2016-12-12 23:34:13 013','系统登录','LogService'),
('8a1076ae58f0abd60158f3abb419010b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.136.154.154','2016-12-12 23:34:26 026','系统异常','LogService'),
('8a1076ae58f0abd60158f3abb4db010c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.136.154.154','2016-12-12 23:34:26 026','请求出错','LogService'),
('8a1076ae58f0abd60158f3abb513010d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.136.154.154','2016-12-12 23:34:26 026','系统异常','LogService'),
('8a1076ae58fafc4b0158fafcd6140000',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-14 09:40:23 023','系统登录','LogService'),
('8a1076ae58fafc4b0158fafcdd8f0001',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-14 09:40:25 025','系统异常','LogService'),
('8a1076ae58fafc4b0158fafe92840002',3,'错误代码:404，访问路径:/favicon.ico','system','113.118.247.234','2016-12-14 09:42:17 017','系统异常','LogService'),
('8a1076ae58fafc4b0158fb0e2e350003',1,'用户：[superadmin] 成功登录系统','superadmin','58.58.179.149','2016-12-14 09:59:20 020','系统登录','LogService'),
('8a1076ae58fafc4b0158fb0e3aef0004',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.58.179.149','2016-12-14 09:59:23 023','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1010b50005',1,'用户：[superadmin] 成功登录系统','superadmin','1.25.99.2','2016-12-14 10:01:23 023','系统登录','LogService'),
('8a1076ae58fafc4b0158fb101eb00006',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','1.25.99.2','2016-12-14 10:01:27 027','请求出错','LogService'),
('8a1076ae58fafc4b0158fb101eeb0007',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','1.25.99.2','2016-12-14 10:01:27 027','系统异常','LogService'),
('8a1076ae58fafc4b0158fb10304f0008',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:01:31 031','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1035610009',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:01:33 033','系统异常','LogService'),
('8a1076ae58fafc4b0158fb103e80000a',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:01:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fb104183000b',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:01:36 036','系统异常','LogService'),
('8a1076ae58fafc4b0158fb104372000c',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:01:36 036','系统异常','LogService'),
('8a1076ae58fafc4b0158fb10840e000d',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:01:53 053','系统异常','LogService'),
('8a1076ae58fafc4b0158fb10a152000e',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:00 000','系统异常','LogService'),
('8a1076ae58fafc4b0158fb10f95d000f',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:23 023','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1103b30010',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:26 026','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1104890011',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:26 026','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1105120012',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:26 026','系统异常','LogService'),
('8a1076ae58fafc4b0158fb11218a0013',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:33 033','系统异常','LogService'),
('8a1076ae58fafc4b0158fb11239c0014',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:34 034','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1126470015',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:34 034','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1128a90016',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fb112b0d0017',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:36 036','系统异常','LogService'),
('8a1076ae58fafc4b0158fb114f6b0018',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:45 045','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1153820019',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:46 046','系统异常','LogService'),
('8a1076ae58fafc4b0158fb115b9e001a',3,'错误代码:404，访问路径:/favicon.ico','system','1.25.99.2','2016-12-14 10:02:48 048','系统异常','LogService'),
('8a1076ae58fafc4b0158fb1af52f001b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 10:13:17 017','登录系统','LogService'),
('8a1076ae58fafc4b0158fb2a85cb001c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 10:30:17 017','登录系统','LogService'),
('8a1076ae58fafc4b0158fb2d44fd001d',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 10:33:17 017','登录系统','LogService'),
('8a1076ae58fafc4b0158fb38efa8001e',1,'用户：[superadmin] 成功登录系统','superadmin','183.6.179.98','2016-12-14 10:46:02 002','系统登录','LogService'),
('8a1076ae58fafc4b0158fb391013001f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.6.179.98','2016-12-14 10:46:10 010','系统异常','LogService'),
('8a1076ae58fafc4b0158fb416a9c0020',3,'错误代码:404，访问路径:/script','system','222.186.21.113','2016-12-14 10:55:18 018','系统异常','LogService'),
('8a1076ae58fafc4b0158fb4288b80021',1,'用户：[superadmin] 成功登录系统','superadmin','115.236.162.162','2016-12-14 10:56:31 031','系统登录','LogService'),
('8a1076ae58fafc4b0158fb429a060022',3,'错误代码:404，访问路径:/favicon.ico','superadmin','115.236.162.162','2016-12-14 10:56:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fb5321770023',1,'用户：[superadmin] 成功登录系统','superadmin','118.112.196.54','2016-12-14 11:14:39 039','系统登录','LogService'),
('8a1076ae58fafc4b0158fb5331390024',3,'错误代码:404，访问路径:/favicon.ico','superadmin','118.112.196.54','2016-12-14 11:14:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fb5332440025',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','118.112.196.54','2016-12-14 11:14:43 043','请求出错','LogService'),
('8a1076ae58fafc4b0158fb5332840026',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','118.112.196.54','2016-12-14 11:14:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fb53ea560027',1,'切换布局：[layout: ${layout}]','superadmin','118.112.196.54','2016-12-14 11:15:30 030','系统首页','LogService'),
('8a1076ae58fafc4b0158fb56c0e50028',1,'用户：[superadmin] 成功登录系统','superadmin','122.224.160.90','2016-12-14 11:18:36 036','系统登录','LogService'),
('8a1076ae58fafc4b0158fb57891a0029',3,'错误代码:404，访问路径:/favicon.ico','superadmin','122.224.160.90','2016-12-14 11:19:27 027','系统异常','LogService'),
('8a1076ae58fafc4b0158fb578d7f002a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','122.224.160.90','2016-12-14 11:19:28 028','系统异常','LogService'),
('8a1076ae58fafc4b0158fb5b0c6d002b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 11:23:17 017','登录系统','LogService'),
('8a1076ae58fafc4b0158fb5e9c4d002c',1,'用户：[superadmin] 成功登录系统','superadmin','124.131.92.128','2016-12-14 11:27:11 011','系统登录','LogService'),
('8a1076ae58fafc4b0158fb5ea9a1002d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.131.92.128','2016-12-14 11:27:14 014','系统异常','LogService'),
('8a1076ae58fafc4b0158fb5eb61c002e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 11:27:18 018','登录系统','LogService'),
('8a1076ae58fafc4b0158fb62ccc1002f',1,'切换布局：[layout: ${layout}]','superadmin','124.131.92.128','2016-12-14 11:31:45 045','系统首页','LogService'),
('8a1076ae58fafc4b0158fb6d46380030',3,'错误代码:404，访问路径:/favicon.ico','system','113.246.85.60','2016-12-14 11:43:12 012','系统异常','LogService'),
('8a1076ae58fafc4b0158fb7106910031',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 11:47:18 018','登录系统','LogService'),
('8a1076ae58fafc4b0158fb73c6a10032',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 11:50:18 018','登录系统','LogService'),
('8a1076ae58fafc4b0158fb73fef80033',1,'用户：[superadmin] 成功登录系统','superadmin','113.200.134.78','2016-12-14 11:50:32 032','系统登录','LogService'),
('8a1076ae58fafc4b0158fb740c9d0034',3,'错误代码:404，访问路径:/favicon.ico','superadmin','113.200.134.78','2016-12-14 11:50:36 036','系统异常','LogService'),
('8a1076ae58fafc4b0158fb7b6c630035',3,'错误代码:404，访问路径:/favicon.ico','system','220.249.99.130','2016-12-14 11:58:39 039','系统异常','LogService'),
('8a1076ae58fafc4b0158fb7ec40e0036',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 12:02:18 018','登录系统','LogService'),
('8a1076ae58fafc4b0158fb902a1c0037',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 12:21:19 019','登录系统','LogService'),
('8a1076ae58fafc4b0158fb9a32a80038',1,'用户：[superadmin] 成功登录系统','superadmin','113.200.134.78','2016-12-14 12:32:16 016','系统登录','LogService'),
('8a1076ae58fafc4b0158fba6b5950039',3,'错误代码:404，访问路径:/favicon.ico','system','113.246.85.60','2016-12-14 12:45:56 056','系统异常','LogService'),
('8a1076ae58fafc4b0158fbaa53eb003a',1,'切换布局：[layout: ${layout}]','superadmin','113.200.134.78','2016-12-14 12:49:53 053','系统首页','LogService'),
('8a1076ae58fafc4b0158fbaa6035003b',1,'切换布局：[layout: ${layout}]','superadmin','113.200.134.78','2016-12-14 12:49:56 056','系统首页','LogService'),
('8a1076ae58fafc4b0158fbcbadde003c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 13:26:19 019','登录系统','LogService'),
('8a1076ae58fafc4b0158fbcf65d1003d',1,'用户：[superadmin] 成功登录系统','superadmin','220.169.30.117','2016-12-14 13:30:23 023','系统登录','LogService'),
('8a1076ae58fafc4b0158fbcf730c003e',3,'错误代码:404，访问路径:/favicon.ico','superadmin','220.169.30.117','2016-12-14 13:30:26 026','系统异常','LogService'),
('8a1076ae58fafc4b0158fbcf73b3003f',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','220.169.30.117','2016-12-14 13:30:26 026','请求出错','LogService'),
('8a1076ae58fafc4b0158fbcf73ed0040',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','220.169.30.117','2016-12-14 13:30:26 026','系统异常','LogService'),
('8a1076ae58fafc4b0158fbcf937f0041',1,'切换布局：[layout: ${layout}]','superadmin','220.169.30.117','2016-12-14 13:30:34 034','系统首页','LogService'),
('8a1076ae58fafc4b0158fbd44dea0042',3,'错误代码:404，访问路径:/favicon.ico','system','122.224.160.90','2016-12-14 13:35:44 044','系统异常','LogService'),
('8a1076ae58fafc4b0158fbde30f90043',1,'用户：[superadmin] 成功登录系统','superadmin','119.6.64.163','2016-12-14 13:46:32 032','系统登录','LogService'),
('8a1076ae58fafc4b0158fbde42c20044',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.6.64.163','2016-12-14 13:46:37 037','系统异常','LogService'),
('8a1076ae58fafc4b0158fbde43060045',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.6.64.163','2016-12-14 13:46:37 037','系统异常','LogService'),
('8a1076ae58fafc4b0158fbea40490046',1,'用户：[superadmin] 成功登录系统','superadmin','59.56.61.153','2016-12-14 13:59:42 042','系统登录','LogService'),
('8a1076ae58fafc4b0158fbea76280047',3,'错误代码:404，访问路径:/favicon.ico','superadmin','59.56.61.153','2016-12-14 13:59:56 056','系统异常','LogService'),
('8a1076ae58fafc4b0158fbeabf4f0048',3,'错误代码:404，访问路径:/net_test.php','system','117.18.4.59','2016-12-14 14:00:15 015','系统异常','LogService'),
('8a1076ae58fafc4b0158fbeacd330049',3,'错误代码:404，访问路径:/net_test.php','system','117.18.4.59','2016-12-14 14:00:18 018','系统异常','LogService'),
('8a1076ae58fafc4b0158fbead209004a',3,'错误代码:404，访问路径:/net_test.php','system','117.18.4.59','2016-12-14 14:00:20 020','系统异常','LogService'),
('8a1076ae58fafc4b0158fbec5407004b',1,'用户：[superadmin] 成功登录系统','superadmin','223.87.36.137','2016-12-14 14:01:59 059','系统登录','LogService'),
('8a1076ae58fafc4b0158fbec65a4004c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.87.36.137','2016-12-14 14:02:03 003','系统异常','LogService'),
('8a1076ae58fafc4b0158fbec8a35004d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.87.36.137','2016-12-14 14:02:12 012','系统异常','LogService'),
('8a1076ae58fafc4b0158fbec8abc004e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','223.87.36.137','2016-12-14 14:02:13 013','请求出错','LogService'),
('8a1076ae58fafc4b0158fbec8b08004f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','223.87.36.137','2016-12-14 14:02:13 013','系统异常','LogService'),
('8a1076ae58fafc4b0158fbecdc4d0050',1,'切换布局：[layout: ${layout}]','superadmin','223.87.36.137','2016-12-14 14:02:33 033','系统首页','LogService'),
('8a1076ae58fafc4b0158fbef63aa0051',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 14:05:19 019','登录系统','LogService'),
('8a1076ae58fafc4b0158fbfd20320052',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 14:20:19 019','登录系统','LogService'),
('8a1076ae58fafc4b0158fbfdefec0053',1,'用户：[superadmin] 成功登录系统','superadmin','119.137.55.220','2016-12-14 14:21:13 013','系统登录','LogService'),
('8a1076ae58fafc4b0158fbfdfd940054',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.137.55.220','2016-12-14 14:21:16 016','系统异常','LogService'),
('8a1076ae58fafc4b0158fbff84cb0055',1,'切换布局：[layout: ${layout}]','superadmin','119.137.55.220','2016-12-14 14:22:56 056','系统首页','LogService'),
('8a1076ae58fafc4b0158fc0163c50056',1,'用户：[superadmin] 成功登录系统','superadmin','211.141.83.125','2016-12-14 14:24:59 059','系统登录','LogService'),
('8a1076ae58fafc4b0158fc017d180057',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','211.141.83.125','2016-12-14 14:25:05 005','请求出错','LogService'),
('8a1076ae58fafc4b0158fc017d720058',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','211.141.83.125','2016-12-14 14:25:05 005','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0544430059',1,'切换布局：[layout: ${layout}]','superadmin','211.141.83.125','2016-12-14 14:29:13 013','系统首页','LogService'),
('8a1076ae58fafc4b0158fc07327e005a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 14:31:19 019','登录系统','LogService'),
('8a1076ae58fafc4b0158fc09080e005b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 14:33:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc0af25a005c',1,'用户：[superadmin] 成功登录系统','superadmin','211.141.83.125','2016-12-14 14:35:25 025','系统登录','LogService'),
('8a1076ae58fafc4b0158fc0b027b005d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','211.141.83.125','2016-12-14 14:35:29 029','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0ce11d005e',1,'用户：[superadmin] 成功登录系统','superadmin','221.10.170.69','2016-12-14 14:37:32 032','系统登录','LogService'),
('8a1076ae58fafc4b0158fc0ceda5005f',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.10.170.69','2016-12-14 14:37:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0ceddc0060',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','221.10.170.69','2016-12-14 14:37:35 035','请求出错','LogService'),
('8a1076ae58fafc4b0158fc0cee1b0061',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','221.10.170.69','2016-12-14 14:37:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0cf83b0062',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.10.170.69','2016-12-14 14:37:38 038','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0d02d30063',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.10.170.69','2016-12-14 14:37:40 040','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0d06430064',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.10.170.69','2016-12-14 14:37:41 041','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0d098b0065',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.10.170.69','2016-12-14 14:37:42 042','系统异常','LogService'),
('8a1076ae58fafc4b0158fc0d213a0066',1,'切换布局：[layout: ${layout}]','superadmin','221.10.170.69','2016-12-14 14:37:48 048','系统首页','LogService'),
('8a1076ae58fafc4b0158fc0d299a0067',3,'错误代码:404，访问路径:/favicon.ico','superadmin','221.10.170.69','2016-12-14 14:37:50 050','系统异常','LogService'),
('8a1076ae58fafc4b0158fc13e9400068',1,'用户：[superadmin] 成功登录系统','superadmin','119.131.245.251','2016-12-14 14:45:13 013','系统登录','LogService'),
('8a1076ae58fafc4b0158fc1467780069',1,'用户：[superadmin] 成功登录系统','superadmin','119.131.245.251','2016-12-14 14:45:45 045','系统登录','LogService'),
('8a1076ae58fafc4b0158fc147c9f006a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.131.245.251','2016-12-14 14:45:50 050','系统异常','LogService'),
('8a1076ae58fafc4b0158fc147cde006b',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','119.131.245.251','2016-12-14 14:45:50 050','请求出错','LogService'),
('8a1076ae58fafc4b0158fc147d1b006c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.131.245.251','2016-12-14 14:45:51 051','系统异常','LogService'),
('8a1076ae58fafc4b0158fc1a5dcb006d',3,'错误代码:404，访问路径:/favicon.ico','system','122.224.160.90','2016-12-14 14:52:16 016','系统异常','LogService'),
('8a1076ae58fafc4b0158fc1b588e006e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 14:53:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc227b4d006f',1,'用户：[superadmin] 成功登录系统','superadmin','115.205.233.202','2016-12-14 15:01:08 008','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2289c00070',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','115.205.233.202','2016-12-14 15:01:11 011','请求出错','LogService'),
('8a1076ae58fafc4b0158fc2289de0071',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','115.205.233.202','2016-12-14 15:01:11 011','系统异常','LogService'),
('8a1076ae58fafc4b0158fc249f7a0072',3,'错误代码:404，访问路径:/favicon.ico','system','122.224.160.90','2016-12-14 15:03:28 028','系统异常','LogService'),
('8a1076ae58fafc4b0158fc27404e0073',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:06:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc2915cc0074',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:08:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc2aa9500075',1,'用户：[superadmin] 成功登录系统','superadmin','118.206.184.248','2016-12-14 15:10:04 004','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2ae2c40076',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:10:18 018','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2afe990077',3,'错误代码:404，访问路径:/favicon.ico','superadmin','223.85.244.7','2016-12-14 15:10:25 025','系统异常','LogService'),
('8a1076ae58fafc4b0158fc2b52930078',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:10:47 047','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2b5d270079',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:10:50 050','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2b6e1f007a',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:10:54 054','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2b7e22007b',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:10:58 058','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2b9f69007c',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:11:07 007','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2bff15007d',1,'用户：[superadmin] 成功登录系统','superadmin','223.85.244.7','2016-12-14 15:11:31 031','系统登录','LogService'),
('8a1076ae58fafc4b0158fc2cfecf007e',1,'切换布局：[layout: ${layout}]','superadmin','223.85.244.7','2016-12-14 15:12:37 037','系统首页','LogService'),
('8a1076ae58fafc4b0158fc2e9435007f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:14:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc3068fc0080',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:16:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc3153640081',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:17:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc31a4be0082',1,'用户：[superadmin] 成功登录系统','superadmin','58.63.50.214','2016-12-14 15:17:41 041','系统登录','LogService'),
('8a1076ae58fafc4b0158fc31b2d30083',3,'错误代码:404，访问路径:/favicon.ico','superadmin','58.63.50.214','2016-12-14 15:17:45 045','系统异常','LogService'),
('8a1076ae58fafc4b0158fc31b3340084',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','58.63.50.214','2016-12-14 15:17:45 045','请求出错','LogService'),
('8a1076ae58fafc4b0158fc31b3710085',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','58.63.50.214','2016-12-14 15:17:45 045','系统异常','LogService'),
('8a1076ae58fafc4b0158fc3381a00086',1,'用户：[superadmin] 成功登录系统','superadmin','111.40.11.179','2016-12-14 15:19:43 043','系统登录','LogService'),
('8a1076ae58fafc4b0158fc33ce2b0087',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.40.11.179','2016-12-14 15:20:03 003','系统异常','LogService'),
('8a1076ae58fafc4b0158fc33cedc0088',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','111.40.11.179','2016-12-14 15:20:03 003','请求出错','LogService'),
('8a1076ae58fafc4b0158fc33cf0d0089',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','111.40.11.179','2016-12-14 15:20:03 003','系统异常','LogService'),
('8a1076ae58fafc4b0158fc343471008a',1,'切换布局：[layout: ${layout}]','superadmin','58.63.50.214','2016-12-14 15:20:29 029','系统首页','LogService'),
('8a1076ae58fafc4b0158fc39f56e008b',3,'错误代码:404，访问路径:/favicon.ico','system','122.224.160.90','2016-12-14 15:26:46 046','系统异常','LogService'),
('8a1076ae58fafc4b0158fc3db9fd008c',1,'用户：[superadmin] 成功登录系统','superadmin','175.0.159.209','2016-12-14 15:30:53 053','系统登录','LogService'),
('8a1076ae58fafc4b0158fc3dc8a1008d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','175.0.159.209','2016-12-14 15:30:57 057','系统异常','LogService'),
('8a1076ae58fafc4b0158fc3dc8ac008e',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','175.0.159.209','2016-12-14 15:30:57 057','请求出错','LogService'),
('8a1076ae58fafc4b0158fc3dc8e3008f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','175.0.159.209','2016-12-14 15:30:57 057','系统异常','LogService'),
('8a1076ae58fafc4b0158fc3f0f3d0090',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:32:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc43f8d20091',1,'用户：[superadmin] 成功登录系统','superadmin','61.130.0.179','2016-12-14 15:37:42 042','系统登录','LogService'),
('8a1076ae58fafc4b0158fc4403fe0092',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.130.0.179','2016-12-14 15:37:45 045','系统异常','LogService'),
('8a1076ae58fafc4b0158fc445e5c0093',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.130.0.179','2016-12-14 15:38:08 008','系统异常','LogService'),
('8a1076ae58fafc4b0158fc46f01c0094',1,'用户：[superadmin] 成功登录系统','superadmin','103.233.82.144','2016-12-14 15:40:57 057','系统登录','LogService'),
('8a1076ae58fafc4b0158fc470aae0095',3,'错误代码:404，访问路径:/favicon.ico','superadmin','103.233.82.144','2016-12-14 15:41:04 004','系统异常','LogService'),
('8a1076ae58fafc4b0158fc474cca0096',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:41:20 020','登录系统','LogService'),
('8a1076ae58fafc4b0158fc4753290097',1,'切换布局：[layout: ${layout}]','superadmin','103.233.82.144','2016-12-14 15:41:22 022','系统首页','LogService'),
('8a1076ae58fafc4b0158fc4bf6b90098',1,'用户：[superadmin] 成功登录系统','superadmin','218.249.210.107','2016-12-14 15:46:26 026','系统登录','LogService'),
('8a1076ae58fafc4b0158fc4c38be0099',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.249.210.107','2016-12-14 15:46:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fc4c3987009a',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.249.210.107','2016-12-14 15:46:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fc5074b8009b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:51:21 021','登录系统','LogService'),
('8a1076ae58fafc4b0158fc5074bd009c',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 15:51:21 021','登录系统','LogService'),
('8a1076ae58fafc4b0158fc51dcae009d',1,'锁定系统','superadmin','223.85.244.7','2016-12-14 15:52:53 053','个人中心','LogService'),
('8a1076ae58fafc4b0158fc520177009e',1,'解锁系统','superadmin','223.85.244.7','2016-12-14 15:53:02 002','个人中心','LogService'),
('8a1076ae58fafc4b0158fc523012009f',3,'错误代码:404，访问路径:/open/doc','superadmin','223.85.244.7','2016-12-14 15:53:14 014','系统异常','LogService'),
('8a1076ae58fafc4b0158fc52dcea00a0',1,'用户：[superadmin] 成功登录系统','superadmin','61.144.226.117','2016-12-14 15:53:58 058','系统登录','LogService'),
('8a1076ae58fafc4b0158fc52ee6d00a1',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','61.144.226.117','2016-12-14 15:54:03 003','请求出错','LogService'),
('8a1076ae58fafc4b0158fc52ee8900a2',3,'错误代码:404，访问路径:/favicon.ico','superadmin','61.144.226.117','2016-12-14 15:54:03 003','系统异常','LogService'),
('8a1076ae58fafc4b0158fc52eee500a3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','61.144.226.117','2016-12-14 15:54:03 003','系统异常','LogService'),
('8a1076ae58fafc4b0158fc53d79200a4',1,'切换布局：[layout: ${layout}]','superadmin','61.144.226.117','2016-12-14 15:55:02 002','系统首页','LogService'),
('8a1076ae58fafc4b0158fc543b5900a5',3,'错误代码:404，访问路径:/open/doc','superadmin','61.144.226.117','2016-12-14 15:55:28 028','系统异常','LogService'),
('8a1076ae58fafc4b0158fc54434c00a6',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-14 15:55:30 030','系统登录','LogService'),
('8a1076ae58fafc4b0158fc54472200a7',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-14 15:55:31 031','系统异常','LogService'),
('8a1076ae58fafc4b0158fc54479b00a8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 15:55:31 031','系统异常','LogService'),
('8a1076ae58fafc4b0158fc5507b700a9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','61.144.226.117','2016-12-14 15:56:20 020','系统异常','LogService'),
('8a1076ae58fafc4b0158fc56147000aa',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-14 15:57:29 029','系统异常','LogService'),
('8a1076ae58fafc4b0158fc56156c00ab',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 15:57:29 029','系统异常','LogService'),
('8a1076ae58fafc4b0158fc561fad00ac',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 15:57:32 032','系统异常','LogService'),
('8a1076ae58fafc4b0158fc56348900ad',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 15:57:37 037','系统异常','LogService'),
('8a1076ae58fafc4b0158fc56707200ae',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 15:57:53 053','系统异常','LogService'),
('8a1076ae58fafc4b0158fc56734300af',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','60.173.220.146','2016-12-14 15:57:53 053','请求出错','LogService'),
('8a1076ae58fafc4b0158fc56738e00b0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 15:57:53 053','系统异常','LogService'),
('8a1076ae58fafc4b0158fc5a87ba00b1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:02:21 021','登录系统','LogService'),
('8a1076ae58fafc4b0158fc60f12a00b2',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:09:21 021','登录系统','LogService'),
('8a1076ae58fafc4b0158fc613bf400b3',3,'错误代码:404，访问路径:/favicon.ico','system','180.150.188.118','2016-12-14 16:09:40 040','系统异常','LogService'),
('8a1076ae58fafc4b0158fc649b7500b4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:13:21 021','登录系统','LogService'),
('8a1076ae58fafc4b0158fc6845b800b5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:17:21 021','登录系统','LogService'),
('8a1076ae58fafc4b0158fc6869d900b6',1,'用户：[superadmin] 成功登录系统','superadmin','183.129.242.122','2016-12-14 16:17:31 031','系统登录','LogService'),
('8a1076ae58fafc4b0158fc6874a200b7',3,'错误代码:404，访问路径:/favicon.ico','superadmin','183.129.242.122','2016-12-14 16:17:33 033','系统异常','LogService'),
('8a1076ae58fafc4b0158fc68771a00b8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','183.129.242.122','2016-12-14 16:17:34 034','系统异常','LogService'),
('8a1076ae58fafc4b0158fc68771e00b9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','183.129.242.122','2016-12-14 16:17:34 034','系统异常','LogService'),
('8a1076ae58fafc4b0158fc6dc4cb00ba',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:23:22 022','登录系统','LogService'),
('8a1076ae58fafc4b0158fc6e961b00bb',3,'错误代码:404，访问路径:/myipha.php','system','95.153.117.28','2016-12-14 16:24:15 015','系统异常','LogService'),
('8a1076ae58fafc4b0158fc6e9ba400bc',3,'错误代码:404，访问路径:/myiphd.php','system','95.153.117.28','2016-12-14 16:24:17 017','系统异常','LogService'),
('8a1076ae58fafc4b0158fc6e9e7500bd',3,'错误代码:404，访问路径:/myipha.php','system','95.153.117.28','2016-12-14 16:24:17 017','系统异常','LogService'),
('8a1076ae58fafc4b0158fc716f0f00be',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:27:22 022','登录系统','LogService'),
('8a1076ae58fafc4b0158fc73448d00bf',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:29:22 022','登录系统','LogService'),
('8a1076ae58fafc4b0158fc741ea500c0',3,'错误代码:404，访问路径:/favicon.ico','system','183.247.152.100','2016-12-14 16:30:18 018','系统异常','LogService'),
('8a1076ae58fafc4b0158fc7976e400c1',1,'用户：[superadmin] 成功登录系统','superadmin','218.1.18.194','2016-12-14 16:36:08 008','系统登录','LogService'),
('8a1076ae58fafc4b0158fc79850e00c2',3,'错误代码:404，访问路径:/favicon.ico','system','218.1.18.194','2016-12-14 16:36:12 012','系统异常','LogService'),
('8a1076ae58fafc4b0158fc79851a00c3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.1.18.194','2016-12-14 16:36:12 012','系统异常','LogService'),
('8a1076ae58fafc4b0158fc7986c300c4',3,'错误代码:404，访问路径:/favicon.ico','system','218.1.18.194','2016-12-14 16:36:12 012','系统异常','LogService'),
('8a1076ae58fafc4b0158fc79964500c5',3,'错误代码:404，访问路径:/favicon.ico','system','218.1.18.194','2016-12-14 16:36:16 016','系统异常','LogService'),
('8a1076ae58fafc4b0158fc7999c600c6',3,'错误代码:404，访问路径:/favicon.ico','system','218.1.18.194','2016-12-14 16:36:17 017','系统异常','LogService'),
('8a1076ae58fafc4b0158fc79a04800c7',3,'错误代码:404，访问路径:/favicon.ico','system','218.1.18.194','2016-12-14 16:36:19 019','系统异常','LogService'),
('8a1076ae58fafc4b0158fc84aa8e00c8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 16:48:22 022','登录系统','LogService'),
('8a1076ae58fafc4b0158fc87677700c9',1,'用户：[superadmin] 成功登录系统','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:51:22 022','系统登录','LogService'),
('8a1076ae58fafc4b0158fc87800500ca',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:51:28 028','系统异常','LogService'),
('8a1076ae58fafc4b0158fc87825b00cb',1,'用户：[superadmin] 成功登录系统','superadmin','60.173.220.146','2016-12-14 16:51:28 028','系统登录','LogService'),
('8a1076ae58fafc4b0158fc8784bf00cc',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','114.255.20.8','2016-12-14 16:51:29 029','请求出错','LogService'),
('8a1076ae58fafc4b0158fc8784e300cd',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:51:29 029','系统异常','LogService'),
('8a1076ae58fafc4b0158fc87854100ce',3,'错误代码:404，访问路径:/favicon.ico','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:51:29 029','系统异常','LogService'),
('8a1076ae58fafc4b0158fc8786b200cf',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.173.220.146','2016-12-14 16:51:30 030','系统异常','LogService'),
('8a1076ae58fafc4b0158fc87875d00d0',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.173.220.146','2016-12-14 16:51:30 030','系统异常','LogService'),
('8a1076ae58fafc4b0158fc87f66100d1',1,'切换布局：[layout: ${layout}]','superadmin','60.173.220.146','2016-12-14 16:51:58 058','系统首页','LogService'),
('8a1076ae58fafc4b0158fc88b4ad00d2',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:52:47 047','系统异常','LogService'),
('8a1076ae58fafc4b0158fc88cc4f00d3',1,'切换布局：[layout: ${layout}]','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:52:53 053','系统首页','LogService'),
('8a1076ae58fafc4b0158fc88cf7900d4',1,'用户：[superadmin] 成功登录系统','superadmin','211.136.253.232','2016-12-14 16:52:54 054','系统登录','LogService'),
('8a1076ae58fafc4b0158fc88dd8100d5',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','211.136.253.200','2016-12-14 16:52:57 057','系统异常','LogService'),
('8a1076ae58fafc4b0158fc88e04c00d6',3,'错误代码:404，访问路径:/favicon.ico','superadmin','211.136.253.232','2016-12-14 16:52:58 058','系统异常','LogService'),
('8a1076ae58fafc4b0158fc88e07f00d7',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','211.136.253.232','2016-12-14 16:52:58 058','请求出错','LogService'),
('8a1076ae58fafc4b0158fc88e0b600d8',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','211.136.253.232','2016-12-14 16:52:58 058','系统异常','LogService'),
('8a1076ae58fafc4b0158fc88f43d00d9',1,'切换布局：[layout: ${layout}]','superadmin','211.136.253.232','2016-12-14 16:53:03 003','系统首页','LogService'),
('8a1076ae58fafc4b0158fc89281500da',1,'切换布局：[layout: ${layout}]','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:53:16 016','系统首页','LogService'),
('8a1076ae58fafc4b0158fc8936a400db',1,'切换布局：[layout: ${layout}]','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:53:20 020','系统首页','LogService'),
('8a1076ae58fafc4b0158fc893dd400dc',1,'切换布局：[layout: ${layout}]','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:53:22 022','系统首页','LogService'),
('8a1076ae58fafc4b0158fc894e8b00dd',1,'切换布局：[layout: ${layout}]','superadmin','10.1.55.51, 10.1.1.20','2016-12-14 16:53:26 026','系统首页','LogService'),
('8a1076ae58fafc4b0158fc8ce07200de',1,'用户：[superadmin] 成功登录系统','superadmin','218.108.35.242','2016-12-14 16:57:20 020','系统登录','LogService'),
('8a1076ae58fafc4b0158fc8cef5b00df',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.108.35.242','2016-12-14 16:57:24 024','系统异常','LogService'),
('8a1076ae58fafc4b0158fc8cf0d900e0',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.108.35.242','2016-12-14 16:57:24 024','系统异常','LogService'),
('8a1076ae58fafc4b0158fc95265700e1',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 17:06:22 022','登录系统','LogService'),
('8a1076ae58fafc4b0158fc9914fd00e2',1,'用户：[superadmin] 成功登录系统','superadmin','222.95.46.36','2016-12-14 17:10:40 040','系统登录','LogService'),
('8a1076ae58fafc4b0158fc99222b00e3',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.95.46.36','2016-12-14 17:10:44 044','系统异常','LogService'),
('8a1076ae58fafc4b0158fca3d12f00e5',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 17:22:24 024','登录系统','LogService'),
('8a1076ae58fafc4b0158fca5a5fc00e6',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 17:24:24 024','登录系统','LogService'),
('8a1076ae58fafc4b0158fca950d300e7',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 17:28:24 024','登录系统','LogService'),
('8a1076ae58fafc4b0158fcaa3b3800e8',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 17:29:24 024','登录系统','LogService'),
('8a1076ae58fafc4b0158fcadbb3100e9',3,'错误代码:404，访问路径:/favicon.ico','system','122.224.160.90','2016-12-14 17:33:13 013','系统异常','LogService'),
('8a1076ae58fafc4b0158fcca49b400ea',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 18:04:25 025','登录系统','LogService'),
('8a1076ae58fafc4b0158fcd839ab00eb',1,'用户：[superadmin] 成功登录系统','superadmin','222.35.71.32','2016-12-14 18:19:38 038','系统登录','LogService'),
('8a1076ae58fafc4b0158fcd849be00ec',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.35.71.32','2016-12-14 18:19:42 042','系统异常','LogService'),
('8a1076ae58fafc4b0158fcd84b3000ed',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.35.120.212','2016-12-14 18:19:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fcd84c3100ee',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.35.71.32','2016-12-14 18:19:43 043','请求出错','LogService'),
('8a1076ae58fafc4b0158fcd84c6600ef',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.35.71.32','2016-12-14 18:19:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fcd8694e00f0',1,'切换布局：[layout: ${layout}]','superadmin','222.35.71.32','2016-12-14 18:19:50 050','系统首页','LogService'),
('8a1076ae58fafc4b0158fcdfcc5b00f1',3,'错误代码:404，访问路径:/open/doc','superadmin','222.35.71.32','2016-12-14 18:27:55 055','系统异常','LogService'),
('8a1076ae58fafc4b0158fcdfd45000f2',3,'错误代码:404，访问路径:/open/doc','system','101.226.33.239','2016-12-14 18:27:57 057','系统异常','LogService'),
('8a1076ae58fafc4b0158fce00c9000f3',3,'错误代码:404，访问路径:/open/doc','system','218.93.80.203','2016-12-14 18:28:11 011','系统异常','LogService'),
('8a1076ae58fafc4b0158fcfbcae500f4',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 18:58:29 029','登录系统','LogService'),
('8a1076ae58fafc4b0158fd0d785b00f5',1,'用户：[superadmin] 成功登录系统','superadmin','222.35.71.32','2016-12-14 19:17:48 048','系统登录','LogService'),
('8a1076ae58fafc4b0158fd0da0eb00f6',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.35.71.32','2016-12-14 19:17:58 058','系统异常','LogService'),
('8a1076ae58fafc4b0158fd0da22300f7',3,'错误代码:404，访问路径:/favicon.ico','superadmin','222.35.71.32','2016-12-14 19:17:58 058','系统异常','LogService'),
('8a1076ae58fafc4b0158fd0da67000f8',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','222.35.71.32','2016-12-14 19:18:00 000','请求出错','LogService'),
('8a1076ae58fafc4b0158fd0da85b00f9',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','222.35.71.32','2016-12-14 19:18:00 000','系统异常','LogService'),
('8a1076ae58fafc4b0158fd0e841000fa',3,'错误代码:404，访问路径:/echo.php','system','139.162.39.80','2016-12-14 19:18:56 056','系统异常','LogService'),
('8a1076ae58fafc4b0158fd0e8bec00fb',3,'错误代码:404，访问路径:/echo.php','system','139.162.39.80','2016-12-14 19:18:58 058','系统异常','LogService'),
('8a1076ae58fafc4b0158fd2889d400fc',1,'用户：[superadmin] 成功登录系统','superadmin','27.43.70.35','2016-12-14 19:47:22 022','系统登录','LogService'),
('8a1076ae58fafc4b0158fd28c78000fd',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.43.70.35','2016-12-14 19:47:37 037','系统异常','LogService'),
('8a1076ae58fafc4b0158fd28c9b700fe',3,'错误代码:404，访问路径:/favicon.ico','superadmin','27.43.70.35','2016-12-14 19:47:38 038','系统异常','LogService'),
('8a1076ae58fafc4b0158fd28ca9700ff',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','27.43.70.35','2016-12-14 19:47:38 038','请求出错','LogService'),
('8a1076ae58fafc4b0158fd28cac40100',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','27.43.70.35','2016-12-14 19:47:38 038','系统异常','LogService'),
('8a1076ae58fafc4b0158fd28de600101',1,'切换布局：[layout: ${layout}]','superadmin','27.43.70.35','2016-12-14 19:47:43 043','系统首页','LogService'),
('8a1076ae58fafc4b0158fd2a95f50102',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 19:49:36 036','登录系统','LogService'),
('8a1076ae58fafc4b0158fd2e10cb0103',3,'错误代码:404，访问路径:/favicon.ico','system','183.48.84.228','2016-12-14 19:53:24 024','系统异常','LogService'),
('8a1076ae58fafc4b0158fd2e10e90104',3,'错误代码:404，访问路径:/favicon.ico','system','183.48.84.228','2016-12-14 19:53:24 024','系统异常','LogService'),
('8a1076ae58fafc4b0158fd2e32d70105',1,'用户：[superadmin] 成功登录系统','superadmin','183.48.84.228','2016-12-14 19:53:33 033','系统登录','LogService'),
('8a1076ae58fafc4b0158fd2e4a740106',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','183.48.84.228','2016-12-14 19:53:39 039','系统异常','LogService'),
('8a1076ae58fafc4b0158fd2ef9980107',1,'切换布局：[layout: ${layout}]','superadmin','183.48.84.228','2016-12-14 19:54:24 024','系统首页','LogService'),
('8a1076ae58fafc4b0158fd2f2ae60108',1,'切换布局：[layout: ${layout}]','superadmin','183.48.84.228','2016-12-14 19:54:36 036','系统首页','LogService'),
('8a1076ae58fafc4b0158fd3af68d0109',1,'用户：[superadmin] 成功登录系统','superadmin','124.93.41.132','2016-12-14 20:07:29 029','系统登录','LogService'),
('8a1076ae58fafc4b0158fd3b0cbe010a',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','124.93.41.132','2016-12-14 20:07:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fd3b0d20010b',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.93.41.132','2016-12-14 20:07:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fd3f3c4e010c',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','124.93.41.132','2016-12-14 20:12:09 009','系统异常','LogService'),
('8a1076ae58fafc4b0158fd41ac56010d',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:14:49 049','系统首页','LogService'),
('8a1076ae58fafc4b0158fd41baa1010e',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:14:53 053','系统首页','LogService'),
('8a1076ae58fafc4b0158fd41c7c6010f',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:14:56 056','系统首页','LogService'),
('8a1076ae58fafc4b0158fd41d1da0110',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:14:59 059','系统首页','LogService'),
('8a1076ae58fafc4b0158fd453f7f0111',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 20:18:43 043','登录系统','LogService'),
('8a1076ae58fafc4b0158fd4bb19a0112',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 20:25:46 046','登录系统','LogService'),
('8a1076ae58fafc4b0158fd4d67460113',1,'用户：[superadmin] 成功登录系统','superadmin','124.93.41.132','2016-12-14 20:27:38 038','系统登录','LogService'),
('8a1076ae58fafc4b0158fd4d7ad70114',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','124.93.41.132','2016-12-14 20:27:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fd4d7bad0115',3,'错误代码:404，访问路径:/favicon.ico','superadmin','124.93.41.132','2016-12-14 20:27:43 043','系统异常','LogService'),
('8a1076ae58fafc4b0158fd50c6730116',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:31:19 019','系统首页','LogService'),
('8a1076ae58fafc4b0158fd50d9b60117',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:31:24 024','系统首页','LogService'),
('8a1076ae58fafc4b0158fd5e1a790118',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:45:52 052','系统首页','LogService'),
('8a1076ae58fafc4b0158fd5e2b160119',1,'切换布局：[layout: ${layout}]','superadmin','124.93.41.132','2016-12-14 20:45:56 056','系统首页','LogService'),
('8a1076ae58fafc4b0158fd690a79011a',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 20:57:49 049','登录系统','LogService'),
('8a1076ae58fafc4b0158fd7a75df011b',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 21:16:51 051','登录系统','LogService'),
('8a1076ae58fafc4b0158fd93df03011c',3,'错误代码:404，访问路径:/favicon.ico','system','123.124.194.192','2016-12-14 21:44:36 036','系统异常','LogService'),
('8a1076ae58fafc4b0158fda53185011d',1,'用户：[superadmin] 成功登录系统','superadmin','117.90.120.183','2016-12-14 22:03:31 031','系统登录','LogService'),
('8a1076ae58fafc4b0158fda548e9011e',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','117.90.120.183','2016-12-14 22:03:37 037','系统异常','LogService'),
('8a1076ae58fafc4b0158fda548e9011f',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','117.90.120.183','2016-12-14 22:03:37 037','系统异常','LogService'),
('8a1076ae58fafc4b0158fda577e70120',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','117.90.120.183','2016-12-14 22:03:49 049','系统异常','LogService'),
('8a1076ae58fafc4b0158fda577e80121',3,'错误代码:404，访问路径:/favicon.ico','superadmin','117.90.120.183','2016-12-14 22:03:49 049','系统异常','LogService'),
('8a1076ae58fafc4b0158fdc1f2a50122',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 22:34:56 056','登录系统','LogService'),
('8a1076ae58fafc4b0158fdd1ffdc0123',1,'用户：[superadmin] 成功登录系统','superadmin','218.18.3.86','2016-12-14 22:52:27 027','系统登录','LogService'),
('8a1076ae58fafc4b0158fdd211280124',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','218.18.3.86','2016-12-14 22:52:32 032','系统异常','LogService'),
('8a1076ae58fafc4b0158fdd212680125',3,'错误代码:404，访问路径:/favicon.ico','superadmin','218.18.3.86','2016-12-14 22:52:32 032','系统异常','LogService'),
('8a1076ae58fafc4b0158fde3a2bb0126',1,'用户：[superadmin] 成功登录系统','superadmin','49.77.98.89','2016-12-14 23:11:43 043','系统登录','LogService'),
('8a1076ae58fafc4b0158fde3b1ed0127',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','49.77.98.89','2016-12-14 23:11:47 047','系统异常','LogService'),
('8a1076ae58fafc4b0158fde3b1fe0128',3,'错误代码:404，访问路径:/favicon.ico','superadmin','49.77.98.89','2016-12-14 23:11:47 047','系统异常','LogService'),
('8a1076ae58fafc4b0158fde6cb5a0129',3,'错误代码:404，访问路径:/favicon.ico','system','123.129.160.117','2016-12-14 23:15:10 010','系统异常','LogService'),
('8a1076ae58fafc4b0158fde8d731012a',1,'用户：[superadmin] 成功登录系统','superadmin','113.99.9.158','2016-12-14 23:17:24 024','系统登录','LogService'),
('8a1076ae58fafc4b0158fde91723012b',3,'错误代码:404，访问路径:/favicon.ico','system','120.204.61.69','2016-12-14 23:17:41 041','系统异常','LogService'),
('8a1076ae58fafc4b0158fde917ae012c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','119.129.82.224','2016-12-14 23:17:41 041','系统异常','LogService'),
('8a1076ae58fafc4b0158fde92ad8012d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','119.129.82.224','2016-12-14 23:17:46 046','系统异常','LogService'),
('8a1076ae58fafc4b0158fdeef214012e',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 23:24:05 005','登录系统','LogService'),
('8a1076ae58fafc4b0158fe005da0012f',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 23:43:06 006','登录系统','LogService'),
('8a1076ae58fafc4b0158fe02fef90130',1,'用户：[superadmin] 成功登录系统','superadmin','111.30.235.11','2016-12-14 23:45:58 058','系统登录','LogService'),
('8a1076ae58fafc4b0158fe030fac0131',3,'错误代码:404，访问路径:/favicon.ico','superadmin','111.30.235.11','2016-12-14 23:46:03 003','系统异常','LogService'),
('8a1076ae58fafc4b0158fe05e6a70132',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-14 23:49:09 009','登录系统','LogService'),
('8a1076ae58fafc4b0158fe1f905c0133',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 00:17:11 011','登录系统','LogService'),
('8a1076ae58fafc4b0158fe2826720134',3,'错误代码:404，访问路径:/favicon.ico','system','123.59.45.58','2016-12-15 00:26:33 033','系统异常','LogService'),
('8a1076ae58fafc4b0158fe50748f0135',3,'错误代码:404，访问路径:/manager/html','system','222.186.34.119','2016-12-15 01:10:35 035','系统异常','LogService'),
('8a1076ae58fafc4b0158fe817cd60136',3,'错误代码:404，访问路径:/robots.txt','system','66.249.69.247','2016-12-15 02:04:08 008','系统异常','LogService'),
('8a1076ae58fafc4b0158ff513e6c0137',3,'错误代码:404，访问路径:/manager/html','system','104.238.117.185','2016-12-15 05:51:04 004','系统异常','LogService'),
('8a1076ae58fafc4b0158ff830cc80138',3,'错误代码:404，访问路径:/testproxy.php','system','91.196.50.33','2016-12-15 06:45:28 028','系统异常','LogService'),
('8a1076ae58fafc4b0158ffe5338d0139',3,'错误代码:404，访问路径:/favicon.ico','system','121.28.132.18','2016-12-15 08:32:40 040','系统异常','LogService'),
('8a1076ae58fafc4b0158ffe72353013a',1,'用户：[superadmin] 成功登录系统','superadmin','61.144.79.174','2016-12-15 08:34:47 047','系统登录','LogService'),
('8a1076ae58fafc4b0158ffe737b9013b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','61.144.79.174','2016-12-15 08:34:52 052','系统异常','LogService'),
('8a1076ae58fafc4b0158ffe73a5e013c',3,'java.lang.IllegalArgumentException: id to load is required for loading','superadmin','61.144.79.174','2016-12-15 08:34:53 053','请求出错','LogService'),
('8a1076ae58fafc4b0158ffe73b88013d',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','61.144.79.174','2016-12-15 08:34:53 053','系统异常','LogService'),
('8a1076ae58fafc4b0158ffec96f2013e',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Connection reset','superadmin','61.144.79.174','2016-12-15 08:40:45 045','请求出错','LogService'),
('8a1076ae58fafc4b0158ffec96f3013f',3,'org.apache.catalina.connector.ClientAbortException: java.net.SocketException: Connection reset','superadmin','61.144.79.174','2016-12-15 08:40:45 045','请求错误','LogService'),
('8a1076ae58fafc4b0158ffecd5e20140',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','61.144.79.174','2016-12-15 08:41:01 001','系统异常','LogService'),
('8a1076ae58fafc4b0158fff0ff5b0141',3,'错误代码:404，访问路径:/favicon.ico','system','122.224.160.90','2016-12-15 08:45:33 033','系统异常','LogService'),
('8a1076ae58fafc4b0158fff6cf360142',1,'用户：[superadmin] 成功登录系统','superadmin','121.60.24.102','2016-12-15 08:51:54 054','系统登录','LogService'),
('8a1076ae58fafc4b01590008b4540143',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 09:11:27 027','登录系统','LogService'),
('8a1076ae58fafc4b01590012d5490144',1,'用户：superadmin 超时，自动退出系统！','SYSTEM','SYSTEM','2016-12-15 09:22:31 031','登录系统','LogService'),
('8a1076ae58fafc4b01590027ec670145',1,'用户：[superadmin] 成功登录系统','superadmin','116.30.70.156','2016-12-15 09:45:33 033','系统登录','LogService'),
('8a1076ae58fafc4b015900280d5d0146',3,'错误代码:404，访问路径:/favicon.ico','superadmin','116.30.70.156','2016-12-15 09:45:41 041','系统异常','LogService'),
('8a1076ae58fafc4b015900280f3d0147',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','116.30.70.156','2016-12-15 09:45:42 042','系统异常','LogService'),
('8a1076ae58fafc4b0159002845350148',1,'切换布局：[layout: ${layout}]','superadmin','116.30.70.156','2016-12-15 09:45:56 056','系统首页','LogService'),
('8a1076ae58fafc4b0159002940470149',1,'切换布局：[layout: ${layout}]','superadmin','116.30.70.156','2016-12-15 09:47:00 000','系统首页','LogService'),
('8a1076ae58fafc4b01590034d6f4014a',1,'用户：[superadmin] 成功登录系统','superadmin','60.12.214.83','2016-12-15 09:59:40 040','系统登录','LogService'),
('8a1076ae58fafc4b01590035477c014b',3,'错误代码:404，访问路径:/app/charts/adapter/undefined.js','superadmin','60.12.214.83','2016-12-15 10:00:08 008','系统异常','LogService'),
('8a1076ae58fafc4b01590035a35b014c',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.12.214.83','2016-12-15 10:00:32 032','系统异常','LogService'),
('8a1076ae58fafc4b01590035a467014d',3,'错误代码:404，访问路径:/favicon.ico','superadmin','60.12.214.83','2016-12-15 10:00:32 032','系统异常','LogService');

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
('402881ff500261d4015002732e960000','数据库管理工具','007','/bi/table','fa fa-table',7,0,'数据库表管理','-1',0,0,1,1,'2015-09-25 11:01:54');

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
('402838814a143628014a149f19d20003','hefei','C4CA4238A0B923820DCC509A6F75849B','合肥分公司','','','','palette',NULL,1,0,'2014-12-04 17:26:18','2016-12-27 11:29:09','115.236.42.130',1,NULL),
('402838814ac1fe5f014ac215e2b6000c','doc','C4CA4238A0B923820DCC509A6F75849B','文档共享中心','','','','palette',NULL,1,0,'2015-01-07 09:50:21',NULL,NULL,0,NULL),
('402881ee5374fb9b0153750220d70033','r1','C4CA4238A0B923820DCC509A6F75849B','','','','','palette',NULL,1,0,'2016-03-14 20:03:07','2016-03-14 20:03:22','localhost',1,NULL),
('402881ee547f564d01547f7dd49b002e','superadmin','C4CA4238A0B923820DCC509A6F75849B','超级管理员','','','','palette.6','${layout}',1,1,'2016-05-05 13:57:13','2017-01-07 21:35:56','27.191.152.98',1,NULL),
('402881ee547f564d01547f7e24910031','zengc','C4CA4238A0B923820DCC509A6F75849B','曾超','','','','palette',NULL,1,0,'2016-05-05 13:57:33','2016-12-27 11:28:21','115.236.42.130',1,NULL),
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
