resource "aws_eks_access_entry" "gitlab" {
  cluster_name      = aws_eks_cluster.gitlab.name
  principal_arn     = local.iam_user
  tags = {
    Name = "eks_access_entry"
    Component = "permissions"
  }
}



resource "aws_eks_access_policy_association" "gitlab" {
  cluster_name  = aws_eks_cluster.gitlab.name
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = local.iam_user

  access_scope {
    type       = "cluster"
  }
}


resource "aws_eks_access_policy_association" "github" {
  cluster_name  = aws_eks_cluster.gitlab.name
  principal_arn = aws_iam_role.oidc_github_gitlab.arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}