resource "aws_eks_access_entry" "gitlab" {
  cluster_name  = aws_eks_cluster.gitlab.name
  principal_arn = "arn:aws:iam::463884819678:user/terraform"
  tags = {
    Name      = "eks_access_entry"
    Component = "permissions"
  }
}



resource "aws_eks_access_policy_association" "gitlab" {
  cluster_name  = aws_eks_cluster.gitlab.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.gitlab.principal_arn

  access_scope {
    type = "cluster"
  }
}




resource "aws_eks_access_entry" "github" {
  cluster_name  = aws_eks_cluster.gitlab.name
  principal_arn = data.aws_iam_role.github.arn
}


resource "aws_eks_access_policy_association" "github" {
  cluster_name  = aws_eks_cluster.gitlab.name
  principal_arn = aws_eks_access_entry.github.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
