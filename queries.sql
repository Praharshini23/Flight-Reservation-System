USE FlightReservationDB;

-- SIMPLE QUERIES
-- 1.Retrieve all passengers
SELECT * FROM Passenger;

-- 2. Find all flights departing from 'DEL'
SELECT * FROM Flight WHERE Source = 'DEL';

-- 3. Find all airlines operating from a specific airport
SELECT AirlineID,Airline_Name FROM Airline WHERE AirportID = 'JFK';

-- 4. Get the details of meals served on a specific ticket
SELECT * FROM Meal_Service WHERE TicketID = 3;

-- 5. Find passengers with a last name 'Smith'
SELECT * FROM Passenger WHERE LastName = 'Smith';

-- 6. Retrieve all flights operated by 'IndiGo'
SELECT * FROM Flight WHERE AirlineID = '6E';

-- 7. Find all flights scheduled for '2025-03-10'
SELECT * FROM Flight_Schedule WHERE Date_Of_Flight = '2025-03-10';

-- 8. Retrieve all baggage details for a specific passenger
SELECT * FROM Baggage WHERE PassengerID = 2;

-- 9. Find all airports in the USA
SELECT * FROM Airport WHERE Country = 'USA';

-- 10. Retrieve flights with fare greater than 50,000
SELECT * FROM Flight_Details WHERE Fare > 50000;

-- JOIN QUERIES
-- 1. Flights with their capacity and fare details
SELECT f.*, fd.Capacity, fd.Fare
FROM Flight f
JOIN Flight_Details fd ON f.FlightID = fd.FlightID;

-- 2. Get flight details along with airline names
SELECT F.FlightID, F.Source, F.Destination, A.Airline_Name 
FROM Flight F
JOIN Airline A ON F.AirlineID = A.AirlineID;

-- 3. Show all flight reservations along with passenger and flight details
SELECT T.TicketID, P.FirstName AS Passenger_Name, F.Source, F.Destination, T.Seat_Type
FROM Ticket T
JOIN Passenger P ON T.PassengerID = P.PassengerID
JOIN Flight F ON T.FlightID = F.FlightID;

-- 4. Get all flights along with their schedules
SELECT F.FlightID, F.Source, F.Destination, S.Date_Of_Flight, S.Departure_Time_IST, S.Arrival_Time_IST
FROM Flight F
JOIN Flight_Schedule S ON F.FlightID = S.FlightID;

-- 5.Show passengers who have booked flights along with their contact details
SELECT P.PassengerID, P.FirstName, P.Phoneno1, T.FlightID 
FROM Passenger P
JOIN Ticket T ON P.PassengerID = T.PassengerID;

-- 6. Find flights that depart from a specific airport along with airline details
SELECT F.FlightID, F.Source, A.Airport_Name, AL.Airline_Name 
FROM Flight F
JOIN Airport A ON F.Source = A.AirportID
JOIN Airline AL ON F.AirlineID = AL.AirlineID;

-- 7. Get flights along with their corresponding destination airports
SELECT F.FlightID, F.Source, F.Destination, A.Airport_Name AS Destination_Airport 
FROM Flight F
JOIN Airport A ON F.Destination = A.AirportID;

-- 8. Passengers with their ticket information 
SELECT p.*, t.TicketID, t.Seat_Number, t.Seat_Type
FROM Passenger p
JOIN Ticket t ON p.PassengerID = t.PassengerID;

-- 9. Tickets with check-in status
SELECT t.*, c.Checkin_Date, c.Checkin_Status
FROM Ticket t
JOIN Checkin c ON t.TicketID = c.TicketID;  

-- 10. Passengers with their travel insurance information
SELECT p.*, ti.Policy_Type, ti.Expiry_Date, ti.Amount
FROM Passenger p
JOIN Travel_Insurance ti ON p.PassengerID = ti.PassengerID;

-- 11. LEFT JOIN: Get all passengers and their ticket details (if any)
SELECT p.FirstName, p.LastName, t.TicketID, t.Seat_Number
FROM Passenger p
LEFT JOIN Ticket t ON p.PassengerID = t.PassengerID;

-- 12. RIGHT JOIN: all tickets and their passenger details 
SELECT p.FirstName, p.LastName, t.TicketID, t.Seat_Number
FROM Passenger p
RIGHT JOIN Ticket t ON p.PassengerID = t.PassengerID;

-- 13. INNER JOIN:passengers who have tickets, and their ticket details
SELECT p.FirstName, p.LastName, t.TicketID, t.Seat_Number
FROM Passenger p
INNER JOIN Ticket t ON p.PassengerID = t.PassengerID;

-- 14. SELF JOIN: Find pairs of flights with the same source airport.
SELECT f1.Flight_Name AS Flight1, f2.Flight_Name AS Flight2, f1.Source
FROM Flight f1
JOIN Flight f2 ON f1.Source = f2.Source
WHERE f1.FlightID < f2.FlightID; 

-- 15. FULL OUTER JOIN all passengers and all tickets, matching 
SELECT p.FirstName, p.LastName, t.TicketID, t.Seat_Number
FROM Passenger p
LEFT JOIN Ticket t ON p.PassengerID = t.PassengerID
UNION
SELECT p.FirstName, p.LastName, t.TicketID, t.Seat_Number
FROM Passenger p
RIGHT JOIN Ticket t ON p.PassengerID = t.PassengerID
WHERE p.PassengerID IS NULL;

-- SET OPERATION QUERIES
-- 1. List all source and destination airports (UNION)
SELECT Source AS Airport FROM Flight
UNION
SELECT Destination FROM Flight;

-- 2. Find all flights that are either scheduled or already booked (UNION)
SELECT FlightID FROM Flight_Schedule
UNION
SELECT FlightID FROM Ticket;

-- 3.Combine domestic and international flights
SELECT FlightID, Flight_Name, 'Domestic' AS Flight_Category
FROM Flight
WHERE Flight_Type = 'Domestic'
UNION
SELECT FlightID, Flight_Name, 'International' AS Flight_Category
FROM Flight
WHERE Flight_Type = 'International';

-- 4. All passengers with both phone numbers (including duplicates)
SELECT PassengerID, FirstName, LastName, PhoneNo1 AS PhoneNumber
FROM Passenger
UNION ALL
SELECT PassengerID, FirstName, LastName, PhoneNo2 AS PhoneNumber
FROM Passenger
WHERE PhoneNo2 IS NOT NULL;

-- 5.List all passenger names and airline names together
SELECT FirstName AS Name, 'Passenger' AS Type
FROM Passenger
UNION ALL
SELECT Airline_Name AS Name, 'Airline' AS Type
FROM Airline;

-- 6. UNION: Combine male and female passenger counts
SELECT 'Male' AS Gender, COUNT(*) AS Count
FROM Passenger
WHERE Gender = 'Male'
UNION
SELECT 'Female' AS Gender, COUNT(*) AS Count
FROM Passenger
WHERE Gender = 'Female';

-- 7. UNION: Combine different seat types with their counts
SELECT 'Business Class' AS Seat_Type, COUNT(*) AS Count
FROM Ticket
WHERE Seat_Type = 'Business Class'
UNION
SELECT 'First Class' AS Seat_Type, COUNT(*) AS Count
FROM Ticket
WHERE Seat_Type = 'First Class'
UNION
SELECT 'Economy Class' AS Seat_Type, COUNT(*) AS Count
FROM Ticket
WHERE Seat_Type = 'Economy Class';

-- 8.Combine all flight sources and destinations
SELECT Source AS Location, 'Departure' AS Type
FROM Flight
UNION ALL
SELECT Destination AS Location, 'Arrival' AS Type
FROM Flight;

-- 9.Flights that have both schedule and details
SELECT FlightID, Flight_Name
FROM Flight f
WHERE EXISTS (SELECT 1 FROM Flight_Schedule WHERE FlightID = f.FlightID)
AND EXISTS (SELECT 1 FROM Flight_Details WHERE FlightID = f.FlightID);

-- 10. List all unique destinations and sources from flights
SELECT Source AS Location FROM Flight
UNION
SELECT Destination AS Location FROM Flight;

-- SUB QUERIES 
-- 1. Find passengers who have booked at least one ticket
SELECT PassengerID , FirstName 
FROM Passenger 
WHERE PassengerID IN (SELECT PassengerID FROM Ticket ) ;

-- 2. Find the highest ticket price among all booked tickets
SELECT MAX(Fare) 
FROM Flight_Details
WHERE Fare = (SELECT MAX(Fare) FROM Flight_Details);

-- 3. Find the flight details of the most expensive ticket
SELECT * 
FROM Flight 
WHERE FlightID = (SELECT FlightID FROM Flight_Details ORDER BY Fare DESC LIMIT 1);

-- 4. Find the total number of passengers who have booked at least one ticket
SELECT COUNT(*) 
FROM Passenger 
WHERE PassengerID IN (SELECT DISTINCT PassengerID FROM Ticket);

-- 5. Find the total revenue generated from ticket sales
SELECT SUM(Fare) 
FROM Flight_Details
WHERE FlightID IN (SELECT FlightID FROM Flight);

-- 6. Passengers with more than average baggage weight
SELECT * FROM Passenger
WHERE PassengerID IN (
    SELECT PassengerID FROM Baggage 
    WHERE Weight_kg > (SELECT AVG(Weight_kg) FROM Baggage)
);

-- 7. Tickets for flights with capacity over 300
SELECT * FROM Ticket
WHERE FlightID IN (
    SELECT FlightID FROM Flight_Details 
    WHERE Capacity > 100
);

-- 8. Passengers with both loyalty program and travel insurance
SELECT * FROM Passenger
WHERE PassengerID IN (
    SELECT PassengerID FROM Loyalty_Program
) AND PassengerID IN (
    SELECT PassengerID FROM Travel_Insurance
);

-- 9. Economy class tickets with veg meal service
SELECT * FROM Ticket
WHERE Seat_Type = 'Economy Class' AND TicketID IN (
    SELECT TicketID FROM Meal_Service WHERE Meal_Type='Veg'
);

-- 10. Flights with above-average ratings
SELECT * FROM Flight
WHERE FlightID IN (
    SELECT FlightID  FROM Rating
    GROUP BY FlightID
    HAVING AVG(Rating) > (SELECT AVG(Rating) FROM Rating)
);

-- NESTED QUERIES 
-- 1. Get flights that have the highest ticket price
SELECT * 
FROM Flight 
WHERE FlightID IN (SELECT FlightID FROM Flight_Details WHERE Fare = (SELECT MAX(Fare) FROM Flight_Details));

-- 2. Get flights where the total ticket revenue is above $5000
SELECT FlightID, Source, Destination 
FROM Flight 
WHERE FlightID IN (SELECT FlightID 
                   FROM Flight_Details
                   GROUP BY FlightID 
                   HAVING SUM(Fare) > 5000);

-- 3. Get flights that have at least one ticket booked at a price higher than $1000
SELECT FlightID, Source, Destination 
FROM Flight 
WHERE FlightID IN (SELECT DISTINCT FlightID 
                   FROM Flight_Details 
                   WHERE Fare > 1000);

-- 4. Get flights where the average ticket price is greater than 750
SELECT FlightID, Source, Destination 
FROM Flight 
WHERE FlightID IN (SELECT FlightID 
                   FROM Flight_Details 
                   GROUP BY FlightID 
                   HAVING AVG(Fare) > 750);
                   
-- 5. Airlines with above-average passenger ratings
SELECT * FROM Airline
WHERE AirlineID IN (
    SELECT AirlineID FROM Flight
    WHERE FlightID IN (
        SELECT FlightID FROM Rating
        GROUP BY FlightID
        HAVING AVG(Rating) > (
            SELECT AVG(Rating) FROM Rating
        )
    )
);

-- 6. Retrieve Flights That Have a Rating of 5 and Belong to Airlines in a Specific Country (e.g., 'USA')
SELECT FlightID, Flight_Name  
FROM Flight  
WHERE FlightID IN (  
    SELECT FlightID FROM Rating WHERE Rating = 5  
)  
AND AirlineID IN (  
    SELECT AirlineID FROM Airline WHERE AirportID IN (  
        SELECT AirportID FROM Airport WHERE Country = 'USA'  
    )  
);

-- 7. Retrieve Airports That Have Airlines But No Domestic Flights
SELECT Airport_Name  
FROM Airport  
WHERE AirportID IN (  
    SELECT AirportID FROM Airline  
    WHERE AirlineID IN (  
        SELECT AirlineID FROM Flight WHERE Flight_Type = 'International'  
    )  
)  
AND AirportID NOT IN (  
    SELECT AirportID FROM Airline  
    WHERE AirlineID IN (  
        SELECT AirlineID FROM Flight WHERE Flight_Type = 'Domestic'  
    )  
);

-- 8. Retrieve Passengers Who Have Made a Complaint But Haven’t Checked In
SELECT FirstName, LastName  
FROM Passenger  
WHERE PassengerID IN (SELECT PassengerID FROM Complaint)  
AND PassengerID IN (  
    SELECT PassengerID FROM Ticket WHERE TicketID IN (SELECT TicketID FROM Checkin)  
);

-- 9. Retrieve Flights That Have the Maximum Fare
SELECT FlightID, Flight_Name  
FROM Flight  
WHERE FlightID IN (  
    SELECT FlightID FROM Flight_Details  
    WHERE Fare = (SELECT MAX(Fare) FROM Flight_Details)  
);

-- 10. Retrieve Flights That Have the Minimum Fare
SELECT FlightID, Flight_Name  
FROM Flight  
WHERE FlightID IN (  
    SELECT FlightID FROM Flight_Details  
    WHERE Fare = (SELECT MIN(Fare) FROM Flight_Details)  
);

-- GROUPBY ORDERBY QUERIES
-- 1.Find the number of flights operated by each airline, sorted alphabetically
SELECT AirlineID, COUNT(*) AS Total_Flights 
FROM Flight 
GROUP BY AirlineID 
ORDER BY AirlineID;

-- 2.Get the average fare per flight and sort by the highest fare
SELECT FlightID, AVG(Fare) AS Avg_Fare 
FROM Flight_Details 
GROUP BY FlightID 
ORDER BY Avg_Fare DESC;

-- 3.Find the total revenue per flight and sort from highest to lowest
SELECT FlightID, SUM(Fare) AS Total_Revenue 
FROM Flight_Details 
GROUP BY FlightID 
ORDER BY Total_Revenue DESC;

-- 4. Count the number of passengers by gender, ordered in descending order
SELECT Gender, COUNT(*) AS PassengerCount  
FROM Passenger  
GROUP BY Gender  
ORDER BY PassengerCount DESC;  

-- 5. Find the number of flights operated by each airline, ordered in descending order
SELECT AirlineID, COUNT(*) AS NumberOfFlights  
FROM Flight  
GROUP BY AirlineID  
ORDER BY NumberOfFlights DESC;  

-- 6. Find the number of passengers traveling from each source city, ordered in descending order
SELECT Source, COUNT(DISTINCT PassengerID) AS PassengerCount  
FROM Flight  
JOIN Ticket ON Flight.FlightID = Ticket.FlightID  
GROUP BY Source  
ORDER BY PassengerCount DESC;  

-- 7.Find the total number of complaints received for each status, ordered from most to least
SELECT Complaint_Status, COUNT(*) AS ComplaintCount  
FROM Complaint  
GROUP BY Complaint_Status  
ORDER BY ComplaintCount DESC;

-- 8. Get the number of reservations for each booking status, ordered alphabetically
SELECT Booking_Status, COUNT(*) AS ReservationCount  
FROM Reservation  
GROUP BY Booking_Status  
ORDER BY Booking_Status ASC;  

-- 9. Find the average rating given to each flight, ordered from highest to lowest
SELECT FlightID, AVG(Rating) AS AverageRating  
FROM Rating  
GROUP BY FlightID  
ORDER BY AverageRating DESC;  

-- 10. Find the number of passengers who have checked in, grouped by check-in status and ordered from most to least
SELECT Checkin_Status, COUNT(*) AS CheckinCount  
FROM Checkin  
GROUP BY Checkin_Status  
ORDER BY CheckinCount DESC;  

-- WITH CLAUSE QUERIES
-- 1. Passengers with their ticket count
WITH PassengerTickets AS (
    SELECT PassengerID, COUNT(*) AS TicketCount
    FROM Ticket
    GROUP BY PassengerID
)
SELECT p.*, pt.TicketCount
FROM Passenger p
LEFT JOIN PassengerTickets pt ON p.PassengerID = pt.PassengerID;

-- 2. Flights with average ratings
WITH FlightRatings AS (
    SELECT FlightID, AVG(Rating) AS AvgRating
    FROM Rating
    GROUP BY FlightID
)
SELECT f.*, fr.AvgRating
FROM Flight f
LEFT JOIN FlightRatings fr ON f.FlightID = fr.FlightID;

-- 3. Popular meal choices
WITH MealPopularity AS (
    SELECT Meal_Type, COUNT(*) AS OrderCount
    FROM Meal_Service
    GROUP BY Meal_Type
)
SELECT * FROM MealPopularity
ORDER BY OrderCount DESC;

-- 4. Baggage statistics by passenger
WITH PassengerBaggage AS (
    SELECT PassengerID, 
           AVG(Weight_kg) AS AvgWeight,
           SUM(No_of_bags) AS TotalBags
    FROM Baggage
    GROUP BY PassengerID
)
SELECT p.*, pb.AvgWeight, pb.TotalBags
FROM Passenger p
LEFT JOIN PassengerBaggage pb ON p.PassengerID = pb.PassengerID;

-- 5. Loyalty program summary
WITH LoyaltySummary AS (
    SELECT Membership_Type, COUNT(*) AS MemberCount
    FROM Loyalty_Program
    GROUP BY Membership_Type
)
SELECT * FROM LoyaltySummary
ORDER BY MemberCount DESC;

-- 6. Complaint resolution status
WITH ComplaintStatus AS (
    SELECT Complaint_Status, COUNT(*) AS StatusCount
    FROM Complaint
    GROUP BY Complaint_Status
)
SELECT * FROM ComplaintStatus
ORDER BY StatusCount DESC;

-- 7. Passengers born after 1990
WITH YoungPassengers AS (
    SELECT FirstName, LastName 
    FROM Passenger
    WHERE YEAR(DOB) > 1990
)
SELECT * FROM YoungPassengers;

-- 8. Airports in a specific country
WITH USAirports AS (
    SELECT Airport_Name
    FROM Airport
    WHERE Country = 'USA'
)
SELECT * FROM USAirports;

-- 9. Male passengers
WITH MalePassengers AS (
    SELECT FirstName, LastName
    FROM Passenger
    WHERE Gender = 'Male'
)
SELECT * FROM MalePassengers;

-- 10. Confirmed reservations
WITH ConfirmedBookings AS (
    SELECT TicketID
    FROM Reservation
    WHERE Booking_Status = 'Confirmed'
)
SELECT * FROM ConfirmedBookings;

-- VIEWS
-- 1. Flights with Duration
CREATE VIEW FlightsWithDuration AS
SELECT 
    f.FlightID, 
    f.Flight_Name, 
    f.Source, 
    f.Destination,
    fs.Duration AS DurationMinutes
FROM Flight f
JOIN Flight_Schedule fs ON f.FlightID = fs.FlightID;
SELECT * FROM FlightsWithDuration;

-- 2. Ticket Prices
CREATE VIEW TicketPricing AS
SELECT 
    t.TicketID,
    t.Seat_Type,
    fd.Fare AS TicketPrice
FROM Ticket t
JOIN Flight_Details fd ON t.FlightID = fd.FlightID;
SELECT * FROM TicketPricing;

-- 3. Check-In COUNT
CREATE VIEW CheckInSummary AS
SELECT 
    Checkin_Status,
    COUNT(*) AS StatusCount
FROM Checkin
GROUP BY Checkin_Status;
SELECT * FROM CheckInSummary;

-- 4. Insurance Policy Counts
CREATE VIEW InsurancePolicyCounts AS
SELECT 
    Policy_Type,
    COUNT(*) AS PolicyCount
FROM Travel_Insurance
GROUP BY Policy_Type;
SELECT * FROM InsurancePolicyCounts;

-- 5. Meal Service Summary
CREATE VIEW MealServiceSummary AS
SELECT 
    f.FlightID,
    f.Flight_Name,
    m.Meal_Type,
    COUNT(*) AS MealsOrdered
FROM Flight f
JOIN Ticket t ON f.FlightID = t.FlightID
JOIN Meal_Service m ON t.TicketID = m.TicketID
GROUP BY f.FlightID, f.Flight_Name, m.Meal_Type;
SELECT * FROM MealServiceSummary;

-- 6. Loyalty Program Summary
CREATE VIEW LoyaltyProgramSummary AS
SELECT 
    lp.Membership_Type,
    COUNT(*) AS MemberCount,
    AVG(lp.Points_Earned) AS AvgPoints
FROM Loyalty_Program lp
GROUP BY lp.Membership_Type;
SELECT * FROM LoyaltyProgramSummary;

-- 7. Check-In Statuses
CREATE VIEW CheckInRecords AS
SELECT TicketID, Checkin_Status 
FROM Checkin;
SELECT * FROM CheckInRecords;

-- 8. Flight Routes
CREATE VIEW FlightRoutes AS
SELECT FlightID, Source, Destination 
FROM Flight;
SELECT * FROM FlightRoutes;

-- 9. Insurance Policies
CREATE VIEW InsurancePlans AS
SELECT PassengerID, Policy_Type 
FROM Travel_Insurance;
SELECT * FROM InsurancePlans;

-- 10. View for Complaints and Status
CREATE VIEW ComplaintStatus AS
SELECT c.PassengerID, p.FirstName, p.LastName, c.Complaint_Type, 
       c.Complaint_Status, c.Date_of_Complaint
FROM Complaint c
JOIN Passenger p ON c.PassengerID = p.PassengerID;
SELECT * FROM ComplaintStatus;

-- HAVING CLAUSE
-- 1. Find Airlines with More Than 1 Flight
SELECT AirlineID, COUNT(FlightID) AS TotalFlights
FROM Flight
GROUP BY AirlineID
HAVING COUNT(FlightID) > 1;

-- 2. Find Airports Serving More Than 1 Airlines
SELECT AirportID, COUNT(AirlineID) AS TotalAirlines
FROM Airline
GROUP BY AirportID
HAVING COUNT(AirlineID) > 1;

-- 3. Find Flights with an Average Fare Greater Than 80000
SELECT FlightID, AVG(Fare) AS AvgFare
FROM Flight_Details
GROUP BY FlightID
HAVING AVG(Fare) > 80000;

-- 4. Find Flights That Have Carried More Than 20kg Bags
SELECT FlightID, SUM(Weight_kg) AS TotalBags
FROM Baggage
GROUP BY FlightID
HAVING SUM(Weight_kg) > 20;

-- 5.Common insurance policies
SELECT Policy_Type, COUNT(*) AS PolicyCount
FROM Travel_Insurance
GROUP BY Policy_Type
HAVING COUNT(*) > 3;

-- 6. Flights with 1 complaint
SELECT PassengerID, COUNT(*) AS ComplaintCount
FROM Complaint
GROUP BY PassengerID
HAVING COUNT(*) = 1;

-- 7. Flights with highest ratings
SELECT FlightID, AVG(Rating) AS AvgRating
FROM Rating
GROUP BY FlightID
HAVING AVG(Rating) >4;

-- 8. Meal Types with total price greater than 1700
SELECT Meal_Type, SUM(Price) AS AvgPrice
FROM Meal_Service
WHERE Price > 0
GROUP BY Meal_Type
HAVING SUM(Price) > 1700;

-- 9. Passengers with Multiple Phone Numbers
SELECT PassengerID, FirstName, LastName
FROM Passenger
GROUP BY PassengerID, FirstName, LastName
HAVING COUNT(PhoneNo1) + COUNT(PhoneNo2) > 1;

-- 10.Passengers with 2 Bags
SELECT PassengerID
FROM Baggage
GROUP BY PassengerID
HAVING SUM(No_of_bags)= 2;

-- CURSORS
-- 1. Cursor to Fetch All Passengers' Names
DELIMITER //
CREATE PROCEDURE GetAllPassengers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE fName VARCHAR(50);
    DECLARE lName VARCHAR(50);
    DECLARE cur CURSOR FOR SELECT FirstName, LastName FROM Passenger;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO fName, lName;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT CONCAT(fName, ' ', lName) AS FullName;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL GetAllPassengers();

-- 2. Cursor to Fetch Passengers with Active Reservations
DELIMITER //
CREATE PROCEDURE ActiveReservations()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE passID INT;
    DECLARE cur CURSOR FOR SELECT PassengerID FROM Reservation WHERE Booking_Status = 'Confirmed';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO passID;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT passID AS ActivePassenger;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL GetActiveReservations();

-- 3. Cursor to Fetch Passengers with a Gold Travel Insurance Policy 
DELIMITER //
CREATE PROCEDURE GoldIns()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE passID INT;
    DECLARE cur CURSOR FOR 
        SELECT PassengerID FROM Travel_Insurance WHERE Policy_Type = 'GOLD';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO passID;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT passID AS GoldMember;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL GoldInsurancePassengers();

-- 4. Cursor to Fetch Passengers Who Have Filed Complaints
DELIMITER //
CREATE PROCEDURE ComplainPassengers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE passID INT;
    DECLARE cur CURSOR FOR 
        SELECT PassengerID FROM Complaint;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO passID;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT passID AS ComplaintPassenger;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

CALL ComplainingPassengers();

-- 5.Cursor to List Passengers Who Have Booked a Ticket
DELIMITER //

CREATE PROCEDURE PassengersWithTickets()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pID INT;
    DECLARE fname, lname VARCHAR(50);

    DECLARE cur CURSOR FOR 
        SELECT PassengerID, FirstName, LastName FROM Passenger 
        WHERE PassengerID IN (SELECT DISTINCT PassengerID FROM Ticket);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO pID, fname, lname;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT pID AS PassengerID, fname AS FirstName, lname AS LastName;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL ListPassengersWithTickets();

-- 6.Cursor to Find International Flights
DELIMITER //
CREATE PROCEDURE InternationalFlight()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE flightName VARCHAR(100);

    DECLARE cur CURSOR FOR 
        SELECT Flight_Name FROM Flight WHERE Flight_Type = 'International';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO flightName;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT flightName AS FlightName;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;
CALL InternationalFlights();

-- 7.Cursor to List Complaints Filed by Passengers
DELIMITER //
CREATE PROCEDURE Complaint()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE complaintType VARCHAR(100);
    DECLARE complaintStatus VARCHAR(50);
    

    DECLARE cur CURSOR FOR 
        SELECT Complaint_Type, Complaint_Status FROM Complaint;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO complaintType, complaintStatus;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT complaintType AS ComplaintType, complaintStatus AS Status;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;
CALL Complaints();

-- Example 8: Cursor to show flights which have rating higher than 4.5
DELIMITER //
CREATE PROCEDURE HighRatedFlight()
BEGIN
    DECLARE v_FlightName VARCHAR(255);
    DECLARE v_AverageRating DECIMAL(3,2);
    DECLARE done INT DEFAULT FALSE;

    DECLARE flight_ratings CURSOR FOR
        SELECT f.Flight_Name, AVG(r.Rating)
        FROM Flight f
        JOIN Rating r ON f.FlightID = r.FlightID
        GROUP BY f.Flight_Name
        HAVING AVG(r.Rating) > 4;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN flight_ratings;

    read_loop: LOOP
        FETCH flight_ratings INTO v_FlightName, v_AverageRating;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Flight: ', v_FlightName, ', Average Rating: ', v_AverageRating) AS Result;
    END LOOP;

    CLOSE flight_ratings;
END //
DELIMITER ;
CALL HighRatedFlights();


-- Example 9: Cursor to show passengers and their total baggage weight
DELIMITER //
CREATE PROCEDURE PassengerBaggageWeight()
BEGIN
    DECLARE v_FirstName VARCHAR(255);
    DECLARE v_LastName VARCHAR(255);
    DECLARE v_TotalWeight DECIMAL(10,2);
    DECLARE done INT DEFAULT FALSE;

    DECLARE passenger_baggage CURSOR FOR
        SELECT p.FirstName, p.LastName, SUM(b.Weight_kg)
        FROM Passenger p
        JOIN Baggage b ON p.PassengerID = b.PassengerID
        GROUP BY p.FirstName, p.LastName;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN passenger_baggage;

    read_loop: LOOP
        FETCH passenger_baggage INTO v_FirstName, v_LastName, v_TotalWeight;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Passenger: ', v_FirstName, ' ', v_LastName, ', Total Weight: ', v_TotalWeight) AS Result;
    END LOOP;

    CLOSE passenger_baggage;
END //

DELIMITER ;
CALL GetPassengerBaggageWeight();

-- Example 10: Cursor to list passengers with their loyalty program points
DELIMITER //
CREATE PROCEDURE LoyaltyPoints()
BEGIN
    DECLARE v_FirstName VARCHAR(255);
    DECLARE v_LastName VARCHAR(255);
    DECLARE v_Points INT;
    DECLARE done INT DEFAULT FALSE;

    DECLARE loyalty_points_cursor CURSOR FOR
        SELECT p.FirstName, p.LastName, lp.Points_Earned
        FROM Passenger p
        JOIN Loyalty_Program lp ON p.PassengerID = lp.PassengerID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN loyalty_points_cursor;

    read_loop: LOOP
        FETCH loyalty_points_cursor INTO v_FirstName, v_LastName, v_Points;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Passenger: ', v_FirstName, ' ', v_LastName, ', Points: ', v_Points) AS Result;
    END LOOP;

    CLOSE loyalty_points_cursor;
END //

DELIMITER ;
CALL GetLoyaltyPoints();

-- TRIGGERS
-- 1. Trigger to prevent ticket booking if flight capacity is exceeded
DELIMITER //
CREATE TRIGGER PreventTicketBook
BEFORE INSERT ON Ticket
FOR EACH ROW
BEGIN
    DECLARE current_capacity INT;
    DECLARE max_capacity INT;

    SELECT COUNT(*) INTO current_capacity
    FROM Ticket
    WHERE FlightID = NEW.FlightID;

    SELECT Capacity INTO max_capacity
    FROM Flight_Details
    WHERE FlightID = NEW.FlightID;

    IF current_capacity >= max_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Flight capacity exceeded.';
    END IF;
END //
DELIMITER ;


INSERT INTO Flight_Details (FlightID, Capacity, Fare)
VALUES (999, 2, 200.00);

-- 2. Trigger to ensure check-in is done only after ticket booking
DELIMITER //
CREATE TRIGGER CheckinAfterTicket
BEFORE INSERT ON Checkin
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Ticket WHERE TicketID = NEW.TicketID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ticket must exist before check-in.';
    END IF;
END //
DELIMITER ;

-- 3. Trigger to update baggage weight upon insertion
DELIMITER //
CREATE TRIGGER UpdateBagWeight
BEFORE INSERT ON Baggage
FOR EACH ROW
BEGIN
    IF NEW.Weight_kg > 30 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Baggage weight exceeds limit.';
    END IF;
END //
DELIMITER ;
INSERT INTO Baggage (No_of_bags, Weight_kg, PassengerID, FlightID)
VALUES (1, 35, 1, 1);

-- 4. Trigger to prevent rating insertion for non-existent flights/passengers
DELIMITER //
CREATE TRIGGER PreventInvalidRatings
BEFORE INSERT ON Rating
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Flight WHERE FlightID = NEW.FlightID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid FlightID.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Passenger WHERE PassengerID = NEW.PassengerID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid PassengerID.';
    END IF;
END //
DELIMITER ;
INSERT INTO Rating (PassengerID, FlightID, Rating)
VALUES (1, 9999, 5);

-- 5. Trigger to prevent meal service insertion for non-existent tickets
DELIMITER //
CREATE TRIGGER PreventInvalidMealServices
BEFORE INSERT ON Meal_Service
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Ticket WHERE TicketID = NEW.TicketID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid TicketID.';
    END IF;
END //
DELIMITER ;
INSERT INTO Meal_Service (Meal_Type, Price, TicketID)
VALUES ('Vegetarian', 15.00, 9999);

-- 6. Trigger to prevent lounge access insertion for non-existent airports/passengers
DELIMITER //
CREATE TRIGGER InvalidLoungeAccess
BEFORE INSERT ON Lounge_Access
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Airport WHERE AirportID = NEW.AirportID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid AirportID.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Passenger WHERE PassengerID = NEW.PassengerID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid PassengerID.';
    END IF;
END //
DELIMITER ;
INSERT INTO Lounge_Access (Lounge_Number, Lounge_Type, AirportID, PassengerID)
VALUES ('Lounge1', 'First Class', 9999, 1);

-- 7. Trigger to prevent complaint insertion for non-existent passengers
DELIMITER //
CREATE TRIGGER PreventInvalidComplaints
BEFORE INSERT ON Complaint
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Passenger WHERE PassengerID = NEW.PassengerID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid PassengerID.';
    END IF;
END //
DELIMITER ;
INSERT INTO Complaint (Complaint_Type, Complaint_Status, Date_of_Complaint, PassengerID)
VALUES ('Lost Baggage', 'Pending', '2023-10-27', 9999);

-- 8. Trigger to prevent a negative Fare in Flight_Details:
DELIMITER //
CREATE TRIGGER NegativeFare
BEFORE INSERT ON Flight_Details
FOR EACH ROW
BEGIN
    IF NEW.Fare < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fare cannot be negative.';
    END IF;
END //
DELIMITER ;
INSERT INTO Flight_Details (FlightID, Capacity, Fare)
VALUES (1, 100, -100.00);

-- 9. Trigger to prevent a Rating outside the range of 1 to 5:
DELIMITER //
CREATE TRIGGER PreventInvalidRatingval
BEFORE INSERT ON Rating
FOR EACH ROW
BEGIN
    IF NEW.Rating < 1 OR NEW.Rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 5.';
    END IF;
END //
DELIMITER ;
INSERT INTO Rating (PassengerID, FlightID, Rating)
VALUES (1,'6E001', 0);


-- 10. Trigger to prevent a passenger from having a future Date of Birth.
DELIMITER //
CREATE TRIGGER Futuredob
BEFORE INSERT ON Passenger
FOR EACH ROW
BEGIN
    IF NEW.DOB > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date of Birth cannot be in the future.';
    END IF;
END //
DELIMITER ;
INSERT INTO Passenger (PassengerID, FirstName, LastName, PhoneNo1, PhoneNo2, Gender, DOB)
VALUES (11, 'Valid', 'Passenger', '987-654-3210', NULL, 'F', '2026-01-01');
