create OR REPLACE trigger modifHora
BEFORE UPDATE OF horaPrevistaSalida,horaPrevistaLlegada ON vuelo
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR(-20001,'Campos no modificables');
end AjRetraso;
/
