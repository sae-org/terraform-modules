variable "proj_prefix" {
  description = "Prefix for naming IAM resources (e.g., 'my-dev', 'sae-org')"
  type        = string
}
variable "create_profile" {
  description = "Determines if instance profile resource needs to be created or not"
  type        = bool
}
variable "assume_role_policy" {
  description = "IAM trust policy JSON for the EC2 role (assume role policy)"
  type        = string
}
variable "role_policy" {
  description = "IAM inline policy JSON attached to the role"
  type        = string
  default = null
}
variable "policy_attachment" {
  description = "Managed policy ARN to attach to the role" 
  type        = list(string)
  default = []
}

