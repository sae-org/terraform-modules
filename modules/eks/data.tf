data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "sae-s3-terraform-backend"
    key    = "dev/us-east-1/vpc/terraform.tfstate"  
    region = "us-east-1"
  }
}

