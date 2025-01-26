# Build an S3 bucket to store TF state
resource "aws_s3_bucket" "state_bucket" {
  bucket = var.name_of_s3_bucket

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  # Prevents Terraform from destroying or replacing this object - a great safety mechanism
  lifecycle {
    prevent_destroy = true
  }

  # Tells AWS to keep a version history of the state file
  versioning {
    enabled = true
  }

  tags = {
    Terraform = "true"
  }
}

# Build a DynamoDB to use for terraform state locking
resource "aws_dynamodb_table" "tf_lock_state" {
  name = var.dynamo_db_table_name

  # Pay per request is cheaper for low-i/o applications, like our TF lock state
  billing_mode = "PAY_PER_REQUEST"

  # Hash key is required, and must be an attribute
  hash_key = "LockID"

  # Attribute LockID is required for TF to use this table for lock state
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.dynamo_db_table_name
    BuiltBy = "Terraform"
  }
}

provider "aws" {
  region = var.aws_region
}

# Create IAM user for Terraform
resource "aws_iam_user" "terraform_user" {
  name = var.iam_user_name
  
  tags = {
    Description = "IAM user for Terraform operations"
    Terraform   = "true"
  }
}

# Create IAM policy for Terraform permissions
resource "aws_iam_policy" "terraform_policy" {
  name        = var.iam_policy_name
  description = "Policy for Terraform IAM user"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          aws_s3_bucket.state_bucket.arn,
          "${aws_s3_bucket.state_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = aws_dynamodb_table.tf_lock_state.arn
      }
    ]
  })
}

# Attach policy to user
resource "aws_iam_user_policy_attachment" "terraform_user_policy" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}
