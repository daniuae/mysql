# Python Built-in Functions - Complete Reference Guide

## Overview

Python provides many built-in functions that are always available without importing any module.

These functions help perform:

- Data Conversion
- Mathematical Operations
- Iteration
- Input/Output
- Object Inspection
- File Handling
- Functional Programming
- OOP Operations
- Debugging

---

# Numeric Functions

| Function | Description | Example |
|-----------|-------------|----------|
| abs() | Absolute value | `abs(-10)` → 10 |
| round() | Round number | `round(3.14159,2)` |
| pow() | Power calculation | `pow(2,3)` |
| divmod() | Quotient and remainder | `divmod(10,3)` |
| sum() | Sum iterable values | `sum([1,2,3])` |
| max() | Largest value | `max([1,2,3])` |
| min() | Smallest value | `min([1,2,3])` |
| complex() | Create complex number | `complex(5,3)` |

### Example

```python
prices = [100, 200, 300]

total_sales = sum(prices)

print(total_sales)
```

Output

```text
600
```

Real World Use Case:
Sales aggregation in ETL pipelines.

---

# Type Conversion Functions

| Function | Description |
|-----------|-------------|
| int() | Convert to integer |
| float() | Convert to float |
| str() | Convert to string |
| bool() | Convert to Boolean |
| list() | Convert to list |
| tuple() | Convert to tuple |
| set() | Convert to set |
| frozenset() | Immutable set |
| dict() | Convert to dictionary |
| bytes() | Create bytes object |
| bytearray() | Mutable bytes |
| memoryview() | Memory-efficient binary access |

### Example

```python
age = int("25")
salary = float("1000.50")

print(age)
print(salary)
```

Output

```text
25
1000.5
```

Real World Use Case:
Converting CSV data before loading into databases.

---

# Mathematical Representation Functions

| Function | Description |
|-----------|-------------|
| bin() | Binary representation |
| oct() | Octal representation |
| hex() | Hexadecimal representation |

### Example

```python
print(bin(10))
print(oct(10))
print(hex(10))
```

Output

```text
0b1010
0o12
0xa
```

Real World Use Case:
Network programming and permissions management.

---

# Character Conversion Functions

| Function | Description |
|-----------|-------------|
| chr() | Unicode to character |
| ord() | Character to Unicode |
| ascii() | ASCII representation |

### Example

```python
print(chr(65))
print(ord("A"))
```

Output

```text
A
65
```

---

# Iterator Functions

| Function | Description |
|-----------|-------------|
| iter() | Create iterator |
| next() | Get next item |
| enumerate() | Add index to iterable |
| zip() | Combine iterables |
| reversed() | Reverse iterable |
| sorted() | Sort iterable |
| range() | Generate sequence |

### Example

```python
employees = ["John", "Mary", "David"]

for index, employee in enumerate(employees):
    print(index, employee)
```

Output

```text
0 John
1 Mary
2 David
```

Real World Use Case:
Generating row numbers during data processing.

---

# Functional Programming Functions

| Function | Description |
|-----------|-------------|
| map() | Apply function |
| filter() | Filter values |
| all() | Check all True |
| any() | Check any True |

### map() Example

```python
sales = [100, 200, 300]

result = list(map(lambda x: x * 1.18, sales))

print(result)
```

Output

```text
[118.0, 236.0, 354.0]
```

Real World Use Case:
Applying GST calculations.

---

### filter() Example

```python
numbers = [10, 15, 20, 25]

result = list(filter(lambda x: x % 2 == 0, numbers))

print(result)
```

Output

```text
[10, 20]
```

Real World Use Case:
Filtering valid records during ETL.

---

# Collection Functions

| Function | Description |
|-----------|-------------|
| len() | Length of object |
| sorted() | Sort collection |
| reversed() | Reverse collection |
| set() | Unique values |
| zip() | Merge collections |

### Example

```python
customers = ["John", "Mary", "John"]

unique_customers = set(customers)

print(unique_customers)
```

Output

```text
{'John', 'Mary'}
```

Real World Use Case:
Removing duplicate customer records.

---

# Input / Output Functions

| Function | Description |
|-----------|-------------|
| input() | Get user input |
| print() | Display output |
| open() | File operations |

### Example

```python
name = input("Enter Name: ")

print("Welcome", name)
```

---

# File Handling Function

## open()

### Read File

```python
with open("employees.csv", "r") as file:
    print(file.read())
```

### Write File

```python
with open("output.txt", "w") as file:
    file.write("Data Engineering")
```

Real World Use Case:
Reading source files in ETL pipelines.

---

# Object Inspection Functions

| Function | Description |
|-----------|-------------|
| type() | Get datatype |
| isinstance() | Type checking |
| issubclass() | Subclass check |
| callable() | Check callable |
| id() | Memory address |
| hash() | Hash value |
| dir() | List attributes |
| vars() | Object attributes |
| help() | Documentation |

### Example

```python
salary = 10000

print(type(salary))
print(isinstance(salary, int))
```

Output

```text
<class 'int'>
True
```

Real World Use Case:
Schema validation in data pipelines.

---

# Attribute Functions

| Function | Description |
|-----------|-------------|
| getattr() | Get attribute |
| setattr() | Set attribute |
| hasattr() | Check attribute |
| delattr() | Delete attribute |

### Example

```python
class Employee:
    pass

emp = Employee()

setattr(emp, "name", "John")

print(getattr(emp, "name"))
```

Output

```text
John
```

---

# Namespace Functions

| Function | Description |
|-----------|-------------|
| globals() | Global variables |
| locals() | Local variables |

### Example

```python
x = 100

print(globals())
```

---

# Dynamic Execution Functions

| Function | Description |
|-----------|-------------|
| eval() | Evaluate expression |
| exec() | Execute Python code |
| compile() | Compile code |

### Example

```python
print(eval("10+20"))
```

Output

```text
30
```

⚠ Never use eval() with untrusted user input.

---

# OOP Functions

| Function | Description |
|-----------|-------------|
| object() | Base object |
| property() | Managed attribute |
| staticmethod() | Static method |
| classmethod() | Class method |
| super() | Parent class access |

### staticmethod Example

```python
class Math:

    @staticmethod
    def add(a, b):
        return a + b

print(Math.add(5, 10))
```

Output

```text
15
```

---

# Utility Functions

| Function | Description |
|-----------|-------------|
| format() | Format values |
| repr() | Official string representation |
| slice() | Slice object |
| breakpoint() | Debugging |
| copyright() | Python copyright |
| credits() | Python credits |
| license() | Python license |

### Example

```python
amount = 1234567

print(format(amount, ","))
```

Output

```text
1,234,567
```

---

# Import Function

## __import__()

Used for dynamic imports.

```python
math_module = __import__("math")

print(math_module.sqrt(25))
```

Output

```text
5.0
```

---

# Complete Built-in Functions List

```text
abs()
aiter()
all()
anext()
any()
ascii()
bin()
bool()
breakpoint()
bytearray()
bytes()
callable()
chr()
classmethod()
compile()
complex()
delattr()
dict()
dir()
divmod()
enumerate()
eval()
exec()
filter()
float()
format()
frozenset()
getattr()
globals()
hasattr()
hash()
help()
hex()
id()
input()
int()
isinstance()
issubclass()
iter()
len()
list()
locals()
map()
max()
memoryview()
min()
next()
object()
oct()
open()
ord()
pow()
print()
property()
range()
repr()
reversed()
round()
set()
setattr()
slice()
sorted()
staticmethod()
str()
sum()
super()
tuple()
type()
vars()
zip()
__import__()
```

---

# Top 15 Functions Every Data Engineer Should Master

```python
len()
range()
enumerate()
zip()
map()
filter()
sum()
max()
min()
sorted()
open()
isinstance()
print()
int()
str()
```

---

# ETL Example Using Multiple Built-in Functions

```python
sales = ["100", "200", "300", "400"]

sales_int = list(map(int, sales))

total_sales = sum(sales_int)

average_sales = total_sales / len(sales_int)

print("Total:", total_sales)
print("Average:", average_sales)
print("Highest:", max(sales_int))
print("Lowest:", min(sales_int))
```

Output

```text
Total: 1000
Average: 250.0
Highest: 400
Lowest: 100
```

Real World Scenario:
Reading sales data from CSV files, converting data types, validating records, aggregating metrics, and loading results into a Data Warehouse.
