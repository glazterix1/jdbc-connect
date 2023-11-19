CREATE DATABASE company_repository;


CREATE SCHEMA company_storage;


DROP SCHEMA company_storage;


CREATE TABLE company
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL UNIQUE,
    date DATE CHECK (date > '1996-01-01' AND date < '2025-01-01')
    );

DROP TABLE company;

CREATE TABLE employee
(
    id         BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id INT REFERENCES company (id) ON DELETE SET NULL,
    salary     INT,
    UNIQUE (first_name, last_name)
);

DROP TABLE employee;
-- NOT NULL
-- UNIQUE
-- CHECK
-- PRIMARY KEY == UNIQUE, NOT NULL
-- foreign key

INSERT INTO company(name,  date)
VALUES ('Yandex', '2021-01-01'),
       ('Apple', '2022-01-01'),
       ('Google', '2020-01-01'),
       ('Amazon', '2021-01-01');

DELETE
FROM company;

INSERT INTO employee(first_name, last_name, company_id, salary)
VALUES ('Frodo', 'Beggins', 1, 1500),
       ('Gendalf', 'Gray', 2, 2000),
       ('Aragorn', 'Aratorn', NULL, 1200),
       ('Sem', 'Gengy', 2, 2500),
       ('Ivan', 'Ivanov', 4, 1500),
       ('Masha', 'Sidorova', 1, 2200);

DELETE
FROM employee;

SELECT id, name, date
FROM company;

-- SELECT id, first_name, last_name, salary
-- FROM employee
-- ORDER BY first_name, salary DESC
-- LIMIT 1
-- OFFSET 1;

-- SELECT DISTINCT name
-- FROM employee
-- ORDER BY first_name, salary ASC
-- LIMIT 10
-- OFFSET 20

SELECT *
FROM employee
WHERE first_name LIKE 'ro%';

SELECT *
FROM employee
WHERE salary BETWEEN 1000 AND 3000;

SELECT *
FROM employee
WHERE first_name IN ('Frodo', 'Ararorn');

SELECT *
FROM employee
WHERE first_name BETWEEN 'A' AND 'Sf';

-- = > < <= >= !=
-- AND OR
-- LIKE
-- BETWEEN
-- IN

SELECT id, lower(first_name)
FROM employee;

SELECT e.id employee_id, salary employee_salary, c.id company_id, name company_name
FROM employee e
         FULL JOIN company c
                   ON e.company_id = c.id;

-- INNER JOIN - JOIN
-- LEFT OUTER JOIN - LEFT JOIN
-- RIGHT OUTER JOIN - RIGHT JOIN
-- FULL JOIN
-- CROSS JOIN
-- SELF JOIN

SELECT e.id employee_id, salary employee_salary, c.id company_id, name company_name
FROM employee e
         FULL JOIN company c
                   ON e.company_id = c.id;

SELECT first_name
FROM employee e
WHERE e.company_id = (SELECT c.id, c.name
                      FROM company c
                      WHERE c.name = 'Yandex');

SELECT c.id
FROM company c
WHERE c.name = 'Yandex';


SELECT c.name, max(e.salary)
FROM company c
         JOIN employee e
              ON c.id = e.company_id
GROUP BY c.name;