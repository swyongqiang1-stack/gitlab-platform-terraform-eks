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
  tags = {
    Component = "metric_alarm"
  } 

  treat_missing_data = "missing"

  alarm_actions = [aws_sns_topic.alerts.arn]
}






resource "aws_cloudwatch_metric_alarm" "Valkey_cpu" {
  alarm_name = "gitlab-Valkey-high-cpu"

  namespace = "AWS/ElastiCache"
  #   https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  #   list of namespace

  metric_name = "EngineCPUUtilization"
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/CacheMetrics.Redis.html
  # list of metrics

  dimensions = {
    CacheClusterId = aws_elasticache_replication_group.gitlab.member_clusters[0]
    CacheNodeId    = "0001"
  }

  tags = {
    Component = "metric_alarm"
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




resource "aws_cloudwatch_metric_alarm" "alb" {
  alarm_name = "gitlab-alb-connections"

  namespace = "AWS/ApplicationELB"

  metric_name = "ActiveConnectionCount"
  #https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html
  # list of metrics

  dimensions = {
    LoadBalancer     = data.aws_lb.gitlab.arn_suffix
    AvailabilityZone = local.AZ.region
  }
  
  tags = {
    Component = "metric_alarm"
  } 

  statistic = "Sum"
  period    = 60

  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  evaluation_periods  = 3
  datapoints_to_alarm = 2

  treat_missing_data = "missing"

  alarm_actions = [aws_sns_topic.alerts.arn]
}


