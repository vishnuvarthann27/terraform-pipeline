CREATE DATABASE loan_db;
USE loan_db;

-- Create the Loan table
CREATE TABLE loan (
    invstr_loan_nbr INT PRIMARY KEY,
    srvcr_loan_nbr INT,
    upb_amt DECIMAL(15,2),
    original_prin_bal DECIMAL(15,2),
    ddlpi_dt DATE,
    first_payment_date DATE,
    loan_mtr_dt DATE,
    invstr_cd VARCHAR(50),
    issur_nbr VARCHAR(50),
    created_timestamp DATETIME
);

-- Create the Loan Transaction table with a composite primary key
CREATE TABLE loan_txn (
    invstr_loan_nbr INT,
    txn_seq_nbr INT,
    srvcr_loan_nbr INT,
    prin_pymt_amt DECIMAL(15,2),
    int_pymt_amt DECIMAL(15,2),
    txn_dt DATE,
    next_pymt_due_dt DATE,
    crtl_amt DECIMAL(15,2),
    int_only_pymt_amt DECIMAL(15,2),
    lqdtn_pymt_amt DECIMAL(15,2),
    prin_bal_aftr_pymt DECIMAL(15,2),
    created_timestamp DATETIME,
    PRIMARY KEY (invstr_loan_nbr, txn_seq_nbr),
    FOREIGN KEY (invstr_loan_nbr) REFERENCES loan(invstr_loan_nbr)
);

-- Create the LLR table (Reporting_Record)
CREATE TABLE llr (
    invstr_loan_nbr INT PRIMARY KEY,
    srvcr_loan_nbr INT,
    prin_pymt_amt DECIMAL(15,2),
    int_pymt_amt DECIMAL(15,2),
    txn_dt DATE,
    next_pymt_due_dt DATE,
    crtl_amt DECIMAL(15,2),
    int_only_pymt_amt DECIMAL(15,2),
    lqdtn_pymt_amt DECIMAL(15,2),
    end_upb_amt DECIMAL(15,2),
    opening_upb_amt DECIMAL(15,2),
    original_prin_bal DECIMAL(15,2),
    ddlpi_dt DATE,
    first_payment_date DATE,
    loan_mtr_dt DATE,
    invstr_cd VARCHAR(50),
    issur_nbr VARCHAR(50),
    created_timestamp DATETIME,
    FOREIGN KEY (invstr_loan_nbr) REFERENCES loan(invstr_loan_nbr)
);
