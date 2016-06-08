-- Espectáculo, año y numero de actores que participaron en ella para toda peli --
-- producida en la década de los 80 --
CREATE VIEW actores AS
SELECT DISTINCT titulo , anioProduccion AS year, COUNT(rol) AS numActores
FROM ESPECTACULO E, PARTICIPAR P
WHERE E.id = P.id_pelicula AND P.rol = 1 AND E.anioProduccion <=1989 AND anioProduccion >= 1980
GROUP BY titulo, anioProduccion
ORDER BY anioProduccion;

-- Espectáculo, año y numero de actrices que participaron en ella para toda peli --
-- producida en la década de los 80 --
CREATE VIEW actrices AS
SELECT DISTINCT titulo AS pelicula, anioProduccion, COUNT(rol) AS numActrices
FROM ESPECTACULO E, PARTICIPAR P
WHERE E.id = P.id_pelicula AND P.rol = 2 AND E.anioProduccion <=1989 AND anioProduccion >= 1980
GROUP BY titulo, anioProduccion
ORDER BY anioProduccion;


-- Titulo de, año, numero de actrices y de actores de todos los espctáculos --
-- en los cuales el número de actrices era mayor que el número de actores --
-- durante la década de los 80 --
SELECT DISTINCT titulo, year, numActrices, numActores
FROM actores M INNER JOIN actrices F
ON M.numActores < F.numActrices AND M.titulo = F.pelicula; 

DROP VIEW actores;
DROP VIEW actrices;

