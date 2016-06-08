ALTER TABLE ESPECTACULO
ADD num_keywords NUMBER(50) NOT NULL DEFAULT 0;

CREATE OR REPLACE TRIGGER numeroPalabrasClave
		AFTER INSERT OR UPDATE ON PELICULAS_CLAVE
		FOR EACH ROW
		BEGIN
			FOR key IN (SELECT COUNT(*) AS num_keys, id_pelicula
						FROM PELICULAS_CLAVE P
						INNER JOIN(
							SELECT E.id
							FROM ESPECTACULO E
							WHERE E.id = P.id_pelicula) join
						ON join.id = P.id_pelicula)
			LOOP
				UPDATE ESPECTACULO SET num_keywords = (key.num_keys) WHERE (id=P.id_pelicula)
			END LOOP
		END;
