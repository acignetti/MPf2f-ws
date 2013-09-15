	DELIMITER $$
	DROP PROCEDURE IF EXISTS `MPF2F_SaleList`$$
	CREATE PROCEDURE `MPF2F_SaleList`(

	/*
	===================================================
	 Nombre: MPF2F_SaleList
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/
	 _user_id int,
	 _status varchar(15),
	 _start int,
	 _limit int


	)
	BEGIN
		
		SELECT * FROM MPF2F_sale WHERE user_id = _user_id AND status = _status ORDER BY date desc limit _start, _limit ;
		


	END$$
	DELIMITER ;
