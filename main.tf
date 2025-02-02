provider "aws" {
  region = var.aws_region
}

# S3 Bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
  }
}

# DynamoDB for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
  }
}

# IAM Role for Terraform Pipeline
resource "aws_iam_role" "terraform_role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::376163012258:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:sub" = "repo:vishnuvarthann27/terraform-pipeline:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}

# Policy for S3 and DynamoDB Access
resource "aws_iam_policy" "terraform_policy" {
  name        = "TerraformAccessPolicy"
  description = "Policy for managing Terraform backend and infrastructure"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:*",
          "dynamodb:*",
          "iam:GetRole",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}

# Create VPC for EKS
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  enable_dns_hostnames = true
}



# Create an EKS cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.28"
  
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  # Node Group Configuration
  eks_managed_node_groups = {
    eks_nodes = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}
