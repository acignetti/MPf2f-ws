DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionCheck`$$
CREATE PROCEDURE `MPF2F_UserSessionCheck`(

/*
===================================================
 Nombre: MPF2F_UserSessionCheck
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail: Coronel, Axel: Fix comparacion de la fecha
===================================================
*/
_user VARCHAR(100),
_session_key VARCHAR(100)
)
BEGIN

	
SELECT *
		FROM MPF2F_user_session
		WHERE user = _user AND session_key = _session_key
			AND  date_end >= now() AND valid = 1 LIMIT 1;



END$$
DELIMITER ;
