# List of domain names to request certificates for
variable "acm_domains" {
  description = "List of domain names to request ACM certificates for"
  type        = list(string)
}

# Validation method used by ACM (typically DNS)
variable "validation_method" {
  description = "Method to validate domain ownership (DNS or EMAIL)"
  type        = string
  default     = "DNS"
}
