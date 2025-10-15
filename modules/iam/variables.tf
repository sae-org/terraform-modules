variable "proj_prefix" {
  description = "Prefix for naming IAM resources (e.g., 'my-dev', 'sae-org')"
  type        = string
}

# Trust policy JSON for the role (use jsonencode(...) or a heredoc JSON string)
variable "assume_role_policy" {
  description = "IAM trust policy JSON for the EC2 role (assume role policy)"
  type        = string
}

# Inline permissions policy JSON attached directly to the role
variable "role_policy" {
  description = "IAM inline policy JSON attached to the role"
  type        = string
  default = null
}

# Full ARN managed policies to attach 
variable "policy_attachment" {
  description = "Managed policy ARN to attach to the role" 
  type        = list(string)
}

