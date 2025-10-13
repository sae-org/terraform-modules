# reference the actual instance_profile resource name ("profile")
output "iam_profile" {
  value = aws_iam_instance_profile.profile.name
}