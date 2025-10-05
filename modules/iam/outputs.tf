# reference the actual instance_profile resource name ("profile")
output "ec2_profile" {
  value = aws_iam_instance_profile.profile.name
}