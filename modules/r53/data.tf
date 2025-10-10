data "terraform_remote_state" "r53" {
  count = var.create_domain ? 0 : 1
  backend = "s3"
  config = {
    bucket = "s3-terraform-backend"
    key    = "${var.environment}/${var.region}/r53/terraform.tfstate"
    region = var.region
  }
}