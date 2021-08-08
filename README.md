# Pewlett-Hackard-Analysis
---------------------------------

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


![retirement_titles.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/retirement_titles.csv)****

- When verifying the data output we notice that employees have moved up in the company and had held multiple positions in the company so we used this code to get their most recent postions within Pwelett-Hackard.  This removed any duplicate entries for our summary of the data.

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.from_date DESC;


![unique_titles.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/unique_titles.csv)

-  Next we were able to summarize the data by the retiring titles.

count	title
29415	Senior Engineer
28255	Senior Staff
14221	Engineer
12242	Staff
4502	Technique Leader
1761	Assistant Engineer
2	Manager
![image](https://user-images.githubusercontent.com/85971908/128618794-79f4b330-a52e-4741-ada1-6bcc2f04f464.png)


![retiring_titles.csv](https://github.com/Bionicbabes/Pewlett-Hackard-Analysis/blob/main/Data/retiring_titles.csv)










