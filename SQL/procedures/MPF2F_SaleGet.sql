	DELIMITER $$
	DROP PROCEDURE IF EXISTS `MPF2F_SaleGet`$$
	CREATE PROCEDURE `MPF2F_SaleGet`(

	/*
	===================================================
	 Nombre: MPF2F_SaleGet
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/

	  _sale_id int
	  
	)
	BEGIN
		
		SELECT * FROM MPF2F_sale WHERE sale_id = _sale_id;
		


	END$$
	DELIMITER ;
