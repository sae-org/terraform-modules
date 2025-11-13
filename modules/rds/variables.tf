# ============================================
# Required Variables (must be provided)
# ============================================

variable "proj_prefix" {
  description = "Project prefix for resource naming (e.g., 'my-portfolio-dev')"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group (use private subnets)"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to attach to RDS"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the database to create (e.g., 'portfolio_db')"
  type        = string
}

variable "username" {
  description = "Master username for the database"
  type        = string
}

variable "password" {
  description = "Master password for the database (required - store in Secrets Manager)"
  type        = string
  sensitive   = true
}

# ============================================
# Engine Configuration (with defaults)
# ============================================

variable "engine" {
  description = "Database engine (postgres, mysql, mariadb, etc.)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.4"
}

variable "instance_class" {
  description = "RDS instance class (e.g., db.t3.micro, db.t3.small)"
  type        = string
  default     = "db.t3.micro"
}

variable "port" {
  description = "Database port (5432 for PostgreSQL, 3306 for MySQL)"
  type        = number
  default     = 5432
}

# ============================================
# Storage Configuration
# ============================================

variable "allocated_storage" {
  description = "Initial allocated storage in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage for autoscaling in GB (0 to disable)"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type (gp2, gp3, io1)"
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

# ============================================
# Network Configuration
# ============================================

variable "publicly_accessible" {
  description = "Whether the DB should be publicly accessible (should be false)"
  type        = bool
  default     = false
}

# ============================================
# Backup Configuration
# ============================================

variable "backup_retention_period" {
  description = "Number of days to retain backups (0-35)"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window in UTC (format: hh24:mi-hh24:mi)"
  type        = string
  default     = "03:00-04:00"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting (set to false in production!)"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshots"
  type        = bool
  default     = true
}

# ============================================
# Maintenance Configuration
# ============================================

variable "maintenance_window" {
  description = "Preferred maintenance window (format: ddd:hh24:mi-ddd:hh24:mi)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades during maintenance window"
  type        = bool
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrades"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes immediately instead of during maintenance window"
  type        = bool
  default     = false
}

# ============================================
# High Availability
# ============================================

variable "multi_az" {
  description = "Enable Multi-AZ deployment for high availability"
  type        = bool
  default     = false
}

# ============================================
# Monitoring Configuration
# ============================================

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch (e.g., ['postgresql'] or ['error', 'general', 'slowquery'] for MySQL)"
  type        = list(string)
  default     = []
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds (0 to disable, or 1, 5, 10, 15, 30, 60)"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "ARN of IAM role for enhanced monitoring (required if monitoring_interval > 0)"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention period in days (7 or 731)"
  type        = number
  default     = 7
}

# ============================================
# Deletion Protection
# ============================================

variable "deletion_protection" {
  description = "Enable deletion protection (prevents accidental deletion)"
  type        = bool
  default     = false
}

# ============================================
# General Tags
# ============================================

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}