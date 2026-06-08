# Advanced Functional Programming in Python

## Learning Objectives

After completing this guide, you will understand:

- Lambda Functions
- map()
- filter()
- reduce()
- Iterators
- Generators
- Decorators
- Benefits of Functional Programming
- Real-world ETL/Data Engineering Use Cases

---

# 1. Functional Programming Overview

Functional Programming (FP) is a programming style where:

- Functions are treated as first-class objects.
- Functions can be passed as arguments.
- Functions can return other functions.
- Avoid changing data (immutability).
- Focus on "what to do" rather than "how to do it".

### Benefits

✔ Cleaner code  
✔ Less bugs  
✔ Reusable functions  
✔ Easier testing  
✔ Better performance for large datasets  
✔ Ideal for ETL and Data Engineering

---

# 2. Lambda Functions

A lambda function is an anonymous (nameless) function.

## Syntax

```python
lambda arguments: expression
```

## Traditional Function

```python
def square(x):
    return x * x

print(square(5))
```

Output:

```text
25
```

## Lambda Equivalent

```python
square = lambda x: x * x

print(square(5))
```

Output:

```text
25
```

---

## Multiple Parameters

```python
add = lambda a, b: a + b

print(add(10, 20))
```

Output

```text
30
```

---

## Sorting Example

```python
employees = [
    ("John", 50000),
    ("David", 70000),
    ("Alex", 60000)
]

employees.sort(key=lambda x: x[1])

print(employees)
```

Output

```python
[
 ('John', 50000),
 ('Alex', 60000),
 ('David', 70000)
]
```

---

# Lambda Use Cases

- Sorting data
- Transformations
- ETL pipelines
- Data filtering
- Pandas operations

---

# 3. map()

map() applies a function to every element in an iterable.

---

## Syntax

```python
map(function, iterable)
```

---

## Example 1

```python
numbers = [1, 2, 3, 4, 5]

result = map(lambda x: x * 2, numbers)

print(list(result))
```

Output

```text
[2, 4, 6, 8, 10]
```

---

## Traditional Loop

```python
numbers = [1,2,3,4,5]

output = []

for n in numbers:
    output.append(n*2)

print(output)
```

Output

```text
[2,4,6,8,10]
```

---

## Example 2

Convert names to uppercase.

```python
names = ["john", "alex", "david"]

result = map(str.upper, names)

print(list(result))
```

Output

```text
['JOHN', 'ALEX', 'DAVID']
```

---

# map() Use Cases

- Data cleaning
- Data transformation
- Unit conversion
- ETL processing

Example:

```python
sales = [1000, 2000, 3000]

sales_usd = list(map(lambda x: x / 83, sales))
```

---

# 4. filter()

filter() returns elements that satisfy a condition.

---

## Syntax

```python
filter(function, iterable)
```

---

## Example 1

Filter even numbers.

```python
numbers = [1,2,3,4,5,6,7,8]

result = filter(lambda x: x % 2 == 0, numbers)

print(list(result))
```

Output

```text
[2,4,6,8]
```

---

## Example 2

Filter employees with salary > 50000

```python
employees = [
    ("John",50000),
    ("David",70000),
    ("Alex",60000)
]

high_paid = filter(
    lambda emp: emp[1] > 50000,
    employees
)

print(list(high_paid))
```

Output

```python
[
 ('David',70000),
 ('Alex',60000)
]
```

---

# filter() Use Cases

- Data validation
- Remove null values
- Customer segmentation
- Fraud detection

Example

```python
records = [10, None, 20, None, 30]

valid = list(filter(lambda x: x is not None, records))
```

Output

```text
[10,20,30]
```

---

# 5. reduce()

reduce() reduces an iterable to a single value.

Located in:

```python
from functools import reduce
```

---

## Syntax

```python
reduce(function, iterable)
```

---

## Example 1

Sum numbers.

```python
from functools import reduce

numbers = [1,2,3,4,5]

result = reduce(
    lambda x,y: x+y,
    numbers
)

print(result)
```

Output

```text
15
```

---

## Example 2

Find maximum value.

```python
from functools import reduce

numbers = [10,30,5,100,25]

max_num = reduce(
    lambda a,b: a if a>b else b,
    numbers
)

print(max_num)
```

Output

```text
100
```

---

# reduce() Use Cases

- Aggregation
- Total sales
- Product calculations
- Statistical summaries

---

# 6. Iterators

An iterator is an object that can be traversed one element at a time.

---

## How it Works

Uses:

```python
__iter__()
__next__()
```

---

## Example

```python
numbers = [10,20,30]

iterator = iter(numbers)

print(next(iterator))
print(next(iterator))
print(next(iterator))
```

Output

```text
10
20
30
```

---

## StopIteration

```python
numbers = [1]

it = iter(numbers)

print(next(it))
print(next(it))
```

Output

```text
StopIteration
```

---

# Custom Iterator

```python
class Counter:

    def __init__(self, max):
        self.max = max
        self.current = 0

    def __iter__(self):
        return self

    def __next__(self):
        if self.current < self.max:
            self.current += 1
            return self.current
        raise StopIteration

for num in Counter(5):
    print(num)
```

Output

```text
1
2
3
4
5
```

---

# Iterator Benefits

- Memory efficient
- Lazy loading
- Handles large datasets

---

# 7. Generators

Generators create iterators automatically.

Use:

```python
yield
```

instead of

```python
return
```

---

## Simple Generator

```python
def generate_numbers():

    yield 1
    yield 2
    yield 3

for n in generate_numbers():
    print(n)
```

Output

```text
1
2
3
```

---

## Generator vs List

### List

```python
numbers = [x for x in range(1000000)]
```

Consumes large memory.

---

### Generator

```python
numbers = (x for x in range(1000000))
```

Consumes very little memory.

---

## Fibonacci Generator

```python
def fibonacci(n):

    a, b = 0, 1

    for _ in range(n):
        yield a
        a, b = b, a+b

for num in fibonacci(10):
    print(num)
```

Output

```text
0 1 1 2 3 5 8 13 21 34
```

---

# Generator Use Cases

- Reading huge files
- Streaming APIs
- ETL pipelines
- Kafka consumers
- Spark data processing

---

## ETL Example

```python
def read_large_file(filename):

    with open(filename) as file:
        for line in file:
            yield line
```

Memory-efficient file processing.

---

# 8. Decorators

Decorators modify or extend function behavior without changing original code.

---

## Syntax

```python
@decorator_name
```

---

# Basic Decorator

```python
def decorator(func):

    def wrapper():
        print("Before function")

        func()

        print("After function")

    return wrapper
```

---

## Usage

```python
@decorator
def hello():
    print("Hello World")

hello()
```

Output

```text
Before function
Hello World
After function
```

---

# Decorator with Arguments

```python
def logger(func):

    def wrapper(*args, **kwargs):

        print("Function Called")

        result = func(*args, **kwargs)

        print("Function Finished")

        return result

    return wrapper
```

---

## Example

```python
@logger
def add(a,b):
    return a+b

print(add(10,20))
```

Output

```text
Function Called
Function Finished
30
```

---

# Real-world Decorator

## Execution Time

```python
import time

def timer(func):

    def wrapper(*args, **kwargs):

        start = time.time()

        result = func(*args, **kwargs)

        end = time.time()

        print(f"Execution Time: {end-start}")

        return result

    return wrapper
```

---

## Usage

```python
@timer
def process():

    time.sleep(2)

process()
```

Output

```text
Execution Time: 2.0
```

---

# Decorator Use Cases

- Logging
- Authentication
- Authorization
- Monitoring
- Retry mechanisms
- Performance measurement
- Audit trails

---

# Functional Programming Pipeline

Example combining map, filter and reduce.

```python
from functools import reduce

numbers = [1,2,3,4,5,6,7,8,9,10]

result = reduce(
    lambda x,y: x+y,
    map(
        lambda x: x*2,
        filter(
            lambda x: x%2==0,
            numbers
        )
    )
)

print(result)
```

Step 1:

```text
[2,4,6,8,10]
```

Step 2:

```text
[4,8,12,16,20]
```

Step 3:

```text
60
```

Output

```text
60
```

---

# Data Engineering Example

Customer Sales ETL

```python
from functools import reduce

sales = [1000, 2500, 500, 3000, 800]

filtered_sales = filter(
    lambda x: x > 1000,
    sales
)

taxed_sales = map(
    lambda x: x * 1.18,
    filtered_sales
)

total = reduce(
    lambda x,y: x+y,
    taxed_sales
)

print(total)
```

Output

```text
7670.0
```

---

# Interview Questions

### Q1. Difference between map() and filter()?

| map() | filter() |
|---------|---------|
| Transforms data | Filters data |
| Returns all items | Returns matching items |

---

### Q2. Difference between Generator and Iterator?

| Generator | Iterator |
|------------|-----------|
| Uses yield | Uses __next__() |
| Easy to create | More code |
| Memory efficient | Memory efficient |

---

### Q3. Why use Decorators?

- Code reuse
- Logging
- Security
- Performance monitoring

---

### Q4. Why are Generators useful?

- Lazy evaluation
- Reduced memory consumption
- Suitable for big data processing

---

# Summary Cheat Sheet

| Feature | Purpose |
|-----------|----------|
| lambda | Anonymous function |
| map() | Transform data |
| filter() | Select data |
| reduce() | Aggregate data |
| iterator | Sequential traversal |
| generator | Lazy data generation |
| decorator | Extend functionality |

---

# Key Takeaway

Functional Programming is heavily used in:

- Python ETL Pipelines
- Data Engineering
- Data Science
- Big Data Processing
- API Processing
- Streaming Systems
- Machine Learning Pipelines

The most commonly used concepts in production systems are:

1. Lambda Functions
2. map()
3. filter()
4. Generators
5. Decorators

These help write cleaner, reusable, scalable, and memory-efficient code.
```**`**````
