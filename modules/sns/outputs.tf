output "sns_topic_arn" {
  description = "SNS topic arn for Cloudwatch"
  value       = aws_sns_topic.alerts.arn
}