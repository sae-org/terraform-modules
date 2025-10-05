variable "secret_name" {
  description = "Secrets Manager name/ARN-friendly path (e.g., terraform/aws/ssh_key_priv)"
  type        = string
}

variable "secret_string" {
  description = "The secret payload to store (e.g., private key PEM)"
  type        = string
  sensitive   = true
}

variable "secret_description" {
  description = "Optional description for the secret"
  type        = string
  default     = "Managed by Terraform"
}

variable "kms_key_id" {
  description = "Optional KMS key ID/ARN to encrypt the secret (defaults to AWS-managed key if null)"
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Recovery window for scheduled deletion (7-30 days)"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Optional tags for the secret resource"
  type        = map(string)
  default     = {}
}
