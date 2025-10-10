# Creates a static public IP the NAT Gateway will use to reach the internet.

resource "aws_eip" "eip_ngw" {
  tags = {
    Name = "${var.env}-eip-ngw"
  }
}
