CREATE TABLE paises(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	-- Criando uma tabela tipo número, não pode ser nulo, que será chave primaria, IDENTITY = AUTO_INCREMENT
	nome VARCHAR(64) NOT NULL,
	-- VARCHAR é o mesmo do MySQL, com as mesmas regras
	continente VARCHAR(64) NOT NULL,
	registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- CONSTRAINTS: São regras, como primary key, not null, int, etc...

SELECT * FROM paises;

INSERT INTO paises VALUES ('Alemanha', 'Europa', DEFAULT);
-- Insert posicional

INSERT INTO paises (nome, continente) VALUES ('Alemanha', 'Europa');
-- Insert Declarativo

INSERT INTO paises (nome, continente) VALUES 
('Estados Unidos','América do Norte'),
('Brasil','América do Sul');
-- Insert declarativo em várias linhas

--------
-- COMANDO SELECT

SELECT nome AS pais, continente FROM paises WHERE nome LIKE '%bra%';
-- Selecionando os paises onde o nome tenha bra

SELECT id, nome FROM paises ORDER BY nome DESC;
-- Selecionando os paises de ordem descendente

SELECT TOP(3) * FROM paises;
-- Selecionando somente os três primeiros registros, igual o ORDER BY do MySQL

SELECT COUNT(nome) AS total FROM paises;
-- Contando a quantidade de registros da tabela

--------
-- COMANDO UPDATE

SELECT id, nome, continente FROM paises;

--Mal Exemplo:
UPDATE paises SET nome = 'Espanha';

-- Maneira correta
UPDATE paises SET nome = 'Brasil' WHERE id = 1;
UPDATE paises SET nome = 'Argentina' WHERE id = 2;
UPDATE paises SET nome = 'Alemanha' WHERE id = 4;
UPDATE paises SET nome = 'Angola' WHERE id = 5;

UPDATE paises SET continente = UPPER(continente) WHERE id BETWEEN 1 AND 5;
-- Atualizando os registros de continentes para letras maiusculas onde o id for entre 1 e 5

--------
-- COMANDO DELETE

SELECT id, nome, continente FROM paises;

DELETE FROM paises WHERE id = 4;

DELETE FROM cidades WHERE id = 2;

DELETE FROM paises WHERE len(continente) > 10;

--------
-- CHAVE ESTRANGEIRA


CREATE TABLE continentes (
	id INT NOT NULL PRIMARY KEY IDENTITY,
	nome VARCHAR(64),
	registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE paises (
	id INT NOT NULL PRIMARY KEY IDENTITY,
	continenteId INT NOT NULL,
	nome VARCHAR(64) NOT NULL,
	registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_pais_continente FOREIGN KEY (continenteId) REFERENCES continentes(id)
);

CREATE TABLE cidades (
	id INT NOT NULL PRIMARY KEY IDENTITY,
	paisId INT NOT NULL,
	nome VARCHAR(64) NOT NULL,
	registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_cidades_paises FOREIGN KEY (paisId) REFERENCES paises(id)
);

SELECT * FROM continentes;

INSERT INTO continentes (nome) VALUES 
	('América do Sul'),
	('América do Norte'),
	('Europa'),
	('África'),
	('Ásia'),
	('Oceania'),
	('Antártida');

SELECT * FROM paises;

INSERT INTO paises (continenteId, nome) VALUES
	(1, 'Brasil'),(1, 'Argentina'),(1, 'Chile'),(1, 'Uruguai'),
	(2, 'Estados Unidos'), (2, 'Canadá'),
	(3, 'Espanha'),(3, 'Alemanha'), (3, 'Portugal');

SELECT * FROM cidades;

INSERT INTO cidades (paisId, nome) VALUES
	(1, 'São Paulo'),(1, 'Rio de Janeiro'),(1, 'Belo Horizonte'),
	(2, 'Buenos Aires'), (3, 'Santiago'), (4, 'Montevidéu'),
	(5, 'Nova Iorque'), (5, 'Brooklin'), (6, 'Ottawa'),
	(7, 'Madrid'), (8, 'Frankfurt am Main'), (9, 'Lisboa');

INSERT INTO cidades (paisId, nome) VALUES (6, 'Ottawa');



