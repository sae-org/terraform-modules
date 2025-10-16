# reference the actual instance_profile resource name ("profile")
output "iam_profile" {
  value = try(aws_iam_instance_profile.profile[0].name, null)
}