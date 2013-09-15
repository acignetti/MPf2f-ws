DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionStart`$$
CREATE PROCEDURE `MPF2F_UserSessionStart`(

/*
===================================================
 Nombre: MPF2F_UserSessionStart
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100),
_pass VARCHAR(100)
)
BEGIN
	
	DECLARE userSelect VARCHAR(100) DEFAULT '';
	DECLARE secret VARCHAR(100) DEFAULT '';

	SELECT user into userSelect 
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

	SELECT * FROM MPF2F_user_session WHERE user = _user AND session_key = @secret;
	

END$$
DELIMITER ;
