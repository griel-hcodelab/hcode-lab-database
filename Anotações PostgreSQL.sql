CREATE TABLE empresas(
	id SERIAL PRIMARY KEY,
	-- SERIAL já cria o INT e o NOT NULL
	nome VARCHAR(64) NOT NULL,
	registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM empresas ORDER BY id;

INSERT INTO empresas VALUES(default, 'Hcode', default);
-- INSERT DECLARATIVO

INSERT INTO empresas (nome) VALUES('Apple'),('Microsoft');
-- INSERT POSICIONAL

-------

SELECT id, nome FROM empresas WHERE id = 2;
SELECT id, nome FROM empresas WHERE LENGTH(nome) > 5; --Somente nomes com mais de 8 caracteres

SELECT id, nome FROM empresas LIMIT 4;
SELECT COUNT(*) AS total FROM EMPRESAS;

-------

CREATE TABLE funcionarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(45) NOT NULL,
	salario DECIMAL(9,2) NOT NULL,
	empresaId INT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_funcionarios_empresas FOREIGN KEY (empresaId) REFERENCES empresas(id)
);

DROP TABLE funcionarios;

SELECT * FROM funcionarios
INNER JOIN empresas on funcionarios.empresaid = empresas.id
WHERE empresas.id = 4;

INSERT INTO funcionarios (nome, salario, empresaid) VALUES 
('Pedro', 5000.00, 5),
('Felipe', 2000,5),
('Sundar Pichai', 10000.00, 2),
('Satya Nadella', 30000.00, 4);

SELECT * FROM funcionarios;

-------

UPDATE funcionarios SET salario = 9000.00 WHERE id = 1;

UPDATE empresas SET nome = 'Hcode Treinamentos' WHERE id = 5;

UPDATE funcionarios SET salario = salario + (salario * 0.2) WHERE empresaId = 5;

-------

SELECT id FROM empresas WHERE nome LIKE '%oogle%'

DELETE FROM funcionarios WHERE empresaId IN (
	SELECT id FROM empresas WHERE nome LIKE '%oogle%'
);

CALL atualizarSalario(4, 8500);

l
