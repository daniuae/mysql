# Python Complete Study Guide (Basic to Advanced)

## Table of Contents

1. Introduction to Python
2. Variables & Data Types
3. Operators
4. Input & Output
5. Conditional Statements
6. Loops
7. Strings
8. Lists
9. Tuples
10. Sets
11. Dictionaries
12. Functions
13. Exception Handling
14. File Handling
15. Object-Oriented Programming
16. Advanced OOP Concepts
17. Modules & Packages
18. Regular Expressions
19. Generators
20. Decorators
21. Multithreading
22. Multiprocessing
23. REST APIs
24. Database Programming
25. Pandas
26. NumPy
27. PySpark
28. Logging
29. Unit Testing
30. Advanced Python
31. ETL & ELT Concepts
32. ETL Project Ideas
33. ELT Project Ideas
34. Dataset Resources
35. Learning Resources
36. Data Engineering Roadmap

---

# 1. Introduction to Python

## What is Python?

Python is a high-level, interpreted, object-oriented programming language widely used in:

- Web Development
- Automation
- Data Engineering
- Data Science
- Machine Learning
- Cloud Computing
- DevOps

## Advantages

- Easy to Learn
- Cross Platform
- Open Source
- Huge Community
- Rich Libraries

---

## Python Execution Flow

```text
Python Program
      |
      v
Python Interpreter
      |
      v
Byte Code
      |
      v
Python Virtual Machine
      |
      v
Output
```

---

# 2. Variables & Data Types

## Variables

```python
name = "Dani"
age = 35
salary = 75000.50
```

## Data Types

| Data Type | Example |
|------------|----------|
| int | 100 |
| float | 99.99 |
| str | "Python" |
| bool | True |
| list | [1,2,3] |
| tuple | (1,2,3) |
| set | {1,2,3} |
| dict | {"id":1} |

### Type Checking

```python
name = "Python"

print(type(name))
```

Output

```python
<class 'str'>
```

---

# 3. Operators

## Arithmetic Operators

```python
a = 10
b = 5

print(a+b)
print(a-b)
print(a*b)
print(a/b)
print(a%b)
```

## Comparison Operators

```python
print(a > b)
print(a < b)
print(a == b)
```

## Logical Operators

```python
x = True
y = False

print(x and y)
print(x or y)
print(not x)
```

---

# 4. Input & Output

```python
name = input("Enter Name: ")
print("Welcome", name)
```

---

# 5. Conditional Statements

## If

```python
age = 18

if age >= 18:
    print("Eligible")
```

## If Else

```python
age = 16

if age >= 18:
    print("Eligible")
else:
    print("Not Eligible")
```

## If Elif Else

```python
marks = 75

if marks >= 90:
    print("Grade A")
elif marks >= 75:
    print("Grade B")
else:
    print("Grade C")
```

---

# 6. Loops

## For Loop

```python
for i in range(1,6):
    print(i)
```

## While Loop

```python
count = 1

while count <= 5:
    print(count)
    count += 1
```

---

# 7. Strings

```python
name = "Data Engineer"
```

## Common Functions

```python
print(name.upper())
print(name.lower())
print(name.replace("Engineer","Architect"))
```

## String Slicing

```python
text = "Python"

print(text[0:3])
```

Output

```text
Pyt
```

---

# 8. Lists

```python
cities = ["Chennai","Bangalore","Hyderabad"]
```

## Operations

```python
cities.append("Mumbai")
cities.remove("Chennai")
```

## List Comprehension

```python
numbers = [1,2,3,4,5]

squares = [x*x for x in numbers]

print(squares)
```

---

# 9. Tuples

```python
employee = (101,"Dani","Data Engineer")
```

- Immutable Collection
- Faster than List

---

# 10. Sets

```python
skills = {"Python","SQL","AWS"}

skills.add("Spark")
```

### Characteristics

- No Duplicates
- Unordered

---

# 11. Dictionaries

```python
employee = {
    "id":101,
    "name":"Dani",
    "salary":100000
}
```

Access Value

```python
print(employee["name"])
```

---

# 12. Functions

## Function

```python
def greet():
    print("Hello")

greet()
```

## Function with Parameters

```python
def add(a,b):
    return a+b

print(add(10,20))
```

## Lambda Function

```python
square = lambda x:x*x

print(square(5))
```

---

# 13. Exception Handling

```python
try:
    result = 10/0

except ZeroDivisionError:
    print("Cannot divide by zero")
```

---

# 14. File Handling

## Read File

```python
with open("employees.txt","r") as file:
    print(file.read())
```

## Write File

```python
with open("employees.txt","w") as file:
    file.write("Hello")
```

---

# 15. Object-Oriented Programming

## Class Example

```python
class Employee:

    def __init__(self,id,name):
        self.id=id
        self.name=name

    def display(self):
        print(self.id,self.name)

emp = Employee(101,"Dani")

emp.display()
```

---

# 16. Advanced OOP

## Encapsulation

```python
class Bank:

    def __init__(self):
        self.__balance = 1000
```

## Polymorphism

```python
class Animal:
    def sound(self):
        pass

class Dog(Animal):
    def sound(self):
        print("Bark")
```

---

# 17. Modules & Packages

```python
import math

print(math.sqrt(25))
```

---

# 18. Regular Expressions

```python
import re

text = "abc123"

result = re.findall(r'\d+', text)

print(result)
```

Output

```python
['123']
```

---

# 19. Generators

```python
def numbers():
    for i in range(5):
        yield i

for n in numbers():
    print(n)
```

---

# 20. Decorators

```python
def logger(func):

    def wrapper():
        print("Start")
        func()
        print("End")

    return wrapper

@logger
def hello():
    print("Hello")

hello()
```

---

# 21. Multithreading

```python
import threading

def task():
    print("Running")

thread = threading.Thread(target=task)

thread.start()
```

---

# 22. Multiprocessing

```python
from multiprocessing import Process

def worker():
    print("Process Running")

p = Process(target=worker)

p.start()
```

---

# 23. REST APIs

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)

print(response.json())
```

---

# 24. Database Programming

## PostgreSQL Connection

```python
import psycopg2

conn = psycopg2.connect(
    database="training",
    user="postgres",
    password="admin"
)
```

---

# 25. Pandas

```python
import pandas as pd

df = pd.read_csv("employees.csv")

print(df.head())
```

### Filtering

```python
df[df["salary"] > 50000]
```

---

# 26. NumPy

```python
import numpy as np

arr = np.array([1,2,3])

print(arr.mean())
```

---

# 27. PySpark

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("ETL") \
    .getOrCreate()
```

---

# 28. Logging

```python
import logging

logging.basicConfig(level=logging.INFO)

logging.info("ETL Started")
```

---

# 29. Unit Testing

```python
import unittest

class TestMath(unittest.TestCase):

    def test_add(self):
        self.assertEqual(10+20,30)

unittest.main()
```

---

# 30. Advanced Python

## Context Managers

```python
with open("file.txt") as f:
    print(f.read())
```

## Iterators

```python
numbers = iter([1,2,3])

print(next(numbers))
```

## Async Programming

```python
import asyncio

async def hello():
    print("Hello")

asyncio.run(hello())
```

---

# 31. ETL Concepts

## ETL Architecture

```text
Source Systems
      |
      v
Extract
      |
      v
Transform
      |
      v
Load
      |
      v
Data Warehouse
```

---

# 32. ELT Concepts

## ELT Architecture

```text
Source Systems
      |
      v
Load
      |
      v
Data Lake
      |
      v
Transform
      |
      v
Analytics
```

---

# 33. ETL Project Ideas

## Retail Sales ETL

Source:
- CSV
- SQL Server

Target:
- PostgreSQL

Tools:
- Python
- Pandas
- SQLAlchemy

---

## Healthcare ETL

Source:
- Patient Files
- APIs
- Databases

Target:
- Data Warehouse

---

## Banking ETL

Source:
- ATM
- Credit Cards
- Loans

Target:
- Enterprise Data Warehouse

---

# 34. ELT Project Ideas

## AWS ELT

```text
CSV
 |
S3
 |
Glue
 |
Redshift
 |
QuickSight
```

## Azure ELT

```text
CSV
 |
ADLS
 |
Databricks
 |
Delta Lake
 |
Power BI
```

## GCP ELT

```text
CSV
 |
GCS
 |
Dataflow
 |
BigQuery
 |
Looker
```

---

# 35. Dataset Resources

## Kaggle

https://www.kaggle.com/datasets

Popular Datasets:

- Retail
- HR Analytics
- Healthcare
- Banking
- E-Commerce

---

## Additional Sources

### NYC Taxi Dataset

https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

### IMDb Dataset

https://datasets.imdbws.com

### UCI Repository

https://archive.ics.uci.edu

### AdventureWorks

https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure

---

# 36. Learning Resources

## Medium

https://medium.com/tag/data-engineering

https://medium.com/tag/apache-spark

https://towardsdatascience.com/tagged/etl

---

# Data Engineering Learning Roadmap

## Month 1

- Python Fundamentals
- OOP
- SQL
- Git

## Month 2

- Pandas
- NumPy
- APIs
- PostgreSQL

## Month 3

- ETL Development
- Data Modeling
- Data Warehouse

## Month 4

- PySpark
- Airflow
- AWS/GCP/Azure

## Month 5

- Kafka
- Streaming
- Delta Lake

## Month 6

- End-to-End ETL Project
- CI/CD
- Docker
- Kubernetes

---

# Recommended Portfolio Projects

1. Retail Sales ETL Pipeline
2. Healthcare Data Warehouse
3. Banking Analytics Platform
4. Cloud ELT Pipeline
5. Real-Time Streaming ETL using Kafka & Spark
6. Data Lakehouse using Delta Lake
7. HR Analytics Dashboard
8. E-Commerce Data Warehouse
9. Customer 360 Platform
10. Fraud Detection Data Pipeline
