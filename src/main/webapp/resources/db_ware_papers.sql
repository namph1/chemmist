/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : chemmist

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2018-02-23 14:16:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_action_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_action_menu`;
CREATE TABLE `tbl_action_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `menu_id` bigint(20) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menu_id` (`menu_id`),
  CONSTRAINT `fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `tbl_menu` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_action_menu
-- ----------------------------
INSERT INTO `tbl_action_menu` VALUES ('1', 'Xóa bỏ', '5', '2018-02-22 08:47:39', 'fa fa-trash text-red');
INSERT INTO `tbl_action_menu` VALUES ('2', 'Chỉnh sửa', '5', '2018-02-22 08:47:39', 'fa fa-pencil text-yellow');
INSERT INTO `tbl_action_menu` VALUES ('3', 'Xóa bỏ', '6', '2018-02-22 08:49:05', 'fa fa-trash text-red');
INSERT INTO `tbl_action_menu` VALUES ('4', 'Chỉnh sửa', '6', '2018-02-22 08:49:22', 'fa fa-pencil text-yellow');
INSERT INTO `tbl_action_menu` VALUES ('5', 'Tìm kiếm', '5', '2018-02-22 08:54:43', 'fa fa-search text-primary');
INSERT INTO `tbl_action_menu` VALUES ('6', 'Thêm mới', '5', '2018-02-22 09:00:33', 'fa fa-plus-square text-aqua');
INSERT INTO `tbl_action_menu` VALUES ('7', 'Tìm kiếm', '6', '2018-02-22 09:01:54', 'fa fa-search text-primary');
INSERT INTO `tbl_action_menu` VALUES ('8', 'Khóa/Mở khóa', '6', '2018-02-22 09:02:30', 'fa fa-lock text-danger');
INSERT INTO `tbl_action_menu` VALUES ('9', 'Thêm mới', '6', '2018-02-22 09:05:54', 'fa fa-plus-square text-aqua');
INSERT INTO `tbl_action_menu` VALUES ('10', 'Thêm mới', '7', '2018-02-22 09:06:58', 'fa fa-plus-square text-aqua');
INSERT INTO `tbl_action_menu` VALUES ('11', 'Chỉnh sửa', '7', '2018-02-22 09:07:11', 'fa fa-pencil text-yellow');
INSERT INTO `tbl_action_menu` VALUES ('12', 'Tìm kiếm', '7', '2018-02-22 09:07:28', 'fa fa-search text-primary');

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `ID` bigint(5) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(15) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `ADDRESS` varchar(500) DEFAULT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  `FACEBOOK` varchar(50) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL,
  `LEVEL` int(2) DEFAULT NULL,
  `TYPE` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1- KHÁCH HÀNG; 2- NHÀ CUNG CẤP',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='- LƯU THÔNG TIN VỀ KHÁCH HÀNG.';

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('1', 'VIEN', 'Trần Văn Viên', 'Khu 1_ P Nhị CHâu- TP Hải Dương', '1', null, '0989380140', '2018-01-23 13:54:11', '1', '1');
INSERT INTO `tbl_customer` VALUES ('2', 'HUE', 'Phạm Thị Minh Huệ', 'Bevarhill- Sydney - Australia', '1', null, null, '2018-01-24 15:49:09', '1', '2');
INSERT INTO `tbl_customer` VALUES ('3', 'CHIN', 'Trần Thị Chín', 'Ninh Bình', '1', '', '1234654655', '2018-02-06 11:05:30', '1', '1');
INSERT INTO `tbl_customer` VALUES ('4', 'HAO', 'Bùi Thị Hảo', 'Hải Dương', '1', '', '0124654', '2018-02-06 11:09:22', '1', '1');
INSERT INTO `tbl_customer` VALUES ('5', 'CHAM', 'Nguyễn Thị Phương Châm', 'Đường Thanh Niên- TP Hải Dươn', '1', '', '0962123456', '2018-02-23 14:03:13', '1', '1');

-- ----------------------------
-- Table structure for tbl_export
-- ----------------------------
DROP TABLE IF EXISTS `tbl_export`;
CREATE TABLE `tbl_export` (
  `ID` bigint(5) NOT NULL AUTO_INCREMENT,
  `NO` bigint(5) DEFAULT NULL,
  `CUSTOMER_ID` bigint(5) DEFAULT NULL,
  `TOTAL` float DEFAULT NULL,
  `DISCOUNT` float DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL,
  `USER_ID` bigint(5) DEFAULT NULL,
  `TOTAL_LAST` float DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `WEIGHT` float DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CUSTOMER` (`CUSTOMER_ID`) USING BTREE,
  KEY `fk_user` (`USER_ID`) USING BTREE,
  CONSTRAINT `tbl_export_ibfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `tbl_customer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_export_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `tbl_users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_export
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_export_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_export_detail`;
CREATE TABLE `tbl_export_detail` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `EXPORT_ID` bigint(5) DEFAULT NULL,
  `PRODUCT_ID` bigint(5) DEFAULT NULL,
  `COUNT` float DEFAULT NULL,
  `PRICE` float DEFAULT NULL,
  `USER_ID` bigint(5) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `UNIT_ID` bigint(5) DEFAULT NULL,
  `WEIGHT` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EXPORT_ID` (`EXPORT_ID`) USING BTREE,
  KEY `fk_product_exp` (`PRODUCT_ID`) USING BTREE,
  KEY `fk_unit_exp` (`UNIT_ID`) USING BTREE,
  CONSTRAINT `tbl_export_detail_ibfk_1` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `tbl_product` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_export_detail_ibfk_2` FOREIGN KEY (`UNIT_ID`) REFERENCES `tbl_unit` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_export_detail_ibfk_3` FOREIGN KEY (`EXPORT_ID`) REFERENCES `tbl_export` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_export_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_import
-- ----------------------------
DROP TABLE IF EXISTS `tbl_import`;
CREATE TABLE `tbl_import` (
  `ID` bigint(5) NOT NULL AUTO_INCREMENT,
  `NO` int(5) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL,
  `USER_ID` bigint(5) DEFAULT NULL,
  `WEIGHT` float DEFAULT NULL,
  `TOTAL_PRICE` float DEFAULT NULL,
  `FEE_SHIP` float DEFAULT NULL,
  `RATE` float DEFAULT NULL,
  `TOTAL` float DEFAULT NULL,
  `CUSTOMER_ID` int(5) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_userId` (`USER_ID`) USING BTREE,
  CONSTRAINT `tbl_import_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `tbl_users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_import
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_import_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_import_detail`;
CREATE TABLE `tbl_import_detail` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID` bigint(5) DEFAULT NULL,
  `COUNT` float DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `USER_ID` bigint(5) DEFAULT NULL,
  `IMPORT_ID` bigint(5) DEFAULT NULL,
  `PRICE` float DEFAULT NULL,
  `TYPE` tinyint(1) DEFAULT '1' COMMENT '0- tồn đầu kỳ; 1- nhập kho',
  PRIMARY KEY (`ID`),
  KEY `FK_IMPORT_ID` (`IMPORT_ID`) USING BTREE,
  KEY `fk_product` (`PRODUCT_ID`) USING BTREE,
  CONSTRAINT `tbl_import_detail_ibfk_1` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `tbl_product` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_import_detail_ibfk_2` FOREIGN KEY (`IMPORT_ID`) REFERENCES `tbl_import` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_import_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_menu`;
CREATE TABLE `tbl_menu` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL,
  `PARENT_ID` bigint(20) DEFAULT '0',
  `URL` varchar(20) DEFAULT NULL,
  `ORDERS` int(11) DEFAULT NULL,
  `ICON` varchar(255) DEFAULT NULL,
  `IS_PARENT` tinyint(1) DEFAULT '0' COMMENT '0- CHILD ;1 - PARENT',
  PRIMARY KEY (`ID`),
  KEY `fk_parent` (`PARENT_ID`) USING BTREE,
  CONSTRAINT `tbl_menu_ibfk_1` FOREIGN KEY (`PARENT_ID`) REFERENCES `tbl_menu` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_menu
-- ----------------------------
INSERT INTO `tbl_menu` VALUES ('4', 'Danh mục', null, null, '2', 'fa fa-th', '1');
INSERT INTO `tbl_menu` VALUES ('5', 'Nhóm sản phẩm', '4', 'g_product', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('6', 'Sản phẩm', '4', 'products', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('7', 'Đơn vị', '4', 'unit', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('8', 'Đại lý', '4', 'customer', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('9', 'Nhà cung cấp', '4', 'vendor', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('11', 'Bán hàng', '12', 'export', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('12', 'Kho hàng', null, null, '4', 'fa fa-pie-chart', '1');
INSERT INTO `tbl_menu` VALUES ('13', 'Nhập kho', '12', 'import', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('14', 'Tồn kho', '12', 'tonkho', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('15', 'Tài chính', null, null, '5', 'fa fa-money', '1');
INSERT INTO `tbl_menu` VALUES ('16', 'Tiền mặt', '15', 'cash', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('24', 'Hệ thống', null, null, '7', 'fa fa-cog', '1');
INSERT INTO `tbl_menu` VALUES ('25', 'Quản trị người dùng', '24', 'system/user', null, null, '0');
INSERT INTO `tbl_menu` VALUES ('26', 'Quản trị nhóm quyền', '24', 'system/role', null, null, '0');

-- ----------------------------
-- Table structure for tbl_money
-- ----------------------------
DROP TABLE IF EXISTS `tbl_money`;
CREATE TABLE `tbl_money` (
  `ID` bigint(5) NOT NULL AUTO_INCREMENT,
  `TYPE` tinyint(1) DEFAULT NULL COMMENT '0- ĐẦU KỲ, 1- TIỀN MẶT, 2- CHUYỂN KHOẢN',
  `NO` int(11) NOT NULL COMMENT 'số chứng từ- bắt đầu theo tháng; 0 là đầu kỳ',
  `CREATED_DATE` datetime DEFAULT NULL,
  `STATUS` int(1) DEFAULT NULL COMMENT '0- thu; 1 - chi',
  `CUSTOMER_ID` bigint(5) DEFAULT NULL,
  `TOTAL` float DEFAULT NULL,
  `NOTE` varchar(200) DEFAULT NULL,
  `USER_ID` bigint(5) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_cust` (`CUSTOMER_ID`) USING BTREE,
  KEY `fk_id` (`ID`) USING BTREE,
  CONSTRAINT `tbl_money_ibfk_2` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `tbl_customer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4859 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_money
-- ----------------------------
INSERT INTO `tbl_money` VALUES ('470', '0', '0', '2017-11-01 14:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('479', '0', '0', '2017-11-01 14:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('491', '0', '0', '2017-11-01 14:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('501', '0', '0', '2017-11-01 14:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('510', '0', '0', '2017-11-01 14:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('512', '0', '0', '2017-11-01 14:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('4815', '0', '0', '2018-01-01 16:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('4824', '0', '0', '2018-01-01 16:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('4826', '0', '0', '2018-01-01 16:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('4836', '0', '0', '2018-01-01 16:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('4846', '0', '0', '2018-01-01 16:00:01', '0', null, '0', null, null);
INSERT INTO `tbl_money` VALUES ('4858', '0', '0', '2018-01-01 16:00:01', '0', null, '0', null, null);

-- ----------------------------
-- Table structure for tbl_product
-- ----------------------------
DROP TABLE IF EXISTS `tbl_product`;
CREATE TABLE `tbl_product` (
  `ID` bigint(5) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(20) DEFAULT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `NOTE` varchar(500) DEFAULT NULL,
  `STATUS` int(1) DEFAULT NULL,
  `PRICE_AU` float DEFAULT NULL,
  `PRICE` float DEFAULT NULL,
  `USER_ID` bigint(5) DEFAULT NULL,
  `UNIT_ID` bigint(5) DEFAULT NULL,
  `PRODUCT_TYPE_ID` bigint(5) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `WEIGHT` float DEFAULT NULL COMMENT 'KHỐI LƯỢNG SẢN PHẨM',
  `IMAGE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_UNIT` (`UNIT_ID`) USING BTREE,
  KEY `fk_type` (`PRODUCT_TYPE_ID`) USING BTREE,
  CONSTRAINT `tbl_product_ibfk_1` FOREIGN KEY (`PRODUCT_TYPE_ID`) REFERENCES `tbl_product_type` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `tbl_product_ibfk_2` FOREIGN KEY (`UNIT_ID`) REFERENCES `tbl_unit` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='- THÔNG TIN SẢN PHẨM \r\n- PHÂN LOẠI THEO NHÓM SẢN PHẨM';

-- ----------------------------
-- Records of tbl_product
-- ----------------------------
INSERT INTO `tbl_product` VALUES ('1', 'Elevit_100', 'Elevit bà bầu 100 viên', 'Thực phẩm chức năng bổ sung đầy đủ vitamins cho bà bầu.\nUống ngày 1 viên. \nNên uống từ trước khi có bầu 1 tháng.', '1', '62.99', '1100000', '1', '2', '1', null, '0.5', null);
INSERT INTO `tbl_product` VALUES ('2', 'Swi_De_100', 'Swisse Liver Detox 100 viên', 'Mỗi ngày uống 2 viên.\nCông dụng: giải độc gan', '1', '16.99', '590000', '1', '1', '1', '2018-01-23 11:26:54', '0.2', 'D:\\DATA\\namph\\icon\\swisse-detox.jpg');
INSERT INTO `tbl_product` VALUES ('3', 'BM_FO400', 'Blackmores Odourless Fish Oil 400 Mini Capsules', 'Dầu cá. thực phẩm chức năng giàu omega3 giúp mắt được cải thiện.', '1', '26.99', '650000', '1', '1', '1', null, '0.8', null);
INSERT INTO `tbl_product` VALUES ('4', 'BM_GLU_180', 'Blackmores Glucosamine 1500mg -180 viên', '- Dùng cho người lớn, mỗi ngày 1 viên sau bữa ăn\n- Giảm đau, giảm viêm khớp mãn tính.\n- Tạo chất nhờn, giảm sự hao mòn sụn.\n- Giảm sưng phù, cải thiện các hoạt động của khớp xương , cải thiện các triệu chứng đau nhức của bệnh viêm khớp.\n- Giúp phục hồi xương khớp, duy trì các hoạt động của khớp xương.', '1', '31', '780000', '1', '1', '1', null, '0.8', null);
INSERT INTO `tbl_product` VALUES ('6', 's26_2', 'Sữa S26 Gold 2+', 'SỮa gold', '1', '16.99', '510000', '1', '2', '1', null, '1', null);

-- ----------------------------
-- Table structure for tbl_product_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_product_type`;
CREATE TABLE `tbl_product_type` (
  `ID` bigint(5) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) DEFAULT NULL,
  `NOTE` varchar(500) DEFAULT NULL,
  `USER_ID` bigint(5) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `STATUS` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='- BANG LOAI SAN PHAM\r\n- GIUP PHÂN LOẠI CÁC NHÓM SẢN PHẨM';

-- ----------------------------
-- Records of tbl_product_type
-- ----------------------------
INSERT INTO `tbl_product_type` VALUES ('1', 'Thực phẩm chức năng', 'Thực phẩm chức năng Úc', '1', null, '1');

-- ----------------------------
-- Table structure for tbl_role
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role`;
CREATE TABLE `tbl_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(255) DEFAULT NULL,
  `NOTE` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UNIQUE_ROLENAME` (`ROLE_NAME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_role
-- ----------------------------
INSERT INTO `tbl_role` VALUES ('1', 'ROLE_ADMIN', 'Quyền Administrator');
INSERT INTO `tbl_role` VALUES ('2', 'ROLE_USER', 'Quyền người dùng');
INSERT INTO `tbl_role` VALUES ('3', 'ROLE_TEST', 'Quyền kiểm thử');

-- ----------------------------
-- Table structure for tbl_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role_menu`;
CREATE TABLE `tbl_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menu` (`menu_id`) USING BTREE,
  KEY `fk_role` (`role_id`) USING BTREE,
  CONSTRAINT `tbl_role_menu_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `tbl_menu` (`ID`),
  CONSTRAINT `tbl_role_menu_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `tbl_role` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_role_menu
-- ----------------------------
INSERT INTO `tbl_role_menu` VALUES ('87', '16', '3');
INSERT INTO `tbl_role_menu` VALUES ('88', '4', '3');
INSERT INTO `tbl_role_menu` VALUES ('89', '5', '3');
INSERT INTO `tbl_role_menu` VALUES ('90', '6', '3');
INSERT INTO `tbl_role_menu` VALUES ('91', '7', '3');
INSERT INTO `tbl_role_menu` VALUES ('92', '8', '3');
INSERT INTO `tbl_role_menu` VALUES ('93', '11', '3');
INSERT INTO `tbl_role_menu` VALUES ('94', '12', '3');
INSERT INTO `tbl_role_menu` VALUES ('95', '13', '3');
INSERT INTO `tbl_role_menu` VALUES ('96', '14', '3');
INSERT INTO `tbl_role_menu` VALUES ('97', '15', '3');
INSERT INTO `tbl_role_menu` VALUES ('106', '4', '1');
INSERT INTO `tbl_role_menu` VALUES ('107', '5', '1');
INSERT INTO `tbl_role_menu` VALUES ('108', '6', '1');
INSERT INTO `tbl_role_menu` VALUES ('109', '7', '1');
INSERT INTO `tbl_role_menu` VALUES ('110', '8', '1');
INSERT INTO `tbl_role_menu` VALUES ('111', '9', '1');
INSERT INTO `tbl_role_menu` VALUES ('124', '16', '2');
INSERT INTO `tbl_role_menu` VALUES ('125', '4', '2');
INSERT INTO `tbl_role_menu` VALUES ('126', '5', '2');
INSERT INTO `tbl_role_menu` VALUES ('127', '6', '2');
INSERT INTO `tbl_role_menu` VALUES ('128', '7', '2');
INSERT INTO `tbl_role_menu` VALUES ('129', '8', '2');
INSERT INTO `tbl_role_menu` VALUES ('130', '11', '2');
INSERT INTO `tbl_role_menu` VALUES ('131', '12', '2');
INSERT INTO `tbl_role_menu` VALUES ('132', '13', '2');
INSERT INTO `tbl_role_menu` VALUES ('133', '14', '2');
INSERT INTO `tbl_role_menu` VALUES ('134', '15', '2');

-- ----------------------------
-- Table structure for tbl_role_menu_action
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role_menu_action`;
CREATE TABLE `tbl_role_menu_action` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `menu_action_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_role` (`role_id`),
  KEY `fk_action_menu` (`menu_action_id`),
  CONSTRAINT `fk_action_menu` FOREIGN KEY (`menu_action_id`) REFERENCES `tbl_action_menu` (`id`),
  CONSTRAINT `fk_role` FOREIGN KEY (`role_id`) REFERENCES `tbl_role` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_role_menu_action
-- ----------------------------
INSERT INTO `tbl_role_menu_action` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for tbl_unit
-- ----------------------------
DROP TABLE IF EXISTS `tbl_unit`;
CREATE TABLE `tbl_unit` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  `NOTE` varchar(1000) DEFAULT NULL,
  `CREATE_DATE` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `UPDATE_DATE` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_unit
-- ----------------------------
INSERT INTO `tbl_unit` VALUES ('1', 'lọ', 'đơn vị 1', null, null);
INSERT INTO `tbl_unit` VALUES ('2', 'hộp', 'đơn vị 2', null, null);

-- ----------------------------
-- Table structure for tbl_users
-- ----------------------------
DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE `tbl_users` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(15) DEFAULT NULL,
  `PASS` varchar(255) DEFAULT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  `FULL_NAME` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(30) DEFAULT NULL,
  `IS_ADMIN` tinyint(1) DEFAULT NULL,
  `POSITION` varchar(20) DEFAULT NULL,
  `PHONE` varchar(15) DEFAULT NULL,
  `CREATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `AVATAR` varchar(0) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UNIQUE_USERNAME` (`USER_NAME`) USING BTREE,
  UNIQUE KEY `UNIQUE_EMAIL` (`EMAIL`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_users
-- ----------------------------
INSERT INTO `tbl_users` VALUES ('1', 'admin', '123456', '1', 'Administrator', 'namtiensinh990@gmail.com', '1', 'Admin', '0989380140', '2017-11-05 09:27:28', null);
INSERT INTO `tbl_users` VALUES ('2', 'tinhte.vn', '123', '1', 'Tinh van te', 'tinhte@gmail.com', '0', 'USER', '0989380140', '2018-02-13 15:00:44', null);
INSERT INTO `tbl_users` VALUES ('3', 'namph', '123456', '1', 'Phạm Huy Nam', 'phamhuynam.1990@gmail.com', '0', 'USER', '0989380140', null, null);
INSERT INTO `tbl_users` VALUES ('4', 'duongnta', '123456', '1', 'Nguyễn Thị Ánh Dương', 'ntaduongvhnt@gmail.com', '0', 'USER', '0986929620', null, null);

-- ----------------------------
-- Table structure for tbl_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_role`;
CREATE TABLE `tbl_user_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) NOT NULL,
  `ROLE_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_role` (`ROLE_ID`) USING BTREE,
  KEY `fk_user` (`USER_ID`) USING BTREE,
  CONSTRAINT `tbl_user_role_ibfk_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `tbl_role` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `tbl_user_role_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `tbl_users` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user_role
-- ----------------------------
INSERT INTO `tbl_user_role` VALUES ('1', '1', '1');
INSERT INTO `tbl_user_role` VALUES ('2', '1', '2');
INSERT INTO `tbl_user_role` VALUES ('12', '2', '3');
INSERT INTO `tbl_user_role` VALUES ('14', '3', '1');
INSERT INTO `tbl_user_role` VALUES ('15', '4', '2');

-- ----------------------------
-- Procedure structure for get_tonkho_bymonth
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_tonkho_bymonth`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tonkho_bymonth`(fromDate date,toDate date)
BEGIN
select tbl_product.id productId, if(sum(t.count) is null,0,sum(count)) count,
tbl_product.name productName, tbl_product.code productCode, tbl_unit.name unitName,
tbl_product.WEIGHT weight, 
(select sum(count) count
from tbl_import_detail 
join tbl_product on tbl_import_detail.PRODUCT_ID = tbl_product.id
where DATE(tbl_import_detail.CREATED_DATE) >= fromDate and DATE(tbl_import_detail.CREATED_DATE) <= toDate
and type <> 0
and product_id = productId
group by product_id) sanluong,
(
select sum(count) count
from tbl_export_detail
 join tbl_unit on tbl_unit.id = tbl_export_detail.UNIT_ID
where DATE(tbl_export_detail.CREATED_DATE) >= fromDate and DATE(tbl_export_detail.CREATED_DATE) <= toDate
and product_id = productId
group by product_id
) sanluongxuat,
(select  if(count is null, 0, count) count
from tbl_import_detail 
 left join tbl_product on tbl_import_detail.PRODUCT_ID = tbl_product.id
where DATE(tbl_import_detail.CREATED_DATE) >= fromDate and DATE(tbl_import_detail.CREATED_DATE) <= toDate
and type = 0
and product_id = productId) tondauky
 from
(
select product_id, sum(count) count, tbl_product.UNIT_ID
from tbl_import_detail 
join tbl_product on tbl_import_detail.PRODUCT_ID = tbl_product.id
where DATE(tbl_import_detail.CREATED_DATE) >= fromDate and DATE(tbl_import_detail.CREATED_DATE) <= toDate
group by product_id
union 
select product_id, -sum(count) count,
 tbl_unit.ID unit_id
from tbl_export_detail
 join tbl_unit on tbl_unit.id = tbl_export_detail.UNIT_ID
where DATE(tbl_export_detail.CREATED_DATE) >= fromDate and DATE(tbl_export_detail.CREATED_DATE) <= toDate
group by product_id) t
right join tbl_product on t.product_id = tbl_product.id
 join tbl_unit on tbl_unit.id = tbl_product.unit_id
GROUP BY tbl_product.id 
order by tbl_product.id;
END
;;
DELIMITER ;
