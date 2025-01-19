# Call the VPC module
module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  azs                = var.azs
  environment        = var.environment
}

# Call the Security Group module
module "security_groups" {
  source    = "../../modules/security_groups"
  vpc_id    = module.vpc.vpc_id
  environment = var.environment
}


# Call the ECR module
module "ecr" {
  source              = "../../modules/ecr"
  ecr_repo_name       = var.ecr_repo_name
  environment         = var.environment
}

# Call the ECS Cluster module
module "ecs_cluster" {
  source              = "../../modules/ecs_cluster"
  cluster_name        = var.cluster_name
  environment         = var.environment
}

# Call the ECS Task Definition module
module "ecs_task_definition" {
  source              = "../../modules/ecs_task_definition"
  task_family         = var.task_family
  container_name      = var.container_name
  image               = var.image
  container_port      = var.container_port
  environment         = var.environment
}

# Call the ECS Service module
module "ecs_service" {
  source              = "../../modules/ecs_service"
  cluster_name        = module.ecs_cluster.cluster_name
  task_definition     = module.ecs_task_definition.task_definition_arn
  subnets             = module.vpc.public_subnet_ids
  security_groups     = module.security_groups.security_group_ids  # Fix here
  environment         = var.environment
}

# Outputs
output "dev_vpc_id" {
  value = module.vpc.vpc_id
}

output "dev_public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "security_group_ids" {
  value = module.security_groups.security_group_ids
}

output "ecr_repo_url" {
  value = module.ecr.ecr_repo_url
}

output "ecr_repo_name" {
  value = module.ecr.ecr_repo_name
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "ecs_task_definition_arn" {
  value = module.ecs_task_definition.task_definition_arn
}
