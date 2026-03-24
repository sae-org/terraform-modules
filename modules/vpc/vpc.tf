# The isolated network that contains all subnets and routing.

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "${var.env}-vpc"
  }
}