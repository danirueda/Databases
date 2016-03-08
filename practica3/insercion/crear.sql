/*CREACIÓN DE TABLAS*/

CREATE TABLE AVION(
id CHAR(7) PRIMARY KEY,
fabricante CHAR(30),
modelo CHAR(20),
tipo_aeronave CHAR(25),
tipo_motor CHAR(15),
anio NUMBER(4)
);

CREATE TABLE AEROLINEA(
id CHAR(7) PRIMARY KEY,
nombre CHAR(100)
);

CREATE TABLE AEROPUERTO(
id CHAR(4) PRIMARY KEY,
nombre CHAR(45),
ciudad CHAR(35),
estado CHAR(2)
);

CREATE TABLE VUELO(
id NUMBER(5) PRIMARY KEY,
fecha CHAR(11) NOT NULL,
aerolinea CHAR(7) NOT NULL,
numVuelo NUMBER(4) NOT NULL,
origen CHAR(4) NOT NULL,
destino CHAR(4) NOT NULL,
numAvion CHAR(7),
horaPrevistaSalida CHAR(4),
horaPrevistaLlegada CHAR(4),
distancia NUMBER(4),
cancelado NUMBER(1) NOT NULL,
horaSalida CHAR(4),
horaLlegada CHAR(4),
FOREIGN KEY (aerolinea) REFERENCES AEROLINEA(id),
FOREIGN KEY (numAvion) REFERENCES AVION(id),
FOREIGN KEY (origen) REFERENCES AEROPUERTO(id),
FOREIGN KEY (destino) REFERENCES AEROPUERTO(id)
);

CREATE TABLE RETRASOS(
id NUMBER(5),
retrasoAerolinea NUMBER(4),
retrasoSeguridad NUMBER(4),
retrasoMeteorologico NUMBER(4),
retrasoTotal NUMBER(4),
FOREIGN KEY (id) REFERENCES VUELO(id),
PRIMARY KEY (id)
);

CREATE TABLE DESVIOS(
id NUMBER(5),
numDesvio NUMBER(1),
idAeropuerto CHAR(4) NOT NULL,
numAvion CHAR(7),
FOREIGN KEY (id) REFERENCES VUELO(id),
PRIMARY KEY (id,numDesvio)
);