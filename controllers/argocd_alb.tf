resource "kubernetes_manifest" "alb" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "aws-load-balancer-controller"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      sources = [
        {
          repoURL        = "https://aws.github.io/eks-charts"
          chart          = "aws-load-balancer-controller"
          targetRevision = "3.6.0"

          helm = {
            releaseName = "aws-load-balancer-controller"

            valueFiles = [
              "$values/values_alb.yaml"
            ]

            parameters = [
              {
                name  = "vpcId"
                value = module.vpc.vpc_id
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
        namespace = "kube-system"
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}