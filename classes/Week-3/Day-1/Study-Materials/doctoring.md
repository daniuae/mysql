# Docstrings in Python

## What is a Docstring?

A **docstring (documentation string)** is a string literal used to describe what a module, class, function, or method does.

It is written using triple quotes (`""" """` or `''' '''`) immediately after the definition.

Docstrings help:

- Document code
- Improve readability
- Generate API documentation
- Assist developers using IDEs
- Provide built-in help using `help()`

---

# Function Docstring Example

## Sample Code

```python
def add(a, b):
    """
    Adds two numbers and returns the result.

    Parameters:
        a (int): First number
        b (int): Second number

    Returns:
        int: Sum of a and b
    """
    return a + b
```

### Accessing the Docstring

```python
print(add.__doc__)
```

### Output

```text
Adds two numbers and returns the result.

Parameters:
    a (int): First number
    b (int): Second number

Returns:
    int: Sum of a and b
```

---

# Using help()

```python
help(add)
```

### Output (Simplified)

```text
Help on function add:

add(a, b)
    Adds two numbers and returns the result.

    Parameters:
        a (int): First number
        b (int): Second number

    Returns:
        int: Sum of a and b
```

---

# Single-Line Docstring

Use when the function is simple.

```python
def greet():
    """Displays a welcome message."""
    print("Welcome!")
```

### Access

```python
print(greet.__doc__)
```

### Output

```text
Displays a welcome message.
```

---

# Multi-Line Docstring

Use for more detailed explanations.

```python
def calculate_area(length, width):
    """
    Calculate the area of a rectangle.

    Args:
        length (float): Length of rectangle
        width (float): Width of rectangle

    Returns:
        float: Area of rectangle
    """
    return length * width
```

---

# Class Docstring Example

```python
class Employee:
    """
    Represents an employee in the organization.

    Attributes:
        emp_id (str): Employee ID
        name (str): Employee Name
    """

    def __init__(self, emp_id, name):
        self.emp_id = emp_id
        self.name = name
```

### Access

```python
print(Employee.__doc__)
```

---

# Method Docstring Example

```python
class Calculator:

    def multiply(self, a, b):
        """
        Multiply two numbers.

        Args:
            a (int): First number
            b (int): Second number

        Returns:
            int: Product of two numbers
        """
        return a * b
```

---

# Module Docstring Example

At the top of a Python file:

```python
"""
Employee Management System

This module contains functions and classes
for employee data processing.
"""
```

File: `employee.py`

---

# Real-World ETL Example

```python
def extract_data(file_path):
    """
    Extract data from a CSV file.

    Args:
        file_path (str): Path to CSV file

    Returns:
        list: Records extracted from CSV
    """
    pass
```

```python
def transform_data(records):
    """
    Clean and transform extracted records.

    Args:
        records (list): Raw records

    Returns:
        list: Cleaned records
    """
    pass
```

```python
def load_data(records):
    """
    Load transformed records into database.

    Args:
        records (list): Processed records

    Returns:
        None
    """
    pass
```

These docstrings help Data Engineers understand ETL pipeline components quickly.

---

# Common Docstring Formats

## Google Style

```python
def add(a, b):
    """
    Adds two numbers.

    Args:
        a (int): First number.
        b (int): Second number.

    Returns:
        int: Sum of numbers.
    """
```

---

## NumPy Style

```python
def add(a, b):
    """
    Adds two numbers.

    Parameters
    ----------
    a : int
        First number
    b : int
        Second number

    Returns
    -------
    int
        Sum of numbers
    """
```

---

## reStructuredText (RST) Style

```python
def add(a, b):
    """
    Adds two numbers.

    :param a: First number
    :type a: int
    :param b: Second number
    :type b: int
    :return: Sum of numbers
    :rtype: int
    """
```

---

# Best Practices

✅ Write docstrings for:

- Modules
- Classes
- Functions
- Methods

✅ Explain:

- Purpose
- Parameters
- Return values
- Exceptions (if any)

✅ Keep them:

- Clear
- Short
- Meaningful

❌ Avoid:

```python
def add(a, b):
    """Add"""
```

Too vague.

Prefer:

```python
def add(a, b):
    """Adds two numbers and returns the result."""
```

---

# Quick Cheat Sheet

## Function

```python
def function_name(param1, param2):
    """
    Description.

    Args:
        param1 (type): Description
        param2 (type): Description

    Returns:
        type: Description
    """
```

## Class

```python
class MyClass:
    """
    Class description.
    """
```

## Module

```python
"""
Module description.
"""
```

---

# Interview Questions

### Q1: What is a docstring?

A docstring is a documentation string used to describe modules, classes, functions, and methods.

### Q2: How do you access a docstring?

```python
function_name.__doc__
```

### Q3: Which function displays docstring information?

```python
help(function_name)
```

### Q4: What quotes are used for docstrings?

```python
"""Docstring"""
```

or

```python
'''Docstring'''
```

### Q5: Why are docstrings important?

- Documentation
- Code readability
- IDE support
- API generation
- Easier maintenance

---

# Summary

Docstrings are Python's built-in documentation mechanism. They make code easier to understand, maintain, and use. Every production-quality function, class, and module should include meaningful docstrings.
