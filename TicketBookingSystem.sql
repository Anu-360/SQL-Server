--TASK 1 [Database Design]

--Create the database named "TicketBookingSystem"
CREATE DATABASE TicketBookingSystem
USE TicketBookingSystem

/*Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships. 
Venue
Event 
Customers 
Booking*/

CREATE TABLE Venue(
venue_id  INT IDENTITY(101,1) NOT NULL PRIMARY KEY,
venue_name VARCHAR(25) ,
[address] VARCHAR(35))

--Creating Table Event
CREATE TABLE [Event](
event_id INT IDENTITY(401,1) NOT NULL PRIMARY KEY,
event_name VARCHAR(20),
event_date DATE,
event_time TIME,
venue_id INT,
FOREIGN KEY(venue_id) REFERENCES Venue(venue_id),
total_seats int,
available_seats int,
ticket_price DECIMAL,
event_type VARCHAR(45),
booking_id INT)

--Creating Table Customer
CREATE TABLE Customer(
customer_id INT IDENTITY(01,1) NOT NULL PRIMARY KEY,
customer_name VARCHAR(25),
email VARCHAR(30),
phone_number BIGINT,
booking_Id INT)

--Creating Table Booking
CREATE TABLE Booking(
booking_id INT IDENTITY(550,1) NOT NULL PRIMARY KEY,
customer_id INT,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
event_id INT,
FOREIGN KEY(event_id) REFERENCES [Event](event_id),
num_tickets INT,
total_cost FLOAT,
booking_date DATE)

--Create appropriate Primary Key and Foreign Key constraints for referential integrity
ALTER TABLE [Event] 
ADD CONSTRAINT Event_Booking_FK
FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE

ALTER TABLE [Event]
ADD CONSTRAINT Event_Venue_FK
FOREIGN KEY(venue_id) REFERENCES Venue(venue_id) ON DELETE CASCADE

ALTER TABLE Customer
ADD CONSTRAINT Customer_FK
FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE

--Before importing data
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT all'

--After importing data
EXEC sp_msforeachtable 'ALTER TABLE ? CHECK CONSTRAINT all'

--Task 2 [Select, Where, Between, AND, LIKE]

--1. Write a SQL query to insert at least 10 sample records into each table.
--INSERTING VALUES INTO TABLE "VENUE"
INSERT INTO Venue VALUES ('MCG Stadium','Melbourne'),
                         ('Eden Garden','Kolkata'),
                         ('Wembley','London'),
                         ('Sofi Stadium','Los Angeles'),
                         ('Ohio Stadium','Japan'),
                         ('AMC Theatre','Kansas'),
                         ('PVR Cinemas','Anna Nagar'),
                         ('San Tiago','Madrid'),
                         ('Wankede','Mumbai'),
                         ('Vetri Cinemas','Chrompet')


--INSERTING VALUES INTO TABLE "EVENT"
INSERT INTO [Event] VALUES('World Cup','2022-06-18','08:45:12',101,25000,1200,2500,'Sports',556),
                          ('Champions Trophy','2024-03-25','12:30:36',101,25000,500,1200,'Sports',550),
                          ('IPL','2023-02-18','18:18:07',102,12000,800,1350,'Sports',551),
                          ('Eras Tour','2024-01-13','19:08:52',103,35052,10520,3000,'Concert',554),
                          ('XO Concert','2020-03-26','13:13:13',104,600,NULL,6000,'Concert',555),
                          ('Blackpink Concert','2021-01-25','23:17:08',105,15000,2050,850,'Concert',557),
                          ('Zootopia','2019-05-04','15:56:32',106,700,700,450,'Movie',NULL),
                          ('Wonder Woman','2023-12-25','19:06:22',107,500,NULL,250,'Movie',552),
                          ('FIFA World Cup',GETDATE(),'20:05:25',108,32560,100,2560,'Sports',553),
                          ('Avengers','2021-05-07','13:35:32',110,950,210,724,'Movie',558)

UPDATE [Event]
SET venue_id=109 
WHERE event_name='Champions Trophy'

--INSERTING VALUES INTO TABLE "CUSTOMER"
INSERT INTO Customer VALUES('Anu','anumitha@gmail.com',9120540480,550),
                           ('Madhu','madhu546@gmail.com',9725240000,551),
                           ('Hemavarsha','camzero5@gmail.com',9320540480,552),
                           ('Maalavikha','maals34@gmail.com',9560278490,552),
                           ('Deepak','deepak78@gmail.com',9356270000,553),
                           ('Naveen','navispark4@gmail.com',7254681024,554),
                           ('Swetha','sparkle@gmail.com',9863012450,555),
                           ('Sriram','sri4good@gmail.com',8567456000,556),
                           ('Dhatchayani','dazzling5dizzle@gmail.com',8562013470,558),
                           ('Ayesha','ayesha76@gmail.com',7546982013,557),
                           ('George','georgi@gmail.com',8974635201,559),
                           ('Harsha','happinessblue@gmail.com',9968745210,560)


--INSERTING VALUES INTO TABLE "BOOKING"
INSERT INTO Booking VALUES(12,402,4,NULL,'2022-05-25'),
                          (06,403,8,NULL,'2023-02-12'),
                          (03,408,2,NULL,'2024-10-01'),
                          (07,409,6,NULL,'2022-05-25'),
                          (01,407,2,NULL,'2022-05-21'),
                          (11,405,3,NULL,'2018-10-29'),
                          (11,401,10,NULL,'2021-01-15'),
                          (08,406,5,NULL,'2023-12-02'),
                          (10,410,12,NULL,'2024-12-19')
                   

UPDATE Booking
SET total_cost=num_tickets*ticket_price
FROM Booking JOIN [Event]
ON Booking.booking_id=[Event].booking_id

--2. Write a SQL query to list all Events
SELECT * FROM [Event]

--3. Write a SQL query to select events with available tickets
SELECT event_name,available_seats,ticket_price FROM [Event]
WHERE available_seats IS NOT NULL

--4. Write a SQL query to select events name partial match with ‘cup’
SELECT event_name FROM [Event]
WHERE event_name LIKE '%cup'

--5. Write a SQL query to select events with ticket price range is between 1000 to 2500
SELECT * FROM [Event]
WHERE ticket_price BETWEEN 1000 AND 2500

--6. Write a SQL query to retrieve events with dates falling within a specific range
SELECT * FROM [Event]
WHERE event_date BETWEEN '2023-01-14' AND GETDATE()

--7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name
SELECT * FROM [Event]
WHERE available_seats IS NOT NULL AND event_name LIKE '%Concert'

--8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user
SELECT * FROM Customer
ORDER BY customer_id
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY

--9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4
SELECT * FROM Booking
WHERE num_tickets > 4

--10. Write a SQL query to retrieve customer information whose phone number end with ‘000’
SELECT * FROM Customer
WHERE phone_number LIKE '%000'

--11. Write a SQL query to retrieve the events in order whose seat capacity more than 15000
SELECT * FROM [Event]
WHERE total_seats > 15000
ORDER BY total_seats DESC

--12. Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT event_name FROM [Event]
WHERE event_name LIKE '[^xyz]%'

--Task 3 [Aggregate functions, Having, Order By, GroupBy and Joins]

--1. Write a SQL query to List Events and Their Average Ticket Prices
SELECT event_id,event_name,AVG(ticket_price) AS Average_ticket_price
FROM [Event]
GROUP BY event_id,event_name

--2.  Write a SQL query to Calculate the Total Revenue Generated by Events
SELECT B.event_id,E.event_name,SUM(B.total_cost) AS Total_Revenue
FROM Booking B LEFT JOIN [Event] E
ON B.booking_id=E.booking_id
GROUP BY B.event_id,E.event_name
ORDER BY Total_Revenue DESC

--3. Write a SQL query to find the event with the highest ticket sales
SELECT  TOP 1 num_tickets AS HIGHEST, E.event_name
FROM Booking B JOIN [Event] E 
ON B.booking_id=E.booking_id
GROUP BY event_name,num_tickets

--4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event
SELECT E.event_id,E.event_name,SUM(num_tickets) AS total_tickets_sold
FROM [Event] E LEFT JOIN Booking B
ON E.booking_id=B.booking_id
GROUP BY event_name,E.event_id

--5. Write a SQL query to Find Events with No Ticket Sales
SELECT E.event_id,E.event_name 
FROM Booking B RIGHT JOIN [Event] E
ON B.booking_id=E.booking_id
WHERE num_tickets IS NULL

--6.  Write a SQL query to Find the User Who Has Booked the Most Tickets
SELECT C.customer_id, customer_name,num_tickets 
FROM Customer C  JOIN 
(SELECT*,ROW_NUMBER() OVER(ORDER BY num_tickets DESC) RN FROM Booking) B
ON C.customer_id=B.customer_id AND B.RN=1

--7. Write a SQL query to List Events and the total number of tickets sold for each month
SELECT E.event_id,E.event_name,
DATENAME(MONTH,event_date) AS [month],
SUM(num_tickets) AS tickets_sold
FROM [Event] E LEFT JOIN Booking B
ON E.booking_id=B.booking_id
GROUP BY E.event_id,event_name,event_date

--8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue
SELECT V.venue_id,V.venue_name,AVG(ticket_price) AS Avg_ticket_price
FROM Venue V LEFT JOIN [Event] E
ON V.venue_id=E.venue_id
GROUP BY V.venue_id,venue_name

--9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type
SELECT E.event_type,SUM(num_tickets) AS Total_tickets_sold
FROM [Event] E LEFT JOIN Booking B
ON E.booking_id=B.booking_id
GROUP BY event_type

--10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year
SELECT E.event_id,E.event_name,
SUM(total_cost) AS Total_Revenue,YEAR(event_date) AS Year
FROM [Event] E LEFT JOIN Booking B
ON E.booking_id=B.booking_id
GROUP BY E.event_id,event_name,event_date
ORDER BY Year 

--11. Write a SQL query to list users who have booked tickets for multiple events
SELECT C.customer_id,C.customer_name,COUNT(B.customer_id) AS [Events]
FROM Customer C JOIN Booking B
ON C.customer_id=B.customer_id
GROUP BY C.customer_id,customer_name
HAVING COUNT(B.customer_id)>1

--12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User
SELECT C.customer_id,C.customer_name,E.event_name,
SUM(B.total_cost) AS Total_Revenue
FROM Customer C JOIN [Event] E
ON C.booking_Id =E.booking_id
JOIN Booking B 
ON E.booking_id=B.booking_id
GROUP BY C.customer_id,customer_name,event_name
ORDER BY Total_Revenue DESC

--13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue
SELECT E.event_type,V.venue_name,AVG(E.ticket_price) AS Avg_ticket_price
FROM [Event] E RIGHT JOIN Venue V
ON E.venue_id=V.venue_id
GROUP BY event_type,venue_name

--14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days
SELECT C.customer_id,C.customer_name,
SUM(B.num_tickets) AS Tickets_purchased,B.booking_date
FROM Customer C JOIN Booking B
ON C.customer_id=B.customer_id
GROUP BY C.customer_id,C.customer_name,B.booking_date
HAVING DATEDIFF(DAY,booking_date,GETDATE())<=30

--Task 4 [Subquery and its types]

--1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT venue_id,event_name,AVG(ticket_price) AS Avg_ticket_price
FROM [Event]
WHERE venue_id IN 
(SELECT venue_id FROM Venue)
GROUP BY venue_id,event_name

--2. Find Events with More Than 50% of Tickets Sold using subquery
SELECT event_id,event_name,available_seats FROM [Event]
WHERE event_id IN 
(SELECT event_id FROM Booking)
GROUP BY available_seats,total_seats,event_id,event_name
HAVING available_seats > total_seats/2

--3. Calculate the Total Number of Tickets Sold for Each Event
SELECT event_id,SUM(num_tickets) AS Total_tickets_sold
FROM Booking 
WHERE event_id IN
(SELECT event_id FROM [Event])
GROUP BY event_id               

--4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery 
SELECT customer_id,customer_name
FROM Customer
WHERE  NOT EXISTS
(SELECT customer_id FROM Booking
WHERE Customer.customer_id=Booking.customer_id)

--5. List Events with No Ticket Sales Using a NOT IN Subquery
SELECT event_id,event_name FROM [Event]
WHERE event_id NOT IN
(SELECT event_id FROM Booking)

--6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause
SELECT event_type,subquery1.Total_tickets
FROM [Event] (SELECT event_id,SUM(num_tickets) AS Total_tickets
FROM Booking 
GROUP BY event_id) AS subquery1
WHERE [Event].event_id=subquery1.event_id

--7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause 
SELECT event_id,event_name FROM [Event]
WHERE ticket_price > 
ALL(SELECT AVG(ticket_price) FROM [Event])

--8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery
SELECT customer_id,SUM(total_cost) AS Total_Revenue FROM Booking
WHERE customer_id IN
(SELECT customer_id FROM Customer)
GROUP BY customer_id

--9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause
SELECT customer_id,customer_name FROM Customer
WHERE customer_id IN 
(SELECT customer_id FROM Booking B JOIN [Event] E
ON B.booking_id=E.booking_id
JOIN Venue V
ON E.venue_id=V.venue_id
WHERE venue_name='Wankede')

--10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY
SELECT event_type ,SUM(num_tickets) AS Tickets_sold
FROM (SELECT E.event_type,B.num_tickets 
FROM [Event] E JOIN Booking B 
ON E.event_id=B.event_id) AS subquery
GROUP BY event_type

--11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT
SELECT customer_id,DATENAME(MONTH,booking_date) AS [Month] FROM Booking
WHERE EXISTS
(SELECT customer_id FROM Customer)
GROUP BY customer_id,booking_date

--12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT venue_id,event_name,AVG(ticket_price) AS Avg_ticket_price
FROM [Event] 
WHERE venue_id IN 
(SELECT venue_id FROM Venue)
GROUP BY event_name,venue_id

