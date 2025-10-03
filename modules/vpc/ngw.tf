# - Lives in a PUBLIC subnet.
# - Lets PRIVATE subnets access the internet (for updates, package installs)
#   without being directly reachable from the internet.
# - Private instances send traffic to the NAT; NAT sends it out via IGW.

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip_ngw.id
  subnet_id     = values(aws_subnet.pub_sub)[0].id  # place NGW in the first public subnet
  tags = {
    Name = "${var.proj_prefix}-ngw"
  }
  # Make sure the IGW is created before NAT tries to route through it
  depends_on = [aws_internet_gateway.igw]
}