-- Função que cria códigos aleatórios, onde no parâmetro é informado a quantidade de caracteres
DELIMITER $$
DROP FUNCTION fn_random;
CREATE FUNCTION fn_random(p_quantity TINYINT)
	RETURNS VARCHAR(255) READS SQL DATA
	BEGIN
		DECLARE v_code VARCHAR(255);
		select substring(MD5(RAND()),1,p_quantity) INTO v_code;
        RETURN v_code;
    END$$
DELIMITER ;

-- Função que vê se a senha está correta
DELIMITER $$
DROP FUNCTION fn_check_password;
CREATE FUNCTION fn_check_password(
	p_user_email VARCHAR(255),
    p_user_password VARCHAR(255)
)
	RETURNS VARCHAR(255) READS SQL DATA
	BEGIN
		DECLARE v_is_valid TINYINT;
        
        IF EXISTS(SELECT id FROM tb_users WHERE user_email = p_user_email AND user_password = p_user_password) THEN
			SET v_is_valid = 1;
        ELSE 
            SET v_is_valid = 0;   
		END IF;  
        RETURN v_is_valid;	
    END$$
DELIMITER ;