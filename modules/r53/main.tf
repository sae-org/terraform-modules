# ===============================================================
# PUBLIC HOSTED ZONE (optional)
# Creates a Route 53 public hosted zone only when create_domain = true
# ===============================================================
resource "aws_route53_zone" "public_hosted_zone" {
  count = var.create_domain ? 1 : 0   # create the zone conditionally
  name  = var.domain_name             # e.g., "example.com"
}

# ===============================================================
# WAIT FOR ZONE PROPAGATION (best-effort buffer)
# Some providers/APIs need a short delay after zone creation before
# records can be reliably created. This adds ~8m20s of wait time.
# ===============================================================
resource "time_sleep" "wait_5_mins" {
  depends_on = [aws_route53_zone.public_hosted_zone]  # ensure zone exists first
  create_duration = "300s"                           
}

# ===============================================================
# ROUTE 53 RECORDS
# Creates one record per subdomain based on var.r53_domains
# Expects var.r53_domains to be a map where each key is a subdomain
# and the value is a list/tuple of record definitions; we take [0].
#
# Example var.r53_domains shape (conceptual):
# {
#   "@" = [
#     {
#       name  = "example.com"
#       type  = "A"
#       value = "1.2.3.4"
#       ttl   = 300
#       # or alias = { name = "...", zone_id = "...", evaluate_target_health = true }
#     }
#   ]
#   "www" = [
#     {
#       name  = "www.example.com"
#       type  = "A"
#       alias = { name = "lb-123.us-east-1.elb.amazonaws.com", zone_id = "Z35SXDOTRQ7X7K", evaluate_target_health = false }
#     }
#   ]
# }
# ===============================================================
resource "aws_route53_record" "site_domains" {
  depends_on = [time_sleep.wait_5_mins]  # wait for zone before creating records

  # Build a map: record => first record object in its list
  for_each = {
    for key, records in var.r53_records :
    records[0].name => records[0]
  }

  # Use the newly-created hosted zone (index 0 because we used count)
  zone_id = var.create_domain ? aws_route53_zone.public_hosted_zone[0].zone_id : data.terraform_remote_state.r53[0].outputs.r53.zone_id

# Let TF overwrite an existing identical record from prior runs
  allow_overwrite = true

  # Record basic attributes from each.value (the chosen record object)
  name = each.value.name
  type = each.value.type

  # If an alias is provided, 'records' and 'ttl' must be null.
  # Otherwise, set a single-value record and a TTL (default 300).
  records = try(each.value.alias, null) != null ? null : toset([tostring(each.value.value)])
  ttl     = try(each.value.alias, null) != null ? null : try(each.value.ttl, 300)

  # Optional ALIAS block (for ALB/CloudFront/etc.). Added only when alias is present.
  dynamic "alias" {
    for_each = try(each.value.alias, null) != null ? [each.value.alias] : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }
}