-- 创建商品库存视图
CREATE VIEW product_inventory AS
SELECT p.ProductName AS 商品名称, s.SupplierName AS 供应商名称, i.CurrentStock AS 当前库存量
FROM products p
JOIN inventory i ON p.ProductID = i.ProductID
JOIN suppliers s ON i.SupplierID = s.SupplierID;

-- 创建销售详情视图
CREATE VIEW sale_details_view AS
SELECT s.SaleID, c.CustomerName, e.EmployeeName, sd.ProductID, p.ProductName, sd.Quantity, sd.UnitPrice
FROM sale_details sd
JOIN sales s ON sd.SaleID = s.SaleID
JOIN customers c ON s.CustomerID = c.CustomerID
JOIN employees e ON s.EmployeeID = e.EmployeeID
JOIN products p ON sd.ProductID = p.ProductID;

-- 创建进货详情视图
CREATE VIEW purchase_details_view AS
SELECT p.PurchaseID, s.SupplierName, pr.ProductName, p.Quantity, p.PurchaseDate
FROM purchases p
JOIN suppliers s ON p.SupplierID = s.SupplierID
JOIN products pr ON p.ProductID = pr.ProductID;

-- 创建退货详情视图
CREATE VIEW return_details_view AS
SELECT r.ReturnID, s.SaleID, c.CustomerName, pr.ProductName, r.Quantity, r.ReturnDate
FROM returns r
JOIN sales s ON r.SaleID = s.SaleID
JOIN customers c ON r.CustomerID = c.CustomerID
JOIN products pr ON r.ProductID = pr.ProductID;
