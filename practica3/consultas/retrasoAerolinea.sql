create view RA (aerolinea,retraso) as
select V.aerolinea,sum(R.retrasoAerolinea) from vuelo V,retrasos R
where V.id=R.id 
group by V.aerolinea;


select retAer.aerolinea,retAer.retraso/VA.numVuelos "RETRASO MEDIO" 
from RA retAer,(select V.aerolinea,count(*) AS numVuelos from vuelo V
		group by V.aerolinea) VA
where retAer.aerolinea=VA.aerolinea
order by retAer.retraso/VA.numVuelos;

drop view RA;
