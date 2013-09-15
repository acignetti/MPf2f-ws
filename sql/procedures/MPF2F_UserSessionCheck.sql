DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionCheck`$$
CREATE PROCEDURE `MPF2F_UserSessionCheck`(

/*
===================================================
 Nombre: MPF2F_UserSessionCheck
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100),
_session_key VARCHAR(100)
)
BEGIN

DECLARE _user_id int DEFAULT -1;

SELECT user_id INTO _user_id FROM MPF2F_user WHERE user = _user;

IF _user_id > -1 THEN
	
	SELECT *, _user_id as user_id
		FROM MPF2F_user_session
		WHERE user = _user AND session_key = _session_key
			AND  date_end >= now() AND valid = 1 LIMIT 1;
END IF;


END$$
DELIMITER ;
