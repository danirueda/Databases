create view VR (id, origen, destinoFinal,fecha, horaSalida, horaLlegada) as 
select V1.id,V1.origen,V1.destino,V1.fecha,
	V1.horaSalida,V1.horaLlegada from vuelo V1,(select V2.id AS id from vuelo V2
					where V2.cancelado=0
					MINUS
					select D.id AS id from desvios D) Exitos
where Exitos.id=V1.id
UNION
select V1.id,V1.origen,D.idAeropuerto,V1.fecha,
	V1.horaSalida,V1.horaLlegada from vuelo V1,desvios D
where V1.id=D.id AND D.numDesvio=(select max(D2.numDesvio) from desvios D2
					where D2.id=D.id);

select V1.origen,V1.destinoFinal "DESTINO",count(*) "CRUCES "from VR V1,VR V2 
where V1.origen=V2.destinoFinal AND V1.destinoFinal=V2.origen AND 		V1.fecha=V2.fecha AND ((V1.horaSalida BETWEEN V2.horaSalida AND 	V2.horaLlegada) OR (V2.horaSalida BETWEEN V1.horaSalida AND 		V1.horaLlegada))
group by V1.origen,V1.destinoFinal
having V1.origen>V1.destinoFinal AND count(*)=(select max(count(*)) from VR V3,VR V4 
where   V3.origen=V4.destinoFinal AND V3.destinoFinal=V4.origen AND 		V3.fecha=V4.fecha AND ((V3.horaSalida BETWEEN V4.horaSalida AND 	V4.horaLlegada) OR (V4.horaSalida BETWEEN V3.horaSalida AND 		V3.horaLlegada))
	group by V3.origen,V3.destinoFinal);

drop view VR;
