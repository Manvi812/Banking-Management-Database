/*
Project: Banking Management Database

Description:
Performs loan risk analysis and generates transaction reports
using SQL window functions, table joins, and filtering conditions.

Key Operations:
- Understanding and applying the OVER() clause
- Ranking loans using RANK() and DENSE_RANK()
- Assigning sequential numbers using ROW_NUMBER()
- Partitioning loan records by CustomerID
- Calculating running loan totals
- Comparing loan records using LAG() and LEAD()
- Generating account transaction reports using INNER JOIN
- Displaying accounts with and without transactions using LEFT JOIN
- Generating deposit transaction reports
- Identifying high-balance account transactions
*/

-- Select the banking database
USE BankingDB;

-- =====================================================================
-- Analyze Loan Risk Using Window Functions
-- =====================================================================

-- --------------------------------------------------
-- Understanding the OVER() Clause
-- --------------------------------------------------

-- Display all loan records
SELECT * FROM Loans;

-- Display loan records with their loan amounts using OVER()
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    SUM(LoanAmount) OVER () AS TotalLoanAmount
FROM Loans;

-- --------------------------------------------------
-- Rank Customer Loans Using RANK()
-- --------------------------------------------------

-- Rank loans from highest amount to lowest amount
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    RANK() OVER (
        ORDER BY LoanAmount DESC
    ) AS LoanRank
FROM Loans;

-- --------------------------------------------------
-- Rank Customer Loans Using DENSE_RANK()
-- --------------------------------------------------

-- Rank loans without skipping rank numbers
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    DENSE_RANK() OVER (
        ORDER BY LoanAmount DESC
    ) AS DenseRank
FROM Loans;

-- --------------------------------------------------
-- Assign Row Numbers Using ROW_NUMBER()
-- --------------------------------------------------

-- Assign a unique sequential number to each loan
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER (
        ORDER BY LoanAmount DESC
    ) AS RowNumber
FROM Loans;

-- --------------------------------------------------
-- Partition Loan Records Using PARTITION BY
-- --------------------------------------------------

-- Assign row numbers separately for each customer
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER (
        PARTITION BY CustomerID
        ORDER BY LoanAmount DESC
    ) AS RowNum
FROM Loans;

-- --------------------------------------------------
-- Calculate Running Total Using SUM() OVER()
-- --------------------------------------------------

-- Calculate cumulative loan amounts from highest to lowest
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    SUM(LoanAmount) OVER (
        ORDER BY LoanAmount DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Loans;

-- --------------------------------------------------
-- Compare Previous Loan Records Using LAG()
-- --------------------------------------------------

-- Display the previous loan amount for each loan
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LAG(LoanAmount) OVER (
        ORDER BY LoanAmount DESC
    ) AS PreviousLoanAmount
FROM Loans;

-- --------------------------------------------------
-- Compare Next Loan Records Using LEAD()
-- --------------------------------------------------

-- Display the next loan amount for each loan
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LEAD(LoanAmount) OVER (
        ORDER BY LoanAmount DESC
    ) AS NextLoanAmount
FROM Loans;

-- =====================================================================
-- Create Transaction Reports Using Table Joins
-- =====================================================================

-- --------------------------------------------------
-- Generate Account Transaction Reports Using INNER JOIN
-- --------------------------------------------------

-- Display account details along with their transaction details
SELECT
    a.AccountID,
    a.AccountType,
    a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID;

-- --------------------------------------------------
-- Display All Accounts Including Those Without Transactions
-- Using LEFT JOIN
-- --------------------------------------------------

-- Display every account, even if it has no transactions
SELECT
    a.AccountID,
    a.AccountType,
    a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
LEFT JOIN Transactions t
    ON a.AccountID = t.AccountID;

-- --------------------------------------------------
-- Generate Deposit Transaction Reports
-- --------------------------------------------------

-- Display only deposit transactions with account details
SELECT
    a.AccountID,
    a.AccountType,
    a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
WHERE t.TransactionType = 'Deposit';

-- --------------------------------------------------
-- Generate High Balance Account Transaction Reports
-- --------------------------------------------------

-- Display transactions for accounts with balances above 30000
SELECT
    a.AccountID,
    a.AccountType,
    a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
WHERE a.Balance > 30000
ORDER BY a.Balance DESC;
