# Get GitHub OIDC cert chain
data "tls_certificate" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"
}

# Create the OIDC provider once per AWS account
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  # safer: trust all fingerprints we see
  thumbprint_list = [for c in data.tls_certificate.github_oidc.certificates : c.sha1_fingerprint]
}