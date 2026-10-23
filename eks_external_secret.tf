resource "kubernetes_manifest" "grafana_external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"

    metadata = {
      name      = "monitoring-secrets"
      namespace = "monitoring"
    }

    spec = {
      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "gitlab-secret"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "gitlab/prod/grafana"
          }
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "rds_external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"

    metadata = {
      name      = "rds-secrets"
      namespace = "gitlab"
    }

    spec = {
      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "gitlab-secret"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "gitlab/prod/rds"
          }
        }
      ]
    }
  }
}


resource "kubernetes_manifest" "s3_external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"

    metadata = {
      name      = "s3-secrets"
      namespace = "gitlab"
    }

    spec = {
      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "gitlab-secret"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "gitlab/prod/s3"
          }
        }
      ]
    }
  }
}


resource "kubernetes_manifest" "rds_external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"

    metadata = {
      name      = "rds-secrets"
      namespace = "gitlab"
    }

    spec = {
      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "gitlab-secret"
        creationPolicy = "Owner"
      }

      data = [
        {
          secretKey = "password"
          remoteRef = {
            key      = aws_db_instance.gitlab.master_user_secret[0].secret_arn
            property = "password"
          }
        }
      ]
    }
  }
}