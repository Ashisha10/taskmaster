variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "task_definition" {
  description = "Task definition ARN"
  type        = string
}

variable "subnets" {
  description = "Subnets for ECS tasks"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups for ECS tasks"
  type        = list(string)
}
