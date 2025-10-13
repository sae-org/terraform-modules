#-------------------------------------------------------------------------------------
# EC2 OUTPUTS
#-------------------------------------------------------------------------------------

output "instance_ids" {
  description = "List of IDs for all EC2 instances created by this module."
  value = aws_instance.webserver[*].id
}

output "instance_arn" {
  description = "List of ARNs for all EC2 instances created by this module."
  value = aws_instance.webserver[*].arn
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
