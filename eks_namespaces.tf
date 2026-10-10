resource "kubernetes_namespace_v1" "gitlab" {
  metadata {
    labels = {
      namespaces = "gitlab"
    }
    name = "gitlab"
  }
}


