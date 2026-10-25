locals {
  gitlab_secrets = {
    grafana = "gitlab/prod/grafana"
    redis   = "gitlab/prod/redis"
    s3      = "gitlab/prod/s3"
  }
}

resource "aws_secretsmanager_secret" "gitlab" {
  for_each = local.gitlab_secrets

  name                    = each.value
  kms_key_id              = aws_kms_key.gitlab.arn
  recovery_window_in_days = 30

  tags = {
    Component = "secrets"
  }
}

ephemeral "random_password" "gitlab" {
  for_each = toset(["grafana", "redis"])

  length           = 32
  special          = true
  override_special = "!#$^-"
}

resource "aws_secretsmanager_secret_version" "grafana" {
  secret_id = aws_secretsmanager_secret.gitlab["grafana"].id

  secret_string_wo = jsonencode({
    "admin-user"     = "admin"
    "admin-password" = ephemeral.random_password.gitlab["grafana"].result
  })

  secret_string_wo_version = 1
}

resource "aws_secretsmanager_secret_version" "redis" {
  secret_id = aws_secretsmanager_secret.gitlab["redis"].id

  secret_string_wo = jsonencode({
    password = ephemeral.random_password.gitlab["redis"].result
  })

  secret_string_wo_version = 1
}

resource "aws_secretsmanager_secret_version" "s3" {
  secret_id = aws_secretsmanager_secret.gitlab["s3"].id

  secret_string = jsonencode({
    connection = yamlencode({
      provider        = "AWS"
      region          = "ap-southeast-1"
      use_iam_profile = true
    })
  })
}
