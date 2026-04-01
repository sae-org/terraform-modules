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






