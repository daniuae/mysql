INTO students (student_name, city, registration_date)
VALUES
('Alice','Delhi','2024-01-15'),
('Bob','Mumbai','2024-02-05'),
('Charlie','Delhi','2024-03-10'),
('Daisy','Kolkata','2024-04-12'),
('Ethan','Delhi','2024-05-01'),
('Fiona','Bangalore','2024-06-18'),
('George','Kolkata','2024-06-25'),
('Helen','Bangalore','2024-07-03'),
('Ian','Chennai','2024-07-18'),
('Jack','Delhi','2024-08-22');


Insert enrollments

INSERT INTO enrollments (student_id, course_name, fee, status)
VALUES
(1,'Python Basics',300,'Active'),
(2,'SQL Mastery',400,'Active'),
(3,'Python Basics',300,'Active'),
(4,'Power BI',350,'Inactive'),
(5,'Python Basics',300,'Active'),
(6,'SQL Mastery',400,'Inactive'),
(7,'Machine Learning',500,'Active'),
(8,'SQL Mastery',400,'Active'),
(9,'Python Basics',300,'Inactive'),
(10,'Power BI',350,'Active');


Confirm your data

SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM enrollments;

Part A - Understanding Query Execution


When you run a query, MySQL’s optimizer decides:

Which indexes to use.
Which join strategy to follow.
In what order to read tables.
Whether to use temporary tables or sorting.


To inspect this, use:

EXPLAIN SELECT * FROM enrollments WHERE course_name='Python Basics';


Output columns (key ones):



id — step number in query execution order.
type — access method (ALL, index, ref, eq_ref).
rows — how many rows MySQL expects to scan.
key — which index (if any) is being used.
Extra — extra operations (e.g., “Using where”).

Part B - Identifying a Full Table Scan


Run:

EXPLAIN SELECT * FROM enrollments WHERE status='Active';


If you see type = ALL, it means:

MySQL scanned the entire table (full table scan).
No index was used.
This can be slow when you have millions of rows.

Part C - Adding an Index


Create an index on status:

CREATE INDEX idx_status ON enrollments(status);
Re-run:

EXPLAIN SELECT * FROM enrollments WHERE status='Active';


Observe:

type now changes from ALL → ref.
key = idx_status.
Fewer rows scanned → faster execution.

Part D - Multi-Column Index for Joins


Examine a join query:

EXPLAIN
SELECT s.student_name, s.city, e.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE s.city='Delhi' AND e.course_name='Python Basics';
If you see “Using where; Using temporary”, optimization is possible.



Add an index on the join column:

CREATE INDEX idx_student_id ON enrollments(student_id);
CREATE INDEX idx_city_course ON students(city);


Re-run the EXPLAIN plan — note how the optimizer now uses indexed lookups.


Part E - Using EXPLAIN FORMAT=JSON


For more detail:

EXPLAIN FORMAT=JSON
SELECT s.student_name, e.course_name, e.status
FROM students s
JOIN enrollments e ON s.student_id=e.student_id
WHERE e.status='Active' AND e.course_name='Python Basics';


This shows cost estimates, filtering percentages, and join algorithms.



Review the "rows_examined_per_scan" and "cost_info" metrics.




Part F - Using ANALYZE TABLE


MySQL uses internal statistics to plan queries.

Refresh them when data changes heavily:

ANALYZE TABLE enrollments;


Run:

SHOW INDEX FROM enrollments;
Observe your created indexes and cardinality.




Part G -Optimizing Query Patterns


Avoid SELECT * — fetch only needed columns:

SELECT student_name, city FROM students WHERE city='Delhi';


Avoid unnecessary sorting:

EXPLAIN SELECT * FROM enrollments ORDER BY course_name;


Add index if sorting column frequently used:

CREATE INDEX idx_course ON enrollments(course_name);


Use LIMIT for large result sets:

SELECT * FROM enrollments LIMIT 5;


Avoid functions on indexed columns (they disable index use):



❌ WHERE UPPER(city) = 'DELHI'
✅ WHERE city = 'Delhi'



Part H - Clean-Up


DROP DATABASE sql_lab_optimization;

Lab Outcome


By the end of this lab, learners can:

Analyze query execution plans using EXPLAIN.
Interpret the optimizer’s choices (ALL, ref, eq_ref, const).
Optimize queries with proper indexing, filtering, and query structure.
Measure performance using SHOW PROFILE and ANALYZE TABLE.
Understand how indexes drastically improve query speed.
