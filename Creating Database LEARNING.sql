-- Class creating database and tables
-- Here we were taught to use the datatype SERIAL for an id data as it will automatically fill in
-- the series of values as and when we insert a new row and it also removes that entire row when
-- it is removed without adjusting the id numbers
-- For columns like age use SMALLINT as you might not need LARGEINT or INTEGER datatypes

CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	user_name VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);

-- Inserting into tables
SELECT * FROM account;

INSERT INTO account(user_name, password, email, created_on)
VALUES
('Tej', 'password', 'tej@mail.com', CURRENT_TIMESTAMP);

INSERT INTO job(job_name)
VALUES
('Data Scientist');

SELECT * FROM job;

INSERT INTO job(job_name)
VALUES
('BI EXPERT');

INSERT INTO account_job(user_id, job_id, hire_date)
VALUES
(1,1,'2023-10-25');

SELECT * FROM account_job;

SELECT * FROM account;

UPDATE account
SET last_login = CURRENT_TIMESTAMP;

UPDATE account
SET last_login = created_on;

SELECT * FROM account;

UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id;

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login;

-- Class Delete

INSERT INTO job(job_name)
VALUES
('Junior Data Scientist');

SELECT * FROM job;

INSERT INTO job(job_name)
VALUES
('Data Science Manager');

DELETE FROM job
WHERE job_name = 'Data Science Manager'
RETURNING job_id, job_name;

-- Class Alter

CREATE TABLE information(
info_id SERIAL PRIMARY KEY,
title VARCHAR(500) NOT NULL,
person VARCHAR(50) NOT NULL UNIQUE
);

SELECT * FROM information;

ALTER TABLE information
RENAME TO new_info;

SELECT * FROM new_info;

ALTER TABLE new_info
RENAME COLUMN person TO people;

INSERT INTO new_info(title)
VALUES
('Title 1');

-- Class Drop

ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL; 

INSERT INTO new_info(title)
VALUES
('Title 1')

ALTER TABLE new_info
DROP COLUMN people;

ALTER TABLE new_info
DROP COLUMN IF EXISTS people;

-- Class CHECK Constraint

CREATE TABLE employees(
emp_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birth_date DATE CHECK (birth_date > '1950-01-01'),
hire_date DATE CHECK (hire_date > birth_date),
Salary INTEGER CHECK (salary > 12000)
);

INSERT INTO employees(
first_name, last_name, birth_date, hire_date, salary)
VALUES
('Samuel', 'Bernoulli', '1990-12-23', '2020-09-11', +703000);

SELECT * FROM employees;

DELETE FROM employees
WHERE emp_id = 2;



