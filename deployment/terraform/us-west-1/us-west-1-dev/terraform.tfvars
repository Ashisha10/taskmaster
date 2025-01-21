# VPC and Subnet values
vpc_cidr_block  = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
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
task_definition = "arn:aws:ecs:us-west-1:241533153259:task-definition/taskmaster-task-dev:latest"

# ECS Task Definition-related values
task_family     = "taskmaster-task"
image = "241533153259.dkr.ecr.us-west-1.amazonaws.com/taskmaster-repo-dev:latest"

# Environment-specific values
environment     = "dev"
