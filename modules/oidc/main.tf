# Get GitHub OIDC cert chain
data "tls_certificate" "oidc_cert" {
  url = var.oidc_url
}

# Create the OIDC provider once per AWS account
resource "aws_iam_openid_connect_provider" "this" {
  url             = var.oidc_url
  client_id_list  = var.client_id_list
  thumbprint_list = [for c in data.tls_certificate.oidc_cert.certificates : c.sha1_fingerprint]
}