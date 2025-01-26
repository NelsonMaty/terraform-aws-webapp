# AWS Infrastructure as Code with Terraform

This project provides an automated way to deploy a web server infrastructure on AWS using Terraform, with a separate bootstrap process for managing Terraform state.

## Project Structure

The project is organized into two main components:
- `bootstrap/`: Creates and manages the Terraform state backend (S3 bucket and DynamoDB table)
- `infrastructure/`: Deploys the web server and networking components

## Prerequisites

- Terraform ~> 1.10.0
- AWS CLI configured with appropriate credentials
- AWS IAM permissions for:
  - S3 bucket creation and management
  - DynamoDB table creation and management
  - VPC and networking resources
  - EC2 instance management
  - IAM user and policy management

## Setup Instructions

### 1. Bootstrap State Backend

First, set up the Terraform state backend:

```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

This creates:
- S3 bucket for state storage
- DynamoDB table for state locking
- IAM user with required permissions

### 2. Deploy Infrastructure

After bootstrap is complete:

```bash
cd ../infrastructure
terraform init
terraform plan
terraform apply
```

This deploys:
- VPC with internet gateway
- Public subnet
- Security group (allows HTTP traffic)
- EC2 instance running Apache web server

## Configuration

### Bootstrap Configuration
Key variables in `bootstrap/variables.tf`:
- `name_of_s3_bucket`: Name of S3 bucket for state storage
- `dynamo_db_table_name`: Name of DynamoDB table for state locking
- `iam_user_name`: Name of IAM user for Terraform operations

### Infrastructure Configuration
Key variables in `infrastructure/variables.tf`:
- `aws_region`: AWS region for deployment
- `vpc_cidr`: CIDR block for VPC
- `subnet_cidr`: CIDR block for subnet
- `instance_type`: EC2 instance type
- `ami_id`: AMI ID for the web server

## Usage Guide

### Modifying Infrastructure

1. Update variables in respective `variables.tf` files
2. Run `terraform plan` to review changes
3. Apply changes with `terraform apply`

### Destroying Infrastructure

To tear down the infrastructure:

```bash
cd infrastructure
terraform destroy

cd ../bootstrap
terraform destroy
```

Note: The S3 bucket has `prevent_destroy = true` set as a safety mechanism.

### Verifying Bootstrap Resources

After running `terraform apply` in the bootstrap directory, verify the resources were created:

```bash
# Verify S3 bucket creation
aws s3 ls | grep nelson-rios.mundose22

# Verify DynamoDB table creation
aws dynamodb list-tables | grep terraformstatelock
```

## Security Notes

- The bootstrap process creates a dedicated IAM user with minimal required permissions
- The web server only accepts HTTP traffic (port 80)
- All resources are tagged for better resource management
