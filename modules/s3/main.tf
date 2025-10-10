
# Creating an S3 bucket for storing Terraform state
resource "aws_s3_bucket" "s3" {
  bucket = "sae-s3-terraform-backend"

  tags   = { 
		Name = "sae-s3-terraform-backend" 
	}
}

# Enforce bucket ownership to avoid ACL issues
resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.s3.id

  rule { 
		object_ownership = "BucketOwnerEnforced" 
	}
}

# Enable default SSE-KMS encryption for the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse" {
  bucket = aws_s3_bucket.s3.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Get details about the current AWS account (like Account ID).
# This doesn't create anything; it's a "data source" Terraform can query.
# We need the account_id so we can build full ARNs for IAM users later.
data "aws_caller_identity" "current" {}

# Create a local variable (principal_arns) that holds a list of full IAM ARNs.
# This will expand to:
#   ["arn:aws:iam::123456789012:user/your_user_1",
#    "arn:aws:iam::123456789012:user/your_user_2"]
# We’ll use this list in the bucket policy to give those users access.
locals {
  principal_arns = [
    for u in var.users :
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${u}"
  ]
}

# Bucket policy to allow S3 access for listed users 
resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3.id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
			{
				Sid       = "Statement2"
				Effect    = "Allow"
				Principal = { 
					AWS = local.principal_arns    # ← [your_user_1, your_user_2]
				}
				Action    = "s3:*"
				Resource  = [
					aws_s3_bucket.s3.arn,					# ← your_bucket_name
					"${aws_s3_bucket.s3.arn}/*"  # ← your_bucket_name/* = and anything within it
				]
    	}
		]
  })
}
