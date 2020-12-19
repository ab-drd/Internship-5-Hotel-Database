create table Hotels(
	Id int IDENTITY(1,1) PRIMARY KEY,
	[Name] nvarchar(64) NOT NULL,
	NumberOfRooms int NOT NULL,
	Adress nvarchar(64) NOT NULL,
	City nvarchar(64) NOT NULL,
	Zip nvarchar(5) NOT NULL,
	Phone nvarchar(7) NOT NULL
)

create table Employees(
	Id int IDENTITY(1,1) PRIMARY KEY,
	PayPerMonth int NOT NULL,
	FirstName nvarchar(32) NOT NULL,
	LastName nvarchar(32) NOT NULL,
	Position nvarchar(32) NOT NULL,
	OIB nvarchar(11) NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

create table Rooms(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Number int NOT NULL,
	Capacity int NOT NULL,
	Category nvarchar(32) NOT NULL,
	PricePerNight int NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

create table Reservations(
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstNameOfBuyer nvarchar(32) NOT NULL,
	LastNameOfBuyer nvarchar(32) NOT NULL,
	VisitType nvarchar(32) NOT NULL CHECK(VisitType IN ('Pension', 'Half-Pension', 'No Pension')),
	ReservationStart dateTime2 NOT NULL,
	ReservationEnd dateTime2 NOT NULL,
	DateOfTransaction dateTime2 NOT NULL,
	PaymentAmount int NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL
)

create table Guests(
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(32) NOT NULL,
	LastName nvarchar(32) NOT NULL,
	[Address] nvarchar(32) NOT NULL,
	City nvarchar(32) NOT NULL,
	ReservationId int FOREIGN KEY REFERENCES Reservations(Id) NOT NULL
)



insert into Hotels([Name], NumberOfRooms, Adress, City, Zip, Phone) VALUES
('Blu Resort', 100, 'Put Trstenika 19', 'Split', '21000', '303-030'),
('Hotel Pax', 50, 'Iza Bolnice 10c', 'Split', '21000', '280-887'),
('Amphora', 196, 'Znjan 22', 'Split', '21000', '222-111'),
('Flora', 20, 'Palme 15', 'Dubrovnik', '20000', '215-231'),
('San Antonio', 69, 'Grljevacka 30', 'Podstrana', '21312', '336-111')

insert into Employees(FirstName, LastName, PayPerMonth, Position, OIB, HotelId) VALUES
('Mario', 'Maric', 2000, 'Cistac', '65734587567', 1),
('Ante', 'Laos', 6000, 'Zastitar', '32058395061', 3),
('Ana', 'Anicic', 1500, 'Cistac', '94028374051', 2),
('Linda', 'Ratkovic', 4000, 'Recepcionar', '84957230691', 5),
('Paola', 'Matic', 8000, 'Recepcionar', '86720394012', 4)

insert into Employees(FirstName, LastName, PayPerMonth, Position, OIB, HotelId) VALUES
('Matej', 'Barbic', 3000, 'Sobna posluga', '83940128453', 1),
('Luka', 'Nisam', 3000, 'Sobna posluga', '93840167934', 1)

insert into Rooms(Number, Capacity, Category, PricePerNight, HotelId) VALUES
(203, 3, 'Triple', 500, 3),
(506, 2, 'Queen', 1000, 2),
(101, 2, 'King', 1100, 1),
(704, 1, 'Single', 700, 4),
(201, 2, 'Double', 200, 5),
(202, 2, 'King', 700, 2)

insert into Reservations(FirstNameOfBuyer, LastNameOfBuyer, VisitType, DateOfTransaction, PaymentAmount, ReservationStart, ReservationEnd, RoomId) VALUES
('Kristina', 'Plokic', 'Pension', '2019-12-13 12:00', 1400, '2019-12-15 14:00', '2019-12-17 10:00', 4),
('Leo', 'Grljic', 'Half-Pension', '2020-06-10 13:47', 700, '2020-07-13 14:00', '2020-07-14 10:00', 4),
('Ela', 'Bagranic', 'No Pension', '2020-12-10 23:11', 3300, '2020-12-27 14:00', '2020-12-30 10:00', 3),
('Ante', 'Peljko', 'Pension', '2020-01-14 22:06', 800, '2020-02-13 14:00', '2020-02-17 11:00', 5),
('Lara', 'Krkec', 'Pension', '2020-12-12 8:32', 1000, '2020-12-15 14:00', '2020-12-17 10:00', 1)

insert into Guests(FirstName, LastName, [Address], City, ReservationId) VALUES
('Maja', 'Majic', 'Tomislav 40', 'Sibenik', 3),
('Helda', 'Peji', 'Cesta 22', 'Omis', 5),
('William', 'Moni', 'Radiceva 12', 'Split', 5),
('Josip', 'Vacic', 'Mosorska 67', 'Podstrana', 2),
('Nasko', 'Rurand', 'Gospe u siti 22', 'Jesenice', 4)



SELECT * FROM Rooms WHERE HotelId = 2 ORDER BY Number

SELECT * FROM Rooms WHERE Number LIKE '1%'

SELECT FirstName, LastName FROM Employees WHERE HotelId = 1 AND Position = 'Cistac'

SELECT * FROM Reservations WHERE DateOfTransaction > '2020-12-01' AND PaymentAmount >= 1000

SELECT * FROM Reservations WHERE ReservationStart < GETDATE() AND ReservationEnd > GETDATE()

DELETE FROM Guests WHERE ReservationId in (1, 2, 4)
DELETE FROM Reservations WHERE DateOfTransaction < '2020-12-01'

UPDATE Hotels SET NumberOfRooms = 4 WHERE Id = 2 AND NumberOfRooms = 3

SELECT * FROM Reservations WHERE RoomId = 4 ORDER BY ReservationStart

SELECT * FROM Reservations WHERE (VisitType = 'Pension' OR VisitType = 'Half-Pension') AND RoomId in (2, 6)

UPDATE Employees SET Position = 'Recepcionist', PayPerMonth = 4000 WHERE FirstName = 'Matej' AND LastName = 'Barbic'
UPDATE Employees SET Position = 'Recepcionist', PayPerMonth = 4000 WHERE FirstName = 'Luka' AND LastName = 'Nisam'