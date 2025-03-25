--Biblioteka

CREATE DATABASE Biblioteka1;
GO
SELECT * FROM sys.tables;
select * 
from sys.databases
	
WHERE name='Biblioteka_new'
table


CREATE DATABASE Biblioteka_new
ON
PRIMARY
(
NAME = 'Biblioteka_new',
FILENAME = 'C:\DB\Baza_biblioteka_new.mdf',
SIZE = 10MB,
MAXSIZE =20MB,
FILEGROWTH =2MB
)
LOG ON
(
NAME = 'Biblioteka_new',
FILENAME = 'C:\DB\Baza_biblioteka.ldf',
SIZE = 10MB,
MAXSIZE =20MB,
FILEGROWTH =2MB
)

CREATE TABLE dbo.bookss
(
id INT IDENTITY(1,1) PRIMARY KEY,
title nvarchar(200) NOT  NULL,
genre varchar(50) NULL,
publisher varchar(100)NULL,
publicationYear INT NOT NULL,
isbn varchar(20) UNIQUE,
status BIT NOT NULL,
audit_id INT 
)

CREATE TABLE dbo.authors
(
[id] INT IDENTITY(1,1) PRIMARY KEY,
[firstName] varchar(100) NOT NULL,
[lastName] varchar(100) NOT NULL,
[birtht] DATE

)

CREATE TABLE dbo.bookAuthor
(
bookID INT,
authorID INT,
CONSTRAINT FK_book FOREIGN KEY (bookID)
	REFERENCES  books(id),

CONSTRAINT Fk_booksAuthors_authors FOREIGN KEY(authorID)
 REFERENCES authors(id),

)

CREATE TABLE dbo.users
(
id INT PRIMARY KEY,
fullName varchar(100) NOT NULL,
email varchar(250) NOT NULL,
userType varchar(20)

)



--ksiazki
-- autor 
-- rodzaj ksiazki
--klient
-- oddzialy
-- wypozyczenia