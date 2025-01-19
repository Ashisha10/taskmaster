

# Variables
variable "ecr_repo_name" {
  description = "Base name for the ECR repository"
  type        = string
}

# New variable for environment name
variable "environment" {
  description = "The environment name (e.g., dev, stage, prod)"
  type        = string
}
