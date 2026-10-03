terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.3.0"
    }
  }
}

provider "aws" {
  region = local.AZ.region
  default_tags {
    tags = {
      Project     = "gitlab"
      Environment = "prod"
      ManagedBy   = "terraform"
    }
  }
}



provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.gitlab.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.gitlab.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.gitlab.name]
      command     = "aws"
    }
    default_tags {
        tags = {
        Project     = "gitlab"
        Environment = "prod"
        ManagedBy   = "terraform"
        }
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.gitlab.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.gitlab.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.gitlab.name]
    command     = "aws"
  }
}

