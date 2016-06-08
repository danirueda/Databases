CREATE OR REPLACE TRIGGER ConsistenciaCapitulos
AFTER INSERT OR UPDATE ON INFO_EPISODIOS
FOR EACH ROW
DECLARE
 episodio tpNatural, temporada tpNatural, serie tpNatural;
 CURSOR cursorCapitulos IS SELECT id, episodio_De, temporada FROM INFO_EPISODIOS;
BEGIN
OPEN cursorCapitulos;
 LOOP
 FETCH cursorCapitulos INTO serie, episodio, temporada;
 EXIT WHEN cursorCapitulos%NOTFOUND;
  IF (NEW.episodio = episodio) AND (NEW.id = serie) AND (NEW.temporada = temporada) THEN
   RAISE_APPLICATION_ERROR (-20000, 'El capitulo y temporada ya estan introducidos para la serie = ' || serie);
  END IF;
 END LOOP;
CLOSE cursorCapitulos;
END;
