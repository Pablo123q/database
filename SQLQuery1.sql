
CREATE DATABASE Biblioteka_new
ON
PRIMARY
(
    NAME = 'Biblioteka_new_data',
    FILENAME = 'C:\DB\Baza_biblioteka_new.mdf',
    SIZE = 10MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 2MB
)
LOG ON
(
    NAME = 'Biblioteka_new_log',
    FILENAME = 'C:\DB\Baza_biblioteka.ldf',
    SIZE = 10MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 2MB
);

-- Użycie nowo utworzonej bazy danych
USE Biblioteka_new;

-- Tworzenie tabeli books
CREATE TABLE dbo.books (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    genre NVARCHAR(50) NULL,
    publisher NVARCHAR(100) NULL,
    publicationYear INT NOT NULL,
    isbn NVARCHAR(20) UNIQUE,
    status BIT NOT NULL,
    audit_id INT NULL
);

-- Tworzenie tabeli authors
CREATE TABLE dbo.authors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    firstName NVARCHAR(100) NOT NULL,
    lastName NVARCHAR(100) NOT NULL,
    birthDate DATE NULL
);

-- Tworzenie tabeli bookAuthor (poprawiono przecinek i nazwy FK)
CREATE TABLE dbo.bookAuthor (
    bookID INT,
    authorID INT,
    CONSTRAINT FK_book FOREIGN KEY (bookID) REFERENCES dbo.books(id),
    CONSTRAINT FK_booksAuthors_authors FOREIGN KEY (authorID) REFERENCES dbo.authors(id),
    PRIMARY KEY (bookID, authorID) -- Relacja wiele do wielu
);

-- Tworzenie tabeli users
CREATE TABLE dbo.users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(250) NOT NULL UNIQUE,
    userType NVARCHAR(20) NULL
);

-- Tworzenie tabeli customers
CREATE TABLE dbo.customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(200) NOT NULL UNIQUE,
    birthDate DATE NULL
);

-- Tworzenie tabeli rentals
CREATE TABLE dbo.rentals (
    id INT IDENTITY(1,1) PRIMARY KEY,
    bookID INT NOT NULL,
    customerID INT NOT NULL,
    rentalDate DATE NOT NULL,
    returnDate DATE NULL,
    status NVARCHAR(20) NOT NULL, -- np. "Wypożyczona", "Zwrócona"
    CONSTRAINT FK_rentals_books FOREIGN KEY (bookID) REFERENCES dbo.books(id),
    CONSTRAINT FK_rentals_customers FOREIGN KEY (customerID) REFERENCES dbo.customers(id)
);

-- Tworzenie tabeli reservations
CREATE TABLE dbo.reservations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    bookID INT NOT NULL,
    customerID INT NOT NULL,
    reservationDate DATE NOT NULL,
    status NVARCHAR(20) NOT NULL, -- np. "Aktywna", "Anulowana"
    CONSTRAINT FK_reservations_books FOREIGN KEY (bookID) REFERENCES dbo.books(id),
    CONSTRAINT FK_reservations_customers FOREIGN KEY (customerID) REFERENCES dbo.customers(id)
);

-- Tworzenie tabeli penalties
CREATE TABLE dbo.penalties (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerID INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    reason NVARCHAR(255) NOT NULL,
    status NVARCHAR(20) NOT NULL, -- np. "Zapłacona", "Nieopłacona"
    CONSTRAINT FK_penalties_customers FOREIGN KEY (customerID) REFERENCES dbo.customers(id)
);

-- Sprawdzenie tabel w bazie
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_CATALOG = 'Biblioteka_new';
