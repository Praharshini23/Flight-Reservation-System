const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// MySQL Connection
const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',       // your MySQL username
  password: 'root',       // your MySQL password
  database: 'FlightReservationDB'
});

db.connect((err) => {
  if (err) {
    console.error('DB Connection Error:', err);
    return;
  }
  console.log('Connected to MySQL database');
});

// Endpoint to handle form submission
app.post('/submit', (req, res) => {
  const { firstname, lastname, phone1, phone2, gender, dob } = req.body;

  const query = 'INSERT INTO Passenger (FirstName, LastName, PhoneNo1, PhoneNo2, Gender, DOB) VALUES (?, ?, ?, ?, ?, ?)';
  const values = [firstname, lastname, phone1, phone2, gender, dob];

  db.query(query, values, (err, result) => {
    if (err) {
      console.error('Insert Error:', err);
      res.status(500).send('Database insert error');
    } else {
      res.send('User registered successfully');
    }
  });
});

app.post('/rating', (req, res) => {
  const { passengerid, flightid, rating } = req.body;

  const query = 'INSERT INTO Rating (PassengerID, FlightID, Rating ) VALUES (?, ?, ?)';
  db.query(query, [passengerid, flightid, rating], (err, result) => {
    if (err) {
      console.error('Insert Rating Error:', err);
      res.status(500).send('Error saving rating');
    } else {
      res.send('Rating submitted successfully');
    }
  });
});

app.post('/complaint', (req, res) => {
  const { complainttype, date, passengerid } = req.body;

  const query = 'INSERT INTO Complaint (Complaint_Type, Date_of_Complaint, PassengerID) VALUES (?, ?, ?)';
  db.query(query, [complainttype, date, passengerid], (err, result) => {
    if (err) {
      console.error('Insert Complaint Error:', err);
      res.status(500).send('Error saving complaint');
    } else {
      res.send('Complaint submitted successfully');
    }
  });
});

app.post('/lounge', (req, res) => {
  const { loungenumber, loungetype, airportid, passengerid } = req.body;

  const query = 'INSERT INTO Lounge_Access (Lounge_Number, Lounge_Type, AirportID, PassengerID) VALUES (?, ?, ?, ?)';
  db.query(query, [loungenumber, loungetype, airportid, passengerid], (err, result) => {
    if (err) {
      console.error('Lounge booking error:', err);
      res.status(500).send('Error booking lounge');
    } else {
      res.send('Lounge booked successfully');
    }
  });
});

app.post('/bookticket', (req, res) => {
  const { seatNumber, seatType, passengerID, flightID } = req.body;

  const query = `
    INSERT INTO Ticket (Seat_Number, Seat_Type, PassengerID, FlightID)
    VALUES (?, ?, ?, ?)
  `;

  db.query(query, [seatNumber, seatType, passengerID, flightID], (err, result) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        res.status(400).send('This seat is already booked for this flight.');
      } else {
        console.error('Ticket booking error:', err);
        res.status(500).send('Booking failed.');
      }
    } else {
      res.send('Ticket booked successfully.');
    }
  });
});



app.get('/schedule', (req, res) => {
  const query = 'SELECT * FROM Flight_Schedule';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching schedule:', err);
      res.status(500).send('Error retrieving flight schedule');
    } else {
      res.json(results);
    }
  });
});

app.post('/travelinsurance', (req, res) => {
  const { expiryDate, policyType, amount, passengerID } = req.body;

  const query = `
    INSERT INTO Travel_Insurance (Expiry_Date, Policy_Type, Amount, PassengerID)
    VALUES (?, ?, ?, ?)
  `;

  db.query(query, [expiryDate, policyType, amount, passengerID], (err, result) => {
    if (err) {
      console.error('Error inserting travel insurance:', err);
      return res.status(500).send('Database error');
    }
    res.send('Travel insurance registered successfully!');
  });
});

app.post('/checkin', (req, res) => {
  const { checkinDate, checkinStatus, ticketID } = req.body;

  const sql = `
    INSERT INTO Checkin (Checkin_Date, Checkin_Status, TicketID)
    VALUES (?, ?, ?)
  `;

  db.query(sql, [checkinDate, checkinStatus, ticketID], (err, result) => {
    if (err) {
      console.error('Error inserting check-in data:', err);
      res.status(500).send('Check-in failed.');
    } else {
      res.send('Check-in successful!');
    }
  });
});

app.post('/mealservice', (req, res) => {
  const { mealType, mealPrice, ticketID } = req.body;

  const sql = `
    INSERT INTO Meal_Service (Meal_Type, Price, TicketID)
    VALUES (?, ?, ?)
  `;

  db.query(sql, [mealType, mealPrice, ticketID], (err, result) => {
    if (err) {
      console.error('Error inserting meal service data:', err);
      res.status(500).send('Meal service submission failed.');
    } else {
      res.send('Meal service recorded successfully!');
    }
  });
});

app.post('/baggage', (req, res) => {
  const { numBags, weight, passengerID, flightID } = req.body;

  if (parseFloat(weight) > 25) {
    return res.status(400).send('Weight exceeds 25kg limit.');
  }

  const sql = `
    INSERT INTO Baggage (No_of_bags, Weight_kg, PassengerID, FlightID) VALUES (?, ?, ?, ?)
  `;

  db.query(sql, [numBags, weight, passengerID, flightID], (err, result) => {
    if (err) {
      console.error('Error inserting baggage data:', err);
      res.status(500).send('Baggage submission failed.');
    } else {
      res.send('Baggage details recorded successfully!');
    }
  });
});



// Start server
app.listen(3000, () => {
  console.log('Server running at http://localhost:3000');
});
