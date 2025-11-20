-- =========================
-- CREATE DATABASE
-- =========================
DROP DATABASE IF EXISTS gymdb;
CREATE DATABASE gymdb CHARACTER SET utf8mb4;
USE gymdb;

-- =========================
-- DROP TABLES (SAFE)
-- =========================
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS ClassBookings;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS MembershipTypes;
DROP TABLE IF EXISTS Trainers;
DROP TABLE IF EXISTS Classes;
SET FOREIGN_KEY_CHECKS = 1;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE MembershipTypes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80),
    duration_days INT,
    price DECIMAL(10,2),
    description TEXT
);

CREATE TABLE Trainers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120),
    phone VARCHAR(20),
    email VARCHAR(150),
    specialty VARCHAR(100),
    hire_date DATE,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(80),
    last_name VARCHAR(80),
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    dob DATE,
    gender CHAR(1),
    address VARCHAR(255),
    membership_type_id INT,
    membership_start DATE,
    membership_end DATE,
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (membership_type_id) REFERENCES MembershipTypes(id)
);

CREATE TABLE Payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    method VARCHAR(50),
    note VARCHAR(255),
    FOREIGN KEY (member_id) REFERENCES Members(id)
);

CREATE TABLE Attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    checkin_time DATETIME,
    checkout_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES Members(id)
);

CREATE TABLE Classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(120),
    description TEXT,
    trainer_id INT,
    start_time TIME,
    duration_minutes INT,
    capacity INT,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(id)
);

CREATE TABLE ClassBookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    member_id INT,
    booking_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (class_id) REFERENCES Classes(id),
    FOREIGN KEY (member_id) REFERENCES Members(id)
);

-- =========================
-- INSERT MEMBERSHIP TYPES (20)
-- =========================
INSERT INTO MembershipTypes (name, duration_days, price, description) VALUES
('Monthly Basic',30,1000,'Basic monthly'),
('Monthly Plus',30,1500,'Monthly with classes'),
('Quarterly Basic',90,2500,'3-month basic'),
('Quarterly Plus',90,3000,'3-month plus'),
('Half Yearly',180,5000,'6 months'),
('Yearly Basic',365,9000,'Yearly basic'),
('Yearly Plus',365,12000,'Yearly premium'),
('Student Monthly',30,600,'Student discount'),
('Student Quarterly',90,1500,'Student 3 months'),
('Senior Annual',365,6000,'Senior members'),
('Corporate 1',365,18000,'Corporate plan A'),
('Corporate 2',365,22000,'Corporate plan B'),
('Weekend Plan',30,700,'Weekend only'),
('Trial 7 Days',7,0,'Free trial'),
('Family Basic',365,16000,'Family basic'),
('Family Premium',365,24000,'Family plus'),
('Couple Plan',90,4500,'Couple 3 months'),
('Flex 10 Visits',365,3000,'10 visit pass'),
('Premium 1 Month',30,2000,'Premium Monthly'),
('Premium 1 Year',365,25000,'Premium yearly');

-- =========================
-- INSERT TRAINERS (20)
-- =========================
INSERT INTO Trainers (name,phone,email,specialty,hire_date) VALUES
('Anita Sharma','9000000001','anita@gym.com','Yoga','2021-01-01'),
('Karan Patel','9000000002','karan@gym.com','Strength','2020-06-10'),
('Suresh Kumar','9000000003','suresh@gym.com','Cardio','2019-03-20'),
('Meena Reddy','9000000004','meena@gym.com','Pilates','2022-04-05'),
('Ravi Singh','9000000005','ravi@gym.com','Crossfit','2023-01-10'),
('Pooja Verma','9000000006','pooja@gym.com','Zumba','2020-07-23'),
('Arjun Rao','9000000007','arjun@gym.com','Strength','2018-12-01'),
('Deepa Iyer','9000000008','deepa@gym.com','Yoga','2017-09-20'),
('Vikram Das','9000000009','vikram@gym.com','HIIT','2023-11-15'),
('Shweta Joshi','9000000010','shweta@gym.com','Nutrition','2022-03-12'),
('Manish Gupta','9000000011','manish@gym.com','Boxing','2019-10-11'),
('Nidhi Rao','9000000012','nidhi@gym.com','Dance','2021-07-07'),
('Bala Murthy','9000000013','bala@gym.com','Strength','2016-04-04'),
('Ruchi Mehta','9000000014','ruchi@gym.com','Pilates','2018-12-12'),
('Amit Bhat','9000000015','amit@gym.com','Crossfit','2021-02-02'),
('Priya Singh','9000000016','priya@gym.com','Yoga','2020-05-20'),
('Naveen Kumar','9000000017','naveen@gym.com','Cardio','2024-01-01'),
('Sana Khan','9000000018','sana@gym.com','Zumba','2023-06-15'),
('Rohit Verma','9000000019','rohit@gym.com','Functional','2019-01-15'),
('Geeta Lal','9000000020','geeta@gym.com','Stretching','2020-10-10');

-- =========================
-- INSERT MEMBERS (20)
-- =========================
INSERT INTO Members (first_name,last_name,email,phone,dob,gender,address,membership_type_id,membership_start,membership_end) VALUES
('Vennela','Reddy','vennela@example.com','9876500001','2002-04-15','F','Hyderabad',1,'2025-11-01','2025-11-30'),
('Ravi','Kumar','ravi@example.com','9876500002','1990-03-21','M','Hyd',2,'2025-01-10','2025-02-10'),
('Sita','Patel','sita@example.com','9876500003','1995-07-12','F','Bengaluru',3,'2025-08-01','2025-10-30'),
('Aman','Shah','aman@example.com','9876500004','1988-02-02','M','Mumbai',4,'2025-06-01','2025-09-01'),
('Priya','Nair','priya@example.com','9876500005','1998-11-30','F','Chennai',5,'2025-09-15','2026-03-15'),
('Karan','Desai','karan@example.com','9876500006','1991-12-01','M','Pune',6,'2025-03-01','2026-03-01'),
('Nisha','Singh','nisha@example.com','9876500007','1993-05-05','F','Delhi',7,'2025-10-01','2026-01-01'),
('Rahul','Bhat','rahul@example.com','9876500008','1985-09-09','M','Gurgaon',8,'2024-11-15','2025-11-14'),
('Sanjay','Khan','sanjay@example.com','9876500009','1978-01-01','M','Noida',9,'2025-02-01','2026-02-01'),
('Anjali','Ghosh','anjali@example.com','9876500010','1996-06-06','F','Kolkata',10,'2025-07-01','2026-07-01'),
('Manoj','Verma','manoj@example.com','9876500011','1989-04-04','M','Lucknow',11,'2025-11-05','2026-11-05'),
('Richa','Sharma','richa@example.com','9876500012','1994-08-18','F','Jaipur',12,'2025-10-20','2026-10-20'),
('Vikas','Yadav','vikas@example.com','9876500013','1992-10-10','M','Kanpur',13,'2025-05-01','2025-10-29'),
('Meera','Bose','meera@example.com','9876500014','2000-12-12','F','Bhopal',14,'2025-04-01','2025-09-30'),
('Sahil','Roy','sahil@example.com','9876500015','1997-03-03','M','Vizag',15,'2025-08-10','2026-08-10'),
('Tina','Dutta','tina@example.com','9876500016','1999-01-25','F','Cuttack',16,'2025-09-01','2026-02-29'),
('Ajay','Kumar','ajay@example.com','9876500017','1987-07-07','M','Patna',17,'2025-06-15','2025-12-15'),
('Sunita','Roy','sunita@example.com','9876500018','1983-11-11','F','Ranchi',18,'2025-11-10','2026-11-10'),
('Vivek','Malik','vivek@example.com','9876500019','1990-09-19','M','Indore',19,'2025-10-05','2025-11-05'),
('Lata','Kaur','lata@example.com','9876500020','1986-02-28','F','Jalandhar',20,'2025-11-12','2026-11-12');

-- =========================
-- INSERT PAYMENTS (20)
-- =========================
INSERT INTO Payments (member_id,amount,payment_date,method,note) VALUES
(1,1000,'2025-11-01','card','Monthly fee'),
(2,1500,'2025-01-10','upi','Monthly'),
(3,2500,'2025-08-01','cash','Quarterly'),
(4,3000,'2025-06-01','card','Quarterly'),
(5,5000,'2025-09-15','card','Half yearly'),
(6,9000,'2025-03-01','netbank','Yearly'),
(7,600,'2025-10-01','upi','Student'),
(8,1500,'2024-11-15','card','Student quarterly'),
(9,18000,'2025-02-01','bank','Corporate'),
(10,22000,'2025-07-01','bank','Corporate'),
(11,0,'2025-11-05','trial','Trial'),
(12,700,'2025-10-20','cash','Weekend plan'),
(13,16000,'2025-05-01','bank','Family'),
(14,24000,'2025-04-01','bank','Family premium'),
(15,4500,'2025-08-10','card','Couple'),
(16,3000,'2025-09-01','upi','10 visits'),
(17,2000,'2025-06-15','card','Premium'),
(18,25000,'2025-11-10','bank','Premium year'),
(19,600,'2025-10-05','upi','Student month'),
(20,2000,'2025-11-12','cash','Extras');

-- =========================
-- INSERT ATTENDANCE (20)
-- =========================
INSERT INTO Attendance (member_id,checkin_time,checkout_time) VALUES
(1,'2025-11-15 06:25','2025-11-15 07:30'),
(2,'2025-11-14 18:00','2025-11-14 19:10'),
(3,'2025-10-05 07:00','2025-10-05 08:00'),
(4,'2025-09-01 06:10','2025-09-01 07:20'),
(5,'2025-09-16 19:00','2025-09-16 20:00'),
(6,'2025-04-02 06:05','2025-04-02 07:00'),
(7,'2025-11-02 17:00','2025-11-02 18:00'),
(8,'2025-10-20 08:00','2025-10-20 09:00'),
(9,'2025-02-10 06:30','2025-02-10 07:30'),
(10,'2025-07-15 18:00','2025-07-15 19:00'),
(11,'2025-11-06 10:00','2025-11-06 11:00'),
(12,'2025-11-19 07:00','2025-11-19 07:50'),
(13,'2025-05-20 06:40','2025-05-20 07:30'),
(14,'2025-04-05 06:50','2025-04-05 07:45'),
(15,'2025-08-12 18:10','2025-08-12 19:00'),
(16,'2025-09-10 07:20','2025-09-10 08:05'),
(17,'2025-06-16 06:00','2025-06-16 07:00'),
(18,'2025-11-11 17:30','2025-11-11 18:20'),
(19,'2025-10-06 06:15','2025-10-06 07:00'),
(20,'2025-11-13 09:00','2025-11-13 10:00');

-- =========================
-- INSERT CLASSES (20)
-- =========================
INSERT INTO Classes (title,description,trainer_id,start_time,duration_minutes,capacity) VALUES
('Morning Yoga','Yoga Session',1,'06:30',60,20),
('Strength Basics','Strength Training',2,'07:30',60,15),
('Cardio Blast','Cardio Workout',3,'18:00',45,30),
('Pilates Core','Pilates',4,'08:00',50,20),
('Crossfit','Crossfit Workout',5,'19:00',45,15),
('Zumba','Zumba Dance',6,'17:30',50,25),
('Advanced Strength','Strength Pro',7,'06:00',60,15),
('Evening Yoga','Yoga Flow',8,'19:30',60,20),
('HIIT','HIIT Session',9,'06:45',30,20),
('Nutrition Talk','Diet Session',10,'12:00',60,40),
('Boxing Basics','Boxing Intro',11,'18:30',45,20),
('Dance Fitness','Dance Workout',12,'16:00',60,30),
('Functional Training','Mobility',13,'07:00',45,20),
('Pilates Stretch','Stretch',14,'09:00',45,20),
('Crossfit Open','Crossfit',15,'06:15',60,15),
('Morning Yoga 2','Gentle Yoga',16,'05:45',45,20),
('Cardio Endurance','Cardio',17,'17:00',75,30),
('Zumba Party','Zumba Fun',18,'20:00',50,25),
('Mobility Flow','Mobility Class',19,'10:00',50,20),
('Stretch & Relax','Cool Down',20,'21:00',30,25);

-- =========================
-- INSERT CLASS BOOKINGS (20)
-- =========================
INSERT INTO ClassBookings (class_id,member_id,booking_date,status) VALUES
(1,1,'2025-11-15','booked'),
(2,2,'2025-11-14','booked'),
(3,3,'2025-10-05','attended'),
(4,4,'2025-09-01','attended'),
(5,5,'2025-09-16','cancelled'),
(6,6,'2025-04-02','attended'),
(7,7,'2025-11-02','booked'),
(8,8,'2025-10-20','booked'),
(9,9,'2025-02-10','attended'),
(10,10,'2025-07-15','attended'),
(11,11,'2025-11-06','booked'),
(12,12,'2025-11-19','booked'),
(13,13,'2025-05-20','attended'),
(14,14,'2025-04-05','attended'),
(15,15,'2025-08-12','attended'),
(16,16,'2025-09-10','booked'),
(17,17,'2025-06-16','attended'),
(18,18,'2025-11-11','booked'),
(19,19,'2025-10-06','attended'),
(20,20,'2025-11-13','booked');

select * from MembershipTypes;
SELECT * FROM Trainers;
SELECT * FROM Members;
SELECT * FROM Payments;
SELECT * FROM Attendance;
SELECT * FROM Classes;
SELECT * FROM ClassBookings;


