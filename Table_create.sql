Drop TABLE LOC;
Drop TABLE VEH;
Drop TABLE CAT;
DROP TABLE LOGINS;

CREATE TABLE LOGINS(login char(10),mot char(15));
  
CREATE TABLE CAT(
  ClassId char(1) Constraint PK_CAT PRIMARY KEY, 
  Prix number(5));

CREATE TABLE VEH(
  CarNum char(5) Constraint PK_VEH PRIMARY KEY, 
  ClassId char(1) Constraint COM_REF_CLASS REFERENCES CAT);

CREATE TABLE LOC(
  NumCom number(5) Constraint PK_LOC PRIMARY KEY, 
  CarNum char(5) Constraint COM_REF_VEH REFERENCES VEH,
  DATE_DEB date,
  DATE_FIN date);

insert into LOGINS values('TP','oracle');
insert into LOGINS values('a','a');
insert into LOGINS values('b','b');
insert into LOGINS values('c','c');
insert into LOGINS values('d','d');
insert into LOGINS values('d','d');
insert into LOGINS values('theo','123');

insert into CAT values ('A',100);
insert into CAT values ('B',500);
insert into CAT values ('C',300);
insert into CAT values ('D',1200);
insert into CAT values ('E',1000);

insert into VEH values ('10001','A');
insert into VEH values ('10002','A');
insert into VEH values ('10003','A');
insert into VEH values ('10004','B');
insert into VEH values ('10005','B');
insert into VEH values ('10006','C');
insert into VEH values ('10007','C');
insert into VEH values ('10008','D');
insert into VEH values ('10009','E');
insert into VEH values ('10010','E');


insert into LOC values (60001,'10002',to_date('2017-06-18','YYYY-MM-DD'),to_date('2017-06-20','YYYY-MM-DD'));
insert into LOC values (60002,'10007',to_date('2017-06-19','YYYY-MM-DD'),to_date('2017-06-22','YYYY-MM-DD'));
insert into LOC values (60003,'10003',to_date('2017-06-20','YYYY-MM-DD'),to_date('2017-06-26','YYYY-MM-DD'));
insert into LOC values (60004,'10009',to_date('2017-06-13','YYYY-MM-DD'),to_date('2017-06-20','YYYY-MM-DD'));
insert into LOC values (60005,'10005',to_date('2017-05-18','YYYY-MM-DD'),to_date('2017-06-20','YYYY-MM-DD'));
insert into LOC values (60006,'10001',to_date('2017-07-18','YYYY-MM-DD'),to_date('2017-07-27','YYYY-MM-DD'));
insert into LOC values (60007,'10004',to_date('2017-07-18','YYYY-MM-DD'),to_date('2017-08-20','YYYY-MM-DD'));
insert into LOC values (60008,'10008',to_date('2017-06-14','YYYY-MM-DD'),to_date('2017-06-17','YYYY-MM-DD'));
insert into LOC values (60009,'10010',to_date('2017-06-18','YYYY-MM-DD'),to_date('2017-06-20','YYYY-MM-DD'));
insert into LOC values (60010,'10009',to_date('2017-08-18','YYYY-MM-DD'),to_date('2017-08-29','YYYY-MM-DD'));
insert into LOC values (60012,'10002',to_date('2017-06-14','YYYY-MM-DD'),to_date('2017-06-29','YYYY-MM-DD'));
insert into LOC values (60013,'10007',to_date('2017-06-19','YYYY-MM-DD'),to_date('2017-06-21','YYYY-MM-DD'));
insert into LOC values (60014,'10003',to_date('2017-06-18','YYYY-MM-DD'),to_date('2017-06-23','YYYY-MM-DD'));
insert into LOC values (60015,'10009',to_date('2017-06-14','YYYY-MM-DD'),to_date('2017-06-21','YYYY-MM-DD'));
insert into LOC values (60016,'10005',to_date('2017-06-24','YYYY-MM-DD'),to_date('2017-06-27','YYYY-MM-DD'));

commit;







