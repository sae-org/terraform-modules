output "zone_id" {
  value = try(aws_route53_zone.private_hosted_zone[0].zone_id, "")
}