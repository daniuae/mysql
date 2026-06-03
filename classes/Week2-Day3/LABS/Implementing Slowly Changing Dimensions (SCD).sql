Implementing Slowly Changing Dimensions (SCD)

Objective
Understand how historical changes are tracked in dimension data (SCD Type 1, 2, and 3).
Scenario
A customer moves from Delhi → Mumbai and we must reflect it in our dimensional table depending on SCD strategy.
Step-by-Step
Step 1: Create Customer Dimension for SCD Testing
CREATE TABLE DimCustomer_SCD (
  CustomerKey INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  CustomerName VARCHAR(100),
  City VARCHAR(50),
  StartDate DATE,
  EndDate DATE,
  CurrentFlag CHAR(1)
);


Step 2: Insert Initial Record
INSERT INTO DimCustomer_SCD
(CustomerID, CustomerName, City, StartDate, EndDate, CurrentFlag)
VALUES (101,'John','Delhi','2022-01-01',NULL,'Y');

Explanation:
Represents the current active record for the customer.

Step 3: Apply SCD Type 1 (Overwrite Change)
UPDATE DimCustomer_SCD
SET City='Mumbai'
WHERE CustomerID=101;

Result:
City is updated — no historical record retained.
Use for non-critical fields.
Step 4: Apply SCD Type 2 (New Row with History)
UPDATE DimCustomer_SCD
SET EndDate='2023-03-01', CurrentFlag='N'
WHERE CustomerID=101 AND CurrentFlag='Y';

INSERT INTO DimCustomer_SCD
(CustomerID, CustomerName, City, StartDate, EndDate, CurrentFlag)
VALUES (101,'John','Mumbai','2023-03-02',NULL,'Y');

Explanation:
Keeps both old and new records — allowing time-based analysis.

Step 5: Apply SCD Type 3 (Track Previous Value)
ALTER TABLE DimCustomer_SCD ADD COLUMN PrevCity VARCHAR(50);

UPDATE DimCustomer_SCD
SET PrevCity='Delhi', City='Bangalore'
WHERE CustomerID=101 AND CurrentFlag='Y';

Explanation:
Only tracks the last change. Partial history only.

Step 6: Validate Historical Changes
SELECT * FROM DimCustomer_SCD ORDER BY CustomerKey;

