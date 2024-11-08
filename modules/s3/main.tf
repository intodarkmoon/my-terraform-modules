# Configuration for root files
/*

provider "aws" {
  region = "ap-southeast-3"
  default_tags {
    tags = {
      Owner   = "Galang-L1"
      Project = "Testing"
    }
  }
}

module "s3" {
  source              = "./modules/s3/"
  bucket              = "galang-s3-bucket"
  acl                 = "private" # Change to "public-read" or "" if needed
  versioning          = "Enabled" # Options: "Enabled" or "Disabled"
  object_lock_enabled = false
  force_destroy       = false

  # Public access settings
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Encryption settings

  object_ownership = "BucketOwnerPreferred"
}
    




*/

# main.tf (S3 module)
# ====================================================================================================
# S3 Bucket
# ====================================================================================================

resource "aws_s3_bucket" "this" {
  # Arguments
  count               = var.create_bucket ? 1 : 0
  bucket              = var.bucket
  bucket_prefix       = var.bucket_prefix
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags

}

# ====================================================================================================
# Object Ownership Configuration
# ====================================================================================================
resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  rule {
    object_ownership = var.object_ownership
  }
}

# ACL Configuration
resource "aws_s3_bucket_acl" "this" {
  count = var.create_bucket ? 1 : 0

  # Arguments
  bucket     = aws_s3_bucket.this[0].id
  acl        = var.acl
  depends_on = [aws_s3_bucket_ownership_controls.this]
}

# ====================================================================================================
# # Block Public Access Settings
# ====================================================================================================
resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  # Arguments
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# ====================================================================================================
# Bucket Versioning
# ====================================================================================================
resource "aws_s3_bucket_versioning" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  versioning_configuration {
    status = var.versioning
  }
}

# ====================================================================================================
# Encryption Configuration
# ====================================================================================================
resource "aws_kms_key" "this" {
  count                   = var.create_bucket ? 1 : 0
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this[0].arn
      sse_algorithm     = "aws:kms"
    }
  }
}



