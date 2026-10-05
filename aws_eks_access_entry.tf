resource "aws_eks_access_entry" "gitlab" {
  cluster_name      = aws_eks_cluster.gitlab.name
  principal_arn     = aws_iam_role.cluster.arn
  tags = {
    Name = "eks_access_entry"
    Component = "permissions"
  }
}



resource "aws_eks_access_policy_association" "gitlab" {
  cluster_name  = aws_eks_cluster.gitlab.name
  policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  principal_arn = local.iam_user

  access_scope {
    type       = "cluster"
  }
  
}
