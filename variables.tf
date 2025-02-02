variable "aws_region" {
  default = "us-east-1"
}

variable "s3_bucket_name" {
  default = "my-terraform-state-bucket-vishnu-2701"
}

variable "dynamodb_table_name" {
  default = "terraform-locks"
}

variable "iam_role_name" {
  default = "TerraformPipelineRole"
}

variable "environment" {
  default = "dev"
}

variable "eks_cluster_name" {
  default     = "my-eks-cluster"
}