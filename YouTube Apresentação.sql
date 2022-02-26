-- DBA
CREATE USER 'root'@'localhost' IDENTIFIED BY 'E5qS4SOfO0cjpd3Jl3wb';
GRANT ALL PRIVILEGES ON youtube.* TO 'root'@'localhost';
GRANT ALL PRIVILEGES ON youtube.* TO 'root'@'200.255.26.0';

-- DBD
CREATE USER 'devadmin'@'localhost' IDENTIFIED BY 'senha123';
GRANT INSERT, DELETE, UPDATE, SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'devadmin'@'localhost';
GRANT INSERT, DELETE, UPDATE, SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'devadmin'@'200.225.26.0';

-- Final Developer
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'developer'@'localhost';
GRANT SELECT, SHOW VIEW, EXECUTE ON youtube.* TO 'developer'@'200.225.26.0';






































USE youtube;

-- Criando um usuário no YouTube.
-- Parâmetros: e-mail, senha, Nome do Usuário, data de nascimento
call sp_users_i('apresentação@youtube.com.br','uma_senha_forte_123','Roberto Griel Filho', '1989-08-28', @last_insert_id, @action_message);































-- Definindo uma assinatura Premium à um usuário no YouTube
-- Neste caso, informamos somente o ID do usuário
call sp_users_premium(15, @executre, @action_message);
































-- Criando um canal
-- Para a criação do canal, informamos o ID do usuário e o nome do canal que será criado
call sp_channel_i(15,'Canal Canal', @id, @message);
SELECT * FROM vw_all_channels;
SELECT * FROM vw_all_active_channels;































-- Atualizando o nome do canal. 
-- É necessário informar o ID do canal, o ID do usuário e o novo nome do canal
call sp_channel_u(16,15,'Canal Sabe Tudo2', @message);































-- Definindo as configurações do canal
-- Para atualizar as configurações do canal, passamos o ID do canal e que vamos alterar
-- > Neste caso iremos definir o país, a moeda, o banner, o avatar, a descrição, ID do vídeo de trailer, ID do vídeo de destaque e as tags
call sp_channel_settings_iu(16, 'Brasil', 'USD', 'bannerphp8.webp', 'avatarphp8.webp','Sabe de tudo', null, null, 'programação, php8.1', @id, @message);



































-- Criando uma playlist para o canal
-- Neste caso passamos a ID do canal, o nome da Playlist, uma descrição e a visilibilidade. 
call sp_playlists(16, 'Instalando o PHP','Aprenda a instalar o PHP 8.1 em seu computador','public', @id, @message);


































-- FAZENDO UPLOAD DO VÍDEO
-- Exibindo as categorias do sistemas e playlists através de uma view antes de enviar o vídeo
SELECT * FROM vw_categories;
SELECT * FROM vw_playlists WHERE Canal = 16;
-- O vídeo recebe a ID do canal, uma URL, o nome do vídeo, a duração, as tags, se o vídeo é restrito, se contém promoçãop paga, a visibilidade, a categoria, a thumb, descrição e a playlist
call sp_video_i (16, 'video_legal','Um vídeo show', '00:00:00', 'tags', 0, 0, 'public', 1, 'thumb.webp', 'Descrição', 1, @id, @message);
SELECT * FROM vw_select_video;

































-- ------------------

-- Atualizando informações dos vídeos

-- Para atualizar um vídeo, precisamos informar o ID do vídeo, ID do canal e o que vamos alterar
call sp_video_u(83, 16,'Um vídeo show (Atualizado)','Novas tags', 0, 0, 'public', 1, 'thumb.webp', 'Nova Descrição', 2, @id, @message);
SELECT * FROM vw_select_video WHERE id = 83;



 



























-- ------------------

-- Exibindo os vídeos
SELECT * FROM vw_select_video;

































-- Dando like em um vídeo
-- Para darmos like, passamos o ID do vídeo, o ID do usuário e a ação
call sp_videos_likes(83, 1, '1');
SELECT * FROM vw_select_video;

































-- =============================
-- ASSISTINDO UM VÍDEO
-- Para assistir um vídeo, informo o id do usuário e o ID do vídeo. Se o usuário não estiver logado, pode passar 0 | Usuário 1 é maior de idade, Usuário 2 é menor de idade
call sp_watch_video(2,1);
-- =============================

































-- Fazendo um comentário em um vídeo
-- Para comentar, passamos o ID do vídeo, o ID do usuário e o comentário
CALL sp_comments_i (83, 1, 'Comentário!', @id, @message);
SELECT * FROM vw_comments WHERE id = 83;






























-- Alterando um comentário. 
-- Precisaos informar o ID do comentário, o ID do vídeo, o ID do usuário e o novo comentário
call sp_comments_u(7, 83, 1,'Novo comentário', @action_message);
SELECT * FROM vw_comments WHERE id = 83;







































































-- -----------------

-- Excluindo um comentário. É necessário passar o id do comentário, o ID do vídeo e o ID do usuario
call sp_comments_d(7,83,1);
SELECT * FROM tb_videos_comments_history;
































-- Exclusão do vídeo requer cuidados especiais. É preciso garantir que quem esteja apagando o vídeo seja o dono do vídeo e proprietário do canal.
-- É passados nos parâmetros o ID do vídeo, o ID do canal e o ID do usuário
START TRANSACTION;
call sp_videos_d(83, 16, 15);
SELECT * FROM vw_select_video;
SELECT * FROM tb_video_deleted;






























-- Exclusão do canal é o mais crítico. É preciso garantir que os dados estejam corretos, uma vez que outra procedure é executada em loop.
-- É passado nos parâmetros o ID do canal e o ID do usuário
START TRANSACTION;
call sp_channel_d(16,15);
SELECT * FROM vw_all_channels;


