# Naming prefix applied to created resources (e.g., "my-dev", "sae-org")
variable "proj_prefix" {
  type        = string
  description = "Prefix used to name the ASG and Launch Template"
}

# AMI to use for instances
variable "ami" {
  type        = string
  description = "AMI ID used by the Launch Template"
}

# EC2 instance type (e.g., t3.micro)
variable "ins_type" {
  type        = string
  description = "EC2 instance type for ASG instances"
}

# Optional IAM Instance Profile name attached to instances
variable "iam_ins_profile" {
  type        = string
  default     = null
  description = "IAM Instance Profile name for the instances (optional)"
}

# Whether to associate a public IP to instances
variable "pub_ip" {
  type        = bool
  default     = null
  description = "Associate a public IP address to instances (null to omit)"
}

# Subnets where the ASG will launch instances (usually across AZs)
variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the ASG"
}

# Target Group ARNs to attach the ASG to (ALB/NLB)
variable "tg_arns" {
  type        = list(string)
  default     = []
  description = "List of Target Group ARNs for load balancer attachment"
}

# Root EBS device settings for instances
variable "root_block_device" {
  type = list(object({
    volume_size = number
    volume_type = string
    encrypted   = bool
  }))
  default     = []
  description = "Root volume configuration for instances"
}

# User data script (non-base64; module base64-encodes when non-empty)
variable "user_data" {
  type        = string
  default     = ""
  description = "Plaintext user data to run on instance boot (leave empty to omit)"
}

# Minimum, desired, and maximum capacity for the ASG
variable "min_size" {
  type        = number
  description = "Minimum number of instances in the ASG"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances in the ASG"
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances in the ASG"
}
