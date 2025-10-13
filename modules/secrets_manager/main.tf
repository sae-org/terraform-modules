# ===============================================================
# SECRETS MANAGER 
# - Creates a secret and stores a provided string (e.g., private key)
# - Optionally uses a custom KMS key
# ===============================================================

# A) Create (or reference-named) secret container
resource "aws_secretsmanager_secret" "this" {
  name                    = var.secret_name                    # e.g., "terraform/aws/ssh_key_priv"
}

# B) Put the secret value (versioned)
resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string   # Sensitive input (e.g., the private key PEM)
}
