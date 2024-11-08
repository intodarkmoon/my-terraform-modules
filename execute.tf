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
