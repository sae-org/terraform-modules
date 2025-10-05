# CLOUDWATCH ALARM

# This alarm monitors the average CPU utilization of your Auto Scaling Group (ASG).
# If the ASG's average CPU exceeds the defined threshold, an SNS notification is sent.

resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  # Alarm name and description
  alarm_name        = "${var.proj_prefix}--asg-avg-cpu-high"
  alarm_description = "ASG average CPU is above threshold"

  # Alarm logic
  comparison_operator = "GreaterThanThreshold"  # triggers when metric > threshold
  threshold           = 65                      # CPU utilization threshold (%)
  period              = 60                      # evaluate every 60 seconds
  evaluation_periods  = 3                       # 3 data points = 3 minutes window
  datapoints_to_alarm = 2                       # requires 2 of 3 periods to breach
  treat_missing_data  = "notBreaching"          # missing data won’t trigger false alarms

  # Actions for alarm state transitions
  alarm_actions = [aws_sns_topic.alerts.arn]    # send email when alarm triggers
  ok_actions    = [aws_sns_topic.alerts.arn]    # send email when alarm returns to OK state

  # Metric configuration
  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  # Dimensions filter which instance group to monitor (by ASG name)
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}