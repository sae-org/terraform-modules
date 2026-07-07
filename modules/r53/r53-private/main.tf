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

resource "aws_route53_record" "site_domains" {
  for_each = var.private_records

  zone_id = var.create_private_zone ? aws_route53_zone.private_hosted_zone[0].zone_id : data.terraform_remote_state.r53_pri_zone[0].outputs.r53.zone_id

  name = each.value.name

  type = each.value.type

  records = [
    each.value.value
  ]

  ttl = try(each.value.ttl, 300)

  allow_overwrite = true
}