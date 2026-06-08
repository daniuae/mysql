# *args and **kwargs in Python

## Overview

`*args` and `**kwargs` are used when a function needs to accept a variable number of arguments.

* `*args` → Variable Positional Arguments
* `**kwargs` → Variable Keyword Arguments

---

# 1. *args (Variable Positional Arguments)

`*args` allows a function to accept any number of positional arguments.

## Example

```python
def add_numbers(*args):
    print(args)
    return sum(args)

result = add_numbers(10, 20, 30, 40)
print(result)
```

### Output

```text
(10, 20, 30, 40)
100
```

### Explanation

* `args` becomes a tuple.
* Any number of positional arguments can be passed.

```python
def display(*args):
    for item in args:
        print(item)

display("Python", "SQL", "Scala")
```

### Output

```text
Python
SQL
Scala
```

---

# 2. **kwargs (Variable Keyword Arguments)

`**kwargs` allows a function to accept any number of named arguments.

## Example

```python
def display_details(**kwargs):
    print(kwargs)

display_details(name="John", age=25, city="Chennai")
```

### Output

```text
{'name': 'John', 'age': 25, 'city': 'Chennai'}
```

### Explanation

* `kwargs` becomes a dictionary.
* Keys represent parameter names.
* Values represent parameter values.

---

## Accessing Values

```python
def display_details(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

display_details(name="John", age=25, city="Chennai")
```

### Output

```text
name: John
age: 25
city: Chennai
```

---

# 3. Using *args and **kwargs Together

```python
def demo(*args, **kwargs):
    print("Args:", args)
    print("Kwargs:", kwargs)

demo(10, 20, 30, name="John", city="Chennai")
```

### Output

```text
Args: (10, 20, 30)
Kwargs: {'name': 'John', 'city': 'Chennai'}
```

---

# 4. Parameter Order

```python
def func(a, b, *args, **kwargs):
    print(a)
    print(b)
    print(args)
    print(kwargs)

func(1, 2, 3, 4, 5, name="John")
```

### Output

```text
1
2
(3, 4, 5)
{'name': 'John'}
```

### Recommended Order

```python
def func(
    normal_arguments,
    *args,
    **kwargs
):
    pass
```

---

# 5. Unpacking with *

## List/Tuple Unpacking

```python
numbers = [10, 20, 30]

def add(a, b, c):
    return a + b + c

print(add(*numbers))
```

### Output

```text
60
```

Equivalent to:

```python
add(10, 20, 30)
```

---

# 6. Unpacking with **

## Dictionary Unpacking

```python
person = {
    "name": "John",
    "age": 25
}

def display(name, age):
    print(name, age)

display(**person)
```

### Output

```text
John 25
```

Equivalent to:

```python
display(name="John", age=25)
```

---

# Real-World ETL Example

A generic ETL logger using `*args` and `**kwargs`.

```python
def log_event(event_type, *messages, **metadata):
    print(f"Event Type: {event_type}")

    print("\nMessages:")
    for msg in messages:
        print("-", msg)

    print("\nMetadata:")
    for key, value in metadata.items():
        print(f"{key}: {value}")

log_event(
    "DATA_LOAD",
    "Reading CSV",
    "Validating Records",
    "Loading into PostgreSQL",
    source="customers.csv",
    records=10000,
    status="SUCCESS"
)
```

### Output

```text
Event Type: DATA_LOAD

Messages:
- Reading CSV
- Validating Records
- Loading into PostgreSQL

Metadata:
source: customers.csv
records: 10000
status: SUCCESS
```

---

# Quick Comparison

| Feature   | *args                    | **kwargs                          |
| --------- | ------------------------ | --------------------------------- |
| Accepts   | Positional Arguments     | Named Arguments                   |
| Data Type | Tuple                    | Dictionary                        |
| Symbol    | `*`                      | `**`                              |
| Example   | `(1, 2, 3)`              | `{'name':'John'}`                 |
| Use Case  | Unknown Number of Values | Unknown Number of Key-Value Pairs |

---

# Memory Trick

```text
*args
  -> Single *
  -> Many Values
  -> Tuple

**kwargs
  -> Double **
  -> Key=Value Pairs
  -> Dictionary
```

## Example

```python
def example(*args, **kwargs):
    print(args)
    print(kwargs)

example(1, 2, 3, name="John", city="Chennai")
```

### Output

```text
(1, 2, 3)
{'name': 'John', 'city': 'Chennai'}
```

---

# Interview Questions

### Q1. What is the difference between *args and **kwargs?

| *args                | **kwargs          |
| -------------------- | ----------------- |
| Positional Arguments | Keyword Arguments |
| Tuple                | Dictionary        |
| Uses `*`             | Uses `**`         |

### Q2. Can we use both together?

Yes.

```python
def func(*args, **kwargs):
    pass
```

### Q3. Why are they useful?

* Dynamic functions
* ETL frameworks
* API development
* Decorators
* Reusable libraries
* Configuration-driven applications

---

# Summary

* `*args` collects multiple positional arguments into a tuple.
* `**kwargs` collects multiple keyword arguments into a dictionary.
* `*` is also used for unpacking lists/tuples.
* `**` is used for unpacking dictionaries.
* Widely used in Data Engineering, ETL pipelines, APIs, decorators, and framework development.
