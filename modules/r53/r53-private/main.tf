resource "aws_route53_zone" "private_hosted_zone" {
  count = var.create_private_zone ? 1 : 0   # create the zone conditionally
  name  = var.domain_name             # e.g., "example.com"

  dynamic "vpc" {
    for_each = var.vpc_ids

    content {
      vpc_id = vpc.value
    }
  }
}

