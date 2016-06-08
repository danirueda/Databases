-- Vista con todas las peliculas con el número de remakes --
-- de cada una de ellas --
CREATE VIEW remakes AS
SELECT titulo, COUNT(I.tipo_relacion) AS remakes
FROM ESPECTACULO E, IDENTIFICAR I
WHERE E.id = I.peliculaOriginal AND I.tipo_relacion = 3
GROUP BY titulo;


-- Vista con todas las peliculas y de número de versiones --
-- de la speliculas incluidas en la vista --
CREATE VIEW versiones AS
SELECT titulo AS title, COUNT(I.tipo_relacion) AS versiones
FROM ESPECTACULO E, IDENTIFICAR I
WHERE E.id = I.peliculaOriginal AND I.tipo_relacion = 13
GROUP BY titulo;

-- Titulo, número de remakes y número de versiones --
-- de todas las peliculas que tienen el mismo número --
-- de remakes como de versiones --
SELECT titulo, remakes, versiones
FROM remakes FULL OUTER JOIN versiones
ON remakes.titulo = versiones.title;

DROP VIEW remakes;
DROP VIEW versiones;
