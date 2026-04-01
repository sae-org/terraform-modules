output "oidc_arn" {
  value = aws_iam_openid_connect_provider.this.arn
}

output "issuer" {
  value = var.oidc_url
}