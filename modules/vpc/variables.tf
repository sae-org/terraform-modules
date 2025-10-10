# CIDR block for the VPC (e.g., "10.0.0.0/16")
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# Project prefix used for naming AWS resources (e.g., "my-dev", "sae-org")
variable "proj_prefix" {
  description = "Prefix added to resource names for easy identification"
  type        = string
}

# List of Availability Zones to deploy resources into
# Example: ["us-east-1a", "us-east-1b", "us-east-1c"]
variable "vpc_az" {
  description = "List of AWS Availability Zones used for subnet creation"
  type        = list(string)
}