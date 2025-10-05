# The isolated network that contains all subnets and routing.

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.proj_prefix}-vpc"
  }
}