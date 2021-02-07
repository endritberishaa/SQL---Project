CREATE DATABASE Spitali
USE Spitali

Create table Punonjesi (
    Punonjesi_ID int,
    Emri varchar(25) not null,  
    Mbiemri varchar(25) not null,
    Numri_Kontakt varchar(25) UNIQUE,
    Primary key(Punonjesi_ID)
)

Create table Recepsionisti (
    Recepsionisti_ID int,
    Emri varchar(20) not null,
    Mbiemri varchar(20) not null,
    Primary key (Recepsionisti_ID),
    Foreign Key(Recepsionisti_ID) REFERENCES Punonjesi(Punonjesi_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

create table Doktori (
    Doktori_ID int,
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Data_Lindjes date,
    Primary key(Doktori_ID),
    Foreign Key(Doktori_ID) REFERENCES Punonjesi(Punonjesi_ID) ON DELETE CASCADE ON UPDATE CASCADE,
)

CREATE table Vizitori(
    ID int primary key,
    FOREIGN Key (ID) REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
)


Create Table Rekruti(
    ID int primary key,
    FOREIGN Key (ID) REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    

)

Create table Infermieri (
    Infermieri_ID int,
    Doktori_ID int not null REFERENCES Doktori(Doktori_ID),
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Data_Lindjes date,
    Primary key(Infermieri_ID),
    Foreign Key(Infermieri_ID) REFERENCES Punonjesi(Punonjesi_ID) ON DELETE CASCADE ON UPDATE CASCADE,

)

Create table Specializimi_Doktorit ( 

    Doktori_ID int NOT NULL REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Specializimi varchar(50) not null,
)

Create table Kualifikimi_Doktorit (
    
    Doktori_ID int NOT NULL REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Kualifikimi varchar(50) not null,
)

Create table Specializimi_Infermierit(
    Infermieri_ID int NOT NULL REFERENCES Infermieri(Infermieri_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Specializimi varchar(50) not null,
)

Create table Pacienti(
    Pacienti_ID int,
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Sigurimi varchar(255),
    Data_Lindjes date,
    Numri_Tel varchar(30) not null unique,
    Qyteti varchar(30),
    Rruga varchar(30),
    Primary key(Pacienti_ID)

 )
 

 create table regjistron(
     Pacienti_ID int, 
     Recepsionisti_ID int,
     PRIMARY Key(Pacienti_ID),
     Foreign KEY(Pacienti_ID) References Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
     Foreign KEY(Recepsionisti_ID) References Recepsionisti(Recepsionisti_ID) ON DELETE CASCADE ON UPDATE CASCADE
     
)

 create table KompaniaSigurimit(
     ID int IDENTITY(1000, 1),
     Emri varchar(255),
     Pacienti_ID int ,
     Qyteti VARCHAR(255),
     Rruga VARCHAR(255),
     primary key(ID),
     Foreign Key(Pacienti_ID) REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE
 )


 create table NrTelefonitKompaniaSigurimit(
     Emri varchar(255),
     Nr_Telefonit VARCHAR(255) not null UNIQUE,
 )

 create table Trajtimi (
     ID_Trajtimit int IDENTITY(200, 1),
     Pacienti_ID int references Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
     Emri_Trajtimit varchar(50) not null,
     PRIMARY Key(ID_Trajtimit),
     
 )

 create table Fatura (
     
     Numri_Fiskal int not null primary key, 
     Pacienti_ID int not null references Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
     ID_Trajtimit int REFERENCES Trajtimi(ID_Trajtimit),
     Koha time not null,
     Shuma int check(Shuma >= 0),
     
 )

 Create table KontaktiEmergjent(
    Kontakti_ID int not null,
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Primary key(Kontakti_ID),

)   



Create table NrTelefonitKontaktiEmergjent (
    Kontakti_ID int REFERENCES KontaktiEmergjent(Kontakti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Nr_Telefonit varchar(255) unique
)
 Create table Dhoma (
    Nr_Dhomes int identity(2000, 1 )not null,
    Tipi_Dhomes varchar(10) not null unique,
    Kati int not null check(Kati between -1 and 4),
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Infermieri_ID int REFERENCES Infermieri(Infermieri_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Primary key(Nr_Dhomes)
)
Create table Termini(
    ID int IDENTITY(6000,1),
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Recepsionisti_ID int REFERENCES Recepsionisti(Recepsionisti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Data date,
    Ora time not null,
    Primary key(ID)
)

Create Table TeDhenatMjeksore (
    ID int identity(4000, 1),
    Ilaqi varchar(50),
    Diagnoza varchar(50) not null,
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Primary key(ID)
)


Create Table Trajtohet(
    Pacienti_ID int,
    Doktori_ID int,
    Infermieri_ID int, 
    ID_TeDhenatMjeksore int, 
    Foreign Key(Pacienti_ID) REFERENCES Pacienti(Pacienti_ID) ON DELETE NO ACTION,
    Foreign Key(Infermieri_ID) REFERENCES Infermieri(Infermieri_ID) ON DELETE NO ACTION,
    Foreign Key(Doktori_ID) REFERENCES Doktori(Doktori_ID) ON DELETE  NO ACTION,
    Foreign Key(ID_TeDhenatMjeksore) REFERENCES TeDhenatMjeksore(ID) ON DELETE  NO ACTION,
    Unique(Pacienti_ID, Doktori_ID, Infermieri_ID)

)

/*Execute this for droping all tables
DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FAST_FORWARD FOR
SELECT DISTINCT sql = 'ALTER TABLE [' + tc2.TABLE_SCHEMA + '].[' +  tc2.TABLE_NAME + '] DROP [' + rc1.CONSTRAINT_NAME + '];'
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

WHILE (@@FETCH_STATUS = 0)
BEGIN
Exec sp_executesql @Sql
FETCH NEXT FROM @Cursor INTO @Sql
END

CLOSE @Cursor DEALLOCATE @Cursor
GO

EXEC sp_MSforeachtable 'DROP TABLE ?'
GO*/




Insert into Punonjesi values(1331, 'Dren', 'Gara', '049-651-987')
Insert into Punonjesi values(1332, 'Aulon', 'Baftiu', '049-755-114')
Insert into Punonjesi values(1334, 'Bledar', 'Gashi', '049-651-988')
Insert into Punonjesi values(1336, 'Lorik', 'Zuka', '044-111-114')
Insert into Punonjesi values(1339, 'Blerina', 'Thaqi', '049-651-981')
Insert into Punonjesi values(1340, 'Festa', 'Qoqaj', '044-112-134')
Insert into Punonjesi values(1333,'Dorant','Dushi','044-568-201')
Insert into Punonjesi values(1341,'Denis','Dushi','044-111-111')
Insert into Punonjesi values(1342,'Diana','Dushi','044-111-112')
Insert into Punonjesi values(1343,'Dion','Kuka','044-111-113')
Insert into Punonjesi values(1344,'Dion','Rexhepi','044-111-204')
Insert into Punonjesi values(1345,'Lek','Demjaha','044-111-115')
Insert into Punonjesi values(1346,'Eliot','Karjagdiu','044-111-116')
Insert into Punonjesi values(1347,'Morin','Morina','044-111-117')
Insert into Punonjesi values(1348,'Jon','Millaku','044-111-118')
Insert into Punonjesi values(1349,'Anda','Hoxha','044-111-119')
Insert into Punonjesi values(1350,'Gent','Krasniqi','044-111-120')
Insert into Punonjesi values(1351,'Edi','Krasniqi','044-111-121')
Insert into Punonjesi values(1352,'Kaltrin','Shala','044-111-122')
Insert into Punonjesi values(1353,'Ares','Jakupi','044-111-123')
Insert into Punonjesi values(1354,'Arita','Berisha','044-111-125')
Insert into Punonjesi values(1355,'Bardh','Zajmi','044-111-126')
Insert into Punonjesi values(1356,'Blend','Rrustemi','044-111-127')
Insert into Punonjesi values(1357,'Blendi','Rexhaj','044-111-128')
Insert into Punonjesi values(1358,'Blendian','Osdatuaj','044-111-229')
Insert into Punonjesi values(1359,'Diar','Ibiqi','044-111-230')
Insert into Punonjesi values(1360,'Dion','Kajdomqaj','044-111-231')
Insert into Punonjesi values(1361,'Diell','Kryeziu','044-111-232')
Insert into Punonjesi values(1362,'Dren','Demaku','044-111-233')
Insert into Punonjesi values(1363,'Dren','Maxhera','044-111-234')
Insert into Punonjesi values(1364,'Drin','Ismajili','044-111-235')
Insert into Punonjesi values(1365,'Endrit','Tahiri','044-111-236')
Insert into Punonjesi values(1366,'Endrit','Berisha','044-111-237')
Insert into Punonjesi values(1367,'Lek','Duli','044-111-238')
Insert into Punonjesi values(1368,'Lek','Shehu','044-111-239')
Insert into Punonjesi values(1380,'Blend','Berisha','044-758-152')
Insert into Punonjesi values(1381,'Astrit','Kabashi','049-111-311')




Insert into Recepsionisti values(1358,'Blendian','Osdautaj')
Insert into Recepsionisti values(1357,'Blendi','Rexhaj')
Insert into Recepsionisti values(1356,'Blendi','Rrustemi')
Insert into Recepsionisti values(1355,'Bardh','Zajmi')
Insert into Recepsionisti values(1354,'Arita','Berisha')
Insert into Recepsionisti values(1353,'Ares','Jakupi')
Insert into Recepsionisti values(1352,'Kaltrin','Shala')
Insert into Recepsionisti values(1351,'Edi','Krasniqi')
Insert into Recepsionisti values(1350,'Genti','Krasniqi')
Insert into Recepsionisti values(1349,'Anda','Hoxha')



Insert into Doktori values(1333,'Dorant','Dushi','2000-10-10')
Insert into Doktori values(1341,'Denis','Dushi','2003-03-14')
Insert into Doktori values(1342,'Diana','Dushi','1999-05-16')
Insert into Doktori values(1343,'Dion','Kuka','2000-10-02')
Insert into Doktori values(1344,'Dion','Rexhepi','2001-06-03')
Insert into Doktori values(1345,'Lek','Demjaha','2001-02-02')
Insert into Doktori values(1346,'Elio','Karjagdiu','2000-09-10')
Insert into Doktori values(1347,'Morin','Morina','1997-10-10')
Insert into Doktori values(1348,'Jon','Millaku','2003-12-01')
Insert into Doktori values(1340,'Festa','Qoqaj','2000-01-10')
Insert into Doktori values(1380,'Blend','Berisha','2000-12-01')
Insert into Doktori values(1381,'Astrit','Kabashi','2000-01-10')



Insert into Vizitori values (1333)
Insert into Vizitori values (1341)
Insert into Vizitori values (1342)
Insert into Vizitori values(1343)


Insert into Rekruti values(1340)
Insert into Rekruti values(1347)
Insert into Rekruti values(1348)
Insert into Rekruti values(1381)


Insert into Infermieri values(1359,1344,'Diar','Ibiqi','2000-01-01')
Insert into Infermieri values(1360,1344,'Dion','Kajdomqaj','2000-01-02')
Insert into Infermieri values(1361,1344,'Diell','Kryeziu','2001-03-01')
Insert into Infermieri values(1362,1345,'Dren','Demaku','2005-02-05')
Insert into Infermieri values(1363,1345,'Dren','Maxhera','2000-01-10')
Insert into Infermieri values(1364,1345,'Drin','Ismajili','2000-10-11')
Insert into Infermieri values(1365,1380,'Endrit','Tahiri','2004-02-06')
Insert into Infermieri values(1366,1380,'Endrit','Berisha','2001-09-03')
Insert into Infermieri values(1367,1381,'Lek','Duli','2004-09-09')
Insert into Infermieri values(1368,1381,'Lek','Shehu','2002-10-10')



Insert into  Specializimi_Doktorit values(1333,'Pediater')
Insert into  Specializimi_Doktorit values(1341,'Ortolog')
Insert into  Specializimi_Doktorit values(1342,'Ortolog')
Insert into  Specializimi_Doktorit values(1343,'Stomatolog')
Insert into  Specializimi_Doktorit values(1344,'Plumollogu')
Insert into  Specializimi_Doktorit values(1345,'Kirurg')
Insert into  Specializimi_Doktorit values(1346,'Gjinekolog')
Insert into  Specializimi_Doktorit values(1347,'Oftomologu')
Insert into  Specializimi_Doktorit values(1348,'Ortopet')
Insert into  Specializimi_Doktorit values(1340,'Nefrolog')
Insert into  Specializimi_Doktorit values(1380,'Nefrolog')
Insert into  Specializimi_Doktorit values(1381,'Stomatolog')

Insert into Kualifikimi_Doktorit values(1333,'Degree')
Insert into Kualifikimi_Doktorit values(1341,'Degree')
Insert into Kualifikimi_Doktorit values(1342,'Degree')
Insert into Kualifikimi_Doktorit values(1343,'Degree')
Insert into Kualifikimi_Doktorit values(1344,'Diploma')
Insert into Kualifikimi_Doktorit values(1345,'Diploma')
Insert into Kualifikimi_Doktorit values(1346,'Degree')
Insert into Kualifikimi_Doktorit values(1347,'Diploma')
Insert into Kualifikimi_Doktorit values(1348,'Diploma')
Insert into Kualifikimi_Doktorit values(1340,'Degree')
Insert into Kualifikimi_Doktorit values(1380,'Diploma')
Insert into Kualifikimi_Doktorit values(1381,'Degree')

Insert into Specializimi_Infermierit values(1359,'Pediater')
Insert into Specializimi_Infermierit values(1360,'Pediater')
Insert into Specializimi_Infermierit values(1361,'Ortolog')
Insert into Specializimi_Infermierit values(1362,'Ortolog')
Insert into Specializimi_Infermierit values(1363,'Ortolog')
Insert into Specializimi_Infermierit values(1364,'Gjinekolog')
Insert into Specializimi_Infermierit values(1365,'Gjinekolog')
Insert into Specializimi_Infermierit values(1366,'Gjinekolog')
Insert into Specializimi_Infermierit values(1367,'Stomatolog')
Insert into Specializimi_Infermierit values(1368,'Stomatolog')

Insert into Pacienti values(1,'Reshat','Llapjani','66','1990-02-01','044-111-222','Prishtine','A1')
Insert into Pacienti values(2,'Albert','Mustafa','60','1994-04-05','044-121-222','Prishtine','A1')
Insert into Pacienti values(3,'Petrit','Zeneli','60','1992-07-03','044-141-222','Prishtine','A1')
Insert into Pacienti values(4,'Rrahman','Zeneli','60','1991-02-01','044-121-223','Prishtine','A1')
Insert into Pacienti values(5,'Idriz','Stublla','60','1995-02-01','044-151-222','Prishtine','A4')
Insert into Pacienti values(6,'Arsim','Saliu','60','1990-02-01','044-111-622','Prishtine','A5')
Insert into Pacienti values(7,'Ramush','Sejdiu','60','1990-01-01','044-111-122','Prishtine','A3')
Insert into Pacienti values(8,'Bekim','Brestovci','66','1990-07-02','044-141-622','Prishtine','A1')
Insert into Pacienti values(9,'Armend','Dushi','66','1994-08-07','044-111-223','Prishtine','A2')
Insert into Pacienti values(10,'Adonis','Dushi','60','1997-09-11','044-111-224','Prishtine','A5')
Insert into Pacienti values(11,'Mehmet','Abdullahu','61','1998-01-25','044-111-225','Prishtine','A1')
Insert into Pacienti values(12,'Leotrim','Abdullahu','61','1997-05-22','044-111-226','Prishtine','A6')
Insert into Pacienti values(13,'Lendrit','Abdullahu','61','1997-06-13','044-111-227','Prishtine','A7')
Insert into Pacienti values(14,'Petrit','Dushi','66','1991-09-30','044-111-228','Prishtine','A8')
Insert into Pacienti values(15,'Gentrit','Arifi','61','1999-11-16','044-111-229','Prishtine','A1')
Insert into Pacienti values(16,'Enver','Ajvazi','66','1995-10-25','044-111-232','Prishtine','A9')
Insert into Pacienti values(17,'Florim','Xhaka','61','1992-05-30','044-111-242','Prishtine','A1')
Insert into Pacienti values(18,'Luan','Dushi','66','1993-04-01','044-111-252','Prishtine','A8')
Insert into Pacienti values(19,'Ramiz','Furri','62','1993-01-01','044-111-202','Prishtine','A7')
Insert into Pacienti values(20,'Rrahman','Llapjani','66','1993-12-12','044-511-222','Prishtine','A1')
Insert into Pacienti values(21,'Vebi','Ajvazi','65','1992-08-11','044-111-522','Prishtine','A4')
Insert into Pacienti values(22,'Egzon','Shabani','67','1991-09-01','044-171-222','Prishtine','A3')
Insert into Pacienti values(23,'Granit','Godeni','62','1990-01-01','044-191-222','Prishtine','A2')
Insert into Pacienti values(24,'Ardit','Hysejni','63','1990-05-01','044-211-222','Prishtine','A2')
Insert into Pacienti values(25,'Agon','Hysejni','69','1990-02-01','044-711-222','Prishtine','A1')


Insert into regjistron values(1,1358)
Insert into regjistron values(2,1357)
Insert into regjistron values(3,1356)
Insert into regjistron values(4,1355)
Insert into regjistron values(5,1354)
Insert into regjistron values(6,1353)
Insert into regjistron values(7,1352)
Insert into regjistron values(8,1351)
Insert into regjistron values(9,1350)
Insert into regjistron values(10,1349)
Insert into regjistron values(11,1358)
Insert into regjistron values(12,1357)
Insert into regjistron values(13,1356)
Insert into regjistron values(14,1355)
Insert into regjistron values(15,1354)
Insert into regjistron values(16,1353)
Insert into regjistron values(17,1352)
Insert into regjistron values(18,1351)
Insert into regjistron values(19,1350)
Insert into regjistron values(20,1349)
Insert into regjistron values(21,1358)
Insert into regjistron values(22,1357)
Insert into regjistron values(23,1356)
Insert into regjistron values(24,1355)
Insert into regjistron values(25,1354)


 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('PRISIG',1,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('SIGURIA',8,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('KOSOVA E RE',19,'Prishtine','B4')
  Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('SIGAL',2,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('SIGAL',3,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('KINDLE',20,'Prishtine','B4')
  Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('SIGURIM',4,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('SIGURIM',5,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('PRISIG',21,'Prishtine','B4')
 Insert into KompaniaSigurimit(Emri, Pacienti_ID, Qyteti, Rruga) values('COMPSIG.',22,'Prishtine','B4')



Insert into NrTelefonitKompaniaSigurimit values('Prisig','044-333-333')
Insert into NrTelefonitKompaniaSigurimit values('Prisig','049-333-333')
Insert into NrTelefonitKompaniaSigurimit values('Prisig','045-333-333')
Insert into NrTelefonitKompaniaSigurimit values('Siguria','044-111-111')
Insert into NrTelefonitKompaniaSigurimit values('Siguria','049-111-111')
Insert into NrTelefonitKompaniaSigurimit values('Siguria','045-111-111')
Insert into NrTelefonitKompaniaSigurimit values('Kosova e Re','044-222-222')
Insert into NrTelefonitKompaniaSigurimit values('Kosova e Re','049-222-222')
Insert into NrTelefonitKompaniaSigurimit values('Kosova e Re','045-222-222')


Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (10,'Kontroll')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (11,'Kontroll')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (12,'Medical')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (13,'Surgical')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (14,'Surgical')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (15,'Medical')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (16,'Dhimbje Nervash')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (17,'Infektim Vesheve')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (18,'Medical')
Insert into Trajtimi(Pacienti_ID, Emri_Trajtimit) values (19,'Surgical')

 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (11111,10,200, '02:02:22',10)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (21111,11,201,'22:22:52',10)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (31111,12,202,'12:12:42',200)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (41111,13,203,'06:15:22',300)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (51111,14,204,'11:24:12',1000)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (61111,15,205,'22:52:32',2000)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (71111,16,206,'19:42:22',300)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (81111,17,207,'13:32:25',200)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (91111,18,208,'11:22:03',1000)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (10211,19,209,'09:12:31',3000)
  Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (81211,1,207,'13:32:25',200)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (91211,2,208,'11:22:03',1000)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (10211,3,209,'09:12:31',3000)
  Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (81213,1,207,'13:32:25',200)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (91214,2,208,'11:22:03',1000)
 Insert into Fatura(Numri_Fiskal, Pacienti_ID,ID_Trajtimit, Koha, Shuma) values (10215,3,209,'09:12:31',3000)

Insert into KontaktiEmergjent values(99,25,'Albion','Hysejni')
Insert into KontaktiEmergjent values(100,25,'Albion','Hysejni')
Insert into KontaktiEmergjent values(98,23,'Meriton','Hysejni')
Insert into KontaktiEmergjent values(97,22,'Bardh','Godeni')
Insert into KontaktiEmergjent values(96,21,'Ilir','Shabani')
Insert into KontaktiEmergjent values(95,20,'Yll','Krasniqi')
Insert into KontaktiEmergjent values(94,19,'Neo','Dovigjenja')
Insert into KontaktiEmergjent values(93,18,'Kastrat','Kastrati')
Insert into KontaktiEmergjent values(92,17,'Albion','Veliu')
Insert into KontaktiEmergjent values(91,16,'Enver','Haradinaj')
Insert into KontaktiEmergjent values(90,15,'Mina','Brestovci')
Insert into KontaktiEmergjent values(101,16,'Enver','Rrustemi')
Insert into KontaktiEmergjent values(102,15,'Blenda','Gashi')
Insert into KontaktiEmergjent values(103,17,'Albatrit','Berisha')
Insert into KontaktiEmergjent values(104,18,'Blend','Baraliu')


Insert into NrTelefonitKontaktiEmergjent values(99, '044-143-111')
Insert into NrTelefonitKontaktiEmergjent values(100, '044-143-112')
Insert into NrTelefonitKontaktiEmergjent values(98, '044-143-113')
Insert into NrTelefonitKontaktiEmergjent values(97, '044-143-114')
Insert into NrTelefonitKontaktiEmergjent values(96, '044-143-115')
Insert into NrTelefonitKontaktiEmergjent values(95, '044-143-116')
Insert into NrTelefonitKontaktiEmergjent values(94, '044-143-117')
Insert into NrTelefonitKontaktiEmergjent values(93, '044-143-118')
Insert into NrTelefonitKontaktiEmergjent values(92, '044-143-119')
Insert into NrTelefonitKontaktiEmergjent values(91, '044-143-120')
Insert into NrTelefonitKontaktiEmergjent values(90, '044-143-121')
Insert into NrTelefonitKontaktiEmergjent values(90, '044-143-122')


Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Trajtim',2,10,1359)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Fizio',2,11,1360)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Analiz',2,12,1361)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Fotografi',1,13,1362)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Pediatri',2,14,1363)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Operacion',3,15,1364)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Emergjenc',2,16,1365)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Staf',2,17,1366)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Laborator',0,18,1367)
Insert into Dhoma(Tipi_Dhomes, Kati, Pacienti_ID, Infermieri_ID) values ('Pritjes',0,19,1368)


Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(10,1349, '2020-11-01', '02:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(11,1350, '2020-11-02', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(12,1351, '2020-11-03', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(13,1351, '2020-11-04', '04:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(14,1353, '2020-11-05', '06:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(15,1352, '2020-11-06', '04:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(16,1352, '2020-11-07', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(17,1356, '2020-11-08', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(18,1358, '2020-11-09', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(19,1351, '2020-11-20', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(10,1349, '2020-11-10', '02:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(11,1349, '2020-11-11', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(12,1351, '2020-11-12', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(13,1351, '2020-11-13', '04:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(14,1352, '2020-11-14', '06:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(15,1352, '2020-11-15', '04:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(16,1357, '2020-11-16', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(17,1356, '2020-11-17', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(18,1358, '2020-11-18', '03:00')
Insert into Termini(Pacienti_ID, Recepsionisti_ID, [Data], Ora) values(19,1354, '2020-11-19', '03:00')


Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',10)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Dhimbje lukthi',19)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Brufen','Per Femij',18)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Omega-3','Per Imunitet',12)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-C','Per Imunitet',13)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-D','Per Imunitet',14)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',15)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',16)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',17)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',11)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',9)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Dhimbje lukthi',8)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Brufen','Per Femij',7)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Omega-3','Per Imunitet',6)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-C','Per Imunitet',5)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-D','Per Imunitet',4)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',3)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',2)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',1)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',22)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Kok Dhimbje',23)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Dhimbje lukthi',24)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Brufen','Per Femij',21)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Omega-3','Per Imunitet',25)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Omega-3','Per Imunitet',20)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Omega-3','Per Imunitet',2)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-D','Per Imunitet',1)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Brufen','Per Kok Dhimbje',22)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Brufen','Per Kok Dhimbje',23)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Brufen','Per Dhimbje lukthi',24)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Paractamol','Per Femij',21)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-D','Per Imunitet',25)
Insert into TeDhenatMjeksore(Ilaqi, Diagnoza, Pacienti_ID) values('Vitamin-D','Per Imunitet',20)

Insert into Trajtohet values(1,1333,1359, 4001)
Insert into Trajtohet  values(2,1333,1359, 4002)
Insert into Trajtohet  values(3,1341,1360, 4003)
Insert into Trajtohet  values(4,1343,1367, 4004)
Insert into Trajtohet  values(5,1345,1359, 4005)
Insert into Trajtohet  values(6,1343,1361, 4006)
Insert into Trajtohet  values(7,1333,1360, 4007)
Insert into Trajtohet  values(8,1333,1359, 4008)
Insert into Trajtohet  values(9,1333,1359, 4009)
Insert into Trajtohet  values(10,1333,1362, 4010)

Insert into Trajtohet  values(11,1333,1359, 4011)
Insert into Trajtohet  values(12,1333,1360, 4012)
Insert into Trajtohet  values(13,1341,1361, 4013)
Insert into Trajtohet  values(14,1343,1362, 4014)
Insert into Trajtohet  values(15,1345,1363, 4015)
Insert into Trajtohet  values(16,1343,1364, 4016)
Insert into Trajtohet  values(17,1333,1365, 4017)
Insert into Trajtohet  values(18,1333,1366, 4018)
Insert into Trajtohet  values(19,1333,1367, 4019)
Insert into Trajtohet  values(20,1333,1368, 4020)

Insert into Trajtohet  values(21,1333,1359, 4021)
Insert into Trajtohet  values(22,1333,1365, 4022)
Insert into Trajtohet  values(23,1341,1365, 4023)
Insert into Trajtohet  values(24,1343,1366, 4024)
Insert into Trajtohet  values(25,1345,1359, 4023)



UPDATE Doktori Set Data_Lindjes = '1999-12-10' WHERE Doktori_ID = 1341
UPDATE Doktori Set Data_Lindjes = '1998-05-05' WHERE Doktori_ID = 1344
UPDATE Doktori Set Data_Lindjes = '1999-01-14' WHERE Doktori_ID = 1348

UPDATE Recepsionisti Set Mbiemri = 'Osdautaj' WHERE Recepsionisti_ID = 1353
UPDATE Recepsionisti Set Mbiemri = 'Berisha' WHERE Recepsionisti_ID = 1352


UPDATE Specializimi_Doktorit Set Specializimi = 'Ortolog' WHERE Doktori_ID = 1347
UPDATE Kualifikimi_Doktorit Set Kualifikimi = 'Diploma' WHERE  Doktori_ID= 1346
UPDATE Specializimi_Infermierit Set Specializimi = 'Ortolog' WHERE Infermieri_ID = 1359
UPDATE Specializimi_Infermierit Set Specializimi = 'Pediater' WHERE Infermieri_ID = 1361
UPDATE Kualifikimi_Doktorit Set Kualifikimi = 'Degree' WHERE Doktori_ID = 1342

UPDATE Pacienti set Qyteti = 'Ferizaj' WHERE Pacienti_ID = 3
UPDATE Pacienti set Qyteti = 'Prizeren' WHERE Pacienti_ID = 10
UPDATE Pacienti set Qyteti = 'Gjakove' WHERE Pacienti_ID = 15

UPDATE KompaniaSigurimit Set Rruga = 'Agim Ramadani' Where ID = '1001'
UPDATE KompaniaSigurimit Set Rruga = 'Agim Ramadani' Where ID = '1002'

UPDATE Fatura set Shuma = 100 where Pacienti_ID = 11
UPDATE Fatura set Shuma = 500 where Pacienti_ID = 15

UPDATE TeDhenatMjeksore set Ilaqi = 'Brufen'  WHERE Pacienti_ID = 17

UPDATE Termini Set Ora = '04:00'  Where Pacienti_ID = 12

Update Regjistron Set Recepsionisti_ID = 1349 Where Pacienti_ID= 16



Delete From Punonjesi Where Punonjesi_ID = 1346

Delete From KontaktiEmergjent Where Pacienti_ID = 15

Delete From Termini Where Pacienti_ID = 14

Delete From Fatura Where Numri_Fiskal = 1111


Delete From Punonjesi Where Punonjesi_ID = 1347

Delete From KompaniaSigurimit Where Emri = 'KINDLE'

DELETE From  Trajtohet Where Pacienti_ID = 10
 
Delete From Dhoma Where Tipi_Dhomes = 'Fizio'

Delete From KontaktiEmergjent Where Kontakti_ID = 99

Delete From Specializimi_Infermierit Where Specializimi = 'Ortolog'

ALTER TABLE Doktori ADD Mosha AS DATEDIFF(YEAR, Data_Lindjes, GETDATE())
ALTER TABLE Infermieri ADD Mosha AS DATEDIFF(YEAR, Data_Lindjes, GETDATE())



-- Queries
---------------------------
--1

Select p.Pacienti_ID,p.Emri, p.Mbiemri from Pacienti p
Where Rruga like 'A1'
--

select count (distinct I.Doktori_ID) as 'Nr i Doktoreve qe asistohen nga Infermieret'
from Infermieri I
--

select f.Pacienti_ID, avg(f.Shuma) as 'Shuma mesatare e faturave' from Fatura f
group by f.Pacienti_ID
--

select * from Pacienti
where Data_Lindjes BETWEEN '1990-01-01' and '1992-01-01'
--Dorant i vazhdon edhe 4 tjera te ndryshme
-- Selekto ID-n e Pacientit , emrin e Pacientit dhe mbiemrin Te cilet i takojn qytetit te Prishtines.
Select p.Pacienti_ID, p.Emri, p.Mbiemri 
From Pacienti p
Where Qyteti like 'Prishtine'

--Selekto Id-n e Infermierit,emrin dhe mbiemrin e infermierit te Cilet jan nen nen vezhgimin e Doktorit me Id '1345'

Select i.Infermieri_ID,i.Emri,i.Mbiemri,i.Data_Lindjes 
From Infermieri i
Where Doktori_ID = 1345

--selekto te gjitha kolonat e  trajtimit  duke i renditur sipas emrit te trajtimit

Select * From Trajtimi
Order by Emri_Trajtimit

--Selekto te gjitha kolonat e Kompanis se Sigurimit te cilat kan emrin 'Pristig' dhe 'Kosova e Re'

Select * From KompaniaSigurimit
Where Emri = 'Pristig' or Emri = 'Kosova e Re'  

---------------------------
--2


select rs.Emri as 'Emri Recepsionistit', rs.Mbiemri as 'Mbiemri Recepsionistit', rgj.Pacienti_ID, p.Emri, p.Mbiemri
from Recepsionisti rs, regjistron rgj, Pacienti p 
where rs.Recepsionisti_ID = rgj.Recepsionisti_ID and rgj.Pacienti_ID = p.Pacienti_ID
order by 1
--
select p.Pacienti_ID,count(*) as 'Nr Kontakteve Emergjente' from KontaktiEmergjent ke, Pacienti p
where p.Pacienti_ID = ke.Pacienti_ID
group by p.Pacienti_ID
--

SELECT f.Pacienti_ID,p.Emri, p.Mbiemri, count(*) as 'Nr Faturave', sum(f.Shuma) as 'Shuma mesatare' FROM Pacienti p, Fatura f
WHERE p.Pacienti_ID = f.Pacienti_ID  
GROUP BY f.Pacienti_ID, p.Emri, p.Mbiemri
HAVING count(*)>1
Order By 3 desc
--

select * from Pacienti p, TeDhenatMjeksore tdm
where p.Pacienti_ID = tdm.Pacienti_ID and p.Emri like 'Rrahman' and p.Mbiemri like 'Llapjani'
--

--Selekto Emrin dhe Mbiemrin e Pacientit dhe Emrin dhe Mbiemrin e Kontaktit emergjent per Pacientet me Mbiemrin 'Dushi' dhe 'Hysejni'

Select p.Emri,p.Mbiemri, ne.Emri,ne.Mbiemri From Pacienti p, KontaktiEmergjent ne
Where p.Mbiemri = 'Dushi' and p.Mbiemri = 'Hysejni'

--Selekto ID-n e Pacientit dhe Emrin e Tij, te Cilet trajtohen nga Doktori_ID i cili ka specializimin ('Ortolog','Pediater','Farmacist')

Select p.Pacienti_ID,p.Emri,t.Doktori_ID  From Pacienti p, Trajtohet t , Specializimi_Doktorit d
Where Specializimi In('Ortolog','Pediater','Farmacist')

--Selekto te gjitha kolonat e Punonjesit dhe numeroji te gjitha si 'Punetoret e Spitalit' dhe numero 5 si 'Pacient'

Select *, count(*) as 'Puntoret e Spitalit',count(5)as 'Pacientet' from Punonjesi , Pacienti 

--Selekto kolonat unike per Ilaqin dhe ID-n e Pacientit nga TeDhenatMjeksore dhe renditi sipas ID-s se Pacientit

Select Distinct s.Ilaqi ,s.Pacienti_ID From TeDhenatMjeksore s
order by Pacienti_ID

-------------------------


--3

--Selekto Id-n e Pacientit dhe emrin nga Pacienti dhe te perputhen ID-t me ID-n e Punonjesit te tabela Punonjesi

Select p.Pacienti_ID,p.emri,pu.Punonjesi_ID from Pacienti p Inner Join Punonjesi pu
On p.Pacienti_ID = pu.Punonjesi_ID

--Selekto emrin,mbiemrin dhe specializmin e Infermierit ku perputhen Specializimi i tij me kualifikimin e Doktorit perkates

Select i.emri, i.mbiemri,s.specializimi from Infermieri i Inner Join  Specializimi_Infermierit s 
on s.Specializimi = 'Pediater' Inner Join Kualifikimi_Doktorit d on d.Kualifikimi = 'Pediater'

--Selekto emrin dhe mbiemrin e Punonjesit dhe emrin e Kompanis se sigurimit ku perputhen te gjitha kolonat nga e majta ne te djatht tu perfshi Punonjesi Id 
--dhe Pacienti_ID dhe si kusht te jen te Prishtines

Select p.emri,p.mbiemri,k.emri from Punonjesi p FULL Join KompaniaSigurimit k on p.Punonjesi_ID = k.Pacienti_ID
where k.Qyteti = 'Prishtine'

--Selektoni Id-n e Doktorit si 'Doktori' dhe specializimin e tij nga Tabela e majt ne te djatht ku IDt te perputhen dhe Specializimi 
--te jete (Pediater, Stomatolog ose Ortolog)

Select d.Doktori_ID as 'Doktori', i.Specializimi
from Doktori d LEFT JOIN Specializimi_Doktorit i on d.Doktori_ID= i.Doktori_ID
where Specializimi in ('Pediater','Stomatolog','Ortolog')
--

--4

Select s.Pacienti_ID,s.Diagnoza 
from TeDhenatMjeksore s
where s.ID not in (Select distinct t.Pacienti_ID from Termini t)
--

Select t.Diagnoza, (Select count(t.Ilaqi) From TeDhenatMjeksore t
Where Ilaqi = 'Omega-3') as 'Ilaqet' from TeDhenatMjeksore t 
Order by Ilaqi
--

Select p.Emri,p.mbiemri,p.Punonjesi_ID 
From Punonjesi p
Where p.Punonjesi_ID = (Select r.Recepsionisti_ID 'ID per Recepsionist'
						from Recepsionisti r
						Where r.Mbiemri In ('Zajmi','Shala','Hoxha')
)
--

Select n.shuma from Fatura n
where n.Shuma > ANY (Select 4000 from Fatura n)
--

--5 
Select top 3 c.Pacienti_ID,c.numri_fiskal , shuma = (Select count(shuma) from Fatura)
From Fatura c;
--

Select top 3 k.emri 
from KompaniaSigurimit k ,(Select k.Pacienti_ID, count (qyteti) as 'Qyteti' From KompaniaSigurimit k	group by Qyteti)
--
--6

(Select emri,mbiemri From Doktori)
UNION (Select emri , mbiemri From Infermieri)
--

(Select Doktori_ID , Mbiemri from Doktori)
INTERSECT
(Select doktori_ID, mbiemri from Infermieri)
--

(Select Emri , Mbiemri from Punonjesi)
Except
(Select Emri, mbiemri from Pacienti)
--

(Select emri, qyteti from KompaniaSigurimit)
Except
(Select emri,mbiemri from Doktori)













