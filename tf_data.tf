data "kubernetes_namespace_v1" "kube_system" {
  metadata {
    name = "kube-system"
  }
}

data "aws_iam_role" "github" {
  name = "github"
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

data "aws_acm_certificate" "gitlab" {
  domain      = "*.erben.cn"
  statuses    = ["ISSUED"]
  most_recent = true
}


data "aws_lb" "gitlab" {
  tags = {
    "ingress.k8s.aws/stack" = "gitlab"
  }
}