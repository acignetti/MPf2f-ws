	DELIMITER $$
	DROP PROCEDURE IF EXISTS `MPF2F_SaleGet`$$
	CREATE PROCEDURE `MPF2F_SaleGet`(

	/*
	===================================================
	 Nombre: MPF2F_SaleGet
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail: Coronel, Axel: fix nombre columna
	===================================================
	*/

	  _sale_id int,
	 _user_id int
	)
	BEGIN
		
		SELECT * FROM MPF2F_sale WHERE sale_id = _sale_id and user_id = _user_id;
		


	END$$
	DELIMITER ;
