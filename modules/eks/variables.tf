variable "cluster_name" {
	description = "EKS cluster name"
	type        = string
}

variable "kubernetes_version" {
	description = "Kubernetes version for the EKS control plane"
	type        = string
	default     = "1.27"
}

variable "vpc_id" {
	description = "VPC id where EKS will be created (informational)"
	type        = string
	default     = ""
}

variable "subnet_ids" {
	description = "List of subnet IDs (private) for worker nodes and cluster communication"
	type        = list(string)
}

variable "public_subnet_ids" {
	description = "Optional list of public subnet IDs for public load balancers"
	type        = list(string)
	default     = []
}

variable "cluster_iam_role_arn" {
	description = "ARN of the IAM role for the EKS control plane (created outside this module)"
	type        = string
}

variable "node_role_arn" {
	description = "Default ARN of the IAM role for node groups (can be overridden per node group)"
	type        = string
}

variable "endpoint_public_access" {
	description = "Whether the cluster API endpoint is publicly accessible"
	type        = bool
	default     = true
}

variable "public_access_cidrs" {
	description = "Allowed CIDRs to access the cluster endpoint when public access is enabled"
	type        = list(string)
	default     = ["0.0.0.0/0"]
}

variable "tags" {
	description = "Tags applied to resources created by the EKS module"
	type        = map(string)
	default     = {}
}

variable "node_groups" {
	description = <<-EOT
		Map of managed node groups to create. Each key is the node group name, value is a map with keys:
			- desired_size (number)
			- min_size (number)
			- max_size (number)
			- instance_types (list(string))
			- node_role_arn (optional) override for this node group
			- subnet_ids (optional) override list
			- disk_size (optional) override (GB)
			- ssh_key_name (optional) ec2 keypair name for remote_access
			- tags (optional) map of tags
	EOT
	type    = map(any)
	default = {}
}

