output "secret_arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_id" {
  description = "ID of the created secret"
  value       = aws_secretsmanager_secret.this.id
}

output "version_id" {
  description = "Version ID of the stored secret value"
  value       = aws_secretsmanager_secret_version.this.version_id
}
