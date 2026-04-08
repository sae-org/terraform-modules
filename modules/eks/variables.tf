variable "env" {
  description = "Environment name (e.g., dev, staging, prod) used as a prefix for resource naming"
  type        = string
  
}
variable "proj_prefix" {
  description = "Project prefix for resource naming (optional)"
  type        = string
  default     = ""
}
variable "kubernetes_version" {
	description = "Kubernetes version for the EKS control plane"
	type        = string
}
variable "desired_size" {
  description = "Default desired size for node groups (can be overridden per node group)"
  type        = number
}
variable "max_size" {
  description = "Default max size for node groups (can be overridden per node group)"
  type        = number          
}
variable "min_size" {
  description = "Default min size for node groups (can be overridden per node group)"
  type        = number
}
variable "endpoint_public_access" {
	description = "Whether the cluster API endpoint is publicly accessible"
	type        = bool
	default     = true
}
variable "argo_cd_app_name" {
  description = "Name of the Argo CD application"
  type        = string
}
variable "repo_url" {
  description = "URL of the Git repository for the Argo CD application"
  type        = string
}
variable "repo_target_revision" {
  description = "Target revision (branch, tag, commit) for the Argo CD application"
  type        = string
}
variable "repo_path" {
  description = "Path within the Git repository for the Argo CD application"
  type        = string
}
variable "argocd_namespace" {
  description = "Kubernetes namespace where Argo CD is deployed"
  type        = string
}
variable "secret_arn" {
  description = "ARN of the AWS Secrets Manager secret containing the GitOps PAT"
  type        = string      
}
variable "secret_version_stage" {
  description = "Version stage of the secret to retrieve (e.g., AWSCURRENT)"
  type        = string
}
variable "argo_secret_name" {
  description = "Name of the Kubernetes secret to create for Argo CD repository credentials"
  type        = string
} 
variable "github_username" {
  description = "GitHub username for Argo CD repository authentication"
  type        = string
}
variable "secret_key" {
  description = "Key within the AWS Secrets Manager secret containing the GitOps PAT"
  type        = string
}
variable "external_dns_domains" {
  description = "List of domains to be managed by External DNS"
  type        = list(string)
  default     = []
}