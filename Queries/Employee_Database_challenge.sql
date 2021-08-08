-- Deliverable 1
-- Retirement_titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

DROP TABLE retiring_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.from_date DESC;

SELECT * FROM unique_titles;


-- Retiring_titles Summary table

SELECT COUNT(ut.title), 
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles;

-- Deliverable 2
--Mentorhsip Program Table 
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND de.to_date = '9999-01-01'
ORDER BY e.birth_date ASC
; 

-- Summary 
-- How many roles will need to be filled as the "silver tsunami" begins to make an impact?
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date,
	e.birth_date
INTO retirement_titles_52
FROM employees as e
INNER JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1952-12-31')
ORDER BY e.birth_date DESC;

SELECT DISTINCT ON (rts.emp_no) rts.emp_no,
	rts.first_name,
	rts.last_name,
	rts.title
INTO unique_titles_52
FROM retirement_titles_52 as rts
ORDER BY rts.emp_no, rts.from_date DESC;

SELECT COUNT(uts.title), 
	uts.title
INTO retiring_titles_52
FROM unique_titles_52 as uts
GROUP BY uts.title
ORDER BY COUNT(uts.title) DESC;

--Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

SELECT ut.emp_no,
	ut.first_name,
	ut.last_name,
	di.dept_name
INTO retirement_dept
FROM unique_titles as ut
INNER JOIN dept_info as di 
ON ut.emp_no = di.emp_no;

SELECT COUNT(rd.dept_name), 
	rd.dept_name
INTO retiring_dept
FROM retirement_dept as rd
GROUP BY rd.dept_name
ORDER BY COUNT(rd.dept_name) DESC;
