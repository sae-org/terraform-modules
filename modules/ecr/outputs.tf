# Outputs the repo name 
output "ecr_repo_name" {
  value = aws_ecr_repository.ecr_repo.name
}