-- 顾客权限
GRANT SELECT, INSERT, UPDATE, DELETE ON customers TO zhangsan@localhost;

-- 员工权限
GRANT SELECT, INSERT, UPDATE, DELETE ON * TO lijun@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO lijun@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON sales TO lijun@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON sale_details TO lijun@localhost;

-- 供应商权限
GRANT SELECT, INSERT, UPDATE ON suppliers TO rog@localhost;
GRANT SELECT, INSERT, UPDATE ON products TO rog@localhost;
GRANT SELECT, INSERT, UPDATE ON inventory TO rog@localhost;
GRANT SELECT, INSERT ON purchases TO rog@localhost;


SHOW GRANTS FOR rog@localhost;