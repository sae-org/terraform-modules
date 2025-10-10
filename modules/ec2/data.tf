data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "s3-terraform-backend"
    key    = "${var.environment}/${var.region}/vpc/terraform.tfstate"
    region = var.region
  }
}