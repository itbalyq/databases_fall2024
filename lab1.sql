CREATE DATABASE lab1;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

ALTER TABLE users
ADD isadmin INT;

ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN;

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT 0;

ALTER TABLE users
ADD PRIMARY KEY (id);

CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INT
);

DROP TABLE tasks;

DROP DATABASE lab1;
