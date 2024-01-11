
SELECT * FROM employees WHERE salary=24000;

EXPLAIN SELECT * FROM employees WHERE salary=24000;
--  SYNTAX
-- CREATE INDEX index_name ON table_name(col1....);

CREATE INDEX salary ON employees(salary);

EXPLAIN SELECT * FROM employees WHERE salary=24000;

DROP INDEX salary ON employees;

