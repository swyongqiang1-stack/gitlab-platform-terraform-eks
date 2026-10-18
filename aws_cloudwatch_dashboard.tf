resource "aws_cloudwatch_dashboard" "gitlab" {

  dashboard_name = "gitlab-monitoring"
  
  dashboard_body = jsonencode({

    widgets = [

      {
        type = "metric"

        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {

          title  = "RDS CPU"
          region = local.AZ.region

          metrics = [
            [
              "AWS/RDS",
              "CPUUtilization",
              "DBInstanceIdentifier",
              aws_db_instance.gitlab.identifier
            ]
          ]

          period = 60
          stat   = "Average"
          view   = "timeSeries"
        }
      }
    ]
  })
}

