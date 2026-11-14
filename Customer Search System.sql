/*
Project: Banking Management Database

Description:
Performs customer searches, banking data analysis,
and summary reporting using SQL queries and built-in functions.

Key Operations:
- Searching records using LIKE patterns
- Filtering records using IN conditions
- Sorting records using ORDER BY
- Limiting results using LIMIT and OFFSET
- Combining filtering, sorting and result limits
- Formatting customer data using string functions
- Performing calculations using math functions
- Analyzing dates using date and time functions
- Comparing values using comparison functions
- Calculating banking metrics using aggregate functions
- Summarizing account performance using GROUP BY
- Identifying high-performing categories using HAVING
*/

-- Select the banking database
USE BankingDB;

-- --------------------------------------------------
-- Search Records Using LIKE Patterns
-- --------------------------------------------------

-- Find customers whose first name starts with A
SELECT * FROM Customers
WHERE FirstName LIKE 'A%';

-- Find customers whose email contains gmail
SELECT * FROM Customers
WHERE Email LIKE '%gmail%';

-- Find customers whose last name ends with kar
SELECT * FROM Customers
WHERE LastName LIKE '%kar';

-- Find customers whose first name starts with R
SELECT * FROM Customers
WHERE FirstName LIKE 'R%';

-- Find customers whose email contains yahoo
SELECT * FROM Customers
WHERE Email LIKE '%yahoo%';

-- Find customers whose last name starts with P
SELECT * FROM Customers
WHERE LastName LIKE 'P%';

-- Find customers whose phone number ends with 99
SELECT * FROM Customers
WHERE Phone LIKE '%99';

-- --------------------------------------------------
-- Filter Records Using IN Conditions
-- --------------------------------------------------

-- Retrieve savings and current accounts
SELECT * FROM Accounts
WHERE AccountType IN ('Savings', 'Current');

-- Retrieve deposit and withdrawal transactions
SELECT * FROM Transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal');

-- Retrieve customers with specified IDs
SELECT * FROM Customers
WHERE CustomerID IN (101, 102, 105);

-- Retrieve salary and savings accounts
SELECT * FROM Accounts
WHERE AccountType IN ('Salary', 'Savings');

-- Retrieve payment and deposit transactions
SELECT * FROM Transactions
WHERE TransactionType IN ('Payment', 'Deposit');

-- Retrieve customers with IDs 103 and 104
SELECT * FROM Customers
WHERE CustomerID IN (103, 104);

-- Retrieve accounts with specified account IDs
SELECT * FROM Accounts
WHERE AccountID IN (201, 203, 204);

-- --------------------------------------------------
-- Sort Records Using ORDER BY
-- --------------------------------------------------

-- Sort customers by last name in ascending order
SELECT * FROM Customers
ORDER BY LastName ASC;

-- Sort accounts by balance in descending order
SELECT * FROM Accounts
ORDER BY Balance DESC;

-- Sort transactions by transaction date in descending order
SELECT * FROM Transactions
ORDER BY TransactionDate DESC;

-- Sort customers by first name
SELECT * FROM Customers
ORDER BY FirstName ASC;

-- Sort accounts alphabetically by account type
SELECT * FROM Accounts
ORDER BY AccountType ASC;

-- Sort transactions by amount from highest to lowest
SELECT * FROM Transactions
ORDER BY Amount DESC;

-- Sort customers by date of birth
SELECT * FROM Customers
ORDER BY DateOfBirth ASC;

-- --------------------------------------------------
-- Retrieve Limited Records Using LIMIT and OFFSET
-- --------------------------------------------------

-- Retrieve the five accounts with the highest balances
SELECT * FROM Accounts
ORDER BY Balance DESC
LIMIT 5;

-- Retrieve the first three customers
SELECT * FROM Customers
LIMIT 3;

-- Skip the first three transactions and retrieve the next five
SELECT * FROM Transactions
ORDER BY TransactionID
LIMIT 5 OFFSET 3;

-- Retrieve the three transactions with the highest amounts
SELECT * FROM Transactions
ORDER BY Amount DESC
LIMIT 3;

-- Retrieve four customer records
SELECT * FROM Customers
LIMIT 4;

-- Skip the first two accounts and retrieve the next three
SELECT * FROM Accounts
ORDER BY AccountID
LIMIT 3 OFFSET 2;

-- Retrieve the five latest transactions
SELECT * FROM Transactions
ORDER BY TransactionDate DESC
LIMIT 5;

-- --------------------------------------------------
-- Combine Filtering, Sorting and Result Limits
-- --------------------------------------------------

-- Retrieve savings accounts sorted by balance in descending order
SELECT * FROM Accounts
WHERE AccountType = 'Savings'
ORDER BY Balance DESC;

-- Retrieve customers whose first name starts with S, limited to five records
SELECT * FROM Customers
WHERE FirstName LIKE 'S%'
LIMIT 5;

-- Retrieve deposit and withdrawal transactions sorted by date
SELECT * FROM Transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal')
ORDER BY TransactionDate DESC;

-- --------------------------------------------------
-- String Functions
-- --------------------------------------------------

-- Display all customer records
SELECT * FROM Customers;

-- Display customer first names in uppercase
SELECT
    FirstName,
    UPPER(FirstName) AS UpperCaseName
FROM Customers;

-- Display customer first names in lowercase
SELECT
    FirstName,
    LOWER(FirstName) AS LowerCaseName
FROM Customers;

-- Calculate the number of characters in each first name
SELECT
    FirstName,
    LENGTH(FirstName) AS NameLength
FROM Customers;

-- Display the first three characters of each first name
SELECT
    FirstName,
    LEFT(FirstName, 3) AS FirstThreeCharacters
FROM Customers;

-- Combine customer first name and last name
SELECT
    CONCAT(FirstName, ' - ', LastName) AS FullName
FROM Customers;

-- --------------------------------------------------
-- Math Functions
-- --------------------------------------------------

-- Round a decimal number to the nearest whole number
SELECT ROUND(1256.75) AS Rounded_Value;

-- Return the smallest integer greater than or equal to a number
SELECT CEIL(1256.25) AS Ceiling_Value;

-- Return the largest integer less than or equal to a number
SELECT FLOOR(1256.75) AS Floor_Value;

-- Return the absolute value of a number
SELECT ABS(-2500) AS Absolute_Value;

-- Calculate the remainder after division
SELECT MOD(25, 4) AS Remainder;

-- --------------------------------------------------
-- Date and Time Functions
-- --------------------------------------------------

-- Display all customer records
SELECT * FROM Customers;

-- Display the current system date
SELECT CURDATE() AS CurrentDate;

-- Display the current system date and time
SELECT NOW() AS CurrentDateTime;

-- Extract the birth year of each customer
SELECT
    CustomerID,
    YEAR(DateOfBirth) AS BirthYear
FROM Customers;

-- Extract the birth month of each customer
SELECT
    CustomerID,
    MONTH(DateOfBirth) AS BirthMonth
FROM Customers;

-- Calculate the number of days since each customer's birth
SELECT
    CustomerID,
    DATEDIFF(CURDATE(), DateOfBirth) AS Days
FROM Customers;

-- --------------------------------------------------
-- Comparison Functions
-- --------------------------------------------------

-- Categorize customers based on their birth year
SELECT
    FirstName,
    DateOfBirth,
    IF(YEAR(DateOfBirth) <= 1995,
       'Adult',
       'Young') AS Category
FROM Customers;

-- Display Not Available when a phone number is NULL
SELECT
    FirstName,
    IFNULL(Phone, 'Not Available') AS PhoneNumber
FROM Customers;

-- Find the latest birth date among the given dates
SELECT GREATEST(
    '2000-09-20',
    '1995-06-18',
    '1997-09-12',
    '1993-11-25'
) AS LatestBirthDate;

-- Find the earliest birth date among the given dates
SELECT LEAST(
    '2000-09-20',
    '1995-06-18',
    '1997-09-12',
    '1993-11-25'
) AS EarliestBirthDate;

-- Compare customer first names with Priya
SELECT
    FirstName,
    NULLIF(FirstName, 'Priya') AS Result
FROM Customers;

-- --------------------------------------------------
-- Aggregate Functions: Overall Banking Performance
-- --------------------------------------------------

-- Calculate the total balance across all accounts
SELECT SUM(Balance) AS total_balance
FROM Accounts;

-- Calculate the average account balance
SELECT AVG(Balance) AS average_balance
FROM Accounts;

-- Find the highest account balance
SELECT MAX(Balance) AS highest_balance
FROM Accounts;

-- Find the lowest account balance
SELECT MIN(Balance) AS lowest_balance
FROM Accounts;

-- Count the total number of accounts
SELECT COUNT(*) AS total_accounts
FROM Accounts;

-- --------------------------------------------------
-- GROUP BY: Account-wise Performance
-- --------------------------------------------------

-- Calculate the total balance for each account type
SELECT
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType;

-- --------------------------------------------------
-- HAVING: Identify High-Performing Account Categories
-- --------------------------------------------------

-- Display account types with total balances exceeding 25000
SELECT
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 25000;
