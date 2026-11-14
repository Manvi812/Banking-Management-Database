/*
Project: Banking Management Database

Description:
Performs advanced banking data analysis using SQL subqueries
and views to retrieve meaningful information from related tables.

Key Operations:
- Identifying transactions above the average transaction amount
- Finding accounts with above-average balances
- Retrieving deposit accounts using multi-row subqueries
- Identifying accounts with the highest balance
- Creating and using SQL views for simplified banking reports
*/

-- Select the banking database
USE BankingDB;

-- =====================================================================
-- Perform Banking Data Analysis Using Subqueries
-- =====================================================================

-- Display all transaction records
SELECT * FROM Transactions;

-- Calculate the average transaction amount
SELECT
    AVG(Amount) AS AverageTransactionAmount
FROM Transactions;

-- Retrieve transactions whose amount is greater than the average
SELECT
    TransactionID,
    TransactionDate,
    TransactionType,
    Amount,
    AccountID
FROM Transactions
WHERE Amount >
(
    SELECT AVG(Amount)
    FROM Transactions
);

-- Display all account records
SELECT * FROM Accounts;

-- Calculate the average account balance and retrieve accounts
-- having balances greater than the average
SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance >
(
    SELECT AVG(Balance)
    FROM Accounts
)
ORDER BY Balance DESC;

-- --------------------------------------------------
-- Identify Deposit Accounts Using a Multi-Row Subquery
-- --------------------------------------------------

-- Retrieve accounts that have performed Deposit transactions
SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE AccountID IN
(
    SELECT AccountID
    FROM Transactions
    WHERE TransactionType = 'Deposit'
);

-- --------------------------------------------------
-- Identify the Account with the Highest Balance
-- --------------------------------------------------

-- Retrieve the account or accounts having the highest balance
SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance =
(
    SELECT MAX(Balance)
    FROM Accounts
);

-- Check existing views in BankingDB
SHOW FULL TABLES IN BankingDB
WHERE TABLE_TYPE = 'VIEW';

-- --------------------------------------------------
-- Create a View for High-Balance Accounts
-- --------------------------------------------------

-- Create a reusable view for accounts with balances above 30000
CREATE VIEW High_Balance_Accounts AS
SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance > 30000;

-- --------------------------------------------------
-- Retrieve Data Using the View
-- --------------------------------------------------

-- Display all high-balance accounts using the created view
SELECT *
FROM High_Balance_Accounts;

-- --------------------------------------------------
-- Modify the View to Include Transaction Details
-- --------------------------------------------------

-- Replace the existing view definition to include transaction details
CREATE OR REPLACE VIEW High_Balance_Accounts AS
SELECT
    a.AccountID,
    a.AccountType,
    a.Balance,
    a.CustomerID,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
WHERE a.Balance > 30000;

-- --------------------------------------------------
-- Generate Banking Reports Using the View
-- --------------------------------------------------

-- Retrieve and sort high-balance account transaction reports
SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID,
    TransactionID,
    TransactionDate,
    TransactionType,
    Amount
FROM High_Balance_Accounts
ORDER BY Balance DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------