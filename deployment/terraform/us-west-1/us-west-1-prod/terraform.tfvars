# VPC and Subnet values for Production environment
vpc_cidr_block  = "10.2.0.0/16"
public_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets = ["10.2.3.0/24", "10.2.4.0/24"]
azs             = ["us-west-1b", "us-west-1c"]

# ALB and container-related values
target_group_name = "taskmaster-target-group"
container_name  = "taskmaster-container"
container_port  = 8080

# ECR-related values
ecr_repo_name   = "taskmaster-repo"

# ECS-cluster-related values
cluster_name   = "taskmaster-cluster"

# ECS Service-related values

# ECS Task Definition-related values
task_family     = "taskmaster-task"

# Environment-specific values
environment     = "prod"
