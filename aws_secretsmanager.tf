resource "aws_secretsmanager_secret" "grafana" {
  name                    = "gitlab/prod/grafana"
  description             = "Grafana admin credentials"
  kms_key_id              = aws_kms_key.gitlab.arn
  recovery_window_in_days = 30

  tags = {
    Component = "secrets"
  }
}

ephemeral "random_password" "grafana" {
  length  = 32
  special = true

  override_special = "!@#%_-+"
}

resource "aws_secretsmanager_secret_version" "grafana" {

  secret_id = aws_secretsmanager_secret.grafana.id

  secret_string_wo = jsonencode({
    "admin-user"     = "admin"
    "admin-password" = ephemeral.random_password.grafana.result
  })

  secret_string_wo_version = 1
}