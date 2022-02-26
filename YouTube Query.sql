-- ----------------------------------

-- Criar o usuário com permissão de root para localhost / xxx.xxx.xxx.xxx
-- Criar usuário com permissão apenas de leitura
-- Criar usuário com permissão apenas para inserir, atualizar e apagar

-- Definir a ordem das tabelas a serem alimentadas
# Users OK
# Person OK

# Channel ok
## Channel Banner ok
## Channel Videos ok
## Channel Playlists

# Videos ok
## Videos Thumbs ok
## Videos Descriptions ok

# User & Channel
## Playlist Video (Ligando o id do canal ao id do vídeo) ok
## Videod Comments (Comentário do vídeo ligando ao id do usuário) ok
## Videos Likes (Ligando o id do usuário ao id do vídeo) Ok
-- Verificar a ação. Se o usuário já tiver dado o like e dar like de novo, remover o like dado. O mesmo para deslike. 
-- Se trocar de like para deslike, atualizar a tabela com a ação efetuada
## Videos Quality (Qualidade dos vídeos: 144, 240, 360, 480, 720, 1080, 1440, 2160, 4320)

--

-- Consultas:

# Logar usuário verificando se o e-mail e a senha são válidos e retornando os dados da pessoa (person)

# Exibir as informações do canal, retornando o nome, url, descrição, data de criação, inscritos, localização e o banner

# Exibir todos os vídeos do canal, retornando o nome, código, data de upload, duração do vídeo e as qualidades

# Exibir todas as playlists do canal com seus respectivos vídeos, retornando nome do canal, nome da playlist, criação da playlist, atualização da playlist, nome do vídeo e thumb do vídeo

-- ----------------------------------

CREATE DATABASE IF NOT EXISTS youtube;

-- Criando usuários:

-- DBA
CREATE USER 'root'@'localhost' IDENTIFIED BY 'E5qS4SOfO0cjpd3Jl3wb';
GRANT ALL PRIVILEGES ON youtube.* TO 'root'@'localhost';

-- DBD
CREATE USER 'devadmin'@'localhost' IDENTIFIED BY 'senha123';
GRANT INSERT, DELETE, UPDATE, SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'devadmin'@'localhost';

-- Final Developer
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'developer'@'localhost';

USE youtube;

CREATE TABLE IF NOT EXISTS tb_users (
  id 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_email 		VARCHAR(255) NOT NULL,
  user_password 	VARCHAR(255) NOT NULL,
  created_at 		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
    CONSTRAINT index_uq_user UNIQUE(user_email)
);

CREATE TABLE IF NOT EXISTS tb_person (
  id_user 			INT NOT NULL PRIMARY KEY,
  name 				VARCHAR(60) NOT NULL,
  birth_date 		DATE NOT NULL,

	CONSTRAINT fk_tb_person_tb_users FOREIGN KEY (id_user) REFERENCES tb_users (id)
);

CREATE TABLE IF NOT EXISTS tb_channel (
  id_channel 			INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  channel_name 			VARCHAR(140) NOT NULL,
  channel_url 			VARCHAR(45) NULL,
  subscription 			BIGINT NOT NULL DEFAULT 0,
  creted_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  description 			VARCHAR(255) NULL,
  location 				VARCHAR(140) NOT NULL,
  
	CONSTRAINT index_uq_channel_url UNIQUE(channel_url),
    CONSTRAINT fk_tb_channel_tb_users FOREIGN KEY (id_user) REFERENCES tb_users (id)
);

CREATE TABLE IF NOT EXISTS tb_channel_banner (
  id_channel 			INT NOT NULL PRIMARY KEY,
  banner_image 			VARCHAR(255) NOT NULL,
	
    CONSTRAINT fk_tb_channel_banner_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel(id_channel)
);

CREATE TABLE IF NOT EXISTS tb_videos (
  id_video 				INT NOT NULL AUTO_INCREMENT,
  id_channel 			INT NOT NULL,
  video_code 			VARCHAR(255) NOT NULL,
  video_name 			VARCHAR(140) NOT NULL,
  uploaded_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  video_length 			TIME NOT NULL,
  
	PRIMARY KEY (id_video, id_channel),
	CONSTRAINT fk_tb_videos_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel (id_channel)
);

CREATE TABLE IF NOT EXISTS tb_playlists (
  id 					INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_channel 			INT NOT NULL,
  name					VARCHAR(140) NULL,
  created_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_tb_playlists_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel (id_channel)
);

CREATE TABLE IF NOT EXISTS tb_playlist_video (
  id_playlist 			INT NOT NULL,
  id_video 				INT NOT NULL,
  PRIMARY KEY (id_playlist, id_video),

	CONSTRAINT fk_tb_playlist_video_tb_playlists FOREIGN KEY (id_playlist) REFERENCES tb_playlists (id),
	CONSTRAINT fk_tb_playlist_video_tb_playlists_video FOREIGN KEY (id_video) REFERENCES tb_videos (id_video)
);

CREATE TABLE IF NOT EXISTS tb_videos_likes (
  id_video 				INT NOT NULL,
  id_user 				INT NOT NULL,
  video_like 			ENUM('-1', '1') NULL,
  
	PRIMARY KEY (id_video, id_user),
  
	CONSTRAINT fk_tb_videos_likes_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
	CONSTRAINT fk_tb_videos_likes_tb_user FOREIGN KEY (id_user) REFERENCES tb_users (id)
);
DROP TABLE tb_videos_comments;
CREATE TABLE IF NOT EXISTS tb_videos_comments (
  id_comment			INT NOT NULL AUTO_INCREMENT,
  id_video 				INT NOT NULL,
  id_user 				INT NOT NULL,
  comment 				TEXT NOT NULL,
  created_at 			TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (id_comment, id_video, id_user),
	CONSTRAINT fk_tb_videos_comments_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
	CONSTRAINT fk_tb_videos_comments_tb_users FOREIGN KEY (id_user) REFERENCES tb_users (id)
);

CREATE TABLE IF NOT EXISTS tb_videos_thumbs (
  id_video 				INT NOT NULL PRIMARY KEY,
  video_thumb_url 		VARCHAR(255) NOT NULL DEFAULT 'no-thumb.webp',

	CONSTRAINT fk_tb_videos_thumbs_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video)
);

CREATE TABLE IF NOT EXISTS tb_videos_descriptions (

  id_video 				INT NOT NULL PRIMARY KEY,
  description 			TEXT NULL,

	CONSTRAINT fk_tb_video_descriptions_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video)
);

CREATE TABLE IF NOT EXISTS tb_videos_views (
  id_video 				INT NOT NULL,
  id_user 				INT NOT NULL,
  
	PRIMARY KEY (id_video, id_user),
    
  CONSTRAINT fk_tb_videos_views_id_video FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
  CONSTRAINT fk_tb_videos_views_id_users FOREIGN KEY (id_user) REFERENCES tb_users (id)
);

-- PROCEDURES

-- Procedure para adicionar usuários
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_add_user;
CREATE PROCEDURE sp_add_user(
	IN p_user_email VARCHAR(255),
    IN p_user_password VARCHAR(255),
    IN p_user_name VARCHAR(60),
    IN p_user_birthdate DATE,
    OUT p_user_id_out INT,
    OUT p_return_message VARCHAR(255)
)
BEGIN
	
    DECLARE user_id INT;

	IF NOT EXISTS (SELECT user_email FROM tb_users WHERE user_email = p_user_email) THEN
    
		INSERT INTO tb_users VALUES (NULL, LOWER(p_user_email), sha2(p_user_password, 256), DEFAULT);
        
        SELECT last_insert_id() INTO user_id;
        
        INSERT INTO tb_person VALUES (user_id, p_user_name, p_user_birthdate);
        
        SELECT concat('O usuário ', LOWER(p_user_email) , ' foi cadastrado com sucesso.') INTO p_return_message;
        
        SELECT user_id INTO p_user_id_out;
        
	ELSE 
    
		SELECT concat('O e-mail ', p_user_email, ' já foi cadastrado.') INTO p_return_message;
    
    END IF;

END$$
DELIMITER ;

-- Procedure para adicionar um canal
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_add_channel;
CREATE PROCEDURE sp_add_channel (
	IN p_channel_name VARCHAR(140),
    IN p_channel_url VARCHAR(45),
    IN p_channel_description VARCHAR(255),
    IN p_channel_location VARCHAR(140),
    OUT p_channel_id_out INT,
	OUT p_return_message VARCHAR(255)
)
BEGIN

	DECLARE id_channel BIGINT;
    


	SET p_channel_id_out = 0;

	IF EXISTS (SELECT channel_name FROM tb_channel WHERE channel_name = p_channel_name) THEN
    
		SELECT concat('O nome do canal já existe.') INTO p_return_message;
        
	ELSEIF EXISTS (SELECT channel_url FROM tb_channel WHERE channel_url = p_channel_url) THEN
    
		SELECT concat('A URL do canal já existe.') INTO p_return_message;
    
    ELSE
		
		INSERT INTO tb_channel (channel_name, channel_url, description, location, subscription) VALUES
        (p_channel_name, p_channel_url, p_channel_description, p_channel_location, FLOOR(RAND()*(10-5+1)*10000));
        
        SELECT last_insert_id() INTO p_channel_id_out;

        SELECT concat('O canal ', p_channel_name , ' foi cadastrado com sucesso.') INTO p_return_message;
        
    END IF;
    
    

END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_add_channel_banner;
CREATE PROCEDURE sp_add_channel_banner (
	IN p_id_channel INT,
    IN p_banner_image VARCHAR(255),
    OUT p_id_out INT,
	OUT p_return_message VARCHAR(255)
)
BEGIN

	SET p_id_out = 0;

	IF EXISTS (SELECT id_channel FROM tb_channel WHERE id_channel = p_id_channel) THEN
    
		INSERT INTO tb_channel_banner VALUES (p_id_channel, p_banner_image);
        
        SELECT last_insert_id() INTO p_id_out;
    
		SELECT 'O banner do canal foi atualizado com sucesso.' INTO p_return_message;
        
    
    ELSE
		
		SELECT 'Este canal não existe.' INTO p_return_message;
        
    END IF;
    
    

END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_add_channel_videos;$$
CREATE PROCEDURE sp_add_channel_videos (
	IN p_id_channel INT,
    IN p_video_name VARCHAR(140),
    IN p_video_description TEXT,
    IN p_video_thumb_url VARCHAR(255), 
    OUT p_id_out INT,
	OUT p_return_message VARCHAR(255)
)
BEGIN

	DECLARE v_video_code VARCHAR(255);
    
	SET p_id_out = 0;

	IF EXISTS (SELECT id_channel FROM tb_channel WHERE id_channel = p_id_channel) THEN
    
		SELECT fn_random(10) INTO v_video_code;
    
		INSERT INTO tb_videos (id_channel, video_code, video_name, video_length) VALUES (p_id_channel, v_video_code, p_video_name, CONCAT(1,substring(RAND(),4,3)));
        
		SELECT last_insert_id() INTO p_id_out;
        
        INSERT INTO tb_videos_descriptions VALUES (p_id_out, p_video_description);
        
        INSERT INTO tb_videos_thumbs VALUES (p_id_out, p_video_thumb_url);
    
		SELECT 'O upload foi realizado com sucesso.' INTO p_return_message;
    
    ELSE
		
		SELECT 'Este canal não existe.' INTO p_return_message;
        
    END IF;
    
    

END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE sp_add_video_comments;
CREATE PROCEDURE sp_add_video_comments(
	IN p_id_video INT,
    IN p_id_user INT,
    IN p_comment TEXT,
	OUT p_id_out INT,
	OUT p_return_message VARCHAR(255)
)
BEGIN

	SET p_id_out = 0;

	IF EXISTS (SELECT id FROM tb_users WHERE id = p_id_user) THEN
    
		IF EXISTS (SELECT id_video FROM tb_videos WHERE id_video = p_id_video) THEN
        
			INSERT INTO tb_videos_comments VALUES (null, p_id_video, p_id_user, p_comment, default);
            
            SELECT last_insert_id() INTO p_id_out;
    
			SELECT 'Comentário enviado com sucesso.' INTO p_return_message;
            
		ELSE 
        
			SELECT 'Esse vídeo não existe.' INTO p_return_message;
        
        END IF;
        
	ELSE
    
		SELECT 'Este usuário não existe' INTO p_return_message;
    
    END IF;
	

END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE sp_add_playlists;$$
CREATE PROCEDURE sp_add_playlists(
	IN p_id_channel INT,
    IN p_name VARCHAR(140),
	OUT p_id_out INT,
	OUT p_return_message VARCHAR(255)
)
BEGIN

	SET p_id_out = 0;

	IF EXISTS (SELECT id_channel FROM tb_channel WHERE id_channel = p_id_channel) THEN
	
		INSERT INTO tb_playlists VALUES (null, p_id_channel, p_name, default, default);
		
		SELECT last_insert_id() INTO p_id_out;

		SELECT CONCAT('A playlist ', p_name, ' foi criada com sucesso.') INTO p_return_message;
		
	ELSE 
	
		SELECT 'Esse canal não existe.' INTO p_return_message;
	
	END IF;

END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE sp_like_handler;
CREATE PROCEDURE sp_like_handler(
	IN p_id_video INT,
    IN p_id_user INT,
    IN p_video_like ENUM('-1','1'),
	OUT p_id_out INT,
	OUT p_return_message VARCHAR(255)
)
BEGIN

	DECLARE v_status CHAR(2);
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
		SELECT('Não foi possível interagir com este vídeo') INTO p_return_message;
        SET p_id_out = 0;
    END;
    
    SET v_status = 0;

	SELECT video_like INTO v_status FROM tb_videos_likes WHERE id_video = p_id_video AND id_user = p_id_user;
    
	IF (v_status != 0) THEN
		
        IF (v_status = p_video_like) THEN
			DELETE FROM tb_videos_likes WHERE id_video = p_id_video AND id_user = p_id_user;
		ELSE 
			UPDATE tb_videos_likes SET video_like = p_video_like WHERE id_video = p_id_video AND id_user = p_id_user;
		END IF;

    ELSE
		INSERT INTO tb_videos_likes VALUES (p_id_video, p_id_user, p_video_like);
    END IF;
    
	SELECT('Interação feita com sucesso') INTO p_return_message;
    SET p_id_out = 1;
    

END$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE sp_del_video_comments;
CREATE PROCEDURE sp_del_video_comments(
    IN p_id_comment INT,
    IN p_id_user INT,
    OUT p_return_message VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT id FROM tb_users WHERE id = p_id_user) THEN
   
        IF EXISTS (SELECT id_comment FROM tb_videos_comments WHERE id_comment = p_id_comment AND id_user = p_id_user) THEN
        
                DELETE FROM tb_videos_comments WHERE id_comment = p_id_comment AND id_user = p_id_user;
    
                SELECT 'Comentário excluído com sucesso.' INTO p_return_message;
            
            ELSE
            
                SELECT 'Esse comentário não existe.' INTO p_return_message;
            
            END IF;
        
    ELSE
    
        SELECT 'Este usuário não existe' INTO p_return_message;
    
        END IF;

END$$
DELIMITER ;







-- ------------------------------------------

-- email do usuário, senha do usuário, nome do usuário, data de nascimento invertida (2000-08-01) o @p_return_id, @p_return_message
CALL sp_add_user('', '', '', '', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;


-- nome do canal, url aleatoria, descrição, país, e o @p_return_id, @p_return_message
CALL sp_add_channel('', '', '', '', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;


-- id do canal, um arquivo de imagem e o @p_return_id, @p_return_message
CALL sp_add_channel_banner(0, '', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;


-- id do canal, nome do vídeo, descrição, miniatura (arquivo.jpg) e o @p_return_id, @p_return_message
-- IMPORTANTE: O NOME DO VÍDEO PRECISA SER RELACIONADO AO CANAL
call sp_add_channel_videos(0, '', '', '---.jpg', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;


-- id do video, id do usuário, comentário e o @p_return_id, @p_return_message
call sp_add_video_comments(1, 5, 'Adorei o vídeo', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;

-- id do canal, nome da playlist e o @p_return_id, @p_return_message
call sp_add_playlists(0, '', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;

-- id do vídeo, id do usuário, 1 para like ou -1 para deslike, e o @p_return_id, @p_return_message
call sp_like_handler(0, 0, '', @p_return_id, @p_return_message);
SELECT @p_return_id AS id, @p_return_message AS message;

-- id do comentário, id do usuário (simulando usuário logado) e o @p_return_message
call sp_del_video_comments(0,0,@p_return_message);
SELECT @p_return_message AS message;







-- ----------------------------------------

-- FUNÇÕES

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

-- ----------------------------------------

-- Alimentando os usuários - Por Eduardo Nicolini
CALL sp_add_user('glaucio@gmail.com', '654321', 'Glaucio', '1988-04-06', @p_return_id, @p_return_message);
CALL sp_add_user('mary.smith@sakilacustomer.org', '78Eg&4', 'Mary', '1970-05-16', @p_return_id, @p_return_message);
CALL sp_add_user('patricia.johnson@sakilacustomer.org', '3a1$89', 'Patricia', '1995-10-26', @p_return_id, @p_return_message);
CALL sp_add_user('margaret.moore@sakilacustomer.org', 'Hj&21', 'Margaret', '2005-04-17', @p_return_id, @p_return_message);
CALL sp_add_user('linda.williams@sakilacustomer.org', '95#1f53', 'Linda', '1998-12-29', @p_return_id, @p_return_message);
CALL sp_add_user('barbara.jones@sakilacustomer.org', '85%56k', 'Barbara', '1978-11-25', @p_return_id, @p_return_message);
CALL sp_add_user('elizabeth.brown@sakilacustomer.org', '9Fh756', 'Elizabeth', '2000-10-10', @p_return_id, @p_return_message);
CALL sp_add_user('jennifer.davis@sakilacustomer.org', '65iP$1', 'Jennifer', '2005-03-02', @p_return_id, @p_return_message);
CALL sp_add_user('maria.miller@sakilacustomer.org ', '6tQg3', 'Maria', '2009-06-12', @p_return_id, @p_return_message);
CALL sp_add_user('susan.wilson@sakilacustomer.org', '65@#yu', 'Susan', '1996-07-13', @p_return_id, @p_return_message);

select tb_users.user_email, tb_users.user_password, tb_person.name, tb_person.birth_date
from tb_person inner join tb_users on tb_users.id = tb_person.id_user;

-- Alimentando os canais - Por Pedro Parimoski
CALL sp_add_channel('Sabe tudo', 'sabe_tudo', 'O melhor canal para aprender', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Churrasco Brasil', 'churasco_brasil', 'O melhor canal de churrasco do Brasil', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Games SP', 'games_sp', 'Canal voltado ao mundo gamer', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Vida Saudavel', 'vida_saudavel', 'Deixe sua vida mais saudavel', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Vamos rir', 'vamos_rir', 'Canal de pegadinha', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Podcast Familia', 'podcast_familia', 'Os melhores Podcast', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Culinaria RJ', 'culinaria_rj', 'Pratos tipicos', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Surf', 'surf_eua', 'Surf', 'Estados Unidos', @p_return_id, @p_return_message);
CALL sp_add_channel('Cortes Pah', 'cortes_pah', 'Canal voltado a cortes de podcast', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Minha Hortal', 'minha_horta', 'Aprenda tudo sobre horta de uma maneira facil', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Tutoriais de Tecnologia', 'tuto_tec', 'Aprenda tudo sobre tecnologia', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Self Make', 'self_make', 'Dicas e truques sobre maquiagem', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Ideias Incriveis', 'ideias_incriveis', 'Supreenda-se com nossas ideias', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Play Game Br', 'play_gamebr', 'Games play e dicas dos seus jogos favoritos', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Clip Mania', 'clip_mania', 'Clips das melhores musicas!', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Hcode', 'hcode', 'Os melhores cursos para DEV do Brasil!', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Pintura da Ju', 'pintura_ju', 'Canal com dicas e truques sobre pintura em tecido', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Tunning Brasil', 'tunning_brasil', 'Os carros mais tunnados você só encontra aqui', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Faça você mesmo', 'faca_voce_mesmo', 'Faça em casa gastando muito pouco com nossos tutorias', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Memes Nwes', 'memes_news', 'Todos os memes você encontra aqui', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Moda Fashion', 'moda_fashion', 'Todas as tendencias e coleções', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Churras Gaucho', 'churrasco_gaucho', 'Tecnicas e truqeus para o verdadeiro churrasco!', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Play Station Brasil', 'ps_brasil', 'Canal oficial do playstation no Brasil!', 'Brasil', @p_return_id, @p_return_message);
CALL sp_add_channel('Speed Arts PS', 'speed_artps', 'Videos de speed arts utilizando o photoshop', 'Brasil', @p_return_id, @p_return_message);

-- Alimentando tabelas de apoio, por Roberto Griel Filho
INSERT INTO tb_playlist_video VALUES (1,2),(1,3),(1,4);
INSERT INTO tb_playlist_video VALUES (2,2),(2,3),(2,4);
SELECT b.name AS 'Nome da Playlist', b.created_at AS 'Criada em', b.updated_at AS 'Última Atualização', c.channel_name AS 'Nome do Canal', d.video_name AS 'Nome do Vídeo'
FROM tb_playlist_video a 
INNER JOIN tb_playlists b ON a.id_playlist = b.id 
INNER JOIN tb_channel c ON b.id_channel = c.id_channel
INNER JOIN tb_videos d ON a.id_video = d.id_video
WHERE b.id = 2;

TABLE tb_playlists;
select * from tb_videos where id_channel = 2;