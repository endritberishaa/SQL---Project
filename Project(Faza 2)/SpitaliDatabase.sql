CREATE DATABASE Spitali
USE Spitali

Create table Punonjesi (
    Punonjesi_ID int,
    Emri varchar(25) not null,  
    Mbiemri varchar(25) not null,
    Numri_Kontakt varchar(25) UNIQUE,
    Primary key(Punonjesi_ID)
)

/*Insert into Punonjesi values(1331, 'Dren', 'Gara', '049-651-987')
Insert into Punonjesi values(1332, 'Aulon', 'Baftiu', '049-755-114')
Insert into Punonjesi values(1334, 'Bledar', 'Gashi', '049-651-988')
Insert into Punonjesi values(1336, 'Lorik', 'Zuka', '044-111-114')
Insert into Punonjesi values(1339, 'Blerina', 'Thaqi', '049-651-981')
Insert into Punonjesi values(1340, 'Festa', 'Qoqaj', '044-112-134')*/

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





