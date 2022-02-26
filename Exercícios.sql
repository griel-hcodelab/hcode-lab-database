/*
Exemplo de comentário
*/

SHOW DATABASES; -- Mostra todos os bancos de dados

USE SAKILA; -- Usa o banco de dados. Precisa usar um DB antes de trabalhar nele

SELECT 
    *
FROM
    city; -- SELECIONO TUDO DA TABELA cidade

CREATE DATABASE hcodelab;

USE hcodelab;

-- ----------------------

-- Há duas formas de criar um usuário: Pode ser criado um usuário com a senha e depois definindo as permissões, ou criar um usuário com as permissões e então garantindo as permissões

-- Criando uma regra
CREATE ROLE 'administrator';
GRANT ALL PRIVILEGES ON hcodelab2.* TO 'administrator';

DROP ROLE 'administrator';
DROP USER 'hcodelab'@'localhost';

-- Criando usuário com uma regra
CREATE USER 'hcodelab'@'localhost' 
	DEFAULT ROLE 'administrator';
    
-- Criando um usuário que pode acessar de determinado IP
CREATE USER 'hcodelab'@'%.%.%.%' IDENTIFIED BY 'T$#Tg43Gg34GF34';
GRANT 'administrator' TO 'hcodelab'@'%.%.%.%';
    
-- Alterando um usuário
ALTER USER 'hcodelab'@'localhost'
	IDENTIFIED BY 'T$#Tg43Gg34GF34';
-- Primeiro é o nome do usuário, após o @ é de onde ele pode acessar

-- ----------------------

-- Criando uma tabela
USE hcodelab;
-- Sempre certifique que você está usando o banco de dados correto

DROP TABLE IF EXISTS cliente;

CREATE TABLE IF NOT EXISTS cliente 
-- Criando uma tabela somente se ela não existir
(
	id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomeCliente		VARCHAR(255) NOT NULL,
    emailcliente	VARCHAR(255) NOT NULL,
    rendaCliente	DECIMAL(10,2) NOT NULL DEFAULT 1000.00,
    
    CONSTRAINT index_uq_cliente UNIQUE(emailCliente)
)
ENGINE = InnoDB -- Mecanismo de armazenamento desta tabela, de forma que ele será guardado no disco
CHARSET = utf8 -- Codificação padrão que a tabela irá aceitar, para caracteres difeentes
COLLATE = utf8_general_ci; -- AI - ACENT INSENTIVE, ou seja, não faz distinção entre acentos | CI - CASE INSENTIVE, ou seja, não faz diferença entre maiusculo ou minusculo

INSERT INTO cliente VALUES(NULL, 'Roberto', 'roberto@griel.com.br', 5000.00);
INSERT INTO cliente VALUES(NULL, 'Roberto', 'roberto@griel.com.br', 5000.00, 4); -- Não deixou adicionar porque mais em baixo alterei a tabela apenas para status 1 a 3

SELECT * FROM cliente;

-- ----------------------

-- Criando uma View

CREATE VIEW view_Cliente AS
SELECT id, nomeCliente as cliente, emailCliente AS email from CLIENTE;

CREATE OR REPLACE -- Esse comando irá criar, ou substituir se já existir
DEFINER = 'cnxuser'@'localhost'
SQL SECURITY INVOKER -- Invoker: Antes de chamar a view, veja os privilégios de quem está chamando a view | Definer: Não importa quem chamar a view, irá usar os privilégios definidos
VIEW view_Cliente AS
SELECT id, nomeCliente as cliente, emailCliente AS email from CLIENTE;

DROP VIEW view_Cliente;

SELECT * FROM view_Cliente;


-- ----------------------

-- Criando uma Stored Procedure
-- O que é? Um ou mais comandos que eu posso agrupar, e chamar de forma externa passando parâmetros.

SELECT COUNT(*) AS total FROM world.city;

-- A partir desta linha, o fim da instrução não é mais o ; e sim a //
DELIMITER $$ 

CREATE PROCEDURE sp_contaCidade (IN pais CHAR(3), OUT cidades INT)
BEGIN

	SELECT COUNT(*) INTO cidades FROM world.city WHERE CountryCode = pais;

END
$$
-- Parâmetros: IN para entradas, OUT para saidas ou INOUT para entradas ou saidas
DELIMITER ;

CALL sp_contaCidade('BRA', @cities);

select @cities as total;


-- ----------------------

-- Comando ALTER

DESCRIBE cliente;
SELECT * FROM cliente;

ALTER TABLE cliente
	RENAME COLUMN rendaCliente TO renda;
    
ALTER TABLE cliente
	ADD COLUMN statusCliente TINYINT SIGNED NOT NULL DEFAULT 1;
    
ALTER TABLE cliente
	DROP COLUMN statusCliente;
    
ALTER TABLE cliente
	ADD CONSTRAINT ch_cliente CHECK(statusCliente BETWEEN 1 AND 3);
    
ALTER TABLE cliente
	DROP CONSTRAINT ch_cliente;
    
-- ----------------------

-- Comando DROP

DROP TABLE IF EXISTS cliente;

DROP DATABASE IF EXISTS hcodelab2;

-- ----------------------

-- Comando Insert

-- Insert Posicional vou inserir em todos  os campos e na ordem que foram criados
-- Sou obrigado a inserir um campo quando ele for NOT NULL e não tiver DEFAULT
INSERT INTO cliente VALUES(NULL, 'Roberto', 'roberto@griel.com.br', 5000.00);

-- Insert Declarativo eu vou informar os campos que eu quero inserir
INSERT INTO cliente (nomeCliente, emailCliente) VALUES
	('Claudi', 'claudio@griel.com'),
	('Anderson', 'andy@gmail.com'),
    ('Joana','joana@gmail.com');

SELECT * FROM cliente;


-- ----------------------

-- Comando Update
UPDATE cliente 
SET 
    rendaCliente = rendaCliente * (1 + (10 / 100)),
    emailCliente = lower(emailCliente);
    
-- ----------------------

-- Comando Delete
-- DELETE SEM WHERE ESTÁ ERRADO!
DELETE FROM cliente;

-- ----------------------

-- Comando Truncate
-- Ele irá apagar a tabela e recriá-la. Se for uma tabela com chave estrangeira, precisa apagar os valores incluidos primeiro

TRUNCATE TABLE cliente;


-- ----------------------

-- Clausula WHERE
DELETE FROM cliente WHERE id = 1;

SELECT * FROM cliente WHERE rendaCliente > 1000 OR rendaCliente < 10;

UPDATE cliente 
SET 
    rendaCliente = rendaCliente * (1 + (10 / 100)),
    emailCliente = lower(emailCliente)
    WHERE id = 2;


-- ----------------------

-- Exercícios de Cláusulas e Operadores

USE sakila;

SHOW TABLES;

SELECT * FROM address WHERE address_id IN(11, 12, 13);

SELECT * FROM address WHERE address_id NOT IN (1,2,3,4,5,6,7);

SELECT * FROM city WHERE city = 'Angra dos Reis';

SELECT * FROM address WHERE city_id IN(
SELECT city_id FROM city WHERE city = 'Belo Horizonte'
);

SELECT * FROM address WHERE city_id NOT IN(
SELECT city_id FROM city WHERE city = 'Angra dos Reis'
);

SELECT * FROM payment WHERE amount BETWEEN 3 AND 7;

SELECT * FROM payment WHERE rental_id BETWEEN '0' AND '500';

SELECT * FROM film WHERE length NOT BETWEEN 30 AND 150;

SELECT * FROM film WHERE rental_rate NOT BETWEEN 1 AND 5;

SELECT * FROM actor WHERE first_name LIKE 'ad%';

SELECT * FROM actor WHERE first_name LIKE '__n';

SELECT 
    first_name AS nome, last_name AS sobrenome
FROM
    actor
WHERE
    first_name LIKE 'e%'
        AND last_name LIKE '__a%';
        
SELECT * FROM country WHERE country NOT LIKE 'a%';
