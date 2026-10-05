resource "aws_eks_addon" "cni" {
  cluster_name = local.cluster_name
  addon_name   = "vpc-cni"
  tags = {
    Name = "cni"
    Component = "network"
  }
}

resource "aws_eks_addon" "coredns" {
  cluster_name = local.cluster_name
  addon_name   = "coredns"
  tags = {
    Name = "coredns"
    Component = "network"
  }
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = local.cluster_name
  addon_name   = "kube-proxy"
  tags = {
    Name = "kube-proxy"
    Component = "network"
  }
}


resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = local.cluster_name
  addon_name   = "aws-ebs-csi-driver"
  tags = {
    Name = "ebs-csi-driver"
    Component = "storage"
  }
  pod_identity_association {
    service_account = "ebs-csi-sa"
    role_arn = aws_iam_role.ebs.arn
  }
}




resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = local.cluster_name
  addon_name   = "eks-pod-identity-agent"
  tags = {
    Name = "pod_identity_agent"
    Component = "identity"
  }
}



