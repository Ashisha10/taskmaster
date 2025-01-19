variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, stage, prod)"
  type        = string
}