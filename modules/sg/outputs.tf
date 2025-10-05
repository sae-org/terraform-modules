# SG ID is commonly needed by other modules (ALB, EC2, ASG, ECS, etc.)
output "sg_id" {
  value       = aws_security_group.sg.id
  description = "ID of the created security group"
}
