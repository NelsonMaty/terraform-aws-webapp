# Infrastructure Setup Checklist

This checklist outlines the required tasks to complete the MundosE DevOps technical assessment.

## 1. Basic Setup Fixes

- [x] Update Terraform version in TerraformApply.yml from 0.12.15 to a recent version (like 1.5.x)
- [x] Update or remove SSH key configuration in main.tf (currently commented out)
- [x] Fix typo in TerraformDestroy.yml (-auto-approved should be -auto-approve)
- [x] Add proper variable declarations and values (currently using hardcoded values)

## 2. Bootstrap Configuration

- [x] Complete the bootstrap module implementation (currently has undefined variables)
- [x] Separate the infrastracture terraform files into its own folder
- [x] Document the bootstrap process and state management in README.md

## 3. State Management Setup

- [x] Configure S3 bucket and DynamoDB table for state management in bootstrap folder
- [x] Set up VPC networking and EC2 instance resources in infrastructure folder

## 4. GitHub Actions Setup

- [x] Configure AWS credentials in GitHub repository secrets
- [x] Complete GitHub Actions workflow steps using /infrastructure as working directory

## 5. Testing

- [x] Test the complete deployment process
- [x] Test the destroy process
- [x] Verify Apache installation
- [x] Verify access to the website

## 6. Documentation

- [x] Create a proper README.md with:
  - [x] Project description
  - [x] Prerequisites
  - [x] Setup instructions
  - [x] Usage guide
  - [x] Architecture diagram

## 7. Improvements

- [x] Add variables for customization (instance type, region, etc.)
- [x] Add outputs for important resource information
- [x] Add tags for better resource management
- [ ] Add a simple website content to demonstrate Apache working
