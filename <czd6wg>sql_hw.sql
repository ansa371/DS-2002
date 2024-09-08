/* World:
Easy
1. all countries in south america */ 
SELECT Name from country WHERE Continent = 'South America';

/* 2. Find the population of Germany. */ 
SELECT Population from country WHERE Name = 'Germany';

/* 3. All cities in country japan*/
SELECT Name FROM city WHERE CountryCode = 'JPN';

/* Medium
 4. 3 most populated countries in the ‘Africa’ region */
SELECT Name, Population FROM country WHERE Continent = 'Africa'
	ORDER BY Population DESC LIMIT 3;

/* 5. country and life expectancy where population is between 1 and 5 million */
SELECT Name, LifeExpectancy FROM country 
	WHERE Population BETWEEN 1000000 AND 5000000;

/*6. Countries with an official language of ‘french’. */
SELECT country.Name FROM country
	JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
	WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';

/* Chinook:

Easy
7.	All album titles by artists ‘AC/DC’ */
SELECT Title FROM Album
	JOIN Artist ON Album.ArtistId = Artist.ArtistId
	WHERE Artist.Name = 'AC/DC';

/* 8.	Name and email of customers located in ‘brazil’. */
SELECT FirstName, LastName, Email FROM Customer WHERE Country = 'Brazil';

/* 9.	All playlists in database. */
SELECT Name FROM Playlist;

/* Medium
10.	Total number of tracks in ‘rock’ genre */
SELECT COUNT(*) FROM Track
	JOIN Genre ON Track.GenreId = Genre.GenreId
	WHERE Genre.Name = 'Rock';

/* 11.	 All employees who report to ‘Nancy Edwards’ */
SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (
    SELECT EmployeeId FROM Employee WHERE
FirstName = 'Nancy' AND LastName = 'Edwards');

/* 12.	 Total sales per customer by summing the total amount in invoices */

SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TotalSales FROM Invoice
	JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
	GROUP BY Customer.CustomerId, Customer.FirstName, Customer.LastName;

/* PART 2 */
CREATE TABLE Authors (
    AuthorId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);
CREATE TABLE Books (
    BookId INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorId INT,
    FOREIGN KEY (AuthorId) REFERENCES Authors(AuthorId)
);
CREATE TABLE Volumes (
    VolumeId INT AUTO_INCREMENT PRIMARY KEY,
    BookId INT,
    VolumeNumber INT NOT NULL,
    VolumeTitle VARCHAR(255) NOT NULL,
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
);
CREATE TABLE VolumeSales (
    SaleId INT AUTO_INCREMENT PRIMARY KEY,
    VolumeId INT,
    SaleDate DATE,
    Quantity INT NOT NULL,
    Sale DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (VolumeId) REFERENCES Volumes(VolumeId)
);

INSERT INTO Authors (Name) VALUES
('Xie Lu'),
('Priest'),
('Tang Jia San Shao'),
('Hu Dielan'),
('Cuttlefish that loves Diving');

INSERT INTO Books (Title, AuthorID) VALUES
('The Grave Robbers Chronicles', 1),
('The legend of Fei', 2),
('Douluo Continent', 3),
('The Kings Avatar', 4),
('Lord of the Mysteries', 5);

INSERT INTO Volumes(BookID, VolumeNumber, VolumeTitle) VALUES
(1, 1, 'Cavern of the Blood Zombies'),
(1, 2, 'Angry Sea, Hidden Sands'),
(1, 3, 'Bronze Tree of Death'),
(1, 4, 'Palace of Doom'),
(1, 5, 'Deadly Desert Winds'),
(1, 6, 'Graveyard of a Queen');

INSERT INTO VolumeSales(VolumeID, SaleDate, Quantity, Sale) VALUES
(1, '2020-12-01', 5000, 10000),
(2, '2021-05-01', 6000, 12000),
(3, '2021-12-01', 10000, 20000),
(4, '2022-05-01', 15000, 30000),
(5, '2022-12-01', 15000, 30000),
(6, '2023-05-01', 20000, 40000);

/* QUERIES
1. a list of all authors */

SELECT Name FROM Authors;

/* 2. get all volumes of the grave robbers chronicles. */

SELECT VolumeNumber, VolumeTitle FROM Volumes
	JOIN Books ON Volumes.BookID = Books.BookId WHERE Books.Title = 'The Grave Robbers Chronicles' ;

/*3. total sales for the grave robbers chronicles. */

SELECT Books.Title, SUM(VolumeSales.Sale) AS TotalSales FROM Books
	JOIN Volumes ON Books.BookId = Volumes.BookId
    JOIN VolumeSales ON Volumes.VolumeId = VolumeSales.VolumeId
    GROUP BY Books.Title;