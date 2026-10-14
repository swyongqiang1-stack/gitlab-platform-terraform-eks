resource "aws_iam_role" "loki_s3" {
  name               = "loki-s3-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}



resource "kubernetes_service_account_v1" "loki_s3" {
  metadata {
    name      = "loki-s3-sa"
    namespace = local.namespace.monitoring
  }
}


resource "aws_eks_pod_identity_association" "loki_s3" {
  cluster_name    = local.cluster_name
  namespace       = local.namespace.monitoring
  service_account = kubernetes_service_account_v1.loki_s3.metadata[0].name
  role_arn        = aws_iam_role.loki_s3.arn

  disable_session_tags = true
}