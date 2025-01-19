
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of public subnets for ALB"
  type        = list(string)
}

variable "alb_name" {
  description = "Base name for the Application Load Balancer"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "target_group_name" {
  description = "Base name for the Target Group"
  type        = string
}

variable "security_groups" {
  description = "Security group IDs"
  type        = list(string)
}

# New variable for environment name
variable "environment" {
  description = "The environment name (e.g., dev, stage, prod)"
  type        = string
}
