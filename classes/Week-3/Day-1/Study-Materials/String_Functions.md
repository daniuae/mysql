# Appending a String to Another String in a `for` Loop

In Python, strings can be concatenated (appended) using the `+` or `+=` operator inside a `for` loop.

---

## Example 1: Build a Sentence

### Code

```python
result = ""

words = ["Python", "is", "easy", "to", "learn"]

for word in words:
    result += word + " "

print(result)
```

### Output

```text
Python is easy to learn
```

### Explanation

- Start with an empty string.
- Loop through each word in the list.
- Append the word and a space (`" "`) to `result`.
- Print the final string.

---

## Example 2: Append Characters One by One

### Code

```python
name = "Dani"
new_string = ""

for ch in name:
    new_string += ch + "-"

print(new_string)
```

### Output

```text
D-a-n-i-
```

### Explanation

- The loop iterates through each character of the string.
- Each character is appended along with a hyphen (`-`).

---

## Example 3: Create a Star Pattern

### Code

```python
stars = ""

for i in range(5):
    stars += "*"
    print(stars)
```

### Output

```text
*
**
***
****
*****
```

### Explanation

- A star (`*`) is appended during each iteration.
- The growing string is printed after every append operation.

---

## Example 4: Concatenate Numbers as a String

### Code

```python
numbers = ""

for i in range(1, 6):
    numbers += str(i)

print(numbers)
```

### Output

```text
12345
```

### Explanation

- Numbers must be converted to strings using `str()`.
- Each number is appended to the existing string.

---

## How `+=` Works

### Code

```python
result += text
```

is equivalent to:

```python
result = result + text
```

### Example

```python
result = "Hello"

for i in range(3):
    result += "!"

print(result)
```

### Output

```text
Hello!!!
```

---

# Real-World Example (ETL / Data Engineering)

## Dynamically Generate a SQL Query

### Code

```python
columns = ["emp_id", "emp_name", "salary"]

select_query = "SELECT "

for col in columns:
    select_query += col + ", "

# Remove the last comma and space
select_query = select_query[:-2]

print(select_query)
```

### Output

```sql
SELECT emp_id, emp_name, salary
```

### Explanation

This technique is commonly used for:

- Dynamic SQL generation
- Building log messages
- Creating reports
- Generating file names
- ETL and ELT pipelines

---

# Key Takeaways

| Operator | Purpose |
|-----------|---------|
| `+` | Concatenate two strings |
| `+=` | Append a string to an existing string |
| `str()` | Convert non-string values to strings before appending |

### General Syntax

```python
result = ""

for item in iterable:
    result += item
```

This pattern is one of the most commonly used approaches for building strings dynamically in Python.
