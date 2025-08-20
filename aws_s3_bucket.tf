# This file is for testing Checkov compliance scanning.
# It contains intentional misconfigurations.
provider "aws" {
  region = "us-east-1"
}

# This bucket is missing encryption and versioning
resource "aws_s3_bucket" "non_compliant_data_lake" {
  bucket = "my-company-non-compliant-data-12345" # Must be globally unique
 

# A better configured bucket for comparison
resource "aws_s3_bucket" "compliant_log_bucket" {
  bucket = "my-company-compliant-logs-12345" # Must be globally unique
  acl    = "private"
  tags = {
    Name        = "Compliant Log Bucket"
    Environment = "Production"
    CostCenter  = "Fin-123" # Good practice tag
  }

  # Enable versioning to protect against accidental deletion
  versioning {
    enabled = true
  }

  # Enable default server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
