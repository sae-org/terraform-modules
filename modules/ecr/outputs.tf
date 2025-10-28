# Outputs the repo name 
output "ecr_repo_name" {
  value = aws_ecr_repository.ecr_repo.name
}

output "repo_url" {
  value = aws_ecr_repository.ecr_repo.repository_url
}

output "image_uri" {
  description = "Full image URI with tag for ECS deployment."
  value       = "${aws_ecr_repository.this.repository_url}:${var.image_tag}"
}