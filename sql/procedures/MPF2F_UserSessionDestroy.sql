DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionDestroy`$$
CREATE PROCEDURE `MPF2F_UserSessionDestroy`(

/*
===================================================
 Nombre: MPF2F_UserSessionDestroy
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

	UPDATE MPF2F_user_session SET valid = 0 WHERE user = _user AND session_key = _session_key;



END$$
DELIMITER ;
