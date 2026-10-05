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

resource "aws_iam_role" "ebs" {
  name               = "eks-pod-identity-ebs"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "ebs" {
  name = "ebs_policy"
  role = aws_iam_role.ebs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}



resource "aws_iam_role_policy_attachment" "ebs" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.ebs.name
}

resource "aws_eks_pod_identity_association" "example" {
  cluster_name    = aws_eks_cluster.gitlab.name
  namespace       = "example"
  service_account = "example-sa"
  role_arn        = aws_iam_role.ebs.arn
}