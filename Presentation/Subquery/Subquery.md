# Deeply Nested Subqueries — Step-by-Step Approach

The best way to solve a **deeply nested subquery** is **not to start from the outside**.

Start with the **innermost question**, solve it, then move one level outward.

---

# 1. Understand the Query Structure

The query has **4 levels**:

```text
customers
    ↓
orders
    ↓
order_items
    ↓
products
```

The business question is:

> **Find customers who purchased at least one product whose price is greater than 5000.**

---

# 2. Step 1 — Translate the Business Question

Break the business question into smaller questions:

1. Which products cost more than 5000?
2. Which order items contain those products?
3. Which orders contain those order items?
4. Which customers placed those orders?

This gives us the nested-query structure.

```text
Products
   ↓
Order Items
   ↓
Orders
   ↓
Customers
```

---

# 3. Step 2 — Start From the Innermost Query

Ask:

> **Which products have a price greater than 5000?**

```sql
SELECT product_id
FROM products
WHERE price > 5000;
```

Suppose the result is:

| product_id |
|---:|
| 101 |
| 105 |
| 110 |

At this point, **do not worry about customers**.

Our only requirement is:

```text
product_id
```

---

# 4. Step 3 — Move One Level Outward

Now ask:

> **Which order items contain these products?**

```sql
SELECT oi.order_id
FROM order_items oi
WHERE oi.product_id IN (
    SELECT product_id
    FROM products
    WHERE price > 5000
);
```

Conceptually:

```text
products
    ↓
Products costing > 5000
    ↓
product_id
    ↓
order_items
    ↓
order_id
```

Suppose the result is:

| order_id |
|---:|
| 5001 |
| 5007 |
| 5012 |

Now we have:

```text
order_id
```

---

# 5. Step 4 — Move Another Level Outward

Now ask:

> **Which customers placed these orders?**

First identify the customers from the orders.

```sql
SELECT o.customer_id
FROM orders o
WHERE o.order_id IN (
    SELECT oi.order_id
    FROM order_items oi
    WHERE oi.product_id IN (
        SELECT product_id
        FROM products
        WHERE price > 5000
    )
);
```

Suppose the result is:

| customer_id |
|---:|
| 1 |
| 3 |
| 7 |

Now we have:

```text
customer_id
```

---

# 6. Step 5 — Finally Get Customer Details

Now we have the customer IDs.

Ask:

> **Give me the names of those customers.**

```sql
SELECT customer_id,
       name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    WHERE o.order_id IN (
        SELECT oi.order_id
        FROM order_items oi
        WHERE oi.product_id IN (
            SELECT product_id
            FROM products
            WHERE price > 5000
        )
    )
);
```

This is the **final nested subquery**.

---

# 7. The Important Mental Model

Whenever you see a nested query like this:

```sql
SELECT ...
FROM A
WHERE ... IN (
    SELECT ...
    FROM B
    WHERE ... IN (
        SELECT ...
        FROM C
        WHERE ... IN (
            SELECT ...
            FROM D
        )
    )
);
```

Don't try to understand everything at once.

Use:

```text
D → C → B → A
```

In this example:

```text
products
    ↓
order_items
    ↓
orders
    ↓
customers
```

Or in plain English:

```text
Which products?
       ↓
Which order items?
       ↓
Which orders?
       ↓
Which customers?
```

---

# 8. Step 6 — Build the Query Incrementally

This is the approach recommended when learning or teaching deeply nested SQL queries.

## Query 1 — Find the Products

```sql
SELECT product_id
FROM products
WHERE price > 5000;
```

### Question

> Which products cost more than 5000?

### Output Needed

```text
product_id
```

---

## Query 2 — Find the Order Items

Put Query 1 inside `order_items`.

```sql
SELECT order_id
FROM order_items
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE price > 5000
);
```

### Question

> Which order items contain products costing more than 5000?

### Output Needed

```text
order_id
```

---

## Query 3 — Find the Customers

Put Query 2 inside `orders`.

```sql
SELECT customer_id
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM order_items
    WHERE product_id IN (
        SELECT product_id
        FROM products
        WHERE price > 5000
    )
);
```

### Question

> Which customers placed orders containing products costing more than 5000?

### Output Needed

```text
customer_id
```

---

## Query 4 — Get Customer Details

Put Query 3 inside `customers`.

```sql
SELECT customer_id,
       name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM order_items
        WHERE product_id IN (
            SELECT product_id
            FROM products
            WHERE price > 5000
        )
    )
);
```

### Question

> Give me the details of customers who purchased products costing more than 5000.

### Final Output

```text
customer_id
name
```

---

# 9. The Most Useful Rule

When solving complex subqueries, ask yourself:

> **"What ID do I need from the next table?"**

For this example:

| Step | Question | Required Data |
|---:|---|---|
| 1 | Which products cost > 5000? | `product_id` |
| 2 | Which order items contain those products? | `order_id` |
| 3 | Which customers placed those orders? | `customer_id` |
| 4 | Which customer details should be displayed? | `customer_id`, `name` |

---

# 10. The ID Chain

The entire problem can be reduced to one simple chain:

```text
product_id
    ↓
order_id
    ↓
customer_id
    ↓
customer details
```

Or using the SmartMart tables:

```text
products
    │
    │ product_id
    ▼
order_items
    │
    │ order_id
    ▼
orders
    │
    │ customer_id
    ▼
customers
```

---

# 11. Think in Terms of Relationships

The database relationships are what make the nested query possible.

```text
PRODUCTS
   │
   │ product_id
   ▼
ORDER_ITEMS
   │
   │ order_id
   ▼
ORDERS
   │
   │ customer_id
   ▼
CUSTOMERS
```

The query travels through the relationship chain:

```text
What products?
      ↓
Which order items?
      ↓
Which orders?
      ↓
Which customers?
```

---

# 12. A Simple Formula for Nested Subqueries

Use this mental formula:

```text
BUSINESS QUESTION
       ↓
Break into smaller questions
       ↓
Find the innermost entity
       ↓
Get the ID required by the next table
       ↓
Move one level outward
       ↓
Repeat
       ↓
Reach the final table
       ↓
Select the required details
```

---

# 13. General Pattern

For a four-level nested query:

```sql
SELECT final_columns
FROM table_A
WHERE id_A IN (
    SELECT id_A
    FROM table_B
    WHERE id_B IN (
        SELECT id_B
        FROM table_C
        WHERE id_C IN (
            SELECT id_C
            FROM table_D
            WHERE condition
        )
    )
);
```

Think:

```text
table_D
   ↓
id_C
   ↓
table_C
   ↓
id_B
   ↓
table_B
   ↓
id_A
   ↓
table_A
```

---

# 14. Teaching / Learning Technique

For every nested subquery, write these four things before writing the final SQL:

```text
1. BUSINESS QUESTION
2. TABLE RELATIONSHIP
3. REQUIRED ID
4. NEXT TABLE
```

For this problem:

```text
Business Question:
Find customers who purchased products costing > 5000.

Table:
products

Condition:
price > 5000

Required ID:
product_id

Next Table:
order_items
```

Then:

```text
Table:
order_items

Condition:
product_id IN (...)

Required ID:
order_id

Next Table:
orders
```

Then:

```text
Table:
orders

Condition:
order_id IN (...)

Required ID:
customer_id

Next Table:
customers
```

Finally:

```text
Table:
customers

Required Output:
customer_id, name
```

---

# 15. Final Mental Model

```text
                    BUSINESS QUESTION
                           │
                           ▼
              "Who purchased expensive products?"
                           │
                           ▼
                PRODUCTS > 5000
                           │
                           │ product_id
                           ▼
                     ORDER_ITEMS
                           │
                           │ order_id
                           ▼
                       ORDERS
                           │
                           │ customer_id
                           ▼
                     CUSTOMERS
                           │
                           ▼
                  customer_id, name
```

---

# 16. Golden Rule

> ##  Don't solve a deeply nested query from the outside in.

Instead:

```text
START HERE
    ↓
INNERMOST QUERY
    ↓
GET REQUIRED ID
    ↓
MOVE OUTWARD
    ↓
GET NEXT REQUIRED ID
    ↓
MOVE OUTWARD
    ↓
REPEAT
    ↓
FINAL TABLE
```

### Remember

```text
D → C → B → A
```

For SmartMart:

```text
PRODUCTS
   ↓
ORDER_ITEMS
   ↓
ORDERS
   ↓
CUSTOMERS
```

The key technique is:

> **Identify the required ID at every level and pass that ID to the next outer query.**

That is the core technique for solving **deeply nested subqueries step by step**.
