resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.3.0"

  namespace        = "argocd"
  create_namespace = false

  values = [
    file("${path.module}/values/argocd.yaml")
  ]
}