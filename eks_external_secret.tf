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
        name           = "monitoring-secret"
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

resource "kubernetes_manifest" "gitlab_external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"

    metadata = {
      name      = "gitlab-secrets"
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
            key = "gitlab/prod/database"
          }
        }
      ]
    }
  }
}