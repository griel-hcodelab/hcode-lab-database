	--------
-- STORED PROCEDURES

CREATE PROCEDURE inserirCidades
	(
		@paisId INT,
		@nome VARCHAR(64)
	)
AS
BEGIN
	INSERT INTO cidades(paisId, nome)
		OUTPUT Inserted.*
	VALUES(@paisId, @nome);
	
END;

CREATE PROCEDURE apagarCidade
	(
		@paisId INT
	)
AS
BEGIN

	DELETE FROM cidades WHERE paisId = @paisId;
	DELETE FROM paises WHERE id = @paisId;

END;

SELECT * FROM cidades;

EXECUTE inserirCidades 1, 'Fortaleza';

EXECUTE apagarCidade 6;