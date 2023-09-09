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

 Date: 11/06/2023 21:52:28
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
