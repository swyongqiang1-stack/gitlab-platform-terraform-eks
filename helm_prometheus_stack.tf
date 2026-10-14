resource "helm_release" "prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "92.3.0"
  namespace  = local.namespace.monitoring

  values = [
    file("${path.module}/values_prometheus.yaml")
  ]


}


