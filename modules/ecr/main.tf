resource "aws_ecr_repository" "ecr_repo" {
  # Repository name pattern: <project_prefix>-ecr-repo
  name = "${var.proj_prefix}-ecr-repo"

  # Controls whether Docker image tags can be overwritten.
  # - MUTABLE: Tags can be reused or overwritten.
  # - IMMUTABLE: Tags cannot be reused once pushed.
  image_tag_mutability = "MUTABLE"

  # Automatically scan images for vulnerabilities upon push.
  image_scanning_configuration {
    scan_on_push = true
    # When enabled, Amazon ECR triggers a vulnerability scan (via Amazon Inspector)
    # each time a new image is pushed. It detects known CVEs in OS packages and libraries.
  }
}
