resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
}