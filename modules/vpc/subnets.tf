# -----------------------------
# compute non-overlapping offsets for per-AZ subnets.

# az_count: number of AZs (length(var.vpc_az))
# public_offset: where public subnets start (1 skips the first /24)
# private_offset: starts right after the public subnets
# ------------------------------
locals {
  az_count       = length(var.vpc_az)
  public_offset  = 1           
  private_offset = local.public_offset + local.az_count
}

# -----------------------------
# PUBLIC SUBNETS (one per AZ)
# - map_public_ip_on_launch not set here; still public because of RT→IGW.
# - cidrsubnet(): derive subnet CIDRs from the VPC block.
#   params: (vpc_cidr, newbits, netnum)
# -----------------------------
resource "aws_subnet" "pub_sub" {
  for_each = toset(var.vpc_az)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, local.public_offset + index(var.vpc_az, each.value))
  availability_zone = each.value

  tags = {
    Name = "${var.env}-public-subnet"
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
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, local.private_offset + index(var.vpc_az, each.value))
  availability_zone = each.value

  tags = {
    Name = "${var.env}-private-subnet"
  }
}