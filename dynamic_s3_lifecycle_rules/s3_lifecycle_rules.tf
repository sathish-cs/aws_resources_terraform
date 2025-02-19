resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.aws_s3_bucket

  server_side_encryption_configuration { # Enable server-side encryption
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256" # Use AES256 encryption
      }
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  # Generate multiple lifecycle rules dynamically
  dynamic "rule" {
    for_each = [

      { id = "backup", status = "Enabled", prefix = "backup/", expiration_days = 60, transition_days = 30, storage_class = "STANDARD_IA" }, # Move objects to the STANDARD_IA storage class after 30 days
      { id = "archive", status = "Enabled", prefix = "archive/", expiration_days = 365, transition_days = 60, storage_class = "GLACIER" }, # Move objects to the GLACIER storage class after 60 days
      { id = "logs", status = "Enabled", prefix = "logs/", expiration_days = 30, transition_days = 0, storage_class = "" } # Expire objects after 1 day
    ]
    # Get the rule id & status
    content {
      id     = rule.value.id  
      status = rule.value.status 

      filter {
        prefix = rule.value.prefix # Apply the rule to objects with the specified prefix
      }

      dynamic "expiration" {
        for_each = rule.value.expiration_days > 0 ? [rule.value.expiration_days] : [] # Only create the expiration block if the expiration_days value is greater than 0
        content {
          days = rule.value.expiration_days
        }
      }

      dynamic "transition" {
        for_each = rule.value.transition_days > 0 ? [rule.value] : [] # Only create the transition block if the transition_days value is greater than 0
        content {
          days          = rule.value.transition_days
          storage_class = rule.value.storage_class
        }
      }
  }
}
}