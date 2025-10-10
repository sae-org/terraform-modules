# ===============================================================
# KEY PAIR 
# - Generates a new RSA key pair (private in Terraform state)
# - Registers the PUBLIC key with EC2 as an aws_key_pair
# ===============================================================

# 1) Generate key in Terraform (private key lives in TF state; protect your state!)
resource "tls_private_key" "dev_key" {
  algorithm = var.algorithm     # "RSA"
  rsa_bits  = var.rsa_bits      # 4096
}

# 2) Register the PUBLIC key with EC2
resource "aws_key_pair" "dev_key_pub" {
  key_name   = var.key_name != "" ? var.key_name : "${var.proj_prefix}-key"
  public_key = tls_private_key.dev_key.public_key_openssh
}
