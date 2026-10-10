resource "aws_iam_role" "alb" {
  name               = "alb-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "alb" {
  name = "alb-role-policy"
  role = aws_iam_role.alb.id

  policy = file("${path.module}/json_alb_permission.json")
}

resource "kubernetes_service_account_v1" "alb" {
  metadata {
    name      = "alb-sa"
    namespace = local.namespace.kube_system
  }
}

resource "aws_eks_pod_identity_association" "alb" {
  cluster_name    = local.cluster_name
  namespace       = "local.namespace.kube_system"
  service_account = "alb-sa"
  role_arn        = aws_iam_role.alb.arn

  disable_session_tags = true
}
