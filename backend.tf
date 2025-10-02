# Store Terraform state in S3 and enable native S3 locking
terraform {
  backend "s3" {
    bucket       = "your-s3-bucket-name"          # use your actual bucket name
    key          = "global/s3/terraform.tfstate" # stable path for the state file
    region       = "your-aws-region"
    encrypt      = true
    use_lockfile = true                           # native S3 locking (Terraform ≥ 1.10)
  }
}
