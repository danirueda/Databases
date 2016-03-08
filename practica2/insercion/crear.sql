/*CREACIÓN DE TABLAS*/
CREATE TABLE PERSONA (
id NUMBER(11) PRIMARY KEY,
nombre CHAR(40) NOT NULL,
genero CHAR(1)
);

CREATE TABLE INFO_PERSONA (
id NUMBER(11),
tipo_dato NUMBER(3) NOT NULL,
info CHAR(120),
FOREIGN KEY (id) REFERENCES PERSONA(id),
PRIMARY KEY (id,tipo_dato)
);

CREATE TABLE ESPECTACULO (
id NUMBER(11) PRIMARY KEY,
titulo CHAR(100) NOT NULL,
tipo NUMBER(1) NOT NULL,
anioProduccion CHAR(5),
anioEmision CHAR(10)
);

CREATE TABLE INFO_EPISODIOS (
id NUMBER(11),
FOREIGN KEY (id) REFERENCES ESPECTACULO(id),
PRIMARY KEY (id),
episodio_de NUMBER(11) NOT NULL,
temporada NUMBER(2),
episodio NUMBER(3)
);

CREATE TABLE IDENTIFICAR(
peliculaOriginal NUMBER(11) NOT NULL,
peliculaRelacionada NUMBER(11) NOT NULL,
tipo_relacion NUMBER(2) NOT NULL,
FOREIGN KEY (peliculaOriginal) REFERENCES ESPECTACULO(id),
FOREIGN KEY (peliculaRelacionada) REFERENCES ESPECTACULO(id),
PRIMARY KEY (peliculaOriginal,peliculaRelacionada,tipo_relacion)
);

CREATE TABLE KEYWORDS(
id NUMBER(11) PRIMARY KEY,
keyword CHAR(100) /*palabras clave*/
);

CREATE TABLE PELICULAS_CLAVE(
id_pelicula NUMBER(11),
id_palabraClave NUMBER(11),
FOREIGN KEY (id_pelicula) REFERENCES ESPECTACULO(id),
FOREIGN KEY (id_palabraClave) REFERENCES KEYWORDS(id)
);

CREATE TABLE PARTICIPAR(
id_persona NUMBER(11),
id_pelicula NUMBER(11),
rol NUMBER(2),
personaje CHAR(100),
FOREIGN KEY (id_persona) REFERENCES PERSONA(id),
FOREIGN KEY (id_pelicula) REFERENCES ESPECTACULO(id),
PRIMARY KEY (id_persona,id_pelicula,rol,personaje)
);