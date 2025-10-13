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
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc.vpc_id   # Target groups are tied to a specific VPC

  tags = {
    Name = "${var.proj_prefix}-tg-${each.key}"
  }
}

# # attach tg to an instance
resource "aws_lb_target_group_attachment" "tg_attachments" {
  for_each = aws_lb_target_group.tg # says for all target groups created by .tg, create an attachment for each one
  # { each.key           each.value
  #   80  = (Target Group resource for port 80),
  #   443 = (Target Group resource for port 443)
  # }
  target_group_arn = each.value.arn
  target_id        = var.ec2_id
  port             = each.value.port
}