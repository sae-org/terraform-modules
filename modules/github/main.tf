# ================================
# CREATE A GITHUB REPO 
# ================================
resource "github_repository" "dev_repo" {
  name        = "${var.proj_prefix}-repo"
  description = var.git_description
  visibility  = var.repo_visibility  # "private" or "public"
}

# ================================
# GITHUB ACTIONS ORGANIZATION SECRET
# ================================
# This creates or updates a reusable organization-level secret.
# You can pass different secret names and values for reusability.
resource "github_actions_organization_secret" "org_secret" {
  secret_name     = var.secret_name     # e.g., "SSH_PRIVATE_KEY" or "AWS_ACCESS_KEY_ID"
  plaintext_value = var.secret_value    # actual secret value (safely passed from TF variable or Vault)
  visibility      = var.secret_visibility # "all", "private", or "selected"

  # Optional future-proofing:
  # repositories = [github_repository.dev_repo.name]
  # ^ uncomment if you ever want to limit the secret to specific repos
}
