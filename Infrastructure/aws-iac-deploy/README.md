# Terraform Deployment Guide

This guide will walk you through the steps to deploy the Terraform project using a shell script and also provide instructions to destroy the project using a separate destroy script.

## Prerequisites

Before proceeding with the deployment, ensure that you have the following prerequisites:

- Terraform installed on your machine
- AWS CLI configured with appropriate credentials

## Deployment Steps

1. Navigate to the project directory

4. Initialize and deploy the Terraform project with bash script:

    ```shell
    ./deploy_terraform_project.sh
    ```

## Destroy Steps

To destroy the deployed infrastructure, follow these steps:

1. Navigate to the project directory

2. Run the destroy script:

    ```shell
    ./destroy_terraform_project.sh
    ```
