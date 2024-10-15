create table location (
location_id int,
city varchar(50)
)

insert into location(location_id, city) values 
(122,'new york'),
(123,'Dallas'),
(124, 'chicago'),
(167,'boston')

select * from location
create table Department (
department_id int,
Name varchar(50),
location_id int
)

insert into Department(department_id,Name, location_id) values 
( 10,'accounting',122),
(20,'sales',124),
(30, 'Research',123),
(40,'Operations',167)

create table Job (
Job_id int,
designation varchar(50)
)
insert into Job(Job_id, designation) values 
(667,'Clerk'),
(668,'Staff'),
(669, 'Analyst'),
(670,'sales Person'),
(671, 'manager'),
(672,'President')

select * from Job

create table employe (
employee_id int,
First_Name varchar(50),
Last_Name varchar(50),
Middle_Name varchar(50),
Job_id int,
Hire_date DATE,
salary int,
comm int ,
department_id int
)

INSERT INTO employe (employee_id, First_Name, Last_Name, Middle_Name, Job_id, Hire_date, salary, comm, department_id)
VALUES 
    (7369, 'John','Smith', 'Q', 667, '1984-12-17', 800, NULL, 20),
    (7499,'Kevin','Allen', 'J', 670, '1985-02-20', 1600, 300, 30),
    (755, 'Jean','Doyle', 'K', 671, '1985-04-04', 2850, NULL, 30),
    (756, 'Lynn','Dennis', 'S', 671, '1985-05-15', 2750, NULL, 30),
    (757, 'Leslie','Baker',  'D', 671, '1985-06-10', 2200, NULL, 40),
    (7521,  'Cynthia','Wark', 'D', 670, '1985-02-12', 1250, 50, 30); -- Corrected date format for Cynthia Wark's hire date


CREATE TABLE DateTable (
    StartDate DATE,
    EndDate DATE
);
INSERT INTO DateTable (StartDate, EndDate)
VALUES 
    ('1985-04-01', '2024-04-05'),
    ('2024-04-06', '2024-04-10'),
    ('2024-04-11', '2024-04-15'),
    ('2024-04-16', '2024-04-20'),
    ('2024-04-21', '2024-04-25');


----Simple Queries 

--Question 1
select * from employe;

---question 2 
select * from Department;

--- Question 3
select * from Job;

---Question 4 
select * from location;

---Question 5
select First_Name, Last_Name, Salary, Comm from employe

---Question 6
SELECT 
    employee_id AS "ID of the Employee",
    Last_Name AS "Name of the Employee",
    department_id AS "Dep_id"
FROM 
    employe;


	----- Question 7 
	SELECT 
    CONCAT (First_Name,' ', Last_Name) AS "Employee Name",
    salary * 12 AS "Annual Salary"
FROM 
    employe;



---------- where condition question
---- Question 1
SELECT 
   *
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.Last_Name = 'Smith';


-----Question 2 
SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.department_id = 20;

	-----------Question 3

	SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.salary between 2000 and 3000;

	---- Question 4 
SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.department_id in  (10,20);


	--- Question 5 

SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.department_id not in (10,30);

	--- Question 6 
SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.First_Name like 'l%';


---Question 7
SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.First_Name like 'l%e';

	---- Question 8
	
SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
LEN(e.First_Name) = 4
and e.First_Name like 'J%';

--- Question 9
SELECT 
*
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_ID
JOIN 
    job j ON e.Job_id = j.Job_ID
WHERE 
    e.department_id = 30 and salary > 2500;

	----- Question 10
	select * from employe where comm is null;


----- Order by Cluase
----Question 1
SELECT 
    employee_id AS "Employee ID",
    Last_Name AS "Last Name"
FROM 
    employe
ORDER BY 
    employee_id ASC;

--- Question 2
SELECT 
    employee_id AS "Employee ID",
    concat(First_Name,' ', Last_Name) AS "Name"
FROM 
    employe
ORDER BY 
    salary ASC;

	--- Question 3
	select * from employe order by Last_Name asc;

	--- Question 4

	select * from employe order by Last_Name asc, department_id desc;

	----- Group by clause and having clause
---- Question 1
select 
      d.Name ,
      MIN(salary) as "minimum_salary", 
	  MAX(salary) as "maximum_salary", 
	  AVG(salary) as "average_salary"   
from 
    employe as e 
inner join 
          Department as d on e.department_id=d.department_id 
group by  
       d.Name ;

---- Question 2

select 
     j.designation ,
	 MIN(salary) as "minimum_salary", 
	 MAX(salary) as "maximum_salary", 
	 AVG(salary) as "average_salary"   
from 
    employe as e 
inner join 
         Job as J on e.Job_id=j.Job_id 
group by 
   j.designation ;

---- Question 3
SELECT FORMAT(Hire_date, 'yyyy-MM') AS "Join Month", 
       COUNT(*) AS "Number of Employees Joined"
FROM  
     employe
GROUP BY 
    FORMAT(Hire_date, 'yyyy-MM')
ORDER BY 
    FORMAT(Hire_date, 'yyyy-MM') ASC;

	--- Question 4
SELECT 
    YEAR(Hire_date) AS "Year",
    MONTH(Hire_date) AS "Month",
    COUNT(*) AS "Number of Employees"
FROM 
    employe
GROUP BY 
    YEAR(Hire_date), MONTH(Hire_date)
ORDER BY 
    YEAR(Hire_date) ASC, MONTH(Hire_date) ASC;


	--- Question 5
SELECT 
    department_id AS "Department ID",
    COUNT(*) AS "Employee Count"
FROM 
    employe
GROUP BY 
    department_id
HAVING 
    COUNT(*) >= 4;

	---- Question 6

 SELECT   
    Month(Hire_date) AS "Join Month",
    COUNT(*) AS "Employees in feb"
FROM 
    employe
WHERE 
    MONTH(Hire_date) = 2
GROUP BY 
    month(Hire_date)
order by 
    month(Hire_date) ;


---- Question 7
SELECT 
    Month(Hire_date) AS "Join Month",
    COUNT(*) AS "Employees Joined in May,June"
FROM 
    employe
WHERE 
    MONTH(Hire_date)in (5,6)
GROUP BY 
    month(Hire_date);

---- Question 8
SELECT   
    Year(Hire_date) AS "Join Year",
    COUNT(*) AS "Employees Joined in year 1985"
FROM 
    employe
WHERE 
    year(Hire_date) = 1985
GROUP BY 
    year(Hire_date)
order by 
    year(Hire_date) ;

----- Question 9

SELECT   
    Month(Hire_date) AS "Join Month",
    COUNT(*) AS "Employees Joined each month"
FROM 
    employe
WHERE 
    year(Hire_date) = 1985
GROUP BY 
    month(Hire_date)
order by 
    month(Hire_date) ;

------ Question 10

 SELECT   
    Month(Hire_date) AS "Join Month",
    COUNT(*) AS "Employees joined in april"
FROM 
    employe
WHERE 
    year(Hire_date) = 1985 and MONTH(Hire_date) = 4
GROUP BY 
    month(Hire_date)
order by 
    month(Hire_date) ;

--Question 11
SELECT 
    department_id AS "Department ID",
    COUNT(*) AS "Number of Employees Joined in April 1985"
FROM 
    employe
WHERE 
    MONTH(Hire_date) = 4
    AND YEAR(Hire_date) = 1985
GROUP BY 
    department_id
HAVING 
    COUNT(*) >= 3;

	
	
------------------------ Joins ---------------------------

-------Question 1
 
select 
    e.employee_id as "employeid",
    e.First_Name  as "firstname",
	e.Last_Name   as "lastname" ,
	d.Name        as "employee department"
from
   employe as e
inner join
   Department as d on e.department_id= d.department_id

   ---- Question 2
   
 select 
         e.employee_id as "EmployeId",
		 e.First_Name  as "Firstname",
		 e.Last_Name   as "Lastname" ,
		 j.designation as "Employee Designation"
from
   employe as e
inner join
   Job as j on e.Job_id= j.Job_id

   --- Question 3

select 
    e.employee_id as "Employe Id",
    e.First_Name  as "Firstname",
	e.Last_Name   as "Lastname" ,
	d.Name        as "Employee Department",
	l.city        as "City" 
from
   employe as e
inner join
   Department as d on e.department_id= d.department_id
inner join 
   location as l on l.location_id= d.location_id


---- Question 4
SELECT 
    d.Department_Id AS "Department ID",
    d.Name AS "Department Name",
    COUNT(e.employee_id) AS "Number of Employees"
FROM 
    department d
LEFT JOIN 
    employe e ON d.Department_Id = e.department_id
GROUP BY 
    d.Department_Id, d.Name
ORDER BY 
    d.Department_Id;

	--- Question 5
SELECT 
    d.Department_Id AS "Department ID",
    d.Name AS "Department Name",
    COUNT(e.employee_id) AS "Number of Employees"
FROM 
    department d
LEFT JOIN 
    employe e ON d.Department_Id = e.department_id
where
 d.Name = 'Sales'
GROUP BY 
    d.Department_Id, d.Name
ORDER BY 
    d.Department_Id;

---- Question 6
SELECT 
    d.Department_Id AS "Department ID",
    d.Name AS "Department Name",
    COUNT(e.employee_id) AS "Number of Employees"
FROM 
    department d
LEFT JOIN 
    employe e ON d.Department_Id = e.department_id
GROUP BY 
    d.Department_Id, d.Name
having 
    COUNT(employee_id) >= 3
ORDER BY 
    d.Name asc;

----- Question 7

SELECT 
    COUNT(e.employee_id) AS "Employees in Dallas"
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
JOIN 
    location l ON d.Location_Id = l.Location_Id
WHERE 
    l.City = 'Dallas';

---- Question 8
SELECT 
    e.employee_id AS "EmployeeId",
    e.First_Name AS "Firstname",
    e.Last_Name AS "Lastname",
    d.Name AS "Department Name"
FROM 
    employe e
JOIN 
    department d ON e.department_id = d.Department_Id
WHERE 
    d.Name IN ('Sales', 'Operations');

	----- Conditional Statment
---- Question 1
SELECT 
    e.employee_id AS "EmployeeID",
    e.First_Name AS "FirstName",
    e.Last_Name AS "LastName",
    e.salary AS "Salary",
    CASE
        WHEN e.salary >= 5000 THEN 'A'
        WHEN e.salary >= 3000 AND e.salary < 5000 THEN 'B'
        WHEN e.salary >= 2000 AND e.salary < 3000 THEN 'C'
        ELSE 'D'
    END AS "Grade"
FROM 
    employe e;

----- Question 2
SELECT 
    CASE
        WHEN salary >= 3000 THEN 'Grade A'
        WHEN salary >= 2000 THEN 'Grade B'
        WHEN salary >= 1000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS "Salary Grade",
    COUNT(*) AS "Number of Employees"
FROM 
    employe
GROUP BY 
    CASE
        WHEN salary >= 3000 THEN 'Grade A'
        WHEN salary >= 2000 THEN 'Grade B'
        WHEN salary >= 1000 THEN 'Grade C'
        ELSE 'Grade D'
    END
ORDER BY 
    MIN(salary);

------ Question 3
SELECT 
    CASE
        WHEN salary BETWEEN 2000 AND 2999 THEN 'Grade B'
        WHEN salary BETWEEN 3000 AND 3999 THEN 'Grade C'
        WHEN salary BETWEEN 4000 AND 4999 THEN 'Grade D'
        ELSE 'Other'
    END AS "Salary Grade",
    COUNT(*) AS "Number of Employees"
FROM 
    employe
WHERE 
    salary BETWEEN 2000 AND 5000
GROUP BY 
    CASE
        WHEN salary BETWEEN 2000 AND 2999 THEN 'Grade B'
        WHEN salary BETWEEN 3000 AND 3999 THEN 'Grade C'
        WHEN salary BETWEEN 4000 AND 4999 THEN 'Grade D'
        ELSE 'Other'
    END
ORDER BY 
    MIN(salary);



------ Subqueries 
---Question 1
select 
   *
from
   employe
where	
   salary = (select max(salary) from employe);
 
 ---Question 2
 SELECT 
    employee_id AS "EmployeeID",
    First_Name AS "FirstName",
    Last_Name AS "LastName",
    department_id AS "DepartmentID"
FROM 
    employe
WHERE 
    department_id IN (SELECT Department_Id FROM department WHERE Name = 'Sales');

	----- Question 3
SELECT 
    employee_id AS "EmployeeID",
    First_Name AS "FirstName",
    Last_Name AS "LastName",
    (SELECT Designation FROM job WHERE Job_ID = employe.Job_id) AS "Job Title"
FROM 
    employe
WHERE 
    Job_id IN (SELECT Job_ID FROM job WHERE Designation = 'Clerk');

----- Question 4
SELECT 
    e.employee_id AS "Employee ID",
    e.First_Name AS "First Name",
    e.Last_Name AS "Last Name"
FROM 
    employe e
WHERE 
    e.department_id IN (
        SELECT d.Department_Id
        FROM department d
        WHERE d.Location_Id = (
            SELECT Location_Id
            FROM location
            WHERE City = 'Boston'
        )
    );

---Question 5


SELECT 
    COUNT(*) AS "Employees in Sales Department"
FROM 
    employe
WHERE 
    department_id IN (
        SELECT Department_Id
        FROM department
        WHERE Name = 'Sales'
    );

--- Question 6 
UPDATE employe
SET salary = salary * 1.1  -- Increase salary by 10%
WHERE Job_id IN (
    SELECT Job_ID
    FROM job
    WHERE Designation = 'Clerk'
);

--- Question 7
SELECT 
    employee_id AS "Employee ID",
    First_Name AS "FirstName",
    Last_Name AS "LastName",
    salary AS "Salary"
FROM (
    SELECT 
        employee_id,
        First_Name,
        Last_Name,
        salary,
        ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank
    FROM 
        employe
) ranked_employees
WHERE 
    salary_rank = 2;

	--- Question 8
SELECT 
    e.employee_id AS "Employee ID",
    e.First_Name AS "FirstName",
    e.Last_Name AS "LastName",
    e.salary AS "Salary"
FROM 
    employe e
WHERE 
    e.salary > (
        SELECT MAX(salary)
        FROM employe
        WHERE department_id = 30
    );

----Question 9
SELECT 
    Department_Id AS "Department ID",
    Name AS "Department Name"
FROM 
    department
WHERE 
    Department_Id NOT IN (
        SELECT DISTINCT department_id
        FROM employe
        WHERE department_id IS NOT NULL
    );

---- Question 10
----- Can perform in two ways by using join and subquery together and by using only subquery
SELECT 
    employee_id AS "Employee ID",
    First_Name AS "First Name",
    Last_Name AS "Last Name",
    salary AS "Salary",
    department_id AS "Department ID"
FROM 
    employe
WHERE 
    salary > (
        SELECT AVG(salary)
        FROM employe AS e2
        WHERE e2.department_id = employe.department_id
    );


--------------------------------------------------------------------------------------------------------------------------------------------------------

	






