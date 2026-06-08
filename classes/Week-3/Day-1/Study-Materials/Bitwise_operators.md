# Bitwise Operators in Python

Bitwise operators work directly on the binary (bit-level) representation of integers.

Computers store numbers as bits (`0` and `1`), and bitwise operators manipulate these bits.

---

## Why Learn Bitwise Operators?

They are commonly used in:

- System Programming
- Network Programming
- Cryptography
- Data Compression
- Performance Optimization
- Flags and Permissions
- Embedded Systems

---

# Understanding Binary Numbers

Before learning bitwise operators, let's convert numbers into binary.

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

### Example

```python
print(bin(5))
```

### Output

```text
0b101
```

---

# 1. Bitwise AND (&)

Returns `1` only when both bits are `1`.

## Truth Table

| A | B | A & B |
|---|---|--------|
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

### Binary Representation

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

### Real-World Example: Check Odd Number

```python
num = 7

if num & 1:
    print("Odd")
else:
    print("Even")
```

### Why?

```text
7 = 0111
1 = 0001
------------
    0001
```

Result is `1`, therefore the number is **Odd**.

---

# 2. Bitwise OR (|)

Returns `1` if at least one bit is `1`.

## Truth Table

| A | B | A \| B |
|---|---|---------|
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

### Binary Representation

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
|---|---|--------|
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

### Binary Representation

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

## XOR for Swapping Numbers

```python
a = 10
b = 20

a = a ^ b
b = a ^ b
a = a ^ b

print(a, b)
```

### Output

```text
20 10
```

---

# 4. Bitwise NOT (~)

Flips all bits.

## Example

```python
print(~5)
```

### Binary Representation

```text
5  = 00000101
~5 = 11111010
```

### Output

```text
-6
```

## Formula

```text
~n = -(n + 1)
```

### Examples

```python
print(~5)
print(~10)
```

### Output

```text
-6
-11
```

---

# 5. Left Shift (<<)

Moves bits to the left.

Every left shift multiplies the number by `2`.

## Example

```python
print(5 << 1)
```

### Binary Representation

```text
5 = 0101

Shift Left 1:

1010
```

### Output

```text
10
```

## Example 2

```python
print(5 << 2)
```

### Binary Representation

```text
0101
↓
10100
```

### Output

```text
20
```

## Formula

```text
n << k = n × (2^k)
```

### Examples

```python
5 << 1 = 10
5 << 2 = 20
5 << 3 = 40
```

---

# 6. Right Shift (>>)

Moves bits to the right.

Each right shift divides the number by `2`.

## Example

```python
print(20 >> 1)
```

### Binary Representation

```text
20 = 10100

Shift Right 1:

01010
```

### Output

```text
10
```

## Example 2

```python
print(20 >> 2)
```

### Output

```text
5
```

## Formula

```text
n >> k = n // (2^k)
```

### Examples

```python
20 >> 1 = 10
20 >> 2 = 5
20 >> 3 = 2
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

# Practical Example: User Permissions

Suppose:

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

### Output

```text
3
```

## Check Write Permission

```python
if permission & WRITE:
    print("Write Access Granted")
```

### Output

```text
Write Access Granted
```

---

# Interview Questions

## Q1. Difference Between `&` and `and`?

| & | and |
|---|------|
| Bitwise Operator | Logical Operator |
| Works on bits | Works on Boolean expressions |

### Example

```python
5 & 3
```

vs

```python
True and False
```

---

## Q2. How Do You Check if a Number is Odd?

```python
num & 1
```

---

## Q3. How Do You Multiply by 8 Using Bitwise Operators?

```python
num << 3
```

Because:

```text
2³ = 8
```

---

## Q4. How Do You Divide by 4 Using Bitwise Operators?

```python
num >> 2
```

Because:

```text
2² = 4
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

# Multiply by 2
5 << 1

# Multiply by 4
5 << 2

# Divide by 2
20 >> 1

# Divide by 4
20 >> 2

# Check Odd
num & 1

# Check Even
not(num & 1)
```

---

# Memory Trick

```text
&  -> Keep only common 1s
|  -> Keep all 1s
^  -> Keep different 1s
~  -> Flip bits
<< -> Multiply by powers of 2
>> -> Divide by powers of 2
```
