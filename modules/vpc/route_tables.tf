# -----------------------------
# PUBLIC ROUTE TABLE
# - Default route (0.0.0.0/0) goes to the IGW → true internet access.
# - Attach PUBLIC subnets to this table.
# -----------------------------
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"       # route all outbound traffic
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.proj_prefix}-pub_rt1"
  }
}

# -----------------------------
# PRIVATE ROUTE TABLE
# - Default route (0.0.0.0/0) goes to the NAT Gateway → outbound only.
# - Attach PRIVATE subnets to this table.
# -----------------------------
resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"   # route all outbound internet-bound traffic
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.proj_prefix}-pri_rt1"
  }
}

# -----------------------------
# ROUTE TABLE ASSOCIATIONS (PUBLIC)
# - Associates every PUBLIC subnet with the PUBLIC route table.
# -----------------------------
resource "aws_route_table_association" "pubsub_rt" {
  for_each       = aws_subnet.pub_sub
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pub_rt.id
}

# -----------------------------
# ROUTE TABLE ASSOCIATIONS (PRIVATE)
# - Associates every PRIVATE subnet with the PRIVATE route table.
# -----------------------------
resource "aws_route_table_association" "prisub_rt" {
  for_each       = aws_subnet.pri_sub
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pri_rt.id
}