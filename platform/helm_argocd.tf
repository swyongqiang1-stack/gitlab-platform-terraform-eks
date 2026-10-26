resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.3.0"

  namespace        = kubernetes_namespace_v1.argocd.metadata[0].name
  create_namespace = false

  values = [
    file("${path.module}/values_argocd.yaml")
  ]
}