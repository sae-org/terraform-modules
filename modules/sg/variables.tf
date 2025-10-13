# Prefix used to name the security group (e.g., "my-dev", "sae-org")
variable "proj_prefix" {
  type        = string
  description = "Naming prefix applied to the security group"
}

# Ingress rule list (each item becomes an 'ingress' block)
# Use EITHER 'cidr_blocks' OR 'security_groups' per rule (both are optional)
variable "ingress_rules" {
  type = list(object({
    from_port       = number             # e.g., 80
    to_port         = number             # e.g., 80
    protocol        = string             # e.g., "tcp" or "-1" (all)
    cidr_blocks     = optional(list(string), [])   # e.g., ["0.0.0.0/0"]
    security_groups = optional(list(string), [])   # e.g., [aws_security_group.alb.id]
  }))
  default     = []
  description = "List of ingress rules (CIDR or SG-based)"
}

# Egress rule list (each item becomes an 'egress' block)
# Default allows all outbound traffic (common for ALB/EC2)
variable "egress_rules" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"            # all protocols
    cidr_blocks = ["0.0.0.0/0"]   # anywhere
  }]
  description = "List of egress rules; defaults to allow-all"
}

# Optional human-readable name (not used in resource; kept for compatibility)
variable "name" {
  type        = string
  default     = " "
  description = "Optional external name (unused in resource, kept for compatibility)"
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