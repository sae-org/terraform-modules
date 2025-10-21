#-------------------------------------------------------------------------------------
# COMMON VARIABLES
#-------------------------------------------------------------------------------------

variable "proj_prefix" {
  type        = string
  description = "Prefix used to name the EC2"
}

#-------------------------------------------------------------------------------------
# EC2 SPECIFIC VARIABLES
#-------------------------------------------------------------------------------------

variable "ec2_count" {
  type = number 
  default = 1
  description = "How many instances to create"
}

variable "ami" {
  type        = string
  description = "AMI ID used by the Launch Template"
}

variable "ins_type" {
  type        = string
  description = "EC2 instance type for ASG instances"
}

variable "iam_ins_profile" {
  type        = string
  default     = null
  description = "IAM Instance Profile name for the instances (optional)"
}

variable "associate_pub_ip" {
  type        = bool
  default     = null
  description = "Associate a public IP address to instances (null to omit)"
}

variable "ec2_sg_id" {
  type        = list(string)
  description = "The sg id for ec2"
}

variable "private_ins" {
  type        = bool
  description = "Is the ec2 being created private"
}

variable "root_block_device" {
  type = list(object({
    volume_size = number
    volume_type = string
    encrypted   = bool
  }))
  default     = []
  description = "Root volume configuration for instances"
}

variable "user_data" {
  type        = string
  default     = null
  description = "Plaintext user data to run on instance boot (leave empty to omit)"
}

variable "user_data_replace" {
  type = bool
  default     = null
  description = "Whether to replace the instance when the user_data script changes"
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