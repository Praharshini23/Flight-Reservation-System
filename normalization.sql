create database flightdb;
use flightdb;

CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female')),
    DOB DATE NOT NULL CHECK (YEAR(DOB) > 1900)
);
CREATE TABLE PassengerPhone (
    PassengerID INT,
    PhoneNo VARCHAR(15) NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Passenger (FirstName, LastName, Gender, DOB) VALUES
('Mary', 'Frost', 'Male', '1990-05-15'),
('Alice', 'Smith', 'Female', '1985-03-22'),
('Robert', 'Brown', 'Male', '1975-08-10'),
('Emily', 'Clark', 'Female', '1992-07-12'),
('Michael', 'Johnson', 'Male', '1988-01-05'),
('Amit', 'Sharma', 'Male', '1987-09-19'),
('Priya', 'Rao', 'Female', '1993-05-29'),
('Rajesh', 'Verma', 'Male', '1982-12-05'),
('Sneha', 'Patel', 'Female', '1996-04-11'),
('Vikram', 'Nair', 'Male', '1989-06-15');

INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (1, '9876543210');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (2, '9123456789'), (2, '9123456710');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (3, '9988776655');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (4, '9234567890');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (5, '9345678901'), (5, '9345678902');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (6, '9456123789');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (7, '9876543219');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (8, '9654321780'), (8, '9654321781');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (9, '9182736450');
INSERT INTO PassengerPhone (PassengerID, PhoneNo) VALUES (10, '9876543200');
SELECT
    p.PassengerID,
    p.FirstName,
    p.LastName,
    p.Gender,
    p.DOB,
    PP.PhoneNo
FROM
    Passenger AS p
JOIN
    PassengerPhone AS pp ON p.PassengerID = pp.PassengerID
ORDER BY
    p.PassengerID;



CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50) UNIQUE
);
CREATE TABLE Airport (
    AirportID CHAR(3) PRIMARY KEY,
    Airport_Name VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);
INSERT INTO Country (CountryID, CountryName) VALUES
(1, 'India'),
(2, 'USA'),
(3, 'UK'),
(4, 'UAE'),
(5, 'Qatar'),
(6, 'Japan'),
(7, 'Germany'),
(8, 'Singapore'),
(9, 'Australia');
INSERT INTO Airport (AirportID, Airport_Name, CountryID) VALUES
('DEL', 'Indira Gandhi International Airport', 1),
('JFK', 'John F. Kennedy International Airport', 2),
('LHR', 'Heathrow Airport', 3),
('DXB', 'Dubai International Airport', 4),
('DOH', 'Hamad International Airport', 5),
('ORD', 'O Hare International Airport', 2),
('HND', 'Haneda Airport', 6),
('FRA', 'Frankfurt Airport', 7),
('SIN', 'Changi Airport', 8),
('SYD', 'Sydney Airport', 9);
SELECT 
    a.AirportID,
    a.Airport_Name,
    c.CountryName AS Country
FROM 
    Airport a
JOIN 
    Country c ON a.CountryID = c.CountryID;
    
    
CREATE TABLE Airline_Master (
    AirlineID VARCHAR(5) PRIMARY KEY,
    Airline_Name VARCHAR(100) NOT NULL
);
CREATE TABLE Airline_Airport_Map (
    AirlineID VARCHAR(5),
    AirportID VARCHAR(10),
    PRIMARY KEY (AirlineID),
    FOREIGN KEY (AirlineID) REFERENCES Airline_Master(AirlineID),
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);
INSERT INTO Airline_Master (AirlineID, Airline_Name) VALUES
('6E', 'IndiGo'),
('AI', 'Air India'),
('EK', 'Emirates'),
('QR', 'Qatar Airways'),
('BA', 'British Airways'),
('SQ', 'Singapore Airlines'),
('AA', 'American Airlines'),
('UA', 'United Airlines'),
('JL', 'Japan Airlines'),
('LH', 'Lufthansa');
INSERT INTO Airline_Airport_Map (AirlineID, AirportID) VALUES
('6E', 'DEL'),
('AI', 'DEL'),
('EK', 'DXB'),
('QR', 'DOH'),
('BA', 'LHR'),
('SQ', 'SIN'),
('AA', 'JFK'),
('UA', 'ORD'),
('JL', 'HND'),
('LH', 'FRA');
SELECT 
    am.AirlineID,
    am.Airline_Name,
    aap.AirportID
FROM 
    Airline_Master am
JOIN 
    Airline_Airport_Map aap ON am.AirlineID = aap.AirlineID;


CREATE TABLE Flight_Master (
    FlightID VARCHAR(10) PRIMARY KEY,
    Flight_Name VARCHAR(100),
    Flight_Type VARCHAR(20),
    AirlineID VARCHAR(5),
    FOREIGN KEY (AirlineID) REFERENCES Airline_Master(AirlineID)
);
CREATE TABLE Flight_Route (
    FlightID VARCHAR(10),
    Source VARCHAR(10),
    Destination VARCHAR(10),
    PRIMARY KEY (FlightID),
    FOREIGN KEY (FlightID) REFERENCES Flight_Master(FlightID),
    FOREIGN KEY (Source) REFERENCES Airport(AirportID),
    FOREIGN KEY (Destination) REFERENCES Airport(AirportID)
);
INSERT INTO Flight_Master (FlightID, Flight_Name, Flight_Type, AirlineID) VALUES
('6E001', 'IndiGo Express', 'International', '6E'),
('6E002', 'IndiGo Express', 'International', '6E'),
('AA001', 'American Eagle', 'International', 'AA'),
('AA002', 'American Eagle', 'Domestic', 'AA'),
('QR001', 'Qatar Sky', 'International', 'QR'),
('QR002', 'Qatar Sky', 'International', 'QR'),
('UA001', 'United Dreamliner', 'International', 'UA'),
('UA002', 'United Dreamliner', 'International', 'UA'),
('EK001', 'Emirates SkyCargo', 'International', 'EK'),
('EK002', 'Emirates SkyCargo', 'International', 'EK');
INSERT INTO Flight_Route (FlightID, Source, Destination) VALUES
('6E001', 'DEL', 'JFK'),
('6E002', 'DEL', 'DXB'),
('AA001', 'JFK', 'LHR'),
('AA002', 'JFK', 'ORD'),
('QR001', 'DOH', 'DXB'),
('QR002', 'DOH', 'DEL'),
('UA001', 'ORD', 'HND'),
('UA002', 'ORD', 'SIN'),
('EK001', 'DXB', 'FRA'),
('EK002', 'DXB', 'SYD');
SELECT 
    fm.FlightID,
    fm.Flight_Name,
    fr.Source,
    fr.Destination,
    fm.Flight_Type,
    fm.AirlineID
FROM 
    Flight_Master fm
JOIN 
    Flight_Route fr ON fm.FlightID = fr.FlightID;


CREATE TABLE Flight_Capacity (
    Capacity INT
);
INSERT INTO Flight_Capacity VALUES (210);
CREATE TABLE Flight_Fare (
    FlightID VARCHAR(10),
    Fare DECIMAL(10,2)
);
INSERT INTO Flight_Fare (FlightID, Fare) VALUES
('6E001', 50000.00),
('6E002', 40000.00),
('AA001', 80000.00),
('AA002', 75000.00),
('QR001', 60000.00),
('QR002', 55000.00),
('UA001', 90000.00),
('UA002', 85000.00),
('EK001', 100000.00),
('EK002', 95000.00);
SELECT 
    fc.Capacity,
    ff.Fare,
    ff.FlightID
FROM 
    Flight_Capacity fc,
    Flight_Fare ff;


CREATE TABLE Flight_Schedule (
    FlightID VARCHAR(10),
    Date_Of_Flight DATE,
    Departure_Time_IST TIME,
    Arrival_Time_IST TIME,
    Duration INT,
    PRIMARY KEY (FlightID, Date_Of_Flight)
);
INSERT INTO Flight_Schedule VALUES
('6E001', '2025-03-10', '08:00:00', '20:00:00', 12),
('6E002', '2025-03-10', '12:00:00', '18:00:00', 6),
('AA001', '2025-03-11', '18:00:00', '23:00:00', 5),
('AA002', '2025-03-11', '22:00:00', '23:00:00', 1),
('QR001', '2025-03-12', '05:00:00', '07:00:00', 2),
('QR002', '2025-03-12', '09:00:00', '15:00:00', 6),
('UA001', '2025-03-13', '10:00:00', '18:00:00', 8),
('UA002', '2025-03-13', '08:00:00', '22:00:00', 14),
('EK001', '2025-03-14', '13:00:00', '20:00:00', 7),
('EK002', '2025-03-14', '19:00:00', '23:00:00', 4);


CREATE TABLE SeatType (
    SeatTypeID INT PRIMARY KEY AUTO_INCREMENT,
    Seat_Type VARCHAR(20) UNIQUE
);
INSERT INTO SeatType (Seat_Type) VALUES
('Economy Class'),
('Business Class'),
('First Class');
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    Seat_Number VARCHAR(5),
    SeatTypeID INT,
    PassengerID INT,
    FlightID VARCHAR(10),
    FOREIGN KEY (SeatTypeID) REFERENCES SeatType(SeatTypeID)
    
);
INSERT INTO Ticket (Seat_Number, SeatTypeID, PassengerID, FlightID) VALUES
('1A', 1, 1, '6E001'),    
('2B', 1, 2, '6E002'),
('3C', 1, 3, 'AA001'),
('4D', 1, 4, 'AA002'),
('5E', 1, 5, 'QR001'),
('10J', 3, 6, 'QR002'),   
('11K', 3, 7, 'UA001'),
('20S', 2, 8, 'UA002'),  
('21T', 2, 9, 'EK001'),
('22U', 2, 10, 'EK002');


CREATE TABLE MealType (
    MealTypeID INT PRIMARY KEY AUTO_INCREMENT,
    Meal_Type VARCHAR(20) UNIQUE
);
INSERT INTO MealType (Meal_Type) VALUES
('Veg'),
('Non Veg'),
('Vegan');
CREATE TABLE Meal_Service (
    ServiceID INT PRIMARY KEY AUTO_INCREMENT,
    TicketID INT,
    MealTypeID INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (MealTypeID) REFERENCES MealType(MealTypeID)
);
INSERT INTO Meal_Service (TicketID, MealTypeID, Price) VALUES
(1, 1, 500.00),
(2, 2, 700.00),
(3, 3, 600.00),
(4, 2, 750.00),
(5, 1, 550.00),
(6, 3, 620.00),
(7, 2, 800.00),
(8, 1, 520.00),
(9, 3, 610.00),
(10, 2, 770.00);
SELECT
  ms.ServiceID,
  t.TicketID,
  mt.MealTypeID,
  mt.Meal_Type,
  ms.Price
FROM
  Meal_Service AS ms
JOIN
  MealType AS mt ON ms.MealTypeID = mt.MealTypeID
JOIN 
  Ticket AS t ON ms.TicketID = t.TicketID
ORDER BY ServiceID;


CREATE TABLE Checkin (
    CheckinID INT PRIMARY KEY AUTO_INCREMENT,
    TicketID INT,
    Checkin_Date DATE,
    Checkin_Status VARCHAR(20),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);
CREATE TABLE CheckinStatus (
    StatusID INT PRIMARY KEY AUTO_INCREMENT,
    Status_Text VARCHAR(20) UNIQUE
);
INSERT INTO CheckinStatus (StatusID, Status_Text) VALUES
(1, 'Checked In'),
(2, 'Pending');
INSERT INTO Checkin (CheckinID, TicketID, Checkin_Date, Checkin_Status) VALUES
(1, 1, '2025-03-09', 'Checked In'),
(2, 2, '2025-03-09', 'Checked In'),
(3, 3, '2025-03-10', 'Checked In'),
(4, 4, '2025-03-10', 'Checked In'),
(5, 5, '2025-03-11', 'Checked In'),
(6, 6, '2025-03-11', 'Pending'),
(7, 7, '2025-03-12', 'Pending'),
(8, 8, '2025-03-12', 'Pending'),
(9, 9, '2025-03-13', 'Pending'),
(10, 10, '2025-03-13', 'Pending');
SELECT 
    c.CheckinID,
    c.TicketID,
    c.Checkin_Date,
    s.Status_Text AS Status
FROM 
    Checkin c
INNER JOIN 
    CheckinStatus s ON c.Checkin_Status = s.Status_Text;


CREATE TABLE Baggage (
    No_of_bags INT,
    Weight_kg DECIMAL(10, 2),
    PassengerID INT,
    FlightID VARCHAR(10),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
    
);
INSERT INTO Baggage (No_of_bags, Weight_kg, PassengerID, FlightID) VALUES
(2, 23.50, 1, '6E001'),
(1, 15.20, 2, '6E002'),
(3, 20.75, 3, 'AA001'),
(1, 18.00, 4, 'AA002'),
(2, 22.00, 5, 'QR001'),
(1, 19.80, 6, 'QR002'),
(4, 24.50, 7, 'UA001'),
(2, 21.00, 8, 'UA002'),
(3, 23.00, 9, 'EK001'),
(1, 17.50, 10, 'EK002');


CREATE TABLE Reservation (
    Date_of_Travel DATE,
    Booking_Status VARCHAR(20),
    PassengerID INT,
    TicketID INT,
    PRIMARY KEY (TicketID, PassengerID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);
INSERT INTO Reservation (Date_of_Travel, Booking_Status, PassengerID, TicketID) VALUES
('2025-03-10', 'Confirmed', 1, 1),
('2025-03-10', 'Pending', 2, 2),
('2025-03-11', 'Confirmed', 3, 3),
('2025-03-11', 'Confirmed', 4, 4),
('2025-03-12', 'Pending', 5, 5),
('2025-03-12', 'Confirmed', 6, 6),
('2025-03-13', 'Pending', 7, 7),
('2025-03-13', 'Confirmed', 8, 8),
('2025-03-14', 'Pending', 9, 9),
('2025-03-14', 'Confirmed', 10, 10);
SELECT 
  T.TicketID,
  T.Seat_Number,
  ST.Seat_Type,
  T.PassengerID,
  T.FlightID
FROM Ticket T
JOIN SeatType ST ON T.SeatTypeID = ST.SeatTypeID;



CREATE TABLE Lounge (
    Lounge_Number INT PRIMARY KEY,
    Lounge_Type VARCHAR(50),
    AirportID VARCHAR(10),
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);
CREATE TABLE Lounge_Access (
    AirportID VARCHAR(10),
    PassengerID INT,
    PRIMARY KEY (AirportID, PassengerID),
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Lounge (Lounge_Number, Lounge_Type, AirportID) VALUES
(101, 'Business Class Lounge', 'JFK'),
(102, 'Economy Class Lounge', 'DXB'),
(103, 'First Class Lounge', 'LHR'),
(104, 'Economy Class Lounge', 'ORD'),
(105, 'Business Class Lounge', 'DXB'),
(106, 'First Class Lounge', 'DEL'),
(107, 'Economy Class Lounge', 'HND'),
(108, 'Business Class Lounge', 'SIN'),
(109, 'First Class Lounge', 'FRA'),
(110, 'Economy Class Lounge', 'SYD');
INSERT INTO Lounge_Access (AirportID, PassengerID) VALUES
('JFK', 1),
('DXB', 2),
('LHR', 3),
('ORD', 4),
('DXB', 5),
('DEL', 6),
('HND', 7),
('SIN', 8),
('FRA', 9),
('SYD', 10);


CREATE TABLE Loyalty_Program (
    Membership_Type VARCHAR(50),
    Points_Earned INT,
    PassengerID INT,
    PRIMARY KEY (PassengerID, Membership_Type),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Loyalty_Program (Membership_Type, Points_Earned, PassengerID) VALUES
('First', 500, 1),
('Second', 300, 2),
('Third', 200, 3),
('First', 700, 4),
('Second', 400, 5),
('Third', 250, 6),
('First', 800, 7),
('Second', 450, 8),
('Third', 300, 9),
('First', 900, 10);


CREATE TABLE Complaint (
    Complaint_Type VARCHAR(100),
    Complaint_Status VARCHAR(50),
    Date_of_Complaint DATE,
    PassengerID INT,
    PRIMARY KEY (Complaint_Type, PassengerID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Complaint (Complaint_Type, Complaint_Status, Date_of_Complaint, PassengerID) VALUES
('Toilet', 'Resolved', '2025-01-01', 1),
('Water Leak', 'In Progress', '2025-01-02', 2),
('Seats', 'Resolved', '2025-01-03', 3),
('Tables', 'In Progress', '2025-01-04', 4),
('Water Leak', 'Resolved', '2025-01-05', 5),
('Toilet', 'In Progress', '2025-01-06', 6),
('Seats', 'Resolved', '2025-01-07', 7),
('Tables', 'In Progress', '2025-01-08', 8),
('Water Leak', 'Resolved', '2025-01-09', 9),
('Toilet', 'In Progress', '2025-01-10', 10);


CREATE TABLE Travel_Insurance (
    Policy_Type VARCHAR(50) CHECK (Policy_Type IN ('GOLD','SILVER','BRONZE')),
    Expiry_Date DATE,
    Amount INT,
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Travel_Insurance (Policy_Type, Expiry_Date, Amount, PassengerID) VALUES
('GOLD', '2025-12-31', 5000, 1),
('SILVER', '2025-11-15', 3000, 2),
('BRONZE', '2025-10-10', 2000, 3),
('GOLD', '2025-09-20', 5000, 4),
('SILVER', '2025-08-25', 3000, 5),
('BRONZE', '2025-07-30', 2000, 6),
('GOLD', '2025-06-05', 5000, 7),
('SILVER', '2025-05-10', 3000, 8),
('BRONZE', '2025-04-15', 2000, 9),
('GOLD', '2025-03-20', 5000, 10);


CREATE TABLE Rating (
    PassengerID INT NOT NULL,
    FlightID VARCHAR(10) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID) 
);
INSERT INTO Rating (PassengerID, FlightID, Rating) VALUES
(1, '6E001', 5),
(2, '6E002', 4),
(3, 'AA001', 3),
(4, 'AA002', 5),
(5, 'QR001', 4),
(6, 'QR002', 3),
(7, 'UA001', 5),
(8, 'UA002', 4),
(9, 'EK001', 5),
(10,'EK002', 4);



CREATE TABLE Membership (
    Membership_Type VARCHAR(20) PRIMARY KEY,
    Points INT
);
CREATE TABLE Passenger_Loyalty (
    PassengerID INT PRIMARY KEY,
    Membership_Type VARCHAR(20),
    Expiry_Date DATE,
    FOREIGN KEY (Membership_Type) REFERENCES Membership(Membership_Type),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Membership VALUES
('GOLD', 5000),
('SILVER', 3000),
('BRONZE', 2000);
INSERT INTO Passenger_Loyalty VALUES
(1, 'GOLD', '2025-12-31'),
(2, 'SILVER', '2025-11-15'),
(3, 'BRONZE', '2025-10-10'),
(4, 'GOLD', '2025-09-20'),
(5, 'SILVER', '2025-08-25'),
(6, 'BRONZE', '2025-07-30'),
(7, 'GOLD', '2025-06-05'),
(8, 'SILVER', '2025-05-10'),
(9, 'BRONZE', '2025-04-15'),
(10, 'GOLD', '2025-03-20');

SELECT 
    pl.PassengerID,
    pl.Membership_Type,
    m.Points,
    pl.Expiry_Date
FROM 
    Passenger_Loyalty pl
JOIN 
    Membership m ON pl.Membership_Type = m.Membership_Type;

