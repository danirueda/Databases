create OR REPLACE trigger retEspec
BEFORE UPDATE OF retrasoAerolinea,retrasoSeguridad,retrasoMeteorologico ON retrasos
FOR EACH ROW 
BEGIN
	if (:NEW.retrasoAerolinea + :NEW.retrasoSeguridad + :NEW.retrasoMeteorologico) > :OLD.retrasoTotal
	THEN 
		RAISE_APPLICATION_ERROR(-20002,'La suma de los retrasos especificos no puede ser superior al retraso total');
	end if;
end AjRetraso;
/
