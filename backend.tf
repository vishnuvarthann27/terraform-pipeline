terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-vishnu-2701"
    key            = "state-files/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
