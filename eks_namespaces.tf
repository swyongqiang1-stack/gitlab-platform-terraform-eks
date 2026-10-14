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
