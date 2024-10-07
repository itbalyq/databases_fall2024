CREATE DATABASE lab4;

CREATE TABLE warehouses (
  code SERIAL PRIMARY KEY,
  location VARCHAR(255) NOT NULL ,
  capacity DECIMAL NOT NULL
);

CREATE TABLE boxes (
  code CHAR(4),
  contents VARCHAR(255) NOT NULL ,
  value INTEGER NOT NULL,
  warehouse INTEGER NOT NULL
);

INSERT INTO warehouses(location, capacity) VALUES ('Chicago', 3);
INSERT INTO warehouses(location, capacity) VALUES ('Chicago', 4);
INSERT INTO warehouses(location, capacity) VALUES ('New York', 7);
INSERT INTO warehouses(location, capacity) VALUES ('Los Angeles', 2);
INSERT INTO warehouses(location, capacity) VALUES ('San Francisco', 8);

INSERT INTO boxes(code, contents, value, warehouse) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('TU55', 'Papers', 90, 5);

SELECT * FROM warehouses;
SELECT * FROM boxes;

DROP TABLE warehouses;
DROP TABLE boxes;

--1
SELECT * FROM warehouses;

--2
SELECT *
FROM boxes
WHERE value > 150;

--3
SELECT DISTINCT contents
FROM boxes;

--4
SELECT w.code, b.value
FROM warehouses w
JOIN boxes b ON b.warehouse = w.code;
--OR
SELECT code, capacity
FROM warehouses;

--5
SELECT w.code, b.value
FROM warehouses w
JOIN boxes b ON b.warehouse = w.code
WHERE value > 2;
--OR
SELECT code, capacity
FROM warehouses
WHERE capacity > 2;

--6
INSERT INTO warehouses(location, capacity) VALUES ('New York', 3);

--7
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('H5RT', 'Papers', 200, 2);

--8
UPDATE boxes
SET value = value * 0.85
WHERE value = (
    SELECT value
    FROM boxes
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
);

--9
DELETE FROM boxes
WHERE value < 150;

--10
DELETE FROM boxes
WHERE warehouse IN (
    SELECT w.code
    FROM warehouses w
    WHERE w.location = 'New York'
)
RETURNING *;