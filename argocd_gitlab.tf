resource "kubernetes_manifest" "gitlab" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "gitlab"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      sources = [
        {
          repoURL        = "https://charts.gitlab.io/"
          chart          = "gitlab"
          targetRevision = "10.4.1"

          helm = {
            releaseName = "gitlab"

            valueFiles = [
              "$values/values_gitlab.yaml"
            ]

            parameters = [
              {
                name  = "global.psql.host"
                value = aws_db_instance.gitlab.address
              },
              {
                name  = "global.redis.host"
                value = aws_elasticache_replication_group.gitlab.primary_endpoint_address
              },
              {
                name  = "global.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/certificate-arn"
                value = local.domain_arn
              }
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
        namespace = local.namespace.gitlab
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