/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : t3-测试

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 11/06/2023 21:52:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `CustomerID` int NOT NULL AUTO_INCREMENT COMMENT '顾客ID',
  `CustomerName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客姓名',
  `CustomerPhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客电话',
  `CustomerEmail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '顾客邮箱',
  `RegistrationDate` date NULL DEFAULT NULL COMMENT '注册日期',
  `IsMember` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否会员，0表示不是，1表示是',
  PRIMARY KEY (`CustomerID`) USING BTREE,
  UNIQUE INDEX `unique_customer_phone`(`CustomerPhone` ASC) USING BTREE,
  UNIQUE INDEX `unique_customer_email`(`CustomerEmail` ASC) USING BTREE,
  CONSTRAINT `chk_customer_email` CHECK (`CustomerEmail` like _utf8mb4'%_@__%.__%'),
  CONSTRAINT `chk_customer_phone` CHECK (regexp_like(`CustomerPhone`,_utf8mb4'^[0-9]{11}$'))
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '顾客表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (1, '张三', '13812345678', 'zhangsan@example.com', '2023-06-01', 1);
INSERT INTO `customers` VALUES (2, '李四', '13912345678', 'lisi@example.com', '2023-06-02', 0);
INSERT INTO `customers` VALUES (3, '王五', '13712345678', 'wangwu@example.com', '2023-06-03', 1);
INSERT INTO `customers` VALUES (4, '赵六', '13612345678', 'zhaoliu@example.com', '2023-06-04', 0);
INSERT INTO `customers` VALUES (5, '陈七', '13512345678', 'chenqi@example.com', '2023-06-05', 1);
INSERT INTO `customers` VALUES (6, '刘八', '13412345678', 'liuba@example.com', '2023-06-06', 0);
INSERT INTO `customers` VALUES (7, '余九', '13312345678', 'zhoujiu@example.com', '2023-06-07', 1);
INSERT INTO `customers` VALUES (8, '钱十', '13212345678', 'qianshi@example.com', '2023-06-08', 0);
INSERT INTO `customers` VALUES (9, '孙十一', '13112345678', 'sunshiyi@example.com', '2023-06-09', 1);
INSERT INTO `customers` VALUES (10, '吴十二', '13012345678', 'wushier@example.com', '2023-06-10', 0);

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees`  (
  `EmployeeID` int NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `EmployeeName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工姓名',
  `EmployeePhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工电话',
  `EmployeeEmail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '员工邮箱',
  `HireDate` date NULL DEFAULT NULL COMMENT '入职日期',
  `Position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`EmployeeID`) USING BTREE,
  UNIQUE INDEX `unique_employee_phone`(`EmployeePhone` ASC) USING BTREE,
  UNIQUE INDEX `unique_employee_email`(`EmployeeEmail` ASC) USING BTREE,
  CONSTRAINT `chk_employee_email` CHECK (`EmployeeEmail` like _utf8mb4'%_@__%.__%'),
  CONSTRAINT `chk_employee_phone` CHECK (regexp_like(`EmployeePhone`,_utf8mb4'^[0-9]{11}$'))
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '员工表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO `employees` VALUES (1, '李军', '12345678901', 'zhangsan@example.com', '2023-01-01', '收银员');
INSERT INTO `employees` VALUES (2, '龚益', '12345678902', 'lisi@example.com', '2023-01-02', '店长');
INSERT INTO `employees` VALUES (3, '王蜥蜴', '12345678903', 'wangwu@example.com', '2023-01-03', '导购员');
INSERT INTO `employees` VALUES (4, '黄博', '12345678904', 'zhaoliu@example.com', '2023-01-04', '采购员');
INSERT INTO `employees` VALUES (5, '钱七', '12345678905', 'qianqi@example.com', '2023-01-05', '仓管员');
INSERT INTO `employees` VALUES (6, '孙八', '12345678906', 'sunba@example.com', '2023-01-06', '收银员');
INSERT INTO `employees` VALUES (7, '周九', '12345678907', 'zhoujiu@example.com', '2023-01-07', '导购员');
INSERT INTO `employees` VALUES (8, '吴十', '12345678908', 'wushi@example.com', '2023-01-08', '收银员');
INSERT INTO `employees` VALUES (9, '郑一', '12345678909', 'zhengyi@example.com', '2023-01-09', '店长');
INSERT INTO `employees` VALUES (10, '黄二', '12345678910', 'huanger@example.com', '2023-01-10', '导购员');

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory`  (
  `ProductID` int NOT NULL COMMENT '商品ID',
  `SupplierID` int NOT NULL COMMENT '供应商ID',
  `CurrentStock` int NOT NULL COMMENT '当前库存量',
  PRIMARY KEY (`ProductID`, `SupplierID`) USING BTREE,
  INDEX `SupplierID`(`SupplierID` ASC) USING BTREE,
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES (1, 2, 100);
INSERT INTO `inventory` VALUES (2, 2, 50);
INSERT INTO `inventory` VALUES (3, 2, 75);
INSERT INTO `inventory` VALUES (4, 4, 200);
INSERT INTO `inventory` VALUES (5, 4, 150);
INSERT INTO `inventory` VALUES (6, 3, 80);
INSERT INTO `inventory` VALUES (7, 3, 120);
INSERT INTO `inventory` VALUES (8, 7, 90);
INSERT INTO `inventory` VALUES (9, 6, 60);
INSERT INTO `inventory` VALUES (10, 6, 110);
INSERT INTO `inventory` VALUES (21, 1, 100);
INSERT INTO `inventory` VALUES (22, 1, 50);
INSERT INTO `inventory` VALUES (23, 1, 75);
INSERT INTO `inventory` VALUES (24, 1, 200);
INSERT INTO `inventory` VALUES (25, 9, 150);
INSERT INTO `inventory` VALUES (26, 1, 80);
INSERT INTO `inventory` VALUES (27, 5, 120);
INSERT INTO `inventory` VALUES (28, 10, 90);
INSERT INTO `inventory` VALUES (29, 9, 60);
INSERT INTO `inventory` VALUES (30, 10, 110);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `ProductID` int NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `SupplierID` int NOT NULL COMMENT '供应商ID',
  `ProductName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `Category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品分类',
  `UnitPrice` decimal(10, 2) NOT NULL COMMENT '商品单价',
  `StockQuantity` int NOT NULL COMMENT '库存数量',
  PRIMARY KEY (`ProductID`) USING BTREE,
  INDEX `fk_supplier`(`SupplierID` ASC) USING BTREE,
  CONSTRAINT `fk_supplier` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 2, '苹果14', '电子产品', 9800.00, 20);
INSERT INTO `products` VALUES (2, 2, '华硕ROG魔霸7plus', '电子产品', 12999.00, 10);
INSERT INTO `products` VALUES (3, 2, '华硕ROG幻16', '电子产品', 11999.00, 6);
INSERT INTO `products` VALUES (4, 4, '苹果', '水果', 2.99, 100);
INSERT INTO `products` VALUES (5, 4, '香蕉', '水果', 1.99, 150);
INSERT INTO `products` VALUES (6, 3, '牛奶', '乳制品', 4.99, 50);
INSERT INTO `products` VALUES (7, 3, '鸡蛋', '禽蛋类', 2.49, 200);
INSERT INTO `products` VALUES (8, 7, '面包', '烘焙', 3.49, 80);
INSERT INTO `products` VALUES (9, 6, '牛肉', '肉类', 9.99, 30);
INSERT INTO `products` VALUES (10, 6, '鱼', '海鲜', 6.99, 40);
INSERT INTO `products` VALUES (11, 1, '酸奶', '乳制品', 1.79, 100);
INSERT INTO `products` VALUES (12, 1, '咖啡', '饮料', 5.99, 60);
INSERT INTO `products` VALUES (13, 1, '巧克力', '零食', 2.99, 120);
INSERT INTO `products` VALUES (14, 9, '洗发水', '个护', 7.99, 90);
INSERT INTO `products` VALUES (15, 10, '抽纸', '生活用品', 2.49, 200);
INSERT INTO `products` VALUES (16, 9, '洗衣液', '家居清洁', 9.99, 70);
INSERT INTO `products` VALUES (17, 10, '面巾纸', '生活用品', 1.99, 150);
INSERT INTO `products` VALUES (18, 1, '口香糖', '零食', 0.99, 300);
INSERT INTO `products` VALUES (19, 1, '红酒', '酒类', 19.99, 20);
INSERT INTO `products` VALUES (20, 1, '啤酒', '酒类', 2.99, 100);
INSERT INTO `products` VALUES (21, 1, '方便面', '速食', 3.49, 120);
INSERT INTO `products` VALUES (22, 1, '橙汁', '饮料', 4.99, 80);
INSERT INTO `products` VALUES (23, 1, '薯片', '零食', 1.99, 200);
INSERT INTO `products` VALUES (24, 1, '面条', '速食', 2.49, 150);
INSERT INTO `products` VALUES (25, 9, '洗洁精', '家居清洁', 3.99, 100);
INSERT INTO `products` VALUES (26, 1, '饼干', '零食', 1.49, 250);
INSERT INTO `products` VALUES (27, 5, '茶叶', '饮料', 6.99, 70);
INSERT INTO `products` VALUES (28, 10, '口罩', '生活用品', 0.99, 500);
INSERT INTO `products` VALUES (29, 9, '牙刷', '个护', 2.99, 120);
INSERT INTO `products` VALUES (30, 10, '香水', '个护', 29.99, 40);
INSERT INTO `products` VALUES (31, 1, '啤酒脆片', '零食', 3.99, 80);
INSERT INTO `products` VALUES (32, 5, '绿茶', '饮料', 1.99, 200);
INSERT INTO `products` VALUES (33, 9, '洗面奶', '个护', 8.99, 60);
INSERT INTO `products` VALUES (34, 1, '雪碧', '饮料', 1.49, 300);
INSERT INTO `products` VALUES (35, 10, '洗手液', '个护', 4.99, 150);
INSERT INTO `products` VALUES (36, 1, '薯条', '速食', 2.99, 100);
INSERT INTO `products` VALUES (37, 1, '果冻', '零食', 0.99, 200);
INSERT INTO `products` VALUES (38, 9, '牙膏', '个护', 3.99, 80);
INSERT INTO `products` VALUES (39, 1, '花生', '零食', 1.49, 250);
INSERT INTO `products` VALUES (40, 9, '洗衣粉', '家居清洁', 6.99, 70);
INSERT INTO `products` VALUES (41, 4, '橙子', '水果', 2.99, 120);
INSERT INTO `products` VALUES (42, 1, '可乐', '饮料', 1.99, 180);
INSERT INTO `products` VALUES (43, 7, '蛋糕', '烘焙', 9.99, 40);
INSERT INTO `products` VALUES (44, 4, '草莓', '水果', 3.99, 80);
INSERT INTO `products` VALUES (45, 6, '牛排', '肉类', 14.99, 25);
INSERT INTO `products` VALUES (46, 1, '零食礼盒', '零食', 9.99, 50);
INSERT INTO `products` VALUES (47, 1, '矿泉水', '饮料', 0.99, 200);
INSERT INTO `products` VALUES (48, 7, '面粉', '烘焙', 2.49, 100);
INSERT INTO `products` VALUES (49, 9, '洗碗液', '家居清洁', 3.99, 70);
INSERT INTO `products` VALUES (50, 8, '花卉', '生活用品', 6.99, 30);
INSERT INTO `products` VALUES (51, 6, '火腿', '肉类', 7.99, 60);
INSERT INTO `products` VALUES (52, 1, '方便火锅', '速食', 8.99, 40);
INSERT INTO `products` VALUES (53, 7, '雪糕', '冰品', 4.99, 90);

-- ----------------------------
-- Table structure for purchases
-- ----------------------------
DROP TABLE IF EXISTS `purchases`;
CREATE TABLE `purchases`  (
  `PurchaseID` int NOT NULL AUTO_INCREMENT COMMENT '进货ID',
  `SupplierID` int NOT NULL COMMENT '供应商ID',
  `ProductID` int NOT NULL COMMENT '商品ID',
  `Quantity` int NOT NULL COMMENT '进货数量',
  `PurchaseDate` date NULL DEFAULT NULL COMMENT '进货日期',
  PRIMARY KEY (`PurchaseID`) USING BTREE,
  INDEX `SupplierID`(`SupplierID` ASC) USING BTREE,
  INDEX `ProductID`(`ProductID` ASC) USING BTREE,
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '进货表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of purchases
-- ----------------------------
INSERT INTO `purchases` VALUES (1, 2, 1, 200, '2023-05-01');
INSERT INTO `purchases` VALUES (2, 4, 5, 100, '2023-05-02');
INSERT INTO `purchases` VALUES (3, 6, 10, 50, '2023-05-03');
INSERT INTO `purchases` VALUES (4, 10, 15, 80, '2023-05-04');
INSERT INTO `purchases` VALUES (5, 1, 20, 150, '2023-05-05');
INSERT INTO `purchases` VALUES (6, 9, 25, 70, '2023-05-06');
INSERT INTO `purchases` VALUES (7, 10, 30, 90, '2023-05-07');
INSERT INTO `purchases` VALUES (8, 10, 35, 120, '2023-05-08');
INSERT INTO `purchases` VALUES (9, 9, 40, 60, '2023-05-09');
INSERT INTO `purchases` VALUES (10, 6, 45, 100, '2023-05-10');
INSERT INTO `purchases` VALUES (11, 2, 2, 80, '2023-05-20');
INSERT INTO `purchases` VALUES (12, 3, 7, 150, '2023-05-21');
INSERT INTO `purchases` VALUES (13, 1, 12, 70, '2023-05-22');
INSERT INTO `purchases` VALUES (14, 10, 17, 90, '2023-05-23');
INSERT INTO `purchases` VALUES (15, 1, 22, 120, '2023-05-24');
INSERT INTO `purchases` VALUES (16, 2, 3, 100, '2023-05-29');
INSERT INTO `purchases` VALUES (17, 7, 8, 50, '2023-05-30');
INSERT INTO `purchases` VALUES (18, 1, 13, 80, '2023-05-31');

-- ----------------------------
-- Table structure for returns
-- ----------------------------
DROP TABLE IF EXISTS `returns`;
CREATE TABLE `returns`  (
  `ReturnID` int NOT NULL AUTO_INCREMENT COMMENT '退货ID',
  `SaleID` int NOT NULL COMMENT '销售ID',
  `CustomerID` int NOT NULL COMMENT '顾客ID',
  `ProductID` int NOT NULL COMMENT '商品ID',
  `Quantity` int NOT NULL COMMENT '退货数量',
  `ReturnDate` date NULL DEFAULT NULL COMMENT '退货日期',
  PRIMARY KEY (`ReturnID`) USING BTREE,
  INDEX `SaleID`(`SaleID` ASC) USING BTREE,
  INDEX `CustomerID`(`CustomerID` ASC) USING BTREE,
  INDEX `ProductID`(`ProductID` ASC) USING BTREE,
  CONSTRAINT `returns_ibfk_1` FOREIGN KEY (`SaleID`) REFERENCES `sales` (`SaleID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `returns_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `returns_ibfk_3` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '退货表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of returns
-- ----------------------------
INSERT INTO `returns` VALUES (1, 1, 1, 1, 2, '2023-06-01');
INSERT INTO `returns` VALUES (2, 2, 2, 3, 1, '2023-06-02');
INSERT INTO `returns` VALUES (3, 3, 3, 2, 3, '2023-06-03');
INSERT INTO `returns` VALUES (4, 4, 4, 5, 2, '2023-06-04');
INSERT INTO `returns` VALUES (5, 5, 5, 4, 1, '2023-06-05');
INSERT INTO `returns` VALUES (6, 6, 1, 1, 3, '2023-06-06');
INSERT INTO `returns` VALUES (7, 7, 2, 3, 1, '2023-06-07');
INSERT INTO `returns` VALUES (8, 8, 3, 2, 2, '2023-06-08');
INSERT INTO `returns` VALUES (9, 9, 4, 5, 1, '2023-06-09');
INSERT INTO `returns` VALUES (10, 10, 5, 4, 2, '2023-06-10');

-- ----------------------------
-- Table structure for sale_details
-- ----------------------------
DROP TABLE IF EXISTS `sale_details`;
CREATE TABLE `sale_details`  (
  `SaleDetailID` int NOT NULL AUTO_INCREMENT COMMENT '销售明细ID',
  `SaleID` int NOT NULL COMMENT '销售ID',
  `ProductID` int NOT NULL COMMENT '商品ID',
  `Quantity` int NOT NULL COMMENT '销售数量',
  `UnitPrice` decimal(10, 2) NOT NULL COMMENT '销售单价',
  PRIMARY KEY (`SaleDetailID`) USING BTREE,
  INDEX `SaleID`(`SaleID` ASC) USING BTREE,
  INDEX `ProductID`(`ProductID` ASC) USING BTREE,
  CONSTRAINT `sale_details_ibfk_1` FOREIGN KEY (`SaleID`) REFERENCES `sales` (`SaleID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sale_details_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '销售明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sale_details
-- ----------------------------
INSERT INTO `sale_details` VALUES (1, 1, 1, 5, 999.00);
INSERT INTO `sale_details` VALUES (2, 1, 2, 3, 20.00);
INSERT INTO `sale_details` VALUES (3, 2, 3, 2, 200.00);
INSERT INTO `sale_details` VALUES (4, 2, 4, 4, 12.50);
INSERT INTO `sale_details` VALUES (5, 3, 5, 1, 30.00);
INSERT INTO `sale_details` VALUES (6, 3, 6, 2, 25.00);
INSERT INTO `sale_details` VALUES (7, 4, 7, 3, 8.00);
INSERT INTO `sale_details` VALUES (8, 4, 8, 2, 18.00);
INSERT INTO `sale_details` VALUES (9, 5, 9, 4, 22.00);
INSERT INTO `sale_details` VALUES (10, 5, 6, 1, 40.00);
INSERT INTO `sale_details` VALUES (11, 6, 4, 5, 25.00);
INSERT INTO `sale_details` VALUES (12, 7, 9, 3, 20.00);
INSERT INTO `sale_details` VALUES (13, 8, 10, 8, 15.00);
INSERT INTO `sale_details` VALUES (14, 9, 4, 3, 30.00);
INSERT INTO `sale_details` VALUES (15, 10, 3, 2, 200.00);

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales`  (
  `SaleID` int NOT NULL AUTO_INCREMENT COMMENT '销售ID',
  `CustomerID` int NOT NULL COMMENT '顾客ID',
  `EmployeeID` int NOT NULL COMMENT '员工ID',
  `SaleDate` date NULL DEFAULT NULL COMMENT '销售日期',
  `TotalPrice` decimal(10, 2) NOT NULL COMMENT '销售总价',
  PRIMARY KEY (`SaleID`) USING BTREE,
  INDEX `sale_customer`(`CustomerID` ASC) USING BTREE,
  INDEX `sale_employee`(`EmployeeID` ASC) USING BTREE,
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '销售表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sales
-- ----------------------------
INSERT INTO `sales` VALUES (1, 1, 1, '2023-05-01', 5055.00);
INSERT INTO `sales` VALUES (2, 2, 2, '2023-05-02', 450.00);
INSERT INTO `sales` VALUES (3, 3, 3, '2023-05-03', 80.00);
INSERT INTO `sales` VALUES (4, 4, 4, '2023-05-04', 60.00);
INSERT INTO `sales` VALUES (5, 5, 5, '2023-05-05', 128.00);
INSERT INTO `sales` VALUES (6, 6, 6, '2023-05-06', 125.00);
INSERT INTO `sales` VALUES (7, 7, 7, '2023-05-07', 60.00);
INSERT INTO `sales` VALUES (8, 8, 8, '2023-05-08', 120.00);
INSERT INTO `sales` VALUES (9, 9, 9, '2023-05-09', 90.00);
INSERT INTO `sales` VALUES (10, 10, 10, '2023-05-10', 400.00);

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `SupplierID` int NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `SupplierName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商名称',
  `ContactPerson` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `SupplierPhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商电话',
  `SupplierEmail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商邮箱',
  `Address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`SupplierID`) USING BTREE,
  UNIQUE INDEX `unique_supplier_phone`(`SupplierPhone` ASC) USING BTREE,
  UNIQUE INDEX `unique_supplier_email`(`SupplierEmail` ASC) USING BTREE,
  CONSTRAINT `chk_supplier_email` CHECK (`SupplierEmail` like _utf8mb4'%_@__%.__%'),
  CONSTRAINT `chk_supplier_phone` CHECK (regexp_like(`SupplierPhone`,_utf8mb4'^[0-9]{11}$'))
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '供应商表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES (1, 'ABC食品公司', '孙十三', '12345678911', 'abcfood@example.com', '某市某区某街道1号');
INSERT INTO `suppliers` VALUES (2, 'XYZ百货商行', 'tony大叔', '12345678912', 'xyzretail@example.com', '某市某区某街道2号');
INSERT INTO `suppliers` VALUES (3, '优选农场', '杨十四', '12345678913', 'premiumfarm@example.com', '某市某区某街道3号');
INSERT INTO `suppliers` VALUES (4, '鲜果供应', '朱十五', '12345678914', 'freshfruit@example.com', '某市某区某街道4号');
INSERT INTO `suppliers` VALUES (5, '绿叶茶庄', '周十六', '12345678915', 'greenleaftea@example.com', '某市某区某街道5号');
INSERT INTO `suppliers` VALUES (6, '优质肉类供应商', '吴十七', '12345678916', 'premiummeat@example.com', '某市某区某街道6号');
INSERT INTO `suppliers` VALUES (7, '美味糕点厂', '郑十八', '12345678917', 'deliciousbakery@example.com', '某市某区某街道7号');
INSERT INTO `suppliers` VALUES (8, '鲜花艺术', '王十九', '12345678918', 'flowerart@example.com', '某市某区某街道8号');
INSERT INTO `suppliers` VALUES (9, '家居用品供应商', '冯二十', '12345678919', 'homeware@example.com', '某市某区某街道9号');
INSERT INTO `suppliers` VALUES (10, '日用品批发', '陈二十一', '12345678920', 'dailyessentials@example.com', '某市某区某街道10号');

-- ----------------------------
-- View structure for product_inventory
-- ----------------------------
DROP VIEW IF EXISTS `product_inventory`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `product_inventory` AS select `p`.`ProductName` AS `商品名称`,`s`.`SupplierName` AS `供应商名称`,`i`.`CurrentStock` AS `当前库存量` from ((`products` `p` join `inventory` `i` on((`p`.`ProductID` = `i`.`ProductID`))) join `suppliers` `s` on((`i`.`SupplierID` = `s`.`SupplierID`)));

-- ----------------------------
-- View structure for purchase_details_view
-- ----------------------------
DROP VIEW IF EXISTS `purchase_details_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `purchase_details_view` AS select `p`.`PurchaseID` AS `PurchaseID`,`s`.`SupplierName` AS `SupplierName`,`pr`.`ProductName` AS `ProductName`,`p`.`Quantity` AS `Quantity`,`p`.`PurchaseDate` AS `PurchaseDate` from ((`purchases` `p` join `suppliers` `s` on((`p`.`SupplierID` = `s`.`SupplierID`))) join `products` `pr` on((`p`.`ProductID` = `pr`.`ProductID`)));

-- ----------------------------
-- View structure for return_details_view
-- ----------------------------
DROP VIEW IF EXISTS `return_details_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `return_details_view` AS select `r`.`ReturnID` AS `ReturnID`,`s`.`SaleID` AS `SaleID`,`c`.`CustomerName` AS `CustomerName`,`pr`.`ProductName` AS `ProductName`,`r`.`Quantity` AS `Quantity`,`r`.`ReturnDate` AS `ReturnDate` from (((`returns` `r` join `sales` `s` on((`r`.`SaleID` = `s`.`SaleID`))) join `customers` `c` on((`r`.`CustomerID` = `c`.`CustomerID`))) join `products` `pr` on((`r`.`ProductID` = `pr`.`ProductID`)));

-- ----------------------------
-- View structure for sale_details_view
-- ----------------------------
DROP VIEW IF EXISTS `sale_details_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sale_details_view` AS select `s`.`SaleID` AS `SaleID`,`c`.`CustomerName` AS `CustomerName`,`e`.`EmployeeName` AS `EmployeeName`,`sd`.`ProductID` AS `ProductID`,`p`.`ProductName` AS `ProductName`,`sd`.`Quantity` AS `Quantity`,`sd`.`UnitPrice` AS `UnitPrice` from ((((`sale_details` `sd` join `sales` `s` on((`sd`.`SaleID` = `s`.`SaleID`))) join `customers` `c` on((`s`.`CustomerID` = `c`.`CustomerID`))) join `employees` `e` on((`s`.`EmployeeID` = `e`.`EmployeeID`))) join `products` `p` on((`sd`.`ProductID` = `p`.`ProductID`)));

-- ----------------------------
-- Procedure structure for GetInventoryAlerts
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetInventoryAlerts`;
delimiter ;;
CREATE PROCEDURE `GetInventoryAlerts`(IN stockThreshold INT)
BEGIN
    SELECT p.ProductID AS '商品ID',
           p.ProductName AS '商品名称',
           s.SupplierName AS '供应商名称',
           i.CurrentStock AS '当前库存量'
    FROM products p
    INNER JOIN suppliers s ON p.SupplierID = s.SupplierID
    INNER JOIN inventory i ON p.ProductID = i.ProductID
    WHERE i.CurrentStock < stockThreshold;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
