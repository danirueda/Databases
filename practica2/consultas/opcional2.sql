-- Numero de peliculas por año de producción --
CREATE VIEW numPeliculas AS 
SELECT DISTINCT anioProduccion, COUNT(DISTINCT titulo) AS numPeliculas
FROM ESPECTACULO
GROUP BY anioProduccion;

-- Numero medio de peliculas por año entre dos fechas dadas --
SELECT TRUNC(AVG(numPeliculas),0) AS media_peliculas
FROM numPeliculas N
WHERE N.anioProduccion > 1979 AND anioProduccion < 2000;

DROP VIEW numPeliculas;
