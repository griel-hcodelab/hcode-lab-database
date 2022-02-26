use ferrariservices;


desc people;
desc users;

delimiter $$
-- desafio, implementar, pname vazio (is null or = '')
-- quantidade de caracteres da senha informada, menor que 6 rejeita.
drop procedure if exists sp_add_people;
create procedure sp_add_people(
	in pname 	varchar(255),    in pemail 		varchar(255),  in ppassword	varchar(255)
)
begin
declare vid int;
	if not exists(select email from users where email = pemail) then
		-- insert -- begin transaction
         start transaction;
        insert into people(name) values (pname);
        select last_insert_id() into vid;
			if(vid > 0) then
				insert into users values (vid, pemail, sha2(ppassword, 256));
                -- confirma
				 commit;
				select concat('Usuário ', pname, ' cadastrado com sucesso!') as result;
			else
            -- cancela a transação
				rollback;
			end if;
		else
			-- temos um problema.
			select 'Usuário já cadastrado!' as result;
    end if;
end$$
call sp_add_people('Thais Placido', 'thais@hcode.com.br','123456')$$

start transaction $$
	delete from services where id = 10;$$
rollback;$$

show engine innodb status;$$
show full processlist;$$
table people;$$

-- views --  

alter view v_user_total
as
select a.name as usuario,a.phone as telefone, b.email, count(c.peopleId) as quantidade, 
sum(c.total) as total from
people a inner join users b
	on a.id = b.id
		inner join schedules c
			on a.id = c.peopleId
            group by c.peopleId
				having sum(c.total) > 2000
                -- having é o where do group by
                with check option
                ;$$
 -- =============================================================
 -- DCL - grant,  deny, revoke
 create view v_people_millennials
 as
  select * from people where birth_date >= '2000-01-01'
  with check option
  ;$$
 insert into v_people_millennials values
 (null, 'José', '2001-01-01', '11999990000','1234512345', current_timestamp(), null)$$
 table people;$$
  -- =============================================================
 select * from v_user_total
 where usuario like 'G%';$$
 -- ==============================================================
select peopleID, count(*) as quantidade from schedules
	group by peopleID
$$ 

create user 'prog_production'@'%.%.%.%' identified by '123456';$$
create user 'prog_production'@'localhost' identified by '123456';$$

grant select, insert on ferrariservices.* to 'prog_production'@'%.%.%.%';$$
grant all privileges on ferrariservices.* to 'prog_production'@'localhost';$$
-- =============================================================
select sum(total) from schedules$$            
table schedules$$
-- =============================================================
delimiter ;
desc passwordrecoveries;

alter table passwordrecoveries
add column active tinyint;

alter table passwordrecoveries
add column ip	char(15),
add column date_expire		datetime;
-- =======================================
desc users;
desc passwordrecoveries;
select sha2(rand() * 100000, 256) as token;
select date_add(now(), interval 7 day) as expire;

delimiter $$

create procedure sp_recovery_password(in pemail varchar(255), in pip char(15))
begin
declare vid int;
declare vtoken varchar(255);
set vtoken = sha2(rand() * 100000, 256);
	select id into vid from users where email = pemail;
    insert into passwordrecoveries values
    (null, vtoken, vid, 1, pip, 
    date_add(now(), interval 7 day));
    select vtoken as result;
end
$$
-- mysqldump -u root@localhost:3306 -p 
call sp_recovery_password('nayanefaria.ns@gmail.com','192.168.0.15')$$

table passwordrecoveries$$
delimiter ;
table services;

TABLE users;
delimiter $$

-- Criando um evento para rodar em uma data específica
CREATE EVENT atualiza_valores ON SCHEDULE AT '2021-08-16 16:57:00' 
DO BEGIN
	DELETE FROM services WHERE id = 2;
END$$

CREATE EVENT e_hourly 
ON SCHEDULE EVERY 10 SECOND
COMMENT "TESTE"
DO BEGIN

	SELECT "Testando";

END$$



 delimiter $$
 desc passwordrecoveries$$
 SELECT * FROM passwordrecoveries$$

-- Funções

DELIMITER $$
DROP FUNCTION IF EXISTS fn_get_token;$$
CREATE FUNCTION fn_get_token(pToken VARCHAR(255))
	RETURNS TINYINT READS SQL DATA -- Boolean não existe no mysql -- SQL Data: trabalha com informações do banco
    
    -- NOT DETERMINISTIC  Toda vez que ela roda, ela vai fazer uma consulta. Determinística precisa retornar o mesmo valor; Não determinística: Eu mando um dado mas pode retornar outro valor
	BEGIN
    
		DECLARE vValid TINYINT;
    
		IF EXISTS(SELECT token FROM passwordrecoveries WHERE token = pToken AND active = 1 AND date_expire >= CURRENT_TIMESTAMP()) THEN
        
			SET vValid = 1;
        
        ELSE 
        
			SET vValid = 0;
        
        END IF;
        
        RETURN vValid;
    
    END$$


SELECT fn_get_token('a3f955b8d22fb66bc1b2027f3e182f2150db36e40817b457e0fae2239b1a51aa') AS result;$$


/*
	1 - Criaremos uma proc, chamada sp_recoverypassword('email')
		- gera um token, insere na tabela com o id do usuário
        - cria a data de expiração - 7 dias depois da data atual.
        - insere o IP de quem solicitou o recovery
        - marca active como 1 ou true.
	2 - Criar uma função fn_get_token('token') - devolve true or false.
		- consultar se o token existe
        - se está dentro do prazo
        - se o token está ativo
        
	3 - Alterar senha - o token está válido, 
		- alteramos o password
        - desativa o token
*/


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_upd_recoverypassword$$
CREATE PROCEDURE sp_upd_recoverypassword(
	IN pEmail		VARCHAR(255),
    IN pToken		VARCHAR(255),
    IN pPassword 	VARCHAR(255)
)
BEGIN

	DECLARE vId INT;

	if (fn_get_token(pToken) = 1) THEN
    
		SELECT id INTO vId FROM users WHERE email = pEmail;
        
        UPDATE users SET password = pPassword WHERE id = vId;
        
        UPDATE passwordrecoveries SET active = 0 WHERE token = pToken;
        
        SELECT 'Senha alterada com sucesso!' AS result;
        
	ELSE 
    
		SELECT 'Esse link expirou!' AS result;
    
    END IF;

END$$

DELIMITER ;

call sp_upd_recoverypassword('nayanefaria.ns@gmail.com', 'a3f955b8d22fb66bc1b2027f3e182f2150db36e40817b457e0fae2239b1a51aa', 'teste_da_silva');

SELECT * FROM passwordrecoveries;
SELECT * FROM users;
