SQL SELECT COMBINATIONS PRACTICE SHEET
(Interview + Real Project Scenarios)

Assume the following tables:

employees
---------
employee_id
employee_name
department_id
manager_id
salary
hire_date

departments
-----------
department_id
department_name

orders
------
order_id
customer_id
order_date
order_amount

customers
---------
customer_id
customer_name
city
PART 1 : PROBLEMS ONLY
1. SELECT + WHERE

Retrieve employees whose salary is greater than 75000.

2. SELECT + ORDER BY

Retrieve all employees sorted by salary descending.

3. SELECT + DISTINCT

Retrieve all unique department IDs.

4. SELECT + AGGREGATE

Find total salary paid to employees.

5. SELECT + GROUP BY

Find employee count per department.

6. SELECT + GROUP BY + HAVING

Find departments having more than 10 employees.

7. SELECT + INNER JOIN

Display employee name and department name.

8. SELECT + LEFT JOIN

Show all employees even if they don't belong to any department.

9. SELECT + SELF JOIN

Display employee name and manager name.

10. SELECT + CROSS JOIN

Generate all possible combinations of products and regions.

11. SELECT + JOIN + WHERE

Retrieve IT department employees earning more than 80000.

12. SELECT + JOIN + GROUP BY

Display department-wise employee count.

13. SELECT + JOIN + GROUP BY + HAVING

Find departments whose average salary exceeds 90000.

14. SELECT + JOIN + ORDER BY

Show employees with department names sorted by salary.

15. SELECT + SUBQUERY

Find employees earning above company average salary.

16. SELECT + Correlated Subquery

Find employees earning above their department average.

17. SELECT + EXISTS

Find departments having at least one employee.

18. SELECT + NOT EXISTS

Find departments without employees.

19. SELECT + IN Subquery

Find employees working in Bangalore departments.

20. SELECT + Derived Table

Find departments with average salary > 80000.

21. SELECT + CTE

Calculate average salary by department.

22. SELECT + CTE + JOIN

Display department name and average salary.

23. SELECT + Recursive CTE

Display organization hierarchy.

24. SELECT + Window Function

Assign row numbers based on salary.

25. SELECT + PARTITION BY

Display department-wise ranking.

26. SELECT + ROW_NUMBER + JOIN

Find highest-paid employee per department.

27. SELECT + RANK

Find top 3 highest-paid employees company-wide.

28. SELECT + DENSE_RANK

Find top salary earners including ties.

29. SELECT + LAG

Show previous employee salary.

30. SELECT + LEAD

Show next employee salary.

31. SELECT + Running Total

Calculate cumulative salary.

32. SELECT + CTE + Window Function

Find top 2 earners in each department.

33. SELECT + JOIN + CTE + Window Function

Find highest-paid employee in each department with department name.

34. SELECT + JOIN + CTE + Aggregate

Find departments whose total salary exceeds company average department salary expenditure.

35. SELECT + JOIN + Subquery + Aggregate

Find department having highest average salary.

36. SELECT + JOIN + EXISTS

Find departments having employees hired after 2024.

37. SELECT + JOIN + NOT EXISTS

Find departments with no employees hired in 2025.

38. SELECT + JOIN + CASE

Classify employees into Salary Grades.

39. SELECT + JOIN + Window Aggregate

Show employee salary and department average salary.

40. SELECT + JOIN + CTE + Window Aggregate

Show employee salary, department average salary and department rank.

41. SELECT + UNION

Combine current employees and retired employees.

42. SELECT + UNION ALL

Combine sales from two years.

43. SELECT + INTERSECT

Find common customers from two systems.

44. SELECT + EXCEPT

Find customers who ordered this year but not last year.

45. SELECT + CTE + Recursive + Join

Display employee hierarchy with department names.

46. SELECT + Multiple CTEs

Find department average salary and company average salary together.

47. SELECT + Nested CTEs

Find departments whose average salary exceeds company average.

48. SELECT + CTE + Join + Group By

Find department-wise employee count and average salary.

49. SELECT + Join + Window + Aggregate

Show salary percentage contribution within department.

50. SELECT + Join + CTE + Window + Aggregate

Show Top 3 employees per department and department total salary.
