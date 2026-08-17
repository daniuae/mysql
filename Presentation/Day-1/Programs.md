# Assignment: Two-Number Calculator

## Goal

Write a program that:

1. Reads two numbers from the user.
2. Calculates their sum.
3. Checks whether the sum is greater than `100`.
4. Displays whether the result is large or small.
5. Displays the final sum.

---

# Python Program

```python
# Two-Number Calculator

# Step 1: Get input
numA = float(input("Enter first number: "))
numB = float(input("Enter second number: "))

# Step 2: Calculate sum
sumResult = numA + numB

# Step 3: Check the result
if sumResult > 100:
    print("Result is a large number.")
else:
    print("Result is a small number.")

# Step 4: Display final result
print("Final Sum =", sumResult)
```

## Python — Sample Output

```text
Enter first number: 40
Enter second number: 75
Result is a large number.
Final Sum = 115.0
```

---

# Java Program

```java
import java.util.Scanner;

public class TwoNumberCalculator {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        // Step 1: Get input
        System.out.print("Enter first number: ");
        double numA = scanner.nextDouble();

        System.out.print("Enter second number: ");
        double numB = scanner.nextDouble();

        // Step 2: Calculate sum
        double sumResult = numA + numB;

        // Step 3: Check the result
        if (sumResult > 100) {
            System.out.println("Result is a large number.");
        } else {
            System.out.println("Result is a small number.");
        }

        // Step 4: Display final result
        System.out.println("Final Sum = " + sumResult);

        scanner.close();
    }
}
```

## Java — Sample Output

```text
Enter first number: 40
Enter second number: 75
Result is a large number.
Final Sum = 115.0
```

---

# Python vs Java

| Concept              | Python                | Java                   |
| -------------------- | --------------------- | ---------------------- |
| Variable             | `numA = 40`           | `double numA = 40;`    |
| Input                | `input()`             | `Scanner`              |
| Addition             | `numA + numB`         | `numA + numB`          |
| Condition            | `if sumResult > 100:` | `if (sumResult > 100)` |
| Else                 | `else:`               | `else {}`              |
| Output               | `print()`             | `System.out.println()` |
| Data Type            | Dynamically inferred  | Explicitly declared    |
| Statement Terminator | Not required          | `;`                    |
| Code Block           | Indentation           | `{ }`                  |
| Program Entry Point  | Not mandatory         | `main()` method        |

---

# Test Cases

## Test Case 1

### Input

```text
40
75
```

### Expected Output

```text
Result is a large number.
Final Sum = 115.0
```

---

## Test Case 2

### Input

```text
20
30
```

### Expected Output

```text
Result is a small number.
Final Sum = 50.0
```

---

## Test Case 3

### Input

```text
100
0
```

### Expected Output

```text
Result is a small number.
Final Sum = 100.0
```

The condition is:

```text
sumResult > 100
```

Therefore, exactly `100` is considered a small result according to the given requirement.

---

# Programming Concepts Demonstrated

* Variables
* Numeric data types
* User input
* Arithmetic operators
* Assignment
* `if / else`
* Comparison operator `>`
* Output
* Python syntax
* Java syntax
* Difference between dynamically typed and statically typed languages
