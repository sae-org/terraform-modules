# KMS key ARN for SSE-KMS encryption
variable "kms_key_arn" {
  type        = string
  description = "KMS key ARN for encrypting S3 objects"
}

# List of IAM usernames allowed by the bucket policy
variable "users" {
  type        = list(string)
  default     = []
  description = "IAM user names with bucket access"
}