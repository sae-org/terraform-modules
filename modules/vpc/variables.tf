# - vpc_az: list of AZs for subnets (e.g., ["us-east-1a","us-east-1b"])

variable "cidr_block" {
  type = string
}

variable "proj_prefix" {}

variable "vpc_az" {
  type = list(string)
}