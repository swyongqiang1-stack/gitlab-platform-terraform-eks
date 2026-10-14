resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana-community.github.io/helm-charts/"
  chart      = "loki"
  version    = "18.15.1"
  namespace  = local.namespace.monitoring

  values = [
    file("${path.module}/values_loki.yaml")
  ]


}


