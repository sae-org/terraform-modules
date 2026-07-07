output "zone_id" {
  value = try(aws_route53_zone.public_hosted_zone[0].zone_id, "")
}