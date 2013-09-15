DELIMITER $$

DROP PROCEDURE IF EXISTS `MPF2F_DealGet`$$
CREATE PROCEDURE `MPF2F_DealGet`(

/*
===================================================
 Nombre: MPF2F_DealGet
 Descripcion: Obtiene los datos de una oferta por el id
 Comentarios: 
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
IN _id INT
)
BEGIN

select * from MPF2F_deals d where d.deal_id = _id;

END$$

DELIMITER ;