# CIDR block for the VPC (e.g., "10.0.0.0/16")
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# env in which deploying vpc
variable "env" {
  description = "Prefix added to resource names for easy identification"
  type        = string
}

# List of Availability Zones to deploy resources into
# Example: ["us-east-1a", "us-east-1b", "us-east-1c"]
variable "vpc_az" {
  description = "List of AWS Availability Zones used for subnet creation"
  type        = list(string)
}

# Whether the VPC should have DNS resolution enabled (recommended true)
variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

# "Whether instances launched in the VPC should receive DNS hostnames"
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

# Extra tags applied specifically to public subnets
variable "public_subnet_tags" {
  description = "Additional tags to add to public subnets"
  type        = map(string)
  default     = {}
}

# Extra tags applied specifically to private subnets
variable "private_subnet_tags" {
  description = "Additional tags to add to private subnets"
  type        = map(string)
  default     = {}
}