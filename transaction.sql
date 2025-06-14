
-- 2
START TRANSACTION;

INSERT INTO Passenger (FirstName, LastName, Gender, DOB) 
VALUES ('Jake', 'matthew', 'Male', '1990-10-10');

INSERT INTO PassengerPhone (PassengerID, PhoneNo) 
VALUES (LAST_INSERT_ID(), '9998887777');

COMMIT;

-- 1
START TRANSACTION;

INSERT INTO Airline_Master (AirlineID, Airline_Name)
VALUES ('AF', 'Air France');

COMMIT;

-- 4
START TRANSACTION;

INSERT INTO Flight_Master (FlightID, Flight_Name, Flight_Type, AirlineID)
VALUES ('AF002', 'Air France Flight', 'International', 'AF');

COMMIT;



-- 5
START TRANSACTION;

INSERT INTO Flight_Schedule (FlightID, Date_Of_Flight, Departure_Time_IST, Arrival_Time_IST, Duration)
VALUES ('AF001', '2025-04-01', '09:00:00', '17:00:00', 8);

COMMIT;

-- 3
START TRANSACTION;
INSERT INTO Lounge_Access (AirportID, PassengerID) VALUES ('JFK', 2);

INSERT INTO Rating (PassengerID, FlightID, Rating) VALUES (10, '6E001', 4);

COMMIT;

-- 6
START TRANSACTION;
UPDATE Passenger SET DOB=1987-10-27 WHERE PassengerID=4;

INSERT INTO Meal_Service (TicketID, MealTypeID, Price) VALUES
(1, 1, 500.00);

COMMIT;

-- 7
START TRANSACTION;

UPDATE Checkin SET Checkin_Status = 'Pending' WHERE TicketID=4;

UPDATE Reservation SET Booking_Status = 'Confirmed' WHERE PassengerID=2;

COMMIT;

-- 1
START TRANSACTION;

INSERT INTO Meal_Service (TicketID, MealTypeID, Price) VALUES
(9, 1, 500.00);

ROLLBACK;

-- 2
START TRANSACTION;

UPDATE Flight_Master
SET Flight_Name = 'Indigo Air'
WHERE FlightID = '6E001';

ROLLBACK;

-- 3
START TRANSACTION;

DELETE FROM flight_Schedule
WHERE FlightID = 'QR001';

ROLLBACK;

-- 4
START TRANSACTION;

INSERT INTO Flight_Master (FlightID, Flight_Name, SourceAirport, DestinationAirport)
VALUES ('6E003', 'IndiGo', 'DEL', 'BOM');

ROLLBACK;

-- 5
START TRANSACTION;
INSERT INTO flight (FlightID, AirlineName, SourceAirport, DestinationAirport)
VALUES ('AA003', 'Air India', 'BLR', 'DEL');

ROLLBACK;

ROLLBACK;

-- 6
START TRANSACTION;

UPDATE Passenger SET DOB='1987-10-27' WHERE PassengerID=5;

ROLLBACK;


-- 7
START TRANSACTION;

INSERT INTO PassengerPhone (PassengerID, PhoneNo) 
VALUES (2, '8529764529');

ROLLBACK;
DELETE FROM Country WHERE CountryID = 10;
-- 1
START TRANSACTION;

INSERT INTO Country (CountryID, CountryName) 
VALUES (10, 'Canada');

SAVEPOINT after_country_insert;

INSERT INTO Country (CountryID, CountryName) 
VALUES (11, 'France');

ROLLBACK TO SAVEPOINT after_country_insert;

COMMIT;

-- 2
START TRANSACTION;

INSERT INTO Airline_Master (AirlineID, Airline_Name) 
VALUES ('AC', 'Air Canada');

SAVEPOINT after_airline_insert;

INSERT INTO Airline_Master (AirlineID, Airline_Name) 
VALUES ('VX', 'Vistara');

ROLLBACK TO SAVEPOINT after_airline_insert;
ROLLBACK;
INSERT INTO Airline_Master (AirlineID, Airline_Name) 
VALUES ('VS', 'Vistara');

COMMIT;

-- 3
START TRANSACTION;

INSERT INTO Flight_Route (FlightID, Source, Destination)
VALUES ('AF001', 'FRA', 'LHR');

SAVEPOINT after_flight_route;

INSERT INTO Flight_Route (FlightID, Source, Destination)
VALUES ('AF002', 'YYZ', 'DEL');

ROLLBACK TO SAVEPOINT after_flight_route;

INSERT INTO Flight_Route (FlightID, Source, Destination)
VALUES ('AF002', 'YYZ', 'FRA');

COMMIT;

-- 4
START TRANSACTION;

INSERT INTO Meal_Service ( TicketID ,MealTypeID, Price)
VALUES (11,1, 500);

SAVEPOINT after_meal_insert;

INSERT INTO Meal_Service (TicketID, MealTypeID, Price)
VALUES (14,1,800);

ROLLBACK TO SAVEPOINT after_meal_insert;

INSERT INTO Meal_Service (TicketID, MealTypeID, Price)
VALUES (14,1,300);

COMMIT;

-- 5
START TRANSACTION;

INSERT INTO Airline_Airport_Map (AirlineID, AirportID) 
VALUES ('AF', 'FRA');

SAVEPOINT after_airport_map;

INSERT INTO Airline_Airport_Map (AirlineID, AirportID) 
VALUES ('AC', 'DEL');

ROLLBACK TO SAVEPOINT after_airport_map;

INSERT INTO Airline_Airport_Map (AirlineID, AirportID) 
VALUES ('AC', 'YYZ');

COMMIT;
ROLLBACK;
-- 6
START TRANSACTION;

INSERT INTO Airport (AirportID, Airport_Name, CountryID) 
VALUES ('YYZ', 'Toronto Airport', 10);

SAVEPOINT after_airport_insert;

INSERT INTO Airport (AirportID, Airport_Name, CountryID) 
VALUES ('HD', 'Rajiv Gandhi', 1);

ROLLBACK TO SAVEPOINT after_airport_insert;

INSERT INTO Airport (AirportID, Airport_Name, CountryID) 
VALUES ('HYD', 'Rajiv Gandhi', 1);

COMMIT;


-- 7
START TRANSACTION;

INSERT INTO Rating (PassengerID, FlightID, Rating)
VALUES (11, 'AC001', 4);

SAVEPOINT after_rating_insert;

INSERT INTO Rating (PassengerID, FlightID, Rating)
VALUES (14, 'AC001', 5);

ROLLBACK TO SAVEPOINT after_rating_insert;

INSERT INTO Rating (PassengerID, FlightID, Rating)
VALUES (14, 'AC001', 4);


COMMIT;


rollback;


