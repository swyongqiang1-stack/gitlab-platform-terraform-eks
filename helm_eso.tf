resource "helm_release" "eso" {
  name       = "eso"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "2.12.0"
  namespace = local.namespace.gitlab

  values = [
    file("${path.module}"/values_eso.yaml)
  ]
}
