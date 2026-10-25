resource "kubernetes_manifest" "prometheus_stack" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "kube-prometheus-stack"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      sources = [
        {
          repoURL        = "https://prometheus-community.github.io/helm-charts"
          chart          = "kube-prometheus-stack"
          targetRevision = "92.3.0"

          helm = {
            releaseName = "kube-prometheus-stack"

            valueFiles = [
              "$values/values_prometheus.yaml"
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
        namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
      }

      syncPolicy = {
        automated = {
          prune    = false
          selfHeal = true
        }

        syncOptions = [
          "ServerSideApply=true"
        ]
      }
    }
  }
}