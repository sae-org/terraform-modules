variable "proj_prefix" {
  type        = string
  description = "Prefix used to name the ASG and Launch Template"
}
variable "ami" {
  type        = string
  description = "AMI ID used by the Launch Template"
}
variable "ins_type" {
  type        = string
  description = "EC2 instance type for ASG instances"
}
variable "asg_sg_id" {
  type        = string
  description = "SG for asg"
}
variable "iam_ins_profile" {
  type        = string
  default     = null
  description = "IAM Instance Profile name for the instances (optional)"
}
variable "pub_ip" {
  type        = bool
  default     = null
  description = "Associate a public IP address to instances (null to omit)"
}
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

#-------------------------------------------------------------------------------------
# KEY_PAIR SPECIFIC VARIABLES
#-------------------------------------------------------------------------------------
variable "algorithm" {
  description = "TLS key algorithm"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "RSA key size in bits"
  type        = number
  default     = 4096
}

#-------------------------------------------------------------------------------------
# DATA FILE SPECIFIC VARIABLES
#-------------------------------------------------------------------------------------

variable "environment" {
  description = "Which working environment (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "Define aws region"
  type        = string
}