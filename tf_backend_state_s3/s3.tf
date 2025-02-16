# Purpose: Create an S3 bucket to store the Terraform state file
resource "aws_s3_bucket" "s3" {
  bucket = var.aws_s3_bucket_name

  server_side_encryption_configuration { # Enable server-side encryption
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256" # Use AES256 encryption
      }
    }
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

variable "aws_s3_bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state file"
  type        = string
  default = "terraform-state-backend" # Replace with your bucket name
  
}