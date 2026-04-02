output "cluster_name" {
	description = "EKS cluster name"
	value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
	description = "EKS cluster ARN"
	value       = aws_eks_cluster.this.arn
}

output "lbc_iam_role_arn" {
  description = "EKS ALB IAM role ARN"
  value = module.lbc_iam.role_arn   
}


output "external_dns_iam_role_arn" {
  description = "EKS ALB IAM role ARN"
  value = module.external_dns_iam.role_arn   
}

output "oidc_arn" {
  value = aws_iam_openid_connect_provider.this.arn
}

output "issuer" {
  value = aws_iam_openid_connect_provider.this.url
}