# ============================================
# RDS Instance Outputs
# ============================================

output "db_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  description = "Connection endpoint (includes port) - format: hostname:port"
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "Hostname of the RDS instance (without port)"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Database port"
  value       = aws_db_instance.this.port
}

# ============================================
# Database Configuration Outputs
# ============================================

output "db_name" {
  description = "Name of the database"
  value       = aws_db_instance.this.db_name
}

output "username" {
  description = "Master username"
  value       = aws_db_instance.this.username
  sensitive   = true
}

output "engine" {
  description = "Database engine type"
  value       = aws_db_instance.this.engine
}

output "engine_version" {
  description = "Database engine version"
  value       = aws_db_instance.this.engine_version_actual
}

# ============================================
# Network Outputs
# ============================================

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}

output "db_subnet_group_arn" {
  description = "ARN of the DB subnet group"
  value       = aws_db_subnet_group.this.arn
}

output "hosted_zone_id" {
  description = "Hosted zone ID of the DB instance (for Route53)"
  value       = aws_db_instance.this.hosted_zone_id
}

output "resource_id" {
  description = "RDS resource ID (for CloudWatch, tags, etc.)"
  value       = aws_db_instance.this.resource_id
}

# ============================================
# Status Outputs
# ============================================

output "status" {
  description = "Status of the RDS instance"
  value       = aws_db_instance.this.status
}

output "availability_zone" {
  description = "Availability zone of the RDS instance"
  value       = aws_db_instance.this.availability_zone
}

output "multi_az" {
  description = "Whether Multi-AZ is enabled"
  value       = aws_db_instance.this.multi_az
}