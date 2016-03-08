--Máximo equipo goleador en goles totales de cada temporada de cada división

CREATE VIEW suma_goles AS
SELECT temporada, division, nombre, sum(goles) AS goles
FROM (
	SELECT temporada, division, nombreLocal AS nombre, sum(golesLocal) AS goles
	FROM PARTIDOS
	GROUP BY temporada, division, nombreLocal
	UNION ALL
	SELECT temporada, division, nombreVisitante, sum(golesVisitante)
	FROM PARTIDOS
	GROUP BY temporada, division, nombreVisitante
)
GROUP BY temporada, division, nombre;

CREATE VIEW golesMaximos AS
SELECT temporada, division, max(goles) AS goles
FROM suma_goles
GROUP BY temporada, division;

SELECT S.temporada, S.division, S.nombre, S.goles
FROM suma_goles S INNER JOIN golesMaximos M ON S.temporada=M.temporada AND S.division=M.division
AND S.goles=M.goles
ORDER BY S.temporada, S.division;