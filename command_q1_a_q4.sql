select * from CAT order by prix; --Q1

select * from LOC,VEH where LOC.CarNum=VEH.CarNum AND (VEH.ClassId='E') order by LOC.DATE_DEB;--Q2

select * from VEH where CarNum NOT IN (SELECT CarNum FROM LOC);--Q3

select ClassId,COUNT(ClassId) AS Nombre from VEH,LOC WHERE LOC.CarNum=VEH.CarNum GROUP BY ClassId Order by Nombre desc;--Q4


