--1
create function inc(a integer) returns integer as
$$
BEGIN
    return a + 10;
END;
$$
    language plpgsql;
select inc(10);


--2
create or replace function compare(in a integer, in b integer, out res varchar) returns varchar as
$$
BEGIN
    if a > b then
        res := 'greater';
    elsif a = b then
        res := 'equal';
    else
        res := 'lesser';
    end if;
END;
$$
    language plpgsql;
select compare(10, 10);


--3
drop function num_series;
create or replace function num_series(in a integer, out res varchar)
returns varchar
as
$$
declare
    i int := 1;
begin
    res := '';
    while i <= a loop
        res := res || i || case when i < a then ' ' else ' ' end;
        i := i + 1;
    end loop;
end;
    $$
language plpgsql;
select num_series(5);


--4
drop table employees;
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    salary numeric
);
INSERT INTO employees (name, department, salary) VALUES
('John Doe', 'Engineering', 10000),
('Jane Smith', 'Marketing', 20000),
('Alice Johnson', 'Human Resources', 12000),
('Bob Brown', 'Engineering', 17000);
drop function find_employee(name varchar);
create or replace function find_employee(in find_name varchar)
    returns table (emp_id int, emp_name varchar, dep varchar, sal numeric) as
    $$
begin
    return query
    select id, name, department, salary
    from employees
    where name = find_name;
end;
    $$
language plpgsql;
select * from find_employee('John Doe');


--5
drop table products;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC
);
INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 799.99),
('Smartphone', 'Electronics', 499.99),
('Desk Chair', 'Furniture', 89.99),
('Coffee Table', 'Furniture', 129.99);

create or replace function list_products(in category_name varchar)
    returns table (product_id int, product_name varchar, pr numeric) as
    $$
begin
    return query
    select id, name, price
    from products
    where category = category_name;

end;
    $$
language plpgsql;
select * from list_products('Electronics');


--6
create or replace function calculate_bonus(in a numeric, out bonus numeric) returns numeric as
$$
BEGIN
    bonus := a * 0.1;
    return;
END;
$$
    language plpgsql;
select calculate_bonus(10);

create or replace function update_salary(in emp_id int) returns void as
    $$
    declare
    bonus numeric;
    new_salary numeric;
    base_salary numeric;
    begin
        select salary into base_salary from employees where id = emp_id;

        bonus := calculate_bonus(base_salary);
        new_salary := base_salary + bonus;

        update employees set salary = new_salary where id = emp_id;
    end;
    $$
language plpgsql;

select update_salary(2);
select * from employees where id = 2;

--7
create or replace function complex(in a int, in b int, in c varchar, out res varchar) returns varchar as
    $$
    declare
        num_res int;
        string_res varchar;
    begin
       <<first_subblock>>
        begin
        num_res := (a * b) / 100;
        end;

        <<second_subblock>>
        begin
        string_res := upper(c);
        end;

        res := concat('First result: ', num_res, '| Second result: ', string_res);
    end;
    $$
language plpgsql;
select complex(50, 200, 'example');
