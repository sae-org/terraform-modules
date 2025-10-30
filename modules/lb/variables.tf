# General naming prefix (e.g., "my-dev", "sae-org")
variable "proj_prefix" {
  description = "Prefix used for naming ALB and Target Groups"
  type        = string
  default     = ""
}

# Whether the ALB is internal or internet-facing
variable "internal" {
  description = "If true, ALB is internal; if false, internet-facing"
  type        = bool
  default     = false
}

variable "cert_name" {
  description = "The cert name being used for HTTPS"
  type        = string
}

variable "target_id" {
  description = "The id of targets being registered "
  type        = string
  default = null
}

# Type of load balancer: "application" or "network"
variable "lb_type" {
  description = "Load balancer type ('application' or 'network')"
  type        = string
  default     = "application"
}

variable "target_type" {
  description = "Target Type (e.g ip, instance)"
  type        = string
  default     = "application"
}

# Security groups applied to the ALB (required for Application LB)
variable "security_groups" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
  default     = []
}

variable "create_tg_attachment" {
  description = "if for asg, no need to create tg attachments, if for single ec2, create tg attachment"
  type = bool
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

# Listener ports and protocols 
variable "listener_ports" {
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

# Target group ports
variable "tg_ports" {
  description = "Target group ports"
  type = list(object({
    port     = number
    protocol = string
  }))
}
variable "target_port" {
  type        = number
  description = "Backend app port the ALB forwards to (must exist in tg_ports), e.g., 80, 8080, etc."
}

# Redirect HTTP → HTTPS status code
variable "http_status_code" {
  description = "Redirect status code used for HTTP to HTTPS (e.g., HTTP_301)"
  type        = string
  default     = "HTTP_301"
}

#-------------------------------------------------------------------------------------
# DATA FILE SPECIFIC VARIABLES
#-------------------------------------------------------------------------------------
variable "environment" {
  description = "Which working environment (dev, staging, prod)"
  type        = string
}
variable "region" {
  description = "Define aws region"
  type        = string
}