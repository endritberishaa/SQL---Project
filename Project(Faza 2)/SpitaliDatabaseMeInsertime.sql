1CREATE DATABASE Spitali
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
--Insert into Recepsionisti values(1331, 'Dren', 'Gara')


create table Doktori (
    Doktori_ID int,
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Data_Lindjes date,
    Primary key(Doktori_ID),
    Foreign Key(Doktori_ID) REFERENCES Punonjesi(Punonjesi_ID) ON DELETE CASCADE ON UPDATE CASCADE,
)

--Insert Into Doktori values(1332, 'Aulon', 'Baftiu', '1987-09-20')
--Insert Into Doktori values(1334, 'Bledar', 'Gashi', '1993-05-12')
--Insert Into Doktori values(1336, 'Lorik', 'Zuka', '1998-06-15')



CREATE table Vizitori(
    ID int primary key,
    FOREIGN Key (ID) REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
)
--Insert into Vizitori values(1332)



Create Table Rekruti(
    ID int primary key,
    FOREIGN Key (ID) REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    

)
--Insert into Rekruti VALUES(1336)



Create table Infermieri (
    Infermieri_ID int,
    Doktori_ID int not null REFERENCES Doktori(Doktori_ID),
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Data_Lindjes date,
    Primary key(Infermieri_ID),
    Foreign Key(Infermieri_ID) REFERENCES Punonjesi(Punonjesi_ID) ON DELETE CASCADE ON UPDATE CASCADE,

)

/*Insert into Infermieri values(1339, 1332, 'Blerina', 'Thaqi', '1992-05-11')
Insert into Infermieri values(1340, 1332 ,'Festa', 'Qoqaj', '1994-08-12')
select * from Punonjesi
select * from Doktori
select * from Vizitori
select * from Rekruti
select * from Infermieri*/




Create table Specializimi_Doktorit ( 

    Doktori_ID int NOT NULL REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Specializimi varchar(50) not null,
)



/*Insert into Specializimi_Doktorit values(1332, 'Ortolog')
Insert into Specializimi_Doktorit values(1332, 'Kirurg')*/
Create table Kualifikimi_Doktorit (
    
    Doktori_ID int NOT NULL REFERENCES Doktori(Doktori_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Kualifikimi varchar(50) not null,
)




Create table Specializimi_Infermierit(
    Infermieri_ID int NOT NULL REFERENCES Infermieri(Infermieri_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Specializimi varchar(50) not null,
)
--Insert into Specializimi_Infermierit values(1339, 'Ortolog')



Create table Pacienti(
    Pacienti_ID int,
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Sigurimi varchar(255),
    Data_Lindjes date,
    Numri_Tel varchar(30) not null,
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
     Emri varchar(255) PRIMARY KEY,
     Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
     Qyteti VARCHAR(255),
     Rruga VARCHAR(255) 
 )



 create table NrTelefonitKompaniaSigurimit(
     Emri varchar(255) REFERENCES KompaniaSigurimit(Emri) ON DELETE CASCADE ON UPDATE CASCADE,
     Nr_Telefonit int not null UNIQUE,
     
 )



 create table Trajtimi (
     ID_Trajtimit int,
     Pacienti_ID int references Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
     Emri_Trajtimit varchar(50) not null,
     PRIMARY Key(ID_Trajtimit),
     
 )


 create table Fatura (
     
     Numri_Fiskal int not null primary key, 
     Pacienti_ID int not null references Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
     ID_Fatura int REFERENCES Trajtimi(ID_Trajtimit),
     Koha time not null,
     Shuma int check(Shuma >= 0),
     
 )

 Create table KontaktiEmergjent(
    Kontakti_ID int IDENTITY not null,
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Emri varchar(25) not null,
    Mbiemri varchar(25) not null,
    Primary key(Kontakti_ID),

)   

/* Bro ktu spo di */
Set Identity_Insert dbo.KontaktiEmergjent ON;
Insert into KontaktiEmergjent values(99,25,'Albion','Hysejni')
Insert into KontaktiEmergjent values(99,25,'Albion','Hysejni')
Insert into KontaktiEmergjent values(98,24,'Meriton','Hysejni')
Insert into KontaktiEmergjent values(97,23,'Bardh','Godeni')
Insert into KontaktiEmergjent values(96,22,'Ilir','Shabani')
Insert into KontaktiEmergjent values(95,21,'Yll','Krasniqi')
Insert into KontaktiEmergjent values(94,20,'Neo','Dovigjenja')
Insert into KontaktiEmergjent values(93,19,'Kastrat','Kastrati')
Insert into KontaktiEmergjent values(92,18,'Albion','Veliu')
Insert into KontaktiEmergjent values(91,17,'Enver','Haradinaj')
Insert into KontaktiEmergjent values(90,16,'Mina','Brestovci')

/* edhe kta se po lidhet me kta nalt */
Create table NrTelefonitKontaktiEmergjent (
    Kontakti_ID int REFERENCES KontaktiEmergjent(Kontakti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Nr_Telefonit varchar(255) unique
)
 Create table Dhoma (
    Nr_Dhomes int not null,
    Tipi_Dhomes varchar(10) not null unique,
    Kati int not null check(Kati between -1 and 4),
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Infermieri_ID int REFERENCES Infermieri(Infermieri_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Primary key(Nr_Dhomes)
)
/* Bro prap me identity spo di */
Create table Termini(
    ID int IDENTITY(1,1),
    Pacienti_ID int REFERENCES Pacienti(Pacienti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Recepsionisti_ID int REFERENCES Recepsionisti(Recepsionisti_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Data date,
    Ora time not null,
    Primary key(ID),

)

Create Table TeDhenatMjeksore (
    ID int,
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
    Unique(Pacienti_ID, Doktori_ID, Infermieri_ID, ID_TeDhenatMjeksore)

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

ALTER TABLE Doktori ADD Mosha AS DATEDIFF(YEAR, Data_Lindjes, GETDATE())
ALTER TABLE Infermieri ADD Mosha AS DATEDIFF(YEAR, Data_Lindjes, GETDATE())


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
Insert into Punonjesi values(1344,'Dion','Rexhepi','044-111-114')
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



Insert into Vizitori values (1333)
Insert into Vizitori values (1341)
Insert into Vizitori values (1342)
Insert into Vizitori values (1343)
Insert into Vizitori values (1344)
Insert into Vizitori values (1345)
Insert into Vizitori values (1346)
Insert into Vizitori values (1347)
Insert into Vizitori values (1348)
Insert into Vizitori values (1340)

Insert into Rekruti values(1340)
Insert into Rekruti values(1349)
Insert into Rekruti values(1348)
Insert into Rekruti values(1347)
Insert into Rekruti values(1346)
Insert into Rekruti values(1345)
Insert into Rekruti values(1344)
Insert into Rekruti values(1343)
Insert into Rekruti values(1342)
Insert into Rekruti values(1341)

Insert into Infermieri values(1359,1333,'Diar','Ibiqi','2000-01-01')
Insert into Infermieri values(1360,1333,'Dion','Kajdomqaj','2000-01-02')
Insert into Infermieri values(1361,1348,'Diell','Kryeziu','2001-03-01')
Insert into Infermieri values(1362,1348,'Dren','Demaku','2005-02-05')
Insert into Infermieri values(1363,1348,'Dren','Maxhera','2000-01-10')
Insert into Infermieri values(1364,1340,'Drin','Ismajili','2000-10-11')
Insert into Infermieri values(1365,1340,'Endrit','Tahiri','2004-02-06')
Insert into Infermieri values(1366,1340,'Endrit','Berisha','2001-09-03')
Insert into Infermieri values(1367,1346,'Lek','Duli','2004-09-09')
Insert into Infermieri values(1368,1346,'Lek','Shehu','2002-10-10')


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

Insert into Kualifikimi_Doktorit values(1333,'I Lart')
Insert into Kualifikimi_Doktorit values(1341,'I Lart')
Insert into Kualifikimi_Doktorit values(1342,'Mesatar')
Insert into Kualifikimi_Doktorit values(1343,'Mesatar')
Insert into Kualifikimi_Doktorit values(1344,'I Lart')
Insert into Kualifikimi_Doktorit values(1345,'I Lart')
Insert into Kualifikimi_Doktorit values(1346,'I Lart')
Insert into Kualifikimi_Doktorit values(1347,'I Lart')
Insert into Kualifikimi_Doktorit values(1348,'I Lart')
Insert into Kualifikimi_Doktorit values(1349,'I Lart')


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
Insert into Pacienti values(4,'Rrahman','Zeneli','60','1991-02-01','044-121-222','Prishtine','A1')
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

 Insert into KompaniaSigurimit values('66',1,'Prishtine','B4')
 Insert into KompaniaSigurimit values('66',8,'Prishtine','B4')
 Insert into KompaniaSigurimit values('66',9,'Prishtine','B4')
 Insert into KompaniaSigurimit values('66',14,'Prishtine','B4')
 Insert into KompaniaSigurimit values('66',16,'Prishtine','B4')
 Insert into KompaniaSigurimit values('66',18,'Prishtine','B4')
 Insert into KompaniaSigurimit values('60',2,'Prishtine','B4')
 Insert into KompaniaSigurimit values('61',11,'Prishtine','B4')
 Insert into KompaniaSigurimit values('62',19,'Prishtine','B4')
 Insert into KompaniaSigurimit values('65',21,'Prishtine','B4')
 Insert into KompaniaSigurimit values('67',22,'Prishtine','B4')
 Insert into KompaniaSigurimit values('63',24,'Prishtine','B4')
 Insert into KompaniaSigurimit values('69',25,'Prishtine','B4')

Insert into NrTelefonitKompaniaSigurimit values('66',112)
Insert into NrTelefonitKompaniaSigurimit values('66',112)
Insert into NrTelefonitKompaniaSigurimit values('62',113)
Insert into NrTelefonitKompaniaSigurimit values('65',116)
Insert into NrTelefonitKompaniaSigurimit values('69',119)
Insert into NrTelefonitKompaniaSigurimit values('67',117)
Insert into NrTelefonitKompaniaSigurimit values('63',113)
Insert into NrTelefonitKompaniaSigurimit values('66',112)
Insert into NrTelefonitKompaniaSigurimit values('66',112)
Insert into NrTelefonitKompaniaSigurimit values('66',112)


Insert into Trajtimi values (101,10,'Kontroll')
Insert into Trajtimi values (102,11,'Kontroll')
Insert into Trajtimi values (103,12,'Kontroll')
Insert into Trajtimi values (104,13,'Kontroll')
Insert into Trajtimi values (105,14,'Kontroll')
Insert into Trajtimi values (106,15,'Kontroll')
Insert into Trajtimi values (107,16,'Kontroll')
Insert into Trajtimi values (108,17,'Kontroll')
Insert into Trajtimi values (109,18,'Kontroll')
Insert into Trajtimi values (110,19,'Kontroll')


 Insert into Fatura values (11111,10,101,'02:02:22',20)
 Insert into Fatura values (21111,11,102,'22:22:52',20)
 Insert into Fatura values (31111,12,103,'12:12:42',20)
 Insert into Fatura values (41111,13,104,'06:15:22',20)
 Insert into Fatura values (51111,14,105,'11:24:12',20)
 Insert into Fatura values (61111,15,106,'22:52:32',20)
 Insert into Fatura values (71111,16,107,'19:42:22',20)
 Insert into Fatura values (81111,17,108,'13:32:25',20)
 Insert into Fatura values (91111,18,109,'11:22:03',20)
 Insert into Fatura values (10111,19,110,'09:12:31',20)

 Insert into Dhoma values (551,'Trajtim',2,1,1359)
Insert into Dhoma values (552,'FizioTerapi',2,2,1360)
Insert into Dhoma values (553,'Analiz',2,3,1361)
Insert into Dhoma values (554,'Fotografi',1,11,1362)
Insert into Dhoma values (555,'Pediatri',2,14,1363)
Insert into Dhoma values (556,'Operacion',3,15,1364)
Insert into Dhoma values (557,'Emergjenc',2,17,1365)
Insert into Dhoma values (558,'Staf',2,10,1366)
Insert into Dhoma values (559,'Laborator',0,21,1367)
Insert into Dhoma values (550,'Pritjes',2,22,1368)

Insert into TeDhenatMjeksore values(65,'Paractamol','Per Kok Dhimbje',9)
Insert into TeDhenatMjeksore values(54,'Paractamol','Per Dhimbje lukthi',19)
Insert into TeDhenatMjeksore values(53,'Brufen','Per Femij',2)
Insert into TeDhenatMjeksore values(52,'Omega-3','Per Imunitet',6)
Insert into TeDhenatMjeksore values(51,'Vitamin-C','Per Imunitet',16)
Insert into TeDhenatMjeksore values(56,'Vitamin-D','Per Imunitet',24)
Insert into TeDhenatMjeksore values(57,'Paractamol','Per Kok Dhimbje',21)
Insert into TeDhenatMjeksore values(58,'Paractamol','Per Kok Dhimbje',15)
Insert into TeDhenatMjeksore values(59,'Paractamol','Per Kok Dhimbje',11)
Insert into TeDhenatMjeksore values(50,'Paractamol','Per Kok Dhimbje',8)

Insert into Trajtohet values(1,1333,1359,56)
Insert into Trajtohet values(2,1333,1359,56)
Insert into Trajtohet values(3,1341,1360,59)
Insert into Trajtohet values(4,1343,1359,56)
Insert into Trajtohet values(5,1345,1359,56)
Insert into Trajtohet values(6,1343,1359,56)
Insert into Trajtohet values(7,1333,1359,52)
Insert into Trajtohet values(8,1333,1359,54)
Insert into Trajtohet values(9,1333,1359,58)
Insert into Trajtohet values(10,1333,1359,56)