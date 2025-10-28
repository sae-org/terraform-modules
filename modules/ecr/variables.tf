variable "proj_prefix" {
  description = "Prefix added to AWS resource names for identification (e.g., 'my-dev', 'sae-org')"
  type        = string
}

variable "image_tag" {
  description = "The Docker image tag (e.g., latest, dev, prod, or commit SHA)."
  type        = string
  default     = "latest"
}