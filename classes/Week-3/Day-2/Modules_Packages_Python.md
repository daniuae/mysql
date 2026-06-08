# Modules and Packages in Python (Step-by-Step Guide)

## Learning Objectives

By the end of this guide, you will understand:

- What is a Module?
- What is a Package?
- Why use Modules and Packages?
- How to create and import modules
- How to create packages
- Absolute and Relative Imports
- `__init__.py` file
- Best Practices
- Real-world Examples

---

# 1. What is a Module?

A **module** is simply a Python file containing:

- Variables
- Functions
- Classes
- Executable code

Every `.py` file is a module.

### Example

Create a file:

```python
# calculator.py

def add(a, b):
    return a + b

def subtract(a, b):
    return a - b
```

This file is a module named:

```text
calculator
```

---

# 2. Why Use Modules?

Without modules:

```python
# Everything in one file

def add():
    pass

def login():
    pass

def process_data():
    pass

def generate_report():
    pass
```

Problems:

- Difficult to maintain
- Difficult to debug
- Difficult to reuse

Modules help:

✅ Code Reusability

✅ Better Organization

✅ Easy Maintenance

✅ Team Collaboration

---

# 3. Importing a Module

## Method 1: Import Entire Module

```python
import calculator

print(calculator.add(10, 20))
```

Output:

```text
30
```

---

## Method 2: Import Specific Function

```python
from calculator import add

print(add(10, 20))
```

Output:

```text
30
```

---

## Method 3: Import Multiple Functions

```python
from calculator import add, subtract

print(add(5, 5))
print(subtract(10, 2))
```

---

## Method 4: Alias Import

```python
import calculator as calc

print(calc.add(10, 20))
```

Output:

```text
30
```

---

# 4. Built-in Modules

Python provides many built-in modules.

## Math Module

```python
import math

print(math.sqrt(25))
```

Output:

```text
5.0
```

---

## Random Module

```python
import random

print(random.randint(1, 100))
```

---

## Datetime Module

```python
import datetime

print(datetime.datetime.now())
```

---

# 5. Understanding Module Search Path

Python searches modules in:

1. Current Directory
2. PYTHONPATH
3. Standard Library

Check search path:

```python
import sys

print(sys.path)
```

---

# 6. Creating Your First Module

## Project Structure

```text
project/
│
├── main.py
└── greetings.py
```

---

### greetings.py

```python
def hello(name):
    print(f"Hello {name}")
```

---

### main.py

```python
import greetings

greetings.hello("John")
```

Output:

```text
Hello John
```

---

# 7. What is a Package?

A **package** is a collection of modules organized in directories.

Think of:

```text
Module  = Single File
Package = Folder of Modules
```

---

# 8. Creating Your First Package

## Folder Structure

```text
project/
│
├── main.py
│
└── utilities/
    ├── __init__.py
    ├── math_utils.py
    └── string_utils.py
```

---

### math_utils.py

```python
def add(a, b):
    return a + b
```

---

### string_utils.py

```python
def uppercase(text):
    return text.upper()
```

---

### __init__.py

```python
# Package Initialization File
```

---

### main.py

```python
from utilities.math_utils import add
from utilities.string_utils import uppercase

print(add(10, 20))
print(uppercase("python"))
```

Output:

```text
30
PYTHON
```

---

# 9. What is __init__.py?

`__init__.py` tells Python:

```text
"This folder should be treated as a package."
```

Example:

```python
# utilities/__init__.py

print("Utilities package loaded")
```

Whenever package loads:

```text
Utilities package loaded
```

appears.

---

# 10. Package Import Methods

## Import Entire Module

```python
import utilities.math_utils

print(utilities.math_utils.add(10, 20))
```

---

## Import Function

```python
from utilities.math_utils import add

print(add(10, 20))
```

---

## Import Package

```python
from utilities import math_utils

print(math_utils.add(10, 20))
```

---

# 11. Using Aliases

```python
from utilities import math_utils as mu

print(mu.add(5, 5))
```

Output:

```text
10
```

---

# 12. Organizing Large Projects

Example Data Engineering Project:

```text
etl_project/
│
├── main.py
│
├── extract/
│   ├── __init__.py
│   └── extractor.py
│
├── transform/
│   ├── __init__.py
│   └── transformer.py
│
├── load/
│   ├── __init__.py
│   └── loader.py
│
└── config/
    ├── __init__.py
    └── settings.py
```

Benefits:

- Clean architecture
- Easy deployment
- Better maintenance

---

# 13. Relative Imports

Suppose:

```text
utilities/
│
├── __init__.py
├── math_utils.py
└── report.py
```

---

### math_utils.py

```python
def add(a, b):
    return a + b
```

---

### report.py

```python
from .math_utils import add

print(add(10, 20))
```

Notice:

```python
from .math_utils import add
```

`.` means current package.

---

# 14. Absolute Imports

Recommended approach.

```python
from utilities.math_utils import add
```

Advantages:

- Clear
- Easy to understand
- Easy debugging

---

# 15. Package Initialization Example

### __init__.py

```python
from .math_utils import add
from .string_utils import uppercase
```

Now:

```python
from utilities import add
from utilities import uppercase

print(add(10, 20))
```

Output:

```text
30
```

---

# 16. Example: Data Engineering Package

## Folder Structure

```text
data_pipeline/
│
├── main.py
│
├── extraction/
│   ├── __init__.py
│   └── mysql_extract.py
│
├── transformation/
│   ├── __init__.py
│   └── cleaning.py
│
├── loading/
│   ├── __init__.py
│   └── snowflake_load.py
│
└── config/
    ├── __init__.py
    └── settings.py
```

---

### mysql_extract.py

```python
def extract():
    print("Extracting data...")
```

---

### cleaning.py

```python
def clean():
    print("Cleaning data...")
```

---

### snowflake_load.py

```python
def load():
    print("Loading data...")
```

---

### main.py

```python
from extraction.mysql_extract import extract
from transformation.cleaning import clean
from loading.snowflake_load import load

extract()
clean()
load()
```

Output:

```text
Extracting data...
Cleaning data...
Loading data...
```

---

# 17. Common Mistakes

## Mistake 1

```python
import math_utils
```

Module not found because package path missing.

Correct:

```python
from utilities import math_utils
```

---

## Mistake 2

Missing:

```text
__init__.py
```

May cause import issues.

---

## Mistake 3

Circular Imports

```python
A imports B
B imports A
```

Avoid this design.

---

# 18. Best Practices

### Use Meaningful Names

```python
customer_service.py
```

Instead of:

```python
test.py
```

---

### One Responsibility Per Module

Good:

```text
email_service.py
payment_service.py
report_service.py
```

Bad:

```text
everything.py
```

---

### Prefer Absolute Imports

```python
from utilities.math_utils import add
```

---

### Group Related Modules

```text
database/
api/
services/
models/
```

---

# 19. Interview Questions

### Q1. What is a Module?

A Python file containing code.

---

### Q2. What is a Package?

A directory containing multiple modules.

---

### Q3. What is __init__.py?

A file that marks a directory as a Python package and can execute initialization code.

---

### Q4. Difference Between Module and Package?

| Module | Package |
|----------|----------|
| Single .py file | Collection of modules |
| Small unit | Larger unit |
| Contains functions/classes | Contains modules/packages |

---

### Q5. What is the Difference Between Absolute and Relative Import?

Absolute:

```python
from utilities.math_utils import add
```

Relative:

```python
from .math_utils import add
```

---

# Quick Summary

| Concept | Description |
|-----------|------------|
| Module | Python file |
| Package | Folder of modules |
| Import | Access code from another module |
| __init__.py | Package initializer |
| Absolute Import | Full package path |
| Relative Import | Current package path |
| Alias | Alternate name using `as` |
| Built-in Module | `math`, `random`, `datetime` |

---

# Real-World Analogy

```text
Company
│
├── HR Department
│   ├── payroll.py
│   └── recruitment.py
│
├── Finance Department
│   ├── budget.py
│   └── tax.py
│
└── IT Department
    ├── security.py
    └── support.py
```

- Company → Package
- Department → Sub-package
- Files → Modules
- Functions → Employees performing tasks
