# TARGET GROUPS

# Target groups define where the ALB sends traffic (e.g., EC2s, ASG, ECS tasks)
# Creates one target group for each port defined in var.ports
resource "aws_lb_target_group" "tg" {
  for_each = {
    for p in var.tg_ports : tostring(p.port) => p
  }

  # Example naming: myapp-tg-80-1, myapp-tg-443-1
  name     = "${var.proj_prefix}-tg-${each.key}"
  port     = each.value.port
  protocol = each.value.protocol
  target_type = var.target_type
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc.vpc_id   # Target groups are tied to a specific VPC

  health_check {
    protocol            = "HTTP"
    path                = "/health"    # make your app return 200 here
    port                = "traffic-port"
    matcher             = "200-399"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.proj_prefix}-tg-${each.key}"
  }
}

# # attach tg to an instance
resource "aws_lb_target_group_attachment" "tg_attachments" {
  count = var.create_tg_attachment ? 1 : 0 
  target_group_arn = aws_lb_target_group.tg["80"].arn
  target_id        = var.target_id
  port             = 80
}