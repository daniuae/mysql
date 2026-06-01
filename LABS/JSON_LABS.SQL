-- Create a table to store JSON:

-- CREATE TABLE CustomerData (
--     Id INT IDENTITY PRIMARY KEY,
--     CustomerInfo NVARCHAR (MAX)
-- );
CREATE TABLE CustomerData (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    CustomerInfo LONGTEXT
);

-- Insert JSON data:

INSERT INTO
    CustomerData (CustomerInfo)
VALUES (
        '{"Name":"John Doe","City":"New York","Orders":[1001,1002,1003]}'
    );

-- Insert another record:

INSERT INTO
    CustomerData (CustomerInfo)
VALUES (
        '{"Name":"Jane Smith","City":"London","Orders":[2001,2002]}'
    );

-- Retrieve raw JSON:

SELECT * FROM CustomerData;

-- Extract name and city:

SELECT JSON_VALUE(CustomerInfo, '$.Name') AS CustomerName, JSON_VALUE(CustomerInfo, '$.City') AS City
FROM CustomerData;

-- Retrieve order arrays:

-- SELECT JSON_QUERY (CustomerInfo, '$.Orders') AS OrdersList
-- FROM CustomerData;

SELECT JSON_EXTRACT(CustomerInfo, '$.Orders') AS OrdersList
FROM CustomerData;

SELECT VERSION();

-- Use OPENJSON to parse nested array:

-- SELECT Id, value AS OrderId
-- FROM CustomerData CROSS APPLY OPENJSON (
--         JSON_QUERY (CustomerInfo, '$.Orders')
--     );

-- MySQL 8.0 Solution

-- Use JSON_TABLE():

SELECT c.Id, jt.OrderId
FROM CustomerData c, JSON_TABLE(
        c.CustomerInfo, '$.Orders[*]' COLUMNS (OrderId INT PATH '$')
    ) jt;

SELECT c.Id, jt.OrderId
FROM CustomerData c, JSON_TABLE(
        c.CustomerInfo, '$.Orders[*]' COLUMNS (OrderId INT PATH '$')
    ) jt;

-- Insert additional nested attributes (e.g., country):

INSERT INTO
    CustomerData (CustomerInfo)
VALUES (
        '{"Name":"Carlos","City":"Madrid","Country":"Spain","Orders":[3001,3002]}'
    );

-- [OPTIONAL] Filter using JSON values:

SELECT *
FROM CustomerData
WHERE
    JSON_VALUE(CustomerInfo, '$.City') = 'London';

-- Update a JSON field:

-- UPDATE CustomerData
-- SET
--     CustomerInfo = JSON_MODIFY (
--         CustomerInfo,
--         '$.City',
--         'Berlin'
--     )
-- WHERE
--     JSON_VALUE(CustomerInfo, '$.Name') = 'John Doe';

UPDATE CustomerData
SET
    CustomerInfo = JSON_SET(
        CustomerInfo,
        '$.City',
        'Berlin'
    )
WHERE
    CustomerInfo ->> '$.Name' = 'John Doe';
-- Validate JSON syntax:

-- SELECT ISJSON (CustomerInfo) AS IsValid FROM CustomerData;

SELECT JSON_VALID(CustomerInfo) AS IsValid FROM CustomerData;
-- Expected Outcome:

-- You can now store, query, and transform semi-structured JSON efficiently in SQL Server.
