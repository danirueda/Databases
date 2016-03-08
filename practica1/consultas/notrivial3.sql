--Estadio, capacidad e inauguración de los equipos que han ganado por una diferencia de al menos 6 goles.

CREATE VIEW goleadores AS
SELECT DISTINCT goleador
FROM (
	SELECT CASE 
			WHEN (golesLocal-golesVisitante)>= 6 THEN nombreLocal
			WHEN (golesLocal-golesVisitante)<= -6 THEN nombreVisitante
			END AS goleador
	FROM PARTIDOS
) WHERE goleador IS NOT NULL;

SELECT E.nombre, E.capacidad, E.inauguración
FROM goleadores G INNER JOIN TENER T ON G.goleador=T.nombreEquipo INNER JOIN ESTADIO E
ON T.nombreEstadio=E.nombre;