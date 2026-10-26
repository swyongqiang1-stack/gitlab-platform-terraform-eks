resource "aws_iam_role" "eso" {
  name               = "eso-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "eso" {
  name = "eso-role-policy"
  role = aws_iam_role.eso.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          aws_secretsmanager_secret.gitlab["grafana"].arn,
          aws_secretsmanager_secret.gitlab["redis"].arn,
          aws_secretsmanager_secret.gitlab["s3"].arn,
          aws_db_instance.gitlab.master_user_secret[0].secret_arn
        ]
      }
    ]
  })
}

resource "kubernetes_service_account_v1" "eso" {
  metadata {
    name      = "eso-sa"
    namespace = kubernetes_namespace_v1.gitlab.metadata[0].name
  }
}


resource "aws_eks_pod_identity_association" "eso" {
  cluster_name    = aws_eks_cluster.gitlab.name
  namespace       = kubernetes_namespace_v1.gitlab.metadata[0].name
  service_account = kubernetes_service_account_v1.eso.metadata[0].name
  role_arn        = aws_iam_role.eso.arn

  disable_session_tags = true
}
