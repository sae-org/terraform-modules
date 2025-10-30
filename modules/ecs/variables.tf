variable "aws_region" {
  description = "AWS region where the ECS infrastructure will be created (e.g., us-east-1)."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where ECS Fargate tasks will run. Must have outbound internet access via a NAT Gateway."
  type        = list(string)
}

variable "proj_prefix" {
  description = "A name prefix for all ECS resources (cluster, service, ALB, etc.). Also used as the ECS service and task definition name."
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the ECS execution role used by the ECS agent to pull images and write logs."
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role assumed by the running container for application-level AWS access."
  type        = string
}

variable "svc_sg_id" {
  description = "Service security group id"
  type        = string
}

variable "tg_arn" {
  description = "ARN of target group for service"
  type        = string
}

variable "app_port" {
  description = "The port on which your containerized application listens inside the ECS task (e.g., 80, 8080)."
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "The number of ECS task replicas to run concurrently in the ECS service."
  type        = number
  default     = 1
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to Fargate tasks. Set to true if running in public subnets without NAT; otherwise, use private subnets with NAT and leave false."
  type        = bool
  default     = false
}

variable "image_uri" {
  description = "The full URI of the container image to deploy, including tag (e.g., 123456789012.dkr.ecr.us-east-1.amazonaws.com/your-app:dev)."
  type        = string
}

variable "cpu" { 
  description = "Task CPU units (e.g., 256=0.25 vCPU)."  
  type = string  
  default = "256" 
}

variable "memory" { 
  description = "Task memory MiB (e.g., 512)."          
  type = string  
  default = "512" 
}

variable "secret_vars" {
  description = "List of maps for secrets { name, valueFrom }"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "env_vars" {
  description = "List of maps for env { name, value }"
  type = list(object({
    name  = string
    value = string
  }))
}