CREATE DATABASE lab8;

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5, 2)
);
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO customer (customer_id, customer_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purchase_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO orders (ord_no, purchase_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

--3
CREATE ROLE junior_dev WITH LOGIN;

--4
CREATE OR REPLACE VIEW nyc_salesmen AS
    SELECT * FROM salesman WHERE city = 'New York';
SELECT * FROM nyc_salesmen;

--5
CREATE OR REPLACE VIEW order_salesman_cust AS
    SELECT o.ord_no, s.name, c.customer_name
    FROM orders o
    JOIN salesman s ON o.salesman_id = s.salesman_id
    JOIN customer c on o.customer_id = c.customer_id;
GRANT ALL PRIVILEGES ON order_salesman_cust TO junior_dev;
SELECT * FROM order_salesman_cust;

--6
CREATE OR REPLACE VIEW high_grade_customer AS
    SELECT * FROM customer WHERE grade = (
        SELECT max(grade) FROM customer);
GRANT SELECT ON high_grade_customer TO junior_dev;
SELECT * FROM high_grade_customer;

--7
CREATE OR REPLACE VIEW salesmen_city AS
    SELECT city, COUNT(*) AS salesmen_num
    FROM salesman
    GROUP BY city;
SELECT * FROM salesmen_city;

--8
CREATE OR REPLACE VIEW salesman_morethan1 AS
    SELECT s.name, COUNT(ord_no) AS order_num
    FROM salesman s
    JOIN orders o on s.salesman_id = o.salesman_id
    GROUP BY s.name
    HAVING COUNT(ord_no) > 1;
SELECT * FROM salesman_morethan1;

--9
CREATE ROLE intern;
GRANT junior_dev TO intern;