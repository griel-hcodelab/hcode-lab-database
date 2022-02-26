CREATE TABLE bancos_de_dados (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(64) NOT NULL,
    ano_criacao DATE NOT NULL,
    cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM bancos_de_dados;

DROP TABLE bancos_de_dados;

---------------------

-- INSERT POSICIONAL

INSERT INTO bancos_de_dados VALUES (DEFAULT, 'MySQL', '24-ABR-1989', DEFAULT);

-- INSERT DECLARATIVO

INSERT INTO bancos_de_dados (nome, ano_criacao) VALUES ('SQL Server', '24-ABR-1989');

-- INSERT DE V�RIAS LINHAS

INSERT INTO bancos_de_dados (nome, ano_criacao) WITH bancos AS (
    SELECT 'Oracle', '01-JAN-1989' FROM dual  UNION ALL
    SELECT 'PostgreSQL', '08-JUL-1996' FROM dual
)
SELECT * FROM bancos;

---------------------

-- CL�USULA WHERE

SELECT nome FROM bancos_de_dados WHERE id = 2;

SELECT nome, ano_criacao FROM bancos_de_dados WHERE ano_criacao < '01-JAN-1990';

SELECT id, nome, ano_criacao FROM bancos_de_dados ORDER BY nome DESC;

SELECT count(id) AS total FROM bancos_de_dados;

SELECT * FROM bancos_de_dados FETCH FIRST 2 ROWS ONLY;
SELECT * FROM bancos_de_dados FETCH NEXT 3 ROWS ONLY;
--Select com LIMIT


---------------------

CREATE TABLE criadores (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(64) NOT NULL,
    cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO criadores (nome) WITH nome AS (
    SELECT ('Rasmus Lerdorf') FROM DUAL UNION ALL
    SELECT ('Dennis Ritchie') FROM DUAL UNION ALL
    SELECT ('Guido van Rossum') FROM DUAL UNION ALL
    SELECT ('James Gosling') FROM DUAL
) 
SELECT * FROM nome;

INSERT INTO criadores (nome) WITH nome AS (
    SELECT ('Michael Widenius') FROM DUAL UNION ALL
    SELECT ('Microsoft') FROM DUAL UNION ALL
    SELECT ('Larry Ellison') FROM DUAL UNION ALL
    SELECT ('Michael Stonebraker') FROM DUAL
) 
SELECT * FROM nome;

SELECT * FROM bancos_de_dados;
SELECT * FROM criadores;

ALTER TABLE bancos_de_dados ADD criador_id INT;
-- Criando uma coluna na tabela 

ALTER TABLE bancos_de_dados 
    ADD CONSTRAINT FK_bancos_de_dados_criadores 
    FOREIGN KEY (criador_id) 
    REFERENCES criadores(id)
    ON DELETE CASCADE;
    
---------------------

UPDATE bancos_de_dados SET ano_criacao = '01-JAN-1979' WHERE id = 3;

UPDATE bancos_de_Dados SET criador_id = 5 WHERE ID = 1;
UPDATE bancos_de_Dados SET criador_id = 6 WHERE ID = 2;
UPDATE bancos_de_Dados SET criador_id = 7 WHERE ID = 3;
UPDATE bancos_de_Dados SET criador_id = 8 WHERE ID = 4;

---------------------

DELETE FROM bancos_de_dados WHERE id = 1;

DELETE FROM bancos_de_dados WHERE ano_criacao < '01-JAN-1980';

---------------------

CREATE OR REPLACE PROCEDURE remover_criadores (
    pid INT
)
IS pidessoa INT;
BEGIN

    DELETE FROM bancos_de_dados WHERE criador_id = pid;
    
    DELETE FROM criadores WHERE id = pid;

END;
-- O 7 � o par�metro da fun��o
EXECUTE remover_criadores(7);