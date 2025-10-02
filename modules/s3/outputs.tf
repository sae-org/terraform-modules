# Output the bucket name for root usage
output "state_bucket" {
	value       = aws_s3_bucket.s3.bucket
  description = "S3 bucket for Terraform state"
}