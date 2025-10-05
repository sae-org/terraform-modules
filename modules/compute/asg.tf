# ===============================================================
# AUTO SCALING GROUP (ASG)
# - Attaches to one or more Target Groups (ALB/NLB)
# - Uses a Launch Template for instance configuration
# - Enables rolling instance refresh on LT changes
# ===============================================================
resource "aws_autoscaling_group" "web_asg" {
  name                = "${var.proj_prefix}-asg"
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size

  # Subnets across AZs where instances will be launched
  vpc_zone_identifier = var.subnet_ids

  # Attach to LB Target Groups (health check type "ELB" leverages TG health checks)
  target_group_arns         = var.tg_arns
  health_check_type         = "ELB"
  health_check_grace_period = 300

  # Launch Template reference
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"   # always use the latest default version
  }

  # Automatically replace instances when the Launch Template changes
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100  # maintain full capacity during refresh
      instance_warmup        = 300  # time for new instances to become healthy
    }
  }

  # Tag instances as they launch (handy for console visibility and discovery)
  tag {
    key                 = "Name"
    value               = "${var.proj_prefix}-asg"
    propagate_at_launch = true
  }

  # Safer rollouts: create new infra before destroying the old
  lifecycle {
    create_before_destroy = true
  }
}

# ===============================================================
# TARGET-TRACKING SCALING POLICY
# - Scales the ASG to maintain ~50% average CPU across instances
# ===============================================================
resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "cpu-target-50"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50  # aim to keep average CPU near 50%
  }
}
