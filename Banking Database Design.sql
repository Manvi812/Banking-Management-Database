/*
Project: Banking Management Database

Description:
Creates the BankingDB database and establishes
the structure of its banking tables.

Key Operations:
- Database and table creation
- Adding and modifying table columns
- Applying primary key and unique constraints
- Establishing foreign key relationships
- Applying data integrity constraints
- Reviewing table structures and relationships
*/

-- Create the banking database
CREATE DATABASE IF NOT EXISTS BankingDB;

-- Select the database
USE BankingDB;

-- Create the Customers table
CREATE TABLE IF NOT EXISTS Customers
(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    AccountCreationDate DATE
);

-- View the Customers table structure
DESCRIBE Customers;

-- Create the Accounts table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

-- Create the Transactions table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

-- Create the Branches table
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);

-- Create the AccountBranches table
CREATE TABLE AccountBranches (
    AssignmentDate DATE
);

-- Create the Loans table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

-- Display all created tables
SHOW TABLES;

-- Add date of birth to the Customers table
ALTER TABLE Customers
ADD DateOfBirth DATE;

-- Modify the phone number column size
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

-- View the updated Customers structure
DESCRIBE Customers;

-- Add a minimum balance constraint to Accounts
ALTER TABLE Accounts
ADD CONSTRAINT chk_MinBalance
CHECK (Balance >= 1000);

-- View the Accounts table structure
DESCRIBE Accounts;

-- Verify the minimum balance constraint
SHOW CREATE TABLE Accounts;

-- Drop the AccountBranches table
DROP TABLE AccountBranches;

-- Verify the remaining tables
SHOW TABLES;

-- Add CustomerID to Accounts
ALTER TABLE Accounts
ADD CustomerID INT;

-- Establish the relationship between Accounts and Customers
ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- Verify the Accounts structure
DESCRIBE Accounts;

-- Verify the foreign key constraint
SHOW CREATE TABLE Accounts;

-- Make FirstName a required field
ALTER TABLE Customers
MODIFY FirstName VARCHAR(50) NOT NULL;

-- Verify the Customers structure
DESCRIBE Customers;

-- Add a unique constraint to customer email addresses
ALTER TABLE Customers
ADD CONSTRAINT uq_Email UNIQUE (Email);

-- Verify the unique constraint
SHOW CREATE TABLE Customers;

-- Add BranchID to Accounts
ALTER TABLE Accounts
ADD BranchID INT;

-- Establish the relationship between Accounts and Branches
ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

-- Verify the Accounts table relationships
SHOW CREATE TABLE Accounts;

-- Add AccountID to Transactions
ALTER TABLE Transactions
ADD AccountID INT;

-- Establish the relationship between Transactions and Accounts
ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

-- Verify the Transactions table relationship
SHOW CREATE TABLE Transactions;

-- Add CustomerID to Loans
ALTER TABLE Loans
ADD CustomerID INT;

-- Establish the relationship between Loans and Customers
ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- Verify the Loans table relationship
SHOW CREATE TABLE Loans;

-- Review the structure of all banking tables
DESCRIBE Customers;
DESCRIBE Accounts;
DESCRIBE Transactions;
DESCRIBE Branches;
DESCRIBE Loans;

-- Display all foreign key relationships in the database
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'BankingDB'
AND REFERENCED_TABLE_NAME IS NOT NULL;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------