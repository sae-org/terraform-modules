data "terraform_remote_state" "r53_pub_zone" {
  count = var.create_public_zone ? 0 : 1
  backend = "s3"
  config = {
    bucket = "sae-s3-terraform-backend"
    key    = "${var.environment}/${var.region}/r53/r53-public/terraform.tfstate"
    region = var.region
  }
}
