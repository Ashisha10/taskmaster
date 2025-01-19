resource "aws_ecs_cluster" "this" {
  name = "${var.cluster_name}-${var.environment}"

  tags = {
    Name = "${var.cluster_name}-${var.environment}"
  }
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}
