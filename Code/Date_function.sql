-- 1. Create Sample Database and Table
CREATE DATABASE company_db;

USE company_db;

CREATE TABLE employee_attendance (
    emp_id INT,
    emp_name VARCHAR(100),
    check_in DATETIME,
    check_out DATETIME,
    joining_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
2. Insert Sample Data
INSERT INTO employee_attendance
(emp_id, emp_name, check_in, check_out, joining_date)
VALUES
(101, 'Raj', '2026-05-20 09:15:00', '2026-05-20 18:10:00', '2020-06-15'),

(102, 'Anu', '2026-05-21 08:55:00', '2026-05-21 17:45:00', '2021-03-10'),

(103, 'Vishwa', '2026-05-22 10:05:00', '2026-05-22 19:20:00', '2019-11-25');
3. Current Date and Time Functions
SELECT Current_date
	CURRENT_DATE()
SELECT CURRENT_DATE();
	CURRENT_TIME()
SELECT CURRENT_TIME();
	CURRENT_TIMESTAMP()
SELECT CURRENT_TIMESTAMP();
NOW()
SELECT NOW();
SYSDATE()
SELECT SYSDATE();
4. Extracting Date Parts
YEAR()
SELECT emp_name, YEAR(joining_date) AS joining_year
FROM employee_attendance;
MONTH()
SELECT emp_name, MONTH(joining_date) AS joining_month
FROM employee_attendance;
MONTHNAME()
SELECT emp_name, MONTHNAME(joining_date) AS month_name
FROM employee_attendance;
DAY()
SELECT emp_name, DAY(joining_date) AS day_number
FROM employee_attendance;
DAYNAME()
SELECT emp_name, DAYNAME(joining_date) AS day_name
FROM employee_attendance;
DAYOFMONTH()
SELECT DAYOFMONTH(CURDATE());
DAYOFYEAR()
SELECT DAYOFYEAR(CURDATE());
WEEK()
SELECT WEEK(CURDATE());
WEEKDAY()
SELECT WEEKDAY(CURDATE());
QUARTER()
SELECT QUARTER(CURDATE());
5. Extracting Time Parts
HOUR()
SELECT emp_name, HOUR(check_in)
FROM employee_attendance;
MINUTE()
SELECT emp_name, MINUTE(check_in)
FROM employee_attendance;
SECOND()
SELECT emp_name, SECOND(check_in)
FROM employee_attendance;
6. Date Formatting
DATE_FORMAT()
SELECT emp_name,
DATE_FORMAT(check_in, '%d-%m-%Y %H:%i:%s') AS formatted_date
FROM employee_attendance;
Common Format Specifiers
Specifier	Meaning
%d	Day
%m	Month
%Y	4-digit year
%y	2-digit year
%H	Hour
%i	Minutes
%s	Seconds
%W	Weekday name
%M	Month name
7. Date Arithmetic
DATE_ADD()
SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL 2 MONTH);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);
DATE_SUB()
SELECT DATE_SUB(CURDATE(), INTERVAL 15 DAY);
8. Difference Between Dates
DATEDIFF()
SELECT emp_name,
DATEDIFF(CURDATE(), joining_date) AS total_days
FROM employee_attendance;
TIMESTAMPDIFF()
Difference in Years
SELECT emp_name,
TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS experience_years
FROM employee_attendance;
Difference in Months
SELECT emp_name,
TIMESTAMPDIFF(MONTH, joining_date, CURDATE()) AS total_months
FROM employee_attendance;
Difference in Hours
SELECT emp_name,
TIMESTAMPDIFF(HOUR, check_in, check_out) AS working_hours
FROM employee_attendance;
9. Converting Data Types
STR_TO_DATE()
SELECT STR_TO_DATE('25-12-2026', '%d-%m-%Y');
DATE()
SELECT DATE(NOW());
TIME()
SELECT TIME(NOW());
10. Last Day and First Day Functions
LAST_DAY()
SELECT LAST_DAY(CURDATE());
First Day of Current Month
SELECT DATE_SUB(CURDATE(),
INTERVAL DAY(CURDATE()) - 1 DAY);
11. Unix Timestamp Functions
UNIX_TIMESTAMP()
SELECT UNIX_TIMESTAMP();
FROM_UNIXTIME()
SELECT FROM_UNIXTIME(1750000000);
12. Working with Time
ADDTIME()
SELECT ADDTIME('10:00:00', '02:30:00');
SUBTIME()
SELECT SUBTIME('10:00:00', '01:15:00');
TIMEDIFF()
SELECT emp_name,
TIMEDIFF(check_out, check_in) AS total_time
FROM employee_attendance;
13. Date Comparison
Employees Joined After 2020
SELECT *
FROM employee_attendance
WHERE joining_date > '2020-01-01';
Employees Checked In Today
SELECT *
FROM employee_attendance
WHERE DATE(check_in) = CURDATE();
14. Sorting by Date
SELECT *
FROM employee_attendance
ORDER BY joining_date DESC;
15. Grouping by Date
Count Employees by Joining Year
SELECT YEAR(joining_date) AS joining_year,
COUNT(*) AS total_employees
FROM employee_attendance
GROUP BY YEAR(joining_date);
16. Important MySQL Date Data Types
Data Type	Description
DATE	Stores only date
TIME	Stores only time
DATETIME	Stores date and time
TIMESTAMP	Stores timestamp
YEAR	Stores year
17. Real-Time Useful Queries
Employee Experience
SELECT emp_name,
TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS experience
FROM employee_attendance;
Attendance Duration
SELECT emp_name,
TIMESTAMPDIFF(MINUTE, check_in, check_out) AS total_minutes
FROM employee_attendance;
Employees Joined This Month
SELECT *
FROM employee_attendance
WHERE MONTH(joining_date) = MONTH(CURDATE())
AND YEAR(joining_date) = YEAR(CURDATE());
18. Advanced Date Functions
EXTRACT()
SELECT EXTRACT(YEAR FROM CURDATE());
SELECT EXTRACT(MONTH FROM CURDATE());
MAKEDATE()
SELECT MAKEDATE(2026, 150);
MAKETIME()
SELECT MAKETIME(10, 45, 30);
19. Generate Calendar Style Output
SELECT
CURDATE() AS today,
DAYNAME(CURDATE()) AS today_name,
MONTHNAME(CURDATE()) AS month_name,
YEAR(CURDATE()) AS year_number;

20. Cleanup
DROP TABLE employee_attendance;

DROP DATABASE company_db;
Important Interview Questions
Difference between DATETIME and TIMESTAMP?
Difference between NOW() and SYSDATE()?
Difference between DATEDIFF() and TIMESTAMPDIFF()?
What is the use of DATE_FORMAT()?
How to calculate employee experience in SQL?
How to find last day of month in MySQL?
How to retrieve only date from datetime?
