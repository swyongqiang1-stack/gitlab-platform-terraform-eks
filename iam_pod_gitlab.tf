resource "aws_iam_role" "gitlab_s3" {
  name               = "gitlab-s3-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}



locals {
  buckets = toset([
    "artifacts",
    "lfs",
    "uploads",
    "packages",
    "backups",
    "backup-tmp"
  ])
}


resource "aws_iam_role_policy" "gitlab_s3" {
  for_each      = local.buckets
  name = "gitlab-s3-policy"
  role = aws_iam_role.gitlab_s3.id

  policy ={
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::463884819678-${each.key}/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::463884819678-${each.key}/*"
        }
    ]
  }
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
  role_arn        = aws_iam_role.gitlab_s3.arn

  disable_session_tags = true
}