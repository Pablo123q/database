
USE master
IF NOT EXISTS(
select * from [sys].[databases] WHERE name = 'Biblioteka_new2'
)
CREATE DATABASE Biblioteka_new2;
GO
USE Biblioteka_new2;




--IF NOT EXISTS
CREATE TABLE dbo.books (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    genre NVARCHAR(50) NULL,
    publisher NVARCHAR(100) NULL,
    publicationYear INT NOT NULL,
    isbn NVARCHAR(20) UNIQUE,
    statuss BIT NOT NULL,
    audit_id INT NULL,
	status_id INT NOT NULL,
	FOREIGN KEY (status_id) REFERENCES [status](status_id)
)

CREATE TABLE dbo.authors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    firstName NVARCHAR(100) NOT NULL,
    lastName NVARCHAR(100) NOT NULL,
    birthDate DATE NULL,
    country_id INT NOT NULL DEFAULT 1,  
    FOREIGN KEY (country_id) REFERENCES dbo.country(country_id)
);

CREATE TABLE dbo.country (
    country_id INT PRIMARY KEY IDENTITY(1,1),
    country NVARCHAR(100) NOT NULL,
    country_short CHAR(3) NOT NULL
);

CREATE TABLE dbo.bookAuthor (
   -- author_book_id INT IDENTITY(1,1) PRIMARY KEY,
	bookID INT,
    authorID INT,
    FOREIGN KEY (bookID) REFERENCES dbo.books(id),
    FOREIGN KEY (authorID) REFERENCES dbo.authors(id),
    CONSTRAINT PK_bookAuthor_authorID_bookID PRIMARY KEY CLUSTERED(authorID,bookID)
)


CREATE TABLE dbo.users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(250) NOT NULL UNIQUE,
    userType NVARCHAR(20) NULL,
	rola VARCHAR(20) CHECK (rola in('admin','librarian','user')),
	status_id INT NOT NULL,
	FOREIGN KEY (status_id) REFERENCES [status](status_id)
)


CREATE TABLE dbo.customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(200) NOT NULL UNIQUE,
    birthDate DATE NULL,
	FOREIGN KEY(user_id) REFERENCES dbo.users(id),
	status_id INT NOT NULL,
	FOREIGN KEY (status_id) REFERENCES [status](status_id)
)


ALTER TABLE dbo.users
ADD CONSTRAINT Df_Doc_Exz_rola CHECK (rola in('admin','librarian','user'))
GO

CREATE TABLE dbo.rentals (
    id INT IDENTITY(1,1) PRIMARY KEY,
    bookID INT NOT NULL,
    customerID INT NOT NULL,
    rentalDate DATE NOT NULL,
    returnDate DATE NULL,
    [status] NVARCHAR(20) CHECK ([status] in ('wypozyczona','zwrocona','przetrzymana')) DEFAULT 'wypozyczona', 
    CONSTRAINT FK_rentals_books FOREIGN KEY (bookID) REFERENCES dbo.books(id),
    CONSTRAINT FK_rentals_customers FOREIGN KEY (customerID) REFERENCES dbo.customers(id)
)


CREATE TABLE dbo.reservations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    bookID INT NOT NULL,
    customerID INT NOT NULL,
    reservationDate DATE NOT NULL,
    res_status NVARCHAR(20) NOT NULL, 
    CONSTRAINT FK_reservations_books FOREIGN KEY (bookID) REFERENCES dbo.books(id),
    CONSTRAINT FK_reservations_customers FOREIGN KEY (customerID) REFERENCES dbo.customers(id)
)

CREATE INDEX IX_reservations_book_is ON dbo.reservations(bookID)

CREATE TABLE dbo.penalties (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerID INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    reason NVARCHAR(255) NOT NULL,
	bookID INT NOT NULL,
    status_id INT NOT NULL,
	--[status] NVARCHAR(20) CHECK ([status] in ('naliczona','oplacona','umorzona')) DEFAULT 'naliczona', 
    CONSTRAINT FK_penalties_customers FOREIGN KEY (customerID) REFERENCES dbo.customers(id),
	FOREIGN KEY (bookID) REFERENCES dbo.books(id),
	FOREIGN KEY (status_id) REFERENCES [status](status_id),
)

create table [status](
	status_id int identity(1,1) PRIMARY KEY,
	status_name varchar(50) NOT NULL,
	status_desc varchar(200),
	status_type varchar(50),--typ statusu
	[status] BIT,
)

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_CATALOG = 'Biblioteka_new';



--INSERT INTO nazwa (kolumna) VALUES (wartosc)

INSERT INTO dbo.[status]([status_name],[status_desc],[status_type],[status])
VALUES('Dostepna','Ksiazaka w bibliotece','books',1)

INSERT INTO dbo.[status]([status_name],[status_type],[status])
VALUES('Niedostepna','books',1),
('Aktywny','users',1),
('Nieaktywny','users',1)


SELECT * FROM dbo.status
