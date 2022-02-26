-- PROCEDURES
-- PARÂMETROS DE SAIDA:
----IN > ENTRADA
----OUT > SAÍDA
---- INOUT -> ENTRADA E SAÍDA. ÚNICA ACEITA NA PROCEDURE



CREATE PROCEDURE atualizarSalario(
	pid INOUT INT,
	psalario INOUT DECIMAL(9,2)
)
LANGUAGE 'sql'
AS
	$$
		UPDATE funcionarios SET salario = psalario WHERE id = pid;
		
		SELECT id, salario FROM funcionarios WHERE id = pid;
	$$
	
DROP PROCEDURE atualizarSalario;