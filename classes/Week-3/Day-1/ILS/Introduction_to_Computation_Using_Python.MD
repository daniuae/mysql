# Introduction to Computation Using Python

## Lab Objective

This lab introduces the fundamentals of computation and guides learners through creating a simple Python program.

### By the end of this lab, learners will be able to:

- Understand what computation is and why it is important.
- Use Python to accept user input.
- Perform a basic mathematical calculation.
- Display output to the user.

---

# Introduction: What is Computation?

**Computation** is the process of using step-by-step instructions (**algorithms**) to perform calculations and solve problems.

It is a foundational concept in programming and allows us to create efficient and effective solutions.

In this lab, you will apply computation principles to write a Python program that calculates the area of a rectangle.

---

# Case Description

You are required to write a Python program that:

1. Accepts the length and width of a rectangle from the user.
2. Calculates the area using the formula:

```text
area = length * width
```

3. Displays the result to the user.

---

# Steps of Computation

## 1. Define Variables

Create variables to store the length and width.

## 2. Input

Use the `input()` function to receive input from the user.

## 3. Convert to Float

Convert the input values to `float` to allow decimal values.

## 4. Calculate Area

Use the formula:

```python
area = length * width
```

## 5. Output

Display the result to the user.

---

# Lab Instructions

## Step 1: Open Visual Studio Code

1. Launch Visual Studio Code.
2. Create a new folder named:

```text
pythonlabs
```

3. Open the folder in Visual Studio Code:

```text
File → Open Folder → Select pythonlabs
```

---

## Step 2: Create a Python File

Inside the `pythonlabs` folder:

1. Create a new file.
2. Name the file:

```text
computation.py
```

---

## Step 3: Add the Program Code

Enter the following code into the `computation.py` file:

```python
# Define Variables
length = 0.0
width = 0.0

# Input
length = float(input("Enter the length of the rectangle: "))
width = float(input("Enter the width of the rectangle: "))

# Calculate Area
area = length * width

# Output
print(f"The area of the rectangle is: {area}")
```

Save the file.

---

## Step 4: Run the Program

### Option 1: Using the Run Button in VS Code

1. Open the file `computation.py`.
2. Click the **Run** button in Visual Studio Code.

---

### Option 2: Using the Terminal

Open the terminal:

```text
View → Terminal
```

Run the program using:

```bash
python computation.py
```

---

# Expected Output

When the program runs, it prompts the user to enter the rectangle dimensions.

### Example

```text
Enter the length of the rectangle: 5.5
Enter the width of the rectangle: 3.25
The area of the rectangle is: 17.875
```

---

# Program Flow Diagram

```text
Start
  │
  ▼
Input Length
  │
  ▼
Input Width
  │
  ▼
Calculate Area
(Length × Width)
  │
  ▼
Display Area
  │
  ▼
 End
```

---

# Key Concepts Learned

| Concept | Description |
|----------|-------------|
| Variable | Stores data in memory |
| Input | Receives data from the user |
| Float | Supports decimal numbers |
| Computation | Performs calculations |
| Output | Displays results to the user |

---

# Lab Summary

In this lab, you:

✅ Accepted user input using `input()`

✅ Converted values to `float`

✅ Performed a mathematical computation

✅ Displayed the result using `print()`

You have successfully created and executed a basic Python program that demonstrates **Input → Computation → Output**.

---

# End of Lab

Congratulations! 🎉

You have completed your first computation-based Python program.
This forms the foundation for more advanced programming concepts such as decision-making, loops, functions, and object-oriented programming.
