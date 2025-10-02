# Tell Terraform we need the AWS provider
terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

# Configure AWS region
provider "aws" {
  region = var.region
}

# KMS module (customer-managed key for SSE-KMS)
module "kms" {
  source = "./modules/kms"
}

# S3 module (state bucket that uses the KMS key)
module "s3" {
  source      = "./modules/s3"
  proj_prefix = var.proj_prefix
  kms_key_arn = module.kms.kms_key_arn   # wiring KMS → S3
  users       = var.users
}
