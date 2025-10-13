# Creates an Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = "${var.proj_prefix}-lb"
  internal           = var.internal                # true = internal ALB, false = internet-facing
  load_balancer_type = var.lb_type                 # typically "application"
  security_groups    = var.security_groups         # required for Application LB
  subnets            = data.terraform_remote_state.vpc.outputs.vpc.pub_sub_id            # subnets in which ALB will be deployed

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = "${var.proj_prefix}-lb"
  }
}