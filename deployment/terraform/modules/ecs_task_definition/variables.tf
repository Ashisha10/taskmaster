variable "task_family" {
  description = "Task family name"
  type        = string
}
variable "ecs_task_execution_role" {}
variable "ecs_task_role" {}
variable "container_name" {
  description = "Container name"
  type        = string
}

variable "image" {
  description = "Docker image"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "environment" {
  description = "The environment name (e.g., dev, stage, prod)"
  type        = string
}