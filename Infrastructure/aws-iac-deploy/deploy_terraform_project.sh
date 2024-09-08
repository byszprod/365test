#!/bin/bash

set -e

echo "Deploying s3 backend store for Terraform project..."

cd s3-backend

# Initialize Terraform project
terraform init

# Validate Terraform project
terraform validate

# Format Terraform project
terraform fmt

# Plan Terraform project
terraform plan

# Apply Terraform project
terraform apply -auto-approve

echo "Successfully deployed s3 backend store for Terraform project."

echo "Deploying Terraform project..."

cd ../test-project

# Initialize Terraform project
terraform init -backend-config=backend/backend.conf

# Validate Terraform project
terraform validate

# Format Terraform project
terraform fmt

# Plan Terraform project
terraform plan -var-file=vars/test_project.tfvars

# Apply Terraform project
terraform apply -var-file=vars/test_project.tfvars -auto-approve

cd ..

echo "Successfully deployed Terraform project."