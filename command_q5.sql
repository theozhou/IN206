DROP TABLE RESULTAT;
CREATE TABLE RESULTAT (NumCom number(5), CarNum char(5),DATE_DEB DATE,DATE_FIN DATE);
DELETE FROM RESULTAT ;
SET SERVEROUTPUT ON;
SET FEEDBACK OFF;
PROMPT Vehicul pour verifier:
ACCEPT car char

DECLARE
	i NUMBER := 0;
	indicator number:=0;
BEGIN
  FOR tuple1 in (
    SELECT * FROM LOC WHERE CarNum IN(SELECT CarNum FROM LOC GROUP BY CarNum HAVING COUNT(CarNum)>1) 
    ORDER BY CarNum) LOOP
      FOR tuple2 in (
    	SELECT * FROM LOC WHERE CarNum IN(SELECT CarNum FROM LOC GROUP BY CarNum HAVING COUNT(CarNum)>1) 
        ORDER BY CarNum) LOOP      
	  iF tuple2.CarNum = tuple1.CarNum THEN
	    if tuple2.NumCom!=tuple1.NumCom then
		if ((tuple2.date_fin - tuple1.date_deb) * (tuple2.date_deb - tuple1.date_fin) <= 0) then
		  --overlap
		  indicator:=indicator+1;
		  INSERT iNTO RESULTAT
		    VALUES(tuple1.NumCom, tuple1.CarNum,tuple1.date_deb,tuple1.date_fin);
		  INSERT iNTO RESULTAT
		    VALUES(tuple2.NumCom, tuple2.CarNum,tuple2.date_deb,tuple2.date_fin);
		end if;
	    end if;
	  --else
	    --exit;	
	  end if;
 	end loop;
  END LOOP;
  if indicator>0 then
    dbms_output.put_line('*****Il y a des vehicule loue deux a la meme periode*****');
  else
    dbms_output.put_line('*******Pas de vehicule loue deux a la meme periode*******');
  end if;
END;
/
SET FEEDBACK ON;
SELECT distinct * FROM resultat where resultat.carnum=&car order by CarNum; --vérifier si un véhicule donné sois loué deux fois à la même periode.

--PROMPT Vehicule loue deux fois a la meme periode ci dessus:
--SELECT distinct * FROM resultat order by CarNum; --list tous les vehicule qui est loué deux fois à la même periode.
