locals {
  s3 ={
    bucket = "elden-state-bucket"
    key = "gitlab/prod/terraform.tfstate"
  }
}

locals {
  AZ = {
    region = "ap-southeast-1"
    AZ-A = "ap-southeast-1a"
    AZ-B = "ap-southeast-1b"
  }
  AZ-A = {
    public = "10.0.1.0/24"
    eks_private = "10.0.16.0/20"
    db_private = "10.0.32.0/24"
  }
  AZ-B = {
    public = "10.0.2.0/24"
    eks_private = "10.0.48.0/20"
    db_private = "10.0.33.0/24"
  }
}


locals {
  iam_user = "arn:aws:iam::463884819678:user/terraform"
  cluster_name = data.aws_eks_cluster.gitlab.name
  repo = "swyongqiang1-stack/gitlab-platform-terraform-eks"
  domain_arn = "arn:aws:acm:ap-southeast-1:463884819678:certificate/1880b9bc-3df9-416c-bc43-97e6a8851050"
}

locals{
  namespace = {
    kube_system = data.aws_eks_cluster.gitlab.metadata[0].namespace
    gitlab = data.kubernetes_namespace_v1.gitlab.metadata[0].name
  }
}
