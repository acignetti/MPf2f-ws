DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_GetSaleUser`$$
CREATE PROCEDURE `MPF2F_GetSaleUser`(

/*
===================================================
 Nombre: MPF2F_GetSaleUser
 Descripción: Devuelve las credenciales de un usuario dado el id de una venta
 Comentarios:
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
_sale_id int
)
BEGIN
	
SELECT u.client_id, u.client_secret, u.token
FROM MPF2F_user u
INNER JOIN MPF2F_sale s on s.user_id = u.user_id
WHERE s.sale_id = _user_id;


END$$
DELIMITER ;
