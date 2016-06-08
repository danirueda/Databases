-- Vista con el año de porduccion, id de serie, numero de temporada y episodios --
-- de la temporada de las series almacenadas en la base de datos --
CREATE VIEW NUM_EPISODIOS AS
SELECT E.anioProduccion AS year, I.episodio_de AS serie, 
I.temporada, MAX(I.episodio) AS num_episodios 
-- funcion MAX para hallar el numero de episodios
FROM ESPECTACULO E, INFO_EPISODIOS I
WHERE E.id = I.episodio_de
GROUP BY anioProduccion, episodio_de, temporada  
HAVING (temporada > 1)
ORDER BY anioProduccion;


-- Vista con año de produccion, serie y numero de temporadas --
-- de las series almacenadas en la base de datos, siempre que --
-- el numero de temporadas sea mayor de 1 --
CREATE VIEW num_temporadas AS
SELECT anioProduccion AS year, episodio_de AS serie,
COUNT(DISTINCT temporada) AS num_temporadas		
-- COUNT DISTINCT para tener el numero de temporadas
FROM ESPECTACULO E, INFO_EPISODIOS I
WHERE E.id= I.episodio_de
GROUP BY E.anioProduccion, I.episodio_de
HAVING COUNT(DISTINCT temporada) > 1
ORDER BY anioProduccion;


-- A partir de las dos vistas creadas para la consulta, lista el año y la serie --
-- en las que el numero de episodios de las temporadas sea distinto en todas ellas --
SELECT year, serie
FROM num_temporadas N
WHERE N.serie IN (SELECT M.serie
		FROM num_episodios M
		HAVING COUNT(DISTINCT M.num_episodios) = N.num_temporadas 
		-- Numero de temporadas con episodios distintos igualado al numero total de temporadas
		GROUP BY M.year, M.serie);

DROP VIEW num_episodios;
DROP VIEW num_temporadas;
