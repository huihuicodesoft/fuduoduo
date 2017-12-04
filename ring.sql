/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : ring

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-12-04 19:12:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for access_record
-- ----------------------------
DROP TABLE IF EXISTS `access_record`;
CREATE TABLE `access_record` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `TERMINAL_MARK` varchar(255) DEFAULT NULL COMMENT '终端标识',
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `REGION` varchar(255) DEFAULT NULL COMMENT '行政区',
  `LNG` double DEFAULT NULL COMMENT '经度',
  `LAT` double DEFAULT NULL COMMENT '纬度',
  `CREATION_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `COUNTRY` varchar(255) NOT NULL COMMENT '国家',
  `PROVINCE` varchar(255) DEFAULT NULL COMMENT '省',
  `CITY` varchar(255) DEFAULT NULL COMMENT '市',
  `DISTRICT` varchar(255) DEFAULT NULL COMMENT '区',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `COUNTRY` (`COUNTRY`,`PROVINCE`,`CITY`,`DISTRICT`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `QUESTION_ID` int(11) NOT NULL COMMENT '问题ID',
  `CONTENT` text NOT NULL COMMENT '回答内容',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `ADDRESS_CODE` varchar(255) DEFAULT NULL COMMENT '地址',
  `DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除0：false，1：true',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `HOST_ID` bigint(20) unsigned NOT NULL COMMENT '帖子ID',
  `HOST_TYPE` tinyint(1) unsigned NOT NULL COMMENT '回复类型\r\n1：帖子',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户',
  `CONTENT` varchar(255) NOT NULL COMMENT '内容',
  `PRAISE_NUMBER` int(10) DEFAULT '0' COMMENT '点赞数',
  `CRITICIZE_NUMBER` int(10) unsigned DEFAULT '0' COMMENT '踩数',
  `REPORT_NUMBER` int(10) unsigned DEFAULT '0' COMMENT '举报数',
  `IS_DELETED` tinyint(1) unsigned DEFAULT '0' COMMENT '帖子是否被删除\r\n0：false（默认值）\r\n1：true',
  `CREATION_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `HOST_ID` bigint(20) unsigned NOT NULL COMMENT '目标ID',
  `HOST_TYPE` tinyint(1) DEFAULT NULL COMMENT '目标类型\r\n1：帖子\r\n2：回复',
  `MARK` varchar(255) NOT NULL COMMENT '用户标识',
  `MARK_TYPE` tinyint(1) unsigned NOT NULL COMMENT '用户类型\r\n1：游客\r\n2：用户',
  `TYPE` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '点赞是否取消\r\n1，赞\r\n2，踩',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operate_answer
-- ----------------------------
DROP TABLE IF EXISTS `operate_answer`;
CREATE TABLE `operate_answer` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ANSWER_ID` bigint(20) unsigned NOT NULL COMMENT '回答的ID',
  `TYPE` tinyint(2) unsigned DEFAULT NULL COMMENT '操作类型（1.点赞，2.踩）',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `DELETED` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除0，false；1，true',
  `CEATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operate_question
-- ----------------------------
DROP TABLE IF EXISTS `operate_question`;
CREATE TABLE `operate_question` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `QUESTION_ID` int(10) unsigned NOT NULL COMMENT '问题ID',
  `TYPE` tinyint(2) DEFAULT NULL COMMENT '操作类型（1.点赞，2.踩）',
  `USER_ID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `DELETED` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除0，false；1，true',
  `CEATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PERMISSION` varchar(255) NOT NULL COMMENT '权限',
  `DESCRIPTION` varchar(255) NOT NULL COMMENT '权限描述',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PERMISSION` (`PERMISSION`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `UUID` varchar(255) NOT NULL COMMENT 'UUID终端提供',
  `DESCRIPTION` text COMMENT '帖子描述',
  `MEDIA_CONTENT` text COMMENT '媒体内容',
  `POST_TYPE_ID` int(10) unsigned DEFAULT NULL COMMENT '帖子类型',
  `PRAISE_NUMBER` int(10) unsigned DEFAULT '0' COMMENT '点赞数',
  `CRITICIZE_NUMBER` int(10) unsigned DEFAULT '0' COMMENT '踩数',
  `COMMENT_NUMBER` int(10) unsigned DEFAULT '0' COMMENT '评论数',
  `REPORT_NUMBER` int(10) unsigned DEFAULT '0' COMMENT '举报数',
  `ANONYMOUS` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '是否匿名\r\n0：false（默认值）\r\n1：true',
  `ADDRESS_ID` int(10) DEFAULT NULL COMMENT '发布地址ID',
  `LNG` double DEFAULT NULL COMMENT '发布位置经度',
  `LAT` double DEFAULT NULL COMMENT '发布位置纬度',
  `STATE` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1' COMMENT '帖子状态值\r\n1：审核中（默认值）\r\n2：审核失败\r\n3：审核成功\r\n4：用户删除',
  `CREATION_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`,`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for post_type
-- ----------------------------
DROP TABLE IF EXISTS `post_type`;
CREATE TABLE `post_type` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `NAME` varchar(16) NOT NULL COMMENT '贴类型名',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '贴描述语',
  `SYMBOL` varchar(255) DEFAULT NULL COMMENT '代表图',
  `SUPPORT` tinyint(2) unsigned zerofill NOT NULL DEFAULT '00' COMMENT '支持的表现形式\r\n1：2/3/4/5\r\n2：文字\r\n3：[文字] + 图片\r\n4：[文字] + 视频\r\n5：[文字] + gif\r\n6 : 2/3\r\n7 : 2/4\r\n8 : 2/5\r\n9：3/4\r\n10：3/5\r\n11：4/5\r\n12：2/3/4\r\n13：3/4/5\r\n12：2/3/4\r\n12：2/3/4\r\n12：2/3/4',
  `IS_DELETED` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '是否删除 : \r\n0 : false\r\n1：true',
  `CREATION_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CONTENT` text NOT NULL COMMENT '问题内容',
  `MEDIA_CONTENT` varchar(255) DEFAULT NULL COMMENT '媒体内容',
  `TOPIC_ID` int(10) unsigned NOT NULL COMMENT '话题ID',
  `USER_ID` bigint(20) unsigned NOT NULL COMMENT '发布用户ID',
  `ADDRESS_CODE` varchar(255) DEFAULT NULL COMMENT '发布位置',
  `DELETED` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0：false，1：true',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for report_post
-- ----------------------------
DROP TABLE IF EXISTS `report_post`;
CREATE TABLE `report_post` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `POST_ID` bigint(20) NOT NULL,
  `MARK` varchar(255) NOT NULL COMMENT '用户标识',
  `CONTENT` varchar(255) DEFAULT NULL,
  `CONTENT_TYPE` smallint(2) unsigned NOT NULL,
  `CREATION_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ROLE` varchar(255) NOT NULL COMMENT '角色标识',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ROLE` (`ROLE`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ROLE_ID` smallint(5) unsigned NOT NULL COMMENT '角色ID',
  `PERMISSION_ID` int(10) unsigned NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`ID`),
  KEY `PERMISSION_ID` (`PERMISSION_ID`),
  KEY `ROLE_ID` (`ROLE_ID`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `permission` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sms_code
-- ----------------------------
DROP TABLE IF EXISTS `sms_code`;
CREATE TABLE `sms_code` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MOBILE` varchar(20) NOT NULL COMMENT '手机号',
  `CODE` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `UPDATE_TIME` datetime NOT NULL COMMENT '验证码更新时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MOBILE` (`MOBILE`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for terminal
-- ----------------------------
DROP TABLE IF EXISTS `terminal`;
CREATE TABLE `terminal` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UUID` varchar(255) NOT NULL COMMENT 'UUID',
  `IMEI` varchar(255) DEFAULT NULL COMMENT '终端设备号',
  `MAC` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '终端MAC地址',
  `OS_TYPE` tinyint(1) unsigned DEFAULT '9' COMMENT '设备系统类型\r\n1：ANDROID;\r；2：IOS；9：未知',
  `MODEL` varchar(255) DEFAULT NULL COMMENT '型号',
  `SDK` varchar(255) DEFAULT NULL COMMENT 'SDK版本',
  `SYSTEM` varchar(255) DEFAULT NULL COMMENT '系统版本',
  `STATE` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '账号状态\r\n1 : 正在使用（默认）\r\n2 : 废弃\r\n3：锁定',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `ACCOUNT` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '账号：\r\n手机号；\r\n三方账号',
  `ACCOUNT_TYPE` tinyint(2) unsigned NOT NULL COMMENT '账号类型：\r\n1.手机号\r\n2.微信账号\r\n3.QQ账号\r\n4.新浪',
  `USER_INFO_ID` bigint(20) DEFAULT NULL COMMENT '用户信息ID',
  `PASSWORD` varchar(255) DEFAULT NULL COMMENT '用户密码（手机账号）',
  `ACCESS_TOKEN` varchar(255) DEFAULT NULL COMMENT '三方的token',
  `REFRESH_TOKEN` varchar(255) DEFAULT NULL COMMENT '三方的刷新token',
  `BIND_ACCOUNT` varchar(255) DEFAULT NULL COMMENT '绑定手机账号',
  `STATE` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1' COMMENT '账号状态\r\n1 : 正在使用（默认）\r\n2 : 废弃\r\n3：锁定',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ACCOUNT` (`ACCOUNT`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `NICKNAME` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `BIRTHDAY` date DEFAULT NULL COMMENT '用户生日',
  `SEX` tinyint(1) unsigned NOT NULL DEFAULT '3' COMMENT '性别 1：男；2：女；3：未选择',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `SIGNATURE` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `ADDRESS_ID` int(10) DEFAULT NULL COMMENT '注册地区ID',
  `LNG` double DEFAULT NULL COMMENT '注册经度',
  `LAT` double DEFAULT NULL COMMENT '注册纬度',
  `LAST_MODIFIED_TIME` datetime DEFAULT NULL COMMENT '信息上次修改时间',
  `DELETED` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `ROLE_ID` smallint(5) unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`,`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_save_id
-- ----------------------------
DROP TABLE IF EXISTS `user_save_id`;
CREATE TABLE `user_save_id` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SAVE_USER_ID` bigint(20) unsigned NOT NULL COMMENT '保存的用户ID',
  `CREATION_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SAVE_USER_ID` (`SAVE_USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_terminal
-- ----------------------------
DROP TABLE IF EXISTS `user_terminal`;
CREATE TABLE `user_terminal` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `TERMINAL_ID` bigint(20) unsigned NOT NULL COMMENT '设备ID',
  `USING` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该设备是否正在被使用\r\n0：false；\r\n1：true',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`,`TERMINAL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
