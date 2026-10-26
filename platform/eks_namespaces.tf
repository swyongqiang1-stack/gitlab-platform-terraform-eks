resource "kubernetes_namespace_v1" "gitlab" {
  metadata {
    labels = {
      namespaces = "gitlab"
    }
    name = "gitlab"
  }
}

resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    labels = {
      namespaces = "monitoring"
    }
    name = "monitoring"
  }
}

resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    labels = {
      namespaces = "argocd"
    }
    name = "argocd"
  }
}