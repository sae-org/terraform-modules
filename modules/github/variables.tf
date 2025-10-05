# Prefix for naming GitHub repositories or related resources
variable "proj_prefix" {
  description = "Prefix used in naming GitHub repositories (e.g., 'my-dev', 'sae-org')"
  type        = string
}

# GitHub repository description
variable "git_description" {
  description = "Description of the GitHub repository"
  type        = string
  default     = "Managed via Terraform"
}

# Repository visibility
variable "repo_visibility" {
  description = "Visibility for the GitHub repository (private or public)"
  type        = string
  default     = "private"
}

# GitHub secret name 
variable "secret_name" {
  description = "Name of the GitHub Actions organization secret"
  type        = string
}

# Secret value text 
variable "secret_value" {
  description = "Plaintext value for the GitHub Actions organization secret"
  type        = string
  sensitive   = true
}

# Secret visibility across organization
# - all: available to all repositories
# - private: only private repositories
# - selected: only specific repos (requires specifying repositories)
variable "secret_visibility" {
  description = "Visibility level for the GitHub organization secret"
  type        = string
  default     = "all"
}
