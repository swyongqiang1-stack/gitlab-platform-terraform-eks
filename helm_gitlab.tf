resource "helm_release" "gitlab" {
  name       = "gitlab"
  repository = "http://charts.gitlab.io/"
  chart      = "gitlab"
  version    = "10.4.1"
  namespace = local.namespace.gitlab

  values = [
    file("${path.module}"/values_gitlab.yaml)
  ]
}
