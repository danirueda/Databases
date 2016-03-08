--Número de veces que cada equipo ha estado en primera y en segunda división

CREATE VIEW primera AS
SELECT equipo, count(equipo) AS vecesPrimera
FROM (
	SELECT DISTINCT temporada, nombreLocal AS equipo
	FROM PARTIDOS
	WHERE division=1
)
GROUP BY equipo;

CREATE VIEW segunda AS
SELECT equipo, count(equipo) AS vecesSegunda
FROM (
	SELECT DISTINCT temporada, nombreLocal AS equipo
	FROM PARTIDOS
	WHERE division=2
)
GROUP BY equipo;


SELECT P.equipo, P.vecesPrimera, S.equipo, S.vecesSegunda
FROM primera P FULL JOIN segunda S ON P.equipo=S.equipo;

