# Prefix for resource naming convention
variable "proj_prefix" {
  description = "Project prefix used to name CloudWatch and SNS resources"
  type        = string
}

# Friendly display name for the SNS topic
variable "display_name" {
  description = "Display name for the SNS topic (appears in AWS Console)"
  type        = string
}

# Email address to subscribe to SNS topic alerts
variable "alert_email" {
  description = "Email address that will receive CloudWatch alarm notifications"
  type        = string
}


