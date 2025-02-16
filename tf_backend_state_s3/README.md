# Terraform S3 Backend State Setup

This repository demonstrates how to configure **S3 as a backend** for storing the Terraform state file. Using S3 as a backend ensures that your state is securely stored, versioned, and accessible across different workstations and team members.

## What is Terraform Backend?

A backend in Terraform defines where the Terraform state is stored. By default, Terraform stores the state locally on the machine running the `terraform` command. 

Once the S3 bucket gets created update the below code in provider.tf 

```
terraform {
  backend "s3" {
  bucket = "terraform-backend-state" # Replace with your S3 bucket name
  key    = "tf-backend" # State file path in the S3 bucket
  region = "eu-central-1"  
  }
}

