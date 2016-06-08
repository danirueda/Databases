create view EC (estado,origen,destino) as
select distinct AE1.estado, CASE
			WHEN V.destino>V.origen THEN V.destino 
			WHEN V.destino<V.origen THEN V.origen
			END,
			CASE
			WHEN V.destino>V.origen THEN V.origen 
			WHEN V.destino<V.origen THEN V.destino
			END from aeropuerto AE1, aeropuerto AE2, vuelo V
where AE1.id=V.origen AND AE2.id=V.destino AND AE1.estado=AE2.estado;

create view ENC (estado,num) as
select estado "Estado", count(*) "numConexiones" from EC
group by estado;

create view EMaxC (estado,numMax) as
select estado, (count(id)*(count(id)-1))/2 from aeropuerto
group by estado;

select C1.estado "Estado",C1.num/C2.numMax "Ratio" from ENC C1, EMaxC C2
where C1.estado=C2.estado
order by C1.num/C2.numMax DESC;


drop view EMaxC;
drop view ENC;
drop view EC;
