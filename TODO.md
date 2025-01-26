# Infrastructure Setup Checklist

This checklist outlines the required tasks to complete the MundosE DevOps technical assessment.

## 1. Basic Setup Fixes

- [ ] Update Terraform version in TerraformApply.yml from 0.12.15 to a recent version (like 1.5.x)
- [ ] Add missing SSH key configuration in main.tf (currently commented out)
- [ ] Fix typo in TerraformDestroy.yml (-auto-approved should be -auto-approve)
- [ ] Add proper variable declarations and values (currently using hardcoded values)

## 2. Bootstrap Configuration

- [ ] Create a terraform.tfvars file to define values for the bootstrap variables
- [ ] Complete the bootstrap module implementation (currently has undefined variables)
- [ ] Create a bash script for setting things up
- [ ] Document the bootstrap process in README.md

## 3. State Management Setup

- [ ] Create the S3 bucket "mundose22" mentioned in backend.tf
- [ ] Create the DynamoDB table "terraformstatelock"
- [ ] Document the state management setup process

## 4. GitHub Actions Setup

- [ ] Configure AWS credentials in GitHub repository secrets
- [ ] Add proper branch protection rules
- [ ] Consider adding a plan step before apply

## 5. Testing

- [ ] Test the complete deployment process
- [ ] Test the destroy process
- [ ] Verify Apache installation
- [ ] Verify access to the website

## 6. Documentation

- [ ] Create a proper README.md with:
  - [ ] Project description
  - [ ] Prerequisites
  - [ ] Setup instructions
  - [ ] Usage guide
  - [ ] Architecture diagram

## 7. Improvements

- [ ] Add variables for customization (instance type, region, etc.)
- [ ] Add outputs for important resource information
- [ ] Add tags for better resource management
- [ ] Add a simple website content to demonstrate Apache working
