DROP PROCEDURE IF EXISTS `MPF2F_UserSessionLogin`;
DELIMITER //
CREATE PROCEDURE `MPF2F_UserSessionLogin`(

/*
===================================================
 Nombre: MPF2F_UserSessionLogin
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail: Coronel, Axel: agregado el id del usuario en el select
===================================================
*/
_user VARCHAR(100),
_pass VARCHAR(100)
)
BEGIN
	
	DECLARE userSelect VARCHAR(100) DEFAULT '';
	DECLARE secret VARCHAR(100) DEFAULT '';
	DECLARE uname VARCHAR(100) DEFAULT '';
	DECLARE uid INT DEFAULT -1;


	SELECT user_id, user,name into uid, userSelect,uname
	    FROM MPF2F_user
	    WHERE user = _user AND pass = _pass;

	IF userSelect = _user THEN
	    
	    SET @secret = MD5(CONCAT(_user, _pass, now()));
	    INSERT INTO MPF2F_user_session(user,
	                             session_key,
	                             date_start,
	                             date_end,
	                             valid)
	                               VALUES(_user,
	                                      @secret,
	                                      now(),
	                                      DATE_ADD(now(), INTERVAL 60 MINUTE),
	                                      1);

	END IF;

	SELECT uid,uname as name, us.* FROM MPF2F_user_session us WHERE user = _user AND session_key = @secret;
	

END//
DELIMITER ;