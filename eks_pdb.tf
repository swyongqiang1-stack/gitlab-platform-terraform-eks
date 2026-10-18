resource "kubernetes_pod_disruption_budget_v1" "webservice" {

  metadata {
    name      = "gitlab-webservice-pdb"
    namespace = "gitlab"

    labels = {
      app = "gitlab"
    }
  }

  spec {

    max_unavailable = "1"

    selector {
      match_labels = {
        environment = "production"
      }
    }
  }
}
