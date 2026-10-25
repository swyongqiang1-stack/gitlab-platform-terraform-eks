resource "kubernetes_manifest" "eso" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "eso"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      sources = [
        {
          repoURL        = "https://charts.external-secrets.io"
          chart          = "external-secrets"
          targetRevision = "2.12.0"

          helm = {
            releaseName = "eso"

            valueFiles = [
              "$values/values_eso.yaml"
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
        namespace = kubernetes_namespace_v1.gitlab.metadata[0].name
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