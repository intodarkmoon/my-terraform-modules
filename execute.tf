# main.tf (root module)
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
  source = "./modules/s3/"

  bucket = "galang-s3-bucket" # Provide a name for your S3 bucket
  acl    = "public-read"

  versioning = "Enabled"

  object_lock_enabled = false


}

