# Pewlett-Hackard-Analysis
---------------------------------

**Overview of the analysis**
------------------------------------------

- Determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. Then, you’ll write a report that summarizes your analysis and helps prepare Bobby’s manager for the “silver tsunami” as many current employees reach retirement age.

**Results**
------------------------------------------

**The Number of Retiring Employees by Title**
------------------------------------------

- As many employees start to reach the retirement age our boss has given us a task to create a "Retirement Titles" table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955.  

- To start we were given the following six spreadsheets containing company data from HR.  We started with an Entity Relationship Diagram (ERD) to establish how all the data was connected and how we will reference the data between tables.

![EmployeeDB.png](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/EmployeeDB.png)

- Next we were able to derive the "Retirement Titles" by first getting all the sorting through all the employess whose birth date where between 01/01/1952 and 12/31/1955.

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


![retirement_titles.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/retirement_titles.csv)

- When verifying the data output we notice that employees have moved up in the company and had held multiple positions in the company so we used this code to get their most recent postions within Pwelett-Hackard.  This removed any duplicate entries for our summary of the data.

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.from_date DESC;


![unique_titles.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/unique_titles.csv)

-  Next we were able to summarize the data by the retiring titles using the query below.

SELECT COUNT(ut.title), 
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

![image](https://user-images.githubusercontent.com/85971908/128618794-79f4b330-a52e-4741-ada1-6bcc2f04f464.png)

![retiring_titles.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/retiring_titles.csv)


**The Employees Eligible for the Mentorship Program**
------------------------------------------

- Create a "Mentorship-Eligibility" table that holds the current employees who were born between January 1, 1965 and December 31, 1965.  Pwelett-Hackard wants to get all the tribal knowledge from the retiring employess and would like them to start mentoring the up and coming stars of the company.  Below is the query for the table created 

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

**Summary**
------------------------------------------

- How many roles will need to be filled as the "silver tsunami" begins to make an impact?

From our results we can use the "Retiring Titles" table to see how many employees will be retiring by title.

![image](https://user-images.githubusercontent.com/85971908/128618794-79f4b330-a52e-4741-ada1-6bcc2f04f464.png)

The dates given for the retirement age was January 1, 1952 and December 31, 1955.  This is a 3 year window and we may not consider people in the latter years to be quite as ready to retire as the earlier years.  As the silver tsumani BEGINS i would refine my query to only include those people with a birth in 1952.  We can do this by refactoring the code that we already have.

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

![image](https://user-images.githubusercontent.com/85971908/128645132-e141a447-7454-4935-9be2-eca57cacef5f.png)

![retiring_titles_52.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/retiring_titles_52.csv)
