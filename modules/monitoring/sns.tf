# -------------------------------
# SNS TOPIC
# -------------------------------
# This topic acts as the communication channel for alert notifications.
# CloudWatch alarms publish messages here when triggered.
resource "aws_sns_topic" "alerts" {
  name         = "${var.proj_prefix}-sns"
  display_name = var.display_name  # Friendly name visible in AWS Console
}

# -------------------------------
# SNS SUBSCRIPTION
# -------------------------------
# This subscription connects your email address to the SNS topic,
# allowing you to receive alarm notifications in your inbox.
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"           # supported protocols: email, https, lambda, sms, etc.
  endpoint  = var.alert_email   # your email address to receive alerts
}