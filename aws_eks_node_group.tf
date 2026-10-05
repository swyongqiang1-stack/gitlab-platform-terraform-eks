resource "aws_eks_node_group" "gitlab" {
  cluster_name    = aws_eks_cluster.gitlab.name
  node_group_name = "gitlab"
  node_role_arn   = aws_iam_role.gitlab.arn
  subnet_ids      = aws_subnet.gitlab[*].id
  instance_types = ["c7a.xlarge"]
  tags = {
    Component = "node_group"
  }
  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.gitlab-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.gitlab-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.gitlab-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_role" "gitlab" {
  name = "eks-node-group-gitlab"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "gitlab-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.gitlab.name
}

resource "aws_iam_role_policy_attachment" "gitlab-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.gitlab.name
}

resource "aws_iam_role_policy_attachment" "gitlab-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.gitlab.name
}

