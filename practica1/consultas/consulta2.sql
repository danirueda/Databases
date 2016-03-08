--Consulta 2
--Contador de victorias locales, visitantes y empates
SELECT temporada, division, round((count(victoriasLocales)/count(*))*100,2) AS VLocales, round((count(victoriasVisitantes)/count(*))*100,2) 
AS VVisitantes, round((count(empates)/count(*))*100,2) AS Empates
FROM (
	SELECT temporada, division,
	CASE
		WHEN golesLocal>golesVisitante THEN 1
		END AS victoriasLocales,
	CASE 
		WHEN golesLocal<golesVisitante THEN 1
		END AS victoriasVisitantes,
	CASE 
		WHEN golesLocal=golesVisitante THEN 1
		END AS empates
	FROM PARTIDOS
)
GROUP BY temporada, division
ORDER BY temporada, division;


