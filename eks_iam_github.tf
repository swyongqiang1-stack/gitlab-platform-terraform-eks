
data "aws_iam_role" "github" {
  name = "github"
}

resource "aws_iam_role_policy" "github" {
  name = "github-role-policy"
  role = data.aws_iam_role.github.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect   = "Allow"
        Action   = ["eks:DescribeCluster"]
        Resource = aws_eks_cluster.gitlab.arn
      }
    ]
  })
}