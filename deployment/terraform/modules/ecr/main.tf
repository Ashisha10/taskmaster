# aws_ecr_repository resource
resource "aws_ecr_repository" "this" {
  name = "${var.ecr_repo_name}-${var.environment}"

  tags = {
    Name = "${var.ecr_repo_name}-${var.environment}"
  }
}

# Output for ECR repository URL
output "ecr_repo_url" {
  value = aws_ecr_repository.this.repository_url
}

output "ecr_repo_name" {
  value = aws_ecr_repository.this.name
}

