resource "aws_iam_role" "external_dns" {
  name               = "external-dns-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "external_dns" {
  name = "external-dns-policy"
  role = aws_iam_role.external_dns.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResources"
        ]
        Resource = [
          aws_route53_zone.main.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "kubernetes_service_account_v1" "external_dns" {
  metadata {
    name      = "external-dns-sa"
    namespace = local.namespace.kube_system
  }
}


resource "aws_eks_pod_identity_association" "external_dns" {
  cluster_name    = local.cluster_name
  namespace       = local.namespace.kube_system
  service_account = kubernetes_service_account_v1.external_dns.metadata[0].name
  role_arn        = aws_iam_role.external_dns.arn

  disable_session_tags = true
}