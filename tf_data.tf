data "aws_eks_cluster" "gitlab" {
  name = "gitlab"
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

data "aws_db_instance" "rds" {
  db_instance_identifier = "gitlab-postgres"
}

data "aws_elasticache_replication_group" "gitlab" {
  replication_group_id = "gitlab-valkey"
}



data "aws_acm_certificate" "gitlab" {
  domain      = "*.erben.cn"
  statuses    = ["ISSUED"]
  most_recent = true
}