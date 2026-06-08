# Bitwise Operators in Python

Bitwise operators work directly on the binary representation (bits) of integers.

---

# Binary Basics

| Decimal | Binary |
|----------|---------|
| 1 | 0001 |
| 2 | 0010 |
| 3 | 0011 |
| 4 | 0100 |
| 5 | 0101 |
| 6 | 0110 |
| 7 | 0111 |
| 8 | 1000 |

```python
print(bin(5))
# Output: 0b101
```

---

# 1. Bitwise AND (&)

Returns `1` only when both bits are `1`.

## Truth Table

| A | B | A & B |
|---|---|-------|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

## Example

```python
a = 5
b = 3

print(a & b)
```

### Binary Calculation

```text
5 = 0101
3 = 0011
------------
& = 0001
```

### Output

```text
1
```

### Practical Example: Check Odd Number

```python
num = 7

if num & 1:
    print("Odd")
else:
    print("Even")
```

---

# 2. Bitwise OR (|)

Returns `1` if at least one bit is `1`.

## Truth Table

| A | B | A \| B |
|---|---|--------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

## Example

```python
a = 5
b = 3

print(a | b)
```

### Binary Calculation

```text
5 = 0101
3 = 0011
------------
| = 0111
```

### Output

```text
7
```

---

# 3. Bitwise XOR (^)

Returns `1` when bits are different.

## Truth Table

| A | B | A ^ B |
|---|---|-------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

## Example

```python
a = 5
b = 3

print(a ^ b)
```

### Binary Calculation

```text
5 = 0101
3 = 0011
------------
^ = 0110
```

### Output

```text
6
```

### Swapping Numbers Using XOR

```python
a = 10
b = 20

a = a ^ b
b = a ^ b
a = a ^ b

print(a, b)
```

Output:

```text
20 10
```

---

# 4. Bitwise NOT (~)

Flips all bits.

## Syntax

```python
print(~5)
```

### Binary

```text
5  = 00000101
~5 = 11111010
```

### Output

```text
-6
```

### Formula

```text
~n = -(n + 1)
```

Examples:

```python
print(~5)   # -6
print(~10)  # -11
```

---

# 5. Left Shift (<<)

Moves bits to the left.

Each shift left multiplies by 2.

## Example

```python
print(5 << 1)
```

### Binary

```text
0101
↓
1010
```

### Output

```text
10
```

## Formula

```text
n << k = n * (2^k)
```

Examples:

```python
print(5 << 1)  # 10
print(5 << 2)  # 20
print(5 << 3)  # 40
```

---

# 6. Right Shift (>>)

Moves bits to the right.

Each shift right divides by 2.

## Example

```python
print(20 >> 1)
```

### Binary

```text
10100
↓
01010
```

### Output

```text
10
```

## Formula

```text
n >> k = n // (2^k)
```

Examples:

```python
print(20 >> 1)  # 10
print(20 >> 2)  # 5
print(20 >> 3)  # 2
```

---

# Summary Table

| Operator | Name | Example | Result |
|-----------|--------|----------|--------|
| & | AND | 5 & 3 | 1 |
| \| | OR | 5 \| 3 | 7 |
| ^ | XOR | 5 ^ 3 | 6 |
| ~ | NOT | ~5 | -6 |
| << | Left Shift | 5 << 1 | 10 |
| >> | Right Shift | 20 >> 2 | 5 |

---

# Visual Comparison

```text
a = 5 = 0101
b = 3 = 0011

AND (&)
0101
0011
----
0001 = 1

OR (|)
0101
0011
----
0111 = 7

XOR (^)
0101
0011
----
0110 = 6
```

---

# Real-World Example: User Permissions

```text
READ    = 1  (001)
WRITE   = 2  (010)
EXECUTE = 4  (100)
```

## Assign Permissions

```python
READ = 1
WRITE = 2
EXECUTE = 4

permission = READ | WRITE

print(permission)
```

Output:

```text
3
```

## Check Permission

```python
if permission & WRITE:
    print("Write Access Granted")
```

Output:

```text
Write Access Granted
```

---

# Difference Between & and and

| & | and |
|---|------|
| Bitwise Operator | Logical Operator |
| Works on bits | Works on boolean values |

```python
print(5 & 3)      # 1
print(True and False)  # False
```

---

# Common Interview Questions

## Check Odd Number

```python
num = 7

if num & 1:
    print("Odd")
```

## Check Even Number

```python
if num & 1 == 0:
    print("Even")
```

## Multiply by 8

```python
num << 3
```

## Divide by 4

```python
num >> 2
```

---

# Cheat Sheet

```python
# AND
5 & 3

# OR
5 | 3

# XOR
5 ^ 3

# NOT
~5

# Left Shift
5 << 1

# Right Shift
20 >> 2

# Odd Check
num & 1

# Even Check
(num & 1) == 0
```

## Memory Trick

```text
&  -> Common 1s
|  -> All 1s
^  -> Different 1s
~  -> Flip bits
<< -> Multiply by 2
>> -> Divide by 2
```
