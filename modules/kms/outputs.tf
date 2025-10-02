# Output the KMS key ARN so the S3 module can use it for encryption
output "kms_key_arn" {
  value       = aws_kms_key.kms_key.arn
  description = "KMS key ARN"
}