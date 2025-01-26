# AWS Infrastructure as Code with Terraform

## Table of Contents
- [Introduction](#introduction)
- [Usage Guide for Developers](#usage-guide-for-developers)
- [Setup Guide for DevOps](#setup-guide-for-devops)
- [Project Structure](#project-structure)

## Introduction

This project automates the deployment of a web server infrastructure on AWS using Terraform. It includes a bootstrap process for managing Terraform state and the main infrastructure deployment for a web server setup with Apache and Astro.js.

Key features:
- Automated infrastructure deployment
- State management with S3 and DynamoDB
- GitHub Actions integration
- Apache web server with Astro.js frontend

## Usage Guide for Developers

### Prerequisites
- AWS CLI configured with appropriate credentials
- Terraform ~> 1.10.0

### Quick Start
```bash
# Deploy infrastructure
cd infrastructure
terraform init
terraform plan
terraform apply

# Get web server IP
terraform output Webserver-Public-IP
```

### GitHub Actions
The repository includes two workflows:
- **TerraformApply**: Automatically deploys infrastructure on push to main branch
- **TerraformDestroy**: Manually triggered workflow to tear down infrastructure

Required GitHub Secrets:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_REGION

## Setup Guide for DevOps

### 1. Bootstrap State Backend
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

### 2. Verify Resources

#### Bootstrap Verification
```bash
# Verify S3 bucket
aws s3 ls | grep nelson-rios.mundose22

# Verify DynamoDB table
aws dynamodb list-tables | grep terraformstatelock
```

#### Infrastructure Verification
```bash
# Verify VPC
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=terraform-vpc"

# Verify EC2 instance
aws ec2 describe-instances --filters "Name=tag:Name,Values=webserver" "Name=instance-state-name,Values=running"

# Test web server
curl http://$(terraform output -raw Webserver-Public-IP)
```

### Configuration Variables

#### Bootstrap (`bootstrap/variables.tf`)
- `name_of_s3_bucket`: S3 bucket name for state storage
- `dynamo_db_table_name`: DynamoDB table name for state locking
- `iam_user_name`: IAM user name for Terraform operations

#### Infrastructure (`infrastructure/variables.tf`)
- `aws_region`: AWS region for deployment
- `vpc_cidr`: CIDR block for VPC
- `subnet_cidr`: CIDR block for subnet
- `instance_type`: EC2 instance type
- `ami_id`: AMI ID for web server

## Project Structure

### Infrastructure Components
- `bootstrap/`
  - `main.tf`: Creates S3 bucket and DynamoDB table for state management
  - `variables.tf`: Bootstrap configuration variables

- `infrastructure/`
  - `backend.tf`: Configures Terraform backend
  - `main.tf`: EC2 instance configuration
  - `setup.tf`: VPC and networking setup
  - `create_apache.sh`: Apache and Astro.js installation script
  - `variables.tf`: Infrastructure variables

### CI/CD
- `.github/workflows/`
  - `TerraformApply.yml`: Automated deployment workflow
  - `TerraformDestroy.yml`: Infrastructure teardown workflow

### Security Notes
- Bootstrap creates minimal-permission IAM user
- Web server accepts only HTTP traffic (port 80)
- All resources are tagged for management
- S3 bucket has deletion protection enabled
