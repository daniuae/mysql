# 📚 Data Engineering Training Program

Welcome to the Data Engineering Training Repository.

This repository contains learning materials, assignments, solutions, notes, quizzes, and project work designed to help trainees build strong foundations in Data Engineering, SQL, Python, Cloud, and Big Data technologies.

---

# 🎯 Learning Objectives

By the end of this program, trainees will be able to:

* Write SQL queries confidently
* Design relational databases
* Build ETL/ELT pipelines
* Work with Cloud platforms
* Understand Data Warehousing concepts
* Develop Big Data solutions using Spark
* Apply software engineering best practices

---

# 📅 Today's Session

## Topic

**Advanced SQL - Common Table Expressions (CTE)**

### Agenda

| Duration | Activity              |
| -------- | --------------------- |
| 15 Min   | Revision              |
| 45 Min   | Concept Discussion    |
| 30 Min   | Hands-on Practice     |
| 15 Min   | Quiz                  |
| 15 Min   | Assignment Discussion |

---

# 🔄 Revision

## Previously Covered Topics

* SQL Basics
* Joins
* Aggregate Functions
* Subqueries
* Window Functions

### Quick Review Questions

* What is the difference between WHERE and HAVING?
* Explain INNER JOIN vs LEFT JOIN.
* What is a Correlated Subquery?
* What are Window Functions?

---

# 📖 Today's Notes

## What is a CTE?

A Common Table Expression (CTE) is a temporary named result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.

### Syntax

```sql
WITH department_salary AS
(
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_salary;
```

---

# 🧩 Practice Problems

## Beginner

* Find the highest salary in each department.
* Find employees earning above department average.
* Find departments having more than 5 employees.

## Intermediate

* Find Top 3 customers by sales.
* Find duplicate records using CTE.
* Generate sequence numbers using Recursive CTE.

## Advanced

* Employee Hierarchy Report.
* Running Total Analysis.
* Month-over-Month Sales Comparison.

---

# ❓ Quiz

### Question 1

What does CTE stand for?

* [ ] Common Table Engine
* [x] Common Table Expression
* [ ] Common Type Expression

### Question 2

Which keyword is used to define a CTE?

* [ ] TEMP
* [ ] VIEW
* [x] WITH
* [ ] CREATE

---

# 🏆 Weekly Leaderboard

| Rank | Name      | Score |
| ---- | --------- | ----- |
| 🥇   | Trainee 1 | 95    |
| 🥈   | Trainee 2 | 90    |
| 🥉   | Trainee 3 | 88    |

---

# 📂 Repository Structure

```text
DataEngineeringTraining/
│
├── SQL/
│   ├── Basics/
│   ├── Joins/
│   ├── CTE/
│   └── WindowFunctions/
│
├── Python/
│   ├── Basics/
│   ├── Pandas/
│   └── ETL/
│
├── DataModeling/
│
├── BigData/
│   ├── Hadoop/
│   ├── Hive/
│   └── Spark/
│
├── Cloud/
│   ├── AWS/
│   ├── Azure/
│   └── GCP/
│
├── Assignments/
│
├── Solutions/
│
└── README.md
```

---

# 📊 Progress Tracker

| Module           | Status |
| ---------------- | ------ |
| SQL Basics       | ✅      |
| Joins            | ✅      |
| Subqueries       | ✅      |
| Window Functions | ✅      |
| CTE              | 🟡     |
| Data Modeling    | ⬜      |
| Python           | ⬜      |
| Spark            | ⬜      |

---

# 🎖️ Assignment

Complete the following before the next session:

1. Solve all Beginner Problems
2. Solve any 2 Intermediate Problems
3. Submit solutions in GitHub
4. Attempt the Quiz

---

# 💡 Quote of the Day

> "Learning is not attained by chance; it must be sought for with ardor and attended to with diligence."

---

# 🤝 Contribution Guidelines

1. Create a feature branch.
2. Commit your changes.
3. Raise a Pull Request.
4. Request review from mentors.

---

# 📞 Contact

For questions or support:

* Mentor: Dhandapani Yedappalli Krishnamurthi
* Email: [daniyk2020@gmail.com](mailto:daniyk2020@gmail.com)
* Teams/Slack Channel: #data-engineering-training

---

⭐ Happy Learning & Keep Practicing!
