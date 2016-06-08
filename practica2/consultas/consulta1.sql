CREATE VIEW vista_titulos(titulo,year,razon1) AS
SELECT distinct titulo, anioProduccion, 'Incluido en titulo'
FROM ESPECTACULO
WHERE UPPER(titulo) LIKE UPPER('%spain%') 	
ORDER BY anioProduccion;




-- Vista que contiene titulo y año de producción de todas las peliculas --
-- que tengan en al menos una de las personas relacionadas con la misma --
-- esta relacionada con una población cualquiera --
CREATE VIEW vista_actores(titulo,year,razon2) AS
SELECT DISTINCT titulo, anioProduccion,'Actor relacionado'
FROM ESPECTACULO E, PARTICIPAR X, PERSONA P, INFO_PERSONA I
WHERE (E.id=X.id_pelicula  AND X.id_persona = P.id 
	AND P.id = I.id AND UPPER(I.info) LIKE UPPER('%spain%'))
ORDER BY anioProduccion;





-- Vista que contiene titulo y año de producción de todas las peliculas --
-- que tengan en al menos en una de las palabras relacionadas con la misma --
-- una población cualquiera --
CREATE VIEW vista_keywords(titulo,year,razon3) AS
SELECT DISTINCT titulo, anioProduccion,'Palabra relacionada'
FROM ESPECTACULO E, PELICULAS_CLAVE P, KEYWORDS K
WHERE (E.id = P.id_pelicula AND P.id_palabraClave=K.id 
AND UPPER(K.keyword) LIKE UPPER('%spain%'))
ORDER BY anioProduccion;


-- Vista para juntar las vistas de actor relacionado y palabra relacionada --
CREATE VIEW parcial(titulo,year,razon2,razon3) AS
SELECT DISTINCT CASE
			WHEN K.titulo IS NOT NULL THEN K.titulo
			ELSE V.titulo END, 
		CASE 
			WHEN K.year IS NOT NULL THEN K.year
			ELSE V.year END, razon2, razon3
FROM vista_actores V FULL OUTER JOIN vista_keywords K 
-- FULL OUTER para coger todas las filas (comunes y no comunes) solapando columnas en caso de ser necesario
ON V.titulo = K.titulo; 


SELECT DISTINCT CASE
			WHEN T.titulo IS NOT NULL THEN T.titulo
			ELSE V.titulo END "Titulo", 
		CASE 
			WHEN T.year IS NOT NULL THEN T.year
			ELSE V.year END "Year", razon1 "R1", razon2 "R2", razon3 "R3"
FROM vista_titulos T FULL OUTER JOIN parcial V
ON T.titulo = V.titulo;






DROP VIEW parcial;
DROP VIEW vista_actores;
DROP VIEW vista_titulos;
DROP VIEW vista_keywords;
