DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_UserGet`$$
CREATE PROCEDURE `MPF2F_UserGet`(

/*
===================================================
 Nombre: MPF2F_UserGet
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100)
)
BEGIN
	
	
	SELECT *
	    FROM MPF2F_user
	    WHERE user = _user;


END$$
DELIMITER ;
