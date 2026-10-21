resource "kubernetes_manifest" "loki" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "loki"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      sources = [
        {
          repoURL        = "https://grafana-community.github.io/helm-charts/"
          chart          = "loki"
          targetRevision = "18.15.1"

          helm = {
            releaseName = "loki"

            valueFiles = [
              "$values/values_loki.yaml"
            ]
          }
        },
        {
          repoURL        = "https://github.com/swyongqiang1-stack/gitlab-platform-terraform-eks.git"
          targetRevision = "main"
          ref            = "values"
        }
      ]

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = local.namespace.monitoring
      }

      syncPolicy = {
        automated = {
          prune    = false
          selfHeal = true
        }
      }
    }
  }
}