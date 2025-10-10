# Attaches to the VPC so public subnets can reach the internet.

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.proj_prefix}-igw"
  }
}