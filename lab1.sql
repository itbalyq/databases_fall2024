create database lab1;

create table if not exists users (
    id serial,
    firstname varchar(50),
    lastname varchar (50)
);

alter table users
add isadmin int;

alter table users
alter column isadmin type boolean;

alter table users
alter column isadmin set default 0;

ALTER TABLE users
ADD PRIMARY KEY (id);

create table if not exists tasks (
    id serial,
    name varchar(50),
    user_id int
);

drop table tasks;

drop database lab1;
