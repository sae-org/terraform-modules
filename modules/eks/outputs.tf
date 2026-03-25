output "cluster_name" {
	description = "EKS cluster name"
	value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
	description = "EKS cluster ARN"
	value       = aws_eks_cluster.this.arn
}

output "alb_iam_role_arn" {
  description = "EKS ALB IAM role ARN"
  value = module.alb_iam.role_arn   
}
