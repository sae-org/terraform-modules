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
}

# Full ARN of the first managed policy to attach (e.g., AmazonSSMManagedInstanceCore)
variable "policy_attachment_1" {
  description = "Managed policy ARN to attach to the role (e.g., AmazonSSMManagedInstanceCore)"
  type        = string
}

# Full ARN of the second managed policy to attach (e.g., CloudWatchAgentServerPolicy)
variable "policy_attachment_2" {
  description = "Managed policy ARN to attach to the role (e.g., CloudWatchAgentServerPolicy)"
  type        = string
}
