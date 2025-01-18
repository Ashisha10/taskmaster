resource "aws_ecs_service" "this" {
  name            = "${var.cluster_name}-service"
  cluster         = var.cluster_name
  task_definition = var.task_definition
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups = var.security_groups
    assign_public_ip = true
  }
}
