data "terraform_remote_state" "eks_oidc" {
  backend = "s3"
  config = {
    bucket = "sae-s3-terraform-backend"
    key    = "dev/us-east-1/oidc/eks/terraform.tfstate"
    region = "us-east-1"
  }
}