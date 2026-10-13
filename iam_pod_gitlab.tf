resource "aws_iam_role" "gitlab_s3" {
  name               = "gitlab-s3-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}



resource "kubernetes_service_account_v1" "gitlab_s3" {
  metadata {
    name      = "gitlab-s3-sa"
    namespace = local.namespace.gitlab
  }
}


resource "aws_eks_pod_identity_association" "gitlab_s3" {
  cluster_name    = local.cluster_name
  namespace       = local.namespace.gitlab
  service_account = kubernetes_service_account_v1.gitlab_s3.metadata[0].name
  role_arn        = aws_iam_role.external_dns.arn

  disable_session_tags = true
}