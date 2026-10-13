resource "aws_iam_role" "eso" {
  name               = "eso-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "eso" {
  name = "eso-role-policy"
  role = aws_iam_role.eso.id

  policy = {
    "Statement" : [
      {
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "*"
        ]
      }
    ],
    "Version" : "2012-10-17"
  }
}

resource "kubernetes_service_account_v1" "eso" {
  metadata {
    name      = "eso-sa"
    namespace = local.namespace.gitlab
  }
}


resource "aws_eks_pod_identity_association" "eso" {
  cluster_name    = local.cluster_name
  namespace       = local.namespace.gitlab
  service_account = kubernetes_service_account_v1.eso.metadata[0].name
  role_arn        = aws_iam_role.eso.arn

  disable_session_tags = true
}
