# Operators in Python

## What are Operators?

Operators are special symbols used to perform operations on variables and values.

```python
a = 10
b = 5

print(a + b)  # 15
```

---

# 1. Arithmetic Operators

Used for mathematical calculations.

| Operator | Description | Example | Result |
|-----------|------------|----------|--------|
| + | Addition | 10 + 5 | 15 |
| - | Subtraction | 10 - 5 | 5 |
| * | Multiplication | 10 * 5 | 50 |
| / | Division | 10 / 5 | 2.0 |
| // | Floor Division | 10 // 3 | 3 |
| % | Modulus (Remainder) | 10 % 3 | 1 |
| ** | Exponent | 2 ** 3 | 8 |

### Example

```python
a = 10
b = 3

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a // b)
print(a % b)
print(a ** b)
```

---

# 2. Comparison Operators

Used to compare values.

| Operator | Description | Example |
|-----------|------------|----------|
| == | Equal to | a == b |
| != | Not equal to | a != b |
| > | Greater than | a > b |
| < | Less than | a < b |
| >= | Greater than or equal to | a >= b |
| <= | Less than or equal to | a <= b |

### Example

```python
a = 10
b = 20

print(a == b)
print(a != b)
print(a > b)
print(a < b)
print(a >= b)
print(a <= b)
```

---

# 3. Assignment Operators

Used to assign values to variables.

| Operator | Example | Equivalent To |
|-----------|----------|---------------|
| = | x = 5 | x = 5 |
| += | x += 3 | x = x + 3 |
| -= | x -= 3 | x = x - 3 |
| *= | x *= 3 | x = x * 3 |
| /= | x /= 3 | x = x / 3 |
| //= | x //= 3 | x = x // 3 |
| %= | x %= 3 | x = x % 3 |
| **= | x **= 3 | x = x ** 3 |

### Example

```python
x = 10

x += 5
print(x)

x *= 2
print(x)
```

---

# 4. Logical Operators

Used to combine conditions.

| Operator | Description |
|-----------|-------------|
| and | Returns True if both conditions are True |
| or | Returns True if at least one condition is True |
| not | Reverses the result |

### Example

```python
age = 25
salary = 50000

print(age > 18 and salary > 30000)
print(age > 30 or salary > 30000)
print(not(age > 30))
```

---

# 5. Bitwise Operators

Operate on binary numbers.

| Operator | Description |
|-----------|-------------|
| & | AND |
| \| | OR |
| ^ | XOR |
| ~ | NOT |
| << | Left Shift |
| >> | Right Shift |

### Example

```python
a = 5   # 0101
b = 3   # 0011

print(a & b)
print(a | b)
print(a ^ b)
print(a << 1)
print(a >> 1)
```

---

# 6. Membership Operators

Check whether a value exists in a sequence.

| Operator | Description |
|-----------|-------------|
| in | Present in sequence |
| not in | Not present in sequence |

### Example

```python
fruits = ["apple", "banana", "orange"]

print("apple" in fruits)
print("grape" not in fruits)
```

---

# 7. Identity Operators

Check whether two variables refer to the same object.

| Operator | Description |
|-----------|-------------|
| is | Same object |
| is not | Different object |

### Example

```python
a = [1, 2, 3]
b = a
c = [1, 2, 3]

print(a is b)
print(a is c)

print(a == c)
```

### Output

```text
True
False
True
```

> `is` compares memory locations, while `==` compares values.

---

# 8. Conditional (Ternary) Operator

Short form of if-else.

### Syntax

```python
value_if_true if condition else value_if_false
```

### Example

```python
age = 20

status = "Adult" if age >= 18 else "Minor"

print(status)
```

---

# Operator Precedence

Order in which Python evaluates operators.

| Priority | Operator |
|-----------|-----------|
| Highest | () |
| | ** |
| | +x, -x, ~x |
| | *, /, //, % |
| | +, - |
| | <<, >> |
| | & |
| | ^ |
| | \| |
| | ==, !=, >, <, >=, <= |
| | not |
| | and |
| Lowest | or |

### Example

```python
result = 10 + 2 * 5
print(result)
```

Output:

```text
20
```

Because multiplication is performed before addition.

---

# Quick Cheat Sheet

```text
Arithmetic : + - * / // % **
Comparison : == != > < >= <=
Assignment : = += -= *= /= //= %= **=
Logical    : and or not
Bitwise    : & | ^ ~ << >>
Membership : in, not in
Identity   : is, is not
Conditional: x if condition else y
```

---

# Practice Exercises

### Beginner

1. Add two numbers.
2. Find remainder using `%`.
3. Check if a number is greater than 100.
4. Use `and` to validate age and salary.
5. Check if a name exists in a list.

### Intermediate

1. Swap two numbers using assignment operators.
2. Find whether a number is even or odd using `%`.
3. Compare two lists using `==` and `is`.
4. Use a ternary operator to find the larger number.
5. Demonstrate all bitwise operators on two integers.

### Advanced

1. Build a calculator using arithmetic operators.
2. Create a login validation using logical operators.
3. Implement role-based access using membership operators.
4. Demonstrate operator precedence with complex expressions.
5. Explain the difference between `is`, `==`, and `id()`.
