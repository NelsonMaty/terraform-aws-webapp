variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "name_of_s3_bucket" {
  description = "Name of S3 bucket for terraform state"
  type        = string
  default     = "mundose22"
}

variable "dynamo_db_table_name" {
  description = "Name of DynamoDB table for terraform state locking"
  type        = string
  default     = "terraformstatelock"
}

variable "iam_user_name" {
  description = "Name of IAM user for Terraform"
  type        = string
  default     = "terraform-admin"
}

variable "iam_policy_name" {
  description = "Name of IAM policy for Terraform permissions"
  type        = string
  default     = "terraform-admin-policy"
}
