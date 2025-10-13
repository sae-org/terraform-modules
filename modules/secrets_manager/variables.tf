variable "secret_name" {
  description = "Secrets Manager name/ARN-friendly PATH (e.g., terraform/aws/ssh_key_priv)"
  type        = string
}

variable "secret_string" {
  description = "The secret payload to store (e.g., private key PEM)"
  type        = string
  sensitive   = true
}
