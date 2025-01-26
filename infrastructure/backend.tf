terraform {
  required_version = "~> 1.10.0"
  
  backend "s3" {
    bucket         = "mundose22"
    region         = "us-east-1"
    key            = "infrastructure.tfstate"
    dynamodb_table = "terraformstatelock"
  }
}
