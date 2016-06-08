select distinct AE1.ciudad from vuelo V1, avion AV1, aeropuerto AE1
	where (V1.origen=AE1.id OR V1.destino=AE1.id) AND V1.numAvion=AV1.id
		AND AV1.tipo_aeronave='Rotorcraft'
MINUS
select distinct AE2.ciudad from vuelo V2, avion AV2, aeropuerto AE2
	where (V2.origen=AE2.id OR V2.destino=AE2.id) AND V2.numAvion=AV2.id
		AND AV2.tipo_aeronave!='Rotorcraft';
