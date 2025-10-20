# ===============================================================
# LAUNCH TEMPLATE (LT)
# - Defines how instances are launched (AMI, type, key, profile, SGs, storage, user_data)
# ===============================================================
resource "aws_launch_template" "web_lt" {
  name_prefix   = "${var.proj_prefix}-lt"
  image_id      = var.ami
  instance_type = var.ins_type

  # SSH key pair (must already exist in AWS; you reference it here)
  key_name      = aws_key_pair.dev_key_pub.key_name

  # IAM role (via Instance Profile) for SSM/CloudWatch/etc.
  iam_instance_profile {
    name = var.iam_ins_profile
  }

  # Basic monitoring on instances 
  monitoring {
    enabled = true
  }

  # Networking for ENI 0
  network_interfaces {
    associate_public_ip_address = var.pub_ip              # true for public subnets / false for private
    security_groups             = [var.asg_sg_id]   # Security Group for instances
  }

  # Root EBS volume configuration (maps over list to allow overrides)
  dynamic "block_device_mappings" {
    for_each = var.root_block_device
    content {
      device_name = "/dev/xvda"
      ebs {
        volume_size = block_device_mappings.value.volume_size
        volume_type = block_device_mappings.value.volume_type
        encrypted   = block_device_mappings.value.encrypted
      }
    }
  }

  # User data must be base64-encoded; this keeps your variable plaintext
  user_data = var.user_data != "" ? base64encode(var.user_data) : null

  # Make the latest version the default so the ASG picks it up
  update_default_version = true

    lifecycle {
    create_before_destroy = true
  }
}