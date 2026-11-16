-- PART A - DDL COMMANDS
-- Create the database employee and select it:
-- 1. Table Creation (CREATE)

CREATE DATABASE employee;
USE employee;

-- Create the tables. The parent tables (Departments, Location) are created first, then Employees, which
-- refers to both of them through foreign keys.

-- (a) Departments table

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- (b) Location table

CREATE TABLE Location (
location_id INT PRIMARY KEY ,
location VARCHAR(30)
);

-- (c) Employees table

CREATE TABLE Employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50) ,
gender ENUM('M' , 'F') ,
age INT ,
hire_date DATE ,
designation VARCHAR(100) ,
department_id INT ,
location_id INT ,
salary DECIMAL(10 , 2) ,
FOREIGN KEY (department_id) REFERENCES Departments(department_id) ,
FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- Verify the tables:

SHOW TABLES;
DESCRIBE Employees;  

-- 2. Table Alteration (ALTER)
-- Add a new column email to the Employees table:

ALTER TABLE Employees ADD COLUMN email VARCHAR(100);

-- Modify the data type of designation to support a wider range of values (VARCHAR(100) to
-- VARCHAR(255)):

ALTER TABLE Employees MODIFY COLUMN designation VARCHAR(255);

-- Drop the age column:

ALTER TABLE Employees DROP COLUMN age;

-- Rename hire_date to date_of_joining:

ALTER TABLE Employees RENAME COLUMN hire_date TO date_of_joining;

-- Verify the new structure (email added, designation widened, age dropped, hire_date renamed):

DESCRIBE Employees;

-- 3.) Table Renaming (RENAME)

-- Rename the two tables and check the result:

RENAME TABLE Departments TO Departments_Info;
RENAME TABLE Location TO Locations;
SHOW TABLES;

-- 4.) Table Truncation (TRUNCATE)

-- Insert one sample row so that the effect of TRUNCATE can be seen:

INSERT INTO Departments_Info VALUES(1 , 'HR');
INSERT INTO Locations VALUES(1 , 'Chennai');
INSERT INTO Employees
VALUES(101 , 'Arun' , 'M' , '2024-06-10' , 'Developer' , 1 , 1 , 45000.00 , 'arun@example.com');
SELECT COUNT(*) AS total_rows FROM Employees;

-- Truncate the Employees table (all rows are removed, the structure is kept):

TRUNCATE TABLE Employees;
SELECT COUNT(*) AS total_rows FROM Employees;

-- 5.) Database & Table Dropping (DROP)

-- Drop the Employees table first, then the employee database:

DROP TABLE Employees;
DROP DATABASE employee;

-- PART B - CONSTRAINTS

-- 1.) Database Recreation

-- Drop the employee database if it exists, recreate it and select it:

DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

-- 2.) Departments Table

-- Requirements: department_id uniquely identifies each department (PRIMARY KEY); department_name
-- must not be NULL and must not repeat (NOT NULL + UNIQUE).

-- Create the Table

CREATE TABLE Departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3.) Location Table

-- Requirements: unique IDs generated automatically and incremented sequentially (AUTO_INCREMENT
-- PRIMARY KEY); location must not be NULL and must not repeat (NOT NULL + UNIQUE).

-- Create the table:

CREATE TABLE Location (
location_id INT AUTO_INCREMENT PRIMARY KEY,
location VARCHAR(30) NOT NULL UNIQUE
);

-- 4.) Employees Table

-- Requirements and how each one is implemented:

/* Requirement Implementation
Distinct employee identifier - employee_id INT PRIMARY KEY
Name is always provided - employee_name VARCHAR(50) NOT NULL
Gender only 'M' or 'F' - gender ENUM('M','F')
Age is 18 or above - CONSTRAINT chk_emp_age CHECK (age >= 18)
hire_date defaults to current date - hire_date DATE DEFAULT (CURRENT_DATE)
Link to Departments and Location - FOREIGN KEY (department_id) and FOREIGN KEY (location_id) */

-- Create the table:

CREATE TABLE Employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50) NOT NULL,
gender ENUM('M' , 'F'),
age INT,
hire_date DATE DEFAULT (CURRENT_DATE),
designation VARCHAR(100),
department_id INT,
location_id INT,
salary DECIMAL (10 , 2),
CONSTRAINT chk_emp_age CHECK (age >= 18),
CONSTRAINT fk_emp_department FOREIGN KEY (department_id) REFERENCES Departments (department_id),
CONSTRAINT fk_emp_location FOREIGN KEY (location_id) REFERENCES Location (location_id)
);

-- Verify the Table Structures

-- List the tables and describe Departments and Location (PRI = primary key, UNI = unique):

SHOW TABLES;
DESCRIBE Departments;
DESCRIBE Location;

/* Describe Employees (MUL = foreign key column, DEFAULT_GENERATED = default value is an
expression) */

DESCRIBE Employees;
SHOW CREATE TABLE Employees;

-- Testing the Constraints with Sample Data

/* The statements below insert valid data first and then try to break every constraint. Each invalid statement is
rejected by MySQL, which proves the constraint works. */

-- Valid data: location_id is generated automatically and hire_date gets the current date

INSERT INTO Departments VALUES (1 , 'HR'), (2 , 'IT');
INSERT INTO Location (location) VALUES ('Chennai'), ('Madurai');
SELECT * FROM Location;
INSERT INTO Employees
(employee_id , employee_name , gender , age , designation ,
department_id , location_id , salary)
VALUES (101 , 'Arun' , 'M' , 25 , 'Developer' , 2 , 1 , 45000.00);
SELECT employee_id , employee_name , gender , age , hire_date FROM Employees;








