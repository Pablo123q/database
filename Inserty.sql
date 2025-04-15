set identity_insert country off
INSERT INTO country (country, country_short) VALUES
('Polska', 'POL'),
('Stany Zjednoczone', 'USA'),
('Wielka Brytania', 'GBR'),
('Francja', 'FRA'),
('Niemcy', 'DEU'),
('Rosja', 'RUS'),
('Japonia', 'JPN'),
('Hiszpania', 'ESP'),
('Włochy', 'ITA'),
('Czechy', 'CZE');

select country, country_short from country where country_short ='POL'

INSERT INTO country DEFAULT VALUES;
INSERT INTO country(country,country_short)
OUTPUT inserted.country_id
Values
('filipiny', 'FL');
create unique index UX_Country_country
ON country (country)
--DELETE FROM country

INSERT INTO [status] (status_name, status_desc, status_type, [status]) VALUES
('Aktywny', 'Konto aktywne', 'user_status', 1),
('Nieaktywny', 'Konto nieaktywne', 'user_status', 0),
('Zablokowany', 'Konto zablokowane', 'user_status', 0),
('Dostępna', 'Książka dostępna', 'book_status', 1),
('Wypożyczona', 'Książka wypożyczona', 'book_status', 1),
('Zarezerwowana', 'Książka zarezerwowana', 'book_status', 1),
('W naprawie', 'Książka w naprawie', 'book_status', 0),
('Zgubiona', 'Książka zgubiona', 'book_status', 0),
('Naliczona', 'Kara naliczona', 'fine_status', 1),
('Opłacona', 'Kara opłacona', 'fine_status', 1);

create unique index UX_Status_Status_name_Status_type
ON status ([status_name], [status_type])

select * from  dbo.country

INSERT INTO authors (first_name, last_name, birth_date, country_id, biography) VALUES
('Henryk', 'Sienkiewicz', '1846-05-05', 36, 'Polski powieściopisarz, nowelista, laureat Nagrody Nobla w dziedzinie literatury.'),
('Stephen', 'King', '1947-09-21', 37, 'Amerykański pisarz, autor horrorów, thrillerów i fantasy.'),
('Joanne', 'Rowling', '1965-07-31', 38, 'Brytyjska pisarka, autorka serii o Harrym Potterze.'),
('George', 'Orwell', '1903-06-25', 39, 'Brytyjski pisarz i publicysta, autor "Roku 1984".'),
('Fiodor', 'Dostojewski', '1821-11-11', 40, 'Rosyjski pisarz, autor "Zbrodni i kary".'),
('Haruki', 'Murakami', '1949-01-12', 41, 'Japoński pisarz i tłumacz.'),
('Gabriel', 'García Márquez', '1927-03-06', 42, 'Kolumbijski pisarz, laureat Nagrody Nobla w dziedzinie literatury.'),
('Umberto', 'Eco', '1932-01-05', 43, 'Włoski pisarz i filozof, autor "Imienia róży".'),
('Franz', 'Kafka', '1883-07-03', 44, 'Pisarz żydowskiego pochodzenia tworzący w języku niemieckim.'),
('Milan', 'Kundera', '1929-04-01', 45, 'Czeski pisarz i eseista.');



INSERT INTO books (title, isbn, publication_year, publisher, genre, available_copies, total_copies, status_id) VALUES
('Quo Vadis', '9788373271810', 1896, 'Gebethner i Wolff', 'powieść historyczna', 5, 5, 4),
('To', '9788382021964', 1986, 'Albatros', 'horror', 3, 3, 4),
('Harry Potter i Kamień Filozoficzny', '9788380080401', 1997, 'Media Rodzina', 'fantasy', 2, 2, 4),
('Rok 1984', '9788375060225', 1949, 'Muza', 'dystopia', 4, 4, 4),
('Zbrodnia i kara', '9788377792506', 1866, 'Znak', 'powieść psychologiczna', 3, 3, 4),
('Kafka nad morzem', '9788374801103', 2002, 'Muza', 'realizm magiczny', 2, 2, 4),
('Sto lat samotności', '9788373014416', 1967, 'Muza', 'realizm magiczny', 1, 1, 4),
('Imię róży', '9788371801403', 1980, 'NOIR SUR BLANC', 'powieść historyczna', 3, 3, 4),
('Proces', '9788375060478', 1925, 'Muza', 'powieść egzystencjalna', 2, 2, 4),
('Nieznośna lekkość bytu', '9788307028216', 1984, 'Państwowy Instytut Wydawniczy', 'powieść filozoficzna', 1, 1, 4);


INSERT INTO authorsBooks (author_id, book_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


select country, country_short,country_id from country 

UPDATE country
set country_short = 23, country ='chiny'
where country ='Polska'



select * from authors as A, country C where author_id = 40 and A.country_id =C.country


UPDATE A
set A.country_id = c.country_id
from authors as A
join country C on c.country_id = 40 AND c.country_id = A.country_id
