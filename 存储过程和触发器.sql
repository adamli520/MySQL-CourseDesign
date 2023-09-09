-- 存储过程：

-- 创建GetInventoryAlerts的存储过程，用于获取库存警报信息
CREATE PROCEDURE GetInventoryAlerts(IN stockThreshold INT)
BEGIN
    SELECT p.ProductID AS '商品ID',
           p.ProductName AS '商品名称',
           s.SupplierName AS '供应商名称',
           i.CurrentStock AS '当前库存量'
    FROM products p
    INNER JOIN suppliers s ON p.SupplierID = s.SupplierID
    INNER JOIN inventory i ON p.ProductID = i.ProductID
    WHERE i.CurrentStock < stockThreshold;
END;

CALL GetInventoryAlerts(60);
-- 删除存储过程，
DROP PROCEDURE IF EXISTS GetInventoryAlerts;
SHOW PROCEDURE STATUS


-- 触发器


CREATE TRIGGER update_inventory_after_purchase
AFTER INSERT ON purchases
FOR EACH ROW
BEGIN
    -- 获取进货的产品ID和数量
    DECLARE productID INT;
    DECLARE quantity INT;
    DECLARE supplierID INT;
    
    SET productID = NEW.ProductID;
    SET quantity = NEW.Quantity;
    SET supplierID = NEW.SupplierID;
    
    -- 更新库存表中与该产品和供应商相关的库存数量
    UPDATE inventory
    SET CurrentStock = CurrentStock + quantity
    WHERE inventory.ProductID = productID AND inventory.SupplierID = supplierID;
    
END;

-- 这个触发器命名为update_customer_membership，在每次向销售表中插入新记录后执行。它通过获取插入的新记录的顾客ID和销售总价，并使用UPDATE语句将对应顾客的会员状态更新为1（成为会员），前提是销售总价超过1000。
CREATE TRIGGER update_customer_membership
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    DECLARE customer_id INT;
    DECLARE total_price DECIMAL(10, 2);
    
    SET customer_id = NEW.CustomerID;
    SET total_price = NEW.TotalPrice;
    
    IF total_price > 1000 THEN
        UPDATE customers
        SET IsMember = 1
        WHERE CustomerID = customer_id;
    END IF;
END;









