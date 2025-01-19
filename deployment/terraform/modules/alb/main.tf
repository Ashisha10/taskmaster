# aws_lb resource
resource "aws_lb" "this" {
  name               = "${var.alb_name}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.alb_name}-${var.environment}"
  }
}

# aws_lb_target_group resource
resource "aws_lb_target_group" "this" {
  name     = "${var.target_group_name}-${var.environment}"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Output for ALB DNS name
output "alb_dns_name" {
  value = aws_lb.this.dns_name
}
