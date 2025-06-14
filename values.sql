INSERT INTO Passenger (FirstName, LastName, PhoneNo1, PhoneNo2, Gender, DOB) VALUES
('Mary', 'Frost', '9876543210', NULL, 'Male', '1990-05-15'),
('Alice', 'Smith', '9123456789', '9123456710', 'Female', '1985-03-22'),
('Robert', 'Brown', '9988776655', NULL, 'Male', '1975-08-10'),
('Emily', 'Clark', '9234567890', NULL, 'Female', '1992-07-12'),
('Michael', 'Johnson', '9345678901', '9345678902', 'Male', '1988-01-05'),
('Amit', 'Sharma', '9456123789', NULL, 'Male', '1987-09-19'),
('Priya', 'Rao', '9876543219', NULL, 'Female', '1993-05-29'),
('Rajesh', 'Verma', '9654321780', '9654321781', 'Male', '1982-12-05'),
('Sneha', 'Patel', '9182736450', NULL, 'Female', '1996-04-11'),
('Vikram', 'Nair', '9876543200', NULL, 'Male', '1989-06-15');

INSERT INTO Airport (AirportID, Airport_Name, Country) VALUES
('DEL', 'Indira Gandhi International Airport', 'India'),
('JFK', 'John F. Kennedy International Airport', 'USA'),
('LHR', 'Heathrow Airport', 'UK'),
('DXB', 'Dubai International Airport', 'UAE'),
('DOH', 'Hamad International Airport', 'Qatar'),
('ORD', 'O Hare International Airport', 'USA'),
('HND', 'Haneda Airport', 'Japan'),
('FRA', 'Frankfurt Airport', 'Germany'),
('SIN', 'Changi Airport', 'Singapore'),
('SYD', 'Sydney Airport', 'Australia');

INSERT INTO Airline (AirlineID, Airline_Name, AirportID) VALUES
('6E', 'IndiGo', 'DEL'),
('AI', 'Air India', 'DEL'),
('EK', 'Emirates', 'DXB'),
('QR', 'Qatar Airways', 'DOH'),
('BA', 'British Airways', 'LHR'),
('SQ', 'Singapore Airlines', 'SIN'),
('AA', 'American Airlines', 'JFK'),
('UA', 'United Airlines', 'ORD'),
('JL', 'Japan Airlines', 'HND'),
('LH', 'Lufthansa', 'FRA');

INSERT INTO Flight (FlightID, Flight_Name, Source, Destination, Flight_Type, AirlineID) VALUES
('6E001', 'IndiGo Express', 'DEL', 'JFK', 'International', '6E'),
('6E002', 'IndiGo Express', 'DEL', 'DXB', 'International', '6E'),
('AA001', 'American Eagle', 'JFK', 'LHR', 'International', 'AA'),
('AA002', 'American Eagle', 'JFK', 'ORD', 'Domestic', 'AA'),
('QR001', 'Qatar Sky', 'DOH', 'DXB', 'International', 'QR'),
('QR002', 'Qatar Sky', 'DOH', 'DEL', 'International', 'QR'),
('UA001', 'United Dreamliner', 'ORD', 'HND', 'International', 'UA'),
('UA002', 'United Dreamliner', 'ORD', 'SIN', 'International', 'UA'),
('EK001', 'Emirates SkyCargo', 'DXB', 'FRA', 'International', 'EK'),
('EK002', 'Emirates SkyCargo', 'DXB', 'SYD', 'International', 'EK');

INSERT INTO Flight_Details (Capacity, Fare, FlightID) VALUES
(210, 50000.00, '6E001'),
(210, 40000.00, '6E002'),
(210, 80000.00, 'AA001'),
(210, 75000.00, 'AA002'),
(210, 60000.00, 'QR001'),
(210, 55000.00, 'QR002'),
(210, 90000.00, 'UA001'),
(210, 85000.00, 'UA002'),
(210, 100000.00, 'EK001'),
(210, 95000.00, 'EK002');

INSERT INTO Flight_Schedule (FlightID, Date_Of_Flight, Departure_Time_IST, Arrival_Time_IST, Duration) VALUES
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


INSERT INTO Ticket (Seat_Number, Seat_Type, PassengerID, FlightID) VALUES
('1A', 'Economy Class', 1, '6E001'),
('2B', 'Economy Class', 2, '6E002'),
('3C', 'Economy Class', 3, 'AA001'),
('4D', 'Economy Class', 4, 'AA002'),
('5E', 'Economy Class', 5, 'QR001'),
('10J', 'First Class', 6, 'QR002'),
('11K', 'First Class', 7, 'UA001'),
('20S', 'Business Class', 8, 'UA002'),
('21T', 'Business Class', 9, 'EK001'),
('22U', 'Business Class', 10, 'EK002');

INSERT INTO Meal_Service (Meal_Type, Price, TicketID) VALUES
('Veg', 500.00, 1),
('Non Veg', 700.00, 2),
('Vegan', 600.00, 3),
('Non Veg', 750.00, 4),
('Veg', 550.00, 5),
('Vegan', 620.00, 6),
('Non Veg', 800.00, 7),
('Veg', 520.00, 8),
('Vegan', 610.00, 9),
('Non Veg', 770.00, 10);

INSERT INTO Checkin (Checkin_Date, Checkin_Status, TicketID) VALUES
('2025-03-09', 'Checked In', 1),  
('2025-03-09', 'Checked In', 2),     
('2025-03-10', 'Checked In', 3),  
('2025-03-10', 'Checked In', 4),
('2025-03-11', 'Checked In', 5),  
('2025-03-11', 'Pending', 6),  
('2025-03-12', 'Pending', 7),
('2025-03-12', 'Pending', 8),
('2025-03-13', 'Pending', 9),
('2025-03-13', 'Pending', 10);

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

INSERT INTO Lounge_Access (Lounge_Number, Lounge_Type, AirportID, PassengerID) VALUES
(101, 'Business Class Lounge', 'JFK', 1),
(102, 'Economy Class Lounge', 'DXB', 2),
(103, 'First Class Lounge', 'LHR', 3),
(104, 'Economy Class Lounge', 'ORD', 4),
(105, 'Business Class Lounge', 'DXB', 5),
(106, 'First Class Lounge', 'DEL', 6),
(107, 'Economy Class Lounge', 'HND', 7),
(108, 'Business Class Lounge', 'SIN', 8),
(109, 'First Class Lounge', 'FRA', 9),
(110, 'Economy Class Lounge', 'SYD', 10);

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
