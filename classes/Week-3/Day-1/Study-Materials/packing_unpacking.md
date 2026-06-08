# Packing and Unpacking in Python

## What is Packing?

**Packing** means placing multiple values into a single variable (usually a tuple).

### Example 1: Packing Values into a Tuple

```python
data = 10, 20, 30

print(data)
print(type(data))
```

### Output

```text
(10, 20, 30)
<class 'tuple'>
```

### Explanation

Python automatically packs multiple values into a tuple.

```python
data = (10, 20, 30)
```

is equivalent to:

```python
data = 10, 20, 30
```

---

## What is Unpacking?

**Unpacking** means extracting values from a collection (tuple, list, set, etc.) into individual variables.

### Example 2: Tuple Unpacking

```python
data = (10, 20, 30)

a, b, c = data

print(a)
print(b)
print(c)
```

### Output

```text
10
20
30
```

### Explanation

Each variable receives one value from the tuple.

| Variable | Value |
|-----------|--------|
| a | 10 |
| b | 20 |
| c | 30 |

---

# Packing and Unpacking with Lists

### Example 3

```python
numbers = [100, 200, 300]

x, y, z = numbers

print(x)
print(y)
print(z)
```

### Output

```text
100
200
300
```

---

# Using the `*` Operator for Unpacking

The `*` operator collects multiple values into a list.

### Example 4

```python
a, *b = [1, 2, 3, 4, 5]

print(a)
print(b)
```

### Output

```text
1
[2, 3, 4, 5]
```

### Explanation

- `a` gets the first value.
- `*b` collects the remaining values into a list.

---

### Example 5

```python
a, *b, c = [1, 2, 3, 4, 5]

print(a)
print(b)
print(c)
```

### Output

```text
1
[2, 3, 4]
5
```

---

# Function Argument Packing

Python can pack multiple arguments into a tuple using `*args`.

### Example 6

```python
def display(*args):
    print(args)

display(10, 20, 30, 40)
```

### Output

```text
(10, 20, 30, 40)
```

### Explanation

All positional arguments are packed into a tuple.

---

# Function Argument Unpacking

### Example 7

```python
def add(a, b, c):
    print(a + b + c)

numbers = (10, 20, 30)

add(*numbers)
```

### Output

```text
60
```

### Explanation

The `*` operator unpacks the tuple and passes values as separate arguments.

```python
add(10, 20, 30)
```

---

# Dictionary Packing and Unpacking

## Packing with `**kwargs`

### Example 8

```python
def employee(**kwargs):
    print(kwargs)

employee(name="John", age=25, city="Chennai")
```

### Output

```text
{'name': 'John', 'age': 25, 'city': 'Chennai'}
```

### Explanation

Keyword arguments are packed into a dictionary.

---

## Unpacking a Dictionary

### Example 9

```python
employee = {
    "name": "John",
    "age": 25
}

def display(name, age):
    print(name, age)

display(**employee)
```

### Output

```text
John 25
```

### Explanation

The `**` operator unpacks dictionary key-value pairs into function arguments.

---

# Real-World Example (Data Engineering)

Suppose a database record is fetched:

```python
record = ("E101", "Rahul", 75000)

emp_id, emp_name, salary = record

print(emp_id)
print(emp_name)
print(salary)
```

### Output

```text
E101
Rahul
75000
```

This is commonly used when:

- Reading database records
- Processing CSV files
- ETL pipelines
- API response handling
- Data transformation tasks

---

# Packing vs Unpacking

| Feature | Packing | Unpacking |
|----------|----------|------------|
| Purpose | Combine values | Extract values |
| Symbol | `*args`, `**kwargs` | `*`, `**` |
| Result | Tuple/Dictionary | Individual variables |
| Usage | Function definitions | Function calls and assignments |

---

# Quick Cheat Sheet

## Packing

```python
data = 1, 2, 3

def func(*args):
    pass

def func(**kwargs):
    pass
```

## Unpacking

```python
a, b, c = (1, 2, 3)

func(*tuple_data)

func(**dict_data)
```

---

# Interview Questions

### Q1: What is packing in Python?

Packing is the process of combining multiple values into a single variable (usually a tuple or dictionary).

### Q2: What is unpacking in Python?

Unpacking extracts values from a collection and assigns them to individual variables.

### Q3: What is `*args`?

`*args` packs multiple positional arguments into a tuple.

### Q4: What is `**kwargs`?

`**kwargs` packs multiple keyword arguments into a dictionary.

### Q5: How do you unpack a tuple into function arguments?

```python
values = (10, 20, 30)
func(*values)
```

### Q6: How do you unpack a dictionary into function arguments?

```python
data = {"name": "John", "age": 25}
func(**data)
```

Python's packing and unpacking features make code cleaner, more flexible, and are heavily used in real-world applications, especially APIs, ETL pipelines, and framework development.
