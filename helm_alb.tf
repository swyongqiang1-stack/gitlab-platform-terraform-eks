resource "helm_release" "alb" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "3.6.0"
  namespace = local.namespace.kube_system

  values = [
    file("${path.module}"/values_alb.yaml)
  ]
  
  set {
    vpcId = module.vpc.vpc_id
  }

}
