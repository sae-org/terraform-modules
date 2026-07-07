data "terraform_remote_state" "r53_pri_zone" {
  count = var.create_private_zone ? 0 : 1
  backend = "s3"
  config = {
    bucket = "sae-s3-terraform-backend"
    key    = "${var.environment}/${var.region}/r53/r53-private/terraform.tfstate"
    region = var.region
  }
}
