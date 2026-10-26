resource "kubernetes_manifest" "secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ClusterSecretStore"

    metadata = {
      name = "aws-secrets"
    }

    spec = {
      provider = {
        aws = {
          service = "SecretsManager"
          region  = "ap-southeast-1"
        }
      }
    }
  }
}