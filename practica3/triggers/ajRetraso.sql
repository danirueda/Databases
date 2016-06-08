create OR REPLACE trigger AjRetraso
AFTER UPDATE OF horaSalida ON vuelo
FOR EACH ROW
DECLARE 
incremento NUMBER;
BEGIN
	if :NEW.horaSalida>:OLD.horaSalida
	THEN
		incremento:=((trunc(:NEW.horaSalida/100))*60 + MOD(:NEW.horaSalida,100)) -((trunc(:NEW.horaPrevistaSalida/100))*60 + MOD(:NEW.horaPrevistaSalida,100));

		if :OLD.horaSalida=:OLD.horaPrevistaSalida
		THEN
			INSERT INTO RETRASOS VALUES (:OLD.id,0,0,0,incremento);
		else
			UPDATE RETRASOS SET retrasoTotal=incremento where id=:OLD.id;
		end if;
	end if;
end AjRetraso;
/
update vuelo set horaSalida='1930' where id=48983;


