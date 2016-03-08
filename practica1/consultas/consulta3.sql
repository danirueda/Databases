--Consulta 3

--Subcampeones de liga
CREATE VIEW subcampeones AS
SELECT temporada, division, nombre
FROM (
	SELECT temporada, division, nombre, final_de_liga, row_number() over(PARTITION BY temporada, division 
		ORDER BY temporada, division, final_de_liga DESC) AS puesto
	FROM (
		--Puntuaciones de todos los equipos a final de liga
		SELECT P.temporada, P.division, P.nombre, sum(P.puntuacion) AS final_de_liga
		FROM (
			--Puntuaciones de cada equipo para cada jornada de cada division de cada temporada
			SELECT temporada, division, jornada, nombre, sum(puntos) AS puntuacion
			FROM (
				--Tabla de asignación de puntos para los locales
				SELECT temporada, division, jornada, nombreLocal AS nombre,
					CASE
						WHEN golesLocal>golesVisitante THEN 3
						WHEN golesLocal<golesVisitante THEN 0
						ELSE 1
						END AS puntos
				FROM PARTIDOS
				UNION
				--Tabla de asignación de puntos para los visitantes
				SELECT temporada, division, jornada, nombreVisitante,
					CASE
						WHEN golesLocal>golesVisitante THEN 0
						WHEN golesLocal<golesVisitante THEN 3
						ELSE 1
						END AS puntos
				FROM PARTIDOS
			)
			GROUP BY temporada, division, jornada, nombre
			ORDER BY temporada, division, jornada
		) P, (
			--Número de jornadas de cada division de cada temporada
			SELECT idTemporada, idDivision, max(jornada) AS numJornadas
			FROM JORNADA
			GROUP BY idTemporada, idDivision
			ORDER BY idTemporada, idDivision
		) J
		WHERE P.temporada=J.idTemporada AND P.division=J.idDivision AND P.jornada<=J.numJornadas
		GROUP BY P.temporada, P.division, P.nombre
		ORDER BY P.temporada, P.division, final_de_liga
	)
)
WHERE puesto=2;

CREATE VIEW campeones AS
SELECT temporada, division ,nombre
FROM (
	SELECT temporada, division, nombre, final_de_liga, row_number() over(PARTITION BY temporada, division 
		ORDER BY temporada, division, final_de_liga DESC) AS puesto
	FROM (
		--Puntuaciones de todos los equipos a final de liga
		SELECT P.temporada, P.division, P.nombre, sum(P.puntuacion) AS final_de_liga
		FROM (
			--Puntuaciones de cada equipo para cada jornada de cada division de cada temporada
			SELECT temporada, division, jornada, nombre, sum(puntos) AS puntuacion
			FROM (
				--Tabla de asignación de puntos para los locales
				SELECT temporada, division, jornada, nombreLocal AS nombre,
					CASE
						WHEN golesLocal>golesVisitante THEN 3
						WHEN golesLocal<golesVisitante THEN 0
						ELSE 1
						END AS puntos
				FROM PARTIDOS
				UNION
				--Tabla de asignación de puntos para los visitantes
				SELECT temporada, division, jornada, nombreVisitante,
					CASE
						WHEN golesLocal>golesVisitante THEN 0
						WHEN golesLocal<golesVisitante THEN 3
						ELSE 1
						END AS puntos
				FROM PARTIDOS
			)
			GROUP BY temporada, division, jornada, nombre
			ORDER BY temporada, division, jornada
		) P, (
			--Número de jornadas de cada division de cada temporada
			SELECT idTemporada, idDivision, max(jornada) AS numJornadas
			FROM JORNADA
			GROUP BY idTemporada, idDivision
			ORDER BY idTemporada, idDivision
		) J
		WHERE P.temporada=J.idTemporada AND P.division=J.idDivision AND P.jornada<=J.numJornadas
		GROUP BY P.temporada, P.division, P.nombre
		ORDER BY P.temporada, P.division, final_de_liga
	)
)
WHERE puesto=1;

--Equipos a los que el campeón ha ganado o empatado en casa en cada liga en cada temporada
CREATE VIEW equipos_camp AS
SELECT C.temporada, C.division, CASE 
								WHEN P.golesLocal>=P.golesVisitante THEN P.nombreVisitante
								END AS equipo
FROM campeones C INNER JOIN PARTIDOS P
ON C.nombre=P.nombreLocal AND C.temporada=P.temporada AND C.division=P.division;

--Equipos a los que el subcampeón ha ganado o empatado en casa en cada liga en cada temporada
CREATE VIEW equipos_sub AS
SELECT S.temporada, S.division, CASE 
								WHEN P.golesLocal>=P.golesVisitante THEN P.nombreVisitante
								END AS equipo
FROM subcampeones S INNER JOIN PARTIDOS P
ON S.nombre=P.nombreLocal AND S.temporada=P.temporada AND S.division=P.division;

SELECT DISTINCT S.temporada, S.division
FROM equipos_camp C INNER JOIN equipos_sub S ON
C.temporada=S.temporada AND C.division=S.division AND C.equipo=S.equipo
ORDER BY S.temporada, S.division;