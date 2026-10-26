resource "kubernetes_manifest" "external_dns" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "external-dns"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      sources = [
        {
          repoURL        = "https://kubernetes-sigs.github.io/external-dns/"
          chart          = "external-dns"
          targetRevision = "1.23.0"

          helm = {
            releaseName = "external-dns"

            valueFiles = [
              "$values/values_external_dns.yaml"
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
        namespace = "kube-system"
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