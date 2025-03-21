CREATE DATABASE TAXI;
USE TAXI;
-- Create Drivers Table
CREATE TABLE Drivers (
    Driver_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Phone_Number VARCHAR(20),
    Rating DECIMAL(2,1),
    Vehicle_Type VARCHAR(20),
    Total_Trips INT
);

-- Create Customers Table
CREATE TABLE Customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(255),
    Phone_Number VARCHAR(20),
    Total_Bookings INT,
    Total_Cancellations INT
);

-- Create Payment Table
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Booking_ID VARCHAR(20),
    Customer_ID VARCHAR(20),
    Payment_Method ENUM('Cash', 'Credit Card', 'Debit Card', 'UPI', 'Wallet'),
    Amount DECIMAL(10,2),
    Payment_Status VARCHAR(20)
);

INSERT INTO Drivers (Driver_ID, Name, Phone_Number, Rating, Vehicle_Type, Total_Trips)
VALUES 
(101, 'Rajesh Kumar', '9876543210', 4.8, 'Prime Sedan', 1200),
(102, 'Amit Sharma', '9865321470', 4.5, 'Mini', 980),
(103, 'Suresh Yadav', '9856741230', 4.2, 'Auto', 750),
(104, 'Vikas Singh', '9845632170', 4.7, 'Prime Plus', 1400),
(105, 'Ramesh Tiwari', '9832154780', 4.3, 'Bike', 600),
(106, 'Deepak Verma', '9821453670', 4.6, 'eBike', 500);

INSERT INTO Customers (Customer_ID, Name, Phone_Number, Total_Bookings, Total_Cancellations)
VALUES 
('CUST2786', 'Anjali Gupta',  '9123456789', 30, 3),
('CUST2790', 'Rahul Mehta', '9234567890', 45, 5),
('CUST2567', 'Priya Sharma', '9345678901', 25, 2),
('CUST2673', 'Vikram Yadav', '9456789012', 60, 8),
('CUST2789', 'Sneha Tiwari',  '9567890123', 15, 1),
('CUST2983', 'Aakash Verma', '9678901234', 35, 4);

INSERT INTO Payment (Payment_ID, Booking_ID, Customer_ID, Payment_Method, Amount, Payment_Status)
VALUES 
(5001, 'BK001', 'CUST2786', 'UPI', 320.50, 'Success'),
(5002, 'BK002', 'CUST2790', 'Credit Card', 450.00, 'Success'),
(5003, 'BK003', 'CUST2567', 'Cash', 280.75, 'Failed'),
(5004, 'BK004', 'CUST2673', 'Wallet', 500.00, 'Success'),
(5005, 'BK005', 'CUST2789', 'Debit Card', 350.25, 'Pending'),
(5006, 'BK006', 'CUST2945', 'UPI', 220.00, 'Success');

SELECT * FROM DELHI_BOOKING_DATA;
SELECT * FROM DRIVERS;
SELECT * FROM CUSTOMERS;
SELECT * FROM PAYMENT;

-- Select the distinct vehicle types from the dataset.
SELECT DISTINCT VEHICLE_TYPE FROM DELHI_BOOKING_DATA;

-- Count the total number of bookings.
SELECT COUNT(BOOKING_ID) AS TOTAL_BOOKING 
FROM DELHI_BOOKING_DATA;

-- Retrieve the top 5 pickup locations with the most bookings.
SELECT PICKUP_LOCATION, COUNT(PICKUP_LOCATION) AS PICK
FROM DELHI_BOOKING_DATA
WHERE BOOKING_STATUS= "SUCCESSFUL"
GROUP BY PICKUP_LOCATION
ORDER BY PICK DESC LIMIT 5;

-- Find the average ride distance for each vehicle type.
SELECT VEHICLE_TYPE, AVG(RIDE_DISTANCE) AS AVG_DISTANCE
FROM DELHI_BOOKING_DATA
WHERE BOOKING_STATUS = "SUCCESSFUL"
GROUP BY VEHICLE_TYPE;

 -- Get the total number of rides for each booking status.
SELECT BOOKING_STATUS, COUNT(BOOKING_STATUS) AS TOTAL_RIDES
FROM DELHI_BOOKING_DATA
GROUP BY BOOKING_STATUS;

-- Find the minimum, maximum, and average booking value for successful rides.
SELECT BOOKING_STATUS, MAX(BOOKING_VALUE), MIN(BOOKING_VALUE), AVG(BOOKING_VALUE)
FROM DELHI_BOOKING_DATA
WHERE BOOKING_STATUS = "SUCCESSFUL";

-- Write a query to find the most frequently booked vehicle type based on the total number of successful rides.
SELECT VEHICLE_TYPE, COUNT(BOOKING_ID) AS TOTAL_TRIPS
FROM DELHI_BOOKING_DATA
WHERE BOOKING_STATUS= "SUCCESSFUL"
GROUP BY VEHICLE_TYPE
ORDER BY TOTAL_TRIPS DESC LIMIT 1;

-- Write a query to get driver details for each successful ride.
SELECT 
DRIVERS.NAME, DRIVERS.DRIVER_ID, DRIVERS.VEHICLE_TYPE, COUNT(DRIVERS.NAME) AS Total_Successful_Rides
FROM DRIVERS
JOIN DELHI_BOOKING_DATA 
ON DRIVERS.VEHICLE_TYPE = DELHI_BOOKING_DATA.VEHICLE_TYPE
WHERE DELHI_BOOKING_DATA.BOOKING_STATUS = 'Successful'
GROUP BY DRIVERS.NAME, DRIVERS.DRIVER_ID, DRIVERS.VEHICLE_TYPE;

--  Retrieve the names of customers who have canceled at least one ride.
SELECT CUSTOMERS.NAME, CUSTOMERS.CUSTOMER_ID
FROM CUSTOMERS
JOIN DELHI_BOOKING_DATA 
ON CUSTOMERS.CUSTOMER_ID = DELHI_BOOKING_DATA.CUSTOMER_ID
WHERE BOOKING_STATUS = 'CANCELLED BY CUSTOMER'
GROUP BY CUSTOMERS.NAME, CUSTOMERS.CUSTOMER_ID
HAVING COUNT(DELHI_BOOKING_DATA.BOOKING_ID) >= 1;

-- Find the total revenue generated by each driver 
SELECT DRIVERS.NAME, DRIVERS.DRIVER_ID, SUM(BOOKING_VALUE) AS TOTAL_REVENUE
FROM DRIVERS
JOIN DELHI_BOOKING_DATA
ON DRIVERS.VEHICLE_TYPE = DELHI_BOOKING_DATA.VEHICLE_TYPE
GROUP BY DRIVERS.NAME, DRIVERS.DRIVER_ID
ORDER BY TOTAL_REVENUE;

-- Retrieve the top 5 drivers with the highest average customer rating.
SELECT DRIVERS.NAME, DRIVERS.DRIVER_ID, AVG(CUSTOMER_RATING) AS TOTAL_RATING
FROM DRIVERS
JOIN DELHI_BOOKING_DATA
ON DRIVERS.VEHICLE_TYPE = DELHI_BOOKING_DATA.VEHICLE_TYPE
GROUP BY DRIVERS.NAME, DRIVERS.DRIVER_ID
ORDER BY TOTAL_RATING DESC LIMIT 5;

-- Find the driver rating trend over different days.
SELECT DATE, AVG(DRIVER_RATINGS) AS AVG_DRIVER_RATING
FROM DELHI_BOOKING_DATA
WHERE booking_status = 'Successful'
GROUP BY DATE
ORDER BY DATE;

-- END OF PROJECT.





