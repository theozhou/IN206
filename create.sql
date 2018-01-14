drop table loc;
drop table veh;
drop table cat;
drop table logins;

create table cat(
	ClassId char(5) constraint PK_Cla primary key,
	prix number(4));

create table veh(
	CarNum char(5) constraint PK_Car primary key,
	ClassId char(5) constraint VEH_REF_CLA references cat);

create table loc(
	NumCom number(5) constraint COM_PK primary key,
	CarNum char(5) constraint LOC_REF_CAR references veh, --ON DELETE CASCADE,
	timeBeg date,
	timeEnd date);

create table LOGINS(login char(10),mot char(15));

insert into LOGINS values('a','a');
insert into LOGINS values('b','b');
insert into LOGINS values('c','c');
insert into LOGINS values('d','d');
insert into LOGINS values('d','d');
insert into LOGINS values('TP','oracle');
insert into LOGINS values('theo','123');

insert into cat values('A',100);
insert into cat values('B',300);
insert into cat values('C',200);
insert into cat values('D',400);
insert into cat values('E',500);

insert into veh values('1','A');
insert into veh values('2','A');
insert into veh values('3','A');
insert into veh values('4','B');
insert into veh values('5','B');
insert into veh values('6','B');
insert into veh values('7','C');
insert into veh values('8','C');
insert into veh values('9','C');
insert into veh values('10','D');
insert into veh values('11','D');
insert into veh values('12','D');
insert into veh values('13','E');
insert into veh values('14','E');
insert into veh values('15','E');

insert into loc values(1,'1','12-jan-2018','15-jan-2018');
insert into loc values(2,'1','12-jan-2018','15-jan-2018');
insert into loc values(3,'2','12-jan-2018','15-jan-2018');
insert into loc values(4,'2','16-jan-2018','17-jan-2018');
insert into loc values(5,'3','12-jan-2018','15-jan-2018');
insert into loc values(6,'4','12-jan-2018','15-jan-2018');
insert into loc values(7,'5','12-jan-2018','15-jan-2018');
insert into loc values(8,'6','12-jan-2018','15-jan-2018');
insert into loc values(9,'7','12-jan-2018','15-jan-2018');
insert into loc values(10,'13','12-jan-2018','15-jan-2018');
insert into loc values(11,'14','12-jan-2018','15-jan-2018');
commit;

