

SELECT a.id_video, a.id_channel, a.video_code, a.video_name, a.video_length, c.description, d.video_thumb_url, e.comment
        FROM tb_videos a
        LEFT JOIN tb_videos_views b ON a.id_video = b.id_video
		LEFT JOIN tb_videos_descriptions c ON a.id_video = c.id_video
		LEFT JOIN tb_videos_thumbs d ON a.id_video = d.id_video
		LEFT JOIN tb_videos_comments e ON a.id_video = e.id_video

		WHERE a.id_video = 1;
;

DELIMITER $$

DROP PROCEDURE sp_watch_video;$$
CREATE PROCEDURE sp_watch_video(
	IN p_video_id INT,
    IN p_user_id INT
)
BEGIN
	
    IF EXISTS(SELECT id_video FROM tb_videos WHERE id_video = p_video_id) THEN
    
		INSERT INTO tb_videos_views VALUES (id_video, id_user);
    
		SELECT a.id_video, a.id_channel, a.video_code, a.video_name, a.video_length, b.description, c.video_thumb_url, d.comment
        FROM tb_videos a
        INNER JOIN tb_videos_views b ON a.id_video = b.id_video
		LEFT JOIN tb_videos_descriptions c ON a.id_video = c.id_video
		LEFT JOIN tb_videos_thumbs d ON a.id_video = d.id_video
		LEFT JOIN tb_videos_comments e ON a.id_video = e.id_video

		WHERE a.id_video = p_video_id;
        

        
        SELECT count(id_video) FROM tb_videos_views WHERE id_video = p_video_id;
	
    ELSE
    
		SELECT('Erro 404: Este vídeo não existe, foi oculto ou excluído do YouTube') AS result;
        
	END IF;

END$$

DELIMITER ;

call sp_watch_video(1, 1);

TABLE tb_videos;