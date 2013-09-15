DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_GetUserCredentials`$$
CREATE PROCEDURE `MPF2F_GetUserCredentials`(

/*
===================================================
 Nombre: MPF2F_GetUserCredentials
 Descripción: Devuelve las credenciales de un usuario dado el id
 Comentarios:
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
_user_id int
)
BEGIN
	
SELECT u.client_id, u.client_secret, u.token
FROM MPF2F_user u
WHERE u.user_id = _user_id; 


END$$
DELIMITER ;
