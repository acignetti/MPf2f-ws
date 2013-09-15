DELIMITER $$
DROP PROCEDURE IF EXISTS `MPF2F_UserSignUp`$$
CREATE PROCEDURE `MPF2F_UserSignUp`(

/*
===================================================
 Nombre: MPF2F_UserSignUp
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user varchar(100) ,
_pass varchar(100) ,
_name varchar(255),
_client_id varchar(50) ,
_client_secret varchar(50),
_token varchar(100)
)
BEGIN
	
	INSERT INTO MPF2F_user(user, pass, name, client_id, client_secret, token)
	   VALUES(_user, _pass, _name, _client_id, _client_secret, _token);


END$$
DELIMITER ;
