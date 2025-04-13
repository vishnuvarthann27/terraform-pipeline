/*
# Create DynamoDB Tables
resource "aws_dynamodb_table" "loan_1" {
  name           = "LOAN_1"
  billing_mode   = "PAY_PER_REQUEST" # On-demand capacity
  hash_key       = "invstr_loan_nbr"

  attribute {
    name = "invstr_loan_nbr"
    type = "S"
  }

  tags = {
    Name = "LOAN_1"
  }
}

resource "aws_dynamodb_table" "loan_2" {
  name           = "LOAN_2"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "invstr_loan_nbr"

  attribute {
    name = "invstr_loan_nbr"
    type = "S"
  }

  tags = {
    Name = "LOAN_2"
  }
}

resource "aws_dynamodb_table" "loan_txn_1" {
  name           = "LOAN_TXN_1"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "invstr_loan_nbr"
  range_key      = "txn_seq_nbr"

  attribute {
    name = "invstr_loan_nbr"
    type = "S"
  }

  attribute {
    name = "txn_seq_nbr"
    type = "S"
  }

  tags = {
    Name = "LOAN_TXN_1"
  }
}

resource "aws_dynamodb_table" "loan_txn_2" {
  name           = "LOAN_TXN_2"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "invstr_loan_nbr"
  range_key      = "txn_seq_nbr"

  attribute {
    name = "invstr_loan_nbr"
    type = "S"
  }

  attribute {
    name = "txn_seq_nbr"
    type = "S"
  }

  tags = {
    Name = "LOAN_TXN_2"
  }
}
*/