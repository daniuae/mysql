/******************************************************************************************
                    COMPLETE CTE (COMMON TABLE EXPRESSION) GUIDE - MYSQL 8+
*******************************************************************************************

WHAT IS A CTE?
--------------
A CTE (Common Table Expression) is a temporary named result set that exists only during
query execution.

Syntax:
WITH cte_name AS
(
    SELECT ...
)
SELECT * FROM cte_name;

Benefits:
---------
1. Improves readability
2. Simplifies complex queries
3. Replaces repeated subqueries
4. Supports recursive processing
5. Useful with JOINs, Aggregations, Window Functions

******************************************************************************************
STEP 1 - CREATE SAMPLE TABLE
******************************************************************************************/

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT,
    joining_date DATE
);

/******************************************************************************************
STEP 2 - INSERT SAMPLE DATA
******************************************************************************************/

INSERT INTO employees VALUES
(101,'Arun Kumar','IT',85000,NULL,'2020-01-15'),
(102,'Priya Sharma','IT',75000,101,'2021-03-10'),
(103,'Rahul Verma','HR',65000,101,'2021-07-12'),
(104,'Sneha Reddy','Finance',95000,101,'2019-09-20'),
(105,'Vikram Singh','Finance',70000,104,'2022-01-25'),
(106,'Anjali Nair','IT',60000,102,'2023-04-01'),
(107,'Karthik Rao','HR',55000,103,'2023-05-15'),
(108,'Meera Iyer','Sales',50000,101,'2022-08-01'),
(109,'Rohit Gupta','Sales',52000,108,'2023-02-10'),
(110,'Neha Joshi','IT',80000,102,'2021-11-05');

/******************************************************************************************
1. SIMPLE CTE
Find employees earning above company average salary
******************************************************************************************/

WITH cte_name as(

select * from employees
)
select * from cte_name;

WITH avg_salary_cte AS
(
    SELECT AVG(salary) avg_salary
    FROM employees
)
SELECT e.*
FROM employees e
CROSS JOIN avg_salary_cte a
WHERE e.salary > a.avg_salary;

/******************************************************************************************
2. MULTIPLE CTEs
******************************************************************************************/

WITH dept_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
)
--select * from dept_avg;
,

high_salary_emp AS
(
    SELECT *
    FROM employees
    WHERE salary > 70000
)
--select * from high_salary_emp
SELECT h.emp_name,
       h.department,
       h.salary,
       d.avg_salary
FROM high_salary_emp h
JOIN dept_avg d
ON h.department = d.department;

/******************************************************************************************
3. CTE WITH JOIN
Employees earning above department average
******************************************************************************************/

WITH dept_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.emp_name,
       e.department,
       e.salary,
       d.avg_salary
FROM employees e
JOIN dept_avg d
ON e.department = d.department
WHERE e.salary > d.avg_salary;

/******************************************************************************************
4. CTE WITH AGGREGATE FUNCTIONS
Department Statistics
******************************************************************************************/

WITH dept_stats AS
(
    SELECT department,
           COUNT(*) total_employees,
           AVG(salary) avg_salary,
           MAX(salary) highest_salary,
           MIN(salary) lowest_salary,
           SUM(salary) total_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM dept_stats;

/******************************************************************************************
5. CTE WITH WINDOW FUNCTIONS
Department Salary Ranking
******************************************************************************************/

WITH employee_rank AS
(
    SELECT emp_name,
           department,
           salary,
           ROW_NUMBER() OVER
           (
               PARTITION BY department
               ORDER BY salary DESC
           ) row_num,
           RANK() OVER
           (
               PARTITION BY department
               ORDER BY salary DESC
           ) ranking,
           DENSE_RANK() OVER
           (
               PARTITION BY department
               ORDER BY salary DESC
           ) dense_ranking
    FROM employees
)
SELECT *
FROM employee_rank;

/******************************************************************************************
6. CTE REFERENCING ANOTHER CTE
******************************************************************************************/

WITH dept_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
),
above_avg_emp AS
(
    SELECT e.*
    FROM employees e
    JOIN dept_avg d
    ON e.department = d.department
    WHERE e.salary > d.avg_salary
)
SELECT *
FROM above_avg_emp;

/******************************************************************************************
7. CTE WITH CASE STATEMENT
Salary Band Classification
******************************************************************************************/

WITH salary_band AS
(
    SELECT emp_name,
           salary,
           CASE
               WHEN salary >= 90000 THEN 'HIGH'
               WHEN salary >= 70000 THEN 'MEDIUM'
               ELSE 'LOW'
           END AS salary_category
    FROM employees
)
SELECT *
FROM salary_band;

/******************************************************************************************
8. CTE WITH SUBQUERY
Highest Paid Employee in Each Department
******************************************************************************************/

WITH dept_max_salary AS
(
    SELECT department,
           MAX(salary) max_salary
    FROM employees
    GROUP BY department
)
SELECT e.*
FROM employees e
JOIN dept_max_salary d
ON e.department = d.department
AND e.salary = d.max_salary;

/******************************************************************************************
9. TOP N EMPLOYEES PER DEPARTMENT
Most Common Interview Question
******************************************************************************************/

WITH ranked_emp AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY department
               ORDER BY salary DESC
           ) rn
    FROM employees
)
SELECT *
FROM ranked_emp
WHERE rn <= 2;

/******************************************************************************************
10. RUNNING TOTAL
******************************************************************************************/

WITH running_total_cte AS
(
    SELECT emp_name,
           salary,
           SUM(salary) OVER
           (
               ORDER BY salary
           ) running_total
    FROM employees
)
SELECT *
FROM running_total_cte;

/******************************************************************************************
11. FIND DUPLICATES
******************************************************************************************/

WITH duplicate_names AS
(
    SELECT emp_name,
           COUNT(*) total_count
    FROM employees
    GROUP BY emp_name
    HAVING COUNT(*) > 1
)
SELECT *
FROM duplicate_names;

/******************************************************************************************
12. RECURSIVE CTE - NUMBER GENERATOR
Generate numbers from 1 to 10
******************************************************************************************/

WITH RECURSIVE numbers AS
(
    SELECT 1 AS num

    UNION ALL

    SELECT num + 1
    FROM numbers
    WHERE num < 10
)
SELECT *
FROM numbers;

/******************************************************************************************
13. RECURSIVE CTE - DATE GENERATOR
Generate calendar dates
******************************************************************************************/

WITH RECURSIVE calendar_dates AS
(
    SELECT DATE '2025-01-01' AS dt

    UNION ALL

    SELECT dt + 1
    FROM calendar_dates
    WHERE dt < DATE '2025-01-10'
)
SELECT *
FROM calendar_dates;

-- WITH RECURSIVE calendar_dates AS
-- (
--     SELECT DATE('2025-01-01') dt

--     UNION ALL

--     SELECT dt + INTERVAL 1 DAY
--     FROM calendar_dates
--     WHERE dt < '2025-01-10'
-- )
-- SELECT *
-- FROM calendar_dates;

/******************************************************************************************
14. RECURSIVE CTE - EMPLOYEE HIERARCHY
Organizational Structure
******************************************************************************************/

WITH RECURSIVE employee_hierarchy AS
(
    /* Anchor Query */

    SELECT emp_id,
           emp_name,
           manager_id,
           1 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    /* Recursive Query */

    SELECT e.emp_id,
           e.emp_name,
           e.manager_id,
           h.hierarchy_level + 1
    FROM employees e
    JOIN employee_hierarchy h
    ON e.manager_id = h.emp_id
)
SELECT *
FROM employee_hierarchy
ORDER BY hierarchy_level;

/******************************************************************************************
15. RECURSIVE CTE - REPORTING PATH
******************************************************************************************/

WITH RECURSIVE reporting_path AS
(
    -- Anchor Query
    SELECT
        emp_id,
        emp_name,
        manager_id,
        emp_name::TEXT AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive Query
    SELECT
        e.emp_id,
        e.emp_name,
        e.manager_id,
        r.path || ' -> ' || e.emp_name AS path
    FROM employees e
    JOIN reporting_path r
        ON e.manager_id = r.emp_id
)
SELECT *
FROM reporting_path;

-- WITH RECURSIVE reporting_path AS
-- (
--     SELECT emp_id,
--            emp_name,
--            manager_id,
--            CAST(emp_name AS CHAR(500)) AS path
--     FROM employees
--     WHERE manager_id IS NULL

--     UNION ALL

--     SELECT e.emp_id,
--            e.emp_name,
--            e.manager_id,
--            CONCAT(r.path,' -> ',e.emp_name)
--     FROM employees e
--     JOIN reporting_path r
--     ON e.manager_id = r.emp_id
-- )
-- SELECT *
-- FROM reporting_path;

/******************************************************************************************
16. FIND MISSING IDS (GAP ANALYSIS)
******************************************************************************************/

WITH RECURSIVE all_ids AS
(
    SELECT 101 AS emp_id

    UNION ALL

    SELECT emp_id + 1
    FROM all_ids
    WHERE emp_id < 110
)
SELECT a.emp_id
FROM all_ids a
LEFT JOIN employees e
ON a.emp_id = e.emp_id
WHERE e.emp_id IS NULL;

/******************************************************************************************
17. CTE WITH LAG()
Previous Employee Salary
******************************************************************************************/

WITH salary_history AS
(
    SELECT emp_name,
           salary,
           LAG(salary)
           OVER(ORDER BY salary) previous_salary
    FROM employees
)
SELECT *
FROM salary_history;

/******************************************************************************************
18. CTE WITH LEAD()
Next Employee Salary
******************************************************************************************/

WITH future_salary AS
(
    SELECT emp_name,
           salary,
           LEAD(salary)
           OVER(ORDER BY salary) next_salary
    FROM employees
)
SELECT *
FROM future_salary;

/******************************************************************************************
19. CTE WITH NTILE()
Salary Quartiles
******************************************************************************************/

WITH salary_quartiles AS
(
    SELECT emp_name,
           salary,
           NTILE(4)
           OVER(ORDER BY salary DESC) quartile
    FROM employees
)
SELECT *
FROM salary_quartiles;

/******************************************************************************************
20. CTE WITH UPDATE
Increase salary by 10% for employees below department average
******************************************************************************************/

WITH dept_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
)
UPDATE employees e
JOIN dept_avg d
ON e.department = d.department
SET e.salary = e.salary * 1.10
WHERE e.salary < d.avg_salary;

/******************************************************************************************
21. CTE WITH DELETE
Delete employees earning below company average
******************************************************************************************/

WITH avg_salary_cte AS
(
    SELECT AVG(salary) avg_salary
    FROM employees
)
DELETE FROM employees
WHERE salary <
(
    SELECT avg_salary
    FROM avg_salary_cte
);

/******************************************************************************************
22. CTE WITH INSERT
Create backup table first
******************************************************************************************/

CREATE TABLE employee_backup AS
SELECT * FROM employees WHERE 1=0;

WITH high_paid AS
(
    SELECT *
    FROM employees
    WHERE salary > 80000
)
INSERT INTO employee_backup
SELECT *
FROM high_paid;

/******************************************************************************************
23. PERCENTAGE CONTRIBUTION OF SALARY
******************************************************************************************/

WITH total_salary_cte AS
(
    SELECT SUM(salary) total_salary
    FROM employees
)
SELECT e.emp_name,
       e.salary,
       ROUND((e.salary/t.total_salary)*100,2) salary_percentage
FROM employees e
CROSS JOIN total_salary_cte t;

/******************************************************************************************
24. DEPARTMENT WITH HIGHEST AVERAGE SALARY
******************************************************************************************/

WITH dept_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
),
max_avg AS
(
    SELECT MAX(avg_salary) highest_avg_salary
    FROM dept_avg
)
SELECT d.*
FROM dept_avg d
JOIN max_avg m
ON d.avg_salary = m.highest_avg_salary;

/******************************************************************************************
25. INTERVIEW QUESTION
Return employees from department having highest average salary
******************************************************************************************/

WITH dept_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
),
highest_avg_dept AS
(
    SELECT department
    FROM dept_avg
    WHERE avg_salary =
    (
        SELECT MAX(avg_salary)
        FROM dept_avg
    )
)
SELECT e.*
FROM employees e
JOIN highest_avg_dept h
ON e.department = h.department;

/******************************************************************************************
CTE TYPES SUMMARY
******************************************************************************************

1. Simple CTE
2. Multiple CTEs
3. Dependent CTEs
4. Recursive CTEs
5. CTE + JOIN
6. CTE + Aggregation
7. CTE + Window Functions
8. CTE + CASE
9. CTE + Subqueries
10. CTE + INSERT
11. CTE + UPDATE
12. CTE + DELETE
13. Hierarchy Traversal
14. Number Generation
15. Date Generation
16. Gap Analysis
17. Top-N Problems
18. Running Totals
19. Ranking Problems
20. Reporting Paths

******************************************************************************************/



/*******************************************************************************************
 CASE EXPRESSIONS & CONDITIONAL LOGIC CHEAT SHEET
 Compatible: PostgreSQL 13+ and MySQL 8+
********************************************************************************************/

/*******************************************************************************************
1. SAMPLE TABLE
********************************************************************************************/

CREATE TABLE case_schema.employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    experience_years INT,
    gender CHAR(1),
    status VARCHAR(20),
    joining_date DATE
);

INSERT INTO case_schema.employees VALUES
(101,'Arun Kumar','IT',85000,8,'M','Active','2020-01-15'),
(102,'Priya Sharma','HR',45000,3,'F','Active','2023-03-10'),
(103,'Rahul Verma','Finance',95000,10,'M','Inactive','2018-05-01'),
(104,'Sneha Reddy','IT',65000,5,'F','Active','2021-06-15'),
(105,'Vikram Singh','Sales',35000,2,'M','Inactive','2024-01-10'),
(106,'Neha Gupta','HR',75000,7,'F','Active','2019-08-20'),
(107,'Rohit Mehta','Sales',55000,4,'M','Active','2022-09-01');


/*******************************************************************************************
2. SIMPLE CASE
   Compares one value against multiple possible values
********************************************************************************************/

SELECT
    emp_name,
    department,
    CASE department
         WHEN 'IT' THEN 'Technology'
         WHEN 'HR' THEN 'Human Resources'
         WHEN 'Finance' THEN 'Accounts'
         ELSE 'Other Department'
    END AS department_name
FROM employees;


/*******************************************************************************************
3. SEARCHED CASE
   Evaluates multiple conditions
********************************************************************************************/

SELECT
    emp_name,
    salary,
    CASE
         WHEN salary >= 90000 THEN 'High Salary'
         WHEN salary >= 60000 THEN 'Medium Salary'
         ELSE 'Low Salary'
    END AS salary_band
FROM employees;


/*******************************************************************************************
4. CASE WITH MULTIPLE CONDITIONS
********************************************************************************************/

-- SELECT
--     emp_name,
--     salary,
--     experience_years,
--     CASE
--          WHEN salary >= 90000
--               AND experience_years >= 8
--               THEN 'Grade A'

--          WHEN salary >= 60000
--               AND experience_years >= 5
--               THEN 'Grade B'

--          ELSE 'Grade C'
--     END AS employee_grade
-- FROM employees;

SELECT
    emp_name,
    salary,
    experience_years,
    CASE
        WHEN salary >= 90000
             AND experience_years >= 8
        THEN 'Grade A'

        WHEN salary >= 60000
             AND experience_years >= 5
        THEN 'Grade B'

        ELSE 'Grade C'
    END AS employee_grade
FROM case_schema.employees;
/*******************************************************************************************
5. NESTED CASE
********************************************************************************************/

SELECT
    emp_name,
    CASE
         WHEN department='IT'
         THEN
             CASE
                  WHEN salary > 80000 THEN 'Senior IT'
                  ELSE 'Junior IT'
             END

         WHEN department='HR'
         THEN
             CASE
                  WHEN salary > 70000 THEN 'Senior HR'
                  ELSE 'Junior HR'
             END

         ELSE 'Other'
    END AS designation
FROM employees;


/*******************************************************************************************
6. CASE IN SELECT
********************************************************************************************/

SELECT
    emp_id,
    emp_name,
    salary,
    CASE
         WHEN salary >= 70000 THEN 'Eligible For Bonus'
         ELSE 'Not Eligible'
    END AS bonus_status
FROM employees;


/*******************************************************************************************
7. CASE IN WHERE CLAUSE
********************************************************************************************/

SELECT *
FROM employees
WHERE
CASE
    WHEN salary >= 70000 THEN 1
    ELSE 0
END = 1;


/*******************************************************************************************
8. CASE IN ORDER BY
   Active employees first
********************************************************************************************/

SELECT *
FROM case_schema.employees  
ORDER BY
CASE
    WHEN status='Active' THEN 1
    ELSE 2
END,
salary DESC;


/*******************************************************************************************
9. DYNAMIC CUSTOM SORTING
********************************************************************************************/

SELECT *
FROM case_schema.employees 
ORDER BY
CASE department
     WHEN 'IT' THEN 1
     WHEN 'Finance' THEN 2
     WHEN 'HR' THEN 3
     WHEN 'Sales' THEN 4
     ELSE 5
END;


/*******************************************************************************************
10. CASE IN GROUP BY
********************************************************************************************/

SELECT
    CASE
         WHEN salary >= 70000 THEN 'High'
         ELSE 'Low'
    END AS salary_group,
    COUNT(*) AS employee_count
FROM employees
GROUP BY
CASE
     WHEN salary >= 70000 THEN 'High'
     ELSE 'Low'
END;


/*******************************************************************************************
11. CASE IN HAVING
********************************************************************************************/

SELECT
    department,
    AVG(salary) avg_salary
FROM employees
GROUP BY department
HAVING AVG(
           CASE
               WHEN salary > 50000
               THEN salary
           END
          ) > 60000;


/*******************************************************************************************
12. CONDITIONAL COUNT
********************************************************************************************/

SELECT
    COUNT(
          CASE
              WHEN salary > 60000
              THEN 1
          END
         ) AS high_salary_count
FROM case_schema.employees;


/*******************************************************************************************
13. CONDITIONAL SUM
********************************************************************************************/

SELECT
    SUM(
        CASE
             WHEN status='Active'
             THEN salary
             ELSE 0
        END
       ) AS active_salary,

    SUM(
        CASE
             WHEN status='Inactive'
             THEN salary
             ELSE 0
        END
       ) AS inactive_salary
FROM case_schema.employees ;


/*******************************************************************************************
14. CONDITIONAL AVG
********************************************************************************************/

SELECT
    AVG(CASE WHEN gender='M' THEN salary END) AS male_avg_salary,
    AVG(CASE WHEN gender='F' THEN salary END) AS female_avg_salary
FROM case_schema.employees ;


/*******************************************************************************************
15. CONDITIONAL MIN/MAX
********************************************************************************************/

SELECT
    MAX(CASE WHEN department='IT' THEN salary END) AS max_it_salary,
    MIN(CASE WHEN department='IT' THEN salary END) AS min_it_salary
FROM case_schema.employees ;


/*******************************************************************************************
16. CONDITIONAL AGGREGATION (MOST COMMON INTERVIEW QUESTION)
********************************************************************************************/

SELECT
    SUM(CASE WHEN status='Active' THEN 1 ELSE 0 END)   AS active_employees,
    SUM(CASE WHEN status='Inactive' THEN 1 ELSE 0 END) AS inactive_employees,
    SUM(CASE WHEN gender='M' THEN 1 ELSE 0 END)        AS male_employees,
    SUM(CASE WHEN gender='F' THEN 1 ELSE 0 END)        AS female_employees
FROM case_schema.employees ;


/*******************************************************************************************
17. PIVOT REPORT USING CASE
********************************************************************************************/

SELECT
    SUM(CASE WHEN department='IT' THEN 1 ELSE 0 END)      AS IT_Count,
    SUM(CASE WHEN department='HR' THEN 1 ELSE 0 END)      AS HR_Count,
    SUM(CASE WHEN department='Finance' THEN 1 ELSE 0 END) AS Finance_Count,
    SUM(CASE WHEN department='Sales' THEN 1 ELSE 0 END)   AS Sales_Count
FROM case_schema.employees ;


/*******************************************************************************************
18. CASE WITH NULL HANDLING
********************************************************************************************/

SELECT
    emp_name,
    CASE
         WHEN salary IS NULL
         THEN 'Salary Missing'
         ELSE 'Salary Available'
    END AS remarks
FROM case_schema.employees ;


/*******************************************************************************************
19. CASE WITH COALESCE
********************************************************************************************/

SELECT
    emp_name,
    COALESCE(
        CASE
            WHEN salary > 70000 THEN 'High'
        END,
        'Normal'
    ) AS salary_category
FROM case_schema.employees;


/*******************************************************************************************
20. CASE IN UPDATE
********************************************************************************************/

UPDATE case_schema.employees 
SET salary =
CASE
     WHEN department='IT'
          THEN salary * 1.10

     WHEN department='HR'
          THEN salary * 1.05

     ELSE salary
END;


/*******************************************************************************************
21. CASE IN DELETE (RARE)
********************************************************************************************/

DELETE FROM case_schema.employees 
WHERE
CASE
     WHEN status='Inactive' THEN 1
     ELSE 0
END = 1;


/*******************************************************************************************
22. CASE IN INSERT
********************************************************************************************/

CREATE TABLE employee_grade (
    emp_id INT,
    grade VARCHAR(20)
);

INSERT INTO employee_grade
SELECT
    emp_id,
    CASE
         WHEN salary >= 90000 THEN 'A'
         WHEN salary >= 70000 THEN 'B'
         ELSE 'C'
    END
FROM employees;


/*******************************************************************************************
23. CASE WITH WINDOW FUNCTIONS
********************************************************************************************/

SELECT
    emp_name,
    salary,
    RANK() OVER(ORDER BY salary DESC) rank_no,

    CASE
         WHEN RANK() OVER(ORDER BY salary DESC) <= 3
              THEN 'Top Performer'
         ELSE 'Regular Employee'
    END AS category
FROM case_schema.employees ;


/*******************************************************************************************
24. CASE WITH ROW_NUMBER()
********************************************************************************************/

SELECT
    emp_name,
    department,
    salary,
    ROW_NUMBER() OVER
    (
        PARTITION BY department
        ORDER BY salary DESC
    ) rn,

    CASE
         WHEN ROW_NUMBER() OVER
             (
               PARTITION BY department
               ORDER BY salary DESC
             ) = 1
         THEN 'Highest Paid'
         ELSE 'Others'
    END AS salary_status
FROM case_schema.employees ;


/*******************************************************************************************
25. CASE WITH JOINS
********************************************************************************************/

CREATE TABLE bonuses (
    department VARCHAR(50),
    bonus_percent INT
);

INSERT INTO bonuses VALUES
('IT',10),
('HR',5),
('Finance',15),
('Sales',8);

SELECT
    e.emp_name,
    e.salary,
    b.bonus_percent,

    CASE
         WHEN b.bonus_percent >= 10
              THEN 'High Bonus'
         ELSE 'Regular Bonus'
    END AS bonus_category

FROM case_schema.employees  e
INNER JOIN bonuses b
ON e.department = b.department;


/*******************************************************************************************
26. CASE WITH SUBQUERY
********************************************************************************************/

SELECT
    emp_name,
    salary,

    CASE
         WHEN salary >
              (
                SELECT AVG(salary)
                FROM employees
              )
         THEN 'Above Average'

         ELSE 'Below Average'
    END AS comparison
FROM case_schema.employees ;


/*******************************************************************************************
27. CASE WITH EXISTS
********************************************************************************************/

SELECT
    emp_name,

    CASE
         WHEN EXISTS
              (
                SELECT 1
                FROM bonuses b
                WHERE b.department=e.department
              )
         THEN 'Bonus Available'

         ELSE 'No Bonus'
    END AS remarks

FROM case_schema.employees  e;


/*******************************************************************************************
28. CASE WITH DATE LOGIC - POSTGRESQL
********************************************************************************************/

SELECT
    emp_name,
    CASE
         WHEN CURRENT_DATE - joining_date > 1825
              THEN 'Experienced'
         ELSE 'New Employee'
    END AS employee_type
FROM case_schema.employees ;


/*******************************************************************************************
29. CASE WITH DATE LOGIC - MYSQL
********************************************************************************************/

SELECT
    emp_name,
    CASE
         WHEN DATEDIFF(CURDATE(),joining_date) > 1825
              THEN 'Experienced'
         ELSE 'New Employee'
    END AS employee_type
FROM case_schema.employees ;


/*******************************************************************************************
30. MYSQL IF() ALTERNATIVE
   MYSQL ONLY
********************************************************************************************/

SELECT
    emp_name,
    IF(salary > 70000,'High Salary','Low Salary') AS salary_status
FROM case_schema.employees ;


/*******************************************************************************************
31. POSTGRESQL FILTER CLAUSE ALTERNATIVE
   POSTGRESQL ONLY
********************************************************************************************/

SELECT
    COUNT(*) FILTER(WHERE status='Active')   AS active_count,
    COUNT(*) FILTER(WHERE status='Inactive') AS inactive_count
FROM case_schema.employees ;


/*******************************************************************************************
32. CASE + BETWEEN
********************************************************************************************/

SELECT
    emp_name,
    salary,

    CASE
         WHEN salary BETWEEN 30000 AND 50000
              THEN 'Level 1'

         WHEN salary BETWEEN 50001 AND 80000
              THEN 'Level 2'

         ELSE 'Level 3'
    END AS salary_level

FROM case_schema.employees ;


/*******************************************************************************************
33. CASE + IN
********************************************************************************************/

SELECT
    emp_name,
    department,

    CASE
         WHEN department IN ('IT','Finance')
              THEN 'Technical'

         ELSE 'Non Technical'
    END AS category
FROM case_schema.employees ;


/*******************************************************************************************
34. CASE + LIKE
********************************************************************************************/

SELECT
    emp_name,

    CASE
         WHEN emp_name LIKE 'A%'
              THEN 'Starts With A'

         ELSE 'Other Names'
    END AS remarks
FROM case_schema.employees ;


/*******************************************************************************************
35. CASE + MODULO OPERATOR
********************************************************************************************/

SELECT
    emp_id,

    CASE
         WHEN MOD(emp_id,2)=0
              THEN 'Even'

         ELSE 'Odd'
    END AS id_type
FROM case_schema.employees ;


/*******************************************************************************************
INTERVIEW SUMMARY

CASE CAN BE USED IN:

✓ SELECT
✓ WHERE
✓ ORDER BY
✓ GROUP BY
✓ HAVING
✓ INSERT
✓ UPDATE
✓ DELETE
✓ JOIN
✓ SUBQUERY
✓ WINDOW FUNCTIONS
✓ AGGREGATE FUNCTIONS
✓ PIVOT REPORTS
✓ DATE CALCULATIONS

MOST COMMON REAL-TIME USES:

1. Salary Banding
2. Customer Segmentation
3. Risk Classification
4. ETL Transformations
5. Data Cleansing
6. Bonus Calculations
7. KPI Dashboards
8. Pivot Reports
9. Dynamic Sorting
10. Conditional Aggregation

********************************************************************************************/

