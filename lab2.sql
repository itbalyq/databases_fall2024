CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries (country_name, region_id, population)
VALUES ('Canada', 1, 38000000);

INSERT INTO countries (country_id, country_name)
VALUES (2, 'Japan');

INSERT INTO countries (country_name, region_id, population)
VALUES ('Australia', NULL, 25000000);

INSERT INTO countries (country_name, region_id, population)
VALUES ('India', 3, 1390000000),
       ('Germany', 2, 83000000),
       ('Brazil', 4, 212000000);

SELECT * FROM countries;

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

INSERT INTO countries_new
SELECT * FROM countries;

UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

SELECT country_name,
       population * 1.10 AS "New Population"
FROM countries;

DELETE FROM countries
WHERE population < 100000
RETURNING *;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

DELETE FROM countries
RETURNING *;
