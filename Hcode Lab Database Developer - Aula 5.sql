use ferrariservices;

-- Stored Engines - Mecanismos de armazenamento
-- > InnoDB SEMPRE!
-- > Se precisar somente de consultas, use MyISAM
-- > Memory: Extramente rápida, porém volátil. Apenas para consultas temporárias
-- > Archive: Tabelas de logs que não permite exclusão de dados, não aceita primary ou foreign key

SELECT * FROM passwordrecoveries;
SELECT * FROM users;

SHOW ENGINES;

-- Tabela tipo Archive

CREATE TABLE passwordhistory(
    userId			INT,
    password		VARCHAR(255),
    dateModified	TIMESTAMP
) ENGINE archive;

-- TRIGGERS

table users;
TABLE passwordhistory;

DELIMITER $$
-- trigger de insert cria uma tabela virutal chamada new
-- trigger de delete cria uma tabela virutal chamada old
-- trigger de update cria uma tabela virutal chamada old e NEW
-- Definir valor: set new.COLUNA = ''
-- usado em tabelas de missão crítica
-- NÃO USAR TRIGGER EM TABELAS QUE RECEBEM VÁRIAS INFORMAÇÕES
DROP TRIGGER upd_password;
CREATE TRIGGER upd_password BEFORE UPDATE ON users
    FOR EACH ROW
		BEGIN
			INSERT INTO passwordhistory VALUES(old.id, old.password, NOW());
		END$$

DELIMITER ;

UPDATE users SET password = sha2('senha facil', 256) WHERE id = 1;

-- --------------

SELECT * FROM services;
DELIMITER $$
DROP TRIGGER tg_add_services;
CREATE TRIGGER tg_add_services BEFORE INSERT 
	ON services
    FOR EACH ROW
		BEGIN

            IF (new.price < 500) THEN
				SET new.price = 500;
			END IF;
            
		END$$
        
DELIMITER ;

INSERT INTO services VALUES (null, 'Serviço Grátis', 'De graça é mais barato', 100);

call sp_add_services('Serviço Grátis', 'De graça é mais barato', 100);


-- --------------
-- ÍNDICES
-- Toda tabela de banco de dados utiliza páginas de dados. 
-- Master Datap Page = Página principal de cada banco, que tem a informação do banco e dos objetos

SELECT * FROM information_schema.tables;
use information_schema;
show tables;

USE ferrariservices;
DESC people;

CREATE UNIQUE INDEX i_people_document ON people(document DESC); -- Índice nos documentos de forma decrescente
SELECT * FROM people;

ANALYZE TABLE people; -- Analizando dados da tabela para InnoDB
OPTIMIZE TABLE addresses; -- OTIMIZANDO UMA TABELA

-- mysqlcheck table; ... mysqlcheck --databases ferrariservices

-- Checando o status da tabela. Usado somente em casos mais sérios
CHECK TABLE people; 
REPAIR TABLE people;

CREATE TABLE articles (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title VARCHAR(255),
    body text,
    fulltext(title, body)
);

INSERT INTO articles(title, body) values 
('React', 'Criando componentes'),
('NodeJS', 'Atualizando componentes'),
('React Native', 'Ciclo de vida do componente'),
('React Router', 'Criando um Router'),
('Node', 'A API HTTP'),
('TypeScript', 'Definindo o retorno dos métodos'),
('Redux', 'Gerenciando o estado de um componente'),
('NodeJS', 'Criando um servidor HTTP'),
('JavaScript', 'Trabalhando com Arrow Functions');

SELECT * FROM articles WHERE MATCH(title, body) AGAINST ('react' in natural language mode);
-- Quando encontrar o react em uma linguagem natural. Precisa ter pelo menos 4 caracteres para fazer a busca e de forma insensitiva

SELECT * FROM articles WHERE MATCH(title, body) AGAINST ('react*' IN BOOLEAN MODE);
