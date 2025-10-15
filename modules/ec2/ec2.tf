# -------------------------------------------------------------------------------
# Creating single ec2  
# -------------------------------------------------------------------------------

resource "aws_instance" "webserver" {
  count                       = var.ec2_count
  instance_type               = var.ins_type
  ami                         = var.ami
  key_name                    = aws_key_pair.dev_key_pub.key_name
  vpc_security_group_ids      = var.ec2_sg_id
  iam_instance_profile        = var.iam_ins_profile
  associate_public_ip_address = var.associate_pub_ip
  subnet_id                   = data.terraform_remote_state.vpc.outputs.vpc.pri_sub_id[0]

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      volume_size = root_block_device.value.volume_size
      volume_type = root_block_device.value.volume_type
      encrypted   = root_block_device.value.encrypted
    }
  }

  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace

  tags = {
    Name = "${var.proj_prefix}-ec2"
  }
}