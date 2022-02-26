CREATE DATABASE IF NOT EXISTS hcodeecommerce;

USE hcodeecommerce;

CREATE TABLE IF NOT EXISTS product_category (
  id				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name 				VARCHAR(255) NOT NULL,
  description 		TEXT NOT NULL,
  created_at 		TIMESTAMP NOT NULL,
  modified_at		TIMESTAMP
);

INSERT INTO product_category (name, description, created_at) VALUES 
('Tênis', 'Os melhores tênis do Brasil com o menor preço e qualidade.', '2021-08-11 20:47:00'),
('Sandálias', 'Sandálias Feminina com a melhor qualidade e aquele precinho incrível', '2021-08-11 20:48:00');

SELECT * FROM product_category;



CREATE TABLE IF NOT EXISTS discount (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name 				VARCHAR(255) NOT NULL,
  description 		VARCHAR(255) NOT NULL,
  discount_percent 	DECIMAL(10,2) NOT NULL,
  active 			TINYINT NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP
);

INSERT INTO discount (name, description, discount_percent, active, created_at, modified_at) 
VALUES 	('Primeira Compra', 'Ganhe um super cupom para usar em sua primeira compra!', 10, 1, '2021-08-11 20:42', '2021-08-11 20:42'),
		('10% de Desconto', 'Vale 10% de desconto para produtos selecionados!', 10, 1, '2021-08-11 20:42', '2021-08-11 20:42');

SELECT * FROM discount;


CREATE TABLE IF NOT EXISTS product_inventory (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quantity 			INT NOT NULL DEFAULT 0,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
  category_id 		INT NULL,
  inventory_id 		INT NOT NULL,
  discount_id 		INT NOT NULL
);


-- DROP TABLE IF EXISTS product_inventory;

SELECT * FROM product_inventory;

CREATE TABLE IF NOT EXISTS product (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name 				VARCHAR(255) NOT NULL,
  description 		TEXT NOT NULL,
  barcode 			VARCHAR(128) NOT NULL,
  price 			DECIMAL(10,2) NOT NULL,
  category_id 		INT NOT NULL,
  inventory_id 		INT NOT NULL,
  discount_id 		INT NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
  
	CONSTRAINT index_fk_product_category FOREIGN KEY (category_id) REFERENCES product_category(id),
    CONSTRAINT index_fk_product_inventory FOREIGN KEY (invetory_id) REFERENCES product_inventory(id),
    CONSTRAINT index_fk_product_discount FOREIGN KEY (discount_id) REFERENCES discount(id)
);

SELECT * FROM product;

-- -----------------

CREATE TABLE IF NOT EXISTS user (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username 			VARCHAR(255) NOT NULL,
  password 			VARCHAR(255) NOT NULL,
  first_name 		VARCHAR(255) NOT NULL,
  last_name 		VARCHAR(255) NOT NULL,
  phone 			CHAR(16),
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
  
	CONSTRAINT index_uq_username UNIQUE(username)
);

INSERT INTO user 
	(username, password, first_name, last_name, phone) 
	VALUES ('rgrielfilho', sha2('senha_segura', 256), 'Roberto', 'Griel Filho', '3732254869');


SELECT * FROM user;

CREATE TABLE IF NOT EXISTS user_address (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id 			INT NOT NULL,
  address_line1 	VARCHAR(255),
  address_line2	 	VARCHAR(255),
  city 				VARCHAR(255) NOT NULL,
  postal_code 		CHAR(10) NOT NULL,
  country 			VARCHAR(100) NOT NULL,
  phone 			CHAR(16) NOT NULL,
  mobile 			CHAR(16),
	
    CONSTRAINT index_fk_user_address FOREIGN KEY (user_id) REFERENCES user(id)
);

INSERT INTO user_address 
(user_id, address_line1, address_line2, city, postal_code, country, phone, mobile) 
VALUES 
	('1', 'Caixa Postal', '23', 'Nova Serrana', '35524120', 'Brasil', '3732254869', '37991376936'),
    ('1', 'Rua Manoel Alves Filho', '876', 'Nova Serrana', '35524182', 'Brasil', '3732254869', '37991376936');


SELECT * FROM user_address;

CREATE TABLE IF NOT EXISTS shopping_session (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id 			INT NOT NULL,
  total 			DECIMAL(10,2) NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
	
    CONSTRAINT index_fk_shopping_session FOREIGN KEY (user_id) REFERENCES user(id)
);

SELECT * FROM shopping_session;

CREATE TABLE IF NOT EXISTS cart_item (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  session_id 		INT NOT NULL,
  product_id 		INT NOT NULL,
  quantity 			INT NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
  
	CONSTRAINT index_fk_cart_item_session FOREIGN KEY(session_id) REFERENCES shopping_session(id),
    CONSTRAINT index_fk_cart_item_product FOREIGN KEY(product_id) REFERENCES product(id)
);

SELECT * FROM cart_item;

-- -----------------

CREATE TABLE IF NOT EXISTS payment_type (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_payment 		VARCHAR(100) NOT NULL,
  installments 		TINYINT NOT NULL
);

INSERT INTO payment_type VALUES (null,'PIX', 1),(null,'Boleto Bancário', 1),(null,'Cartão de Crédito', 18),(null,'Cartão de Débito', 1),
(null,'Transferência Bancária', '1'),(null,'Pagamento na Entrega', '1');


SELECT * FROM payment_type;


CREATE TABLE IF NOT EXISTS user_payment (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id			INT NOT NULL,
  payment_type_id 	INT NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
	
    CONSTRAINT index_fk_user_payment FOREIGN KEY (user_id) REFERENCES user(id),
    CONSTRAINT index_fk_user_payment_type FOREIGN KEY (payment_type_id) REFERENCES payment_type(id)
);

SELECT * FROM user_payment;


CREATE TABLE IF NOT EXISTS order_details (
 id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id 			INT NOT NULL,
  total 			DECIMAL(10,2),
  payment_id 		INT,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
  
	CONSTRAINT index_fk_order_details FOREIGN KEY(user_id) REFERENCES user(id)
);

SELECT * FROM order_details;


CREATE TABLE IF NOT EXISTS order_items (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id 			INT NOT NULL,
  product_id 		INT NOT NULL,
  quantity 			INT NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
  
	CONSTRAINT index_fk_order_items_detail FOREIGN KEY (order_id) REFERENCES order_details(id),
    CONSTRAINT index_fk_order_items_product FOREIGN KEY (product_id) REFERENCES product(id)
);

SELECT * FROM order_items;


CREATE TABLE IF NOT EXISTS payment_details (
  id 				INT NOT NULL PRIMARY KEY,
  order_id 			INT NOT NULL,
  payment_type_id 	INT NOT NULL,
  created_at 		TIMESTAMP,
  modified_at 		TIMESTAMP,
	
    CONSTRAINT index_fk_payment_details FOREIGN KEY (order_id) REFERENCES order_details(id),
    CONSTRAINT index_fk_payment_type FOREIGN KEY (payment_type_id) REFERENCES payment_type(id)
);

SELECT * FROM payment_details;

