# This output lists the DNS validation records (CNAMEs) ACM requires.
# You can feed these into Route53 to automate validation.
output "domain_records" {
  value = {
    for domain in var.acm_domains :
    domain => [
      for dvo in aws_acm_certificate.certs[domain].domain_validation_options : {
        name  = dvo.resource_record_name
        type  = dvo.resource_record_type
        value = dvo.resource_record_value
      }
    ]
  }
  description = "Map of subdomain to domain validation options for Route53"
}

# This output maps each validated domain to its ACM certificate ARN.
# You can reference this ARN in ALBs, CloudFront, etc.
output "certificate_arns" {
  value = {
    for domain, cert in aws_acm_certificate_validation.validation :
    domain => cert.certificate_arn
  }
  description = "Map of subdomain to ACM certificate ARN"
}
