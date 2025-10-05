# -----------------------------
# PUBLIC SUBNETS (one per AZ)
# - map_public_ip_on_launch not set here; still public because of RT→IGW.
# - cidrsubnet(): derive subnet CIDRs from the VPC block.
#   params: (vpc_cidr, newbits, netnum)
# -----------------------------
resource "aws_subnet" "pub_sub" {
  for_each = toset(var.vpc_az)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, index(var.vpc_az, each.value) + 1)
  availability_zone = each.value

  tags = {
    Name = "${var.proj_prefix}-public-subnet"
  }
}

# -----------------------------
# PRIVATE SUBNETS (one per AZ)
# - No public route; internet egress happens via NAT.
# - cidrsubnet() with different netnum to avoid overlap with public subnets.
# -----------------------------
resource "aws_subnet" "pri_sub" {
  for_each = toset(var.vpc_az)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, index(var.vpc_az, each.value) + 3)
  availability_zone = each.value

  tags = {
    Name = "${var.proj_prefix}-private-subnet"
  }
}