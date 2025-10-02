# AWS region for all resources
variable "region" {
  type    = string
  default = "your-aws-region"
}

# Short prefix to keep resource names unique
variable "proj_prefix" {
  type    = string
  default = "your-project-name"
}

# IAM usernames in this account allowed by the bucket policy
variable "users" {
  type    = list(string)
  default = ["add_your_user_1", "add_your_user_2"]
}