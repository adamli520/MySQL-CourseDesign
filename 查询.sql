-- 查询用户购买信息：
SELECT c.CustomerName AS 顾客姓名, p.ProductName AS 商品名称, sd.Quantity AS 购买数量, sd.UnitPrice AS 单价, s.SaleDate AS 销售日期
FROM customers c
JOIN sales s ON c.CustomerID = s.CustomerID
JOIN sale_details sd ON s.SaleID = sd.SaleID
JOIN products p ON sd.ProductID = p.ProductID
WHERE c.CustomerID = 1;

-- 查询销售信息：
SELECT s.SaleID AS 销售ID, c.CustomerName AS 顾客姓名, e.EmployeeName AS 员工姓名, s.TotalPrice AS 销售总价, s.SaleDate AS 销售日期
FROM sales s
JOIN customers c ON s.CustomerID = c.CustomerID
JOIN employees e ON s.EmployeeID = e.EmployeeID;

-- 查询商品库存信息：
SELECT p.ProductName AS 商品名称, s.SupplierName AS 供应商名称, i.CurrentStock AS 当前库存量
FROM products p
JOIN inventory i ON p.ProductID = i.ProductID
JOIN suppliers s ON i.SupplierID = s.SupplierID
ORDER BY p.ProductID;

-- 更新数据

UPDATE sales s
SET TotalPrice = (
  SELECT SUM(sd.Quantity * sd.UnitPrice)
  FROM sale_details sd
  WHERE sd.SaleID = s.SaleID
)

UPDATE inventory i
INNER JOIN products p ON i.ProductID = p.ProductID
SET i.SupplierID = p.SupplierID;

UPDATE purchases p
JOIN products cp ON p.ProductID = cp.ProductID
SET p.SupplierID = cp.SupplierID;