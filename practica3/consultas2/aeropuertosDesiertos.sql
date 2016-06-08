create view EAD (id) AS
select AE.id from aeropuerto AE
MINUS
select distinct V1.origen from vuelo V1
MINUS 
select distinct V2.destino from vuelo V2;


select AE1.estado,count(*) "AEROPUERTOS DESIERTOS" from EAD V1,aeropuerto AE1
where V1.id=AE1.id
group by AE1.estado
having count(*)=(select max(count(*)) from EAD V2,aeropuerto AE2
		where V2.id=AE2.id group by AE2.estado);

drop view EAD;
