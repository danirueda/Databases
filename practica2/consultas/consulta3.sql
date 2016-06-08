CREATE VIEW vida_actores(id,primeraPeli,numPeliculas) AS
SELECT id_persona, MIN(anioProduccion) , COUNT(DISTINCT P.id_pelicula)
FROM PARTICIPAR P, ESPECTACULO E
WHERE E.id = P.id_pelicula AND (rol = 1 OR rol = 2)
GROUP BY id_persona; 


CREATE VIEW vida_directores(id_dir,primeraPeli,numPeliculas) AS
SELECT id_persona, MIN(anioProduccion) , COUNT(DISTINCT P.id_pelicula)
FROM PARTICIPAR P, ESPECTACULO E
WHERE E.id = P.id_pelicula AND rol = 3
GROUP BY id_persona; 


SELECT id
FROM vida_actores A INNER JOIN vida_directores B
ON A.id = B.id_dir
WHERE (A.numPeliculas > B.numPeliculas) OR
	(A.numPEliculas = B.numPeliculas
	AND A.primeraPeli < B.primeraPeli);

DROP VIEW vida_actores;
DROP VIEW vida_directores;

