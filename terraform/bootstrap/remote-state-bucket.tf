terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61"
    }
  }
}

provider "aws" {
  profile = var.AWS_PROFILE
  region  = "us-east-1"
  default_tags {
    tags = {
      Enterprise  = var.enterprise,
      Project     = var.project_name,
      Environment = var.environment
    }
  }
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  # bucket = "${local.name_tag_prefix}terraform-state"
  # bucket = "${local.name_tag_prefix}terraform-state${local.name_tag_sufix}"
  bucket_prefix = "terraform-state-"
  force_destroy = true
  # lifecycle {
  #   prevent_destroy = true
  # }
  tags = {
    InternalUsage  = "True",
    TerraformUsage = "True"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Tells AWS to encrypt the S3 bucket at rest by default
resource "aws_kms_key" "terraform_state_bucket_encryption_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state_bucket_encryption_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name          = "terraform-state"
  # read_capacity  = 1
  # write_capacity = 1
  hash_key      = "LockID"
  # Pay per request is cheaper for low-i/o applications, like our TF lock state
  billing_mode  = "PAY_PER_REQUEST"
  # Attribute LockID is required for TF to use this table for lock state
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    InternalUsage   = "True",
    TerraformUsage  = "True",
    BuiltBy         = "Terraform"
  }
}

output "terraform_state_bucket_name" {
  description = "Bucket name to store terraform state. Use in '../09.provider.tf'."
  value = aws_s3_bucket.terraform_state_bucket.bucket
}
