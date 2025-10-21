# Name and ARN of the Auto Scaling Group
output "asg_name" {
  value       = aws_autoscaling_group.web_asg.name
  description = "Name of the created Auto Scaling Group"
}

output "asg_arn" {
  value       = aws_autoscaling_group.web_asg.arn
  description = "ARN of the created Auto Scaling Group"
}

# Launch Template identifiers
output "launch_template_id" {
  value       = aws_launch_template.web_lt.id
  description = "ID of the created Launch Template"
}

output "launch_template_latest_version" {
  value       = aws_launch_template.web_lt.latest_version
  description = "Latest version number of the Launch Template"
}

#-------------------------------------------------------------------------------------
# KEY_PAIR OUTPUTS
#-------------------------------------------------------------------------------------

# Public material and IDs (safe to output)
output "key_pair_name" {
  description = "EC2 key pair name"
  value       = aws_key_pair.dev_key_pub.key_name
}

# Private material
# This enables piping the private key to other modules (Secrets Manager).
output "private_key_pem" {
  description = "Private key in PEM format (sensitive)"
  value       = tls_private_key.dev_key.private_key_pem
  sensitive   = true
}
