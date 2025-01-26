terraform {
  required_version = "~> 1.10.0"
  
  backend "s3" {
    bucket         = var.bucket_name
    region         = var.aws_region
    key            = "backend.tfstate"
    dynamodb_table = var.dynamodb_table_name
  }
}

