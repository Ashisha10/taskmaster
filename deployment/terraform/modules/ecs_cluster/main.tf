resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  tags = {
    Name = var.cluster_name
  }
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}
