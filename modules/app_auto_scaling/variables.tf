variable "enabled" {
  description = "Create autoscaling resources"
  type        = bool
  default     = true
}

variable "proj_prefix" {
  description = "Prefix for scaling policy names"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name (not ARN)"
  type        = string
}

variable "service_name" {
  description = "ECS service name (not ARN)"
  type        = string
}

variable "min_capacity" {
  description = "Minimum desiredCount"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum desiredCount"
  type        = number
  default     = 4
}

variable "enable_cpu" {
  description = "Enable CPU target tracking"
  type        = bool
  default     = true
}

variable "cpu_target_percent" {
  description = "CPU target utilization percent"
  type        = number
  default     = 50
}

variable "enable_memory" {
  description = "Enable Memory target tracking"
  type        = bool
}

variable "memory_target_percent" {
  description = "Memory target utilization percent"
  type        = number
  default     = 60
}

variable "scale_in_cooldown_seconds" {
  description = "Seconds to wait before scaling in again"
  type        = number
}

variable "scale_out_cooldown_seconds" {
  description = "Seconds to wait before scaling out again"
  type        = number
}
