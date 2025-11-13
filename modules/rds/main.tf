# RDS Subnet Group
# RDS needs to know which subnets (network zones) it can live in. This groups your private subnets together.
resource "aws_db_subnet_group" "this" {
  name       = "${var.proj_prefix}-db-subnet-group"
  subnet_ids = var.subnet_ids
  
  tags = merge(
    {
      Name        = "${var.proj_prefix}-db-subnet-group"
      Environment = var.environment
    },
    var.tags
  )
}

# RDS Instance
# The actual PostgreSQL database
resource "aws_db_instance" "this" {
  identifier = "${var.proj_prefix}-db"

  # Engine Configuration
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  
  # Storage Configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted
  
  # Database Configuration
  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port
  
  # Network Configuration
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.publicly_accessible
  
  # Backup Configuration
  backup_retention_period   = var.backup_retention_period
  backup_window            = var.backup_window
  skip_final_snapshot      = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.proj_prefix}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  copy_tags_to_snapshot    = var.copy_tags_to_snapshot
  
  # Maintenance Configuration
  maintenance_window              = var.maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  apply_immediately              = var.apply_immediately
  
  # High Availability
  multi_az = var.multi_az
  
  # Monitoring
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  monitoring_interval            = var.monitoring_interval
  monitoring_role_arn            = var.monitoring_interval > 0 ? var.monitoring_role_arn : null
  performance_insights_enabled   = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  
  # Deletion Protection
  deletion_protection = var.deletion_protection
  
  tags = merge(
    {
      Name        = "${var.proj_prefix}-db"
      Environment = var.environment
      Engine      = var.engine
    },
    var.tags
  )
  
  # Lifecycle rule: Don't recreate DB if password changes
  lifecycle {
    ignore_changes = [
      password,
      final_snapshot_identifier
    ]
  }
}