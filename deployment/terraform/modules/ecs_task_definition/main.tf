resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "512"        # Memory in MiB (512, 1024, etc.)
  cpu                      = "256"        # CPU in units (256, 512, etc.)
  
  container_definitions = jsonencode([{
    name      = var.container_name
    image     = var.image
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    }]
  }])
}


output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}
