# Create a KMS key that will encrypt S3 bucket objects
resource "aws_kms_key" "kms_key" {
  description             = "Key for encrypting S3 state bucket objects"
  deletion_window_in_days = 10  # grace period before final deletion
}
