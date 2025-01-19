# VPC and Subnet values
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-1b", "us-west-1c"]
}

# ALB and container-related values
variable "target_group_name" {
  description = "Name of the target group for ALB"
  type        = string
  default     = "taskmaster-target-group"
}

variable "container_name" {
  description = "Name of the ECS container"
  type        = string
  default     = "taskmaster-container"
}

variable "container_port" {
  description = "Port used by the container"
  type        = number
  default     = 8080
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
  default     = ["sg-12345678"]
}

# ECR-related values
variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
  default     = "taskmaster-repo"
}

# ECS-cluster-related values
variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "taskmaster-cluster"
}

# ECS Service-related values
variable "task_definition" {
  description = "ARN of the ECS task definition"
  type        = string
  default     = "arn:aws:ecs:us-west-1:123456789012:task-definition/my-task-definition"
}

# ECS Task Definition-related values
variable "task_family" {
  description = "Task family for the ECS task definition"
  type        = string
  default     = "taskmaster-task"
}

variable "image" {
  description = "Docker image used in ECS"
  type        = string
  default     = "taskmaster-image:latest"
}

# Environment-specific values
variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
  default     = "dev"
}
