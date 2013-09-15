	DELIMITER $$
	DROP PROCEDURE IF EXISTS `MPF2F_SaleNew`$$
	CREATE PROCEDURE `MPF2F_SaleNew`(

	/*
	===================================================
	 Nombre: MPF2F_SaleNew
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/
	  _user_id int,
	  _name varchar(500),
	  _ammount double

	  
	)
	BEGIN
		
		
		INSERT INTO MPF2F_sale(user_id, name, ammount, date) VALUES(_user_id, _name, _ammount, now());

		SELECT @@identity as sale_id;


	END$$
	DELIMITER ;
