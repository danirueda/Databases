create view VC (id,numAvion,origen, destino) as 
select id,numAvion, CASE WHEN origen>destino THEN origen
			WHEN origen<destino THEN destino
			END,CASE
			WHEN origen>destino THEN destino
			WHEN origen<destino THEN origen END
			from vuelo
where numAvion is not NULL;
select AV.modelo,V2.numAvion,V2.origen,V2.destino,V2.numVuelos 
from (select V1.numAvion,max(V1.origen) as origen ,max(V1.destino) as destino,count(*) AS numVuelos 						from VC V1
					group by V1.numAvion
					having count(distinct origen)=1 
						AND count(distinct destino)=1) V2,avion AV
where AV.id=V2.numAvion
order by AV.modelo;
drop view VC;
