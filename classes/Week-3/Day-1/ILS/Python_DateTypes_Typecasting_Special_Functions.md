# Python Data Types, Typecasting & Special Functions

## Objective
Learn Python data types, typecasting, and built-in functions: `len()`, `id()`, `type()`, and `range()`.

## Key Concepts
- Common data types: `int`, `float`, `str`, `list`
- Typecasting converts one data type to another.
- Useful functions:
  - `type()` → Returns data type
  - `len()` → Returns length
  - `id()` → Returns object identity (memory reference)
  - `range()` → Generates a sequence of numbers

---

# Part 1: Data Types

### Setup
1. Open VS Code.
2. Create a folder: **pythonlabs**
3. Create a file: **fundamentals.py**

### Code

```python
# Data Type Exploration

int_var = 10
float_var = 10.5
str_var = "Hello, World!"
list_var = [1, 2, 3, 4, 5]

print("Integer:", int_var, type(int_var))
print("Float:", float_var, type(float_var))
print("String:", str_var, type(str_var))
print("List:", list_var, type(list_var))
```

### Run

```bash
python fundamentals.py
```

### Output

```text
Integer: 10 <class 'int'>
Float: 10.5 <class 'float'>
String: Hello, World! <class 'str'>
List: [1, 2, 3, 4, 5] <class 'list'>
```

---

# Part 2: Typecasting

### Append Code

```python
# Typecasting

int_to_float = float(int_var)
float_to_int = int(float_var)
str_to_int = int("123")
list_to_str = str(list_var)

print("Int → Float:", int_to_float, type(int_to_float))
print("Float → Int:", float_to_int, type(float_to_int))
print("String → Int:", str_to_int, type(str_to_int))
print("List → String:", list_to_str, type(list_to_str))
```

### Output

```text
Int → Float: 10.0 <class 'float'>
Float → Int: 10 <class 'int'>
String → Int: 123 <class 'int'>
List → String: [1, 2, 3, 4, 5] <class 'str'>
```

---

# Part 3: Special Functions

### Append Code

```python
# Special Functions

print("String Length:", len(str_var))
print("List Length:", len(list_var))

print("int_var ID:", id(int_var))
print("float_var ID:", id(float_var))
print("str_var ID:", id(str_var))
print("list_var ID:", id(list_var))

print("int_var Type:", type(int_var))
print("float_var Type:", type(float_var))
print("str_var Type:", type(str_var))
print("list_var Type:", type(list_var))

range_list = list(range(10))
print("Range:", range_list, type(range_list))
```

### Sample Output

```text
String Length: 13
List Length: 5

int_var ID: 140731907923408
float_var ID: 140731907923216

int_var Type: <class 'int'>
float_var Type: <class 'float'>

Range: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] <class 'list'>
```

---

## Quick Reference

| Function | Description |
|-----------|-------------|
| `type(x)` | Returns data type |
| `len(x)` | Returns length |
| `id(x)` | Returns object identity |
| `range(n)` | Generates numbers from 0 to n-1 |

## Learning Outcomes
✔ Understand Python data types  
✔ Perform typecasting  
✔ Use `len()`, `id()`, `type()` and `range()`  
✔ Execute Python programs in VS Code
