output "cluster_name" {
	description = "EKS cluster name"
	value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
	description = "EKS cluster ARN"
	value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
	description = "EKS cluster endpoint (API server)"
	value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
	description = "Base64 encoded certificate-authority-data for the cluster"
	value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_oidc_issuer" {
	description = "OIDC issuer URL for the cluster (used to create OIDC provider/IRSA roles)"
	value       = try(aws_eks_cluster.this.identity[0].oidc[0].issuer, "")
}

output "kubeconfig" {
	description = "Kubeconfig that uses AWS CLI exec credential plugin (do not store this in remote state if you care about secrets)"
	value = <<EOF
apiVersion: v1
clusters:
- cluster:
		server: ${aws_eks_cluster.this.endpoint}
		certificate-authority-data: ${aws_eks_cluster.this.certificate_authority[0].data}
	name: ${aws_eks_cluster.this.name}
contexts:
- context:
		cluster: ${aws_eks_cluster.this.name}
		user: aws
	name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
	user:
		exec:
			apiVersion: client.authentication.k8s.io/v1alpha1
			command: aws
			args:
				- "eks"
				- "get-token"
				- "--cluster-name"
				- "${aws_eks_cluster.this.name}"
EOF
}

output "node_groups" {
	description = "Map of created node-groups with metadata"
	value = {
		for k, ng in aws_eks_node_group.this : k => {
			id     = ng.id
			arn    = ng.arn
			status = ng.status
		}
	}
}

