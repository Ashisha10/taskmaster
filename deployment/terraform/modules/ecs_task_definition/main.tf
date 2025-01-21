# aws_ecs_task_definition resource
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.task_family}-${var.environment}"
  execution_role_arn       = var.ecs_task_execution_role
  task_role_arn            = var.ecs_task_role
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "512"        # Memory in MiB (512, 1024, etc.)
  cpu                      = "256"        # CPU in units (256, 512, etc.)

  container_definitions = jsonencode([{
    name      = "${var.container_name}-${var.environment}"  # Append environment to container name
    image     = var.image
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    }]
  }])
}

# Output for task definition ARN
output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}
