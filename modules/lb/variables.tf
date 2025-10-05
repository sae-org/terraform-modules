# General naming prefix (e.g., "my-dev", "sae-org")
variable "proj_prefix" {
  description = "Prefix used for naming ALB and Target Groups"
  type        = string
  default     = ""
}

# ID of the VPC the ALB and Target Groups belong to
variable "vpc_id" {
  description = "VPC ID for Target Groups and ALB"
  type        = string
}

# (Optional) EC2 ID placeholder (useful if registering targets manually)
variable "ec2_id" {
  description = "Optional EC2 instance ID (not used here but reserved for extensions)"
  type        = string
  default     = null
  nullable    = true
}

# Whether the ALB is internal or internet-facing
variable "internal" {
  description = "If true, ALB is internal; if false, internet-facing"
  type        = bool
  default     = false
}

# Type of load balancer: "application" or "network"
variable "lb_type" {
  description = "Load balancer type ('application' or 'network')"
  type        = string
  default     = "application"
}

# Security groups applied to the ALB (required for Application LB)
variable "security_groups" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
  default     = []
}

# Subnets where ALB will be deployed (must match VPC)
variable "subnets" {
  description = "List of subnet IDs for ALB placement"
  type        = list(string)
  default     = []
}

# (Optional) Dependency placeholder (Terraform cannot use variables in depends_on)
variable "depend_on" {
  description = "NO-OP placeholder for dependencies (not used directly)"
  type        = list(string)
  default     = []
}

# Protects ALB from accidental deletion
variable "enable_deletion_protection" {
  description = "Enable deletion protection on the ALB"
  type        = bool
  default     = false
}

# Listener ports and protocols (used for both listeners and target groups)
variable "ports" {
  description = "List of listener ports and protocols"
  type = list(object({
    port     = number
    protocol = string
  }))
  default = [
    { port = 80,  protocol = "HTTP"  },
    { port = 443, protocol = "HTTPS" }
  ]
}

# Map of domain name → ACM certificate ARN
variable "cert_arn" {
  description = "Map of domain name to ACM certificate ARN"
  type        = map(string)
}

# Domain key to pick the primary certificate for HTTPS
variable "primary_cert_domain" {
  description = "Domain key to select primary ACM certificate ARN"
  type        = string
}

# Redirect HTTP → HTTPS status code
variable "http_status_code" {
  description = "Redirect status code used for HTTP to HTTPS (e.g., HTTP_301)"
  type        = string
  default     = "HTTP_301"
}
