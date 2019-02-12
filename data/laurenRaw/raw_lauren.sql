set search_path to raw_lauren;

/************************************************************************
CREATE BLANK SYNTHEA SCHEMA
https://github.com/OHDSI/ETL-Synthea/blob/master/ETL/SQL/synthea_ddl.sql
https://github.com/synthetichealth/synthea/wiki/CSV-File-Data-Dictionary
************************************************************************/
drop table if exists allergies;
create table allergies (
start         date,
stop          date,
patient       varchar(1000),
encounter     varchar(1000),
code          varchar(100),
description   varchar(100)
);

drop table if exists careplans;
create table careplans (
id            varchar(1000),
start         date,
stop          date,
patient       varchar(1000),
encounter     varchar(1000),
code          varchar(100),
description   varchar(100),
reason_code   varchar(100),
reason_desc   varchar(100)
);

drop table if exists conditions;
create table conditions (
start         date,
stop          date,
patient       varchar(1000),
encounter     varchar(1000),
code          varchar(100),
description   varchar(100)
);

drop table if exists encounters;
create table encounters (
id            		varchar(1000),
start         		date,
stop				date,
patient       		varchar(1000),
provider			varchar(1000),
encounterclass		varchar(1000),
code          		varchar(100),
description   		varchar(100),
cost				numeric,
reasoncode   		varchar(100),
reasondescription 	varchar(100)
);

drop table if exists immunizations;
create table immunizations (
"date"        date,
patient       varchar(1000),
encounter     varchar(1000),
code          varchar(100),
description   varchar(100),
cost		  numeric
);

drop table if exists imaging_studies;
create table imaging_studies (
id			  			varchar(1000),
"date"        			date,
patient					varchar(1000),
encounter				varchar(1000),
bodysitecode			varchar(100),
bodysitedescription		varchar(100),
modalitycode			varchar(100),
modalitydescription		varchar(100),
SOPcode					varchar(100),
SOPdescription			varchar(100)
);

drop table if exists medications;
create table medications (
start         		date,
stop          		date,
patient       		varchar(1000),
encounter     		varchar(1000),
code          		varchar(100),
description  		varchar(1000),
cost				numeric,
dispenses			int,
totalcost			numeric,
reasoncode   		varchar(100),
reasondescription   varchar(100)
);

drop table if exists observations;
create table observations (
"date"        date,
patient       varchar(1000),
encounter     varchar(1000),
code          varchar(100),
description   varchar(100),
value     	  varchar(1000),
units         varchar(100),
type		  varchar(100)
);

drop table if exists organizations;
create table organizations (
id			  varchar(1000),
"name"	      varchar(1000),
address       varchar(1000),
city		  varchar(100),
state     	  varchar(100),
zip           varchar(100),
phone		  varchar(100),
utilization	  varchar(100)
);

drop table if exists patients;
create table patients (
id            varchar(1000),
birthdate     date,
deathdate     date,
ssn           varchar(100),
drivers       varchar(100),
passport      varchar(100),
prefix        varchar(100),
first         varchar(100),
last          varchar(100),
suffix        varchar(100),
maiden        varchar(100),
marital       varchar(100),
race          varchar(100),
ethnicity     varchar(100),
gender        varchar(100),
birthplace    varchar(100),
address       varchar(100),
city		  varchar(100),
state		  varchar(100),
zip			  varchar(100)
);

drop table if exists procedures;
create table procedures (
"date"        		date,
patient       		varchar(1000),
encounter     		varchar(1000),
code          		varchar(100),
description   		varchar(100),
cost		  		numeric,
reasoncode    		varchar(100),
reasondescription   varchar(100)
);

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA raw_lauren
TO etl;

/***************************************************************/
/*CLEAN OUT TABLES*/
/***************************************************************/
TRUNCATE TABLE raw_lauren.patients;
TRUNCATE TABLE raw_lauren.encounters;
TRUNCATE TABLE raw_lauren.procedures;
TRUNCATE TABLE raw_lauren.conditions;
TRUNCATE TABLE raw_lauren.observations;
TRUNCATE TABLE raw_lauren.medications;
TRUNCATE TABLE raw_lauren.allergies;
TRUNCATE TABLE raw_lauren.careplans;
TRUNCATE TABLE raw_lauren.imaging_studies;
TRUNCATE TABLE raw_lauren.immunizations;
TRUNCATE TABLE raw_lauren.organizations;

/***************************************************************
LAUREN INFORMATION
https://www.endometriosis-uk.org/laurens-story
****************************************************************/
INSERT INTO raw_lauren.patients (id,birthdate,deathdate,ssn,drivers,passport,prefix,first,last,suffix,maiden,marital,race,ethnicity,gender,birthplace,address,city,state,zip)
VALUES(1,'03/12/1982',NULL,'123-45-6789',NULL,NULL,'Ms.','Lauren','Smith',NULL,NULL,'M','white','engligh','F','London',NULL,NULL,NULL,NULL);

/***************************************************************
About 3 years ago I noticed my periods, which had also been 
painful, were getting increasingly more painful. I started 
becoming aware of a sharp jabbing pain right by my colon and 
feeling tender and bloated around my tailbone and lower pelvis 
area. My periods had become so painful that I was missing 1-2 
days of work a month. Painkillers sometimes dulled the pain, 
but usually they didn’t do much.
****************************************************************/
INSERT INTO raw_lauren.encounters (id,start,stop,patient,provider,encounterclass,code,description,cost,reasoncode,reasondescription)
VALUES (70,'2010/01/06','2010/01/06',1,'340f836c-8b1f-45e7-91f8-498de5fbb320','outpatient',185347001,'Encounter for problem','129.16',82423001,'Chronic pain');

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2010/01/06',NULL,1,70,194696,'Dysmenorrhea');

INSERT INTO raw_lauren.medications (start,stop,patient,encounter,code,description,cost,dispenses,totalcost,reasoncode,reasondescription)
VALUES('2010/01/06',NULL,1,70,313782,'Acetaminophen 325 MG Oral Tablet','6.62','1','6.62',82423001,'Chronic pain');

/***/

INSERT INTO raw_lauren.encounters (id,start,stop,patient,provider,encounterclass,code,description,cost,reasoncode,reasondescription)
VALUES (80,'2011/01/06','2011/01/06',1,'340f836c-8b1f-45e7-91f8-498de5fbb320','outpatient',185347001,'Encounter for problem','129.16',82423001,'Chronic pain');

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2011/01/06',NULL,1,80,194696,'Dysmenorrhea');

INSERT INTO raw_lauren.medications (start,stop,patient,encounter,code,description,cost,dispenses,totalcost,reasoncode,reasondescription)
VALUES('2011/01/06',NULL,1,80,313782,'Acetaminophen 325 MG Oral Tablet','6.62','1','6.62',82423001,'Chronic pain');

/***/

INSERT INTO raw_lauren.encounters (id,start,stop,patient,provider,encounterclass,code,description,cost,reasoncode,reasondescription)
VALUES (90,'2012/01/06','2012/01/06',1,'340f836c-8b1f-45e7-91f8-498de5fbb320','outpatient',185347001,'Encounter for problem','129.16',82423001,'Chronic pain');

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2012/01/06',NULL,1,90,194696,'Dysmenorrhea');

INSERT INTO raw_lauren.medications (start,stop,patient,encounter,code,description,cost,dispenses,totalcost,reasoncode,reasondescription)
VALUES('2012/01/06',NULL,1,90,313782,'Acetaminophen 325 MG Oral Tablet','6.62','1','6.62',82423001,'Chronic pain');

/***************************************************************
I had been in to see my GP about possibly having a cyst because 
I had felt a lump in my pelvis below my hip bone. My GP wasn’t 
convinced and said she said she couldn’t feel anything on a 
pelvic exam.
****************************************************************/
INSERT INTO raw_lauren.encounters (id,start,stop,patient,provider,encounterclass,code,description,cost,reasoncode,reasondescription)
VALUES (100,'2013/01/07','2013/01/07',1,'340f836c-8b1f-45e7-91f8-498de5fbb320','outpatient',185347001,'Encounter for problem','129.16',82423001,'Chronic pain');

INSERT INTO raw_lauren.procedures(date,patient,encounter,code,description,cost,reasoncode,reasondescription)
VALUES('2013/01/07',1,100,35025007,'Manual pelvic examination','516.65',NULL, NULL);

/***************************************************************
I finally convinced her to let me get an ultrasound just to make 
sure. The ultrasound showed a 4x5 cm cyst by my left ovary. My 
GP scheduled me for a scan in four weeks’ time.
****************************************************************/
INSERT INTO raw_lauren.encounters (id,start,stop,patient,provider,encounterclass,code,description,cost,reasoncode,reasondescription)
VALUES (101,'2013/01/14','2013/01/14',1,'2a27a4ea-0c36-427f-b360-a4537d42475c','ambulatory',371883000,'Outpatient procedure','129.16',NULL,NULL);

INSERT INTO raw_lauren.procedures(date,patient,encounter,code,description,cost,reasoncode,reasondescription)
VALUES('2013/01/14',1,101,304435002,'Ultrasound treatment to pelvis','516.65',NULL, NULL);

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2013/01/14',NULL,1,101,12238591000119108,'Cyst of left ovary');

/***************************************************************
However, before I had my scan, I awoke one morning in severe pain. 
My husband called 999, but despite the obvious pain I was in, the 
medics still seemed unconvinced. I was eventually taken to hospital 
where I developed a very high fever and a very bloated stomach. 
****************************************************************/
INSERT INTO raw_lauren.encounters (id,start,stop,patient,provider,encounterclass,code,description,cost,reasoncode,reasondescription)
VALUES (102,'2013/01/17','2013/01/24',1,'df04de94-b6d1-4704-8837-71be7337a336','inpatient',32485007,'Hospital admission','129.16',NULL,NULL);

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2013/01/17',NULL,1,102,237067000,'Chronic pelvic pain of female');

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2013/01/18',NULL,1,102,386661006,'Fever');

INSERT INTO raw_lauren.observations(date,patient,encounter,code,description,value,units,type)
VALUES('2013/01/18',1,102,'8331-1','Oral temperature','39.4','Cel','numeric');

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2013/01/18',NULL,1,102,271835004,'Abdominal distension, gaseous');

/***************************************************************
However, I still waited for three days before eventually being 
given a scan, which showed an alarming amount of fluid in my 
abdomen. I was quickly rushed into surgery.
****************************************************************/
INSERT INTO raw_lauren.procedures(date,patient,encounter,code,description,cost,reasoncode,reasondescription)
VALUES('2013/01/21',1,102,418332004,'CT of neck, thorax, abdomen and pelvis','516.65',NULL, NULL);

INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2013/01/21',NULL,1,102,389026000,'Ascites');

INSERT INTO raw_lauren.procedures(date,patient,encounter,code,description,cost,reasoncode,reasondescription)
VALUES('2013/01/21',1,102,107784002,'Surgical procedure on lower extremity','516.65',NULL, NULL);

/***************************************************************
Post-surgery I was told I did have endometriosis and that an 
endometrioma had ruptured in my left ovary and had attracted a 
fluid to it. This fluid had become infected and was causing my 
high fever and pain.
****************************************************************/
INSERT INTO raw_lauren.conditions(start,stop,patient,encounter,code,description)
VALUES('2013/01/21',NULL,1,102,129103003,'Endometriosis');

INSERT INTO raw_lauren.procedures(date,patient,encounter,code,description,cost,reasoncode,reasondescription)
VALUES('2013/01/21',1,102,4270918,'Destruction of intra-abdominal endometriomas','516.65',NULL, NULL);
