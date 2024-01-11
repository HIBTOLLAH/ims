
CREATE TABLE ims_category (
  categoryid INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(250) NOT NULL,
  status ENUM('active', 'inactive') NOT NULL,
  PRIMARY KEY (categoryid)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ims_supplier (
  supplier_id INT NOT NULL AUTO_INCREMENT,
  supplier_name VARCHAR(200) NOT NULL,
  mobile VARCHAR(50) NOT NULL,
  address TEXT NOT NULL,
  status ENUM('active', 'inactive') NOT NULL,
  PRIMARY KEY (supplier_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ims_brand (
  id INT NOT NULL AUTO_INCREMENT,
  categoryid INT NOT NULL,
  bname VARCHAR(250) NOT NULL,
  status ENUM('active', 'inactive') NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (categoryid) REFERENCES ims_category(categoryid)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- إنشاء جدول ims_customer
CREATE TABLE ims_customer (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL,
  address TEXT NOT NULL,
  mobile INT NOT NULL,
  balance DOUBLE(10,2) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ims_order (
  order_id INT NOT NULL AUTO_INCREMENT,
  product_id VARCHAR(255) NOT NULL,
  total_shipped INT NOT NULL,
  customer_id INT NOT NULL,
  order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id),
  FOREIGN KEY (product_id) REFERENCES ims_product(pid),
  FOREIGN KEY (customer_id) REFERENCES ims_customer(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ims_purchase (
  purchase_id INT NOT NULL AUTO_INCREMENT,
  supplier_id VARCHAR(255) NOT NULL,
  product_id VARCHAR(255) NOT NULL,
  quantity VARCHAR(255) NOT NULL,
  purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_id),
  FOREIGN KEY (supplier_id) REFERENCES ims_supplier(supplier_id),
  FOREIGN KEY (product_id) REFERENCES ims_product(pid)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ims_user (
  userid INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(200) NOT NULL,
  password VARCHAR(200) NOT NULL,
  name VARCHAR(200) NOT NULL,
  type ENUM('admin', 'member') NOT NULL,
  status ENUM('Active', 'Inactive') NOT NULL,
  PRIMARY KEY (userid)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ims_product (
  pid INT NOT NULL AUTO_INCREMENT,
  categoryid INT NOT NULL,
  brandid INT NOT NULL,
  pname VARCHAR(300) NOT NULL,
  model VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  quantity INT NOT NULL,
  unit VARCHAR(150) NOT NULL,
  base_price DOUBLE(10,2) NOT NULL,
  tax DECIMAL(4,2) NOT NULL,
  minimum_order DOUBLE(10,2) NOT NULL,
  supplier INT NOT NULL,
  status ENUM('active', 'inactive') NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY (pid),
  FOREIGN KEY (categoryid) REFERENCES ims_category(categoryid),
  FOREIGN KEY (brandid) REFERENCES ims_brand(id),
  FOREIGN KEY (supplier) REFERENCES ims_supplier(supplier_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DELIMITER $$

CREATE PROCEDURE AddCustomer(
    IN customerName VARCHAR(200),
    IN customerAddress TEXT,
    IN customerMobile INT,
    IN customerBalance DOUBLE(10,2)
)
BEGIN
    INSERT INTO ims_customer (name, address, mobile, balance)
    VALUES (customerName, customerAddress, customerMobile, customerBalance);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE UpdateCustomer(
    IN customerId INT,
    IN customerName VARCHAR(200),
    IN customerAddress TEXT,
    IN customerMobile INT,
    IN customerBalance DOUBLE(10,2)
)
BEGIN
    UPDATE ims_customer
    SET
        name = customerName,
        address = customerAddress,
        mobile = customerMobile,
        balance = customerBalance
    WHERE id = customerId;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE DeleteCustomer(
    IN customerId INT
)
BEGIN
    DELETE FROM ims_customer WHERE id = customerId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE GetCustomerDetails(
    IN customerId INT
)
BEGIN
    SELECT * FROM ims_customer WHERE id = customerId;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE AddSupplier(
    IN supplierName VARCHAR(200),
    IN supplierMobile VARCHAR(50),
    IN supplierAddress TEXT
)
BEGIN
    INSERT INTO ims_supplier (supplier_name, mobile, address)
    VALUES (supplierName, supplierMobile, supplierAddress);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE DeleteSupplier(
    IN supplierId INT
)
BEGIN
    DELETE FROM ims_supplier WHERE supplier_id = supplierId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE UpdateSupplier(
    IN supplierId INT,
    IN supplierName VARCHAR(200),
    IN supplierMobile VARCHAR(50),
    IN supplierAddress TEXT
)
BEGIN
    UPDATE ims_supplier
    SET
        supplier_name = supplierName,
        mobile = supplierMobile,
        address = supplierAddress
    WHERE supplier_id = supplierId;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE GetSupplierDetails(
    IN supplierId INT
)
BEGIN
    SELECT * FROM ims_supplier WHERE supplier_id = supplierId;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE AddOrder(
    IN productId INT,
    IN totalShipped INT,
    IN customerId INT
)
BEGIN
    INSERT INTO ims_order (product_id, total_shipped, customer_id, order_date)
    VALUES (productId, totalShipped, customerId, CURRENT_TIMESTAMP);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE UpdateOrder(
    IN orderId INT,
    IN productId INT,
    IN totalShipped INT,
    IN customerId INT
)
BEGIN
    UPDATE ims_order
    SET
        product_id = productId,
        total_shipped = totalShipped,
        customer_id = customerId,
        order_date = CURRENT_TIMESTAMP
    WHERE order_id = orderId;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE DeleteOrder(
    IN orderId INT
)
BEGIN
    DELETE FROM ims_order WHERE order_id = orderId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE GetOrderDetails(
    IN orderId INT
)
BEGIN
    SELECT * FROM ims_order WHERE order_id = orderId;
END $$

DELIMITER ;





DELIMITER $$

CREATE PROCEDURE AddBrand(
    IN categoryId INT,
    IN brandName VARCHAR(250),
    IN status ENUM('active','inactive')
)
BEGIN
    INSERT INTO ims_brand (categoryid, bname, status)
    VALUES (categoryId, brandName, status);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE DeleteBrand(
    IN brandId INT
)
BEGIN
    DELETE FROM ims_brand WHERE id = brandId;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE UpdateBrand(
    IN brandId INT,
    IN categoryId INT,
    IN brandName VARCHAR(250),
    IN status ENUM('active','inactive')
)
BEGIN
    UPDATE ims_brand
    SET
        categoryid = categoryId,
        bname = brandName,
        status = status
    WHERE id = brandId;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE GetBrandDetails(
    IN brandId INT
)
BEGIN
    SELECT * FROM ims_brand WHERE id = brandId;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE AddCategory(
    IN categoryName VARCHAR(250),
    IN status ENUM('active','inactive')
)
BEGIN
    INSERT INTO ims_category (name, status)
    VALUES (categoryName, status);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE UpdateCategory(
    IN categoryId INT,
    IN categoryName VARCHAR(250),
    IN status ENUM('active','inactive')
)
BEGIN
    UPDATE ims_category
    SET
        name = categoryName,
        status = status
    WHERE categoryid = categoryId;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE DeleteCategory(
    IN categoryId INT
)
BEGIN
    DELETE FROM ims_category WHERE categoryid = categoryId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE GetCategoryDetails(
    IN categoryId INT
)
BEGIN
    SELECT * FROM ims_category WHERE categoryid = categoryId;
END $$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE AddPurchase(
    IN supplierId INT,
    IN productId VARCHAR(255),
    IN quantity VARCHAR(255)
)
BEGIN
    INSERT INTO ims_purchase (supplier_id, product_id, quantity, purchase_date)
    VALUES (supplierId, productId, quantity, CURRENT_TIMESTAMP);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE DeletePurchase(
    IN purchaseId INT
)
BEGIN
    DELETE FROM ims_purchase WHERE purchase_id = purchaseId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE UpdatePurchase(
    IN purchaseId INT,
    IN supplierId INT,
    IN productId VARCHAR(255),
    IN quantity VARCHAR(255)
)
BEGIN
    UPDATE ims_purchase
    SET
        supplier_id = supplierId,
        product_id = productId,
        quantity = quantity,
        purchase_date = CURRENT_TIMESTAMP
    WHERE purchase_id = purchaseId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE GetPurchaseDetails(
    IN purchaseId INT
)
BEGIN
    SELECT * FROM ims_purchase WHERE purchase_id = purchaseId;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE CalculateCustomerBalance(
    IN customerId INT
)
BEGIN
    DECLARE totalPurchaseAmount DOUBLE;
    DECLARE totalPaymentAmount DOUBLE;

    -- Toplam satın alma tutarını hesapla
    SELECT SUM(oi.base_price * oi.quantity) INTO totalPurchaseAmount
    FROM ims_order o
    JOIN ims_product oi ON o.product_id = oi.pid
    WHERE o.customer_id = customerId;

    -- Toplam ödeme tutarını hesapla
    SELECT SUM(od.odeme_tutar) INTO totalPaymentAmount
    FROM abc_odemeler od
    WHERE od.musteri_id = customerId;

    -- Bakiyeyi hesapla
    SELECT (totalPaymentAmount - totalPurchaseAmount) AS customerBalance;
END $$

DELIMITER ;





-- Müşterinin bakiyesini kontrol etmek için tetikleyici
DELIMITER $$
CREATE TRIGGER check_customer_balance
BEFORE INSERT ON ims_order FOR EACH ROW
BEGIN
  DECLARE current_balance DOUBLE;

  -- Müşterinin güncel bakiyesini al
  SELECT balance INTO current_balance
  FROM ims_customer
  WHERE id = NEW.customer_id;

  -- Müşterinin yeterli bakiyesi olup olmadığını kontrol et
  IF current_balance < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Müşterinin yeterli bakiyesi yok';
  END IF;
END;
$$
DELIMITER ;


-- Satın almadan önce satın alınan miktarı kontrol etmek için tetikleyici
DELIMITER $$
CREATE TRIGGER check_purchase_quantity
BEFORE INSERT ON ims_purchase FOR EACH ROW
BEGIN
  -- Satın alınan miktarın pozitif olup olmadığını kontrol et
  IF NEW.quantity < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Geçersiz negatif miktar satın alma';
  END IF;
END;
$$
DELIMITER ;


-- Sipariş toplam tutarını al
  DECLARE order_total DOUBLE;
  SELECT SUM(p.base_price) INTO order_total
  FROM ims_product p
  WHERE p.pid IN (SELECT product_id FROM ims_order WHERE order_id = NEW.order_id);




--Belirli bir kategoriye ait ürünleri listeleme:
SELECT * 
FROM ims_product 
WHERE categoryid = [belirli_kategori_id];


--Belirli bir markaya ait ürünleri listeleme:

SELECT * 
FROM ims_product 
WHERE brandid = [belirli_marka_id];


--Belirli bir müşterinin yaptığı siparişleri listeleme:
SELECT * 
FROM ims_order 
WHERE customer_id = [belirli_musteri_id];


--Belirli bir tarihte yapılan siparişleri listeleme:
SELECT * 
FROM ims_order 
WHERE order_date >= 'belirli_tarih';

--Belirli bir ürün için yapılan alımları listeleme:
SELECT * 
FROM ims_purchase 
WHERE product_id = [belirli_urun_id];
 
--Belirli bir tedarikçinin sağladığı ürünleri listeleme:
SELECT * 
FROM ims_product 
WHERE supplier = [belirli_tedarikci_id];

--Belirli bir müşterinin bakiyesini güncelleme:
UPDATE ims_customer 
SET balance = [yeni_bakiye] 
WHERE id = [belirli_musteri_id];


--Belirli bir ürünün stok miktarını güncelleme:
UPDATE ims_product 
SET quantity = [yeni_stok_miktar] 
WHERE pid = [belirli_urun_id];
--Belirli bir siparişin toplam sevkiyatını güncelleme:

UPDATE ims_order 
SET total_shipped = [yeni_sevkiyat_miktar] 
WHERE order_id = [belirli_siparis_id];

--Toplam Sipariş Miktarını Hesaplayan Bir Fonksiyon:

DELIMITER //
CREATE FUNCTION CalculateTotalOrderQuantity(customerID INT) RETURNS INT
BEGIN
    DECLARE totalQuantity INT;
    SELECT SUM(total_shipped) INTO totalQuantity
    FROM ims_order
    WHERE customer_id = customerID;
    RETURN totalQuantity;
END //
DELIMITER ;

--Belirli Bir Kategoriye Ait Aktif Ürün Sayısını Hesaplayan Fonksiyon:

DELIMITER //
CREATE FUNCTION CountActiveProductsInCategory(categoryID INT) RETURNS INT
BEGIN
    DECLARE productCount INT;
    SELECT COUNT(*) INTO productCount
    FROM ims_product
    WHERE categoryid = categoryID AND status = 'active';
    RETURN productCount;
END //
DELIMITER ;

--Belirli Bir Kullanıcının Aktif Sipariş Sayısını Hesaplayan Fonksiyon:

DELIMITER //
CREATE FUNCTION CountActiveOrdersForUser(userID INT) RETURNS INT
BEGIN
    DECLARE orderCount INT;
    SELECT COUNT(*) INTO orderCount
    FROM ims_order
    WHERE customer_id = userID AND order_date >= CURDATE();
    RETURN orderCount;
END //
DELIMITER ;




































