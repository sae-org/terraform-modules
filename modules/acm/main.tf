# REQUEST ACM CERTIFICATES
# This resource requests a certificate for each domain in var.acm_domains.
# Each domain will be validated via DNS.
resource "aws_acm_certificate" "certs" {
  for_each          = toset(var.acm_domains)   # Loop through all domains provided
  domain_name       = each.value               # The current domain name
  validation_method = var.validation_method    # Use DNS validation (default)
}


# VALIDATE CERTIFICATES
# This resource performs validation once DNS records exist in Route53.
# It uses the domain_validation_options returned by ACM.
resource "aws_acm_certificate_validation" "validation" {
  for_each        = aws_acm_certificate.certs
  certificate_arn = each.value.arn

  # Collect all the FQDNs that ACM expects to validate ownership via DNS.
  validation_record_fqdns = [
    for dvo in each.value.domain_validation_options : dvo.resource_record_name
  ]
}