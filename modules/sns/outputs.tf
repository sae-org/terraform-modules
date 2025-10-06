output "public_key_openssh" {
  description = "SNS topic arn for Cloudwatch"
  value       = aws_sns_topic.alerts.arn
}