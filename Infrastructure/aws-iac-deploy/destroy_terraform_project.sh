#!/bin/bash

set -e

echo "Destroying Terraform project..."

cd test-project

# Initialize Terraform project
terraform init -backend-config=backend/backend.conf

# Apply Terraform project
terraform destroy -var-file=vars/test_project.tfvars -auto-approve

echo "Successfully destroyed Terraform project."

echo "Destroying s3 backend store for Terraform project..."
cd ../s3-backend

# Initialize Terraform project
terraform init

# Destroy Terraform project
terraform destroy -auto-approve

cd ..
echo "Successfully destroyed s3 backend store for Terraform project."