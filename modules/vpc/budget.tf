resource "aws_budgets_budget" "gitlab" {
  name              = "budget-gitlab-monthly"
  budget_type       = "COST"
  limit_amount      = "50"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2026-07-01_00:00"
  time_unit         = "MONTHLY"
  tags = {
    Component = "budgets"
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 40
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.email]
  }
}
