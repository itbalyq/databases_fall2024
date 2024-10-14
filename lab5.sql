--1
CREATE DATABASE lab5;

--2
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER NOT NULL,
    salesman_id INTEGER
);

CREATE TABLE orders (
    ord_no INTEGER PRIMARY KEY,
    purch_amt DOUBLE PRECISION,
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER
);

CREATE TABLE salesmen (
    salesman_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DOUBLE PRECISION
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

INSERT INTO salesmen (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'London', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

DROP TABLE customers, orders, salesmen;

--3
SELECT SUM(purch_amt) AS total_purchase_amount
FROM orders;

--4
SELECT AVG(purch_amt) AS avg_purchase_amount
FROM orders;

--5
SELECT COUNT(cust_name) AS number_of_customers
FROM customers;

--6
SELECT MIN(purch_amt) AS minimum_purchase_amount
FROM orders;

--7
SELECT *
FROM customers
WHERE cust_name LIKE '%b';

--8
SELECT o.*
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'New York';

--9
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.purch_amt > 10;

--10
SELECT SUM(grade) AS total_grade
FROM customers;

--11
SELECT *
FROM customers
WHERE cust_name IS NOT NULL;

--12
SELECT MAX(grade) AS maximum_grade
FROM customers;

