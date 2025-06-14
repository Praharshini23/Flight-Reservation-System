CREATE DATABASE FlightReservationDB;

USE FlightReservationDB;

-- Passenger Table
CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNo1 VARCHAR(15) NOT NULL,
	PhoneNo2 VARCHAR(15),
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female')),
    DOB DATE NOT NULL CHECK (YEAR(DOB) > 1900)
);

-- Airport Table
CREATE TABLE Airport (
    AirportID VARCHAR(10) PRIMARY KEY,
    Airport_Name VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
);

-- Airline Table
CREATE TABLE Airline (
    AirlineID VARCHAR(10) PRIMARY KEY ,
    Airline_Name VARCHAR(100) NOT NULL,
    AirportID VARCHAR(10) NOT NULL,
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

-- Flight Table
CREATE TABLE Flight (
    FlightID VARCHAR(10) PRIMARY KEY ,
    Flight_Name VARCHAR(100) NOT NULL,
    Source VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
	Flight_Type VARCHAR(20) NOT NULL CHECK (Flight_Type IN ('International', 'Domestic')),
    AirlineID VARCHAR(10) NOT NULL,
    FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID)
    
);

-- Flight Details Table
CREATE TABLE Flight_Details (
    Capacity INT NOT NULL CHECK (Capacity BETWEEN 50 AND 800) ,
    Fare DECIMAL(10,2) NOT NULL,
    FlightID VARCHAR(10) NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- Flight Schedule Table
CREATE TABLE Flight_Schedule (
    FlightID VARCHAR(10) NOT NULL,
    Date_Of_Flight DATE NOT NULL,
    Departure_Time_IST TIME NOT NULL,
    Arrival_Time_IST TIME NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- Ticket Table
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    Seat_Number VARCHAR(10) NOT NULL,
    Seat_Type VARCHAR(20) NOT NULL CHECK (Seat_Type IN ('Business Class', 'First Class', 'Economy Class')),
    PassengerID INT NOT NULL,
    FlightID VARCHAR(10) NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
	UNIQUE (FlightID, Seat_Number)
);

-- Meal Service Table
CREATE TABLE Meal_Service (
    Meal_Type VARCHAR(50) CHECK (Meal_Type IN ('Veg', 'Non Veg', 'Vegan') OR Meal_Type IS NULL),
    Price DECIMAL(9,2),
    TicketID INT,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- Check-in Table
CREATE TABLE Checkin (
    Checkin_Date DATE NOT NULL,
    Checkin_Status VARCHAR(20) NOT NULL CHECK (Checkin_Status IN ('Checked In', 'Pending')),
    TicketID INT NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- Baggage Table
CREATE TABLE Baggage (
    No_of_bags INT CHECK (No_of_bags BETWEEN 1 AND 5),
    Weight_kg DECIMAL(4,2) CHECK (Weight_kg < 25),
    PassengerID INT,
    FlightID VARCHAR(10),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- Reservation Table
CREATE TABLE Reservation (
    Date_of_Travel DATE NOT NULL,
    Booking_Status VARCHAR(20) NOT NULL CHECK (Booking_Status IN ('Confirmed','Pending')),
    PassengerID INT NOT NULL,
    TicketID INT NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- Lounge Access Table
CREATE TABLE Lounge_Access (
    Lounge_Number INT,
    Lounge_Type VARCHAR(50) CHECK (Lounge_Type IN ('Business Class Lounge', 'First Class Lounge', 'Economy Class Lounge') OR Lounge_Type IS NULL),
    AirportID VARCHAR(10),
    PassengerID INT,
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- Loyalty Program Table
CREATE TABLE Loyalty_Program (
    Membership_Type VARCHAR(50) CHECK (Membership_Type IN ('First','Second','Third') OR Membership_Type IS NULL),
    Points_Earned INT,
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- Complaint Table
CREATE TABLE Complaint (
    Complaint_Type VARCHAR(100),
    Complaint_Status VARCHAR(50) CHECK (Complaint_Status IN ('Resolved', 'In Progress') OR Complaint_Status IS NULL),
    Date_of_Complaint DATE,
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- Travel Insurance Table
CREATE TABLE Travel_Insurance (
    Policy_Type VARCHAR(50) CHECK (Policy_Type IN ('GOLD','SILVER','BRONZE')),
    Expiry_Date DATE,
    Amount INT,
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- Rating Table
CREATE TABLE Rating (
    PassengerID INT NOT NULL,
    FlightID VARCHAR(10) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID) ,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID) 
);

