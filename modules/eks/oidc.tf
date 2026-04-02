# Get GitHub OIDC cert chain
data "tls_certificate" "oidc_cert" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# Create the OIDC provider once per AWS account
resource "aws_iam_openid_connect_provider" "this" {
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [for c in data.tls_certificate.oidc_cert.certificates : c.sha1_fingerprint]
}