CREATE DATABASE IF NOT EXISTS ferrariServices;

USE ferrariServices;

CREATE TABLE IF NOT EXISTS people (
	id			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name		VARCHAR(255) NOT NULL,
    birth_date	date,
    phone		CHAR(16) NOT NULL,
    document	CHAR(13) NOT NULL,
    created_at	DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at	TIMESTAMP,
    
		CONSTRAINT index_uq_people UNIQUE(document)
);

INSERT INTO people (name, birth_date, phone, document) VALUES ('Glaucio Daniel', '1990-05-10', '11 32252222', '14515625800');
INSERT INTO people (name, birth_date, phone, document) VALUES ('Djalma Sindeaux', '1981-01-30', replace('11 32252222', ' ', ''), replace('561.515.153','.',''));

INSERT INTO people VALUES (null, 'João Rangel', '1989-05-20', replace('11 40045566', ' ', ''), replace('561.543.153','.',''), DEFAULT, DEFAULT);

INSERT INTO people (name, birth_date, phone, document) VALUES 
	('Ronaldo Braz', '1990-05-01', replace('11 32252222', ' ', ''), replace('561.999.153','.','')),
    ('Geisa Alguma-Coisa', '1991-03-28', replace('11 97852222', ' ', ''), replace('365.999.153','.','')),
    ('Roberto Griel Filho', '1989-08-28', replace('37 991372222', ' ', ''), replace('398.999.153','.',''));
    
SELECT * FROM people;

-- SELECT REPLACE(REPLACE('369.555.555-05', '.',''),'-','') as DOCUMENTO;

-- -------------------

CREATE TABLE IF NOT EXISTS users (
	id			INT NOT NULL PRIMARY KEY,
    email		VARCHAR(255) NOT NULL,
    password	VARCHAR(255) NOT NULL,
    
		CONSTRAINT index_fk_user FOREIGN KEY(id) REFERENCES people(id),
        CONSTRAINT index_uq_user UNIQUE(email)
);

INSERT INTO users VALUES 
	(1, 'glaucio@hcode.com', sha2('teste123', 256)),
    (2, 'djalma@hcode.com', sha2('FGDSgsd', 256)),
    (4, 'joao@hcode.com', sha2('gerbverFG$R', 256)),
    (5, 'ronaldo@hcode.com', sha2('tefdf$F34FG#$G43g3', 256)),
    (6, 'geisa@hcode.com', sha2('VDFvGRE4reV$', 256)),
    (7, 'roberto@griel.com.br', sha2('28156231', 256));
    
SELECT * FROM users;

SELECT sha2('senha', 256) AS 'HASH DA SENHA';

-- -------------------

CREATE TABLE IF NOT EXISTS passwordRecoveries (
	id			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    token		VARCHAR(255) NOT NULL,
    userId		INT NOT NULL,
    
		CONSTRAINT index_uq_token UNIQUE(token),
        CONSTRAINT index_fk_passwordRecoveries FOREIGN KEY(userId) REFERENCES users(id)
);

-- -------------------

CREATE TABLE IF NOT EXISTS addresses(
	id			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    address		VARCHAR(255) NOT NULL,
    number		VARCHAR(20) NOT NULL,
    complement	VARCHAR(255) NULL,
    district	VARCHAR(255) NOT NULL,
    city		VARCHAR(255) NOT NULL,
    state		VARCHAR(128) NOT NULL,
    country		VARCHAR(100) NOT NULL,
    zipcode		CHAR(8) NOT NULL,
    peopleId	INT NOT NULL,
    
		CONSTRAINT index_fk_addresses FOREIGN KEY(peopleId) REFERENCES people(id)
);

INSERT INTO addresses (address, number, complement, district, city, state, country, zipcode, peopleId) VALUES 
	('Avenida José Versolato', '175', 'Andar 7', 'Centro', 'São Bernardo do Campo', 'São Paulo', 'Brasil', '05214556', 1),
    ('Avenida Paulista', '1000', 'Andar 7, Apt 15', 'Bela Vista', 'São Paulo', 'São Paulo', 'Brasil', '05214556', 2),
    ('Rua São Carlos do Pinhal', '525', 'Casa C', 'Bela Vista', 'São Paulo', 'São Paulo', 'Brasil', '05214556', 4),
    ('Rua das Laranjeiras', '490', '', 'Santa Luzia', 'São Bernardo do Campo', 'São Paulo', 'Brasil', '05214556', 5),
    ('Travessa Primeiro de Maio', '430', '', 'Jardim Europa', 'São José dos Pinhais', 'São Paulo', 'Brasil', '05214556', 6),
    ('Caixa Postal', '23', 'Agência dos Correios', 'Parque Dona Gumercinda', 'Nova Serrana', 'Minas Gerais', 'Brasil', '35524120', 7)
    ;

SELECT * FROM addresses;

-- -------------------

CREATE TABLE IF NOT EXISTS time_options (
  id		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  day		TINYINT NULL,
  time		TIME NULL
);

SELECT * FROM time_options;

INSERT INTO time_options (day, time) VALUES 
	(1, '08:00'),(1, '09:00'),(1, '10:00'),(1, '11:00'),(1, '12:00'),
    (2, '08:00'),(2, '11:00'),(2, '13:00'),(2, '14:00'),
    (3, '13:00'),(3, '14:00'),(3, '15:00'),(3, '16:00'),
    (4, '13:00'),(4, '14:00'),(4, '15:00'),(4, '16:00'),
	(5, '08:00'),(5, '11:00'),(5, '13:00'),(5, '14:00'),(5, '17:00');
    
    
-- -------------------    
    
    
CREATE TABLE IF NOT EXISTS payments (
  id 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name 		VARCHAR(45) NOT NULL,
  
		CONSTRAINT index_uq_payments UNIQUE(name)
);

INSERT INTO payments (name) VALUES ('Boleto Bancário'),('PIX'),('Cartão de Débito'),('Dinheiro a Vista');
INSERT INTO payments (name) VALUES ('Cartão de Crédito');

SELECT * FROM payments ORDER BY id;

-- -------------------

CREATE TABLE IF NOT EXISTS services (
  id			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name			VARCHAR(45) NOT NULL,
  description 	TEXT NOT NULL,
  price			DECIMAL(10,2) NOT NULL,
  
		CONSTRAINT index_uq_name UNIQUE(name)
);

INSERT INTO services (name, description, price) VALUES 
('Revisão','Verificação mínima necessária', 500),
('Alinhamento','Alinhamento e balanceamento dos pneus', 1200),
('Filtros','Troca de filtros de ar e de combustível', 989.99);

INSERT INTO services (name, description, price) VALUES 
('Embreagem','Troca de discos de embreagem e cabos de apoio', 2980),
('Freios','Troca de discos e fluidos de freio', 780);

INSERT INTO services (name, description, price) VALUES 
('Óleo de Câmbio','Troca de óleo do câmbio', 450.10);

SELECT * FROM services;
TABLE services;

-- -------------------

CREATE TABLE IF NOT EXISTS schedules (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  peopleId 			INT NOT NULL,
  timeOptionId 		INT NOT NULL,
  paymentId 		INT NOT NULL,
  billingAddressId 	INT NOT NULL,
  schedule_at 		DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  total 			DECIMAL(10,2) NOT NULL,
  installments 		TINYINT NOT NULL,
	  CONSTRAINT index_fk_schedules_peopleId 		FOREIGN KEY (peopleId) 			REFERENCES people(id),
	  CONSTRAINT index_fk_schedules_timeOption 		FOREIGN KEY (timeOptionId) 		REFERENCES time_options(id),
	  CONSTRAINT index_fk_schedules_payment 		FOREIGN KEY (paymentId) 		REFERENCES payments(id),
	  CONSTRAINT index_fk_schedules_billingAddress 	FOREIGN KEY (billingAddressId) 	REFERENCES addresses(id)
);

SELECT * FROM schedules;

INSERT INTO schedules (peopleId, timeOptionId, paymentId, billingAddressId, schedule_at, total, installments) 
VALUES (4, 2, 5, 4, '2021-08-11 09:00', 1500, 5);

INSERT INTO schedules (peopleId, timeOptionId, paymentId, billingAddressId, schedule_at, total, installments) 
VALUES (1, 19, 4, 1, '2021-08-13 11:00', 5500, 2);

INSERT INTO schedules (peopleId, timeOptionId, paymentId, billingAddressId, schedule_at, total, installments)
VALUES (5, 13, 2, 4, '2021-08-11 16:00', 1500, 1);

SELECT * FROM people;
SELECT * FROM time_options;
SELECT * FROM payments;
SELECT * FROM addresses;

-- -------------------

CREATE TABLE IF NOT EXISTS schedules_services (
  schedulesId 		INT NOT NULL,
  servicesId 		INT NOT NULL,
  
		PRIMARY KEY (schedulesId, servicesId),
        CONSTRAINT index_fk_schedules_schedulesId FOREIGN KEY (schedulesId) REFERENCES schedules(id),
        CONSTRAINT index_fk_schedules_schedulesServicesId FOREIGN KEY (servicesId) REFERENCES services(id)
);

SELECT * FROM schedules_services ORDER BY schedulesId;

INSERT INTO schedules_services VALUES (1, 2),(1,3);
INSERT INTO schedules_services VALUES (2, 1),(2,4);
INSERT INTO schedules_services VALUES (3,1),(3,3);

-- -------------------

-- CONSULTAS COM JOIN

SELECT a.name, b.email FROM people a
INNER JOIN users b 
ON a.id = b.id;

SELECT a.name, b.address, b.number, b.complement, c.email
FROM people a
INNER JOIN addresses b
INNER JOIN users c
ON a.id = b.peopleId;

select
	a.name AS 'Cliente', b.email,
    c.address, c.number, c.complement
FROM people a INNER JOIN users b
ON a.id = b.id 
INNER JOIN addresses c
ON a.id = c.peopleId;

select people.name as cliente,
services.name as servico
from people inner join schedules 
on people.id = schedules.peopleId
    inner join schedules_services
        on schedules.id = schedules_services.schedulesId
            inner join services
                on services.id = schedules_services.servicesId;

-- A TABELA MAIOR SEMPRE FICA POR ÚLTIMO. DOS QUE SOBRAREM DO JOIN, FAÇA UM INNER JOIN COM A ÚLTIMA TABELA.

-- padrão MySQL: using(id)


-- -------------------

-- PROCEDURES

-- A partir deste momento, o que vier após o delimiter irá interromper o código. É sempre bom usar pares de caracteres.
-- Não por comentários nem nada na frente do delimiter.

-- SUB ROTINA: ELA SÓ EXECUTA; FUNCTION: EXECUTA E RETORNA UM VALOR.
-- i(Informação, ex. isnumeric); c(Conversão, ex. cInt); u(User Functions, funções criadas pelo usuários), cl(Calculos)
-- PROCEDURE É SUB ROTINA. SÓ IRÁ EXECUTAR.

DELIMITER $$ 

DROP PROCEDURE IF EXISTS sp_add_services$$

CREATE PROCEDURE sp_add_services(
	IN pName VARCHAR(45),
	IN pDesc TEXT,
	IN pPrice dec(10,2))
BEGIN
	
    declare vId INT;
    SELECT id INTO vId FROM services WHERE name = pName;

	IF NOT EXISTS(SELECT name FROM services WHERE name = pName) THEN
		INSERT INTO services VALUES(NULL, pName, pDesc, pPrice);
		SELECT concat('Serviço ', pName, ' cadastrado com sucesso.') AS result;
	ELSE
		if (vId > 0) THEN
			UPDATE services SET name = pName, description = pDesc, price = pPrice WHERE id = vId;
			SELECT concat('Serviço ', pName, ' atualizado com sucesso.') AS result;
		END IF;
    END IF;

END
$$

call sp_add_services('Revisão', 'Verificação mínima necessária', 900)$$
TABLE SERVICES$$


-- FAZER: call sp_del_services('Nome do serviço ao apagar mas buscar pelo id');

DROP PROCEDURE IF EXISTS sp_del_services;

CREATE PROCEDURE sp_del_services(
	IN pName VARCHAR(45))
BEGIN
	
    declare vId INT;
    SELECT id INTO vId FROM services WHERE name = pName;
    
	DELETE FROM schedules_services where servicesId = vId;
	DELETE FROM services WHERE id = vId;
    
	SELECT concat('Serviço ', pName, ' apagado com sucesso.') AS result;

END
$$

call sp_del_services('Revisão')$$
TABLE SERVICES$$
TABLE schedules_services$$