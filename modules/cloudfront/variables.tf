# Prefix for resource naming convention
variable "proj_prefix" {
  description = "Project prefix used to name CloudWatch and SNS resources"
  type        = string
}

# Required: ALB DNS name (origin)
variable "alb_dns_name" {
  description = "DNS name of the ALB (e.g., app-123456.us-east-1.elb.amazonaws.com)"
  type        = string
}

# Optional: custom domain (aliases) and certificate
variable "cf_aliases" {
  description = "List of alternate domain names for the distribution (e.g., [\"cloudfront-project.saeeda.me\"])"
  type        = list(string)
  default     = []
}

variable "cf_certificate_arn" {
  description = "ACM cert ARN in us-east-1 for the aliases. If null, use the default CloudFront cert."
  type        = string
  default     = null
}

variable "cf_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "cf_enable_logging" {
  description = "Enable access logs"
  type        = bool
  default     = false
}

variable "cf_log_bucket" {
  description = "S3 bucket domain name for logs (e.g., logs-bucket.s3.amazonaws.com)"
  type        = string
  default     = null
}
