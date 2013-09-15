	DELIMITER $$
	DROP PROCEDURE IF EXISTS `MPF2F_SaleUpdateStatus`$$
	CREATE PROCEDURE `MPF2F_SaleUpdateStatus`(

	/*
	===================================================
	 Nombre: MPF2F_SaleUpdateStatus
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/
	  _user_id int,
	  _sale_id int,
	  _status varchar(15)
	  
	)
	BEGIN
		
		UPDATE MPF2F_sale SET status = _status WHERE sale_id = _sale_id and user_id = _user_id;
		
		SELECT ROW_COUNT() as success;

	END$$
	DELIMITER ;
