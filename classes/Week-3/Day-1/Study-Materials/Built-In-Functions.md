# Common Built-in Functions & Math Module in Python

## Built-in Functions

Built-in functions are available by default in Python.

---

## Input & Output

### print()

Displays output.

```python
print("Hello World")
```

**Output**

```text
Hello World
```

### input()

Accepts user input.

```python
name = input("Enter Name: ")
print(name)
```

---

## Type Conversion Functions

### int()

```python
x = int("100")
print(x)
```

**Output**

```text
100
```

### float()

```python
x = float("10.5")
print(x)
```

### str()

```python
x = str(100)
print(x)
```

### bool()

```python
print(bool(1))
print(bool(0))
```

**Output**

```text
True
False
```

---

## Mathematical Functions

### abs()

Returns absolute value.

```python
print(abs(-25))
```

**Output**

```text
25
```

### round()

```python
print(round(3.678))
print(round(3.678, 2))
```

**Output**

```text
4
3.68
```

### pow()

```python
print(pow(2, 3))
```

**Output**

```text
8
```

### min() and max()

```python
numbers = [10, 20, 5, 40]

print(min(numbers))
print(max(numbers))
```

**Output**

```text
5
40
```

### sum()

```python
numbers = [10, 20, 30]

print(sum(numbers))
```

**Output**

```text
60
```

---

## Sequence Functions

### len()

```python
print(len("Python"))
```

**Output**

```text
6
```

### sorted()

```python
numbers = [5, 2, 8, 1]

print(sorted(numbers))
```

**Output**

```text
[1, 2, 5, 8]
```

### reversed()

```python
name = "Python"

print(list(reversed(name)))
```

**Output**

```text
['n', 'o', 'h', 't', 'y', 'P']
```

---

## Data Structure Functions

### list()

```python
x = (1, 2, 3)

print(list(x))
```

### tuple()

```python
x = [1, 2, 3]

print(tuple(x))
```

### set()

```python
numbers = [1, 2, 2, 3, 3]

print(set(numbers))
```

**Output**

```text
{1, 2, 3}
```

### dict()

```python
employee = dict(name="Dani", age=30)

print(employee)
```

---

## Character Functions

### ord()

```python
print(ord('A'))
```

**Output**

```text
65
```

### chr()

```python
print(chr(65))
```

**Output**

```text
A
```

---

## Validation Functions

### type()

```python
x = 100

print(type(x))
```

### isinstance()

```python
x = 100

print(isinstance(x, int))
```

**Output**

```text
True
```

---

# Math Module

Import the module:

```python
import math
```

---

## Mathematical Constants

### math.pi

```python
import math

print(math.pi)
```

**Output**

```text
3.141592653589793
```

### math.e

```python
import math

print(math.e)
```

**Output**

```text
2.718281828459045
```

---

## Power Functions

### math.sqrt()

```python
import math

print(math.sqrt(25))
```

**Output**

```text
5.0
```

### math.pow()

```python
import math

print(math.pow(2, 3))
```

**Output**

```text
8.0
```

---

## Rounding Functions

### math.ceil()

Rounds up.

```python
import math

print(math.ceil(5.1))
```

**Output**

```text
6
```

### math.floor()

Rounds down.

```python
import math

print(math.floor(5.9))
```

**Output**

```text
5
```

### math.trunc()

Removes decimal portion.

```python
import math

print(math.trunc(5.99))
```

**Output**

```text
5
```

---

## Logarithmic Functions

### math.log()

```python
import math

print(math.log(10))
```

### math.log10()

```python
import math

print(math.log10(100))
```

**Output**

```text
2.0
```

---

## Trigonometric Functions

### math.sin()

```python
import math

print(math.sin(math.radians(90)))
```

**Output**

```text
1.0
```

### math.cos()

```python
import math

print(math.cos(math.radians(0)))
```

**Output**

```text
1.0
```

### math.tan()

```python
import math

print(math.tan(math.radians(45)))
```

**Output**

```text
0.9999999999999999
```

---

## Factorial

### math.factorial()

```python
import math

print(math.factorial(5))
```

**Output**

```text
120
```

---

## Greatest Common Divisor

### math.gcd()

```python
import math

print(math.gcd(24, 36))
```

**Output**

```text
12
```

---

## Distance Between Points

### math.dist()

```python
import math

point1 = (1, 2)
point2 = (4, 6)

print(math.dist(point1, point2))
```

**Output**

```text
5.0
```

---

# Real-World Examples

## Circle Area Calculation

```python
import math

radius = 5

area = math.pi * radius ** 2

print("Area =", area)
```

---

## Interest Calculation

```python
principal = 100000
rate = 10

interest = principal * (rate / 100)

print("Interest =", interest)
```

---

## Student Marks Analysis

```python
marks = [78, 85, 92, 67, 89]

print("Total:", sum(marks))
print("Average:", sum(marks) / len(marks))
print("Highest:", max(marks))
print("Lowest:", min(marks))
```

---

# Frequently Used Functions for Data Engineers

| Function | Purpose |
|-----------|----------|
| len() | Count records |
| sum() | Total values |
| min() | Minimum value |
| max() | Maximum value |
| sorted() | Sort data |
| abs() | Remove negative sign |
| round() | Round decimals |
| type() | Check datatype |
| isinstance() | Validate datatype |
| math.sqrt() | Square root |
| math.ceil() | Round up |
| math.floor() | Round down |
| math.log() | Log calculations |
| math.factorial() | Combinatorics |
| math.gcd() | Mathematical operations |

---

# Quick Quiz

### Q1

```python
print(abs(-50))
```

**Answer:** `50`

### Q2

```python
import math
print(math.ceil(4.2))
```

**Answer:** `5`

### Q3

```python
print(len("Python"))
```

**Answer:** `6`

### Q4

```python
print(max([10, 25, 5, 40]))
```

**Answer:** `40`

### Q5

```python
import math
print(math.factorial(4))
```

**Answer:** `24`
