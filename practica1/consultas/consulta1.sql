--Consulta 1
--Campeones de liga
CREATE VIEW ganadores_liga AS
SELECT DISTINCT nombre
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

--Clasificación de equipos de cada temporada de cada división a mitad de liga sin los 3 primeros
CREATE VIEW mitad_liga AS
SELECT DISTINCT nombre
FROM (
	SELECT temporada, division, nombre, mitad_de_liga, row_number() over(PARTITION BY temporada, division ORDER BY temporada, division, mitad_de_liga DESC) AS puesto
	FROM (
		--Puntuaciones de todos los equipos a mitad de liga
		SELECT P.temporada, P.nombre, P.division, sum(P.puntuacion) AS mitad_de_liga
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
		WHERE P.temporada=J.idTemporada AND P.division=J.idDivision AND P.jornada<=(J.numJornadas/2)
		GROUP BY P.temporada, P.division, P.nombre
	)
) 
WHERE puesto>3;

SELECT M.nombre
FROM ganadores_liga G INNER JOIN mitad_liga M ON G.nombre=M.nombre;