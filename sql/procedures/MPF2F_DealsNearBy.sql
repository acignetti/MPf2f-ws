DELIMITER $$

DROP PROCEDURE IF EXISTS `MPF2F_DealsNearBy`$$
CREATE PROCEDURE `MPF2F_DealsNearBy`(

/*
===================================================
 Nombre: MPF2F_DealsNearBy
 Descripcion: Obtiene ofertas cerca al usuario dadas sus coordenadas gps
 Comentarios: 
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
IN _lat FLOAT,
IN _lon FLOAT,
IN _min_dist FLOAT
)
BEGIN

SELECT d.*, 
 (3959 * ACOS(COS(RADIANS(_lat)) 
 * COS(RADIANS(d.lat)) 
 * COS(RADIANS(d.lon) 
 - RADIANS(_lon)) 
 + SIN(RADIANS(_lat)) 
 * SIN(RADIANS(d.lat)) 
)
) AS dist
FROM MPF2F_deals d
HAVING dist < _min_dist
ORDER BY dist
LIMIT 0, 20;

END$$

DELIMITER ;