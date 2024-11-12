--1
CREATE INDEX countries_name_index ON countries(name);

--2
CREATE INDEX employees_name_index ON employees(name, surname);

--3
CREATE UNIQUE INDEX employees_salary_unique_index ON employees(salary);

--4
CREATE INDEX employees_name_index ON employees(substring(name FROM 1 for 4));

--5
CREATE INDEX employees_index ON employees(department_id);
CREATE INDEX department_dep_id_index ON departments(department_id);
CREATE INDEX employees_salary_index ON employees(salary);
CREATE INDEX department_budget_index ON departments(budget);
