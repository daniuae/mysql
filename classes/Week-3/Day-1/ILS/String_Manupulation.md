# String Manipulation in Python

## Objective

Learn common string operations in Python:

* Reverse strings
* Capitalize words
* Count occurrences
* Replace text
* Find length
* Change case
* Check prefixes/suffixes

---

## 1. Reverse a String

```python
s = input("Enter a string: ")
print("Reversed:", s[::-1])
```

**Output**

```text
Enter a string: hello
Reversed: olleh
```

---

## 2. Capitalize Each Word

```python
s = input("Enter a sentence: ")
print("Capitalized:", s.title())
```

**Output**

```text
hello world
Capitalized: Hello World
```

---

## 3. Count Substring Occurrences

```python
text = "Hello, World! Hello, Python!"
print("Count:", text.count("Hello"))
```

**Output**

```text
Count: 2
```

---

## 4. Replace Substring

```python
text = "Hello, World! Hello, Python!"
print(text.replace("Hello", "Hi"))
```

**Output**

```text
Hi, World! Hi, Python!
```

---

## 5. Find String Length

```python
text = "Hello, Python!"
print("Length:", len(text))
```

**Output**

```text
Length: 14
```

---

## 6. Convert Case

```python
text = "Hello, Python!"
print("Upper:", text.upper())
print("Lower:", text.lower())
```

**Output**

```text
Upper: HELLO, PYTHON!
Lower: hello, python!
```

---

## 7. Check Start/End

```python
text = "Hello, Python!"

print(text.startswith("Hello"))
print(text.endswith("Python!"))
```

**Output**

```text
True
True
```

---

## Quick Reference

| Function       | Purpose           |
| -------------- | ----------------- |
| `[::-1]`       | Reverse string    |
| `title()`      | Capitalize words  |
| `count()`      | Count occurrences |
| `replace()`    | Replace text      |
| `len()`        | String length     |
| `upper()`      | Uppercase         |
| `lower()`      | Lowercase         |
| `startswith()` | Check prefix      |
| `endswith()`   | Check suffix      |

## Learning Outcomes

✔ Reverse strings using slicing
✔ Capitalize words with `title()`
✔ Count text using `count()`
✔ Replace text using `replace()`
✔ Find length with `len()`
✔ Convert case using `upper()` / `lower()`
✔ Validate prefixes and suffixes
