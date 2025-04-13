/*

resource "aws_ecr_repository" "flink_loan_txn_app" {
  name                 = "flink-loan-txn-app"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project = "Flink Loan Transaction Processing"
    Environment = "Production"
  }
}

resource "aws_ecr_repository" "flink-loan-app" {
  name                 = "flink-loan-app"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project = "Flink Loan Processing"
    Environment = "Production"
  }
}

*/