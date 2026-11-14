/*
Project: Banking Management Database

Description:
Manages banking records and retrieves meaningful
information using SQL queries.

Key Operations:
- Inserting, updating and deleting records
- Retrieving and filtering banking information
- Sorting and limiting query results
- Checking NULL values
- Categorizing records using CASE statements
- Analyzing data using window functions
*/

-- Select the banking database
USE BankingDB;

-- Check existing banking records
SELECT * FROM Customers;
SELECT * FROM Branches;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;

-- Insert customer records
INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(101, 'Rahul', 'Sharma', 'rahul@gmail.com', '9876543210', '1998-04-15'),
(102, 'Priya', 'Verma', 'priya@gmail.com', '9876543211', '1999-06-20'),
(103, 'Amit', 'Kumar', 'amit@gmail.com', '9876543212', '1997-08-10'),
(104, 'Neha', 'Singh', 'neha@gmail.com', '9876543213', '2000-02-25');

-- Insert branch records
INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Lucknow Main Branch', 'Hazratganj, Lucknow', '5224001001'),
(2, 'Delhi Branch', 'Connaught Place, Delhi', '1124001002'),
(3, 'Mumbai Branch', 'Andheri, Mumbai', '2224001003'),
(4, 'Pune Branch', 'Shivaji Nagar, Pune', '2024001004'),
(5, 'Jaipur Branch', 'MI Road, Jaipur', '1414001005');

-- Insert account records
INSERT INTO Accounts
(AccountID, CustomerID, BranchID, AccountType, Balance)
VALUES
(201, 101, 1, 'Savings', 25000),
(202, 102, 2, 'Current', 35000),
(203, 103, 3, 'Savings', 18000),
(204, 104, 4, 'Current', 42000);

-- Insert transaction records
INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2026-11-01', 5000, 'Deposit'),
(302, 202, '2026-11-02', 3000, 'Withdrawal'),
(303, 203, '2026-11-03', 7000, 'Deposit'),
(304, 204, '2026-11-04', 2000, 'Withdrawal'),
(305, 201, '2026-11-05', 1500, 'Deposit');

-- Insert loan records
INSERT INTO Loans
(LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES
(401, 101, 200000, 8.50, '2026-01-01', '2031-01-01'),
(402, 102, 350000, 9.00, '2026-02-01', '2032-02-01'),
(403, 103, 150000, 8.75, '2026-03-01', '2031-03-01'),
(404, 104, 500000, 9.25, '2026-04-01', '2033-04-01'),
(405, 101, 100000, 8.00, '2026-05-01', '2030-05-01');

-- Update customer phone number
UPDATE Customers
SET Phone = '9999999999'
WHERE CustomerID = 101;

-- Update customer email address
UPDATE Customers
SET Email = 'rahul.sharma@gmail.com'
WHERE CustomerID = 101;

-- Update account balance
UPDATE Accounts
SET Balance = 30000
WHERE AccountID = 201;

-- Verify updated customer details
SELECT * FROM Customers
WHERE CustomerID = 101;

-- Verify updated account balance
SELECT * FROM Accounts
WHERE AccountID = 201;

-- Delete a transaction record
DELETE FROM Transactions
WHERE TransactionID = 302;

-- Delete an account record
DELETE FROM Accounts
WHERE AccountID = 202;

-- Verify remaining transactions
SELECT * FROM Transactions;

-- Verify remaining accounts
SELECT * FROM Accounts;

-- Retrieve complete customer records
SELECT * FROM Customers;

-- Retrieve selected customer details
SELECT FirstName, LastName, Email, Phone
FROM Customers;

-- Retrieve account details
SELECT AccountID, AccountType, Balance
FROM Accounts;

-- Filter savings accounts
SELECT * FROM Accounts
WHERE AccountType = 'Savings';

-- Find accounts with balances above 25000
SELECT * FROM Accounts
WHERE Balance > 25000;

-- Find transactions between 5000 and 20000
SELECT * FROM Transactions
WHERE Amount BETWEEN 5000 AND 20000;

-- Retrieve customers with specified IDs
SELECT * FROM Customers
WHERE CustomerID IN (101, 102, 103);

-- Find customers whose first name starts with R
SELECT * FROM Customers
WHERE FirstName LIKE 'R%';

-- Retrieve current accounts
SELECT * FROM Accounts
WHERE AccountType = 'Current';

-- Find accounts with balances below 15000
SELECT * FROM Accounts
WHERE Balance < 15000;

-- Find transactions between 1000 and 10000
SELECT * FROM Transactions
WHERE Amount BETWEEN 1000 AND 10000;

-- Retrieve customers with IDs 104 and 105
SELECT * FROM Customers
WHERE CustomerID IN (104, 105);

-- Find customers whose last name starts with S
SELECT * FROM Customers
WHERE LastName LIKE 'S%';

-- Sort customers alphabetically by first name
SELECT * FROM Customers
ORDER BY FirstName ASC;

-- Sort accounts by balance from highest to lowest
SELECT * FROM Accounts
ORDER BY Balance DESC;

-- Display unique account types
SELECT DISTINCT AccountType
FROM Accounts;

-- Retrieve the three accounts with the highest balances
SELECT * FROM Accounts
ORDER BY Balance DESC
LIMIT 3;

-- Skip the first two transactions and retrieve the next five
SELECT * FROM Transactions
LIMIT 5 OFFSET 2;

-- Sort customers alphabetically by last name
SELECT * FROM Customers
ORDER BY LastName ASC;

-- Retrieve the five highest-value transactions
SELECT * FROM Transactions
ORDER BY Amount DESC
LIMIT 5;

-- Display unique transaction types
SELECT DISTINCT TransactionType
FROM Transactions;

-- Skip the first three transactions and retrieve the next four
SELECT * FROM Transactions
ORDER BY TransactionID
LIMIT 4 OFFSET 3;

-- Find customers with missing phone numbers
SELECT * FROM Customers
WHERE Phone IS NULL;

-- Find customers with available email addresses
SELECT * FROM Customers
WHERE Email IS NOT NULL;

-- Find customers with missing email addresses
SELECT * FROM Customers
WHERE Email IS NULL;

-- Find accounts with a recorded balance
SELECT * FROM Accounts
WHERE Balance IS NOT NULL;

-- Categorize accounts based on their balance
SELECT
    AccountID,
    AccountType,
    Balance,
    CASE
        WHEN Balance >= 50000 THEN 'Premium'
        WHEN Balance >= 25000 THEN 'Standard'
        ELSE 'Basic'
    END AS AccountCategory
FROM Accounts;

-- Categorize transactions based on their amount
-- High: 5000 or above | Medium: 2000–4999.99 | Low: below 2000
SELECT
    TransactionID,
    Amount,
    TransactionType,
    CASE
        WHEN Amount >= 5000 THEN 'High'
        WHEN Amount >= 2000 THEN 'Medium'
        ELSE 'Low'
    END AS TransactionCategory
FROM Transactions;

-- Rank accounts by balance in descending order
SELECT
    AccountID,
    AccountType,
    Balance,
    RANK() OVER (ORDER BY Balance DESC) AS AccountRank
FROM Accounts;

-- Calculate a running total of transaction amounts by date
SELECT
    TransactionID,
    TransactionDate,
    Amount,
    SUM(Amount) OVER (
        ORDER BY TransactionDate, TransactionID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Transactions;

-- Display the average transaction amount for each transaction
SELECT
    TransactionID,
    TransactionDate,
    Amount,
    AVG(Amount) OVER () AS AverageTransactionAmount
FROM Transactions;

-- Rank customers based on their account balance
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    a.Balance,
    RANK() OVER (ORDER BY a.Balance DESC) AS CustomerRank
FROM Customers c
LEFT JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- Calculate a running total of account balances
SELECT
    AccountID,
    Balance,
    SUM(Balance) OVER (
        ORDER BY AccountID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningBalance
FROM Accounts;

-- Display the maximum transaction amount using a window function
SELECT
    TransactionID,
    Amount,
    MAX(Amount) OVER () AS MaximumTransactionAmount
FROM Transactions;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------