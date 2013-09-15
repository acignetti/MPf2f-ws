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

	  _name varchar(500),
	  _ammount double

	  
	)
	BEGIN
		
		
		INSERT INTO MPF2F_sale( name, ammount, date) VALUES(_name, _ammount, now());

		SELECT @@identity as sale_id;


	END$$
	DELIMITER ;
