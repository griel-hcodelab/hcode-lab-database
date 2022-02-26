CREATE DATABASE youtube;
USE youtube;

-- Criando usuários:

-- DBA
CREATE USER 'root'@'%.%.%.%' IDENTIFIED BY 'E5qS4SOfO0cjpd3Jl3wb';
GRANT ALL PRIVILEGES ON youtube.* TO 'root'@'%.%.%.%';

-- DBD
CREATE USER 'devadmin'@'%.%.%.%' IDENTIFIED BY 'senha123';
GRANT INSERT, DELETE, UPDATE, SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'devadmin'@'%.%.%.%';

-- Final Developer
CREATE USER 'developer'@'%.%.%.%' IDENTIFIED BY 'password123';
GRANT SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'developer'@'%.%.%.%';

-- Tabela de Usuários

CREATE TABLE IF NOT EXISTS tb_users (
  id 			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_email 	VARCHAR(255) NOT NULL,
  user_password VARCHAR(255) NOT NULL,
  created_at 	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
	UNIQUE INDEX user_email_uq(user_email ASC) 
);


-- Tabela de dados pessoais

CREATE TABLE IF NOT EXISTS tb_person (
  id_user 		INT NOT NULL,
  name 			VARCHAR(255) NOT NULL,
  birth_date 	DATE NOT NULL,
  PRIMARY KEY (id_user),
  CONSTRAINT fk_tb_person_tb_users1
    FOREIGN KEY (id_user)
    REFERENCES tb_users (id)
    
    );


-- Tabela de Canais

CREATE TABLE IF NOT EXISTS tb_channel (
  id_channel 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_user 			INT NOT NULL,
  channel_name 		VARCHAR(100) NOT NULL,
  channel_url 		VARCHAR(45) NOT NULL,
  subscription		BIGINT NOT NULL DEFAULT 0,
  created_at 		DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at 		DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  channel_active 	TINYINT DEFAULT 1,
  
	UNIQUE INDEX channel_url_uq(channel_url ASC),
	INDEX fk_tb_channel_tb_users (id_user ASC),
	CONSTRAINT fk_tb_channel_tb_users FOREIGN KEY (id_user) REFERENCES tb_users (id)    
);



-- Tabela de Vídeos

CREATE TABLE IF NOT EXISTS tb_videos (
  id_video 				INT NOT NULL AUTO_INCREMENT,
  id_channel 			INT NOT NULL,
  video_url 			VARCHAR(255) NOT NULL,
  video_name 			VARCHAR(140) NOT NULL,
  uploaded_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  video_length 			TIME NOT NULL,
  video_tags 			VARCHAR(255) NULL,
  video_is_restricted 	TINYINT NOT NULL DEFAULT 0,
  paid_promotion 		TINYINT NOT NULL DEFAULT 0,
  video_visibility 		ENUM('public', 'restricted', 'private') NOT NULL DEFAULT 'private',
  id_category 			TINYINT NULL,
	
    PRIMARY KEY (id_video, id_channel),
	INDEX fk_tb_videos_tb_channel (id_channel DESC),
	CONSTRAINT fk_tb_videos_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel (id_channel)    
);



-- Tabela de likes nos vídeos

CREATE TABLE IF NOT EXISTS tb_videos_likes (
  id_video 		INT NOT NULL,
  id_user 		INT NOT NULL,
  video_like 	ENUM('-1', '1') NULL,
	PRIMARY KEY (id_video, id_user),
	INDEX fk_tb_videos_likes_tb_user_idx (id_user ASC),
	CONSTRAINT fk_tb_videos_likes_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
	CONSTRAINT fk_tb_videos_likes_tb_user FOREIGN KEY (id_user) REFERENCES tb_users (id)
);



-- Tabela com os comentários dos vídeos

CREATE TABLE IF NOT EXISTS tb_videos_comments (
  id_comment 	INT NOT NULL AUTO_INCREMENT,
  id_video 		INT NOT NULL,
  id_user 		INT NOT NULL,
  comment 		TEXT NOT NULL,
  created_at 	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_comment, id_video, id_user),
	INDEX fk_tb_videos_comments_tb_users (id_user DESC),
	CONSTRAINT fk_tb_videos_comments_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
	CONSTRAINT fk_tb_videos_comments_tb_users FOREIGN KEY (id_user) REFERENCES tb_users (id)
);

CREATE TABLE IF NOT EXISTS tb_videos_comments_history (
  id_video 		INT NOT NULL,
  comment 		TEXT NOT NULL,
  deleted_at 	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
)ENGINE = archive;



-- Tabela para as thumbs dos vídeos

CREATE TABLE IF NOT EXISTS tb_videos_thumbs (
  id_video 			INT NOT NULL PRIMARY KEY,
  video_thumb_url 	VARCHAR(255) NOT NULL,
	CONSTRAINT fk_tb_videos_thumbs_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video)
);



-- Tabela com descrição dos vídeos

CREATE TABLE IF NOT EXISTS tb_videos_descriptions (
  id_video 			INT NOT NULL PRIMARY KEY,
  description 		TEXT NULL,
	CONSTRAINT fk_tb_video_descriptions_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video)
);



-- Tabela com playlists com vídeo

CREATE TABLE IF NOT EXISTS tb_playlists (
  id 					INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_channel 			INT NOT NULL,
  name 					VARCHAR(140) NULL,
  playlist_description	TEXT NULL,
  playlist_visibility 	ENUM('public', 'restricted', 'private') NOT NULL DEFAULT 'private',
  created_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at 			DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	INDEX fk_tb_playlists_tb_channel_idx (id_channel DESC),
	CONSTRAINT fk_tb_playlists_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel (id_channel)
);

-- Tabela de apoio para Playlist

CREATE TABLE IF NOT EXISTS tb_playlist_video (
  id_playlist 		INT NOT NULL,
  id_video 			INT NOT NULL,
	  PRIMARY KEY (id_playlist, id_video),
	  INDEX fk_tb_playlist_video_tb_playlists_video_idx (id_video DESC) ,
	  CONSTRAINT fk_tb_playlist_video_tb_playlists FOREIGN KEY (id_playlist) REFERENCES tb_playlists (id),
	  CONSTRAINT fk_tb_playlist_video_tb_playlists_video FOREIGN KEY (id_video) REFERENCES tb_videos (id_video)
);


-- Tabela com configurações do canal

CREATE TABLE IF NOT EXISTS tb_channel_settings (
  id_channel 				INT NOT NULL PRIMARY KEY,
  channel_banner_image 		VARCHAR(255) NULL,
  channel_avatar_image 		VARCHAR(255) NULL,
  channel_description 		TEXT NULL,
  channel_location 			VARCHAR(140) NOT NULL,
  channel_video_trailer 	INT NULL,
  channel_video_featured 	INT NULL,
  channel_currency 			VARCHAR(4) NOT NULL DEFAULT 'BRL',
  channel_keywords 			VARCHAR(255) NULL,

	CONSTRAINT fk_tb_channel_banner_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel (id_channel)
);


-- Tabela de inscritos do canal

CREATE TABLE IF NOT EXISTS tb_channel_subscribers (
  id_user 		INT NOT NULL,
  id_channel 	INT NOT NULL,
  id_video 		INT NOT NULL,
  created_at 	DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_user, id_channel, id_video)
);



-- Tabelas de categorias pré-definidas do YouTube

CREATE TABLE IF NOT EXISTS tb_system_categories (
  id 	TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name 	VARCHAR(140) NOT NULL
);

INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Filmes e animação');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Automóveis');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Música');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Animais');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Esportes');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Viagens e eventos');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Jogos');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Pessoas e blogs');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Comédia');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Entretenimento');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Notícias e política');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Instruções e estilo');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Educação');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Ciência e tecnologia');
INSERT INTO tb_system_categories (id, name) VALUES (DEFAULT, 'Sem fins lucrativos e ativismo');


-- Tabela de apoio das categorias dos vídeos

CREATE TABLE IF NOT EXISTS tb_video_category (
  id_category 	TINYINT NOT NULL,
  id_video 		INT NOT NULL,
  PRIMARY KEY (id_category, id_video),
  INDEX fk_tb_videos_category_tb_videos_idx (id_video DESC),
  INDEX fk_tb_video_category_tb_system_categories_idx (id_category DESC),
  CONSTRAINT fk_tb_videos_category_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
  CONSTRAINT fk_tb_video_category_tb_system_categories FOREIGN KEY (id_category) REFERENCES tb_system_categories (id)
);



-- Tabela de armazenamento de visualização atual do vídeo

CREATE TABLE IF NOT EXISTS tb_video_current_state (
  id_video 			INT NOT NULL,
  id_user 			INT NOT NULL,
  current_state 	TIME NOT NULL,
  INDEX fk_tb_videos_current_state_tb_videos_idx (id_video DESC) ,
  INDEX fk_tb_videos_current_state_tb_user_idx (id_user DESC) ,
  CONSTRAINT fk_tb_videos_current_state_tb_videos FOREIGN KEY (id_video) REFERENCES tb_videos (id_video),
  CONSTRAINT fk_tb_videos_current_state_tb_user FOREIGN KEY (id_user) REFERENCES tb_users (id)
);



-- Tabela com histórico de exclusão do vídeo.

CREATE TABLE IF NOT EXISTS tb_video_deleted (
  id_video	 	INT NOT NULL,
  deleted_at 	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
	COMMENT 'TABELA DE HISTÓRICO DE EXCLUSÃO DE VIDEOS.\n\nIrá armazenar os dados do vídeo excluído, como o id do vídeo, o id do usuário que excluiu, a data de exclusão e o motivo, que pode ser exclusão proposital do usuário, strike ou denúncia por exemplo.')
ENGINE archive;



-- Tabela para assinaturas YouTube Premium

CREATE TABLE IF NOT EXISTS tb_users_premium (
  id_user 		INT NOT NULL PRIMARY KEY,
  valid_until 	DATE NOT NULL,
  updated_at 	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
	CONSTRAINT fk_tb_users_premium_tb_users FOREIGN KEY (id_user) REFERENCES tb_users (id)
);



-- Tabela com informações padrão para futuros uploads

CREATE TABLE IF NOT EXISTS tb_channel_upload_defaults (
  id_channel 		INT NOT NULL PRIMARY KEY,
  video_title 		VARCHAR(255) NULL,
  video_description TEXT NULL,
  video_visibility 	ENUM('public', 'restricted', 'private') NULL,
  video_tags 		VARCHAR(255) NULL,

	CONSTRAINT fk_tb_channel_upload_defaults_tb_channel FOREIGN KEY (id_channel) REFERENCES tb_channel (id_channel)
);


-- Tabela com o histórico de visualizações dos vídeos do usuário

CREATE TABLE IF NOT EXISTS tb_video_view (
  id_view 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_video 		INT NULL,
  id_user 		INT NOT NULL,
  created_at 	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
	INDEX fk_tb_video_view_id_video_idx (id_video DESC)
);


-- ------------------------------------------
-- PROCEDURES
-- ------------------------------------------






-- ------------------------------------------
-- VIEWS
-- ------------------------------------------




-- ------------------------------------------
-- TRIGGERS
-- ------------------------------------------

DELIMITER $$

DROP TRIGGER IF EXISTS tg_comment_history;
CREATE TRIGGER tg_comment_history BEFORE DELETE ON tb_videos_comments
	FOR EACH ROW
		BEGIN
        
			INSERT INTO tb_videos_comments_history VALUES (old.id_video, old.comment, NOW());
        
        END $$

DELIMITER ;

DELIMITER $$

DROP TRIGGER IF EXISTS tg_video_history;
CREATE TRIGGER tg_video_history BEFORE DELETE ON tb_videos
	FOR EACH ROW
		BEGIN

			INSERT INTO tb_video_deleted VALUES (old.id_video, NOW());
        
        END $$

DELIMITER ;

-- ------------------------------------------
-- EVENT
-- ------------------------------------------

