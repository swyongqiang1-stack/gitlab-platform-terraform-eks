resource "helm_release" "gitlab" {
  name       = "gitlab"
  repository = "http://charts.gitlab.io/"
  chart      = "gitlab"
  version    = "10.4.1"
  namespace  = local.namespace.gitlab

  values = [
    file("${path.module}/values_gitlab.yaml")
  ]

  set {
    name  = "global.psql.host"
    value = data.aws_db_instance.rds.address
  }
  set {
    name  = "global.redis.host"
    value = data.aws_elasticache_replication_group.gitlab.primary_endpoint_address
  }
  set {
    name = "global.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/certificate-arn"
    value = local.domain_arn
  }
}
