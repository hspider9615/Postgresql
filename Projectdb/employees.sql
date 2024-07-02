-- select * from employees;

-- ================================================
-- meny entry change ya Update:-
	
-- CREATE OR REPLACE PROCEDURE update_emp_salary(
-- 	p_employee_id INT,
-- 	p_new_salary NUMERIC
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- 	UPDATE employees
-- 	SET salary = p_new_salary
-- 	WHERE emp_id = p_employee_id;
-- END;
-- $$;
-- ---------------------------------------------
-- Short cut method:-

-- CALL update_emp_salary(3, 71000);

-- ================================================

-- CREATE OR REPLACE PROCEDURE add_employee(
--     p_emp_id INTEGER,  -- Assuming emp_id is provided or managed automatically
--     p_fname VARCHAR,
--     p_lname VARCHAR,
--     p_email VARCHAR,
--     p_dept VARCHAR,
--     p_salary NUMERIC
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO employees (emp_id, fname, lname, email, dept, salary)
--     VALUES (p_emp_id, p_fname, p_lname, p_email, p_dept, p_salary);
-- END;
-- $$;
-- ---------------------------------------------------------
-- CALL add_employee(11, 'Het','Gadara','hspider961@gmail.com','IT',145000);

=============================================================
-- User Define Function ----------------
	
-- select * from employees;

-- select dept, max(salary) from 
-- 	employees
-- 	group by dept;

-- SELECT 
-- 	e.emp_id,
-- 	e.fname,
-- 	e.salary
-- FROM
-- 	employees e
-- WHERE e.dept = 'IT'
-- 	AND e.salary = (
-- 	SELECT MAX(emp.salary)
-- 	FROM employees emp
-- 	WHERE emp.dept = 'IT'
-- 	);

+++++++++++++++++++++++++++++++++++++++++++++	
	
-- SELECT * FROM dept_max_sal_emp('Finance');

-- ^
-- small query
-- ||||||||||||||||||||||||||||||||||||||||

	
-- CREATE OR REPLACE FUNCTION dept_max_sal_emp(dept_name VARCHAR)
-- RETURNS TABLE(emp_id INT, fname VARCHAR, salary NUMERIC)
-- AS $$
-- BEGIN
-- 	RETURN QUERY
-- 	SELECT
-- 		e.emp_id, e.fname, e.salary
-- 	FROM
-- 		employees e
-- 	WHERE
-- 		e.dept = dept_name
-- 		AND e.salary = (
-- 			SELECT MAX(emp.salary)
-- 			FROM employees emp
-- 			WHERE emp.dept = dept_name
-- 		);
-- END;
-- $$ LANGUAGE plpgsql;

=================================================
-- Window function in over()
	
SELECT fname, salary,
	SUM(salary) OVER(ORDER BY salary)
FROM  employees;

SELECT 
	ROW_NUMBER() OVER(PARTITION BY dept),
	fname, dept, salary
	FROm employees;

SELECT 
	fname, salary,
	RANK() OVER(ORDER BY salary DESC)   
	FROm employees;

-- ek sathe 2 loko sarakh hoy tya re DENSE_RANK not use thay

SELECT 
	fname, salary,
	DENSE_RANK() OVER(ORDER BY salary DESC)
	FROm employees;

SELECT 
	fname, salary,
 	LAG(salary) OVER(ORDER BY salary DESC)   
	FROm employees;