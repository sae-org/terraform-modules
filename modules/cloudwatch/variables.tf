# Prefix for resource naming convention
variable "proj_prefix" {
  description = "Project prefix used to name CloudWatch and SNS resources"
  type        = string
}

# Auto Scaling Group name to monitor
variable "asg_name" {
  description = "Name of the Auto Scaling Group to monitor for CPU utilization"
  type        = string
}

# SNS topic to send notifications
variable "sns_topic" {
  description = "ARN of the SNS topic to which Cloudwatch will send notifications"
  type        = string
}
