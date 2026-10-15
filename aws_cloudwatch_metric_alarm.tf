resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name = "gitlab-rds-high-cpu"

  namespace = "AWS/RDS"
  #   https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  #   list of namespace

  metric_name = "CPUUtilization"
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-metrics.html
  # list of metrics

  dimensions = {
    DBInstanceIdentifier = "gitlab-postgres"
  }

  statistic = "Average"
  period    = 60

  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  evaluation_periods  = 3
  datapoints_to_alarm = 2

  treat_missing_data = "missing"

  alarm_actions = [aws_sns_topic.alerts.arn]
}