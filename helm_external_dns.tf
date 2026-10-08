resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.23.0"
  namespace = local.namespace.kube_system
  values = [
    file("${path.module}"/values_external_dns.yaml)
  ]
  set {
    vpcId = module.vpc.vpc_id
  }

}

